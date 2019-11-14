SELECT country, COUNT(*)
FROM release_country
GROUP BY country
ORDER BY count DESC;