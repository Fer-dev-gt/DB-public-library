-- Ahora nos toca responder a varias preguntas de negocio sobre nuestra Base de Datos de una librería, estas son las preguntas:
-- ¿Qué nacionalidades hay? 
SELECT DISTINCT nationality                                                             -- Al usar DISTINCT hago que no me muestre datos repetidos
FROM authors
ORDER BY nationality;


-- ¿Cuantos escritores hay de cada nacionalidad? 
SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
GROUP BY nationality
ORDER BY c_authors DESC;

SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;                                                         -- Tambien puedo ordenar por varios campos, primero por c_authors y luego por nationality

SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
WHERE nationality IS NOT NULL
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;    

SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
WHERE nationality IS NOT NULL
AND nationality NOT IN ('RUS', 'AUT')
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;  

SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
WHERE nationality IS NOT NULL
AND nationality IN ('RUS', 'AUT')
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC;  


-- ¿Cuantos libros hay de cada nacionalidad? 
SELECT nationality, COUNT(*) AS c_books
FROM books AS b 
LEFT JOIN authors AS a
  ON b.author_id = a.author_id
WHERE nationality IS NOT NULL
GROUP BY nationality;


-- ¿Cuál es el promedio y desviación estándar del precio de libros? 
SELECT AVG(price) AS average, STDDEV(price) AS standar_dev
FROM books;

UPDATE books                                                                                    -- Agregamos precios a los libros que lo tengan como NULL
  SET price = FLOOR(RAND()*(35-10+1))+10
  WHERE book_id between 1 and 198


-- ¿Cuál es el promedio/desviación estándar de la cantidad de autores por nacionalidad? 
SELECT nationality, AVG(price) AS average_avg, STDDEV(price) AS standar_dev
FROM books AS b
JOIN authors AS a
ON a.author_id = b.author_id
GROUP BY nationality;

SELECT nationality, AVG(price) AS average_avg, STDDEV(price) AS standar_dev
FROM books AS b
JOIN authors AS a
ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY average_avg DESC;

SELECT nationality, COUNT(book_id) AS c_books, AVG(price) AS average_avg, STDDEV(price) AS standar_dev
FROM books AS b
JOIN authors AS a
ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY c_books DESC;


-- ¿Cuál es el precio máximo y mínimo de un libro?
SELECT MAX(price)
FROM books;

SELECT a.nationality, MAX(b.price), MIN(b.price)
FROM books AS b
JOIN authors AS a
  ON a.author_id = b.author_id
GROUP BY a.nationality;


-- ¿Cómo quedaría el reporte de préstamos? 
SELECT c.name, t.type, b.title, a.name, a.nationality
FROM transactions AS t
LEFT JOIN clients AS c
  ON c.client_id = t.client_id
LEFT JOIN books AS b
  ON b.book_id = t.book_id
LEFT JOIN authors AS a
  ON a.author_id = b.author_id;


-- Vamos a usar CONCAT() para juntar la data de dos columnas
SELECT c.name, t.type, b.title, CONCAT(a.name, " (", a.nationality, ")") AS author_nationality
FROM transactions AS t
LEFT JOIN clients AS c
  ON c.client_id = t.client_id
LEFT JOIN books AS b
  ON b.book_id = t.book_id
LEFT JOIN authors AS a
  ON a.author_id = b.author_id;


-- TRABAJANDO CON FECHAS, usando Función TO_DAYS(), nos devuelve cuantos dias han pasado desde el inicio del calendario Gregoriano (año 0)
-- Nos dice cuantos dias han pasado desde el inicio del año 0
SELECT TO_DAYS(NOW());


-- Solo ha pasado un dia desde el año 0
SELECT TO_DAYS('0000-01-01');


-- Mostramos cuantos dias ha vivido alguien
SELECT name, TO_DAYS(NOW()) - TO_DAYS(birthdate) AS days_lived
FROM clients
LIMIT 10;


-- Agrego una columna que muestra cuantos dias han pasade desde que se crearon los datos de la transaccion usando función TO_DAYS()
SELECT c.name, t.type, b.title, CONCAT(a.name, " (", a.nationality, ")") AS author_nationality, TO_DAYS(NOW()) - TO_DAYS(t.created_at) AS create_ago
FROM transactions AS t
LEFT JOIN clients AS c
  ON c.client_id = t.client_id
LEFT JOIN books AS b
  ON b.book_id = t.book_id
LEFT JOIN authors AS a
  ON a.author_id = b.author_id;