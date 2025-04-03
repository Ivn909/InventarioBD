USE inventario;
DELIMITER //

-- Procedimiento: registrarEntrada
-- Inserta una entrada de productos usando el código de barras y cantidad.
CREATE PROCEDURE registrarEntrada(
    IN codBarras DOUBLE,
    IN cantidad INT
)
BEGIN
    DECLARE IDprod INT;
    DECLARE IDtienda INT DEFAULT 1;
    DECLARE IDempleado INT DEFAULT 1;
    DECLARE IDproveedor INT DEFAULT 1;

    -- Buscar producto por código de barras
    SELECT IDproducto INTO IDprod
    FROM Productos
    WHERE codigoBarras = codBarras;

    -- Validar existencia del producto
    IF IDprod IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Producto no encontrado con ese código de barras';
    END IF;

    -- Insertar movimiento de entrada
    INSERT INTO Movimientos (
        IDtienda, IDproducto, IDempleado, IDproveedor, tipo, cantidad, motivo
    ) VALUES (
        IDtienda, IDprod, IDempleado, IDproveedor, 'entrada', cantidad, 'Entrada de producto'
    );
END;
//

-- Procedimiento: registrarSalida
-- Inserta una salida de productos usando el código de barras y cantidad.
CREATE PROCEDURE registrarSalida(
    IN codBarras DOUBLE,
    IN cantidad INT
)
BEGIN
    DECLARE IDprod INT;
    DECLARE IDtienda INT DEFAULT 1;
    DECLARE IDempleado INT DEFAULT 1;

    -- Buscar producto por código de barras
    SELECT IDproducto INTO IDprod
    FROM Productos
    WHERE codigoBarras = codBarras;

    -- Validar existencia del producto
    IF IDprod IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Producto no encontrado con ese código de barras';
    END IF;

    -- Insertar movimiento de salida
    INSERT INTO Movimientos (
        IDtienda, IDproducto, IDempleado, tipo, cantidad, motivo
    ) VALUES (
        IDtienda, IDprod, IDempleado, 'salida', cantidad, 'Salida de producto'
    );
END;
//

DELIMITER ;
