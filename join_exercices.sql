-- EJERCICIOS USANDO JOIN, un JOIN es tomar 2 tablas, relacionarlas y desplegar la información ya relacionada
-- JOIN es igual a INNER JOIN, esta implicito
-- Muestro el book_id, el nombre del autor de ese libro y el titulo de dicho libre, solo muestro los autoroes con 'author_id' del 1 al 5
SELECT b.book_id, a.name, b.title
FROM books AS b
JOIN authors AS a
  on a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5;


-- Traigo la misma información solo le agrego el 'author_id'
SELECT b.book_id, a.name, a.author_id, b.title
FROM books AS b
JOIN authors AS a
  on a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5;


-- Los datos que trae este query estan con numeros en id, hay que cambiarlos para que muestro el nombre de la persona asociada a ese número juntando varias tablas
SELECT * FROM transactions;


-- Aca estoy relacionando 3 tablas para mostrar los nombres de autores y libros que estan relacionados a la tabla 'transactions' por medio de su id
-- Muestro en la columnas, el nombre del cliente, el titulo del libro y el tipo de transacción
SELECT c.name, b.title, t.type
FROM transactions AS t
JOIN books AS b
  ON t.book_id = b.book_id
JOIN clients AS c
  ON t.client_id = c.client_id;


-- Ahora le pongo una condición a la información de arriba, le pido que traiga a los clientes mujeres y que su tipo de transacción sea 'sell'
SELECT c.name, b.title, t.type
FROM transactions AS t
JOIN books AS b
  ON t.book_id = b.book_id
JOIN clients AS c
  ON t.client_id = c.client_id
WHERE c.gender = 'F' AND t.type = 'sell';


-- Puedo realizar cuantas tablas necesito, ahora voy a relacionar 4 tablas al sumarle la de 'authors'
-- Por medio de la tabla b de books relaciono a la tabla authors por medio de su id
SELECT c.name, b.title, a.name, t.type
FROM transactions AS t
JOIN books AS b
  ON t.book_id = b.book_id
JOIN clients AS c
  ON t.client_id = c.client_id
JOIN authors AS a
  ON b.author_id = a.author_id
WHERE c.gender = 'F' AND t.type = 'sell';


-- En el campo t.type puedo definir una lista de opciones donde sea valido la condición, usando el comando IN('choices') tiene que estar exactamente iguales
SELECT c.name, b.title, a.name, t.type
FROM transactions AS t
JOIN books AS b
  ON t.book_id = b.book_id
JOIN clients AS c
  ON t.client_id = c.client_id
JOIN authors AS a
  ON b.author_id = a.author_id
WHERE c.gender = 'M' AND t.type IN ('sell', 'lend');                                                            -- Para validar varias opciones usamos IN()


-- Muchos realizan un INNER JOIN sin darse cuenta, lo hacen de esta manera
SELECT b.title, a.name
FROM authors AS a, books AS b
WHERE a.author_id = b.author_id
LIMIT 10;


-- Desplegando exactamente la misma información con este query con un JOIN implicito
SELECT b.title, a.name
FROM books AS b
INNER JOIN authors AS a
  ON a.author_id = b.author_id
LIMIT 10;


-- Muestro datos dentro un INNER JOIN implicito y lo voy comparar despues en el otro query con un RIGHT JOIN que me va a traer registros NULL de una tabla
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5;


-- Traigo a todos las autores incluso si no tienen registros en la tabla books
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
LEFT JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5;


-- Ordeno como se despliegan los datos de manera ascendente y descendente con ORDER BY
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id;                                                                                           -- De forma implicita se ordena de forma Ascendente


-- Ordeno de manera DESC
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id DESC;


-- Tambien puedo order con letras desde a-z o z-a
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.name DESC;


SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
LEFT JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id ASC;


-- Ejercicios de COUNT(something) con GROUP BY
-- Muestro cuanto books distintos tiene cada autor
SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id)
FROM authors AS a
LEFT JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id                                                                                            -- GROUP BY hace 'aggregation', quiere decir que en vez de mostrar 3 veces los datos de un autor va a mostrar solo una vez al autor pero que tiene 3 libros escritos
ORDER BY a.author_id;                                                                                           -- Siempre que se pueda es mejor agrupar u ordenar por un id que por un string


-- Si en vez de usar un LEFT JOIN uso un INNER JOIN solo me traera los datos que tienen libros registrados, los NULL no los va a traer
SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id)
FROM authors AS a
INNER JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id                          
ORDER BY a.author_id;  


-- Le colocamos un alias a la columna que cuenta los libros
SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id) AS published_books
FROM authors AS a
LEFT JOIN books AS b
  on b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id                          
ORDER BY a.author_id;


-- Puedo ORDER BY en orden random, nunca se desplegara de la misma manera las filas aunque ejecutemos el mismo comando (no muy recomendado programaticamento con un script)
SELECT * 
FROM authors
ORDER BY RAND()
LIMIT 10;