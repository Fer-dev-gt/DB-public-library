-- El keyword "UNSIGNED" hace que el book_id sea solo positivos, lo cual ahorra el espacio de memoria del signo del númeor haciendo mas rápida la tabla 
-- La columna 'cover_url' sera la URL de una foto/imagen
-- El tipo de dato 'TINYINT(1)' lo usaremos para almacenar datos Booleanos 0 y 1
CREATE TABLE IF NOT EXISTS books (
  book_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  author_id INT UNSIGNED,
  title VARCHAR(100) NOT NULL,
  year INT UNSIGNED NOT NULL DEFAULT 1900,
  language VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',
  cover_url VARCHAR(500),
  price DOUBLE NOT NULL DEFAULT 10.0,
  sellable TINYINT DEFAULT 1,
  copies INT NOT NULL DEFAULT 1,
  description TEXT
);


CREATE TABLE IF NOT EXISTS authors(
  author_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,                                                                   -- `name` va en comillas para especificarle a SQL que se trata del nombre de una columna y no una keyword
  nationality VARCHAR(3)
);


CREATE TABLE clients(
  client_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  birthdate DATETIME,
  gender ENUM('M', 'F', 'ND') NOT NULL,
  active TINYINT DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS operations(
  operations_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  book_id INTEGER UNSIGNED NOT NULL,
  client_id INTEGER UNSIGNED NOT NULL,
  type ENUM('prestado', 'devuelto', 'vendido') NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  finished TINYINT NOT NULL
);


-- INSERTANDO DATOS
INSERT INTO authors(author_id, name, nationality)
VALUES('', 'Juan Rulfo', 'MEX');                                                                -- Consejo, cuando el id esta en AUTO_INCREMENT podemos mandar el dato vacio y se aumentara automaticamente


-- Aplicando el AUTO_INCREMENT ahora solo inserto datos en las otras 2 columnas
INSERT INTO authors(name, nationality)
VALUES('Juan Rulfo', 'MEX'),
('Gabriel García Márquez', 'COL'),
('Juan Gabriel Vasquez', 'COL'),
('Julio Cortázar', 'ARG'),
('Isabel Allende', 'CHI'),
('Octavio Paz', 'MEX'),
('Juan Carlos Onelli', 'URU');


-- Otra forma de ingresar datos a una tabla, no especificamos las columnas pero mandamos todos los campos de las columnas con algun dato
INSERT INTO authors
VALUES ('','Gabriel García Márquez', 'COL');


-- Acá le di un valor en especifico al campo 'created_at' para el año 2018
INSERT INTO `clients` (client_id, name, email, birthdate, gender, active, created_at)
VALUES 
(1,'Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1,'2018-04-09 16:51:30'),
(2,'Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1,'2018-04-09 16:51:30'),
(3,'Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1,'2018-04-09 16:51:30'),
(4,'Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1,'2018-04-09 16:51:30');


-- Intentando ingresar datos repetidos en el campo de email
INSERT INTO `clients` (name, email, birthdate, gender, active, created_at)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1,'2018-04-09 16:51:30');


-- IMPORTANTE NUNCA USAR ESTE COMANDO 'IGNORE ALL', HACE QUE LA APLICACIÓN NO LANCE ERRORES Y NO LE HAGA CASO A LOS ERRORES LO CUAL HACE QUE LA APLIACIÓN SEA DEFECTUOSA 
INSERT INTO `clients` (name, email, birthdate, gender, active)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
ON DUPLICATE KEY IGNORE ALL;


-- Al usar el Comando 'ON DUPLICATE KEY UPDATE SET active = VALUES(active)' hago que el query actualice el campo señalado con el valor que cambié, en este caso de 1 a 0 en la columna activo
INSERT INTO `clients` (name, email, birthdate, gender, active)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
ON DUPLICATE KEY UPDATE active = VALUES(active);


INSERT INTO books (title, author_id) 
VALUES('El laberinto de la soledad', 6);


-- Usamos un query anidado para insertar datos de un 'author_id' en particular (No muy recomendado, complejidad algoritmica Big O al cuadrado)
INSERT INTO books (title, author_id, `year`) 
VALUES('Vuelta al laberinto de la soledad',
 (SELECT author_id FROM authors
 WHERE name = 'Octavio Paz'
 LIMIT 1), 1960                                                           -- Limitamos a que solo nos devuelva un registro que usaremos para insertar en el query externo
);