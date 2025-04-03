-- Muestra las ventas (movimientos de tipo salida), junta la información
-- de la tienda, producto y empleado. Además calcula el total de la venta.
CREATE VIEW ReporteVentas AS
SELECT 
    m.IDmovimiento,
    t.nombre AS Tienda,
    p.nombre AS Producto,
    p.precio,
    m.cantidad,
    (p.precio * m.cantidad) AS TotalVenta,
    m.fecha,
    e.nombre AS Empleado,
    m.motivo
FROM Movimientos m
INNER JOIN Tiendas t ON m.IDtienda = t.IDtienda
INNER JOIN Productos p ON m.IDproducto = p.IDproducto
INNER JOIN Empleados e ON m.IDempleado = e.IDempleado
WHERE m.tipo = 'salida';

-- Vista donde se muestra el producto, su id y el stock total disponible.
CREATE VIEW StockTotal AS
SELECT 
    p.IDproducto,
    p.nombre AS Producto,
    SUM(i.stock) AS TotalStock
FROM Inventario i
INNER JOIN Productos p ON i.IDproducto = p.IDproducto
GROUP BY p.IDproducto, p.nombre;
