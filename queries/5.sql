SELECT r.id as release, a.id as artist
FROM release_has_artist rha
INNER JOIN release r ON rha.release = r.id
INNER JOIN artist a ON rha.artist = a.id
WHERE rha.contribution = 0
ORDER BY r.id, a.id
