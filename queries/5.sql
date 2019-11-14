SELECT rha.release as release, rha.artist as artist
FROM release_has_artist rha
WHERE rha.contribution = 0;
