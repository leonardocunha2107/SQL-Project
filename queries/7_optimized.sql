SELECT rc.country as country, rc.release as release
FROM release_country as rc 
INNER JOIN (SELECT release
		FROM track
		GROUP BY release
        HAVING COUNT(*)>1) as c on rc.release=c.release;