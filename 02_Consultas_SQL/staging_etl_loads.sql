. INSERTAR DATOS DE EJEMPLO
-- ===================================================

-- Oficinas
INSERT INTO oficina (Descripcion, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
VALUES 
('BCN-ES','Barcelona','España','Cataluña','08019','+34 933561182','Avenida Diagonal 38',''),
('MAD-ES','Madrid','España','Madrid','28032','+34 917514487','Calle Mayor 10','');

-- Empleados
INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, ID_oficina, ID_jefe, puesto) VALUES
('Marcos','Magaña','Perez','3897','marcos@jardineria.es',1,NULL,'Director General'),
('Ruben','López','Martinez','2899','rlopez@jardineria.es',2,1,'Subdirector Ventas');

-- Categorías
INSERT INTO Categoria_producto (Desc_Categoria, descripcion_texto, descripcion_html, imagen)
VALUES 
('Herramientas','Herramientas manuales de jardinería','<b>Herramientas</b>','herramientas.png'),
('Plantas','Plantas ornamentales y de interior','<b>Plantas</b>','plantas.png');

-- Clientes
INSERT INTO cliente (nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, ciudad, pais, codigo_postal, ID_empleado_rep_ventas, limite_credito)
VALUES
('Jardinería Verde','Carlos','Pérez','911223344','911223345','Calle Alcalá 100','Madrid','España','28001',2,5000.00);

-- Productos
INSERT INTO producto (ID_producto, nombre, Categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor)
VALUES
('P001','Pala de mano',1,'30cm','Herramex','Pala metálica',150,12.50,8.00),
('P002','Maceta barro',2,'15cm','Ceramix','Maceta tradicional',200,7.00,3.50);

-- Pedido
INSERT INTO pedido (fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, ID_cliente)
VALUES ('2025-09-01','2025-09-10','2025-09-09','Entregado','Entrega rápida',1);

-- Detalle pedido
INSERT INTO detalle_pedido (ID_pedido, ID_producto, cantidad, precio_unidad, numero_linea)
VALUES (1,'P001',10,12.50,1);

-- Pago
INSERT INTO pago (ID_cliente, forma_pago, id_transaccion, fecha_pago, total)
VALUES (1,'Tarjeta Crédito','TX1001','2025-09-05',125.00);
