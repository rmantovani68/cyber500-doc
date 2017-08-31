#!/usr/bin/awk -f

{ 
    printf "INSERT INTO public.plctags (name, address, description) VALUES ('%s','%s','%s');\r\n", $1, $2, $3;
}




