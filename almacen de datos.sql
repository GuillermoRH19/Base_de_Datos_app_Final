CREATE DATABASE AlmacenDeDatos;
USE AlmacenDeDatos;

Create TABLE Suppliers (
    SupplierId INT IDENTITY(1,1) PRIMARY KEY,
    SupplierDB int not null,
    CompanyName VARCHAR(40),
    Country VARCHAR(15),
    Address VARCHAR(60),
    City VARCHAR(15)
);

insert into Suppliers(SupplierId,SupplierDB,CompanyName,Country,[Address],City)
select ns.SupplierID AS 'ProveedorDB',
ns.CompanyName AS 'Nombre',
ns.Country AS 'Estado',
ns.[Address] AS 'Correo',
ns.City AS 'Ciudad'
from [Northwind].dbo.Suppliers as ns


Create TABLE Customers (
    ClientId INT IDENTITY(1,1) PRIMARY KEY,
    ClientDB nchar(5) not null,
    CompanyName VARCHAR(40) not null,
    Address VARCHAR(60) not null,
    City VARCHAR(15) not null,
    Region VARCHAR(15) not null,
    Country VARCHAR(15) not null
);

insert into Customers(ClienteID,ClienteDB,CompanyName,[Address],City,Region,Country)
select nc.ClienteID AS 'ClienteDB',
nc.CompanyName AS 'Nombre',
nc.[Address] AS 'Correo',
nc.City AS 'Ciudad'
nc.region AS 'Region',
nc.Country AS 'Estado',
from [Northwind].dbo.Suppliers as nc

CREATE TABLE Employees (
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeDB Int not null,
    FullName VARCHAR(110),
    Title VARCHAR(30),
    HireDate DATE,
    Address VARCHAR(60),
    City VARCHAR(15),
    Region VARCHAR(15),
    Country VARCHAR(15)
);


CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductDB Int not null,
    ProductName VARCHAR(40),
    CategoryName VARCHAR(15)
);

CREATE TABLE Ventas (
    VentaId INT IDENTITY(1,1) PRIMARY KEY,
    ClientId INT,
    ProductId INT,
    EmployeeId INT,
    SupplierId INT,
    Quantity INT,
    UnitPrice Money,
    FOREIGN KEY (ClientId) REFERENCES Customers(ClientId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId),
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId)
);

CREATE PROCEDURE InsertSupplier
    @SupplierDB int,
    @CompanyName VARCHAR(40),
    @Country VARCHAR(15),
    @Address VARCHAR(60),
    @City VARCHAR(15)
AS
BEGIN
    INSERT INTO Suppliers (SupplierDB, CompanyName, Country, Address, City)
    VALUES (@SupplierDB, @CompanyName, @Country, @Address, @City);
END;

CREATE PROCEDURE InsertCustomer
    @ClientDB Int,
    @CompanyName VARCHAR(40),
    @Address VARCHAR(60),
    @City VARCHAR(15),
    @Region VARCHAR(15),
    @Country VARCHAR(15)
AS
BEGIN
    INSERT INTO Customers (ClientDB, CompanyName, Address, City, Region, Country)
    VALUES (@ClientDB, @CompanyName, @Address, @City, @Region, @Country);
END;

CREATE PROCEDURE InsertEmployee
    @EmployeeDB int,
    @FullName VARCHAR(110),
    @Title VARCHAR(30),
    @HireDate DATE,
    @Address VARCHAR(60),
    @City VARCHAR(15),
    @Region VARCHAR(15),
    @Country VARCHAR(15)
AS
BEGIN
    INSERT INTO Employees (EmployeeDB, FullName, Title, HireDate, Address, City, Region, Country)
    VALUES (@EmployeeDB, @FullName, @Title, @HireDate, @Address, @City, @Region, @Country);
END;

CREATE PROCEDURE InsertProduct
    @ProductDB Int,
    @ProductName VARCHAR(40),
    @CategoryName VARCHAR(15)
AS
BEGIN
    INSERT INTO Products (ProductDB, ProductName, CategoryName)
    VALUES (@ProductDB, @ProductName, @CategoryName);
END;

CREATE PROCEDURE InsertVenta
    @ClientId INT,
    @ProductId INT,
    @EmployeeId INT,
    @SupplierId INT,
    @Quantity INT,
    @UnitPrice money
AS
BEGIN
    INSERT INTO Ventas (ClientId, ProductId, EmployeeId, SupplierId, Quantity, UnitPrice)
    VALUES (@ClientId, @ProductId, @EmployeeId, @SupplierId, @Quantity, @UnitPrice);
END;


--EXEC InsertSupplier 001, 'Supplier A', 'Country A', 'Address A', 'City A';
--EXEC InsertSupplier 002, 'Supplier B', 'Country B', 'Address B', 'City B';
--EXEC InsertCustomer 101, 'Customer A', 'Address A', 'City A', 'Region A', 'Country A';
--EXEC InsertCustomer 102, 'Customer B', 'Address B', 'City B', 'Region B', 'Country B';
--EXEC InsertEmployee 201, 'Employee A', 'Title A', '2023-01-01', 'Address A', 'City A', 'Region A', 'Country A';
--EXEC InsertEmployee 202, 'Employee B', 'Title B', '2023-02-01', 'Address B', 'City B', 'Region B', 'Country B';
--EXEC InsertProduct 301, 'Product A', 'Category A';
--EXEC InsertProduct 302, 'Product B', 'Category B';
--EXEC InsertVenta 1, 1, 1, 1, 10, 100.00;
--EXEC InsertVenta 2, 2, 2, 2, 5, 200.00;

