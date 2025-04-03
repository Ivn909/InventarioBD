USE inventario;

-- Insertar tienda
INSERT INTO Tiendas (nombre, rubro, fechaAlta, direccion)
VALUES ('Abarrotes Mari', 'Abarrotes', '2025-04-03', 'Av. Independencia 123, Col. Centro');

-- Insertar empleados (5 empleados + 1 administrativo)
INSERT INTO Empleados (IDtienda, nombre, rol, telefono, fechaContratacion, usuario, contrasena)
VALUES 
(1, 'Ana López', 'empleado', '5551000001', '2025-04-03', 'analopez', '1234'),
(1, 'Luis Méndez', 'empleado', '5551000002', '2025-04-03', 'luismendez', '1234'),
(1, 'Claudia Torres', 'empleado', '5551000003', '2025-04-03', 'claudiatorres', '1234'),
(1, 'Jorge Hernández', 'empleado', '5551000004', '2025-04-03', 'jorgehernandez', '1234'),
(1, 'Carmen Ríos', 'empleado', '5551000005', '2025-04-03', 'carmenrios', '1234'),
(1, 'Pedro Gómez', 'administrativo', '5551000006', '2025-04-03', 'pedrogomez', 'admin1234');

-- Insertar categorías
INSERT INTO Categorias (nombre, descripcion)
VALUES
('Abarrotes secos', 'Alimentos básicos no perecederos'),
('Enlatados y conservas', 'Alimentos enlatados y conservas'),
('Botanas y dulces', 'Snacks y golosinas'),
('Cereales y barras', 'Cereales y barras nutritivas'),
('Pan y tortillas', 'Productos de panadería y tortillas'),
('Bebidas', 'Bebidas frías y calientes'),
('Lácteos y derivados', 'Productos lácteos'),
('Embutidos', 'Carnes procesadas'),
('Higiene personal', 'Productos de cuidado personal'),
('Limpieza hogar', 'Productos para limpieza doméstica'),
('Desechables y empaques', 'Utensilios de un solo uso y empaques'),
('Mascotas', 'Alimentos y accesorios para mascotas');

-- Insertar proveedores
INSERT INTO Proveedores (nombre, telefono, direccion)
VALUES
('Grupo Bimbo', '5551100001', 'CDMX, Parque Industrial Bimbo'),
('Sigma Alimentos', '5551100002', 'Monterrey, NL'),
('Nestlé México', '5551100003', 'CDMX, Santa Fe'),
('PepsiCo México', '5551100004', 'CDMX, Lomas Verdes'),
('La Moderna', '5551100005', 'Toluca, Edo. Mex.'),
('P&G México', '5551100006', 'CDMX, Reforma'),
('Colgate-Palmolive', '5551100007', 'CDMX, Del Valle'),
('Mars México', '5551100008', 'Querétaro, QRO'),
('Purina', '5551100009', 'Guadalajara, JAL');

-- Insertar productos
INSERT INTO Productos (IDcategoria, codigoBarras, nombre, descripcion, precio)
VALUES
-- Abarrotes secos
(1, '7501031311101', 'Arroz SOS 1kg', 'Arroz blanco pulido', 28.50),
(1, '7501031311102', 'Frijol Negro La Sierra 900g', 'Frijol cocido en bolsa', 23.00),
(1, '7501031311103', 'Harina Maseca 1kg', 'Harina de maíz nixtamalizado', 18.00),

-- Enlatados y conservas
(2, '7501031311201', 'Atún Dolores Agua 140g', 'Atún en agua enlatado', 19.00),
(2, '7501031311202', 'Sardinas Calmex 155g', 'Sardinas en salsa de tomate', 22.00),
(2, '7501031311203', 'Frijoles Isadora Refritos 430g', 'Frijoles refritos listos para servir', 24.00),

