// #0.1 Include de llibreries de c++
#include <stdlib.h>
#include <iostream>

// #0.2 Include de les llibreries que es connectem amb MySQL
#include "mysql_connection.h"
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>

int main(void)
{
	// #1 Es creen les variables necessàries per a connectar-se a MySQL
	sql::Driver *driver;
	sql::Connection *con;
	sql::Statement *stmt;
	sql::ResultSet *res;

	// #2 Es crea la connexió al SGBD amb usuari "root" i contrasenya "eric"
	driver = get_driver_instance();
	con = driver->connect("tcp://127.0.0.1:3306", "root", "eric");
	
	// #3 Ens connectem a la base de dades "hyrule" (similar a USE hyrule;)
	con->setSchema("formulari");

	// #4 Creem una transacció
	stmt = con->createStatement();
	
	// #5 Executem la consulta "SELECT * FROM users" i guardem el resultat a la variable res
	res = stmt->executeQuery("SELECT * FROM users");

	// #6 Preguntem a l'usuari el username i password
	std::string username;
	std::string password;

	std::cout << "username: " << std::flush;
	std::getline(std::cin, username);

	std::cout << "password: " << std::flush;
	std::getline(std::cin, password);
	
	// #7 Consultem el contingut de la variable res 
	//   (cada iteració del bucle, és un registre de la taula resultat)
	//		1a iterció: user1 pass1
	//		2a iteració: user2 pass2
	//		3a iteració: user3 pass3
	//		4a iteració: ...
	//		...
	bool signIn = false;
	while (res->next()) {

		// #8 Consultem el valor de la columna '1' i columna '2' i columna '3'
		//   i els guardem per comprovar si l'usuari del formulari coincideix amb algun de la BD

		int resultatId = res->getInt(1); // dada columna 1 get..(1)
		std::string resultatUsername = res->getString(2); // dada columna 2 get..(2)
		std::string resultatPassword = res->getString(3); // dada columna 3 get..(3)

		// #9 Comprovem si coincideix l'usuari introduït amd el registre actual
		if (resultatUsername == username && resultatPassword == password) {
			signIn = true;
		}
	}

	// #10 Mostrem per pantalla si l'usuari ha pogut inciar sessió
	if (signIn) {
		std::cout << "Welcome" << std::endl;
	}
	else {
		std::cout << "[ERROR] Usuari i contrasenya incorrectes" << std::endl;
	}

	// #11 Necessari per a tancar el programa correctament
	delete res;
	delete stmt;
	delete con;

	return EXIT_SUCCESS;
}
