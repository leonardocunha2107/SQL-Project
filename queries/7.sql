EXPLAIN
SELECT rc.country, rc.release
FROM release_country rc
WHERE rc.release IN (SELECT t.release
	                 FROM track t
	                 WHERE COUNT(*) > 1
	                 GROUP BY t.release);