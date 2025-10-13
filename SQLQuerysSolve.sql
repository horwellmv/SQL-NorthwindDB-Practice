/*Basado en la forma de redaccion de Queries sugerida por un DBA con mucha experiencia que sugería
presentar las consultas de una manera estructurada para facilitar la lectura del codigo.
No es mandatorio, pero se supone una buena practica.*/

Use Northwind;

-- 1. Recuperar Lista de empleados (Nombre y Apellido)
Select	
		FirstName as Nombre,
		LastName  as Apellido
from	
		Employees;

-- 2. Recuperar Id, Apellido y Fecha de contratación de los empelados.
Select	
		EmployeeID	as ID,
		LastName	as Apellido,
		HireDate	as FechaContratacion
from 
		Employees

-- 3. Recuperar id, nombre completo concatenado y título de cada empleado.
select	
		FirstName + ' ' + LastName	as NombreCompleto,
		Notes						as Titulos
from	
		Employees;

-- 4. Recuperar lista de clientes (id y nombre de la compañía).
Select	
		CustomerID	as ClienteID,
		CompanyName	as Compañia
from	
		Customers;

-- 5. Recuperar productos con sus precios unitarios, ordenados por precio descendente.
Select	
		ProductName	as Producto,
		UnitPrice	as PrecioUnitario
from	
		Products
order By
		UnitPrice desc;


/* Recuperar productos cuyo precio sea mayor a 50.
Recuperar pedidos hechos en el año 1997.
Recuperar empleados cuyo país sea “USA”.
Recuperar productos con stock entre 10 y 50 unidades.
Recuperar clientes de países específicos (México, Argentina, Brasil).
Recuperar empleados cuyo apellido empiece con “D”.*/

-- 6. Recuperar productos cuyo precio sea mayor a 50.
Select
	*
from 
	Products
Where
	UnitPrice > 50;

-- 7. Recuperar pedidos hechos en el año 1997.
Select
	*
From 
	Orders
Where
	-- YEAR (OrderDate) = 1997;				-- Usando la función YEAR().
	OrderDate >= '1997-01-01 00:00:00.000'
	And
	OrderDate < '1998-01-01 00:00:00.000';  -- Esta opcion es más eficiente si tenemos índices. 

-- 8. Recuperar empleados cuyo país sea “USA”.
Select
	*
From
	Employees
Where
	Country='USA';

-- 9. Recuperar productos con stock entre 10 y 50 unidades.
Select
	*
From
	Products
Where
	UnitsInStock Between 10 and 50;

-- 10. Recuperar clientes de países específicos (México, Argentina, Brasil). Tener en cuenta el idioma de la DB.
Select
	*
From
	Customers
Where
	Country = 'Mexico'		or 
	Country = 'Argentina'	or
	Country = 'Brazil';

-- 11. Recuperar empleados cuyo apellido empiece con “D”.
Select
	*
From
	Employees
Where
	LastName like 'D%';


/*
12. Recuperar productos ordenados por categoría y luego por precio.
13. Recuperar empleados ordenados por fecha de contratación (más antiguos primero).
14. Recuperar empleados ordenados por país ascendente y ciudad descendente.*/

-- 12. Recuperar productos ordenados por categoría y luego por precio.
Select
	*
From
	Products
order By
	CategoryID, UnitPrice;

-- 13. Recuperar empleados ordenados por fecha de contratación (más antiguos primero).
Select
	*
From
	Employees
Order By
	HireDate;

-- 14. Recuperar empleados ordenados por país ascendente y ciudad descendente.
Select
	*
From
	Employees
Order By
	Country asc, City desc;

/*
15. Recuperar lista de pedidos con nombre del cliente asociado.
16. Recuperar lista de productos junto con su categoría.
17. Recuperar lista de pedidos junto con el nombre completo del empleado que lo gestionó.
18. Recuperar lista de productos y su proveedor.
19. Recuperar lista de pedidos con cliente, empleado y transportista.
20. Recuperar lista de categorías con la cantidad de productos que tiene cada una.
*/

-- 15. Recuperar lista de pedidos con nombre del cliente asociado.
Select
	OrderID,
	o.ShipName,
	o.CustomerID,
	c.CustomerID,
	ContactName,
	c.CompanyName
From
	Orders as o
inner join
	Customers as c
On 
	o.CustomerID = c.CustomerID

-- 16. Recuperar lista de productos junto con su categoría.
Select
	p.ProductID,
	p.ProductName,
	c.CategoryID,
	c.CategoryName
From
	Products as p
	inner join
	Categories as c
