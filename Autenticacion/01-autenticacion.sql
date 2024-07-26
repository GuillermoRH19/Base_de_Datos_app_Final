use Northwind

create or alter procedure selec_prueba
as
begin
select * from Employees


select * from Customers
update Customers
set City='Berlin'
where CustomerID='ALFKI'


select * from [Order Details]
select * from Orders
select * from Products
end;

exec [dbo].[spu_agregar_venta]
@customerid='ALFKI',
@EmployeeID=1,
@OrderDate='2024-07-26',
@RequiredDate='2024-07-26',
@ShippedDate='2024-07-26',
@ShipVia=1, @ProductID=2,
@Quantity =10