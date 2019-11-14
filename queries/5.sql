EXPLAIN
SELECT r.id, a.id
FROM release r, release_has_artist rha, artist a
WHERE rha.release = r.id AND rha.artist = a.id AND rha.contribution = 0