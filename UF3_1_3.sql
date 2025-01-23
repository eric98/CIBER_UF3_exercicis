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

INSERT INTO herois (nom,edat) VALUES  ('superman', 352), ('spiderman', 21);
INSERT INTO mascares (nom, color) VALUES ('majora', 'marró'), ('rupies', 'verd');
INSERT INTO armes (nom, poder) VALUES ('espasa mestra', 100), ('arc', 40);

-- >> Comprovació
SHOW DATABASES;
SHOW TABLES;
DESCRIBE herois;
DESCRIBE mascares;
DESCRIBE armes;

-- a) Crea dos rols, un anomenat ORNI amb tots els privilegis sobre la taula 
-- herois i mascares i un altre anomenat GERUDO amb tots els privilegis 
-- sobre la taula armes.
CREATE ROLE orni;
GRANT ALL PRIVILEGES ON hyrule.herois TO orni;
GRANT ALL PRIVILEGES ON hyrule.mascares TO orni;

CREATE ROLE gerudo;
GRANT ALL PRIVILEGES ON hyrule.armes TO gerudo;

-- > Comprovació
SELECT user FROM mysql.user;
SHOW GRANTS ON orni;
SHOW GRANTS ON gerudo;

-- b) Crea un usuari anomenat ganon i atorga-li el rol GERUDO per defecte.
CREATE USER ganon;
GRANT gerudo TO ganon;
SET DEFAULT ROLE gerudo TO ganon;

-- > Comprovació
SELECT user FROM mysql.user;
SHOW GRANTS FOR ganon;
-- > (2) Comprovació des de ganon
-- SELECT CURRENT_ROLE();

-- c) Connectat amb l'usuari ganon i prova d'executar una consulta sobre la 
-- taula herois i una altra sobre la taula armes.
SELECT * FROM hyrule.herois; -- ERROR: no té permisos
SELECT * FROM hyrule.armes; -- OK: té permisos amb el rol gerudo

-- d) A continuació, des de root, atorga el rol ORNI a ganon i repeteix la 
-- consulta sobre la taula herois amb l'usuari ganon.
GRANT orni TO ganon;

-- > des de l'usuari ganon:
-- SELECT * FROM hyrule.herois; -- ERROR: no té permisos

-- > Comprovació
SHOW GRANTS FOR ganon;

-- e) Seguidament, amb l'usuari ganon activa el rol ORNI per a la sessió 
-- actual (SET ROLE) i repeteix una altra vegada la consulta sobre la taula 
-- armes.
-- > des de l'usuari ganon:
-- SET ROLE orni;
-- SELECT * FROM hyrule.herois; -- OK: funciona correctament

-- f) Desactiva tots els rols de l'usuari ganon.
SHOW GRANTS FOR ganon;
REVOKE gerudo, orni FROM ganon;

-- > Comprovació
SHOW GRANTS FOR ganon;

-- g) Consulta la taula herois amb l'usuari ganon.
-- des de l'usuari ganon:
-- SELECT * FROM hyrule.herois; -- ERROR: no té permisos
