-- Realizar un sp que permita vizualizar lo vendido a los clientes mostrando el nombre del cliente y en año variable

   CREATE PROCEDURE procedure_ciclo_prueba
    AS
    BEGIN
      SELECT c.CompanyName as 'cliente', YEAR(o.orderdate) as 'año', SUM(od.UnitPrice*od.Quantity) as 'total'
      from Customers as c JOIN Orders as o on c.CustomerID=o.CustomerID join [Order Details] as od on od.OrderID=o.OrderID 
      GROUP by c.CompanyName,YEAR(o.OrderDate)
        end

        exec procedure_ciclo_prueba 

-- 2.- Crear un sp que inserte un producto


       
