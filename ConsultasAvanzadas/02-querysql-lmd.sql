use [bdventas]

select * from [Northwind].dbo.customers
GO
select * from Cliente;
GO

-- Insertar varios clientes en una sola instrucción
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('hashashashas','RAHG050106HHGNRLA3','Alfreds Futterkiste','jsjhdn','Futterkiste')
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('SJSAJS','ATEG050106HHGNRLA3','Ana Trujillo Emparedados y heladosiste','KEKSKEK','FUER')
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('HASAJSAJ','AHRG16235HK1628J3','Antonio Moreno Taquería','HJSAK','KASKAKSL')
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('UEIREROE','EURIEOA183JSML4863','Around the Horn','KASLAS','JSJDSOA')
GO

-- Elimina los datos de la tabla cliente
delete from cliente
GO

-- Comando para reiniciar el identity de una tabla
DBCC CHECKIDENT (cliente, RESEED, 0)
GO

select top 0 EmployeeID as 'empleadoid', LastName as 'apellido', FirstName as 'nombre',BirthDate as
'fecha de nacimiento',HireDate as 'FechaContratacion', [Address] as 'direccion',
City as 'ciudad', Region, PostalCode as CodigoPostal,Country as 'pais' into empleado2 from Northwind.dbo.Employees
GO

--Insertar datos a partir de una consulta
drop table empleado2
GO

-- Altera una tabla agregandole un constraint de primary key
alter table empleado2
add constraint pk_empleado2
primary key (empleadoid)
GO

select top 5 * from Northwind.dbo.[Order Details]
order by OrderID desc
GO

select * from empleado2

insert into empleado2 (empleadoid,apellido,nombre,fechadenacimiento,fechacontratacion,direccion,ciudad,codigopostal,pais)
select EmployeeID as 'empleadoid',
LastName as 'apellido', 
FirstName as 'nombre',
BirthDate as 'fechadenacimiento',
HireDate as 'FechaContratacion',
[Address] as 'direccion',
City as 'ciudad', Region, PostalCode as CodigoPostal,Country as 'pais' from Northwind.dbo.Employees

select * from empleado2;
select * from empleado;
select * from Cliente

insert into Empleado(Nombre, Apellido1, Apellido2, CURP, RFC, numeroExterno, calle, Salario, NumeroNomina) values 
('Alan','Sntiago','Molina','ALM456789','ALMN3435',23,'Calle del infierno', 67890.9,1234),
('Yamileth','Mejia','Rangel','YMR456789','YMRN3435',null,'Calle del hambre', 77890.17,23456),
('Moises','Santiago','Isidro','MSI456789','MSIN3435',null,'Calle de la gordura', 20000,98765);

insert into ordencompra values 
(getdate(),'2024-06-10',1,6),
(getdate(),'2024-06-10',2,7),
(getdate(),'2024-07-11',3,8);

select * from  ordencompra
select * from  Cliente
select * from  empleado


select * from Producto

select * from Northwind.dbo.Products

select * from Proveedor

select * from Northwind.dbo.Suppliers

insert into Proveedor
select  CompanyName,PostalCode,'Calle de la sol',City,2345 as CP,'www.prueba.com.mx' as 'PaginaWeb' from Northwind.dbo.Suppliers


--Fecha actual del Sistema
select getdate()
select * from ordencompra

insert into producto (numerocontrol,descripcion,precio,[status],existencia,proveedorid)
select ProductID,ProductName,UnitPrice,Discontinued,UnitsInStock,SupplierID
from Northwind.dbo.Products
select * from DetalleCompra
select * from Producto
select * from ordencompra
insert into DetalleCompra 
values(1,7,10,(select precio from producto where numerocontrol =1)),
(2,8,11,(select precio from producto where numerocontrol =2))


--seleccionar las ordenes de compra realizadas al producto1
select *, (cantidad*preciocompra) as importe
from DetalleCompra
where ProductoId = 1

--seleccionar el total a pagar de las ordenes que contienen el producto 1

select sum(cantidad * preciocompra) as 'total'
from DetalleCompra
where ProductoId = 1