CREATE TABLE bd (
    id SERIAL PRIMARY KEY,
    database_name character varying(255) NOT NULL,
    table_name character varying(255) NOT NULL,
    attr_name character varying(255) NOT NULL,
    attr_type character varying(255) NOT NULL,
    is_pk boolean DEFAULT FALSE,
    pos integer DEFAULT NULL
);

CREATE TABLE relations (
  id SERIAL PRIMARY KEY,
  unique_name character varying(255) NOT NULL,
  tableA character varying(255) NOT NULL,
  fieldA character varying(255) NOT NULL,
  tableB character varying(255) NOT NULL,
  fieldB character varying(255) NOT NULL,
  pos integer NOT NULL
);