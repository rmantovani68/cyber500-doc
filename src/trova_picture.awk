#!/usr/bin/awk -f

#
# trova le pictures nei file frm (esercizio)
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

BEGIN {
	full_path="CP240"
	picture_index=""
	property_name = ""
}

{ 
	# printf "-- %s --\n", $1
	
    if($1=="Begin")
    {
		name=$3
		temp = full_path "." name
		full_path = temp
		printf "Begin  : %s\n",full_path
    }

	if($1=="End\r")
	{
		last_dot_position = rindex(full_path,".")
		#printf "last_dot_position    : %s\n",last_dot_position-1
		temp=substr(full_path,1,last_dot_position-1)
		full_path = temp
		printf "End    : %s\n",full_path
	}
	if($1=="Index")
	{
		# tolgo il ^M
		picture_index=substr($3,1,length($3)-1)
	}
	if($1=="BeginProperty")
	{
		property_name = $2
	}
	if($1=="EndProperty\r")
	{
		property_name = ""
	}
	
	if($1=="Picture")
	{
		if(property_name!=""){
			printf "Picture: %s-%s.%s\n",full_path,property_name,$3
		} else if(picture_index!=0){
			printf "Picture: %s-%s.%s\n",full_path,picture_index,$3
		}
	}
}




