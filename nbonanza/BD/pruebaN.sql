# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : nbonanza


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `nbonanza`;

CREATE DATABASE `nbonanza`;

USE `nbonanza`;

#
# Structure for the `aval_por_documento` table : 
#

DROP TABLE IF EXISTS `aval_por_documento`;

CREATE TABLE `aval_por_documento` (
  `ClaveOrden` int(11) NOT NULL,
  `ClaveProducto` int(6) default NULL,
  `ConsecutivoRecepcion` int(6) unsigned default NULL,
  `Adquisicion` int(1) default '1',
  `Tipo` int(1) default NULL,
  `Cantidad` double(10,3) default NULL,
  `DocAval` varchar(11) collate latin1_spanish_ci default NULL,
  `TipoDocAval` int(1) default NULL,
  `FechaDocAval` date default NULL,
  `Estatus` int(1) default NULL,
  KEY `ClaveOrden` (`ClaveOrden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
  `activo` int(1) default '1',
  PRIMARY KEY  (`rfc`,`nombre`)
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
  `fechaRealPago` date default NULL,
  KEY `numTicket` (`numTicket`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci ;

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
  `tipoDoc` int(1) default NULL,
  `docPadre` varchar(11) collate latin1_spanish_ci default NULL,
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
  `usuario` varchar(8) collate latin1_spanish_ci default NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `descuenta` double(10,3) default NULL,
  `cantidadOriginal` double(10,3) default NULL,
  `nuevaCantidad` double(10,3) default NULL,
  `causa` varchar(100) collate latin1_spanish_ci default NULL,
  `sitio` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci ;

#
# Structure for the `modificainv` table : 
#

DROP TABLE IF EXISTS `modificainv`;

CREATE TABLE `modificainv` (
  `ID_Modifica` int(8) NOT NULL auto_increment,
  `ID_Pro` int(6) default NULL,
  `claveUsuario` varchar(8) collate latin1_spanish_ci default NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `cantidadOriginal` double(10,3) default NULL,
  `nuevaCantidad` double(10,3) default NULL,
  `causa` varchar(100) collate latin1_spanish_ci default NULL,
  `tipo` int(1) default NULL,
  `sitio` int(1) default NULL,
  PRIMARY KEY  (`ID_Modifica`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci ;

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
# Structure for the `permisos` table : 
#

DROP TABLE IF EXISTS `permisos`;

CREATE TABLE `permisos` (
  `Tipo` int(1) default NULL,
  `Clave` int(4) default NULL
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
  `claveProducto` int(6) default NULL,
  `tipoProducto` int(1) default NULL,
  `claveOrden` int(11) default NULL,
  `precioAnterior` double(8,2) default NULL,
  `precioCompra` double(8,2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `prestamos` table : 
#

DROP TABLE IF EXISTS `prestamos`;

CREATE TABLE `prestamos` (
  `clavePrestamo` int(11) NOT NULL auto_increment,
  `claveE` int(4) default NULL,
  `fechaPrestamo` date default NULL,
  `horaPrestamo` time default NULL,
  `cantidadAPagar` double(9,2) default NULL,
  `fechaFiniquito` date default NULL,
  `autorizo` varchar(10) collate latin1_spanish_ci default NULL,
  `estatus` int(1) default NULL,
  PRIMARY KEY  (`clavePrestamo`),
  UNIQUE KEY `clavePrestamo` (`clavePrestamo`)
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
  `materiaPrima` int(1) default '0',
  `cortes` int(1) default '0',
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
  `precioMenu` double(8,2) NOT NULL default '0.00',
  `precioMenuC` double(8,2) NOT NULL default '0.00',
  `precioMM` double(8,2) default '0.00',
  `precioMMC` double(8,2) default '0.00',
  `precioM` double(8,2) default '0.00',
  `precioMC` double(8,2) default '0.00',
  `maxInv` double(8,3) default NULL,
  `minInv` double(8,3) default NULL,
  `invTienda` double(10,3) default '0.000',
  `invAlmacen` double(10,3) default '0.000',
  `activo` int(1) default '1',
  PRIMARY KEY  (`ID_Pro`),
  UNIQUE KEY `ID_Pro` (`ID_Pro`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos_orden` table : 
#

DROP TABLE IF EXISTS `productos_orden`;

CREATE TABLE `productos_orden` (
  `ClaveOrden` int(11) NOT NULL,
  `ClaveProducto` int(6) NOT NULL,
  `Cantidad` double(10,3) default NULL,
  `Tipo` int(1) NOT NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` double(10,3) default NULL,
  `Adquisicion` int(1) default NULL,
  KEY `ClaveOrden` (`ClaveOrden`)
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
  `activo` int(1) default NULL,
  KEY `rfc` (`rfc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `salidas` table : 
#

DROP TABLE IF EXISTS `salidas`;

CREATE TABLE `salidas` (
  `numTicket` int(10) NOT NULL default '0',
  `fechaVenta` date NOT NULL default '0000-00-00',
  `horaVenta` time NOT NULL,
  `sumaVenta` double(8,2) default '0.00',
  `factura` int(1) default '0',
  `tipoCobro` int(1) default NULL,
  `referenciaCobro` varchar(40) collate latin1_spanish_ci default NULL,
  `usuario` varchar(20) collate latin1_spanish_ci default NULL,
  `activo` int(1) default '1',
  KEY `numTicket` (`numTicket`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci ;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `vendedores` table : 
#

DROP TABLE IF EXISTS `vendedores`;

CREATE TABLE `vendedores` (
  `claveVenta` int(4) NOT NULL auto_increment,
  `NombreE` varchar(50) default NULL,
  `clavePermiso` int(4) default NULL,
  `permisoCobro` int(1) unsigned default '0',
  `salario` double(8,2) default NULL,
  `direccion` varchar(80) default NULL,
  `telCasa` varchar(15) default NULL,
  `telCel` varchar(15) default NULL,
  `observacion` varchar(80) default NULL,
  `estatus` int(1) default '1',
  PRIMARY KEY  (`claveVenta`),
  UNIQUE KEY `claveVenta` (`claveVenta`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

#
# Data for the `avisos` table  (LIMIT 0,500)
#

# automatico:3:49671
# frase:253:0
# activo:3:32768

INSERT INTO `avisos` (`automatico`, `frase`, `activo`) VALUES 
  (1,'Pregunte por nuestras canastas navideñas, el mejor regalo para esta fiestas decembrinas.',1);

COMMIT;

#
# Data for the `cancelacion` table  (LIMIT 0,500)
#

# claveCancela:3:49667
# numTicket:3:32769
# fechaTicket:10:128
# tipoTicket:3:32800
# cajeroTicket:253:0
# montoTotal:5:32768
# fechaBaja:10:128
# horaBaja:11:128

INSERT INTO `cancelacion` (`claveCancela`, `numTicket`, `fechaTicket`, `tipoTicket`, `cajeroTicket`, `montoTotal`, `fechaBaja`, `horaBaja`) VALUES 
  (1,1,'2007-11-14',2,'',1716.90,'2007-11-14','17:55:09'),
  (2,7,'2007-11-14',2,'',103.21,'2007-11-14','17:55:21'),
  (3,2,'2007-11-14',1,'1',478.00,'2007-11-14','17:59:08'),
  (4,11,'2007-11-15',2,'',856.13,'2007-11-15','17:35:35'),
  (5,11,'2007-11-15',2,'',856.13,'2007-11-15','17:36:23');

COMMIT;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

# rfc:253:16387
# curp:253:1
# nombre:253:16387
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
  ('feje751115gw1','feje751115','Enrique Fernández Jaimes','Cerro de la libertad #227','Campestre Churubusco','Coyoacan','04200','México, D.F.','Enrique Fernández','56464578','','2007-11-14',1,50000.00,10,48179.89,0,1);

COMMIT;

#
# Data for the `codigosb` table  (LIMIT 0,500)
#

# ID_Pro:3:32768
# codBarra:253:0

INSERT INTO `codigosb` (`ID_Pro`, `codBarra`) VALUES 
  (2,'21'),
  (2,'22'),
  (2,'23'),
  (2,'24'),
  (2,'25'),
  (2,'26'),
  (2,'27'),
  (3,'54564'),
  (3,'54545');

COMMIT;

#
# Data for the `contenidoticket` table  (LIMIT 0,500)
#

# numTicket:3:49161
# fechaRegistro:10:129
# horaRegistro:11:128
# ID_Pro:3:32769
# claveVendedor:3:32769
# tipoVenta:3:32769
# tipoPrecio:3:32768
# precioVenta:5:32769
# cantidadProducto:5:32768
# pesoEnPz:5:32768
# estatusPago:3:32768
# precioAPagar:5:32769
# estatusTicket:3:32768
# fechaRealPago:10:128

INSERT INTO `contenidoticket` (`numTicket`, `fechaRegistro`, `horaRegistro`, `ID_Pro`, `claveVendedor`, `tipoVenta`, `tipoPrecio`, `precioVenta`, `cantidadProducto`, `pesoEnPz`, `estatusPago`, `precioAPagar`, `estatusTicket`, `fechaRealPago`) VALUES 
  (1,'2007-11-14','11:08:25',1,1,3,0,180.00,1.500,0.000,2,270.00,1,NULL),
  (1,'2007-11-14','11:08:54',2,1,4,0,280.00,1.000,4.400,2,280.00,1,NULL),
  (1,'2007-11-14','11:09:01',3,1,2,7,5.90,66.000,0.000,2,389.40,1,NULL),
  (1,'2007-11-14','11:09:21',4,1,2,1,7.00,10.000,0.000,2,70.00,1,NULL),
  (1,'2007-11-14','11:09:42',5,1,1,2,55.00,1.500,0.000,2,82.50,1,NULL),
  (1,'2007-11-14','11:10:11',6,1,1,3,25.00,25.000,0.000,2,625.00,1,NULL),
  (2,'2007-11-14','11:23:01',1,1,2,0,18.00,11.000,0.000,0,198.00,1,NULL),
  (2,'2007-11-14','11:25:57',2,1,4,0,280.00,1.000,4.450,0,280.00,1,NULL),
  (3,'2007-11-14','11:39:57',1,1,3,0,180.00,1.000,0.000,0,180.00,1,NULL),
  (4,'2007-11-14','11:40:21',3,1,2,7,6.00,15.000,0.000,1,90.00,1,'2007-11-14'),
  (5,'2007-11-14','11:42:23',3,1,2,7,5.95,33.000,0.000,1,196.35,1,'2007-11-14'),
  (6,'2007-11-14','11:51:31',4,2,2,0,7.50,25.000,0.000,0,187.50,2,NULL),
  (7,'2007-11-14','11:56:41',1,1,2,0,18.00,2.000,0.000,2,36.00,1,NULL),
  (7,'2007-11-14','11:56:57',5,1,1,2,55.00,1.222,0.000,2,67.21,1,NULL),
  (8,'2007-11-14','11:58:26',6,1,1,3,20.00,1.000,0.000,1,20.00,1,'2007-11-14'),
  (9,'2007-11-14','12:42:18',6,2,1,2,26.50,3.666,0.000,1,97.15,1,'2007-11-14'),
  (9,'2007-11-14','12:57:57',1,2,3,2,170.00,1.000,0.000,1,170.00,1,'2007-11-14'),
  (9,'2007-11-14','12:58:32',5,2,4,3,200.00,1.500,5.000,1,300.00,1,'2007-11-14'),
  (10,'2007-11-14','20:01:44',1,1,2,1,17.50,15.000,0.000,1,262.50,1,'2007-11-14'),
  (10,'2007-11-14','20:02:01',2,1,1,0,64.00,1.533,0.000,1,98.11,1,'2007-11-14'),
  (10,'2007-11-14','20:02:18',3,1,2,7,5.80,100.000,0.000,1,580.00,1,'2007-11-14'),
  (10,'2007-11-14','20:02:33',4,1,2,0,7.50,15.000,0.000,1,112.50,1,'2007-11-14'),
  (10,'2007-11-14','20:03:01',5,1,1,0,60.00,0.555,0.000,1,33.30,1,'2007-11-14'),
  (10,'2007-11-14','20:03:18',6,1,1,0,30.00,5.555,0.000,1,166.65,1,'2007-11-14'),
  (11,'2007-11-15','16:01:52',1,1,3,0,180.00,1.500,0.000,2,270.00,1,NULL),
  (11,'2007-11-15','16:02:10',2,1,4,0,280.00,1.000,4.450,2,280.00,1,NULL),
  (11,'2007-11-15','16:02:20',3,1,2,7,5.95,35.000,0.000,2,208.25,1,NULL),
  (11,'2007-11-15','16:02:27',4,1,2,0,7.50,11.000,0.000,2,82.50,1,NULL),
  (11,'2007-11-15','16:03:13',5,1,1,3,30.00,0.300,0.000,2,9.00,1,NULL),
  (11,'2007-11-15','16:03:26',6,1,1,1,28.50,0.224,0.000,2,6.38,1,NULL),
  (12,'2007-11-17','11:58:40',3,1,2,7,6.00,1.000,0.000,0,6.00,1,NULL),
  (12,'2007-11-17','11:58:58',4,1,2,3,5.00,15.000,0.000,0,75.00,1,NULL);

COMMIT;

#
# Data for the `creditos` table  (LIMIT 0,500)
#

# numTicket:3:32769
# fechaCredito:10:128
# fechaAPagar:10:128
# rfc:253:0
# nombreCliente:253:0
# cantidadAPagar:5:32768
# factura:3:32768
# tipoCobro:3:32768
# referenciaCobro:253:0
# usuario:253:0
# fechaRealPago:10:128
# usuarioPago:253:0
# estatusCredito:3:32768
# activo:3:32768

INSERT INTO `creditos` (`numTicket`, `fechaCredito`, `fechaAPagar`, `rfc`, `nombreCliente`, `cantidadAPagar`, `factura`, `tipoCobro`, `referenciaCobro`, `usuario`, `fechaRealPago`, `usuarioPago`, `estatusCredito`, `activo`) VALUES 
  (7,'2007-11-14','2007-11-26','feje751115gw1','Enrique Fernández Jaimes',103.21,0,0,'','super',NULL,'',0,0),
  (1,'2007-11-14','2007-11-24','feje751115gw1','Enrique Fernández Jaimes',1716.90,0,0,'','super',NULL,'',0,0),
  (1,'2007-11-14','2007-11-24','feje751115gw1','Enrique Fernández Jaimes',1716.90,0,0,'','super',NULL,'',0,1),
  (7,'2007-11-14','2007-11-24','feje751115gw1','Enrique Fernández Jaimes',103.21,0,0,'','super',NULL,'',0,1),
  (11,'2007-11-15','2007-11-17','1','creditoInterno',856.13,0,0,'','super',NULL,'',0,1),
  (11,'2007-11-15','2007-11-26','feje751115gw1','Enrique Fernández Jaimes',856.13,0,0,'','super',NULL,'',0,0),
  (11,'2007-11-15','2007-11-17','2','creditoInterno',856.13,0,0,'','super',NULL,'',0,0);

COMMIT;

#
# Data for the `facventas` table  (LIMIT 0,500)
#

# numFactura:253:0
# tickets:253:0
# rfc:253:0
# nombre:253:0
# fechaFac:10:128
# fechaCrea:10:128
# tasa0:5:32768
# tasa15:5:32768
# iva:5:32768
# total:5:32768
# estatus:3:32768
# cantXFac:3:32768

INSERT INTO `facventas` (`numFactura`, `tickets`, `rfc`, `nombre`, `fechaFac`, `fechaCrea`, `tasa0`, `tasa15`, `iva`, `total`, `estatus`, `cantXFac`) VALUES 
  ('3785','1%7','feje751115gw1','Enrique Fernández Jaimes','2007-11-14','2007-11-14',1820.11,0.00,0.00,1820.11,0,14),
  ('3785','10%9%8%7%1','feje751115gw1','Enrique Fernández Jaimes','2007-11-14','2007-11-14',2738.42,0.00,0.00,2738.42,0,14),
  ('3786','10%9%8%7%1','feje751115gw1','Enrique Fernández Jaimes','2007-11-14','2007-11-14',921.90,0.00,0.00,921.90,0,14);

COMMIT;

#
# Data for the `mermas` table  (LIMIT 0,500)
#

# ID_Pro:3:32768
# usuario:253:0
# fecha:10:128
# hora:11:128
# descuenta:5:32768
# cantidadOriginal:5:32768
# nuevaCantidad:5:32768
# causa:253:0
# sitio:3:32768

INSERT INTO `mermas` (`ID_Pro`, `usuario`, `fecha`, `hora`, `descuenta`, `cantidadOriginal`, `nuevaCantidad`, `causa`, `sitio`) VALUES 
  (2,'super','2007-10-27','10:19:58',0.500,7.500,7.000,'Descuento .5 de Almacen',2),
  (2,'super','2007-10-27','10:20:57',0.750,26.500,25.750,'Descuento .750 de Tienda',1),
  (2,'super','2007-10-27','10:21:52',0.250,25.750,25.500,'Descuento de ambos para dejarlas con .500',1),
  (2,'super','2007-10-27','10:21:52',0.500,7.000,6.500,'Descuento de ambos para dejarlas con .500',2);

COMMIT;

#
# Data for the `modificainv` table  (LIMIT 0,500)
#

# ID_Modifica:3:49667
# ID_Pro:3:32768
# claveUsuario:253:0
# fecha:10:128
# hora:11:128
# cantidadOriginal:5:32768
# nuevaCantidad:5:32768
# causa:253:0
# tipo:3:32768
# sitio:3:32768

INSERT INTO `modificainv` (`ID_Modifica`, `ID_Pro`, `claveUsuario`, `fecha`, `hora`, `cantidadOriginal`, `nuevaCantidad`, `causa`, `tipo`, `sitio`) VALUES 
  (22,2,'super','2007-10-27','10:19:58',7.500,7.000,'Descuento .5 de Almacen',2,2),
  (23,2,'super','2007-10-27','10:20:57',26.500,25.750,'Descuento .750 de Tienda',2,1),
  (24,2,'super','2007-10-27','10:21:52',25.750,25.500,'Descuento de ambos para dejarlas con .500',2,1),
  (25,2,'super','2007-10-27','10:21:52',7.000,6.500,'Descuento de ambos para dejarlas con .500',2,2),
  (26,1,'super','2007-11-02','18:12:21',258.000,300.000,'Prueba en punto de Venta',1,1),
  (27,1,'super','2007-11-02','18:12:21',9.000,0.000,'Prueba en punto de Venta',1,2),
  (28,1,'super','2007-11-02','18:12:58',300.000,0.000,'Prueb',1,1),
  (29,1,'super','2007-11-02','18:15:56',0.000,1.000,'Test',1,2),
  (30,1,'super','2007-11-02','18:27:15',0.000,1.000,'Prueba',1,1),
  (31,1,'super','2007-11-14','10:34:41',1.000,150.000,'Regalo',1,1),
  (32,1,'super','2007-11-14','10:55:29',150.000,1.000,'Prueba Inventario',1,1),
  (33,1,'super','2007-11-14','10:58:56',1.000,150.000,'2',1,1);

COMMIT;

#
# Data for the `permisos` table  (LIMIT 0,500)
#

# Tipo:3:32768
# Clave:3:32768

INSERT INTO `permisos` (`Tipo`, `Clave`) VALUES 
  (1,123),
  (2,4321);

COMMIT;

#
# Data for the `pescalonados` table  (LIMIT 0,500)
#

# ID_Pro:3:32769
# ca_peEscalon:3:32768
# campoPrecio:5:32768
# activo:3:32768

INSERT INTO `pescalonados` (`ID_Pro`, `ca_peEscalon`, `campoPrecio`, `activo`) VALUES 
  (3,0,6.00,1),
  (3,24,5.95,1),
  (3,49,5.90,1),
  (3,99,5.80,1),
  (3,499,5.70,1);

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

# ID_Pro:3:49671
# descripcion:253:0
# tipoPro:3:32768
# gravaIVA:3:32768
# genero:3:32768
# materiaPrima:3:32768
# cortes:3:32768
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
# precioMenu:5:32769
# precioMenuC:5:32769
# precioMM:5:32768
# precioMMC:5:32768
# precioM:5:32768
# precioMC:5:32768
# maxInv:5:32768
# minInv:5:32768
# invTienda:5:32768
# invAlmacen:5:32768
# activo:3:32768

INSERT INTO `productos` (`ID_Pro`, `descripcion`, `tipoPro`, `gravaIVA`, `genero`, `materiaPrima`, `cortes`, `id_prov1`, `id_prov2`, `id_prov3`, `id_prov4`, `id_prov5`, `uniCompra`, `precioUniCompra`, `preCaCompra`, `cantidadXCaja`, `precioUnidadKG`, `kgXUnidad`, `tipoPrecio`, `manejoPrecio`, `precioMenu`, `precioMenuC`, `precioMM`, `precioMMC`, `precioM`, `precioMC`, `maxInv`, `minInv`, `invTienda`, `invAlmacen`, `activo`) VALUES 
  (1,'Crema Lala de 1Lt.',0,0,1,1,0,'FEJE751115GW1','','','','',1,15.00,150.00,10,0.00,0.00,1,1,18.00,180.00,17.50,175.00,17.00,170.00,1500.000,300.000,93.000,1.000,1),
  (2,'Jamón Serrano El Vasco',1,0,1,0,0,'FEJE751115GW1','','','','',2,0.00,0.00,0,50.00,4.50,0,2,64.00,280.00,64.00,280.00,64.00,280.00,50.000,25.000,2.385,6.500,1),
  (3,'Coca Cola 1 Lt',0,0,2,0,0,'FEJE751115GW1','','','','',1,5.00,50.00,10,0.00,0.00,2,0,6.00,0.00,0.00,0.00,0.00,0.00,5000.000,200.000,4251.000,1500.000,1),
  (4,'Tostadas Charras',0,0,1,0,0,'FEJE751115GW1','','','','',1,5.00,50.00,10,0.00,0.00,1,0,7.50,0.00,7.00,0.00,6.50,0.00,1500.000,10.000,214.000,0.000,1),
  (5,'Jamón Zwan Horneado',1,0,1,0,0,'FEJE751115GW1','','','','',2,0.00,0.00,0,50.00,3.50,1,2,60.00,210.00,57.50,201.25,55.00,192.50,500.000,5.000,317.203,0.000,1),
  (6,'Queso Panela Hoster',1,0,1,0,0,'FEJE751115GW1','','','','',2,0.00,0.00,0,24.00,2.50,1,0,30.00,0.00,28.50,0.00,26.50,0.00,250.000,5.000,92.055,0.000,1);

COMMIT;

#
# Data for the `proveedores` table  (LIMIT 0,500)
#

# rfc:253:16392
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
  ('FEJE751115GW1','Enrique Fernández Jaimes','Cerro de la libertad #227','Campestre Churubusco','Coyoacan','04200','México, D.F.','56464578','55497316','56890662','www.alphanet.com.mx','enrique@alphanet.com.mx','Enrique o Sofía',2,'',1,50000.00,15,3.00,2.00,0.00,50000.00,'2007-10-02',1);

COMMIT;

#
# Data for the `salidas` table  (LIMIT 0,500)
#

# numTicket:3:49161
# fechaVenta:10:129
# horaVenta:11:4225
# sumaVenta:5:32768
# factura:3:32768
# tipoCobro:3:32768
# referenciaCobro:253:0
# usuario:253:0
# activo:3:32768

INSERT INTO `salidas` (`numTicket`, `fechaVenta`, `horaVenta`, `sumaVenta`, `factura`, `tipoCobro`, `referenciaCobro`, `usuario`, `activo`) VALUES 
  (2,'2007-11-14','11:37:34',478.00,0,1,'','1',0),
  (4,'2007-11-14','11:40:36',90.00,0,1,'','1',1),
  (5,'2007-11-14','11:42:35',196.35,0,1,'','1',1),
  (8,'2007-11-14','11:58:39',20.00,0,1,'','1',1),
  (9,'2007-11-14','17:06:47',567.15,0,1,'','super',1),
  (10,'2007-11-14','20:04:43',1253.06,0,1,'','super',1);

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
  ('Super','super','administrador','Administrador',1,2006,0,1),
  ('Factura','factura','simple','Factura',2,1738,0,1),
  ('Caja','caja','simple','Caja',3,0,0,1);

COMMIT;

#
# Data for the `vendedores` table  (LIMIT 0,500)
#

# claveVenta:3:49671
# NombreE:253:0
# clavePermiso:3:32768
# permisoCobro:3:32800
# salario:5:32768
# direccion:253:0
# telCasa:253:0
# telCel:253:0
# observacion:253:0
# estatus:3:32768

INSERT INTO `vendedores` (`claveVenta`, `NombreE`, `clavePermiso`, `permisoCobro`, `salario`, `direccion`, `telCasa`, `telCel`, `observacion`, `estatus`) VALUES 
  (1,'Fernández Jaimes Enrique',123,1,4500.00,'Cerro de la libertad #293 - #202, Col. Camp. Churubusco, Coyoacan, Mex, D.F.','55497316','56464578','',1),
  (2,'Gabián Domínguez Sofía',123,1,4500.00,'','55497316','5518867271','',1),
  (3,'Roberto Gómez Pedraza',0,0,525.00,'Tecamac #35, Col. Heroes de la Independencia, Ecatepec, Edo. Mex.','9172547859','55487756545','',1);

COMMIT;

