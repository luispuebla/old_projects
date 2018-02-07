# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;

USE `vasago`;

#
# Structure for the `marca` table : 
#

CREATE TABLE `marca` (
  `clave` char(3) collate latin1_spanish_ci default NULL,
  `nombre` varchar(40) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

