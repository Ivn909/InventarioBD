SHOW TRIGGERS;

USE inventario;
-- Añadir productos
DELIMITER //

CREATE TRIGGER annadirProducto
AFTER INSERT ON Movimientos
FOR EACH ROW
BEGIN
    DECLARE existe_inventario INT;
    
    -- Verificar si ya existe registro en el inventario para esta tienda-producto
    SELECT COUNT(*) INTO existe_inventario 
    FROM Inventario 
    WHERE IDtienda = NEW.IDtienda AND IDproducto = NEW.IDproducto;
    
    -- Si no existe, crear el registro en inventario
    IF existe_inventario = 0 THEN
        INSERT INTO Inventario (IDtienda, IDproducto, stock, fechaUltimaActualizacion)
        VALUES (NEW.IDtienda, NEW.IDproducto, 0, NOW());
    END IF;
    
    -- Actualizar el inventario según el tipo de movimiento
    IF NEW.tipo = 'entrada' THEN
        UPDATE Inventario 
        SET stock = stock + NEW.cantidad,
            fechaUltimaActualizacion = NOW()
        WHERE IDtienda = NEW.IDtienda AND IDproducto = NEW.IDproducto;
    ELSEIF NEW.tipo = 'salida' THEN
        UPDATE Inventario 
        SET stock = stock - NEW.cantidad,
            fechaUltimaActualizacion = NOW()
        WHERE IDtienda = NEW.IDtienda AND IDproducto = NEW.IDproducto;
    END IF;
    
    -- Registrar en el historial
    INSERT INTO HistorialMovimientos (IDmovimiento, IDempleado, accion, motivoCambio)
    VALUES (NEW.IDmovimiento, NEW.IDempleado, 'creacion', NEW.motivo);
END //

DELIMITER ;

-- Eliminar productos 
DELIMITER //

CREATE TRIGGER eliminarProducto
BEFORE DELETE ON Productos
FOR EACH ROW
BEGIN
    DECLARE tiene_movimientos INT;
    
    -- Verificar si el producto tiene movimientos históricos
    SELECT COUNT(*) INTO tiene_movimientos 
    FROM Movimientos 
    WHERE IDproducto = OLD.IDproducto;
    
    -- Preservar información histórica
    IF tiene_movimientos > 0 THEN
        -- Registrar eliminación en historial
        INSERT INTO HistorialMovimientos (
            IDempleado, 
            accion, 
            motivoCambio, 
            datosAnteriores
        )
        SELECT 
            IDempleado, 
            'eliminacion', 
            'Producto eliminado con movimientos históricos', 
            JSON_OBJECT(
                'producto', JSON_OBJECT(
                    'id', OLD.IDproducto,
                    'nombre', OLD.nombre,
                    'codigo', OLD.codigoBarras
                ),
                'ultimo_movimiento', MAX(fecha),
                'total_movimientos', COUNT(*)
            )
        FROM Movimientos 
        WHERE IDproducto = OLD.IDproducto
        GROUP BY IDempleado;
        
        -- Anonimizar movimientos (conservar el registro pero sin FK)
        UPDATE Movimientos 
        SET IDproducto = NULL,
            motivo = CONCAT('(Producto eliminado) ', motivo)
        WHERE IDproducto = OLD.IDproducto;
    ELSE
        -- Registrar eliminación simple para productos sin historial
        INSERT INTO HistorialMovimientos (
            IDempleado, 
            accion, 
            motivoCambio, 
            datosAnteriores
        )
        VALUES (
            1, -- Administrador
            'eliminacion', 
            'Producto sin historial eliminado', 
            JSON_OBJECT(
                'id', OLD.IDproducto,
                'nombre', OLD.nombre
            )
        );
    END IF;
    
    -- Eliminar siempre el inventario (no es histórico)
    DELETE FROM Inventario WHERE IDproducto = OLD.IDproducto;
END //

DELIMITER ;