on
	p.CategoryID = c.CategoryID

-- 17. Recuperar lista de pedidos junto con el nombre completo del empleado que lo gestionó.
Select
	o.OrderID,
	o.CustomerID,
	e.EmployeeID,
	e.FirstName + ' ' + e.LastName as EmployedName
From
	Orders as o
inner join
	Employees as e
on
	o.EmployeeID = e.EmployeeID


-- 18. Recuperar lista de productos y su proveedor.
Select
	p.ProductID,
	p.ProductName,
	s.SupplierID,
	s.CompanyName
From
	Products as p
	inner join
	Suppliers as s
on
	p.SupplierID = s.SupplierID


-- 19. Recuperar lista de pedidos con cliente, empleado y transportista.
Select
	o.OrderID,
	o.OrderDate,
	o.ShipName,
	e.EmployeeID,
	e.FirstName,
	c.CustomerID,
	c.CompanyName,
	c.ContactName
From
	Orders as o
inner join
	Customers as c
on
	o.CustomerID = c.CustomerID
inner join
	Employees as e
on 
	o.EmployeeID = e.EmployeeID


-- 20. Recuperar lista de categorías con la cantidad de productos que tiene cada una.
Use Northwind
Select
	c.CategoryName,
	c.CategoryID,
	SUM(p.UnitsInStock) as cantidad
From
	Categories as c
inner join
	Products as p
on
	c.CategoryID = p.CategoryID
group By
	c.CategoryName, c.CategoryID

/*
21. Recuperar el precio máximo de los productos.
22. Recuperar el precio promedio de los productos de la categoría “Beverages”.
23. Recuperar el total de pedidos realizados por cada cliente.
24. Recuperar los 5 productos más caros.
25. Recuperar clientes que han realizado más de 10 pedidos.
26. Recuperar el total de ingresos por cada producto (cantidad * precio unitario).
*/

-- 21. Recuperar el precio máximo de los productos.
Select
	MAX(UnitPrice) as PrecioMaximo
From
	Products;

-- 22. Recuperar el precio promedio de los productos de la categoría “Beverages”.
Select
	AVG(UnitPrice) as precioPromedio
From
	Products as p
	inner join
	Categories as c
on 
	p.CategoryID = c.CategoryID
Where
	c.CategoryName = 'Beverages'

-- 23. Recuperar el total de pedidos realizados por cada cliente.
Select
	c.CompanyName,
	Count(o.OrderID) as ordenes
From
	Customers as c
	inner join
	Orders as o
on
	c.CustomerID = o.CustomerID
Group by
	c.CustomerID,
	c.CompanyName
order By
	ordenes


-- 24. Recuperar los 5 productos más caros.
Select top 5
	*
From
	Products
Order by
	UnitPrice desc


-- 25. Recuperar clientes que han realizado más de 10 pedidos.
Select
	c.CustomerID,
	c.CompanyName,
	count(o.OrderID) as CantidadPedidos
From
	Customers as c
	inner join
	Orders as o
on
	c.CustomerID = o.CustomerID
Group by
	c.CustomerID,
	c.CompanyName
Having
	count(o.OrderID) > 10
Order by
	CantidadPedidos desc;


-- 26. Recuperar el total de ingresos por cada producto (cantidad * precio unitario).
Select
	ProductID,
	productName,
	UnitPrice,
	UnitsInStock,
	UnitPrice * UnitsInStock as Ingresos
From
	Products
Order By
	Ingresos desc

/*
27. Recuperar productos cuyo precio sea mayor al promedio de todos los productos.
28. Recuperar pedidos realizados por el cliente con más pedidos.
29. Recuperar empleados que trabajan en la misma ciudad que “Andrew Fuller”.
30. Recuperar proveedores que proveen productos más caros que el promedio.
*/


-- 27. Recuperar productos cuyo precio sea mayor al promedio de todos los productos.
Select
	*
From
	Products
Where
	UnitPrice > (SELECT AVG(UnitPrice)
				 FROM Products);

-- 28. Recuperar pedidos realizados por el cliente con más pedidos.
Select
	*
From
	Orders
Where
	CustomerID = (	Select top 1
						CustomerID
					From
						Orders
					group by
						CustomerID
					order by
						Count(OrderID) desc );

-- 29. Recuperar empleados que trabajan en la misma ciudad que “Andrew Fuller”.
-- Solo arrojaba un resultado, para probar la query, usé un empleado que vivie en una ciudad más común.
Select
	*
From 
	Employees
