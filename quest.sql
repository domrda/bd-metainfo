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
    uniqueTable2Field integer,

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
    uniqueTable1Field integer,

    PRIMARY KEY(id),
    UNIQUE(field1, field2),
    UNIQUE(field3, field4, field1),
    UNIQUE(field4),

    FOREIGN KEY (id) REFERENCES table2(id),
    FOREIGN KEY (field1, field2) REFERENCES table2(field1, field2),
    FOREIGN KEY (field3, field4, field1) REFERENCES table2(field2, field3, field4),
    FOREIGN KEY (field4) REFERENCES table2(field1)
);--#

INSERT INTO table2 (id, field1, field2, field3, field4, uniqueTable2Field) VALUES (1, 1, 1, 1, 1, 1), (2, 2, 2, 2, 2, 2), (3, 3, 3, 3, 3, 3);
INSERT INTO table1 (id, field1, field2, field3, field4, uniqueTable1Field) VALUES (1, 1, 1, 1, 1, 1), (2, 2, 2, 2, 2, 2), (3, 3, 3, 3, 3, 3), (4, 4, 4, 4, 4, 4);