--Cliente
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Clientes_ADD
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDeDatos.dbo.Customers
    SET 
        ClientDB = n.CustomerID,
        CompanyName = ISNULL(n.CompanyName, 'sin CompanyName'),
        [Address] = ISNULL(n.[Address], 'sin direccion'),
        City = ISNULL(n.City, 'sin ciudad'),
        Region = ISNULL(n.Region, 'sin region'),
        Country = ISNULL(n.Country, 'sin pais')
    FROM Northwind.dbo.Customers AS n
    INNER JOIN AlmacenDeDatos.dbo.Customers AS a
    ON n.CustomerID = a.ClientDB
    WHERE 
        a.ClientDB <> n.CustomerID OR
        a.CompanyName <> ISNULL(n.CompanyName, 'sin CompanyName') OR
        a.[Address] <> ISNULL(n.[Address], 'sin direccion') OR
        a.City <> ISNULL(n.City, 'sin ciudad') OR
        a.Region <> ISNULL(n.Region, 'sin region') OR
        a.Country <> ISNULL(n.Country, 'sin pais');

    -- Insertar registros nuevos
    INSERT INTO AlmacenDeDatos.dbo.Customers (ClientDB, CompanyName, [Address], City, Region, Country)
    SELECT 
        n.CustomerID,
        ISNULL(n.CompanyName, 'sin CompanyName'),
        ISNULL(n.[Address], 'sin direccion'),
        ISNULL(n.City, 'sin ciudad'),
        ISNULL(n.Region, 'sin region'),
        ISNULL(n.Country, 'sin pais')
    FROM Northwind.dbo.Customers AS n
    LEFT JOIN AlmacenDeDatos.dbo.Customers AS a
    ON n.CustomerID = a.ClientDB
    WHERE a.ClientDB IS NULL;
END;


EXEC sp_Actualizar_Insertar_Clientes_ADD;

	select * from AlmacenDeDatos.dbo.Customers;
	select * from Northwind.dbo.Customers;

--Employes
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Empleado_ADD
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDeDatos.dbo.Employees
    SET 
        EmployeeDB = n.EmployeeID,
        FullName = ISNULL(CONCAT(n.FirstName, ' ', n.LastName), 'sin nombre completo'),
        Title = ISNULL(n.Title, 'sin titulo'),
        HireDate = ISNULL(CONVERT(varchar, n.HireDate, 120), 'Sin fecha de contratación'),
        [Address] = ISNULL(n.[Address], 'Sin direccion'),
        City = ISNULL(n.City, 'sin ciudad'),
        Region = ISNULL(n.Region, 'sin Region'),
        Country = ISNULL(n.Country, 'sin país')
    FROM Northwind.dbo.Employees AS n
    INNER JOIN AlmacenDeDatos.dbo.Employees AS a
    ON n.EmployeeID = a.EmployeeDB
    WHERE 
        a.EmployeeDB <> n.EmployeeID OR
        a.FullName <> ISNULL(CONCAT(n.FirstName, ' ', n.LastName), 'sin nombre completo') OR
        a.Title <> ISNULL(n.Title, 'sin titulo') OR
        a.HireDate <> ISNULL(CONVERT(varchar, n.HireDate, 120), 'Sin fecha de contratación') OR
        a.[Address] <> ISNULL(n.[Address], 'Sin direccion') OR
        a.City <> ISNULL(n.City, 'sin ciudad') OR
        a.Region <> ISNULL(n.Region, 'sin Region') OR
        a.Country <> ISNULL(n.Country, 'sin país');

    -- Insertar registros nuevos
    INSERT INTO AlmacenDeDatos.dbo.Employees (EmployeeDB, FullName, Title, HireDate, [Address], City, Region, Country)
    SELECT 
        n.EmployeeID,
        ISNULL(CONCAT(n.FirstName, ' ', n.LastName), 'sin nombre completo'),
        ISNULL(n.Title, 'sin titulo'),
        ISNULL(CONVERT(varchar, n.HireDate, 120), 'Sin fecha de contratación'),
        ISNULL(n.[Address], 'Sin direccion'),
        ISNULL(n.City, 'sin ciudad'),
        ISNULL(n.Region, 'sin Region'),
        ISNULL(n.Country, 'sin país')
    FROM Northwind.dbo.Employees AS n
    LEFT JOIN AlmacenDeDatos.dbo.Employees AS a
    ON n.EmployeeID = a.EmployeeDB
    WHERE a.EmployeeDB IS NULL;
