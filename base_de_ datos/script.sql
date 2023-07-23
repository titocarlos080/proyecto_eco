 -- crear base de datos
 -- drop database proyecto_eco
create database proyecto_eco;
SET GLOBAL log_bin_trust_function_creators = 1;
use proyecto_eco;
-- tabla categoria
create table categoria(
id int auto_increment primary key not null,
nombre varchar(40) not null
);
-- tabla de gastos
create table gastos(
id int auto_increment primary key not null,
monto float not null  ,
fecha varchar(50),
asunto varchar(200) ,
id_categoria int not null,
foreign key (id_categoria) references categoria(id)
);
create table cuenta(
id int auto_increment primary key not null,
nombre varchar(150) not null
);
create table movcuenta(
id int auto_increment primary key not null,
fecha varchar(150) not null,
monto float not null,
id_cuenta int not null,
foreign key (id_cuenta) references cuenta(id)
);
insert into cuenta values(1,'adm');
DELIMITER //
CREATE FUNCTION calcular_saldo() RETURNS FLOAT
BEGIN
    DECLARE saldo FLOAT;
    DECLARE gasto FLOAT;
    SELECT IFNULL(SUM(monto), 0) INTO saldo FROM movcuenta;
    SELECT IFNULL(SUM(monto), 0) INTO gasto FROM gastos;
    RETURN saldo-gasto;
END;
//
DELIMITER ;
 
-- Insertar 10 categorías
INSERT INTO categoria (nombre) VALUES('Alimentación'),('Transporte'),('Entretenimiento'),('Salud'),
									('Educación'),('Ropa'),('Hogar'),('Tecnología'),('Viajes'),('Otros');
-- Insertar 5 gastos para cada categoría
-- Categoría 'Alimentación'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(1, 10.50, 'Compras en el supermercado', 1),
(2, 8.75, 'Cena en restaurante', 1),
(3, 15.20, 'Almuerzo en el trabajo', 1),
(4, 5.00, 'Postres y golosinas', 1),
(5, 20.30, 'Café y snacks', 1);

-- Categoría 'Transporte'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(6, 50.00, 'Gasolina para el auto', 2),
(7, 25.75, 'Boletos de transporte público', 2),
(8, 12.30, 'Uber o taxi', 2),
(9, 15.50, 'Peaje', 2),
(10, 30.00, 'Mantenimiento del auto', 2);

-- Categoría 'Entretenimiento'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(11, 12.00, 'Boletos de cine', 3),
(12, 8.50, 'Suscripción a streaming', 3),
(13, 5.75, 'Entradas a conciertos', 3),
(14, 20.00, 'Juegos y entretenimiento digital', 3),
(15, 18.25, 'Actividades recreativas', 3);

-- Categoría 'Salud'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(16, 30.75, 'Medicamentos', 4),
(17, 50.00, 'Consultas médicas', 4),
(18, 15.00, 'Vitaminas y suplementos', 4),
(19, 10.25, 'Productos de cuidado personal', 4),
(20, 45.80, 'Seguro médico', 4);

-- Categoría 'Educación'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(21, 25.00, 'Libros y material escolar', 5),
(22, 12.50, 'Cursos y talleres', 5),
(23, 40.00, 'Matrícula y colegiaturas', 5),
(24, 18.75, 'Material de estudio', 5),
(25, 5.20, 'Suscripciones educativas', 5);

-- Categoría 'Ropa'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(26, 50.00, 'Ropa de temporada', 6),
(27, 30.25, 'Calzado', 6),
(28, 15.50, 'Accesorios', 6),
(29, 20.00, 'Ropa deportiva', 6),
(30, 25.80, 'Ropa íntima', 6);

-- Categoría 'Hogar'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(31, 100.00, 'Muebles y decoración', 7),
(32, 50.25, 'Electrodomésticos', 7),
(33, 30.50, 'Artículos de limpieza', 7),
(34, 40.00, 'Reparaciones y mejoras', 7),
(35, 25.75, 'Compras para el hogar', 7);

-- Categoría 'Tecnología'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(36, 500.00, 'Compra de teléfono móvil', 8),
(37, 120.00, 'Accesorios electrónicos', 8),
(38, 30.75, 'Aplicaciones y software', 8),
(39, 80.50, 'Dispositivos y gadgets', 8),
(40, 250.25, 'Reparación de equipos', 8);

-- Categoría 'Viajes'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(41, 1000.00, 'Boletos de avión', 9),
(42, 250.50, 'Hospedaje', 9),
(43, 80.25, 'Comidas y restaurantes', 9),
(44, 150.75, 'Actividades turísticas', 9),
(45, 200.00, 'Souvenirs y recuerdos', 9);

-- Categoría 'Otros'
INSERT INTO gastos (id, monto, asunto, id_categoria) VALUES
(46, 50.00, 'Regalos y obsequios', 10),
(47, 30.25, 'Caridad y donaciones', 10),
(48, 15.50, 'Gastos inesperados', 10),
(49, 20.00, 'Multas y penalizaciones', 10),
(50, 25.80, 'Otros gastos varios', 10);

-- CONSULTAS
select * from gastos;
-- EJ. saca los gastos de las categoria Otros
select gastos.* from categoria, gastos where categoria.id=gastos.id_categoria and categoria.nombre='Otros';
delete  from gastos

 