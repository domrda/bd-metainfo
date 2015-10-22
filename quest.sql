CREATE SEQUENCE table1_seq
   START WITH 1
   INCREMENT BY 1
   NO MINVALUE
   NO MAXVALUE
   CACHE 1;--#

CREATE SEQUENCE table2_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE TABLE table2 (
    id integer DEFAULT nextval('table2_seq'::regclass),
    field1 integer,
    field2 integer,
    field3 integer,
    field4 integer,

    PRIMARY KEY(id),
    UNIQUE(field1, field2),
    UNIQUE(field2, field3, field4),
    UNIQUE(field1)
);--#

CREATE TABLE table1 (
    id integer DEFAULT nextval('table1_seq'::regclass),
    field1 integer,
    field2 integer,
    field3 integer,
    field4 integer,

    PRIMARY KEY(id),
    UNIQUE(field1, field2),
    UNIQUE(field3, field4, field1),
    UNIQUE(field4),

    FOREIGN KEY (id) REFERENCES table2(id),
    FOREIGN KEY (field1, field2) REFERENCES table2(field1, field2),
    FOREIGN KEY (field3, field4, field1) REFERENCES table2(field2, field3, field4),
    FOREIGN KEY (field4) REFERENCES table2(field1)
);--#