END;


EXEC sp_Actualizar_Insertar_Empleado_ADD;

	select * from AlmacenDeDatos.dbo.Employees;
	select * from Northwind.dbo.Employees;

--Suppliers
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Suppliers_ADD
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDeDatos.dbo.Suppliers
    SET 
        SupplierDB = n.SupplierID,
        CompanyName = ISNULL(n.CompanyName, 'Sin CompanyName'),
        Country = ISNULL(n.Country, 'Sin pais'),
        [Address] = ISNULL(n.[Address], 'Sin direccion'),
        City = ISNULL(n.City, 'sin ciudad')
    FROM Northwind.dbo.Suppliers AS n
    INNER JOIN AlmacenDeDatos.dbo.Suppliers AS a
    ON n.SupplierID = a.SupplierDB
    WHERE 
        a.SupplierDB <> n.SupplierID OR
        a.CompanyName <> ISNULL(n.CompanyName, 'Sin CompanyName') OR
        a.Country <> ISNULL(n.Country, 'Sin pais') OR
        a.[Address] <> ISNULL(n.[Address], 'Sin direccion') OR
        a.City <> ISNULL(n.City, 'sin ciudad');

    -- Insertar registros nuevos
    INSERT INTO AlmacenDeDatos.dbo.Suppliers (SupplierDB, CompanyName, Country, [Address], City)
    SELECT 
        n.SupplierID,
        ISNULL(n.CompanyName, 'Sin CompanyName'),
        ISNULL(n.Country, 'Sin pais'),
        ISNULL(n.[Address], 'Sin direccion'),
        ISNULL(n.City, 'sin ciudad')
    FROM Northwind.dbo.Suppliers AS n
    LEFT JOIN AlmacenDeDatos.dbo.Suppliers AS a
    ON n.SupplierID = a.SupplierDB
    WHERE a.SupplierDB IS NULL;
END;

EXEC sp_Actualizar_Insertar_Suppliers_ADD;

	select * from AlmacenDeDatos.dbo.Suppliers;
	select * from Northwind.dbo.Suppliers;

--Product
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Product_ADD
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDeDatos.dbo.Products
    SET 
	    ProductDB = n.ProductID,
        ProductName = ISNULL(n.ProductName, 'Sin nombre de producto'),
		CategoryName = ISNULL(na.CategoryName, 'sin Categoria')
	
    FROM Northwind.dbo.Products AS n
    INNER JOIN AlmacenDeDatos.dbo.Products AS a
    ON n.ProductID = a.ProductDB
	INNER JOIN Northwind.dbo.Categories AS na
	ON n.CategoryID = na.CategoryID
    WHERE 
		a.ProductDB <> n.ProductID OR
        a.ProductName <> ISNULL(n.ProductName, 'Sin nombre de producto') OR
		a.CategoryName <> ISNULL(na.CategoryName, 'sin Categoria');
	
    -- Insertar registros nuevos
    INSERT INTO AlmacenDeDatos.dbo.Products(ProductDB, ProductName, CategoryName)
    SELECT 
        n.ProductID,
        ISNULL(n.ProductName, 'Sin nombre de producto'),
        ISNULL(na.CategoryName, 'sin Categoria')
        
    FROM Northwind.dbo.Products AS n
    LEFT JOIN AlmacenDeDatos.dbo.Products AS a
    ON n.ProductID = a.ProductDB
	LEFT JOIN Northwind.dbo.Categories AS na
	ON n.CategoryID = na.CategoryID
    WHERE a.ProductDB IS NULL;
END;

EXEC sp_Actualizar_Insertar_Product_ADD;

	select * from AlmacenDeDatos.dbo.Suppliers;
	select * from Northwind.dbo.Suppliers;

