SELECT rc.country as country, rc.release as release
FROM release_country rc
WHERE (SELECT COUNT(*)
	   FROM track t
	   WHERE t.release = rc.release
	   LIMIT 2) >= 2
ORDER BY rc.country, rc.release;