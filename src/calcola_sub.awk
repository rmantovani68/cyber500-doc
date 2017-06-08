#!/usr/bin/awk -f

#
# script per calcolare dati relativi alle sub presenti nei .bas e nei .frm
#
BEGIN {
	exec=0
	num_lines=0
}

{ 
	first  = $1
	second  = $2
	third =$3
	
	if(exec==0)
	{
		if((first =="Public" || first =="public" || first =="Private" || first =="private") && (second == "Sub" || second =="Function" ))
		{
			exec=1
			modifier = first
			type = second
			name = third
			riga_completa = $0
			num_lines=0;
			

		}
	}
	if(exec==1)
	{
		if(first =="End"  && (substr(second,1,3) == "Sub" || substr(second,1,8) =="Function" ))
		{
			exec=0
			printf "%5d - %s\n",num_lines,riga_completa
		}
		num_lines=1+num_lines;
	}

	# printf "%d - %s %s %s\n",exec,first, second, third
}





