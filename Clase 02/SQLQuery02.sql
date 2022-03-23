USE [AdventureWorks]

--Laboratorio: AdventureWorks - Distinct

--1. Mostrar los diferentes productos vendidos.
--Tablas: Sales.SalesOrderDetail
--Campos: ProductID
select distinct ProductID from Sales.SalesOrderDetail


--Laboratorio: AdventureWorks - Union

--1. Mostrar todos los productos vendidos y ordenados
--Tablas: Sales.SalesOrderDetail, Production.WorkOrder
--Campos: ProductID
select ProductID from Sales.SalesOrderDetail
union all
select ProductID from Production.WorkOrder


--2. Mostrar los diferentes productos vendidos y ordenados
--Tablas: Sales.SalesOrderDetail, Production.WorkOrder
--Campos: ProductID
select ProductID from Sales.SalesOrderDetail
union 
select ProductID from Production.WorkOrder order by ProductID

--Laboratorio: AdventureWorks -
--Expresión CASE

--1. Obtener el id y una columna denominada sexo cuyo valores 
--disponibles sean “Masculino” y ”Femenino”.
--Tablas: HumanResources.Employee
--Campos: BusinessEntityID, Gender
select BusinessEntityID, case Gender
when 'M' then 'Masculino'
when 'F' then 'Femenino'
end as Sexo
from HumanResources.Employee

--2. Mostrar el id de los empleados, si tiene salario deberá 
--mostrarse descendente de lo contrario ascendente.
--Tablas: HumanResources.Employee
--Campos: BusinessEntityID, SalariedFlag
select BusinessEntityID, SalariedFlag from HumanResources.Employee
order by 
case when SalariedFlag = 1 then BusinessEntityID end desc, 
case when SalariedFlag <> 1 then BusinessEntityID end asc
--case SalariedFlag when 1 then BusinessEntityID end desc, 
--case SalariedFlag when 0 then BusinessEntityID end asc



--Funciones de agregación/agrupamiento
--contar, sumar, minimo, máximo, promedio 

--Laboratorio: AdventureWorks - Funciones de agregado

--1. Mostrar la fecha más reciente de venta.
--Tablas: Sales.SalesOrderHeader
--Campos: OrderDate
--select top 1 OrderDate [Fecha más reciente] from Sales.SalesOrderHeader order by OrderDate desc
select max(OrderDate) [Fecha más reciente] from Sales.SalesOrderHeader


--2. Mostrar el precio más barato de todas 
--las bicicletas.
--Tablas: Production.Product
--Campos: ListPrice, Name
select min(ListPrice) [Precio más barato] from Production.Product where Name like '%bike%'
select min(ListPrice) [Precio más barato] from Production.Product where ProductSubcategoryID in (1,2,3)



--3. Mostrar la fecha de nacimiento del 
--empleado más joven.
--Tablas: HumanResources.Employee
--Campos: BirthDate
select max(BirthDate) [Fecha Nac emp más joven] from HumanResources.Employee


--4. Mostrar el promedio del listado de 
--precios de productos.
--Tablas: Production.Product
--Campos: ListPrice
select avg(ListPrice) [Promedio ListPrice] from Production.Product


--5. Mostrar la cantidad de ventas y el 
--total vendido.
--Tablas: Sales.SalesOrderDetail
--Campos: LineTotal
select sum(OrderQty) [Cantidad ventas], sum(LineTotal) [TotalVendido] from Sales.SalesOrderDetail



--Laboratorio: AdventureWorks - Group By

--1. Mostrar el código de subcategoría y el 
--precio del producto más barato de cada 
--una de ellas.
--Tablas: Production.Product
--Campos: ProductSubcategoryID, ListPrice
select ProductSubcategoryID, min(ListPrice) [Produto más barato] from Production.Product
where ProductSubcategoryID is not null
group by ProductSubcategoryID

--2. Mostrar los productos y la cantidad total 
--vendida de cada uno de ellos.
--Tablas: Sales.SalesOrderDetail
--Campos: ProductID, OrderQty
select ProductId, sum(OrderQty) [TotalVendido] from Sales.SalesOrderDetail
group by ProductId order by ProductId


--3. Mostrar los productos y el total vendido de 
--cada uno de ellos, ordenados por el total 
--vendido.
--Tablas: Sales.SalesOrderDetail
--Campos: ProductID, LineTotal
select ProductID, sum(LineTotal) [Total vendido] from Sales.SalesOrderDetail
group by ProductID order by [Total vendido]

--4. Mostrar el promedio vendido por factura.
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, LineTotal
select SalesOrderId, avg(LineTotal) [Prom vend por factura] from Sales.SalesOrderDetail
group by SalesOrderId


--Laboratorio: AdventureWorks - Having

--1. Mostrar todas las facturas realizadas y
--el total facturado de cada una de ellas 
--ordenado por número de factura pero sólo 
--de aquellas órdenes superen un total de 
--$10.000.
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, LineTotal
select SalesOrderID, sum(LineTotal) [TotalFacturado] from Sales.SalesOrderDetail
group by SalesOrderID 
having sum(LineTotal) > 10000
order by SalesOrderID
--order by [TotalFacturado] 


--2. Mostrar la cantidad de facturas que 
--vendieron más de 20 unidades.
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, OrderQty
select SalesOrderId, sum(OrderQty) [Cantidad vendido] from Sales.SalesOrderDetail
group by SalesOrderID
having sum(OrderQty) > 20
order by [Cantidad vendido]


--3. Mostrar las subcategorías de los productos 
--que tienen dos o más productos que cuestan 
--menos de $150.
--Tablas: Production.Product
--Campos: ProductSubcategoryID, ListPrice
select ProductSubcategoryID, count(*) [Cantidad de Productos] from Production.Product
where ProductSubcategoryID is not null and ListPrice < 150
group by ProductSubcategoryID
having count(*) >= 2

--4. Mostrar todos los códigos de subcategorías 
--existentes junto con la cantidad para los 
--productos cuyo precio de lista sea mayor a $ 
--70 y el precio promedio sea mayor a $ 300.
--Tablas: Production.Product
--Campos: ProductSubcategoryID, ListPrice
select ProductSubcategoryID, count(*) [Cantidad de Productos], sum(ListPrice) [PrecioTotal], 
avg (ListPrice) [PrecioPromedio] from Production.Product
where ProductSubcategoryID is not null and ListPrice > 70
group by ProductSubcategoryID
having avg (ListPrice) > 300


--Laboratorio: AdventureWorks - RollUp

--1. Mostrar el número de factura, el monto vendido, y al final, 
--totalizar la facturación.
--Tablas: Sales.SalesOrderDetail
--Campos: SalesOrderID, UnitPrice, OrderQty
select SalesOrderID, sum(UnitPrice * OrderQty) [TotalVendido] from Sales.SalesOrderDetail
group by rollup (SalesOrderID)