create database repasojoins;

use repasojoins;

create table proveedor(
     provid int not null identity(1,1),
     nombre varchar(50) not null,
     limite_credito money not null,
     constraint pk_proveedor
     primary key (provid)
)

create table producto(
    prodid int not null identity(1,1),
    nombre varchar(50) not null,
    existencia int not null,
    precio money not null,
    proveedor int,
    constraint pk_producto
    primary key (prodid),
    constraint fk_producto_proveedor
    foreign key (proveedor)
    references proveedor(provid)
)

--insertar datos en las tablas
insert into proveedor (nombre,limite_credito)
values('proveedor1',10000),
      ('proveedor2',20000),
      ('proveedor3',30000),
      ('proveedor4',40000),
      ('proveedor5',50000)

insert into producto(nombre,existencia,precio,proveedor)
values('producto1',54,45.6,1),
      ('producto2',54,45.6,1),
      ('producto3',54,45.6,2),
      ('producto4',54,45.6,3)

      select * from proveedor

      select * from producto

      --CONSULTAS INNER JOIN--

      --SELECCIONAR TODOS LOS PRODUCTOS QUE TENGAN PROVEEDOR

      select pr.nombre as 'Nombre_Producto', pr.precio as 'precio',
      pr.existencia as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      inner join producto as pr
      on p.provid=pr.proveedor

      --CONSULTA LEFT JOIN

      --MOSTRAR TODOS LOS PROVEEDORES Y SUS RESPECTIVOS PRODUCTOS

      select pr.nombre as 'Nombre_Producto', pr.precio as 'precio',
      pr.existencia as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      left join producto as pr
      on p.provid=pr.proveedor

      update proveedor
      set nombre = 'proveedor6'
      where provid = 5;

      select * from proveedor

      update proveedor
      set nombre = 'proveedor5'
      where provid = 5;

      insert into proveedor (nombre,limite_credito)
      values('proveedor6',45000)

      select * from proveedor

      delete from proveedor
      where provid = 7

      update proveedor
      set nombre = 'proveedor6'
      where provid = 6;

      --UTILIZANDO RIGHT JOIN

        select pr.nombre as 'Nombre_Producto', pr.precio as 'precio',
      pr.existencia as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      right join producto as pr
      on p.provid=pr.proveedor

      insert into producto(nombre,precio,existencia,proveedor)
      values('producto5',78.8,22,null)

      --FULL JOIN

       select pr.nombre as 'Nombre_Producto', pr.precio as 'precio',
      pr.existencia as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      full join producto as pr
      on p.provid=pr.proveedor

      --SELECCIONAR TODOS LOS PROVEEDORES QUE NO TIENEN ASIGNADO PRODUCTOS

       select p.provid as 'numero de proveedor', p.nombre as 'proveedor'
      from proveedor as p
      left join producto as pr
      on p.provid=pr.proveedor
      where pr.prodid is null

       select p.provid as 'numero de proveedor', p.nombre as 'proveedor'
      from proveedor as p
      left join producto as pr
      on p.provid=pr.proveedor
      where pr.prodid is not null

      --SELECCIONAR TODOS LOS PRODUCTOS QUE NO TIENEN PROVEEDOR

       select pr.nombre, pr.precio, pr.existencia 
      from proveedor as p
      right join producto as pr
      on p.provid=pr.proveedor
      where p.provid is null

      
