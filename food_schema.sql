CREATE SEQUENCE ingredient_seq
   START WITH 1
   INCREMENT BY 1
   NO MINVALUE
   NO MAXVALUE
   CACHE 1;--#

CREATE SEQUENCE condition_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE measure_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE cuisine_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE status_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE diet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE consists_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE recipe_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE source_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE recipe_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE author_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE editor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE source_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE TABLE ingredient (
    id integer DEFAULT nextval('ingredient_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE measure (
    id integer DEFAULT nextval('measure_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE condition (
    id integer DEFAULT nextval('condition_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE cuisine (
    id integer DEFAULT nextval('cuisine_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE status (
    id integer DEFAULT nextval('status_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE diet (
    id integer DEFAULT nextval('diet_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE source_type (
    id integer DEFAULT nextval('source_type_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE source (
    id integer DEFAULT nextval('source_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL,
    image character varying(255),
    author_name character varying(255),
    source_type_id integer NOT NULL REFERENCES source_type(id)
);--#

CREATE TABLE author (
    id integer DEFAULT nextval('author_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    time timestamp DEFAULT now(),
    image character varying(255)
);--#

CREATE TABLE editor (
    id integer DEFAULT nextval('editor_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    time timestamp DEFAULT now(),
    image character varying(255)
);--#

CREATE TABLE recipe (
    id integer DEFAULT nextval('recipe_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL,
    author_id integer NOT NULL REFERENCES author(id),
    description character varying(255),
    time timestamp,
    editor_id integer NOT NULL REFERENCES editor(id),
    callories integer,
    source_id integer NOT NULL REFERENCES source(id),
    cuisine_id integer REFERENCES cuisine(id),
    status_id integer NOT NULL REFERENCES status(id),
    diet_id integer REFERENCES diet(id)
);--#


CREATE TABLE consists (
    id integer DEFAULT nextval('consists_seq'::regclass) PRIMARY KEY,
    ingredient_id integer NOT NULL REFERENCES ingredient(id),
    condition_id integer NOT NULL REFERENCES condition(id),
    measure_id integer NOT NULL REFERENCES measure(id),
    recipe_id integer NOT NULL REFERENCES recipe(id),
    amount integer NOT NULL
);--#


CREATE TABLE recipe_item (
    id integer DEFAULT nextval('recipe_item_seq'::regclass) PRIMARY KEY,
    recipe_id integer NOT NULL REFERENCES recipe(id),
    index_number integer NOT NULL,
    image character varying(255),
    description character varying(255) NOT NULL
);--#