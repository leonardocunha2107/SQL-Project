SELECT rha1.artist as artist, rha2.artist as artist, COUNT(*) as count
FROM release_has_artist rha1, release_has_artist rha2
WHERE rha1.artist <> rha2.artist AND rha1.release = rha2.release
GROUP BY rha1.artist, rha2.artist;