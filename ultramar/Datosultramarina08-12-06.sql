# SQL Manager 2005 for MySQL 3.6.5.8
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : ultramarina


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `ultramarina`;

CREATE DATABASE `ultramarina`
    CHARACTER SET 'latin1'
    COLLATE 'latin1_spanish_ci';

USE `ultramarina`;

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
  `combinable` int(1) default NULL,
  `dimensionable` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `rfc` varchar(13) collate latin1_spanish_ci NOT NULL default '',
  `CURP` varchar(18) collate latin1_spanish_ci default NULL,
  `nombre` varchar(80) collate latin1_spanish_ci NOT NULL default '',
  `direccion` varchar(80) collate latin1_spanish_ci NOT NULL default '',
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(30) collate latin1_spanish_ci default NULL,
  `tel1` varchar(20) collate latin1_spanish_ci default NULL,
  `tel2` varchar(20) collate latin1_spanish_ci default NULL,
  `fax` varchar(20) collate latin1_spanish_ci default NULL,
  `email` varchar(80) collate latin1_spanish_ci default NULL,
  `contacto` varchar(50) collate latin1_spanish_ci default NULL,
  `alta` date default NULL,
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `cobros` table : 
#

DROP TABLE IF EXISTS `cobros`;

CREATE TABLE `cobros` (
  `consecutivo` int(11) NOT NULL auto_increment,
  `claveVenta` int(11) default NULL,
  `fechaCobro` date default NULL,
  `monto` double(8,2) default NULL,
  `formaPago` int(1) default NULL,
  `observaciones` varchar(255) collate latin1_spanish_ci default NULL,
  `activo` int(1) default NULL,
  `propina` double(8,2) default NULL,
  `usuario` varchar(11) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (`consecutivo`)
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
  `Ob` varchar(30) default NULL,
  `PU` double(8,2) default NULL,
  `PT` double(8,2) default NULL,
  `Estatus` int(1) default NULL,
  `IDSecuencia` int(3) default NULL,
  `IDImpresion` int(1) default '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 7168 kB';

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
# Structure for the `empleados` table : 
#

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `IDEmpleado` int(4) unsigned NOT NULL auto_increment,
  `ClaveU` varchar(8) default NULL,
  `Contra` int(4) unsigned NOT NULL default '0',
  `Nombre` varchar(20) NOT NULL default '',
  `APaterno` varchar(20) NOT NULL default '',
  `AMaterno` varchar(20) default NULL,
  `Tipo` int(1) default '0',
  `Activo` int(1) NOT NULL default '1',
  PRIMARY KEY  (`IDEmpleado`),
  UNIQUE KEY `IDEmpleado` (`IDEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
# Structure for the `materiaprima` table : 
#

DROP TABLE IF EXISTS `materiaprima`;

CREATE TABLE `materiaprima` (
  `clave` int(11) NOT NULL auto_increment,
  `nombre` varchar(40) collate latin1_spanish_ci default NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mermas` table : 
#

DROP TABLE IF EXISTS `mermas`;

CREATE TABLE `mermas` (
  `claveProducto` int(11) default NULL,
  `cantidad` double(8,3) default NULL,
  `fecha` date default NULL,
  `tipo` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mermasb` table : 
#

DROP TABLE IF EXISTS `mermasb`;

CREATE TABLE `mermasb` (
  `claveProducto` int(11) default NULL,
  `cantidadB` int(11) default NULL,
  `cantidadC` double(8,3) default NULL,
  `fecha` date default NULL,
  `tipo` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mesas` table : 
#

DROP TABLE IF EXISTS `mesas`;

CREATE TABLE `mesas` (
  `IDMesa` int(1) unsigned NOT NULL default '0',
  `Estatus` int(1) unsigned NOT NULL default '0',
  `LigaA` varchar(45) collate latin1_spanish_ci default '',
  PRIMARY KEY  (`IDMesa`),
  UNIQUE KEY `IDMesa` (`IDMesa`)
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
  `Cantidad` double(8,3) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` double(8,3) default NULL
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
# Structure for the `usuarios` table : 
#

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `ClaveU` varchar(8) collate latin1_spanish_ci NOT NULL default '',
  `Contrasena` varchar(4) collate latin1_spanish_ci NOT NULL default '',
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
# Data for the `alimentos` table  (LIMIT 0,500)
#

INSERT INTO `alimentos` (`clave`, `nombre`, `descripcion`, `materia0`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `materia9`, `cantidad0`, `cantidad1`, `cantidad2`, `cantidad3`, `cantidad4`, `cantidad5`, `cantidad6`, `cantidad7`, `cantidad8`, `cantidad9`, `precio`, `division`, `estatus`) VALUES 
  (1,'Quesadillas de Sesos','Tres Quesadillas Fritas',11,12,41,86,10,23,2,106,0,0,0.01,0.05,0.015,0.03,0.05,0.025,0.01,0.005,0,0,45,18,1),
  (2,'Manitas a la Vinagreta','Manitas Acompañadas con Chiles en Vinagre',68,12,8,6,2,4,1,63,0,0,0.3,0.015,0.02,0.05,0.05,0.05,0.01,0.05,0,0,80,18,1),
  (3,'Jamón Serrano','',69,33,0,0,0,0,0,0,0,0,0.1,0.2,0,0,0,0,0,0,0,0,100,18,1),
  (4,'Sesos Rebozados','',67,11,12,41,38,45,106,18,1,63,0.2,0.001,0.005,0.01,0.06,0.1,0.025,0.05,0.03,0.01,80,18,1),
  (5,'Sesos a la Mantequilla','',11,12,41,39,42,0,0,0,0,0,0.02,0.01,0.05,0.05,0.005,0,0,0,0,0,80,18,1),
  (6,'Machitos Fritos','',70,106,8,2,0,0,0,0,0,0,0.25,0.025,0.01,0.025,0,0,0,0,0,0,80,18,1),
  (7,'Chistorra Natural','',71,2,8,0,0,0,0,0,0,0,0.25,0.025,0.015,0,0,0,0,0,0,0,100,18,1),
  (8,'Chistorra con Queso','',71,33,0,0,0,0,0,0,0,0,0.25,0.2,0,0,0,0,0,0,0,0,120,18,1),
  (9,'Pierna al Horno','',11,41,12,72,106,8,2,0,0,0,0.045,0.2,0.02,0.25,0.025,0.01,0.025,0,0,0,100,14,1),
  (10,'Carne Asada con Enchiladas','Sabana de Filete con Enchiladas Verdes',73,86,105,40,7,22,2,8,42,0,0.2,0.15,0.025,0.025,0.02,0.005,0.005,0.02,0.005,0,150,14,1),
  (11,'Filete de Res a la Cazuela','Filete de Res en su  Jugo Horneado en Cazuela de Barro',73,106,25,39,94,93,42,0,0,0,0.2,0.025,0.05,0.01,0.009,0.009,0.009,0,0,0,170,14,1),
  (12,'Filete de Res al Gusto','',73,0,0,0,0,0,0,0,0,0,0.2,0,0,0,0,0,0,0,0,0,170,14,1),
  (13,'Milanesa de Filete','Milanesa de Filete Empanizada acompañada de Ensalada o Papas a la Francesa',73,45,38,106,259,0,0,0,0,0,0.2,0.02,0.06,0.02,0.03,0,0,0,0,0,150,14,1),
  (14,'Puntas de Filete a la Mexicana','',73,2,10,107,1,12,93,94,41,0,0.2,0.025,0.03,0.025,0.06,0.005,0.009,0.009,0.003,0,150,14,1),
  (15,'Puntas de Filete al Gusto','',73,0,0,0,0,0,0,0,0,0,0.2,0,0,0,0,0,0,0,0,0,150,14,1),
  (16,'Pechuga Asada','Pechuga de Pollo Aplanada y Asada',74,106,41,0,0,0,0,0,0,0,0.25,0.025,0.005,0,0,0,0,0,0,0,100,16,1),
  (17,'Pechuga Empanizada','Pechuga de Pollo Aplanada y Empanizada Acompañada de Ensalada o Papas a la Francesa',74,45,259,38,106,42,0,0,0,0,0.25,0.02,0.03,0.06,0.025,0.005,0,0,0,0,100,16,1),
  (18,'Cecina Enchilada','Cecina Frita Acompañada de Guacamole, Crema y Frijoles',75,106,0,0,0,0,0,0,0,0,0.2,0.025,0,0,0,0,0,0,0,0,100,14,1),
  (19,'Top Sirloin','Sirloin Asado Acompañado de Ensalada o Papas a la Francesa',76,106,0,0,0,0,0,0,0,0,0.25,0.003,0,0,0,0,0,0,0,0,120,14,1),
  (20,'T-Bone','A la Plancha Acompañado de Ensalada o Papas a la Francesa',77,106,0,0,0,0,0,0,0,0,0.25,0.003,0,0,0,0,0,0,0,0,120,14,1),
  (21,'Arrachera','A la Plancha Acompañada de Ensalada o Papas a la Francesa',78,106,0,0,0,0,0,0,0,0,0.25,0.003,0,0,0,0,0,0,0,0,140,14,1),
  (22,'Ensalada Mixta','',90,18,1,2,4,0,0,0,0,0,0.05,0.05,0.03,0.025,0.03,0,0,0,0,0,40,26,1),
  (23,'Ensalada de Pepino','',26,14,42,0,0,0,0,0,0,0,0.2,0.02,0.005,0,0,0,0,0,0,0,40,26,1),
  (24,'Ensalada de Jitomate','',1,2,42,14,0,0,0,0,0,0,0.09,0.025,0.003,0.02,0,0,0,0,0,0,40,26,1),
  (25,'Ensalada Cesar','',260,107,38,11,94,93,261,262,0,0,0.1,0.075,0.06,0.005,0.009,0.009,0.01,0.025,0,0,70,26,1),
  (26,'Riñonada de Cabrito','Pieza de Cabrito Acompañada de Guacamole y Frijoles',263,11,41,12,113,106,0,0,0,0,0.76,0.05,0.05,0.001,0.4,0.2,0,0,0,0,180,23,1),
  (27,'Espaldilla de Cabrito','Pieza de Cabrito Acompañada de Guacamole y Frijoles',264,11,41,12,113,106,0,0,0,0,0.76,0.05,0.05,0.001,0.4,0.2,0,0,0,0,180,23,1),
  (28,'Pierna de Cabrito','Pieza de Cabrito Acompañada de Guacamole y Frijoles',265,11,41,12,113,106,0,0,0,0,0.76,0.05,0.05,0.001,0.4,0.2,0,0,0,0,180,23,1),
  (29,'Almeja Viva','20 Conchas Acompañadas de Salsa y Galleta Salada',81,0,0,0,0,0,0,0,0,0,0.9,0,0,0,0,0,0,0,0,0,175,23,1),
  (30,'Almejas a la Plancha','20 Conchas Acompañadas de Salsa y Galletas',81,39,94,11,42,0,0,0,0,0,0.9,0.1,0.009,0.015,0.005,0,0,0,0,0,200,23,1),
  (31,'Almejas Rockefeller','20 COnchas Acompañadas de Salsa y Galletas',81,39,17,33,11,42,94,0,0,0,0.9,0.1,0.05,0.2,0.005,0.005,0.009,0,0,0,240,23,1),
  (32,'Huachinango a la Plancha','',82,39,0,0,0,0,0,0,0,0,1,0.1,0,0,0,0,0,0,0,0,240,17,1),
  (33,'Camaron Gigante a la Plancha','',83,39,0,0,0,0,0,0,0,0,0.35,0.1,0,0,0,0,0,0,0,0,240,17,1),
  (34,'Cmaron Grande al Mojo de Ajo','',83,39,11,0,0,0,0,0,0,0,0.35,0.1,0.01,0,0,0,0,0,0,0,240,17,1),
  (35,'Camaron al Ajillo','',83,107,11,28,0,0,0,0,0,0,0.35,0.03,0.005,0.005,0,0,0,0,0,0,240,17,1),
  (36,'Camarón a la Diabla','',83,44,106,11,0,0,0,0,0,0,0.35,0.05,0.01,0.005,0,0,0,0,0,0,240,17,1),
  (37,'Cocktail de Camarón','',84,2,10,1,22,11,94,93,107,51,0.2,0.025,0.015,0.1,0.01,0.04,0.009,0.009,0.009,0.027,90,17,1),
  (38,'Camarón a la Poblana','',84,107,2,9,11,0,0,0,0,0,0.2,0.015,0.05,0.04,0.01,0,0,0,0,0,100,17,1),
  (39,'Alambre Mar y Tierra','Combinación de Filete y Camarón',84,73,2,19,25,36,94,42,0,0,0.15,0.15,0.05,0.05,0.015,0.03,0.009,0.005,0,0,240,17,1),
  (40,'Ceviche de Sierra','',85,2,1,10,22,107,14,42,0,0,0.2,0.018,0.1,0.015,0.01,0.015,0.1,0.001,0,0,50,17,1),
  (41,'Filete de Pescado a la Plancha','',79,39,42,0,0,0,0,0,0,0,0.18,0.05,0.005,0,0,0,0,0,0,0,100,17,1),
  (42,'Pepito','Acompañada de Papas a la Francesa',73,4,1,2,3,0,0,0,0,0,0.1,0.025,0.1,0.1,0.15,0,0,0,0,0,70,19,1),
  (43,'Torta de Pierna','Acompañada de Papas a la Francesa',72,4,1,2,3,0,0,0,0,0,0.1,0.025,0.01,0.01,0.15,0,0,0,0,0,50,19,1),
  (44,'Torta de Chorizo','Acompañada de Papas a la Francesa',35,4,1,2,3,0,0,0,0,0,0.1,0.025,0.01,0.01,0.15,0,0,0,0,0,50,19,1),
  (45,'Torta de Pechuga','Acompañada de Papas a la Francesa',74,4,1,2,3,0,0,0,0,0,0.1,0.025,0.01,0.01,0.15,0,0,0,0,0,50,19,1),
  (46,'Torta de Huevo con Chorizo','Acompañada de Papas a la Francesa',38,35,4,1,2,3,0,0,0,0,0.03,0.1,0.025,0.01,0.01,0.15,0,0,0,0,50,19,1),
  (47,'Torta de Milanesa','',73,259,45,38,4,1,2,0,0,0,0.1,0.05,0.01,0.03,0.025,0.01,0.01,0,0,0,50,19,1),
  (48,'Torta de Queso','Acompañada de Papas a la Francesa',34,4,1,2,3,0,0,0,0,0,0.1,0.025,0.01,0.01,0.15,0,0,0,0,0,50,19,1),
  (49,'Sopa de Botana','',266,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,22,0),
  (50,'Tacos','',267,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,22,0),
  (51,'Quesadillas','',268,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,22,0),
  (52,'Guisado','',269,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,22,0),
  (53,'Quesadillas de Queso','Tres Quesadillas Fritas',86,33,0,0,0,0,0,0,0,0,0.03,0.09,0,0,0,0,0,0,0,0,45,18,1),
  (54,'Duraznos en Almibar','',49,0,0,0,0,0,0,0,0,0,0.2,0,0,0,0,0,0,0,0,0,35,21,1),
  (55,'Chongos Zamoranos','',48,0,0,0,0,0,0,0,0,0,0.2,0,0,0,0,0,0,0,0,0,35,21,1),
  (56,'Ate con Queso','',50,33,0,0,0,0,0,0,0,0,0.1,0.12,0,0,0,0,0,0,0,0,35,21,1),
  (57,'Helado','2 Bolas de Helado',290,0,0,0,0,0,0,0,0,0,0.1,0,0,0,0,0,0,0,0,0,30,21,1),
  (58,'Ate Flameado','Flameado con Brandy Presidente o Amaretto H.V.',50,33,184,0,0,0,0,0,0,0,0.1,0.12,0.045,0,0,0,0,0,0,0,70,21,1),
  (59,'Aceitunas Preparadas','',46,94,93,95,285,0,0,0,0,0,0.1,0.009,0.009,0.009,0.009,0,0,0,0,0,30,18,1),
  (60,'Botanas','Botanas',266,268,267,269,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,22,1);

COMMIT;

#
# Data for the `bebidas` table  (LIMIT 0,500)
#

INSERT INTO `bebidas` (`clave`, `nombre`, `descripcion`, `materia0`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `materia9`, `cantidad0`, `cantidad1`, `cantidad2`, `cantidad3`, `cantidad4`, `cantidad5`, `cantidad6`, `cantidad7`, `cantidad8`, `cantidad9`, `precioC`, `precioB1`, `precioB2`, `division`, `estatus`, `alcoholica`, `combinable`, `dimensionable`) VALUES 
  (1,'Bacardi Blanco','',152,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,700,5,1,1,1,1),
  (2,'Bacardi Añejo','',154,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,750,5,1,1,1,1),
  (3,'Bacardi Oro','',153,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,700,5,1,1,1,1),
  (4,'Bacardi 101','',159,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,55,700,0,5,1,1,1,1),
  (5,'Bacardi Solera','',158,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,650,0,5,1,1,1,1),
  (6,'Bacardi Coco','',156,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,650,0,5,1,1,1,1),
  (7,'Bacardi Limón','',155,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,650,0,5,1,1,1,1),
  (8,'Bacardi Razz','',157,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,650,0,5,1,1,1,1),
  (9,'Baraima Blanco','',160,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,550,0,5,1,1,1,1),
  (10,'Appleton Estate','',151,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,700,0,5,1,1,1,1),
  (11,'Appleton Special','',150,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,650,800,5,1,1,1,1),
  (12,'Appleton Blanco','',149,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,550,700,5,1,1,1,1),
  (13,'Malibú','',170,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,650,0,5,1,1,1,1),
  (14,'Matusalem Platino','',171,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,700,0,5,1,1,1,1),
  (15,'Matusalem Clásico','',172,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,700,0,5,1,1,1,1),
  (16,'Matusalem Gran Reserva','',173,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,800,0,5,1,1,1,1),
  (17,'Flor de Caña 12','',165,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,850,0,5,1,1,1,1),
  (18,'Flor de Caña 7','',164,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,700,0,5,1,1,1,1),
  (19,'Flor de Caña 4','',163,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,600,0,5,1,1,1,1),
  (20,'Flor de Caña Blanco','',162,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,550,0,5,1,1,1,1),
  (21,'Havana Blanco','',166,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,550,0,5,1,1,1,1),
  (22,'Havana Añejo Especial 3','',167,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,650,0,5,1,1,1,1),
  (23,'Havana Añejo Reserva','',168,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,750,0,5,1,1,1,1),
  (24,'Havana 7','',169,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,750,0,5,1,1,1,1),
  (25,'Ocumare Blanco','',174,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,550,0,5,1,1,1,1),
  (26,'Ocumare Añejo','',175,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,650,0,5,1,1,1,1),
  (27,'Potosí','',176,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,700,5,1,1,1,1),
  (28,'Castillo','',161,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,650,5,1,1,1,1),
  (29,'Don Q Cristal','',228,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,650,0,5,1,1,1,1),
  (30,'Don Q Añejo','',229,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,700,0,5,1,1,1,1),
  (31,'Centenario Plata','',135,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,650,0,4,1,1,1,1),
  (32,'Centenario Reposado','',134,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,0,750,4,1,1,1,1),
  (33,'Cuervo Especial','',137,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,700,4,1,1,1,1),
  (34,'Tradicional','',138,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,700,0,4,1,1,1,1),
  (35,'Hacienda','',146,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,800,4,1,1,1,1),
  (36,'Conmemorativo','',145,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,800,5,0,1,1,1),
  (37,'Hornitos','',147,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,700,0,4,1,1,1,1),
  (38,'1800','',136,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,900,0,4,1,1,1,1),
  (39,'Don Julio Reposado','',140,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,900,0,4,1,1,1,1),
  (40,'Don Julio Blanco','',139,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,850,0,4,1,1,1,1),
  (41,'Cabrito','',132,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,700,4,1,1,1,1),
  (42,'7 Leguas','',148,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,900,0,4,1,1,1,1),
  (43,'Cazadores','',133,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,850,0,4,1,1,1,1),
  (44,'Herradura Añejo','',143,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,120,1500,0,4,1,1,1,1),
  (45,'Herradura Reposado','',141,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,900,0,4,1,1,1,1),
  (46,'Herradura Blanco','',142,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,750,900,4,1,1,1,1),
  (47,'Jimador','',144,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,800,4,1,1,1,1),
  (48,'100 Años','',131,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,600,0,5,0,1,1,1),
  (49,'Don Pedro','',180,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,600,750,6,1,1,1,1),
  (50,'Presidente','',184,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,550,0,6,1,1,1,1),
  (51,'Absolut Azul','',202,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,800,0,8,1,1,1,1),
  (52,'Absolut Mandarin','',204,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,800,0,8,1,1,1,1),
  (53,'Absolut Citron','',203,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,800,0,8,1,1,1,1),
  (54,'Absolut Vainilla','',205,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,800,0,8,1,1,1,1),
  (55,'Absolut Raspberry','',206,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,70,900,0,8,1,1,1,1),
  (56,'Absolut Ruby Red','',208,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,70,900,0,8,1,1,1,1),
  (57,'Absolut Apeach','',207,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,70,900,0,8,1,1,1,1),
  (58,'Smirnoff','',209,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,700,8,1,1,1,1),
  (59,'Wyborowa','',211,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,800,0,8,1,1,1,1),
  (60,'Stolichnaya','',210,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,800,0,8,1,1,1,1),
  (61,'Belvedere','',212,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,80,1200,0,8,1,1,1,1),
  (62,'Grey Goose','',213,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,80,1200,0,8,1,1,1,1),
  (63,'Bombay','',218,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,70,900,0,10,1,1,1,1),
  (64,'Beefeater','',217,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,750,0,10,1,1,1,1),
  (65,'Oso Negro','',219,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,750,10,1,1,1,1),
  (66,'Fundador','',182,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,700,0,6,1,1,1,1),
  (67,'Magno','',183,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,650,0,6,1,1,1,1),
  (68,'Terry 1900','',186,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,750,0,6,1,1,1,1),
  (69,'Terry Centenario','',185,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,650,0,6,1,1,1,1),
  (70,'Torres 5','',188,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,55,700,0,6,1,1,1,1),
  (71,'Torres 10','',187,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,750,0,6,1,1,1,1),
  (72,'Azteca de Oro','',177,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,50,700,0,6,1,1,1,1),
  (73,'Etiqueta Roja','',246,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,850,0,7,1,1,1,1),
  (74,'Etiqueta Negra','',195,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,80,1300,0,7,1,1,1,1),
  (75,'Etiqueta Verde','',196,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,120,1500,0,7,1,1,1,1),
  (76,'Etiqueta Dorada','',4,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,150,2100,0,7,1,1,1,1),
  (77,'Etiqueta Azul','',200,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,400,4800,0,7,1,1,1,1),
  (78,'Buchanans','',190,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,80,1300,0,7,1,1,1,1),
  (79,'Chivas','',192,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,80,1300,0,7,1,1,1,1),
  (80,'Cutty Sark','',191,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,850,0,7,1,1,1,1),
  (81,'J&B','',193,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,850,0,7,1,1,1,1),
  (82,'Jack Daniels','',199,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,900,0,7,1,1,1,1),
  (83,'Carlos I','',179,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,120,1400,0,6,1,1,1,1),
  (84,'Duque de Alba','',181,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,165,2400,0,6,1,1,1,1),
  (85,'Cardenal de Mendoza','',178,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,150,2200,0,6,1,1,1,1),
  (86,'Remy Martin','',216,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,120,1350,0,9,1,1,1,1),
  (87,'Hennessy','',214,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,140,1550,0,9,1,1,1,1),
  (88,'Martell','',215,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,120,1350,0,9,1,1,1,1),
  (89,'Bailey\'s','',117,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,900,0,3,1,1,1,1),
  (90,'Chinchon Dulce','',222,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,850,11,1,1,1,1),
  (91,'Chinchon Seco','',221,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,850,11,1,1,1,1),
  (92,'Cadenas','',220,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,850,11,1,1,1,1),
  (93,'Vaccari Black','',129,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,0,0,3,1,1,1,1),
  (94,'Vaccari Blanco','',130,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,0,0,3,1,1,1,1),
  (95,'Licor 43','',125,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,0,0,3,1,1,1,1),
  (96,'Frangelico','',122,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,0,0,3,1,1,1,1),
  (97,'Chartreuse Verde','',121,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,120,0,0,3,1,1,1,1),
  (98,'Chartreuse Amarillo','',120,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,80,0,0,3,1,1,1,1),
  (99,'Amaretto di Sarono','',226,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,70,0,0,3,1,1,1,1),
  (100,'Kahlua','',128,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,0,3,1,1,1,1),
  (101,'Grand Marnier','',124,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,120,0,0,3,1,1,1,1),
  (102,'Strega','',127,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,0,0,3,1,1,1,1),
  (103,'Galliano','',123,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,65,0,0,3,1,1,1,1),
  (104,'Midori','',126,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,60,0,0,3,1,1,1,1),
  (105,'Controy','',118,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,0,3,1,1,1,1),
  (106,'Crema de Menta','',119,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,0,3,1,1,1,1),
  (107,'Casillero del Diablo','',232,0,0,0,0,0,0,0,0,0,0.177,0,0,0,0,0,0,0,0,0,60,130,250,25,1,1,0,1),
  (108,'Sangre de Toro','',231,0,0,0,0,0,0,0,0,0,0.177,0,0,0,0,0,0,0,0,0,70,150,300,25,1,1,0,1),
  (109,'Concha y Toro Tinto','',114,0,0,0,0,0,0,0,0,0,0.177,0,0,0,0,0,0,0,0,0,45,100,200,25,1,1,0,1),
  (110,'Concha y Toro Blanco','',113,0,0,0,0,0,0,0,0,0,0.177,0,0,0,0,0,0,0,0,0,45,100,200,25,1,1,0,1),
  (111,'100 Años','',131,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,650,0,4,1,1,1,1),
  (112,'Conmemorativo','',145,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,800,4,1,1,1,1),
  (113,'Domecq','',223,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,0,11,0,1,1,1),
  (114,'Domecq Seco','',223,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,0,11,1,1,1,1),
  (115,'Domecq Dulce','',223,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,0,11,1,1,1,1),
  (116,'Mico','',225,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,40,0,0,11,1,1,1,1),
  (117,'Campari','',110,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,0,1,1,1,1,1),
  (118,'Cinzano Dulce','',111,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,0,1,1,1,1,1),
  (119,'Cinzano Seco','',112,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,0,1,1,1,1,1),
  (120,'Cinzano Rojo','',241,0,0,0,0,0,0,0,0,0,0.045,0,0,0,0,0,0,0,0,0,45,0,0,1,1,1,1,1),
  (121,'Oporto Ferreira','',115,0,0,0,0,0,0,0,0,0,0.09,0,0,0,0,0,0,0,0,0,65,0,700,1,1,1,1,1),
  (122,'Café Americano','',270,0,0,0,0,0,0,0,0,0,0.005,0,0,0,0,0,0,0,0,0,15,0,0,15,1,0,1,0),
  (123,'Café Europeo','',270,0,0,0,0,0,0,0,0,0,0.005,0,0,0,0,0,0,0,0,0,20,0,0,15,1,0,1,0),
  (124,'Café Express','',270,0,0,0,0,0,0,0,0,0,0.005,0,0,0,0,0,0,0,0,0,20,0,0,15,1,0,0,1),
  (125,'Corona','',271,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (126,'Victoria','',272,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (127,'Negra Modelo','',273,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (128,'Modelo Especial','',274,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (129,'Pacifico','',275,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (130,'León','',276,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (131,'Montejo','',277,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (132,'Modelo Light','',278,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,30,0,0,12,1,1,1,0),
  (133,'O`Douls','',279,0,0,0,0,0,0,0,0,0,0.325,0,0,0,0,0,0,0,0,0,40,0,0,12,1,1,1,0),
  (134,'Coca Cola','',280,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (135,'Coca Cola Light','',281,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (136,'Sidral','',251,0,0,0,0,0,0,0,0,0,0.31,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (137,'Quina','',252,0,0,0,0,0,0,0,0,0,0.195,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (138,'Tehuacan','',253,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (139,'Del Valle','',256,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (140,'Canada Dry','',282,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (141,'Squirt','',258,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (142,'Squirt Light','',257,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,0,0,13,1,0,2,0),
  (143,'Clamato','',255,0,0,0,0,0,0,0,0,0,0.295,0,0,0,0,0,0,0,0,0,30,0,0,13,1,0,2,0),
  (144,'Alfonso XIII','',128,184,97,0,0,0,0,0,0,0,0.03,0.03,0.044,0,0,0,0,0,0,0,45,0,0,2,1,1,0,1),
  (145,'Becerro','',114,251,0,0,0,0,0,0,0,0,0.221,0.221,0,0,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (146,'Veneno','',94,93,95,96,42,0,0,0,0,0,0.073,0.073,0.03,0.073,0.009,0,0,0,0,0,35,0,0,24,1,0,2,0),
  (147,'Sangrita','',94,93,95,96,242,14,99,100,42,0,0.073,0.073,0.03,0.073,0.029,0.25,0.33,0.33,0.005,0,10,0,0,24,1,0,2,1),
  (148,'Bloody Mary','',209,100,285,283,0,0,0,0,0,0,0.045,0.06,0.009,0.009,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (149,'Bull Claro','',219,152,243,14,271,0,0,0,0,0,0.022,0.022,0.045,0.045,0.089,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (150,'Bull Oscuro','',219,152,243,14,273,0,0,0,0,0,0.023,0.023,0.045,0.045,0.089,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (151,'Clamato Natural','',255,283,285,0,0,0,0,0,0,0,0.103,0.009,0.009,0,0,0,0,0,0,0,50,0,0,2,1,0,2,0),
  (152,'Daiquiri','',152,243,285,0,0,0,0,0,0,0,0.045,0.045,0.045,0,0,0,0,0,0,0,45,0,0,2,1,1,0,0),
  (153,'Desarmador','',209,99,0,0,0,0,0,0,0,0,0.045,0.132,0,0,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (154,'Margarita','',118,132,243,285,0,0,0,0,0,0,0.03,0.03,0.015,0.015,0,0,0,0,0,0,40,0,0,2,1,1,0,0),
  (155,'Pantera Rosa','',209,110,252,0,0,0,0,0,0,0,0.045,0.009,0.132,0,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (156,'Piedra','',132,225,224,0,0,0,0,0,0,0,0.03,0.03,0.009,0,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (157,'Piña Colada','',152,66,97,243,98,0,0,0,0,0,0.045,0.03,0.03,0.03,0.088,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (158,'Piñada','',66,97,243,98,0,0,0,0,0,0,0.03,0.03,0.03,0.089,0,0,0,0,0,0,50,0,0,2,1,0,0,0),
  (159,'Sangría','',209,285,243,114,253,0,0,0,0,0,0.045,0.03,0.059,0.03,0.089,0,0,0,0,0,60,0,0,2,1,1,0,0),
  (160,'Sol  y Sombra','',182,222,0,0,0,0,0,0,0,0,0.022,0.022,0,0,0,0,0,0,0,0,60,0,0,2,1,1,0,0),
  (161,'Tequila Sunrise','',132,286,242,99,0,0,0,0,0,0,0.045,0.009,0.009,0.206,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (162,'Tom Collins','',219,243,285,253,0,0,0,0,0,0,0.045,0.045,0.03,0.073,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (163,'Vampiro','',132,283,242,99,0,0,0,0,0,0,0.045,0.009,0.009,0.118,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (164,'Ron con Goma','',169,243,285,0,0,0,0,0,0,0,0.045,0.03,0.03,0,0,0,0,0,0,0,60,0,0,2,1,1,0,0),
  (165,'Cucaracha','',128,132,0,0,0,0,0,0,0,0,0.022,0.022,0,0,0,0,0,0,0,0,50,0,0,2,1,1,0,0),
  (166,'Lagartija','',209,119,285,243,253,0,0,0,0,0,0.03,0.03,0.03,0.059,0.059,0,0,0,0,0,60,0,0,2,1,1,0,0),
  (167,'Mojito','',167,285,253,0,0,0,0,0,0,0,0.045,0.03,0.103,0,0,0,0,0,0,0,60,0,0,2,1,1,0,0),
  (168,'Martini','',217,239,0,0,0,0,0,0,0,0,0.059,0.009,0,0,0,0,0,0,0,0,80,0,0,2,1,1,0,0),
  (169,'Licor de Manzana Verde','',287,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,3,1,1,2,1),
  (170,'Licor de Cassis','',286,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,3,1,1,2,1),
  (171,'Licor de Platano','',288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,3,1,1,2,1),
  (172,'Curacao Azul','',289,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,3,1,1,2,1),
  (173,'Licor de Damiana','',230,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,3,1,1,0,1),
  (174,'Jugo de Naranja','',99,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,60,0,29,1,0,2,0),
  (175,'Jugo de Arandano','',103,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,60,0,29,1,0,2,0),
  (176,'Jugo de Piña','',98,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,60,0,29,1,0,2,0),
  (177,'Jugo de Uva','',102,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,60,0,10,0,0,2,0),
  (178,'Jugo de Toronja','',101,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,60,0,29,1,0,2,0),
  (179,'Jugo de Tomate','',100,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,60,0,29,1,0,2,0),
  (180,'Jugo de Uva','',102,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,20,60,0,29,1,0,2,0),
  (181,'Budweiser','',291,0,0,0,0,0,0,0,0,0,0.355,0,0,0,0,0,0,0,0,0,40,0,0,12,1,1,1,0);

COMMIT;

#
# Data for the `cobros` table  (LIMIT 0,500)
#

INSERT INTO `cobros` (`consecutivo`, `claveVenta`, `fechaCobro`, `monto`, `formaPago`, `observaciones`, `activo`, `propina`, `usuario`) VALUES 
  (1,2,'2006-11-30',240,1,'',1,0,'super'),
  (2,1,'2006-11-30',0,1,'',1,0,'super'),
  (3,3,'2006-12-06',480,1,'',1,0,'super'),
  (4,4,'2006-12-06',210,1,'',1,0,'super'),
  (5,5,'2006-12-06',300,4,'',1,0,'super'),
  (6,1,'2006-12-07',60,1,'',1,0,'super');

COMMIT;

#
# Data for the `comanda` table  (LIMIT 0,500)
#

INSERT INTO `comanda` (`IDC`, `IDMM`, `IDM`, `FA`, `TA`, `NC`, `PT`, `Es`) VALUES 
  (1,12,1,'2006-12-07','20:19:09',4,60,0),
  (2,9,6,'2006-12-07','20:35:18',2,1240,1),
  (3,11,1,'2006-12-08','18:58:27',2,0,1);

COMMIT;

#
# Data for the `comandapro` table  (LIMIT 0,500)
#

INSERT INTO `comandapro` (`IDC`, `IDM`, `IDCom`, `HR`, `DiA`, `Ge`, `Di`, `CanPro`, `ClPro`, `Tipo`, `Ob`, `PU`, `PT`, `Estatus`, `IDSecuencia`, `IDImpresion`, `TB`, `FB`, `MB`, `AB`, `CA1`, `CA2`, `CA3`, `CA4`, `CB1`, `CB2`, `CB3`, `CB4`, `TB1`, `TB2`, `TB3`, `TB4`) VALUES 
  (1,6,1,'20:23:13','2006-12-07',2,7,1,73,1,'tavo',60,60,2,1,1,1,1,2,0,1,0,0,0,138,0,0,0,3,0,0,0),
  (2,1,1,'18:53:49','2006-12-08',2,6,1,72,1,'',50,50,1,1,1,1,1,2,0,1,0,0,0,134,0,0,0,3,0,0,0),
  (2,1,1,'18:54:39','2006-12-08',2,6,1,85,1,'',150,150,1,2,1,1,3,2,3,1,0,0,0,134,0,0,0,3,0,0,0),
  (2,1,1,'18:54:39','2006-12-08',2,6,1,85,1,'',150,150,1,2,1,1,1,3,0,1,1,0,0,134,174,0,0,3,3,0,0),
  (2,1,1,'18:55:51','2006-12-08',1,14,1,21,0,'sin frijoles',140,140,1,3,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
  (2,1,1,'18:56:53','2006-12-08',2,4,1,32,2,'',750,750,1,4,1,1,0,0,0,3,1,0,0,141,138,0,0,3,3,0,0);

COMMIT;

#
# Data for the `division` table  (LIMIT 0,500)
#

INSERT INTO `division` (`clave`, `nombre`, `area`, `estatus`) VALUES 
  (1,'APERITIVOS',2,1),
  (2,'COCKTAILS',2,1),
  (3,'LICORES Y CREMAS',2,1),
  (4,'TEQUILAS',2,1),
  (5,'RONES',2,1),
  (6,'BRANDIES',2,1),
  (7,'WHISKIES',2,1),
  (8,'VODKAS',2,1),
  (9,'COGNACS',2,1),
  (10,'GINEBRAS',2,1),
  (11,'ANISES',2,1),
  (12,'CERVEZAS',2,1),
  (13,'REFRESCOS',2,1),
  (14,'CARNES',1,1),
  (15,'CAFÉ',2,1),
  (16,'POLLOS',1,1),
  (17,'PESCADOS Y MARISCOS',1,1),
  (18,'ENTRADAS',1,1),
  (19,'TORTAS',1,1),
  (20,'EXTRAS',1,1),
  (21,'POSTRES',1,1),
  (22,'BOTANAS',1,1),
  (23,'ESPECIALIDADES',1,1),
  (24,'EXTRAS BEBIDAS',2,1),
  (25,'VINOS DE MESA',2,1),
  (26,'ENSALADAS',1,1),
  (27,'GUARNICIONES',1,1),
  (28,'SERVICIO MESA',1,1),
  (29,'Jugos',2,1);

COMMIT;

#
# Data for the `empleados` table  (LIMIT 0,500)
#

INSERT INTO `empleados` (`IDEmpleado`, `ClaveU`, `Contra`, `Nombre`, `APaterno`, `AMaterno`, `Tipo`, `Activo`) VALUES 
  (1,NULL,2303,'Enrique','Fernández','Jaimes',0,1),
  (2,NULL,2303,'Sofía','Gabián','Domínguez',0,1),
  (3,'blue',103,'Shary Estefanía','Manzanares','Nuñez',1,1),
  (4,'Roxana',1606,'Mónica Roxana','Cruz','Carrasco',0,1),
  (5,'Karen',1234,'Leslie Karen','Arzate','Mondragón',1,1),
  (6,'Sarahi',2422,'Sarahi','Bonilla','Calzada',0,1);

COMMIT;

#
# Data for the `materiaprima` table  (LIMIT 0,500)
#

INSERT INTO `materiaprima` (`clave`, `nombre`, `tipo`, `tipoA`, `KgXUnidad`, `litrosXBotella1`, `litrosXBotella2`, `inventarioKG`, `inventarioUnidad`, `inventarioBotella1`, `inventarioBotella2`, `inventarioCopeo`, `costoKG`, `costoUnidad`, `costoBotella1`, `costoBotella2`, `Estatus`) VALUES 
  (1,'Jitomate',1,1,0,0,0,0.83,0,0,0,0,16,0,0,0,1),
  (2,'Cebolla',1,1,0,0,0,0.765,0,0,0,0,12,0,0,0,1),
  (3,'Papas',1,1,0,0,0,1,0,0,0,-0.3,10,0,0,0,1),
  (4,'Aguacate',1,1,0,0,0,0.95,0,0,0,0,25,0,0,0,1),
  (5,'Chayote',1,1,0,0,0,1,0,0,0,0,8,0,0,0,1),
  (6,'Zanahoria',1,1,0,0,0,1,0,0,0,0,8,0,0,0,1),
  (7,'Tomate Verde',1,1,0,0,0,1,0,0,0,0,28,0,0,0,1),
  (8,'Chile Cuaresmeño',1,1,0,0,0,1,0,0,0,0,9,0,0,0,1),
  (9,'Chile Poblano',1,1,0,0,0,1,0,0,0,0,14,0,0,0,1),
  (10,'Chile de Árbol',1,1,0,0,0,0.97,0,0,0,0,60,0,0,0,1),
  (11,'Ajo',1,1,0,0,0,0.99,0,0,0,0,35,0,0,0,1),
  (12,'Hierbas de Olor',1,2,0.05,0,0,0,10,0,0,-0.005,0,10,0,0,1),
  (13,'Nopales',1,1,0,0,0,1,0,0,0,0,10,0,0,0,1),
  (14,'Limón',1,2,18,0,0,0,1,0,0,0,0,150,0,0,1),
  (15,'Elotes',1,2,0.05,0,0,0,8,0,0,0,0,2,0,0,1),
  (16,'Calabacitas',1,1,0,0,0,1,0,0,0,0,10,0,0,0,1),
  (17,'Espinacas',1,1,0,0,0,1,0,0,0,0,15,0,0,0,1),
  (18,'Lechugas Romanas',1,2,800,0,0,0,8,0,0,0,0,5,0,0,1),
  (19,'Pimiento Morrón',1,1,0,0,0,0.9,0,0,0,0,16,0,0,0,1),
  (20,'Apio',1,1,0,0,0,1,0,0,0,0,20,0,0,0,1),
  (21,'Naranja',1,1,0,0,0,1,0,0,0,0,6,0,0,0,1),
  (22,'Cilantro',1,1,0,0,0,1,0,0,0,0,40,0,0,0,1),
  (23,'Epazote',1,1,0,0,0,1,0,0,0,0,40,0,0,0,1),
  (24,'Verdolagas',1,1,0,0,0,1,0,0,0,0,15,0,0,0,1),
  (25,'Champìñones',1,1,0,0,0,0.905,0,0,0,0,28,0,0,0,1),
  (26,'Pepinos',1,1,0,0,0,1,0,0,0,0,16,0,0,0,1),
  (27,'Poros',1,1,0,0,0,1,0,0,0,0,16,0,0,0,1),
  (28,'Chile Guajillo',1,1,0,0,0,1,0,0,0,0,45,0,0,0,1),
  (29,'Chile Morita',1,1,0,0,0,1,0,0,0,0,50,0,0,0,1),
  (30,'Camarón Seco',1,1,0,0,0,1,0,0,0,0,130,0,0,0,1),
  (31,'Chile Ancho',1,1,0,0,0,1,0,0,0,0,45,0,0,0,1),
  (32,'Chile Pasilla',1,1,0,0,0,1,0,0,0,0,45,0,0,0,1),
  (33,'Queso Manchego',1,1,0,0,0,1,0,0,0,0,60,0,0,0,1),
  (34,'Queso Panela',1,1,0,0,0,1,0,0,0,0,40,0,0,0,1),
  (35,'Chorizo',1,1,0,0,0,0.9,0,0,0,0,35,0,0,0,1),
  (36,'Tocino',1,1,0,0,0,1,0,0,0,-0.06,70,0,0,0,1),
  (37,'Salchicha',1,1,0,0,0,1,0,0,0,0,45,0,0,0,1),
  (38,'Huevos',1,1,0,0,0,0.85,0,0,0,0,12,0,0,0,1),
  (39,'Mantequilla',1,1,0,0,0,0.99,0,0,0,0,45,0,0,0,1),
  (40,'Queso Rayado',1,1,0,0,0,1,0,0,0,0,25,0,0,0,1),
  (41,'Sal de Grano',1,1,0,0,0,0.997,0,0,0,0,3,0,0,0,1),
  (42,'Sal de Mesa',1,1,0,0,0,0.981,0,0,0,0,3,0,0,0,1),
  (43,'Consome de Pollo',1,2,0.8,0,0,0,2,0,0,0,0,42,0,0,1),
  (44,'Chile Chipotle',1,2,0.38,0,0,0,12,0,0,0,0,16,0,0,1),
  (45,'Harina de Trigo',1,1,0,0,0,1,0,0,0,0,10,0,0,0,1),
  (46,'Aceitunas',1,2,0.1,0,0,0,1,0,0,0,0,9,0,0,1),
  (47,'Atún',1,2,0.12,0,0,0,1,0,0,0,0,8,0,0,1),
  (48,'Chongos Zamoranos',1,2,1,0,0,0,5,0,0,0,0,40,0,0,1),
  (49,'Duraznos en Almibar',1,2,0.82,0,0,0,5,0,0,0,0,17,0,0,1),
  (50,'Até',1,1,0,0,0,1,0,0,0,0,120,0,0,0,1),
  (51,'Salsa Catsup',1,2,0.7,0,0,0,3,0,0,0,0,17,0,0,1),
  (52,'Pure de Tomate',1,2,1,0,0,0,1,0,0,0,0,12,0,0,1),
  (53,'Cerezas',1,2,0.082,0,0,0,1,0,0,0,0,15,0,0,1),
  (54,'Frijol Negro',1,1,0,0,0,1,0,0,0,0,18,0,0,0,1),
  (55,'Sopa de Fideo',1,2,0.2,0,0,0,1,0,0,0,0,4,0,0,1),
  (56,'Sopa de Munición',1,2,0.2,0,0,0,1,0,0,0,0,4,0,0,1),
  (57,'Sopa de Moño',1,2,0.2,0,0,0,1,0,0,0,0,4,0,0,1),
  (58,'Sopa de Codito',1,2,0.2,0,0,0,1,0,0,0,0,4,0,0,1),
  (59,'Lenteja',1,1,0,0,0,1,0,0,0,0,12,0,0,0,1),
  (60,'Haba',1,1,0,0,0,1,0,0,0,0,26,0,0,0,1),
  (61,'Spaghuetti',1,2,0.2,0,0,0,1,0,0,0,0,4,0,0,1),
  (62,'Arroz',1,2,1,0,0,0,1,0,0,0,0,10,0,0,1),
  (63,'Vinagre Blanco',2,0,0,0.75,0,0,0,1,0,0,0,0,9,0,1),
  (64,'Galletas Saladas',1,2,0.54,0,0,0,3,0,0,0,0,21,0,0,1),
  (65,'Garbanzos',1,1,0,0,0,1,0,0,0,0,23,0,0,0,1),
  (66,'Concentrado de Coco',1,2,0.48,0,0,0,5,0,0,0,0,15,0,0,1),
  (67,'Sesos de Res',1,1,0,0,0,1,0,0,0,0,81,0,0,0,1),
  (68,'Manitas de Cerdo',1,1,0,0,0,1,0,0,0,0,23,0,0,0,1),
  (69,'Jamón Serrano',1,2,0.1,0,0,0,8,0,0,0,0,30,0,0,1),
  (70,'Machitos de carnero',1,2,0.25,0,0,0,20,0,0,0,0,7,0,0,1),
  (71,'Chistorra',1,1,0,0,0,1,0,0,0,0,50,0,0,0,1),
  (72,'Pierna de Cerdo',1,1,0,0,0,1,0,0,0,0,34,0,0,0,1),
  (73,'Filete de Res',1,1,0,0,0,0.2,0,0,0,0,120,0,0,0,1),
  (74,'Pechuga de Pollo',1,2,0.2,0,0,0,14,0,0,0,0,7,0,0,1),
  (75,'Cecina Enchilada',1,1,0,0,0,1,0,0,0,0,80,0,0,0,1),
  (76,'Top Sirloin',1,1,0,0,0,1,0,0,0,0,90,0,0,0,1),
  (77,'T Bone',1,1,0,0,0,1,0,0,0,0,90,0,0,0,1),
  (78,'Arrachera',1,1,0,0,0,0.5,0,0,0,0,130,0,0,0,1),
  (79,'Filete de Pescado',1,2,250,0,0,0,8,0,0,0,0,16,0,0,1),
  (80,'Cabrito 6 piezas',1,1,0,0,0,1,0,0,0,0,85,0,0,0,0),
  (81,'Almejas',1,1,0,0,0,0.1,0,0,0,0,30,0,0,0,1),
  (82,'Huachinango',1,1,0,0,0,1,0,0,0,0,160,0,0,0,1),
  (83,'Camarón Grande',1,1,0,0,0,1,0,0,0,0,185,0,0,0,1),
  (84,'Camarón Cocktail',1,1,0,0,0,0.7,0,0,0,0,125,0,0,0,1),
  (85,'Pescado Sierra',1,1,0,0,0,1,0,0,0,0,45,0,0,0,1),
  (86,'Tortilla de Maiz',1,1,0,0,0,1,0,0,0,0,8,0,0,0,1),
  (87,'Tortillas de Harina',1,2,0.2,0,0,0,15,0,0,0,0,6,0,0,1),
  (88,'Bolillo',1,2,0.09,0,0,0,10,0,0,0,0,1,0,0,1),
  (89,'Flan Casero',1,2,1,0,0,0,2,0,0,0,0,75,0,0,1),
  (90,'Lechuga Sangría',1,2,0.4,0,0,0,2,0,0,0,0,7,0,0,1),
  (91,'Cebollitas Cambray',1,1,0,0,0,1,0,0,0,0,30,0,0,0,1),
  (92,'Appleton White',2,0,0,0.75,1,0,0,2,3,0.5,0,0,100,150,0),
  (93,'Salsa Maggi',2,0,0,0.2,0,0,0,4,0,-0.036,0,0,27,0,1),
  (94,'Salsa Inglesa',2,0,0,0.145,0.29,0,0,2,0,-0.054,0,0,18,25,1),
  (95,'Salsa Tabasco',2,0,0,0.06,0.355,0,0,3,1,0,0,0,25,75,1),
  (96,'Salsa Valentina',2,0,0,0.37,0,0,0,4,0,0,0,0,6.5,0,1),
  (97,'Leche Carnation',2,0,0,0.373,0,0,0,1,0,0,0,0,9,0,1),
  (98,'Jugo de Piña',2,0,0,1,0,0,0,1,0,0,0,0,13,0,1),
  (99,'Jugo de Naranja',2,0,0,1,0,0,0,7,0,0.75,0,0,13,0,1),
  (100,'Jugo de Tomate',2,0,0,1,0,0,0,3,0,0,0,0,13,0,1),
  (101,'Jugo de Toronja',2,0,0,1,0,0,0,1,0,0,0,0,13,0,1),
  (102,'Jugo de Uva',2,0,0,1,0,0,0,3,0,0,0,0,13,0,1),
  (103,'Jugo de Arandano',2,0,0,2.84,0,0,0,1,0,0,0,0,36,0,1),
  (104,'Agua Embotellada',2,0,0,0.5,0,0,0,2,0,0,0,0,2,0,1),
  (105,'crema',2,0,0,1,0,0,0,1,0,0,0,0,21,0,1),
  (106,'Aceite',2,0,0,1,0,0,0,1,0,-0.031,0,0,10.5,0,1),
  (107,'Aceite de Olivo',2,0,0,1,0,0,0,1,0,-0.175,0,0,95,0,1),
  (108,'Mostaza',1,2,0.397,0,0,0,1,0,0,0,0,19.1,0,0,1),
  (109,'Mayonesa',1,2,0.79,0,0,0,1,0,0,0,0,31.93,0,0,1),
  (110,'Campari',2,0,0,0.75,0,0,0,0,0,0.705,0,0,145,0,1),
  (111,'Cinzano Dulce',2,0,0,0.75,0,0,0,1,0,0,0,0,120,0,1),
  (112,'Cinzano Seco',2,0,0,0.75,0,0,0,1,0,0,0,0,120,0,1),
  (113,'Vino Blanco Concha y Toro',2,0,0,0.75,0.375,0,0,2,2,0,0,0,55,34,1),
  (114,'Vino Tinto Concha y Toro',2,0,0,0.75,0.375,0,0,2,2,0,0,0,55,34,1),
  (115,'Oporto Ferreira',2,0,0,0.75,0,0,0,4,0,0,0,0,156,0,1),
  (116,'Amaretto H.V.',2,0,0,0.75,0,0,0,2,0,0,0,0,72,0,1),
  (117,'Bailey\'s',2,0,0,0.75,0,0,0,2,0,0,0,0,175,0,1),
  (118,'Controy',2,0,0,0.75,0,0,0,0,0,0.72,0,0,75,0,1),
  (119,'Crema de Menta',2,0,0,0.75,0,0,0,1,0,0,0,0,70,0,1),
  (120,'Chartreuse Amarillo',2,0,0,0.7,0,0,0,1,0,0,0,0,350,0,1),
  (121,'Chartreuse Verde',2,0,0,0.7,0,0,0,1,0,0,0,0,356,0,1),
  (122,'Frangelico',2,0,0,0.7,0,0,0,1,0,0,0,0,274,0,1),
  (123,'Galliano',2,0,0,0.7,0,0,0,1,0,0,0,0,185,0,1),
  (124,'Grand Marnier',2,0,0,0.7,0,0,0,2,0,0,0,0,405,0,1),
  (125,'Licor 43',2,0,0,0.75,0,0,0,2,0,0,0,0,270,0,1),
  (126,'Midori',2,0,0,0.75,0,0,0,2,0,0,0,0,170,0,1),
  (127,'Strega',2,0,0,0.75,0,0,0,2,0,0,0,0,285,0,1),
  (128,'Kahlúa',2,0,0,0.98,0,0,0,1,0,0,0,0,87,0,1),
  (129,'Vaccari Black',2,0,0,0.7,0,0,0,2,0,0,0,0,229,0,1),
  (130,'Vaccari White',2,0,0,0.7,0,0,0,2,0,0,0,0,203,0,1),
  (131,'Tequila 100 Años',2,0,0,0.75,0,0,0,2,0,0,0,0,94,0,1),
  (132,'Tequila Cabrito',2,0,0,1,0,0,0,1,0,0.97,0,0,106,0,1),
  (133,'Tequila Cazadores',2,0,0,0.75,1,0,0,8,3,0,0,0,170,206,1),
  (134,'Tequila Centenario Reposado',2,0,0,0.95,0,0,0,3,0,0,0,0,173,0,1),
  (135,'Tequila Centenario Plata',2,0,0,0.7,0,0,0,4,0,0,0,0,119,0,1),
  (136,'Tequila Cuervo 1800',2,0,0,0.7,0,0,0,4,0,0,0,0,245,0,1),
  (137,'Tequila Cuervo Especial',2,0,0,0.7,0,0,0,2,0,0,0,0,245,0,1),
  (138,'Tequila Cuervo Tradicional',2,0,0,0.695,0.95,0,0,9,2,0,0,0,165,207,1),
  (139,'Tequila Don Julio Blanco',2,0,0,0.75,0,0,0,4,0,0,0,0,220,0,1),
  (140,'Tequila Don Julio Reposado',2,0,0,0.75,0,0,0,1,0,0.705,0,0,277,0,1),
  (141,'Tequila Herradura Reposado',2,0,0,0.7,0,0,0,5,0,0,0,0,259,0,1),
  (142,'Tequila Herradura Blanco',2,0,0,0.7,0.95,0,0,2,2,0,0,0,220,295,1),
  (143,'Tequila Herradura Añejo',2,0,0,0.75,0,0,0,2,0,0,0,0,369,0,1),
  (144,'Tequila Jimador',2,0,0,0.95,0,0,0,5,0,0,0,0,129,0,1),
  (145,'Tequila Sauza Conmemorativo',2,0,0,1,0,0,0,2,0,0,0,0,181,0,1),
  (146,'Tequila Sauza Hacienda',2,0,0,1,0,0,0,2,0,0,0,0,165,0,1),
  (147,'Tequila Sauza Hornitos',2,0,0,0.7,0,0,0,6,0,0,0,0,141,0,1),
  (148,'Tequila Siete Leguas',2,0,0,0.75,0,0,0,1,0,0,0,0,277,0,1),
  (149,'Ron Appleton White',2,0,0,0.75,0.95,0,0,4,6,0,0,0,69,86,1),
  (150,'Ron Appleton Special',2,0,0,0.75,0.95,0,0,1,7,0,0,0,90,103,1),
  (151,'Ron Appleton Estate',2,0,0,0.75,0,0,0,7,0,0,0,0,126,0,1),
  (152,'Ron Bacardi Blanco',2,0,0,0.946,0,0,0,8,0,0.856,0,0,86,0,1),
  (153,'Ron Bacardi Oro',2,0,0,0.946,0,0,0,3,0,0,0,0,87,0,1),
  (154,'Ron Bacardi Añejo',2,0,0,1,0,0,0,16,0,0,0,0,101,0,1),
  (155,'Ron Bacardi Limón',2,0,0,0.75,0,0,0,3,0,0,0,0,109,0,1),
  (156,'Ron Bacardi Coco',2,0,0,0.75,0,0,0,3,0,0,0,0,109,0,1),
  (157,'Ron Bacardi Razz',2,0,0,0.75,0,0,0,3,0,0,0,0,109,0,1),
  (158,'Ron Bacardi Solera',2,0,0,0.75,0,0,0,9,0,0,0,0,126,0,1),
  (159,'Ron Bacardi 101',2,0,0,0.75,0,0,0,3,0,0,0,0,120,0,1),
  (160,'Ron Baraima Blanco',2,0,0,0.7,0,0,0,6,0,0,0,0,50,0,1),
  (161,'Ron Castillo Imperial',2,0,0,1,0,0,0,2,0,0,0,0,54,0,1),
  (162,'Ron Flor de Caña Extra Dry',2,0,0,0.75,0,0,0,3,0,0,0,0,75,0,1),
  (163,'Ron Flor de Caña 4 Años',2,0,0,0.75,0,0,0,3,0,0,0,0,109,0,1),
  (164,'Ron Flor de Caña 7 Años',2,0,0,0.75,0,0,0,2,0,0,0,0,138,0,1),
  (165,'Ron Flor de Caña 12 Años',2,0,0,0.75,0,0,0,2,0,0,0,0,189,0,1),
  (166,'Ron Havana Blanco',2,0,0,0.75,0,0,0,2,0,0,0,0,77,0,1),
  (167,'Ron Havana Añejo Especial (3 Años)',2,0,0,0.75,0,0,0,2,0,0.705,0,0,90,0,1),
  (168,'Ron Havana Añejo Reserva ( 5 Años)',2,0,0,0.75,0,0,0,2,0,0,0,0,135,0,1),
  (169,'Ron Havana 7 Años',2,0,0,0.75,0,0,0,5,0,0,0,0,205,0,1),
  (170,'Ron Malibú',2,0,0,0.75,0,0,0,3,0,0,0,0,134,0,1),
  (171,'Ron Matusalem Platino',2,0,0,0.75,0,0,0,2,0,0,0,0,95,0,1),
  (172,'Ron Matusalem Clásico',2,0,0,0.75,0,0,0,2,0,0.705,0,0,120,0,1),
  (173,'Ron Matusalem Gran Reserva',2,0,0,0.75,0,0,0,2,0,0,0,0,169,0,1),
  (174,'Ron Ocumare Blanco',2,0,0,0.7,0,0,0,2,0,0,0,0,79,0,1),
  (175,'Ron Ocumare Añejo',2,0,0,0.7,0,0,0,2,0,0,0,0,85,0,1),
  (176,'Ron Potosí Añejo',2,0,0,1,0,0,0,2,0,0,0,0,77,0,1),
  (177,'Brandy Azteca de Oro',2,0,0,0.7,0,0,0,2,0,0.655,0,0,124,0,1),
  (178,'Brandy Cardenal de Mendoza',2,0,0,0.7,0,0,0,0,0,0.61,0,0,450,0,1),
  (179,'Brandy Carlos I',2,0,0,0.7,0,0,0,1,0,0,0,0,435,0,1),
  (180,'Brandy Don Pedro',2,0,0,0.75,1,0,0,2,2,0,0,0,78,101,1),
  (181,'Brandy Duque de Alba',2,0,0,0.7,0,0,0,1,0,0,0,0,360,0,1),
  (182,'Brandy Fundador',2,0,0,0.7,0,0,0,9,0,0,0,0,119,0,1),
  (183,'Brandy Magno',2,0,0,0.75,0,0,0,5,0,0,0,0,163,0,1),
  (184,'Brandy Presidente',2,0,0,0.7,0,0,0,2,0,0,0,0,55,0,1),
  (185,'Brandy Terry Centenario',2,0,0,0.7,0,0,0,3,0,0,0,0,159,0,1),
  (186,'Brandy Terry 1900',2,0,0,0.7,0,0,0,3,0,0,0,0,175,0,1),
  (187,'Brandy Torres 10',2,0,0,0.7,0,0,0,6,0,0.61,0,0,189,0,1),
  (188,'Brandy Torres 5',2,0,0,0.7,0,0,0,2,0,0,0,0,129,0,1),
  (189,'Whisky William Lawsons',2,0,0,0.75,0,0,0,1,0,0,0,0,129,0,1),
  (190,'Whisky Buchanans 12 Años',2,0,0,0.75,0,0,0,3,0,0,0,0,348,0,1),
  (191,'Whisky Cutty Sark',2,0,0,0.75,0,0,0,2,0,0,0,0,175,0,1),
  (192,'Whisky Chivas Regal 12 Años',2,0,0,0.75,0,0,0,4,0,0,0,0,292,0,1),
  (193,'Whisky J&B',2,0,0,0.75,0,0,0,3,0,0,0,0,151,0,1),
  (194,'Whisky Johnnie Walker E.R:',2,0,0,0.75,0,0,0,3,0,0,0,0,185,0,0),
  (195,'Whisky Johnnie Walker E.N.',2,0,0,0.75,0,0,0,4,0,0,0,0,291,0,1),
  (196,'Whisky Johnnie Walker E.V.',2,0,0,0.75,0,0,0,2,0,0,0,0,559,0,1),
  (197,'Whisky Johnnie Walker  Golden Label',2,0,0,0.75,0,0,0,1,0,0,0,0,731,0,1),
  (198,'Whisky Old Parr 12 Años',2,0,0,0.75,0,0,0,2,0,0,0,0,295,0,1),
  (199,'Whisky Jack Daniels',2,0,0,0.7,0,0,0,2,0,0,0,0,239,0,1),
  (200,'Whisky Johnnie Walker Blue Label',2,0,0,0.75,0,0,0,1,0,0,0,0,1900,0,1),
  (201,'Tequila Herradura Antiguo',2,0,0,0.7,0,0,0,2,0,0,0,0,159,0,1),
  (202,'Vodka Absolut Azul',2,0,0,0.75,0,0,0,6,0,0.66,0,0,148,0,1),
  (203,'Vodka Absolut Citrus',2,0,0,0.75,0,0,0,4,0,0,0,0,163,0,1),
  (204,'Vodka Absolut Mandarin',2,0,0,0.75,0,0,0,4,0,0.66,0,0,163,0,1),
  (205,'Vodka Absolut Vanilla',2,0,0,0.75,0,0,0,3,0,0,0,0,163,0,1),
  (206,'Vodka Absolut Raspberry',2,0,0,0.75,0,0,0,4,0,0,0,0,163,0,1),
  (207,'Vodka Absolut Appeach',2,0,0,0.75,0,0,0,2,0,0,0,0,163,0,1),
  (208,'Vodka Absolut Rubby Red',2,0,0,0.75,0,0,0,2,0,0,0,0,163,0,1),
  (209,'Vodka Smirnoff',2,0,0,1,0,0,0,4,0,0,0,0,104,0,1),
  (210,'Vodka Stolichnaya',2,0,0,0.75,0,0,0,4,0,0,0,0,167,0,1),
  (211,'Vodka Wiborowa',2,0,0,0.75,0,0,0,5,0,0,0,0,105,0,1),
  (212,'Vodka Belvedere',2,0,0,0.7,0,0,0,3,0,0,0,0,340,0,1),
  (213,'Vodka Grey Goose',2,0,0,0.7,0,0,0,2,0,0,0,0,340,0,1),
  (214,'Cognac Hennessy VS.O.P.',2,0,0,0.7,0,0,0,1,0,0.655,0,0,446,0,1),
  (215,'Cognac Martell V.S.O.P.',2,0,0,0.7,0,0,0,2,0,0,0,0,419,0,1),
  (216,'Cognac Remy Martin',2,0,0,0.7,0,0,0,2,0,0,0,0,379,0,1),
  (217,'Ginebra Beefeater',2,0,0,0.75,0,0,0,1,0,0.705,0,0,218,0,1),
  (218,'Ginebra Bombay',2,0,0,0.75,0,0,0,2,0,0,0,0,279,0,1),
  (219,'Ginebra Oso Negro',2,0,0,1,0,0,0,1,0,0,0,0,75,0,1),
  (220,'Anis Cadenas',2,0,0,1,0,0,0,2,0,0,0,0,179,0,1),
  (221,'Anis Chinchón Seco',2,0,0,1,0,0,0,1,0,0,0,0,125,0,1),
  (222,'Anís Chinchón Dulce',2,0,0,1,0,0,0,4,0,0,0,0,125,0,1),
  (223,'Anís Domecq',2,0,0,1,0,0,0,2,0,0,0,0,69,0,1),
  (224,'Fernet',2,0,0,0.75,0,0,0,1,0,0,0,0,90,0,1),
  (225,'Anis Mico',2,0,0,1,0,0,0,1,0,0,0,0,65,0,1),
  (226,'Amaretto di Sarono',2,0,0,0.7,0,0,0,1,0,0,0,0,239,0,1),
  (227,'Champagne Moet Chandon',2,0,0,0.75,0,0,0,2,0,0,0,0,446,0,1),
  (228,'Ron Don Q Cristal',2,0,0,0.7,0,0,0,2,0,0,0,0,85,0,1),
  (229,'Ron Don Q Añejo',2,0,0,0.7,0,0,0,2,0,0,0,0,105,0,1),
  (230,'Damiana',2,0,0,0.75,0,0,0,1,0,0,0,0,105,0,1),
  (231,'Vino Tinto Gran Sangre de Toro',2,0,0,0.75,0,0,0,2,0,0,0,0,139,0,1),
  (232,'Vino Tinto Casillero del Diablo',2,0,0,0.75,0.375,0,0,2,2,0,0,0,105,59,1),
  (233,'Rompope',2,0,0,0.9,0,0,0,2,0,0,0,0,69,0,1),
  (234,'Cacao Blanco H.V.',2,0,0,0.75,0,0,0,2,0,0,0,0,70,0,1),
  (235,'Licor de Melón H.V.',2,0,0,0.75,0,0,0,1,0,0,0,0,68,0,1),
  (236,'Curacao H.V.',2,0,0,0.75,0,0,0,1,0,0,0,0,70,0,1),
  (237,'Southern Comfort',2,0,0,0.75,0,0,0,1,0,0,0,0,170,0,1),
  (238,'Martini Rojo',2,0,0,0.75,0,0,0,2,0,0,0,0,129,0,1),
  (239,'Martini Extra Dry',2,0,0,0.75,0,0,0,1,0,0,0,0,129,0,1),
  (240,'Martini Bianco',2,0,0,0.75,0,0,0,1,0,0,0,0,129,0,1),
  (241,'Cinzano Rojo',2,0,0,0.75,0,0,0,1,0,0,0,0,120,0,1),
  (242,'Jarabe de Granadina',2,0,0,1,0,0,0,1,0,0,0,0,20,0,1),
  (243,'Jarabe Natural',2,0,0,1,0,0,0,4,0,0.985,0,0,20,0,1),
  (244,'Ron Baraima Black',2,0,0,0.75,0,0,0,1,0,0,0,0,150,0,1),
  (245,'Ron Baraima Añejo',2,0,0,0.75,0,0,0,1,0,0,0,0,150,0,1),
  (246,'Whisky Johnnie Walker E.R.',2,0,0,0.75,0,0,0,3,0,0.48,0,0,185,0,1),
  (247,'Coca Cola Mediana',2,0,0,0.354,0,0,0,192,0,0,0,0,4.38,0,0),
  (248,'Coca Cola Chica',2,0,0,0.191,0,0,0,192,0,0,0,0,4.38,0,0),
  (249,'Coca Cola Light Mediana',2,0,0,0.354,0,0,0,72,0,0,0,0,5.25,0,0),
  (250,'Coca Cola Light Chica',2,0,0,0.191,0,0,0,72,0,0,0,0,4.75,0,0),
  (251,'Sidral',2,0,0,0.31,0,0,0,72,0,0,0,0,3.96,0,1),
  (252,'Quina',2,0,0,0.191,0,0,0,118,0,0,0,0,4.38,0,1),
  (253,'Tehuacán',2,0,0,0.354,0,0,0,258,0,0.251,0,0,4.63,0,1),
  (254,'Ginger Ale',2,0,0,0.354,0,0,0,24,0,0,0,0,3.94,0,1),
  (255,'Clamato',2,0,0,0.295,0,0,0,22,0,0.192,0,0,8.38,0,1),
  (256,'Del Valle',2,0,0,0.355,0,0,0,96,0,0,0,0,3.96,0,1),
  (257,'Squirt Light',2,0,0,0.354,0,0,0,24,0,0,0,0,5.25,0,1),
  (258,'Squirt',2,0,0,0.355,0,0,0,141,0,0,0,0,3.94,0,1),
  (259,'Pan Molido',1,1,0,0,0,1,0,0,0,0,15,0,0,0,1),
  (260,'Lechuga Orejona',1,2,0.45,0,0,-1.1,3,0,0,0,0,15,0,0,1),
  (261,'Anchoa',1,2,0.2,0,0,-0.42,3,0,0,0,0,60,0,0,1),
  (262,'Queso Parmesano Rallado',1,1,0,0,0,0.2,0,0,0,0,120,0,0,0,1),
  (263,'Riñonada de Cabrito',1,1,0,0,0,1.52,0,0,0,0,98,0,0,0,1),
  (264,'Espaldilla de Cabrito',1,1,0,0,0,3.04,0,0,0,0,98,0,0,0,1),
  (265,'Pierna de Cabrito',1,1,0,0,0,3.04,0,0,0,0,98,0,0,0,1),
  (266,'Sopa de Botana',1,2,0,0,0,0,10000,0,0,0,0,0,0,0,1),
  (267,'Tacos',1,2,0,0,0,0,10000,0,0,0,0,0,0,0,1),
  (268,'Quesadillas',1,2,0,0,0,0,10000,0,0,0,0,0,0,0,1),
  (269,'Guisado',1,2,0,0,0,0,10000,0,0,0,0,0,0,0,1),
  (270,'Cafe',1,1,0,0,0,9.985,0,0,0,0,60,0,0,0,1),
  (271,'Cerveza Corona',2,0,0,0.325,0,0,0,200,0,0,0,0,5.1,0,1),
  (272,'Cerveza Victoria',2,0,0,0.325,0,0,0,140,0,0,0,0,4.65,0,1),
  (273,'Cerveza Negra Modelo',2,0,0,0.325,0,0,0,96,0,0,0,0,6.84,0,1),
  (274,'Cerveza Modelo Especial',2,0,0,0.325,0,0,0,69,0,0,0,0,6.84,0,1),
  (275,'Cerveza Pacifico',2,0,0,0.325,0,0,0,60,0,0,0,0,4.65,0,1),
  (276,'Cerveza León negra',2,0,0,0.325,0,0,0,60,0,0,0,0,4.25,0,1),
  (277,'Cerveza Montejo',2,0,0,0.325,0,0,0,37,0,0,0,0,4.25,0,1),
  (278,'Cerveza Modelo Light',2,0,0,0.325,0,0,0,24,0,0,0,0,4.71,0,1),
  (279,'Cerveza Ó\'Douls',2,0,0,0.325,0,0,0,24,0,0,0,0,8.46,0,1),
  (280,'Coca Cola',2,0,0,0.203,0.355,0,0,192,274,0,0,0,4.38,4.38,1),
  (281,'Coca Cola Light',2,0,0,177,355,0,0,72,71,0,0,0,4.75,5.25,1),
  (282,'Canada Dry',2,0,0,0.355,0,0,0,23,0,0,0,0,3.94,0,1),
  (283,'Veneno',2,0,0,0.25,0,0,0,0,0,0.241,0,0,45,0,1),
  (284,'Sangrita',2,0,0,1,0,0,0,1,0,0,0,0,60,0,1),
  (285,'Jugo de Limón',2,0,0,1,0,0,0,0,0,0.946,0,0,25,0,1),
  (286,'Licor de Cassis H.V.',2,0,0,0.75,0,0,0,1,0,0,0,0,70,0,1),
  (287,'Licor de Manzana Verde',2,0,0,0.75,0,0,0,1,0,0,0,0,70,0,1),
  (288,'Licor de Platano H.V.',2,0,0,0.75,0,0,0,1,0,0,0,0,70,0,1),
  (289,'Curacao Azul H.V.',2,0,0,0.75,0,0,0,1,0,0,0,0,70,0,1),
  (290,'Helado',1,2,0.1,0,0,0,1000,0,0,0,0,16,0,0,1),
  (291,'Cerveza Budweiser',2,0,0,0.355,0,0,0,24,0,0,0,0,9.6,0,1);

COMMIT;

#
# Data for the `mesas` table  (LIMIT 0,500)
#

INSERT INTO `mesas` (`IDMesa`, `Estatus`, `LigaA`) VALUES 
  (1,0,NULL),
  (2,0,NULL),
  (3,0,NULL),
  (4,0,NULL),
  (5,0,NULL),
  (6,0,NULL),
  (7,0,NULL),
  (8,0,NULL),
  (9,1,NULL),
  (10,0,NULL),
  (11,1,NULL),
  (12,0,NULL),
  (13,0,NULL),
  (14,0,NULL),
  (15,0,NULL),
  (16,0,NULL),
  (17,0,NULL),
  (18,0,NULL);

COMMIT;

#
# Data for the `traspasoautomatico` table  (LIMIT 0,500)
#

INSERT INTO `traspasoautomatico` (`Cantidad`, `MatPClave`, `Fecha`) VALUES 
  (2,274,'2006-12-06'),
  (1,246,'2006-12-06'),
  (1,277,'2006-12-06'),
  (1,277,'2006-12-06'),
  (1,217,'2006-12-06'),
  (1,214,'2006-12-07'),
  (1,187,'2006-12-07'),
  (1,274,'2006-12-07'),
  (1,277,'2006-12-07'),
  (1,110,'2006-12-07'),
  (1,202,'2006-12-07'),
  (1,152,'2006-12-07'),
  (1,204,'2006-12-07'),
  (1,172,'2006-12-07'),
  (1,118,'2006-12-07'),
  (1,132,'2006-12-07'),
  (1,243,'2006-12-07'),
  (1,285,'2006-12-07'),
  (1,140,'2006-12-07'),
  (1,255,'2006-12-07'),
  (1,283,'2006-12-07'),
  (1,167,'2006-12-07'),
  (1,253,'2006-12-07'),
  (1,177,'2006-12-08'),
  (1,178,'2006-12-08');

COMMIT;

#
# Data for the `usuarios` table  (LIMIT 0,500)
#

INSERT INTO `usuarios` (`ClaveU`, `Contrasena`, `Tipo`, `Nombre`, `APaterno`, `AMaterno`, `Puesto`, `Area`, `Estatus`) VALUES 
  ('blue','0103','Simple','Shary Estefanía','Manzanares','Nuñez','Hostes','Ventas','1'),
  ('Karen','1234','Simple','Leslie Karen','Arzate','Mondragón','Hostes','Ventas','1'),
  ('manuel','1234','Simple','manuel','hermida','gutierrez','Caja','Cobros','0'),
  ('producto','2222','Simple','Producto','Producto','Producto','producto','producto','1'),
  ('Roxana','1606','Simple','Mónica Roxana','Cruz','Carrasco','Mesera','Ventas','1'),
  ('Sarahi','2422','Simple','Sarahi','Bonilla','Calzada','Mesera','Ventas','1'),
  ('super','1111','Admin','Super','Super','Super','Administrador','Admin','1'),
  ('Yareth','2207','Simple','Yareth','Bonilla','Calzada','Bartender','Operativa','1');

COMMIT;

