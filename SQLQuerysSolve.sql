/*Basado en la forma de redaccion de Queries sugerida por un DBA con mucha experiencia que suger�a
presentar las consultas de una manera estructurada para facilitar la lectura del codigo.
No es mandatorio, pero se supone una buena practica.*/

Use Northwind;

-- 1. Recuperar Lista de empleados (Nombre y Apellido)
Select	
		FirstName as Nombre,
		LastName  as Apellido
from	
		Employees;

-- 2. Recuperar Id, Apellido y Fecha de contrataci�n de los empelados.
Select	
		EmployeeID	as ID,
		LastName	as Apellido,
		HireDate	as FechaContratacion
from 
		Employees

-- 3. Recuperar id, nombre completo concatenado y t�tulo de cada empleado.
select	
		FirstName + ' ' + LastName	as NombreCompleto,
		Notes						as Titulos
from	
		Employees;

-- 4. Recuperar lista de clientes (id y nombre de la compa��a).
Select	
		CustomerID	as ClienteID,
		CompanyName	as Compa�ia
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
Recuperar pedidos hechos en el a�o 1997.
Recuperar empleados cuyo pa�s sea �USA�.
Recuperar productos con stock entre 10 y 50 unidades.
Recuperar clientes de pa�ses espec�ficos (M�xico, Argentina, Brasil).
Recuperar empleados cuyo apellido empiece con �D�.*/

-- 6. Recuperar productos cuyo precio sea mayor a 50.
Select
	*
from 
	Products
Where
	UnitPrice > 50;

-- 7. Recuperar pedidos hechos en el a�o 1997.
Select
	*
From 
	Orders
Where
	-- YEAR (OrderDate) = 1997;				-- Usando la funci�n YEAR().
	OrderDate >= '1997-01-01 00:00:00.000'
	And
	OrderDate < '1998-01-01 00:00:00.000';  -- Esta opcion es m�s eficiente si tenemos �ndices. 

-- 8. Recuperar empleados cuyo pa�s sea �USA�.
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

-- 10. Recuperar clientes de pa�ses espec�ficos (M�xico, Argentina, Brasil). Tener en cuenta el idioma de la DB.
Select
	*
From
	Customers
Where
	Country = 'Mexico'		or 
	Country = 'Argentina'	or
	Country = 'Brazil';

-- 11. Recuperar empleados cuyo apellido empiece con �D�.
Select
	*
From
	Employees
Where
	LastName like 'D%';