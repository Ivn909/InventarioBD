DROP DATABASE IF EXISTS inventario;
CREATE DATABASE IF NOT EXISTS inventario;
USE inventario;

-- Tabla de Tiendas
CREATE TABLE Tiendas (
    IDtienda INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    rubro VARCHAR(100) NOT NULL,
    fechaAlta DATE NOT NULL,
    direccion VARCHAR(200) NOT NULL
);

-- Tabla de Empleados
CREATE TABLE Empleados (
    IDempleado INT PRIMARY KEY AUTO_INCREMENT,
    IDtienda INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    rol ENUM('empleado', 'administrativo') NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fechaContratacion DATE NOT NULL,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(50) NOT NULL,
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
    IDcategoria INT,
    codigoBarras VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NOT NULL DEFAULT 'N/A',
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IDcategoria) REFERENCES Categorias(IDcategoria)
);

-- Tabla de Inventario
CREATE TABLE Inventario (
    IDinventario INT PRIMARY KEY AUTO_INCREMENT,
    IDtienda INT NOT NULL,
    IDproducto INT NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    fechaUltimaActualizacion DATETIME,
    FOREIGN KEY (IDtienda) REFERENCES Tiendas(IDtienda),
    FOREIGN KEY (IDproducto) REFERENCES Productos(IDproducto),
    UNIQUE KEY (IDtienda, IDproducto)
);

-- Tabla de Movimientos del inventario
CREATE TABLE Movimientos (
    IDmovimiento INT PRIMARY KEY AUTO_INCREMENT,
    IDtienda INT NOT NULL,
    IDproducto INT NOT NULL,
    IDempleado INT NOT NULL,
    IDproveedor INT,
    tipo ENUM('entrada', 'salida', 'ajuste') NOT NULL,
    cantidad INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motivo VARCHAR(200) NOT NULL,
    FOREIGN KEY (IDtienda) REFERENCES Tiendas(IDtienda),
    FOREIGN KEY (IDproducto) REFERENCES Productos(IDproducto),
    FOREIGN KEY (IDempleado) REFERENCES Empleados(IDempleado),
    FOREIGN KEY (IDproveedor) REFERENCES Proveedores(IDproveedor)
);

-- Tabla de Historial de Movimientos (para deshacer/rehacer)
CREATE TABLE HistorialMovimientos (
    IDhistorial INT PRIMARY KEY AUTO_INCREMENT,
    IDmovimiento INT NOT NULL,
    IDempleado INT NOT NULL,
    accion ENUM('creacion', 'modificacion', 'eliminacion', 'RESTAURACION') NOT NULL,
    fechaCambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motivoCambio VARCHAR(200) NOT NULL,
    datosAnteriores JSON,
    FOREIGN KEY (IDmovimiento) REFERENCES Movimientos(IDmovimiento),
    FOREIGN KEY (IDempleado) REFERENCES Empleados(IDempleado)
);

CREATE INDEX idxProductoCodigo ON Productos(codigoBarras);
CREATE INDEX idxMovimientosFecha ON Movimientos(fecha);
CREATE INDEX idxInventarioTienda_Producto ON Inventario(IDtienda, IDproducto);