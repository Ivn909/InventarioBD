DROP DATABASE IF EXISTS inventario;
CREATE DATABASE IF NOT EXISTS inventario;
USE inventario;

-- Tabla de Tiendas
CREATE TABLE Tiendas (
    IDtienda INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    rubro VARCHAR(100) NOT NULL,
    fechaAlta DATE NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    activa BOOLEAN DEFAULT TRUE
);

-- Tabla de Empleados
CREATE TABLE Empleados (
    IDempleado INT PRIMARY KEY AUTO_INCREMENT,
    IDtienda INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    rol ENUM('empleado', 'administrativo') NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fechaContratacion DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (IDtienda) REFERENCES Tiendas(IDtienda)
);

-- Tabla de Proveedores
CREATE TABLE Proveedores (
    IDproveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Categorías de Productos
CREATE TABLE Categorias (
    IDcategoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NOT NULL DEFAULT 'N/A'
);

-- Tabla de Productos
CREATE TABLE Productos (
    IDproducto INT PRIMARY KEY AUTO_INCREMENT,
    IDcategoria INT NOT NULL,
    IDproveedor INT NOT NULL,
    codigoBarras VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NOT NULL DEFAULT 'N/A',
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    fechaIngreso DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (IDcategoria) REFERENCES Categorias(IDcategoria),
    FOREIGN KEY (IDproveedor) REFERENCES Proveedores(IDproveedor)
);

-- Tabla de Movimientos
CREATE TABLE Movimientos (
    IDmovimiento INT PRIMARY KEY AUTO_INCREMENT,
    IDproducto INT NOT NULL,
    IDempleado INT NOT NULL,
    tipo ENUM('entrada', 'salida') NOT NULL,
    cantidad INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivo VARCHAR(200) NOT NULL,
    FOREIGN KEY (IDproducto) REFERENCES Productos(IDproducto),
    FOREIGN KEY (IDempleado) REFERENCES Empleados(IDempleado)
);

-- Tabla de Historial de Movimientos (para deshacer/rehacer)
CREATE TABLE HistorialMovimientos (
    IDhistorial INT PRIMARY KEY AUTO_INCREMENT,
    IDmovimiento INT NOT NULL,
    IDempleado INT NOT NULL,
    accion ENUM('creacion', 'modificacion', 'eliminacion') NOT NULL,
    fechaCambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivoCambio VARCHAR(200),
    datosAnteriores JSON,
    FOREIGN KEY (IDmovimiento) REFERENCES Movimientos(IDmovimiento),
    FOREIGN KEY (IDempleado) REFERENCES Empleados(IDempleado)
);

-- Tabla de Reportes (puede ser vista o tabla física según necesidades)
CREATE TABLE Reportes (
    IDreporte INT PRIMARY KEY AUTO_INCREMENT,
    IDempleado INT NOT NULL,
    tipo ENUM('ventas', 'inventario') NOT NULL,
    periodo ENUM('diario', 'semanal', 'mensual') NOT NULL,
    fechaGeneracion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    datos JSON NOT NULL,
    FOREIGN KEY (IDempleado) REFERENCES Empleados(IDempleado)
);