Where
	City = (Select
				City
			From
				Employees
			Where LastName = 'Buchanan' and FirstName = 'Steven' );

--30. Recuperar proveedores que proveen productos más caros que el promedio.
Select
	s.*
From
	Suppliers as s
	inner join
	Products as p
	on 
	p.SupplierID = s.SupplierID
Where
	UnitPrice >(Select
					AVG(UnitPrice)
				From
					Products)
Order By
	s.CompanyName;


/*
31. Obtener la cantidad de pedidos por cada año.
32. Obtener el promedio de precios por categoría.
33. Obtener los clientes con más de 20 pedidos.
34. Obtener las categorías cuyo precio promedio de producto sea mayor a 40.
35. Obtener el total de ventas (cantidad * precio) por año.
*/


-- 31. Obtener la cantidad de pedidos por cada año.
Select
	 YEAR(OrderDate) as Año,
	 count(OrderID) as 'Cantidad pedidos'
From
	Orders
Group by
	Year(OrderDate)
Order By
	Año

-- 32. Obtener el promedio de precios por categoría.
Select
	CategoryID as Categoria,
	AVG(UnitPrice) as 'Costo Promedio'
From
	Products
group by
	CategoryID

-- 33. Obtener los clientes con más de 20 pedidos.
Select
	CustomerID as 'ID Cliente', COUNT(OrderID) as '# Pedididos'
From
	Orders
Group by
	CustomerID
Having
	COUNT(OrderID) > 20;

-- 34. Obtener las categorías cuyo precio promedio de producto sea mayor a 40.
Select
	CategoryID as Categoria,
	AVG(UnitPrice) as 'Costo Promedio'
From
	Products
group by
	CategoryID
Having
	AVG(UnitPrice) > 40;


-- 35. Obtener el total de ventas (cantidad * precio) por año.
Select
	YEAR(o.OrderDate) as Año,
	SUM(d.UnitPrice * d.Quantity) as Total
From
	[Order Details] as d
	inner join
	Orders as o
	on
	d.OrderID = o.OrderID
Group by
	YEAR(o.OrderDate)
Order By
	Año;

/*
36. Obtener los pedidos agrupados por mes y año.
37. Obtener el número de empleados contratados por década.
38. Obtener los clientes cuyo nombre de compañía tenga más de 20 caracteres.
39. Obtener los tres primeros caracteres del apellido de cada empleado.
*/

-- 36. Obtener los pedidos agrupados por mes y año.
Select
	YEAR(OrderDate) as Año,
	MONTH(OrderDate) as Mes,
	COUNT(OrderID) as Total
from
	Orders
Group By
	YEAR(OrderDate),
	MONTH(OrderDate)
order By
	Año, Mes;

-- 37. Obtener el número de empleados contratados por Año. Decada no tiene sentido según la historia de la DB.
Select
	YEAR(HireDate) as Año,
	COUNT(EmployeeID) as Contratos
From
	Employees
Group By
	YEAR(HireDate)
Order By
	Año;

-- 38. Obtener los clientes cuyo nombre de compañía tenga más de 20 caracteres.
Select
	*
From
	Customers
Where
	LEN(CompanyName) > 20;

-- 39. Obtener los tres primeros caracteres del apellido de cada empleado.
Select
	LEFT(LastName, 3)	as 'Apellido Corto',
	LastName			as 'Apellido Completo'
From
	Employees;


/*
40. Insertar un nuevo cliente ficticio.
41. Actualizar el teléfono de un proveedor específico.
42. Eliminar un transportista ficticio.
43. Aumentar en 10% el precio de todos los productos de la categoría “Seafood”.
44. Eliminar todos los pedidos de un cliente ficticio.
*/

