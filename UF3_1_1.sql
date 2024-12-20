-- == PREPARACIÓ ==
DROP DATABASE IF EXISTS hyrule;
CREATE DATABASE hyrule;
USE hyrule;

CREATE TABLE herois (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(25),
	edat INT UNSIGNED
);
 
CREATE TABLE mascares (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(25),
	color VARCHAR(15)
);
 
CREATE TABLE armes (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nom VARCHAR(25),
	poder INT UNSIGNED
);
 
INSERT INTO herois (nom,edat) VALUES
 ('superman', 352),
 ('spiderman', 21);
 
INSERT INTO mascares (nom, color) VALUES
 ('majora', 'marró'),
 ('rupies', 'verd');
 
INSERT INTO armes (nom, poder) VALUES
 ('espasa mestra', 100),
 ('arc', 40);

-- == Exercici ==
-- a) Crea un usuari anomenat navi@localhost amb la sintaxi CREATE USER 
-- amb permisos de només connexió. Comprova-ho amb SHOW GRANTS FOR 
-- navi@localhost;
CREATE USER navi@localhost;

-- // (1) Comprovació
SELECT user, host FROM mysql.user;
SHOW GRANTS FOR 'navi'@'localhost';

-- // (2) Comprovació des de l'usuari creat
-- SHOW TABLES FROM escola;

-- b) Crea un usuari anomenat skullkid@localhost amb la sintaxi CREATE 
-- USER amb permisos de només connexió i identificat amb contrasenya. 
-- Comprova-ho amb SHOW GRANTS FOR skullkid@localhost;.
CREATE USER skullkid@localhost;
SELECT user,host FROM mysql.user;
SHOW GRANTS FOR 'skullkid'@'localhost';

-- // (1) Comprovació
SELECT user, host FROM mysql.user;
SHOW GRANTS FOR 'skullkid'@'localhost';

-- // (2) Comprovació des de l'usuari creat
-- SHOW TABLES FROM escola;

-- c) Dona a l'usuari skullkid permisos de SELECT dins la taula hyrule.herois i 
-- comprova que pugui consultar la taula
GRANT SELECT ON hyrule.herois TO skullkid@localhost;

-- // (1) Comprovació
SHOW GRANTS FOR 'navi'@'localhost';

-- // (2) Comprovació des de l'usuari creat
-- SELECT * FROM hyrule.herois;

-- d) Dona a l'usuari navi permisos de SELECT, INSERT i UPDATE a les taules 
-- de la base de dades hyrule amb GRANT OPTION.
GRANT SELECT, INSERT, UPDATE ON hyrule.* TO navi@localhost WITH GRANT OPTION;

-- // (1) Comprovació
SHOW GRANTS FOR 'navi'@'localhost';

-- // (2) Comprovació des de l'usuari creat
-- SELECT * FROM hyrule.herois;
-- INSERT INTO hyrule.herois (nom, edat) VALUES ('Nobita Novi', 10);
-- UPDATE hyrule.herois SET edat=18 WHERE nom = 'Nobita Novi';
-- GRANT SELECT, INSERT, UPDATE ON hyrule.* TO 'sonic'@'%';

-- // (3) Comprovació del grant option des de root
-- SHOW GRANTS FOR sonic;

-- e) Connecta't amb l'usuari navi i dona permisos de selecció a skullkid per 
-- a la taula hyrule.mascares, comprova que així sigui.

-- f) Treu els permisos de selecció a skullkid sobre la taula hyrule.herois.

-- g) Connecta't com a root i elimina tots els permisos que has donat a navi i 
-- skullkid.

-- h) Dona a skullkid els permisos de SELECT sobre les columnes id i nom de 
-- la taula armes de la BD hyrule.

-- i) Connecta't amb skullkid i executa la query SELECT * FROM hyrule.armes. 
-- Què succeeix?
