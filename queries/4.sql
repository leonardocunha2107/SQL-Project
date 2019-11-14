SELECT country as id, COUNT(*) as cc
FROM release_country
GROUP BY country
ORDER BY cc DESC;
