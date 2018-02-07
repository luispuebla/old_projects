# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : nbonanza


SET FOREIGN_KEY_CHECKS=0;

USE `nbonanza`;

#
# Structure for the `ticket_ligado` table : 
#

DROP TABLE IF EXISTS `ticket_ligado`;

CREATE TABLE `ticket_ligado` (
  `ID_Liga` int(8) unsigned NOT NULL auto_increment,
  `numTicket` int(10) default NULL,
  `fechaTicket` date default NULL,
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombre` varchar(60) collate latin1_spanish_ci default NULL,
  `claveVendedor` int(4) default NULL,
  `estatus` int(1) unsigned default '0',
  PRIMARY KEY  (`ID_Liga`),
  UNIQUE KEY `ID_Liga` (`ID_Liga`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

