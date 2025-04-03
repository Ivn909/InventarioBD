USE inventario;

-- CREAR ROLES --

CREATE ROLE IF NOT EXISTS 'empleado';
CREATE ROLE IF NOT EXISTS 'administrador';

-- CREAR USUARIOS --
-- Empleados
CREATE USER IF NOT EXISTS 'analopez'@'localhost' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'luismendez'@'localhost' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'claudiatorres'@'localhost' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'jorgehernandez'@'localhost' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'carmenrios'@'localhost' IDENTIFIED BY '1234';
-- Administrador
CREATE USER IF NOT EXISTS 'pedrogomez'@'localhost' IDENTIFIED BY 'admin1234';

-- ASIGNAR ROLES A LOS USUARIOS --
-- Empleados
GRANT 'empleado' TO 'analopez'@'localhost';
GRANT 'empleado' TO 'luismendez'@'localhost';
GRANT 'empleado' TO 'claudiatorres'@'localhost';
GRANT 'empleado' TO 'jorgehernandez'@'localhost';
GRANT 'empleado' TO 'carmenrios'@'localhost';

-- Administrador
GRANT 'administrador' TO 'pedrogomez'@'localhost';

-- ESTABLECER ROL POR DEFECTO --
-- Empleados
SET DEFAULT ROLE 'empleado' TO 'analopez'@'localhost';
SET DEFAULT ROLE 'empleado' TO 'luismendez'@'localhost';
SET DEFAULT ROLE 'empleado' TO 'claudiatorres'@'localhost';
SET DEFAULT ROLE 'empleado' TO 'jorgehernandez'@'localhost';
SET DEFAULT ROLE 'empleado' TO 'carmenrios'@'localhost';

-- Administrador
SET DEFAULT ROLE 'administrador' TO 'pedrogomez'@'localhost';

-- ASIGNAR PERMISOS A LOS ROLES --
-- Empleado puede ejecutar entrada/salida
GRANT EXECUTE ON PROCEDURE inventario.registrarEntrada TO 'empleado';
GRANT EXECUTE ON PROCEDURE inventario.registrarSalida TO 'empleado';

-- Administrador tiene todo
GRANT ALL PRIVILEGES ON inventario.* TO 'administrador';