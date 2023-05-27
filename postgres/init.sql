CREATE SCHEMA IF NOT exists demo;
CREATE TABLE IF NOT exists demo.demo (
    id integer PRIMARY KEY,
    name text
);

TRUNCATE TABLE demo.demo;

INSERT INTO demo.demo VALUES (1, 'Bugs Bunny');
INSERT INTO demo.demo VALUES (2, 'Duffy Duck');
INSERT INTO demo.demo VALUES (3, 'Mighty Mouse');