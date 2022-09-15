-- MARCA

CREATE TABLE marca(
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	num_empleados INT,
	CONSTRAINT pk_marca PRIMARY KEY(id)

);

SELECT * FROM marca;

INSERT INTO marca(name, num_empleados) VALUES ('Seat', 20);
INSERT INTO marca(name, num_empleados) VALUES ('Audi', 10000);

-- MODELO
CREATE TABLE modelo(
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	id_marca INT,
	CONSTRAINT pk_modelo PRIMARY KEY(id),
	CONSTRAINT fk_modelo_marca FOREIGN KEY(id_marca) REFERENCES marca(id)
);

SELECT * FROM modelo;

INSERT INTO modelo (name, id_marca) VALUES('Leon', 1);
INSERT INTO modelo (name, id_marca) VALUES('Tt', 2);
INSERT INTO modelo (name, id_marca) VALUES('Ibiza', 1);
INSERT INTO modelo (name, id_marca) VALUES('Rs 6', 2);

SELECT * FROM modelo;

-- VERSION
CREATE TABLE version(
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	motor VARCHAR(50),
	precio NUMERIC,
	cc NUMERIC(2,1),
	id_modelo INT,
	CONSTRAINT pk_version PRIMARY KEY(id),
	CONSTRAINT fk_versio_modelo FOREIGN KEY(id_modelo) REFERENCES modelo(id) ON UPDATE SET null ON DELETE SET NULL
);

INSERT INTO version(name, motor, precio, cc, id_modelo) VALUES('León Cupra', 'Gasolina', 40.000, 2.0, 1);
INSERT INTO version(name, motor, precio, cc, id_modelo) VALUES('RS6T', 'Electrico', 100.000, 0.0, 2);
INSERT INTO version(name, motor, precio, cc, id_modelo) VALUES('Ibiza FR', 'Gasolina', 26.000, 1.6, 1);

SELECT * FROM version;


-- EXTRA
CREATE TABLE extra(
	id SERIAL,
	name VARCHAR(50) NOT NULL,
	descripcción VARCHAR(300),
	CONSTRAINT pk_extra PRIMARY KEY(id)
);

SELECT * FROM extra;

CREATE TABLE extra_version(
	id_version INT,
	id_extra INT,
	precio NUMERIC NOT NULL CHECK (precio >= 0),
	CONSTRAINT pk_extra_version PRIMARY KEY(id_version, id_extra),
	CONSTRAINT fk_version_extra FOREIGN KEY(id_version) REFERENCES version(id) ON UPDATE cascade ON DELETE cascade,
	CONSTRAINT fk_extra_version FOREING KEY(id_extra) REFERENCES extra(id) ON UPDATE cascade ON DELETE cascade
);

INSERT INTO extra (name, descripcción) VALUES('Techo solar', 'Acabado dark, con cristal de seguridad y sistema eléctrico')
INSERT INTO extra (name, descripcción) VALUES('Neumaticos competición', 'Michelin Pilot Sport Cup 2')
INSERT INTO extra (name, descripcción) VALUES('Nevera', 'Insertada como parte del coche, con espacio para 4 bebidas')

-- Seat Ibiza FR techo solar
INSERT INTO extra_version VALUES(1, 1, 3000);
-- Audi RS6T nevera
INSERT INTO extra_version VALUES(2, 2, 8000);


SELECT * FROM extra_version;

-- Empleados
CREATE TABLE empleado(
	id SERIAL,
	name VARCHAR(30),
	nif VARCHAR(9) NOT NULL UNIQUE,
	teléfono VARCHAR(9),
	CONSTRAINT pk_empleado PRIMARY KEY(id)
);

INSERT INTO empleado(name, nif, teléfono) VALUES("Pedro", "11223366A", "666666666");
INSERT INTO empleado(name, nif, teléfono) VALUES("Estela", "11277366A", "666665555");


SELECT * FROM empleado;

-- Cliente
CREATE TABLE cliente(
	id SERIAL,
	name VARCHAR(30),
	email VARCHAR(50) NOT NULL UNIQUE,
	CONSTRAINT pk_cliente PRIMARY KEY(id)
);

INSERT INTO cliente(name, email) VALUES("Sonia", "srn@hetmail.es")
INSERT INTO cliente(name, email) VALUES("David", "dvds@hetmail.es")


SELECT * FROM cliente;

-- Vehículo 
CREATE TABLE vehículo(
	id SERIAL,
	matricula VARCHAR(7),
	fecha_fabricación DATE,
	precio_final NUMERIC,
	precio_neto NUMERIC,
	tipo VARCHAR(30),
	id_marca INT,
	id_modelo INT,
	id_version INT,
	id_extra INT,
	CONSTRAINT pk_vehículo PRIMARY KEY(id),
	CONSTRAINT fk_vehículo_marca FOREIGN KEY(id_marca) REFERENCES marca(id),
	CONSTRAINT fk_vehículo_modelo FOREIGN KEY(id_modelo) REFERENCES modelo(id),
	CONSTRAINT fk_vehículo_extra_version FOREIGN KEY(id_version, id_extra) REFERENCES extra_version(id_version, id_extra)

);

INSERT INTO vehículo(matricula, precio_final, id_marca, id_version, id_extra)
VALUES('0000XXX', 30000, 1, 2, 1, 2);

INSERT INTO vehículo(matricula, precio_final, id_marca, id_version, id_extra)
VALUES('0200XYX', 90000, 1, 3, 3, 3);


SELECT * FROM vehículo;

-- Venta
CREATE TABLE venta(
	id SERIAL,
	fecha_venta DATE,
	descripción VARCHAR(300),
	id_vehiculo INT,
	id_empleado INT,
	id_cliente INT,
	CONSTRAINT venta PRIMARY KEY(id),
	CONSTRAINT fk_venta_vehículo FOREIGN KEY(id_vehículo) REFERENCES vehículo(id)
	CONSTRAINT fk_venta_empleado FOREIGN KEY(id_empleado) REFERENCES empleado(id)
	CONSTRAINT fk_venta_cliente FOREIGN KEY(id_cliente) REFERENCES cliente(id)
);

INSERT INTO venta(fecha_venta, descripción, id_vehículo, id_empleado, id_cliente)
VALUES('2022-09-15', "venta telefónica", 1, 1, 1);

SELECT * FROM venta;





