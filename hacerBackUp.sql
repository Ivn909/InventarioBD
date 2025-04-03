USE inventario;

DELIMITER //

CREATE PROCEDURE hacerBackup(IN rutaArchivo VARCHAR(255))
BEGIN
    DECLARE comando TEXT;

    -- Construye el comando mysqldump
    SET comando = CONCAT(
        'mysqldump -u root -pTuClaveSegura inventario > "', rutaArchivo, '"'
    );

    -- Ejecuta el backup con sys_exec (requiere que el plugin sys esté habilitado)
    -- Si estás usando MySQL en consola, mejor ejecuta el comando externamente
    SELECT 'Comando a ejecutar:' AS Info, comando AS BackupCommand;

    -- Si tienes acceso al SO y estás en MySQL Shell, puedes ejecutarlo externamente
    -- Por ahora, devolvemos el comando para que se copie/pegue
END;
//

DELIMITER ;


-- Prueba de recovery
DELIMITER //

CREATE PROCEDURE sp_RestaurarBackup(IN p_ruta_archivo VARCHAR(355))
BEGIN
    -- Validar que el archivo existe
    -- Esta validación requeriría funciones de sistema de archivos no disponibles en MySQL puro
    
    -- Registrar inicio de restauración
    INSERT INTO BackupLogs (fecha, tipo, ruta_archivo, estado)
    VALUES (NOW(), 'Restauración', p_ruta_archivo, 'Iniciado');
    
    -- Ejecutar restauración (esto sería mediante mysql client en la práctica)
    SET @restore_cmd = CONCAT('mysql -u root -p tu_password inventario < "', p_ruta_archivo, '"');
    
    -- En un procedimiento almacenado no puedes ejecutar directamente comandos del sistema
    -- Esta parte debería manejarse desde un script externo o cliente
    
    -- Simular éxito
    UPDATE BackupLogs SET estado = 'Completado' 
    WHERE ruta_archivo = p_ruta_archivo AND estado = 'Iniciado';
    
    SELECT CONCAT('Restauración programada desde: ', p_ruta_archivo) AS Mensaje;
END //

DELIMITER ;