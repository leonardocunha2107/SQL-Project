CREATE TABLE artist_type(
    id int PRIMARY KEY,
    name varchar(30)
);
CREATE TABLE gender(
    id int PRIMARY KEY,
    name varchar(30)
);
CREATE TABLE country(
    id int PRIMARY KEY,
    name varchar(30)
);
CREATE TABLE artist(
    id int PRIMARY KEY ,
    name varchar(30),
    gender int REFERENCES gender(id) ON DELETE SET NULL,
    sday int,
    smonth int,
    syear int,
    eday int,
    emonth int,
    eyear int,
    type int NOT NULL REFERENCES artist_type(id) ON DELETE CASCADE,
    area int REFERENCES country(id) ON DELETE SET NULL,
    /*Starting-date check*/
    CHECK ( syear >= 1000 AND syear <= 3000 AND smonth >= 1 AND smonth <= 12 ),
    CHECK ( (syear % 400 <> 0 AND (syear % 100 = 0 OR syear % 4 <> 0)) OR smonth <> 2 OR (sday >= 1 AND sday <=29) ),
    CHECK ( (syear % 400 = 0 OR (syear % 100 <> 0 && syear % 4 = 0)) OR smonth <> 2 OR (sday >= 1 AND sday <= 28)  ),
    CHECK ( (smonth not in (1, 3, 5, 7, 8, 10, 12)) OR (sday >=1 AND sday <=31) ),
    CHECK ( (smonth not in (4, 6, 9, 11)) OR (sday >= 1 AND sday <= 30) ),
    /*Ending date check*/
    CHECK ( eyear >= 1000 AND eyear <= 3000 AND emonth >= 1 AND emonth <= 12 ),
    CHECK ( (eyear % 400 <> 0 AND (eyear % 100 = 0 OR eyear % 4 <> 0)) OR emonth <> 2 OR (eday >= 1 AND eday <=29) ),
    CHECK ( (eyear % 400 = 0 OR (eyear % 100 <> 0 && eyear % 4 = 0)) OR emonth <> 2 OR (eday >= 1 AND eday <= 28)  ),
    CHECK ( (emonth not in (1, 3, 5, 7, 8, 10, 12)) OR (eday >=1 AND eday <=31) ),
    CHECK ( (emonth not in (4, 6, 9, 11)) OR (eday >= 1 AND eday <= 30) ),
    /*Sanity check*/
    CHECK ( eyear > syear OR ( eyear = syear AND ( emonth > smonth OR (emonth = smonth AND eday >= sday)) ) ),
    /*Person has gender check*/
    CHECK ( (type <> 'Person') OR (gender NOTNULL ) )
);
CREATE TABLE release_status(
    id int PRIMARY KEY,
    name varchar(30)
);
CREATE TABLE release(
    id int PRIMARY KEY,
    status int REFERENCES release_status(id) ON DELETE SET NULL,
    title varchar(30),
    barcode varchar(26),
    packaging varchar(22)
);
CREATE TABLE release_country(
    release int NOT NULL REFERENCES release(id) ON DELETE SET NULL,
    country int REFERENCES release(id) ON DELETE SET NULL,
    day int,
    month int,
    year int,
    PRIMARY KEY (release, country),
    /* date check */
    CHECK ( year >= 1000 AND year <= 3000 AND month >= 1 AND month <= 12 ),
    CHECK ( (year % 400 <> 0 AND (year % 100 = 0 OR year % 4 <> 0)) OR month <> 2 OR (day >= 1 AND day <=29) ),
    CHECK ( (year % 400 = 0 OR (year % 100 <> 0 AND year % 4 = 0)) OR month <> 2 OR (day >= 1 AND day <= 28) ),
    CHECK ( (month not in (1, 3, 5, 7, 8, 10, 12)) OR (day >=1 AND day <=31) ),
    CHECK ( (month not in (4, 6, 9, 11)) OR (day >= 1 AND day <= 30) )
);
CREATE TABLE release_has_artist(
    release int REFERENCES release(id) ON DELETE CASCADE,
    artist int REFERENCES artist(id) ON DELETE CASCADE,
    contribution int,
    PRIMARY KEY (release, artist)
);
CREATE TABLE track(
    id int PRIMARY KEY ,
    name varchar(30),
    no int,
    length int,
    release int NOT NULL REFERENCES release(id) ON DELETE CASCADE
);
CREATE TABLE track_has_artist(
    artist int REFERENCES artist(id) ON DELETE CASCADE,
    track int REFERENCES track(id) ON DELETE CASCADE,
    contribution int,
    PRIMARY KEY (artist, track)
);
