# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : ultramarina


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `ultramarina`;

CREATE DATABASE `ultramarina`;

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
  `combinable` int(1) default '1',
  `dimensionable` int(1) default '1',
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
  `ClaveU` varchar(8) collate latin1_spanish_ci default NULL,
  `Contra` int(4) unsigned NOT NULL default '0',
  `Nombre` varchar(20) collate latin1_spanish_ci NOT NULL default '',
  `APaterno` varchar(20) collate latin1_spanish_ci NOT NULL default '',
  `AMaterno` varchar(20) collate latin1_spanish_ci default NULL,
  `Tipo` int(1) default '0',
  `Activo` int(1) NOT NULL default '1',
  PRIMARY KEY  (`IDEmpleado`),
  UNIQUE KEY `IDEmpleado` (`IDEmpleado`)
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
# combinable:3:32768
# dimensionable:3:32768

INSERT INTO `bebidas` (`clave`, `nombre`, `descripcion`, `materia0`, `materia1`, `materia2`, `materia3`, `materia4`, `materia5`, `materia6`, `materia7`, `materia8`, `materia9`, `cantidad0`, `cantidad1`, `cantidad2`, `cantidad3`, `cantidad4`, `cantidad5`, `cantidad6`, `cantidad7`, `cantidad8`, `cantidad9`, `precioC`, `precioB1`, `precioB2`, `division`, `estatus`, `alcoholica`, `combinable`, `dimensionable`) VALUES 
  (1,'Tequila Reserva Especial Don Julio','Añejado por 10 años',4,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,480.00,0.00,3,1,1,1,0),
  (2,'Tequila Jimador','Bravo de Jalisco',5,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,220.00,0.00,3,1,1,1,1),
  (3,'Paloma Jimador','Refrescante',5,0,0,0,0,0,0,0,0,0,0.150,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,3,1,1,1,1),
  (4,'Vino tinto Sangre de Toro','Cabernet Sauvigon',6,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,350.00,250.00,5,1,1,0,0),
  (5,'Vino Blanco Blue Rhin','Aleman de Origen',7,0,0,0,0,0,0,0,0,0,0.300,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,180.00,130.00,5,1,1,0,0),
  (6,'Charro Vikingo','V. Blanco Aleman T. Jimador',5,7,0,0,0,0,0,0,0,0,0.200,0.350,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,0.00,0.00,4,1,1,0,1),
  (7,'Coca-Cola','Refreco',10,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,25.00,20.00,6,1,0,2,0),
  (8,'Tehuacan','Agua Mineral',11,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,22.00,0.00,6,1,0,2,0),
  (9,'Squirt','Sabor Toronja',12,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,12.00,0.00,6,1,0,2,0);

COMMIT;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

# rfc:253:1
# CURP:253:0
# nombre:253:1
# direccion:253:1
# colonia:253:0
# delegacion:253:0
# cp:253:0
# ciudad:253:0
# tel1:253:0
# tel2:253:0
# fax:253:0
# email:253:0
# contacto:253:0
# alta:10:128
# activo:3:32768

