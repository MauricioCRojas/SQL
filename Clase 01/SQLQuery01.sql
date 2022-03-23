USE [AdventureWorks]

--Laboratorio: AdventureWorks - Operadores

--1. Mostrar el ID de los empleados que tienen más de 90 horas
--de vacaciones.
--Tablas: HumanResources.Employee
--Campos: VacationHours, BusinessEntityID
select VacationHours "Horas de Vac", BusinessEntityID "ID empleado" from HumanResources.Employee
where VacationHours > 90 
	
--2. Mostrar el nombre, precio de lista y precio de lista con IVA de
--los productos con precio distinto de cero.
--Tablas: Production.Product
--Campos: Name, ListPrice
select Name, ListPrice, ListPrice * 1.21 "ListPrice+IVA" from Production.Product 
where ListPrice <> 0

--3. Mostrar precio de lista y nombre de los productos 776, 777, 778
--Tablas: Production.Product
--Campos: ProductID, Name, ListPrice
select ProductID, Name, ListPrice from Production.Product where ProductID in (776, 777, 778)

--4. Mostrar el nombre concatenado con el apellido 
--de las personas cuyo apellido sea Johnson.
--Tablas: Person.Person
--Campos: FirstName, LastName
--select FirstName, LastName, CONCAT (FirstName, ' ', LastName) "FullName"
select FirstName + ' ' + LastName "FullName"
from Person.Person where LastName = 'Johnson'

--5. Mostrar todos los productos cuyo precio de lista 
--sea inferior a $150 de color rojo o cuyo precio 
--de lista sea mayor a $500 de color negro.
--Tablas: Production.Product
--Campos: ProductID, ListPrice, Color
select ProductID, ListPrice, Color from Production.Product 
where (ListPrice < 150 and Color = 'Red') or (ListPrice > 500 and Color = 'Black')

--6. Mostrar el ID, fecha de ingreso y horas de 
--vacaciones de los empleados que ingresaron a 
--partir del año 2000.
--Tablas: HumanResources.Employee
--Campos: BusinessEntityID, HireDate, VacationHours
select BusinessEntityID, HireDate, VacationHours from HumanResources.Employee 
where YEAR(HireDate) >= 2000
--where HireDate > '2000-01-01'

--7. Mostrar el nombre, número de 
--producto, precio de lista y el precio de 
--lista incrementado en un 10% de los 
--productos cuya fecha de fin de venta 
--sea anterior al día de hoy.
--Tablas: Production.Product
--Campos: Name, ProductNumber, ListPrice, 
--SellEndDate
--SQL Programming
select Name, ProductNumber, ListPrice, ListPrice * 1.10 'PriceMore10%', SellEndDate from Production.Product
where SellEndDate < getdate()

--Laboratorio: AdventureWorks - “Null”

--1. Mostrar los representantes de ventas (vendedores) que no 
--tienen definido el número de territorio.
--Tablas: Sales.SalesPerson
--Campos: BusinessEntityID, TerritoryID
select BusinessEntityID, TerritoryID from Sales.SalesPerson 
where TerritoryID is null

--2. Mostrar el peso de todos los artículos. Si el peso no estuviese 
--definido, reemplazar por cero.
--Tablas: Production.Product
--Campos: ProductID, Weight
select ProductID, Weight, ISNULL (Weight, 0) 'New Weight' from Production.Product


-- -- 

--Laboratorio: AdventureWorks

--Criterios de selección

--1. Mostrar el nombre, precio y color de los accesorios para 
--asientos las bicicletas cuyo precio sea mayor a 100 pesos.
--Tablas: Production.Product
--Campos: Name, ListPrice, Color
select Name, ListPrice, Color from Production.Product
where ListPrice > 100

--2. Mostrar el nombre de los productos que tengan cualquier 
--combinación de ‘mountain bike’.
--Tablas: Production.Product
--Campos: Name
select Name from Production.Product
where Name like '%mountain bike%'

