use AdventureWorks2019

CREATE VIEW v_reporte_productos
AS
select ProductNumber, [name], ProductLine,
CASE ProductLine
when 'R' then 'Road'
when 'M' then 'Mountain'
when 'T' then 'Touring'
when 'S' then 'Other Sale items'
ELSE 'Not for sale'
END AS [Category]
from Production.Product

select * from v_reporte_productos

select ProductNumber, [name], ProductLine,
[Category] =CASE ProductLine
when 'R' then 'Road'
when 'M' then 'Mountain'
when 'T' then 'Touring'
when 'S' then 'Other Sale items'
ELSE 'Not for sale'
END 
from Production.Product

select ProductNumber as 'NumeroProducto',
[name] as 'Nombre Pro                                                                       '