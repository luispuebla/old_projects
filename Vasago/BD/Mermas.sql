# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;


USE `vasago`;

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

