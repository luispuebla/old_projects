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
  `activo` int(1) default '1',
  `folio` varchar(10) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `cobros` table : 
#

DROP TABLE IF EXISTS `cobros`;

CREATE TABLE `cobros` (
  `consecutivo` int(11) NOT NULL auto_increment,
  `claveVenta` int(11) default NULL,
  `fechaCobro` datetime default NULL,
  `monto` double(8,2) default NULL,
  `formaPago` int(1) default NULL,
  `observaciones` varchar(255) collate latin1_spanish_ci default NULL,
  `activo` int(1) default NULL,
  `propina` double(8,2) default NULL,
  `usuario` varchar(11) collate latin1_spanish_ci default NULL,
  `facturado` int(1) default NULL,
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
  `Ob` varchar(30) collate latin1_spanish_ci default NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `descuentos` table : 
#

DROP TABLE IF EXISTS `descuentos`;

CREATE TABLE `descuentos` (
  `comanda` int(8) default NULL,
  `numComensal` int(4) default NULL,
  `porcentaje` int(3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
# Structure for the `facturaventa` table : 
#

DROP TABLE IF EXISTS `facturaventa`;

CREATE TABLE `facturaventa` (
  `consecutivo` int(11) NOT NULL auto_increment,
  `comanda` int(11) default NULL,
  `fechaComanda` datetime default NULL,
  `cobro` int(11) default NULL,
  `factura` varchar(10) collate latin1_spanish_ci default NULL,
  `fechaFactura` datetime default NULL,
  `monto` double(8,2) default NULL,
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `activo` int(1) default NULL,
  PRIMARY KEY  (`consecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `internopro` table : 
#

DROP TABLE IF EXISTS `internopro`;

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
  `tipo` char(1) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mermasb` table : 
#

DROP TABLE IF EXISTS `mermasb`;

CREATE TABLE `mermasb` (
  `claveProducto` int(11) default NULL,
  `cantidadB` int(11) default NULL,
  `cantidadB2` int(11) default NULL,
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
# Structure for the `tempinterno` table : 
#

DROP TABLE IF EXISTS `tempinterno`;

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
  ('ale','33','Simple','Alejandra','Flores','Bernal','Mesera','Ventas','0'),
  ('ALEX','33','Simple','ALEJANDRA','ZAVALA','MORENO','Hostes','Ventas','0'),
  ('Alfredo','4242','Simple','Alfredo','Olivares','Samaniego','Ayudante','Operativa','1'),
  ('Angeliqu','00','Simple','Angelique','Gorand','Gorand','Bartender','Operativa','0'),
  ('Ari','66','Simple','Ariadne','Diaz','Gomez','Mesera','Ventas','0'),
  ('atenea','22','Simple','atenea','iturriaga','sauco','Mesera','Ventas','0'),
  ('Barbara','33','Simple','Barbara','Martinez','Montesinos','Mesera','Ventas','0'),
  ('Begoña','22','Simple','Begoña','Landa','Marcano','Mesera','Ventas','0'),
  ('blue','0103','Simple','Shary Estefanía','Manzanares','Nuñez','Hostes','Ventas','0'),
  ('Claudia','33','Simple','Claudia','Monroy','Diaz','Mesera','Ventas','0'),
  ('Fabiola','55','Simple','Fabiola','Baylon','Guzman','Mesera','Ventas','1'),
  ('Jenny','2711','Simple','Jennifer','Rojas','Valdés','Mesera','Ventas','0'),
  ('Jessica','22','Simple','Jessica','Diaz','Rosas','Mesera','Ventas','1'),
  ('Jesús','4141','Simple','Jesús','Alcaraz','Ávila','Cocinero','Operativa','1'),
  ('JUDITH','44','Simple','JUDITH','SANCHEZ','PEROZO','Mesera','Ventas','1'),
  ('Karen','1234','Simple','Leslie Karen','Arzate','Mondragón','Hostes','Ventas','0'),
  ('Leslie','33','Simple','Karen','Arzate','Mondragón','Hostes','Ventas','1'),
  ('luis','1507','Admin','Luis Enrique','Ocampo','Castillo','Administrador','Admin','1'),
  ('luis1','1234','Caja','Luis Enrique','Ocampo','Castillo','Caja','Cobros','1'),
  ('manuel','1917','Admin','Manuel','Hermida','Gutierrez','Administrador','Admin','1'),
  ('manuel1','1234','Caja','manuel','hermida','gutierrez','Caja','Cobros','1'),
  ('Marina','22','Simple','Marina','Rodriguez','Rodriguez','Mesera','Ventas','0'),
  ('Mario','4343','Simple','Mario Alberto','Castellano','Pérez','Ayudante','Operativa','1'),
  ('Michelle','55','Simple','Michelle','Montaño','Tellez','Bartender','Operativa','0'),
  ('Paul','99','Simple','Paul','Liberato','Moreno','Ayudante','Operativa','1'),
  ('producto','2222','Simple','Producto','Producto','Producto','producto','producto','1'),
  ('Roxana','1212','Simple','Mónica Roxana','Cruz','Carrasco','Mesera','Ventas','0'),
  ('Sarahi','2422','Simple','Sarahi','Bonilla','Calzada','Mesera','Ventas','0'),
  ('Shary','77','Simple','Shary','Manzanares','de Oliver','Hostes','Ventas','0'),
  ('super','1111','Admin','Super','Super','Super','Administrador','Admin','1'),
  ('Tania','55','Simple','Tania','Gaspar','Fernandez','Mesera','Ventas','1'),
  ('Taymi','22','Simple','Taymi','Bransuela','Johnson','Mesera','Ventas','0'),
  ('VIANEY','11','Simple','Vianey','Rivas','Miguez','Mesera','Ventas','1'),
  ('Yar','2207','Caja','Yareth','Bonilla','Calzada','Caja','Cobros','0'),
  ('Yarendi','22','Simple','Yarendi','Barrera','Trujillo','Mesera','Ventas','0'),
  ('Yareth','2207','Simple','Yareth','Bonilla','Calzada','Bartender','Operativa','0'),
  ('Yareth1','11','Simple','Yareth','Bonilla','Calzada','Mesera','Ventas','0');

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
  (18,0,NULL),
  (19,0,NULL),
  (20,0,NULL),
  (21,0,NULL),
  (22,0,NULL),
  (23,0,NULL),
  (24,0,NULL),
  (25,0,NULL),
  (26,0,NULL),
  (27,0,NULL),
  (28,0,NULL),
  (29,0,NULL);

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
  (1,'Jitomate',1,1,0.000,0.000,0.000,2.720,3,0,0,0.000,16.00,0.00,0.00,0.00,1),
  (2,'Cebolla',1,1,0.000,0.000,0.000,13.625,0,0,0,-1.300,12.00,0.00,0.00,0.00,1),
  (3,'Papas',1,1,0.000,0.000,0.000,39.700,0,0,0,-108.900,10.00,0.00,0.00,0.00,1),
  (4,'Aguacate',1,1,0.000,0.000,0.000,-15.170,0,0,0,-0.510,25.00,0.00,0.00,0.00,1),
  (5,'Chayote',1,1,0.000,0.000,0.000,1.000,0,0,0,0.000,8.00,0.00,0.00,0.00,1),
  (6,'Zanahoria',1,1,0.000,0.000,0.000,45.100,0,0,0,0.000,8.00,0.00,0.00,0.00,1),
  (7,'Tomate Verde',1,1,0.000,0.000,0.000,27.980,0,0,0,0.000,28.00,0.00,0.00,0.00,1),
  (8,'Chile Cuaresmeño',1,1,0.000,0.000,0.000,-1.160,0,0,0,0.000,9.00,0.00,0.00,0.00,1),
  (9,'Chile Poblano',1,1,0.000,0.000,0.000,0.520,0,0,0,0.000,14.00,0.00,0.00,0.00,1),
  (10,'Chile de Árbol',1,1,0.000,0.000,0.000,-8.850,0,0,0,0.000,60.00,0.00,0.00,0.00,1),
  (11,'Ajo',1,1,0.000,0.000,0.000,-8.526,0,0,0,-5.270,35.00,0.00,0.00,0.00,1),
  (12,'Hierbas de Olor',1,2,0.050,0.000,0.000,-48.194,709,0,0,-0.150,0.00,10.00,0.00,0.00,1),
  (13,'Nopales',1,1,0.000,0.000,0.000,20.000,0,0,0,0.000,10.00,0.00,0.00,0.00,1),
  (14,'Limón',1,2,18.000,0.000,0.000,-6567.275,364,0,0,0.000,0.00,150.00,0.00,0.00,1),
  (15,'Elotes',1,2,0.050,0.000,0.000,0.000,20,0,0,0.000,0.00,2.00,0.00,0.00,1),
  (16,'Calabacitas',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,10.00,0.00,0.00,0.00,1),
  (17,'Espinacas',1,1,0.000,0.000,0.000,-0.650,0,0,0,0.000,15.00,0.00,0.00,0.00,1),
  (18,'Lechugas Romanas',1,2,800.000,0.000,0.000,-38402.400,56,0,0,0.000,0.00,5.00,0.00,0.00,1),
  (19,'Pimiento Morrón',1,1,0.000,0.000,0.000,3.200,0,0,0,0.000,16.00,0.00,0.00,0.00,1),
  (20,'Apio',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,20.00,0.00,0.00,0.00,1),
  (21,'Naranja',1,1,0.000,0.000,0.000,13.700,0,0,0,0.000,6.00,0.00,0.00,0.00,1),
  (22,'Cilantro',1,1,0.000,0.000,0.000,-0.680,0,0,0,-2.210,40.00,0.00,0.00,0.00,1),
  (23,'Epazote',1,1,0.000,0.000,0.000,-6.075,0,0,0,0.000,40.00,0.00,0.00,0.00,1),
  (24,'Verdolagas',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,15.00,0.00,0.00,0.00,1),
  (25,'Champìñones',1,1,0.000,0.000,0.000,1.010,0,0,0,0.000,28.00,0.00,0.00,0.00,1),
  (26,'Pepinos',1,1,0.000,0.000,0.000,3.800,0,0,0,0.000,16.00,0.00,0.00,0.00,1),
  (27,'Poros',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,16.00,0.00,0.00,0.00,1),
  (28,'Chile Guajillo',1,1,0.000,0.000,0.000,0.850,0,0,0,0.000,45.00,0.00,0.00,0.00,1),
  (29,'Chile Morita',1,1,0.000,0.000,0.000,1.000,0,0,0,0.000,50.00,0.00,0.00,0.00,1),
  (30,'Camarón Seco',1,1,0.000,0.000,0.000,20.000,0,0,0,0.000,130.00,0.00,0.00,0.00,1),
  (31,'Chile Ancho',1,1,0.000,0.000,0.000,1.000,0,0,0,0.000,45.00,0.00,0.00,0.00,1),
  (32,'Chile Pasilla',1,1,0.000,0.000,0.000,1.000,0,0,0,0.000,45.00,0.00,0.00,0.00,1),
  (33,'Queso Manchego',1,1,0.000,0.000,0.000,-147.250,0,0,0,0.000,60.00,0.00,0.00,0.00,1),
  (34,'Queso Panela',1,1,0.000,0.000,0.000,1.200,0,0,0,0.000,40.00,0.00,0.00,0.00,1),
  (35,'Chorizo',1,1,0.000,0.000,0.000,25.950,0,0,0,0.000,35.00,0.00,0.00,0.00,1),
  (36,'Tocino',1,1,0.000,0.000,0.000,5.000,0,0,0,-1.680,70.00,0.00,0.00,0.00,1),
  (37,'Salchicha',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,45.00,0.00,0.00,0.00,1),
  (38,'Huevos',1,1,0.000,0.000,0.000,15.590,0,0,0,0.000,12.00,0.00,0.00,0.00,1),
  (39,'Mantequilla',1,1,0.000,0.000,0.000,-10.460,0,0,0,0.000,45.00,0.00,0.00,0.00,1),
  (40,'Queso Rayado',1,1,0.000,0.000,0.000,-1.300,0,0,0,0.000,25.00,0.00,0.00,0.00,1),
  (41,'Sal de Grano',1,1,0.000,0.000,0.000,-21.742,0,0,0,0.000,3.00,0.00,0.00,0.00,1),
  (42,'Sal de Mesa',1,1,0.000,0.000,0.000,-0.563,0,0,0,-1.175,3.00,0.00,0.00,0.00,1),
  (43,'Consome de Pollo',1,2,0.800,0.000,0.000,0.000,10,0,0,0.000,0.00,42.00,0.00,0.00,1),
  (44,'Chile Chipotle',1,2,0.380,0.000,0.000,-10.800,37,0,0,0.000,0.00,16.00,0.00,0.00,1),
  (45,'Harina de Trigo',1,1,0.000,0.000,0.000,8.310,0,0,0,-3.400,10.00,0.00,0.00,0.00,1),
  (46,'Aceitunas',1,2,0.100,0.000,0.000,-7.000,43,0,0,0.000,0.00,9.00,0.00,0.00,1),
  (47,'Atún',1,2,0.120,0.000,0.000,0.000,24,0,0,0.000,0.00,8.00,0.00,0.00,1),
  (48,'Chongos Zamoranos',1,2,1.000,0.000,0.000,-78.400,70,0,0,0.000,0.00,40.00,0.00,0.00,1),
  (49,'Duraznos en Almibar',1,2,0.820,0.000,0.000,-56.460,58,0,0,0.000,0.00,17.00,0.00,0.00,1),
  (50,'Até',1,1,0.000,0.000,0.000,-14.900,0,0,0,0.000,120.00,0.00,0.00,0.00,1),
  (51,'Salsa Catsup',1,2,0.700,0.000,0.000,-80.240,113,0,0,0.000,0.00,17.00,0.00,0.00,1),
  (52,'Pure de Tomate',1,2,1.000,0.000,0.000,0.000,10,0,0,0.000,0.00,12.00,0.00,0.00,1),
  (53,'Cerezas',1,2,0.082,0.000,0.000,0.000,5,0,0,0.000,0.00,15.00,0.00,0.00,1),
  (54,'Frijol Negro',1,1,0.000,0.000,0.000,9.850,0,0,0,0.000,18.00,0.00,0.00,0.00,1),
  (55,'Sopa de Fideo',1,2,0.200,0.000,0.000,0.000,10,0,0,0.000,0.00,4.00,0.00,0.00,1),
  (56,'Sopa de Munición',1,2,0.200,0.000,0.000,0.000,10,0,0,0.000,0.00,4.00,0.00,0.00,1),
  (57,'Sopa de Moño',1,2,0.200,0.000,0.000,0.000,10,0,0,0.000,0.00,4.00,0.00,0.00,1),
  (58,'Sopa de Codito',1,2,0.200,0.000,0.000,0.000,10,0,0,0.000,0.00,4.00,0.00,0.00,1),
  (59,'Lenteja',1,1,0.000,0.000,0.000,10.000,0,0,0,0.000,12.00,0.00,0.00,0.00,1),
  (60,'Haba',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,26.00,0.00,0.00,0.00,1),
  (61,'Spaghuetti',1,2,0.200,0.000,0.000,0.000,10,0,0,0.000,0.00,4.00,0.00,0.00,1),
  (62,'Arroz',1,2,1.000,0.000,0.000,0.000,20,0,0,0.000,0.00,10.00,0.00,0.00,1),
  (63,'Vinagre Blanco',2,0,0.000,0.750,0.000,0.000,0,24,0,16.990,0.00,0.00,9.00,0.00,1),
  (64,'Galletas Saladas',1,2,0.540,0.000,0.000,0.000,10,0,0,0.000,0.00,21.00,0.00,0.00,1),
  (65,'Garbanzos',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,23.00,0.00,0.00,0.00,1),
  (66,'Concentrado de Coco',1,2,0.480,0.000,0.000,-62.688,129,0,0,0.000,0.00,15.00,0.00,0.00,1),
  (67,'Sesos de Res',1,1,0.000,0.000,0.000,25.800,0,0,0,0.000,81.00,0.00,0.00,0.00,1),
  (68,'Manitas de Cerdo',1,1,0.000,0.000,0.000,4.500,0,0,0,0.000,23.00,0.00,0.00,0.00,1),
  (69,'Jamón Serrano',1,2,0.100,0.000,0.000,-36.600,194,0,0,0.000,0.00,30.00,0.00,0.00,1),
  (70,'Machitos de carnero',1,2,0.250,0.000,0.000,-104.500,227,0,0,0.000,0.00,7.00,0.00,0.00,1),
  (71,'Chistorra',1,1,0.000,0.000,0.000,-16.500,0,0,0,0.000,50.00,0.00,0.00,0.00,1),
  (72,'Pierna de Cerdo',1,1,0.000,0.000,0.000,-26.150,0,0,0,0.000,34.00,0.00,0.00,0.00,1),
  (73,'Filete de Res',1,1,0.000,0.000,0.000,-105.900,0,0,0,0.000,120.00,0.00,0.00,0.00,1),
  (74,'Pechuga de Pollo',1,2,0.200,0.000,0.000,-115.550,284,0,0,0.000,0.00,7.00,0.00,0.00,1),
  (75,'Cecina Enchilada',1,1,0.000,0.000,0.000,20.200,0,0,0,0.000,80.00,0.00,0.00,0.00,1),
  (76,'Top Sirloin',1,1,0.000,0.000,0.000,37.250,0,0,0,0.000,90.00,0.00,0.00,0.00,1),
  (77,'T Bone',1,1,0.000,0.000,0.000,37.500,0,0,0,0.000,90.00,0.00,0.00,0.00,1),
  (78,'Arrachera',1,1,0.000,0.000,0.000,-53.500,0,0,0,0.000,130.00,0.00,0.00,0.00,1),
  (79,'Filete de Pescado',1,2,250.000,0.000,0.000,-50547.510,210,0,0,0.000,0.00,16.00,0.00,0.00,1),
  (80,'Cabrito 6 piezas',1,1,0.000,0.000,0.000,1.000,0,0,0,0.000,85.00,0.00,0.00,0.00,0),
  (81,'Almejas',1,1,0.000,0.000,0.000,-140.100,0,0,0,0.000,30.00,0.00,0.00,0.00,1),
  (82,'Huachinango',1,1,0.000,0.000,0.000,26.000,0,0,0,0.000,160.00,0.00,0.00,0.00,1),
  (83,'Camarón Grande',1,1,0.000,0.000,0.000,-35.450,0,0,0,0.000,185.00,0.00,0.00,0.00,1),
  (84,'Camarón Cocktail',1,1,0.000,0.000,0.000,1.400,0,0,0,0.000,125.00,0.00,0.00,0.00,1),
  (85,'Pescado Sierra',1,1,0.000,0.000,0.000,18.400,0,0,0,0.000,45.00,0.00,0.00,0.00,1),
  (86,'Tortilla de Maiz',1,1,0.000,0.000,0.000,66.130,0,0,0,0.000,8.00,0.00,0.00,0.00,1),
  (87,'Tortillas de Harina',1,2,0.200,0.000,0.000,-107.410,171,0,0,0.000,0.00,6.00,0.00,0.00,1),
  (88,'Bolillo',1,2,0.090,0.000,0.000,0.000,50,0,0,0.000,0.00,1.00,0.00,0.00,1),
  (89,'Flan Casero',1,2,1.000,0.000,0.000,-123.400,113,0,0,0.000,0.00,75.00,0.00,0.00,1),
  (90,'Lechuga Sangría',1,2,0.400,0.000,0.000,-7.200,36,0,0,0.000,0.00,7.00,0.00,0.00,1),
  (91,'Cebollitas Cambray',1,1,0.000,0.000,0.000,20.000,0,0,0,0.000,30.00,0.00,0.00,0.00,1),
  (92,'Appleton White',2,0,0.000,0.750,1.000,0.000,0,2,3,0.500,0.00,0.00,100.00,150.00,0),
  (93,'Salsa Maggi',2,0,0.000,0.200,0.000,0.000,0,0,0,-0.135,0.00,0.00,27.00,0.00,1),
  (94,'Salsa Inglesa',2,0,0.000,0.145,0.290,0.000,0,20,6,-0.045,0.00,0.00,18.00,25.00,1),
  (95,'Salsa Tabasco',2,0,0.000,0.060,0.355,0.000,0,12,2,0.150,0.00,0.00,25.00,75.00,1),
  (96,'Salsa Valentina',2,0,0.000,0.370,0.000,0.000,0,11,0,0.020,0.00,0.00,6.50,0.00,1),
  (97,'Leche Carnation',2,0,0.000,0.373,0.000,0.000,0,46,0,0.083,0.00,0.00,9.00,0.00,1),
  (98,'Jugo de Piña',2,0,0.000,1.000,0.000,0.000,0,80,0,0.649,0.00,0.00,13.00,0.00,1),
  (99,'Jugo de Naranja',2,0,0.000,1.000,0.000,0.000,0,77,0,0.928,0.00,0.00,13.00,0.00,1),
  (100,'Jugo de Tomate',2,0,0.000,1.000,0.000,0.000,0,96,0,0.640,0.00,0.00,13.00,0.00,1),
  (101,'Jugo de Toronja',2,0,0.000,1.000,0.000,0.000,0,100,0,0.935,0.00,0.00,13.00,0.00,1),
  (102,'Jugo de Uva',2,0,0.000,1.000,0.000,0.000,0,99,0,1.095,0.00,0.00,13.00,0.00,1),
  (103,'Jugo de Arandano',2,0,0.000,2.840,0.000,0.000,0,98,0,0.325,0.00,0.00,36.00,0.00,1),
  (104,'Agua Embotellada',2,0,0.000,0.500,0.000,0.000,0,332,0,0.000,0.00,0.00,2.00,0.00,1),
  (105,'crema',2,0,0.000,1.000,0.000,0.000,0,10,0,-3.000,0.00,0.00,21.00,0.00,1),
  (106,'Aceite',2,0,0.000,1.000,0.000,0.000,0,12,0,-101.075,0.00,0.00,10.50,0.00,1),
  (107,'Aceite de Olivo',2,0,0.000,1.000,0.000,0.000,0,3,0,-6.860,0.00,0.00,95.00,0.00,1),
  (108,'Mostaza',1,2,0.397,0.000,0.000,0.000,10,0,0,0.000,0.00,19.10,0.00,0.00,1),
  (109,'Mayonesa',1,2,0.790,0.000,0.000,0.000,10,0,0,0.000,0.00,31.93,0.00,0.00,1),
  (110,'Campari',2,0,0.000,0.750,0.000,0.000,0,1,0,0.630,0.00,0.00,145.00,0.00,1),
  (111,'Cinzano Dulce',2,0,0.000,0.750,0.000,0.000,0,1,0,0.705,0.00,0.00,120.00,0.00,1),
  (112,'Cinzano Seco',2,0,0.000,0.750,0.000,0.000,0,1,0,0.750,0.00,0.00,120.00,0.00,1),
  (113,'Vino Blanco Concha y Toro',2,0,0.000,0.750,0.375,0.000,0,9,10,-131.343,0.00,0.00,55.00,34.00,1),
  (114,'Vino Tinto Concha y Toro',2,0,0.000,0.750,0.375,0.000,0,4,0,0.323,0.00,0.00,55.00,34.00,1),
  (115,'Oporto Ferreira',2,0,0.000,0.750,0.000,0.000,0,2,0,0.660,0.00,0.00,156.00,0.00,1),
  (116,'Amaretto H.V.',2,0,0.000,0.750,0.000,0.000,0,2,0,0.570,0.00,0.00,72.00,0.00,1),
  (117,'Bailey\'s',2,0,0.000,0.750,0.000,0.000,0,2,0,0.045,0.00,0.00,175.00,0.00,1),
  (118,'Controy',2,0,0.000,0.750,0.000,0.000,0,1,0,0.465,0.00,0.00,75.00,0.00,1),
  (119,'Crema de Menta',2,0,0.000,0.750,0.000,0.000,0,0,0,0.613,0.00,0.00,70.00,0.00,1),
  (120,'Chartreuse Amarillo',2,0,0.000,0.700,0.000,0.000,0,1,0,0.000,0.00,0.00,350.00,0.00,1),
  (121,'Chartreuse Verde',2,0,0.000,0.700,0.000,0.000,0,1,0,0.520,0.00,0.00,356.00,0.00,1),
  (122,'Frangelico',2,0,0.000,0.700,0.000,0.000,0,2,0,0.565,0.00,0.00,274.00,0.00,1),
  (123,'Galliano',2,0,0.000,0.700,0.000,0.000,0,2,0,0.520,0.00,0.00,185.00,0.00,1),
  (124,'Grand Marnier',2,0,0.000,0.700,0.000,0.000,0,2,0,0.655,0.00,0.00,405.00,0.00,1),
  (125,'Licor 43',2,0,0.000,0.750,0.000,0.000,0,2,0,0.675,0.00,0.00,270.00,0.00,1),
  (126,'Midori',2,0,0.000,0.750,0.000,0.000,0,2,0,0.767,0.00,0.00,170.00,0.00,1),
  (127,'Strega',2,0,0.000,0.750,0.000,0.000,0,1,0,0.645,0.00,0.00,285.00,0.00,1),
  (128,'Kahlúa',2,0,0.000,0.980,0.000,0.000,0,2,0,0.536,0.00,0.00,87.00,0.00,1),
  (129,'Vaccari Black',2,0,0.000,0.700,0.000,0.000,0,2,0,0.285,0.00,0.00,229.00,0.00,1),
  (130,'Vaccari White',2,0,0.000,0.700,0.000,0.000,0,2,0,0.680,0.00,0.00,203.00,0.00,1),
  (131,'Tequila 100 Años',2,0,0.000,0.750,0.000,0.000,0,4,0,0.315,0.00,0.00,94.00,0.00,1),
  (132,'Tequila Cabrito',2,0,0.000,1.000,0.000,0.000,0,5,0,0.494,0.00,0.00,106.00,0.00,1),
  (133,'Tequila Cazadores',2,0,0.000,0.750,1.000,0.000,0,19,12,0.125,0.00,0.00,170.00,206.00,1),
  (134,'Tequila Centenario Reposado',2,0,0.000,0.950,0.000,0.000,0,3,0,0.110,0.00,0.00,173.00,0.00,1),
  (135,'Tequila Centenario Plata',2,0,0.000,0.700,0.000,0.000,0,3,0,0.260,0.00,0.00,119.00,0.00,1),
  (136,'Tequila Cuervo 1800',2,0,0.000,0.700,0.000,0.000,0,6,0,0.495,0.00,0.00,245.00,0.00,1),
  (137,'Tequila Cuervo Especial',2,0,0.000,0.700,0.000,0.000,0,5,0,0.630,0.00,0.00,245.00,0.00,1),
  (138,'Tequila Cuervo Tradicional',2,0,0.000,0.695,0.950,0.000,0,10,5,0.540,0.00,0.00,165.00,207.00,1),
  (139,'Tequila Don Julio Blanco',2,0,0.000,0.750,0.000,0.000,0,5,0,0.585,0.00,0.00,220.00,0.00,1),
  (140,'Tequila Don Julio Reposado',2,0,0.000,0.750,0.000,0.000,0,5,0,0.450,0.00,0.00,277.00,0.00,1),
  (141,'Tequila Herradura Reposado',2,0,0.000,0.700,0.000,0.000,0,7,0,0.395,0.00,0.00,259.00,0.00,1),
  (142,'Tequila Herradura Blanco',2,0,0.000,0.700,0.950,0.000,0,10,6,0.820,0.00,0.00,220.00,295.00,1),
  (143,'Tequila Herradura Añejo',2,0,0.000,0.750,0.000,0.000,0,4,0,0.225,0.00,0.00,369.00,0.00,1),
  (144,'Tequila Jimador',2,0,0.000,0.950,0.000,0.000,0,4,0,0.575,0.00,0.00,129.00,0.00,1),
  (145,'Tequila Sauza Conmemorativo',2,0,0.000,1.000,0.000,0.000,0,10,0,0.695,0.00,0.00,181.00,0.00,1),
  (146,'Tequila Sauza Hacienda',2,0,0.000,1.000,0.000,0.000,0,4,0,0.695,0.00,0.00,165.00,0.00,1),
  (147,'Tequila Sauza Hornitos',2,0,0.000,0.700,0.000,0.000,0,3,0,0.560,0.00,0.00,141.00,0.00,1),
  (148,'Tequila Siete Leguas',2,0,0.000,0.750,0.000,0.000,0,2,0,0.345,0.00,0.00,277.00,0.00,1),
  (149,'Ron Appleton White',2,0,0.000,0.750,0.950,0.000,0,18,0,0.330,0.00,0.00,69.00,86.00,1),
  (150,'Ron Appleton Special',2,0,0.000,0.750,0.950,0.000,0,8,5,0.325,0.00,0.00,90.00,103.00,1),
  (151,'Ron Appleton Estate',2,0,0.000,0.750,0.000,0.000,0,7,0,0.180,0.00,0.00,126.00,0.00,1),
  (152,'Ron Bacardi Blanco',2,0,0.000,0.946,0.000,0.000,0,19,0,0.286,0.00,0.00,86.00,0.00,1),
  (153,'Ron Bacardi Oro',2,0,0.000,0.946,0.000,0.000,0,2,0,0.496,0.00,0.00,87.00,0.00,1),
  (154,'Ron Bacardi Añejo',2,0,0.000,1.000,0.000,0.000,0,6,0,0.870,0.00,0.00,101.00,0.00,1),
  (155,'Ron Bacardi Limón',2,0,0.000,0.750,0.000,0.000,0,3,0,0.435,0.00,0.00,109.00,0.00,1),
  (156,'Ron Bacardi Coco',2,0,0.000,0.750,0.000,0.000,0,3,0,0.705,0.00,0.00,109.00,0.00,1),
  (157,'Ron Bacardi Razz',2,0,0.000,0.750,0.000,0.000,0,3,0,0.165,0.00,0.00,109.00,0.00,1),
  (158,'Ron Bacardi Solera',2,0,0.000,0.750,0.000,0.000,0,7,0,0.660,0.00,0.00,126.00,0.00,1),
  (159,'Ron Bacardi 101',2,0,0.000,0.750,0.000,0.000,0,1,0,0.255,0.00,0.00,120.00,0.00,1),
  (160,'Ron Baraima Blanco',2,0,0.000,0.700,0.000,0.000,0,2,0,0.275,0.00,0.00,50.00,0.00,1),
  (161,'Ron Castillo Imperial',2,0,0.000,1.000,0.000,0.000,0,2,0,0.425,0.00,0.00,54.00,0.00,1),
  (162,'Ron Flor de Caña Extra Dry',2,0,0.000,0.750,0.000,0.000,0,5,0,0.075,0.00,0.00,75.00,0.00,1),
  (163,'Ron Flor de Caña 4 Años',2,0,0.000,0.750,0.000,0.000,0,4,0,0.675,0.00,0.00,109.00,0.00,1),
  (164,'Ron Flor de Caña 7 Años',2,0,0.000,0.750,0.000,0.000,0,4,0,0.720,0.00,0.00,138.00,0.00,1),
  (165,'Ron Flor de Caña 12 Años',2,0,0.000,0.750,0.000,0.000,0,1,0,0.285,0.00,0.00,189.00,0.00,1),
  (166,'Ron Havana Blanco',2,0,0.000,0.750,0.000,0.000,0,2,0,0.105,0.00,0.00,77.00,0.00,1),
  (167,'Ron Havana Añejo Especial (3 Años)',2,0,0.000,0.750,0.000,0.000,0,6,0,0.555,0.00,0.00,90.00,0.00,1),
  (168,'Ron Havana Añejo Reserva ( 5 Años)',2,0,0.000,0.750,0.000,0.000,0,3,0,0.600,0.00,0.00,135.00,0.00,1),
  (169,'Ron Havana 7 Años',2,0,0.000,0.750,0.000,0.000,0,9,0,0.180,0.00,0.00,205.00,0.00,1),
  (170,'Ron Malibú',2,0,0.000,0.750,0.000,0.000,0,4,0,0.225,0.00,0.00,134.00,0.00,1),
  (171,'Ron Matusalem Platino',2,0,0.000,0.750,0.000,0.000,0,4,0,0.105,0.00,0.00,95.00,0.00,1),
  (172,'Ron Matusalem Clásico',2,0,0.000,0.750,0.000,0.000,0,3,0,0.420,0.00,0.00,120.00,0.00,1),
  (173,'Ron Matusalem Gran Reserva',2,0,0.000,0.750,0.000,0.000,0,3,0,0.585,0.00,0.00,169.00,0.00,1),
  (174,'Ron Ocumare Blanco',2,0,0.000,0.700,0.000,0.000,0,2,0,0.000,0.00,0.00,79.00,0.00,1),
  (175,'Ron Ocumare Añejo',2,0,0.000,0.700,0.000,0.000,0,2,0,0.160,0.00,0.00,85.00,0.00,1),
  (176,'Ron Potosí Añejo',2,0,0.000,1.000,0.000,0.000,0,2,0,0.290,0.00,0.00,77.00,0.00,1),
  (177,'Brandy Azteca de Oro',2,0,0.000,0.700,0.000,0.000,0,3,0,0.495,0.00,0.00,124.00,0.00,1),
  (178,'Brandy Cardenal de Mendoza',2,0,0.000,0.700,0.000,0.000,0,1,0,0.025,0.00,0.00,450.00,0.00,1),
  (179,'Brandy Carlos I',2,0,0.000,0.700,0.000,0.000,0,2,0,0.230,0.00,0.00,435.00,0.00,1),
  (180,'Brandy Don Pedro',2,0,0.000,0.750,1.000,0.000,0,1,0,0.240,0.00,0.00,78.00,101.00,1),
  (181,'Brandy Duque de Alba',2,0,0.000,0.700,0.000,0.000,0,0,0,0.275,0.00,0.00,360.00,0.00,1),
  (182,'Brandy Fundador',2,0,0.000,0.700,0.000,0.000,0,4,0,0.666,0.00,0.00,119.00,0.00,1),
  (183,'Brandy Magno',2,0,0.000,0.750,0.000,0.000,0,9,0,0.480,0.00,0.00,163.00,0.00,1),
  (184,'Brandy Presidente',2,0,0.000,0.700,0.000,0.000,0,2,0,0.390,0.00,0.00,55.00,0.00,1),
  (185,'Brandy Terry Centenario',2,0,0.000,0.700,0.000,0.000,0,0,0,0.240,0.00,0.00,159.00,0.00,1),
  (186,'Brandy Terry 1900',2,0,0.000,0.700,0.000,0.000,0,3,0,0.435,0.00,0.00,175.00,0.00,1),
  (187,'Brandy Torres 10',2,0,0.000,0.700,0.000,0.000,0,14,0,0.240,0.00,0.00,189.00,0.00,1),
  (188,'Brandy Torres 5',2,0,0.000,0.700,0.000,0.000,0,2,0,0.345,0.00,0.00,129.00,0.00,1),
  (189,'Whisky William Lawsons',2,0,0.000,0.750,0.000,0.000,0,1,0,0.660,0.00,0.00,129.00,0.00,1),
  (190,'Whisky Buchanans 12 Años',2,0,0.000,0.750,0.000,0.000,0,13,0,0.015,0.00,0.00,348.00,0.00,1),
  (191,'Whisky Cutty Sark',2,0,0.000,0.750,0.000,0.000,0,2,0,0.705,0.00,0.00,175.00,0.00,1),
  (192,'Whisky Chivas Regal 12 Años',2,0,0.000,0.750,0.000,0.000,0,0,0,0.615,0.00,0.00,292.00,0.00,1),
  (193,'Whisky J&B',2,0,0.000,0.750,0.000,0.000,0,8,0,0.360,0.00,0.00,151.00,0.00,1),
  (194,'Whisky Johnnie Walker E.R:',2,0,0.000,0.750,0.000,0.000,0,3,0,0.000,0.00,0.00,185.00,0.00,0),
  (195,'Whisky Johnnie Walker E.N.',2,0,0.000,0.750,0.000,0.000,0,2,0,0.060,0.00,0.00,291.00,0.00,1),
  (196,'Whisky Johnnie Walker E.V.',2,0,0.000,0.750,0.000,0.000,0,1,0,0.480,0.00,0.00,559.00,0.00,1),
  (197,'Whisky Johnnie Walker  Golden Label',2,0,0.000,0.750,0.000,0.000,0,4,0,75.000,0.00,0.00,731.00,0.00,1),
  (198,'Whisky Old Parr 12 Años',2,0,0.000,0.750,0.000,0.000,0,10,0,0.000,0.00,0.00,295.00,0.00,1),
  (199,'Whisky Jack Daniels',2,0,0.000,0.700,0.000,0.000,0,2,0,0.215,0.00,0.00,239.00,0.00,1),
  (200,'Whisky Johnnie Walker Blue Label',2,0,0.000,0.750,0.000,0.000,0,1,0,0.705,0.00,0.00,1900.00,0.00,1),
  (201,'Tequila Herradura Antiguo',2,0,0.000,0.700,0.000,0.000,0,4,0,0.480,0.00,0.00,159.00,0.00,1),
  (202,'Vodka Absolut Azul',2,0,0.000,0.750,0.000,0.000,0,5,0,0.137,0.00,0.00,148.00,0.00,1),
  (203,'Vodka Absolut Citrus',2,0,0.000,0.750,0.000,0.000,0,7,0,0.000,0.00,0.00,163.00,0.00,1),
  (204,'Vodka Absolut Mandarin',2,0,0.000,0.750,0.000,0.000,0,5,0,0.345,0.00,0.00,163.00,0.00,1),
  (205,'Vodka Absolut Vanilla',2,0,0.000,0.750,0.000,0.000,0,10,0,0.450,0.00,0.00,163.00,0.00,1),
  (206,'Vodka Absolut Raspberry',2,0,0.000,0.750,0.000,0.000,0,9,0,0.090,0.00,0.00,163.00,0.00,1),
  (207,'Vodka Absolut Appeach',2,0,0.000,0.750,0.000,0.000,0,8,0,0.240,0.00,0.00,163.00,0.00,1),
  (208,'Vodka Absolut Rubby Red',2,0,0.000,0.750,0.000,0.000,0,10,0,0.570,0.00,0.00,163.00,0.00,1),
  (209,'Vodka Smirnoff',2,0,0.000,1.000,0.000,0.000,0,5,0,0.915,0.00,0.00,104.00,0.00,1),
  (210,'Vodka Stolichnaya',2,0,0.000,0.750,0.000,0.000,0,10,0,0.495,0.00,0.00,167.00,0.00,1),
  (211,'Vodka Wiborowa',2,0,0.000,0.750,0.000,0.000,0,4,0,0.705,0.00,0.00,105.00,0.00,1),
  (212,'Vodka Belvedere',2,0,0.000,0.700,0.000,0.000,0,9,0,0.435,0.00,0.00,340.00,0.00,1),
  (213,'Vodka Grey Goose',2,0,0.000,0.700,0.000,0.000,0,1,0,0.415,0.00,0.00,340.00,0.00,1),
  (214,'Cognac Hennessy VS.O.P.',2,0,0.000,0.700,0.000,0.000,0,2,0,0.185,0.00,0.00,446.00,0.00,1),
  (215,'Cognac Martell V.S.O.P.',2,0,0.000,0.700,0.000,0.000,0,1,0,0.520,0.00,0.00,419.00,0.00,1),
  (216,'Cognac Remy Martin',2,0,0.000,0.700,0.000,0.000,0,2,0,0.320,0.00,0.00,379.00,0.00,1),
  (217,'Ginebra Beefeater',2,0,0.000,0.750,0.000,0.000,0,4,0,0.062,0.00,0.00,218.00,0.00,1),
  (218,'Ginebra Bombay',2,0,0.000,0.750,0.000,0.000,0,3,0,0.285,0.00,0.00,279.00,0.00,1),
  (219,'Ginebra Oso Negro',2,0,0.000,1.000,0.000,0.000,0,2,0,0.015,0.00,0.00,75.00,0.00,1),
  (220,'Anis Cadenas',2,0,0.000,1.000,0.000,0.000,0,2,0,0.570,0.00,0.00,179.00,0.00,1),
  (221,'Anis Chinchón Seco',2,0,0.000,1.000,0.000,0.000,0,2,0,0.740,0.00,0.00,125.00,0.00,1),
  (222,'Anís Chinchón Dulce',2,0,0.000,1.000,0.000,0.000,0,3,0,0.456,0.00,0.00,125.00,0.00,1),
  (223,'Anís Domecq',2,0,0.000,1.000,0.000,0.000,0,2,0,0.818,0.00,0.00,69.00,0.00,1),
  (224,'Fernet',2,0,0.000,0.750,0.000,0.000,0,2,0,0.033,0.00,0.00,90.00,0.00,1),
  (225,'Anis Mico',2,0,0.000,1.000,0.000,0.000,0,1,0,0.155,0.00,0.00,65.00,0.00,1),
  (226,'Amaretto di Sarono',2,0,0.000,0.700,0.000,0.000,0,4,0,0.165,0.00,0.00,239.00,0.00,1),
  (227,'Champagne Moet Chandon',2,0,0.000,0.750,0.000,0.000,0,2,0,0.000,0.00,0.00,446.00,0.00,1),
  (228,'Ron Don Q Cristal',2,0,0.000,0.700,0.000,0.000,0,2,0,0.350,0.00,0.00,85.00,0.00,1),
  (229,'Ron Don Q Añejo',2,0,0.000,0.700,0.000,0.000,0,2,0,0.475,0.00,0.00,105.00,0.00,1),
  (230,'Damiana',2,0,0.000,0.750,0.000,0.000,0,1,0,0.000,0.00,0.00,105.00,0.00,1),
  (231,'Vino Tinto Gran Sangre de Toro',2,0,0.000,0.750,0.000,0.000,0,3,0,5.000,0.00,0.00,139.00,0.00,1),
  (232,'Vino Tinto Casillero del Diablo',2,0,0.000,0.750,0.375,0.000,0,3,3,0.573,0.00,0.00,105.00,59.00,1),
  (233,'Rompope',2,0,0.000,0.900,0.000,0.000,0,1,0,0.855,0.00,0.00,69.00,0.00,1),
  (234,'Cacao Blanco H.V.',2,0,0.000,0.750,0.000,0.000,0,1,0,0.735,0.00,0.00,70.00,0.00,1),
  (235,'Licor de Melón H.V.',2,0,0.000,0.750,0.000,0.000,0,1,0,0.000,0.00,0.00,68.00,0.00,1),
  (236,'Curacao H.V.',2,0,0.000,0.750,0.000,0.000,0,1,0,0.000,0.00,0.00,70.00,0.00,1),
  (237,'Southern Comfort',2,0,0.000,0.750,0.000,0.000,0,100,0,0.000,0.00,0.00,170.00,0.00,1),
  (238,'Martini Rojo',2,0,0.000,0.750,0.000,0.000,0,2,0,0.000,0.00,0.00,129.00,0.00,1),
  (239,'Martini Extra Dry',2,0,0.000,0.750,0.000,0.000,0,2,0,0.612,0.00,0.00,129.00,0.00,1),
  (240,'Martini Bianco',2,0,0.000,0.750,0.000,0.000,0,1,0,0.000,0.00,0.00,129.00,0.00,1),
  (241,'Cinzano Rojo',2,0,0.000,0.750,0.000,0.000,0,0,0,0.645,0.00,0.00,120.00,0.00,1),
  (242,'Jarabe de Granadina',2,0,0.000,1.000,0.000,0.000,0,2,0,0.709,0.00,0.00,20.00,0.00,1),
  (243,'Jarabe Natural',2,0,0.000,1.000,0.000,0.000,0,93,0,0.728,0.00,0.00,20.00,0.00,1),
  (244,'Ron Baraima Black',2,0,0.000,0.750,0.000,0.000,0,1,0,0.000,0.00,0.00,150.00,0.00,1),
  (245,'Ron Baraima Añejo',2,0,0.000,0.750,0.000,0.000,0,8,0,0.000,0.00,0.00,150.00,0.00,1),
  (246,'Whisky Johnnie Walker E.R.',2,0,0.000,0.750,0.000,0.000,0,11,0,0.600,0.00,0.00,185.00,0.00,1),
  (247,'Coca Cola Mediana',2,0,0.000,0.354,0.000,0.000,0,192,0,0.000,0.00,0.00,4.38,0.00,0),
  (248,'Coca Cola Chica',2,0,0.000,0.191,0.000,0.000,0,192,0,0.000,0.00,0.00,4.38,0.00,0),
  (249,'Coca Cola Light Mediana',2,0,0.000,0.354,0.000,0.000,0,72,0,0.000,0.00,0.00,5.25,0.00,0),
  (250,'Coca Cola Light Chica',2,0,0.000,0.191,0.000,0.000,0,72,0,0.000,0.00,0.00,4.75,0.00,0),
  (251,'Sidral',2,0,0.000,0.310,0.000,0.000,0,167,0,0.178,0.00,0.00,3.96,0.00,1),
  (252,'Quina',2,0,0.000,0.191,0.000,0.000,0,162,0,0.118,0.00,0.00,4.38,0.00,1),
  (253,'Tehuacán',2,0,0.000,0.354,0.000,0.000,0,4316,0,0.126,0.00,0.00,4.63,0.00,1),
  (254,'Ginger Ale',2,0,0.000,0.354,0.000,0.000,0,200,0,100.000,0.00,0.00,3.94,0.00,1),
  (255,'Clamato',2,0,0.000,0.295,0.000,0.000,0,962,0,0.269,0.00,0.00,8.38,0.00,1),
  (256,'Del Valle',2,0,0.000,0.355,0.000,0.000,0,198,0,0.000,0.00,0.00,3.96,0.00,1),
  (257,'Squirt Light',2,0,0.000,0.354,0.000,0.000,0,434,0,0.458,0.00,0.00,5.25,0.00,1),
  (258,'Squirt',2,0,0.000,0.355,0.000,0.000,0,101,0,0.000,0.00,0.00,3.94,0.00,1),
  (259,'Pan Molido',1,1,0.000,0.000,0.000,-11.880,0,0,0,-12.390,15.00,0.00,0.00,0.00,1),
  (260,'Lechuga Orejona',1,2,0.450,0.000,0.000,-4.850,24,0,0,0.000,0.00,15.00,0.00,0.00,1),
  (261,'Anchoa',1,2,0.200,0.000,0.000,-1.880,10,0,0,0.000,0.00,60.00,0.00,0.00,1),
  (262,'Queso Parmesano Rallado',1,1,0.000,0.000,0.000,0.900,0,0,0,0.000,120.00,0.00,0.00,0.00,1),
  (263,'Riñonada de Cabrito',1,1,0.000,0.000,0.000,24.920,0,0,0,0.000,98.00,0.00,0.00,0.00,1),
  (264,'Espaldilla de Cabrito',1,1,0.000,0.000,0.000,-48.040,0,0,0,0.000,98.00,0.00,0.00,0.00,1),
  (265,'Pierna de Cabrito',1,1,0.000,0.000,0.000,-46.520,0,0,0,0.000,98.00,0.00,0.00,0.00,1),
  (266,'Sopa de Botana',1,2,0.000,0.000,0.000,0.000,2000,0,0,0.000,0.00,0.00,0.00,0.00,1),
  (267,'Tacos',1,2,0.000,0.000,0.000,0.000,2000,0,0,0.000,0.00,0.00,0.00,0.00,1),
  (268,'Quesadillas',1,2,0.000,0.000,0.000,0.000,10000,0,0,0.000,0.00,0.00,0.00,0.00,1),
  (269,'Guisado',1,2,0.000,0.000,0.000,0.000,2000,0,0,0.000,0.00,0.00,0.00,0.00,1),
  (270,'Cafe',1,1,0.000,0.000,0.000,2.735,0,0,0,0.000,60.00,0.00,0.00,0.00,1),
  (271,'Cerveza Corona',2,0,0.000,0.325,0.000,0.000,0,2761,0,0.102,0.00,0.00,5.10,0.00,1),
  (272,'Cerveza Victoria',2,0,0.000,0.325,0.000,0.000,0,761,0,0.000,0.00,0.00,4.65,0.00,1),
  (273,'Cerveza Negra Modelo',2,0,0.000,0.325,0.000,0.000,0,520,0,0.014,0.00,0.00,6.84,0.00,1),
  (274,'Cerveza Modelo Especial',2,0,0.000,0.325,0.000,0.000,0,84,0,0.325,0.00,0.00,6.84,0.00,1),
  (275,'Cerveza Pacifico',2,0,0.000,0.325,0.000,0.000,0,114,0,0.000,0.00,0.00,4.65,0.00,1),
  (276,'Cerveza León negra',2,0,0.000,0.325,0.000,0.000,0,780,0,0.000,0.00,0.00,4.25,0.00,1),
  (277,'Cerveza Montejo',2,0,0.000,0.325,0.000,0.000,0,197,0,0.000,0.00,0.00,4.25,0.00,1),
  (278,'Cerveza Modelo Light',2,0,0.000,0.325,0.000,0.000,0,340,0,0.000,0.00,0.00,4.71,0.00,1),
  (279,'Cerveza Ó\'Douls',2,0,0.000,0.325,0.000,0.000,0,24,0,0.000,0.00,0.00,8.46,0.00,1),
  (280,'Coca Cola',2,0,0.000,0.203,0.355,0.000,0,9997,1494,0.045,0.00,0.00,4.38,4.38,1),
  (281,'Coca Cola Light',2,0,0.000,177.000,355.000,0.000,0,4998,4990,347.900,0.00,0.00,4.75,5.25,1),
  (282,'Canada Dry',2,0,0.000,0.355,0.000,0.000,0,181,0,0.000,0.00,0.00,3.94,0.00,1),
  (283,'Veneno',2,0,0.000,0.250,0.000,0.000,0,83,0,0.219,0.00,0.00,45.00,0.00,1),
  (284,'Sangrita',2,0,0.000,1.000,0.000,0.000,0,20,0,10.000,0.00,0.00,60.00,0.00,1),
  (285,'Jugo de Limón',2,0,0.000,1.000,0.000,0.000,0,80,0,0.370,0.00,0.00,25.00,0.00,1),
  (286,'Licor de Cassis H.V.',2,0,0.000,0.750,0.000,0.000,0,1,0,0.000,0.00,0.00,70.00,0.00,1),
  (287,'Licor de Manzana Verde',2,0,0.000,0.750,0.000,0.000,0,2,0,0.210,0.00,0.00,70.00,0.00,1),
  (288,'Licor de Platano H.V.',2,0,0.000,0.750,0.000,0.000,0,1,0,0.570,0.00,0.00,70.00,0.00,1),
  (289,'Curacao Azul H.V.',2,0,0.000,0.750,0.000,0.000,0,0,0,0.480,0.00,0.00,70.00,0.00,1),
  (290,'Helado',1,2,0.100,0.000,0.000,-17.320,2071,0,0,0.000,0.00,16.00,0.00,0.00,1),
  (291,'Cerveza Budweiser',2,0,0.000,0.355,0.000,0.000,0,41,0,0.000,0.00,0.00,9.60,0.00,1),
  (292,'Whisky Old Parr',2,0,0.000,0.750,0.000,0.000,0,10,0,0.285,0.00,0.00,370.00,0.00,1),
  (293,'Champagne',2,0,0.000,0.750,0.000,0.000,0,3,0,0.000,0.00,0.00,575.00,0.00,1),
  (294,'Jaggemeister',2,0,0.000,0.700,0.000,0.000,0,3,0,0.410,0.00,0.00,178.00,0.00,1),
  (295,'Red Bull',2,0,0.000,0.235,0.000,0.000,0,27,0,0.051,0.00,0.00,25.00,0.00,1),
  (296,'Boost',2,0,0.000,0.235,0.000,0.000,0,62,0,0.000,0.00,0.00,12.00,0.00,1),
  (297,'Mezcal Gusano Rojo',2,0,0.000,1.000,0.000,0.000,0,2,0,0.600,0.00,0.00,850.00,0.00,1),
  (298,'Vodka Zubrowka',2,0,0.000,0.750,0.000,0.000,0,8,0,0.345,0.00,0.00,180.00,0.00,1),
  (299,'Escamoles',1,2,0.200,0.000,0.000,-12.200,44,0,0,0.000,0.00,150.00,0.00,0.00,1),
  (300,'Coca Cola Zero',2,0,0.000,0.355,0.000,0.000,0,288,0,0.355,0.00,0.00,4.58,0.00,1),
  (301,'Sprite 0',2,0,0.000,0.355,0.000,0.000,0,154,0,0.256,0.00,0.00,4.58,0.00,1),
  (302,'Gusanos de Maguey',1,1,0.000,0.000,0.000,5.000,0,0,0,0.000,750.00,0.00,0.00,0.00,1),
  (303,'Licor de Pacharán',2,0,0.000,0.750,0.000,0.000,0,2,0,0.480,0.00,0.00,150.00,0.00,1),
  (304,'Whisky Glennfiddich 12 años',2,0,0.000,0.750,0.000,0.000,0,2,0,0.000,0.00,0.00,500.00,0.00,1),
  (305,'Licor de Pacharan Etxeko',2,0,0.000,0.700,0.000,0.000,0,2,0,0.000,0.00,0.00,159.00,0.00,1),
  (306,'Tequila Centenario Añejo',2,0,0.000,0.695,0.000,0.000,0,3,0,0.605,0.00,0.00,245.00,0.00,1),
  (307,'Cerveza Estrella',2,0,0.000,0.325,0.000,0.000,0,4962,0,0.000,0.00,0.00,6.00,0.00,1),
  (308,'whisky William Lawson\'s',2,0,0.000,0.750,0.000,0.000,0,1,0,0.000,0.00,0.00,165.00,0.00,1),
  (309,'Ginger Ale Schweppes',2,0,0.000,0.355,0.000,0.000,0,22,0,0.000,0.00,0.00,4.50,0.00,1),
  (310,'Quina  Schwepppes',2,0,0.000,0.296,0.000,0.000,0,24,0,0.000,0.00,0.00,8.00,0.00,1),
  (311,'Monster',2,0,0.000,0.246,0.000,0.000,0,24,0,0.000,0.00,0.00,25.00,0.00,1),
  (312,'Whisky Buchanans 18 años',2,0,0.000,0.750,0.000,0.000,0,2,0,0.340,0.00,0.00,710.00,0.00,1),
  (313,'ETIQUETA DORADA',2,0,0.000,0.750,0.750,0.000,0,5,5,0.750,0.00,0.00,650.00,2100.00,1),
  (314,'Pecho de Ternera',1,2,0.250,0.000,0.000,1.750,20,0,0,0.000,0.00,12.50,0.00,0.00,1);

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
  (1,'Roxana',33,'Mónica Roxana','Cruz','Carrasco',0,0),
  (2,'Karen',44,'Leslie Karen','Arzate','Mondragón',1,0),
  (3,'Sarahi',22,'Sarahi','Bonilla','Calzada',0,0),
  (4,'Jenny',11,'Jennifer','Rojas','Valdés',0,0),
  (5,'blue',103,'Shary Estefanía','Manzanares','Nuñez',1,0),
  (6,'Alfredo',77,'Alfredo','Olivares','Samaniego',3,1),
  (7,'Jesús',66,'Jesús','Alcaraz','Ávila',3,1),
  (8,'luis',12,'Luis Enrique','Ocampo','Castillo',2,1),
  (9,'manuel',13,'Manuel','Hermida','Gutierrez',2,1),
  (10,'Mario',88,'Mario Alberto','Castellano','Pérez',3,1),
  (11,'Yar',55,'Yareth','Bonilla','Calzada',3,0),
  (12,'Paul',99,'Paul','Liberato','Moreno',3,1),
  (13,'Yareth',11,'yareth','bonilla','calzada',0,0),
  (14,'atenea',22,'atenea','iturriaga','sauco',0,0),
  (15,'yareth',11,'Yareth','Bonilla','Calzada',0,0),
  (16,'Yareth1',11,'Yareth','Bonilla','Calzada',0,0),
  (17,'Shary',77,'Shary','Manzanares','de Oliver',1,0),
  (18,'Ari',66,'Ariadne','Diaz','Gomez',0,0),
  (19,'Taymi',22,'Taymi','Bransuela','Johnson',0,0),
  (20,'ale',33,'Alejandra','Flores','Bernal',0,0),
  (21,'Claudia',33,'Claudia','Monroy','Diaz',0,0),
  (22,'VIANEY',11,'Vianey','Rivas','Miguez',0,1),
  (23,'Barbara',33,'Barbara','Martinez','Montesinos',0,0),
  (24,'Yarendi',22,'Yarendi','Barrera','Trujillo',0,0),
  (25,'ALEX',33,'ALEJANDRA','ZAVALA','MORENO',1,0),
  (26,'JUDITH',44,'JUDITH','SANCHEZ','PEROZO',0,1),
  (27,'Leslie',33,'Karen','Arzate','Mondragón',1,1),
  (28,'Begoña',22,'Begoña','Landa','Marcano',0,0),
  (29,'Fabiola',55,'Fabiola','Baylon','Guzman',0,1),
  (30,'Tania',55,'Tania','Gaspar','Fernandez',0,1),
  (31,'Marina',22,'Marina','Rodriguez','Rodriguez',0,0),
  (32,'Jessica',22,'Jessica','Diaz','Rosas',0,1);

COMMIT;

#
# Data for the `division` table  (LIMIT 0,500)
#

# clave:3:49667
# nombre:253:0
# area:3:32768
# estatus:3:32768

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
  (29,'Jugos',2,1),
  (30,'Champagne',2,1);

COMMIT;

#
# Data for the `cobros` table  (LIMIT 0,500)
#

# consecutivo:3:49667
# claveVenta:3:32768
# fechaCobro:12:128
# monto:5:32768
# formaPago:3:32768
# observaciones:253:0
# activo:3:32768
# propina:5:32768
# usuario:253:0
# facturado:3:32768


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
# folio:253:0

INSERT INTO `clientes` (`rfc`, `CURP`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tel1`, `tel2`, `fax`, `email`, `contacto`, `alta`, `activo`, `folio`) VALUES 
  ('OACL540715','','Luis Enrique Ocampo Castillo','T. De Mixcoac A-14-802','Torres de Mixcoac','Alvaro Obregon','01490','Mexico D.F.','04455-54153489','','','','','2006-12-13',1,''),
  ('GBC980826593','','García Baca Consultores Especializados S.C.','Uxmal 294','Narvarte','Benito Juárez','03020','Mexico D.F.','','','','','','2006-12-18',1,'E1178451'),
  ('MME901204V46','','Matinsa Medicinas S.A. de C.V.','Chiapas 55','Roma','Cuauhtemoc','06700','Mexico D.F.','','','','','','2006-12-19',1,'A0088377'),
  ('CPR060830FZ0','','Cuarenta Producciones S.A.de C.V.','Mérida 164 Int. 301','Roma','Cuauhtemoc','06700','México D.F.','','','','','','2006-12-21',1,'G1223257'),
  ('FOLG7005054F4','','Guillermo Flores Lugo','Valle de Señora 801-3','Del Valle','Leon;Gto.','37150','Leon , Guanajuato','','','','','','2007-01-03',1,'E249034'),
  ('GBA020313FN9','','Grupo Batt S.A.de C.V.','Fco. del Paso y Troncoso 398-C-102','Jardin Balbuena','Venustiano Carranza','15900','Mexico D.F.','','','','','','2007-01-04',1,'K1453576'),
  ('AAJH780530843','','Hernando Carlos Alvarez Juarez','Privada de Matamoros 5','Santa Fe','Alvaro Obregon','01210','Mexico D.F.','','','','','','2007-01-04',1,'I1199556'),
  ('CEMC641002FJA','','Carlos Alberto Cerecedo Martinez','Calle Matagalpa 922','Lindavista','Gustavo A. Madero','07300','Mexico D.F.','','','','','','2007-01-04',1,'H1435614'),
  ('FFA840123C9A','','FERRAL DE LA FUENTE Y ASOCIADOS S.C.','BAJA CALIFORNIA 104','ROMA SUR','CUAUHTEMOC','06760','MEXICO D.F.','','','','','','2007-01-08',1,'A0686125'),
  ('GURL730417KL9','','GUEVARA  ROJAS JOSE LUIS','Callejon del Bosque #13','San Jeronimo Lidice','Magdalena Contreras','10200','Mexico D.F','','','','','','2007-01-09',1,'H1386977'),
  ('CTR0110064Z6','','CUERNAVACA TRAVEL S.A. DE C.V.','SAN DIEGO 310','VISTA HERMOSA','CUERNAVACA','62290','CUERNAVACA MOR.','','','','','','2007-01-09',1,'E1286987'),
  ('SAGE561110717','','ENRIQUE SANCHEZ GALVEZ','FEDERICO HIGAREDA 375','NORIA DE MONTES','SAHUAYO','59099','SAHUAYO MICH.','','','','','','2007-01-11',0,'E880979'),
  ('SAGE5611107T7','','ENRIQUE SANCHEZ GALVEZ','FRANCISCO HIGAREDA 375','NORIA DE MONTES','SAHUAYO','59099','SAHUAYO,MICH.','','','','','','2007-01-11',1,'E880979'),
  ('CUN721206UVA','','CONSTRUCCIONES URBANAS NACIONALES S.A.','AVENIDA AMSTERDAM 87','HIPODROMO CONDESA','CUAUHTEMOC','06170','MEXICO D.F.','','','','','','2007-01-12',1,'A0084818'),
  ('PII991111CL6','','PROYECTO E INSTALACIONES INTEGRALES EN INGENIERIA S.A. DE C.V.','NAYARIT 78-A','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-01-12',1,'E1214362'),
  ('DMI060425595','','DISTRIBUIDOR MEDICO INDUSTRIAL S.A. DE C.V.','TLACOTALPAN 37 P.B.','ROMA SUR','CUAUHTEMOC','06760','MEXICO D.F.','','','','','','2007-01-12',1,'G1217408'),
  ('OELL760621A32','','LUIS MANUEL ORNELAS LOPEZ','PROSPERIDAD 5','ESCANDON','MIGUEL HIDALGO','11800','MEXICO D.F.','','','','','','2007-01-16',1,'E1230214'),
  ('LORD860306233','','DANIEL LOPEZ RUEDA','LUZ SAVIÑON 1905','NARVARTE','BENITO JUAREZ','03020','MEXICO D F','','','','','','2007-01-16',1,'A1410835'),
  ('QFE020422M92','','QUIMICA FARMACEUTICA ESTEROIDAL S.A. DE C.V.','Cda. 15 DE SEPTIEMBRE 21','FRANCISCO VILLA','TLAHUAC','13520','MEXICO D.F.','','','','','','2007-01-16',1,'K1474039'),
  ('CSE 051024H45','','CONGRESOS SEICOT S.A. DE C.V','CHIAPAS 130 BIS','ROMA NORTE','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-01-19',1,'G1209306'),
  ('AAAO7002166A7','','OSCAR HUGO ANDRACO AYALA','BOSQUE DE EUCALIPTOS MZ 16 LT 34 CASA C SIN NUMERO','BOSQUE REAL','TULTUTLAN EDOMEX','54910','MEXICO','','','','','','2007-01-20',1,'Q1559924'),
  ('HSEO670627R30','','IRASEMA HERNANDEZ SOCORRO','AV. POPOCATEPETL 289-3','STA. CRUZ ATOYAC','BENITO JUAREZ','03310','MEXICO D.F.','','','','','','2007-01-20',1,'N1417580'),
  ('FSCO7011658A','','FARMA SEGURA  COMERCIALIZADORA SA DE CV','TEOCELO #43','ROMA SUR','CUAUHTEMOC','06700','MEXICO DF.','','','','','','2007-01-23',0,'A1207049'),
  ('FSC07011658A','','FARMA SEGURA  COMERCIALIZADORA SA DE CV','TEOCELO #43','ROMA SUR','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-01-23',1,'A1207049'),
  ('CMC811211749','','MIER Y CONCHA JIMENEZ ABOGADOS  S.C.','VARSOVIA Nº53 2º PISO','JUAREZ','CUAUHTEMOC','06600','MEXICO D.F.','','','','','','2007-01-23',1,'A0073235'),
  ('CBA840207SE6','','CONSTRUCTORA BALLENA S.A. DE C.V.','AV. RIO MIXCOAC 65','INSURGENTES MIXCOAC','BENITO JUAREZ','03920','MEXICO D.F.','','','','','','2007-01-24',1,'B0215033'),
  ('VIBL5307305PA','','LUIS ABDON VILLALBA BARRERA','CALLE 637   No 154','SAN JUAN DE ARAGON','GUSTAVO A. MADERO','07920','MEXICO.D.F.','','','','','','2007-01-26',1,''),
  ('CCY020903A45','','COMUNICACIONES CIBERNETICAS S.A. DE C.V.','NIÑO PERDIDO 10','MIGUEL HIDALGO','MINATITLAN','96770','MINATITLAN, VER.','','','','','','2007-01-29',1,'F1202348'),
  ('SEIB500926616','','BERNARDO SERRANO IBARRA','EFREN REBOLLEDO #53','OBRERA','CUAUHTEMOC','06800','MEXICO D.F.','','','','','','2007-01-30',1,'A12077848'),
  ('SNT440406MI0','','SDTO NAL TRABS SEGURO SOCIAL','ZAMORA Nº 107','CONDESA','MIGUEL HIDALGO','06140','MEXICO D.F.','','','','','','2007-01-31',0,'E1201019'),
  ('SNT440406ML0','','SDTO NAL TRABS SEGURO SOCIAL','ZAMORA Nº 107','CONDESA','MIGUEL HIDALGO','06140','MEXICO D.F.','','','','','','2007-01-31',1,'E1201019'),
  ('APC050524UE8','','ARQUITECTURA PREFABRICADA DE CONCRETO SA DE CV','CARR. TEOLOYUCAN-HUEHUETOCA KM 21.5 DIAGONAL CONCRELEMENTOS','STA. MA. CALIACAC,TEOLOYU','NEZAHUALCOYOT','54770','EDO. DE MEXICO','','','','','','2007-02-02',1,'Q1580609'),
  ('CDS630910NB1','','CLUB DEPORTIVO SOCIAL Y CULTURAL CRUZ AZUL A.C','INSURGENTES SUR 1457','INSURGENTES MIXCOAC','ALVARO OBREGON','03920','MEXICO D.F.','','','','','','2007-02-02',1,'A0594007'),
  ('GPS0406231D7','','GPSPCISA SA DE CV','MANZANILLO Nº138','ROMA NORTE','CUAUHTEMOC','06760','MEXICO D.F','','','','','','2007-02-02',1,'I1121175'),
  ('IPD010207815','','INSTITUTO POBLANO DEL DEPORTE','LIB. A TEHUACAN s/n POLIDEPORTIVO GIMNASIO MIGUEL HIDALGO','PUEBLA','PUEBLA','72220','PUEBLA','','','','','','2007-02-03',1,'G2117139'),
  ('JGM060623AA4','','JUST GLOBAL DE MEXICO S A DE CV','AV CUAUHTEMOC N. 682 DEPTO. 6','NARVARTE','BENITO JUAREZ','03020','MEXICO D.F','','','','','','2007-02-08',1,'N1413565'),
  ('DEL83013185A','','DOMESTICOS ELECTRICOS S.A. DE C.V.','TONALA 124','ROMA SUR','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-02-12',1,'A0088299'),
  ('RUTA550526CU6','','RUIZ TAPIA AUSTREBERTO','TONALA 178 DEP 401','ROMA NORTE','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-02-13',1,'L 1591141'),
  ('MNE9909094C2','','MEDICAL NETWORK SA DE CV','JALISCO 55-A','HEROES DEPADIERNA','MAGDALENA CONTRERAS','10700','MEXICO D.F.','','','','','','2007-02-14',1,'F1397983'),
  ('CSN040805AH4','','CLASE 69 S DE RL DE CV','TONALA 194 DESP. F','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-02-15',1,'F1266479'),
  ('OHA051017KE7','','OPERADORA DE HOSPITALES ANGELES S.A. DE C.V.','CAMINO A STA. TERESA 1055 PISO 14','HEROES DE PADIERNA','MAGDALENA CONTRERAS','10700','MEXICO D.F.','','','','','','2007-02-15',1,'A1320782'),
  ('KDP990225MI9','','KARPEL DISTRIBUIDORA DE PAPELES SA DE CV','CALLE QUERETARO Nº116-C','ROMA','CUAUHTEMOC','06760','MEXICO D.F.','','','','','','2007-02-20',1,'E1196286'),
  ('S&N921215RG4','','SMITH & NEPHEW SA DE CV','PATRICIO SANZ #442','DEL VALLE','BENITO JUAREZ','03100','MEXICO D.F.','','','','','','2007-02-20',1,'E0219593'),
  ('FER991028EZ8','','FERMICAISE SA DE CV','AV. INSURGENTES SUR 1457 PISO 13','INSURGENTES MIXCOAC','BENITO JUAREZ','03920','MEXICO D.F.','','','','','','2007-02-20',1,'F1130757'),
  ('MDI861217GS7','','MAQUINARIA DIESEL S.A. DE C.V.','BOULEVARD PUERTO AEREO 34','SANTA CRUZ AVIACION','VENUSTIANO CARRANZA','15540','MEXICO D.F.','','','','','','2007-02-21',1,'A0171310'),
  ('TTR971128A85','','TURISMO TRAVEL S.A.DE.C.V.','ALVARO OBREGON 180','ROMA SUR','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-02-28',1,'C1278266'),
  ('HON641119JI7','','HONEYWELL S.A. DE C.V.','GUILLERMO GONZALEZ CAMARENA 1450-7','SANTA FE','ALVARO OBREGON','01210','MEXICO D.F.','','','','','','2007-03-01',1,'K1361780'),
  ('ECO970407JQ0','','EAGLE COMMUNICATION S.A. DE C.V.','CALLE 11 No. 24-303','SAN PEDRO DE LOS PINOS','BENITO JUAREZ','03800','MEXICO D.F.','','','','','','2007-03-01',1,'E1391259'),
  ('TORI450720QX8','','IGNACIO DE LA TORRE ROJO','PRESIDENTE MASARYK 101 PISO 16','POLANCO','MIGUEL HIDALGO','11560','MEXICO D.F.','','','','','','2007-03-01',1,'F1189294'),
  ('EPE960416P82','','ESENCIAS Y PERFUMES EUROPEOS S.A DE C.V.','AV. 1o. DE MAYO 236 - A','SAN ANDRES ATOTO','NAUCALPAN, EDO. MEX','53500','NAUCALPAN','','','','','','2007-03-02',1,''),
  ('PAS0310032XA','','PVM AGENTE DE SEGUROS S A DE CV','PASEO DE LA REFORMA 76 902','JUAREZ VERSALLES','CUAUHTEMOC','06600','CO','','','','','','2007-03-02',1,'F 1227079'),
  ('PCA0301167A8','','PERI CIMBRAS Y ANDAMIOS S.A.DE C.V.','CDA. DE TEJOCOTES S/N LOTE 4 BODEGA \"A\"','FRACC. IND. S.MARTIN OBIS','CUAUTITLAN IXCALLI','54763','CUAUTITLAN IXCALLI','','','','','','2007-03-03',1,'O1542612'),
  ('CDB0511088J9','','COMERCIALIZADORA Y DISTRIBUIDORA BREMYL S.A. DE C.V.','COAHUILA 56-101-A','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-03-03',1,'G1210520'),
  ('FFV940202FFA','','FERREFUNDICION LA VICTORIA S.A. DE C.V.','NORTE  86 #4239 LOCAL 2','MALINCHE','G.A. MADERO','07880','MEXICO D.F.','','','','','','2007-03-05',1,'C140024566'),
  ('IAFG6606179YA','','GUSTAVO IBARRA FALCON','AZALEAS MZ. 22 LT. 18-4','JARDINES DE LA CAÑADA','TULTITLAN','54900','TULTITLAN EDO. DE MEXICO','','','','','','2007-03-07',1,'P1514564'),
  ('BUPA640114UG5','','ARTURO BURGOS PICON','DR. BALMIS 79','DOCTORES','CUAUHTEMOC','06720','MEXICO D.F.','','','','','','2007-03-07',1,'A1202110'),
  ('TAE870320RC9','','EL TREBOL AUTOMOTRIZ ERMITA S.A. DE C.V.','CALZ. ERMITA IZTAPALAPA 1739','LOS ANGELES','IZATAPALAPA','09830','MEXICO D.F.','','','','','','2007-03-08',1,'A0185862'),
  ('SCI0108066A6','','SERVICIOS Y CONEXIONES INTERNACIONALES S.A. DE C.V.','ALDAMA 1100 LOCAL 21','CENTRO LIB. ECHEVERRIA','REYNOSA','88500','REYNOSA. TAMPS.','','','','','','2007-03-09',1,'C3295439'),
  ('HCD 1108216E6','','HONORABLE CAMARA DE DIPUTADOS','HONORABLE CONGRESO DE LA UNION S N','EL PARQUE','VENUSTIANO CARRANZA','15969','MEXICO D.F.','','','','','','2007-03-09',1,''),
  ('AMÑ050504M94','','ANJA METSI ÑITHI SA DE CV','EUGENIA 926-8','DEL VALLE','BENITO JUAREZ','03100','MEXICO D.F.','','','','','','2007-03-09',1,'F 1295218'),
  ('BME980105U13','','BIOMET MEXICO SA DE CV','AVE ACOXPA 436-702','EXHACIENDA COAPA','COYOACAN','14390','MEXICO D.F.','','','','','','2007-03-13',1,'E2179707'),
  ('GHO030603AW9','','GK HOLDING SA DE CV','LA UNION 207','TEPEYAC INSURGENTES','GUSTAVO A. MADERO','07020','MEXICO D.F.','','','','','','2007-03-13',1,'F1217270'),
  ('MATJ520209611','','MACIAS TORRES JAVIER','PASEO DE LONDRES 454','fRACC. TEJEDA CORREGIDORA','QUERETARO','76190','QUERETARO','','','','','','2007-03-14',1,'E457662'),
  ('CVA000719NX1','','CORONA VILLALPANDO Y ASOCIADOS SC','CALZ. MEXICO XOCHIMILCO #35-4','SAN LORENZO HUIPULCO','TLALPÀN','14370','MEXICO D.F.','','','','','','2007-03-17',1,'H1321886'),
  ('SOLJ720626S91','','SOLORZANO LEIRO JUAN CARLOS','C. PINO Nº90 EDIF. HALCON','SAN CLEMENTE','ALVARO OBREGON','01740','MEXICO D.F.','','','','','','2007-03-20',1,'H1395196'),
  ('CARG700731NB9','','CARRIZO RODRIGUEZ MARIA GUADALUPE','CHICAGO 124-502','NAPOLES','BENITO JUAREZ','03120','MEXICO D.F.','','','','','','2007-03-22',1,'F1246248'),
  ('GAU921015G81','','GRUPO AUSA S.A. DEC.V.','TONALA 136','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-03-22',1,'A1633581'),
  ('PESJ391030MG9','','PEÑALOZA SANTILLAN JESUS ALFONSO','TLACOTALPAN NUM. 37-501','ROMA SUR','CUAUHTEMOC','06760','MEXICO D.F.','','','','','','2007-03-22',1,'E1235647'),
  ('CTR011006426','','CUERNAVACA TRAVEL SA DE CV','SAN DIEGO 310','VISTA HERMOSA','MORELOS','62290','CUERNAVACA MORELOS','','','','','','2007-03-22',0,'E1286987'),
  ('HUCJ620930VA7','','HUERTA CLETO JERONIMO','RIO LERMA Nº 329','CUAUHTEMOC','CUAUHTEMOC','06500','MEXICO D.F.','','','','','','2007-03-22',1,'E1220577'),
  ('IEX821020AJ0','','IMPRESORA  Y EDITORA XALCO SA DE CV','AV. JOSE MARIA MARTINEZ Nº301','SAN MIGUEL JACALONES','CHALCO','56600','EDO. DE MEXICO','','','','','','2007-03-23',1,'O1581556'),
  ('ACO980508MGA','','ACOVER S.A. DE C.V.','BENITO JUAREZ 514-A','CENTRO','BOCA DEL RIO','94290','VERACRUZ','','','','','','2007-03-23',1,'C2939870'),
  ('AOMJ154112882','','ALONSO MARTINEZ JUAN MANUEL','CJON IXTAPANTENCO 118 E-102','LOS REYES','COYOACAN','04330','MEXICO D.F.','','','','','','2007-03-27',1,'G1130242'),
  ('MAHR730528JX9','','MACIEL HERNANDEZ RABINDRANATH','HDA EL MAYORAZGO 26 FRACC','EX HDA DEL ROSARIO','AZCAPOTZALCO','02420','MEXICO D.F.','','','','','','2007-03-27',1,'F1190642'),
  ('SITA680906U59','','SIL TRELLES JOSE ANGEL','RANCHO LA PALMA 24','VILLA OBREGON','AZCAPOTZALCO','01000','MEXICO D.F.','','','','','','2007-03-28',1,'J1316112'),
  ('FES840823HH0','','FARMACOS ESPECIALIZADOS S.A. DE C.V.','QUERETARO 137','ROMA SUR','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-03-29',1,'A0084681'),
  ('TOR050923839','','TIGER OFF ROAD DE MEXICO S.A. DE C.V.','PROL. 5 DE MAYO #15 BODEGA 7','SAN JUAN DE OCOTAN','ZAPOPAN. JAL','45019','ZAPOPAN','','','','','','2007-03-31',1,'F6354742'),
  ('PRO990901388','','PROVOLOTO S.A. DE C.V.','CALZADA DE TLALPAN 4870-12\"A\"','BARRIO DEL NIÑO JESUS','TLALPAN','14080','MEXICO D.F.','','','','','','2007-04-02',1,'E1206670'),
  ('GOGE570203LS8','','JOSE EDUARDO GONZALEZ GONZALEZ','MAR MARMARA 411-4','POPOTLA','MIGUEL HIDALGO','11400','MEXICO D.F.','','','','','','2007-04-03',1,'A1117911'),
  ('ALC0607203X4','','ASESORIA LEGAL CORPORATIVA CEMA S.C.','MATAGALPA 922','LINDAVISTA','GUSTAVO A. MADERO','07300','MEXICO D.F.','','','','','','2007-04-17',1,'N1412541'),
  ('MME9908053X5','','MATCHCODE DE MEXICO S.A. DE C.V.','AV.SANTA FE 170 7o PISO 714','LOMAS DE SANTA FE','ALVARO OBREGON','01210','MEXICO D.F.','','','','','','2007-04-20',1,'E1207366'),
  ('AGA910731SN6','','ANTONIO GUERRERO Y ASOCIADOS S A DE CV','ZACATECAS 182','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-04-26',1,'E0345785'),
  ('GPR050218BYA','','GOTIKA PRODUCCIONES S.A. DE C.V.','AV. ACUEDUCTO 1308-105','CHAPULTEPEC NORTE','MORELIA','58260','MORELIA, MICHOACAN','','','','','','2007-04-27',1,'F346550'),
  ('GUZJ520917F80','','GUTIERREZ  ZAMORANO JESUS FAUSTINO','AND. OAXTEPEC 8','EMILIANO ZAPATA','COYOACAN','04919','MEXICO D.F.','','','','','','2007-04-28',1,'N1355891'),
  ('AACC501125FZ8','','DE ANDA CERECEDO MARIA CECILIA','LABORISTAS 105','SAN ANDRES TETEPILCO','IZTAPALAPA','09440','MEXICO D.F.','','','','','','2007-05-05',1,'M1449118'),
  ('SSN051121A17','','SCT SERVICIOS A LA NAVEGACION EN EL ESPACIO AEREO MEXICANO','AV. 602 No 161','ZONA FEDERAL AICM','VENUSTIANO CARRANZA','15620','MEXICO D.F.','','','','','','2007-05-10',1,'N1411991'),
  ('GUMA7311124H8','','GUTIERREZ RUIZ MARIO','NELLIE CAMPOBELLO 129 EDIF. LACANDONA 305','CAROLA','ALVARO OBREGON','01180','MEXICO D.F.','','','','','','2007-05-11',1,'K1343462'),
  ('CIN0608073IA','','CALLA INGENIERIA S.A. DE C.V.','CAMINO A STA. FE 614','ZENON DELGADO','ALVARO OBREGON','01220','MEXICO D.F.','','','','','','2007-05-17',1,'I1110023'),
  ('SEA050420QP8','','SERVICIOS EMPRESARIALES AMEX S.A. DE C.V.','AV.585 No.9','SAN JUAN DE ARAGON','GUSTAVO A. MADERO','07970','MEXICO D.F.','','','','','','2007-05-18',1,'M1431993'),
  ('CAV910627S20','','CONTUR AGENCIA DE VIAJES S.A. DE C.V.','LONDRES 152 P.B.','JUAREZ','CUAUHTEMOC','06600','MEXICO D.F.','','','','','','2007-05-23',1,'A0075737'),
  ('OEQD690427550','','ORNELAS QUIROZ DAVID','CANAL DE MIRAMONTES 2714','CIPRESES','COYOACAN','04830','MEXICO D.F.','','','','','','2007-05-23',1,'M1408830'),
  ('GOAJ720819BK7','','GONZALEZ AYALA JORGE ENRIQUE','LOMA DE LA PLATA 45','LOMAS DE TARANGO','AZCAPOTZALCO','01629','MEXICO D.F.','','','','','','2007-05-23',1,'G1314451'),
  ('FMF6210196Z4','','FEDERACION MEXICANA DE FUTBOL ASOCIACION A.C.','COLIMA 373','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-05-26',1,'G1206501'),
  ('HEML670615FLT','','HERNANDEZ MORALES LUIS FERNANDO','DR. VERTIZ 244 DEPTO. 4','DOCTORES','CUAUHTEMOC','06720','MEXICO D.F.','','','','','','2007-05-28',1,'E1297769'),
  ('CCR0105317W7','','CONSULTORIA Y CAPACITACION EN REDES S A DE CV','TONALA 194 INT G','ROMA','CUAUHTEMOC','06760','MEXICO D.F.','','','','','','2007-05-28',1,'G1176072'),
  ('FEF9304196L4','','FACTOR EFICIENCIA S.A. DE C.V.','DON JUAN 73 INT. 2','NATIVITAS','CUAUHTEMOC','03500','MEXICO D.F.','','','','','','2007-05-31',1,'B2767999'),
  ('SADM7108074F7','','SANTANA DOMINGUEZ MIGUEL DARIO','AV. AZCAPOTZALCO 95-9','SAN ALVARO','AZCAPOTZALCO','02090','MEXICO D.F.','','','','','','2007-05-31',1,'G1170202'),
  ('SET861125GH1','','SERVICIOS ESPECIALIZADOS Y TECNOLOGIA INFORMATICA S A DE C V','CHIAPAS 91','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-06-05',1,'A0072561'),
  ('GEL741008GY9','','GOBIERNO EDO LIB SOBER Q ROO','CALLE 22 DE ENERO N,o 01','CHETUMAL CENTRO','QUINTANA ROO','77000','MEXICO','','','','','','2007-06-06',1,'B0821085'),
  ('RATS760830QL7','','SERGIO RAMIREZ TENORIO','ORIENTE 257 No 86 MOD. 2 EDIF 6 DEPTO 201','AGRICOLA ORIENTAL','IZTACALCO','08500','MEXICO D.F.','','','','','','2007-06-08',1,'A1434812'),
  ('MNA010904JK3','','MARTINEZ NAVA ABOGADOS SC','CHIHUAHUA 157 8','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-06-12',1,'E 1284505'),
  ('CV1850612111','','CONSTRUCTORA VIRGO S A DE CV','ALVARO OBREGON 74 º 502','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-06-12',1,'E 1241277'),
  ('LEBC6212101W2','','MARIA CONCEPCION LEON BECERRIL','VALLE DE OLMECAS MZ 48 H16-C No 101','FUENTES DE ARAGON','ECATEPEC','55210','ECATEPEC EDO. DE MEXICO','','','','','','2007-06-13',1,'R1556672'),
  ('HSF8601153I3','','HOSPITAL SANTA FE S A DE CV','SAN LUIS POTOSI 143','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-06-14',1,'A50084358'),
  ('RIOL470307MY3','','RIVERA ORTIZ JOSE LUIS','YUCA 234 PLANTA BAJA','NUEVA SANTA MARIA','AZCAPOTZALCO','02800','MEXICO D.F.','','','','','','2007-06-14',1,'I1183185'),
  ('ALD971028S24','','ASMBLEA LEGISLATIVA DEL DISTRITO FEDERAL','DONCELES Y ALLENDE S/N','CENTRO','CUAUHTEMOC','06010','MEXICO D.F.','','','','','','2007-06-14',1,'E2050431'),
  ('GVA050926B44','','GRUPO VASCHETTA S.A. DE C.V.','MELCHOR OCAMPO 305 BAJOS 101','ANZURES','MIGUEL HIDALGO','11590','MEXICO D.F.','','','','','','2007-06-19',1,'I1189905'),
  ('GCR0305289G3','','GRUPO CORPORATIVO DE RIESGOS S.C.','AV. INSURGENTES SUR 318 P.B.','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-06-25',1,'F1215807'),
  ('PASC6708263J8','','PAEZ SANCHEZ CESAR PORFIRIO','TRIPOLI 620 D-402','PORTALES','BENITO JUAREZ','03300','MEXICO D.F.','','','','','','2007-06-29',1,'M1491035'),
  ('SIP000808AMO','','SOPORTE INTEGRAL DE PERSONAL S.C.','TONALA 178-202','ROMA NORTE','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-07-03',1,'E1260202'),
  ('LMI0301223N7','','LEGGI MILENIUM S.A. DE C.V.','28 DE OCTUBRE #107-302','SAN SEBASTIAN','TOLUCA','50090','TOLUCA, EDO. DE MEXICO','','','','','','2007-07-04',1,'F1642673'),
  ('MED011012TD4','','MEDICAVIAL S.A. DE C.V.','AQV. ALVARO OBREGON 121-10','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-07-04',1,'E1287560'),
  ('SIC921218S34','','SISTEMAS INTEGRADOS DE CONTROL AMBIENTAL S.A. DE C.V.','PEDRO ACEVES 70','STA. MARTHA ACATITLA','IZATAPALAPA','09510','MEXICO D.F.','','','','','','2007-07-06',1,'E0541942'),
  ('GRO050830PG8','','GRUPO ROTRANS S.A. DE C.V.','ALVARO OBREGON 151 DESP. 801 Y 802','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-07-07',1,'G1217671'),
  ('MAAJ351008NC8','','MARTINEZ ACEVES JORGE','ARBOLILLO 46','VILLA COAPA','TLALPAN','14390','MEXICO D.F.','','','','','','2007-07-10',1,'H1374369'),
  ('GARM72011186P','','GALVAN RAMIREZ JOSE MARIO','20 RETORNO DE ROSARIO CASTELLANOS  138 A','CULHUACAN C T M OBRERO','COYOACAN','04480','MEXICO D.F.','','','','','','2007-07-10',1,'J 1328183'),
  ('HAD9111129T6','','HUMANA ADMINISTRADORA S.A. DE C.V.','CAMINO A SANTA TERESA 1055 SOTANO 21','HEROES DE PADIERNA','MAGDALENA CONTRERAS','10700','MEXICO D.F.','','','','','','2007-07-11',1,'A0698213'),
  ('GUQA851003QMA','','GUTIERREZ QUIROZ ALFREDO','SAN LUIS POTOSI 107','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-07-12',1,'G1212691'),
  ('SER0006197DA','','SERBIOMED S A DE C V','GIOTTO 213','ALFONSO XIII','ALVARO OBREGON','01460','MEXICO D.F','','','','','','2007-07-16',1,'H 1319453'),
  ('AEH0402048N1','','ASESORES EN EQUIPAMIENTO HOSPITALARIO S. DE R.L. DE C.V.','ARISTA 883','TEQUISQUIAPAN','SAN LUIS POTOSI','78230','SAN LUIS POTOSI','','','','','','2007-07-20',1,'F640570'),
  ('JCI78031351A','','JANSSEN CILAG S.A. DE C.V.','CANOA 79','TIZAPAN SAN ANGEL','ALVARO OBREGON','01090','MEXICO D.F.','','','','','','2007-07-20',1,'H1363856'),
  ('ACF070529KF6','','AGV CONSULTORIA FISCAL S C','TONALA 178 DEP 401','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-07-21',1,'A1217536'),
  ('GAS930426QSO','','GRUPO ACTUARIAL Y SERVICIOS SA DE CV','AV TECNOLOGICO 100 14','SAN ANGEL','QUERETARO QTO','76030','MEXICO','','','','','','2007-07-27',1,'4867783'),
  ('CATJ780309PD8','','CHAVEZ TELLEZ JULIO MAURICIO','SUR 87 No 225','CACAMA','IZATAPALAPA','09080','MEXICO D.F.','','','','','','2007-07-30',1,'I1464136'),
  ('LIN011023H80','','LIPSA INDUSTRIAL S A DE CV','MONTES URALES 520 PB','LOMAS DE CHAPULTEPEC','MIGUEL HIDALGO','11000','MEXICO D.F','','','','','','2007-07-31',1,'G 1190425'),
  ('AIRJ760911G1A','','AVILA  REYES JUAN   CARLOS','MIRAMAR 925','MIRAVALLE TLAPAN Y MIRAFL','BENITO JUAREZ','03580','MEXICO D.F','','','','','','2007-07-31',1,'M 1460633'),
  ('HOMV460816S27','','HGORTA MORENO VICENTE','ASPERON 6233-1','TRES ESTRELLAS','GUSTAVO A. MADERO','07820','MEXICO D.F.','','','','','','2007-08-01',1,'M1477638'),
  ('MAHA551224LL7','','MARQUEZ HORCASITAS JOSE ANTONIO','CDA. ROMERO DE TERREROS 50','DEL VALLE','BENITO JUAREZ','03100','MEXICO D.F.','','','','','','2007-08-03',1,'L1441048'),
  ('PEFF490807RV2','','PEREZ FERNANDEZ FRANCISCO','ORIENTE 249 A','AGRICOLA ORIENTAL','IZTACALCO','08500','MEXICO D.F.','','','','','','2007-08-07',1,'l 1446530'),
  ('RARD771216TS6','','RANGEL RIOS DANIEL','MEDELLIN 259 \"A\"','ROMA SUR','CUAUHTEMOC','06760','MEXICO D.F.','','','','','','2007-08-09',1,'G1218433'),
  ('GAML8105019YA','','JOSE LUIS  GRACIA MEDINA','BOSQUE DE FONTAINEBLEAU 95','PASEOS DEL BOSQUE','NAUCALPAN, EDO. MEX','53297','ESTADO DE MEXICO','','','','','','2007-08-10',1,'A1573186'),
  ('VIBI440416AG6','','VILLELA APARICIO Y BARAJAS IGNACIO ANTONIO','GABRIEL MANCERA 136 P B','DEL VALLE','BENITO JUAREZ','03100','MEXICO DF.','','','','','','2007-08-10',1,'F 1218964'),
  ('ROBL480830HU5','','RODRIGUEZ BRAVO JOSE LUIS GILBERTO','XOLA 318-203','DEL VALLE','BENITO JUAREZ','03100','MEXICO D.F.','','','','','','2007-08-11',1,'I1401731'),
  ('IPR981125PN9','','IMPRESORES PROFESIONALES SA DE CV','CALLE 6 N o 208','AGRICOLA PANTITLA',' IZTACALCO','08100','MEXICO D.F','','','','','','2007-08-14',1,'G 1460442'),
  ('DEA0405134D4','','DISEÑO ESTRUCTURALES EN ACERO SA DE CV','CALLE 4 A LOTE 4 MANZANA H','AMPLIACION DEL PARQUE IND','TOLUCA','50200','EDO. DE MEXICO','','','','','','2007-08-14',1,'F 1669316'),
  ('GCP060929C12','','GRUPO CONSULTORES EN PROCESOS Y TECNOLOGIA DE LA INFOR SA DE CV','TLACOTALPAN 137 B','ROMA SUR','CUAUHTEMOC','06760','MEXICO D.F','','','','','','2007-08-15',1,'A1201902'),
  ('DIC000926FP4','','DICOT S.A. DE C.V.','AV. EJERCITO NACIONAL 326 DEP 402','CHAPULTEPEC MORALES','MIGUEL HIDALGO','11570','MEXICO D.F.','','','','','','2007-08-16',1,'I1114792'),
  ('MIN900330GQ8','','MAPAS INTELIGENTES S A DE C V','AMSTERDAM 291 101','HIPODROMO','CUAUHTEMOC','06100','MEXICO D.F','','','','','','2007-08-16',1,'G 1217850'),
  ('IMP8107107Y2','','IMPRECENTRO S A DE C V','AV  YUCATAN 84 C','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-08-16',1,'D0539274'),
  ('POGJ760303FE3','','JUAN CRISTOBAL POPOCA GUERRERO','TABASCO 236  104','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-08-16',1,'F 1268651'),
  ('GCE951030R21','','GRUPO CONSTRUCTORA EJA S.A. DE C.V.','DOCTOR VEAZCO 36 INT 202','DOCTORES','CUAUHTEMOC','06720','MEXICO D.F.','','','','','','2007-08-18',1,'E0104646'),
  ('VIEC7503247M4','','CARLOS ANDRES VILLELA ELIZONDO','BARCELONA 147','MEXICO','TLALNEPANTLA','54020','EDO. DE MEXICO','','','','','','2007-08-21',1,'A1548808'),
  ('EZK0610105A2','','EZKIRA SA DE CV','MEDELLIN  40 LOCAL A \"','ROMA NORTE','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-08-21',1,'G1225608'),
  ('AIN030313QS5','','AUTO INTEGRAL S.A. DE C.V.','3a CERRADA DE AV. CENTRAL No 3','PANTITLAN','IZTACALCO','08100','MEXICO D.F.','','','','','','2007-08-24',1,'A1437834'),
  ('AIP040203MR6','','ASESORIA EN INVERSIONES Y PROYECTOS DE ALTA TECNOLOGIA SA DE CV','AV PASEO DE LA REFORMA 2467','LOMAS DE REFORMA',' MIGUEL HIDALGO','11000','MEXICO D.F.','','','','','','2007-08-29',1,'I 1104767'),
  ('MAHA700311JX5','','MARTINEZ HERRERA ADRIAN','RETORNO 38 19 AVANTE LA VIRGEN Y SANTANA','COYOACAN','COYOACAN','04460','MEXICO D.F.','','','','','','2007-08-31',1,'K1342809'),
  ('MAGL760324ML1','','LUIS DAVID MACHAIN GARZA','VIVEROS DEL ALAMO NO 17','VIVEROS DE LA LOMA','TLALNEPANTLA DE BAZ','54080','ESTADO DE MEXICO','','','','','','2007-09-06',1,'A1564360'),
  ('REPF570703DDO','l 1420470',' REVILLA PEÑALOZA FRANCISCO','ESTAFETA  129 -14','POSTAL','BENITO JUAREZ','03410','MEXICO D.F.','','','','','','2007-09-06',1,''),
  ('DETG721013IV8','','DELGADILLO TEYER GERMAN HUMBERTO','ANDADOR DE LA FRATERNIDA 101UH','FOVISSSTE SN PEDRO MATIR','TLALPAN','14650','MEXICO D.F','','','','','','2007-09-07',1,'H 1398959'),
  ('ASC05081QR7','','ALTERNATIVA SOCIAL DEMOCRATA Y CAMPESINA','INSURGENTES SUR 1942','FLORIDA','ALVARO OBREGON','01030','MEXICO D.F','','','','','','2007-09-07',1,'G 1203235'),
  ('BSU930628DJ5','','EI BC SUPPLY SA DE CV','AV UNIVERSIDAD 1377 P B','AXOTLA','ALVARO OBREGON','01030','MEXICO D.F.','','','','','','2007-09-07',1,'B1025983'),
  ('SME001012R12','','STAR MEDICA S.A. DE C.V.','BLVD. TEOFILO BORUNDA 868-1 LOC. 70 Y 71 P.B.','PARTIDO IGLESIAS','CD. JUAREZ','32618','CIUDAD JUAREZ, CHIHUAHUA','','','','','','2007-09-10',1,'F346805'),
  ('AMH9802248U5','','ABASTECEDORA DE MATERIALES HIDRAULICOS AMI SA DE CV','FRANCISCO MORAZAN No 6','PRADERA','GUSTAVO A. MADERO','07500','MEXICO D.F','','','','','','2007-09-11',1,'G 1416071'),
  ('ROMG6503243VA','','RODRIGUEZ MENDOZA GABRIEL','MONTECITO 38 PISO 33 OF. 30','NAPOLES','BENITO JUAREZ','03810','MEXICO D.F.','','','','','','2007-09-12',1,'G1211465'),
  ('AIBL7302151X8','','AVILA BAÑUELOS LUIS GERARDO','JOSE JOAQUIN ARRIAGA No 63-1','OBRERA','CUAUHTEMOC','06800','MEXICO D.F','','','','','','2007-09-13',1,'K1404168'),
  ('COP920428Q20','','COPPEL S.A.B.  DE CV','CALLE REPUBLICA 2855 PTE','RECURSOS',' CULIACAN','80105','CULIACAN, SINALOA','','','','','','2007-09-14',1,'A4405480'),
  ('NAMJ760203ID1','','JUAN SEBASTIAN NAVARRO MONTOYA','DAVID CABRAL N.o 105-B','FRA. MEDICOS VETERINARIOS','ZACATECAS ZAC.','98097','ZACATECAS','','','','','','2007-09-17',1,'A5605931'),
  ('MPE020301U74','','CIA DE MAQ DE PROS Y EMP PIALIM SA DE CV','NORTE 66 ·# 3724','M DE RIO BLANCO','G.A. MADERO','07880','MEXICO D.F','','','','','','2007-09-19',1,'K 1452894'),
  ('ECC7808113ZO','','ESCUELA COMERCIAL CAMARA DE COMERCIO SC','QUERETARO 34','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-09-24',1,'A0086738'),
  ('LOUE740821EE6','','LOPEZ URIBE EUGENIA','C. MIRAVALLE 211-1','ALBERT','BENITO JUAREZ','03560','MEXICO D.F.','','','','','','2007-09-25',1,'C0520757'),
  ('CLA011009S17','','CORPORACCION LATINO AMERICANA DE EJECUTIVOS ESPECIALIZADOS SC.','LAURO AGUIRRE # 212','AGRICULTURA','MIGUEL HIDALGO','11360','MEXICO D.F.','','','','','','2007-09-27',1,'H1153721'),
  ('PES060523N37','','PREMIUM ELEVATOR SERVICE COMPANY S.A. DE C.V.','CDA. ARROYO 50-16','LOS FRESNOS','NAUCALPAN, EDO. MEX','53237','NAUCALPAN','','','','','','2007-09-28',1,''),
  ('AARH7010134GA','','ALVARADO RAMIREZ HUGO EDUARDO','HACIENDA DEL CAMPESTRE 218','HACIENDA DEL CAMPESTRE','LEON GANAJUATO','37170','MEXICO','','','','','','2007-10-04',1,'X222702'),
  ('SNC9906299J5','','SINDICATO NACIONAL DE CONTROLADORES DE TRANSITO AEREO','TAPACHULA N.o 3','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-10-05',1,'l 1403978'),
  ('SSC060823HI1','','6 + 4 CONTROL DE RIESGOS SA DE CV','JUAN N. ALMONTE MZ 7 LTE 17','PRESIDENTES DE MEXICO','IZTAPALAPA','09740','MEXICO D.F.','','','','','','2007-10-11',1,'A1412446'),
  ('PFl730206632','','PFlZER SA DE CV','PASEO DE LOS TAMARINDOS N.o 40','BOSQUES DE LAS LOMAS','CUAJIMALPA','05120','MEXICO D.F.','','','','','','2007-10-12',1,'D0128282'),
  ('TEM050915CB5','','TELEVISA EMI MUSIC S.A. DE C.V.','AV. VASCO DE QUIROGA 2000','SANTA FE','CUAJIMALPA','01210','MEXICO D.F.','','','','','','2007-10-12',1,'K1359147'),
  ('HOL010927QIA','','HOLISTICANDO S.A. DE C.V.','COAHUILA 52-3','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-10-12',1,'E1286725'),
  ('AFI07022224A','','ADVERTISNG FINDERS SA DE CV','ACOXPA AND 9','VILLA COAPA','TLALPAN','14390','MEXICO D.F','','','','','','2007-10-16',1,'A1326500'),
  ('WCA070716V69','','WH CONSULTORES ASOCIADOS SA DE CV','Av VIADUCTO MIGUEL ALEMAN 679  1','ROMA SUR','CUAUHTEMOC','06760','MEXICO D.F.','','','','','','2007-10-16',1,'A1221834'),
  ('SPL0701298Z7','','SERV. PROF. DE LIMPIEZA RAJTO SA DE CV','LAS FUENTES 1110 OFICINA G','LAS FUENTES SEC. LOMAS','REYNOSA','88700','REYNOSA. TAMPS.','','','','','','2007-10-17',1,'A1218005'),
  ('CDP900926EE9','','CARTELLO DISEÑO PUBLICITARIO S.A. DE C.V','AGUA DULCE 904','PETROLERA','TAMPICO','89110','TAMPICO, TAMPS.','','','','','','2007-10-18',1,'C3393604'),
  ('SPV0505036I2','','SERVICIOS PRENDARIOS VALLE DEL MEZQUITAL S.A. DE C.V.','GUADALUPE VICTORIA 6 LOCAL 4,5 Y 6','CENTRO MIXQUIAHUALA','MIXQUIAHUALA','42700','MIXQUIAHUALA DE JUAREZ, HGO','','','','','','2007-10-22',1,'F536282'),
  ('NAED5512115L7','','NATOLI ESPINOSA DAMASO','CHIAPAS 156','ROMA SUR','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2007-10-22',1,'E1233865'),
  ('CAGS470405GT4','','SERGIO DEL CASTILLO GUIZAR','AV. REVOLUCION 1104 3º PISO','PERIODISTAS','PACHUCA','42060','PACHUCA HIDALGO','','','','','','2007-10-24',1,'A0518825'),
  ('NAMA670807GB6','','NAVARRO MONTIEL ARTURO','EMILIANO ZAPATA 58-4','PROVIDENCIA','AZCAPOTZALCO','02440','MEXICO D.F.','','','','','','2007-10-26',1,'H1126596'),
  ('CUMN751217UF9','','CUEVAS MARTINEZ NIMCY','SAN JOSE DEL REAL 14','LOMAS VERDES 5A SEC','NAUCALPAN','53126','ESTADO DE MEXICO','','','','','','2007-10-26',1,'1518770'),
  ('DN&031002E26','','DIGITAL NETWORKS & CABLE SYSTEMS SA DE CV','AVENIDA BENITO JUAREZ Nº 100 INTERIOR LOCAL 15 ALTOS','CUESCO','PACHUCA','42080','PACHUCA HIDALGO','','','','','','2007-11-01',1,'F504085'),
  ('CAS990719T10','','CAPA ASESORES S.C.','PUEBLA 112','ROMA NORTE','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2007-11-01',1,'C1299891'),
  ('MOKR640617U83','','ROBERTO ANGEL MOLINARI KROQUER','CAROLINA 74 B','TEPEYAC','GUSTAVO A. MADERO','07020','MAXICO DF','','','','','','2007-11-06',1,'A1482714'),
  ('BGU070212DR1','','BELDUN GUELTZE S.A. DE C.V .','DINAMARCA 77-4','JUAREZ','CUAUHTEMOC','06600','MEXICO D.F','','','','','','2007-11-08',1,'A1209055'),
  ('LSA840101TC6','','LABORATORIOS SANFER SA DE CV','BULEVER ADOLFO LOPEZ MATEOS Nª 314-1A','TLACOPAC','ALVARO OBREGON','01049','MAXICO DF','','','','','','2007-11-09',1,'0532882'),
  ('EAME760918CU6','','ESTRADA MARTINEZ EDGAR OMAR','JERICO Nª 46','ROMERO RUBIO','VENUSTIANO CARRANZA','15400','MEXICO D.F','','','','','','2007-11-15',1,'J1494168'),
  ('WMI970414AQ8','','WONDERWARE DE MEXICO','AGUSTIN M. CHAVEZ 1 DESP. 004','CENTRO DE CD. SANTA FE','ALVARO OBREGON','01210','MEXICO D.F.','','','','','','2007-11-16',0,'E1800857'),
  ('WMI970414AQ8','','WONDERWARE DE MEXICO.INC','AGUSTIN M. CHAVEZ 1 DESP. 004','CENTRO DE CD. SANTA FE','ALVARO OBREGON','01210','MEXICO D.F.','','','','','','2007-11-16',1,'E1800857'),
  ('EMM830609-T73','','EDITORIAL EL MANUAL MODERNO SA DE CV','AV. SONORA 206-201','HIPODROMO','CUAUHTEMOC','06100','MEXICO D.F','','','','','','2007-11-20',1,'A0088027'),
  ('SCO020920HHA','','SERVICIOS CORPORATIVOS MC S.C','VIRREY DE MENDOZA 2000','FELIX IRETA','MORELIA','58070','MORELIA, MICHOACAN','','','','','','2007-11-22',1,'F305798'),
  ('CGS060612V97','','CORPORATIVO GSM SA DE CV','VIRREY DE MENDOZA 2000 2 A FELIX IRETA MORELIA CAMELINAS Y TAXIMAROA','MORELIA MICHOACAN','MORELIA','58070','MORELIA MICHOACAN','','','','','','2007-11-22',1,'F0359100'),
  ('SME000210IC3','','STARMIX DE MEXICO SA DE CV','JALAPA 37 ALTOS','ROMA','CUAUHTEMOC','06700','MAXICO DF','','','','','','2007-11-22',1,'E1225158'),
  ('OHA051207QG8','','OPERADORA DE HOSPITALES DE ALTA ESPECIALIDAD S.A. DE C.V.','CAMINO DE RECREO 90','EL RECREO','AZCAPOTZALCO','02070','MEXICO D.F','','','','','','2007-11-22',1,'I1190440'),
  ('MIS050914TU7','','MACA IMPULSORA DE SERVICIOS PROFESIONALES S.A. DE C.V.','AMSTERDAM 73-C','CONDESA','CUAUHTEMOC','06100','MEXICO D.F.','','','','','','2007-11-22',1,'G1203410'),
  ('CYY980206VE7','','CONSORCIO YAN YAN TI S.A. DE C.V.','SAGU 190','GRANJAS ESMERALDA','IZTAPALAPA','09810','MEXICO D.F.','','','','','','2007-11-22',1,'K1440382'),
  ('SIRA810510KT7','','ALEJANDRO SILVA RODRIGUEZ','VALLE DE CARVAJAL136','VALLE DE ARAGON','NEZAHUALCOYOTL','57100','MEXICO D.F.','','','','','','2007-11-29',1,'A1532598'),
  ('MARS551202B22','','SILVIA ELDA MARTINEZ ROJAS','CHIHUAHUA 232','ROMA','CUAUHTEMOC','06700','MAXICO DF','','','','','','2007-12-01',1,'F6459384'),
  ('IAG900424HG7','','INGENIEROS ASOCIADOS EN GEOTECNIA Y SUPERVISION SA DE CV','INSURGENTES SUR 382-32','ROMA SUR','CUAUHTEMOC','06760','MAXICO DF','','','','','','2007-12-03',1,'A1216096'),
  ('FAR980619TJ7','','FARMASIDE SA DE CV','PESTALOZZI Nª 964','DEL VALLE','BENITO JUAREZ','03100','MEXICO D.F.','','','','','','2007-12-03',1,'I 1368496'),
  ('GSL011001IXA','','GRUPO SLAVA SA DE CV','PASEO DE LE REFORMA Nª 2625 BIS','LOMAS ALTAS','MIGUEL HIDALGO','11950','MEXICO D.F.','','','','','','2007-12-04',1,'G1188014'),
  ('TEC021010KA9','','TECHNO DOMUS, SA CU','ESCOCIA Nª 24 PLANTA  B','PARQUE SAN ANDRES','COYOACAN','04040','MEXICO D.F.','','','','','','2007-12-06',1,'L1403273'),
  ('SAM951123978','','SANOFI AVENTIS DE MEXICO SA DE CV','AV UNIVERSIDAD 1738','COYOACAN CENTRO','COYOACAN','04000','MAXICO DF','','','','','','2007-12-07',1,'K 1385136'),
  ('RIM-841030QC8','','REPRECENTACIONES E INVESTIGACIONES MEDICAS S.A. DE C.V.','CAMINO A SANTA TERESA Nª 1040 INT. 501,502,601','JARDINES EN LA MONTAÑA','TLALPAN','14210','MEXICO D.F','','','','','','2007-12-12',1,'A0116222'),
  ('MED980923JP5','','MEDILAP SA DE CV','SAN LUIS POTOSI 122','ROMA','CUAUHTEMOC','06700','MEXICO DF.','','','','','','2007-12-14',1,'C1286576'),
  ('ASE960826UMO','','ASEG SA DE CV','HACIENDA DE LORETO 205','REAL DE MINAS','PACHUCA','42090','PACHUCA HIDALGO','','','','','','2007-12-17',1,'F081636A'),
  ('ECO950403D56','','ECOSAN S.A. DE C.V.','ZENZONTLE 7','BELLAVISTA','ALVARO OBREGON','01140','MEXICO D.F','','','','','','2007-12-21',1,'C11639*95'),
  ('OICM700819M43','','OLIVERA CARRILLO MAURICIO ESTEBAN','YACATAS 415','NARVARTE','BENITO JUAREZ','03020','MEXICO D.F.','','','','','','2008-01-04',1,'H1393540'),
  ('NISM4609124U8','','NIETO SEGUNDO MANUEL','DURANGO #59 ED.1 DEP. 102','STA. APOLONIA','AZCAPOTZALCO','02790','MAXICO DF','','','','','','2008-01-04',1,'I1140094'),
  ('SCO941025828','','SERVICIOS Y CONSTRUCCIONES ORLER SA DE CV','RIO PAPALOAPAN 718-302','INDUSTRIAL BRAVO','CULIACAN','80120','CULIACAN, SINALOA','','','','','','2008-01-07',1,'F4409826'),
  ('GMT050819MW9','','GRUPO MERCANTIL TE PRESTAMOS SA DE CV','SIERRA MOHINORA Nª 46','REFORMA SOCIAL','MIGUEL HIDALGO','11000','MAXICO DF','','','','','','2008-01-08',1,'I1179264'),
  ('SPE0304104N9','','SOLUCIONES PROF EMP POR EXP EN TEC SPEXTEC SA DE CV','OMETUSCO Nª7 ALTOS 1','HIPODROMO CONDESA','CUAUHTEMOC','06170','MEXICO D.F','','','','','','2008-01-09',1,'F1213693'),
  ('CEN9812024W6','','CORPORATIVO ENCISO SC','5 DE MAYO No 967','CENTRO APDO POSTAL 182','VERACRUZ','91700','VERACRUZ VERACRUZ','','','','','','2008-01-10',1,'G1459967'),
  ('SIA890123DL6','','SERVICIOS DE INGENIERIA Y ASESORIA EN SOLDURA SA DE CV','AVENIDA BAJA CALIFORNIA Nª71','ROMA','CUAUHTEMOC','06760','MAXICO DF','','','','','','2008-01-10',1,'A0075626'),
  ('CSA980102UV4','','CASA SABA S.A. DE C.V.','AV. TAXQUEÑA 1798','PASEOS DE TAXQUEÑA','COYOACAN','04250','MEXICO D.F.','','','','','','2008-01-10',1,'E1263709'),
  ('HDM5809026N4','','HOBART DAYTON MEXICANA SA DE CV','ALFONSO REYES 2305','DEL PRADO','MONTERREY','64410','MONTERREY N.L.','','','','','','2008-01-14',1,'C1292742'),
  ('ZUUJ5504275T2','','ZUGARRAMUNDI UNZU JORGE','CHIAPAS 73','ROMA SUR','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2008-01-16',1,'A1232103'),
  ('GMS971110BTA','','GRUPO MEXICANO DE SEGUROS SA DE CV','INSURGENTES SUR 1605 PISO 25','SAN JOSE INSURGENTES','BENITO JUAREZ','03900','MAXICO DF','','','','','','2008-01-17',1,'I1382770'),
  ('OWI021218GK1','','Oñate Willy y Compañia s c','Calle Norte 196 No 694','Pensador Mexicano','VENUSTIANO CARRANZA','15510','MEXICO D.F.','','','','','','2008-01-17',1,'L 1406921'),
  ('HNA9405101Q0','','HIPOTECARIA NACIONAL SA DE CV','MONTES URALES 424 2ª PISO','LOMAS DE CHAPULTEPEC','MIGUEL HIDALGO','11000','MEXICO D.F.','','','','','','2008-01-18',1,'D0305291'),
  ('CGE0009145F6','','CARNES GEMPRO SA DE CV','PERIFERICO ORIENTE S/N','ZONA  IND. SUR','HERMOSILLO','63200','HERMOSILLO SONORA','','','','','','2008-01-22',1,'C4687608'),
  ('CJU060676474','','CORPORATIVO JURIN SC','CALLE PLAYA GUITARRON Nª 286-1','REFORMA IZTACCIHUATL NTE','IZTACALCO','08810','MAXICO DF','','','','','','2008-01-22',1,'N1401264'),
  ('CJU060616474','','CORPORATIVO JURIN SC','CALLE PLAYA GUITARRON Nª 286-1','REFORMA IZTACCIHUATL NTE','IZTACALCO','08500','MEXICO D.F','','','','','','2008-01-22',1,'N1401264'),
  ('DCC930302FR1','','DELEGACION DE LA COMISION DE LAS COMUNIDADES EUROPEAS','PASEO DE LA REFORMA  1675','LOMAS DE CHAPULTEPEC','MIGUEL HIDALGO','11001','MEXICO D.F','','','','','','2008-01-25',1,'0955292'),
  ('MANC820109772','','CRISTINA MARTINEZ NAVARRO','PARQUE DE GRANADA 71','BALCONES DE LA HERRADURA','HUIXQUILUCAN','52785','ESTADO DE MEXICO','','','','','','2008-01-31',1,'A1536663'),
  ('GCO060504D51','','GLOBAL CONTACT SA DE CV','SINDICALISIMO Nª 87-107','ESCANDON','MIGUEL HIDALGO','11800','MEXICO D.F','','','','','','2008-01-31',1,'I 1197679'),
  ('CSNO40805AH4','','CLASE 69 S. DE RL DE CV','TONALA 194-F','ROMA','CUAUHTEMOC','06700','MEXICO D.F','','','','','','2008-02-05',1,'FJ266749'),
  ('CCM981103792','','CORPORATIVO COMERCIAL MLM SA DE CV','MORENA #962 INT - E','NARVARTE','BENITO JUAREZ','03020','MEXICO D.F','','','','','','2008-02-06',1,'G1455685'),
  ('SBM-840823UU8','','SOTO BARRANCO MEXICANA SA DE CV','ALEJANDRIA Nª 71','CLAVERIA','AZCAPOTZALCO','02080','MEXICO D.F','','','','','','2008-02-06',1,'A0039149'),
  ('AMAO604208FA','','AP MASCARILLAS SA DE CV','NUEVOS HORIZONTES MZ. 414 LTE 3917','LAZARO CARDENAS','TLANEPANTLA','54189','EDO. DE MEXICO','','','','','','2008-02-07',1,'R1539118'),
  ('NMA0206102N2','','LA NUEVA MADRILEÑA SA DE CV','ROMERO DE TERREROS Nª520 L-2','DEL VALLE','BENITO JUAREZ','03100','MEXICO D.F','','','','','','2008-02-08',1,'I1352015'),
  ('ISM031125618','','INTERNACIONAL DE SISTEMAS MODULARES SA DE CV','NORTE 77 Nª3325','OBRERO POPULAR','AZCAPOTZALCO','02840','MEXICO D.F','','','','','','2008-02-12',1,'S92877542'),
  ('TOX910412554','','TOXTI S.A. DE C.V.','MONTERREY 170','ROMA','CUAUHTEMOC','06700','MEXICO D.F.','','','','','','2008-02-15',1,'E2262686'),
  ('NP&011002SU8','','NET PACING & MEDICAL S.A. DE C.V.','PESTALOZZI 312-303','NARVARTE','BENITO JUAREZ','03020','MEXICO D.F.','','','','','','2008-02-15',1,'E1290073'),
  ('REC000929I5A','','RESCATE ECOLOGICO CULTURAL Y MINERO RECMAC A.C.','DOMICILIO CONOCIDO','DOS ESTRELLAS','TLALPUJAHUA','61060','TLALPUJAHUA,MICH.','','','','','','2008-02-20',1,'E378596'),
  ('MNO051013NC3','','MICRO ANALISIS DEL NORTE SA DE CV','CDA. MERCED DE LAS HUERTAS 25-3','STO TOMAS','MIGUEL HIDALGO','11340','MEXICO D.F.','','','','','','2008-02-20',1,'I1183795');

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
  (1,'Bacardi Blanco','',152,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,700.00,5,1,1,1,1),
  (2,'Bacardi Añejo','',154,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,750.00,5,1,1,1,1),
  (3,'Bacardi Oro','',153,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,700.00,5,1,1,1,1),
  (4,'Bacardi 101','',159,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,700.00,0.00,5,1,1,1,1),
  (5,'Bacardi Solera','',158,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,650.00,0.00,5,1,1,1,1),
  (6,'Bacardi Coco','',156,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,650.00,0.00,5,1,1,1,1),
  (7,'Bacardi Limón','',155,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,650.00,0.00,5,1,1,1,1),
  (8,'Bacardi Razz','',157,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,650.00,0.00,5,1,1,1,1),
  (9,'Baraima Blanco','',160,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,600.00,0.00,5,1,1,1,1),
  (10,'Appleton Estate','',151,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,5,1,1,1,1),
  (11,'Appleton Special','',150,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,650.00,800.00,5,1,1,1,1),
  (12,'Appleton Blanco','',149,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,600.00,700.00,5,1,1,1,1),
  (13,'Malibú','',170,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,650.00,0.00,5,1,1,1,1),
  (14,'Matusalem Platino','',171,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,700.00,0.00,5,1,1,1,1),
  (15,'Matusalem Clásico','',172,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,700.00,0.00,5,1,1,1,1),
  (16,'Matusalem Gran Reserva','',173,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,800.00,0.00,5,1,1,1,1),
  (17,'Flor de Caña 12','',165,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,850.00,0.00,5,1,1,1,1),
  (18,'Flor de Caña 7','',164,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,5,1,1,1,1),
  (19,'Flor de Caña 4','',163,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,600.00,0.00,5,1,1,1,1),
  (20,'Flor de Caña Blanco','',162,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,600.00,0.00,5,1,1,1,1),
  (21,'Havana Blanco','',166,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,600.00,0.00,5,1,1,1,1),
  (22,'Havana Añejo Especial 3','',167,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,650.00,0.00,5,1,1,1,1),
  (23,'Havana Añejo Reserva','',168,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,750.00,0.00,5,1,1,1,1),
  (24,'Havana 7','',169,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,750.00,0.00,5,1,1,1,1),
  (25,'Ocumare Blanco','',174,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,600.00,0.00,5,1,1,1,1),
  (26,'Ocumare Añejo','',175,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,650.00,0.00,5,1,1,1,1),
  (27,'Potosí','',176,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,700.00,5,1,1,1,1),
  (28,'Castillo','',161,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,650.00,5,1,1,1,1),
  (29,'Don Q Cristal','',228,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,650.00,0.00,5,1,1,1,1),
  (30,'Don Q Añejo','',229,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,5,1,1,1,1),
  (31,'Centenario Plata','',135,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,650.00,0.00,4,1,1,1,1),
  (32,'Centenario Reposado','',134,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,750.00,4,1,1,1,1),
  (33,'Cuervo Especial','',137,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,700.00,4,1,1,1,1),
  (34,'Tradicional','',138,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,4,1,1,1,1),
  (35,'Hacienda','',146,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,800.00,4,1,1,1,1),
  (36,'Conmemorativo','',145,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,800.00,5,0,1,1,1),
  (37,'Hornitos','',147,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,4,1,1,1,1),
  (38,'1800','',136,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,900.00,0.00,4,1,1,1,1),
  (39,'Don Julio Reposado','',140,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,900.00,0.00,4,1,1,1,1),
  (40,'Don Julio Blanco','',139,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,4,1,1,1,1),
  (41,'Cabrito','',132,0,0,0,0,0,0,0,0,0,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,700.00,4,1,1,1,1),
  (42,'7 Leguas','',148,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,900.00,0.00,4,1,1,1,1),
  (43,'Cazadores','',133,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,4,1,1,1,1),
  (44,'Herradura Añejo','',143,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,125.00,1500.00,0.00,4,1,1,1,1),
  (45,'Herradura Reposado','',141,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,900.00,0.00,4,1,1,1,1),
  (46,'Herradura Blanco','',142,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,750.00,900.00,4,1,1,1,1),
  (47,'Jimador','',144,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,800.00,4,1,1,1,1),
  (48,'100 Años','',131,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,600.00,0.00,5,0,1,1,1),
  (49,'Don Pedro','',180,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,600.00,750.00,6,1,1,1,1),
  (50,'Presidente','',184,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,600.00,0.00,6,1,1,1,1),
  (51,'Absolut Azul','',202,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,800.00,0.00,8,1,1,1,1),
  (52,'Absolut Mandarin','',204,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,800.00,0.00,8,1,1,1,1),
  (53,'Absolut Citron','',203,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,800.00,0.00,8,1,1,1,1),
  (54,'Absolut Vainilla','',205,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,800.00,0.00,8,1,1,1,1),
  (55,'Absolut Raspberry','',206,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,75.00,900.00,0.00,8,1,1,1,1),
  (56,'Absolut Ruby Red','',208,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,75.00,900.00,0.00,8,1,1,1,1),
  (57,'Absolut Apeach','',207,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,75.00,900.00,0.00,8,1,1,1,1),
  (58,'Smirnoff','',209,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,700.00,8,1,1,1,1),
  (59,'Wyborowa','',211,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,800.00,0.00,8,1,1,1,1),
  (60,'Stolichnaya','',210,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,800.00,0.00,8,1,1,1,1),
  (61,'Belvedere','',212,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,1200.00,0.00,8,1,1,1,1),
  (62,'Grey Goose','',213,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,1200.00,0.00,8,1,1,1,1),
  (63,'Bombay','',218,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,75.00,900.00,0.00,10,1,1,1,1),
  (64,'Beefeater','',217,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,750.00,0.00,10,1,1,1,1),
  (65,'Oso Negro','',219,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,750.00,10,1,1,1,1),
  (66,'Fundador','',182,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,6,1,1,1,1),
  (67,'Magno','',183,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,6,1,1,1,1),
  (68,'Terry 1900','',186,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,750.00,0.00,6,1,1,1,1),
  (69,'Terry Centenario','',185,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,6,1,1,1,1),
  (70,'Torres 5','',188,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,700.00,0.00,6,1,1,1,1),
  (71,'Torres 10','',187,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,750.00,0.00,6,1,1,1,1),
  (72,'Azteca de Oro','',177,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,700.00,0.00,6,1,1,1,1),
  (73,'Etiqueta Roja','',246,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,7,1,1,1,1),
  (74,'Etiqueta Negra','',195,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,1300.00,0.00,7,1,1,1,1),
  (75,'Etiqueta Verde','',196,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,125.00,1500.00,0.00,7,1,1,1,1),
  (76,'Etiqueta Dorada','',197,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,200.00,2100.00,0.00,7,1,1,1,1),
  (77,'Etiqueta Azul','',200,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,420.00,4800.00,0.00,7,1,1,1,1),
  (78,'Buchanans','',190,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,1300.00,0.00,7,1,1,1,1),
  (79,'Chivas','',192,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,1300.00,0.00,7,1,1,1,1),
  (80,'Cutty Sark','',191,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,7,1,1,1,1),
  (81,'J&B','',193,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,7,1,1,1,1),
  (82,'Jack Daniels','',199,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,900.00,0.00,7,1,1,1,1),
  (83,'Carlos I','',179,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,125.00,1400.00,0.00,6,1,1,1,1),
  (84,'Duque de Alba','',181,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,170.00,2400.00,0.00,6,1,1,1,1),
  (85,'Cardenal de Mendoza','',178,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,155.00,2200.00,0.00,6,1,1,1,1),
  (86,'Remy Martin','',216,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,125.00,1350.00,0.00,9,1,1,1,1),
  (87,'Hennessy','',214,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,150.00,1550.00,0.00,9,1,1,1,1),
  (88,'Martell','',215,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,125.00,1350.00,0.00,9,1,1,1,1),
  (89,'Bailey\'s','',117,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,900.00,0.00,3,1,1,1,1),
  (90,'Chinchon Dulce','',222,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,850.00,11,1,1,1,1),
  (91,'Chinchon Seco','',221,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,850.00,11,1,1,1,1),
  (92,'Cadenas','',220,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,850.00,11,1,1,1,1),
  (93,'Vaccari Black','',129,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,0.00,3,1,1,1,1),
  (94,'Vaccari Blanco','',130,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,0.00,3,1,1,1,1),
  (95,'Licor 43','',125,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,0.00,3,1,1,1,1),
  (96,'Frangelico','',122,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,0.00,3,1,1,1,1),
  (97,'Chartreuse Verde','',121,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,125.00,0.00,0.00,3,1,1,1,1),
  (98,'Chartreuse Amarillo','',120,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,0.00,0.00,3,1,1,1,1),
  (99,'Amaretto di Sarono','',226,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,75.00,0.00,0.00,3,1,1,1,1),
  (100,'Kahlua','',128,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,3,1,1,1,1),
  (101,'Grand Marnier','',124,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,125.00,0.00,0.00,3,1,1,1,1),
  (102,'Strega','',127,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,0.00,3,1,1,1,1),
  (103,'Galliano','',123,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,0.00,3,1,1,1,1),
  (104,'Midori','',126,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,3,1,1,1,1),
  (105,'Controy','',118,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,3,1,1,1,1),
  (106,'Crema de Menta','',119,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,3,1,1,1,1),
  (107,'Casillero del Diablo','',232,0,0,0,0,0,0,0,0,0,0.177,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,130.00,250.00,25,1,1,0,1),
  (108,'Sangre de Toro','',231,0,0,0,0,0,0,0,0,0,0.177,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,75.00,150.00,300.00,25,1,1,0,1),
  (109,'Concha y Toro Tinto','',114,0,0,0,0,0,0,0,0,0,0.177,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,100.00,200.00,25,1,1,0,1),
  (110,'Concha y Toro Blanco','',113,0,0,0,0,0,0,0,0,0,0.177,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,100.00,200.00,25,1,1,0,1),
  (111,'100 Años','',131,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,650.00,0.00,4,1,1,1,1),
  (112,'Conmemorativo','',145,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,800.00,4,1,1,1,1),
  (113,'Domecq','',223,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,0.00,0.00,11,0,1,1,1),
  (114,'Domecq Seco','',223,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,11,1,1,1,1),
  (115,'Domecq Dulce','',223,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,11,1,1,1,1),
  (116,'Mico','',225,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,11,1,1,1,1),
  (117,'Campari','',110,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,1,1,1,1,1),
  (118,'Cinzano Dulce','',111,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,1,1,1,1,1),
  (119,'Cinzano Seco','',112,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,1,1,1,1,1),
  (120,'Cinzano Rojo','',241,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,1,1,1,1,1),
  (121,'Oporto Ferreira','',115,0,0,0,0,0,0,0,0,0,0.090,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,700.00,1,1,1,1,1),
  (122,'Café Americano','',270,0,0,0,0,0,0,0,0,0,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,15.00,0.00,0.00,15,1,0,1,0),
  (123,'Café Europeo','',270,0,0,0,0,0,0,0,0,0,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,15,1,0,1,0),
  (124,'Café Express','',270,0,0,0,0,0,0,0,0,0,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,15,1,0,0,1),
  (125,'Corona','',271,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (126,'Victoria','',272,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (127,'Negra Modelo','',273,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (128,'Modelo Especial','',274,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (129,'Pacifico','',275,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (130,'León','',276,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (131,'Montejo','',277,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (132,'Modelo Light','',278,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (133,'O`Douls','',279,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,0.00,0.00,12,1,1,1,0),
  (134,'Coca Cola','',280,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (135,'Coca Cola Light','',281,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (136,'Sidral','',251,0,0,0,0,0,0,0,0,0,0.310,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (137,'Quina','',252,0,0,0,0,0,0,0,0,0,0.195,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (138,'Tehuacan','',253,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (139,'Del Valle','',256,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (140,'Canada Dry','',282,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (141,'Squirt','',258,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (142,'Squirt Light','',257,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (143,'Clamato','',255,0,0,0,0,0,0,0,0,0,0.295,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,13,0,0,2,0),
  (144,'Alfonso XIII','',128,184,97,0,0,0,0,0,0,0,0.030,0.030,0.044,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,2,1,1,0,1),
  (145,'Becerro','',114,251,0,0,0,0,0,0,0,0,0.221,0.221,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (146,'Veneno','',94,93,95,96,42,0,0,0,0,0,0.073,0.073,0.030,0.073,0.009,0.000,0.000,0.000,0.000,0.000,35.00,0.00,0.00,24,1,0,2,0),
  (147,'Sangrita','',94,93,95,96,242,14,99,100,42,0,0.073,0.073,0.030,0.073,0.029,0.250,0.330,0.330,0.005,0.000,10.00,0.00,0.00,24,1,0,2,1),
  (148,'Bloody Mary','',209,100,285,283,0,0,0,0,0,0,0.045,0.060,0.009,0.009,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (149,'Bull Claro','',219,152,243,14,271,0,0,0,0,0,0.022,0.022,0.045,0.045,0.089,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (150,'Bull Oscuro','',219,152,243,14,273,0,0,0,0,0,0.023,0.023,0.045,0.045,0.089,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (151,'Clamato Natural','',255,283,285,0,0,0,0,0,0,0,0.103,0.009,0.009,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,0,2,0),
  (152,'Daiquiri','',152,243,285,0,0,0,0,0,0,0,0.045,0.045,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,2,1,1,0,0),
  (153,'Desarmador','',209,99,0,0,0,0,0,0,0,0,0.045,0.132,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (154,'Margarita','',118,132,243,285,0,0,0,0,0,0,0.030,0.030,0.015,0.015,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,2,1,1,0,0),
  (155,'Pantera Rosa','',209,110,252,0,0,0,0,0,0,0,0.045,0.009,0.132,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (156,'Piedra','',132,225,224,0,0,0,0,0,0,0,0.030,0.030,0.009,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (157,'Piña Colada','',152,66,97,243,98,0,0,0,0,0,0.045,0.030,0.030,0.030,0.088,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (158,'Piñada','',66,97,243,98,0,0,0,0,0,0,0.030,0.030,0.030,0.089,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,0,0,0),
  (159,'Sangría','',209,285,243,114,253,0,0,0,0,0,0.045,0.030,0.059,0.030,0.089,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,2,1,1,0,0),
  (160,'Sol  y Sombra','',182,222,0,0,0,0,0,0,0,0,0.022,0.022,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,2,1,1,0,0),
  (161,'Tequila Sunrise','',132,286,242,99,0,0,0,0,0,0,0.045,0.009,0.009,0.206,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (162,'Tom Collins','',219,243,285,253,0,0,0,0,0,0,0.045,0.045,0.030,0.073,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (163,'Vampiro','',132,283,242,99,0,0,0,0,0,0,0.045,0.009,0.009,0.118,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,0),
  (164,'Ron con Goma','',169,243,285,0,0,0,0,0,0,0,0.045,0.030,0.030,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,2,1,1,0,0),
  (165,'Cucaracha','',128,132,0,0,0,0,0,0,0,0,0.022,0.022,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,0.00,0.00,2,1,1,0,0),
  (166,'Lagartija','',209,119,285,243,253,0,0,0,0,0,0.030,0.030,0.030,0.059,0.059,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,2,1,1,0,0),
  (167,'Mojito','',167,285,253,0,0,0,0,0,0,0,0.045,0.030,0.103,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,2,1,1,0,0),
  (168,'Martini','',217,239,0,0,0,0,0,0,0,0,0.059,0.009,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,0.00,0.00,2,1,1,0,0),
  (169,'Licor de Manzana Verde','',287,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,3,1,1,2,1),
  (170,'Licor de Cassis','',286,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,3,1,1,2,1),
  (171,'Licor de Platano','',288,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,3,1,1,2,1),
  (172,'Curacao Azul','',289,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,3,1,1,2,1),
  (173,'Licor de Damiana','',230,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,3,1,1,0,1),
  (174,'Jugo de Naranja','',99,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,60.00,0.00,29,1,0,2,0),
  (175,'Jugo de Arandano','',103,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,70.00,0.00,29,1,0,2,0),
  (176,'Jugo de Piña','',98,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,60.00,0.00,29,1,0,2,0),
  (177,'Jugo de Uva','',102,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,60.00,0.00,10,0,0,2,0),
  (178,'Jugo de Toronja','',101,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,60.00,0.00,29,1,0,2,0),
  (179,'Jugo de Tomate','',100,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,60.00,0.00,29,1,0,2,0),
  (180,'Jugo de Uva','',102,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,60.00,0.00,29,1,0,2,0),
  (181,'Budweiser','',291,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,0.00,0.00,12,1,1,1,0),
  (182,'Clamato 2','',255,283,0,0,0,0,0,0,0,0,0.118,0.009,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,10.00,0.00,0.00,24,1,0,2,0),
  (183,'Piñada 2','',243,66,97,98,0,0,0,0,0,0,0.009,0.009,0.018,0.027,0.000,0.000,0.000,0.000,0.000,0.000,15.00,0.00,0.00,24,1,0,2,0),
  (184,'Sangría 2','',243,285,253,114,0,0,0,0,0,0,0.009,0.018,0.118,0.045,0.000,0.000,0.000,0.000,0.000,0.000,15.00,0.00,0.00,24,1,1,2,0),
  (185,'Agua','',104,0,0,0,0,0,0,0,0,0,0.500,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,2,0),
  (186,'Old Parr','',292,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,85.00,1300.00,0.00,7,1,1,1,1),
  (187,'Moet Chandon','',227,0,0,0,0,0,0,0,0,0,0.750,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,1500.00,1500.00,0.00,30,1,1,1,0),
  (188,'Vaso Michelado','',42,285,0,0,0,0,0,0,0,0,0.001,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,5.00,0.00,0.00,24,1,0,1,0),
  (189,'Vaso Cubano','',42,285,283,0,0,0,0,0,0,0,0.001,0.005,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,5.00,0.00,0.00,24,1,0,1,0),
  (190,'Herradura Antiguo','',201,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,750.00,0.00,4,1,1,1,1),
  (191,'Limonada','',243,285,253,0,0,0,0,0,0,0,0.045,0.045,0.180,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,0.00,0.00,13,1,0,0,0),
  (192,'Naranjada','',243,99,253,0,0,0,0,0,0,0,0.045,0.090,0.135,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,0.00,0.00,13,1,0,2,0),
  (193,'Conga','',242,99,98,0,0,0,0,0,0,0,0.023,0.180,0.180,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,13,1,0,0,0),
  (194,'Jagermeister','',294,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,750.00,0.00,3,1,1,1,1),
  (195,'Ruso Negro','',209,128,0,0,0,0,0,0,0,0,0.030,0.030,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,2,1,1,0,1),
  (196,'Ruso Blanco','',209,234,97,0,0,0,0,0,0,0,0.030,0.015,0.050,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,0.00,0.00,2,1,1,0,1),
  (197,'Suero','',253,285,42,0,0,0,0,0,0,0,0.355,0.030,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,25.00,0.00,0.00,13,1,0,0,0),
  (198,'Red Bull','',295,0,0,0,0,0,0,0,0,0,0.235,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,13,1,0,2,0),
  (199,'Boost','',296,0,0,0,0,0,0,0,0,0,0.235,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,13,1,0,2,0),
  (200,'Clamato Smirnoff','',209,283,255,0,0,0,0,0,0,0,0.045,0.009,0.120,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,0.00,0.00,2,1,1,0,1),
  (201,'Express Doble','',270,0,0,0,0,0,0,0,0,0,0.010,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,0.00,0.00,15,1,0,0,1),
  (202,'charro negro','',132,285,280,0,0,0,0,0,0,0,0.045,0.900,0.335,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,2,1,1,1,1),
  (203,'Mezcal Gusano Rojo','',297,0,0,0,0,0,0,0,0,0,0.800,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,850.00,0.00,4,1,1,1,1),
  (204,'Rompope','',233,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,3,1,1,1,1),
  (205,'Ojo Rojo','cerveza con clamato',271,255,285,283,0,0,0,0,0,0,0.300,0.070,0.005,0.005,0.000,0.000,0.000,0.000,0.000,0.000,50.00,0.00,0.00,12,1,1,0,1),
  (206,'Bloody Mary 2','jugo de tomate con veneno y limon',100,283,285,0,0,0,0,0,0,0,0.050,0.005,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,10.00,0.00,0.00,24,1,1,0,1),
  (207,'Jarra de jJugo de Arandano','',103,0,0,0,0,0,0,0,0,0,1.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,0.00,0.00,29,1,0,1,0),
  (208,'Martini de Manzana','',202,287,0,0,0,0,0,0,0,0,0.045,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,95.00,0.00,0.00,2,1,1,0,1),
  (209,'Perla Negra','',294,296,0,0,0,0,0,0,0,0,0.045,0.235,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,120.00,0.00,0.00,2,1,1,0,0),
  (210,'Vodka Zubrowka','',298,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,80.00,900.00,0.00,8,1,1,1,1),
  (211,'ABC','',116,117,215,0,0,0,0,0,0,0,0.015,0.015,0.015,0.000,0.000,0.000,0.000,0.000,0.000,0.000,110.00,0.00,0.00,2,1,1,0,0),
  (212,'MAMADA','',128,288,117,0,0,0,0,0,0,0,0.015,0.015,0.015,0.000,0.000,0.000,0.000,0.000,0.000,0.000,100.00,0.00,0.00,2,1,1,0,1),
  (213,'Fernet','',224,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,11,1,1,1,1),
  (214,'Hawai Azul','',152,289,98,97,0,0,0,0,0,0,0.045,0.045,0.170,0.045,0.000,0.000,0.000,0.000,0.000,0.000,100.00,0.00,0.00,2,1,1,0,0),
  (215,'Perla Dorada','',294,295,0,0,0,0,0,0,0,0,0.045,0.250,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,120.00,0.00,0.00,2,1,1,0,0),
  (216,'Coca Cola Zero','',300,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,20.00,0.00,13,1,0,1,0),
  (217,'Sprite 0','',301,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,20.00,0.00,13,1,0,1,0),
  (218,'Rafaga','',132,119,223,0,0,0,0,0,0,0,0.023,0.023,0.023,0.000,0.000,0.000,0.000,0.000,0.000,0.000,75.00,0.00,0.00,2,1,1,0,0),
  (219,'Licor de Pacharán','',303,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,3,1,1,0,1),
  (220,'Whisky Glennfiddich 12 años','',304,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,105.00,1900.00,0.00,7,1,1,1,1),
  (221,'Licor de Pacharan Etxeko','',305,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,3,1,1,1,1),
  (222,'Licor de Amaretto H.V.','',116,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,55.00,600.00,0.00,3,1,1,1,1),
  (223,'RED POP','',202,126,301,295,0,0,0,0,0,0,0.023,0.023,0.089,0.089,0.000,0.000,0.000,0.000,0.000,0.000,120.00,0.00,0.00,2,1,1,0,0),
  (224,'Tequila Centenario Añejo','',306,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,900.00,0.00,4,1,1,1,1),
  (225,'Estrella','',307,0,0,0,0,0,0,0,0,0,0.325,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,0.00,0.00,12,1,1,1,0),
  (226,'William Lawsons','',189,0,0,0,0,0,0,0,0,0,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,65.00,850.00,0.00,7,1,1,1,1),
  (227,'Ginger Ale Schweppes','',309,0,0,0,0,0,0,0,0,0,0.355,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,1,0),
  (228,'Quina  Schwepppes','',310,0,0,0,0,0,0,0,0,0,0.296,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,20.00,0.00,0.00,13,1,0,1,0),
  (229,'Mmonster','',311,0,0,0,0,0,0,0,0,0,0.246,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,0.00,0.00,13,1,0,1,0),
  (230,'Mai Tai','',218,289,285,0,0,0,0,0,0,0,0.445,0.220,0.220,0.000,0.000,0.000,0.000,0.000,0.000,0.000,110.00,0.00,0.00,2,1,1,0,0),
  (231,'Buchanans 18años','',312,0,0,0,0,0,0,0,0,0,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,195.00,2100.00,0.00,7,1,1,1,1);

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
  (1,'Quesadillas de Sesos','Tres Quesadillas Fritas',11,12,41,86,10,23,2,106,0,0,0.010,0.050,0.015,0.030,0.050,0.025,0.010,0.005,0.000,0.000,45.00,18,1),
  (2,'Manitas a la Vinagreta','Manitas Acompañadas con Chiles en Vinagre',68,12,8,6,2,4,1,63,0,0,0.300,0.015,0.020,0.050,0.050,0.050,0.010,0.050,0.000,0.000,80.00,18,1),
  (3,'Jamón Serrano','',69,33,0,0,0,0,0,0,0,0,0.100,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,100.00,18,1),
  (4,'Sesos Rebozados','',67,11,12,41,38,45,106,18,1,63,0.200,0.001,0.005,0.010,0.060,0.100,0.025,0.050,0.030,0.010,80.00,18,1),
  (5,'Sesos a la Mantequilla','',11,12,41,39,42,0,0,0,0,0,0.020,0.010,0.050,0.050,0.005,0.000,0.000,0.000,0.000,0.000,80.00,18,1),
  (6,'Machitos Fritos','',70,106,8,2,0,0,0,0,0,0,0.250,0.025,0.010,0.025,0.000,0.000,0.000,0.000,0.000,0.000,80.00,18,1),
  (7,'Chistorra Natural','',71,2,8,0,0,0,0,0,0,0,0.250,0.025,0.015,0.000,0.000,0.000,0.000,0.000,0.000,0.000,100.00,18,1),
  (8,'Chistorra con Queso','',71,33,0,0,0,0,0,0,0,0,0.250,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,120.00,18,1),
  (9,'Pierna al Horno','',11,41,12,72,106,8,2,0,0,0,0.045,0.200,0.020,0.250,0.025,0.010,0.025,0.000,0.000,0.000,100.00,14,1),
  (10,'Carne Asada con Enchiladas','Sabana de Filete con Enchiladas Verdes',73,86,105,40,7,22,2,8,42,0,0.200,0.150,0.025,0.025,0.020,0.005,0.005,0.020,0.005,0.000,150.00,14,1),
  (11,'Filete de Res a la Cazuela','Filete de Res en su  Jugo Horneado en Cazuela de Barro',73,106,25,39,94,93,42,0,0,0,0.200,0.025,0.050,0.010,0.009,0.009,0.009,0.000,0.000,0.000,170.00,14,1),
  (12,'Filete de Res al Gusto','',73,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,170.00,14,1),
  (13,'Milanesa de Filete','Milanesa de Filete Empanizada acompañada de Ensalada o Papas a la Francesa',73,45,38,106,259,0,0,0,0,0,0.200,0.020,0.060,0.020,0.030,0.000,0.000,0.000,0.000,0.000,150.00,14,1),
  (14,'Puntas de Filete a la Mexicana','',73,2,10,107,1,12,93,94,41,0,0.200,0.025,0.030,0.025,0.060,0.005,0.009,0.009,0.003,0.000,150.00,14,1),
  (15,'Puntas de Filete al Gusto','',73,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,150.00,14,1),
  (16,'Pechuga Asada','Pechuga de Pollo Aplanada y Asada',74,106,41,0,0,0,0,0,0,0,0.250,0.025,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,100.00,16,1),
  (17,'Pechuga Empanizada','Pechuga de Pollo Aplanada y Empanizada Acompañada de Ensalada o Papas a la Francesa',74,45,259,38,106,42,0,0,0,0,0.250,0.020,0.030,0.060,0.025,0.005,0.000,0.000,0.000,0.000,100.00,16,1),
  (18,'Cecina Enchilada','Cecina Frita Acompañada de Guacamole, Crema y Frijoles',75,106,0,0,0,0,0,0,0,0,0.200,0.025,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,100.00,14,1),
  (19,'Top Sirloin','Sirloin Asado Acompañado de Ensalada o Papas a la Francesa',76,106,0,0,0,0,0,0,0,0,0.250,0.003,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,120.00,14,1),
  (20,'T-Bone','A la Plancha Acompañado de Ensalada o Papas a la Francesa',77,106,0,0,0,0,0,0,0,0,0.250,0.003,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,120.00,14,1),
  (21,'Arrachera','A la Plancha Acompañada de Ensalada o Papas a la Francesa',78,106,0,0,0,0,0,0,0,0,0.250,0.003,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,140.00,14,1),
  (22,'Ensalada Mixta','',90,18,1,2,4,0,0,0,0,0,0.050,0.050,0.030,0.025,0.030,0.000,0.000,0.000,0.000,0.000,40.00,26,1),
  (23,'Ensalada de Pepino','',26,14,42,0,0,0,0,0,0,0,0.200,0.020,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,26,1),
  (24,'Ensalada de Jitomate','',1,2,42,14,0,0,0,0,0,0,0.090,0.025,0.003,0.020,0.000,0.000,0.000,0.000,0.000,0.000,40.00,26,1),
  (25,'Ensalada Cesar','',260,107,38,11,94,93,261,262,0,0,0.100,0.075,0.060,0.005,0.009,0.009,0.010,0.025,0.000,0.000,70.00,26,1),
  (26,'Riñonada de Cabrito','Pieza de Cabrito Acompañada de Guacamole y Frijoles',263,11,41,12,113,106,0,0,0,0,0.760,0.050,0.050,0.001,0.400,0.200,0.000,0.000,0.000,0.000,180.00,23,1),
  (27,'Espaldilla de Cabrito','Pieza de Cabrito Acompañada de Guacamole y Frijoles',264,11,41,12,113,106,0,0,0,0,0.760,0.050,0.050,0.001,0.400,0.200,0.000,0.000,0.000,0.000,180.00,23,1),
  (28,'Pierna de Cabrito','Pieza de Cabrito Acompañada de Guacamole y Frijoles',265,11,41,12,113,106,0,0,0,0,0.760,0.050,0.050,0.001,0.400,0.200,0.000,0.000,0.000,0.000,180.00,23,1),
  (29,'Almeja Viva','20 Conchas Acompañadas de Salsa y Galleta Salada',81,0,0,0,0,0,0,0,0,0,0.900,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,175.00,23,1),
  (30,'Almejas a la Plancha','20 Conchas Acompañadas de Salsa y Galletas',81,39,94,11,42,0,0,0,0,0,0.900,0.100,0.009,0.015,0.005,0.000,0.000,0.000,0.000,0.000,200.00,23,1),
  (31,'Almejas Rockefeller','20 COnchas Acompañadas de Salsa y Galletas',81,39,17,33,11,42,94,0,0,0,0.900,0.100,0.050,0.200,0.005,0.005,0.009,0.000,0.000,0.000,240.00,23,1),
  (32,'Huachinango a la Plancha','',82,39,0,0,0,0,0,0,0,0,1.000,0.100,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,240.00,17,1),
  (33,'Camaron Gigante a la Plancha','',83,39,0,0,0,0,0,0,0,0,0.350,0.100,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,240.00,17,1),
  (34,'Cmaron Grande al Mojo de Ajo','',83,39,11,0,0,0,0,0,0,0,0.350,0.100,0.010,0.000,0.000,0.000,0.000,0.000,0.000,0.000,240.00,17,1),
  (35,'Camaron al Ajillo','',83,107,11,28,0,0,0,0,0,0,0.350,0.030,0.005,0.005,0.000,0.000,0.000,0.000,0.000,0.000,240.00,17,1),
  (36,'Camarón a la Diabla','',83,44,106,11,0,0,0,0,0,0,0.350,0.050,0.010,0.005,0.000,0.000,0.000,0.000,0.000,0.000,240.00,17,1),
  (37,'Cocktail de Camarón','',84,2,10,1,22,11,94,93,107,51,0.200,0.025,0.015,0.100,0.010,0.040,0.009,0.009,0.009,0.027,90.00,17,1),
  (38,'Camarón a la Poblana','',84,107,2,9,11,0,0,0,0,0,0.200,0.015,0.050,0.040,0.010,0.000,0.000,0.000,0.000,0.000,100.00,17,1),
  (39,'Alambre Mar y Tierra','Combinación de Filete y Camarón',84,73,2,19,25,36,94,42,0,0,0.150,0.150,0.050,0.050,0.015,0.030,0.009,0.005,0.000,0.000,240.00,17,1),
  (40,'Ceviche de Sierra','',85,2,1,10,22,107,14,42,0,0,0.200,0.018,0.100,0.015,0.010,0.015,0.100,0.001,0.000,0.000,50.00,17,1),
  (41,'Filete de Pescado a la Plancha','',79,39,42,0,0,0,0,0,0,0,0.180,0.050,0.005,0.000,0.000,0.000,0.000,0.000,0.000,0.000,100.00,17,1),
  (42,'Pepito','Acompañada de Papas a la Francesa',73,4,1,2,3,0,0,0,0,0,0.100,0.025,0.100,0.100,0.150,0.000,0.000,0.000,0.000,0.000,70.00,19,1),
  (43,'Torta de Pierna','Acompañada de Papas a la Francesa',72,4,1,2,3,0,0,0,0,0,0.100,0.025,0.010,0.010,0.150,0.000,0.000,0.000,0.000,0.000,50.00,19,1),
  (44,'Torta de Chorizo','Acompañada de Papas a la Francesa',35,4,1,2,3,0,0,0,0,0,0.100,0.025,0.010,0.010,0.150,0.000,0.000,0.000,0.000,0.000,50.00,19,1),
  (45,'Torta de Pechuga','Acompañada de Papas a la Francesa',74,4,1,2,3,0,0,0,0,0,0.100,0.025,0.010,0.010,0.150,0.000,0.000,0.000,0.000,0.000,50.00,19,1),
  (46,'Torta de Huevo con Chorizo','Acompañada de Papas a la Francesa',38,35,4,1,2,3,0,0,0,0,0.030,0.100,0.025,0.010,0.010,0.150,0.000,0.000,0.000,0.000,50.00,19,1),
  (47,'Torta de Milanesa','',73,259,45,38,4,1,2,0,0,0,0.100,0.050,0.010,0.030,0.025,0.010,0.010,0.000,0.000,0.000,50.00,19,1),
  (48,'Torta de Queso','Acompañada de Papas a la Francesa',34,4,1,2,3,0,0,0,0,0,0.100,0.025,0.010,0.010,0.150,0.000,0.000,0.000,0.000,0.000,50.00,19,1),
  (49,'Sopa de Botana','',266,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,22,0),
  (50,'Tacos','',267,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,22,0),
  (51,'Quesadillas','',268,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,22,0),
  (52,'Guisado','',269,0,0,0,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,22,0),
  (53,'Quesadillas de Queso','Tres Quesadillas Fritas',86,33,0,0,0,0,0,0,0,0,0.030,0.090,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,18,1),
  (54,'Duraznos en Almibar','',49,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,35.00,21,1),
  (55,'Chongos Zamoranos','',48,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,35.00,21,1),
  (56,'Ate con Queso','',50,33,0,0,0,0,0,0,0,0,0.100,0.120,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,35.00,21,1),
  (57,'Helado','2 Bolas de Helado',290,0,0,0,0,0,0,0,0,0,0.100,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,21,1),
  (58,'Ate Flameado','Flameado con Brandy Presidente o Amaretto H.V.',50,33,184,0,0,0,0,0,0,0,0.100,0.120,0.045,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,21,1),
  (59,'Aceitunas Preparadas','',46,94,93,95,285,0,0,0,0,0,0.100,0.009,0.009,0.009,0.009,0.000,0.000,0.000,0.000,0.000,30.00,18,1),
  (60,'Botanas','Botanas',266,268,267,269,0,0,0,0,0,0,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,22,1),
  (61,'Queso Extra','',33,0,0,0,0,0,0,0,0,0,0.150,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,20,1),
  (62,'Huevos al Gusto','',38,0,0,0,0,0,0,0,0,0,0.120,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,45.00,20,1),
  (63,'Torta con Queso','',72,33,0,0,0,0,0,0,0,0,0.200,0.050,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,19,1),
  (64,'Camaron Empanizado','',83,45,259,290,0,0,0,0,0,0,0.350,0.050,0.050,0.060,0.000,0.000,0.000,0.000,0.000,0.000,240.00,17,1),
  (65,'Filete de Pescado al Gusto','',79,0,0,0,0,0,0,0,0,0,0.250,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,120.00,17,1),
  (66,'Queso Fundido','',33,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,90.00,18,1),
  (67,'Papas a la Francesa','',3,106,0,0,0,0,0,0,0,0,0.200,0.008,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,20,1),
  (68,'Orden de Queso','',33,0,0,0,0,0,0,0,0,0,0.200,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,90.00,18,1),
  (69,'Guisado Extra','',73,106,1,0,0,0,0,0,0,0,0.100,0.005,0.030,0.000,0.000,0.000,0.000,0.000,0.000,0.000,50.00,20,1),
  (70,'Frijoles con Chorizo','',54,35,0,0,0,0,0,0,0,0,0.050,0.050,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,40.00,20,1),
  (71,'Orden de Aguacate','',4,0,0,0,0,0,0,0,0,0,0.100,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,30.00,20,1),
  (72,'Orden de Guacamole','',4,2,10,42,0,0,0,0,0,0,0.100,0.010,0.005,0.005,0.000,0.000,0.000,0.000,0.000,0.000,40.00,20,1),
  (73,'Tacos de Camaron','',87,84,0,0,0,0,0,0,0,0,0.030,0.050,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,60.00,20,1),
  (74,'SINCRONIZADAS DE PIERNA','',87,72,33,0,0,0,0,0,0,0,4.000,0.100,0.100,0.000,0.000,0.000,0.000,0.000,0.000,0.000,70.00,18,1),
  (75,'Flan Napolitano','',89,0,0,0,0,0,0,0,0,0,0.100,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.000,35.00,21,1),
  (76,'ESCAMOLES','',299,23,106,0,0,0,0,0,0,0,0.200,0.050,0.025,0.000,0.000,0.000,0.000,0.000,0.000,0.000,300.00,23,1),
  (77,'Gusanos de Maguey','',299,23,106,0,0,0,0,0,0,0,0.200,0.050,0.025,0.000,0.000,0.000,0.000,0.000,0.000,0.000,300.00,23,1),
  (78,'Pecho de Ternera','',314,6,3,21,2,106,0,0,0,0,0.250,0.050,0.050,0.100,0.100,0.010,0.000,0.000,0.000,0.000,150.00,23,1);

COMMIT;

