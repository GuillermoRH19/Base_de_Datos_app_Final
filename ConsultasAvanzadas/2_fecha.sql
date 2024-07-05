-- Funciones de fecha 

use Northwind

-- seleccionar los años, dias, mes y cuatrimestre de las ordenes

select GETDATE()

select DATEPART(YEAR, '2024-06-06')as 'Año',
DATEPART(MONTH, '2024-06-06')as 'mes',
DATEPART(QUARTER, '2024-06-06')as 'trimestre',
DATEPART(WEEK, '2024-06-06')as 'semana',
DATEPART(DAY, '2024-06-06')as 'dia',
DATEPART(WEEKDAY, '2024-06-06')as 'Dia de la semana'


select DATEPART(YEAR, o.OrderDate)as 'Año',
DATEPART(MONTH, o.OrderDate)as 'mes',
DATEPART(QUARTER, o.OrderDate)as 'trimestre',
DATEPART(WEEK, o.OrderDate)as 'semana',
DATEPART(DAY, o.OrderDate)as 'dia',
DATEPART(WEEKDAY, o.OrderDate)as 'Dia de la semana'
 from Orders as o

 -- funcion que regresa el nombre de un mes o dia, etc

 select DATETIME(month, GETDATE()) as mes
set LANGUAGE spanish
select DATENAME(month,GETDATE()) as mes, DATENAME(day,GETDATE()) as dia

SET LANGUAGE spanish
select DATENAME(YEAR, o.OrderDate)as 'Año',
DATENAME(MONTH, o.OrderDate)as 'mes',
DATENAME(QUARTER, o.OrderDate)as 'trimestre',
DATENAME(WEEK, o.OrderDate)as 'semana',
DATENAME(DAY, o.OrderDate)as 'dia',
DATENAME(WEEKDAY, o.OrderDate)as 'Dia de la semana'
 from Orders as o

 -- funcion para obtener la diferencia entre años, meses, dias, etc

 select DATEDIFF(year, '1983-04-06', GETDATE()) as 'tiempo de vejez'

 --