CREATE SEQUENCE main_seq
   START WITH 1
   INCREMENT BY 1
   NO MINVALUE
   NO MAXVALUE
   CACHE 1;--#

CREATE SEQUENCE rel_sec
   START WITH 1
   INCREMENT BY 1
   NO MINVALUE
   NO MAXVALUE
   CACHE 1;--#

CREATE TABLE bd (
    id integer DEFAULT nextval('main_seq'::regclass) PRIMARY KEY,
    database_name character varying(255) NOT NULL,
    table_name character varying(255) NOT NULL,
    attr_name character varying(255) NOT NULL,
    attr_type character varying(255) NOT NULL,
    is_pk boolean DEFAULT FALSE,
    pos integer DEFAULT NULL
);--#

CREATE TABLE relations (
  id integer DEFAULT nextval('rel_sec'::regclass) PRIMARY KEY,
  unique_name character varying(255) NOT NULL,
  tableA character varying(255) NOT NULL,
  fieldA character varying(255) NOT NULL,
  tableB character varying(255) NOT NULL,
  fieldB character varying(255) NOT NULL,
  pos integer NOT NULL
);--#