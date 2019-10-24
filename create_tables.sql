
create table artist_type
(
    id INTEGER,
    name VARCHAR,
    PRIMARY KEY(id),
    CHECK(name=='Person' OR name =='Orchestra' OR name =='Character' OR name == 'Group' OR name =='Choir' OR name == 'Other')

);
CREATE TABLE gender(
    id INTEGER,
    name VARCHAR,
    PRIMARY KEY(id)
);
CREATE TABLE contry(
    id  INTEGER,
    name VARCHAR,
    PRIMARY KEY(id)
);

CREATE TABLE artist(
    id INTEGER,
    name VARCHAR,
    gender INTEGER,
    sday INTEGER,
    smonth INTEGER,
    syear INTEGER,
    eday INTEGER,
    emonth INTEGER,
    eyear INTEGER,
    type INTEGER,
    area VARCHAR,


    PRIMARY KEY(name),
    FOREIGN KEY(type) REFERENCES type.id

    CHECK (0<=eday AND 31>=eday) AND 0<=sday AND sday<=31 AND
            0<=smonth AND 12>=smonth AND 0<=emonth AND 12>= emonth),        
    
);

CREATE ASSERTION personHasGender AS
CHECK((
    SELECT a.gender
    FROM artist_type t, artist a
    WHERE(a.id==t.id AND t.name=='Person')) 
    IN
                           (SELECT id
                            FROM gender
                            WHERE *)
);
CREATE TABLE release_status(
    id INTEGER,
    name VARCHAR,
    PRIMARY KEY(id)
    CHECK (name=='Official' OR  name == 'Promotion' OR name=='Bootleg' or name=='Pseudo-Release')
);

CREATE TABLE release(
    id INTEGER,
    title VARCHAR,
    status INTEGER,
    barcode VARCHAR(26),
    packaging VARCHAR(22),
    PRIMARY KEY(id)
);


CREATE ASSERTION statusKey //TODO

CREATE TABLE release_country(
    release INTEGER,
    country VARCHAR,
    day INTEGER,
    month INTEGER,
    year INTEGER,

    CHECK( 0<=day AND 31>= day AND 0<= month AND 12 >= month),
    PRIMARY KEY(release,country)
    FOREIGN KEY (release) REFERENCES release.id
);


CREATE TABLE release_has_artist(
    release INTEGER,
    artist INTEGER,
    contribution VARCHAR,
    PRIMARY KEY(release,artist),
    FOREIGN KEY (release) REFERENCES release.id,
    FOREIGN KEY (artist) REFERENCES artist.id
);

CREATE TABLE track(
    id INTEGER,
    name VARCHAR,
    no INTEGER,
    lenght
)
