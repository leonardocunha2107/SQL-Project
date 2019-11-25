CREATE VIEW acb AS (
  SELECT 
    c.name AS country,
    a.name AS artist,
    concat(lpad(a.syear::text, 4, '0'::text), '-', lpad(a.smonth::text, 2, '0'::text), '-', lpad(a.sday::text, 2, '0'::text))::date 
      AS borndate
  FROM artist a, country c
  WHERE
    c.id = a.area 
    AND a.syear IS NOT NULL
    AND a.smonth IS NOT NULL 
    AND a.sday IS NOT NULL
    AND a.type = 1);

SELECT
  globcount.country AS country,
  globcount.artist AS artist,
  loccount.nb_local AS nb,
  globcount.nb_global AS nb_global
FROM
  (SELECT
    country,
    artist,
    ((ROW_NUMBER() OVER (ORDER BY borndate))-1) AS nb_global 
   FROM acb) AS globcount,
  (SELECT
    country,
    artist,
    ((ROW_NUMBER() OVER (PARTITION BY country ORDER BY borndate))-1) AS nb_local 
   FROM acb) AS loccount
WHERE globcount.country = loccount.country AND globcount.artist = loccount.artist
ORDER BY nb, nb_global;

DROP VIEW acb;
