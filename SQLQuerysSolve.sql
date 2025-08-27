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