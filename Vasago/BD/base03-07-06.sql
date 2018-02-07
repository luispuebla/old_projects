# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `vasago`;

CREATE DATABASE `vasago`;

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
  PRIMARY KEY  (`claveOrden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos` table : 
#

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `linea` char(3) collate latin1_spanish_ci default NULL,
  `marca` char(3) collate latin1_spanish_ci default NULL,
  `proveedor1` varchar(13) collate latin1_spanish_ci default NULL,
  `proveedor2` varchar(13) collate latin1_spanish_ci default NULL,
  `descripcion` varchar(100) collate latin1_spanish_ci default NULL,
  `costo` double(8,2) default NULL,
  `precio1` double(8,2) default NULL,
  `precio2` double(8,2) default NULL,
  `precio3` double(8,2) default NULL,
  `precio4` double(8,2) default NULL,
  `precio5` double(8,2) default NULL,
  `maximo` int(4) default NULL,
  `minimo` int(4) default NULL,
  `existencia` int(4) default NULL,
  `piezasXcaja` int(5) default NULL,
  `activo` int(1) default NULL,
  `iva` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos_orden` table : 
#

DROP TABLE IF EXISTS `productos_orden`;

CREATE TABLE `productos_orden` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` int(7) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` int(7) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 11264 kB';

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
  `Cantidad` int(7) default NULL,
  `Llego` int(7) default NULL
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
# Data for the `bancos` table  (LIMIT 0,500)
#

# clave:3:49667
# numero:253:0
# banco:253:0
# importeInicial:5:32768
# importeActual:5:32768

INSERT INTO `bancos` (`clave`, `numero`, `banco`, `importeInicial`, `importeActual`) VALUES 
  (5,'60508612609','SANTANDER SERFIN S,A,DEC.V.',20000.00,32000.00),
  (6,'9000','INBURSA',10000.00,22800.00),
  (7,'123456789','HSBC',25530.00,96251.09);

COMMIT;

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
  ('el retoño','candelario ramirez pozos','bodega pasillo 4','ejido del moral','IZTAPALAPA','09040','MEXICO D.F.',3,'569431','569463','','',1,'3 4','ANITA',0.00,0,'PG','2006-06-19',1,0.00,0),
  ('TEX931122P11','LA TEXANA,S.A DE C.V.','BODEGA 93-95','EJIDOS DEL MORAL','IZTAPALAPA','09030','MEXICO,D.F.',1,'569431','','','',1,'','',300000.00,29,'rx','2006-06-21',1,0.00,0),
  ('feje751115','enrique fernandez jaimes','cerro de la libertad no. 293','campestre churubusco','coyoacan','04200','mexico, d.f.',1,'554973l6','','56890662','enriquefj@alphanet.com.mx',7,'14','sofia gabian',20000.00,8,'rx','2006-06-26',0,20000.00,0);

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
  (5,5,'2006-06-18','GASTO DE GASOLINA',500.00,0),
  (6,6,'2006-06-21','desyuno',100.00,1),
  (7,6,'2006-06-21','desyuno',100.00,1),
  (8,6,'2006-06-24','pago concepto nestle',2000.00,1),
  (9,7,'2006-06-26','Papeleria',785.00,1),
  (10,7,'2006-06-25','Desayuno empleados',450.00,0),
  (11,7,'2006-06-27','Mantenimiento Camioneta',13879.00,1),
  (12,7,'2006-06-26','Chicles',3.50,0),
  (13,7,'2006-06-26','Tenencias',16149.73,1);

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
  (9,5,'2006-06-19','VENTAS DE MOSTRADOR',12000.00,1),
  (10,6,'2006-06-20','utilidades',5000.00,1),
  (11,6,'2006-06-27','utilidades del mes de junio',10000.00,1),
  (12,7,'2006-06-26','Recolecta Desayuno',235.00,0),
  (13,7,'2006-06-25','Utilidad extra',14620.00,1),
  (14,7,'2006-06-27','Utilidad extra2',1235.00,1),
  (15,7,'2006-06-26','Deposito',2356.00,0),
  (16,7,'2006-06-26','Devolución de Proveedor',85679.82,1);

COMMIT;

#
# Data for the `linea` table  (LIMIT 0,500)
#

# clave:254:0
# nombre:253:0

INSERT INTO `linea` (`clave`, `nombre`) VALUES 
  ('LEC','Leche'),
  ('CRE','Crema'),
  ('MAN','Mantequilla'),
  ('QUE','Queso'),
  ('YOG','Yogurt'),
  ('MAR','MARGARINA'),
  ('TOS','TOSTADA'),
  ('NAR','NARANJADA');

COMMIT;

#
# Data for the `marca` table  (LIMIT 0,500)
#

# clave:254:0
# nombre:253:0

INSERT INTO `marca` (`clave`, `nombre`) VALUES 
  ('LAL','Lala'),
  ('DAN','Danone'),
  ('IBE','Iberia'),
  ('CHI','Chipilo'),
  ('ALP','Alpura'),
  ('UNI','UNILEVER'),
  ('CHA','FIESTA CHARRA'),
  ('BON','BONAFINA');

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

INSERT INTO `orden_compra` (`claveOrden`, `claveProveedor`, `fecha`, `fechaEntrega`, `observaciones`, `descuento1`, `descuento2`, `descuento3`, `subtotal`, `descuento`, `iva`, `total`, `activo`, `factura`, `Entrega`, `usuario`) VALUES 
  (9,'0','2006-07-02',NULL,'hola',10.00,5.00,3.00,880.00,729.83,37.32,767.15,1,'0',0,'chofas'),
  (10,'0','2006-07-02',NULL,'',5.00,3.00,0.00,3000.00,2764.50,414.68,3179.18,1,'0',0,'chofas'),
  (11,'DANO800101rt1','2006-07-02',NULL,'',10.00,5.00,3.00,2670.00,2214.36,332.15,2546.52,1,'0',0,'super'),
  (12,'nes800101','2006-07-02','0000-00-00','',5.00,3.00,0.00,12.00,12.00,0.00,12.00,1,'0',0,'super'),
  (13,'nes800101','2006-07-02','2006-07-02','',5.00,3.00,0.00,4680.00,4312.62,646.89,4959.51,0,'0',0,'super'),
  (14,'DANO800101rt1','2006-07-03','2006-07-03','',10.00,0.00,0.00,1710.00,1539.00,230.85,1769.85,1,'0',0,'super');

COMMIT;

#
# Data for the `productos_orden` table  (LIMIT 0,500)
#

# ClaveOrden:3:32768
# ClaveProducto:253:0
# Cantidad:3:32768
# Costo:5:32768
# Importe:5:32768
# Llegan:3:32768

INSERT INTO `productos_orden` (`ClaveOrden`, `ClaveProducto`, `Cantidad`, `Costo`, `Importe`, `Llegan`) VALUES 
  (9,'LECLAL01',10,30.00,300.00,0),
  (9,'MANIBE01',10,58.00,580.00,0),
  (10,'LECLAL02',100,30.00,3000.00,0),
  (11,'LECLAL01',89,30.00,2670.00,0),
  (12,'MANLAL01',12,1.00,12.00,0),
  (13,'LECLAL02',156,30.00,4680.00,0),
  (14,'CREALP01',15,114.00,1710.00,0);

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
  ('CSC880523NAI','CREMERIA Y SALCHICHONERIA CUADRITOS S,A, DE C.V,','','','','','','569400','','','','','',1,'',0.00,0,0.00,0.00,0.00,0.00,'2006-06-19',0),
  ('123','DISTRBUIDORA DE ZUMPANGO,S.A. DE C.V.','','','','','','963514','','','','','',1,'',100000.00,60,5.00,0.00,0.00,100000.00,'2006-06-21',0),
  ('nes800101','nestle de mexico,s.a. de c.v.','reforma 1305','centro','benito juarez','03510','mexico,d.f.','55832020','','56122121','www.nestle.com.mx','ventas@nestle.com.mx','jose ramirez perez',3,'9510332512 banamez',150000.00,15,5.00,3.00,0.00,150000.00,'2006-06-26',1),
  ('DANO800101rt1','Danone de México, S.A. de C.V.','Av. Tlahuac #23423','Industrial','Iztapalapa','01457','México, D.F.','55887799','','','','','',4,'',0.00,0,10.00,5.00,3.00,0.00,'2006-07-02',1);

COMMIT;

#
# Data for the `regalos_extras` table  (LIMIT 0,500)
#

# ClaveOrden:3:32768
# ClaveProducto:253:0
# Cantidad:3:32768
# Llego:3:32768

INSERT INTO `regalos_extras` (`ClaveOrden`, `ClaveProducto`, `Cantidad`, `Llego`) VALUES 
  (9,'MANLAL01',10,0);

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
  ('super','SP','Admin','Administrador','Administrador','Administrador','Gerente','Admin','1');

COMMIT;

