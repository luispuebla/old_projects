# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;

USE `vasago`;

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


UPDATE `clientes` SET saldoDisponible = credito WHERE activo = 1;

UPDATE `proveedores` SET saldoDisponible = credito WHERE activo = 1;

