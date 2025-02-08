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
	
	// #3 Ens connectem a la base de dades "formulari" (similar a USE formulari;)
	con->setSchema("formulari");

	// #4 Creem una transacció
	stmt = con->createStatement();

	// #5 Preguntem a l'usuari el username i password
	std::string formulariUsername;
	std::string formulariPassword;

	std::cout << "username: " << std::flush;
	std::getline(std::cin, formulariUsername);

	std::cout << "password: " << std::flush;
	std::getline(std::cin, formulariPassword);

	// #6 Executem la consulta "  SELECT * FROM users WHERE username='antonio' AND password='boxboni'  " i guardem el resultat a la variable res
	std::string query = "SELECT * FROM users WHERE username='"+formulariUsername+"' AND password='"+formulariPassword+"'";
	std::cout << "Query a executar: " << query << std::endl;
	res = stmt->executeQuery(query);

	// #7 Consultem el contingut de la variable res
	//   (cada iteració del bucle, és un registre de la taula resultat)
	//		1a iterció: user1 pass1
	//		2a iteració: user2 pass2
	//		3a iteració: user3 pass3
	//		4a iteració: ...
	//		...
	bool signIn = false;
	while (res->next()) {
		// Com que estem executant:
		//	SELECT * FROM users ....... 
		// 	   WHERE username='${formulariUsername}'
		// 	   AND password='${formulariPassword}'
		//   la taula resultant serà un únic usuari amb aquest usuari i contrasenya.
		//
		//   Per tant, si la taula té algun registre => l'usuari pot iniciar sessió
		//             si la taula no té cap registre => no es pot iniciar sessió
		signIn = true;
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
