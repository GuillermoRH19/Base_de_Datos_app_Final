/* 
Ejercicio 1:
 -> Realizar un Venta dentro de la base de datos Northwind  utilizando transacciones y stores Procedures*/

 use northwind

 create or alter procedure sp_nueva_venta
 @CustomerID nchar(5),
 @EmployeeID int,
 @orderDate datetime,
 @RequiredDate datetime,
 @ShippedDate datetime,
 @ShipVia int,
 @Freight money = null,
 @ShipName nvarchar(40) = null,
 @ShipAddress nvarchar(60) = null,
 @ShipCity nvarchar(15) = null,
 @ShipRegion nvarchar(15) = null,
 @ShipPostalCode nvarchar(15) = null,
 @ShipCountry nvarchar(15) = null,
 @ProductID int,
 @UnitPrice money,
 @Quantity smallint,
 @Discount real
 as
 begin
 begin transaction
 begin try
 -- insertar en la tabla order
INSERT INTO Northwind.dbo.Orders(CustomerID, EmployeeID,orderDate,RequiredDate,ShippedDate,ShipVia ,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry) 
values (@CustomerID, @EmployeeID,@orderDate,@RequiredDate,@ShippedDate,@ShipVia ,@Freight,@ShipName,@ShipAddress,@ShipCity,@ShipRegion,@ShipPostalCode,@ShipCountry)
		   
--obtener el id insertado de la orden 
declare @orderid int
set @orderid=SCOPE_IDENTITY();

--obtener el precio del producto a insertar
declare @precioventa money

select @precioventa=UnitPrice from Products
where ProductID=@ProductID

set @precioventa=@UnitPrice

--insertar en detalle_orden el proucto
INSERT INTO Northwind.dbo.[Order Details](OrderID,ProductID,UnitPrice,Quantity,Discount) 
values (@orderid, @ProductID,@UnitPrice,@Quantity,@Discount)

--actualizar la tabla products reduciendo el unitsinstock con la cantidad vendida
update Products
set UnitsInStock=UnitsInStock - @Quantity
where ProductId=@ProductID

commit transaction

 end try
 begin catch
 rollback transaction

 declare @mensajeError varchar(400)
 set @mensajeError = ERROR_MESSAGE()
 print @mensajeError
 end catch
 end;


 go

 rollback transaction;

 update Products
 set UnitsInStock=29
 where ProductID=9

 select MAX(OrderID) from Orders

 select * from [Order Details]
 where OrderID=11077