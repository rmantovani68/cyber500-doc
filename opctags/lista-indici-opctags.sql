select 
	plcname,
	basename1,
	basename2,
	basename3,
	null::int as NUM ,
	null::int as START1 , null::int as END1,
	null::int as START2 , null::int as END2,
	null::int as START3 , null::int as END3

from lll_plctags 

where 
	seq1 is null  and seq2 is null and seq3 is null
	
group by plcname,basename1,basename2,basename3
union
select 
	plcname,
	basename1,
	basename2,
	basename3,
	count(index1) as NUM ,
	min(index1::int) as START1 ,max(index1::int) as END1,
	null::int as START2 , null::int as END2,
	null::int as START3 , null::int as END3

from lll_plctags 

where 
	seq1='S'  and seq2 is null and seq3 is null
	
group by plcname,basename1,basename2,basename3

union
select 
	plcname,
	basename1,
	basename2,
	basename3,
	count(index1) as NUM ,
	min(index1::int) as START1 ,max(index1::int) as END1,
	min(index2::int) as START2 ,max(index2::int) as END2,
	null::int as START3 , null::int as END3

from lll_plctags 

where 
	seq1='S'  and seq2 ='S' and seq3 is null
	
group by plcname,basename1,basename2,basename3

union
select 
	plcname,
	basename1,
	basename2,
	basename3,
	count(index1) as NUM ,
	min(index1::int) as START1 ,max(index1::int) as END1,
	min(index2::int) as START2 ,max(index2::int) as END2,
	min(index3::int) as START3 ,max(index3::int) as END3

from lll_plctags 

where 
	seq1='S'  and seq2 ='S' and seq3 ='S'
	
group by plcname,basename1,basename2,basename3


order by plcname,basename1,basename2,basename3;




