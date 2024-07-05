-- store procedures (parametros de salida)
use Northwind

-- crear un sp que calcule el área de un circulo

create or alter procedure sp_calcular_area_circulo
@radio float, --parametro de entrada 
@area float output --parametro de salida
AS
BEGIN
    SET @area=PI()*@radio*@radio

END
GO

DECLARE @resultado float
EXEC sp_calcular_area_circulo @radio = 5.5, @area = @resultado output
print 'El valor del área es: '+cast(@resultado as varchar);
go

-- 1.-Obtener los nombres de un empleado dado
create or alter procedure sp_obtener_informacion_empleado
@employeeid int=-1,
@apellido nvarchar(20) output,
@nombre nvarchar(10) output
as
begin

if @employeeid <> -1
begin
select FirstName,LastName from Employees
where EmployeeID=@employeeid
end
else
begin
print ('El valor del empleado no es valido')
end
end

DECLARE @firstname nvarchar(10),
@lastname nvarchar(20)

EXEC sp_obtener_informacion_empleado @employeeid = 1,@nombre=@firstname output,@apellido=@lastname
print ('el nombre es: '+@firstname)
print ('el apellido es: '+@lastname)

create or alter proc sp_obtener_informacion_empleado2
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre as nvarchar(10) output
AS
begin

   DECLARE @existe int
   set @existe=(select count(*) from Employees where EmployeeID =@employeeid)
   -- select @existe = count(*) from Employees where EmployeeID =@employeeid
   

   IF @existe > 0
   begin
    Select @nombre = FirstName, @apellido=lastname
    from Employees
    where EmployeeID = @employeeid
   end
   else
   begin
   if @existe = 0
   begin
      print 'El id del empleado no existe'
   end
  end
end

-------------------------------------------------------------

declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec sp_obtener_informacion_empleado2
@nombre=@firstname output, @apellido = @lastname output

print ('El nombre es: ' + @firstname)
print ('El apellido es: ' + @lastname)
-------------------------------------------------------------

---- 2.- total de compras
create or alter procedure sp_obtener_ventas_por_cliente
@customerid nchar(5),
@fechainicial date,
@fechafinal date,
@total decimal(10,2) output
as

select @total=sum(od.UnitPrice*Quantity)
from [Order Details] as od
inner join orders as o
on od.OrderID=o.OrderID
where CustomerID=@customerid AND
OrderDate BETWEEN @fechainicial AND @fechafinal