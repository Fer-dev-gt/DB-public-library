-- Forma de alterar el 'schema' de una Base de Datos
ALTER TABLE authors
ADD COLUMN birthyear INTEGER DEFAULT 1930
AFTER name;                                                                       -- Con el Comando AFTER le decimos despues de que columna debe de colocar la nueva columna

ALTER TABLE authors
ADD COLUMN birthyear INTEGER
FIRST;                                                                            -- Tambien se puede usar FIRST, aunque no es recomendable porque la primera columna siempre deberia ser el id de la tabla/entidad 


-- Forma de modicar la estructura de una columna usando MODIFY
ALTER TABLE authors
MODIFY COLUMN birthyear
year DEFAULT 1920;  


-- Forma de borrar una columna por completo, MUCHO CUIDADO CON ESTO
ALTER TABLE authors
DROP COLUMN birthyear;  


-- Podemos usar LIKE en los mismos nombres de las tablas para buscar por patrones
SHOW TABLES LIKE '%i%';







-- Forma de hacer un BACKUP a la Base de Datos con MySQLDUMP, esto lo hacemos para "Versionar" el "Schema" o el DDL de la Base de Datos, IMPORTANTE los datos puros NO SE VERSIONAN, SE RESPALDAN
-- Estas instrucciones las ejecutamos directamente en la Terminal no en SQL
mysqldump -r root -p cursoplatzi


-- Para que muestre la creción del schema y las tablas pero no los datos que van dentro de ella
mysqldump -u root -p -d cursoplatzi

-- Para mostrarlo por paginacion
mysqldump -u root -p -d cursoplatzi | more

-- Para crear un archivo con la información del Schema
mysqldump -u root -p -d cursoplatzi > esquema_libreria.sql