# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : ultramarina


SET FOREIGN_KEY_CHECKS=0;



USE `ultramarina`;

#
# Structure for the `facturaventa` table : 
#
CREATE TABLE `tempinterno` (
  `IDPersonal` int(4) default NULL,
  `IDD` int(11) default NULL,
  `IDG` int(1) default NULL,
  `IDCP` int(11) default NULL,
  `IDT` int(1) default NULL,
  `CP` int(2) default NULL,
  `Ob` varchar(30) collate latin1_spanish_ci default NULL,
  `PU` double(8,2) default NULL,
  `PT` double(8,2) default NULL,
  `TB` int(1) default NULL,
  `FB` int(1) default NULL,
  `MB` int(1) default NULL,
  `AB` int(1) default NULL,
  `CA1` int(2) default NULL,
  `CA2` int(2) default NULL,
  `CA3` int(2) default NULL,
  `CA4` int(2) default NULL,
  `CB1` int(6) default NULL,
  `CB2` int(6) default NULL,
  `CB3` int(6) default NULL,
  `CB4` int(6) default NULL,
  `TB1` int(1) default NULL,
  `TB2` int(1) default NULL,
  `TB3` int(1) default NULL,
  `TB4` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

CREATE TABLE `internopro` (
  `IDPersonal` int(4) default NULL,
  `HR` time default NULL,
  `DiA` date default NULL,
  `Ge` int(1) default NULL,
  `Di` int(1) default NULL,
  `CanPro` int(2) default NULL,
  `ClPro` int(11) default NULL,
  `Tipo` int(1) default NULL,
  `Ob` varchar(30) collate latin1_spanish_ci default NULL,
  `PU` double(8,2) default NULL,
  `PT` double(8,2) default NULL,
  `Estatus` int(1) default NULL,
  `IDImpresion` int(11) default NULL,
  `TB` int(1) default NULL,
  `FB` int(1) default NULL,
  `MB` int(1) default NULL,
  `AB` int(1) default NULL,
  `CA1` int(2) default NULL,
  `CA2` int(2) default NULL,
  `CA3` int(2) default NULL,
  `CA4` int(2) default NULL,
  `CB1` int(6) default NULL,
  `CB2` int(6) default NULL,
  `CB3` int(6) default NULL,
  `CB4` int(6) default NULL,
  `TB1` int(1) default NULL,
  `TB2` int(1) default NULL,
  `TB3` int(1) default NULL,
  `TB4` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci