-- Comparación Origen vs Staging

-- Clientes
SELECT 
   (SELECT COUNT(*) FROM jardineria.cliente) AS clientes_origen,
   (SELECT COUNT(*) FROM staging_jardineria.dim_cliente) AS clientes_staging;

-- Empleados
SELECT 
   (SELECT COUNT(*) FROM jardineria.empleado) AS empleados_origen,
   (SELECT COUNT(*) FROM staging_jardineria.dim_empleado) AS empleados_staging;

-- Productos
SELECT 
   (SELECT COUNT(*) FROM jardineria.producto) AS productos_origen,
   (SELECT COUNT(*) FROM staging_jardineria.dim_producto) AS productos_staging;

-- Pedidos
SELECT 
   (SELECT COUNT(DISTINCT id_pedido) FROM jardineria.pedido) AS pedidos_origen,
   (SELECT COUNT(*) FROM staging_jardineria.fact_pedido) AS pedidos_staging;
