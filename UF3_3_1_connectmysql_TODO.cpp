// TODO: Escriu el formulari al lloc corresponen per a que el programa es connecti amb username i password
/*std::string username;
std::string password;

std::cout << "username: " << std::flush;
std::getline(std::cin, username);

std::cout << "password: " << std::flush;
std::getline(std::cin, password);*/



// #0.1 Include de llibreries de c++
#include <stdlib.h>
#include <iostream>

// #0.2 Include de les llibreries que es connecten amb MySQL
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
	con->setSchema("hyrule");

	// #4 Creem una transacció
	stmt = con->createStatement();
	
	// #5 Executem la consulta "SELECT nom,poder FROM armes" i guardem el resultat a la variable res
	res = stmt->executeQuery("SELECT nom,poder FROM armes");
	
	// #6 Consultem el contingut de la variable res 
	//   (cada iteració del bucle, és un registre de la taula resultat)
	//		1a iterció: 'espasa mestra'	100
	//		2a iteració: 'arc'		40
	//		3a iteració: 'espasa laser'	...
	//		4a iteració: ...
	//		...
	while (res->next()) {

		// #7 Consultem el valor de la columna '1' i columna '2'
		//   i els mostrem amb un st::cout
		std::cout << "Nom: " << res->getString(1) << "\tPoder: " << res->getInt(2) << std::endl;
		
	}

	// #7 Necessari per a tancar el programa correctament
	delete res;
	delete stmt;
	delete con;

	return EXIT_SUCCESS;
}
