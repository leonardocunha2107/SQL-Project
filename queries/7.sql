SELECT DISTINCT rc.country as country, rc.release as release
FROM   (SELECT release,COUNT(*)
		FROM track
		GROUP BY release) as aux,release_country as rc
WHERE aux.count>1 and aux.release=rc.release;