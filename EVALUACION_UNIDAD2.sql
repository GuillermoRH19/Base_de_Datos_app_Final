

--actualice los precios de los productos y guardarlos en una tabla de historicos
--debe llevar un id la tabla, el id del producto que se modifico, el precio anterior, el precio nuevo y la fecha de modificación
use Northwind

create table p_historicos(
IDproducto_historico int identity primary key,
ProductID int,
precio_anterior money,
nuevo_precio money,
fecha Datetime Default Getdate()
 );

drop table p_historicos


create or alter procedure sp_act_precio
@IDProducto int,
    @nuevo_precio Money
as
begin
    BEGIN TRANSACTION
        BEGIN TRY
            declare
            @precio money
            set @precio= (select UnitPrice
                from Products
                where ProductID = @IDProducto)
            Update Products
            Set UnitPrice =  @nuevo_precio
            where ProductID = @IDProducto
            Print ('se actulizo la lista de precios')
            insert into p_historicos
                    (ProductID,precio_anterior,nuevo_precio)
                select @ProductID, @precio,  @nuevo_precio
                from Products
                where ProductID = @IDProducto
            COMMIT TRANSACTION
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            DECLARE @mensajeError VARCHAR(50)
            set @mensajeError = ERROR_MESSAGE()
            PRINT @mensajeError
        END CATCH
END
GO

 ------------------------EJECUCIÓN-----------------------------------
 exec sp_act_precio @IDProducto = 3, @nuevo_precio = 21.00;
--crear un store procedure que elimine una orden y orden details y actulizar el stock
select * from p_historicos;
select * from Products
go
 go

 select * from Products
 select * from p_historicos;


select * from [Northwind].dbo.Products

-- crear un sp que elimine una orden y actualizar el stock del producto