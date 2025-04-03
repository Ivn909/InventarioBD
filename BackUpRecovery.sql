use inventario;

-- Solo para administradores
DELIMITER //

CREATE PROCEDURE hacerBackupDesktop()
BEGIN
	DECLARE rutaArchivo VARCHAR(255);
    DECLARE comando TEXT;
    
    IF CURRENT_ROLE() != 'administrador' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: solo administradores pueden realizar backups';
    END IF;

    

    SET rutaArchivo = CONCAT(
        'C:/Users/', SYSTEM_USER(), '/Desktop/inventarioBK',
        DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s'), '.sql'
    );

    SET comando = CONCAT(
        'mysqldump -u root -pTuClaveSegura inventario > "', rutaArchivo, '"'
    );

    SELECT 'Ejecutar este comando en CMD o terminal externa:' AS Info, comando AS BackupCMD;
END;
//

CREATE PROCEDURE restaurarBackupDesktop(IN nombreArchivo VARCHAR(100))
BEGIN
	DECLARE rutaArchivo VARCHAR(255);
    DECLARE comando TEXT;
    
    IF CURRENT_ROLE() != 'administrador' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Acceso denegado: solo administradores pueden restaurar backups';
    END IF;

    

    SET rutaArchivo = CONCAT('C:/Users/', SYSTEM_USER(), '/Desktop/', nombreArchivo);

    SET comando = CONCAT(
        'mysql -u root -pTuClaveSegura inventario < "', rutaArchivo, '"'
    );

    SELECT 'Ejecutar este comando en CMD o terminal externa:' AS Info, comando AS RestoreCMD;
END;
//

DELIMITER ;