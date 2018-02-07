# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;

USE `vasago`;

#
# Structure for the `regalos_extras` table : 
#

CREATE TABLE `regalos_extras` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` int(7) default NULL,
  `Llego` int(7) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos_orden` table : 
#

CREATE TABLE `productos_orden` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` varchar(12) collate latin1_spanish_ci default NULL,
  `Cantidad` int(7) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` int(7) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `orden_compra` table : 
#

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

