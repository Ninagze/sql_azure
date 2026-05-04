--1. Ver productos ordenados por precio (de mayor a menor)
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;
--2. Productos que cuestan más de 1000
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice > 1000;
--3. Productos rojos o negros
SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN ('Red', 'Black');
--4. Productos cuyo nombre contiene "Mountain"
SELECT ProductID, Name
FROM SalesLT.Product
WHERE Name LIKE '%Mountain%';
--5. Mostrar clientes de 'United States'
SELECT c.FirstName, c.LastName, a.CountryRegion
FROM SalesLT.Customer c 
JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address a ON ca.AddressID = a.AddressID
WHERE a.CountryRegion = 'United States';
--6. Mostrar productos con precio entre 500 y 1500
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice BETWEEN 500 AND 1500
ORDER BY ListPrice;
--7. Contar cuántos productos hay de color 'Blue'
SELECT COUNT(*) AS ProductosAzules
FROM SalesLT.Product
WHERE Color = 'Blue';
--8. Mostrar las 5 direcciones (Address) de la ciudad 'Seattle'
SELECT TOP 5 AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE City = 'Seattle';


--1. Mostrar clientes con sus direcciones (Customer + Address)
-- Pista: necesitas la tabla CustomerAddress como puente
SELECT c.FirstName, c.LastName, a.AddressLine1
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.Address a ON a.AddressID = ca.AddressID
--2. Productos de la categoría "Bikes" con precio > 2000
SELECT
    P.Name AS Producto,
    C.Name AS Categoria,
    P.ListPrice AS Precio
FROM SalesLT.Product AS P
INNER JOIN SalesLT.ProductCategory AS C
    ON P.ProductCategoryID = C.ProductCategoryID
WHERE C.Name LIKE '%Bikes%'
  AND P.ListPrice > 2000
ORDER BY P.ListPrice DESC;
--3. TOP 10 productos más vendidos (usa SalesOrderDetail)
-- Pista: agrupa por ProductID y suma OrderQty
SELECT TOP 10
    p.Name AS Producto,
    SUM(sod.OrderQty) AS TotalVendido
FROM SalesLT.SalesOrderDetail sod
INNER JOIN SalesLT.Product p ON sod.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalVendido DESC;


CREATE TABLE SalesLT.TestProducts (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    Category NVARCHAR(50),
    CreatedDate DATETIME DEFAULT GETDATE()
);    

INSERT INTO SalesLT.TestProducts (ProductName, Price, Category)
VALUES ('Casco de ciclismo pro', 89.99,'Accesorios');

INSERT INTO SalesLT.TestProducts (ProductName, Price, Category)
VALUES
 ('Guantes', 39.99,'Accesorios'),
 ('Botellin', 15.99,'Accesorios'),
 ('Luces LED Delanteras', 24.99,'Iluminacion'),
 ('Luces LED Traseras', 34.99,'Iluminacion');

 -- 1. Insertar 3 productos nuevos de tu elección
INSERT INTO SalesLT.TestProducts (ProductName, Price, Category)
VALUES 
    ('Sillín Ergonómico', 65.50, 'Componentes'),
    ('Pedales Automáticos', 85.00, 'Componentes'),
    ('Bomba de Aire Portátil', 18.20, 'Accesorios');

-- 2. Insertar un producto sin especificar precio (NULL)
INSERT INTO SalesLT.TestProducts (ProductName, Category)
VALUES ('Kit de Parches Antipinazos', 'Accesorios');
-- 3. Verificar que se insertaron correctamente
SELECT * 
FROM SalesLT.TestProducts;
