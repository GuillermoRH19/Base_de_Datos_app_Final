create database vistaspractica;

use vistaspractica;

--Crear una vista de la siguiente consulta
CREATE VIEW view_categorias_productos 
as
    select c.CategoryName As 'Nombre Categoria', 
    p.ProductName as 'Nombre Producto', 
    p.UnitPrice as 'Precio', 
    p.UnitsInStock as 'Existencia'
    from 
    Northwind.dbo.Categories AS c
    inner join Northwind.dbo.Products As p
    on c.CategoryID = p.CategoryID;

select *,(precio*existencia) as 'PrecioInventario' 
from view_categorias_productos
where [nombre categoria] in('Beverages','Condiments')
order by[nombre categoria] desc;

select * from view_categorias_productos

--Seleccionar la suma del precio del inventario agrupado por categoria

-- selecciona la suma del precio del inventario agrupado por categoria

select [nombre categoria] as 'categoria', sum(precio*Existencia) as 'PrecioInventario'
from view_categorias_productos
group by [nombre categoria];