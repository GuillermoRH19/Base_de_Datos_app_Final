-- store procedure que visualice los resultados
-- de cualquier tabla

-- select * from [tabla]

use northwind

create or alter procedure sp_visualizar_datos
@tabla varchar(50)
as
begin
declare @sql nvarchar(50)
set @sql = 'SELECT * FROM' + QUOTENAME(@tabla)
exec sp_executesql @sql 
end;

declare @tabla2 varchar(50) = 'Customers'
exec sp_visualizar_datos 'products'

------------------------------------------------------------------

