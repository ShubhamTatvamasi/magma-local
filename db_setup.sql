create database if not exists magma;
create user if not exists 'magma'@'localhost' identified by 'password';
create user if not exists 'magma'@'%' identified by 'password';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON magma.* TO 'magma'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON magma.* TO 'magma'@'%';

create database if not exists orc8r;
create user if not exists 'orc8r'@'localhost' identified by 'password';
create user if not exists 'orc8r'@'%' identified by 'password';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON orc8r.* TO 'orc8r'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, INDEX, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON orc8r.* TO 'orc8r'@'%';
