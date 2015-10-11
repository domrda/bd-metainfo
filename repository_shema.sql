CREATE SEQUENCE main_seq
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
    pos integer DEFAULT NULL,
    link integer DEFAULT NULL
);--#