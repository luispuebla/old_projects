# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : ultramarina


SET FOREIGN_KEY_CHECKS=0;



USE `ultramarina`;

#
# Structure for the `materiaprima` table : 
#

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
# Structure for the `alimentos` table : 
#

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
# Data for the `materiaprima` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# tipo:3:32768
# tipoA:3:32768
# KgXUnidad:5:32768
# litrosXBotella1:5:32768
# litrosXBotella2:5:32768
# inventarioKG:5:32768
# inventarioUnidad:3:32768
# inventarioBotella1:3:32768
# inventarioBotella2:3:32768
# inventarioCopeo:5:32768
# costoKG:5:32768
# costoUnidad:5:32768
# costoBotella1:5:32768
# costoBotella2:5:32768
# Estatus:3:32768

INSERT INTO `materiaprima` (`clave`, `nombre`, `tipo`, `tipoA`, `KgXUnidad`, `litrosXBotella1`, `litrosXBotella2`, `inventarioKG`, `inventarioUnidad`, `inventarioBotella1`, `inventarioBotella2`, `inventarioCopeo`, `costoKG`, `costoUnidad`, `costoBotella1`, `costoBotella2`, `Estatus`) VALUES 
  (1,'Tequila Jimador',2,0,0.000,0.700,1.100,0.000,0,5,0,1.250,0.00,0.00,75.00,90.00,1),
  (2,'Vino Tinto Concha y Toro',2,0,0.000,0.750,0.250,0.000,0,3,1,0.300,0.00,0.00,70.00,35.00,1),
  (3,'Vinagre Barril',2,0,0.000,1.000,0.000,0.000,0,3,0,0.000,0.00,0.00,25.00,0.00,1),
  (4,'Jitomate',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,50.00,0.00,0.00,0.00,1),
  (5,'Atun Tunny',1,2,0.300,0.000,0.000,0.000,11,0,0,0.000,0.00,10.00,0.00,0.00,1);

COMMIT;

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
  (1,'Atún a la Veracruzana','Tipico del Sur de Veracruz',4,5,1,0,0,0,0,0,0,0,0.250,0.500,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,8,1);

COMMIT;

