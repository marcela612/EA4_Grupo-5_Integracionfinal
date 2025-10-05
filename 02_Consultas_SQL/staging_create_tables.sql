DROP DATABASE IF EXISTS jardineria;
CREATE DATABASE jardineria;
USE jardineria;

-- ===================================================
-- 2. CREAR TABLAS
-- ===================================================

-- Oficinas
CREATE TABLE oficina (
    ID_oficina INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(100),
    ciudad VARCHAR(50),
    pais VARCHAR(50),
    region VARCHAR(50),
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    linea_direccion1 VARCHAR(100),
    linea_direccion2 VARCHAR(100)
);

-- Empleados
CREATE TABLE empleado (
    ID_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    extension VARCHAR(10),
    email VARCHAR(100),
    ID_oficina INT,
    ID_jefe INT,
    puesto VARCHAR(50),
    FOREIGN KEY (ID_oficina) REFERENCES oficina(ID_oficina),
    FOREIGN KEY (ID_jefe) REFERENCES empleado(ID_empleado)
);

-- Categorías de productos
CREATE TABLE Categoria_producto (
    ID_categoria INT AUTO_INCREMENT PRIMARY KEY,
    Desc_Categoria VARCHAR(50),
    descripcion_texto TEXT,
    descripcion_html TEXT,
    imagen VARCHAR(100)
);

-- Clientes
CREATE TABLE cliente (
    ID_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    nombre_contacto VARCHAR(50),
    apellido_contacto VARCHAR(50),
    telefono VARCHAR(20),
    fax VARCHAR(20),
    linea_direccion1 VARCHAR(100),
    linea_direccion2 VARCHAR(100),
    ciudad VARCHAR(50),
    region VARCHAR(50),
    pais VARCHAR(50),
    codigo_postal VARCHAR(10),
    ID_empleado_rep_ventas INT,
    limite_credito DECIMAL(10,2),
    FOREIGN KEY (ID_empleado_rep_ventas) REFERENCES empleado(ID_empleado)
);

-- Pedidos
CREATE TABLE pedido (
    ID_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE,
    fecha_esperada DATE,
    fecha_entrega DATE,
    estado VARCHAR(15),
    comentarios TEXT,
    ID_cliente INT,
    FOREIGN KEY (ID_cliente) REFERENCES cliente(ID_cliente)
);

-- Productos
CREATE TABLE producto (
    ID_producto VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(100),
    Categoria INT,
    dimensiones VARCHAR(25),
    proveedor VARCHAR(50),
    descripcion TEXT,
    cantidad_en_stock INT,
    precio_venta DECIMAL(10,2),
    precio_proveedor DECIMAL(10,2),
    FOREIGN KEY (Categoria) REFERENCES Categoria_producto(ID_categoria)
);

-- Detalle pedido
CREATE TABLE detalle_pedido (
    ID_pedido INT,
    ID_producto VARCHAR(15),
    cantidad INT,
    precio_unidad DECIMAL(10,2),
    numero_linea SMALLINT,
    PRIMARY KEY(ID_pedido, ID_producto),
    FOREIGN KEY (ID_pedido) REFERENCES pedido(ID_pedido),
    FOREIGN KEY (ID_producto) REFERENCES producto(ID_producto)
);

-- Pagos
CREATE TABLE pago (
    ID_pago INT AUTO_INCREMENT PRIMARY KEY,
    ID_cliente INT,
    forma_pago VARCHAR(40),
    id_transaccion VARCHAR(50),
    fecha_pago DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (ID_cliente) REFERENCES cliente(ID_cliente)
);
