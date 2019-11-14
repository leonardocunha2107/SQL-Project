SELECT DISTINCT a.id as id
FROM artist a, release_has_artist rha, release_country rc, country c
WHERE rha.artist = a.id AND rha.release = rc.release AND CAST(rc.country AS INT) = c.id AND LEFT(c.name, 1) = 'A';