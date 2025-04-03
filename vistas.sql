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
    i.IDtienda,
    t.nombre AS Tienda,
    p.IDproducto,
    p.nombre AS Producto,
    i.stock AS Stock,
    i.fechaUltimaActualizacion
FROM Inventario i
INNER JOIN Tiendas t ON i.IDtienda = t.IDtienda
INNER JOIN Productos p ON i.IDproducto = p.IDproducto;


-- Muestra los movimientos realizados en los úlitmos 7 días, muestra la tienda,
-- el producto, el empleado que realizo el movimiento, el tipo de movimiento,
-- cantidad, fecha y motivo del movimiento.
CREATE VIEW MovimientosRecientes AS
SELECT 
    m.IDmovimiento,
    t.nombre AS Tienda,
    p.nombre AS Producto,
    e.nombre AS Empleado,
    m.tipo,
    m.cantidad,
    m.fecha,
    m.motivo
FROM Movimientos m
INNER JOIN Tiendas t ON m.IDtienda = t.IDtienda
INNER JOIN Productos p ON m.IDproducto = p.IDproducto
INNER JOIN Empleados e ON m.IDempleado = e.IDempleado
WHERE m.fecha >= DATE_SUB(NOW(), INTERVAL 7 DAY);

-- Muestra los productos con un stock bajo (menor a 10)
CREATE VIEW StockBajoIndividual AS
SELECT 
    i.IDtienda,
    t.nombre AS Tienda,
    p.IDproducto,
    p.nombre AS Producto,
    i.stock AS Stock
FROM Inventario i
INNER JOIN Tiendas t ON i.IDtienda = t.IDtienda
INNER JOIN Productos p ON i.IDproducto = p.IDproducto
WHERE i.stock < 10;

-- Muestra los movimientos totales por producto individual
CREATE VIEW MovimientosTotalesProducto AS
SELECT 
    m.IDtienda,
    t.nombre AS Tienda,
    p.IDproducto,
    p.nombre AS Producto,
    SUM(CASE WHEN m.tipo = 'entrada' THEN m.cantidad ELSE 0 END) AS TotalEntradas,
    SUM(CASE WHEN m.tipo = 'salida' THEN m.cantidad ELSE 0 END) AS TotalSalidas,
    SUM(CASE WHEN m.tipo = 'ajuste' THEN m.cantidad ELSE 0 END) AS TotalAjustes,
    (SUM(CASE WHEN m.tipo = 'entrada' THEN m.cantidad ELSE 0 END) -
     SUM(CASE WHEN m.tipo = 'salida' THEN m.cantidad ELSE 0 END)) AS MovimientoNeto
FROM Movimientos m
INNER JOIN Tiendas t ON m.IDtienda = t.IDtienda
INNER JOIN Productos p ON m.IDproducto = p.IDproducto
GROUP BY m.IDtienda, t.nombre, p.IDproducto, p.nombre;

-- Muestra los cambios realizados, indica la acción, la fecha, el motivo, el estado
-- anterior y quien realizo la acción.
CREATE VIEW HistorialCambios AS
SELECT 
    h.IDhistorial,
    h.IDmovimiento,
    e.nombre AS Empleado,
    h.accion,
    h.fechaCambio,
    h.motivoCambio,
    h.datosAnteriores
FROM HistorialMovimientos h
INNER JOIN Empleados e ON h.IDempleado = e.IDempleado;
