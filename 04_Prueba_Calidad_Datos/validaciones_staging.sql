USE staging_jardineria;

SELECT COUNT(*) AS clientes_staging FROM dim_cliente;
SELECT COUNT(*) AS empleados_staging FROM dim_empleado;
SELECT COUNT(*) AS productos_staging FROM dim_producto;
SELECT COUNT(*) AS pedidos_staging FROM fact_pedido;
