use Northwind

-- un sp para almacenar o actualizar, o insertar registros
-- Creación de la base de datos Northwind_2
create database Northwind_3;
-- Uso de la nueva base de datos
use Northwind_3;

-- 1. Crear la tabla Suppliers
select top 0
    s.SupplierID, s.CompanyName, s.Country, s.Address, s.City
into [Northwind_3].dbo.Suppliers
from [Northwind].dbo.Suppliers as s;
go
alter table Suppliers add constraint PK_Suppliers primary key (SupplierID);
go

-- 2. Employees
select top 0
    e.EmployeeID, concat(e.FirstName, ' ', e.LastName) as FullName, e.Title, e.HireDate, e.Address, e.City, e.Region, e.Country
into [Northwind_3].dbo.Employees
from [Northwind].dbo.Employees as e;
go
alter table Employees add constraint PK_Employees primary key (EmployeeID);
go

-- 3. Customers
select top 0
    c.CustomerID, c.CompanyName, c.Address, c.City, c.Region, c.Country
into [Northwind_3].dbo.Customers
from [Northwind].dbo.Customers as c;
go
alter table Customers add constraint PK_Customers primary key (CustomerID);
go

-- 4. Products
select top 0
    p.ProductID, p.ProductName, c.CategoryName
into [Northwind_3].dbo.Products
from [Northwind].dbo.Products as p
    join [Northwind].dbo.Categories as c on p.CategoryID = c.CategoryID;
go
alter table Products add constraint PK_Products primary key (ProductID);
go

-- 5. Sales
select top 0
    concat(o.CustomerID, o.EmployeeID, od.ProductID, p.SupplierID) as SaleID,
    o.CustomerID, o.EmployeeID, od.ProductID, p.SupplierID, od.Quantity, od.UnitPrice
into [Northwind_3].dbo.Sales
from [Northwind].dbo.Orders as o
    join [Northwind].dbo.[Order Details] as od on o.OrderID = od.OrderID
    join [Northwind].dbo.Products as p on p.ProductID = od.ProductID;

alter table Sales add constraint FK_Customers foreign key (CustomerID) references Customers(CustomerID);
go
alter table Sales add constraint FK_Employees foreign key (EmployeeID) references Employees(EmployeeID);
go
alter table Sales add constraint FK_Products foreign key (ProductID) references Products(ProductID);
go
alter table Sales add constraint FK_Suppliers foreign key (SupplierID) references Suppliers(SupplierID);
go


-- 3. Customers
create or alter procedure insercion_c3
as
begin
insert into [Northwind_3].dbo.Customers
select 
    c.CustomerID,ISNULL(cast(c.CompanyName as varchar),'no tiene nombre'), isnull(c.Address,'no tiene direccion'), isnull(c.City,'no tiene ciudad'), isnull(c.Region,'no tiene region'), isnull(c.Country,'no tiene pais')
from [Northwind].dbo.Customers as c
left join [Northwind_3].dbo.Customers as c3
on c.CustomerID=c3.CustomerID
where c3.CustomerID is null

update [Northwind_3].dbo.Customers
set 
    CustomerID=c.CustomerID,
	CompanyName = ISNULL(cast(c.CompanyName as varchar),'no tiene nombre'),
	Address = isnull(c.Address,'no tiene direccion'),
	city = isnull(c.City,'no tiene ciudad'),
	region = isnull(c.Region,'no tiene region'),
	country = isnull(c.Country,'no tiene pais')
from [Northwind_3].dbo.Customers as c3
left join [Northwind].dbo.Customers as c
on c.CustomerID=c3.CustomerID
where 
    c3.CompanyName <> ISNULL(cast(c.CompanyName as varchar),'no tiene nombre') or
	c3.Address <> isnull(c.Address,'no tiene direccion') or
	c3.city <> isnull(c.City,'no tiene ciudad') or
	c3.region <> isnull(c.Region,'no tiene region') or
	c3.Country <> isnull(c.Country,'no tiene pais')
end

exec insercion_c3

alter table Customers add constraint PK_Customers primary key (CustomerID);
go

-- insertar un registro en la tabla de empleados

create or alter procedure ins_2

@productname varchar(50),
@supplierid int,
@categoryid int,
@quantity decimal(10,2),
@unitprice decimal(10,2),
@unitsinstock int,
@unitsonorder int,
@reorderlevel int,
@discontinued int
as
begin
insert into [Northwind].dbo.Products(ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
values (@productname,@supplierid,@categoryid,@quantity,@unitprice,@unitsinstock,@unitsonorder,@reorderlevel,@discontinued)
end

declare @productname2 varchar(50)='WWE',@supplierid2 INT=1,@categoryid2 INT=2,@quantity2 DECIMAL(10,2)=12.4,@unitprice2 DECIMAL(10,2)=16.6,@unitsinstock2 INT=6,@unitsonorder2 INT=6,@reorderlevel2 INT=9,@discontinued2 INT=0 
exec ins_2  @productname=@productname2,@supplierid=@supplierid2,@categoryid=@categoryid2,@quantity=@quantity2,@unitprice=@unitprice2,@unitsinstock=@unitsinstock2,@unitsonorder=@unitsonorder2,@reorderlevel=@reorderlevel2,@discontinued=@discontinued2

select * from Products