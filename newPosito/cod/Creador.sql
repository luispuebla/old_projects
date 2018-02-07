# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : nretono


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `nretono`;

CREATE DATABASE `nretono`;

USE `nretono`;

#
# Structure for the `avisos` table : 
#

DROP TABLE IF EXISTS `avisos`;

CREATE TABLE `avisos` (
  `automatico` int(6) NOT NULL auto_increment,
  `frase` varchar(200) collate latin1_spanish_ci default NULL,
  `activo` int(1) default '0',
  PRIMARY KEY  (`automatico`),
  UNIQUE KEY `automatico` (`automatico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `cancelacion` table : 
#

DROP TABLE IF EXISTS `cancelacion`;

CREATE TABLE `cancelacion` (
  `claveCancela` int(10) NOT NULL auto_increment,
  `numTicket` int(10) NOT NULL default '0',
  `fechaTicket` date default NULL,
  `tipoTicket` int(1) unsigned default NULL,
  `cajeroTicket` varchar(20) collate latin1_spanish_ci default NULL,
  `montoTotal` double(8,2) default NULL,
  `fechaBaja` date default NULL,
  `horaBaja` time default NULL,
  PRIMARY KEY  (`claveCancela`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `rfc` varchar(13) collate latin1_spanish_ci NOT NULL default '',
  `curp` varchar(20) collate latin1_spanish_ci NOT NULL default '',
  `nombre` varchar(45) collate latin1_spanish_ci NOT NULL default '',
  `direccion` varchar(35) collate latin1_spanish_ci NOT NULL default '',
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(20) collate latin1_spanish_ci default NULL,
  `contacto` varchar(40) collate latin1_spanish_ci default NULL,
  `tel1` varchar(12) collate latin1_spanish_ci default NULL,
  `tel2` varchar(12) collate latin1_spanish_ci default NULL,
  `alta` date default NULL,
  `tipoCliente` int(1) NOT NULL default '0',
  `credito` double(8,2) default NULL,
  `tiempoCredito` int(2) default '0',
  `saldo` double(8,2) default NULL,
  `bloqueoXPagoV` int(1) default '0',
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `codigosb` table : 
#

DROP TABLE IF EXISTS `codigosb`;

CREATE TABLE `codigosb` (
  `ID_Pro` int(6) default NULL,
  `codBarra` varchar(15) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `contenidoticket` table : 
#

DROP TABLE IF EXISTS `contenidoticket`;

CREATE TABLE `contenidoticket` (
  `numTicket` int(10) NOT NULL default '0',
  `fechaRegistro` date NOT NULL default '0000-00-00',
  `horaRegistro` time default NULL,
  `ID_Pro` int(6) NOT NULL default '0',
  `claveVendedor` int(4) NOT NULL default '0',
  `tipoVenta` int(1) NOT NULL default '0',
  `tipoPrecio` int(1) default NULL,
  `precioVenta` double(8,2) NOT NULL default '0.00',
  `cantidadProducto` double(8,3) default NULL,
  `pesoEnPz` double(8,3) default NULL,
  `estatusPago` int(1) default '0',
  `precioAPagar` double(8,2) NOT NULL default '0.00',
  `estatusTicket` int(1) default '0',
  `fechaRealPago` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 129024 kB';

#
# Structure for the `creditos` table : 
#

DROP TABLE IF EXISTS `creditos`;

CREATE TABLE `creditos` (
  `numTicket` int(10) NOT NULL default '0',
  `fechaCredito` date default NULL,
  `fechaAPagar` date default NULL,
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombreCliente` varchar(45) collate latin1_spanish_ci default NULL,
  `cantidadAPagar` double(8,2) default NULL,
  `factura` int(1) default NULL,
  `tipoCobro` int(1) default NULL,
  `referenciaCobro` varchar(40) collate latin1_spanish_ci default NULL,
  `usuario` varchar(20) collate latin1_spanish_ci default NULL,
  `fechaRealPago` date default NULL,
  `usuarioPago` varchar(20) collate latin1_spanish_ci default NULL,
  `estatusCredito` int(1) default '0',
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `facturas` table : 
#

DROP TABLE IF EXISTS `facturas`;

CREATE TABLE `facturas` (
  `claveOrden` int(8) default NULL,
  `docAval` varchar(11) collate latin1_spanish_ci default NULL,
  `fechaDoc` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `facventas` table : 
#

DROP TABLE IF EXISTS `facventas`;

CREATE TABLE `facventas` (
  `numFactura` varchar(12) collate latin1_spanish_ci default NULL,
  `tickets` varchar(40) collate latin1_spanish_ci default NULL,
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombre` varchar(45) collate latin1_spanish_ci default NULL,
  `fechaFac` date default NULL,
  `fechaCrea` date default NULL,
  `tasa0` double(8,2) default NULL,
  `tasa15` double(8,2) default NULL,
  `iva` double(8,2) default NULL,
  `total` double(8,2) default NULL,
  `estatus` int(1) default NULL,
  `cantXFac` int(2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mermas` table : 
#

DROP TABLE IF EXISTS `mermas`;

CREATE TABLE `mermas` (
  `ID_Pro` int(6) default NULL,
  `usuario` varchar(8) default NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `descuenta` double(8,3) default NULL,
  `cantidadOriginal` double(8,3) default NULL,
  `nuevaCantidad` double(8,3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `modificainv` table : 
#

DROP TABLE IF EXISTS `modificainv`;

CREATE TABLE `modificainv` (
  `ID_Modifica` int(8) NOT NULL auto_increment,
  `ID_Pro` int(6) default NULL,
  `claveUsuario` varchar(8) default NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `cantidadOriginal` double(8,3) default NULL,
  `nuevaCantidad` double(8,3) default NULL,
  `tipo` int(1) default NULL,
  PRIMARY KEY  (`ID_Modifica`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `orden_compra` table : 
#

DROP TABLE IF EXISTS `orden_compra`;

CREATE TABLE `orden_compra` (
  `claveOrden` int(11) NOT NULL auto_increment,
  `claveProveedor` varchar(13) collate latin1_spanish_ci default NULL,
  `fechaRegistro` date default NULL,
  `fechaEntrega` date default NULL,
  `fechaPago` date default NULL,
  `observaciones` varchar(250) collate latin1_spanish_ci default NULL,
  `descuento1` double(4,2) default NULL,
  `descuento2` double(4,2) default NULL,
  `descuento3` double(4,2) default NULL,
  `subtotal` double(8,2) default NULL,
  `descuento` double(8,2) default NULL,
  `iva` double(8,2) default NULL,
  `total` double(8,2) default NULL,
  `activo` int(1) default NULL,
  `docAval` varchar(11) collate latin1_spanish_ci default NULL,
  `entrega` int(1) default NULL,
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
  `claveOrden` int(8) default NULL,
  `claveProveedor` varchar(13) collate latin1_spanish_ci default NULL,
  `fechaPago` date default NULL,
  `monto` double(8,2) default NULL,
  `formaPago` int(1) default NULL,
  `numeroCheque` varchar(12) collate latin1_spanish_ci default NULL,
  `bancoCuenta` int(1) default NULL,
  `activo` int(1) default NULL,
  `usuario` varchar(8) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (`consecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `pescalonados` table : 
#

DROP TABLE IF EXISTS `pescalonados`;

CREATE TABLE `pescalonados` (
  `ID_Pro` int(6) NOT NULL default '0',
  `ca_peEscalon` int(6) default '0',
  `campoPrecio` double(8,2) default '0.00',
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `precio_anterior_producto` table : 
#

DROP TABLE IF EXISTS `precio_anterior_producto`;

CREATE TABLE `precio_anterior_producto` (
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `tipoProducto` int(1) default NULL,
  `claveOrden` int(11) default NULL,
  `precioAnterior` double(8,2) default NULL,
  `precioCompra` double(8,2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos` table : 
#

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `ID_Pro` int(6) NOT NULL auto_increment,
  `descripcion` varchar(35) collate latin1_spanish_ci default NULL,
  `tipoPro` int(1) default NULL,
  `gravaIVA` int(1) default '0',
  `genero` int(1) default NULL,
  `id_prov1` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov2` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov3` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov4` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov5` varchar(13) collate latin1_spanish_ci default NULL,
  `uniCompra` int(1) default NULL,
  `precioUniCompra` double(8,2) default NULL,
  `preCaCompra` double(8,2) default NULL,
  `cantidadXCaja` int(4) default NULL,
  `precioUnidadKG` double(8,2) default NULL,
  `kgXUnidad` double(8,2) default NULL,
  `tipoPrecio` int(1) default NULL,
  `manejoPrecio` int(1) default NULL,
  `precioBase1` double(8,2) NOT NULL default '0.00',
  `precioBase1Caja` double(8,2) NOT NULL default '0.00',
  `precioG1` double(8,2) default '0.00',
  `precioG1Caja` double(8,2) default '0.00',
  `precioG2` double(8,2) default '0.00',
  `precioG2Caja` double(8,2) default '0.00',
  `precioG3` double(8,2) default '0.00',
  `precioG3Caja` double(8,2) default '0.00',
  `precioG4` double(8,2) default '0.00',
  `precioG4Caja` double(8,2) default '0.00',
  `precioG5` double(8,2) default '0.00',
  `precioG5Caja` double(8,2) default '0.00',
  `precioG6` double(8,2) default '0.00',
  `precioG6Caja` double(8,2) default '0.00',
  `maxInv` double(8,3) default NULL,
  `minInv` double(8,3) default NULL,
  `existencia` double(8,3) default '0.000',
  `activo` int(1) default '1',
  PRIMARY KEY  (`ID_Pro`),
  UNIQUE KEY `ID_Pro` (`ID_Pro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos_orden` table : 
#

DROP TABLE IF EXISTS `productos_orden`;

CREATE TABLE `productos_orden` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` double(8,3) default NULL,
  `Tipo` int(1) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` double(8,3) default NULL,
  `Adquisicion` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `proveedores` table : 
#

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombre` varchar(80) collate latin1_spanish_ci default NULL,
  `direccion` varchar(50) collate latin1_spanish_ci default NULL,
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(30) collate latin1_spanish_ci default NULL,
  `tel1` varchar(20) collate latin1_spanish_ci default NULL,
  `tel2` varchar(20) collate latin1_spanish_ci default NULL,
  `fax` varchar(20) collate latin1_spanish_ci default NULL,
  `pagina` varchar(75) collate latin1_spanish_ci default NULL,
  `email` varchar(80) collate latin1_spanish_ci default NULL,
  `vendedor` varchar(50) collate latin1_spanish_ci default NULL,
  `formaPago` int(1) default NULL,
  `cuentas` text collate latin1_spanish_ci,
  `IDcredito` int(1) default '1',
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
# Structure for the `salidas` table : 
#

DROP TABLE IF EXISTS `salidas`;

CREATE TABLE `salidas` (
  `numTicket` int(10) NOT NULL default '0',
  `fechaVenta` date NOT NULL default '0000-00-00',
  `horaVenta` time default NULL,
  `sumaVenta` double(8,2) default '0.00',
  `factura` int(1) default '0',
  `tipoCobro` int(1) default NULL,
  `referenciaCobro` varchar(40) collate latin1_spanish_ci default NULL,
  `usuario` varchar(20) collate latin1_spanish_ci default NULL,
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 129024 kB';

#
# Structure for the `usuario` table : 
#

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `USUARIO_ID` varchar(8) collate latin1_spanish_ci NOT NULL default '',
  `PASSWORD` varchar(8) collate latin1_spanish_ci default NULL,
  `TIPO` varchar(15) collate latin1_spanish_ci default NULL,
  `NombreE` varchar(50) collate latin1_spanish_ci default NULL,
  `claveVenta` int(6) NOT NULL auto_increment,
  `clavePermiso` int(4) default NULL,
  `permisoCobro` int(1) unsigned default '0',
  `estatus` int(1) default '1',
  UNIQUE KEY `claveVenta` (`claveVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `vendedores` table : 
#

DROP TABLE IF EXISTS `vendedores`;

CREATE TABLE `vendedores` (
  `claveVenta` int(4) NOT NULL auto_increment,
  `NombreE` varchar(50) collate latin1_spanish_ci default NULL,
  `clavePermiso` int(4) default NULL,
  `permisoCobro` int(1) unsigned default '0',
  `estatus` int(1) default '1',
  PRIMARY KEY  (`claveVenta`),
  UNIQUE KEY `claveVenta` (`claveVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Data for the `vendedores` table  (LIMIT 0,500)
#

# claveVenta:3:49671
# NombreE:253:0
# clavePermiso:3:32768
# permisoCobro:3:32800
# estatus:3:32768

INSERT INTO `vendedores` (`claveVenta`, `NombreE`, `clavePermiso`, `permisoCobro`, `estatus`) VALUES 
  (1,'Enrique Fernandez Jaimes',1234,1,1),
  (2,'Sofia Gabian Dominguez',1234,0,1),
  (3,'Adalberto Martínez Rojas',0,0,1),
  (4,'Jorge Pimentel Aguayo',505,1,1),
  (5,'Arturo Días Ordanza',34,1,0);

COMMIT;

#
# Data for the `usuario` table  (LIMIT 0,500)
#

# USUARIO_ID:253:1
# PASSWORD:253:0
# TIPO:253:0
# NombreE:253:0
# claveVenta:3:49667
# clavePermiso:3:32768
# permisoCobro:3:32800
# estatus:3:32768

INSERT INTO `usuario` (`USUARIO_ID`, `PASSWORD`, `TIPO`, `NombreE`, `claveVenta`, `clavePermiso`, `permisoCobro`, `estatus`) VALUES 
  ('super','super','administrador','Administrador',1,2005,0,1),
  ('factura','factura','simple','facturacion',2,1738,0,1),
  ('cobro','cobro','simple','cobro',3,0,0,1);

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
# IDcredito:3:32768
# credito:5:32768
# diasPago:3:32768
# descuento1:5:32768
# descuento2:5:32768
# descuento3:5:32768
# saldoDisponible:5:32768
# alta:10:128
# activo:3:32768

INSERT INTO `proveedores` (`rfc`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tel1`, `tel2`, `fax`, `pagina`, `email`, `vendedor`, `formaPago`, `cuentas`, `IDcredito`, `credito`, `diasPago`, `descuento1`, `descuento2`, `descuento3`, `saldoDisponible`, `alta`, `activo`) VALUES 
  ('GADS800104','Sofia Gabian Dominguez','','','','','','547788778','','','','','',1,'',1,65000.00,0,0.00,0.00,0.00,43131.21,'2007-01-29',1),
  ('feje751115gw1','Enrique Fernández Jaimes','Cerro de la libertad #293, Depto. #202','Campestre Churubusco','Coyoacan','04200','México, D.F.','55497316','56890662','','','','Enrique',1,'',1,10000.00,10,0.00,0.00,0.00,-41946.89,'2007-02-01',1),
  ('mosi741125tq4','Ivonne Morales Sanchez','Tenochtitlan Mz 513 Lt 74','Cd Azteca 1ra secc','Ecatepec','55120','Estado de México','57 76 02 35','044 55 27 14 93 56','','','','Ivonne',2,'',1,50000.00,21,3.00,0.00,0.00,44026.58,'2007-02-05',1),
  ('RAPC','CANDELARIO  RAMIREZ  POZOS','CALLE   7  NOM   13','EDO  DE MEXICO','XHIMALHUACAN   EDO','5600','CHIMALHUACAN   EDO  DE MEX','51129493','56948759','','','','EMILIO   JUAREZ',1,'HBC   1297595610',1,40000.00,16,2.00,4.00,6.00,34279.61,'2007-02-05',1),
  ('kiko','kiko','','','','','','3323','','','','','',1,'',0,0.00,15,0.00,0.00,0.00,0.00,'2007-03-05',0),
  ('234234','234234','','','','','','234234','','','','','',1,'',0,0.00,0,0.00,0.00,0.00,0.00,'2007-05-10',1);

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

# ID_Pro:3:49671
# descripcion:253:0
# tipoPro:3:32768
# gravaIVA:3:32768
# genero:3:32768
# id_prov1:253:0
# id_prov2:253:0
# id_prov3:253:0
# id_prov4:253:0
# id_prov5:253:0
# uniCompra:3:32768
# precioUniCompra:5:32768
# preCaCompra:5:32768
# cantidadXCaja:3:32768
# precioUnidadKG:5:32768
# kgXUnidad:5:32768
# tipoPrecio:3:32768
# manejoPrecio:3:32768
# precioBase1:5:32769
# precioBase1Caja:5:32769
# precioG1:5:32768
# precioG1Caja:5:32768
# precioG2:5:32768
# precioG2Caja:5:32768
# precioG3:5:32768
# precioG3Caja:5:32768
# precioG4:5:32768
# precioG4Caja:5:32768
# precioG5:5:32768
# precioG5Caja:5:32768
# precioG6:5:32768
# precioG6Caja:5:32768
# maxInv:5:32768
# minInv:5:32768
# existencia:5:32768
# activo:3:32768

INSERT INTO `productos` (`ID_Pro`, `descripcion`, `tipoPro`, `gravaIVA`, `genero`, `id_prov1`, `id_prov2`, `id_prov3`, `id_prov4`, `id_prov5`, `uniCompra`, `precioUniCompra`, `preCaCompra`, `cantidadXCaja`, `precioUnidadKG`, `kgXUnidad`, `tipoPrecio`, `manejoPrecio`, `precioBase1`, `precioBase1Caja`, `precioG1`, `precioG1Caja`, `precioG2`, `precioG2Caja`, `precioG3`, `precioG3Caja`, `precioG4`, `precioG4Caja`, `precioG5`, `precioG5Caja`, `precioG6`, `precioG6Caja`, `maxInv`, `minInv`, `existencia`, `activo`) VALUES 
  (1,'Coca-Cola 600ml.',0,1,2,'feje751115gw1','RAPC','mosi741125tq4','GADS800104','',1,0.00,45.00,12,0.00,0.00,1,1,5.00,60.00,5.50,66.00,5.75,69.00,5.70,68.40,6.00,72.00,4.85,58.20,4.90,58.80,5500.000,800.000,1500.000,1),
  (2,'Pepsi-Cola 300ml en lata',0,1,2,'RAPC','feje751115gw1','mosi741125tq4','GADS800104','',1,4.50,27.25,6,0.00,0.00,2,0,5.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,5500.000,300.000,5248.000,1),
  (3,'Jamón Zwan Virginia',1,0,1,'RAPC','feje751115gw1','mosi741125tq4','GADS800104','',2,0.00,0.00,0,120.00,3.50,1,0,25.00,0.00,25.50,0.00,25.40,0.00,25.60,0.00,24.50,0.00,24.00,0.00,26.00,0.00,500.000,5.000,415.560,1),
  (4,'Queso Oaxaca El Norteño',1,0,1,'RAPC','feje751115gw1','mosi741125tq4','GADS800104','',2,0.00,0.00,0,70.01,3.00,1,0,18.00,0.00,18.30,0.00,18.20,0.00,18.10,0.00,18.50,0.00,17.00,0.00,17.50,0.00,50.000,5.000,54.540,1),
  (5,'Sopa Maruchan',0,0,3,'RAPC','feje751115gw1','mosi741125tq4','GADS800104','',1,5.00,50.00,10,0.00,0.00,0,1,6.00,60.00,6.00,60.00,6.00,60.00,6.00,60.00,6.00,60.00,6.00,60.00,6.00,60.00,1500.000,35.000,750.000,1),
  (6,'Ate La Costeña',0,0,3,'RAPC','feje751115gw1','mosi741125tq4','GADS800104','',1,10.00,100.00,10,0.00,0.00,1,1,12.00,120.00,12.50,125.00,12.80,128.00,12.90,129.00,13.00,130.00,11.90,119.00,11.50,115.00,2500.000,30.000,500.000,1),
  (7,'Queso Panela Esmeralda',1,0,1,'feje751115gw1','','','','',2,0.00,0.00,0,22.00,3.70,1,2,25.00,95.00,26.00,96.20,24.00,88.80,24.50,90.65,25.50,94.35,23.00,85.10,24.80,91.76,1000.000,300.000,98.660,1),
  (8,'Jamon de Pavo Sabori',1,0,1,'RAPC','','','','',2,0.00,0.00,0,22.00,3.70,1,2,25.00,95.00,26.00,96.20,27.00,99.90,28.00,103.60,29.00,107.30,25.50,94.35,26.60,98.42,1000.000,25.000,45.550,1),
  (9,'Jamon Ahumado San Rafael',1,0,1,'mosi741125tq4','','','','',2,0.00,0.00,0,22.00,3.70,1,2,25.00,85.00,26.00,96.20,27.00,99.90,28.00,103.60,29.00,107.30,30.00,111.00,30.00,111.00,1000.000,300.000,546.840,1),
  (10,'Alta precio',0,1,1,'mosi741125tq4','','','','',1,5000.00,10000.00,2,0.00,0.00,1,1,5001.00,10002.00,5002.00,10004.00,5003.00,10006.00,5004.00,10008.00,5005.00,10010.00,5006.00,10012.00,5007.00,10014.00,50.000,10.000,25.000,0),
  (11,'salchicha de pavo fud',1,0,1,'RAPC','mosi741125tq4','','','',2,0.00,0.00,0,25.30,2.20,1,2,28.00,61.60,28.00,61.60,27.50,60.50,27.00,59.40,26.50,58.30,26.00,57.20,25.80,56.76,500.000,22.000,45.440,1),
  (12,'Completo por Peso, pieza y grupos',1,0,1,'RAPC','feje751115gw1','','','',2,0.00,0.00,0,50.00,1.50,1,2,51.00,152.00,52.00,78.00,53.00,79.50,54.00,81.00,55.00,82.50,56.00,84.00,57.00,85.50,500.000,100.000,424.540,1),
  (13,'test fin',1,0,1,'','mosi741125tq4','','','',2,0.00,0.00,0,1.00,1.50,1,2,2.00,250.00,3.00,350.00,4.00,450.00,5.00,550.00,6.00,650.00,7.00,750.00,8.00,850.00,500.000,100.000,5.500,1),
  (14,'qw',1,0,1,'','','mosi741125tq4','','',2,0.00,0.00,0,10.00,1.50,1,2,11.00,16.50,11.00,16.50,12.00,18.00,13.00,19.50,14.00,21.00,15.00,22.50,16.00,24.00,5000.000,50.000,120.500,1),
  (15,'Completo Peso',1,0,1,'mosi741125tq4','','','','',2,0.00,0.00,0,25.00,2.50,1,2,28.00,70.00,29.00,71.00,30.00,73.00,31.00,75.00,32.00,78.00,27.50,68.00,27.75,69.00,1000.000,10.000,56.890,1),
  (16,'jamon San Rafael',1,0,1,'RAPC','','','','',2,0.00,0.00,0,35.00,4.50,1,2,38.00,169.00,39.00,172.00,40.00,174.00,37.50,167.00,37.00,166.00,38.00,169.00,38.00,169.00,500.000,25.000,45.870,1);

COMMIT;

#
# Data for the `pescalonados` table  (LIMIT 0,500)
#

# ID_Pro:3:32769
# ca_peEscalon:3:32768
# campoPrecio:5:32768
# activo:3:32768

INSERT INTO `pescalonados` (`ID_Pro`, `ca_peEscalon`, `campoPrecio`, `activo`) VALUES 
  (2,0,5.00,1),
  (2,9,4.95,1),
  (2,24,4.90,1),
  (2,49,4.85,1),
  (2,99,4.80,1);

COMMIT;

#
# Data for the `codigosb` table  (LIMIT 0,500)
#

# ID_Pro:3:32768
# codBarra:253:0

INSERT INTO `codigosb` (`ID_Pro`, `codBarra`) VALUES 
  (6,'088698200704'),
  (1,'7901451648858'),
  (3,'636920000402'),
  (2,'708988400187'),
  (11,'656565123'),
  (15,'2333'),
  (15,'2334');

COMMIT;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

# rfc:253:1
# curp:253:1
# nombre:253:1
# direccion:253:1
# colonia:253:0
# delegacion:253:0
# cp:253:0
# ciudad:253:0
# contacto:253:0
# tel1:253:0
# tel2:253:0
# alta:10:128
# tipoCliente:3:32769
# credito:5:32768
# tiempoCredito:3:32768
# saldo:5:32768
# bloqueoXPagoV:3:32768
# activo:3:32768

INSERT INTO `clientes` (`rfc`, `curp`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `contacto`, `tel1`, `tel2`, `alta`, `tipoCliente`, `credito`, `tiempoCredito`, `saldo`, `bloqueoXPagoV`, `activo`) VALUES 
  ('feje751115gw1','feje751115','Enrique Fernández Jaimes','Cerro de la libertad #227','Campestre Churubusco','Coyoacan','04200','México, D.F.','Kiko','55497316','56890662','2007-01-29',1,1500.00,5,1500.00,0,1),
  ('becs741225','kfdhfdhf','Sergio Beltran Cardoso','Xochimilco 45','Azteca','Ecatepec','55120','Estado de México','Sergio','57760235','','2007-02-05',1,10000.00,8,10000.00,0,1),
  ('RAPC','020267','RENE      GARCIA','CALLE  12  NOM  26','LEYES DE REFORMA','IZTACALCO','53200','PUEBLA','LA PALMA','56948759','56002607','2007-02-05',1,20000.00,8,20000.00,0,1),
  ('gads800104','gads800104','Sofía Gabián Domínguez','Cerro de la libertad #293 Depto#202','Campestre Churubusco','Coyoacan','04200','México, D.F.','Sofía','','','2007-05-07',0,0.00,0,0.00,0,1),
  ('wer','','wer','wer','wer','wer','23233','wer','','','','2007-05-10',1,5000.00,5,5000.00,0,1);

COMMIT;

#
# Data for the `avisos` table  (LIMIT 0,500)
#

# automatico:3:49671
# frase:253:0
# activo:3:32768

INSERT INTO `avisos` (`automatico`, `frase`, `activo`) VALUES 
  (1,'Este 10 de Mayo en sus compras mayores a $300 lleve a mamá un regalo de sus amigo de \"El Retoño\"',1);

COMMIT;

