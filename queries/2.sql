SELECT c.name as name, a.name as name
FROM country c, artist a, (SELECT t.area
                           FROM (SELECT area, COUNT(*)
                                 FROM artist
                                 WHERE area IS NOT NULL
                                 GROUP BY area) as t
                           ORDER BY t.count DESC
                           LIMIT 1) as temp
WHERE c.id = temp.area AND a.area = temp.area;
