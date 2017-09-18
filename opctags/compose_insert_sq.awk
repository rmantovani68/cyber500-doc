#!/usr/bin/awk -f

#
# crea la lista di comandi insert a partire da un export da excel in formato testo posizioni fisse (prn)
# il file prn viene prodotto con uno script di poswershell (estrazione-opctags-from-xls.ps1)
#

#
# successivamente lanciare il seguente comando
# rm insert_plctags.sql; for i in _extract_*.prn ; do echo $i; ./compose_insert_sq.awk $i >> insert_plctags.sql; done
#

function rindex( str, search,     pos, res )
{
    do
    {
        res = index( substr( str, pos + 1 ), search );
        pos += res;
    } while (res >= 1);
    #printf "stringa : %s , pos = %d\n",str,pos
    return pos;
}

{ 
    # elimino i cr nei campi 
    p2 = rindex($1,"")
    name= p2 ? substr($1,1,p2-1):$1

    p2 = rindex($2,"")
    address = p2 ? substr($2,1,p2-1):$2
    # printf "address = '%s'\n",address

    p2 = rindex($3,"")
    description = p2 ? substr($3,1,p2-1):$3

    p2 = rindex(address,"/")
    plcname = p2 ? substr(address,1,p2-1):""

    p1 = index(address,"/")
    p2 = index(address,":")
    db = p1 && p2 ? substr(address,p1+1, p2-p1):""
    # printf "db = '%s'\n",db

    p2 = index(db,".")
    dbname = p1 ? substr(db,1, p2-1):""
    # printf "dbname = '%s'\n",dbname

    p1 = index(db,".")
    dba = p1 ? substr(db,p1+1, length(db)-p1):""
    # printf "dba = '%s'\n",dba

    p1 = rindex(dba,".")
    dbaddress = p1 ? substr(dba,1, p1-1):dba
    # printf "dbaddress = '%s'\n",dbaddress

    p1 = index(dba,".")
    bitnum = p1 ? substr(dba,p1+1, length(dba)-p1):""
    # printf "bitnum = '%s'\n",bitnum

    p1 = index(address,":")
    vartype = p1 ? substr(address,p1+1, length(address)-p1):""


    printf "INSERT INTO public.plctags (name, address, description, plcname, plcdbname, plcdbaddress, plcbitnum, plcvartype ) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s');\n", name,address,description,plcname,dbname,dbaddress,bitnum,vartype;
}


# INSERT INTO public.plctags (name, address, description,plcname) VALUES ('PLCTAG_NM_ForzatoDarwin_96','plc4/db2010.dbx129.7:BOOL','','plc4');


