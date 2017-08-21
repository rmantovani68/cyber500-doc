



create table lll_plctags as select * from plctags;

alter table lll_plctags
add column basename1 text,
add column    index1 text,
add column      seq1 text,
add column basename2 text,
add column    index2 text,
add column      seq2 text,
add column basename3 text,
add column    index3 text,
add column      seq3 text;

alter table lll_plctags add column count1 int default 0;
alter table lll_plctags add column count2 int default 0;
alter table lll_plctags add column count3 int default 0;
alter table lll_plctags add column offset1 int default 0;
alter table lll_plctags add column offset2 int default 0;
alter table lll_plctags add column offset3 int default 0;




-- cerco il basename ovvero la stringa a partire dall'inizio fino al primo numero o la fine. Poi metto in basename1
update lll_plctags set basename1=substring(name, '^[^1234567890]*');
-- cerco un eventuale primo numero e lo metto in index1
update lll_plctags set index1=substring(name, '\d+');


---- CICLO

-- cerco i soli record che sono sequenze. In questo caso faccio due query. Con la prima cerco i tag che hanno un tag con basename1 omonimo e un index1 precedente. Poi
-- metto la 'S' anche al precedente, che dall'update prima non poteva essere settato
update lll_plctags set seq1='S' where basename1||index1 in (with bq as (select basename1||(index1::int+1)::text from lll_plctags where index1 is not null) select distinct(basename1||index1) from lll_plctags where basename1||index1::int in (select * from bq) and index1 is not null);
update lll_plctags set seq1='S' where basename1 in (select distinct(basename1) from lll_plctags where seq1='S') ;
-- metto la 'F' (FINE) nei tags che hanno finito l'analisi
--update  lll_plctags set seq1='F' where index1 is null and seq1 is null;
-- Problema: non tutti i numeri sono sequenze, quindi devo ridefinire il basename e rifare il giro sopra
update lll_plctags set basename1=basename1||index1||substring(right(name, -(length(basename1||index1))),'^[^1234567890]*') where index1 is not null and seq1 is null;
-- questa select mi fa vedere le righe ancora in gioco
select name,basename1,index1,seq1, substring(right(name, -length(basename1)), '\d+') from lll_plctags  where index1 is not null and seq1 is null order by basename1,index1::int;
-- Sistemo questi che non sono vere sequenze -> gli metto il basename1=name1
update lll_plctags set  basename1=name where name ~ 'DB'and index1 is not null and seq1 is null;
-- Metto il nuovo indice in index1
update lll_plctags set index1=substring(right(name, -length(basename1)), '\d+') where index1 is not null and seq1 is null;


---- FINE CICLO


-- Come  detto prima, rifaccio il giro sopra almeno 4 volte


--- Ora possiamo vedere come sarebbe il basename2 
select name,basename1,index1,seq1, substring(right(name, -length(basename1||index1)), '^[^1234567890]*') from lll_plctags where seq1='S' order by basename1,index1::int;
---  Poi creo il basename2
update lll_plctags set basename2=substring(right(name, -length(basename1||index1)), '^[^1234567890]*') where seq1='S';
-- Poi vedo l'index2
select name,basename1,index1,seq1, substring(right(name, -length(basename1||index1)), '\d+') from lll_plctags where seq1='S' order by basename1,index1::int;	
-- Poi creo l'index2
update lll_plctags set index2=substring(right(name, -length(basename1||index1)), '\d+');



---- CICLO 2
-- Vedo quali sono i susseguenti in una seq2
select 'SS',* from lll_plctags  where basename1||index1||basename2||index2 in (with bq as (select basename1||index1||basename2||(index2::int+1)::text from lll_plctags where index2 is not null) select distinct(basename1||index1||basename2||index2) from lll_plctags where basename1||index1||basename2||index2::int in (select * from bq) and index2 is not null);
-- cerco i soli record che sono sequenze di livello 2. In questo caso faccio due query. Con la prima cerco i tag che hanno un tag con basename1||index1||basename2 omonimo e un index2 precedente. Poi
-- metto la 'S' anche al precedente, che dall'update prima non poteva essere settato
update lll_plctags set seq2='S' where basename1||index1||basename2||index2 in (with bq as (select basename1||index1||basename2||(index2::int+1)::text from lll_plctags where index2 is not null) select distinct(basename1||index1||basename2||index2) from lll_plctags where basename1||index1||basename2||index2::int in (select * from bq) and index2 is not null);
update lll_plctags set seq2='S' where basename1||index1||basename2 in (select distinct(basename1||index1||basename2) from lll_plctags where seq2='S') ;

-- Problema: non tutti i numeri sono sequenze, quindi devo ridefinire il basename2 e rifare il giro sopra.
-- Infatti con la select evidenzio gli index 2 che non erano serie e aggancio il numero successivo
select name,basename1,index1,seq1,basename2,index2,seq2, basename2||index2||substring(right(name, -(length(basename1||index1||basename2||index2))),'^[^1234567890]*') from lll_plctags where index2 is not null and seq2 is null order by basename1, basename2, index1::int,index2::int;
-- Con l'update allungo il basename2 al numero successivo, se presente, o alla fine del name
update lll_plctags set basename2=basename2||index2||substring(right(name, -(length(basename1||index1||basename2||index2))),'^[^1234567890]*') where index2 is not null and seq2 is null;
-- Vediamo le righe ancora in gioco
select name,basename1,index1,seq1,basename2,index2,seq2, substring(right(name, -length(basename1||index1||basename2)), '\d+') from lll_plctags  where index2 is not null and seq2 is null order by basename1,index1::int,basename2,index2::int;
-- metto il nuovo indice in index2
update lll_plctags set index2= substring(right(name, -length(basename1||index1||basename2)), '\d+')  where index2 is not null and seq2 is null ;


