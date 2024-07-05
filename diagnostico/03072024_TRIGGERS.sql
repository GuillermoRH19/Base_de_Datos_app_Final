--SINTAXIS DE TRIGGER
-- Create Trigger nombre_trigger
-- on nombre_tabla
-- after (insert,delete,update)
-- as
-- begin
-- .....codigo
-- end

/*
create trigger verificar_insercion_tabla1
on tabla1
after insert, update
as
begin
print 'se ejecuto el trigger en la tabla1'
end
*/

/*

*/

Create database pruebatriggersg3
go

use pruebatriggersg3

create table tabla1
(
id int not null primary key,
nombre varchar(50) not null
);
go

--TRIGGERS

--Trigger que verifica el evento que se ejecuto

create or alter trigger tg_verificar_insercion
on tabla1
after insert
as
begin
print 'se ejecuto el evento insert en la tabla 1'
end;

insert into tabla1
values (1,'nombre1')


--DELETE

create or alter trigger tg_verificar_delete
on tabla1
after Delete
as
begin
print 'se ejecuto el evento delete en la tabla 1'
end;

delete tabla1
where id=1

insert into tabla1
values(1,'Nombre1')

--UPDATE

create or alter trigger tg_verificar_update
on tabla1
after update
as
begin
print 'se ejecuto el evento update en la tabla 1'
end;

update tabla1
set nombre = 'Nombre nuevo'
where id=1

--BORRAR LOS TRIGGERS
drop trigger tg_verificar_insercion
drop trigger tg_verificar_delete
drop trigger tg_verificar_update

--CREAR NUEVO TRIGGER
create trigger verificar_contenido_inserted
on tabla1
after insert
as
begin
-- ver los datos de la tabla inserted
select * from inserted
end;

insert into tabla1
values (2,'Nombre2')

insert into tabla1
values (3,'Nombre3')

insert into tabla1
values (4,'Nombre4'), (5,'Nombre5')

-- USAMOS NORTHWIND

Use Northwind

Create or alter trigger tg_verificar_inserted_categories
on categories
after insert
as
begin
select categoryid,categoryname,[description] from inserted;
end

insert into categories (categoryname, description)
values ('CategoriaNueva','Prueba Triggers')


--UPDATE

begin transaction

--confirmar=commit
--cancelar=rollback

Create or alter trigger tg_verificar_update_categories
on categories
after update
as
begin
select categoryid,categoryname,[description] from inserted;
select categoryid,categoryname,[description] from deleted;
end


select * from categories

update categories
set categoryname = 'categoriaOtra',
[description] = 'si esta bien'
where categoryid=9

drop trigger tg_verificar_inserted_categories
drop trigger tg_verificar_update_categories

--NUEVO TRIGGER

CREATE or alter TRIGGER verificar_inserted_deleted
on categories
after insert,update,delete
as
begin
if exists(select 1 from inserted) and not exists(select 1 from deleted)
begin
print('Existen datos en la tabla inserted, se ejecuto un insert')
end

if exists(select 1 from deleted) and not exists(select 1 from inserted)
begin
print('Existen datos en la tabla delete, se realizo un delete')
end
else if exists(select 1 from deleted) and exists (select 1 from inserted)
begin
print ('Existen datos en las dos tablas, se realizo un update')
end

end;

insert into categories(categoryname,[description])
values ('categoria10','Pipon')

delete categories
where categoryname='categoria10'

update categories
set categoryname = 'categoriaOtra2',
[description] = 'ahora si esta bien'
where categoryid=9

select * from categories

DROP trigger verificar_inserted_deleted

/*CREAR UN TRIGGER EN LA BASE DE DATOS PRUEBATRIGGERSG3, PARA LA TABLA EMPLEADOS,
ESTE TRIGGER DEBE EVITAR QUE SE INSERTEN O MODIFIQUEN SALARIOS Myores a 50000*/

use pruebatriggersg3

create table empleado
(
id int not null primary key,
nombre varchar(50) not null,
salario money not null,
)

create or alter trigger verificar_salario
on empleado
after insert,update
as
begin
	if exists(select 1 from inserted) and not exists(select 1 from deleted)
	begin
		print('Existen datos en la tabla inserted, se ejecuto un insert')
	end

	declare @salarioNuevo money 
	set @salarioNuevo= (select salario from inserted)
	if @salarioNuevo>50000
	begin
		raiserror('El salario es mayor a 50000 y no esta permitido',16,1)
	rollback transaction
	end
end;

insert into empleado(id,nombre,salario)
values (1,'Nombre1',60000)