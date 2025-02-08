CREATE DATABASE formulari;
USE formulari;

CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20) UNIQUE, -- 'username' és unic per a cada usuari
	password VARCHAR(20)
);

INSERT INTO users (username, password) VALUES
	('pol','admin1234'),
	('victor','qwerty.123'),
	('antonio','boxboni');
