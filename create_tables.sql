
create table artist_type
(
    id INTEGER,
    name VARCHAR,
    PRIMARY KEY(id)
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

    CHECK (0<=eday AND 31>=eday AND 0<=sday AND sday<=31 AND
            0<=smonth AND 12>=smonth AND 0<=emonth AND 12>= emonth)
    C
    

);

create ASSERTION oneGender