-- Botanas y dulces
(3, '7501031311301', 'Papas Sabritas Clásicas 150g', 'Botana de papas fritas', 39.00),
(3, '7501031311302', 'Galletas Emperador Chocolate 170g', 'Galletas rellenas sabor chocolate', 18.00),
(3, '7501031311303', 'Carlos V Chocolate 18g', 'Chocolate con leche', 10.00),

-- Cereales y barras
(4, '7501031311401', 'Choco Krispis 330g', 'Cereal de arroz inflado sabor chocolate', 49.00),
(4, '7501031311402', 'Zucaritas Kellogg\'s 370g', 'Cereal de maíz azucarado', 52.00),
(4, '7501031311403', 'Nature Valley Barritas 2pz', 'Barritas energéticas de avena', 17.00),

-- Pan y tortillas
(5, '7501031311501', 'Pan Bimbo Blanco 680g', 'Pan de caja clásico', 38.00),
(5, '7501031311502', 'Pan Molido Bimbo 210g', 'Pan molido para empanizar', 19.00),
(5, '7501031311503', 'Tortillas Tía Rosa 500g', 'Tortillas de harina', 22.00),

-- Bebidas
(6, '7501031311601', 'Coca-Cola 2L', 'Refresco de cola embotellado', 32.00),
(6, '7501031311602', 'Agua Ciel 1L', 'Agua purificada sin gas', 14.00),
(6, '7501031311603', 'Jugo Jumex Durazno 1L', 'Jugo de fruta sin conservadores', 20.00),

-- Lácteos y derivados
(7, '7501031311701', 'Leche Lala 1L', 'Leche entera pasteurizada', 24.00),
(7, '7501031311702', 'Yoghurt Danone Natural 1L', 'Yogurt natural para beber', 29.00),
(7, '7501031311703', 'Queso Manchego NocheBuena 200g', 'Queso tipo manchego rebanado', 48.00),

-- Embutidos
(8, '7501031311801', 'Jamón FUD Virginia 250g', 'Jamón tipo virginia', 49.00),
(8, '7501031311802', 'Salchichas Viena FUD 400g', 'Salchicha tipo viena', 36.00),
(8, '7501031311803', 'Chorizo San Rafael 250g', 'Chorizo para freír', 35.00),

-- Higiene personal
(9, '7501031311901', 'Shampoo Head & Shoulders 375ml', 'Shampoo anticaspa mentolado', 57.00),
(9, '7501031311902', 'Desodorante Axe Dark Temptation', 'Desodorante en aerosol', 45.00),
(9, '7501031311903', 'Papel Higiénico Regio 4pzs', 'Papel de baño doble hoja', 34.00),

-- Limpieza hogar
(10, '7501031312001', 'Cloro Cloralex 950ml', 'Desinfectante líquido multiusos', 22.00),
(10, '7501031312002', 'Fabuloso Lavanda 1L', 'Limpiador multiusos con aroma lavanda', 27.00),
(10, '7501031312003', 'Esponja Scotch-Brite 2pz', 'Esponja de cocina multiuso', 19.00),

-- Desechables y empaques
(11, '7501031312101', 'Vasos Desechables GreatValue 50pz', 'Vasos de plástico 250ml', 19.00),
(11, '7501031312102', 'Platos Desechables 20pz', 'Platos redondos plásticos', 23.00),
(11, '7501031312103', 'Papel Aluminio Reynolds 7.6m', 'Papel aluminio de cocina', 29.00),

-- Mascotas
(12, '7501031312201', 'Dog Chow Adulto 1kg', 'Croquetas para perro adulto', 65.00),
(12, '7501031312202', 'Whiskas Gato Pollo 500g', 'Croquetas para gato sabor pollo', 48.00),
(12, '7501031312203', 'Collar Antipulgas Bayer', 'Accesorio para control de pulgas', 85.00);

-- Insertar inventario inicial
INSERT INTO Inventario (IDtienda, IDproducto, stock, fechaUltimaActualizacion)
SELECT 1, IDproducto, 20, '2025-04-03 06:16:57'
FROM Productos;
