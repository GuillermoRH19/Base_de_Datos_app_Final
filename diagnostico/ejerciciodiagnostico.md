# Requerimientos
Una empresa encargada de las ventas de diferentes productos desea crear una base de datos que controles los proveedores, clientes, empleados, categorías de producto y órdenes de compra. Para los proveedores se necesita almacenar un numero de control, nombre de la empresa, dirección (numero, calle, colonia, estado), cp,teléfono, página web, teléfono de contacto o contactos del proveedor, nombre del contacto, email del contacto. Para los empleados se desea almacenar un numero de nómina, nombre completo del empleado, rfc, curp, salario (El salario máximo es de 65000), para las ordenes de compra se necesita almacenar la fecha de creación de la orden, el empleado que la realizo, al cliente que se le vende, la fecha de entrega y los diferentes productos que contiene. El producto debe almacenar un numero de control y una descripción única, status, existencia y un precio. La categoría debe tener un identificador y nombre único de categoría. La compra siempre debe tener un precio de venta que se obtiene del precio unitario del producto y una cantidad vendida.

# Diagrama E-R
![Diagrama Relacional](./img/bdventas.png)
# Diagrama Relacional

# Creación de BD con lenguaje SQL-LDD
```sql
--Crear base de datos
Create database bdventas
--Utilizar bd
use bdventas

/* Crear tabla Clientes */
Create table Cliente(
    clienteID int not null identity (1,1),
    rfc varchar(20) not null,
    curp varchar(18) not null,
    Nombre varchar(50) not null,
    Apellido1 varchar(50) not null,
    Apellido2 varchar(50) not null,
    constraint PK_Cliente
    Primary key(ClienteID),
    constraint unico_rfc
    unique(rfc),
    constraint unico_curp
    unique(curp)
    );

	/* Crear tabla Contacto */
create table ContactoProveedor(
ContactoId int not null identity(1,1),
ProveedorId int not null,
Nombres varchar (50) not null,
Apellido1 varchar(50)not null,
Apellido2 varchar(50)not null,
);

/* Crear tabla Proveedor */
create table Proveedor(
ProveedorId int not null identity(1,1),
nombreEmpresa varchar(50) not null,
RFC varchar(20) not null,
Calle varchar(50) not null,
Colonia varchar(50) not null,
CP varchar(50) not null,
PaginaWeb varchar(50) not null,
Constraint unique_nombreEmpresa unique (nombreEmpresa),
Constraint Pk_Proveedor primary key (ProveedorId),
);

alter table ContactoProveedor
add constraint fk_ContactoProveedor_proveedor
foreign key(proveedorid)
references Proveedor(proveedorid)

create table empleado(
empleadoid int not null identity(1,1),
nombre varchar(50) not null,
apellido1 varchar(50)not null,
apellido2 varchar(50)not null,
salario money not null,
numeronomina int not null,
rfc varchar(20) not null,
curp varchar(18) not null,
constraint pk_empleado
primary key (empleadoid),
constraint unico_rfc_empleado
unique(rfc),
constraint unico_curp_empleado
unique(curp),
constraint chk_salario
check (salario>0.0 and salario>=100000),
constraint unico_nomina_empleado
unique (numeronomina)
-- check (salario between 0.1 and 100000)
)

create table telefonoproveedor(
telefonoid int not null,
proveedorid int not null,
numerotelefono varchar(15),
constraint pk_telefono_proveedor
primary key (telefonoid,proveedorid),
constraint fk_telefonoprov_proveedor
foreign key(proveedorid)
references proveedor(proveedorid)
on delete cascade
on update cascade
)

create table producto(
numerocontrol int not null identity(1,1),
descripcion varchar(50) not null,
precio money not null,
[status] int not null,
existencia int not null,
proveedorid int not null,
constraint pk_producto
primary key(numerocontrol),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
check(precio between 1 and 200000),
constraint chk_status
-- status in (0,1)
check([status] = 1 or [status] = 0),
constraint chk_existencia
check(existencia>0),
constraint fk_producto_proveedor
foreign key (proveedorid)
references proveedor(proveedorid),
)

create table ordencompra(
numeroorden int not null identity,
fechacompra date not null,
fechaentrega date not null,
clienteid int not null,
empleadoid int not null,
constraint pk_ordencompra
primary key(numeroorden),
constraint fk_ordencompra_cliente
foreign key(clienteid)
references cliente(clienteid),
constraint fk_ordencompra_empleado
foreign key(empleadoid)
references empleado(empleadoid)
)

create table DetalleCompra (
    ProductoId int not null,
    numeroOrden int not null,
    cantidad int not null,
    preciocompra money not null,
   constraint pk_DetalleCompra_DetalleCompra  primary key (ProductoId,numeroOrden),
   constraint fk_DetalleCompra_numeroOrden foreign key (numeroOrden) references OrdenCompra(numeroOrden) ,
   constraint fk_DetalleCompra_Producto foreign key (ProductoId) references Producto(NumeroControl) 
);

```

#Llenar base de datos con lenguaje SQL-LMD

```sql
use [bdventas]

select * from [Northwind].dbo.customers
GO
select * from Cliente;
GO

-- Insertar varios clientes en una sola instrucci�n
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('hashashashas','RAHG050106HHGNRLA3','Alfreds Futterkiste','jsjhdn','Futterkiste')
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('SJSAJS','ATEG050106HHGNRLA3','Ana Trujillo Emparedados y heladosiste','KEKSKEK','FUER')
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('HASAJSAJ','AHRG16235HK1628J3','Antonio Moreno Taquer�a','HJSAK','KASKAKSL')
insert into cliente (rfc,curp,nombre,apellido1,apellido2)
values ('UEIREROE','EURIEOA183JSML4863','Around the Horn','KASLAS','JSJDSOA')
GO

-- Elimina los datos de la tabla cliente
delete from cliente
GO

-- Comando para reiniciar el identity de una tabla
DBCC CHECKIDENT (cliente, RESEED, 0)
GO

select top 0 EmployeeID as 'empleadoid', LastName as 'apellido', FirstName as 'nombre',BirthDate as
'fecha de nacimiento',HireDate as 'FechaContratacion', [Address] as 'direccion',
City as 'ciudad', Region, PostalCode as CodigoPostal,Country as 'pais' into empleado2 from Northwind.dbo.Employees
GO

--Insertar datos a partir de una consulta
drop table empleado2
GO

-- Altera una tabla agregandole un constraint de primary key
alter table empleado2
add constraint pk_empleado2
primary key (empleadoid)
GO

select top 5 * from Northwind.dbo.[Order Details]
order by OrderID desc
GO

select * from empleado2

insert into empleado2 (empleadoid,apellido,nombre,fechadenacimiento,fechacontratacion,direccion,ciudad,codigopostal,pais)
select EmployeeID as 'empleadoid',
LastName as 'apellido', 
FirstName as 'nombre',
BirthDate as 'fechadenacimiento',
HireDate as 'FechaContratacion',
[Address] as 'direccion',
City as 'ciudad', Region, PostalCode as CodigoPostal,Country as 'pais' from Northwind.dbo.Employees
´´´