INSERT INTO `clientes` (`rfc`, `CURP`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tel1`, `tel2`, `fax`, `email`, `contacto`, `alta`, `activo`) VALUES 
  ('feje751115gw1','feje751115','Enrique Fernandez Jaimes','Cerro de la libertad #227','Campestre Churubusco','Coyoacan','04200','México, D.F.','55497316','','','enrique@alphanet.com.mx','Enrique','2006-10-26',0);

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
  (5,'Vinos',2,1),
  (6,'Refrescos',2,1);

COMMIT;

#
# Data for the `empleados` table  (LIMIT 0,500)
#

# IDEmpleado:3:49703
# ClaveU:253:0
# Contra:3:32801
# Nombre:253:1
# APaterno:253:1
# AMaterno:253:0
# Tipo:3:32768
# Activo:3:32769

INSERT INTO `empleados` (`IDEmpleado`, `ClaveU`, `Contra`, `Nombre`, `APaterno`, `AMaterno`, `Tipo`, `Activo`) VALUES 
  (1,NULL,2303,'Enrique','Fernández','Jaimes',0,1),
  (2,NULL,2303,'Sofía','Gabián','Domínguez',0,1);

COMMIT;

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
  (1,'Atún Tunny',1,2,0.350,0.000,0.000,0.000,10,0,0,0.000,0.00,8.50,0.00,0.00,1),
  (2,'Carne Tampiqueña',1,1,0.000,0.000,0.000,7.502,0,0,0,0.000,33.48,0.00,0.00,0.00,1),
  (3,'Frijoles La Costeña',1,2,0.300,0.000,0.000,0.225,9,0,0,0.000,0.00,7.80,0.00,0.00,1),
  (4,'Tequila Don Julio Reserva Especial',2,0,0.000,0.750,0.000,0.000,0,8,0,0.000,0.00,0.00,282.68,0.00,1),
  (5,'Tequila Jimador',2,0,0.000,0.750,0.000,0.000,0,8,0,0.734,0.00,0.00,87.50,0.00,1),
  (6,'Vino Tinto Sangre de Toro',2,0,0.000,0.750,0.500,0.000,0,8,6,0.200,0.00,0.00,230.00,150.00,1),
  (7,'Vino Blanco Rhin Blue Nun',2,0,0.000,0.850,0.500,0.000,0,8,6,0.350,0.00,0.00,120.00,80.00,1),
  (8,'Pollo',1,1,0.000,0.000,0.000,9.230,0,0,0,0.000,21.50,0.00,0.00,0.00,1),
  (9,'Jitomate',1,1,0.000,0.000,0.000,6.300,0,0,0,0.000,27.50,0.00,0.00,0.00,1),
  (10,'Coca-Cola',2,0,0.000,0.450,0.320,0.000,0,200,150,0.000,0.00,0.00,12.00,8.00,1),
  (11,'Tehuacan',2,0,0.000,0.350,0.000,0.000,0,200,0,0.000,0.00,0.00,6.00,0.00,1),
  (12,'Squirt',2,0,0.000,0.600,0.000,0.000,0,100,0,0.000,0.00,0.00,5.00,0.00,1);

COMMIT;

#
# Data for the `mesas` table  (LIMIT 0,500)
#

# IDMesa:3:49191
# Estatus:3:32801
# LigaA:253:0

INSERT INTO `mesas` (`IDMesa`, `Estatus`, `LigaA`) VALUES 
  (1,0,NULL),
  (2,0,NULL),
  (3,0,NULL),
  (4,0,NULL),
  (5,0,NULL),
  (6,0,NULL),
  (7,0,NULL),
  (8,0,NULL),
  (9,0,NULL),
  (10,0,NULL),
  (11,0,NULL),
  (12,0,NULL),
  (13,0,NULL),
  (14,0,NULL),
  (15,0,NULL),
  (16,0,NULL),
  (17,0,NULL),
  (18,0,NULL);

COMMIT;

#
# Data for the `proveedores` table  (LIMIT 0,500)
#

# rfc:253:0
# nombre:253:0
# direccion:253:0
# colonia:253:0
# delegacion:253:0
# cp:253:0
# ciudad:253:0
# tel1:253:0
# tel2:253:0
# fax:253:0
# pagina:253:0
# email:253:0
# vendedor:253:0
# formaPago:3:32768
# cuentas:252:16
# credito:5:32768
# diasPago:3:32768
# descuento1:5:32768
# descuento2:5:32768
# descuento3:5:32768
# saldoDisponible:5:32768
# alta:10:128
# activo:3:32768

INSERT INTO `proveedores` (`rfc`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tel1`, `tel2`, `fax`, `pagina`, `email`, `vendedor`, `formaPago`, `cuentas`, `credito`, `diasPago`, `descuento1`, `descuento2`, `descuento3`, `saldoDisponible`, `alta`, `activo`) VALUES 
  ('feje751115gw1','Enrique Fernandez','','','','','','55492494','','','','','',1,'',10000.00,15,0.00,0.00,0.00,10000.00,'2006-10-26',0);

COMMIT;

#
# Data for the `usuarios` table  (LIMIT 0,500)
#

# ClaveU:253:16391
# Contrasena:253:1
# Tipo:253:0
# Nombre:253:0
# APaterno:253:0
# AMaterno:253:0
# Puesto:253:0
# Area:253:0
# Estatus:254:0

INSERT INTO `usuarios` (`ClaveU`, `Contrasena`, `Tipo`, `Nombre`, `APaterno`, `AMaterno`, `Puesto`, `Area`, `Estatus`) VALUES 
  ('super','supe','Admin','Super','Super','Super','Administrador','Admin','1');

COMMIT;

