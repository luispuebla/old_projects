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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 11264 kB';

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
  `cantidad` int(4) default NULL,
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
  `existencia` int(4) default NULL,
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
  `maximo` int(4) default NULL,
  `minimo` int(4) default NULL,
  `existencia` int(4) default NULL,
  `piezasXcaja` int(5) default NULL,
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
  `Cantidad` int(7) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` int(7) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 11264 kB';

#
# Structure for the `productos_venta` table : 
#

DROP TABLE IF EXISTS `productos_venta`;

CREATE TABLE `productos_venta` (
  `claveVenta` int(11) default NULL,
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
# Structure for the `regalos_venta` table : 
#

DROP TABLE IF EXISTS `regalos_venta`;

CREATE TABLE `regalos_venta` (
  `claveVenta` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` int(7) default NULL,
  `Llego` int(7) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `tempprodob` table : 
#

DROP TABLE IF EXISTS `tempprodob`;

CREATE TABLE `tempprodob` (
  `claveOrden` int(11) default NULL,
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `cantidad` int(4) default NULL
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
  ('bety','bety','Admin','Beatriz','Vazquez','Perez','Gerente','Admin','1'),
  ('CHAVA','CHAVA','Simple','Salvador','Gonzalez','Plascencia','Agente','Ventas','1'),
  ('piero','piero','Admin','Piero','Gonzalez','Serrano','Gerente','Admin','1')
  ('salvador','salvador','Admin','Salvador','Gonzalez','Plascencia','Gerente','Admin','1');

COMMIT;

