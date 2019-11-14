SELECT 
    c.name as country, 
    a.name as artist, 
    (SELECT COUNT(*)
	 FROM artist older
	 WHERE (older.area = a.area
            AND (older.year < a.year
                 OR (older.year = a.year AND older.month < a.month)
                 OR (older.year = a.year AND older.month = a.month AND older.day < a.day)))
	 LIMIT 1) as nb,
    (SELECT COUNT(*)
	 FROM artist older
	 WHERE (older.year < a.year
            OR (older.year = a.year AND older.month < a.month)
            OR (older.year = a.year AND older.month = a.month AND older.day < a.day))
	 LIMIT 1) as nb_global
FROM 
    artist a
    INNER JOIN country c ON c.id = a.area
    INNER JOIN artist_type atype ON atype.id = a.type
WHERE atype.name = "Person";
