use inventario;

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
