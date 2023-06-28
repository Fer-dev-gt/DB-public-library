-- EJERCICIOS DE SELECT
DESC clients;

SELECT name 
FROM clients;

SELECT name, email, gender 
FROM clients;

SELECT name, email, gender 
FROM clients
LIMIT 10;

SELECT name, email, gender 
FROM clients
WHERE gender = 'M';

SELECT name, email, gender 
FROM clients
WHERE gender = 'F';

SELECT birthdate
FROM clients;

SELECT name
FROM authors
WHERE author_id = 4;


-- Podemos usar FUNCIONES en SQL
-- Usamos función YEAR() para trabajar con solo el número del año
SELECT YEAR(birthdate)
FROM clients;

-- Usamos la función NOW() para mostrar la fecha y hora actual de cuando se ejecuta ese comando
SELECT NOW();

-- Puedo 'anidar' funciones para obtener datos particulares
SELECT YEAR(NOW());

-- Uso funciones anidadas para calcular y mostrar la edad de los clients
SELECT YEAR(NOW()) - YEAR(birthdate)
FROM clients;

SELECT YEAR(NOW()) - YEAR(birthdate)
FROM clients
LIMIT 10;

SELECT name, YEAR(NOW()) - YEAR(birthdate)
FROM clients
LIMIT 10;


-- Usando la función LIKE para buscar patrones de texto junto a '%string%', 2 signos % significa que puede buscar en cualquier parte del string
SELECT * 
FROM clients
WHERE name LIKE '%Saav%';

-- Usando varias condiciones en el WHERE utilizand el operador AND, tambien utilizo AS para darle un alias a la columna que calcula los años
SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender
FROM clients
WHERE gender = 'F'
  AND name Like '%Lop%';


-- Contando la cantidad de registros en las tablas
SELECT COUNT(*)
FROM books;

SELECT COUNT(*)
FROM authors;


-- Utlizando WHERE con rangos usando AND o BETWEEN
SELECT * 
FROM authors
WHERE author_id > 0 AND author_id < 6;

SELECT * 
FROM authors
WHERE author_id > 0 AND author_id <= 5;

SELECT * 
FROM books
WHERE author_id BETWEEN 1 AND 5;

SELECT book_id, author_id, title
FROM books
WHERE author_id BETWEEN 1 AND 5;