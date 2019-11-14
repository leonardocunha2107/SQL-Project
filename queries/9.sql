SELECT 
    c.name as country, 
    a.name as artist, 
    (SELECT COUNT(*)
	 FROM artist older
	 WHERE (older.area = a.area
            AND (older.syear < a.syear
                 OR (older.syear = a.syear AND older.smonth < a.smonth)
                 OR (older.syear = a.syear AND older.smonth = a.smonth AND older.sday < a.sday)))
	 LIMIT 1) as nb,
    (SELECT COUNT(*)
	 FROM artist older
	 WHERE (older.syear < a.syear
            OR (older.syear = a.syear AND older.smonth < a.smonth)
            OR (older.syear = a.syear AND older.smonth = a.smonth AND older.sday < a.sday))
	 LIMIT 1) as nb_global
FROM 
    artist a
    INNER JOIN country c ON c.id = a.area
    INNER JOIN artist_type atype ON atype.id = a.type
WHERE atype.name LIKE 'Person';
