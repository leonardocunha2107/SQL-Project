Create view acb as 
 (SELECT c.name AS country,
  a.name AS artist,
  concat(lpad(a.syear::text, 4, '0'::text), '-', lpad(a.smonth::text, 2, '0'::text), '-', lpad(a.sday::text, 2,             '0'::text))::date 
  AS borndate

  FROM artist a,
  country c
   WHERE c.id = a.area AND a.syear IS NOT NULL AND a.smonth IS NOT NULL AND a.sday IS NOT NULL  and a.type=1);


EXPLAIN select globcount.country, globcount.artist, loccount.nb_local, globcount.nb_global

from
 (select country, artist, ((ROW_NUMBER() OVER (ORDER BY borndate))-1) 
   as nb_global 
  from acb) as globcount,

 (select country, artist, ((ROW_NUMBER() OVER (PARTITION BY country ORDER BY borndate))-1) 
   as nb_local 
  from acb) as loccount
 
where globcount.country= loccount.country and globcount.artist=loccount.artist;

drop view acb;


