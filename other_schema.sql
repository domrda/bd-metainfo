CREATE SEQUENCE product_seq
   START WITH 1
   INCREMENT BY 1
   NO MINVALUE
   NO MAXVALUE
   CACHE 1;--#

CREATE SEQUENCE prices_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE SEQUENCE shop_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;--#

CREATE TABLE product (
    id integer DEFAULT nextval('product_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL
);--#

CREATE TABLE shop (
    id integer DEFAULT nextval('shop_seq'::regclass) PRIMARY KEY,
    name character varying(255) NOT NULL,
    image character varying(255),
    address character varying(255)
);--#

CREATE TABLE prices (
    id integer DEFAULT nextval('prices_seq'::regclass) PRIMARY KEY,
    product_id integer NOT NULL REFERENCES product(id),
    shop_id integer NOT NULL REFERENCES shop(id),
    value integer NOT NULL
);--#

CREATE TABLE employee (
    shop_id integer NOT NULL REFERENCES shop(id),
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    image character varying(255),

    PRIMARY KEY(name, email)
);--#