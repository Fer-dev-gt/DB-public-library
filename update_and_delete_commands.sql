-- EJERCICIO USANDO COMANDOS UPDATE Y DELETE
-- DELETE
DELETE 
FROM authors
WHERE author_id = 112
LIMIT 1;                                                                            -- Es buena practica que cada vez que hacemos DELETE limitarlo a solo una fila por si nos llegamos a equivocar no borramos datos de más


-- Siempre es buena idea que en vez de hacer DELETE una fila, creemos una columna llamada 'activo' booleana y cuando vamos a 'borrar' un registro la colocamos como false
-- No muestra los usuarios que hicimos un 'DELETE' pero con un UPDATE en el campo de 'active'
SELECT client_id, name
FROM clients
WHERE active <> 1;                                                                  -- '<>' significa 'diferente a'


-- Ejecutamos un UPDATE
UPDATE clients
SET active = 0
WHERE client_id = 85
LIMIT 1;


-- Mostramos algunos cliente y comparamos su campo 'active'
SELECT client_id, name, active 
FROM clients
WHERE client_id IN (85, 23, 1, 61, 4, 32);


-- Ahora le vamos a cambiar el email a un cliente
UPDATE clients
SET email = 'Mafer@123.com'
WHERE client_id = 1
LIMIT 1;

SELECT client_id, name, email, active 
FROM clients
WHERE client_id IN (85, 23, 1, 61, 4, 32);

SELECT client_id, name, active 
FROM clients
ORDER BY RAND()
LIMIT 10;


-- Arreglando el error de los 'authors' que tienen nacionalidad ENG en vez de GBR
UPDATE authors
SET nationality = 'GBR'
WHERE nationality = 'ENG';


-- Ponemos diferentes condiciones para que cambie a varios registros
UPDATE clients
SET active = 0
WHERE client_id IN (85, 23, 1, 61, 4, 32)
OR name LIKE '%Lop%';


-- Muestro 6 clientes por id y los clientes que cumplan con el patrón '%Lop%'
SELECT client_id, name 
FROM clients
WHERE client_id IN (85, 23, 1, 61, 4, 32)
OR name LIKE '%Lop%';

SELECT client_id, name, email, active 
FROM clients
WHERE client_id IN (85, 23, 1, 61, 4, 32)
OR name LIKE '%Lop%';


-- Usando el Comando TRUNCATE borramos todos los registros de una tabla pero no la tabla, se mantiene la estructura
TRUNCATE transactions;