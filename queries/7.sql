SELECT rc.country as country, rc.release as release
FROM release_country rc
WHERE rc.release IN (SELECT t.release, COUNT(*) as cnt
	                 FROM track t
	                 WHERE cnt > 1
	                 GROUP BY t.release);
