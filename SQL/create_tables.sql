CREATE TABLE Customer (
  id INT PRIMARY KEY,
  email VARCHAR(100),
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  sexo VARCHAR(10),
  direccion VARCHAR(100),
  fecha_nacimiento DATE,
  telefono VARCHAR(20)
);

CREATE TABLE Category (
  id INT PRIMARY KEY,
  descripcion VARCHAR(1000),
  path VARCHAR(255)
);

CREATE TABLE Item (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  precio DECIMAL(10,2),
  descripcion TEXT,
  estado VARCHAR(20),
  fecha_baja DATE,
  categoria_id INT,
  FOREIGN KEY (categoria_id) REFERENCES Category(id)
);

CREATE TABLE OrderP (
  id INT PRIMARY KEY,
  customer_id INT,
  item_id INT,
  fecha_compra DATE,
  cantidad INT,
  FOREIGN KEY (customer_id) REFERENCES Customer(id),
  FOREIGN KEY (item_id) REFERENCES Item(id)
);