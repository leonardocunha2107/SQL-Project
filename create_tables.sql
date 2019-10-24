
create table artist_type(
    id INTEGER PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE gender(
    id INTEGER PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE contry(
    id  INTEGER PRIMARY KEY,
    name VARCHAR,
);

CREATE TABLE artist(
    id INTEGER PRIMARY KEY,
    name VARCHAR,
    gender INTEGER REFERENCES gender.id ON DELETE SET NULL,
    sday INTEGER,
    smonth INTEGER,
    syear INTEGER,
    eday INTEGER,
    emonth INTEGER,
    eyear INTEGER,
    type INTEGER NOT NULL REFERENCES artist_type.id ON DELETE CASCADE,
    area INTEGER REFERENCES country.id ON DELETE SET NULL,

    /* Validate starting date */
    CHECK(smonth >= 1 AND smonth <= 12 and sday >= 1 AND sday <= 31),
    CHECK((smonth NOT IN (4, 6, 9, 11)) OR (sday <= 30)),
    CHECK ((syear % 400 <> 0 AND (syear % 100 = 0 OR syear % 4 <> 0)) OR smonth <> 2 OR sday <=29),
    CHECK ((syear % 400 = 0 OR (syear % 100 <> 0 AND syear % 4 = 0)) OR smonth <> 2 OR sday <= 28),
    
    /* Validate ending date */
    CHECK(emonth >= 1 AND emonth <= 12 and eday >= 1 AND eday <= 31),
    CHECK((emonth NOT IN (4, 6, 9, 11)) OR (eday <= 30)),
    CHECK((eyear % 400 <> 0 AND (eyear % 100 = 0 OR eyear % 4 <> 0)) OR emonth <> 2 OR eday <= 29),
    CHECK((eyear % 400 = 0 OR (eyear % 100 <> 0 AND eyear % 4 = 0)) OR emonth <> 2 OR eday <= 28),
    
    /* Check that the starting date comes before the ending date */
    CHECK(syear < eyear OR (syear = eyear AND (smonth < emonth OR (smonth = emonth AND sday <= eday)))),

    /* Artist of type 'Person' must have gender */
    CHECK((type <> 'Person') OR (gender IS NOT NULL)),

    /* Artist of types that are not 'Person' must have no gender */
    CHECK((type = 'Person') OR  (gender IS NULL))
);

CREATE TABLE release_status(
    id INTEGER PRIMARY KEY,
    name VARCHAR,

    /* Check that it is one of valid status */
    CHECK(name = 'Official' OR name = 'Promotion' OR name = 'Bootleg' or name = 'Pseudo-Release')
);

CREATE TABLE release(
    id INTEGER PRIMARY KEY,
    title VARCHAR,
    status INTEGER REFERENCES release_status.id ON DELETE SET NULL,
    barcode VARCHAR(26),
    packaging VARCHAR(22),
);

CREATE TABLE release_country(
    release INTEGER NOT NULL REFERENCES release.id ON DELETE SET NULL,
    country VARCHAR,
    day INTEGER,
    month INTEGER,
    year INTEGER,
    PRIMARY KEY(release, country),
    
    /* Validate date */
    CHECK(month >= 1 AND month <= 12 and day >= 1 AND day <= 31),
    CHECK((month NOT IN (4, 6, 9, 11)) OR (day <= 30)),
    CHECK((year % 400 <> 0 AND (year % 100 = 0 OR year % 4 <> 0)) OR month <> 2 OR day <= 29),
    CHECK((year % 400 = 0 OR (year % 100 <> 0 AND year % 4 = 0)) OR month <> 2 OR day <= 28)
);

CREATE TABLE release_has_artist(
    release INTEGER REFERENCES release.id ON DELETE CASCADE,
    artist INTEGER REFERENCES artist.id ON DELETE CASCADE,
    contribution VARCHAR(2),
    PRIMARY KEY(release, artist)
);

CREATE TABLE track(
    id INTEGER PRIMARY KEY,
    name VARCHAR,
    no INTEGER,
    length INTEGER,
    release INTEGER NOT NULL REFERENCES release.id ON DELETE CASCADE
);

CREATE TABLE track_has_artist(
    artist INTEGER REFERENCES artist.id ON DELETE CASCADE,
    track INTEGER REFERENCES track.id ON DELETE CASCADE,
    contribution VARCHAR(2),
    PRIMARY KEY(artist, track)
)
