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