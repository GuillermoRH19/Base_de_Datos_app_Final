--CREAR BASE DE DATOS PARA DEMOSTRAR EL USO DE LEFT JOIN

create database pruebajoins;

--Utilizamos la base de datos

use pruebajoins;

--CREAR TABLA CATEGORIAS

create table categoria(
    categoriaid int not null identity(1,1),
    nombre varchar(50) not null default 'no categoria',
    constraint pk_categoria
    primary key (categoriaid)
);

--CREAR LA TABLA PRODUCTO

create table producto(
    productoid int not null identity(1,1),
    nombre varchar(50) not null,
    existencia int not null,
    precio money not null,
    categoriaid int,
    constraint pk_producto
    primary key(productoid),
    constraint unico_nombrep
    unique(nombre),
    constraint fk_producto_categoria
    foreign key (categoriaid)
    references categoria(categoriaid)
);

--AGREGAR REGISTROS A LA TABLA CATEGORIA

insert into categoria(nombre)
values ('LB'),
       ('LACTEOS'),
       ('ROPA'),
       ('BEBIDAS'),
       ('CARNES FRIAS')

       select * from categoria

insert into producto (nombre,existencia,precio,categoriaid)
values ('REFRIGERADOR',3,10000.0,1),
       ('ESTUFA',3,9000.04,1),
       ('CREMA',2,10.5,2),
       ('YOGURT',3,13.45,2);

select * from producto

select * from producto as p
INNER JOIN categoria as c
on p.categoriaid=c.categoriaid;

select * from categoria as c
LEFT JOIN producto as p
on c.categoriaid=p.categoriaid;

select c.categoriaid, c.nombre from categoria as c
LEFT JOIN producto as p
on c.categoriaid=p.categoriaid
where p.productoid is null;

--RIGHT JOIN

select * from producto as p
RIGHT JOIN categoria as c
on p.categoriaid=c.categoriaid;

--FULL JOIN

select * from producto as p
FULL JOIN categoria as c
on p.categoriaid=c.categoriaid;

--EJERCICIO 

--1.CREAR UNA BASE DE DATOS LLAMADA EJERCICIOJOINS

create database ejerciciojoins

use ejerciciojoins

--2.CREAR UNA TABLA EMPLEADOS TOMANDO COMO BASE LA TABLA EMPLOYEES DE NORTHWIND(NO TOMAR TODOS LOS CAMPOS)

select top 0 EmployeeID as 'empleadoid',
CONCAT(FirstName,' ',LastName) as 'NombreCompleto',
title as 'titulo',
HireDate as 'FechaContratación'
into ejerciciojoins.dbo.empleados
from Northwind.dbo.Employees;

--3.LLENAR LA TABLA CON UNA CONSULTA A LA TABLA EMPLOYEES

insert into ejerciciojoins.dbo.empleados (NombreCompleto,titulo,FechaContratación)
select
CONCAT(FirstName,' ',LastName) as 'NombreCompleto',
title as 'titulo',
HireDate as 'FechaContratación'
from Northwind.dbo.Employees

select top 0 *
into ejerciciojoins.dbo.dimempleados
from ejerciciojoins.dbo.empleados

select * from dimempleados

select * from empleados

--4.AGREGAR NUEVOS DATOS A LA TABLA EMPLEADOS POR LO MENOS DOS

insert into ejerciciojoins.dbo.empleados(NombreCompleto,titulo,FechaContratación)
select
CONCAT(FirstName,' ',LastName) as 'NombreCompleto',
title as 'titulo',
HireDate as 'FechaContratación'
from ejerciciojoins.dbo.Employees


--5.ACTUALIZAR LA TABLA EMPEADOS CON LOS NUEVOS REGISTROS, LA CUAL SE LLENARAN EN UNA NUEVA TABLA LLAMADA DIM_PRODUCTO
