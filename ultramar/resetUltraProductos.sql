# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : ultramarina


SET FOREIGN_KEY_CHECKS=0;

USE `ultramarina`;

#
# Structure for the `traspasoautomatico` table : 
#

DROP TABLE IF EXISTS `traspasoautomatico`;

CREATE TABLE `traspasoautomatico` (
  `Cantidad` int(4) default NULL,
  `MatPClave` int(11) default NULL,
  `Fecha` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `alimentos` table : 
#

DROP TABLE IF EXISTS `alimentos`;

CREATE TABLE `alimentos` (
  `clave` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) collate latin1_spanish_ci default NULL,
  `descripcion` varchar(100) collate latin1_spanish_ci default NULL,
  `materia0` int(11) default NULL,
  `materia1` int(11) default NULL,
  `materia2` int(11) default NULL,
  `materia3` int(11) default NULL,
  `materia4` int(11) default NULL,
  `materia5` int(11) default NULL,
  `materia6` int(11) default NULL,
  `materia7` int(11) default NULL,
  `materia8` int(11) default NULL,
  `materia9` int(11) default NULL,
  `cantidad0` double(8,3) default NULL,
  `cantidad1` double(8,3) default NULL,
  `cantidad2` double(8,3) default NULL,
  `cantidad3` double(8,3) default NULL,
  `cantidad4` double(8,3) default NULL,
  `cantidad5` double(8,3) default NULL,
  `cantidad6` double(8,3) default NULL,
  `cantidad7` double(8,3) default NULL,
  `cantidad8` double(8,3) default NULL,
  `cantidad9` double(8,3) default NULL,
  `precio` double(8,2) default NULL,
  `division` int(11) default NULL,
  `estatus` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `bebidas` table : 
#

DROP TABLE IF EXISTS `bebidas`;

CREATE TABLE `bebidas` (
  `clave` int(11) NOT NULL auto_increment,
  `nombre` varchar(50) collate latin1_spanish_ci default NULL,
  `descripcion` varchar(100) collate latin1_spanish_ci default NULL,
  `materia0` int(11) default NULL,
  `materia1` int(11) default NULL,
  `materia2` int(11) default NULL,
  `materia3` int(11) default NULL,
  `materia4` int(11) default NULL,
  `materia5` int(11) default NULL,
  `materia6` int(11) default NULL,
  `materia7` int(11) default NULL,
  `materia8` int(11) default NULL,
  `materia9` int(11) default NULL,
  `cantidad0` double(8,3) default NULL,
  `cantidad1` double(8,3) default NULL,
  `cantidad2` double(8,3) default NULL,
  `cantidad3` double(8,3) default NULL,
  `cantidad4` double(8,3) default NULL,
  `cantidad5` double(8,3) default NULL,
  `cantidad6` double(8,3) default NULL,
  `cantidad7` double(8,3) default NULL,
  `cantidad8` double(8,3) default NULL,
  `cantidad9` double(8,3) default NULL,
  `precioC` double(8,2) default NULL,
  `precioB1` double(8,2) default NULL,
  `precioB2` double(8,2) default NULL,
  `division` int(11) default NULL,
  `estatus` int(1) default NULL,
  `alcoholica` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `comanda` table : 
#

DROP TABLE IF EXISTS `comanda`;

CREATE TABLE `comanda` (
  `IDC` int(8) unsigned NOT NULL auto_increment,
  `IDMM` int(2) unsigned NOT NULL default '0',
  `IDM` int(4) unsigned NOT NULL default '0',
  `FA` date default NULL,
  `TA` time default NULL,
  `NC` int(4) default NULL,
  `PT` double(8,2) default NULL,
  `Es` int(1) default '1',
  PRIMARY KEY  (`IDC`),
  UNIQUE KEY `IDC` (`IDC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `comandapro` table : 
#

DROP TABLE IF EXISTS `comandapro`;

CREATE TABLE `comandapro` (
  `IDC` int(8) default NULL,
  `IDM` int(4) default NULL,
  `IDCom` int(4) default NULL,
  `HR` time default NULL,
  `DiA` date default NULL,
  `Ge` int(1) default NULL,
  `Di` int(11) default NULL,
  `CanPro` int(2) default NULL,
  `ClPro` int(11) default NULL,
  `Tipo` int(1) default NULL,
  `Ob` varchar(30) collate latin1_spanish_ci default NULL,
  `PU` double(8,2) default NULL,
  `PT` double(8,2) default NULL,
  `Estatus` int(1) default NULL,
  `IDSecuencia` int(3) default NULL,
  `IDImpresion` int(1) default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 7168 kB';

#
# Structure for the `division` table : 
#

DROP TABLE IF EXISTS `division`;

CREATE TABLE `division` (
  `clave` int(11) NOT NULL auto_increment,
  `nombre` varchar(30) collate latin1_spanish_ci default NULL,
  `area` int(1) default NULL,
  `estatus` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `materiaprima` table : 
#

DROP TABLE IF EXISTS `materiaprima`;

CREATE TABLE `materiaprima` (
  `clave` int(11) NOT NULL auto_increment,
  `nombre` varchar(40) default NULL,
  `tipo` int(1) default NULL,
  `tipoA` int(1) default NULL,
  `KgXUnidad` double(8,3) default NULL,
  `litrosXBotella1` double(8,3) default NULL,
  `litrosXBotella2` double(8,3) default NULL,
  `inventarioKG` double(10,3) default NULL,
  `inventarioUnidad` int(11) default NULL,
  `inventarioBotella1` int(11) default NULL,
  `inventarioBotella2` int(11) default NULL,
  `inventarioCopeo` double(15,3) default NULL,
  `costoKG` double(8,2) default NULL,
  `costoUnidad` double(8,2) default NULL,
  `costoBotella1` double(8,2) default NULL,
  `costoBotella2` double(8,2) default NULL,
  `Estatus` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `tempcom` table : 
#

DROP TABLE IF EXISTS `tempcom`;

CREATE TABLE `tempcom` (
  `IDC` int(8) unsigned default NULL,
  `IDM` int(4) default NULL,
  `IDD` int(11) default NULL,
  `IDG` int(1) default NULL,
  `IDCP` int(11) default NULL,
  `IDT` int(1) default NULL,
  `CP` int(2) default NULL,
  `IDCom` int(4) default NULL,
  `Ob` varchar(30) collate latin1_spanish_ci default NULL,
  `PU` double(8,2) default NULL,
  `PT` double(8,2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Data for the `traspasoautomatico` table  (LIMIT 0,500)
#

# Cantidad:3:32768
# MatPClave:3:32768
# Fecha:10:128



#
# Data for the `alimentos` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# descripcion:253:0
# materia0:3:32768
# materia1:3:32768
# materia2:3:32768
# materia3:3:32768
# materia4:3:32768
# materia5:3:32768
# materia6:3:32768
# materia7:3:32768
# materia8:3:32768
# materia9:3:32768
# cantidad0:5:32768
# cantidad1:5:32768
# cantidad2:5:32768
# cantidad3:5:32768
# cantidad4:5:32768
# cantidad5:5:32768
# cantidad6:5:32768
# cantidad7:5:32768
# cantidad8:5:32768
# cantidad9:5:32768
# precio:5:32768
# division:3:32768
# estatus:3:32768

INSERT INTO `alimentos` (`clave`, `nombre`, `descripcion`, `materia0`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `materia9`, `cantidad0`, `cantidad1`, `cantidad2`, `cantidad3`, `cantidad4`, `cantidad5`, `cantidad6`, `cantidad7`, `cantidad8`, `cantidad9`, `precio`, `division`, `estatus`) VALUES 
  (1,'Pechuga Parmesana','Pechuga de Pollo con Queso Parmesano y Arroz Blanco',8,9,3,0,0,0,0,0,0,0,0.300,0.250,0.150,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,1,1),
  (2,'Pechuga a la Plancha','Pechuga de Pollo y Arroz Blanco',8,9,0,0,0,0,0,0,0,0,0.500,0.300,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,1,1),
  (3,'Carne Asada','Carne Asada con Frijoles y guacamole',2,3,9,0,0,0,0,0,0,0,0.350,0.200,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,80.00,2,1);

COMMIT;

#
# Data for the `bebidas` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# descripcion:253:0
# materia0:3:32768
# materia1:3:32768
# materia2:3:32768
# materia3:3:32768
# materia4:3:32768
# materia5:3:32768
# materia6:3:32768
# materia7:3:32768
# materia8:3:32768
# materia9:3:32768
# cantidad0:5:32768
# cantidad1:5:32768
# cantidad2:5:32768
# cantidad3:5:32768
# cantidad4:5:32768
# cantidad5:5:32768
# cantidad6:5:32768
# cantidad7:5:32768
# cantidad8:5:32768
# cantidad9:5:32768
# precioC:5:32768
# precioB1:5:32768
# precioB2:5:32768
# division:3:32768
# estatus:3:32768
# alcoholica:3:32768

INSERT INTO `bebidas` (`clave`, `nombre`, `descripcion`, `materia0`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `materia9`, `cantidad0`, `cantidad1`, `cantidad2`, `cantidad3`, `cantidad4`, `cantidad5`, `cantidad6`, `cantidad7`, `cantidad8`, `cantidad9`, `precioC`, `precioB1`, `precioB2`, `division`, `estatus`, `alcoholica`) VALUES 
  (1,'Tequila Reserva Especial Don Julio','Añejado por 10 años',4,0,0,0,0,0,0,0,0,0,0.000,0.750,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,480.00,0.00,3,1,1),
  (2,'Tequila Jimador','Bravo de Jalisco',5,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,220.00,0.00,3,1,1),
  (3,'Paloma Jimador','Refrescante',5,0,0,0,0,0,0,0,0,0,0.150,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,3,1,1),
  (4,'Vino tinto Sangre de Toro','Cabernet Sauvigon',6,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,350.00,250.00,5,1,1),
  (5,'Vino Blanco Blue Rhin','Aleman de Origen',7,0,0,0,0,0,0,0,0,0,0.300,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,180.00,130.00,5,1,1),
  (6,'Charro Vikingo','Mezcla de Vino Blanco Aleman con tequila Jimador',5,7,0,0,0,0,0,0,0,0,0.200,0.350,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,0.00,0.00,4,1,1);

COMMIT;

#
# Data for the `comanda` table  (LIMIT 0,500)
#

# IDC:3:49703
# IDMM:3:32801
# IDM:3:32801
# FA:10:128
# TA:11:128
# NC:3:32768
# PT:5:32768
# Es:3:32768

INSERT INTO `materiaprima` (`clave`, `nombre`, `tipo`, `tipoA`, `KgXUnidad`, `litrosXBotella1`, `litrosXBotella2`, `inventarioKG`, `inventarioUnidad`, `inventarioBotella1`, `inventarioBotella2`, `inventarioCopeo`, `costoKG`, `costoUnidad`, `costoBotella1`, `costoBotella2`, `Estatus`) VALUES
  (1,'Atún Tunny',1,2,0.350,0.000,0.000,0.000,10,0,0,0.000,0.00,8.50,0.00,0.00,1),
  (2,'Carne Tampiqueña',1,1,0.000,0.000,0.000,7.852,0,0,0,0.000,33.48,0.00,0.00,0.00,1),
  (3,'Frijoles La Costeña',1,2,0.300,0.000,0.000,0.125,8,0,0,0.000,0.00,7.80,0.00,0.00,1),
  (4,'Tequila Don Julio Reserva Especial',2,0,0.000,0.750,0.000,0.000,0,8,0,0.000,0.00,0.00,282.68,0.00,1),
  (5,'Tequila Jimador',2,0,0.000,0.750,0.000,0.000,0,8,0,0.384,0.00,0.00,87.50,0.00,1),
  (6,'Vino Tinto Sangre de Toro',2,0,NULL,0.750,0.500,0.000,0,5,3,0.200,0.00,0.00,230.00,150.00,1),
  (7,'Vino Blanco Rhin Blue Nun',2,0,0.000,0.850,0.500,0.000,0,8,5,0.300,0.00,0.00,120.00,80.00,1),
  (8,'Pollo',1,1,0.000,0.000,0.000,4.500,0,0,0,0.000,21.50,0.00,0.00,0.00,1),
  (9,'Jitomate',1,1,0.000,0.000,0.000,6.500,0,0,0,0.000,27.50,0.00,0.00,0.00,1);

COMMIT;

#
# Data for the `division` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# area:3:32768
# estatus:3:32768

INSERT INTO `division` (`clave`, `nombre`, `area`, `estatus`) VALUES 
  (1,'Pollos',1,1),
  (2,'Carnes',1,1),
  (3,'Tequila',2,1),
  (4,'Preparadas',2,1),
  (5,'Vinos',2,1);

COMMIT;

