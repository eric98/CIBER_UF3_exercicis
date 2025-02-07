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
	
	// #3 Ens connectem a la base de dades "test" (similar a USE test;)
	con->setSchema("test");

	// #4 Creem una transacció
	stmt = con->createStatement();
	
	// #5 Executem la consulta "SELECT 'Hello World!' AS _message" i guardem el resultat a la variable res
	res = stmt->executeQuery("SELECT 'Hello World!' AS _message");
	
	// #6 Consultem el contingut de la variable res
	while (res->next()) {

		std::cout << res->getString(1) << endl;
		
	}

	// TODO: Escriu el formulari al lloc corresponen per a que el programa es connecti amb username i password
	std::string username;
	std::string password;

	std::cout << "username: " << std::flush;
	std::getline(std::cin, username);

	std::cout << "password: " << std::flush;
	std::getline(std::cin, password);

	// #7 Necessari per a tancar el programa correctament
	delete res;
	delete stmt;
	delete con;

	return EXIT_SUCCESS;
}