---- FINE CICLO 2



-- Come  detto prima, rifaccio il giro sopra almeno 4 volte (in verita ne bastano 2 in questo caso


--- Ora possiamo vedere come sarebbe il basename3
select name,basename1,index1,seq1,basename2,index2,seq2, substring(right(name, -length(basename1||index1||basename2||index2)), '^[^1234567890]*') from lll_plctags where seq2='S' order by basename1,basename2,index1::int,index2::int;
---  Poi creo il basename3
update lll_plctags set basename3=substring(right(name, -length(basename1||index1||basename2||index2)), '^[^1234567890]*') where seq2='S';
-- Poi vedo l'index3
select name,basename1,index1,seq1,basename2,index2,seq2, substring(right(name, -length(basename1||index1||basename2||index2)), '\d+') from lll_plctags where seq2='S' order by basename1,basename2,index1::int,index2::int;
-- Poi creo l'index3
update lll_plctags set index3=substring(right(name, -length(basename1||index1||basename2||index2)), '\d+');


---- CICLO 3
-- Vedo quali sono i susseguenti in una seq3
select 'SS',* from lll_plctags   where basename1||index1||basename2||index2||basename3||index3 in (with bq as (select basename1||index1||basename2||index2||basename3||(index3::int+1)::text from lll_plctags where index3 is not null) select distinct(basename1||index1||basename2||index2||basename3||index3) from lll_plctags where basename1||index1||basename2||index2||basename3||index3::int in (select * from bq) and index3 is not null) order by basename1,basename2,basename3,index1::int,index2::int,index3::int;
-- cerco i soli record che sono sequenze di livello 3. In questo caso faccio due query. Con la prima cerco i tag che hanno un tag con basename1||index1||basename2||basename3||index3 omonimo e un index3 precedente. Poi
-- metto la 'S' anche al precedente, che dall'update prima non poteva essere settato
update lll_plctags set seq3='S'  where basename1||index1||basename2||index2||basename3||index3 in (with bq as (select basename1||index1||basename2||index2||basename3||(index3::int+1)::text from lll_plctags where index3 is not null) select distinct(basename1||index1||basename2||index2||basename3||index3) from lll_plctags where basename1||index1||basename2||index2||basename3||index3::int in (select * from bq) and index3 is not null) order by basename1,basename2,basename3,index1::int,index2::int,index3::int;
update lll_plctags set seq3='S' where basename1||index1||basename2||index2||basename3 in (select distinct(basename1||index1||basename2||index2||basename3) from lll_plctags where seq3='S') ;

-- Problema: non tutti i numeri sono sequenze, quindi devo ridefinire il basename3 e rifare il giro sopra.
-- Infatti con la select evidenzio gli index 3 che non erano serie e aggancio il numero successivo (in verita' nessuno!!! Ho quasi finito)
-- Anche se non trovo nulla la faccio lo stesso, cosi' per sicurezza
select name,basename1,index1,seq1,basename2,index2,seq2,basename3,index3,seq3, basename3||index3||substring(right(name, -(length(basename1||index1||basename2||index2||basename3||index3))),'^[^1234567890]*') from lll_plctags where index3 is not null and seq3 is null order by basename1, basename2,basename3, index1::int,index2::int,index3::int;
-- Con l'update allungo il basename3 al numero successivo, se presente, o alla fine del name (nessuna riga!)
update lll_plctags set basename3=basename3||index3||substring(right(name, -(length(basename1||index1||basename2||index2||basename3||index3))),'^[^1234567890]*') where index3 is not null and seq3 is null;
-- Vediamo le righe ancora in gioco (nessuna riga!)
select name,basename1,index1,seq1,basename2,index2,seq2,basename3,index3,seq3, substring(right(name, -length(basename1||index1||basename2||index2||basename3)), '\d+') from lll_plctags  where index3 is not null and seq3 is null order by basename1, basename2,basename3, index1::int,index2::int,index3::int;
-- metto il nuovo indice in index3  (nessuna riga!)
update lll_plctags set index3= substring(right(name, -length(basename1||index1||basename2||index2||basename3)), '\d+')  where index3 is not null and seq3 is null ;

---- FINE CICLO 3


--Non ci sono piu basename, infatti se cerco un basename4 ottengo stringhe nulle
select name,basename1,index1,seq1,basename2,index2,seq2,basename3,index3,seq3, substring(right(name, -length(basename1||index1||basename2||index2||basename2||index3)), '^[^1234567890]*') from  lll_plctags where seq3='S' order by basename1,basename2,basename3,index1::int,index2::int,index3::int;



-- Ora riempio count1, offset1,  
