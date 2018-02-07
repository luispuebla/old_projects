# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;

USE `vasago`;

#
# Structure for the `productos` table : 
#

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
  `activo` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