-- 40. Insertar un nuevo cliente ficticio.
INSERT INTO Customers
	(CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
VALUES
	('FICTI', 'Fictitious Company Ltd.', 'Max Power', 'Purchasing Manager', 'Calle Falsa 123', 'Springfield', NULL, '28001', 'Spain', '+34-91-1234567', '+34-91-7654321');

-- 41. Actualizar el teléfono de un proveedor específico.
UPDATE Customers
SET Phone = '+34-91-0000000'
WHERE CustomerID = 'FICTI';

-- 42. Eliminar un transportista ficticio.
Select
	*
From
	Shippers
Insert into Shippers
	(CompanyName, Phone)
Values
	('Fedex','(503) 555-000');

Delete From
	Shippers
Where
	ShipperID = 4;

-- 43. Aumentar en 10% el precio de todos los productos de la categoría “Seafood”.
Select
	*
From
	Products
Where CategoryID = 8;


UPDATE Products
SET UnitPrice = UnitPrice * 1.10
WHERE CategoryID = (
    SELECT CategoryID 
    FROM Categories 
    WHERE CategoryName = 'Seafood'
	and ProductID = 13
);

-- 44. Eliminar todos los pedidos de un cliente ficticio.
Select
	*
From
	Orders
Where
	CustomerID = 'ficticio';
--Como no tenemos definido el atributo cascade de la base de datos, debemos eliminar primero las tablas relacionadas que dependen de las ordenes.
Delete From
	[Order Details]
Where
	OrderID in (
		Select
			OrderID
		From
			Orders
		Where
			CustomerID = 'ficticio');
-- Finalmente podemos eliminar los pedidios de la tabla Orders.
Delete From 
	[Orders]
Where
	CustomerID = 'ficticio';

/*

45. Crear una vista con los productos y el nombre de su categoría.
46. Crear una vista con los pedidos y el nombre del cliente.
47. Crear una función que retorne la antigüedad en años de un empleado dado su EmployeeID.
48. Crear un procedimiento que retorne los clientes ordenados por la cantidad de pedidos.
49. Crear un trigger que actualice automáticamente el stock de un producto después de insertar un pedido.
50. Crear un trigger que registre en una tabla de auditoría cada vez que se elimine un pedido.

*/

-- 45. Crear una vista con los productos y el nombre de su categoría.
CREATE VIEW
	Vista_Productos_Categorias AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.QuantityPerUnit,
    p.UnitPrice,
    p.UnitsInStock
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID;

-- HAcemos una consulta usando la vista creada 
SELECT
	*
FROM
	Vista_Productos_Categorias;

-- 46. Crear una vista con los pedidos y el nombre del cliente.
CREATE VIEW
	Vista_Pedidos_Clientes AS
SELECT
	O.OrderID,
	C.CustomerID,
	C.CompanyName	AS Compañia,
	O.OrderDate		AS Fecha,
	C.City			AS Ciudad,
	C.Phone			AS Telefono
FROM
	Orders O
inner join
	Customers C
ON
	O.CustomerID = C.CustomerID;

-- Usamos la Vista creada anteriormente
SELECT
	*
FROM
	Vista_Pedidos_Clientes;

-- 47. Crear una función que retorne la antigüedad en años de un empleado dado su EmployeeID.

CREATE FUNCTION
	fn_ANtiguedad_Empleado (@EmployeedID INT)
RETURNS INT
AS
BEGIN
	DECLARE @FechaContratacion DATETIME;
	DECLARE @Antiguedad INT;

	SELECT
		@FechaContratacion = HireDate
	FROM
		Employees
	WHERE
		EmployeeID = @EmployeedID;

	IF @FechaContratacion IS NOT NULL
		SET @Antiguedad = DATEDIFF(YEAR,@FechaContratacion, GETDATE());
	ELSE
		SET @Antiguedad = NULL;
	RETURN @Antiguedad;
END;
GO

-- probamos la funcion con algun ID como el 5.
SELECT
	dbo.fn_ANtiguedad_Empleado (5) AS Antiguedad;

-- 48. Crear un procedimiento que retorne los clientes ordenados por la cantidad de pedidos.
CREATE PROCEDURE 
	Procedure_Clientes_Cantidad_Pedidos
AS
BEGIN
    SELECT 
        C.CustomerID,
        C.CompanyName		AS	Compañia,
        COUNT(O.OrderID)	AS CantidadPedidos
    FROM 
		Customers C
	LEFT JOIN 
		Orders O 
	ON C.CustomerID = O.CustomerID
    GROUP BY 
		C.CustomerID, C.CompanyName
    ORDER BY 
		CantidadPedidos DESC;
END;
GO

-- Ejecutamos nuestro nuevo Procedure
EXEC Procedure_Clientes_Cantidad_Pedidos;

--49. Crear un trigger que actualice automáticamente el stock de un producto después de insertar un pedido.

CREATE TRIGGER
	trigger_ActualizarStock
ON
	[Order Details]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; -- elimina el mensaje de n filas afectadas.

    -- Verificar si hay suficiente stock para todos los productos insertados
    IF EXISTS (
        SELECT
			1 -- Manera de verificar que existe al menos una fila, o que hay resultados.
        FROM 
			inserted i
        INNER JOIN 
			Products p
			ON i.ProductID = p.ProductID
        WHERE 
			p.UnitsInStock < i.Quantity
    )
    BEGIN
		/* RAICEERROR recibe el mensaje, 
		una escala de gravedad:
		• 0–10: Informativo (no se considera error).
		• 11–16: Errores del usuario o aplicación (se pueden capturar).
		• 17–19: Errores del sistema que el usuario no puede resolver.
		• 20–25: Errores críticos (terminan la conexión).
		y un numero para identificar errores o estados personales de mi base de datos.*/
        RAISERROR('No hay suficiente stock para uno o más productos del pedido.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Actualizar el stock de los productos con base en los pedidos insertados
    UPDATE p
    SET 
		p.UnitsInStock = p.UnitsInStock - i.Quantity
    FROM
		Products p
    INNER JOIN 
		inserted i
	ON p.ProductID = i.ProductID;
END;
GO

-- Prueba exitosa
-- Producto con suficiente stock
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10248, 1, 18.00, 1, 0);

-- producto sin stock suficiente
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (10249, 1, 18.00, 999, 0);

--Verificar el stock de la tabla productos con id 1.
select *
from Products
where ProductID = 1;

--50. Crear un trigger que registre en una tabla de auditoría cada vez que se elimine un pedido.

CREATE TABLE Audit_Orders (
    AuditID		INT IDENTITY(1,1) PRIMARY KEY,
    OrderID		INT,
    CustomerID	NCHAR(5),
    EmployeeID	INT,
    OrderDate	DATETIME,
    DeletedAt	DATETIME,
    DeletedBy	NVARCHAR(100)
);

CREATE TABLE Audit_Order_Details (
    AuditDetailID	INT IDENTITY(1,1) PRIMARY KEY,
    AuditID			INT,              -- Relación con Audit_Orders
    OrderID			INT,
    ProductID		INT,
    UnitPrice		MONEY,
    Quantity		SMALLINT,
    Discount		REAL
);

CREATE TRIGGER trigger_Auditoria_EliminacionPedidos
ON Orders
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Registrar primero los detalles del pedido eliminado
    INSERT INTO Audit_Order_Details (AuditID, OrderID, ProductID, UnitPrice, Quantity, Discount)
    SELECT 
        NULL,  -- temporal, se actualizará luego
        od.OrderID,
        od.ProductID,
        od.UnitPrice,
        od.Quantity,
        od.Discount
    FROM [Order Details] od
    INNER JOIN deleted d ON od.OrderID = d.OrderID;

    -- Registrar los pedidos eliminados
    INSERT INTO Audit_Orders (OrderID, CustomerID, EmployeeID, OrderDate, DeletedAt, DeletedBy)
    SELECT 
        d.OrderID,
        d.CustomerID,
        d.EmployeeID,
        d.OrderDate,
        GETDATE(),
        SYSTEM_USER
    FROM deleted d;

    -- Actualizar AuditID en los detalles insertados
    UPDATE od
    SET od.AuditID = ao.AuditID
    FROM Audit_Order_Details od
    INNER JOIN Audit_Orders ao ON ao.OrderID = od.OrderID
    WHERE od.AuditID IS NULL;
END;
GO


--Creando orden para eliminar despues
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipCountry)
VALUES ('ALFKI', 5, GETDATE(), DATEADD(DAY, 7, GETDATE()), 1, 20.00, 'Fidel MuVal', 'Finca El Tesoro', 'Medallo', 'Colombia');


-- obtener el id del pedido
SELECT TOP 1 OrderID
FROM Orders
ORDER BY OrderID DESC;

--Cargar los detalles del pedido.
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
(11080, 1, 18.00, 5, 0),
(11080, 8, 20.00, 1, 0),
(11080, 2, 19.00, 3, 0);


--test eliminando un pedido de Details y Orders
BEGIN TRANSACTION;
    -- Eliminar los detalles del pedido
    DELETE FROM [Order Details]
    WHERE OrderID = 11080;  

    -- Eliminar el pedido principal (activará el trigger de auditoría)
    DELETE FROM Orders
    WHERE OrderID = 11080;  
COMMIT TRANSACTION;


-- Test consultando el historial de pedidos eliminados y sus detalles para auditar.
SELECT 
    oa.AuditID,
    oa.OrderID,
    oa.CustomerID,
    oa.DeletedAt,
    oa.DeletedBy,
    od.ProductID,
    od.Quantity,
    od.UnitPrice,
    od.Discount
FROM
	Audit_Orders oa
INNER JOIN
	Audit_Order_Details od
    ON oa.AuditID = od.AuditID
ORDER BY
	oa.AuditID, od.OrderID;

select * from Audit_Orders
order by OrderID desc