// #0.1 Include de llibreries de c++
#include <stdlib.h>
#include <iostream>

// #0.2 Include de les llibreries que es connectem amb MySQL
#include "mysql_connection.h"
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/prepared_statement.h>

int main(void)
{
	// #1 Es creen les variables necessàries per a connectar-se a MySQL
	sql::Driver *driver = nullptr;
	sql::Connection *con = nullptr;
	sql::ResultSet *res = nullptr;
	sql::PreparedStatement *prep_stmt = nullptr;
	
	try {
		// #2 Es crea la connexió al SGBD amb usuari "form_user" i contrasenya "qLw.2t3V.cnkq"
		driver = get_driver_instance();
		con = driver->connect("tcp://127.0.0.1:3306", "form_user", "qLw.2t3V.cnkq");

		// #3 Ens connectem a la base de dades "formulari" (similar a USE formulari;)
		con->setSchema("formulari");

		// #4 Preguntem a l'usuari el username i password
		std::string formulariUsername;
		std::string formulariPassword;

		std::cout << "username: " << std::flush;
		std::getline(std::cin, formulariUsername);

		std::cout << "password: " << std::flush;
		std::getline(std::cin, formulariPassword);

		// #5 Preparem la consulta SELECT
		prep_stmt = con->prepareStatement("SELECT user,password FROM users WHERE user=? AND password=MD5(?)");
		
		// #6 Assignem els paràmetres rebuts a través del formulari
		prep_stmt->setString(1, formulariUsername);
		prep_stmt->setString(2, formulariPassword);
		
		// #7 Executem la query i guardem el resultat a res
		res = prep_stmt->executeQuery();

		// #8 Consultem el contingut de la variable res
		//   (cada iteració del bucle, és un registre de la taula resultat)
		//		1a iterció: user1 pass1
		//		2a iteració: user2 pass2
		//		3a iteració: user3 pass3
		//		4a iteració: ...
		//		...
		bool signIn = false;
		while (res->next()) {
			// Com que estem executant:
			//	SELECT * FROM users
			// 	   WHERE username='${formulariUsername}'
			// 	   AND password='${formulariPassword}'
			//   la taula resultant serà un únic usuari amb aquest usuari i contrasenya.
			//
			//   Per tant, si la taula té algun registre => l'usuari pot iniciar sessió
			//             si la taula no té cap registre => no es pot iniciar sessió
			signIn = true;
		}

		// #9 Mostrem per pantalla si l'usuari ha pogut inciar sessió
		if (signIn) {
			std::cout << "Welcome" << std::endl;
		}
		else {
			std::cout << "[ERROR] Usuari i contrasenya incorrectes" << std::endl;
		}
		
	} catch (sql::SQLException &e) {
		
		// Més informació sobre cadascun dels errors:
		// https://downloads.mysql.com/docs/mysql-errors-8.3-en.a4.pdf
		
		switch (e.getErrorCode()) {
			
			case 1045:
				// Error number: 1045; Symbol: ER_ACCESS_DENIED_ERROR; SQLSTATE: 28000
				// Message: Access denied for user '%s'@'%s' (using password: %s)
				std::cout << "Usuari o contrasenya incorrectes." << std::endl;
				break;
			
			case 2055:
				// Error number: 2055; Symbol: CR_SERVER_LOST_EXTENDED;
				// Message: Lost connection to MySQL server at '%s', system error: %d
				std::cout << "S'ha perdut la connexió amb MySQL server." << std::endl;
				break;
				
			// case ...
			
			default:
				// Volem mostrar un missatge genèric a l'usuari
				// -> l'usuari no podrà veure dades sensibles ni part de l'estructura del SGBD
				std::cout << "S'ha detectat un error." << std::endl;
				break;
				
			return EXIT_FAILURE;
		}
		
		// #10 Necessari per a tancar el programa correctament
		delete res;
		delete prep_stmt;
		delete con;

		return EXIT_SUCCESS;
	}
}
