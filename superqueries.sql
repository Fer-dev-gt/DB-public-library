-- Realizando "SUPER QUERIES" para responder preguntas del negocio a mayor profundidad y hacer matrices que vuelvan "más inteligentes" a las tablas
SELECT DISTINCT nationality
FROM authors;


-- Es una mejor práctica hacer un COUNT() con el id de la tabla en vez de COUNT(*)
SELECT COUNT(book_id)
FROM books;


-- Tambien podemos usar SUM(1) que se incrementara por 1 cada vez que pase por una fila
SELECT COUNT(book_id), SUM(1)
FROM books;

-- Podemos usar el SUM() con condicionales para que cumpla ciertos requisitos
SELECT SUM(price)
FROM books
WHERE sellable = 1;


-- Puedo meter mas operaciones dentro de SUM()
SELECT SUM(price * copies)
FROM books
WHERE sellable = 1;

SELECT sellable, SUM(price * copies)
FROM books
GROUP BY sellable;


-- Metemos condiciones ADENTRO del SUM() usando IF(condicion, valor_si_verdadero, valor_si_falso)
-- En este query pedimos cuantos años son publicados antes de 1950 y hacemos un contador
SELECT COUNT(book_id), SUM(IF(year < 1950, 1, 0)) AS '<1950'
FROM books;

SELECT COUNT(book_id),
 SUM(IF(year < 1950, 1, 0)) AS '<1950',
 SUM(IF(year < 1950, 0, 1)) AS '>1950'
FROM books;


-- Creamos una matriz con los años de publicacion, haciendo mas inteligente a las filas
SELECT COUNT(book_id),
 SUM(IF(year < 1950, 1, 0)) AS '<1950',
 SUM(IF(year >= 1950 AND year < 1990, 1, 0)) AS '<1990'
FROM books;

SELECT COUNT(book_id),
 SUM(IF(year < 1950, 1, 0)) AS '<1950',
 SUM(IF(year >= 1950 AND year < 1990, 1, 0)) AS '<1990',
 SUM(IF(year >= 1990 AND year < 2000, 1, 0)) AS '<2000',
 SUM(IF(year > 2000, 1, 0)) AS '<hoy'
FROM books;


-- Ahora le agregamos mas campos como nationality 
SELECT nationality, COUNT(book_id),
 SUM(IF(year < 1950, 1, 0)) AS '<1950',
 SUM(IF(year >= 1950 AND year < 1990, 1, 0)) AS '<1990',
 SUM(IF(year >= 1990 AND year < 2000, 1, 0)) AS '<2000',
 SUM(IF(year > 2000, 1, 0)) AS '<hoy'
FROM books AS b
JOIN authors AS a
  ON a.author_id = b.author_id
WHERE a.nationality IS NOT NULL
GROUP BY nationality;