--Ventas
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Ventas_ADD
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDeDatos.dbo.Ventas
    SET 
	    ClientID = ISNULL(cast(c.ClientID as nvarchar), 'No tiene ClienteId'),
		ProductID = ISNULL(cast(p.ProductID as nvarchar), 'No tiene ProductId'),
		EmployeeID = ISNULL(cast(n.EmployeeID as nvarchar), 'No tiene EmployeeID'),
		SupplierID = ISNULL(cast(s.SupplierID as nvarchar), 'No tiene ShipperId'),
        UnitPrice = ISNULL(od.UnitPrice, 0), 
        Quantity = ISNULL(od.Quantity, 0)    
     FROM Northwind.dbo.Orders AS n
    LEFT JOIN AlmacenDeDatos.dbo.Customers AS c
        ON n.CustomerID = c.ClientDB        
    LEFT JOIN AlmacenDeDatos.dbo.Employees AS e
        ON n.EmployeeID = e.EmployeeDB   
    LEFT JOIN Northwind.dbo.[Order Details] AS od
        ON n.OrderID = od.OrderID
	LEFT JOIN AlmacenDeDatos.dbo.Products AS p
        ON od.ProductID= p.ProductDB 
	LEFT JOIN Northwind.dbo.Products AS np
        ON p.ProductDB = np.ProductID 
	LEFT JOIN AlmacenDeDatos.dbo.Suppliers AS s
        ON np.SupplierID = s.SupplierDB
		LEFT JOIN AlmacenDeDatos.dbo.Ventas AS v
        ON c.ClientID = v.ClientID
    WHERE 
        v.ClientId <> ISNULL(cast(c.ClientId as nvarchar), 'No tiene ClienteId') OR
		v.ProductId <> ISNULL(cast(p.ProductID as nvarchar), 'No tiene ProductId') OR
		v.EmployeeId <> ISNULL(cast(n.EmployeeID as nvarchar), 'No tiene EmployeeID') OR
		v.SupplierId <> ISNULL(cast(s.SupplierDB as nvarchar), 'No tiene ShipperId') OR
		v.UnitPrice <> ISNULL(od.UnitPrice, 0) OR
		v.Quantity <> ISNULL(od.Quantity, 0) 

    -- Insertar registros nuevos
    INSERT INTO AlmacenDeDatos.dbo.Ventas (ClientId, ProductId, EmployeeId, SupplierId, UnitPrice, Quantity)
    SELECT 
        ISNULL(cast(c.ClientId as nvarchar), 'No tiene ClienteId'),
    ISNULL(cast(p.ProductId as nvarchar), 'No tiene ProductId'),
    ISNULL(cast(n.EmployeeID as nvarchar), 'No tiene EmployeeID'),
    ISNULL(cast(s.SupplierId as nvarchar), 'No tiene ShipperId'),
    ISNULL(od.UnitPrice, 0) AS UnitPrice,
    ISNULL(od.Quantity, 0) AS Quantity    
    FROM Northwind.dbo.Orders AS n
    LEFT JOIN AlmacenDeDatos.dbo.Customers AS c
        ON n.CustomerID = c.ClientDB       
    LEFT JOIN AlmacenDeDatos.dbo.Employees AS e
        ON n.EmployeeID = e.EmployeeDB   
    LEFT JOIN Northwind.dbo.[Order Details] AS od
        ON n.OrderID = od.OrderID
	LEFT JOIN AlmacenDeDatos.dbo.Products AS p
        ON od.ProductID= p.ProductDB  
	LEFT JOIN Northwind.dbo.Products AS np
        ON p.ProductDB = np.ProductID 
	LEFT JOIN AlmacenDeDatos.dbo.Suppliers AS s
        ON np.SupplierID = s.SupplierDB
		LEFT JOIN AlmacenDeDatos.dbo.Ventas AS v
        ON c.ClientId = v.ClientId
    WHERE v.ClientId  is null;
END;



EXEC sp_Actualizar_Insertar_Ventas_ADD;

	select * from AlmacenDeDatos.dbo.Ventas;
	select * from Northwind.dbo.[Order Details];
	
	--2 Crear un sp que Actualice la tabla ventas

