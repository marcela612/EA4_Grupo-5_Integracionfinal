
-- 05_consultas_completo.sql
-- Versión: completa para EA2/EA3/EA4 (consultas, CRUD, funciones, triggers, analíticas)
-- NOTA: ejecútalo sobre la base de datos apropiada (jardineria o jardineria_datamart) según corresponda.

/* ===========================
   VALIDACIONES / CONTADORES
   (Ejecutar en la BD transaccional: jardineria)
=========================== */
USE jardineria;

-- Conteos básicos (calidad)
SELECT COUNT(*) AS total_oficinas FROM oficina;
SELECT COUNT(*) AS total_empleados FROM empleado;
SELECT COUNT(*) AS total_clientes FROM cliente;
SELECT COUNT(*) AS total_pedidos FROM pedido;
SELECT COUNT(*) AS total_productos FROM producto;
SELECT COUNT(*) AS total_detalles FROM detalle_pedido;
SELECT COUNT(*) AS total_pagos FROM pago;

/* ===========================
   PROCEDIMIENTOS CRUD (CLIENTE)
=========================== */
DROP PROCEDURE IF EXISTS InsertarCliente;
DELIMITER $$
CREATE PROCEDURE InsertarCliente(
    IN p_nombre_cliente VARCHAR(100),
    IN p_nombre_contacto VARCHAR(50),
    IN p_apellido_contacto VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_ciudad VARCHAR(50),
    IN p_pais VARCHAR(50),
    IN p_id_empleado_rep INT,
    IN p_limite_credito DECIMAL(10,2)
)
BEGIN
    INSERT INTO cliente (nombre_cliente, nombre_contacto, apellido_contacto, telefono, ciudad, pais, ID_empleado_rep_ventas, limite_credito)
    VALUES (p_nombre_cliente, p_nombre_contacto, p_apellido_contacto, p_telefono, p_ciudad, p_pais, p_id_empleado_rep, p_limite_credito);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ActualizarCliente;
DELIMITER $$
CREATE PROCEDURE ActualizarCliente(
    IN p_id_cliente INT,
    IN p_telefono VARCHAR(20),
    IN p_ciudad VARCHAR(50),
    IN p_pais VARCHAR(50),
    IN p_limite_credito DECIMAL(10,2)
)
BEGIN
    UPDATE cliente
    SET telefono = p_telefono,
        ciudad = p_ciudad,
        pais = p_pais,
        limite_credito = p_limite_credito
    WHERE ID_cliente = p_id_cliente;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS EliminarCliente;
DELIMITER $$
CREATE PROCEDURE EliminarCliente(IN p_id_cliente INT)
BEGIN
    DELETE FROM cliente WHERE ID_cliente = p_id_cliente;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ListarClientes;
DELIMITER $$
CREATE PROCEDURE ListarClientes()
BEGIN
    SELECT * FROM cliente;
END$$
DELIMITER ;


/* ===========================
   PROCEDIMIENTOS CRUD (EMPLEADO)
=========================== */
DROP PROCEDURE IF EXISTS InsertarEmpleado;
DELIMITER $$
CREATE PROCEDURE InsertarEmpleado(
   IN p_nombre VARCHAR(50),
   IN p_apellido1 VARCHAR(50),
   IN p_apellido2 VARCHAR(50),
   IN p_extension VARCHAR(10),
   IN p_email VARCHAR(100),
   IN p_id_oficina INT,
   IN p_id_jefe INT,
   IN p_puesto VARCHAR(50)
)
BEGIN
   INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, ID_oficina, ID_jefe, puesto)
   VALUES (p_nombre, p_apellido1, p_apellido2, p_extension, p_email, p_id_oficina, p_id_jefe, p_puesto);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ActualizarEmpleado;
DELIMITER $$
CREATE PROCEDURE ActualizarEmpleado(
   IN p_id INT,
   IN p_email VARCHAR(100),
   IN p_puesto VARCHAR(50)
)
BEGIN
   UPDATE empleado SET email = p_email, puesto = p_puesto WHERE ID_empleado = p_id;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS EliminarEmpleado;
DELIMITER $$
CREATE PROCEDURE EliminarEmpleado(IN p_id INT)
BEGIN
   DELETE FROM empleado WHERE ID_empleado = p_id;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS ListarEmpleados;
DELIMITER $$
CREATE PROCEDURE ListarEmpleados()
BEGIN
   SELECT * FROM empleado;
END$$
DELIMITER ;


/* ===========================
   FUNCIÓN: TotalVentasCliente (transaccional)
   calcula la suma de (cantidad * precio_unidad) para un cliente
=========================== */
DROP FUNCTION IF EXISTS TotalVentasCliente;
DELIMITER $$
CREATE FUNCTION TotalVentasCliente(p_id_cliente INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
   DECLARE total DECIMAL(12,2) DEFAULT 0;
   SELECT SUM(dp.cantidad * dp.precio_unidad) INTO total
   FROM detalle_pedido dp
   JOIN pedido p ON dp.ID_pedido = p.ID_pedido
   WHERE p.ID_cliente = p_id_cliente;
   RETURN IFNULL(total,0);
END$$
DELIMITER ;


/* ===========================
   TRIGGER: actualizar stock después de insertar un detalle de pedido
=========================== */
DROP TRIGGER IF EXISTS ActualizarStock_AfterInsert;
DELIMITER $$
CREATE TRIGGER ActualizarStock_AfterInsert
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
   UPDATE producto
   SET cantidad_en_stock = cantidad_en_stock - NEW.cantidad
   WHERE ID_producto = NEW.ID_producto;
END$$
DELIMITER ;


/* ===========================
   CONSULTAS ANALÍTICAS (DATAMART)
   Cambiar a la BD del datamart cuando corresponda
=========================== */
USE jardineria_datamart;

-- Total de ventas por cliente (fact_ventas)
SELECT c.nombre_cliente, SUM(f.total) AS total_cliente
FROM fact_ventas f
JOIN dim_cliente c ON f.id_cliente = c.ID_cliente
GROUP BY c.nombre_cliente;

-- Total de ventas por producto
SELECT p.nombre, SUM(f.cantidad) AS unidades_vendidas, SUM(f.total) AS total_ventas
FROM fact_ventas f
JOIN dim_producto p ON f.id_producto = p.ID_producto
GROUP BY p.nombre;

-- Total de ventas por empleado
SELECT e.nombre, e.apellido1, SUM(f.total) AS total_vendido
FROM fact_ventas f
JOIN dim_empleado e ON f.id_empleado = e.ID_empleado
GROUP BY e.nombre, e.apellido1;

-- Ventas por mes
SELECT t.anio, t.mes, SUM(f.total) AS ventas_mes
FROM fact_ventas f
JOIN dim_tiempo t ON f.id_tiempo = t.id_tiempo
GROUP BY t.anio, t.mes
ORDER BY t.anio, t.mes;
