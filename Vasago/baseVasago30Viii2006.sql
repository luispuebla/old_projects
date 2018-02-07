# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;



USE `vasago`;

#
# Structure for the `bancos` table : 
#

DROP TABLE IF EXISTS `bancos`;

CREATE TABLE `bancos` (
  `clave` int(1) NOT NULL auto_increment,
  `numero` varchar(30) collate latin1_spanish_ci default NULL,
  `banco` varchar(100) collate latin1_spanish_ci default NULL,
  `importeInicial` double(8,2) default NULL,
  `importeActual` double(8,2) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `rfc` varchar(13) collate latin1_spanish_ci NOT NULL default '',
  `nombre` varchar(80) collate latin1_spanish_ci NOT NULL default '',
  `direccion` varchar(80) collate latin1_spanish_ci NOT NULL default '',
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(30) collate latin1_spanish_ci default NULL,
  `tipo` int(1) default NULL,
  `tel1` varchar(20) collate latin1_spanish_ci default NULL,
  `tel2` varchar(20) collate latin1_spanish_ci default NULL,
  `fax` varchar(20) collate latin1_spanish_ci default NULL,
  `email` varchar(80) collate latin1_spanish_ci default NULL,
  `diaCierran` int(1) default NULL,
  `horaComida` varchar(20) collate latin1_spanish_ci default NULL,
  `contacto` varchar(50) collate latin1_spanish_ci default NULL,
  `credito` double(8,2) default NULL,
  `pagoA` int(2) default NULL,
  `agente` varchar(8) collate latin1_spanish_ci default NULL,
  `alta` date default NULL,
  `activo` int(1) default '1',
  `saldoDisponible` double(8,2) default NULL,
  `bloqueoXPagoV` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `cobros` table : 
#

DROP TABLE IF EXISTS `cobros`;

CREATE TABLE `cobros` (
  `consecutivo` int(11) NOT NULL auto_increment,
  `claveVenta` int(11) default NULL,
  `claveCliente` varchar(13) collate latin1_spanish_ci default NULL,
  `fechaCobro` date default NULL,
  `monto` double(8,2) default NULL,
  `formaPago` int(1) default NULL,
  `observaciones` varchar(255) collate latin1_spanish_ci default NULL,
  `bancoCuenta` int(1) default NULL,
  `activo` int(1) default NULL,
  PRIMARY KEY  (`consecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `facturas` table : 
#

DROP TABLE IF EXISTS `facturas`;

CREATE TABLE `facturas` (
  `Clave_Orden` int(11) default NULL,
  `factura` varchar(11) collate latin1_spanish_ci default NULL,
  `fecha_factura` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `gastos` table : 
#

DROP TABLE IF EXISTS `gastos`;

CREATE TABLE `gastos` (
  `clave` int(8) NOT NULL auto_increment,
  `bancoCuenta` int(1) default NULL,
  `fecha` date default NULL,
  `concepto` varchar(100) collate latin1_spanish_ci default NULL,
  `importe` double(8,2) default NULL,
  `activo` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `ingresos` table : 
#

DROP TABLE IF EXISTS `ingresos`;

CREATE TABLE `ingresos` (
  `clave` int(8) NOT NULL auto_increment,
  `bancoCuenta` int(1) default NULL,
  `fecha` date default NULL,
  `concepto` varchar(100) collate latin1_spanish_ci default NULL,
  `importe` double(8,2) default NULL,
  `activo` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `linea` table : 
#

DROP TABLE IF EXISTS `linea`;

CREATE TABLE `linea` (
  `clave` char(3) collate latin1_spanish_ci default NULL,
  `nombre` varchar(20) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `marca` table : 
#

DROP TABLE IF EXISTS `marca`;

CREATE TABLE `marca` (
  `clave` char(3) collate latin1_spanish_ci default NULL,
  `nombre` varchar(40) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mermas` table : 
#

DROP TABLE IF EXISTS `mermas`;

CREATE TABLE `mermas` (
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `cantidad` double(8,3) default NULL,
  `fecha` date default NULL,
  `tipo` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `orden_compra` table : 
#

DROP TABLE IF EXISTS `orden_compra`;

CREATE TABLE `orden_compra` (
  `claveOrden` int(11) NOT NULL auto_increment,
  `claveProveedor` varchar(13) collate latin1_spanish_ci default NULL,
  `fecha` date default NULL,
  `fechaEntrega` date default NULL,
  `observaciones` varchar(250) collate latin1_spanish_ci default NULL,
  `descuento1` double(4,2) default NULL,
  `descuento2` double(4,2) default NULL,
  `descuento3` double(4,2) default NULL,
  `subtotal` double(8,2) default NULL,
  `descuento` double(8,2) default NULL,
  `iva` double(8,2) default NULL,
  `total` double(8,2) default NULL,
  `activo` int(1) default NULL,
  `factura` varchar(11) collate latin1_spanish_ci default NULL,
  `Entrega` int(1) default NULL,
  `usuario` varchar(8) collate latin1_spanish_ci default NULL,
  `pago` int(1) default NULL,
  PRIMARY KEY  (`claveOrden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `pagos` table : 
#

DROP TABLE IF EXISTS `pagos`;

CREATE TABLE `pagos` (
  `consecutivo` int(11) NOT NULL auto_increment,
  `claveOrden` int(11) default NULL,
  `claveProveedor` varchar(13) collate latin1_spanish_ci default NULL,
  `fechaPago` date default NULL,
  `monto` double(8,2) default NULL,
  `formaPago` int(1) default NULL,
  `numeroCheque` int(11) default NULL,
  `bancoCuenta` int(1) default NULL,
  `activo` int(1) default NULL,
  PRIMARY KEY  (`consecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 11264 kB';

#
# Structure for the `precio_anterior_producto` table : 
#

DROP TABLE IF EXISTS `precio_anterior_producto`;

CREATE TABLE `precio_anterior_producto` (
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `claveOrden` int(11) default NULL,
  `precioAnterior` double(8,2) default NULL,
  `precioCompra` double(8,2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `producto_obsequio` table : 
#

DROP TABLE IF EXISTS `producto_obsequio`;

CREATE TABLE `producto_obsequio` (
  `claveproducto` varchar(10) collate latin1_spanish_ci NOT NULL default '',
  `existencia` double(8,3) default NULL,
  PRIMARY KEY  (`claveproducto`),
  UNIQUE KEY `field1` (`claveproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos` table : 
#

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `linea` char(3) collate latin1_spanish_ci default NULL,
  `marca` char(3) collate latin1_spanish_ci default NULL,
  `tipo` int(1) default '1',
  `proveedor1` varchar(13) collate latin1_spanish_ci default NULL,
  `proveedor2` varchar(13) collate latin1_spanish_ci default NULL,
  `proveedor3` varchar(13) collate latin1_spanish_ci default NULL,
  `proveedor4` varchar(13) collate latin1_spanish_ci default NULL,
  `proveedor5` varchar(13) collate latin1_spanish_ci default NULL,
  `descripcion` varchar(100) collate latin1_spanish_ci default NULL,
  `costo` double(8,2) default NULL,
  `precio1` double(8,2) default NULL,
  `precio2` double(8,2) default NULL,
  `precio3` double(8,2) default NULL,
  `precio4` double(8,2) default NULL,
  `precio5` double(8,2) default NULL,
  `maximo` double(8,3) default NULL,
  `minimo` double(8,3) default NULL,
  `existencia` double(8,3) default NULL,
  `piezasXcaja` double(6,3) default NULL,
  `activo` int(1) default NULL,
  `iva` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 11264 kB';

#
# Structure for the `productos_orden` table : 
#

DROP TABLE IF EXISTS `productos_orden`;

CREATE TABLE `productos_orden` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` double(8,3) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` double(8,3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 11264 kB';

#
# Structure for the `productos_venta` table : 
#

DROP TABLE IF EXISTS `productos_venta`;

CREATE TABLE `productos_venta` (
  `claveVenta` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` double(8,3) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` double(8,3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `proveedores` table : 
#

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombre` varchar(100) collate latin1_spanish_ci default NULL,
  `direccion` varchar(50) collate latin1_spanish_ci default NULL,
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(30) collate latin1_spanish_ci default NULL,
  `tel1` varchar(20) collate latin1_spanish_ci default NULL,
  `tel2` varchar(20) collate latin1_spanish_ci default NULL,
  `fax` varchar(20) collate latin1_spanish_ci default NULL,
  `pagina` varchar(100) collate latin1_spanish_ci default NULL,
  `email` varchar(80) collate latin1_spanish_ci default NULL,
  `vendedor` varchar(50) collate latin1_spanish_ci default NULL,
  `formaPago` int(1) default NULL,
  `cuentas` text collate latin1_spanish_ci,
  `credito` double(8,2) default NULL,
  `diasPago` int(3) default NULL,
  `descuento1` double(8,2) default NULL,
  `descuento2` double(8,2) default NULL,
  `descuento3` double(8,2) default NULL,
  `saldoDisponible` double(8,2) default NULL,
  `alta` date default NULL,
  `activo` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `regalos_extras` table : 
#

DROP TABLE IF EXISTS `regalos_extras`;

CREATE TABLE `regalos_extras` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` double(8,3) default NULL,
  `Llego` double(8,3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `regalos_venta` table : 
#

DROP TABLE IF EXISTS `regalos_venta`;

CREATE TABLE `regalos_venta` (
  `claveVenta` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` double(8,3) default NULL,
  `Llego` double(8,3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `tempprodob` table : 
#

DROP TABLE IF EXISTS `tempprodob`;

CREATE TABLE `tempprodob` (
  `claveOrden` int(11) default NULL,
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `cantidad` double(8,3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `usuarios` table : 
#

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `ClaveU` varchar(8) collate latin1_spanish_ci NOT NULL default '',
  `Contrasena` varchar(8) collate latin1_spanish_ci NOT NULL default '',
  `Tipo` varchar(8) collate latin1_spanish_ci default NULL,
  `Nombre` varchar(30) collate latin1_spanish_ci default NULL,
  `APaterno` varchar(30) collate latin1_spanish_ci default NULL,
  `AMaterno` varchar(30) collate latin1_spanish_ci default NULL,
  `Puesto` varchar(30) collate latin1_spanish_ci default NULL,
  `Area` varchar(30) collate latin1_spanish_ci default NULL,
  `Estatus` char(1) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (`ClaveU`),
  UNIQUE KEY `ClaveU` (`ClaveU`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `ventas` table : 
#

DROP TABLE IF EXISTS `ventas`;

CREATE TABLE `ventas` (
  `claveVenta` int(11) NOT NULL auto_increment,
  `claveCliente` varchar(13) collate latin1_spanish_ci default NULL,
  `fechaAlta` date default NULL,
  `fechaEntrega` date default NULL,
  `observaciones` varchar(250) collate latin1_spanish_ci default NULL,
  `subtotal` double(8,2) default NULL,
  `iva` double(8,2) default NULL,
  `total` double(8,2) default NULL,
  `activo` int(1) default NULL,
  `tipo` int(1) default NULL,
  `factura` varchar(11) collate latin1_spanish_ci default NULL,
  `remision` int(11) default NULL,
  `Entrega` int(1) default NULL,
  `usuario` varchar(8) collate latin1_spanish_ci default NULL,
  `pago` int(1) default NULL,
  `repartidor` varchar(8) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (`claveVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

# rfc:253:1
# nombre:253:1
# direccion:253:1
# colonia:253:0
# delegacion:253:0
# cp:253:0
# ciudad:253:0
# tipo:3:32768
# tel1:253:0
# tel2:253:0
# fax:253:0
# email:253:0
# diaCierran:3:32768
# horaComida:253:0
# contacto:253:0
# credito:5:32768
# pagoA:3:32768
# agente:253:0
# alta:10:128
# activo:3:32768
# saldoDisponible:5:32768
# bloqueoXPagoV:3:32768

INSERT INTO `clientes` (`rfc`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tipo`, `tel1`, `tel2`, `fax`, `email`, `diaCierran`, `horaComida`, `contacto`, `credito`, `pagoA`, `agente`, `alta`, `activo`, `saldoDisponible`, `bloqueoXPagoV`) VALUES 
  ('MAPV601008RTA','Maldonado Villegas Patricia','Calle Canal de Apatlaco # G-75','Ejidos Del Moral','Iztapalapa','09040','Mexico D.F.',1,'56409887','','','',1,'','Rene Espinoza',0.00,0,'Piero','2006-06-07',0,0.00,0),
  ('DCN-040210NJO','Dinamica Comercial Nueva Orizaba S.A de C.V','Zona 1 Sector 1 Nave 1 bodega G 67 y 69','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'5694 2043','','','',7,'','Jose Luis Hernandez Saavedra',100000.00,10,'CHAVA','2006-06-07',0,100000.00,0),
  ('CLA-830615UC2','Comercializadora de Lacteos S.A de C.V.','Central de Abasto Iztapalapa G 93-95','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',3,'5694-1421','','','',7,'','Socorro  y  Federico',80000.00,6,'Piero','2006-06-07',0,80000.00,0),
  ('DCC-040210C48','Dinamica Comercial Central  S.A de C.V','Zona 1 Sector 1 Crujia 2 Local 118  CEDA','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',2,'','','','',7,'','Sergio  y  Alejandro',50000.00,10,'Piero','2006-06-07',0,50000.00,0),
  ('RARR7404053M1','Ramirez Rodriguez Roberto','Pasillo i j  Bodega 46','Ejidos del Moral','Iztapalapa','09310','Mexico D.F.',1,'5640-9230','','','',7,'','Roberto y Arturo',80000.00,10,'Piero1','2006-06-07',1,80000.00,0),
  ('GAAY8110197E3','Garcia Almanza Yashira Tahide','Andador el condor Mz N Lote 8','Heroes de Chapultepec','Gustavo A Madero','07930','Mexico D.F.',2,'5547-6693','','','',7,'','Isrrael y Arturo Garcia',40000.00,5,'Piero1','2006-06-07',1,40000.00,0),
  ('TEX931122JL3','La Texana S.A.de C.V','Bodega H 52 y H 54','Aculco','Central de abasto','09410','Mexico Distrito Federal.',3,'5600-2034','','','',7,'','Alejandro Bolanos y Alfredo Carreon',150000.00,10,'Piero1','2006-06-07',1,142932.00,0),
  ('CTC900503Q24','Cremeria Teresita de Central de Abasto S.A de C.V.','Zona 1 Sector 1 Nave1 Bodega G 39 y G 41','Central de Abastos','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Tomas y Sergio',250000.00,5,'Piero1','2006-06-07',1,246100.00,0),
  ('DCC040210C48','Dinamica Comercial Central S.A de C.V','Zona 1 Sector 1 Crujia 2 Local 118','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'','','','',7,'','Sergio  y Alejandro',80000.00,15,'Piero1','2006-06-07',1,80000.00,0),
  ('CLA830615UC2','Comercializadora De Lacteos S.A de C.V','Bodega G-93-95 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 1421','','','',7,'','Socorro y Federico',80000.00,10,'CHAVA','2006-06-07',1,46659.00,0),
  ('CSC880523NA1','Cremeria y Salchichoneria Cuadritos S.A de C. V.','Pasillo 2 Locs. 110 110A 112 114 116 letra G-H','Aculco','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Raul y David',200000.00,5,'CHAVA','2006-06-07',1,180350.00,0),
  ('MAVP601008RTA','Maldonado Villegas Patricia','Calle Canal de Apatlaco G75','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5640 9887','','','',7,'','Rene  Espinoza',150000.00,15,'Piero1','2006-06-07',1,134824.00,0),
  ('LSF050118U75','Lacteos San Fransisco de Asis S.de R.L de C.V','Canal de Apatlaco Zona 1 Sector 1 Nave 1 Bod. G3','Central de Abasto','Iztapalapa','09040','Mexico D.F',1,'5694 2235','','','',7,'','Chucho y Luis',100000.00,10,'Piero1','2006-06-07',1,19600.00,0),
  ('CSL0309122V5','Cremeria y Salchichoneria Lichus S.A. de C.V.','Bodega 58-59 Zona 1 Sector 1 Nave 3','Central de Abasto','iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','Fausto y el Abuelo',70000.00,10,'CHAVA','2006-06-07',1,51415.60,0),
  ('DCP040210S26','Dinamica Comercial Pastora s.a de C.V.','Pasillo 3 Local 52-53','ejidos del Moral','iztapalapa','09040','Mexico D.F.',2,'5694-3388','','','',7,'','Victor y Sergio',150000.00,15,'Piero','2006-06-07',0,150000.00,0),
  ('AEVJ741206QJ3','Avendano Villegas Jaime','Av.606-101 Agrup.A. Casa #56','San Juan de Aragon','Gustvo A. Madero','07950','Mexico D.F.',1,'','','','',7,'','Jaime',0.00,5,'Piero1','2006-06-08',1,0.00,0),
  ('CSJ871008UQ4','Cremeria San Jose  S.A .de C.V.','Bodega G 79 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Don Poncho  y  Jose Castillo',50000.00,7,'Piero1','2006-06-08',1,50000.00,0),
  ('FAVA670829598','Favian Veibar Artemio','Local G 50 Pasillo 3','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'56941403','','','',7,'','artemio y Ismael',50000.00,15,'Piero1','2006-06-08',1,50000.00,0),
  ('CSS850907851','Cremeria Y Salchichoneria La Suiza S.A.de C.V','Bodega G7 y G9 ZNA1 SEC1 NVE1','Central de Abasto','Iztapalapa','09040','Mexico D.F.',1,'56007583','','','',7,'','Celso y Lucio',80000.00,7,'CHAVA','2006-06-08',1,73770.00,0),
  ('CME9109236F1','Cotija Mercantil S.A deC.V','Zona 1 Sector 1 Nave 2 Bodega G 83','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 1448','','','',7,'','Fransisco y Miguel de la Parra',50000.00,8,'CHAVA','2006-06-08',1,50000.00,0),
  ('PAPE720521P11','De La Parra Portocarrero Elsa','G H 81 y 83','Central de Abasto','Iztapalapa','09040','Mexico D.F.',1,'56943066','','','',7,'','Pablo y Francisco',80000.00,8,'CHAVA','2006-06-08',1,73020.00,0),
  ('DPL871024KN8','Distribuidora de Productos Lacteos Chiluca S.A. de C.V.','Bodega G91 CEDA','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Rafa y Alfredo',50000.00,3,'Piero1','2006-06-08',1,50000.00,0),
  ('DCH040220NMA','Dinamica Comercial Higuera S.A de C.V.','Bodega H 52 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'5600 6809','','','',7,'','Leonardo yMonica',30000.00,15,'Piero1','2006-06-08',1,25155.80,0),
  ('HESJ501028FJ3','Jose Hernandez Saavedra','Bodega G 51 ZNA1SEC1NVE2','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'56942875','','','',7,'','Juan',60000.00,8,'CHAVA','2006-06-08',1,56192.50,0),
  ('CSH870328B82','Cremeria y Salchichoneria la Holandesa S.A de C.V.','Bodega G 5 Central de Abasto','Ejidos del Moral','Iztapalapa','09030','Mexico D.F',1,'5694 0823','','','',7,'','Gerarado y Enrique',100000.00,5,'CHAVA','2006-06-08',1,98000.00,0),
  ('HESJ440722S33','Jorge Hernandez Saavedra','P 1 Loc 29 A  CEDA','Aculco','Iztapalapa','09040','Mexico D.F.',1,'56942100','','','',7,'','Primo y Luis',100000.00,15,'CHAVA','2006-06-08',1,89181.70,0),
  ('AAGF740817Q38','Fransisco Salvador Alvares del Castillo Gudiño','Bodega G 19 Central de Abasto','Ejidos del Moral','Iztapalapa','09030','Mexico D.F.',2,'','','','',7,'','Paco y Hugo',40000.00,8,'Piero1','2006-06-08',1,27856.00,0),
  ('AAEF660414AJ1','Fernando Amador Espejo','Bodega G 79 A CEDA Iztapalapa','Ejidos del Moral','Iztapalapa','09030','Mexico D.F.',1,'56941397','','','',7,'','Luis y Alejandro',25000.00,3,'Piero1','2006-06-08',1,25000.00,0),
  ('DLE920309PEO','Distribuidora de Lacteos y Embutidos El Zarco','Pasillo 2 Local F 85','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Gerardo y Roberto',25000.00,0,'CHAVA','2006-06-08',1,25000.00,0),
  ('CDO9612105D9','Comercializadora el Dorado S.A. de C.V.','Bodega G 21 CEDA','Ejidos del Moral','Iztapalapa','09040',' Mexico D.F.',1,'','','','',7,'','Hazan',10000.00,3,'Piero1','2006-06-08',1,10000.00,0),
  ('AARZ770413CVA','Alcala Rivera Zeuz Avelino Baltazar','Zona1 Sector1 Nave 2 Bodega G 55','Urbana Ejidal','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Alcala  y  Zeuz',30000.00,8,'CHAVA','2006-06-08',1,30000.00,0),
  ('DCP000926455','Dinamica Comercial El Pato S.A de C.V.','Pas 2 Loc 138 entre I-J y G -H','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Jaime',15000.00,7,'CHAVA','2006-06-08',1,15000.00,0),
  ('CAS020724SE8','Consorcio de Alimentos san Salvador S.A. de C.V.','Pasillo 4 Anden I-J Local 133','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Camaron y Tono',60000.00,15,'CHAVA','2006-06-08',1,60000.00,0),
  ('RAPC670202135','Candelario Ramirez Pozos','Pasillo 3 E 32','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','Candido y Ana',150000.00,0,'piero 2','2006-06-08',1,150000.00,0),
  ('RAPC670202','Candelario Ramirez Pozos','Pasillo 3 Local E 32','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','',150000.00,15,'Piero','2006-06-08',0,150000.00,0),
  ('EDE0402134B7','Especialidades Deli S.A. de C.V.','Circuito F y L Pasillo 4 Crujia 1 Loc. 137-139','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 3118','','','',7,'','Pancho  y  Yair',80000.00,10,'CHAVA','2006-06-08',1,80000.00,0),
  ('JUPF7706198H0','Flor de Maria Juarez Paredes','Local 51 Pasillo 1 y 3','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 2403','','','',7,'','Tono y Beto',80000.00,15,'Piero1','2006-06-08',1,80000.00,0),
  ('Ramirez','Ramirez','central de abasto','ejidos del moral','iztapalapa','09040','Mexico D.F.',1,'5640 9230','','','',7,'','',80000.00,8,'Piero1','2006-06-14',1,60525.00,0),
  ('Teresita','Teresita','G 41','CEDA','iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Tomas',200000.00,8,'Piero1','2006-06-14',1,118919.00,0),
  ('Marga','Marga','G 15','CEDA','iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Tomas',100000.00,8,'CHAVA','2006-06-14',1,100000.00,0),
  ('Rigo','Rigo','G 1','CEDA','iztapalapa','09040','Mexico D.F.',1,'56407354','','','',7,'','Rigo',10000.00,3,'Piero1','2006-06-14',1,10000.00,0),
  ('Union','Union',' Pasillo 1 Local 3','CEDA','iztapalapa','09040','Mexico D.F.',1,'56009947','','','',7,'','Nicolas',50000.00,15,'Piero1','2006-06-14',1,42774.00,0),
  ('Chucho','Chucho','G 3','CEDA','Iztapalapa','09040','Mexico D.f.',1,'','','','',7,'','Chucho',50000.00,8,'CHAVA','2006-06-14',1,37445.00,0),
  ('Tapatio','Tapatio','G 15','CEDA','Iztapalapa','09040','Mexico D.F',1,'56407036','','','',7,'','Felipe',20000.00,5,'Piero1','2006-06-14',1,15600.00,0),
  ('Gea','Gea','G 19','CEDA','Iztapalapa','09030','Mexico D:F',1,'','','','',7,'','',50000.00,8,'Piero1','2006-06-14',1,50000.00,0),
  ('Normita','Normita','G 43','CEDA','Iztapalapa','09040','Mexico D:F.',1,'56948789','','','',7,'','Claudio',25000.00,5,'Piero1','2006-06-14',1,5110.00,0),
  ('Texana','Texana','H 52-54','Aculco','Iztapalapa','09410','Mexico D.F',1,'5600 2034','','','',7,'','Alfredo y  Alejandro',20000.00,8,'Piero1','2006-06-14',1,11212.00,0),
  ('Vanguardia','Vanguardia','G 61','CEDA','Iztapalapa','09040','Mexico D:F.',1,'5694 1459','','','',7,'','',40000.00,5,'CHAVA','2006-06-14',1,40000.00,0),
  ('Ranchito','Ranchito','G 79','CEDA','Iztapalapa','09040','Mexico D.F',1,'5694 1397','','','',7,'','Luis y Alejandro',25000.00,8,'Piero1','2006-06-14',1,3175.00,0),
  ('Especial','Especial','G 77','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 4692','','','',7,'','Ulises',150000.00,15,'Piero1','2006-06-14',1,76109.00,0),
  ('D`MargònZ','D`MargònZ','Local 51','CEDA','Iztapalapa','09040','Mexico D.F',1,'5694 2403','','','',7,'','Toño',40000.00,15,'Piero1','2006-06-14',1,40000.00,0),
  ('LA GUERA','LA GUERA','Pasillo 3 Loc. 50 G-H','CEDA','Iztapalapa','09040','Mexico D.F',1,'56941403','','','',7,'','Artemio',40000.00,15,'Piero','2006-06-14',0,40000.00,0),
  ('CHILUCA','CHILUCA','G 91','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Rafael',40000.00,3,'Piero1','2006-06-14',1,40000.00,0),
  ('Josè Manuel','Josè Manuel','G 87','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Josè Manuel',70000.00,15,'Piero1','2006-06-14',1,45965.00,0),
  ('SURTIDOR','SURTIDOR','Pasillo 3 Loc 25','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56002097','','','',7,'','Jose y Beto',70000.00,15,'Piero','2006-06-14',0,66055.60,0),
  ('Nueva Merced','Nueva Merced','Pasillo 3 Local 30','CEDA','Iztapalapa','09040','Mexico D.f',1,'','','','',7,'','Puebla',20000.00,3,'Piero1','2006-06-14',1,20000.00,0),
  ('ESPERANZA','ESPERANZA','Pasillo  3 Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56940435','','','',7,'','Pedro y Juana',130000.00,15,'Piero','2006-06-14',0,91008.90,0),
  ('Retoño','Retoño',' E 32 Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','Candido',150000.00,15,'Piero1','2006-06-14',1,132545.60,0),
  ('L # 45','L # 45',' Pasillo 3 Loc. 45','CEDA','Iatapalapa','09040','Mexico D.F.',1,'','','','',7,'','Sr. Jose',50000.00,15,'Piero1','2006-06-14',1,50000.00,0),
  ('Ruiseñor','Ruiseñor','Pasillo 3 Local  25','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 7263','','','',7,'','Bertha',20000.00,6,'Piero1','2006-06-14',1,13707.80,0),
  ('Esperanza','Esperanza','Pasillo 3 Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56940435','','','',7,'','Pedro y Juana',130000.00,15,'Piero1','2006-06-14',1,91008.90,0),
  ('Retoñito','Retoñito','Pasillo 3 Local 80','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5600 2607','','','',7,'','Rosa y Osbelia',150000.00,15,'CHAVA','2006-06-14',1,132893.80,0),
  ('Surtidor','Surtidor','Pasillo 3 Loc.','CEDA','Iztapalapa','09040','Mexico. D.F.',1,'56002097','','','',7,'','Jose y Beto',70000.00,15,'Piero1','2006-06-14',1,66055.60,0),
  ('Yoely','Yoely','Pasillo 3 Local 78','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Alma y Elizabeth',50000.00,15,'CHAVA','2006-06-14',1,37645.50,0),
  ('La Guera','La Guera','Pasillo 3 Loc 50 G-H','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56941403','','','',7,'','Artemio',40000.00,15,'Piero1','2006-06-14',1,40000.00,0),
  ('Lupita','Lupita','Pasillo 4  Local 124','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 3118','','','',7,'','Panchito',70000.00,10,'CHAVA','2006-06-14',1,50387.00,0),
  ('Super Palmas','Super Palmas','Pasillo I-J Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Meliton',20000.00,8,'CHAVA','2006-06-14',1,20000.00,0),
  ('Erik','Erik','I - J','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Erik',2000.00,3,'CHAVA','2006-06-19',1,1072.00,0),
  ('Bonanza','Bonanza','i - j  pasillo 5','CEDA','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Memo y Ivan',30000.00,5,'CHAVA','2006-06-19',1,19000.00,0),
  ('Max','Max','I-61  entre pasillo 2 y 3','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Max',5000.00,2,'Piero1','2006-06-19',1,5000.00,0),
  ('Laura','Laura','Pasillo 1  g-h','CEDA','Iztapalapa','09040','Mexico D.F',3,'','','','',7,'','Alfredo',40000.00,8,'CHAVA','2006-06-19',1,38553.00,0),
  ('Perico','Perico','Av. Riva Palacio','Neza','Neza','000','Mexico D.F.',3,'','','','',7,'','Pedro',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Rosa de oro','Rosa de oro','Pasillo 1 g-h','CEDA','Iztapalapa','09040','Mexico D.F.',5,'5694 8111','','','',7,'','Javier',20000.00,8,'CHAVA','2006-06-19',1,17453.00,0),
  ('Juan Munoz','Juan Munoz','Chalco','Chalco','Edo.Mex.','000','Edo. Mex.',1,'59751692','','','',7,'','Juan Munoz',40000.00,6,'Piero1','2006-06-19',1,23632.00,0),
  ('Palomas','Palomas','E- F Pasillo 2','CEDA','Iztapalapa','09040','Mexico D.F.',3,'5694 6529','','','',7,'','Beto',50000.00,8,'Piero1','2006-06-19',1,50000.00,0),
  ('Alfredo','Alfredo','Altamirano Guerrero','Altamirano Guerrero','Guerrero','000','Guerrero',3,'0176 76726774','','','',7,'','Alfredo',40000.00,5,'Piero1','2006-06-19',1,40000.00,0),
  ('Jorge Montoya','Jorge Montoya','Neza','Neza','Edo. Mexico','000','Edo. Mexico.',3,'','','','',7,'','Jorge Montoya',15000.00,10,'Piero1','2006-06-19',1,15000.00,0),
  ('Barca','Barca','O-P  Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F.',3,'5694 5586','','','',7,'','Josè Luis',15000.00,3,'Piero1','2006-06-19',1,10624.00,0),
  ('Trinidad','Jose Trinidad','Tlaxcala','Tlaxcala','Tlaxcala','000','Tlaxcala',3,'','','','',7,'','Jose Trinidad',40000.00,3,'Piero1','2006-06-19',1,40000.00,0),
  ('Juan Zepeda','Juan Zepeda','I-61','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Juan Zepada',1000.00,2,'Piero1','2006-06-19',1,1000.00,0),
  ('Rojas','Rojas','Pasillo 3   I-J','Ceda','Iztapalapa','09040','Mexico D.F',3,'','','','',7,'','Rojas',1000.00,0,'Piero1','2006-06-19',1,1000.00,0),
  ('Nochistlan','Nochistlan','O -P Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F',5,'','','','',7,'','Nochistlan',1000.00,0,'Piero1','2006-06-19',1,926.00,0),
  ('El Pico de O','El Pico De Orizaba','S-T  Pasillo 4','Ceda','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','',5000.00,0,'Piero1','2006-06-19',1,5000.00,0),
  ('Yony','Yony','Neza','Neza','Neza','000','Mexico D.F.',3,'','','','',7,'','Yony',2000.00,0,'Piero1','2006-06-19',1,2000.00,0),
  ('Mundo','Mundo','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Mundo',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Paty','Paty','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Paty',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Alejandro','Alejandro','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Alejandro',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Sr. Zarco','Sr. Zarco','Texcoco','Texcoco','Edo. Mexico','000','Edo. Mexico',3,'56800428','','','',7,'','Sr. Zarco',30000.00,10,'Piero1','2006-06-19',1,30000.00,0),
  ('Mario','Mario Figueroa','Taxco','Taxco','Taxco','000','Taxco Guerrero',1,'','','','',7,'','Mario Figueroa',30000.00,8,'Piero1','2006-07-13',1,30000.00,0),
  ('Israel','Israel Melchor','Desconocida','Desconocida','Desconocida','000','Mexico D.F',1,'','','','',7,'','Israel',0.00,0,'Piero1','2006-07-13',1,0.00,0),
  ('Rene','Rene','Bodega G-75','CEDA','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','',50000.00,10,'Piero1','2006-07-13',1,50000.00,0),
  ('DCP040210F26','Dinamica Comercial Pastora S.A de C.V.','Pasillo 3 locales 52-53','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',5,'','','','',7,'','Victor',115000.00,15,'Piero1','2006-07-17',1,111540.00,0),
  ('DCS0402101N9','Dinamica comercial soledad,S.A. DE C.V.','Pasillo 2 local 198-200-202- KL','Col. Ejidos del Moral','Iztapalapa','09040','Mexico,D.F.',5,'','','','',7,'','Pepe',20000.00,5,'CHAVA','2006-07-19',1,20000.00,0),
  ('DCL0402164N0','Deinne Club,S.A.DEC.V.','Guanajuato No.240 Int.1','Roma','Cuahutemoc','06700','Mexico,D.F.',1,'57119706','','','',7,'','',40000.00,5,'Piero1','2006-07-19',1,40000.00,0),
  ('DCP040210J5A',' Dinamica Comercial Parroquia,S.A.DE C.V.','Pasillo 2 Local  128','Ejidos del Moral','Iztapalapa','09040','Mexico,D.F.',3,'56942355','','','',7,'','PEPE',20000.00,5,'CHAVA','2006-07-19',1,11715.00,0),
  ('Rancherita','La Rancherita','Pasillo 4','Ejidos Del Moral','Iztapalapa','09040','Mexico,D.F.',3,'56009548','','','',7,'','',40000.00,10,'CHAVA','2006-07-19',1,37525.00,0),
  ('melo','melo','melo','melo','melo','000','mexico',3,'','','','',7,'','melo',10000.00,3,'Piero1','2006-08-02',1,15420.00,0),
  ('toro','toro','toro','toro','toro','000','mexico',5,'','','','',7,'','toro',100.00,0,'Piero1','2006-08-02',1,100.00,0),
  ('Moro','Moro','Moro','Moro','Moro','09040','Mexico D.F.',3,'','','','',7,'','Moro',40000.00,8,'Piero1','2006-08-02',1,40000.00,0),
  ('DCP040210NJO','Dinamica Comercial Parroquia S.A de C.V','Central de Abasto Local 128 Pasillo 2','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','Laura',10000.00,0,'CHAVA','2006-08-02',0,10000.00,0),
  ('DCN040210NJO','Dinamica Comercial Nueva Orizaba S.A de C.V','Central de Abasto G 67 y 69','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','Pepe',50000.00,8,'Piero1','2006-08-02',1,35325.00,0),
  ('Galdino','Galdino','mexico','emexico','mexico','000','Mexico',1,'','','','',7,'','',20000.00,4,'Piero1','2006-08-03',1,20000.00,0),
  ('celestino','celestino','ceda','ceda','iztapalapa','09040','mexico',3,'','','','',7,'','',7000.00,5,'Piero1','2006-08-03',1,4816.00,0),
  ('DMA0106263S9','Distribuidora Marga S.A de C.V','Zona 1 sector 1 nave1','central de abasto','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Tomas',80000.00,8,'CHAVA','2006-08-03',1,80000.00,0),
  ('Yovany','Yovany','ceda','ceda','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Yovany',0.00,1,'Piero1','2006-08-04',1,0.00,0),
  ('Conan','Conan','ceda','ceda','Iztapalapa','09040','Mexico D.F',3,'','','','',1,'','conan',0.00,0,'Piero1','2006-08-05',1,0.00,0),
  ('Che','Che','CEDA','Iztapalapa','Iztapalapa','09040','Mexico  D.F.',4,'','','','',1,'','',0.00,0,'Piero1','2006-08-29',1,0.00,0),
  ('GALP','Garcia Perez Jose Luis','Bodega G75  CEDA  Iztapalapa','Ejidos Del Moral','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','moro',0.00,8,'Piero1','2006-08-29',0,0.00,0),
  ('GALP601011M59','Garcia Perez Jose Luis','Bodega G 75 CEDA Iztapalapa','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','',0.00,8,'piero 2','2006-08-29',1,-7014.40,0),
  ('DEMA640807PB5','Delfino Montiel Alfredo','Mercado Lazaro Cardenas L  101','C.D Altamirano Guerrero','Altamirano Guerrero','0000','C.D. Altamirano Guerrero',4,'','','','',7,'','Alfredo',50000.00,10,'Piero1','2006-08-30',1,32751.00,0),
  ('PLV0501201N3','Productos Lacteos Vanguardia S de R L de C.V.','Zona 1 Sector 1 Nave 2 Bodega G 61','Central de Abasto','Iztapalapa','09040','Mexico D.F.',3,'5694 1459','','','',7,'','Hugo',50000.00,5,'CHAVA','2006-08-31',1,40000.00,0);

COMMIT;

#
# Data for the `cobros` table  (LIMIT 0,500)
#

# consecutivo:3:49667
# claveVenta:3:32768
# claveCliente:253:0
# fechaCobro:10:128
# monto:5:32768
# formaPago:3:32768
# observaciones:253:0
# bancoCuenta:3:32768
# activo:3:32768

INSERT INTO `cobros` (`consecutivo`, `claveVenta`, `claveCliente`, `fechaCobro`, `monto`, `formaPago`, `observaciones`, `bancoCuenta`, `activo`) VALUES 
  (1,4,'Che','2006-08-29',345.00,1,'',0,1),
  (2,5,'Yovany','2006-08-29',358.00,1,'',0,1),
  (3,6,'Retoño','2006-08-29',13442.00,1,'',0,1),
  (4,1,'Barca','2006-08-29',440.00,1,'',0,1),
  (5,21,'Barca','2006-08-29',168.00,1,'',0,1),
  (6,31,'GAAY8110197E3','2006-08-29',31192.00,1,'',0,1),
  (7,33,'Nochistlan','2006-08-29',157.00,1,'',0,1),
  (8,35,'AEVJ741206QJ3','2006-08-29',3152.00,1,'',0,1),
  (9,36,'Nochistlan','2006-08-29',62.00,1,'',0,1),
  (10,13,'Erik','2006-08-30',363.00,1,'',0,1),
  (11,18,'Esperanza','2006-08-30',1500.00,1,'',0,1),
  (12,45,'Juan Zepeda','2006-08-30',62.50,1,'',0,1),
  (13,41,'melo','2006-08-30',7000.00,1,'',0,1),
  (14,48,'melo','2006-08-30',7000.00,1,'',0,1),
  (15,49,'Che','2006-08-30',136.00,1,'',0,1),
  (16,42,'TEX931122JL3','2006-08-30',13900.00,1,'',0,1),
  (17,58,'Alfredo','2006-08-30',14620.00,1,'',0,1),
  (18,62,'DEMA640807PB5','2006-08-30',5380.00,1,'',0,1),
  (19,77,'Esperanza','2006-08-30',1500.00,1,'',0,1),
  (20,9,'Ranchito','2006-08-30',1680.00,1,'',0,1),
  (21,10,'Normita','2006-08-30',3225.00,1,'',0,1),
  (22,38,'DCP040210F26','2006-08-30',1027.00,1,'',0,1),
  (23,74,'Erik','2006-08-30',660.00,1,'',0,1),
  (24,46,'CSS850907851','2006-08-30',11120.00,1,'',0,1),
  (25,89,'AEVJ741206QJ3','2006-08-30',5639.00,1,'',0,1);

COMMIT;

#
# Data for the `facturas` table  (LIMIT 0,500)
#

# Clave_Orden:3:32768
# factura:253:0
# fecha_factura:10:128

INSERT INTO `facturas` (`Clave_Orden`, `factura`, `fecha_factura`) VALUES 
  (2,'41659','2006-08-29'),
  (6,'7471','2006-08-30');

COMMIT;

#
# Data for the `gastos` table  (LIMIT 0,500)
#

# clave:3:49667
# bancoCuenta:3:32768
# fecha:10:128
# concepto:253:0
# importe:5:32768
# activo:3:32768

INSERT INTO `gastos` (`clave`, `bancoCuenta`, `fecha`, `concepto`, `importe`, `activo`) VALUES 
  (1,0,'2006-08-29','Pago a la Compra #2',149867.76,1),
  (2,0,'2006-08-29','Pago a la Compra #3',50440.00,1),
  (3,0,'2006-08-30','Pago a la Compra #5',55208.00,1),
  (4,0,'2006-08-30','Pago a la Compra #8',83027.17,1),
  (5,0,'2006-08-30','Pago a la Compra #9',19000.00,0),
  (6,0,'2006-08-31','Pago a la Compra #7',4476.00,1),
  (7,0,'2006-08-31','Pago a la Compra #6',14920.00,1),
  (8,0,'2006-08-31','Pago a la Compra #10',35044.26,1);

COMMIT;

#
# Data for the `ingresos` table  (LIMIT 0,500)
#

# clave:3:49667
# bancoCuenta:3:32768
# fecha:10:128
# concepto:253:0
# importe:5:32768
# activo:3:32768

INSERT INTO `ingresos` (`clave`, `bancoCuenta`, `fecha`, `concepto`, `importe`, `activo`) VALUES 
  (1,0,'2006-08-29','Cobro de la Venta #4',345.00,1),
  (2,0,'2006-08-29','Cobro de la Venta #5',358.00,1),
  (3,0,'2006-08-29','Cobro de la Venta #6',13442.00,1),
  (4,0,'2006-08-29','Cobro de la Venta #1',440.00,1),
  (5,0,'2006-08-29','Cobro de la Venta #21',168.00,1),
  (6,0,'2006-08-29','Cobro de la Venta #31',31192.00,1),
  (7,0,'2006-08-29','Cobro de la Venta #33',157.00,1),
  (8,0,'2006-08-29','Cobro de la Venta #35',3152.00,1),
  (9,0,'2006-08-29','Cobro de la Venta #36',62.00,1),
  (10,0,'2006-08-30','Cobro de la Venta #13',363.00,1),
  (11,0,'2006-08-30','Cobro de la Venta #18',1500.00,1),
  (12,0,'2006-08-30','Cobro de la Venta #45',62.50,1),
  (13,0,'2006-08-30','Cobro de la Venta #41',7000.00,1),
  (14,0,'2006-08-30','Cobro de la Venta #48',7000.00,1),
  (15,0,'2006-08-30','Cobro de la Venta #49',136.00,1),
  (16,0,'2006-08-30','Cobro de la Venta #42',13900.00,1),
  (17,0,'2006-08-30','Cobro de la Venta #58',14620.00,1),
  (18,0,'2006-08-30','Cobro de la Venta #62',5380.00,1),
  (19,0,'2006-08-30','Cobro de la Venta #77',1500.00,1),
  (20,0,'2006-08-30','Cobro de la Venta #9',1680.00,1),
  (21,0,'2006-08-30','Cobro de la Venta #10',3225.00,1),
  (22,0,'2006-08-30','Cobro de la Venta #38',1027.00,1),
  (23,0,'2006-08-30','Cobro de la Venta #74',660.00,1),
  (24,0,'2006-08-30','Cobro de la Venta #46',11120.00,1),
  (25,0,'2006-08-30','Cobro de la Venta #89',5639.00,1);

COMMIT;

#
# Data for the `linea` table  (LIMIT 0,500)
#

# clave:254:0
# nombre:253:0

INSERT INTO `linea` (`clave`, `nombre`) VALUES 
  ('lec','leche'),
  ('yog','yogurth'),
  ('mar','margarina'),
  ('man','mantequillas'),
  ('nar','naranjadas'),
  ('tos','tostadas'),
  ('pos','postre'),
  ('cre','crema'),
  ('gel','gelatina'),
  ('beb','bebida'),
  ('que','queso'),
  ('cho','chorizo'),
  ('hue','huevo'),
  ('jam','jamon'),
  ('Pal','Palomitas');

COMMIT;

#
# Data for the `marca` table  (LIMIT 0,500)
#

# clave:254:0
# nombre:253:0

INSERT INTO `marca` (`clave`, `nombre`) VALUES 
  ('lal','lala'),
  ('alp','alpura'),
  ('ibe','iberia'),
  ('chi','chipilo'),
  ('dan','danone'),
  ('cha','charra'),
  ('car','carioca'),
  ('ama','amarillo'),
  ('bon','bonafina'),
  ('ran','rancherita'),
  ('man','manchego'),
  ('rio','riojano'),
  ('gal','galicia'),
  ('bac','bachoco'),
  ('cot','cotija'),
  ('gin','gina'),
  ('raa','rancherito'),
  ('lca','lcastel'),
  ('pri','primavera chantilly'),
  ('fru','frutsy'),
  ('gen','generosa'),
  ('bot','botellin'),
  ('new','new mix'),
  ('Act','Act II');

COMMIT;

#
# Data for the `orden_compra` table  (LIMIT 0,500)
#

# claveOrden:3:49667
# claveProveedor:253:0
# fecha:10:128
# fechaEntrega:10:128
# observaciones:253:0
# descuento1:5:32768
# descuento2:5:32768
# descuento3:5:32768
# subtotal:5:32768
# descuento:5:32768
# iva:5:32768
# total:5:32768
# activo:3:32768
# factura:253:0
# Entrega:3:32768
# usuario:253:0
# pago:3:32768

INSERT INTO `orden_compra` (`claveOrden`, `claveProveedor`, `fecha`, `fechaEntrega`, `observaciones`, `descuento1`, `descuento2`, `descuento3`, `subtotal`, `descuento`, `iva`, `total`, `activo`, `factura`, `Entrega`, `usuario`, `pago`) VALUES 
  (1,'UNI9704247M2','2006-08-29','2006-08-29','',0.00,0.00,0.00,69523.60,69523.60,0.00,69523.60,1,'35425',2,'bety',0),
  (2,'MEG0202151X5','2006-08-29','2006-08-29','',0.00,0.00,0.00,149867.76,149867.76,0.00,149867.76,1,'p',2,'bety',2),
  (3,'Galdino','2006-08-29','2006-08-29','',0.00,0.00,0.00,50440.00,50440.00,0.00,50440.00,1,'s/n',2,'bety',2),
  (4,'MEG0202151X5','2006-08-29','2006-08-29','',0.00,0.00,0.00,17768.00,17768.00,0.00,17768.00,0,'0',0,'piero',0),
  (5,'Galdino','2006-08-30','2006-08-30','',0.00,0.00,0.00,55208.00,55208.00,0.00,55208.00,1,'s/n',2,'bety',2),
  (6,'CLD0507145H6','2006-08-30','2006-08-30','',0.00,0.00,0.00,14920.00,14920.00,0.00,14920.00,1,'7471',2,'bety',2),
  (7,'CLD0507145H6','2006-08-30','2006-08-30','',0.00,0.00,0.00,4476.00,4476.00,0.00,4476.00,1,'7511',2,'bety',2),
  (8,'Ricardo','2006-08-30','2006-08-30','',0.00,0.00,0.00,83027.17,83027.17,0.00,83027.17,1,'s/n',2,'bety',2),
  (9,'Carioca','2006-08-30','2006-08-30','',0.00,0.00,0.00,19000.00,19000.00,0.00,19000.00,1,'2117',2,'bety',1),
  (10,'Ricardo','2006-08-31','2006-08-31','',0.00,0.00,0.00,35044.26,35044.26,0.00,35044.26,1,'s/n',2,'bety',2),
  (11,'TNI920507GB8','2006-08-31','2006-08-31','',0.00,0.00,0.00,21816.00,21816.00,0.00,21816.00,1,'PEND',2,'bety',0),
  (12,'MEG0202151X5','2006-08-31','2006-08-31','',0.00,0.00,0.00,158733.32,158733.32,0.00,158733.32,1,'PEND',1,'bety',0),
  (13,'Texana','2006-08-31','2006-08-31','',0.00,0.00,0.00,75400.00,75400.00,0.00,75400.00,1,'0200',2,'bety',0);

COMMIT;

#
# Data for the `pagos` table  (LIMIT 0,500)
#

# consecutivo:3:49667
# claveOrden:3:32768
# claveProveedor:253:0
# fechaPago:10:128
# monto:5:32768
# formaPago:3:32768
# numeroCheque:3:32768
# bancoCuenta:3:32768
# activo:3:32768

INSERT INTO `pagos` (`consecutivo`, `claveOrden`, `claveProveedor`, `fechaPago`, `monto`, `formaPago`, `numeroCheque`, `bancoCuenta`, `activo`) VALUES 
  (1,2,'MEG0202151X5','2006-08-29',149867.76,1,0,0,1),
  (2,3,'Galdino','2006-08-29',50440.00,1,0,0,1),
  (3,5,'Galdino','2006-08-30',55208.00,1,0,0,1),
  (4,8,'Ricardo','2006-08-30',83027.17,1,0,0,1),
  (5,9,'Carioca','2006-08-30',19000.00,2,0,0,1),
  (6,7,'CLD0507145H6','2006-08-31',4476.00,2,0,0,1),
  (7,6,'CLD0507145H6','2006-08-31',14920.00,2,0,0,1),
  (8,10,'Ricardo','2006-08-31',35044.26,1,0,0,1);

COMMIT;

#
# Data for the `precio_anterior_producto` table  (LIMIT 0,500)
#

# claveProducto:253:0
# claveOrden:3:32768
# precioAnterior:5:32768
# precioCompra:5:32768

INSERT INTO `precio_anterior_producto` (`claveProducto`, `claveOrden`, `precioAnterior`, `precioCompra`) VALUES 
  ('crealp02',3,257.11,260.00),
  ('crealp03',3,257.11,260.00),
  ('crealp02',5,260.00,268.00),
  ('crealp03',5,260.00,268.00),
  ('crelal04',6,304.00,298.40),
  ('crelal04',6,301.20,298.40),
  ('crelal04',7,299.80,298.40),
  ('crealp01',8,114.70,115.19),
  ('crealp02',8,264.00,261.00),
  ('crealp03',8,264.00,261.00),
  ('crealp01',10,114.95,113.53),
  ('crealp02',10,262.50,261.00);

COMMIT;

#
# Data for the `producto_obsequio` table  (LIMIT 0,500)
#

# claveproducto:253:16391
# existencia:5:32768

INSERT INTO `producto_obsequio` (`claveproducto`, `existencia`) VALUES 
  ('yogdan05',63.000);

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

# claveProducto:253:0
# linea:254:0
# marca:254:0
# tipo:3:32768
# proveedor1:253:0
# proveedor2:253:0
# proveedor3:253:0
# proveedor4:253:0
# proveedor5:253:0
# descripcion:253:0
# costo:5:32768
# precio1:5:32768
# precio2:5:32768
# precio3:5:32768
# precio4:5:32768
# precio5:5:32768
# maximo:5:32768
# minimo:5:32768
# existencia:5:32768
# piezasXcaja:5:32768
# activo:3:32768
# iva:3:32768

INSERT INTO `productos` (`claveProducto`, `linea`, `marca`, `tipo`, `proveedor1`, `proveedor2`, `proveedor3`, `proveedor4`, `proveedor5`, `descripcion`, `costo`, `precio1`, `precio2`, `precio3`, `precio4`, `precio5`, `maximo`, `minimo`, `existencia`, `piezasXcaja`, `activo`, `iva`) VALUES 
  ('leclal01','lec','lal',1,'Ricardo','0','0','0','0','Leche Entera Tetrapac',95.00,98.00,100.00,101.00,103.00,103.00,200.000,50.000,0.000,12.000,1,0),
  ('crealp01','cre','alp',1,'Joaquin','Ricardo','0','0','0',' acida 250 gr.',114.24,116.00,116.80,117.00,117.00,117.00,800.000,50.000,0.000,24.000,1,0),
  ('yogalp01','yog','alp',1,'Joaquin','Calderon','0','0','0','de200gr',59.00,60.00,60.50,61.00,61.50,62.50,1500.000,50.000,1.000,0.000,1,0),
  ('crealp02','cre','alp',1,'Joaquin','Ricardo','0','0','0',' acida 450 gr.',261.75,260.00,261.80,262.00,278.00,275.00,600.000,50.000,0.000,0.000,1,0),
  ('crealp03','cre','alp',1,'Galdino','Ricardo','0','0','0',' acida 900gr.',262.50,260.00,261.80,262.00,275.00,278.00,250.000,50.000,0.000,0.000,1,0),
  ('toscha01','tos','cha',1,'TNI920507GB8','0','0','0','0','con 18 pz',145.44,147.50,148.00,149.00,150.00,150.00,1500.000,50.000,280.000,18.000,1,0),
  ('toscar01','tos','car',1,'Carioca','0','0','0','0','con 24pz',95.00,100.00,100.00,100.00,100.00,100.00,400.000,10.000,0.000,24.000,1,0),
  ('yogdan01','yog','dan',1,'MEG0202151X5','0','0','0','0','fruix con cereal 151gr',89.80,90.00,92.00,93.00,95.00,95.00,600.000,50.000,17.000,24.000,1,0),
  ('yogdan02','yog','dan',1,'MEG0202151X5','0','0','0','0','danonino para beber 100gr',75.07,81.00,100.00,102.00,102.00,102.00,100.000,10.000,13.000,25.000,1,0),
  ('yogdan03','yog','dan',1,'MEG0202151X5','0','0','0','0','dan-up 250gr',125.47,129.00,130.00,131.00,132.00,143.00,1500.000,150.000,246.000,0.000,1,0),
  ('yogdan04','yog','dan',1,'MEG0202151X5','0','0','0','0','licuado250gr',146.16,158.00,158.00,158.00,158.00,158.00,10.000,2.000,0.000,28.000,1,0),
  ('yogdan05','yog','dan',1,'MEG0202151X5','0','0','0','0','danonino  180gr',177.68,181.00,182.00,183.00,184.00,184.00,2000.000,150.000,740.000,24.000,1,0),
  ('geldan01','gel','dan',1,'MEG0202151X5','0','0','0','0','dany sabores 125gr',106.43,112.00,113.00,115.00,115.00,115.00,300.000,30.000,96.000,48.000,1,0),
  ('posdan01','pos','dan',1,'MEG0202151X5','0','0','0','0','danette natilla 200gr',125.28,130.00,133.00,133.00,133.00,133.00,30.000,5.000,11.000,24.000,1,0),
  ('yogdan06','yog','dan',1,'MEG0202151X5','0','0','0','0','vitalinea para beber 250gr',156.51,168.00,168.00,168.00,168.00,169.00,60.000,10.000,21.000,0.000,1,0),
  ('yogdan07','yog','dan',1,'MEG0202151X5','0','0','0','0','vitalinea solido 150gr',179.61,190.00,190.00,190.00,190.00,190.00,5.000,2.000,0.000,48.000,1,0),
  ('yogdan08','yog','dan',1,'MEG0202151X5','0','0','0','0','activia solido 150gr',141.91,155.00,161.00,162.00,162.00,162.00,90.000,15.000,33.000,48.000,1,0),
  ('yogdan09','yog','dan',1,'MEG0202151X5','0','0','0','0','activia para beber 250gr',156.51,160.00,163.00,165.00,168.00,169.00,800.000,50.000,256.000,0.000,1,0),
  ('posdan02','pos','dan',1,'MEG0202151X5','0','0','0','0','flan danette 200gr',125.28,130.00,133.00,133.00,133.00,133.00,200.000,20.000,30.000,24.000,1,0),
  ('posdan03','pos','dan',1,'MEG0202151X5','0','0','0','0','arroz con leche 200gr',125.28,130.00,133.00,133.00,133.00,133.00,80.000,15.000,0.000,24.000,1,0),
  ('bebbon01','beb','bon',1,'UNI9704247M2','0','0','0','0','naranjada 900ml',83.00,89.00,89.00,89.00,89.00,90.00,700.000,50.000,62.000,20.000,1,0),
  ('bebbon02','beb','bon',1,'UNI9704247M2','0','0','0','0','naranjada 700ml',63.00,68.00,68.00,68.00,68.00,70.00,700.000,50.000,75.000,20.000,1,0),
  ('bebbon03','beb','bon',1,'UNI9704247M2','0','0','0','0','naranjada de plastico 1lt',90.00,96.00,96.00,96.00,96.00,98.00,250.000,20.000,91.000,20.000,1,0),
  ('bebbon04','beb','bon',1,'UNI9704247M2','0','0','0','0','naranjada shak',62.40,66.00,66.00,66.00,66.00,68.00,200.000,10.000,13.000,5.000,1,0),
  ('bebbon05','beb','bon',1,'UNI9704247M2','0','0','0','0','naranjada 3.750',80.00,86.00,86.00,86.00,86.00,86.00,35.000,5.000,2.000,6.000,1,0),
  ('creran01','cre','ran',1,'Joaquin','0','0','0','0','vegetal 900ml',126.70,132.00,135.00,138.00,138.00,138.00,30.000,5.000,0.000,12.000,1,0),
  ('queama01','que','ama',1,'UNI9704247M2','0','0','0','0','la provinciana de 1kg',104.20,107.00,108.00,110.00,112.00,112.00,500.000,50.000,0.000,10.000,0,0),
  ('cregin01','cre','gin',1,'UNI9704247M2','0','0','0','0','bolsa de 1kg',64.20,66.00,67.00,68.00,69.00,69.00,600.000,50.000,88.000,10.000,1,0),
  ('queama02','que','ama',1,'UNI9704247M2','0','0','0','0','rancherito rebanado 2kg',300.00,293.00,295.00,298.00,298.00,298.00,700.000,30.000,0.000,6.000,0,0),
  ('queraa01','que','raa',1,'UNI9704247M2','0','0','0','0','rebanado de 2kg',300.00,287.00,290.00,293.00,295.00,298.00,700.000,30.000,686.000,0.000,1,0),
  ('quechi01','que','chi',1,'UNI9704247M2','0','0','0','0','rebanado de 2kg',345.00,336.00,337.00,340.00,343.00,345.00,700.000,30.000,190.000,0.000,1,0),
  ('quelca01','que','lca',1,'UNI9704247M2','0','0','0','0','rebanado de 1.8kg',225.00,218.00,220.00,225.00,225.00,225.00,200.000,15.000,78.000,0.000,1,0),
  ('manchi01','man','chi',1,'UNI9704247M2','0','0','0','0','pura de 90gr',91.54,93.00,95.50,95.50,95.50,95.50,250.000,20.000,17.000,24.000,1,0),
  ('manchi02','man','chi',1,'UNI9704247M2','0','0','0','0','pura de 225gr',81.15,83.00,85.00,85.00,85.00,85.00,200.000,20.000,59.000,0.000,1,0),
  ('manchi03','man','chi',1,'UNI9704247M2','0','0','0','0','pura de 1kg',376.50,385.00,385.00,385.00,385.00,385.00,20.000,2.000,0.000,10.000,1,0),
  ('manchi04','man','chi',1,'UNI9704247M2','0','0','0','0','industial de 1kg',190.00,190.00,193.00,196.00,196.00,196.00,180.000,10.000,116.000,10.000,1,0),
  ('chorio01','cho','rio',2,'Retonito','0','0','0','0','por atado',32.00,38.00,38.00,38.00,38.00,38.00,2.000,0.000,0.000,0.000,1,0),
  ('yogbon01','yog','bon',1,'UNI9704247M2','0','0','0','0','para beber de 500ml',165.60,169.20,169.20,169.20,169.20,169.20,150.000,10.000,31.000,36.000,1,0),
  ('yogbon02','yog','bon',1,'UNI9704247M2','0','0','0','0','para beber de 1lt',153.00,160.00,160.00,160.00,160.00,160.00,35.000,5.000,6.000,0.000,1,0),
  ('crelal01','cre','lal',1,'CLD0507145H6','0','0','0','0','aciada de 200ml',106.80,107.00,108.00,108.50,109.00,110.00,250.000,30.000,49.000,24.000,1,0),
  ('crelal02','cre','lal',1,'CLD0507145H6','0','0','0','0','acida de 450ml',106.80,107.00,108.00,108.50,109.00,110.00,700.000,30.000,153.000,12.000,1,0),
  ('crelal03','cre','lal',1,'CLD0507145H6','0','0','0','0','acida de 900ml',106.80,107.00,108.00,108.50,109.00,110.00,1000.000,30.000,31.000,6.000,1,0),
  ('crelal04','cre','lal',1,'CLD0507145H6','0','0','0','0','acida de cubeta',299.10,306.00,310.00,314.00,314.00,320.00,150.000,5.000,53.000,4.000,1,0),
  ('maribe01','mar','ibe',1,'UNI9704247M2','0','0','0','0','sin sal de 90gr',75.50,71.50,72.00,72.50,73.00,74.00,8000.000,200.000,3643.000,24.000,1,0),
  ('maribe02','mar','ibe',1,'UNI9704247M2','0','0','0','0','sin sal 225 grs.',63.50,60.50,61.00,61.50,62.00,63.00,4500.000,200.000,0.000,9.000,1,0),
  ('maribe03','mar','ibe',1,'UNI9704247M2','0','0','0','0','sin sal de .500 grs.',145.33,146.00,146.50,147.00,147.50,148.00,200.000,10.000,99.000,10.000,1,0),
  ('maribe04','mar','ibe',1,'UNI9704247M2','0','0','0','0','sin sal de 1kl.',183.00,171.00,172.00,173.00,174.00,178.00,3000.000,100.000,1171.000,10.000,1,0),
  ('manchi05','man','chi',1,'UNI9704247M2','0','0','0','0','pura de 500gr',301.00,325.00,325.00,325.00,325.00,325.00,10.000,0.000,0.000,10.000,1,0),
  ('marpri01','mar','pri',1,'UNI9704247M2','0','0','0','0','sin sal de190gr',80.00,81.50,82.00,83.00,84.00,85.00,2000.000,30.000,339.000,0.000,1,0),
  ('bebfru01','beb','fru',1,'Yordy','0','0','0','0','con 24pz.',36.50,39.50,40.00,41.00,41.00,41.00,5000.000,10.000,0.000,0.000,1,1),
  ('bebgen01','beb','gen',1,'Yordy','0','0','0','0','con 24pz',105.00,110.00,111.00,112.00,112.00,114.00,1000.000,10.000,0.000,24.000,1,1),
  ('bebbot01','beb','bot',1,'Yordy','0','0','0','0','con 24pz',66.08,80.00,81.00,82.00,83.00,84.00,500.000,10.000,0.000,24.000,1,1),
  ('quecot01','que','cot',1,'Candido','0','0','0','0','29 kg aprox.',32.00,32.50,33.00,33.50,34.00,34.00,50.000,0.000,0.000,1.000,1,0),
  ('bebnew01','beb','new',1,'Candido','0','0','0','0','de 355ml',148.00,150.00,151.00,152.00,153.00,154.00,3000.000,0.000,0.000,24.000,1,0),
  ('queama03','que','ama',1,'UNI9704247M2','0','0','0','0','fundido la provinciana de kg',104.20,107.00,108.00,109.00,110.00,112.00,600.000,20.000,236.000,10.000,1,0),
  ('PalAct01','Pal','Act',1,'DCL0402164N0','0','0','0','0','de mantequilla c/18',186.50,190.00,191.00,192.00,193.00,195.00,50.000,5.000,20.000,4.000,1,0),
  ('PalAct02','Pal','Act',1,'DCL0402164N0','0','0','0','0','natural c/18pz',186.50,190.00,191.00,192.00,193.00,195.00,50.000,5.000,20.000,4.000,1,0),
  ('PalAct03','Pal','Act',1,'DCL0402164N0','0','0','0','0','de caramelo c/ 9pz',280.00,284.00,285.00,286.00,288.00,290.00,20.000,1.000,25.000,4.000,1,0),
  ('yogdan10','yog','dan',1,'MEG0202151X5','0','0','0','0','fruix solido de 125gr',106.43,109.00,109.00,109.00,109.00,109.00,15.000,2.000,1.000,48.000,1,0),
  ('queama04','que','ama',1,'Texana','0','0','0','0','rebanado singles',580.00,590.00,590.00,591.00,592.00,590.00,1.000,1.000,0.000,6.000,1,0);

COMMIT;

#
# Data for the `productos_orden` table  (LIMIT 0,500)
#

# ClaveOrden:3:32768
# ClaveProducto:253:0
# Cantidad:5:32768
# Costo:5:32768
# Importe:5:32768
# Llegan:5:32768

INSERT INTO `productos_orden` (`ClaveOrden`, `ClaveProducto`, `Cantidad`, `Costo`, `Importe`, `Llegan`) VALUES 
  (1,'manchi04',85.000,190.00,16150.00,85.000),
  (1,'queama03',252.000,104.20,26258.40,252.000),
  (1,'cregin01',84.000,64.20,5392.80,84.000),
  (1,'bebbon03',108.000,90.00,9720.00,108.000),
  (1,'yogbon01',54.000,165.60,8942.40,54.000),
  (1,'yogbon02',20.000,153.00,3060.00,20.000),
  (2,'yogdan01',104.000,89.80,9339.20,104.000),
  (2,'yogdan02',10.000,75.07,750.70,10.000),
  (2,'yogdan03',528.000,125.47,66248.16,528.000),
  (2,'yogdan05',300.000,177.68,53304.00,300.000),
  (2,'geldan01',90.000,106.43,9578.70,90.000),
  (2,'posdan01',10.000,125.28,1252.80,10.000),
  (2,'posdan02',50.000,125.28,6264.00,50.000),
  (2,'yogdan06',20.000,156.51,3130.20,20.000),
  (3,'crealp02',96.000,260.00,24960.00,96.000),
  (3,'crealp03',98.000,260.00,25480.00,98.000),
  (4,'yogdan05',100.000,177.68,17768.00,0.000),
  (5,'crealp02',102.000,268.00,27336.00,102.000),
  (5,'crealp03',104.000,268.00,27872.00,104.000),
  (6,'crelal04',50.000,298.40,14920.00,50.000),
  (7,'crelal04',15.000,298.40,4476.00,15.000),
  (8,'crealp01',143.000,115.19,16472.17,143.000),
  (8,'crealp02',191.000,261.00,49851.00,191.000),
  (8,'crealp03',64.000,261.00,16704.00,64.000),
  (9,'toscar01',200.000,95.00,19000.00,200.000),
  (10,'crealp01',42.000,113.53,4768.26,42.000),
  (10,'crealp02',116.000,261.00,30276.00,116.000),
  (11,'toscha01',150.000,145.44,21816.00,150.000),
  (12,'yogdan09',132.000,156.51,20659.32,0.000),
  (12,'posdan03',50.000,125.28,6264.00,0.000),
  (12,'yogdan05',640.000,177.68,113715.20,560.000),
  (12,'yogdan02',30.000,75.07,2252.10,15.000),
  (12,'geldan01',90.000,106.43,9578.70,90.000),
  (12,'posdan02',50.000,125.28,6264.00,50.000),
  (13,'queama04',130.000,580.00,75400.00,130.000);

COMMIT;

#
# Data for the `productos_venta` table  (LIMIT 0,500)
#

# claveVenta:3:32768
# ClaveProducto:253:0
# Cantidad:5:32768
# Costo:5:32768
# Importe:5:32768
# Llegan:5:32768

INSERT INTO `productos_venta` (`claveVenta`, `ClaveProducto`, `Cantidad`, `Costo`, `Importe`, `Llegan`) VALUES 
  (1,'crelal01',4.000,110.00,440.00,4.000),
  (2,'yogdan06',1.000,168.00,168.00,1.000),
  (3,'yogbon01',2.000,169.20,338.40,2.000),
  (4,'quechi01',1.000,345.00,345.00,1.000),
  (5,'yogdan01',2.000,95.00,190.00,2.000),
  (5,'yogdan09',1.000,168.00,168.00,1.000),
  (6,'posdan01',2.000,133.00,266.00,2.000),
  (6,'toscha01',15.000,150.00,2250.00,15.000),
  (6,'yogdan01',20.000,93.00,1860.00,20.000),
  (6,'yogdan02',6.000,81.00,486.00,6.000),
  (6,'yogdan03',40.000,130.00,5200.00,40.000),
  (6,'yogdan09',20.000,169.00,3380.00,20.000),
  (7,'bebbon01',5.000,89.00,445.00,5.000),
  (7,'bebbon02',5.000,68.00,340.00,5.000),
  (7,'quechi01',10.000,345.00,3450.00,10.000),
  (7,'quelca01',10.000,220.00,2200.00,10.000),
  (8,'toscha01',20.000,148.00,2960.00,20.000),
  (9,'yogdan03',10.000,130.00,1300.00,10.000),
  (9,'yogdan01',4.000,95.00,380.00,4.000),
  (10,'yogdan01',5.000,95.00,475.00,5.000),
  (10,'yogdan09',10.000,168.00,1680.00,10.000),
  (10,'posdan02',5.000,133.00,665.00,5.000),
  (10,'yogdan02',5.000,81.00,405.00,5.000),
  (11,'yogdan09',10.000,169.00,1690.00,10.000),
  (11,'toscha01',50.000,149.00,7450.00,50.000),
  (12,'crelal02',4.000,110.00,440.00,4.000),
  (12,'crelal03',5.000,110.00,550.00,5.000),
  (12,'yogdan05',10.000,184.00,1840.00,10.000),
  (12,'posdan02',4.000,133.00,532.00,4.000),
  (12,'yogdan08',2.000,162.00,324.00,2.000),
  (12,'geldan01',6.000,115.00,690.00,6.000),
  (13,'crelal03',2.000,110.00,220.00,2.000),
  (13,'yogdan03',1.000,143.00,143.00,1.000),
  (14,'crelal03',100.000,108.00,10800.00,100.000),
  (14,'yogdan03',15.000,130.00,1950.00,15.000),
  (14,'yogdan01',2.000,95.00,190.00,2.000),
  (14,'yogdan09',3.000,169.00,507.00,3.000),
  (14,'posdan02',2.000,133.00,266.00,2.000),
  (14,'queraa01',20.000,295.00,5900.00,20.000),
  (15,'yogdan03',20.000,130.00,2600.00,20.000),
  (16,'yogdan09',3.000,169.00,507.00,3.000),
  (16,'bebbon05',2.000,86.00,172.00,2.000),
  (16,'bebbon03',4.000,96.00,384.00,4.000),
  (16,'yogbon01',2.000,169.20,338.40,2.000),
  (16,'quechi01',3.000,345.00,1035.00,3.000),
  (17,'yogdan03',20.000,130.00,2600.00,20.000),
  (17,'yogdan05',20.000,184.00,3680.00,20.000),
  (17,'yogdan01',10.000,95.00,950.00,10.000),
  (17,'yogdan09',20.000,169.00,3380.00,20.000),
  (17,'yogdan08',5.000,162.00,810.00,5.000),
  (17,'posdan01',1.000,133.00,133.00,1.000),
  (17,'yogdan04',5.000,158.00,790.00,5.000),
  (17,'yogdan06',3.000,169.00,507.00,3.000),
  (17,'posdan03',5.000,133.00,665.00,5.000),
  (17,'bebbon01',10.000,89.00,890.00,10.000),
  (17,'bebbon03',4.000,96.00,384.00,4.000),
  (17,'manchi01',5.000,95.50,477.50,5.000),
  (17,'maribe04',5.000,178.00,890.00,5.000),
  (17,'queraa01',1.000,298.00,298.00,1.000),
  (18,'toscha01',10.000,150.00,1500.00,10.000),
  (19,'bebbon01',5.000,89.00,445.00,5.000),
  (20,'posdan02',2.000,133.00,266.00,2.000),
  (20,'bebbon01',5.000,89.00,445.00,5.000),
  (20,'maribe01',30.000,73.00,2190.00,30.000),
  (21,'yogdan06',1.000,168.00,168.00,1.000),
  (22,'posdan02',10.000,130.00,1300.00,10.000),
  (23,'yogdan05',10.000,184.00,1840.00,10.000),
  (23,'yogdan03',20.000,130.00,2600.00,20.000),
  (23,'yogdan01',3.000,95.00,285.00,3.000),
  (23,'posdan03',1.000,133.00,133.00,1.000),
  (23,'posdan02',1.000,133.00,133.00,1.000),
  (24,'yogdan03',20.000,130.00,2600.00,20.000),
  (24,'geldan01',20.000,115.00,2300.00,20.000),
  (25,'cregin01',10.000,69.00,690.00,10.000),
  (25,'queraa01',5.000,295.00,1475.00,5.000),
  (25,'quechi01',5.000,345.00,1725.00,5.000),
  (25,'quelca01',2.000,220.00,440.00,2.000),
  (26,'manchi01',5.000,95.50,477.50,5.000),
  (26,'queama03',2.000,112.00,224.00,2.000),
  (26,'bebbon02',15.000,68.00,1020.00,15.000),
  (26,'bebbon01',20.000,89.00,1780.00,20.000),
  (26,'bebbon03',5.000,96.00,480.00,5.000),
  (26,'yogbon01',3.000,169.20,507.60,3.000),
  (26,'yogbon02',2.000,160.00,320.00,2.000),
  (27,'yogdan03',10.000,130.00,1300.00,10.000),
  (27,'manchi01',10.000,95.50,955.00,10.000),
  (27,'manchi02',10.000,85.00,850.00,10.000),
  (27,'bebbon01',10.000,89.00,890.00,10.000),
  (27,'bebbon02',10.000,68.00,680.00,10.000),
  (28,'yogdan03',20.000,130.00,2600.00,20.000),
  (28,'yogdan09',3.000,169.00,507.00,3.000),
  (29,'yogdan05',10.000,184.00,1840.00,10.000),
  (29,'geldan01',9.000,115.00,1035.00,9.000),
  (29,'posdan02',3.000,133.00,399.00,3.000),
  (29,'yogdan06',3.000,169.00,507.00,3.000),
  (29,'posdan03',1.000,133.00,133.00,1.000),
  (30,'queraa01',3.000,298.00,894.00,3.000),
  (30,'quechi01',3.000,345.00,1035.00,3.000),
  (30,'quelca01',2.000,225.00,450.00,2.000),
  (30,'bebbon02',5.000,68.00,340.00,5.000),
  (30,'bebbon01',5.000,89.00,445.00,5.000),
  (30,'bebbon03',3.000,96.00,288.00,3.000),
  (30,'yogbon01',2.000,169.20,338.40,2.000),
  (30,'yogbon02',1.000,160.00,160.00,1.000),
  (31,'yogdan05',30.000,184.00,5520.00,30.000),
  (31,'yogdan03',50.000,130.00,6500.00,50.000),
  (31,'geldan01',6.000,115.00,690.00,6.000),
  (31,'yogdan01',10.000,95.00,950.00,10.000),
  (31,'yogdan09',10.000,169.00,1690.00,10.000),
  (31,'yogdan06',2.000,168.00,336.00,2.000),
  (31,'toscha01',7.000,148.00,1036.00,7.000),
  (31,'maribe01',50.000,73.00,3650.00,50.000),
  (31,'maribe02',20.000,61.00,1220.00,20.000),
  (31,'queraa01',15.000,298.00,4470.00,15.000),
  (31,'quechi01',10.000,345.00,3450.00,10.000),
  (31,'marpri01',20.000,84.00,1680.00,20.000),
  (32,'yogdan03',20.000,130.00,2600.00,20.000),
  (33,'bebbon01',1.000,89.00,89.00,1.000),
  (33,'bebbon02',1.000,68.00,68.00,1.000),
  (34,'yogdan08',1.000,162.00,162.00,1.000),
  (35,'geldan01',6.000,115.00,690.00,6.000),
  (35,'posdan03',1.000,133.00,133.00,1.000),
  (35,'yogdan01',4.000,95.00,380.00,4.000),
  (35,'yogdan05',10.000,184.00,1840.00,10.000),
  (35,'yogdan10',1.000,109.00,109.00,1.000),
  (36,'maribe02',1.000,62.00,62.00,1.000),
  (37,'yogdan03',6.000,130.00,780.00,0.000),
  (37,'yogdan09',3.000,169.00,507.00,0.000),
  (38,'yogdan09',3.000,169.00,507.00,3.000),
  (38,'yogdan03',4.000,130.00,520.00,4.000),
  (39,'yogdan03',20.000,130.00,2600.00,0.000),
  (40,'bebbon01',20.000,89.00,1780.00,20.000),
  (40,'bebbon02',15.000,68.00,1020.00,15.000),
  (40,'bebbon03',5.000,96.00,480.00,5.000),
  (40,'manchi01',5.000,95.50,477.50,5.000),
  (40,'queama03',2.000,112.00,224.00,2.000),
  (40,'yogbon01',3.000,169.20,507.60,3.000),
  (40,'yogbon02',2.000,160.00,320.00,2.000),
  (41,'yogdan05',20.000,184.00,3680.00,20.000),
  (41,'yogdan03',8.000,130.00,1040.00,8.000),
  (41,'yogdan09',4.000,169.00,676.00,4.000),
  (41,'yogalp01',20.000,62.50,1250.00,20.000),
  (41,'bebbon01',6.000,89.00,534.00,6.000),
  (41,'bebbon02',2.000,68.00,136.00,2.000),
  (41,'maribe01',10.000,73.00,730.00,10.000),
  (41,'maribe02',5.000,61.00,305.00,5.000),
  (41,'maribe04',3.000,178.00,534.00,3.000),
  (42,'crealp02',40.000,278.00,11120.00,40.000),
  (42,'crealp03',10.000,278.00,2780.00,10.000),
  (43,'crelal04',5.000,314.00,1570.00,5.000),
  (43,'queraa01',11.000,287.00,3157.00,11.000),
  (43,'maribe04',20.000,174.00,3480.00,20.000),
  (43,'bebbon01',1.000,89.00,89.00,1.000),
  (43,'bebbon02',1.000,68.00,68.00,1.000),
  (43,'maribe01',20.000,73.00,1460.00,20.000),
  (43,'queama03',1.000,110.00,110.00,1.000),
  (43,'cregin01',5.000,69.00,345.00,5.000),
  (43,'yogdan05',20.000,184.00,3680.00,20.000),
  (44,'crealp02',17.000,278.00,4726.00,17.000),
  (44,'crealp03',20.000,278.00,5560.00,20.000),
  (45,'yogalp01',1.000,62.50,62.50,1.000),
  (46,'crealp02',30.000,278.00,8340.00,30.000),
  (46,'crealp03',10.000,278.00,2780.00,10.000),
  (47,'crealp02',20.000,278.00,5560.00,20.000),
  (47,'crealp03',20.000,278.00,5560.00,20.000),
  (48,'yogdan05',20.000,184.00,3680.00,20.000),
  (48,'yogdan03',8.000,130.00,1040.00,8.000),
  (48,'yogdan09',4.000,169.00,676.00,4.000),
  (48,'yogalp01',20.000,62.50,1250.00,20.000),
  (48,'bebbon01',6.000,89.00,534.00,6.000),
  (48,'bebbon02',2.000,68.00,136.00,2.000),
  (48,'maribe01',10.000,73.00,730.00,10.000),
  (48,'maribe04',3.000,178.00,534.00,3.000),
  (49,'bebbon02',2.000,68.00,136.00,2.000),
  (50,'maribe04',100.000,174.00,17400.00,100.000),
  (50,'toscha01',80.000,148.00,11840.00,80.000),
  (50,'cregin01',2.000,69.00,138.00,2.000),
  (50,'geldan01',2.000,115.00,230.00,2.000),
  (50,'posdan02',1.000,133.00,133.00,1.000),
  (50,'crelal01',5.000,110.00,550.00,5.000),
  (50,'crelal02',5.000,110.00,550.00,5.000),
  (50,'crelal03',5.000,110.00,550.00,5.000),
  (50,'yogdan05',30.000,184.00,5520.00,30.000),
  (50,'yogdan09',2.000,169.00,338.00,2.000),
  (51,'quechi01',72.000,336.00,24192.00,72.000),
  (52,'yogalp01',15.000,62.50,937.50,15.000),
  (52,'yogdan03',10.000,130.00,1300.00,10.000),
  (53,'toscha01',100.000,147.50,14750.00,100.000),
  (54,'geldan01',6.000,115.00,690.00,6.000),
  (54,'yogdan01',5.000,95.00,475.00,5.000),
  (54,'maribe01',30.000,73.00,2190.00,30.000),
  (54,'queraa01',3.000,298.00,894.00,3.000),
  (54,'quechi01',5.000,345.00,1725.00,5.000),
  (55,'yogalp01',60.000,60.50,3630.00,60.000),
  (55,'posdan02',10.000,130.00,1300.00,10.000),
  (56,'yogdan09',2.000,169.00,338.00,2.000),
  (56,'toscha01',25.000,150.00,3750.00,25.000),
  (56,'maribe02',128.000,61.00,7808.00,128.000),
  (56,'bebbon02',10.000,68.00,680.00,10.000),
  (57,'crealp02',10.000,275.00,2750.00,10.000),
  (57,'crealp03',10.000,275.00,2750.00,10.000),
  (57,'toscha01',10.000,148.00,1480.00,10.000),
  (58,'maribe04',50.000,174.00,8700.00,50.000),
  (58,'toscha01',40.000,148.00,5920.00,40.000),
  (59,'toscha01',15.000,149.00,2235.00,15.000),
  (60,'yogbon01',1.000,169.20,169.20,1.000),
  (61,'crealp02',5.000,275.00,1375.00,5.000),
  (61,'crealp03',10.000,275.00,2750.00,10.000),
  (61,'crelal02',10.000,110.00,1100.00,10.000),
  (61,'crelal03',5.000,110.00,550.00,5.000),
  (61,'maribe01',10.000,73.00,730.00,10.000),
  (61,'maribe04',10.000,178.00,1780.00,10.000),
  (62,'crelal01',5.000,110.00,550.00,5.000),
  (62,'crelal02',5.000,110.00,550.00,5.000),
  (62,'crelal03',5.000,110.00,550.00,5.000),
  (62,'yogdan05',30.000,184.00,5520.00,30.000),
  (62,'geldan01',2.000,115.00,230.00,2.000),
  (62,'posdan02',1.000,133.00,133.00,1.000),
  (62,'yogdan09',2.000,169.00,338.00,2.000),
  (62,'toscha01',40.000,148.00,5920.00,40.000),
  (62,'maribe04',50.000,174.00,8700.00,50.000),
  (62,'cregin01',2.000,69.00,138.00,2.000),
  (63,'crelal01',5.000,110.00,550.00,5.000),
  (63,'crelal02',5.000,110.00,550.00,5.000),
  (63,'yogdan03',30.000,130.00,3900.00,30.000),
  (63,'bebbon02',10.000,68.00,680.00,10.000),
  (63,'yogbon01',1.000,169.20,169.20,1.000),
  (63,'yogbon02',1.000,160.00,160.00,1.000),
  (64,'toscar01',20.000,100.00,2000.00,20.000),
  (65,'crealp02',20.000,275.00,5500.00,20.000),
  (65,'crealp03',20.000,275.00,5500.00,20.000),
  (66,'geldan01',6.000,115.00,690.00,6.000),
  (66,'posdan02',4.000,133.00,532.00,4.000),
  (67,'crealp02',50.000,275.00,13750.00,50.000),
  (67,'crealp03',20.000,275.00,5500.00,20.000),
  (67,'cregin01',10.000,69.00,690.00,10.000),
  (68,'yogdan03',20.000,130.00,2600.00,20.000),
  (68,'yogdan01',3.000,95.00,285.00,3.000),
  (68,'yogdan09',5.000,169.00,845.00,5.000),
  (68,'yogdan06',4.000,169.00,676.00,4.000),
  (68,'maribe01',30.000,73.00,2190.00,30.000),
  (68,'bebbon05',2.000,86.00,172.00,2.000),
  (69,'yogdan03',40.000,130.00,5200.00,40.000),
  (69,'yogdan05',20.000,182.00,3640.00,20.000),
  (69,'yogdan08',5.000,155.00,775.00,5.000),
  (69,'bebbon01',3.000,89.00,267.00,3.000),
  (69,'yogbon01',5.000,169.20,846.00,5.000),
  (70,'yogalp01',25.000,62.50,1562.50,25.000),
  (71,'toscha01',15.000,148.00,2220.00,15.000),
  (72,'quechi01',5.000,345.00,1725.00,5.000),
  (73,'crealp02',10.000,278.00,2780.00,10.000),
  (74,'crealp02',1.000,275.00,275.00,1.000),
  (74,'crealp03',1.000,275.00,275.00,1.000),
  (74,'crelal02',1.000,110.00,110.00,1.000),
  (75,'crealp02',20.000,278.00,5560.00,20.000),
  (75,'crealp03',30.000,278.00,8340.00,30.000),
  (75,'toscha01',25.000,148.00,3700.00,25.000),
  (76,'yogalp01',44.000,62.50,2750.00,44.000),
  (76,'yogbon01',3.000,169.20,507.60,3.000),
  (76,'yogbon02',2.000,160.00,320.00,2.000),
  (77,'toscha01',10.000,150.00,1500.00,10.000),
  (78,'maribe01',1.000,74.00,74.00,1.000),
  (79,'yogdan01',20.000,95.00,1900.00,20.000),
  (79,'yogdan08',2.000,162.00,324.00,2.000),
  (80,'yogdan03',60.000,130.00,7800.00,60.000),
  (80,'yogdan05',30.000,184.00,5520.00,30.000),
  (80,'geldan01',6.000,115.00,690.00,6.000),
  (80,'bebbon03',5.000,96.00,480.00,5.000),
  (80,'yogbon01',5.000,169.20,846.00,5.000),
  (80,'yogbon02',2.000,160.00,320.00,2.000),
  (81,'yogdan01',3.000,95.00,285.00,3.000),
  (81,'bebbon01',10.000,89.00,890.00,10.000),
  (81,'bebbon02',4.000,68.00,272.00,4.000),
  (82,'bebbon01',5.000,89.00,445.00,5.000),
  (82,'bebbon02',5.000,68.00,340.00,5.000),
  (83,'crealp01',143.000,117.00,16731.00,143.000),
  (83,'crealp02',185.000,275.00,50875.00,185.000),
  (83,'crealp03',49.000,275.00,13475.00,49.000),
  (84,'crealp03',64.000,275.00,17600.00,64.000),
  (84,'yogdan03',1.000,130.00,130.00,1.000),
  (85,'toscha01',25.000,148.00,3700.00,25.000),
  (86,'bebbon01',10.000,89.00,890.00,10.000),
  (86,'bebbon03',3.000,96.00,288.00,3.000),
  (86,'yogbon01',1.000,169.20,169.20,1.000),
  (87,'yogalp01',20.000,62.50,1250.00,20.000),
  (87,'geldan01',10.000,115.00,1150.00,10.000),
  (87,'yogdan06',2.000,169.00,338.00,2.000),
  (88,'toscar01',15.000,100.00,1500.00,15.000),
  (89,'cregin01',5.000,69.00,345.00,5.000),
  (89,'quechi01',2.000,345.00,690.00,2.000),
  (89,'yogdan01',6.000,95.00,570.00,6.000),
  (89,'yogdan03',10.000,130.00,1300.00,10.000),
  (89,'queraa01',3.000,298.00,894.00,3.000),
  (89,'yogdan05',10.000,184.00,1840.00,10.000),
  (90,'crealp02',5.000,275.00,1375.00,5.000),
  (90,'crealp03',10.000,275.00,2750.00,10.000),
  (90,'crelal02',5.000,110.00,550.00,5.000),
  (90,'crelal03',10.000,110.00,1100.00,10.000),
  (90,'maribe01',10.000,73.00,730.00,10.000),
  (90,'maribe04',10.000,178.00,1780.00,10.000),
  (91,'maribe01',6.000,73.00,438.00,6.000),
  (91,'maribe03',3.000,148.00,444.00,3.000),
  (91,'yogdan09',2.000,169.00,338.00,2.000),
  (91,'marpri01',2.000,84.00,168.00,2.000),
  (91,'manchi04',1.000,196.00,196.00,1.000),
  (91,'toscha01',4.000,150.00,600.00,4.000),
  (92,'posdan02',1.000,133.00,133.00,1.000),
  (92,'cregin01',2.000,69.00,138.00,2.000),
  (92,'maribe03',2.000,148.00,296.00,2.000),
  (92,'queraa01',2.000,295.00,590.00,2.000),
  (92,'maribe01',15.000,73.00,1095.00,15.000),
  (92,'bebbon01',1.000,89.00,89.00,1.000),
  (92,'bebbon02',1.000,68.00,68.00,1.000),
  (93,'crealp02',119.000,278.00,33082.00,119.000),
  (93,'crealp03',20.000,278.00,5560.00,20.000),
  (93,'crealp01',42.000,117.00,4914.00,42.000),
  (94,'yogdan03',10.000,130.00,1300.00,10.000),
  (95,'yogdan01',5.000,95.00,475.00,5.000),
  (95,'posdan02',5.000,133.00,665.00,5.000),
  (95,'yogdan08',4.000,162.00,648.00,4.000),
  (95,'yogdan06',2.000,169.00,338.00,2.000),
  (95,'yogdan02',2.000,81.00,162.00,2.000),
  (95,'toscar01',65.000,100.00,6500.00,65.000),
  (96,'yogdan03',10.000,130.00,1300.00,10.000),
  (96,'yogdan01',2.000,95.00,190.00,2.000),
  (97,'yogdan05',100.000,184.00,18400.00,100.000),
  (97,'posdan02',5.000,133.00,665.00,5.000),
  (97,'yogbon01',5.000,169.20,846.00,5.000),
  (97,'yogbon02',5.000,160.00,800.00,5.000),
  (97,'toscha01',50.000,148.00,7400.00,50.000),
  (98,'cregin01',2.000,68.00,136.00,2.000),
  (98,'manchi01',20.000,95.50,1910.00,20.000),
  (99,'geldan01',3.000,115.00,345.00,3.000),
  (99,'yogdan06',3.000,169.00,507.00,3.000),
  (99,'bebbon03',5.000,96.00,480.00,5.000),
  (99,'yogbon01',1.000,169.20,169.20,1.000),
  (99,'yogbon02',1.000,160.00,160.00,1.000),
  (100,'manchi01',10.000,95.50,955.00,10.000),
  (100,'manchi02',10.000,85.00,850.00,10.000),
  (100,'maribe01',50.000,73.00,3650.00,50.000),
  (100,'quechi01',10.000,340.00,3400.00,10.000),
  (101,'crelal03',5.000,110.00,550.00,5.000),
  (101,'yogdan01',3.000,95.00,285.00,3.000),
  (101,'bebbon01',5.000,89.00,445.00,5.000),
  (101,'bebbon02',5.000,68.00,340.00,5.000),
  (102,'geldan01',15.000,115.00,1725.00,15.000),
  (102,'maribe01',50.000,72.50,3625.00,50.000),
  (102,'posdan02',5.000,133.00,665.00,5.000),
  (102,'yogdan01',10.000,95.00,950.00,10.000),
  (102,'yogdan06',3.000,169.00,507.00,3.000),
  (102,'yogdan09',10.000,169.00,1690.00,10.000),
  (103,'crelal04',2.000,314.00,628.00,2.000),
  (103,'toscha01',2.000,150.00,300.00,2.000),
  (104,'bebbon01',15.000,89.00,1335.00,15.000),
  (104,'bebbon02',15.000,68.00,1020.00,15.000),
  (104,'bebbon03',2.000,96.00,192.00,2.000),
  (105,'manchi02',5.000,85.00,425.00,5.000),
  (105,'maribe01',20.000,73.00,1460.00,20.000),
  (106,'maribe01',20.000,73.00,1460.00,20.000),
  (107,'posdan02',3.000,133.00,399.00,3.000),
  (107,'yogdan08',2.000,162.00,324.00,2.000),
  (108,'yogdan03',30.000,130.00,3900.00,30.000),
  (108,'yogdan05',20.000,184.00,3680.00,20.000),
  (108,'posdan01',1.000,133.00,133.00,1.000),
  (108,'posdan02',5.000,133.00,665.00,5.000),
  (108,'yogdan02',5.000,81.00,405.00,5.000),
  (108,'bebbon01',15.000,89.00,1335.00,15.000),
  (108,'bebbon02',10.000,68.00,680.00,10.000),
  (108,'maribe01',50.000,73.00,3650.00,50.000),
  (108,'cregin01',10.000,69.00,690.00,10.000),
  (108,'quechi01',5.000,345.00,1725.00,5.000),
  (108,'queraa01',2.000,298.00,596.00,2.000),
  (109,'toscha01',10.000,150.00,1500.00,10.000),
  (110,'yogdan01',3.000,95.00,285.00,3.000),
  (110,'yogdan03',10.000,130.00,1300.00,10.000),
  (110,'yogdan08',1.000,162.00,162.00,1.000),
  (110,'geldan01',3.000,115.00,345.00,3.000),
  (110,'bebbon01',5.000,89.00,445.00,5.000),
  (110,'bebbon02',5.000,68.00,340.00,5.000),
  (110,'yogbon01',1.000,169.20,169.20,1.000),
  (110,'cregin01',5.000,69.00,345.00,5.000),
  (111,'yogdan03',10.000,130.00,1300.00,10.000),
  (111,'posdan02',1.000,133.00,133.00,1.000),
  (111,'geldan01',2.000,115.00,230.00,2.000),
  (111,'bebbon01',4.000,89.00,356.00,4.000),
  (111,'bebbon03',2.000,96.00,192.00,2.000),
  (111,'bebbon04',4.000,66.00,264.00,4.000),
  (112,'toscar01',100.000,100.00,10000.00,100.000),
  (113,'yogdan09',4.000,169.00,676.00,4.000),
  (113,'toscha01',30.000,149.00,4470.00,30.000),
  (113,'bebbon01',10.000,89.00,890.00,10.000),
  (113,'bebbon04',5.000,66.00,330.00,5.000),
  (114,'yogdan03',30.000,130.00,3900.00,30.000),
  (115,'yogdan03',20.000,130.00,2600.00,20.000),
  (115,'geldan01',6.000,115.00,690.00,6.000),
  (115,'maribe01',30.000,73.00,2190.00,30.000),
  (115,'quechi01',2.000,345.00,690.00,2.000),
  (116,'toscha01',25.000,148.00,3700.00,25.000),
  (116,'queama04',130.000,590.00,76700.00,130.000),
  (117,'yogdan09',3.000,169.00,507.00,3.000),
  (118,'bebbon01',5.000,89.00,445.00,5.000),
  (118,'bebbon02',5.000,68.00,340.00,5.000),
  (118,'quelca01',2.000,220.00,440.00,2.000),
  (119,'yogdan05',20.000,184.00,3680.00,20.000),
  (119,'yogdan03',10.000,130.00,1300.00,10.000),
  (119,'quechi01',10.000,345.00,3450.00,10.000),
  (119,'bebbon01',10.000,89.00,890.00,10.000),
  (119,'bebbon02',10.000,68.00,680.00,10.000),
  (120,'crelal04',5.000,314.00,1570.00,5.000),
  (121,'posdan02',3.000,133.00,399.00,0.000),
  (121,'yogdan09',3.000,169.00,507.00,0.000),
  (122,'yogdan09',2.000,169.00,338.00,2.000),
  (122,'toscha01',10.000,149.00,1490.00,10.000),
  (122,'cregin01',5.000,68.00,340.00,5.000),
  (122,'queama03',15.000,112.00,1680.00,15.000),
  (122,'bebbon01',7.000,89.00,623.00,7.000),
  (122,'bebbon02',3.000,68.00,204.00,3.000),
  (122,'yogbon01',1.000,169.20,169.20,1.000);

COMMIT;

#
# Data for the `proveedores` table  (LIMIT 0,500)
#

# rfc:253:0
# nombre:253:0
# direccion:253:0
# colonia:253:0
# delegacion:253:0
# cp:253:0
# ciudad:253:0
# tel1:253:0
# tel2:253:0
# fax:253:0
# pagina:253:0
# email:253:0
# vendedor:253:0
# formaPago:3:32768
# cuentas:252:16
# credito:5:32768
# diasPago:3:32768
# descuento1:5:32768
# descuento2:5:32768
# descuento3:5:32768
# saldoDisponible:5:32768
# alta:10:128
# activo:3:32768

INSERT INTO `proveedores` (`rfc`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tel1`, `tel2`, `fax`, `pagina`, `email`, `vendedor`, `formaPago`, `cuentas`, `credito`, `diasPago`, `descuento1`, `descuento2`, `descuento3`, `saldoDisponible`, `alta`, `activo`) VALUES 
  ('MEG0202151X5','MEGA COMER S.A DE C.V','POCHTECAS 37','PASEOS DE CHURUBUSCO','IZTAPALAPA','09040','MEXICO D.F.','56405668','56405666','','','','FERNANDO LUKE',2,'',0.00,2,0.00,0.00,0.00,-158733.32,'2006-06-02',1),
  ('TNI920507GB8','TOSTIRICAS NIETO S.A DE C.V.','Priv. ceylan 45-A','Industrial Vallejo','Azcapotzalco','02300','Mexico D.F.','53687475','0445520731372','','','','Luis Maldonado Villegas',2,'',0.00,30,0.00,0.00,0.00,-21816.00,'2006-06-02',1),
  ('UNI9704247M2','UNIFOOS S.A DE C.V.','Poniente 122  -459','Industrial Vallejo','Azcapotzalco','02300','Mexico D.F.','53331200','0445518668248 ABRHAM','0445518668244 PICOS','','','ABRHAM    PICOS   ALBERTO  TOÑO',2,'',0.00,0,4.00,0.00,0.00,-69523.60,'2006-06-02',1),
  ('Mateo','Mateo','Santa Maria La Rivera','Santa Maria La Rivera','Santa Maria La River','000','Mexico D. F.','S/N','','','','','Mateo',1,'',0.00,5,0.00,0.00,0.00,0.00,'2006-06-27',1),
  ('Ricardo','Ricardo Nava Butanda','Cuautitlan','Cuautitlan','Cuautitlan Izcali','000','Mexico D.F.','0445521413035','','','','','Ricardo Nava Butanda',1,'',0.00,4,0.00,0.00,0.00,0.00,'2006-06-27',1),
  ('Galdino','Galdino','','','','000','Mexico D.F.','0445525641900','','','','','Galdino',1,'',100000.00,5,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Ambrosio','Ambrosio Alvarado Martinez','','','','000','Mexico D.F.','S/N','','','','','Bocho',1,'',100000.00,3,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Calderon','Ernesto Calderon','Calle Miguel Hidalgo','Urbana','Xalostoc','000','Mexico D.F.','57141445','0445516329317','','','','Calderon',1,'',300000.00,10,0.00,0.00,0.00,300000.00,'2006-06-30',1),
  ('Teresita','Cremeria Teresita De La Central De Abasto','Central de Abasto Boega G-41','Ceda','Iztapalapa','09040','Mexico D.F.','5694','','','','','Tomas',1,'',150000.00,8,0.00,0.00,0.00,150000.00,'2006-06-30',1),
  ('CTC900503Q24','Cremeria Teresita De Central De Abasto S.A de C.V.','Zona 1 Sector1 Nave1 Bodega G-39 -41','Central de Abasto','Iztapalapa','09040','Mexico D.F.','5694','','','','','Tomas y Sergio',2,'',150000.00,8,0.00,0.00,0.00,150000.00,'2006-06-30',1),
  ('Candido','Candelario Ramirez Pozos','Pasillo 3 Local 32','Central de Abasto','Iztapalapa','09040','Mexico D.F.','5694 8759','','','','','Candido',1,'',100000.00,30,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Joaquin','Alfredo Joaquin Guevara','Zumpango','Zumpango','Zumpango','000','Pachuca Hgo.','015919173541','','','','','Marcos',1,'',300000.00,8,0.00,0.00,0.00,300000.00,'2006-06-30',1),
  ('Palomas','Palomas','Pasillo 2 Local E-F','CEDA','Iztapalapa','09040','Mexico D.F.','5694 6529','','','','','Beto',1,'',100000.00,15,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Carioca','Javier Vidal Mata','Cuautla','Cuatla','Morelos','000','Morelos','017353578634','','','','','Jose Luis',1,'',30000.00,2,0.00,0.00,0.00,11000.00,'2006-06-30',1),
  ('Charra','Charra','Privada Ceylan 45','Industrial Vallejo','Industial Vallejo','000','Mexico D.F.','0445520731372','','','','','Luis',1,'',15000.00,5,0.00,0.00,0.00,15000.00,'2006-06-30',1),
  ('Mario','Mario Figueroa Mundo','Taxco','Taxco','Taxco','000','Taxco Guerrero','017626253992','','','','','Mario',1,'',150000.00,5,0.00,0.00,0.00,150000.00,'2006-06-30',1),
  ('Chispeadero','Chispeadero','Pasillo G-H Local-47','CEDA','Iztapalapa','09040','Mexico D.F.','5694','','','','','Chispeadero',1,'',1000.00,2,0.00,0.00,0.00,1000.00,'2006-06-30',1),
  ('Retonito','Rosalva Cano Pozos','Pasillo 3 Local 80','CEDA','Iztapalapa','09040','Mexico D.F.','5600 2607','','','','','Rosalva',1,'',50000.00,15,0.00,0.00,0.00,50000.00,'2006-06-30',1),
  ('Ramirez','Ramirez','Pasillo 2 Local I-J','CEDA','Iztapalapa','09040','Mexico D.F.','5640 9230','','','','','Arturo',1,'',3000.00,8,0.00,0.00,0.00,3000.00,'2006-06-30',1),
  ('Rene','Rene Espinoza','G 75','CEDA','Iztapalapa','09040','Mexico D,F','56409887','','','','','Rene',1,'',40000.00,8,0.00,0.00,0.00,40000.00,'2006-06-30',1),
  ('Texana','La Texana S.A de C.V.','H 52-54','CEDA','Iztapalapa','09040','Mexico D.F.','56002034','56940238','','','','Alfredo',1,'',30000.00,8,0.00,0.00,0.00,-45400.00,'2006-06-30',1),
  ('CLZ040329SD5','Comercializadora la Laguna De Zumpango S.A de C.V','Calle Braniff  s/n','B.de santiago 1ra seccion','','55600','Estado de Mexico','015919173541','','','','','Marco y Joaquin',2,'',500000.00,5,0.00,0.00,0.00,500000.00,'2006-07-04',1),
  ('CLD0507145H6','Comercializadora de Lacteos y Derivados S.A de C.V.','Lazaro Cardenas #185 Parque Industrial Lagunero','Canatatlan','Valle Guadina','35077','Durango','S/N','','','','','Rostro',2,'',200000.00,15,0.00,0.00,0.00,200000.00,'2006-07-04',1),
  ('Yordy','Yordy','Bodega H-32b','CEDA','Iztapalapa','09040','Mexico D.F.','s/n','','','','','Fausto y Yordy',1,'',200000.00,15,0.00,0.00,0.00,200000.00,'2006-07-13',1),
  ('DCL0402164N0','DeinneClub,S.A.DEC.V.','Guanajuato No.240 Int.1','Roma','Cuahutemoc','06700','Mexico,D.F.','57119706','91525620','','','','Fernando y Roberto',2,'',300000.00,5,0.00,0.00,0.00,300000.00,'2006-07-19',1);

COMMIT;

#
# Data for the `regalos_extras` table  (LIMIT 0,500)
#

# ClaveOrden:3:32768
# ClaveProducto:253:0
# Cantidad:5:32768
# Llego:5:32768

INSERT INTO `regalos_extras` (`ClaveOrden`, `ClaveProducto`, `Cantidad`, `Llego`) VALUES 
  (4,'yogdan05',10.000,0.000),
  (12,'yogdan05',56.000,56.000);

COMMIT;

#
# Data for the `regalos_venta` table  (LIMIT 0,500)
#

# claveVenta:3:32768
# ClaveProducto:253:0
# Cantidad:5:32768
# Llego:5:32768

INSERT INTO `regalos_venta` (`claveVenta`, `ClaveProducto`, `Cantidad`, `Llego`) VALUES 
  (12,'yogdan05',1.000,1.000),
  (31,'yogdan05',3.000,3.000),
  (35,'yogdan05',1.000,1.000),
  (41,'yogdan05',2.000,2.000),
  (43,'yogdan05',2.000,2.000),
  (48,'yogdan05',2.000,2.000),
  (69,'yogdan05',2.000,2.000),
  (97,'yogdan05',10.000,10.000),
  (119,'yogdan05',2.000,2.000);

COMMIT;

#
# Data for the `usuarios` table  (LIMIT 0,500)
#

# ClaveU:253:16391
# Contrasena:253:1
# Tipo:253:0
# Nombre:253:0
# APaterno:253:0
# AMaterno:253:0
# Puesto:253:0
# Area:253:0
# Estatus:254:0

INSERT INTO `usuarios` (`ClaveU`, `Contrasena`, `Tipo`, `Nombre`, `APaterno`, `AMaterno`, `Puesto`, `Area`, `Estatus`) VALUES 
  ('bety','2431','Admin','Beatriz','Vazquez','Perez','Gerente','Admin','1'),
  ('CHAVA','CHAVA','Simple','Salvador','Gonzalez','Plascencia','Agente','Ventas','1'),
  ('marcial','marcial','Simple','marcial','marcial','marcial','Repartidor','Ventas','0'),
  ('piero','1127','Admin','Piero','Gonzalez','Serrano','Gerente','Admin','1'),
  ('piero 2','dos','Simple','piero2','gonzalez','serrano','Agente','Ventas','1'),
  ('piero a','raul','Simple','piero','piero','piero','Caja','Cobros','0'),
  ('Piero1','piero1','Simple','Piero','Gonzalez','Serrano','Agente','Ventas','1'),
  ('salvador','chavol','Admin','Salvador','Gonzalez','Plascencia','Gerente','Admin','1');

COMMIT;

#
# Data for the `ventas` table  (LIMIT 0,500)
#

# claveVenta:3:49667
# claveCliente:253:0
# fechaAlta:10:128
# fechaEntrega:10:128
# observaciones:253:0
# subtotal:5:32768
# iva:5:32768
# total:5:32768
# activo:3:32768
# tipo:3:32768
# factura:253:0
# remision:3:32768
# Entrega:3:32768
# usuario:253:0
# pago:3:32768
# repartidor:253:0

INSERT INTO `ventas` (`claveVenta`, `claveCliente`, `fechaAlta`, `fechaEntrega`, `observaciones`, `subtotal`, `iva`, `total`, `activo`, `tipo`, `factura`, `remision`, `Entrega`, `usuario`, `pago`, `repartidor`) VALUES 
  (1,'Barca','2006-08-29','2006-08-29',' Repartidor: null',440.00,0.00,440.00,1,2,'',1,2,'bety',2,'null'),
  (2,'Barca','2006-08-29','2006-08-29',' Repartidor: null',168.00,0.00,168.00,0,2,'',2,2,'bety',0,'null'),
  (3,'Retoño','2006-08-29','2006-08-29',' Repartidor: null',338.40,0.00,338.40,1,2,'',3,2,'bety',0,'null'),
  (4,'Che','2006-08-29','2006-08-29',' Repartidor: null',345.00,0.00,345.00,1,2,'',4,2,'bety',2,'null'),
  (5,'Yovany','2006-08-29','2006-08-29',' Repartidor: null',358.00,0.00,358.00,1,2,'',5,2,'bety',2,'null'),
  (6,'Retoño','2006-08-29','2006-08-29',' Repartidor: null',13442.00,0.00,13442.00,1,2,'',6,2,'bety',2,'null'),
  (7,'Josè Manuel','2006-08-29','2006-08-29',' Repartidor: null',6435.00,0.00,6435.00,1,2,'',7,2,'bety',0,'null'),
  (8,'Union','2006-08-29','2006-08-29',' Repartidor: null',2960.00,0.00,2960.00,1,2,'',8,2,'bety',0,'null'),
  (9,'Ranchito','2006-08-29','2006-08-29',' Repartidor: null',1680.00,0.00,1680.00,1,2,'',9,2,'bety',2,'null'),
  (10,'Normita','2006-08-29','2006-08-29',' Repartidor: null',3225.00,0.00,3225.00,1,2,'',10,2,'bety',2,'null'),
  (11,'Yoely','2006-08-29','2006-08-29',' Repartidor: null',9140.00,0.00,9140.00,1,2,'',11,2,'bety',0,'null'),
  (12,'Barca','2006-08-29','2006-08-29',' Repartidor: null',4376.00,0.00,4376.00,1,2,'',12,2,'bety',0,'null'),
  (13,'Erik','2006-08-29','2006-08-29',' Repartidor: null',363.00,0.00,363.00,1,2,'',13,2,'bety',2,'null'),
  (14,'Lupita','2006-08-29','2006-08-29',' Repartidor: null',19613.00,0.00,19613.00,1,2,'',14,2,'bety',0,'null'),
  (15,'Retoñito','2006-08-29','2006-08-29',' Repartidor: null',2600.00,0.00,2600.00,1,2,'',15,2,'bety',0,'null'),
  (16,'Surtidor','2006-08-29','2006-08-29',' Repartidor: null',2436.40,0.00,2436.40,1,2,'',16,2,'bety',0,'null'),
  (17,'Esperanza','2006-08-29','2006-08-29',' Repartidor: null',16454.50,0.00,16454.50,1,2,'',17,2,'bety',0,'null'),
  (18,'Esperanza','2006-08-29','2006-08-29',' Repartidor: null',1500.00,0.00,1500.00,1,2,'',18,2,'bety',2,'null'),
  (19,'Ramirez','2006-08-29','2006-08-29',' Repartidor: null',445.00,0.00,445.00,1,2,'',19,2,'bety',0,'null'),
  (20,'Ruiseñor','2006-08-29','2006-08-29',' Repartidor: null',2901.00,0.00,2901.00,1,2,'',20,2,'bety',0,'null'),
  (21,'Barca','2006-08-29','2006-08-29',' Repartidor: null',168.00,0.00,168.00,1,2,'',21,2,'bety',2,'null'),
  (22,'CSS850907851','2006-08-29','2006-08-29',' Repartidor: null',1300.00,0.00,1300.00,1,1,'16477',0,2,'bety',0,'null'),
  (23,'GALP601011M59','2006-08-29','2006-08-29',' Repartidor: null',4991.00,0.00,4991.00,1,1,'16478',0,2,'bety',0,'null'),
  (24,'CSC880523NA1','2006-08-29','2006-08-29',' Repartidor: null',4900.00,0.00,4900.00,1,1,'16472',0,2,'bety',0,'null'),
  (25,'TEX931122JL3','2006-08-29','2006-08-29',' Repartidor: null',4330.00,0.00,4330.00,1,1,'16471',0,2,'bety',0,'null'),
  (26,'HESJ501028FJ3','2006-08-29','2006-08-29',' Repartidor: null',4809.10,0.00,4809.10,0,1,'16479',0,2,'bety',0,'null'),
  (27,'DCN040210NJO','2006-08-29','2006-08-29',' Repartidor: null',4675.00,0.00,4675.00,1,1,'16480',0,2,'bety',0,'null'),
  (28,'CLA830615UC2','2006-08-29','2006-08-29',' Repartidor: null',3107.00,0.00,3107.00,1,1,'16481',0,2,'bety',0,'null'),
  (29,'CLA830615UC2','2006-08-29','2006-08-29',' Repartidor: null',3914.00,0.00,3914.00,1,1,'16482',0,2,'bety',0,'null'),
  (30,'CSL0309122V5','2006-08-29','2006-08-29',' Repartidor: null',3950.40,0.00,3950.40,1,1,'16483',0,2,'bety',0,'null'),
  (31,'GAAY8110197E3','2006-08-29','2006-08-29',' Repartidor: null',31192.00,0.00,31192.00,1,1,'16475',0,2,'bety',2,'null'),
  (32,'MAVP601008RTA','2006-08-29','2006-08-29',' Repartidor: null',2600.00,0.00,2600.00,1,1,'16484',0,2,'bety',0,'null'),
  (33,'Nochistlan','2006-08-29','2006-08-29',' Repartidor: null',157.00,0.00,157.00,1,2,'',22,2,'bety',2,'null'),
  (34,'Yoely','2006-08-29','2006-08-29',' Repartidor: null',162.00,0.00,162.00,1,2,'',23,2,'bety',0,'null'),
  (35,'AEVJ741206QJ3','2006-08-29','2006-08-29',' Repartidor: null',3152.00,0.00,3152.00,1,1,'16476',0,2,'bety',2,'null'),
  (36,'Nochistlan','2006-08-29','2006-08-29',' Repartidor: null',62.00,0.00,62.00,1,2,'',24,2,'bety',2,'null'),
  (37,'DCP040210F26','2006-08-29','2006-08-29','',1287.00,0.00,1287.00,0,1,'16485',0,0,'bety',0,''),
  (38,'DCP040210F26','2006-08-29','2006-08-29',' Repartidor: null',1027.00,0.00,1027.00,1,1,'16485',0,2,'bety',2,'null'),
  (39,'MAVP601008RTA','2006-08-29','2006-08-29','',2600.00,0.00,2600.00,0,1,'16484',0,0,'bety',0,''),
  (40,'HESJ440722S33','2006-08-29','2006-08-29',' Repartidor: null',4809.10,0.00,4809.10,1,1,'16479',0,2,'piero',0,'null'),
  (41,'melo','2006-08-30','2006-08-30',' Repartidor: null',8885.00,0.00,8885.00,0,2,'',25,2,'bety',1,'null'),
  (42,'TEX931122JL3','2006-08-30','2006-08-30',' Repartidor: null',13900.00,0.00,13900.00,1,2,'',26,2,'bety',2,'null'),
  (43,'Juan Munoz','2006-08-30','2006-08-30',' Repartidor: null',13959.00,0.00,13959.00,1,2,'',27,2,'bety',0,'null'),
  (44,'Rigo','2006-08-30','2006-08-30',' Repartidor: null',10286.00,0.00,10286.00,0,2,'',28,2,'bety',0,'null'),
  (45,'Juan Zepeda','2006-08-30','2006-08-30',' Repartidor: null',62.50,0.00,62.50,1,2,'',29,2,'bety',2,'null'),
  (46,'CSS850907851','2006-08-30','2006-08-30',' Repartidor: null',11120.00,0.00,11120.00,1,2,'',30,2,'bety',2,'null'),
  (47,'Retoñito','2006-08-30','2006-08-30',' Repartidor: null',11120.00,0.00,11120.00,1,2,'',31,2,'bety',0,'null'),
  (48,'melo','2006-08-30','2006-08-30',' Repartidor: null',8580.00,0.00,8580.00,1,2,'',32,2,'bety',1,'null'),
  (49,'Che','2006-08-30','2006-08-30',' Repartidor: null',136.00,0.00,136.00,1,2,'',33,2,'bety',2,'null'),
  (50,'Alfredo','2006-08-30','2006-08-30',' Repartidor: null',37249.00,0.00,37249.00,0,2,'',34,2,'bety',0,'null'),
  (51,'CLA830615UC2','2006-08-30','2006-08-30',' Repartidor: null',24192.00,0.00,24192.00,1,1,'16489',0,2,'bety',0,'null'),
  (52,'HESJ501028FJ3','2006-08-30','2006-08-30',' Repartidor: null',2237.50,0.00,2237.50,1,1,'16488',0,2,'bety',0,'null'),
  (53,'CSC880523NA1','2006-08-30','2006-08-30',' Repartidor: null',14750.00,0.00,14750.00,1,1,'16490',0,2,'bety',0,'null'),
  (54,'AAGF740817Q38','2006-08-30','2006-08-30',' Repartidor: null',5974.00,0.00,5974.00,1,1,'16491',0,2,'bety',0,'null'),
  (55,'CSS850907851','2006-08-30','2006-08-30',' Repartidor: null',4930.00,0.00,4930.00,1,1,'16492',0,2,'bety',0,'null'),
  (56,'MAVP601008RTA','2006-08-30','2006-08-30',' Repartidor: null',12576.00,0.00,12576.00,1,1,'16493',0,2,'bety',0,'null'),
  (57,'PAPE720521P11','2006-08-30','2006-08-30',' Repartidor: null',6980.00,0.00,6980.00,1,1,'16494',0,2,'bety',0,'null'),
  (58,'Alfredo','2006-08-30','2006-08-30',' Repartidor: null',14620.00,0.00,14620.00,1,2,'',35,2,'bety',2,'null'),
  (59,'DCP040210F26','2006-08-30','2006-08-30',' Repartidor: null',2235.00,0.00,2235.00,1,1,'16495',0,2,'bety',0,'null'),
  (60,'GALP601011M59','2006-08-30','2006-08-30',' Repartidor: null',169.20,0.00,169.20,1,1,'16496',0,2,'bety',0,'null'),
  (61,'DCP040210J5A','2006-08-30','2006-08-30',' Repartidor: null',8285.00,0.00,8285.00,0,1,'16498',0,2,'bety',0,'null'),
  (62,'DEMA640807PB5','2006-08-30','2006-08-30',' Repartidor: null',22629.00,0.00,22629.00,1,1,'16499',0,2,'bety',1,'null'),
  (63,'HESJ440722S33','2006-08-30','2006-08-30',' Repartidor: null',6009.20,0.00,6009.20,1,1,'16500',0,2,'bety',0,'null'),
  (64,'CSH870328B82','2006-08-30','2006-08-30',' Repartidor: null',2000.00,0.00,2000.00,1,1,'16501',0,2,'bety',0,'null'),
  (65,'Bonanza','2006-08-30','2006-08-30',' Repartidor: null',11000.00,0.00,11000.00,1,2,'',36,2,'bety',0,'null'),
  (66,'CLA830615UC2','2006-08-30','2006-08-30',' Repartidor: null',1222.00,0.00,1222.00,1,1,'16502',0,2,'bety',0,'null'),
  (67,'Ranchito','2006-08-30','2006-08-30',' Repartidor: null',19940.00,0.00,19940.00,1,2,'',37,2,'bety',0,'null'),
  (68,'CSL0309122V5','2006-08-30','2006-08-30',' Repartidor: null',6768.00,0.00,6768.00,1,1,'16503',0,2,'bety',0,'null'),
  (69,'Normita','2006-08-30','2006-08-30',' Repartidor: null',10728.00,0.00,10728.00,1,2,'',38,2,'bety',0,'null'),
  (70,'Yoely','2006-08-30','2006-08-30',' Repartidor: null',1562.50,0.00,1562.50,1,2,'',39,2,'bety',0,'null'),
  (71,'Union','2006-08-30','2006-08-30',' Repartidor: null',2220.00,0.00,2220.00,1,2,'',40,2,'bety',0,'null'),
  (72,'Retoñito','2006-08-30','2006-08-30',' Repartidor: null',1725.00,0.00,1725.00,1,2,'',41,2,'piero',0,'null'),
  (73,'Tapatio','2006-08-30','2006-08-30',' Repartidor: null',2780.00,0.00,2780.00,1,2,'',42,2,'piero',0,'null'),
  (74,'Erik','2006-08-30','2006-08-30',' Repartidor: null',660.00,0.00,660.00,1,2,'',43,2,'piero',2,'null'),
  (75,'Josè Manuel','2006-08-30','2006-08-30',' Repartidor: null',17600.00,0.00,17600.00,1,2,'',44,2,'piero',0,'null'),
  (76,'Esperanza','2006-08-30','2006-08-30',' Repartidor: null',3577.60,0.00,3577.60,1,2,'',45,2,'piero',0,'null'),
  (77,'Esperanza','2006-08-30','2006-08-30',' Repartidor: null',1500.00,0.00,1500.00,1,2,'',46,2,'piero',2,'null'),
  (78,'Nochistlan','2006-08-30','2006-08-30',' Repartidor: null',74.00,0.00,74.00,1,2,'',47,2,'piero',0,'null'),
  (79,'Especial','2006-08-30','2006-08-30',' Repartidor: null',2224.00,0.00,2224.00,1,2,'',48,2,'piero',0,'null'),
  (80,'Retoño','2006-08-30','2006-08-30',' Repartidor: null',15656.00,0.00,15656.00,1,2,'',49,2,'piero',0,'null'),
  (81,'Laura','2006-08-30','2006-08-30',' Repartidor: null',1447.00,0.00,1447.00,1,2,'',50,2,'piero',0,'null'),
  (82,'Surtidor','2006-08-30','2006-08-30',' Repartidor: null',785.00,0.00,785.00,1,2,'',51,2,'piero',0,'null'),
  (83,'Teresita','2006-08-30','2006-08-30',' Repartidor: null',81081.00,0.00,81081.00,1,2,'',52,2,'piero',0,'null'),
  (84,'Ramirez','2006-08-30','2006-08-30',' Repartidor: null',17730.00,0.00,17730.00,1,2,'',53,2,'piero',0,'null'),
  (85,'Chucho','2006-08-30','2006-08-30',' Repartidor: null',3700.00,0.00,3700.00,1,2,'',54,2,'piero',0,'null'),
  (86,'GALP601011M59','2006-08-30','2006-08-30',' Repartidor: null',1347.20,0.00,1347.20,1,1,'16504',0,2,'piero',0,'null'),
  (87,'TEX931122JL3','2006-08-30','2006-08-30',' Repartidor: null',2738.00,0.00,2738.00,1,1,'16487',0,2,'piero',0,'null'),
  (88,'CSL0309122V5','2006-08-30','2006-08-30',' Repartidor: null',1500.00,0.00,1500.00,1,1,'16505',0,2,'piero',0,'null'),
  (89,'AEVJ741206QJ3','2006-08-30','2006-08-30',' Repartidor: null',5639.00,0.00,5639.00,1,1,'16506',0,2,'piero',2,'null'),
  (90,'DCP040210J5A','2006-08-30','2006-08-30',' Repartidor: null',8285.00,0.00,8285.00,1,1,'16498',0,2,'piero',0,'null'),
  (91,'celestino','2006-08-31','2006-08-31',' Repartidor: null',2184.00,0.00,2184.00,1,2,'',55,2,'bety',0,'null'),
  (92,'Juan Munoz','2006-08-31','2006-08-31',' Repartidor: null',2409.00,0.00,2409.00,1,2,'',56,2,'bety',0,'null'),
  (93,'Especial','2006-08-31','2006-08-31',' Repartidor: null',43556.00,0.00,43556.00,1,2,'',57,2,'bety',0,'null'),
  (94,'Ramirez','2006-08-31','2006-08-31',' Repartidor: null',1300.00,0.00,1300.00,1,2,'',58,2,'bety',0,'null'),
  (95,'Texana','2006-08-31','2006-08-31',' Repartidor: null',8788.00,0.00,8788.00,1,2,'',59,2,'bety',0,'null'),
  (96,'Yoely','2006-08-31','2006-08-31',' Repartidor: null',1490.00,0.00,1490.00,1,2,'',60,2,'bety',0,'null'),
  (97,'Especial','2006-08-31','2006-08-31',' Repartidor: null',28111.00,0.00,28111.00,1,2,'',61,2,'bety',0,'null'),
  (98,'Union','2006-08-31','2006-08-31',' Repartidor: null',2046.00,0.00,2046.00,1,2,'',62,2,'bety',0,'null'),
  (99,'Retoñito','2006-08-31','2006-08-31',' Repartidor: null',1661.20,0.00,1661.20,1,2,'',63,2,'bety',0,'null'),
  (100,'Chucho','2006-08-31','2006-08-31',' Repartidor: null',8855.00,0.00,8855.00,1,2,'',64,2,'bety',0,'null'),
  (101,'Tapatio','2006-08-31','2006-08-31',' Repartidor: null',1620.00,0.00,1620.00,1,2,'',65,2,'bety',0,'null'),
  (102,'Normita','2006-08-31','2006-08-31',' Repartidor: null',9162.00,0.00,9162.00,1,2,'',66,2,'bety',0,'null'),
  (103,'Erik','2006-08-31','2006-08-31',' Repartidor: null',928.00,0.00,928.00,1,2,'',67,2,'bety',0,'null'),
  (104,'Rosa de oro','2006-08-31','2006-08-31',' Repartidor: null',2547.00,0.00,2547.00,1,2,'',68,2,'bety',0,'null'),
  (105,'Ranchito','2006-08-31','2006-08-31',' Repartidor: null',1885.00,0.00,1885.00,1,2,'',69,2,'BETY',0,'null'),
  (106,'Retoño','2006-08-31','2006-08-31',' Repartidor: null',1460.00,0.00,1460.00,1,2,'',70,2,'bety',0,'null'),
  (107,'Surtidor','2006-08-31','2006-08-31',' Repartidor: null',723.00,0.00,723.00,1,2,'',71,2,'bety',0,'null'),
  (108,'Esperanza','2006-08-31','2006-08-31',' Repartidor: null',17459.00,0.00,17459.00,1,2,'',72,2,'bety',0,'null'),
  (109,'Esperanza','2006-08-31','2006-08-31',' Repartidor: null',1500.00,0.00,1500.00,1,2,'',73,2,'bety',0,'null'),
  (110,'Ruiseñor','2006-08-31','2006-08-31',' Repartidor: null',3391.20,0.00,3391.20,1,2,'',74,2,'bety',0,'null'),
  (111,'Rancherita','2006-08-31','2006-08-31',' Repartidor: null',2475.00,0.00,2475.00,1,2,'',75,2,'bety',0,'null'),
  (112,'PLV0501201N3','2006-08-31','2006-08-31',' Repartidor: null',10000.00,0.00,10000.00,1,1,'16508',0,2,'bety',0,'null'),
  (113,'CSL0309122V5','2006-08-31','2006-08-31',' Repartidor: null',6366.00,0.00,6366.00,1,1,'16509',0,2,'bety',0,'null'),
  (114,'CTC900503Q24','2006-08-31','2006-08-31',' Repartidor: null',3900.00,0.00,3900.00,1,1,'16510',0,2,'bety',0,'null'),
  (115,'AAGF740817Q38','2006-08-31','2006-08-31',' Repartidor: null',6170.00,0.00,6170.00,1,1,'16511',0,2,'bety',0,'null'),
  (116,'LSF050118U75','2006-08-31','2006-08-31',' Repartidor: null',80400.00,0.00,80400.00,1,1,'16513',0,2,'bety',0,'null'),
  (117,'GALP601011M59','2006-08-31','2006-08-31',' Repartidor: null',507.00,0.00,507.00,1,1,'16514',0,2,'bety',0,'null'),
  (118,'DCP040210F26','2006-08-31','2006-08-31',' Repartidor: null',1225.00,0.00,1225.00,1,1,'16515',0,2,'bety',0,'null'),
  (119,'DCN040210NJO','2006-08-31','2006-08-31',' Repartidor: null',10000.00,0.00,10000.00,1,1,'16517',0,2,'bety',0,'null'),
  (120,'HESJ501028FJ3','2006-08-31','2006-08-31',' Repartidor: null',1570.00,0.00,1570.00,1,1,'16518',0,2,'bety',0,'null'),
  (121,'CLA830615UC2','2006-08-31','2006-08-31','',906.00,0.00,906.00,1,1,'16519',0,0,'bety',0,''),
  (122,'DCH040220NMA','2006-08-31','2006-08-31',' Repartidor: null',4844.20,0.00,4844.20,1,1,'16520',0,2,'bety',0,'null');

COMMIT;

