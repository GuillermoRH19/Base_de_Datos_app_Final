-- Tablas tipo TYPE
CREATE TYPE P_tipoTabla 
   AS TABLE
      ( ProductID INT
      , Quantity SMALLINT
      , Discount REAL );
GO

declare @TablaProducto as P_tipoTabla
INSERT INTO @TablaProducto(ProductID,Quantity,Discount)
values(1,5,0),(2,8,0),(3,10,0)
go

SELECT * from products;
GO

-- Procedimiento almacenado modificado
CREATE OR ALTER PROCEDURE sp_insercion_tabla
    @CustomerID nchar(5),
    @EmployeeID int,
    @OrderDate datetime,
    @RequiredDate datetime,
    @ShippedDate datetime,
    @ShipVia int,
    @Freight money = null,
    @ShipName nvarchar(40) = null,
    @ShipAddress nvarchar(60) = null,
    @ShipCity nvarchar(15) = null,
    @ShipRegion nvarchar(15) = null,
    @ShipPostalCode nvarchar(10) = null,
    @ShipCountry nvarchar(15),
    @TablaProducto P_tipoTabla READONLY
AS
BEGIN
    BEGIN TRANSACTION
        BEGIN TRY
            -- Insertar en la tabla Orders
            INSERT INTO Northwind.dbo.Orders(
                CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
            ) 
            VALUES(
                @CustomerID, @EmployeeID, @OrderDate, @RequiredDate, @ShippedDate, @ShipVia, @Freight, @ShipName, @ShipAddress, @ShipCity, @ShipRegion, @ShipPostalCode, @ShipCountry
            );
            
            -- Obtener el Id Insertado en la orden 
            DECLARE @OrderID int;
            SET @OrderID = SCOPE_IDENTITY();

            -- Iterar sobre cada fila de la tabla de parámetros
            DECLARE @ProductID int, @Quantity smallint, @Discount real, @precioVenta money;
            
            DECLARE cur CURSOR FOR 
            SELECT ProductID, Quantity, Discount FROM @TablaProducto;

            OPEN cur;
            FETCH NEXT FROM cur INTO @ProductID, @Quantity, @Discount;

            WHILE @@FETCH_STATUS = 0
            BEGIN
                -- Obtener el Precio del producto a insertar
                IF EXISTS(SELECT 1 FROM Northwind.dbo.Products WHERE ProductID = @ProductID)
                BEGIN
                    SELECT @precioVenta = UnitPrice FROM Northwind.dbo.Products WHERE ProductID = @ProductID;
                    
                    INSERT INTO Northwind.dbo.[Order Details](
                        OrderID, ProductID, UnitPrice, Quantity, Discount
                    ) 
                    VALUES(
                        @OrderID, @ProductID, @precioVenta, @Quantity, @Discount
                    );

                    -- Actualizar la tabla Products reduciendo UnitsInStock con la cantidad vendida
                    UPDATE Northwind.dbo.Products 
                    SET UnitsInStock = UnitsInStock - @Quantity 
                    WHERE ProductID = @ProductID;
                END
                ELSE 
                BEGIN
                    RAISERROR('El producto ID %d no existe', 16, 1, @ProductID);
                    ROLLBACK TRANSACTION;
                    RETURN;
                END
                
                FETCH NEXT FROM cur INTO @ProductID, @Quantity, @Discount;
            END

            CLOSE cur;
            DEALLOCATE cur;

            --COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH 
            ROLLBACK TRANSACTION;
            DECLARE @mensajeError varchar(400); 
            SET @mensajeError = ERROR_MESSAGE();
            PRINT @mensajeError;
        END CATCH
END;
GO

-- Declarar la tabla de parámetros
DECLARE @TablaProducto P_tipoTabla;

-- Insertar datos en la tabla de parámetros
INSERT INTO @TablaProducto(ProductID, Quantity, Discount)
VALUES (1, 5, 0), (2, 8, 0), (3, 10, 0);

-- Visualizar los datos de la tabla de parámetros
-- SELECT * FROM @TablaProducto;

-- Ejecutar el procedimiento almacenado
EXEC sp_insercion_tabla
    @CustomerID = 'ALFKI', -- Ejemplo de CustomerID
    @EmployeeID = 5, 
    @OrderDate = '2023-02-18', -- Formato de fecha adecuado
    @RequiredDate = '2023-02-18', -- Formato de fecha adecuado
    @ShippedDate = '2023-02-18', -- Formato de fecha adecuado
    @ShipVia = 3,
    @Freight = 10.0, -- Valor de ejemplo para Freight
    @ShipCountry = 'USA', -- Valor de ejemplo para ShipCountry
    @TablaProducto = @TablaProducto;
GO