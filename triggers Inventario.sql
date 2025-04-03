SHOW TRIGGERS;
USE inventario;
DROP TRIGGER IF EXISTS agregarProducto;
DROP TRIGGER IF EXISTS eliminarProducto;

DELIMITER //

-- Trigger para agregar productos al inventario (entradas)
CREATE TRIGGER agregarProducto
AFTER INSERT ON Movimientos
FOR EACH ROW
BEGIN
    -- Solo procesar si es una entrada
    IF NEW.tipo = 'entrada' THEN
        -- Verificar si el producto ya existe en el inventario de la tienda
        IF EXISTS (SELECT 1 FROM Inventario WHERE IDtienda = NEW.IDtienda AND IDproducto = NEW.IDproducto) THEN
            -- Actualizar el stock existente
            UPDATE Inventario 
            SET stock = stock + NEW.cantidad,
                fechaUltimaActualizacion = NOW()
            WHERE IDtienda = NEW.IDtienda AND IDproducto = NEW.IDproducto;
        ELSE
            -- Insertar nuevo registro en el inventario
            INSERT INTO Inventario (IDtienda, IDproducto, stock, fechaUltimaActualizacion)
            VALUES (NEW.IDtienda, NEW.IDproducto, NEW.cantidad, NOW());
        END IF;
    END IF;
END//

-- Trigger para eliminar productos del inventario (salidas)
DELIMITER //

CREATE TRIGGER eliminarProducto
AFTER INSERT ON Movimientos
FOR EACH ROW
BEGIN
    -- Declarar variables al inicio del bloque
    DECLARE current_stock INT;
    
    -- Solo procesar si es una salida
    IF NEW.tipo = 'salida' THEN
        -- Obtener el stock actual
        SELECT stock INTO current_stock FROM Inventario 
        WHERE IDtienda = NEW.IDtienda AND IDproducto = NEW.IDproducto;
        
        -- Verificar si se encontró el registro
        IF current_stock IS NOT NULL THEN
            -- Validar stock suficiente
            IF current_stock >= NEW.cantidad THEN
                -- Actualizar el stock
                UPDATE Inventario 
                SET stock = stock - NEW.cantidad,
                    fechaUltimaActualizacion = NOW()
                WHERE IDtienda = NEW.IDtienda AND IDproducto = NEW.IDproducto;
            ELSE
                -- No hay suficiente stock, generar error
                SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'No hay suficiente stock para realizar esta salida';
            END IF;
        ELSE
            -- El producto no existe en el inventario
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El producto no existe en el inventario de esta tienda';
        END IF;
    END IF;
END//

DELIMITER ;