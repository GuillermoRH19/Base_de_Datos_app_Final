use northwind

DECLARE @x INT
SET @x=10
print 'El valor de x es:'+ cast(@x as varchar)

if @x>=0
BEGIN
print 'el numero es positivo'
END
ELSE
BEGIN
print 'el numero es negativo'
END

DECLARE @i as INT
set @i=1
WHILE(@i<=10)
BEGIN
PRINT CAST(@i as varchar)
set @i=@i+1
end

DECLARE @i INT
set @i = 1

WHILE @i<=1
BEGIN
    PRINT 'El primer valor es: '+cast(@i as varchar)
    set @i=@i+1
    END

    --crear un sp

    ALTER PROCEDURE procedure_ciclo_
    @n1 as int,
    @n2 as int
    AS
    BEGIN
       DECLARE @suma INT
        set @suma = @n1+@n2

        print 'la suma es: ' + CAST(@suma as varchar)
        end

        exec procedure_ciclo_ 40,30

       WHILE @i<=1
        BEGIN
        PRINT 'El primer valor es: '+cast(@i as varchar)
        set @i=@i+1
       END

declare @ii int =1


while @ii<=2
BEGIN

exec procedure_ciclo_
set @ii=@ii+1
END

--Realizar un sp que sume dos numeros cualquiera y que imprima el resultado


    CREATE PROCEDURE procedure_ciclo_2
    as 
       DECLARE @y INT, @t int, @o INT
        set @y = 5 
        set @t=4
        BEGIN
         set @o=@y+@t
        PRINT 'La suma es: '+cast(@o as varchar)
       END

       exec procedure_ciclo_2