--3. Mostrar las personas cuyo nombre comience con la
--letra “y”.
--Tablas: Person.Person
--Campos: FirstName
--SQL Programming
select * from Person.Person
where left(FirstName, 1) = 'y'
--where FirstName like 'y%'

--4. Mostrar las personas que en la segunda 
--letra de su apellido tienen una ‘s’.
--Tablas: Person.Person
--Campos: LastName
select * from Person.Person
where LastName like '_s%'

--5. Mostrar el nombre concatenado con el 
--apellido de las personas cuyo apellido 
--terminen en ‘ez’.
--Tablas: Person.Person
--Campos: FirstName, LastName
select CONCAT (FirstName, ' ', LastName) 'FullName' from Person.Person
where LastName like '%ez'

--6. Mostrar los nombres de los productos 
--que terminen en un número.
--Tablas: Production.Product
--Campos: Name
select Name from Production.Product
where Name like '%[0-9]'

--7. Mostrar las personas cuyo nombre tenga 
--una ‘C’ o ‘c’ como primer carácter, cualquier 
--otro como segundo carácter, ni ‘d’ ni ‘e’ ni ‘f’ 
--ni ‘g’ como tercer carácter, cualquiera entre 
--‘j’ y ‘r’ o entre ‘s’ y ‘w’ como cuarto carácter y 
--el resto sin restricciones.
--Tablas: Person.Person
--Campos: FirstName
select * from Person.Person
where FirstName like '[C-c]_[^d-g][j-w]%'

--Laboratorio: AdventureWorks - Between

--1. Mostrar todos los productos cuyo precio de lista esté entre 200 y 300.
--Tablas: Production.Product
--Campos: ListPrice
select * from Production.Product
where ListPrice between 200 and 300

--2. Mostrar todos los empleados que nacieron entre 1970 y 1985.
--Tablas: HumanResources.Employee
--Campos: BirthDate
select * from HumanResources.Employee
--where BirthDate between '1970-01-01' and '1985-12-31'
where year(BirthDate) between 1970 and 1985

--3. Mostrar la fecha, número de cuenta y subtotal de las órdenes de venta 
--efectuadas en los años 2005 y 2006.
--Tablas: Sales.SalesOrderHeader
--Campos: OrderDate, AccountNumber, SubTotal
select OrderDate, AccountNumber, Subtotal from Sales.SalesOrderHeader
where year(OrderDate) between 2005 and 2006

--4. Mostrar todas las órdenes de venta cuyo Subtotal no esté entre 50 y 70
--Tablas: Sales.SalesOrderHeader
--Campos: OrderDate, AccountNumber, SubTotal
select OrderDate, AccountNumber, Subtotal from Sales.SalesOrderHeader
where Subtotal not between 50 and 70

--Laboratorio: AdventureWorks - IN

--1. Mostrar los códigos de orden de venta, código de producto, 
--cantidad vendida y precio unitario de los productos 750, 753 y 770.
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, OrderQty, ProductID, UnitPrice
select SalesOrderID, OrderQty, ProductID, UnitPrice from Sales.SalesOrderDetail
where ProductID in (750, 753, 770) order by ProductID

--2. Mostrar todos los productos cuyo color sea verde, blanco y azul.
--Tablas: Production.Product
--Campos: Color
select * from Production.Product
where Color in ('Green', 'White', 'Red') order by Color

-- --

--Laboratorio: AdventureWorks - Order By

--1. Mostrar las personas ordenadas, primero por su 
--apellido y luego por su nombre.
--Tablas: Person.Person
--Campos: Firstname, Lastname
select * from Person.Person
order by LastName, FirstName 

--2. Mostrar los cinco productos más caros y su nombre, 
--ordenados en forma alfabética.
--Tablas: Production.Product
--Campos: Name, ListPrice
select top 5 Name, ListPrice from Production.Product
order by ListPrice desc, Name