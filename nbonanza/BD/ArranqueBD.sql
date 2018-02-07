# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : nretono


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `nretono`;

CREATE DATABASE `nretono`;

USE `nretono`;

#
# Structure for the `aval_por_documento` table : 
#

DROP TABLE IF EXISTS `aval_por_documento`;

CREATE TABLE `aval_por_documento` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` int(6) default NULL,
  `ConsecutivoRecepcion` int(6) unsigned default NULL,
  `Adquisicion` int(1) default '1',
  `Tipo` int(1) default NULL,
  `Cantidad` double(10,3) default NULL,
  `DocAval` varchar(11) collate latin1_spanish_ci default NULL,
  `TipoDocAval` int(1) default NULL,
  `FechaDocAval` date default NULL,
  `Estatus` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `avisos` table : 
#

DROP TABLE IF EXISTS `avisos`;

CREATE TABLE `avisos` (
  `automatico` int(6) NOT NULL auto_increment,
  `frase` varchar(200) collate latin1_spanish_ci default NULL,
  `activo` int(1) default '0',
  PRIMARY KEY  (`automatico`),
  UNIQUE KEY `automatico` (`automatico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `cancelacion` table : 
#

DROP TABLE IF EXISTS `cancelacion`;

CREATE TABLE `cancelacion` (
  `claveCancela` int(10) NOT NULL auto_increment,
  `numTicket` int(10) NOT NULL default '0',
  `fechaTicket` date default NULL,
  `tipoTicket` int(1) unsigned default NULL,
  `cajeroTicket` varchar(20) collate latin1_spanish_ci default NULL,
  `montoTotal` double(8,2) default NULL,
  `fechaBaja` date default NULL,
  `horaBaja` time default NULL,
  PRIMARY KEY  (`claveCancela`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `rfc` varchar(13) collate latin1_spanish_ci NOT NULL default '',
  `curp` varchar(20) collate latin1_spanish_ci NOT NULL default '',
  `nombre` varchar(45) collate latin1_spanish_ci NOT NULL default '',
  `direccion` varchar(35) collate latin1_spanish_ci NOT NULL default '',
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(20) collate latin1_spanish_ci default NULL,
  `contacto` varchar(40) collate latin1_spanish_ci default NULL,
  `tel1` varchar(12) collate latin1_spanish_ci default NULL,
  `tel2` varchar(12) collate latin1_spanish_ci default NULL,
  `alta` date default NULL,
  `tipoCliente` int(1) NOT NULL default '0',
  `credito` double(8,2) default NULL,
  `tiempoCredito` int(2) default '0',
  `saldo` double(8,2) default NULL,
  `bloqueoXPagoV` int(1) default '0',
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `codigosb` table : 
#

DROP TABLE IF EXISTS `codigosb`;

CREATE TABLE `codigosb` (
  `ID_Pro` int(6) default NULL,
  `codBarra` varchar(15) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `contenidoticket` table : 
#

DROP TABLE IF EXISTS `contenidoticket`;

CREATE TABLE `contenidoticket` (
  `numTicket` int(10) NOT NULL default '0',
  `fechaRegistro` date NOT NULL default '0000-00-00',
  `horaRegistro` time default NULL,
  `ID_Pro` int(6) NOT NULL default '0',
  `claveVendedor` int(4) NOT NULL default '0',
  `tipoVenta` int(1) NOT NULL default '0',
  `tipoPrecio` int(1) default NULL,
  `precioVenta` double(8,2) NOT NULL default '0.00',
  `cantidadProducto` double(8,3) default NULL,
  `pesoEnPz` double(8,3) default NULL,
  `estatusPago` int(1) default '0',
  `precioAPagar` double(8,2) NOT NULL default '0.00',
  `estatusTicket` int(1) default '0',
  `fechaRealPago` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 129024 kB';

#
# Structure for the `creditos` table : 
#

DROP TABLE IF EXISTS `creditos`;

CREATE TABLE `creditos` (
  `numTicket` int(10) NOT NULL default '0',
  `fechaCredito` date default NULL,
  `fechaAPagar` date default NULL,
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombreCliente` varchar(45) collate latin1_spanish_ci default NULL,
  `cantidadAPagar` double(8,2) default NULL,
  `factura` int(1) default NULL,
  `tipoCobro` int(1) default NULL,
  `referenciaCobro` varchar(40) collate latin1_spanish_ci default NULL,
  `usuario` varchar(20) collate latin1_spanish_ci default NULL,
  `fechaRealPago` date default NULL,
  `usuarioPago` varchar(20) collate latin1_spanish_ci default NULL,
  `estatusCredito` int(1) default '0',
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `facturas` table : 
#

DROP TABLE IF EXISTS `facturas`;

CREATE TABLE `facturas` (
  `claveOrden` int(8) default NULL,
  `docAval` varchar(11) collate latin1_spanish_ci default NULL,
  `tipoDoc` int(1) default NULL,
  `docPadre` varchar(11) collate latin1_spanish_ci default NULL,
  `fechaDoc` date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `facventas` table : 
#

DROP TABLE IF EXISTS `facventas`;

CREATE TABLE `facventas` (
  `numFactura` varchar(12) collate latin1_spanish_ci default NULL,
  `tickets` varchar(40) collate latin1_spanish_ci default NULL,
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombre` varchar(45) collate latin1_spanish_ci default NULL,
  `fechaFac` date default NULL,
  `fechaCrea` date default NULL,
  `tasa0` double(8,2) default NULL,
  `tasa15` double(8,2) default NULL,
  `iva` double(8,2) default NULL,
  `total` double(8,2) default NULL,
  `estatus` int(1) default NULL,
  `cantXFac` int(2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mermas` table : 
#

DROP TABLE IF EXISTS `mermas`;

CREATE TABLE `mermas` (
  `ID_Pro` int(6) default NULL,
  `usuario` varchar(8) default NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `descuenta` double(8,3) default NULL,
  `cantidadOriginal` double(8,3) default NULL,
  `nuevaCantidad` double(8,3) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `modificainv` table : 
#

DROP TABLE IF EXISTS `modificainv`;

CREATE TABLE `modificainv` (
  `ID_Modifica` int(8) NOT NULL auto_increment,
  `ID_Pro` int(6) default NULL,
  `claveUsuario` varchar(8) default NULL,
  `fecha` date default NULL,
  `hora` time default NULL,
  `cantidadOriginal` double(10,3) default NULL,
  `nuevaCantidad` double(10,3) default NULL,
  `tipo` int(1) default NULL,
  PRIMARY KEY  (`ID_Modifica`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#
# Structure for the `orden_compra` table : 
#

DROP TABLE IF EXISTS `orden_compra`;

CREATE TABLE `orden_compra` (
  `claveOrden` int(11) NOT NULL auto_increment,
  `claveProveedor` varchar(13) collate latin1_spanish_ci default NULL,
  `fechaRegistro` date default NULL,
  `fechaEntrega` date default NULL,
  `fechaPago` date default NULL,
  `observaciones` varchar(250) collate latin1_spanish_ci default NULL,
  `descuento1` double(4,2) default NULL,
  `descuento2` double(4,2) default NULL,
  `descuento3` double(4,2) default NULL,
  `subtotal` double(8,2) default NULL,
  `descuento` double(8,2) default NULL,
  `iva` double(8,2) default NULL,
  `total` double(8,2) default NULL,
  `activo` int(1) default NULL,
  `docAval` varchar(11) collate latin1_spanish_ci default NULL,
  `entrega` int(1) default NULL,
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
  `claveOrden` int(8) default NULL,
  `claveProveedor` varchar(13) collate latin1_spanish_ci default NULL,
  `fechaPago` date default NULL,
  `monto` double(8,2) default NULL,
  `formaPago` int(1) default NULL,
  `numeroCheque` varchar(12) collate latin1_spanish_ci default NULL,
  `bancoCuenta` int(1) default NULL,
  `activo` int(1) default NULL,
  `usuario` varchar(8) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (`consecutivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `pescalonados` table : 
#

DROP TABLE IF EXISTS `pescalonados`;

CREATE TABLE `pescalonados` (
  `ID_Pro` int(6) NOT NULL default '0',
  `ca_peEscalon` int(6) default '0',
  `campoPrecio` double(8,2) default '0.00',
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `precio_anterior_producto` table : 
#

DROP TABLE IF EXISTS `precio_anterior_producto`;

CREATE TABLE `precio_anterior_producto` (
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `tipoProducto` int(1) default NULL,
  `claveOrden` int(11) default NULL,
  `precioAnterior` double(8,2) default NULL,
  `precioCompra` double(8,2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos` table : 
#

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `ID_Pro` int(6) NOT NULL auto_increment,
  `descripcion` varchar(35) collate latin1_spanish_ci default NULL,
  `tipoPro` int(1) default NULL,
  `gravaIVA` int(1) default '0',
  `genero` int(1) default NULL,
  `id_prov1` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov2` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov3` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov4` varchar(13) collate latin1_spanish_ci default NULL,
  `id_prov5` varchar(13) collate latin1_spanish_ci default NULL,
  `uniCompra` int(1) default NULL,
  `precioUniCompra` double(8,2) default NULL,
  `preCaCompra` double(8,2) default NULL,
  `cantidadXCaja` int(4) default NULL,
  `precioUnidadKG` double(8,2) default NULL,
  `kgXUnidad` double(8,2) default NULL,
  `tipoPrecio` int(1) default NULL,
  `manejoPrecio` int(1) default NULL,
  `precioBase1` double(8,2) NOT NULL default '0.00',
  `precioBase1Caja` double(8,2) NOT NULL default '0.00',
  `precioG1` double(8,2) default '0.00',
  `precioG1Caja` double(8,2) default '0.00',
  `precioG2` double(8,2) default '0.00',
  `precioG2Caja` double(8,2) default '0.00',
  `precioG3` double(8,2) default '0.00',
  `precioG3Caja` double(8,2) default '0.00',
  `precioG4` double(8,2) default '0.00',
  `precioG4Caja` double(8,2) default '0.00',
  `precioG5` double(8,2) default '0.00',
  `precioG5Caja` double(8,2) default '0.00',
  `precioG6` double(8,2) default '0.00',
  `precioG6Caja` double(8,2) default '0.00',
  `maxInv` double(8,3) default NULL,
  `minInv` double(8,3) default NULL,
  `existencia` double(10,3) default '0.000',
  `activo` int(1) default '1',
  PRIMARY KEY  (`ID_Pro`),
  UNIQUE KEY `ID_Pro` (`ID_Pro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos_orden` table : 
#

DROP TABLE IF EXISTS `productos_orden`;

CREATE TABLE `productos_orden` (
  `ClaveOrden` int(11) default NULL,
  `ClaveProducto` int(6) default NULL,
  `Cantidad` double(10,3) default NULL,
  `Tipo` int(1) default NULL,
  `Costo` double(8,2) default NULL,
  `Importe` double(8,2) default NULL,
  `Llegan` double(10,3) default NULL,
  `Adquisicion` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `proveedores` table : 
#

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `rfc` varchar(13) collate latin1_spanish_ci default NULL,
  `nombre` varchar(80) collate latin1_spanish_ci default NULL,
  `direccion` varchar(50) collate latin1_spanish_ci default NULL,
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(30) collate latin1_spanish_ci default NULL,
  `tel1` varchar(20) collate latin1_spanish_ci default NULL,
  `tel2` varchar(20) collate latin1_spanish_ci default NULL,
  `fax` varchar(20) collate latin1_spanish_ci default NULL,
  `pagina` varchar(75) collate latin1_spanish_ci default NULL,
  `email` varchar(80) collate latin1_spanish_ci default NULL,
  `vendedor` varchar(50) collate latin1_spanish_ci default NULL,
  `formaPago` int(1) default NULL,
  `cuentas` text collate latin1_spanish_ci,
  `IDcredito` int(1) default '1',
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
# Structure for the `salidas` table : 
#

DROP TABLE IF EXISTS `salidas`;

CREATE TABLE `salidas` (
  `numTicket` int(10) NOT NULL default '0',
  `fechaVenta` date NOT NULL default '0000-00-00',
  `horaVenta` time default NULL,
  `sumaVenta` double(8,2) default '0.00',
  `factura` int(1) default '0',
  `tipoCobro` int(1) default NULL,
  `referenciaCobro` varchar(40) collate latin1_spanish_ci default NULL,
  `usuario` varchar(20) collate latin1_spanish_ci default NULL,
  `activo` int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='InnoDB free: 129024 kB';

#
# Structure for the `usuario` table : 
#

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `USUARIO_ID` varchar(8) collate latin1_spanish_ci NOT NULL default '',
  `PASSWORD` varchar(8) collate latin1_spanish_ci default NULL,
  `TIPO` varchar(15) collate latin1_spanish_ci default NULL,
  `NombreE` varchar(50) collate latin1_spanish_ci default NULL,
  `claveVenta` int(6) NOT NULL auto_increment,
  `clavePermiso` int(4) default NULL,
  `permisoCobro` int(1) unsigned default '0',
  `estatus` int(1) default '1',
  UNIQUE KEY `claveVenta` (`claveVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `vendedores` table : 
#

DROP TABLE IF EXISTS `vendedores`;

CREATE TABLE `vendedores` (
  `claveVenta` int(4) NOT NULL auto_increment,
  `NombreE` varchar(50) collate latin1_spanish_ci default NULL,
  `clavePermiso` int(4) default NULL,
  `permisoCobro` int(1) unsigned default '0',
  `estatus` int(1) default '1',
  PRIMARY KEY  (`claveVenta`),
  UNIQUE KEY `claveVenta` (`claveVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Data for the `vendedores` table  (LIMIT 0,500)
#

# claveVenta:3:49671
# NombreE:253:0
# clavePermiso:3:32768
# permisoCobro:3:32800
# estatus:3:32768

INSERT INTO `vendedores` (`claveVenta`, `NombreE`, `clavePermiso`, `permisoCobro`, `estatus`) VALUES 
  (1,'Enrique Fernandez Jaimes',1234,1,1),
  (2,'Sofia Gabian Dominguez',1234,0,1),
  (3,'Adalberto Martínez Rojas',0,0,1),
  (4,'Jorge Pimentel Aguayo',505,1,1),
  (5,'Arturo Días Ordanza',34,1,0),
  (6,'rosalba cano pozos',1000,1,1),
  (7,'candelario  ramirez  pozos',202,1,1),
  (8,'Erick  daniel ramirez  Hernandez',0,0,1);

COMMIT;

#
# Data for the `usuario` table  (LIMIT 0,500)
#

# USUARIO_ID:253:1
# PASSWORD:253:0
# TIPO:253:0
# NombreE:253:0
# claveVenta:3:49667
# clavePermiso:3:32768
# permisoCobro:3:32800
# estatus:3:32768

INSERT INTO `usuario` (`USUARIO_ID`, `PASSWORD`, `TIPO`, `NombreE`, `claveVenta`, `clavePermiso`, `permisoCobro`, `estatus`) VALUES 
  ('Super','super','administrador','Administrador',1,2005,0,1),
  ('Factura','factura','simple','Facturacion',2,1738,0,1),
  ('Caja','caja','simple','Caja',3,0,0,1);

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
# IDcredito:3:32768
# credito:5:32768
# diasPago:3:32768
# descuento1:5:32768
# descuento2:5:32768
# descuento3:5:32768
# saldoDisponible:5:32768
# alta:10:128
# activo:3:32768

INSERT INTO `proveedores` (`rfc`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tel1`, `tel2`, `fax`, `pagina`, `email`, `vendedor`, `formaPago`, `cuentas`, `IDcredito`, `credito`, `diasPago`, `descuento1`, `descuento2`, `descuento3`, `saldoDisponible`, `alta`, `activo`) VALUES 
  ('MAL990429SE5','MONTEBLANCO ALIMENTOS S.A. DE C.V.','FEBRERO 1917 No. 32','PARQUE INDUSTRIAL','CHALCO','56600','ESTADO DE MEXICO','59732222','','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('SJM880607FU8','SALCHICHA Y JAMONES DE MEXICO S.A. DE C.V.','GUILLERMO GONZALEZ CAMARENA No. 28','FRAC. IND. CUAMATLA','CUAUTITLAN IZCALLI','54730','ESTADO DE MEXICO','10831083','','1083-1070','','info@saljamex.com','GOMEZ BRENDA',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('SCT8411179Q4','SOCIEDAD COOPERATIVA TRABAJADORES DE PASCUAL S.C.L.','CLAVIJERO No. 75','TRANSITO','CUAUHTEMOC','06820','MEXICO D.F.','51320830','57410859','57408941','','','',2,'',1,0.00,8,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('CPA051124K21','COMALA PRODUCTOS ALIMENTICIOS S.A. DE C.V.','CENTENO No. 132','GRANJAS ESMERALDA','IZTAPALAPA','09810','MEXICO D.F.','54459197','54459198','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('COGI720102GZ9','CORTES GARCIA IVAN SAUL','CRUJIA J-5 LOCAL 87 NAVE 405 PASILLO 4 Y 5','CENTRAL DE ABASTO','IZTAPALAPA','09040','MEXICO D.F.','56941066','','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('DAL040721KQ7','DSSA ALIMENTOS S.A. DE C.V.','ZONA V SECTOR 2 CRUJIA 2 LOCAL 200 CEDA','EJIDOS DEL MORAL','IZTAPALAPA','09040','MEXICO D.F.','56949489','','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('.','HERMANOS CASTRO','','','','','','.','','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',0),
  ('A','AHUMADOS FINOS LA MONTAÑESA S.A DE C.V.','MIGUEL NEGRETE No. 4','NIÑOS HEROES','','03440','MEXICO D.F.','56961111','55791900','','','','',2,'',1,0.00,0,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('SAB960412CK7','SABORIMEX S.A. DE C.V.','CONVENTO DE ACOLMAN No, 90','JARDINES DE SANTA MONICA','TLALNEPANTLA','54050','ESTADO DE MEXICO','53610863','53615881','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('ERI0202067M0','EMPACADORA RION S.A DE C.V','GRAL.  NICOLAS BRAVO No. 30','TEPALCATES','IZTAPALAPA','09210','MEXICO D.F.','57639938','57639928','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('VAPB730831UM9','VAZQUEZ PEREZ BEATRIZ','CALLE 8 No. 4404-4','AGUILERA','','02900','MEXICO D.F.','13243814','13243815','','','','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('LSF050118U75','LACTEOS SAN FRANCISCO DE ASIS S. DE R. L. DE C V.','ZONA 1 SECCION 1 NAVE 1 BODEGA  G-03','CENTRAL DE ABASTO','IZTAPALAPA','09040','MEXICO D.F.','56940860','56942235','','','fjcg_81@hotmail.com','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('CVE9501177P3','CREMERIA VENECIA S.A DE C.V','11 DE AGOSTO DE AGOSTO  DE 1859 MZ 143 LOTE 1572','LEYE DE REFORMA','IZTAPALAPA','09310','MEXICO D.F.','56003227','','56003220','','cremvem@prodigy.net.mx','',2,'',1,0.00,20,0.00,0.00,0.00,0.00,'2007-03-12',1),
  ('PNE860402GL2','PRODUCTOS NEZA S.A. DE C.V.','MONTE ALTO MANZANA 7 LOTE 21 Y 23','PARQUE IND.CD NEZA','NEZAHUALCOTL','57810','EDO. MEX.','51132559','','','','','JUAN',2,'',1,10000.00,8,2.00,0.00,0.00,10000.00,'2007-03-21',1),
  ('PRL8602136M3','PRODUCTOS LACTEOS RAFA SA DE CV','LAZARO CARDENAS No150','CENTRO','PUREPERO','58760','MIHOACAN','01-(471)-36-6-04-30','','','','','',2,'',1,25000.00,30,0.00,0.00,0.00,25000.00,'2007-04-11',1),
  ('DMA0106263S9','DISTRIBUIDORA MARGA SA  DE  CV','ZONA 1 SECC.1 NAVE 1  BODEGA  G-15','CENTRAL DE ABASTO','IZTAPALAPA','09040','MEXICO D.F.','56-00-40-98','56-94-06-47','','','','MODESTO',2,'',1,150000.00,60,0.00,0.00,0.00,150000.00,'2007-04-11',1),
  ('AMO930202EQ6','ABARROTES  MONARCA  SA DE  CV','BODEGA H-50-B','ACULCO','IZTAPALAPA','09410','MEXICO, D.F.','56-00-59-85','56-00-64-84','','','','',2,'',1,250000.00,60,0.00,0.00,0.00,250000.00,'2007-04-11',1),
  ('QAO680613E91','QUALTIA  ALIMENTOS OPERACIONES S DE R.L DE C.V.','AV. CONDUCTORES No 600','LAGRANGE','SN NICOLAS D LA GARZ','66490','NUEVO LEON','57-00-00-60','8305-00-00','','','','',2,'',1,25000.00,30,0.00,0.00,0.00,25000.00,'2007-04-11',1),
  ('TBM9209297G9','TOSTADAS BORIS DE MEXICO SA DE CV','EMILIANO  ZAPATA   No1','AMPLIACION EMI. ZAPATA','AYOTLA','','ESTADO DE MEXICO','59-74-50-61','','59-76-63-22','','','',2,'',1,10000.00,90,0.00,0.00,0.00,10000.00,'2007-04-11',1),
  ('ROGR661008P89','ROJAS  GONZALEZ  MARIA DEL  ROSARIO','ZONA V SECTOR 2 LOCAL 107-A','CENTRAL DE ABASTO','IZTAPALAPA','09040','MEXICO  D.F.','56-94-21-34','56-48-15-25','','','','',2,'',1,30000.00,30,0.00,0.00,0.00,30000.00,'2007-04-12',1),
  ('YAK800303JA7','YAKULT SA  DE CV','AV. DIVICION DEL NORTE No 1419','STA. CRUZ ATOYAC','BENITO  JUAREZ','03310','','56-00-56-07','50-00-14-00','','','','ANGEL  NEGRETE',2,'',0,0.00,0,0.00,0.00,0.00,0.00,'2007-04-12',1),
  ('MAB0511152H6','MABEFRUT  SA  DE CV','PUERTO OPORTO  64 C-D  ED-12','PUEBLO SAN JUAN DE ARAGN','GUSTAVO A. MADERO','07950','MEXICO  D.F.','56','','','','','GERMAN  TREJO',2,'',1,50000.00,60,0.00,0.00,0.00,50000.00,'2007-04-12',1),
  ('CUBG660909S60','GORGONIO DE LA CRUZ  BAUTISTA','PASILLO 3 LOC.82 LETRA I-J CUJIA 3','CANTRAL DE ABASTO','IZTAPALAPA','09040','MEXICO D.F','56-00-70-40','56-94-70-59','56-00-26-07','','','',2,'',1,200000.00,90,0.00,0.00,0.00,200000.00,'2007-04-12',1),
  ('CME9109236F1','COTIJA MERCANTIL  SA  DE  CV','BODEGA G-83 ZONA1 SECTOR1','ZONA URBANA','IZTAPALAPA','09040','MEXICO D.F','56-94-30-66','56-94-14-48','56-94-63-16','','','',2,'',1,100000.00,30,0.00,0.00,0.00,100000.00,'2007-04-12',1),
  ('GPL860521FW8','GANADEROS PRODUCTORES DE LECHE PURA SA DE CV','KM.37.4 AUTOPISTA MEX-QRO','FRACC. IND. CUAMATLA','C. IZCALLI, EDO.DE M','54730','ESTADO DE MEXICO','53-99-80-11','','','WWW.ALPURA.COM','','',2,'',1,250000.00,60,0.00,0.00,0.00,250000.00,'2007-04-12',1),
  ('ROSJ630714AV0','J. VENTURA  ROMERO SANCHEZ','VILLA DIEZMA  MZ.35-B LT.3','DESARROLLO URBANO','','09700','MEXICO D.F.','54-28-53-47','54-28-14-01','','','','',2,'',1,25000.00,60,0.00,0.00,0.00,25000.00,'2007-04-12',1),
  ('FER961113AX1','FERD  SA  DE CV','VENUSTIANO CARRANZA MZ.78   LTE. 903','SANTA MARIA AZTAHUACAN','IZTAPALAPA','09500','MEXICO D.F.','56-92-48-91','56-93-55-84','','','','',2,'',1,50000.00,60,0.00,0.00,0.00,48557.00,'2007-04-12',1),
  ('JIVV690125DG7','VERONA JIMENEZ VILLASEÑOR','BODEGA B-22','CENTRAL DE ABASTO','IZTAPALAPA','09410','MEXICO D.F.','56-94-61-86','','','','','BERTHA VILLASEÑOR ALCAZAR',2,'',1,30000.00,60,0.00,0.00,0.00,30000.00,'2007-04-12',1),
  ('DLP9109119U6','DISTRIBUIDORA DE LACTEOS LA PAZ','AV. CARLOS HANK GONZALES  No 263','BOSQUES DE ARAGON','NEZAHUALCOYOTL','57170','ESTADO DE MEXICO','57-96-06-71','57-96-06-91','','','','ROBERTO',2,'',1,200000.00,60,0.00,0.00,0.00,200000.00,'2007-04-12',1),
  ('CBA871214MS6','COMERCIALIZADORA BAGRO SA  DE CV','BODEGA 96 ZONA1 SECTOR2 CRUJIA 2','CENTRAL DE ABASTOS','IZTAPALAPA','09040','MEXICO D.F.','56-0-75-33','56-94-23-92','','','','',2,'',1,50000.00,30,0.00,0.00,0.00,50000.00,'2007-04-12',1),
  ('GIOS481228V40','MARIA DE LA SALUD GIL  ORTIZ','AZAHAREZ No 135','JUAN GONZALEZ  ROMERO','GUZTAVO A. MADERO','07410','MEXICO D.F.','57-15-82-21','','57-15-89-61','','','ERNESTO FUENTES MORALES',2,'',1,100000.00,30,0.00,0.00,0.00,100000.00,'2007-04-13',1),
  ('MOSC5311115E7','JOSE CESAREO MOYA SOSA','SAN SEBASTIAN DEL SALITRE S/N','','SAN JOSE DE INTURBID','','GUANAJUATO','.','','','','','JUANA  MOYA  SOSA',2,'',1,60000.00,60,0.00,0.00,0.00,60000.00,'2007-04-13',1),
  ('REF060919EE8','REFREMEX   SA   DE CV','ACUEDUCTO EL ALTO 14-A','AMOMOLULCO','OCOYOACAC','52740','ESTADO DE MEXICO','.','','','','','',2,'',1,50000.00,30,0.00,0.00,0.00,50000.00,'2007-04-16',1),
  ('CLA8702224H20','COMERCIALIZADORA LACTICA SA  DE CV','DR. SOSA No 3302 NTE.','RESIDENCIAL VIDRIERA','','64520','MONTERREY','86-25-24-36','','','','','',2,'',1,25000.00,10,0.00,0.00,0.00,25000.00,'2007-04-18',1),
  ('NABR560603K10','NAVA BUTANDA   RICARDO','JUAN ALDANA  LT. 19 MZA.3','GUADALUPE DEL MORAL','IZTAPALAPA','09300','MEXICO D.F.','58-93-16-54','044-55-21-41-30-35','','','','',2,'',1,100000.00,60,0.00,0.00,0.00,100000.00,'2007-04-18',1),
  ('PUV570904PUG','PRODUCTOS DE UVA SA DE CV','ANTONIO M. RIVERA Mo 25','FRACC. IND. SAN NICOLAS','TLANEPANTLA','54030','ESTADO DE MEXICO','55-65-41-11','53-90-02-77','55-65-25-26','','','',2,'',1,200000.00,60,0.00,0.00,0.00,200000.00,'2007-04-18',1),
  ('CHF920528MB4','CARNES FRIAS LA HACIENDA SA DE CV','AV. MA. GUADALUPE MZ. 30 LT. 10','STA. CRUZ TECAMAC','.','55767','ESTADO DE  MEXICO','59-38-49-25','56-00-59-83','56-00-59-83','','','',2,'',1,30000.00,60,0.00,0.00,0.00,30000.00,'2007-04-18',1),
  ('EHC951010S36','EMBUTIDOS HERMANOS CASTRO SA DE CV','CALLE 10 No110','ESTADO DE MEXICO','NEZAHUALCOYOTL','57210','ESTADO DE MEXICO','57-35-69-07','57-35-71-57','','','','',2,'',1,50000.00,60,0.00,0.00,0.00,50000.00,'2007-04-18',1),
  ('ESA0010171E5','EMPACADORA SAN ANGEL SA  DE CV','15 DE JUNIO DE 1861  No 30','LEYES DE REFORMA','IZTAPALAPA','09310','MEXICO D.F.','36-16-69-80','36-16-69-81','56-40-42-99','','','',2,'',1,50000.00,60,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('CLD0507145H6','COMERCIALIZADORA DE LACTEOS Y DERIVADOS SA DE CV','LAZARO CARDENAS No185','PARQUE INDUSTRIAL LAGUNER','','35077','GOMEZ PALACIO DURANGO','01-871-7-50-01-01','58-04-61-55','','','','',2,'',1,50000.00,10,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('GAA970226DL8','GRUPO ABASTECEDOR DE ABARROTES SA DE CV','TAMEMES Mz2 Lt. 21','GUADALUPE DEL MORAL','IZTAPALAPA','09040','MEXICO D.F.','56-00-43-05','56-94-67-13','56-94-90-83','www.grupoabastecedor.com.mx','','LUIS',2,'',1,200000.00,60,0.00,0.00,0.00,200000.00,'2007-04-20',1),
  ('AIÑ911217SF4','ABASTECEDORA IÑAKI SA  DE CV','AV. CUAUHTEMOC OTE No5','TEPEYAHUALCO','TEPEYAHUALCO DE CUAU','75630','PUEBLA','55-54-57-07','','','','','EDITH   RIVERA',2,'',1,100000.00,30,0.00,0.00,0.00,100000.00,'2007-04-20',1),
  ('PAL860319A25','PALMASA SA DE CV','AV. PANAMERICANA No 90','CENTRO','PEDRO ESCOBEDO','76700','QUERETARO','56-94-11-21','56-94-26-29','56-94-95-46','','','SR. ALFONZO',2,'',1,50000.00,30,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('BAR011108CC6','BARCEL SA DE CV','CARR. MEXICO-TOLUCA KM. 54','INDUSTRIAL','LERMA','52000','ESTADO DE MEXICO','.','','','','','',2,'',1,50000.00,10,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('IMP961016B86','IMPROLAC SA  DE CV','MORELOS No23','CENTRO','VISTA HERM. DE NEGRE','','MICHOACAN','01-328-524-22-42','56-48-27-42','','','','',2,'',1,50000.00,60,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('CBE900712JI7','CADBURY BEBIDAS SA DE CV','BLVD. MANUEL AVILA CAMACHO No20 PISO 4 5 Y 10','LOMAS DE CHAPULTEPEC','MUIGEL HIDALGO','11000','MEXICO D.F.','52-49-90-00','01-800-223-28-79','','','','',2,'',1,150000.00,60,0.00,0.00,0.00,150000.00,'2007-04-20',1),
  ('CSA950831HZ9','CREMERIA EL SAUCITO SA DE CV','ADOLFO GURRION No90 ACC.6','MERCED BALBUENA','VENUSTIANO CARRANZA','','MEXICO D.F.','.','','','','','MARIO  FUENTES',2,'',1,50000.00,60,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('GAR851002HJ8','GELATINAS ART SA DE CV','CALLE DIEZ No 210','GRANJAS SAN ANTONIO','IZTAPALAPA','09070','MEXICO D.F.','56-70-02-66','','','','','',2,'',1,50000.00,90,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('GKM0601209Z0','GRUPO KOSAKO DE MEXICO SA DE CV','AV. BENJAMIN FRANKLIN No 231 PISO 1 NIVEL 2','HIPODROMO CONDESA','CUAUHTEMOC','06170','MEXICO D.F.','56-96-81-84','','56-96-55-83','','','',2,'',1,25000.00,90,0.00,0.00,0.00,25000.00,'2007-04-20',1),
  ('CEL470228G64','COMERCIALIZADORA ELORO SA','KM. 12.5 CARRETERA MEXICO- PACHUCA','RUSTICA XALOSTOC','','55340','ESTADO DE MEXICO','56-99-19-99','','55-69-26-21','www.jumex.com.mx','','',2,'',1,100000.00,90,0.00,0.00,0.00,100000.00,'2007-04-20',1),
  ('UNI9704247M2','UNIFOODS SA DE CV','PONIENTE 122 No 459','INDUSTRIAL VALLEJO','AZCAPOTZALCO','02300','MEXICO D.F.','53-33-12-00','','','','','',2,'',1,250000.00,60,0.00,3.00,4.00,250000.00,'2007-04-20',1),
  ('MAL880623MKA','MIREYA ALIMENTOS SA DE CV','APICULTURA No92','20 DE NOVIEMBRE','VENUSTIANO CARRANZA','15300','MEXICO, D.F.','57-89-36-75','','','','','',2,'',1,50000.00,90,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('AOR821025A25','ACIDOS ORGANICOS SA DE CV','CALZ. VALLEJO No1100 ESQ. PTE. 152','PRADO VALLEJO','TLANEPANTLA','54170','ESTADO DE MEXICO','55-87-21-22','','55-67-68-12','','','',2,'',1,10000.00,60,0.00,0.00,0.00,10000.00,'2007-04-20',1),
  ('APA850331PZ1','ALIMENTOS PAR SA DE CV','SIERRA  NEVADA No 6, 12 Y 14','PARQUE INDUSTRIAL','NEZAHUALCOYOTL','57800','ESTADO DE MEXICO','51-13-25-51','','','','','',2,'',1,50000.00,60,0.00,0.00,0.00,50000.00,'2007-04-20',1),
  ('PAL010828UR4','PROCESO DE ALIMENTOS LACTEOS SA DE CV','CALLE 16 DE SEPTIEMBRE No 48','BARRIO DE LA CONCHITA','CHALCO','56600','ESTADO DE MEXICO','59-75-38-29','','','','','',2,'',1,25000.00,60,0.00,0.00,0.00,25000.00,'2007-04-20',1),
  ('EPA950622S60','EMPACADORA LA PAZ SA  DE CV','CALLE IGNACIO MANUEL ALTAMIRANO No 50','MEXICO','NEZAHUALCOYOTL','','ESTADO DE MEXICO','57-92-45-98','','','','','',2,'',1,25000.00,60,0.00,0.00,0.00,25000.00,'2007-04-20',1),
  ('TDC970225L82','TIENDAS DE DESCUENTO DE LA CENTRAL SA DE CV','NAVE 1 BODEGA G-87','CENTRAL DE ABASTO','IZTAPALAPA','09410','MEXICO D.F.','56-94-16-54','56-94-60-76','','','','FELIPE',2,'',1,250000.00,60,0.00,0.00,0.00,250000.00,'2007-04-20',1),
  ('CSC880523NA1','CREMERIA Y SALCHICHONERIA CUADRITOS SA DE CV','PASILLO 2 NAVE G-H  LOCS. 110,110-A, 112, 114 Y116','CENTRAL DE ABASTO','IZTAPALAPA','09040','MEXICO D.F.','56-94-24-72','56-9430-94','56-94-00-01','www.cremeriacuadritos.com.mx','','MEMO RICAÑO',2,'',1,100000.00,30,0.00,0.00,0.00,100000.00,'2007-04-21',1),
  ('MDI950606EW7','MICRO DISTRIBUIDORA SA DE CV','H. CONGRESO DE LA UNION 6535','STA. COLETA','','07490','MEXICO D.F.','57-50-11-22','','55-77-35-40','','','',2,'',1,50000.00,60,0.00,0.00,0.00,50000.00,'2007-04-21',1),
  ('CCO820507BV4','CONSERVAS LA COSTEÑA SA DE CV','VIA MORELOS No 268','SANTA MARIA TULPETLAC','ECATEPEC','55400','ESTADO DE MEXICO','58-36-36-36','','58-36-36-08','','','',2,'',1,50000.00,30,0.00,0.00,0.00,50000.00,'2007-04-21',1),
  ('ROCJ','JOSEFINA ROSAS CARDENAS','BARRIO METEPEC PRIPERO','','ACATLAN','','HIDALGO','.','','','','','EL LOBITO',1,'',1,50000.00,30,0.00,0.00,0.00,50000.00,'2007-04-21',1),
  ('SAEH64114RMS','HILARIO SANCHEZ E.','CHAUTENCO','','ACATLAN','','HIDALGO','.','','','','','',1,'',1,50000.00,30,0.00,0.00,0.00,50000.00,'2007-04-21',1),
  ('ILS8803258L6','INDUSTRIALIZADORA DE LACTEOS SANTA ANITA SA DE CV','RAMON CORONA No679','','TLAJOMULCO DE ZUÑIGA','','JALISCO','33-36-86-05-43','','','','','',1,'',1,10000.00,30,0.00,0.00,0.00,10000.00,'2007-04-21',1),
  ('DLC050125K82','DISTRIBUIDORA DE LACTEOS DEL NORTE SA DE CV','AVE. GOMEZ MORIN No1111','CARRIZALEJO','SAN PEDRO GARZA GAR','66254','NUEVO LEON','55-79-79-00','01-81-87-48-90-99','01-81-87-48-90-75','','','ALFREDO',1,'',0,0.00,0,0.00,0.00,0.00,0.00,'2007-04-21',1),
  ('CAN710909PUA','CHANTILLY','CHICLE No266','GRANJAS MEXICO','IZTACALCO','08400','MEXICO D.F.','01-800-849-81-29','','','','','',1,'',0,0.00,0,0.00,0.00,0.00,0.00,'2007-04-21',1),
  ('MEAX5805181I3','SANDRA MENDEZ ALARCON','CHIHUAHUA 105','ROJO GOMEZ','TULANCINGO','43645','HIDALGO','.','','','','','',2,'',1,30000.00,0,0.00,0.00,0.00,30000.00,'2007-05-08',1),
  ('VAQUERO','PEDRO PEÑALOZA ESCORCIA','DOMICILIO CONOCIDO S/N','28 DE MAYO','ACATLAN','43540','HIDALGO','01 775 76-17-0-16','','','','','',2,'',1,10000.00,10,0.00,0.00,0.00,10000.00,'2007-05-08',1),
  ('VAM051215JV8','VALORES ALIMENTICIOS DE MEXICO','GUILLERMO GONZALEZ CAMARENA No. 35','PARQUE IND. CUAMATLA','CUAUTITLAN IZCALLI','54730','ESTADO DE MEXICO','(55) 36 40 51 20','(55) 36 40 51 21','(55) 36 40 51 39','','','',2,'',1,30000.00,20,0.00,0.00,0.00,30000.00,'2007-05-11',1),
  ('SANTA LUCIA','EMBUTIDOS FINOS MARCELLA SA DE CV','ALFREDO DEL MAZO MZ 10 LT 8','JOSEFA O DE DOMINGUEZ','ECATEPEC','55117','ESTADO DE MEXICO','24 59 06 19','','','','','',2,'',1,30000.00,20,0.00,0.00,0.00,30000.00,'2007-05-11',1),
  ('SOBA','DISTRIBUIDORA SOBA SA DE CV','AV INDUSTRIAL 808','LOS REYES IXTACALA','TLALNEPANTLA','.','ESTADO DE MEXICO','017 26 17','565 69 83','','','','',2,'',1,50000.00,30,0.00,0.00,0.00,50000.00,'2007-05-11',1),
  ('CAN970516RI6','COMERCIALIZADORA ANGULO SA DE CV','SASSO FERRATO 64','ALFONSO XIII','.','01460','MEXICO D.F.','56 11 71 34','','','','','',2,'',1,10000.00,20,0.00,0.00,0.00,10000.00,'2007-05-11',1),
  ('CCM810420IF2','CREMO CHANTY DE MEXICO SA DE CV','NORTE 180 No. 458','PENSADOR MEXICANO','.','15510','MEXICO D.F.','57 62 03 93','01 800 112 37 33','','','','',2,'',1,20000.00,20,0.00,0.00,0.00,20000.00,'2007-05-11',1),
  ('x','.','','','','','','.','','','','','',1,'',0,0.00,0,0.00,0.00,0.00,0.00,'2007-05-17',1),
  ('BIMBO','BIMBO','.','.','.','.','.','.','.','.','.','','',1,'',0,0.00,0,0.00,0.00,0.00,0.00,'2007-05-24',1);

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

# ID_Pro:3:49671
# descripcion:253:0
# tipoPro:3:32768
# gravaIVA:3:32768
# genero:3:32768
# id_prov1:253:0
# id_prov2:253:0
# id_prov3:253:0
# id_prov4:253:0
# id_prov5:253:0
# uniCompra:3:32768
# precioUniCompra:5:32768
# preCaCompra:5:32768
# cantidadXCaja:3:32768
# precioUnidadKG:5:32768
# kgXUnidad:5:32768
# tipoPrecio:3:32768
# manejoPrecio:3:32768
# precioBase1:5:32769
# precioBase1Caja:5:32769
# precioG1:5:32768
# precioG1Caja:5:32768
# precioG2:5:32768
# precioG2Caja:5:32768
# precioG3:5:32768
# precioG3Caja:5:32768
# precioG4:5:32768
# precioG4Caja:5:32768
# precioG5:5:32768
# precioG5Caja:5:32768
# precioG6:5:32768
# precioG6Caja:5:32768
# maxInv:5:32768
# minInv:5:32768
# existencia:5:32768
# activo:3:32768

INSERT INTO `productos` (`ID_Pro`, `descripcion`, `tipoPro`, `gravaIVA`, `genero`, `id_prov1`, `id_prov2`, `id_prov3`, `id_prov4`, `id_prov5`, `uniCompra`, `precioUniCompra`, `preCaCompra`, `cantidadXCaja`, `precioUnidadKG`, `kgXUnidad`, `tipoPrecio`, `manejoPrecio`, `precioBase1`, `precioBase1Caja`, `precioG1`, `precioG1Caja`, `precioG2`, `precioG2Caja`, `precioG3`, `precioG3Caja`, `precioG4`, `precioG4Caja`, `precioG5`, `precioG5Caja`, `precioG6`, `precioG6Caja`, `maxInv`, `minInv`, `existencia`, `activo`) VALUES 
  (1,'CREMA',1,0,1,'COGI720102GZ9','PRL8602136M3','CVE9501177P3','','',2,0.00,0.00,0,14.50,5.00,1,0,20.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,17.00,0.00,16.00,0.00,200.000,20.000,999976.960,1),
  (2,'QUESO OAXACA SAN PABLO',1,0,1,'MOSC5311115E7','','','','',2,0.00,0.00,0,51.00,4.00,1,0,60.00,0.00,58.00,0.00,55.00,0.00,53.00,0.00,53.00,0.00,52.00,0.00,52.00,0.00,200.000,100.000,99912.592,1),
  (3,'QUESO OAXACA SAN DIEGO',1,0,1,'ROCJ','','','','',2,0.00,0.00,0,51.00,4.00,1,0,60.00,0.00,58.00,0.00,55.00,0.00,54.00,0.00,53.00,0.00,52.00,0.00,52.00,0.00,150.000,100.000,99984.760,1),
  (4,'QUESO OAXACA CHINOS',1,0,1,'MEAX5805181I3','','','','',2,0.00,0.00,0,51.00,4.00,1,0,60.00,0.00,58.00,0.00,55.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,52.00,0.00,40.000,10.000,99906.672,1),
  (5,'QUESO RAYADO DELICIAS',1,0,1,'MEAX5805181I3','GIC960719217','','','',2,0.00,0.00,0,17.00,5.00,1,0,22.00,0.00,21.00,0.00,20.00,0.00,19.50,0.00,19.00,0.00,18.00,0.00,18.00,0.00,100.000,50.000,999914.000,1),
  (6,'QUESO OAXACA VAQUERO',1,0,1,'VAQUERO','','','','',2,0.00,0.00,0,55.50,4.00,1,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,59.00,0.00,58.00,0.00,57.00,0.00,100.000,50.000,99940.736,1),
  (7,'JAMON MANDOLINA GALICIA',1,0,1,'COGI720102GZ9','','','','',2,0.00,0.00,0,35.50,6.50,1,0,45.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,37.00,0.00,36.50,0.00,100.000,50.000,999983.350,1),
  (8,'JAMON HORNEADO GALICIA',1,0,1,'COGI720102GZ9','','','','',2,0.00,0.00,0,35.50,45.00,1,0,45.00,0.00,40.00,0.00,38.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,70.000,25.000,999976.290,1),
  (9,'QUESO DE PUERCO GALICIA',1,0,1,'COGI720102GZ9','','','','',2,0.00,0.00,0,26.00,4.00,1,0,32.00,0.00,31.00,0.00,30.00,0.00,29.00,0.00,28.00,0.00,27.00,0.00,26.50,0.00,70.000,25.000,99999.000,1),
  (10,'CUERITOS MEDIANOS',0,0,1,'ROSJ630714AV0','','','','',1,10.00,192.00,12,0.00,0.00,1,0,14.00,0.00,14.00,0.00,13.50,0.00,13.00,0.00,13.00,0.00,13.00,0.00,13.00,0.00,90.000,50.000,99997.000,1),
  (11,'CUERITOS CHICO',0,0,1,'ROSJ630714AV0','','','','',1,7.00,0.00,0,0.00,0.00,1,0,9.00,0.00,9.00,0.00,8.00,0.00,7.50,0.00,7.00,0.00,7.00,0.00,7.00,0.00,50.000,25.000,99999.000,1),
  (12,'CHULETA',1,0,1,'EHC951010S36','A','','','',2,0.00,0.00,0,32.50,3.50,1,0,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,33.00,0.00,50.000,25.000,99971.360,1),
  (13,'JAMON SUPREMO',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,42.00,6.50,1,0,48.00,0.00,47.00,0.00,46.00,0.00,45.00,0.00,44.00,0.00,43.00,0.00,42.50,0.00,100.000,50.000,99999.000,1),
  (14,'JAMON DE PIERNA YORK HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,42.50,6.50,1,0,48.00,0.00,47.00,0.00,46.00,0.00,45.00,0.00,44.00,0.00,44.00,0.00,43.00,0.00,100.000,50.000,99986.140,1),
  (15,'JAMON DE PAVO MINITOY',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,32.50,2.00,1,0,40.00,0.00,39.00,0.00,38.00,0.00,37.50,0.00,36.00,0.00,35.00,0.00,34.50,0.00,50.000,25.000,99999.000,1),
  (16,'JAMON AMERICANO OV  HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,25.50,4.00,1,0,32.00,0.00,31.00,0.00,31.00,0.00,30.00,0.00,29.00,0.00,28.00,0.00,27.50,0.00,50.000,25.000,99999.000,1),
  (17,'TOCINO SELECTO HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,33.50,4.00,1,0,40.00,0.00,39.00,0.00,38.00,0.00,37.00,0.00,36.00,0.00,35.00,0.00,34.50,0.00,100.000,50.000,99992.652,1),
  (18,'YAKULT',0,0,1,'YAK800303JA7','','','','',1,2.51,75.40,30,0.00,0.00,1,1,3.17,95.00,3.17,95.00,3.10,93.00,3.00,90.00,2.87,86.00,2.87,86.00,2.87,86.00,1000.000,500.000,99542.000,1),
  (19,'PEPERONI HERTI',0,0,1,'MAL990429SE5','','','','',1,40.50,0.00,0,0.00,0.00,1,0,45.00,0.00,55.00,0.00,54.00,0.00,53.00,0.00,52.00,0.00,51.00,0.00,50.00,0.00,100.000,50.000,99999.000,1),
  (20,'CHULETA AL ALTO VACIO',1,0,1,'A','','','','',2,0.00,0.00,0,34.00,3.50,1,0,40.00,0.00,39.00,0.00,38.00,0.00,37.00,0.00,36.00,0.00,35.00,0.00,35.50,0.00,80.000,40.000,99993.820,1),
  (21,'QUESO MOLIDO',1,0,1,'JIVV690125DG7','x','','','',2,0.00,0.00,0,5.20,10.00,1,0,10.00,0.00,10.00,0.00,9.00,0.00,8.00,0.00,7.50,0.00,7.50,0.00,7.50,0.00,100.000,90.000,99857.500,1),
  (22,'YOGHURT SABINO 4 LT',0,0,1,'DMA0106263S9','','','','',1,35.00,0.00,0,0.00,0.00,1,0,40.00,0.00,39.00,0.00,38.00,0.00,37.00,0.00,36.00,0.00,35.50,0.00,35.00,0.00,120.000,100.000,99993.000,1),
  (23,'ADEREZO DE MAYONESA HELLMANS 3.8',0,0,3,'DMA0106263S9','','','','',1,36.50,146.00,4,0.00,0.00,1,1,42.00,165.00,41.25,165.00,40.00,160.00,39.00,156.00,38.00,152.00,37.00,148.00,37.00,148.00,100.000,50.000,999999.000,1),
  (24,'SALSA CATSUP BACHI',0,0,3,'DMA0106263S9','','','','',1,28.75,115.00,4,0.00,0.00,1,1,32.00,125.00,31.25,125.00,30.00,120.00,30.00,120.00,30.00,120.00,30.00,120.00,30.00,120.00,0.000,0.000,99995.000,1),
  (25,'QUESO CANASTO MICROCLAVEL',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,50.00,5.40,1,0,56.00,0.00,55.00,0.00,54.00,0.00,53.00,0.00,52.00,0.00,51.50,0.00,51.00,0.00,120.000,50.000,99969.130,1),
  (26,'YOGHURT NORMEX 1 LT',0,0,1,'DMA0106263S9','','','','',1,16.00,0.00,0,0.00,0.00,1,0,22.00,0.00,21.00,0.00,20.00,0.00,19.00,0.00,18.00,0.00,17.00,0.00,16.50,0.00,100.000,70.000,99990.000,1),
  (27,'QUESO CANASTO MICROCAMELIA',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,48.00,5.70,1,0,55.00,0.00,54.00,0.00,53.00,0.00,52.00,0.00,51.00,0.00,50.00,0.00,49.50,0.00,100.000,50.000,99989.670,1),
  (28,'QUESO AMARILLO CAMELIA 1.8 KG',0,0,1,'DMA0106263S9','','','','',1,65.00,0.00,0,0.00,0.00,0,0,67.00,0.00,67.00,0.00,67.00,0.00,67.00,0.00,67.00,0.00,67.00,0.00,67.00,0.00,0.000,0.000,9996.000,1),
  (29,'QUESO COTTAGE NORMEX 4 KG',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,38.75,4.00,1,2,45.00,160.00,45.00,180.00,42.00,168.00,42.00,168.00,42.00,168.00,42.00,168.00,42.00,168.00,100.000,99.000,99999.000,1),
  (30,'QUESO AMARILLO CAPELLANIA 200 GR',0,0,1,'DMA0106263S9','','','','',1,7.20,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,9999.000,1),
  (31,'CHORIZO MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,29.00,1.00,1,0,35.00,0.00,34.00,0.00,33.00,0.00,32.00,0.00,31.00,0.00,30.00,0.00,30.00,0.00,120.000,100.000,99999.000,1),
  (32,'LONGANIZA MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,27.50,1.00,1,0,35.00,0.00,34.00,0.00,33.00,0.00,32.00,0.00,31.00,0.00,30.00,0.00,29.00,0.00,120.000,100.000,99999.000,1),
  (33,'SALCHICHA VIENA MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,12.50,2.20,1,0,18.00,0.00,17.00,0.00,16.00,0.00,15.00,0.00,14.00,0.00,13.00,0.00,12.90,0.00,80.000,40.000,99992.480,1),
  (34,'JAMON COCIDO MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,20.00,4.00,1,0,28.00,0.00,27.00,0.00,26.00,0.00,25.00,0.00,24.00,0.00,23.00,0.00,23.00,0.00,50.000,25.000,99984.000,1),
  (35,'GELATINA VITROLERO 100/3 GR',0,0,1,'GAR851002HJ8','','','','',1,38.00,228.00,6,0.00,0.00,1,0,45.00,0.00,44.00,0.00,43.00,0.00,42.00,0.00,41.00,0.00,40.00,0.00,40.00,0.00,99.000,60.000,99999.000,1),
  (36,'QUESO PANELA ABUELO',1,0,1,'AIÑ911217SF4','','','','',2,0.00,0.00,0,47.00,2.50,1,0,53.00,0.00,51.00,0.00,50.00,0.00,49.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,200.000,50.000,99881.160,1),
  (37,'QUESO CANASTO DEL ABUELO CHICO',1,0,1,'AIÑ911217SF4','','','','',2,0.00,0.00,0,48.00,5.70,1,0,55.00,0.00,54.00,0.00,53.00,0.00,52.00,0.00,51.00,0.00,50.00,0.00,50.00,0.00,80.000,79.000,9999.000,1),
  (38,'QUESO DE PUERCO NEZA',1,0,1,'PNE860402GL2','','','','',2,0.00,0.00,0,24.50,3.50,1,0,30.00,0.00,30.00,0.00,28.00,0.00,26.50,0.00,26.00,0.00,25.00,0.00,25.00,0.00,50.000,49.000,99977.089,1),
  (39,'PECHUGA DE PAVO DYN',1,0,1,'APA850331PZ1','','','','',2,0.00,0.00,0,42.50,3.50,1,0,50.00,0.00,49.00,0.00,48.00,0.00,46.00,0.00,45.00,0.00,44.00,0.00,44.00,0.00,100.000,99.000,9999.000,1),
  (40,'ATE LA FLOR DE MORELIA',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,17.50,6.00,1,2,20.00,108.00,18.00,108.00,18.00,108.00,18.00,108.00,18.00,108.00,18.00,108.00,18.00,108.00,0.000,0.000,99999.000,1),
  (41,'SALCHICHA COCKTAIL ALPINO',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,18.00,2.00,0,0,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,0.000,0.000,99999.000,1),
  (42,'PIERNA C/HORNEADA A/V HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,38.50,3.20,1,0,45.00,0.00,44.00,0.00,43.00,0.00,42.00,0.00,41.00,0.00,40.00,0.00,40.00,0.00,50.000,25.000,99997.000,1),
  (43,'JAMON DE PIERNA MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,34.00,6.50,1,0,38.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,0.000,0.000,99999.000,1),
  (44,'JAMON MANDOLINA FRANS',1,0,1,'DAL040721KQ7','','','','',2,0.00,0.00,0,46.00,6.50,1,0,52.00,0.00,51.00,0.00,50.00,0.00,49.00,0.00,48.00,0.00,47.00,0.00,46.00,0.00,120.000,60.000,999986.380,1),
  (45,'JAMON JAR-8',1,0,1,'DAL040721KQ7','','','','',2,0.00,0.00,0,19.50,4.00,1,0,26.00,0.00,25.00,0.00,24.00,0.00,23.00,0.00,22.00,0.00,21.00,0.00,20.00,0.00,25.000,24.000,999978.625,1),
  (46,'YOGHURT PALMALAC 4 LT',0,0,1,'PAL860319A25','','','','',1,63.00,0.00,0,0.00,0.00,1,0,68.00,0.00,68.00,0.00,67.00,0.00,65.00,0.00,65.00,0.00,65.00,0.00,65.00,0.00,0.000,0.000,99996.000,1),
  (47,'TOCINO AHUMADO A/V DHECTTOR',1,0,1,'UNI9704247M2','','','','',2,0.00,0.00,0,34.00,3.00,1,0,40.00,0.00,40.00,0.00,38.50,0.00,36.50,0.00,36.50,0.00,36.50,0.00,36.50,0.00,0.000,0.000,99979.640,1),
  (48,'CHORIZO PASTOR',1,0,1,'FER961113AX1','','','','',2,0.00,0.00,0,28.00,1.00,0,0,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,99982.020,1),
  (49,'LONGANIZA PASTOR',1,0,1,'FER961113AX1','','','','',2,0.00,0.00,0,27.50,1.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99983.540,1),
  (50,'GELATINA DANY 125 GR',0,0,1,'VAPB730831UM9','','','','',1,2.40,120.00,48,0.00,0.00,1,1,3.00,120.00,2.50,120.00,2.50,120.00,2.50,120.00,2.50,120.00,2.50,120.00,2.50,120.00,3000.000,480.000,99975.000,1),
  (51,'TOSTADAS CHARRAS',0,0,1,'VAPB730831UM9','','','','',1,9.50,171.00,18,0.00,0.00,1,1,10.00,178.00,9.89,178.00,9.72,175.00,9.61,173.00,9.61,173.00,9.61,173.00,9.61,173.00,100.000,20.000,99870.000,1),
  (52,'YOGHURT FRUIX C/CEREAL 151 GR',0,0,1,'VAPB730831UM9','','','','',1,3.75,90.00,24,0.00,0.00,0,1,4.00,96.00,4.00,96.00,4.00,96.00,4.00,96.00,4.00,96.00,4.00,96.00,4.00,96.00,1234.000,123.000,99981.000,1),
  (53,'YOGHURT DANONINO 180 GR',0,0,1,'VAPB730831UM9','','','','',1,7.71,185.00,24,0.00,0.00,1,1,8.50,190.00,7.92,190.08,7.92,190.08,7.92,190.08,7.92,190.08,7.92,190.08,7.92,190.08,1230.000,100.000,99999.000,1),
  (54,'YOGHURT ACTIVIA 150 GR',0,0,1,'VAPB730831UM9','','','','',1,3.38,168.00,48,0.00,0.00,1,1,4.50,216.00,4.42,212.02,4.42,212.02,4.42,212.02,4.42,212.02,4.42,212.02,4.42,212.02,100.000,99.000,99879.000,1),
  (55,'CREMA VEGETAL GINA 1 KG',0,0,1,'UNI9704247M2','VAPB730831UM9','','','',1,8.00,80.00,10,0.00,0.00,1,1,9.00,90.00,9.00,90.00,8.50,85.00,8.50,85.00,8.50,85.00,8.50,85.00,8.50,85.00,0.000,0.000,99960.000,1),
  (56,'YOGHURT BONAFINA 1 LT',0,0,1,'UNI9704247M2','VAPB730831UM9','','','',1,9.60,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99978.000,0),
  (57,'BONAFINA 1 LT',0,0,1,'UNI9704247M2','VAPB730831UM9','LSF050118U75','','',1,4.50,120.00,20,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.20,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,10.000,5.000,99498.000,1),
  (58,'BONAFINA 220 ML',0,0,1,'UNI9704247M2','VAPB730831UM9','LSF050118U75','','',1,1.30,0.00,0,0.00,0.00,1,0,2.00,0.00,1.80,0.00,1.70,0.00,1.70,0.00,1.70,0.00,1.70,0.00,1.40,0.00,500.000,250.000,99656.000,1),
  (59,'YOGHURT BONAFINA 500 ML',0,0,1,'UNI9704247M2','VAPB730831UM9','LSF050118U75','','',1,4.64,0.00,0,0.00,0.00,1,0,6.00,0.00,6.00,0.00,5.50,0.00,5.40,0.00,5.20,0.00,5.00,0.00,4.80,0.00,500.000,250.000,99944.000,1),
  (60,'YOGHURT BONAFINA 1 LT',0,0,1,'UNI9704247M2','VAPB730831UM9','LSF050118U75','','',1,8.50,0.00,0,0.00,0.00,1,0,11.00,0.00,10.00,0.00,9.80,0.00,9.40,0.00,9.20,0.00,9.10,0.00,9.10,0.00,500.000,250.000,99979.000,1),
  (61,'BONAKULT 5/120 ML',0,0,1,'UNI9704247M2','','','','',1,8.29,58.00,7,0.00,0.00,1,1,12.00,84.00,12.00,84.00,11.71,82.00,10.00,70.00,10.00,70.00,10.00,70.00,8.57,60.00,50.000,25.000,999995.000,1),
  (62,'SHAK BOLSA 12/160 ML',0,0,1,'UNI9704247M2','','','','',1,8.50,0.00,0,0.00,0.00,1,0,12.00,0.00,11.00,0.00,10.00,0.00,9.00,0.00,9.00,0.00,9.00,0.00,9.00,0.00,100.000,50.000,99987.000,1),
  (63,'JAMON DE PAVO MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,34.00,3.80,1,0,42.00,0.00,40.00,0.00,39.00,0.00,38.00,0.00,37.00,0.00,36.00,0.00,35.00,0.00,90.000,50.000,99997.000,1),
  (64,'BONAFINA 500 ML',0,0,1,'UNI9704247M2','VAPB730831UM9','LSF050118U75','','',1,3.50,0.00,0,0.00,0.00,1,0,5.00,0.00,4.20,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,100.000,50.000,999683.000,1),
  (65,'BONAFINA GALON',0,0,1,'UNI9704247M2','VAPB730831UM9','LSF050118U75','','',1,14.00,0.00,0,0.00,0.00,1,0,17.50,0.00,17.00,0.00,16.50,0.00,16.00,0.00,15.50,0.00,15.00,0.00,15.50,0.00,50.000,49.000,99991.000,1),
  (66,'PIERNA ESPAÑOLA',1,0,1,'SAB960412CK7','','','','',2,0.00,0.00,0,28.00,6.00,1,0,34.00,0.00,34.00,0.00,32.50,0.00,31.50,0.00,31.50,0.00,31.50,0.00,31.50,0.00,50.000,49.000,99986.100,1),
  (67,'QUESO DOBLECREMA CHILCHOTA',0,0,1,'AMO930202EQ6','','','','',1,39.00,156.00,4,0.00,0.00,1,1,42.50,168.00,42.00,168.00,41.00,164.00,39.75,159.00,39.50,158.00,39.25,157.00,39.25,157.00,50.000,20.000,9945.000,1),
  (68,'JUGO GENERICA DEL VALLE',0,0,2,'AMO930202EQ6','','','','',1,4.50,108.00,24,0.00,0.00,0,1,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,0.000,0.000,0.000,0),
  (69,'QUESO SIERRA MINIPEQUEÑA',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,46.50,4.00,1,0,50.00,0.00,49.00,0.00,48.50,0.00,48.00,0.00,47.50,0.00,47.00,0.00,47.00,0.00,50.000,25.000,99981.680,1),
  (70,'QUESO CANASTO CHILCHOTA',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,48.50,10.00,1,0,55.00,0.00,53.00,0.00,52.00,0.00,51.00,0.00,50.00,0.00,49.50,0.00,49.50,0.00,50.000,25.000,9985.020,1),
  (71,'QUESO BARRA CANASTO CHILCHOTA',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,48.50,4.00,1,0,55.00,0.00,53.00,0.00,52.00,0.00,51.00,0.00,50.00,0.00,49.50,0.00,49.50,0.00,50.000,25.000,9991.179,1),
  (72,'QUESO CANASTO SELLO DE ORO',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,46.50,4.00,1,0,53.00,0.00,53.00,0.00,50.00,0.00,48.50,0.00,47.50,0.00,47.50,0.00,47.50,0.00,50.000,25.000,99956.090,1),
  (73,'QUESO GOUDA NUEVA ZELANDA',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,55.00,10.00,1,0,65.00,0.00,62.00,0.00,59.00,0.00,58.00,0.00,57.00,0.00,57.50,0.00,69.50,0.00,50.000,25.000,99999.000,1),
  (74,'JAMON HORNEADO DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,31.00,5.00,1,0,34.00,0.00,36.00,0.00,35.00,0.00,34.00,0.00,33.00,0.00,32.50,0.00,32.00,0.00,50.000,25.000,99984.040,1),
  (75,'JAMON AMERICANO DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,24.10,5.00,1,0,30.00,0.00,28.00,0.00,27.00,0.00,26.50,0.00,26.00,0.00,25.00,0.00,25.00,0.00,50.000,25.000,99949.000,1),
  (76,'MORTADELA DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,13.40,5.00,1,0,20.00,0.00,20.00,0.00,16.00,0.00,15.50,0.00,15.50,0.00,15.50,0.00,15.50,0.00,0.000,0.000,99998.000,1),
  (77,'PIERNA ADOBADA DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,24.60,5.00,1,0,27.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,0.000,0.000,99978.500,1),
  (78,'SALCHICHA VIENA DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,12.20,2.50,1,2,14.00,35.00,14.00,35.00,13.60,34.00,13.20,33.00,12.80,32.00,12.80,32.00,12.80,32.00,0.000,0.000,99825.250,1),
  (79,'JAMON YORK DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,44.00,6.30,1,0,48.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,0.000,0.000,99992.660,1),
  (80,'JAMON DE PIERNA HORNEADO DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,34.20,6.30,1,0,36.50,0.00,35.70,0.00,35.70,0.00,35.70,0.00,35.70,0.00,35.70,0.00,35.70,0.00,100.000,50.000,99979.900,1),
  (81,'JAMON DE PIERNA AMERICANA DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,24.10,6.30,1,0,32.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,24.70,0.00,0.000,0.000,99999.000,1),
  (82,'JAMON COCIDO DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,16.60,5.00,1,0,18.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,0.000,0.000,9998.500,1),
  (83,'QUESO TORTERO',1,0,1,'IMP961016B86','','','','',2,0.00,0.00,0,22.50,4.00,0,0,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,0.000,0.000,99999.000,1),
  (84,'QUESO CANASTO ABAJEÑO',1,0,1,'IMP961016B86','','','','',2,0.00,0.00,0,28.00,7.00,0,0,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,0.000,0.000,99999.000,1),
  (85,'QUESO CHIHUAHUA MENONITA',1,0,1,'CME9109236F1','','','','',2,0.00,0.00,0,50.50,4.00,1,0,56.00,0.00,56.00,0.00,54.00,0.00,52.50,0.00,52.00,0.00,52.00,0.00,52.00,0.00,0.000,0.000,99992.459,1),
  (86,'LEVADURA 400 GR',0,0,1,'AOR821025A25','','','','',1,10.63,255.00,24,0.00,0.00,1,1,12.00,288.00,11.46,275.04,11.46,275.04,11.46,275.04,11.46,275.04,11.46,275.04,11.46,275.04,360.000,120.000,99999.000,1),
  (87,'QUESO COTIJA SUIZA',1,0,1,'CME9109236F1','','','','',2,0.00,0.00,0,42.00,25.00,1,0,52.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,0.000,0.000,99997.800,1),
  (88,'QUESO CHIHUAHUA ARCONOR',1,0,1,'CME9109236F1','','','','',2,0.00,0.00,0,34.50,2.50,1,0,40.00,0.00,40.00,0.00,38.00,0.00,36.50,0.00,35.00,0.00,35.00,0.00,35.00,0.00,0.000,0.000,9997.500,1),
  (89,'QUESO CHIHUAHUA MENONITA',1,0,1,'CME9109236F1','','','','',2,0.00,0.00,0,45.40,2.50,1,0,48.00,0.00,47.00,0.00,47.00,0.00,47.00,0.00,47.00,0.00,47.00,0.00,47.00,0.00,0.000,0.000,0.000,0),
  (90,'MILECHE 1 LT',0,0,1,'CBA871214MS6','','','','',1,7.00,90.00,12,0.00,0.00,0,1,8.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,120.000,100.000,99855.000,1),
  (91,'JAMON AMERICANO ALYS',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,18.00,5.00,1,0,25.00,0.00,24.00,0.00,23.00,0.00,22.00,0.00,21.00,0.00,20.00,0.00,19.50,0.00,50.000,49.000,99999.000,1),
  (92,'ARROZ CON LECHE DANONE 200 ML',0,0,1,'VAPB730831UM9','','','','',1,2.77,133.00,48,0.00,0.00,1,1,3.00,140.00,2.92,140.00,2.92,140.00,2.92,140.00,2.92,140.00,2.92,140.00,2.92,140.00,720.000,240.000,99995.000,1),
  (93,'CREMA BATIDA CARRANCEDO 5 KG',0,0,1,'VAM051215JV8','','','','',1,85.80,0.00,0,0.00,0.00,1,0,92.00,0.00,92.00,0.00,92.00,0.00,92.00,0.00,92.00,0.00,91.00,0.00,90.00,0.00,50.000,49.000,9999.000,1),
  (94,'CREMA BATIDA CARRANCEDO 1 KG',0,0,1,'VAM051215JV8','','','','',1,20.49,0.00,0,0.00,0.00,1,0,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,100.000,25.000,9999.000,1),
  (95,'YOGHURT TARASCO 4 LT',0,0,1,'PRL8602136M3','','','','',1,31.90,0.00,0,0.00,0.00,1,0,40.00,0.00,39.00,0.00,38.00,0.00,37.00,0.00,36.00,0.00,35.00,0.00,35.00,0.00,50.000,25.000,99999.000,1),
  (96,'YOGHURT BALCAM',0,0,1,'PRL8602136M3','','','','',1,38.00,0.00,0,0.00,0.00,1,0,45.00,0.00,43.00,0.00,42.00,0.00,41.00,0.00,40.00,0.00,38.00,0.00,38.00,0.00,50.000,25.000,99874.000,1),
  (97,'QUESO CANASTO DURANGUEÑO',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,35.00,6.50,1,0,45.00,0.00,43.00,0.00,42.00,0.00,40.00,0.00,39.00,0.00,38.00,0.00,38.00,0.00,50.000,25.000,99999.000,1),
  (98,'JAMON AMERICANO OV SANTA LUCIA',1,0,1,'SANTA LUCIA','','','','',2,0.00,0.00,0,30.00,5.00,1,0,38.00,0.00,37.00,0.00,36.00,0.00,35.00,0.00,34.00,0.00,33.00,0.00,33.00,0.00,50.000,25.000,99999.000,1),
  (99,'JAMON DE PIERNA AMERICANO STA LUCIA',1,0,1,'SANTA LUCIA','','','','',2,0.00,0.00,0,34.00,6.00,1,0,40.00,0.00,39.00,0.00,38.00,0.00,37.00,0.00,36.00,0.00,35.50,0.00,35.00,0.00,50.000,25.000,99999.000,1),
  (100,'ACEITE CRISTAL  1 LT',0,0,3,'SOBA','','','','',1,11.50,138.00,12,0.00,0.00,1,1,13.50,144.00,12.00,144.00,12.00,144.00,12.00,144.00,12.00,144.00,12.00,144.00,12.00,144.00,660.000,60.000,999999.000,1),
  (101,'ACEITE CRISTAL 1.5 LT',0,0,3,'SOBA','','','','',1,17.25,138.00,8,0.00,0.00,1,1,18.50,140.00,17.50,140.00,17.50,140.00,17.50,140.00,17.50,140.00,17.50,140.00,17.50,140.00,100.000,99.000,999997.000,1),
  (102,'ACEITE CRISTAL 5 LT',0,0,3,'SOBA','','','','',1,59.00,118.00,2,0.00,0.00,1,1,61.00,122.00,60.00,120.00,60.00,120.00,60.00,120.00,60.00,120.00,60.00,120.00,60.00,120.00,50.000,25.000,999999.000,1),
  (103,'ACEITE CRISTAL 20 LT',0,0,3,'SOBA','','','','',1,228.00,0.00,0,0.00,0.00,1,0,240.00,0.00,235.00,0.00,235.00,0.00,235.00,0.00,235.00,0.00,235.00,0.00,235.00,0.00,100.000,50.000,999999.000,1),
  (104,'QUESO AMARILLO RANCHERITO',0,0,1,'VAPB730831UM9','','','','',1,40.00,240.00,6,0.00,0.00,1,1,55.00,330.00,55.00,330.00,55.00,330.00,55.00,330.00,55.00,330.00,50.00,300.00,42.00,252.00,0.000,0.000,9998.000,1),
  (105,'FLAN DANETTE 200 GR',0,0,1,'VAPB730831UM9','','','','',1,2.77,133.00,48,0.00,0.00,1,1,3.00,140.00,2.92,140.02,2.92,140.02,2.92,140.02,2.92,140.02,2.92,140.02,2.92,140.02,0.000,0.000,999977.000,1),
  (106,'YOGHURT DANUP 250 ML',0,0,1,'VAPB730831UM9','','','','',1,4.64,130.00,28,0.00,0.00,1,1,5.80,145.00,5.50,154.00,5.18,145.00,5.07,142.00,5.07,142.00,5.07,142.00,5.07,142.00,0.000,0.000,99893.000,1),
  (107,'YOGHURT VITALINEA 250 ML',0,0,1,'VAPB730831UM9','','','','',1,6.03,169.00,28,0.00,0.00,1,1,6.80,185.00,6.61,185.00,6.61,185.00,6.61,185.00,6.61,185.00,6.61,185.00,6.61,185.00,0.000,0.000,99993.000,1),
  (108,'BONAFINA PLASTICO 1 LT',0,0,1,'VAPB730831UM9','','','','',1,5.30,0.00,0,0.00,0.00,1,0,6.00,0.00,5.60,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,0.000,0.000,99984.000,1),
  (109,'SALSA CATSUP CHEFS',0,0,3,'CAN970516RI6','','','','',1,33.25,133.00,4,0.00,0.00,1,1,36.00,138.00,34.50,138.00,34.50,138.00,34.50,138.00,34.50,138.00,34.50,138.00,34.50,138.00,0.000,0.000,99999.000,1),
  (110,'LECHE CONDENSADA NORDIKA 1 KG',0,0,1,'CCM810420IF2','','','','',1,22.00,0.00,0,0.00,0.00,0,0,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,0.000,0.000,99998.000,1),
  (111,'LECHE CONDENSADA NORDIKA 25 KG',0,0,1,'CCM810420IF2','','','','',1,500.00,0.00,0,0.00,0.00,0,0,510.00,0.00,510.00,0.00,510.00,0.00,510.00,0.00,510.00,0.00,510.00,0.00,510.00,0.00,0.000,0.000,9999.000,1),
  (112,'ACEITE 1-2-3',0,0,3,'x','','','','',1,11.83,142.00,12,0.00,0.00,1,1,13.00,152.00,12.67,152.00,12.67,152.00,12.67,152.00,12.67,152.00,12.67,152.00,12.67,152.00,0.000,0.000,9999.000,1),
  (113,'ACEITE CAPULLO',0,0,3,'x','','','','',1,16.66,200.00,12,0.00,0.00,1,1,18.00,205.00,17.50,210.00,17.50,210.00,17.50,210.00,17.50,210.00,17.50,210.00,17.50,210.00,0.000,0.000,99999.000,1),
  (114,'ACEITE DE OLIVA YBARRA 946 ML',0,0,3,'x','','','','',1,80.00,0.00,0,0.00,0.00,0,0,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,0.000,0.000,999999.000,1),
  (115,'ACEITE KARTAMUS',0,0,3,'x','','','','',1,8.75,105.00,12,0.00,0.00,1,1,11.00,132.00,10.00,120.00,10.00,120.00,10.00,120.00,10.00,120.00,10.00,120.00,10.00,120.00,0.000,0.000,999999.000,1),
  (116,'ACEITUNA C/HUESO',1,0,1,'x','','','','',2,0.00,0.00,0,28.00,1.00,0,0,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,0.000,0.000,999998.995,1),
  (117,'ACEITUNA NEGRA',1,0,1,'x','','','','',2,0.00,0.00,0,55.00,100.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,999999.000,1),
  (118,'ACEITUNA S/HUESO',1,0,1,'x','','','','',2,0.00,0.00,0,45.00,100.00,0,0,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,0.000,0.000,999999.000,1),
  (119,'ADEREZO',1,0,1,'x','','','','',2,0.00,0.00,0,8.00,25.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,999999.000,1),
  (120,'ADEREZO DE MAYONESA MCCORMICK 3.9',0,0,3,'x','','','','',1,67.50,270.00,4,0.00,0.00,1,1,75.00,285.00,71.25,285.00,71.25,285.00,71.25,285.00,71.25,285.00,70.00,280.00,68.50,274.00,0.000,0.000,99998.000,1),
  (121,'ADEREZO DE MAYONESA MEGA 3.9 KG',0,0,3,'DMA0106263S9','','','','',1,40.17,241.00,6,0.00,0.00,0,1,43.00,258.00,43.00,258.00,43.00,258.00,43.00,258.00,43.00,258.00,43.00,258.00,43.00,258.00,0.000,0.000,999999.000,1),
  (122,'ADEREZO DE MAYONESA ROYAL 3.8 KG',0,0,3,'x','','','','',1,35.00,140.00,4,0.00,0.00,1,1,40.00,148.00,37.00,148.00,37.00,148.00,37.00,148.00,37.00,148.00,37.00,148.00,37.00,148.00,0.000,0.000,99999.000,1),
  (123,'ADEREZO PARA NACHOS BIOLAC 4 KG',0,0,3,'GIC960719217','','','','',1,49.50,0.00,0,0.00,0.00,0,0,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,0.000,0.000,999999.000,1),
  (124,'ADEREZO DE MAYONESA VENECIA 3.8 KG',0,0,3,'x','','','','',1,30.00,120.00,4,0.00,0.00,1,1,33.00,128.00,32.00,128.00,31.50,126.00,31.50,126.00,31.50,126.00,31.50,126.00,30.50,122.00,0.000,0.000,999997.000,1),
  (125,'AGUA BONAFONT 330 ML',0,0,2,'x','','','','',1,2.50,60.00,24,0.00,0.00,1,1,3.00,72.00,2.96,71.00,2.92,70.01,2.88,69.00,2.83,68.00,2.79,67.01,2.79,67.01,0.000,0.000,99999.000,1),
  (126,'AGUA BE LIGHT 1.5 LT',0,1,2,'x','','','','',1,8.80,97.00,12,0.00,0.00,1,1,12.00,110.00,9.17,110.00,9.17,110.00,9.17,110.00,9.17,110.00,9.17,110.00,9.17,110.00,0.000,0.000,999999.000,1),
  (127,'AGUA BONAFONT 500 ML',0,0,2,'x','','','','',1,2.34,56.00,24,0.00,0.00,1,1,4.00,62.00,2.58,62.00,2.58,62.00,2.58,62.00,2.58,62.00,2.50,60.00,2.44,58.00,100.000,50.000,99741.000,1),
  (128,'AGUA BONAFONT 1 LT',0,0,2,'x','','','','',1,4.34,52.00,12,0.00,0.00,1,1,6.00,72.00,5.33,64.00,5.33,64.00,5.33,64.00,4.83,58.00,4.83,58.00,4.75,57.00,6000.000,600.000,999957.000,1),
  (129,'AGUA BONAFONT 1.5 LT',0,0,2,'x','','','','',1,4.67,56.00,12,0.00,0.00,1,1,7.00,64.00,5.42,65.00,5.33,64.00,5.25,63.00,5.25,63.00,5.25,63.00,5.25,63.00,0.000,0.000,99827.000,1),
  (130,'AGUA ELECTROPURA 500 ML',0,0,2,'x','','','','',1,1.75,42.00,24,0.00,0.00,1,1,4.00,48.00,2.00,48.00,1.96,47.00,1.92,46.00,1.88,45.00,1.83,44.00,1.75,42.00,0.000,0.000,99987.000,1),
  (131,'AGUA ELECTROPURA 1.5 LT',0,0,2,'x','','','','',1,3.50,42.00,12,0.00,0.00,1,1,5.00,48.00,4.00,48.00,3.92,47.00,3.83,46.00,3.75,45.00,3.66,44.00,3.50,42.00,0.000,0.000,99993.000,1),
  (132,'AGUA LEVITE 1.5 LT',0,1,2,'x','','','','',1,8.58,103.00,12,0.00,0.00,1,1,12.00,110.00,9.17,110.00,9.08,109.00,8.92,107.00,8.83,106.00,8.75,105.00,8.67,103.99,0.000,0.000,99975.000,1),
  (133,'ALCAPARRA',1,0,1,'x','','','','',2,0.00,0.00,0,50.00,25.00,0,0,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,0.000,0.000,999999.000,1),
  (134,'ATUN DOLORES EN ACEITE 170 GR',0,0,3,'x','','','','',1,6.77,325.00,48,0.00,0.00,1,1,7.00,330.00,6.88,330.00,6.88,330.00,6.88,330.00,6.88,330.00,6.88,330.00,6.88,330.00,0.000,0.000,99995.000,1),
  (135,'ATUN DOLORES EN ACEITE 1.880 KG',0,0,3,'x','','','','',1,66.60,400.00,6,0.00,0.00,1,1,72.00,410.00,68.33,410.01,68.33,410.01,68.33,410.01,68.33,410.01,68.33,410.01,68.33,410.01,0.000,0.000,99999.000,1),
  (136,'ATUN DOLORES EN AGUA 170 GR',0,0,3,'x','','','','',1,6.88,330.00,48,0.00,0.00,1,1,8.00,335.00,6.98,334.99,6.98,334.99,6.98,334.99,6.98,334.99,6.98,334.99,6.98,334.99,0.000,0.000,99999.000,1),
  (137,'AZUCAR',0,0,3,'x','','','','',1,6.70,335.00,50,0.00,0.00,1,1,8.00,343.00,6.86,343.00,6.86,343.00,6.86,343.00,6.86,343.00,6.86,343.00,6.86,343.00,0.000,0.000,99999.000,1),
  (138,'AZUCAR REFINADA',0,0,3,'x','','','','',1,395.00,0.00,0,0.00,0.00,0,0,398.00,0.00,398.00,0.00,398.00,0.00,398.00,0.00,398.00,0.00,398.00,0.00,398.00,0.00,0.000,0.000,99999.000,1),
  (139,'BACALAO NORUEGO',1,0,1,'x','','','','',2,0.00,0.00,0,130.00,10.00,0,0,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,0.000,0.000,99999.000,1),
  (140,'BEBERE GALON',0,1,2,'x','','','','',1,16.66,100.00,6,0.00,0.00,1,1,19.00,105.00,17.50,105.00,17.00,102.00,17.00,102.00,17.00,102.00,17.00,102.00,17.00,102.00,0.000,0.000,99998.000,1),
  (141,'BETTER CREAM',0,0,1,'x','','','','',1,142.00,0.00,0,0.00,0.00,0,0,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,145.00,0.00,0.000,0.000,99999.000,1),
  (142,'BETTER CREAM 1 LT',0,0,1,'x','','','','',1,38.00,0.00,0,0.00,0.00,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,0.000,0.000,99999.000,1),
  (143,'BIG COLA 620 ML',0,1,2,'x','','','','',1,3.13,75.00,24,0.00,0.00,1,1,4.00,79.00,3.29,79.01,3.25,78.00,3.21,77.02,3.17,76.01,3.17,76.01,3.17,76.01,0.000,0.000,99975.000,1),
  (144,'BIMBOLLOS JUMBO',0,0,1,'x','','','','',1,24.00,0.00,0,0.00,0.00,0,0,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,0.000,0.000,0.000,0),
  (145,'BIMBOLLOS',0,0,1,'x','','','','',1,15.00,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,0.000,0),
  (146,'CAFE INSTANTANEO 30 GR',0,0,3,'x','','','','',1,84.00,0.00,0,0.00,0.00,1,0,90.00,0.00,89.00,0.00,88.00,0.00,87.00,0.00,86.00,0.00,85.00,0.00,85.00,0.00,0.000,0.000,999999.000,1),
  (147,'CAFE LEGAL EXHIBIDOR 6-60/28 GR',0,0,3,'x','','','','',1,148.00,0.00,0,0.00,0.00,0,0,153.00,0.00,153.00,0.00,153.00,0.00,153.00,0.00,153.00,0.00,153.00,0.00,153.00,0.00,0.000,0.000,99999.000,1),
  (148,'CAFE OLE 281 ML',0,0,2,'x','','','','',1,9.58,115.00,12,0.00,0.00,1,1,10.50,120.00,10.00,120.00,10.00,120.00,10.00,120.00,10.00,120.00,10.00,120.00,10.00,120.00,0.000,0.000,99999.000,1),
  (149,'CAJETA',1,0,3,'x','','','','',2,0.00,0.00,0,12.80,25.00,1,2,16.00,355.00,14.20,355.00,14.00,350.00,13.80,345.00,13.80,345.00,13.80,345.00,13.80,345.00,0.000,0.000,9991.500,1),
  (150,'CHAMPIÑONES REBANADOS 3 KG',0,0,3,'x','','','','',1,70.00,420.00,6,0.00,0.00,1,1,79.00,455.00,75.83,455.00,75.83,455.00,75.83,455.00,75.83,455.00,75.83,455.00,75.83,455.00,0.000,0.000,99996.000,1),
  (151,'CHAMPIÑONES REBANADOS',0,0,3,'x','','','','',1,28.00,0.00,0,0.00,0.00,0,0,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,0.000,0.000,999999.000,1),
  (152,'CHICHARRON PRENSADO',1,0,1,'x','','','','',2,0.00,0.00,0,35.00,25.00,0,0,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,37.00,0.00,0.000,0.000,999999.000,1),
  (153,'BIG COLA 1.3 LT',0,1,2,'x','','','','',1,5.17,62.00,12,0.00,0.00,1,1,6.50,78.00,5.67,68.00,5.58,67.00,5.58,67.00,5.54,66.50,5.50,66.00,5.50,66.00,0.000,0.000,99998.000,1),
  (154,'BIG COLA 3 LT',0,1,2,'x','','','','',1,10.00,60.00,6,0.00,0.00,1,1,12.00,63.00,10.50,63.00,10.17,61.00,10.17,61.00,10.17,61.00,10.17,61.00,10.17,61.00,0.000,0.000,99993.000,1),
  (155,'BIG COLA DE LATA 335 ML',0,1,2,'x','','','','',1,2.41,58.00,24,0.00,0.00,1,1,3.00,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,0.000,0.000,99999.000,1),
  (156,'BIO 4 LALA 120 GR',0,0,1,'x','','','','',1,3.13,75.00,24,0.00,0.00,1,1,3.50,84.00,3.33,80.00,3.29,79.00,3.25,78.00,3.25,78.00,3.25,78.00,3.25,78.00,0.000,0.000,99992.000,1),
  (157,'BOING 250 ML',0,0,2,'x','','','','',1,2.59,70.00,27,0.00,0.00,1,1,3.50,78.00,2.89,78.00,2.78,75.00,2.70,73.00,2.70,72.90,2.70,73.00,2.70,73.00,0.000,0.000,99781.000,1),
  (158,'BOING 500 ML.',0,0,2,'x','','','','',1,4.33,104.00,24,0.00,0.00,1,1,6.00,111.00,4.63,111.00,4.58,110.00,4.50,108.00,4.50,108.00,4.50,108.00,4.50,108.00,0.000,0.000,99579.000,1),
  (159,'BOING 1 LT',0,0,2,'x','','','','',1,8.75,105.00,12,0.00,0.00,1,1,12.00,111.00,9.25,111.00,9.17,110.00,9.00,108.00,9.00,108.00,9.00,108.00,9.00,108.00,0.000,0.000,99891.000,1),
  (160,'BOING LATA',0,0,2,'x','','','','',1,3.66,88.00,24,0.00,0.00,1,1,5.00,92.00,3.83,92.00,3.83,92.00,3.83,92.00,3.83,92.00,3.83,92.00,3.83,92.00,0.000,0.000,99999.000,1),
  (161,'BOING TRIANGULO',0,0,2,'x','','','','',1,2.22,40.00,18,0.00,0.00,1,1,3.00,43.00,2.39,43.00,2.39,43.00,2.39,43.00,2.39,43.00,2.39,43.00,2.39,43.00,0.000,0.000,99999.000,1),
  (162,'BOING VIDRIO',0,0,2,'x','','','','',1,3.96,95.00,24,0.00,0.00,1,1,6.00,98.00,4.08,98.00,4.08,98.00,4.08,98.00,4.08,98.00,4.08,98.00,4.08,98.00,0.000,0.000,999915.000,1),
  (163,'BOTELLIN 250 ML',0,0,2,'x','','','','',1,3.54,85.00,24,0.00,0.00,1,1,4.50,93.00,3.88,93.00,3.88,93.00,3.88,93.00,3.88,93.00,3.88,93.00,3.88,93.00,0.000,0.000,999999.000,1),
  (164,'CARIBE COOLER 300 ML',0,1,2,'x','','','','',1,7.92,190.00,24,0.00,0.00,1,1,10.00,205.00,8.54,205.00,8.33,200.00,8.25,198.00,8.25,198.00,8.25,198.00,8.25,198.00,0.000,0.000,99879.000,1),
  (165,'CARNE PARA AMBURGUESA',0,0,1,'x','','','','',1,85.00,0.00,0,0.00,0.00,0,0,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,0.000,0.000,99999.000,1),
  (166,'CEREZA',0,0,3,'x','','','','',1,55.00,0.00,0,0.00,0.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (167,'CEREZA 4.25',0,0,1,'OCM870210PC6','','','','',1,130.00,520.00,4,0.00,0.00,1,1,140.00,555.00,138.75,555.00,137.50,550.00,136.25,545.00,135.00,540.00,132.50,530.00,132.50,530.00,0.000,0.000,99999.000,1),
  (168,'CHILES CHIPOTLES',0,0,3,'x','','','','',1,45.00,0.00,0,0.00,0.00,0,0,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,0.000,0.000,99999.000,1),
  (169,'CHILES CHIPOTLES 40/105 GR',0,0,3,'x','','','','',1,3.00,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,99999.000,1),
  (170,'CHILES CHIPOTLES ADOBADOS 380 GR',0,0,3,'x','','','','',1,12.08,290.00,24,0.00,0.00,1,1,14.00,295.00,12.29,295.01,12.29,295.01,12.29,295.01,12.29,295.01,12.29,295.01,12.29,295.01,0.000,0.000,99999.000,1),
  (171,'CHILES CHIPOTLES BAOLI 2.8 KG',0,0,3,'x','','','','',1,40.00,0.00,0,0.00,0.00,0,0,43.00,0.00,43.00,0.00,43.00,0.00,43.00,0.00,43.00,0.00,43.00,0.00,43.00,0.00,0.000,0.000,99999.000,1),
  (172,'CHILES CHIPOTLES CLEMENTE JACQU 210',0,0,3,'x','','','','',1,5.63,135.00,24,0.00,0.00,1,1,8.00,192.00,5.83,140.00,5.83,140.00,5.83,140.00,5.83,140.00,5.83,140.00,5.83,140.00,0.000,0.000,99999.000,1),
  (173,'CHILESCHIPOTLES LA COSTEÑA 2.8 KG',0,0,3,'x','','','','',1,64.16,385.00,6,0.00,0.00,1,1,80.00,390.00,65.00,390.00,65.00,390.00,65.00,390.00,65.00,390.00,65.00,390.00,65.00,390.00,0.000,0.000,99999.000,1),
  (174,'CHILES CHIPOTLES LA TORRE 2.800 KG',0,0,3,'x','','','','',1,60.00,0.00,0,0.00,0.00,1,0,63.00,0.00,62.00,0.00,62.00,0.00,62.00,0.00,62.00,0.00,62.00,0.00,62.00,0.00,0.000,0.000,99999.000,1),
  (175,'CHILES CHIPOTLES MOLIDOS BAOLI 2.8',0,0,3,'x','','','','',1,27.00,0.00,0,0.00,0.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99999.000,1),
  (176,'CHILES RAJAS 1 KG',0,0,3,'x','','','','',1,12.50,150.00,12,0.00,0.00,0,1,12.83,154.00,12.83,154.00,12.83,154.00,12.83,154.00,12.83,154.00,12.83,154.00,12.83,154.00,0.000,0.000,99999.000,1),
  (177,'CHORIZO OMAR',1,0,1,'x','','','','',2,0.00,0.00,0,22.00,1.00,0,0,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,0.000,0.000,99999.000,1),
  (178,'CHORIZO CAMPESTRE',1,0,1,'x','','','','',2,0.00,0.00,0,55.00,1.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (179,'CHILES RAJAS LA TORRE 2.800 kg',0,0,3,'x','','','','',1,32.00,0.00,0,0.00,0.00,1,0,35.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,99999.000,1),
  (180,'CHORIZO RIOJANO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,32.76,1.00,1,0,35.50,0.00,33.50,0.00,33.50,0.00,33.50,0.00,33.50,0.00,33.50,0.00,33.50,0.00,0.000,0.000,99999.000,1),
  (181,'QUESO ASADERO CASA BLANCA 1 KG',1,0,1,'GIC960719217','','','','',2,0.00,0.00,0,26.80,1.00,0,0,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,9999.000,1),
  (182,'QUESO BOTANERO',1,0,1,'x','','','','',2,0.00,0.00,0,55.00,1.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,9999.000,1),
  (183,'QUESO BRIE ARTESANAL 260',0,0,1,'x','','','','',1,46.00,0.00,0,0.00,0.00,0,0,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,0.000,0.000,9999.000,1),
  (184,'QUESO CHEDDAR',0,0,1,'x','','','','',1,80.00,0.00,0,0.00,0.00,0,0,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,0.000,0.000,99999.000,1),
  (185,'QUESO COTTAGE LYNCOTT',0,0,1,'x','','','','',1,150.00,0.00,0,0.00,0.00,0,0,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,0.000,0.000,99997.000,1),
  (186,'QUESO COTTAGE LYNCOTT 380 GR',0,0,1,'x','','','','',1,24.00,0.00,0,0.00,0.00,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,99999.000,1),
  (187,'QUESO CREMA',0,0,1,'x','','','','',1,40.00,0.00,0,0.00,0.00,0,0,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,0.000,0.000,99997.000,1),
  (188,'QUESO CREMA DE UNTAR 4 KG',0,0,1,'x','','','','',1,175.00,0.00,0,0.00,0.00,0,0,182.00,0.00,182.00,0.00,182.00,0.00,182.00,0.00,182.00,0.00,182.00,0.00,182.00,0.00,0.000,0.000,9999.000,1),
  (189,'QUESO DE CABRA',0,0,1,'x','','','','',1,21.00,0.00,0,0.00,0.00,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,99999.000,1),
  (190,'QUESO FETA',1,0,1,'x','','','','',2,0.00,0.00,0,38.00,1.00,0,0,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,0.000,0.000,9999.000,1),
  (191,'QUESO FUNDIDO QUENACHO 1 KG',0,0,1,'x','','','','',1,9.00,90.00,10,0.00,0.00,1,1,11.00,100.00,10.00,100.00,9.80,98.00,9.80,98.00,9.80,98.00,9.80,98.00,9.80,98.00,0.000,0.000,99999.000,1),
  (192,'QUESO FUNDIDO RANCHERITO',0,0,1,'x','','','','',1,10.50,105.00,10,0.00,0.00,1,1,12.00,118.00,11.80,118.00,11.80,118.00,11.80,118.00,11.80,118.00,11.80,118.00,10.60,106.00,0.000,0.000,9989.000,1),
  (193,'QUESO GROULLER',1,0,1,'x','','','','',2,0.00,0.00,0,84.00,1.00,0,0,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,0.000,0.000,9999.000,1),
  (194,'CERVEZA CORONA FAMILIAR',0,1,2,'x','','','','',1,12.92,155.00,12,0.00,0.00,1,1,15.00,160.00,13.33,160.00,13.17,158.00,13.00,156.00,13.00,156.00,13.00,156.00,13.00,156.00,0.000,0.000,99843.000,1),
  (195,'CERVEZA MODELO 340 ML',0,1,2,'x','','','','',1,6.67,160.00,24,0.00,0.00,1,1,10.00,170.00,9.17,170.00,7.00,168.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,0.000,0.000,99756.000,1),
  (196,'BOTES',0,0,1,'x','','','','',1,10.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (197,'CHILE CHIPOTLE SAN MARCOS 1/8',0,0,3,'x','','','','',1,145.00,0.00,0,0.00,0.00,0,0,155.00,0.00,155.00,0.00,155.00,0.00,155.00,0.00,155.00,0.00,155.00,0.00,155.00,0.00,0.000,0.000,99999.000,1),
  (198,'CHILE CHIPOTLE SAN MARCOS 2.8',0,0,3,'x','','','','',1,75.00,0.00,0,0.00,0.00,0,0,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,85.00,0.00,0.000,0.000,99999.000,1),
  (199,'CHILES CHIPOTLES SAN MARCOS 380 GR',0,0,3,'x','','','','',1,275.00,0.00,0,0.00,0.00,0,0,288.00,0.00,288.00,0.00,288.00,0.00,288.00,0.00,288.00,0.00,288.00,0.00,288.00,0.00,0.000,0.000,99999.000,1),
  (200,'CHILES EN VINAGRE',0,0,3,'x','','','','',1,8.60,215.00,25,0.00,0.00,0,1,13.00,219.00,13.00,219.00,13.00,219.00,13.00,219.00,13.00,219.00,13.00,219.00,13.00,219.00,0.000,0.000,99999.000,1),
  (201,'CHILES GUEROS',1,0,3,'x','','','','',2,0.00,0.00,0,35.00,25.00,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,0.000,0.000,99999.000,1),
  (202,'CHILES JALAPEÑOS CLEMENTE JAQU 220',0,0,3,'x','','','','',1,3.13,75.00,24,0.00,0.00,1,1,4.50,80.00,3.33,80.02,3.33,80.02,3.33,80.02,3.33,80.02,3.33,80.02,3.33,80.02,0.000,0.000,99999.000,1),
  (203,'CHILES JALAPEÑOS CLEMENTE JAQUE 780',0,0,3,'x','','','','',1,9.58,115.00,12,0.00,0.00,1,1,12.00,121.00,10.08,121.00,10.08,121.00,10.08,121.00,10.08,121.00,10.08,121.00,10.08,121.00,0.000,0.000,99998.000,1),
  (204,'CHILES JALAPEÑOS LA COSTEÑA 2.8 KG',0,0,3,'x','','','','',1,25.00,0.00,0,0.00,0.00,1,0,27.50,0.00,27.00,0.00,26.50,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,0.000,0.000,99997.000,1),
  (205,'CHILES JALAPEÑOS PICADOS COSTEÑA 3',0,0,3,'x','','','','',1,40.00,240.00,6,0.00,0.00,1,1,46.00,260.00,43.33,260.00,43.33,260.00,43.33,260.00,43.33,260.00,43.33,260.00,43.33,260.00,0.000,0.000,9999.000,1),
  (206,'CHILES LARGOS EN ESCABECHE 2.8',0,0,3,'x','','','','',1,40.00,0.00,0,0.00,0.00,0,0,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,0.000,0.000,99999.000,1),
  (207,'CHILES NACHOS 800 GR',0,0,3,'x','','','','',1,10.00,0.00,0,0.00,0.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,99999.000,1),
  (208,'CHILES NACHOS COSTEÑA 2.8 GR',0,0,3,'x','','','','',1,39.67,238.00,6,0.00,0.00,1,1,43.00,258.00,42.50,255.00,42.50,255.00,42.50,255.00,42.50,255.00,42.50,255.00,40.00,240.00,0.000,0.000,99999.000,1),
  (209,'CHILES RAJAS CLEMENTE JAQUES 220',0,0,3,'x','','','','',1,3.13,75.00,24,0.00,0.00,1,1,4.50,80.00,3.33,80.02,3.33,80.02,3.33,80.02,3.33,80.02,3.33,80.02,3.33,80.02,0.000,0.000,99999.000,1),
  (210,'CHILES RAJAS CLEMENTE JACQUES 380',0,0,3,'x','','','','',1,4.91,118.00,24,0.00,0.00,1,1,6.50,156.00,5.04,121.01,5.04,121.01,5.04,121.01,5.04,121.01,5.04,121.01,5.04,121.01,0.000,0.000,99999.000,1),
  (211,'CHILES RAJAS LA COSTEÑA 380 GR',0,0,1,'x','','','','',1,6.88,165.00,24,0.00,0.00,1,1,7.50,168.00,7.00,168.00,7.00,168.00,7.00,168.00,7.00,168.00,7.00,168.00,7.00,168.00,0.000,0.000,999999.000,1),
  (212,'CHILES RAJAS COSTEÑA 250 GR',0,0,3,'x','','','','',1,4.16,200.00,48,0.00,0.00,0,1,4.29,206.00,4.29,206.00,4.29,206.00,4.29,206.00,4.29,206.00,4.29,206.00,4.29,206.00,0.000,0.000,999999.000,1),
  (213,'CHILES RAJAS COSTEÑA 3',0,0,1,'x','','','','',1,36.66,220.00,6,0.00,0.00,1,1,39.00,231.00,38.50,231.00,38.50,231.00,38.50,231.00,38.50,231.00,38.50,231.00,37.50,225.00,0.000,0.000,999992.000,1),
  (214,'CHILES RAJAS COSTEÑA 800 GR',0,0,3,'x','','','','',1,12.08,145.00,12,0.00,0.00,1,1,13.55,162.60,12.67,152.00,12.67,152.00,12.67,152.00,12.67,152.00,12.67,152.00,12.67,152.00,0.000,0.000,99999.000,1),
  (215,'CHILES RAJAS VITROLERO',0,0,1,'x','','','','',1,25.00,0.00,0,0.00,0.00,0,0,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,0.000,0.000,99999.000,1),
  (216,'CHILES CHIPOTLES COSTEÑA 220 GR',0,0,3,'x','','','','',1,185.00,0.00,0,0.00,0.00,0,0,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,0.000,0.000,99999.000,1),
  (217,'CHILE CHIPOTLE SAN MARCOS 215 GR',0,0,3,'x','','','','',1,330.00,0.00,0,0.00,0.00,0,0,335.00,0.00,335.00,0.00,335.00,0.00,335.00,0.00,335.00,0.00,335.00,0.00,335.00,0.00,0.000,0.000,99999.000,1),
  (218,'CHISTORRA',0,0,1,'x','','','','',1,58.00,0.00,0,0.00,0.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (219,'CHOCOLATE ABUELITA 6/90 GR',0,0,3,'x','','','','',1,26.10,628.00,24,0.00,0.00,0,1,30.00,635.00,30.00,635.00,30.00,635.00,30.00,635.00,30.00,635.00,30.00,635.00,30.00,635.00,0.000,0.000,99999.000,1),
  (220,'CHORIZO RIVERA',1,0,1,'x','','','','',2,0.00,0.00,0,23.00,1.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,9998.000,1),
  (221,'COCA COLA 600 ML',0,1,2,'x','','','','',1,4.92,118.00,24,0.00,0.00,1,1,6.00,132.00,5.50,132.00,5.46,131.00,5.42,130.00,5.38,129.00,5.38,129.00,5.00,120.00,0.000,0.000,99574.000,1),
  (222,'COCA COLA 1 LT',0,1,2,'x','','','','',1,7.33,88.00,12,0.00,0.00,1,1,9.00,108.00,7.58,91.00,7.58,91.00,7.58,91.00,7.58,91.00,7.58,91.00,7.58,91.00,0.000,0.000,0.000,0),
  (223,'COCA COLA DESECHABLE 2.5 LT',0,1,2,'x','','','','',1,13.75,110.00,8,0.00,0.00,1,1,16.00,118.00,14.75,118.00,14.75,118.00,14.75,118.00,14.75,118.00,14.75,118.00,14.25,114.00,0.000,0.000,99967.000,1),
  (224,'COCA COLA DE VIDRIO',0,1,2,'x','','','','',1,3.54,85.00,24,0.00,0.00,1,1,5.00,120.00,4.17,100.00,4.17,100.00,4.17,100.00,4.17,100.00,4.17,100.00,4.17,100.00,0.000,0.000,99879.000,1),
  (225,'COCA COLA LATA 335 ML',0,1,2,'x','','','','',1,3.96,95.00,24,0.00,0.00,1,1,6.00,110.00,4.58,110.00,4.54,109.00,4.50,108.00,4.25,102.00,4.25,102.00,4.25,102.00,0.000,0.000,99819.000,1),
  (226,'COCA COLA LATA 237 ML',0,1,2,'x','','','','',1,2.92,70.00,24,0.00,0.00,1,1,3.50,84.00,3.13,75.00,3.13,75.00,3.13,75.00,3.13,75.00,3.13,75.00,3.13,75.00,0.000,0.000,99975.000,1),
  (227,'COCA COLA LATA LIGHT 335 ML',0,1,2,'x','','','','',1,4.79,115.00,24,0.00,0.00,1,1,6.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,4.92,118.01,0.000,0.000,99999.000,1),
  (228,'COCA COLA LIGHT 600 ML',0,1,2,'x','','','','',1,5.83,140.00,24,0.00,0.00,1,1,6.50,145.00,6.04,145.01,6.04,145.01,6.04,145.01,6.04,145.01,6.04,145.01,6.04,145.01,0.000,0.000,99999.000,1),
  (229,'CONSOME DE POLLO',0,0,3,'x','','','','',1,150.00,0.00,0,0.00,0.00,0,0,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,0.000,0.000,99999.000,1),
  (230,'CERVEZA CORONA BARRIL PICO DE ORO',0,1,2,'x','','','','',1,5.91,142.00,24,0.00,0.00,1,1,8.50,147.00,7.50,180.00,6.13,147.00,6.08,146.00,6.04,145.00,6.04,145.00,6.04,145.00,0.000,0.000,99951.000,1),
  (231,'CERVEZA CORONITA 325',0,1,2,'x','','','','',1,4.80,96.00,20,0.00,0.00,1,1,5.10,102.00,5.10,102.00,5.00,100.00,4.90,98.00,4.85,97.00,4.85,97.00,4.85,97.00,0.000,0.000,99939.000,1),
  (232,'CREMA BATIDA CHANTY 1 KG',0,0,1,'CAN710909PUA','','','','',1,21.00,0.00,0,0.00,0.00,1,0,25.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,0.000,0.000,9976.000,1),
  (233,'CREMA BATIDA CHANTY 5 KG',0,0,1,'CAN710909PUA','','','','',1,90.00,0.00,0,0.00,0.00,1,0,95.00,0.00,92.00,0.00,90.00,0.00,90.00,0.00,90.00,0.00,90.00,0.00,90.00,0.00,0.000,0.000,99997.000,1),
  (234,'CREMA BATIDA DULCIMA 1 KG',0,0,1,'x','','','','',1,20.00,0.00,0,0.00,0.00,0,0,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,0.000,0.000,99999.000,1),
  (235,'CREMA BATIDA DULCIMA 5 KG',0,0,1,'x','','','','',1,86.00,0.00,0,0.00,0.00,0,0,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,88.00,0.00,0.000,0.000,99999.000,1),
  (236,'CREMA CAMELIA 1 KG',0,0,1,'DMA0106263S9','','','','',1,8.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,9999.000,1),
  (237,'CREMA LYNCOTT',0,0,1,'x','','','','',1,30.00,0.00,0,0.00,0.00,0,0,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,0.000,0.000,99999.000,1),
  (238,'CREMA VEGETAL RANCHERITA 900 ML',0,0,1,'x','','','','',1,13.75,165.00,12,0.00,0.00,0,1,14.00,168.00,14.00,168.00,14.00,168.00,14.00,168.00,14.00,168.00,14.00,168.00,14.00,168.00,0.000,0.000,99999.000,1),
  (239,'CREMA VENECIA 1 KG',0,0,1,'x','','','','',1,5.00,60.00,12,0.00,0.00,1,1,6.00,65.00,5.42,65.00,5.42,65.00,5.42,65.00,5.42,65.00,5.42,65.00,5.42,65.00,0.000,0.000,99999.000,1),
  (240,'CREMERO LYNCOTT',0,0,1,'x','','','','',1,57.00,0.00,0,0.00,0.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (241,'CUERITOS GRANDE',0,0,1,'x','','','','',1,10.00,0.00,0,0.00,0.00,1,0,16.00,0.00,16.00,0.00,15.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,99997.000,1),
  (242,'CUERITOS JUMBO',0,0,1,'x','','','','',1,13.00,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99999.000,1),
  (243,'DANONINO',0,0,1,'VAPB730831UM9','','','','',1,7.66,184.00,24,0.00,0.00,1,1,8.50,190.00,8.00,192.00,7.92,190.00,7.80,187.20,7.92,190.01,7.92,190.01,7.92,190.01,0.000,0.000,99956.000,1),
  (244,'DURAZNOS  820 GR',0,0,3,'VAM051215JV8','','','','',1,12.09,290.00,24,0.00,0.00,0,0,13.00,0.00,13.00,0.00,13.00,0.00,13.00,0.00,13.00,0.00,13.00,0.00,13.00,0.00,0.000,0.000,99999.000,1),
  (245,'DURAZNOS EN ALMIBAR 820 GR',0,0,3,'x','','','','',1,12.00,288.00,24,0.00,0.00,1,1,13.00,300.00,12.50,300.00,12.50,300.00,12.50,300.00,12.50,300.00,12.50,300.00,12.50,300.00,0.000,0.000,99997.000,1),
  (246,'DURAZNOS EN ALMIBAR 3 KG',0,0,3,'x','','','','',1,45.00,270.00,6,0.00,0.00,1,1,50.00,300.00,48.67,292.00,48.67,292.00,48.67,292.00,48.67,292.00,48.67,292.00,48.67,292.00,0.000,0.000,99998.000,1),
  (247,'DURAZNO EN TROZO 4.25 KG',0,0,3,'x','','','','',1,56.66,240.00,6,0.00,0.00,1,1,58.50,345.00,57.50,345.00,57.50,345.00,57.50,345.00,57.50,345.00,57.50,345.00,57.50,345.00,0.000,0.000,99999.000,1),
  (248,'DURAZNO EN MITADES COSTEÑA 820 GR',0,0,3,'x','','','','',1,20.00,240.00,12,0.00,0.00,1,1,23.00,245.00,20.42,245.00,20.42,245.00,20.42,245.00,20.42,245.00,20.42,245.00,20.42,245.00,0.000,0.000,99999.000,1),
  (249,'DURAZNOS EN ALMIBAR LA TORRE 3 KG',0,0,3,'x','','','','',1,48.33,290.00,6,0.00,0.00,1,1,52.00,298.00,49.67,298.00,49.67,298.00,49.67,298.00,49.67,298.00,49.67,298.00,49.67,298.00,0.000,0.000,99999.000,1),
  (250,'DURAZNOS EN TROZO 3 KG',0,0,3,'','','','','x',1,55.84,335.00,6,0.00,0.00,1,1,60.00,348.00,58.00,348.00,58.00,348.00,58.00,348.00,58.00,348.00,58.00,348.00,58.00,348.00,300.000,150.000,99999.000,1),
  (251,'GRANO DE ELOTE CLEMENTE JACQUES 220',0,0,3,'x','','','','',1,3.75,90.00,24,0.00,0.00,1,1,6.00,100.00,4.17,100.01,4.17,100.01,4.17,100.01,4.17,100.01,4.17,100.01,4.17,100.01,0.000,0.000,99999.000,1),
  (252,'ENSALADA DE VERDURAS 3 KG',0,0,3,'x','','','','',1,36.66,220.00,6,0.00,0.00,0,1,38.00,228.00,38.00,228.00,38.00,228.00,38.00,228.00,38.00,228.00,38.00,228.00,38.00,228.00,0.000,0.000,99993.000,1),
  (253,'FRIJOLES LA TORRE 3 KG',0,0,1,'x','','','','',1,30.00,180.00,6,0.00,0.00,1,1,39.00,200.00,38.00,228.00,37.00,222.00,36.00,216.00,35.00,210.00,34.00,204.00,30.83,185.00,0.000,0.000,999999.000,1),
  (254,'FRIJOLES BAYOS LA COSTEÑA 3 KG',0,0,3,'x','','','','',1,35.50,213.00,6,0.00,0.00,1,1,39.00,218.00,36.33,218.00,36.33,218.00,36.33,218.00,36.33,218.00,36.33,218.00,36.33,218.00,0.000,0.000,99999.000,1),
  (255,'FRIJOLES BAYOS SIRRA',0,0,3,'x','','','','',1,6.16,74.00,12,0.00,0.00,1,1,8.00,77.00,6.42,76.99,6.42,76.99,6.42,76.99,6.42,76.99,6.42,76.99,6.42,76.99,0.000,0.000,99999.000,1),
  (256,'FRIJOLES REFRITOS 580 GR',0,0,3,'x','','','','',1,7.08,85.00,12,0.00,0.00,1,1,8.00,95.00,7.92,94.99,7.92,94.99,7.92,94.99,7.92,94.99,7.92,94.99,7.42,89.00,0.000,0.000,9999.000,1),
  (257,'FRUTSI',0,1,2,'x','','','','',1,1.75,42.00,24,0.00,0.00,1,1,3.50,48.50,2.02,48.50,2.02,48.50,2.02,48.50,2.02,48.50,2.02,48.50,1.75,42.00,0.000,0.000,99807.000,1),
  (258,'GALLETAS MARIAS 10/1 KG',0,0,3,'OCM870210PC6','','','','',1,18.00,180.00,10,0.00,0.00,0,1,18.50,185.00,18.50,185.00,18.50,185.00,18.50,185.00,18.50,185.00,18.50,185.00,18.50,185.00,100.000,50.000,99999.000,1),
  (259,'GALLETAS SALADAS',0,0,3,'OCM870210PC6','','','','',1,50.00,0.00,0,0.00,0.00,0,0,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,0.000,0.000,99999.000,1),
  (260,'GELATINA MOZAICO',0,0,1,'x','','','','',1,4.00,0.00,0,0.00,0.00,0,0,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,0.000,0.000,99987.000,1),
  (261,'GELATINA VITROLERO',0,0,1,'x','','','','',1,30.00,0.00,0,0.00,0.00,0,0,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,0.000,0.000,0.000,0),
  (262,'JUGO GENERICA DEL VALLE',0,0,2,'x','','','','',1,4.58,110.00,24,0.00,0.00,1,1,6.00,120.00,5.00,120.00,4.92,118.00,4.88,117.00,4.58,110.00,4.58,110.00,4.58,110.00,0.000,0.000,999771.000,1),
  (263,'GLAZE 1 KG',0,0,1,'x','','','','',1,20.00,0.00,0,0.00,0.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,99999.000,1),
  (264,'GLAZE 5 KG',0,0,1,'x','','','','',1,68.00,0.00,0,0.00,0.00,0,0,72.00,0.00,72.00,0.00,72.00,0.00,72.00,0.00,72.00,0.00,72.00,0.00,72.00,0.00,0.000,0.000,999999.000,1),
  (265,'GRANO DE ELOTE 3 KG',0,0,3,'x','','','','',1,40.00,240.00,6,0.00,0.00,1,1,45.00,270.00,42.50,255.00,42.50,255.00,42.50,255.00,42.50,255.00,42.50,255.00,42.50,255.00,0.000,0.000,99999.000,1),
  (266,'GRANO DE ELOTE CLEMENTE JAQUES 410',0,0,3,'x','','','','',1,6.25,150.00,24,0.00,0.00,1,1,9.00,155.00,6.46,154.99,6.46,154.99,6.46,154.99,6.46,154.99,6.46,154.99,6.46,154.99,0.000,0.000,99999.000,1),
  (267,'GRANO DE ELOTE COSTEÑA 410',0,0,3,'x','','','','',1,7.92,190.00,24,0.00,0.00,1,1,9.00,195.00,8.13,195.00,8.13,195.00,8.13,195.00,8.13,195.00,8.13,195.00,8.13,195.00,0.000,0.000,99999.000,1),
  (268,'HARINA DE TRIGO',0,0,3,'x','','','','',1,8.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (269,'HERSHEY 250 ML',0,0,1,'x','','','','',1,4.62,125.00,27,0.00,0.00,1,1,5.50,130.00,4.82,130.01,4.82,130.01,4.82,130.01,4.82,130.01,4.82,130.01,4.74,128.00,0.000,0.000,999945.000,1),
  (270,'JAMON AMERICANO MANDOLINA HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,25.00,6.00,1,0,30.00,0.00,29.00,0.00,29.00,0.00,29.00,0.00,29.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,99999.000,1),
  (271,'JAMON AMERICANO OV HACIENDA',1,0,1,'x','','','','',2,0.00,0.00,0,23.00,5.00,1,0,25.50,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,99999.000,1),
  (272,'JAMON COCIDO OV HACIENDA',1,0,1,'x','','','','',2,0.00,0.00,0,22.00,5.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,99999.000,1),
  (273,'JAMON COCIDO OV HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,16.00,5.00,0,0,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,0.000,0.000,99999.000,1),
  (274,'JAMON DE PAVO OV HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,34.00,5.00,1,0,40.00,0.00,36.50,0.00,36.50,0.00,36.50,0.00,36.50,0.00,36.50,0.00,35.00,0.00,100.000,50.000,99989.820,1),
  (275,'JAMON JAROCHO',1,0,1,'EHC951010S36','','','','',2,0.00,0.00,0,17.00,5.00,1,0,22.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,0.000,0.000,99984.020,1),
  (276,'LECHE EVAPORADA CLAVEL 410 GR',0,0,3,'GAA970226DL8','','','','',1,7.66,367.70,48,0.00,0.00,1,1,8.30,380.00,7.92,380.00,7.92,380.00,7.92,380.00,7.92,380.00,7.92,380.00,7.92,380.00,0.000,0.000,9990.000,1),
  (277,'LECHE TAMARIZ',0,0,1,'x','','','','',1,6.16,74.00,12,0.00,0.00,1,1,7.00,77.00,6.42,77.00,6.42,77.00,6.42,77.00,6.42,77.00,6.42,77.00,6.42,77.00,0.000,0.000,9999.000,1),
  (278,'LECHERA',1,0,1,'x','','','','',2,0.00,0.00,0,17.40,25.00,1,2,22.00,525.00,22.00,525.00,21.00,525.00,20.00,525.00,20.00,525.00,20.00,525.00,20.00,525.00,0.000,0.000,99985.239,1),
  (279,'LECHE CONDENSADA G LARA',0,0,1,'x','','','','',1,430.00,0.00,0,0.00,0.00,1,0,460.00,0.00,435.00,0.00,435.00,0.00,435.00,0.00,435.00,0.00,435.00,0.00,435.00,0.00,0.000,0.000,9999.000,1),
  (280,'LECHERA NESTLE 100 GR',0,0,3,'x','','','','',1,7.00,0.00,0,0.00,0.00,0,0,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,0.000,0.000,99999.000,1),
  (281,'NESCAFE 1 KG',0,0,1,'x','','','','',1,180.00,720.00,4,0.00,0.00,0,1,185.00,740.00,185.00,740.00,185.00,740.00,185.00,740.00,185.00,740.00,185.00,740.00,185.00,740.00,0.000,0.000,99999.000,1),
  (282,'NESCAFE C/LECHE 0.010 GR',0,0,1,'x','','','','',1,47.00,0.00,0,0.00,0.00,0,0,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,0.000,0.000,99999.000,1),
  (283,'NESCAFE CLASICO 50 GR',0,0,1,'x','','','','',1,12.73,152.70,12,0.00,0.00,0,1,13.00,156.00,13.00,156.00,13.00,156.00,13.00,156.00,13.00,156.00,13.00,156.00,13.00,156.00,0.000,0.000,99999.000,1),
  (284,'NESCAFE CLASICO 100 GR',0,0,3,'x','','','','',1,22.58,542.00,24,0.00,0.00,1,1,25.00,550.00,22.92,550.01,22.92,550.01,22.92,550.01,22.92,550.01,22.92,550.01,22.92,550.01,0.000,0.000,99999.000,1),
  (285,'YOGHURT ACTIVIA 250 ML',0,0,1,'VAPB730831UM9','','','','',1,6.43,180.00,28,0.00,0.00,1,1,7.00,190.00,6.79,190.00,6.71,188.00,6.64,186.00,6.61,185.00,6.61,185.00,6.61,185.00,0.000,0.000,99972.000,1),
  (286,'AGUA CIEL 1.5',0,0,2,'x','','','','',1,3.33,40.00,12,0.00,0.00,1,0,7.00,0.00,4.17,0.00,4.08,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (287,'AGUA CIEL 500 ML',0,0,2,'x','','','','',1,1.88,45.00,24,0.00,0.00,1,1,3.50,50.00,2.08,49.99,2.04,49.00,2.00,48.00,2.00,48.00,2.00,48.00,2.00,48.00,0.000,0.000,99999.000,1),
  (288,'AGUA CIEL 5 LT',0,0,2,'x','','','','',1,9.00,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,99999.000,1),
  (289,'AGUA DE LOS ALPES 19 LT',0,0,2,'x','','','','',1,14.00,0.00,0,0.00,0.00,0,0,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,0.000,0.000,99999.000,1),
  (290,'AGUA DE LOS ALPES 500 ML',0,0,2,'x','','','','',1,1.20,29.00,24,0.00,0.00,1,1,2.50,60.00,1.46,34.99,1.42,34.01,1.33,31.99,1.33,31.99,1.33,31.99,1.33,31.99,0.000,0.000,99999.000,1),
  (291,'YOGHURT CLASICO LALA 1 KG',0,0,1,'x','','','','',1,14.00,0.00,0,0.00,0.00,1,0,18.00,0.00,18.00,0.00,17.00,0.00,16.00,0.00,15.50,0.00,15.50,0.00,15.50,0.00,0.000,0.000,99993.000,1),
  (292,'YOGHURT CREMIFRUT 125 GR',0,0,1,'x','','','','',1,2.00,96.00,48,0.00,0.00,1,1,2.30,103.00,2.15,103.00,2.13,102.00,2.11,101.00,2.11,101.00,2.11,101.00,2.11,101.00,0.000,0.000,99973.000,1),
  (293,'YOGHURT DANUP 250 ML',0,0,1,'VAPB730831UM9','','','','',1,4.92,138.00,28,0.00,0.00,1,1,5.80,142.00,5.07,141.99,5.07,141.99,5.07,141.99,5.07,141.99,5.07,141.99,5.07,141.99,0.000,0.000,0.000,0),
  (294,'YOGHURT DULAIT 4 LT',0,0,1,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,0.000,0.000,9999.000,1),
  (295,'YOGHURT DULAIT 1 LT',0,0,1,'x','','','','',1,8.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (296,'YOGHURT NORMEX 4 LT',0,0,1,'x','','','','',1,55.00,0.00,0,0.00,0.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (297,'YOGHURT PALMALAC 1 LT',0,0,1,'PAL860319A25','','','','',1,18.00,0.00,0,0.00,0.00,1,0,20.00,0.00,20.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,0.000,0.000,99999.000,1),
  (298,'YOGHURT PALMALAC 20 LT',0,0,1,'PAL860319A25','','','','',1,285.00,0.00,0,0.00,0.00,1,0,305.00,0.00,305.00,0.00,300.00,0.00,298.00,0.00,298.00,0.00,298.00,0.00,298.00,0.00,0.000,0.000,99999.000,1),
  (299,'YOGHURT PARA BEBER LALA 250 ML',0,0,1,'x','','','','',1,4.66,112.00,24,0.00,0.00,1,1,5.00,115.00,4.79,115.01,4.79,115.01,4.79,115.01,4.79,115.01,4.79,115.01,4.79,115.01,0.000,0.000,99980.000,1),
  (300,'YOGHURT VITALINEA 150 GR',0,0,1,'VAPB730831UM9','','','','',1,4.58,220.00,48,0.00,0.00,1,1,4.80,230.50,4.80,230.50,4.80,230.50,4.80,230.50,4.80,230.50,4.80,230.50,4.80,230.50,0.000,0.000,99999.000,1),
  (301,'YOGHURT VITALINEA LT',0,0,1,'x','','','','',1,16.00,0.00,0,0.00,0.00,0,0,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,0.000,0.000,99999.000,1),
  (302,'YOGHURT YOFRUT ALPURA 250 ML',0,0,1,'GPL860521FW8','','','','',1,4.45,107.00,24,0.00,0.00,1,1,5.00,110.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,0.000,0.000,99999.000,1),
  (303,'YOGHURT YOPLAIT 150 GR',0,0,1,'GPL860521FW8','','','','',1,2.50,60.00,24,0.00,0.00,1,1,3.00,65.00,2.71,65.00,2.71,65.00,2.71,65.00,2.71,65.00,2.71,65.00,2.71,65.00,0.000,0.000,99995.000,1),
  (304,'YOGHURT YOPLAIT 1 LT',0,0,1,'GPL860521FW8','','','','',1,14.00,0.00,0,0.00,0.00,1,0,20.00,0.00,19.00,0.00,18.00,0.00,17.00,0.00,16.00,0.00,15.00,0.00,15.00,0.00,0.000,0.000,99999.000,1),
  (305,'YOMI LALA 90 GR',0,0,1,'x','','','','',1,1.50,108.00,72,0.00,0.00,1,1,1.64,118.00,1.63,117.00,1.61,116.00,1.61,116.00,1.61,116.00,1.61,116.00,1.61,116.00,0.000,0.000,99835.000,1),
  (306,'YOGHURT ALPURA 150 ML',0,0,1,'GPL860521FW8','','','','',1,2.66,64.00,24,0.00,0.00,1,1,3.00,68.00,2.83,68.00,2.75,66.00,2.71,65.00,2.71,65.00,2.71,65.00,2.71,65.00,0.000,0.000,99691.000,1),
  (307,'TORTILLINA TIA ROSA 10 PZ',0,0,1,'BIMBO','','','','',1,5.60,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99999.000,1),
  (308,'TOSTADA X CIENTO',0,0,1,'x','','','','',1,32.00,160.00,5,0.00,0.00,1,1,35.00,163.00,32.60,163.00,32.60,163.00,32.60,163.00,32.60,163.00,32.60,163.00,32.60,163.00,0.000,0.000,99999.000,1),
  (309,'TORTILLA DE HARINA',0,0,1,'x','','','','',1,8.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (310,'SAPA MARUCHAN',0,0,3,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (311,'SERVILLETAS',0,1,3,'x','','','','',1,13.33,160.00,12,0.00,0.00,1,1,14.00,165.00,13.75,165.00,13.75,165.00,13.75,165.00,13.75,165.00,13.75,165.00,13.75,165.00,0.000,0.000,99999.000,1),
  (312,'SALSA VALENTINA AMARILLA 370 ML',0,0,3,'x','','','','',1,3.54,85.00,24,0.00,0.00,1,1,4.00,90.00,3.75,90.00,3.75,90.00,3.75,90.00,3.75,90.00,3.75,90.00,3.75,90.00,0.000,0.000,999999.000,1),
  (313,'SALSA VALENTINA AMARILLA 1 LT',0,0,3,'x','','','','',1,7.66,92.00,12,0.00,0.00,1,1,9.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,8.00,96.00,0.000,0.000,99999.000,1),
  (314,'SALSA VALENTINA NEGRA 370 ML',0,0,3,'x','','','','',1,3.95,95.00,24,0.00,0.00,1,1,5.00,99.00,4.13,99.00,4.13,99.00,4.13,99.00,4.13,99.00,4.13,99.00,4.13,99.00,0.000,0.000,99999.000,1),
  (315,'SALSA VALENTINA NEGRA 1 LT',0,0,3,'x','','','','',1,8.33,100.00,12,0.00,0.00,1,1,9.50,104.00,8.67,104.00,8.67,104.00,8.67,104.00,8.67,104.00,8.67,104.00,8.67,104.00,0.000,0.000,99999.000,1),
  (316,'SALSA CATSUP CLEMENTE 3.1',0,0,3,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,0.000,0.000,99999.000,1),
  (317,'SALSA CATSUP CLEMENTE JACQUES 1 KG',0,0,3,'x','','','','',1,12.91,155.00,12,0.00,0.00,1,1,15.00,160.00,13.33,160.00,13.33,160.00,13.33,160.00,13.33,160.00,13.33,160.00,13.33,160.00,0.000,0.000,999999.000,1),
  (318,'SALSA CATSUP COSTEÑA 3.250 KG',0,0,3,'x','','','','',1,39.00,234.00,6,0.00,0.00,1,1,42.50,253.00,42.17,253.00,42.00,252.00,41.00,246.00,40.00,240.00,40.00,240.00,40.00,240.00,0.000,0.000,99999.000,1),
  (319,'SALSA CATSUP MEGARIKA 3.8 KG',0,0,3,'x','','','','',1,32.67,196.00,6,0.00,0.00,0,1,35.00,210.00,35.00,210.00,35.00,210.00,35.00,210.00,35.00,210.00,35.00,210.00,35.00,210.00,0.000,0.000,99999.000,1),
  (320,'SALSA CATSUP PORCION',0,0,3,'x','','','','',1,135.00,0.00,0,0.00,0.00,0,0,140.00,0.00,140.00,0.00,140.00,0.00,140.00,0.00,140.00,0.00,140.00,0.00,140.00,0.00,0.000,0.000,99999.000,1),
  (321,'SALSA CATSUP  PREMIER 4.5 KG',0,0,3,'x','','','','',1,37.50,0.00,0,0.00,0.00,0,0,41.50,0.00,41.50,0.00,41.50,0.00,41.50,0.00,41.50,0.00,41.50,0.00,41.50,0.00,100.000,50.000,99993.000,1),
  (322,'SALSA INGLESA 980 ML',0,0,3,'x','','','','',1,17.00,0.00,0,0.00,0.00,0,0,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,0.000,0.000,999999.000,1),
  (323,'SALSA INGLESA 145 ML',0,0,3,'x','','','','',1,15.00,0.00,0,0.00,0.00,0,0,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,18.50,0.00,0.000,0.000,99999.000,1),
  (324,'SALAMI HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,27.50,1.00,1,0,29.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.50,0.00,0.000,0.000,99999.000,1),
  (325,'SALCHICHA COCKTAIL FUD',1,0,1,'x','','','','',2,0.00,0.00,0,26.00,2.50,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,999999.000,1),
  (326,'SALCHICHA ALYS',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,12.20,2.50,1,0,14.00,0.00,12.90,0.00,12.90,0.00,12.90,0.00,12.90,0.00,12.90,0.00,12.90,0.00,0.000,0.000,999999.000,1),
  (327,'SALCHICHA CAFRISA',1,0,1,'x','','','','',2,0.00,0.00,0,11.00,2.50,0,0,11.90,0.00,11.90,0.00,11.90,0.00,11.90,0.00,11.90,0.00,11.90,0.00,11.90,0.00,0.000,0.000,99999.000,1),
  (328,'JAMON PIERNA   ZWAN',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,73.50,6.00,0,0,76.00,0.00,76.00,0.00,76.00,0.00,76.00,0.00,76.00,0.00,76.00,0.00,76.00,0.00,100.000,50.000,999999.000,1),
  (329,'SALCHICHA COCKTAIL MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,25.00,2.50,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,999999.000,1),
  (330,'SALCHICHA ESE',1,0,1,'x','','','','',2,0.00,0.00,0,20.00,2.50,1,2,23.00,52.00,22.50,52.00,22.00,52.00,22.00,52.00,22.00,52.00,22.00,52.00,22.00,47.00,0.000,0.000,999999.000,1),
  (331,'SALCHICHA OPERADORA FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,23.00,2.50,1,2,25.00,63.00,23.50,63.00,23.00,63.00,23.50,63.00,23.50,63.00,23.50,63.00,23.50,63.00,0.000,0.000,999995.860,1),
  (332,'SALCHICHA TORINO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,13.40,2.00,1,0,15.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,0.000,0.000,999998.000,1),
  (333,'SALCHICHA Z WAN',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,18.20,2.50,1,0,20.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,18.50,0.00,100.000,50.000,99999.000,1),
  (334,'SALCHIRICA',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,12.30,2.50,1,2,12.80,32.00,12.80,32.00,12.50,32.00,12.50,32.00,12.50,32.00,12.50,32.00,12.50,32.00,0.000,0.000,99999.000,1),
  (335,'SALMUERA 200 GR',0,0,1,'DLC050125K82','','','','',1,5.90,88.50,15,0.00,0.00,1,1,6.95,102.00,6.60,99.00,6.60,99.00,6.60,99.00,6.60,99.00,6.60,99.00,6.20,93.00,0.000,0.000,99945.000,1),
  (336,'SALMUERA DE PAVO 200 GR',0,0,1,'DLC050125K82','','','','',1,6.40,96.00,15,0.00,0.00,1,0,7.50,0.00,7.50,0.00,7.20,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99839.000,1),
  (337,'SALMUERA DE PAVO DOBLE',0,0,1,'DLC050125K82','','','','',1,12.40,0.00,0,0.00,0.00,0,0,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,0.000,0.000,99999.000,1),
  (338,'SALSA BOTANERA',0,0,3,'x','','','','',1,21.66,130.00,6,0.00,0.00,1,1,23.50,135.00,22.50,135.00,22.50,135.00,22.50,135.00,22.50,135.00,22.50,135.00,22.50,135.00,0.000,0.000,999999.000,1),
  (339,'SALSA CATSUP 100/8 GR',0,0,3,'x','','','','',1,22.00,0.00,0,0.00,0.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,999999.000,1),
  (340,'QUESO EMENTAL',1,0,1,'x','','','','',2,0.00,0.00,0,125.00,1.00,0,0,130.00,0.00,130.00,0.00,130.00,0.00,130.00,0.00,130.00,0.00,130.00,0.00,130.00,0.00,0.000,0.000,99999.000,1),
  (341,'QUESO EMENTAL',1,0,1,'x','','','','',2,0.00,0.00,0,49.00,0.50,0,0,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,0.000,0.000,99999.000,0),
  (342,'QUESO MOZARELLA CUBICADO',1,0,1,'x','','','','',2,0.00,0.00,0,460.00,1.00,1,0,475.00,0.00,475.00,0.00,470.00,0.00,465.00,0.00,465.00,0.00,465.00,0.00,465.00,0.00,0.000,0.000,99999.000,1),
  (343,'QUESO PROVOLETA',1,0,1,'x','','','','',2,0.00,0.00,0,90.00,1.00,0,0,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,999999.000,1),
  (344,'QUESO RIKOTA',1,0,1,'x','','','','',2,0.00,0.00,0,72.00,1.00,0,0,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,0.000,0.000,999999.000,1),
  (345,'QUESO AMARILLO',1,0,1,'x','','','','',2,0.00,0.00,0,28.00,1.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99999.000,1),
  (346,'QUESO AMARILLO BARRA COLONOS',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,51.70,2.00,0,0,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,0.000,0.000,99999.000,1),
  (347,'QUESO AMARILLO BARRA NORMEX',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,56.00,2.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (348,'QUESO AMARILLO BIOLAC 1.82',0,0,1,'GIC960719217','','','','',1,41.83,0.00,0,0.00,0.00,0,0,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,300.000,60.000,9999.000,1),
  (349,'QUESO AMARILLO BLUE HOUSE',0,0,1,'DMA0106263S9','','','','',1,50.00,0.00,0,0.00,0.00,0,0,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,0.000,0.000,9999.000,1),
  (350,'QUESO AMARILLO CASTELL',0,0,1,'x','','','','',1,40.00,240.00,6,0.00,0.00,1,1,45.00,245.00,40.00,240.00,40.00,240.00,40.00,240.00,40.00,240.00,40.00,240.00,40.00,240.00,0.000,0.000,9999.000,1),
  (351,'QUESO AMARILLO CHALET',0,0,1,'x','','','','',1,75.00,0.00,0,0.00,0.00,0,0,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,0.000,0.000,9999.000,1),
  (352,'QUESO AMARILLO CHIPILO',0,0,1,'x','','','','',1,57.83,347.00,6,0.00,0.00,1,1,63.00,378.00,63.00,378.00,62.00,372.00,60.00,360.00,60.00,360.00,60.00,360.00,60.00,360.00,0.000,0.000,9988.000,1),
  (353,'QUESO AMARILLO COLONOS',0,0,1,'DMA0106263S9','','','','',1,46.00,0.00,0,0.00,0.00,0,0,49.50,0.00,49.50,0.00,49.50,0.00,49.50,0.00,49.50,0.00,49.50,0.00,49.50,0.00,0.000,0.000,9999.000,1),
  (354,'QUESO AMARILLO PREMIER',0,0,1,'x','','','','',1,56.00,336.00,6,0.00,0.00,0,1,59.00,348.00,59.00,348.00,59.00,348.00,59.00,348.00,59.00,348.00,59.00,348.00,59.00,348.00,0.000,0.000,9999.000,1),
  (355,'QUESO MANCHEGO',1,0,1,'x','','','','',2,0.00,0.00,0,45.00,1.00,0,0,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,0.000,0.000,9995.000,1),
  (356,'QUESO MANCHEGO CAMPESINA',1,0,1,'x','','','','',2,0.00,0.00,0,46.00,2.00,1,0,55.00,0.00,53.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,1300.000,500.000,99990.580,1),
  (357,'QUESO MANCHEGO NOCHEBUENA 400 GR',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,60.00,0.40,1,0,64.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,0.000,0.000,9999.000,1),
  (358,'QUESO MANCHEGO NOCHEBUENA 4 KG',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,60.00,4.00,1,0,64.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,0.000,0.000,9994.420,1),
  (359,'QUESO MORRAL',1,0,1,'x','','','','',2,0.00,0.00,0,60.00,1.00,1,0,62.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (360,'QUESO OAXACA VAQUERO',1,0,1,'x','','','','',2,0.00,0.00,0,52.00,1.00,0,0,54.50,0.00,54.50,0.00,54.50,0.00,54.50,0.00,54.50,0.00,54.50,0.00,54.50,0.00,0.000,0.000,0.000,0),
  (361,'QUESO PARMESANO 227',0,0,1,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (362,'QUESO PARMESANO RAYADO',1,0,1,'x','','','','',2,0.00,0.00,0,75.00,1.00,0,0,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,0.000,0.000,999998.500,1),
  (363,'QUESO PHILADELPHIA 190 GR',0,0,1,'x','','','','',1,14.58,350.00,24,0.00,0.00,1,1,16.00,384.00,14.79,355.01,14.79,355.01,14.79,355.01,14.79,355.01,14.79,355.01,14.79,355.01,0.000,0.000,999983.000,1),
  (364,'QUESO PHILADELPHIA 1.9',0,0,1,'x','','','','',1,130.00,0.00,0,0.00,0.00,0,0,136.00,0.00,136.00,0.00,136.00,0.00,136.00,0.00,136.00,0.00,136.00,0.00,136.00,0.00,0.000,0.000,99999.000,1),
  (365,'QUESO PROBOLONE',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,75.00,1.00,0,0,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,0.000,0.000,999999.000,1),
  (366,'RECORTE DE JAMON',1,0,1,'x','','','','',2,0.00,0.00,0,10.00,1.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,99999.000,1),
  (367,'RECORTE DE QUESO',1,0,1,'x','','','','',2,0.00,0.00,0,15.00,1.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,99999.000,1),
  (368,'REQUESON',1,0,1,'x','','','','',2,0.00,0.00,0,8.00,1.00,1,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,7.00,0.00,0.000,0.000,999989.000,1),
  (369,'QUESO RICOTA NACIONAL',1,0,1,'x','','','','',2,0.00,0.00,0,75.00,1.00,0,0,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,0.000,0.000,999999.000,1),
  (370,'JAMON AMERICANO FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,21.80,5.00,1,2,37.00,165.00,35.00,165.00,34.50,165.00,34.50,165.00,34.50,165.00,34.50,165.00,34.50,165.00,0.000,0.000,99975.120,1),
  (371,'PAN BIMBO BLANCO CHICO',0,0,1,'BIMBO','','','','',1,9.15,0.00,0,0.00,0.00,0,0,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,0.000,0.000,999999.000,1),
  (372,'PAN BIMBO BLANCO GRANDE',0,0,1,'BIMBO','','','','',1,13.30,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99997.000,1),
  (373,'PAN BIMBO INTEGRAL CHICO',0,0,1,'BIMBO','','','','',1,9.85,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,9999.000,1),
  (374,'PAN BIMBO INTEGRAL GRANDE',0,0,1,'BIMBO','','','','',1,13.95,0.00,0,0.00,0.00,0,0,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,0.000,0.000,9999.000,1),
  (375,'PAN BIMBO MULTIGRANO 540 GR',0,0,1,'BIMBO','','','','',1,11.90,0.00,0,0.00,0.00,0,0,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,0.000,0.000,99999.000,1),
  (376,'PAN INTEGRAL DOBLE FIBRA MED',0,0,1,'BIMBO','','','','',1,9.85,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,99999.000,1),
  (377,'PAN INTEGRAL DOBLE FIBRA GRANDE',0,0,1,'BIMBO','','','','',1,11.90,0.00,0,0.00,0.00,0,0,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,0.000,0.000,99999.000,1),
  (378,'MEDIAS NOCHES 8 PZ',0,0,1,'BIMBO','','','','',1,9.00,0.00,0,0.00,0.00,0,0,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,0.000,0.000,99999.000,1),
  (379,'BIMBOLLOS 8 PZ',0,0,1,'BIMBO','','','','',1,13.10,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99999.000,1),
  (380,'BIMBOLLOS EXTRA 6 PZ',0,0,1,'BIMBO','','','','',1,12.30,0.00,0,0.00,0.00,0,0,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,0.000,0.000,99999.000,1),
  (381,'BIMBOLLOS EXTRA 15 PZ',0,0,1,'BIMBO','','','','',1,24.00,0.00,0,0.00,0.00,0,0,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,0.000,0.000,99999.000,1),
  (382,'PAN TOSTADO',0,0,1,'BIMBO','','','','',1,8.20,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (383,'PAN TOSTADO DOBLE FIBRA',0,0,1,'BIMBO','','','','',1,9.00,0.00,0,0.00,0.00,0,0,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,0.000,0.000,99999.000,1),
  (384,'PALITRIGOS',0,0,1,'BIMBO','','','','',1,5.30,0.00,0,0.00,0.00,0,0,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,0.000,0.000,9999.000,1),
  (385,'PALITRIGOS DOBLE FIBRA',0,0,1,'BIMBO','','','','',1,5.70,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,9999.000,1),
  (386,'PAN MOLIDO 210 GR',0,0,1,'BIMBO','','','','',1,4.10,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,9999.000,1),
  (387,'PAN MOLIDO 5 KG',0,0,1,'BIMBO','','','','',1,94.60,0.00,0,0.00,0.00,0,0,113.30,0.00,113.30,0.00,113.30,0.00,113.30,0.00,113.30,0.00,113.30,0.00,113.30,0.00,0.000,0.000,99999.000,1),
  (388,'TORTILLINA TIA ROSA 20 PZ',0,0,1,'BIMBO','','','','',1,10.80,0.00,0,0.00,0.00,0,0,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,0.000,0.000,99999.000,1),
  (389,'TORTILLA MILPA REAL 500 GR',0,0,1,'BIMBO','','','','',1,4.15,0.00,0,0.00,0.00,0,0,5.20,0.00,5.20,0.00,5.20,0.00,5.20,0.00,5.20,0.00,5.20,0.00,5.20,0.00,0.000,0.000,99999.000,1),
  (390,'TORTILLA TAQUERA 500 GR',0,0,1,'BIMBO','','','','',1,4.20,0.00,0,0.00,0.00,0,0,5.30,0.00,5.30,0.00,5.30,0.00,5.30,0.00,5.30,0.00,5.30,0.00,5.30,0.00,0.000,0.000,99999.000,1),
  (391,'TORTILLA NIXTAMALIZADA',0,0,1,'BIMBO','','','','',1,4.00,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (392,'TOSTADA PLANA 15 PZ',0,0,1,'BIMBO','','','','',1,4.50,0.00,0,0.00,0.00,0,0,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,99999.000,1),
  (393,'TOSTADA TUBO',0,0,1,'BIMBO','','','','',1,9.00,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,99999.000,1),
  (394,'ROLES DE CANELA 9 PZ',0,0,1,'BIMBO','','','','',1,12.95,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99999.000,1),
  (395,'ROLES DE CANELA 3 PZ',0,0,1,'BIMBO','','','','',1,4.85,0.00,0,0.00,0.00,0,0,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,99999.000,1),
  (396,'ROLES GLASEADOS 9 PZ',0,0,1,'BIMBO','','','','',1,12.95,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99999.000,1),
  (397,'ROLES GLASEADOS 3 PZ',0,0,1,'BIMBO','','','','',1,4.85,0.00,0,0.00,0.00,0,0,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,99999.000,1),
  (398,'COLCHONES',0,0,1,'BIMBO','','','','',1,4.85,0.00,0,0.00,0.00,0,0,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,99999.000,1),
  (399,'PANQUE DE PASAS',0,0,1,'BIMBO','','','','',1,11.75,0.00,0,0.00,0.00,0,0,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,14.50,0.00,0.000,0.000,99999.000,1),
  (400,'PANQUE DE NUEZ',0,0,1,'BIMBO','','','','',1,12.15,0.00,0,0.00,0.00,0,0,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,0.000,0.000,9994.000,1),
  (401,'PANQUECITO DE GOTA CHOCOLATE',0,0,1,'BIMBO','','','','',1,6.10,0.00,0,0.00,0.00,0,0,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,0.000,0.000,9999.000,1),
  (402,'MANTECADAS',0,0,1,'BIMBO','','','','',1,5.65,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99999.000,1),
  (403,'DONAS 4 PZ',0,0,1,'BIMBO','','','','',1,4.05,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99997.000,1),
  (404,'DONAS ESPOLVOREADAS 6 PZ',0,0,1,'BIMBO','','','','',1,4.45,0.00,0,0.00,0.00,0,0,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,0.000,0.000,99999.000,1),
  (405,'NEGRITO',0,0,1,'BIMBO','','','','',1,3.25,0.00,0,0.00,0.00,0,0,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (406,'PONKE',0,0,1,'BIMBO','','','','',1,2.45,0.00,0,0.00,0.00,0,0,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,0.000,0.000,99999.000,1),
  (407,'CONCHAS',0,0,1,'BIMBO','','','','',1,5.65,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99999.000,1),
  (408,'MANTECHOCX',0,0,1,'BIMBO','','','','',1,4.05,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (409,'REBANADAS',0,0,1,'BIMBO','','','','',1,2.00,0.00,0,0.00,0.00,0,0,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,0.000,0.000,99999.000,1),
  (410,'BRAN FRUT',0,0,1,'BIMBO','','','','',1,2.40,0.00,0,0.00,0.00,0,0,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,0.000,0.000,99999.000,1),
  (411,'BIMBUÑUELOS',0,0,1,'BIMBO','','','','',1,2.40,0.00,0,0.00,0.00,0,0,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,0.000,0.000,99998.000,1),
  (412,'BARRA MULTIGRANO LINAZA',0,0,1,'BIMBO','','','','',1,2.80,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,99999.000,1),
  (413,'BARRA MULTIGRANO NUEZ',0,0,1,'BIMBO','','','','',1,2.80,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,99999.000,1),
  (414,'BARRA MULTIGRANO AMARANTO',0,0,1,'BIMBO','','','','',1,2.80,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,99999.000,1),
  (415,'NUTRI LUNCH',0,0,1,'BIMBO','','','','',1,6.50,0.00,0,0.00,0.00,0,0,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,0.000,0.000,99999.000,1),
  (416,'BIMBUÑUELOS 24 PZ',0,0,1,'BIMBO','','','','',1,20.00,0.00,0,0.00,0.00,0,0,22.05,0.00,22.05,0.00,22.05,0.00,22.05,0.00,22.05,0.00,22.05,0.00,22.05,0.00,0.000,0.000,99999.000,1),
  (417,'DONAS 20 PZ',0,0,1,'BIMBO','','','','',1,19.90,0.00,0,0.00,0.00,0,0,21.90,0.00,21.90,0.00,21.90,0.00,21.90,0.00,21.90,0.00,21.90,0.00,21.90,0.00,0.000,0.000,99999.000,1),
  (418,'DONITAS EXPOLVOREADAS 30 PZ',0,0,1,'BIMBO','','','','',1,19.90,0.00,0,0.00,0.00,0,0,21.95,0.00,21.95,0.00,21.95,0.00,21.95,0.00,21.95,0.00,21.95,0.00,21.95,0.00,0.000,0.000,99999.000,1),
  (419,'MANTECADAS 16 PZ',0,0,1,'BIMBO','','','','',1,21.29,0.00,0,0.00,0.00,0,0,23.47,0.00,23.47,0.00,23.47,0.00,23.47,0.00,23.47,0.00,23.47,0.00,23.47,0.00,0.000,0.000,99999.000,1),
  (420,'PANQUECITO GOTA CHOCOLATE',0,0,1,'BIMBO','','','','',1,27.73,0.00,0,0.00,0.00,0,0,30.40,0.00,30.40,0.00,30.40,0.00,30.40,0.00,30.40,0.00,30.40,0.00,30.40,0.00,0.000,0.000,99999.000,1),
  (421,'PAN BLANCO DETALLE  WONDER 560 GR',0,0,1,'BIMBO','','','','',1,13.10,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99999.000,1),
  (422,'SUPER PAN BLANCO GRANDE  WONDER 680',0,0,1,'BIMBO','','','','',1,13.95,0.00,0,0.00,0.00,0,0,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,0.000,0.000,99999.000,1),
  (423,'PAN INTEGRAL C/AJN WONDER 680 GR',0,0,1,'BIMBO','','','','',1,14.75,0.00,0,0.00,0.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,99999.000,1),
  (424,'PAN DE LINAZA WONDER 475 GR',0,0,1,'BIMBO','','','','',1,11.50,0.00,0,0.00,0.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,99999.000,1),
  (425,'PAN INTEGRAL 100% MED WONDER 475 GR',0,0,1,'BIMBO','','','','',1,11.50,0.00,0,0.00,0.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,9999.000,1),
  (426,'HOT DOG WONDER 8 PZ 435 GR',0,0,1,'BIMBO','','','','',1,9.00,0.00,0,0.00,0.00,0,0,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,0.000,0.000,99999.000,1),
  (427,'SUPER MEDIAS WONDER 8 PZ 435 GR',0,0,1,'BIMBO','','','','',1,14.35,0.00,0,0.00,0.00,0,0,17.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,17.50,0.00,0.000,0.000,9999.000,1),
  (428,'BOLLOS WONDER 8 PZ',0,0,1,'CBE900712JI7','','','','',1,13.10,0.00,0,0.00,0.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99999.000,1),
  (429,'TORTILLA DE HARINA WONDER 12/260 GR',0,0,1,'BIMBO','','','','',1,5.60,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99999.000,1),
  (430,'TORTILLA DE HARINA WONDER 20 PZ',0,0,1,'BIMBO','','','','',1,10.80,0.00,0,0.00,0.00,0,0,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,0.000,0.000,99999.000,1),
  (431,'PAN MOLIDO WONDER 180 GR',0,0,1,'BIMBO','','','','',1,4.10,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (432,'PAN MOLIDO WONDER 5 KG',0,0,1,'BIMBO','','','','',1,94.35,0.00,0,0.00,0.00,0,0,115.10,0.00,115.10,0.00,115.10,0.00,115.10,0.00,115.10,0.00,115.10,0.00,115.10,0.00,0.000,0.000,99999.000,1),
  (433,'BOLLOS WONDER 18 PZ',0,0,1,'BIMBO','','','','',1,22.31,0.00,0,0.00,0.00,0,0,27.20,0.00,27.20,0.00,27.20,0.00,27.20,0.00,27.20,0.00,27.20,0.00,27.20,0.00,0.000,0.000,999999.000,1),
  (434,'BOLLOS WONDER 15 PZ',0,0,1,'BIMBO','','','','',1,29.00,0.00,0,0.00,0.00,0,0,35.40,0.00,35.40,0.00,35.40,0.00,35.40,0.00,35.40,0.00,35.40,0.00,35.40,0.00,0.000,0.000,99999.000,1),
  (435,'PAN TOSTADO WONDER',0,0,1,'BIMBO','','','','',1,8.20,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (436,'PAN INTEGRAL GRANDE WONDER 680 GR',0,0,1,'BIMBO','','','','',1,13.95,0.00,0,0.00,0.00,0,0,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,0.000,0.000,99999.000,1),
  (437,'TORTILLA DE HARINA INTEGRAL WONDER',0,0,1,'BIMBO','','','','',1,6.00,0.00,0,0.00,0.00,0,0,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,0.000,0.000,99999.000,1),
  (438,'PAN MULTICEREAL BCO MED WONDER 475',0,0,1,'BIMBO','','','','',1,11.50,0.00,0,0.00,0.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,99999.000,1),
  (439,'COCOTORRO',0,0,1,'BIMBO','','','','',1,3.20,0.00,0,0.00,0.00,0,0,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (440,'DALMATA',0,0,1,'BIMBO','','','','',1,3.20,0.00,0,0.00,0.00,0,0,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (441,'TUINKI 3 PZ',0,0,1,'BIMBO','','','','',1,5.20,0.00,0,0.00,0.00,0,0,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,0.000,0.000,99999.000,1),
  (442,'PANQUE TIA ROSA 300 GR',0,0,1,'BIMBO','','','','',1,10.80,0.00,0,0.00,0.00,0,0,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,13.50,0.00,0.000,0.000,99999.000,1),
  (443,'MANTECADAS TIA ROSA 2 PZ',0,0,1,'BIMBO','','','','',1,4.80,0.00,0,0.00,0.00,0,0,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,99999.000,1),
  (444,'MANTECADAS CHOCOLATE TIA ROSA',0,0,1,'BIMBO','','','','',1,5.20,0.00,0,0.00,0.00,0,0,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,0.000,0.000,99999.000,1),
  (445,'MANTECADAS VAINILLA NUEZ TIA ROSA',0,0,1,'BIMBO','','','','',1,5.60,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99999.000,1),
  (446,'CONCHAS TIA ROSA 2 PZ',0,0,1,'BIMBO','','','','',1,6.40,0.00,0,0.00,0.00,0,0,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,0.000,0.000,9999.000,1),
  (447,'SEMITAS TIA ROSA 2 PZ',0,0,1,'BIMBO','','','','',1,6.00,0.00,0,0.00,0.00,0,0,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,0.000,0.000,99999.000,1),
  (448,'BIGOTES DE CHOCOLATE TIA ROSA',0,0,1,'BIMBO','','','','',1,4.00,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (449,'CUERNITOS TIA ROSA',0,0,1,'BIMBO','','','','',1,5.60,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,999999.000,1),
  (450,'OREJAS TIA ROSA',0,0,1,'BIMBO','','','','',1,4.00,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,999999.000,1),
  (451,'DORADITAS TIA ROSA 3 PZ',0,0,1,'BIMBO','','','','',1,4.00,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (452,'MINIDORADITAS',0,0,1,'BIMBO','','','','',1,2.00,0.00,0,0.00,0.00,0,0,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,0.000,0.000,99941.000,1),
  (453,'MINIBIGOTES DE CHOCOLATE TIA ROSA',0,0,1,'BIMBO','','','','',1,2.00,0.00,0,0.00,0.00,0,0,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,0.000,0.000,99999.000,1),
  (454,'POLVORON CASERO TIA ROSA',0,0,1,'BIMBO','','','','',1,2.00,0.00,0,0.00,0.00,0,0,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,0.000,0.000,9999.000,1),
  (455,'CANAPINAS',0,0,1,'BIMBO','','','','',1,2.92,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,99999.000,1),
  (456,'ANIMALITOS CARAMELIZADOS',0,0,1,'BIMBO','','','','',1,4.15,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99984.000,1),
  (457,'CREMOSITAS',0,0,1,'BIMBO','','','','',1,4.12,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (458,'SALADA LARA 200 PZ',0,0,1,'BIMBO','','','','',1,44.00,0.00,0,0.00,0.00,0,0,47.30,0.00,47.30,0.00,47.30,0.00,47.30,0.00,47.30,0.00,47.30,0.00,47.30,0.00,0.000,0.000,99999.000,1),
  (459,'SALADAS LARA 140 GR',0,0,1,'BIMBO','','','','',1,3.75,0.00,0,0.00,0.00,0,0,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,0.000,0.000,99999.000,1),
  (460,'DECANELAS',0,0,1,'BIMBO','','','','',1,3.33,0.00,0,0.00,0.00,0,0,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (461,'TARTINAS',0,0,1,'BIMBO','','','','',1,4.15,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (462,'CHOCOCHISPAS',0,0,1,'BIMBO','','','','',1,4.15,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (463,'GANSITO 50 GR',0,0,1,'BIMBO','','','','',1,3.20,0.00,0,0.00,0.00,0,0,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (464,'ROCKO',0,0,1,'BIMBO','','','','',1,2.08,0.00,0,0.00,0.00,0,0,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,2.50,0.00,0.000,0.000,99999.000,1),
  (465,'PINGUINOS',0,0,1,'BIMBO','','','','',1,4.40,0.00,0,0.00,0.00,0,0,5.55,0.00,5.55,0.00,5.55,0.00,5.55,0.00,5.55,0.00,5.55,0.00,5.55,0.00,0.000,0.000,99999.000,1),
  (466,'SUBMARINOS',0,0,1,'BIMBO','','','','',1,5.20,0.00,0,0.00,0.00,0,0,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,0.000,0.000,99999.000,1),
  (467,'CHOCORROLES',0,0,1,'BIMBO','','','','',1,4.40,0.00,0,0.00,0.00,0,0,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,5.50,0.00,0.000,0.000,99999.000,1),
  (468,'ROLLO FRESA',0,0,1,'BIMBO','','','','',1,4.00,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (469,'PAY DE PIÑA',0,0,1,'BIMBO','','','','',1,6.00,0.00,0,0.00,0.00,0,0,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,7.50,0.00,0.000,0.000,9999.000,1),
  (470,'PAY DE NUEZ',0,0,1,'BIMBO','','','','',1,6.40,0.00,0,0.00,0.00,0,0,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,0.000,0.000,9999.000,1),
  (471,'NAPOLITANO',0,0,1,'BIMBO','','','','',1,3.60,0.00,0,0.00,0.00,0,0,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,0.000,0.000,99999.000,1),
  (472,'BARRITAS MARINELA',0,0,1,'BIMBO','','','','',1,2.92,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,99999.000,1),
  (473,'CANELITAS',0,0,1,'BIMBO','','','','',1,2.50,0.00,0,0.00,0.00,0,0,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,0.000,0.000,99998.000,1),
  (474,'TRIKI TRAKES',0,0,1,'BIMBO','','','','',1,3.33,0.00,0,0.00,0.00,0,0,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (475,'SPONCH 8 PZ',0,0,1,'BIMBO','','','','',1,5.42,0.00,0,0.00,0.00,0,0,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,6.50,0.00,0.000,0.000,99999.000,1),
  (476,'TRIKI TRAKES DE CHOCOLATE',0,0,1,'BIMBO','','','','',1,3.33,0.00,0,0.00,0.00,0,0,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,99999.000,1),
  (477,'PLATIVOLOS',0,0,1,'BIMBO','','','','',1,3.75,0.00,0,0.00,0.00,0,0,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,0.000,0.000,99998.000,1),
  (478,'SUAVICREMAS',0,0,1,'BIMBO','','','','',1,2.50,0.00,0,0.00,0.00,0,0,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,3.00,0.00,0.000,0.000,99998.000,1),
  (479,'POLVORONES',0,0,1,'BIMBO','','','','',1,2.92,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,99999.000,1),
  (480,'PRINCIPE 8 PZ',0,0,1,'BIMBO','','','','',1,4.17,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (481,'PRINCIPE CHOC BLANCO',0,0,1,'BIMBO','','','','',1,4.17,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (482,'PRINCIPE FRESA',0,0,1,'BIMBO','','','','',1,4.17,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (483,'LORS',0,0,1,'BIMBO','','','','',1,3.75,0.00,0,0.00,0.00,0,0,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,4.50,0.00,0.000,0.000,999999.000,1),
  (484,'BOMBONETE',0,0,1,'BIMBO','','','','',1,4.17,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99999.000,1),
  (485,'SUAVICREMAS',0,0,1,'BIMBO','','','','',1,8.33,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (486,'CANELITAS TUBO',0,0,1,'BIMBO','','','','',1,8.33,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (487,'TRIKI TRAKES TUBO',0,0,1,'BIMBO','','','','',1,8.33,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (488,'PLATIVOLOS TUBO',0,0,1,'BIMBO','','','','',1,8.33,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (489,'POLVORONES TUBO',0,0,1,'BIMBO','','','','',1,8.33,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (490,'PRINCIPE TUBO',0,0,1,'BIMBO','','','','',1,8.33,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,9999.000,1),
  (491,'LORS TUBO',0,0,1,'BIMBO','','','','',1,8.33,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (492,'PASTISETAS 150 GR',0,0,1,'BIMBO','','','','',1,12.45,0.00,0,0.00,0.00,0,0,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,0.000,0.000,9999.000,1),
  (493,'PASTICETAS 75 GR',0,0,1,'BIMBO','','','','',1,6.20,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99999.000,1),
  (494,'PANERA DE PAN DULCE DOMO',0,0,1,'BIMBO','','','','',1,2.90,0.00,0,0.00,0.00,0,0,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,3.50,0.00,0.000,0.000,9999.000,1),
  (495,'BOLILLO 60 GR',0,0,1,'BIMBO','','','','',1,1.00,0.00,0,0.00,0.00,0,0,1.30,0.00,1.30,0.00,1.30,0.00,1.30,0.00,1.30,0.00,1.30,0.00,1.30,0.00,0.000,0.000,99999.000,1),
  (496,'SANWICHON',0,0,1,'BIMBO','','','','',1,6.40,0.00,0,0.00,0.00,0,0,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,0.000,0.000,99999.000,1),
  (497,'CUERNO BIMKINGO',0,0,1,'BIMBO','','','','',1,6.40,0.00,0,0.00,0.00,0,0,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,8.00,0.00,0.000,0.000,99999.000,1),
  (498,'LONCHITO',0,0,1,'BIMBO','','','','',1,8.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,999999.000,1),
  (499,'CUERNITO',0,0,1,'BIMBO','','','','',1,8.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,99999.000,1),
  (500,'GALLETAS MARIAS 1 KG',0,0,1,'BIMBO','','','','',1,91.30,0.00,0,0.00,0.00,0,0,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,0.000,0.000,99999.000,1);

COMMIT;

#
# Data for the `productos` table  (LIMIT 500,500)
#

# ID_Pro:3:49671
# descripcion:253:0
# tipoPro:3:32768
# gravaIVA:3:32768
# genero:3:32768
# id_prov1:253:0
# id_prov2:253:0
# id_prov3:253:0
# id_prov4:253:0
# id_prov5:253:0
# uniCompra:3:32768
# precioUniCompra:5:32768
# preCaCompra:5:32768
# cantidadXCaja:3:32768
# precioUnidadKG:5:32768
# kgXUnidad:5:32768
# tipoPrecio:3:32768
# manejoPrecio:3:32768
# precioBase1:5:32769
# precioBase1Caja:5:32769
# precioG1:5:32768
# precioG1Caja:5:32768
# precioG2:5:32768
# precioG2Caja:5:32768
# precioG3:5:32768
# precioG3Caja:5:32768
# precioG4:5:32768
# precioG4Caja:5:32768
# precioG5:5:32768
# precioG5Caja:5:32768
# precioG6:5:32768
# precioG6Caja:5:32768
# maxInv:5:32768
# minInv:5:32768
# existencia:5:32768
# activo:3:32768

INSERT INTO `productos` (`ID_Pro`, `descripcion`, `tipoPro`, `gravaIVA`, `genero`, `id_prov1`, `id_prov2`, `id_prov3`, `id_prov4`, `id_prov5`, `uniCompra`, `precioUniCompra`, `preCaCompra`, `cantidadXCaja`, `precioUnidadKG`, `kgXUnidad`, `tipoPrecio`, `manejoPrecio`, `precioBase1`, `precioBase1Caja`, `precioG1`, `precioG1Caja`, `precioG2`, `precioG2Caja`, `precioG3`, `precioG3Caja`, `precioG4`, `precioG4Caja`, `precioG5`, `precioG5Caja`, `precioG6`, `precioG6Caja`, `maxInv`, `minInv`, `existencia`, `activo`) VALUES 
  (501,'AGUA CELTA 500 ML',0,0,2,'x','','','','',1,1.88,45.00,24,0.00,0.00,1,1,4.00,50.00,2.08,50.00,2.08,50.00,2.08,50.00,2.08,50.00,2.08,50.00,2.08,50.00,0.000,0.000,99999.000,1),
  (502,'AGUA CELTA 1.5 ML',0,0,2,'x','','','','',1,3.75,45.00,12,0.00,0.00,1,1,5.00,50.00,4.17,50.00,4.17,50.00,4.17,50.00,4.17,50.00,4.17,50.00,4.17,50.00,0.000,0.000,99999.000,1),
  (503,'AGUA FRIZZO 1.5 LT',0,0,2,'x','','','','',1,2.66,32.00,12,0.00,0.00,1,1,5.00,35.00,2.92,35.00,2.92,35.00,2.92,35.00,2.92,35.00,2.92,35.00,2.92,35.00,0.000,0.000,99999.000,1),
  (504,'AGUA FRIZZO 500 ML',0,0,2,'x','','','','',1,1.33,32.00,24,0.00,0.00,0,1,2.50,35.00,2.50,35.00,2.50,35.00,2.50,35.00,2.50,35.00,2.50,35.00,2.50,35.00,0.000,0.000,99999.000,1),
  (505,'CABRITO LATA',0,1,2,'x','','','','',1,5.00,120.00,24,0.00,0.00,1,1,9.00,135.00,5.63,135.00,5.63,135.00,5.63,135.00,5.63,135.00,5.63,135.00,5.63,135.00,0.000,0.000,99999.000,1),
  (506,'CHAPARRITA 250 ML',0,1,2,'x','','','','',1,2.70,65.00,24,0.00,0.00,1,1,3.00,72.00,3.00,72.00,3.00,72.00,3.00,72.00,3.00,72.00,3.00,72.00,3.00,72.00,0.000,0.000,0.000,0),
  (507,'ENERGIA 500 ML',0,1,2,'x','','','','',1,5.83,70.00,12,0.00,0.00,1,1,7.00,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,0.000,0.000,99999.000,1),
  (508,'FIRS 620 ML',0,1,2,'x','','','','',1,2.92,70.00,24,0.00,0.00,1,1,5.00,75.00,3.13,75.00,3.13,75.00,3.13,75.00,3.13,75.00,3.13,75.00,3.13,75.00,0.000,0.000,999999.000,1),
  (509,'GALLO 3 LT',0,0,1,'x','','','','',1,8.66,52.00,6,0.00,0.00,1,1,12.00,60.00,10.00,60.00,9.83,59.00,9.67,58.00,9.67,58.00,9.67,58.00,9.67,58.00,0.000,0.000,99981.000,1),
  (510,'GATORADE 500 ML',0,1,2,'x','','','','',1,8.13,195.00,24,0.00,0.00,1,1,10.00,205.00,8.54,205.00,8.50,204.00,8.46,203.00,8.42,202.00,8.38,201.00,8.33,200.00,0.000,0.000,99951.000,1),
  (511,'GATORADE 1 LT',0,1,2,'x','','','','',1,13.33,160.00,12,0.00,0.00,1,1,16.00,170.00,14.17,170.00,14.08,169.00,14.00,168.00,13.92,167.00,13.83,166.00,13.75,165.00,0.000,0.000,99999.000,1),
  (512,'GO FAST SPORT',0,1,1,'x','','','','',1,15.83,380.00,24,0.00,0.00,1,1,18.00,390.00,16.25,390.00,16.21,388.99,16.17,388.01,16.13,387.00,16.08,385.99,16.04,385.01,0.000,0.000,99999.000,1),
  (513,'JARRITO 2 LT',0,1,2,'x','','','','',1,7.88,63.00,8,0.00,0.00,1,1,10.00,68.00,8.50,68.00,8.38,67.00,8.25,66.00,8.13,65.00,8.13,65.00,8.13,65.00,0.000,0.000,99983.000,1),
  (514,'JARRITO 600 ML',0,1,2,'x','','','','',1,3.67,88.00,24,0.00,0.00,1,1,5.00,90.00,3.75,90.00,3.71,89.02,3.67,88.00,3.67,88.00,3.67,88.00,3.67,88.00,0.000,0.000,9937.000,1),
  (515,'JARRITO LATA 355 ML',0,1,2,'x','','','','',1,2.50,60.00,24,0.00,0.00,1,1,4.00,68.00,2.83,68.00,2.79,67.00,2.75,66.00,2.71,65.00,2.67,64.00,2.63,63.00,0.000,0.000,99999.000,1),
  (516,'JUGO AMI GALON',0,1,2,'x','','','','',1,22.50,90.00,4,0.00,0.00,1,1,26.00,96.00,24.00,96.00,24.00,96.00,24.00,96.00,24.00,96.00,24.00,96.00,24.00,96.00,0.000,0.000,99999.000,1),
  (517,'JUGO AMI JUMEX 500 ML',0,1,2,'x','','','','',1,3.33,40.00,12,0.00,0.00,1,1,4.00,42.00,3.50,42.00,3.50,42.00,3.50,42.00,3.50,42.00,3.50,42.00,3.50,42.00,0.000,0.000,99939.000,1),
  (518,'JUGO ART',0,1,2,'x','','','','',1,3.33,80.00,24,0.00,0.00,1,1,3.50,84.00,3.42,82.00,3.42,82.00,3.42,82.00,3.42,82.00,3.42,82.00,3.42,82.00,0.000,0.000,9999.000,1),
  (519,'JUGO BEBERE 473 ML',0,1,2,'x','','','','',1,2.71,65.00,24,0.00,0.00,1,1,4.00,80.00,3.33,80.00,3.29,79.00,3.29,79.00,3.29,79.00,3.29,79.00,3.29,79.00,0.000,0.000,99975.000,1),
  (520,'JUGO DE TOMATE CLAMATO 946 ML',0,0,2,'x','','','','',1,195.00,0.00,0,0.00,0.00,0,0,200.00,0.00,200.00,0.00,200.00,0.00,200.00,0.00,200.00,0.00,200.00,0.00,200.00,0.00,0.000,0.000,99999.000,1),
  (521,'JUGO DE TOMATE JUMEX 1 LT',0,0,2,'x','','','','',1,10.41,125.00,12,0.00,0.00,1,1,12.00,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,0.000,0.000,99999.000,1),
  (522,'JUMEX 1 LT',0,0,2,'x','','','','',1,10.41,125.00,12,0.00,0.00,1,1,12.00,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.41,125.00,0.000,0.000,99987.000,1),
  (523,'JUMEX LATA 200 ML',0,0,2,'x','','','','',1,5.20,125.00,24,0.00,0.00,1,1,6.00,144.00,5.33,128.00,5.33,128.00,5.33,128.00,5.33,128.00,5.33,128.00,5.33,128.00,0.000,0.000,99975.000,1),
  (524,'JUMEX SPORT',0,1,2,'x','','','','',1,5.00,60.00,12,0.00,0.00,1,1,8.00,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,0.000,0.000,99999.000,1),
  (525,'JUMEX MINIBRIK 200 ML',0,0,2,'x','','','','',1,3.00,120.00,40,0.00,0.00,1,1,4.00,130.00,3.25,130.00,3.25,130.00,3.25,130.00,3.25,130.00,3.25,130.00,3.25,130.00,0.000,0.000,9759.000,1),
  (526,'JUGOSA JUMEX',0,0,2,'x','','','','',1,4.16,100.00,24,0.00,0.00,1,1,6.00,110.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,0.000,0.000,99975.000,1),
  (527,'LINEA COCA COLA 2.5 LT',0,1,2,'x','','','','',1,11.25,90.00,8,0.00,0.00,0,1,13.00,95.00,13.00,95.00,13.00,95.00,13.00,95.00,13.00,95.00,13.00,95.00,13.00,95.00,0.000,0.000,99983.000,1),
  (528,'LINEA COCA COLA LATA',0,1,2,'x','','','','',1,4.29,103.00,24,0.00,0.00,0,1,5.00,110.00,5.00,110.00,5.00,110.00,5.00,110.00,5.00,110.00,5.00,110.00,5.00,110.00,0.000,0.000,99951.000,1),
  (529,'LINEA PEPSI  2.5 LT',0,1,2,'x','','','','',1,10.00,80.00,8,0.00,0.00,0,1,12.00,82.00,12.00,82.00,12.00,82.00,12.00,82.00,12.00,82.00,12.00,82.00,12.00,82.00,0.000,0.000,99999.000,1),
  (530,'LINEA PEPSI 600 ML',0,1,2,'x','','','','',1,3.95,95.00,24,0.00,0.00,1,1,5.00,105.00,4.38,105.00,4.25,102.00,4.17,100.00,4.17,100.00,4.17,100.00,4.17,100.00,0.000,0.000,999915.000,1),
  (531,'LINEA PEPSI LATA 355 ML',0,1,2,'x','','','','',1,3.25,78.00,24,0.00,0.00,0,1,5.00,82.00,5.00,82.00,5.00,82.00,5.00,82.00,5.00,82.00,5.00,82.00,5.00,82.00,0.000,0.000,999999.000,1),
  (532,'LULU 300 ML',0,1,2,'x','','','','',1,2.29,55.00,24,0.00,0.00,0,1,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,0.000,0.000,99999.000,1),
  (533,'LULU 3 LT',0,1,2,'x','','','','',1,9.16,55.00,6,0.00,0.00,1,1,13.00,63.00,10.50,63.00,10.34,62.00,10.17,61.00,10.00,60.00,10.00,60.00,10.00,60.00,0.000,0.000,99932.000,1),
  (534,'MANZANITA DELICIOSA 250 ML',0,1,2,'x','','','','',1,2.50,60.00,24,0.00,0.00,1,1,3.50,65.00,2.71,65.00,2.67,64.00,2.67,64.00,2.67,64.00,2.67,64.00,2.67,64.00,0.000,0.000,999999.000,1),
  (535,'MANZANITA DELICIOSA 600 ML',0,1,2,'x','','','','',1,3.95,95.00,24,0.00,0.00,1,1,5.00,100.00,4.17,100.00,4.13,99.00,4.08,98.00,4.08,98.00,4.08,98.00,4.08,98.00,0.000,0.000,999999.000,1),
  (536,'MANZANITA DELICIOSA  3 LT',0,1,2,'x','','','','',1,11.66,70.00,6,0.00,0.00,1,1,15.00,75.00,12.50,75.00,12.50,75.00,12.50,75.00,12.50,75.00,12.50,75.00,12.50,75.00,0.000,0.000,99999.000,1),
  (537,'MORGAN 600 ML',0,1,2,'x','','','','',1,2.29,55.00,24,0.00,0.00,1,1,3.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,0.000,0.000,999999.000,1),
  (538,'MORGAN DE SABOR',0,1,2,'x','','','','',1,2.29,55.00,24,0.00,0.00,1,1,3.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,0.000,0.000,99999.000,1),
  (539,'MORGAN KIDS',0,1,2,'x','','','','',1,2.29,55.00,24,0.00,0.00,1,1,3.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,2.50,60.00,0.000,0.000,99999.000,1),
  (540,'MUNDET 2 LT',0,1,2,'x','','','','',1,7.50,60.00,8,0.00,0.00,1,1,10.00,65.00,8.13,65.00,8.13,65.00,8.13,65.00,8.13,65.00,8.13,65.00,8.13,65.00,0.000,0.000,99999.000,1),
  (541,'NEW MIX 2 LT',0,1,2,'x','','','','',1,23.33,140.00,6,0.00,0.00,1,1,30.00,150.00,25.00,150.00,25.00,150.00,25.00,150.00,25.00,150.00,25.00,150.00,25.00,150.00,0.000,0.000,99999.000,1),
  (542,'NEW MIX LATA',0,1,2,'x','','','','',1,6.66,160.00,24,0.00,0.00,1,1,10.00,172.00,7.17,172.00,7.08,170.00,7.08,170.00,7.08,170.00,7.08,170.00,7.08,170.00,0.000,0.000,99447.000,1),
  (543,'PASCUAL 250 ML',0,1,2,'x','','','','',1,2.29,55.00,24,0.00,0.00,0,1,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,3.00,62.00,0.000,0.000,9999.000,1),
  (544,'PEÑAFIEL 600 ML',0,1,2,'x','','','','',1,4.58,110.00,24,0.00,0.00,1,1,6.00,120.00,5.00,120.00,4.79,115.00,4.75,114.00,4.75,114.00,4.75,114.00,4.75,114.00,0.000,0.000,99939.000,1),
  (545,'PEÑAFIEL 2 LT',0,1,2,'x','','','','',1,10.55,95.00,9,0.00,0.00,1,1,15.00,105.00,11.67,105.00,11.44,103.00,11.44,103.00,11.44,103.00,11.44,103.00,11.44,103.00,0.000,0.000,9999.000,1),
  (546,'PEÑAFIEL 1 LT',0,1,2,'x','','','','',1,7.00,84.00,12,0.00,0.00,1,1,7.33,88.00,7.08,85.00,7.08,85.00,7.08,85.00,7.08,85.00,7.08,85.00,7.08,85.00,0.000,0.000,9999.000,1),
  (547,'PEÑAFIEL NATUREL 600 ML',0,1,2,'x','','','','',1,6.61,99.20,15,0.00,0.00,1,1,7.50,112.50,7.33,110.00,7.33,110.00,7.33,110.00,7.33,110.00,7.33,110.00,7.33,110.00,0.000,0.000,99999.000,1),
  (548,'PEÑAFIEL TWIST 600 ML',0,1,2,'x','','','','',1,4.42,106.15,24,0.00,0.00,1,1,6.00,114.00,4.75,114.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,4.58,110.00,0.000,0.000,99975.000,1),
  (549,'PRESIDENCOLA',0,1,2,'AMO930202EQ6','','','','',1,6.66,160.00,24,0.00,0.00,1,1,10.00,165.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,0.000,0.000,99951.000,1),
  (550,'PROPEL 500 ML',0,1,2,'x','','','','',1,5.41,130.00,24,0.00,0.00,1,1,8.00,140.00,5.83,140.00,5.83,140.00,5.83,140.00,5.83,140.00,5.83,140.00,5.83,140.00,0.000,0.000,99996.000,1),
  (551,'PIT BUT',0,0,1,'x','','','','',1,16.25,390.00,24,0.00,0.00,1,1,18.00,400.00,16.67,400.01,16.67,400.01,16.67,400.01,16.67,400.01,16.67,400.01,16.67,400.01,0.000,0.000,99999.000,1),
  (552,'RED BULL',0,1,2,'x','','','','',1,15.41,370.00,24,0.00,0.00,1,1,22.00,400.00,16.67,400.00,16.67,400.00,16.67,400.00,16.67,400.00,16.67,400.00,16.67,400.00,0.000,0.000,99963.000,1),
  (553,'REFRESCO DEL HUERTO',0,1,2,'x','','','','',1,2.29,55.00,24,0.00,0.00,0,1,2.42,58.01,2.42,58.01,2.42,58.01,2.42,58.01,2.42,58.01,2.42,58.01,2.42,58.01,0.000,0.000,99999.000,1),
  (554,'RED COLA 3 LT',0,1,2,'x','','','','',1,9.66,58.00,6,0.00,0.00,1,1,12.00,63.00,10.50,63.00,10.33,62.00,10.17,61.00,10.00,60.00,10.00,60.00,10.00,60.00,0.000,0.000,99999.000,1),
  (555,'RED COLA 600 ML',0,1,2,'x','','','','',1,3.25,78.00,24,0.00,0.00,1,1,4.00,82.00,3.42,82.00,3.38,81.00,3.33,80.00,3.33,80.00,3.33,80.00,3.33,80.00,0.000,0.000,99999.000,1),
  (556,'SANGRIA 600 ML',0,1,2,'x','','','','',1,4.16,100.00,24,0.00,0.00,0,1,6.00,105.00,6.00,105.00,6.00,105.00,6.00,105.00,6.00,105.00,6.00,105.00,6.00,105.00,0.000,0.000,999975.000,1),
  (557,'MARGARINA IBERIA 90 GR',0,0,1,'x','','','','',1,3.34,80.00,24,0.00,0.00,1,1,5.00,86.00,3.58,86.00,3.54,85.00,3.50,84.00,3.42,82.00,3.42,82.00,3.42,82.00,0.000,0.000,99831.000,1),
  (558,'MARGARINA IBERIA 225 GR',0,0,1,'x','','','','',1,6.66,60.00,9,0.00,0.00,1,1,9.00,76.00,8.44,76.00,8.33,75.00,8.11,73.00,7.88,71.00,7.88,71.00,7.88,71.00,0.000,0.000,99990.000,1),
  (559,'MARGARINA IBERIA 500 GR',0,0,1,'x','','','','',1,11.90,119.00,10,0.00,0.00,1,1,15.50,160.00,16.00,160.00,15.80,158.00,15.60,156.00,15.60,156.00,15.60,156.00,15.60,156.00,0.000,0.000,99999.000,1),
  (560,'MARGARINA IBERIA 1 KG',0,0,1,'VAPB730831UM9','','','','',1,17.00,177.00,10,0.00,0.00,1,1,22.00,195.00,20.00,200.00,19.00,190.00,18.80,188.00,18.80,188.00,18.80,188.00,18.80,188.00,0.000,0.000,99970.000,1),
  (561,'MALTEADA ALPURA 250 ML',0,0,1,'GPL860521FW8','','','','',1,3.40,92.00,27,0.00,0.00,1,1,4.00,97.00,3.59,97.00,3.57,96.50,3.56,96.00,3.54,95.50,3.52,95.00,3.41,92.00,0.000,0.000,99712.500,1),
  (562,'MALTEADA ALPURA 1 LT',0,0,1,'GPL860521FW8','','','','',1,10.16,122.00,12,0.00,0.00,1,1,11.00,132.00,11.00,132.00,10.83,130.00,10.75,129.00,10.75,129.00,10.75,129.00,10.75,129.00,0.000,0.000,99914.000,1),
  (563,'MANTEQUILLA GLORIA 1 KG',0,0,1,'x','','','','',1,35.00,350.00,10,0.00,0.00,1,1,38.00,365.00,36.50,365.00,36.50,365.00,36.50,365.00,36.50,365.00,36.50,365.00,36.50,365.00,0.000,0.000,999995.000,1),
  (564,'MANTEQUILLA PORCION 90/0.0060 GR',0,0,1,'x','','','','',1,25.00,250.00,10,0.00,0.00,1,1,38.00,285.00,28.50,285.00,28.50,285.00,28.50,285.00,28.50,285.00,28.50,285.00,28.50,285.00,0.000,0.000,99999.000,1),
  (565,'MARGARINA CHANTILLY PRIMAVERA 190 G',0,0,1,'x','','','','',1,7.08,85.00,12,0.00,0.00,1,1,9.00,102.00,8.50,102.00,8.42,101.00,8.33,100.00,8.33,100.00,8.33,100.00,8.33,100.00,0.000,0.000,999974.000,1),
  (566,'FORTILECHE',0,0,1,'GPL860521FW8','','','','',1,8.40,100.80,12,0.00,0.00,1,1,9.00,103.00,8.58,103.00,8.58,103.00,8.58,103.00,8.58,103.00,8.58,103.00,8.58,103.00,0.000,0.000,99987.000,1),
  (567,'BLUE SHOT',0,1,2,'x','','','','',1,7.08,170.00,24,0.00,0.00,1,1,15.00,180.00,7.50,180.00,7.46,179.00,7.42,178.00,7.38,177.00,7.33,176.00,7.29,175.00,0.000,0.000,99999.000,1),
  (568,'CERVEZA NOCHE BUENA',0,1,2,'x','','','','',1,5.83,70.00,12,0.00,0.00,1,1,9.00,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,6.25,75.00,0.000,0.000,99939.000,1),
  (569,'CERVEZA PICO DE ORO',0,1,2,'x','','','','',1,6.04,145.00,24,0.00,0.00,1,1,8.50,150.00,6.25,150.00,6.25,150.00,6.25,150.00,6.25,150.00,6.25,150.00,6.17,148.00,0.000,0.000,0.000,0),
  (570,'CHAPARRITA 250 ML',0,1,2,'x','','','','',1,2.70,65.00,24,0.00,0.00,1,1,3.00,72.00,3.00,72.00,2.98,71.50,2.96,71.00,2.92,70.00,2.92,70.00,2.92,70.00,0.000,0.000,999999.000,1),
  (571,'CHISPAZO',0,1,2,'x','','','','',1,7.08,85.00,12,0.00,0.00,1,1,8.00,96.00,8.00,96.00,7.83,94.00,7.67,92.00,7.50,90.00,7.50,90.00,7.50,90.00,0.000,0.000,99999.000,1),
  (572,'CHORIZO REAL DEL MONTE',1,0,1,'x','','','','',2,0.00,0.00,0,25.00,1.00,0,0,29.00,0.00,29.00,0.00,29.00,0.00,29.00,0.00,29.00,0.00,29.00,0.00,29.00,0.00,0.000,0.000,99999.000,1),
  (573,'CHORIZO SABADEL',1,0,1,'x','','','','',2,0.00,0.00,0,29.00,1.00,1,0,32.00,0.00,31.50,0.00,31.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99999.000,1),
  (574,'CLAMATO CHICO',0,0,2,'x','','','','',1,10.41,125.00,12,0.00,0.00,1,1,12.00,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,0.000,0.000,0.000,0),
  (575,'CLAMATO GRANDE',0,0,2,'x','','','','',1,21.25,255.00,12,0.00,0.00,1,1,23.00,260.00,21.67,260.00,21.67,260.00,21.67,260.00,21.67,260.00,21.67,260.00,21.67,260.00,0.000,0.000,99999.000,1),
  (576,'COCA COLA 1 LT',0,1,2,'x','','','','',1,7.08,85.00,12,0.00,0.00,1,1,9.00,94.00,7.83,94.00,7.75,93.00,7.67,92.00,7.58,91.00,7.50,90.00,7.50,90.00,0.000,0.000,99975.000,1),
  (577,'COCA COLA 1.5 ML',0,1,2,'x','','','','',1,8.66,104.00,12,0.00,0.00,1,1,11.00,110.00,9.17,110.00,9.17,110.00,9.17,110.00,9.17,110.00,9.17,110.00,9.17,110.00,0.000,0.000,99969.000,1),
  (578,'COCA COLA 2 LT',0,1,2,'x','','','','',1,10.50,84.00,8,0.00,0.00,1,1,14.00,88.00,11.00,88.00,10.88,87.00,10.75,86.00,10.63,85.00,10.63,85.00,10.63,85.00,0.000,0.000,99999.000,1),
  (579,'COCA COLA 3 LT',0,1,2,'x','','','','',1,15.00,90.00,6,0.00,0.00,1,1,17.00,96.00,16.00,96.00,15.92,95.50,15.83,95.00,15.83,95.00,15.83,95.00,15.83,95.00,0.000,0.000,99999.000,1),
  (580,'GELATINA ART',0,0,1,'x','','','','',1,1.56,50.00,32,0.00,0.00,1,1,2.50,55.00,1.72,55.00,1.72,55.00,1.72,55.00,1.72,55.00,1.72,55.00,1.72,55.00,0.000,0.000,99999.000,1),
  (581,'JAMON AMERICANO ALYS',1,0,1,'x','','','','',2,0.00,0.00,0,22.00,4.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,99999.000,1),
  (582,'JAMON DANIEL',1,0,1,'x','','','','',2,0.00,0.00,0,35.00,5.00,1,0,38.00,0.00,38.00,0.00,36.00,0.00,34.50,0.00,34.50,0.00,34.50,0.00,34.50,0.00,0.000,0.000,99976.460,1),
  (583,'SOPA MARUCHAN',0,0,1,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,0.000,0.000,999996.000,0),
  (584,'SALUTZO 275 ML',0,1,2,'x','','','','',1,8.41,202.00,24,0.00,0.00,1,1,10.00,230.00,9.58,230.00,8.67,208.00,8.67,208.00,8.67,208.00,8.67,208.00,8.67,208.00,0.000,0.000,99999.000,1),
  (585,'SANGRIA 2 LT',0,1,2,'x','','','','',1,8.13,65.00,8,0.00,0.00,1,1,13.00,72.00,9.00,72.00,8.88,71.00,8.75,70.00,8.63,69.00,8.50,68.00,8.50,68.00,0.000,0.000,999999.000,1),
  (586,'SIDRAL 2 LT',0,1,2,'x','','','','',1,10.00,80.00,8,0.00,0.00,1,1,12.00,96.00,10.75,86.00,10.63,85.00,10.50,84.00,10.50,84.00,10.50,84.00,10.50,84.00,0.000,0.000,999999.000,1),
  (587,'SIDRAL 600 ML',0,1,2,'x','','','','',1,4.16,100.00,24,0.00,0.00,1,1,6.00,110.00,4.58,110.00,4.54,109.00,4.50,108.00,4.46,107.00,4.42,106.00,4.38,105.00,0.000,0.000,999999.000,1),
  (588,'SKYY BLUE 275 ML',0,1,2,'x','','','','',1,9.79,235.00,24,0.00,0.00,1,1,12.00,242.00,10.08,242.00,10.04,241.00,10.00,240.00,10.00,240.00,10.00,240.00,10.00,240.00,0.000,0.000,99999.000,1),
  (589,'SPIRIT',0,1,2,'x','','','','',1,8.12,195.00,24,0.00,0.00,1,1,9.00,210.00,8.75,210.00,8.71,209.00,8.67,208.00,8.63,207.00,8.58,206.00,8.54,205.00,0.000,0.000,99999.000,1),
  (590,'SQUIRT 2.5 LT',0,1,2,'x','','','','',1,9.38,75.00,8,0.00,0.00,1,1,13.00,82.00,10.25,82.00,10.13,81.00,10.00,80.00,9.88,79.00,9.75,78.00,9.75,78.00,0.000,0.000,99983.000,1),
  (591,'VIÑA REAL 330 ML',0,1,2,'x','','','','',1,6.66,160.00,24,0.00,0.00,1,1,10.00,170.00,6.88,165.00,6.88,164.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,0.000,0.000,99831.000,1),
  (592,'VIÑA REAL 1 LT',0,1,2,'x','','','','',1,16.66,100.00,6,0.00,0.00,1,1,20.00,110.00,18.33,110.00,18.17,109.00,18.00,108.00,17.83,107.00,17.67,106.00,17.50,105.00,0.000,0.000,99981.000,1),
  (593,'VIÑA REAL 500 ML',0,1,2,'x','','','','',1,8.33,100.00,12,0.00,0.00,1,1,10.00,115.00,9.58,115.00,9.17,110.00,9.00,108.00,9.00,108.00,9.00,108.00,9.00,108.00,0.000,0.000,99951.000,1),
  (594,'VIÑA REAL 2 LT',0,1,2,'x','','','','',1,30.83,185.00,6,0.00,0.00,1,1,37.00,195.00,32.50,195.00,32.33,194.00,32.17,193.00,32.00,192.00,31.83,191.00,31.67,190.00,0.000,0.000,99999.000,1),
  (595,'VIÑA REAL 2.6 LT',0,1,2,'x','','','','',1,220.00,0.00,0,0.00,0.00,0,0,230.00,0.00,230.00,0.00,230.00,0.00,230.00,0.00,230.00,0.00,230.00,0.00,230.00,0.00,0.000,0.000,99999.000,1),
  (596,'MAYONESA MCCORMICK 190 GR #8',0,0,3,'x','','','','',1,7.29,175.00,24,0.00,0.00,1,1,9.50,188.00,7.83,188.00,7.83,188.00,7.83,188.00,7.83,188.00,7.83,188.00,7.50,180.00,0.000,0.000,99998.000,1),
  (597,'MAYONESA MCCORMICK 390 GR #16',0,0,3,'x','','','','',1,15.00,180.00,12,0.00,0.00,1,1,19.50,185.00,15.42,185.00,15.42,185.00,15.42,185.00,15.42,185.00,15.42,185.00,15.00,180.00,0.000,0.000,99999.000,1),
  (598,'MAYONESA MCCORMICK 790 GR #32',0,0,3,'x','','','','',1,26.66,320.00,12,0.00,0.00,1,1,32.00,330.00,27.50,330.00,27.50,330.00,27.50,330.00,27.50,330.00,27.50,330.00,27.50,330.00,0.000,0.000,99999.000,1),
  (599,'MAYONESA MCCORMICK 1.730 GR #64',0,0,3,'x','','','','',1,48.33,290.00,6,0.00,0.00,1,1,55.00,295.00,49.17,295.00,49.17,295.00,49.17,295.00,49.17,295.00,49.17,295.00,49.17,295.00,0.000,0.000,99999.000,1),
  (600,'MAYONESA MCCORMICK 105 GR',0,0,3,'x','','','','',1,4.58,110.00,24,0.00,0.00,1,1,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,0.000,0.000,99999.000,1),
  (601,'MAYONESA MCCORMICK 285 GR',0,0,3,'x','','','','',1,10.00,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,99999.000,1),
  (602,'MAYONESA MCCORMICK 3.800 KG',0,0,3,'x','','','','',1,75.00,300.00,4,0.00,0.00,1,1,85.00,320.00,80.00,320.00,80.00,320.00,80.00,320.00,80.00,320.00,80.00,320.00,80.00,320.00,0.000,0.000,99999.000,1),
  (603,'MAYONESA PORCION',0,0,3,'x','','','','',1,390.00,0.00,0,0.00,0.00,0,0,400.00,0.00,400.00,0.00,400.00,0.00,400.00,0.00,400.00,0.00,400.00,0.00,400.00,0.00,0.000,0.000,99999.000,1),
  (604,'MAYONESA STAR VALUE 3.570',0,0,1,'x','','','','',1,50.00,0.00,0,0.00,0.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,99999.000,1),
  (605,'ACEITE AVE',0,0,3,'x','','','','',1,9.33,112.00,12,0.00,0.00,1,1,10.50,126.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,0.000,0.000,9975.000,1),
  (606,'ACEITE CAPITAN',0,0,3,'x','','','','',1,175.00,0.00,0,0.00,0.00,0,0,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,0.000,0.000,99999.000,1),
  (607,'ACEITE COCINERA 946 ML',0,0,3,'x','','','','',1,9.58,115.00,12,0.00,0.00,1,1,11.00,122.00,10.17,122.00,10.17,122.00,10.17,122.00,10.17,122.00,10.17,122.00,10.17,122.00,0.000,0.000,9999999.000,1),
  (608,'ACEITE GLORIA 1 LT',0,0,3,'x','','','','',1,10.83,130.00,12,0.00,0.00,1,1,14.00,140.00,11.67,140.00,11.67,140.00,11.67,140.00,11.67,140.00,11.67,140.00,11.67,140.00,0.000,0.000,999999.000,1),
  (609,'CALDO DE POLLO BACHOCO',0,0,3,'x','','','','',1,130.00,520.00,4,0.00,0.00,1,1,160.00,550.00,137.50,550.00,137.50,550.00,137.50,550.00,137.50,550.00,137.50,550.00,137.50,550.00,0.000,0.000,999999.000,1),
  (610,'CHONGOS ZAMORANOS',0,1,3,'x','','','','',1,36.00,0.00,0,0.00,0.00,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,0.000,0.000,99999.000,1),
  (611,'CHONGOS ZAMORANOS',0,0,3,'x','','','','',1,100.00,0.00,0,0.00,0.00,0,0,105.00,0.00,105.00,0.00,105.00,0.00,105.00,0.00,105.00,0.00,105.00,0.00,105.00,0.00,0.000,0.000,99999.000,1),
  (612,'CHORIZO DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,20.00,1.00,0,0,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,23.00,0.00,0.000,0.000,99999.000,1),
  (613,'CHORIZO HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,34.00,1.00,0,0,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,0.000,0.000,99999.000,1),
  (614,'CHORIZO RIVERA',1,0,1,'x','','','','',2,0.00,0.00,0,22.00,1.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,99999.000,1),
  (615,'COCA COLA RETORNABLE 2.5 LT',0,1,2,'x','','','','',1,10.63,86.00,8,0.00,0.00,1,1,13.00,90.00,11.25,90.00,11.00,88.00,10.75,86.00,10.75,86.00,10.75,86.00,10.75,86.00,0.000,0.000,9999.000,1),
  (616,'CREMA ALPURA 200 ML',0,0,1,'GPL860521FW8','x','','','',1,5.08,122.00,24,0.00,0.00,1,1,6.00,132.00,5.50,132.00,5.42,130.00,5.42,130.00,5.42,130.00,5.42,130.00,5.42,130.00,0.000,0.000,99818.000,1),
  (617,'CREMA ALPURA 900 ML',0,0,1,'GPL860521FW8','x','','','',1,22.58,271.00,12,0.00,0.00,1,1,23.50,278.00,23.17,278.00,23.17,278.00,23.17,278.00,23.17,278.00,23.17,278.00,23.00,276.00,0.000,0.000,9983.000,1),
  (618,'CREMA ALPURA 4 LT',0,0,1,'GPL860521FW8','x','','','',1,100.00,0.00,0,0.00,0.00,1,0,110.00,0.00,110.00,0.00,108.00,0.00,106.00,0.00,106.00,0.00,106.00,0.00,106.00,0.00,0.000,0.000,99997.000,1),
  (619,'CREMA ALPURA 450 ML',0,0,1,'GPL860521FW8','x','','','',1,11.29,271.00,24,0.00,0.00,1,1,12.50,283.00,12.00,288.00,11.80,283.00,11.58,278.00,11.58,278.00,11.58,278.00,11.58,278.00,0.000,0.000,99826.000,1),
  (620,'CREMA CHILCHOTA 4 LT',0,0,1,'x','','','','',1,60.00,0.00,0,0.00,0.00,0,0,64.00,0.00,64.00,0.00,64.00,0.00,64.00,0.00,64.00,0.00,64.00,0.00,64.00,0.00,0.000,0.000,99999.000,1),
  (621,'CREMA CORTEZ',1,0,1,'x','','','','',2,0.00,0.00,0,14.50,5.00,0,0,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,0.000,0.000,99999.000,1),
  (622,'CREMA LALA 200 ML',0,0,1,'x','VAPB730831UM9','','','',1,4.79,115.00,24,0.00,0.00,1,1,5.30,125.00,5.21,125.04,5.13,123.12,5.00,120.00,5.00,120.00,5.00,120.00,5.00,120.00,0.000,0.000,99978.000,1),
  (623,'CREMA LALA 450 ML',0,0,1,'x','VAPB730831UM9','','','',1,9.58,115.00,12,0.00,0.00,1,1,11.00,125.00,10.42,125.00,10.25,123.00,10.17,122.04,10.09,121.00,10.09,121.00,10.09,121.00,0.000,0.000,9983.000,1),
  (624,'CREMA LALA 900 ML',0,0,1,'x','VAPB730831UM9','','','',1,19.66,118.00,6,0.00,0.00,1,1,21.00,123.00,20.50,123.00,20.50,123.00,20.50,123.00,20.50,123.00,20.50,123.00,20.50,123.00,0.000,0.000,9862.000,1),
  (625,'CREMA LALA 4 LT',0,0,1,'x','','','','',1,82.00,0.00,0,0.00,0.00,1,0,95.00,0.00,95.00,0.00,94.00,0.00,93.00,0.00,93.00,0.00,93.00,0.00,93.00,0.00,0.000,0.000,99991.000,1),
  (626,'CREMA PARA BATIR DULCIMA',0,0,1,'x','','','','',1,47.00,0.00,0,0.00,0.00,0,0,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,0.000,0.000,99999.000,1),
  (627,'CUBARAYMA',0,1,1,'x','','','','',1,6.58,158.00,24,0.00,0.00,1,1,8.00,165.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,6.88,165.00,0.000,0.000,99999.000,1),
  (628,'DANONINO LIQUIDO',0,0,1,'x','VAPB730831UM9','','','',1,3.36,84.00,25,0.00,0.00,1,1,4.00,87.00,3.48,87.00,3.48,87.00,3.48,87.00,3.48,87.00,3.48,87.00,3.48,87.00,0.000,0.000,99999.000,1),
  (629,'GALLO',0,1,2,'x','','','','',1,9.33,56.00,6,0.00,0.00,1,1,10.00,60.00,10.00,60.00,9.67,58.00,9.67,58.00,9.67,58.00,9.67,58.00,9.67,58.00,0.000,0.000,99999.000,1),
  (630,'HUEVO',1,0,1,'x','','','','',2,0.00,0.00,0,10.00,1.00,0,0,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,11.00,0.00,0.000,0.000,99999.000,1),
  (631,'JAMON AMERICANO FUD DE PAVO',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,31.90,5.00,1,2,37.00,172.50,36.50,172.50,36.50,172.50,36.50,172.50,36.50,172.50,36.50,172.50,36.50,172.50,0.000,0.000,99999.000,1),
  (632,'JAMON COCIDO DE PIERNA VIVA',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,25.00,5.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99999.000,1),
  (633,'JAMON COCIDO VIVA',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,25.00,5.00,1,2,28.00,107.50,27.00,107.50,27.00,107.50,27.00,107.50,27.00,107.50,27.00,107.50,25.50,107.50,0.000,0.000,99999.000,1),
  (634,'JAMON DE PAVO AHUMADO SAN RAFAEL',1,0,1,'x','','','','',2,0.00,0.00,0,72.00,6.00,0,0,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,0.000,0.000,99999.000,1),
  (635,'JAMON DE PAVO FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,50.00,5.00,1,0,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,0.000,0.000,99999.000,1),
  (636,'JAMON DE PAVO PAVINO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,40.00,5.00,1,0,45.00,0.00,42.70,0.00,42.70,0.00,42.70,0.00,42.70,0.00,42.70,0.00,42.70,0.00,0.000,0.000,99999.000,1),
  (637,'JAMON DE PAVO VIRGINIA FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,42.00,5.00,1,2,50.00,198.00,50.00,198.00,49.50,198.00,48.50,198.00,47.00,198.00,47.00,198.00,47.00,498.00,0.000,0.000,99957.440,1),
  (638,'JAMON DE PIERNA ALPINO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,52.00,6.00,0,0,57.00,0.00,57.00,0.00,57.00,0.00,57.00,0.00,57.00,0.00,57.00,0.00,57.00,0.00,0.000,0.000,99999.000,1),
  (639,'JAMON DE PIERNA YORK RIOJANO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,45.00,6.00,1,0,48.50,0.00,47.50,0.00,47.50,0.00,47.50,0.00,47.50,0.00,47.50,0.00,47.50,0.00,0.000,0.000,99999.000,1),
  (640,'JAMON LUNCH KIR',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,27.00,2.00,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,100.000,50.000,99986.400,1),
  (641,'JAMON SAN RAFAEL',1,0,1,'x','','','','',2,0.00,0.00,0,65.00,6.00,1,0,74.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,0.000,0.000,99997.400,1),
  (642,'JAMON SANTA LUCIA',1,0,1,'x','','','','',2,0.00,0.00,0,24.00,5.00,1,0,30.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,27.00,0.00,25.00,0.00,0.000,0.000,99999.000,1),
  (643,'JAMON SERRANO',1,0,1,'x','','','','',2,0.00,0.00,0,160.00,6.00,0,0,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,180.00,0.00,0.000,0.000,99999.000,1),
  (644,'JAMON SERRANO CUMBRES',1,0,1,'x','','','','',2,0.00,0.00,0,140.00,6.00,1,0,160.00,0.00,148.00,0.00,148.00,0.00,148.00,0.00,148.00,0.00,148.00,0.00,148.00,0.00,0.000,0.000,99999.000,1),
  (645,'JAMON VIRGINIA ALPINO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,35.00,5.00,1,0,40.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (646,'JAMON VIRGINIA DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,25.30,5.00,1,0,28.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,0.000,0.000,99999.000,1),
  (647,'JAMON VIRGINIA FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,41.70,5.00,1,2,50.00,160.00,50.00,250.00,48.50,242.50,47.50,237.50,42.50,212.50,42.50,160.00,42.50,160.00,0.000,0.000,99995.060,1),
  (648,'JAMON VIRGINIA RIOJANO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,37.00,5.00,1,0,40.00,0.00,38.50,0.00,38.50,0.00,38.50,0.00,38.50,0.00,38.50,0.00,38.50,0.00,0.000,0.000,99999.000,1),
  (649,'JAMON YORK DE PIERNA FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,63.00,6.00,1,0,70.00,0.00,68.00,0.00,68.00,0.00,68.00,0.00,68.00,0.00,68.00,0.00,65.00,0.00,0.000,0.000,99999.000,1),
  (650,'JARABE DE TRES LECHES',0,0,1,'x','','','','',1,90.00,0.00,0,0.00,0.00,0,0,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,99999.000,1),
  (651,'JARABE DE TRES LECHES 1 LT',0,0,1,'x','','','','',1,28.00,0.00,0,0.00,0.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99999.000,1),
  (652,'JUGO MAGGI 800 ML',0,0,3,'x','','','','',1,55.00,0.00,0,0.00,0.00,0,0,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,58.00,0.00,0.000,0.000,9999.000,1),
  (653,'JUMEX MINIBRIK',0,0,2,'x','','','','',1,3.00,120.00,40,0.00,0.00,1,1,5.00,126.00,3.15,126.00,3.15,126.00,3.15,126.00,3.15,126.00,3.15,126.00,3.15,126.00,0.000,0.000,0.000,0),
  (654,'KNOR SUIZA 1.6',0,0,3,'x','','','','',1,75.00,0.00,0,0.00,0.00,0,0,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,80.00,0.00,0.000,0.000,99999.000,1),
  (655,'KNORK SUIZA GALON',0,0,3,'x','','','','',1,150.00,600.00,4,0.00,0.00,1,1,168.00,620.00,155.00,620.00,155.00,620.00,155.00,620.00,155.00,620.00,155.00,620.00,155.00,620.00,0.000,0.000,99999.000,1),
  (656,'KNORK SUIZA 50/22 GR',0,0,1,'x','','','','',1,100.00,0.00,0,0.00,0.00,0,0,108.00,0.00,108.00,0.00,108.00,0.00,108.00,0.00,108.00,0.00,108.00,0.00,108.00,0.00,0.000,0.000,99999.000,1),
  (657,'KNORK TOMATE EXH',0,0,1,'x','','','','',1,58.00,0.00,0,0.00,0.00,0,0,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,63.00,0.00,0.000,0.000,99999.000,1),
  (658,'KONTIKI',0,1,2,'x','','','','',1,1.00,20.00,20,0.00,0.00,0,1,2.00,24.00,2.00,24.00,2.00,24.00,2.00,24.00,2.00,24.00,2.00,24.00,2.00,24.00,0.000,0.000,999999.000,1),
  (659,'LECHE ALPURA 2000',0,0,1,'GPL860521FW8','','','','',1,9.65,115.80,12,0.00,0.00,1,1,10.50,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,0.000,0.000,99535.000,1),
  (660,'LECHE ALPURA 250 ML',0,0,1,'GPL860521FW8','','','','',1,3.22,87.00,27,0.00,0.00,1,1,4.00,90.00,3.33,90.00,3.33,90.00,3.33,90.00,3.33,90.00,3.33,90.00,3.33,90.00,0.000,0.000,99999.000,1),
  (661,'LECHE ALPURA 40 YTANTOS',0,0,1,'GPL860521FW8','','','','',1,10.70,128.40,12,0.00,0.00,1,1,11.60,132.00,11.00,132.00,11.00,132.00,11.00,132.00,11.00,132.00,11.00,132.00,11.00,132.00,0.000,0.000,99999.000,1),
  (662,'LECHE ALPURA DESCREMADA',0,0,1,'GPL860521FW8','','','','',1,9.65,115.80,12,0.00,0.00,1,1,10.50,126.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,0.000,0.000,99999.000,1),
  (663,'LECHE ALPURA DESLACTOSADA',0,0,1,'GPL860521FW8','','','','',1,10.70,128.40,12,0.00,0.00,1,1,11.60,133.00,11.08,133.00,11.00,132.00,10.92,131.00,10.83,130.00,10.83,130.00,10.83,130.00,0.000,0.000,99926.000,1),
  (664,'LECHE ALPURA LIGHT',0,0,1,'GPL860521FW8','','','','',1,9.65,118.00,12,0.00,0.00,1,1,10.50,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,0.000,0.000,9987.000,1),
  (665,'LECHE ASPEN',0,0,1,'x','','','','',1,75.00,0.00,0,0.00,0.00,0,0,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,77.00,0.00,0.000,0.000,9999.000,1),
  (666,'LECHE CLAVEL 1 LT',0,0,3,'x','','','','',1,19.16,230.00,12,0.00,0.00,1,1,21.00,238.00,19.83,238.00,19.83,238.00,19.83,238.00,19.83,238.00,19.83,238.00,19.83,238.00,0.000,0.000,99999.000,1),
  (667,'LECHE CONDENSADA LECHERA 397 GR',0,0,3,'GAA970226DL8','','','','',1,11.03,529.25,48,0.00,0.00,1,1,12.50,550.00,12.00,576.00,11.80,566.40,11.46,550.08,11.46,550.00,11.46,550.00,11.46,550.00,0.000,0.000,9997.000,1),
  (668,'LECHE CONDENSADA DULCIMA 10 KG',0,0,1,'x','','','','',1,196.00,0.00,0,0.00,0.00,0,0,205.00,0.00,205.00,0.00,205.00,0.00,205.00,0.00,205.00,0.00,205.00,0.00,205.00,0.00,0.000,0.000,99999.000,1),
  (669,'LECHE CONDENSADA NORDIKA 1 KG',0,0,1,'x','','','','',1,22.08,530.00,24,0.00,0.00,1,1,23.00,545.00,22.71,545.00,22.71,545.00,22.71,545.00,22.71,545.00,22.71,545.00,22.71,545.00,0.000,0.000,99999.000,1),
  (670,'LOMO CANADIENSE  HERTI',1,0,1,'MAL990429SE5','','','','',2,0.00,0.00,0,49.00,1.00,1,0,52.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,50.00,0.00,0.000,0.000,99999.000,1),
  (671,'LONGANIZA A/V DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,21.00,1.00,0,0,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,24.00,0.00,0.000,0.000,999999.000,1),
  (672,'LONGANIZA RIOJANO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,31.50,1.00,1,0,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,33.00,0.00,32.50,0.00,100.000,50.000,99992.540,1),
  (673,'LONGANIZA RIVERA',1,0,1,'x','','','','',2,0.00,0.00,0,22.00,1.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,99999.000,1),
  (674,'MAIZ POZOLERO A/V',0,0,1,'x','','','','',1,7.00,0.00,0,0.00,0.00,0,0,8.50,0.00,8.50,0.00,8.50,0.00,8.50,0.00,8.50,0.00,8.50,0.00,8.50,0.00,0.000,0.000,99934.000,1),
  (675,'MAIZ POZOLERO C/AGUA',0,0,1,'x','','','','',1,5.00,0.00,0,0.00,0.00,0,0,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,99999.000,1),
  (676,'MANTECA',0,0,1,'x','','','','',1,10.00,0.00,0,0.00,0.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,99999.000,1),
  (677,'MANTECA CAPITAN',0,0,1,'x','','','','',1,180.00,0.00,0,0.00,0.00,0,0,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,0.000,0.000,99999.000,1),
  (678,'MANTECA COMBATE',0,0,1,'x','','','','',1,200.00,0.00,0,0.00,0.00,0,0,210.00,0.00,210.00,0.00,210.00,0.00,210.00,0.00,210.00,0.00,210.00,0.00,210.00,0.00,0.000,0.000,99999.000,1),
  (679,'MANTECA INCA',0,0,1,'x','','','','',1,17.08,205.00,12,0.00,0.00,1,1,18.00,212.00,17.67,212.00,17.67,212.00,17.67,212.00,17.67,212.00,17.67,212.00,17.67,212.00,0.000,0.000,99999.000,1),
  (680,'MANTEQUILLA',1,0,1,'x','','','','',2,0.00,0.00,0,10.00,1.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,99990.000,1),
  (681,'MANTEQUILLA GLORIA PORCION',0,0,1,'x','','','','',1,115.00,0.00,0,0.00,0.00,0,0,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,0.000,0.000,99999.000,1),
  (682,'MANTEQUILLA LALA 90 GR',0,0,1,'x','','','','',1,4.25,85.00,20,0.00,0.00,1,1,5.00,90.00,4.50,90.00,4.50,90.00,4.50,90.00,4.50,90.00,4.50,90.00,4.50,90.00,0.000,0.000,999999.000,1),
  (683,'MARGARINA CHILCHOTA 1 KG',0,0,1,'x','','','','',1,14.00,140.00,10,0.00,0.00,1,1,16.00,145.00,14.50,145.00,14.50,145.00,14.50,145.00,14.50,145.00,14.50,145.00,14.50,145.00,0.000,0.000,99999.000,1),
  (684,'MANTEQUILLA CHIPILO 90 GR',0,0,1,'UNI9704247M2','','','','',1,3.75,90.00,24,0.00,0.00,1,1,4.50,105.00,4.38,105.00,4.38,105.00,4.38,105.00,4.38,105.00,4.38,105.00,4.38,105.00,0.000,0.000,99999.000,1),
  (685,'MANTEQUILLA CHIPILO 225 GR',0,0,1,'UNI9704247M2','','','','',1,8.88,80.00,9,0.00,0.00,1,1,12.00,88.00,9.78,88.00,9.78,88.00,9.78,88.00,9.78,88.00,9.78,88.00,9.78,88.00,0.000,0.000,9999.000,1),
  (686,'MANTEQUILLA CHIPILO 1 KG',0,0,1,'UNI9704247M2','','','','',1,20.00,200.00,10,0.00,0.00,1,1,23.00,213.00,21.30,213.00,21.30,213.00,21.30,213.00,21.30,213.00,21.30,213.00,21.30,213.00,2.000,0.000,99998.000,1),
  (687,'MARGARINA DELICIAS 1 KG',0,0,1,'x','','','','',1,14.00,140.00,10,0.00,0.00,1,1,16.00,148.00,14.80,148.00,14.80,148.00,14.80,148.00,14.80,148.00,14.80,148.00,14.80,148.00,0.000,0.000,99999.000,1),
  (688,'MARGARINA FLEX 1 KG',0,0,1,'x','','','','',1,12.00,120.00,10,0.00,0.00,1,1,16.00,148.00,14.80,148.00,14.80,148.00,14.80,148.00,14.80,148.00,14.80,148.00,13.50,135.00,0.000,0.000,99999.000,1),
  (689,'MARGARINA SAN ANTONIO 1 KG',0,0,1,'x','','','','',1,13.00,130.00,10,0.00,0.00,1,1,16.00,140.00,14.00,140.00,14.00,140.00,14.00,140.00,14.00,140.00,14.00,140.00,14.00,140.00,0.000,0.000,99999.000,1),
  (690,'MAYONESA',0,0,1,'x','','','','',1,18.00,0.00,0,0.00,0.00,0,0,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,0.000,0.000,99999.000,1),
  (691,'MAYONESA CHULAVISTA',0,0,3,'x','','','','',1,55.00,220.00,4,0.00,0.00,1,1,60.00,225.00,56.25,225.00,56.25,225.00,56.25,225.00,56.25,225.00,56.25,225.00,56.25,225.00,0.000,0.000,99999.000,1),
  (692,'MAYONESA HELLMANS',0,0,3,'x','','','','',1,90.00,360.00,4,0.00,0.00,1,1,94.00,370.00,92.50,370.00,92.50,370.00,92.50,370.00,92.50,370.00,92.50,370.00,92.50,370.00,0.000,0.000,99999.000,1),
  (693,'MERMELADA',1,0,3,'x','','','','',2,0.00,0.00,0,8.80,25.00,1,2,12.00,278.00,11.50,287.50,11.12,278.00,10.00,250.00,10.00,250.00,10.00,250.00,10.00,250.00,0.000,0.000,99997.900,1),
  (694,'MERMELADA CLEMENTE JACQUES 300 GR',0,0,3,'x','','','','',1,10.33,248.00,24,0.00,0.00,1,1,12.50,254.00,10.58,254.00,10.58,254.00,10.58,254.00,10.58,254.00,10.58,254.00,10.58,254.00,0.000,0.000,99999.000,1),
  (695,'MERMELADA CLEMENTE JACQUES 500 GR',0,0,3,'x','','','','',1,14.16,170.00,12,0.00,0.00,1,1,17.00,180.00,15.00,180.00,15.00,180.00,15.00,180.00,15.00,180.00,15.00,180.00,15.00,180.00,0.000,0.000,99999.000,1),
  (696,'MERMELADA DE CHABACANO',0,0,3,'x','','','','',1,15.00,0.00,0,0.00,0.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,99999.000,1),
  (697,'MERMELADA DE PIÑA',0,0,1,'x','','','','',1,12.00,0.00,0,0.00,0.00,0,0,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,0.000,0.000,99999.000,1),
  (698,'MERMELADA DE ZARZAMORA',0,0,3,'x','','','','',1,12.00,0.00,0,0.00,0.00,0,0,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,15.00,0.00,0.000,0.000,99999.000,1),
  (699,'MIEL',0,0,1,'x','','','','',1,9.20,230.00,25,0.00,0.00,0,1,11.00,240.00,11.00,240.00,11.00,240.00,11.00,240.00,11.00,240.00,11.00,240.00,11.00,240.00,0.000,0.000,99999.000,1),
  (700,'MIEL FRASCO',0,0,3,'x','','','','',1,13.00,0.00,0,0.00,0.00,0,0,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,0.000,0.000,99998.000,1),
  (701,'MOLE DE PASTA',0,0,1,'x','','','','',1,32.00,0.00,0,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (702,'MOSTAZA',0,0,3,'x','','','','',1,8.00,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,999999.000,1),
  (703,'NACHOS BARCEL',0,0,1,'x','','','','',1,18.00,54.00,3,0.00,0.00,1,1,19.50,57.00,19.00,57.00,19.00,57.00,19.00,57.00,19.00,57.00,19.00,57.00,19.00,57.00,0.000,0.000,99999.000,1),
  (704,'NESCAFE CLASICO 200 GR',0,0,3,'x','','','','',1,38.33,460.00,12,0.00,0.00,1,1,42.00,465.00,38.75,465.00,38.75,465.00,38.75,465.00,38.75,465.00,38.75,465.00,38.75,465.00,0.000,0.000,99999.000,1),
  (705,'MORTADELA FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,20.50,4.00,1,0,23.50,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,0.000,0.000,99999.000,1),
  (706,'NATILLA DANETTE 200 GR',0,0,1,'VAPB730831UM9','x','','','',1,2.81,135.00,48,0.00,0.00,1,1,3.50,140.00,2.92,140.00,2.92,140.00,2.92,140.00,2.92,140.00,2.92,140.00,2.92,140.00,0.000,0.000,99992.000,1),
  (707,'NESK QUICK',0,0,1,'GAA970226DL8','','','','',1,4.37,118.00,27,0.00,0.00,1,1,5.50,130.00,4.81,130.00,4.63,125.00,4.44,120.00,4.44,120.00,4.44,120.00,4.44,120.00,0.000,0.000,99972.000,1),
  (708,'NUTRILECHE1 LT',0,0,1,'x','','','','',1,7.75,95.00,12,0.00,0.00,1,1,9.50,103.00,8.58,103.00,8.50,102.00,8.34,100.00,8.34,100.00,8.34,100.00,8.34,100.08,0.000,0.000,99675.000,1),
  (709,'QUESO OAXACA FRANJA',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,47.00,4.00,0,0,50.50,0.00,50.50,0.00,50.50,0.00,50.50,0.00,50.50,0.00,50.50,0.00,50.50,0.00,0.000,0.000,99999.000,1),
  (710,'PALOMITASMICROHONDAS MANTEQ 18 PZ',0,0,3,'x','','','','',1,51.00,204.00,4,0.00,0.00,1,1,55.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,0.000,0.000,99999.000,1),
  (711,'PALOMITAS MICROHONDAS NATURAL 18 PZ',0,0,3,'AMO930202EQ6','','','','',1,51.00,204.00,4,0.00,0.00,1,1,55.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,53.00,212.00,0.000,0.000,99999.000,1),
  (712,'PALOMITAS MICROHONDAS QUESO-CARAMEL',0,0,3,'x','','','','',1,70.00,280.00,4,0.00,0.00,1,1,78.00,300.00,75.00,300.00,75.00,300.00,75.00,300.00,75.00,300.00,75.00,300.00,75.00,300.00,0.000,0.000,99999.000,1),
  (713,'PALOMITAS MICROHONDAS 12 PZ',0,0,3,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (714,'PAN ARABE',0,0,1,'x','','','','',1,15.00,0.00,0,0.00,0.00,0,0,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,20.00,0.00,0.000,0.000,9999.000,1),
  (715,'PAPAS A LA FRANCESA',0,0,1,'x','','','','',1,30.83,185.00,6,0.00,0.00,1,1,34.00,190.00,31.67,190.00,31.67,190.00,31.67,190.00,31.67,190.00,31.67,190.00,31.67,190.00,0.000,0.000,99999.000,1),
  (716,'PASTEL PIMIENTO',1,0,1,'APA850331PZ1','','','','',2,0.00,0.00,0,18.90,4.00,0,0,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,0.000,0.000,99999.000,1),
  (717,'PAU PAU',0,1,2,'x','','','','',1,1.45,35.00,24,0.00,0.00,1,1,3.00,40.00,1.67,40.00,1.67,40.00,1.67,40.00,1.67,40.00,1.67,40.00,1.67,40.00,0.000,0.000,9999.000,1),
  (718,'PECHUGA DE PAVO MADISON',1,0,1,'x','','','','',2,0.00,0.00,0,55.00,5.00,1,0,62.00,0.00,59.00,0.00,59.00,0.00,59.00,0.00,59.00,0.00,59.00,0.00,59.00,0.00,0.000,0.000,99999.000,1),
  (719,'PECHUGA DE PAVO SAN ANTONIO',1,0,1,'x','','','','',2,0.00,0.00,0,35.00,4.00,1,0,42.00,0.00,38.50,0.00,38.50,0.00,38.50,0.00,38.50,0.00,38.50,0.00,38.50,0.00,0.000,0.000,99999.000,1),
  (720,'PECHUGA DE PAVO SAN RAFAEL',1,0,1,'x','','','','',2,0.00,0.00,0,75.00,5.00,1,0,85.00,0.00,81.00,0.00,81.00,0.00,81.00,0.00,81.00,0.00,81.00,0.00,81.00,0.00,0.000,0.000,99999.000,1),
  (721,'PIERNA T AMERICANA DHECTTOR',1,0,1,'SJM880607FU8','','','','',2,0.00,0.00,0,25.00,6.00,1,0,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,0.000,0.000,99999.000,1),
  (722,'PIÑA EN ALMIBAR 850 GR',0,0,3,'ALC0011111Y9','','','','',1,12.50,300.00,24,0.00,0.00,1,1,14.00,324.00,13.50,324.00,13.50,324.00,13.50,324.00,13.50,324.00,13.50,324.00,13.50,324.00,500.000,250.000,99999.000,1),
  (723,'PIÑA EN ALMIBAR EN  TROZO 3.00 KG',0,0,3,'ALC0011111Y9','','','','',1,43.34,260.00,6,0.00,0.00,1,1,50.00,290.00,48.33,290.00,48.33,290.00,48.33,290.00,48.33,290.00,48.33,290.00,48.33,290.00,0.000,0.000,99999.000,1),
  (724,'PIÑA REBANADA 2.800 KG',0,0,3,'x','','','','',1,44.16,265.00,6,0.00,0.00,1,1,54.00,315.00,52.50,315.00,52.50,315.00,52.50,315.00,52.50,315.00,52.50,315.00,52.50,315.00,0.000,0.000,9999.000,1),
  (725,'PIZZA CHICA',0,0,1,'DLC050125K82','','','','',1,15.00,0.00,0,0.00,0.00,0,0,16.50,0.00,16.50,0.00,16.50,0.00,16.50,0.00,16.50,0.00,16.50,0.00,16.50,0.00,0.000,0.000,9999.000,1),
  (726,'ºPIZZA GRANDE',0,0,1,'x','','','','',1,45.00,0.00,0,0.00,0.00,0,0,48.50,0.00,48.50,0.00,48.50,0.00,48.50,0.00,48.50,0.00,48.50,0.00,48.50,0.00,0.000,0.000,9999.000,1),
  (727,'QUESO PROVOLONE AHUMADO',1,0,1,'x','','','','',2,0.00,0.00,0,65.00,1.00,0,0,70.00,0.00,70.00,0.00,70.00,0.00,70.00,0.00,70.00,0.00,70.00,0.00,70.00,0.00,0.000,0.000,999999.000,1),
  (728,'PURE DE TOMATE 2.900 KG',0,0,3,'x','','','','',1,28.00,168.00,6,0.00,0.00,1,1,32.00,180.00,30.00,180.00,30.00,180.00,30.00,180.00,30.00,180.00,30.00,180.00,30.00,180.00,0.000,0.000,9998.000,1),
  (729,'PURE DE TOMATE 800 GR',0,0,3,'x','','','','',1,12.00,0.00,0,0.00,0.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,9999.000,1),
  (730,'PURE DE TOMATE 1 KG',0,0,3,'x','','','','',1,8.75,105.00,12,0.00,0.00,1,1,11.00,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,10.83,130.00,0.000,0.000,99999.000,1),
  (731,'QUESO AMARILLO KRAFT BARRA',0,0,1,'x','','','','',1,100.00,0.00,0,0.00,0.00,0,0,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,0.000,0.000,9999.000,1),
  (732,'QUESO AMARILLO SINGLESS 1.800 KG',0,0,1,'x','','','','',1,100.00,0.00,0,0.00,0.00,0,0,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,110.00,0.00,0.000,0.000,9999.000,1),
  (733,'QUESO CAMEMBERT RENY',0,0,1,'AIÑ911217SF4','','','','',1,150.00,0.00,0,0.00,0.00,0,0,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,160.00,0.00,0.000,0.000,99999.000,1),
  (734,'QUESO CHIHUAHUA COUNTRY',1,0,1,'x','','','','',2,0.00,0.00,0,28.00,4.00,1,0,32.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99999.000,1),
  (735,'QUESO COTTAGE BORDEN',0,0,1,'x','','','','',1,30.00,0.00,0,0.00,0.00,0,0,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,0.000,0.000,99999.000,1),
  (736,'QUESO CUBICADO PIZZERO',0,0,1,'x','','','','',1,200.00,400.00,2,0.00,0.00,1,1,215.00,425.00,212.50,425.00,212.50,425.00,212.50,425.00,212.50,425.00,212.50,425.00,212.50,425.00,0.000,0.000,99999.000,1),
  (737,'QUESO DE PUERCO FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,25.00,4.00,1,2,35.00,124.30,33.00,124.30,33.00,124.30,33.00,124.30,33.00,124.30,33.00,124.30,33.00,124.30,0.000,0.000,99999.000,1),
  (738,'QUESO DE PUERCO SAGITARIO',1,0,1,'EHC951010S36','','','','',2,0.00,0.00,0,16.00,4.00,1,0,25.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,0.000,0.000,9999.000,1),
  (739,'QUESO GORGONZOSA',0,0,1,'x','','','','',1,160.00,0.00,0,0.00,0.00,0,0,170.00,0.00,170.00,0.00,170.00,0.00,170.00,0.00,170.00,0.00,170.00,0.00,170.00,0.00,0.000,0.000,99999.000,1),
  (740,'QUESO GORGONZOLA BELGI-O-IOSO',0,0,1,'x','','','','',1,180.00,0.00,0,0.00,0.00,0,0,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,190.00,0.00,0.000,0.000,99999.000,1),
  (741,'QUESO MANCHEGO NUEVA ZELANDA',1,0,1,'x','','','','',2,0.00,0.00,0,45.00,10.00,1,0,56.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,0.000,0.000,99999.000,1),
  (742,'QUESO MASCARPONE 225 GR',0,0,1,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,0.000,0.000,999999.000,1),
  (743,'QUESO MOZARELLA',0,0,1,'x','','','','',1,70.00,0.00,0,0.00,0.00,0,0,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,75.00,0.00,0.000,0.000,99999.000,0),
  (744,'QUESO OAXACA NOCHEBUENA',1,0,1,'x','','','','',2,0.00,0.00,0,60.00,4.00,0,0,65.00,0.00,65.00,0.00,65.00,0.00,65.00,0.00,65.00,0.00,65.00,0.00,65.00,0.00,0.000,0.000,99999.000,1),
  (745,'QUESO OAXACA SAN ADRIAN',1,0,1,'x','','','','',2,0.00,0.00,0,49.00,4.00,1,0,55.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,0.000,0.000,99996.465,1),
  (746,'QUESO PANELA FRANJA',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,37.00,2.50,1,0,44.00,0.00,41.00,0.00,41.00,0.00,41.00,0.00,41.00,0.00,41.00,0.00,38.00,0.00,0.000,0.000,999996.760,1),
  (747,'QUESO PHILADELPHIA UNTABLE 180 GR',0,0,1,'x','','','','',1,15.00,0.00,0,0.00,0.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,999999.000,1),
  (748,'QUESO RAYADO CANADA',0,0,1,'x','','','','',1,14.00,0.00,0,0.00,0.00,0,0,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,0.000,0.000,999999.000,1),
  (749,'QUESO RAYADO ESPECIAL',0,0,1,'x','','','','',1,8.50,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,99999.000,1),
  (750,'QUESO ROQUEFOUR',1,0,1,'x','','','','',2,0.00,0.00,0,100.00,1.00,0,0,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,120.00,0.00,0.000,0.000,999999.000,1),
  (751,'QUESO SUIZO NORMEX',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,49.50,4.00,1,0,52.00,0.00,51.00,0.00,51.00,0.00,51.00,0.00,51.00,0.00,51.00,0.00,51.00,0.00,100.000,50.000,999999.000,1),
  (752,'QUESO TENATE',0,0,1,'x','','','','',1,55.00,0.00,0,0.00,0.00,0,0,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,60.00,0.00,0.000,0.000,999999.000,1),
  (753,'SANGRIA 600 GR',0,1,2,'x','','','','',1,4.08,98.00,24,0.00,0.00,1,1,5.00,105.00,4.38,105.00,4.25,102.00,4.25,102.00,4.25,102.00,4.25,102.00,4.17,100.00,0.000,0.000,99999.000,1),
  (754,'SALAMI FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,43.00,2.00,0,2,48.00,78.00,48.00,78.00,48.00,78.00,48.00,78.00,48.00,78.00,48.00,78.00,48.00,78.00,0.000,0.000,99999.000,1),
  (755,'SALCHICHA DE PAVO TURKEY FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,23.00,2.30,1,2,29.00,52.00,26.50,52.00,26.50,52.00,26.50,52.00,26.50,52.00,26.50,52.00,24.00,52.00,0.000,0.000,99991.240,1),
  (756,'SALCHICHA JUMBO',0,0,1,'QAO680613E91','','','','',1,24.02,0.00,0,0.00,0.00,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,99999.000,1),
  (757,'SALCHICHA DE PAVO PAVINO',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,27.00,2.30,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,150.000,100.000,99999.000,1),
  (758,'SALCHICHA VIENA ZWAN',1,0,1,'x','','','','',2,0.00,0.00,0,21.30,2.50,0,0,25.20,0.00,25.20,0.00,25.20,0.00,25.20,0.00,25.20,0.00,25.20,0.00,25.20,0.00,0.000,0.000,99999.000,1),
  (759,'SALCHICHA VIVA',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,16.20,2.50,1,2,20.00,42.00,18.50,42.00,18.50,42.00,18.50,42.00,18.50,42.00,18.50,42.00,18.50,42.00,0.000,0.000,99996.480,1),
  (760,'SOPA DE PASTA',0,0,3,'x','','','','',1,45.00,0.00,0,0.00,0.00,0,0,49.00,0.00,49.00,0.00,49.00,0.00,49.00,0.00,49.00,0.00,49.00,0.00,49.00,0.00,0.000,0.000,99999.000,1),
  (761,'SPIRIT',0,1,2,'x','','','','',1,7.91,190.00,24,0.00,0.00,1,1,10.00,205.00,8.54,205.00,8.54,205.00,8.54,205.00,8.54,205.00,8.54,205.00,8.54,205.00,0.000,0.000,99999.000,0),
  (762,'SPLASH V8',0,1,2,'x','','','','',1,6.66,80.00,12,0.00,0.00,1,1,10.00,88.00,7.33,88.00,7.33,88.00,7.33,88.00,7.33,88.00,7.33,88.00,6.83,82.00,0.000,0.000,99975.000,1),
  (763,'SQUIRT 2.5 LT',0,1,2,'x','','','','',1,9.75,78.00,8,0.00,0.00,1,1,13.00,85.00,10.63,85.00,10.63,85.00,10.63,85.00,10.63,85.00,10.63,85.00,10.63,85.00,0.000,0.000,999975.000,1),
  (764,'TOCINO FUD',1,0,1,'DLC050125K82','','','','',2,0.00,0.00,0,40.00,3.00,0,0,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,45.00,0.00,0.000,0.000,99999.000,1),
  (765,'TOCINO FUD 180 GR',0,0,1,'DLC050125K82','','','','',1,17.00,0.00,0,0.00,0.00,0,0,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,0.000,0.000,99999.000,1),
  (766,'VINAGRE 1 LT',0,0,3,'x','','','','',1,4.33,52.00,12,0.00,0.00,1,1,10.00,75.00,8.00,75.00,6.25,75.00,5.00,60.00,5.00,60.00,5.00,60.00,5.00,60.00,0.000,0.000,99998.000,1),
  (767,'VINAGRE 4 LT',0,0,3,'x','','','','',1,15.00,60.00,4,0.00,0.00,1,1,17.00,64.00,16.00,64.00,16.00,64.00,16.00,64.00,16.00,64.00,16.00,64.00,16.00,64.00,0.000,0.000,99999.000,1),
  (768,'FIRST 3.3',0,0,2,'x','','','','',1,9.16,55.00,6,0.00,0.00,0,1,10.00,60.00,10.00,60.00,10.00,60.00,10.00,60.00,10.00,60.00,10.00,60.00,10.00,60.00,0.000,0.000,99999.000,1),
  (769,'ENERGI MONSTER',0,1,2,'x','','','','',1,17.50,420.00,24,0.00,0.00,1,1,20.00,450.00,18.75,450.00,18.75,450.00,18.75,450.00,18.75,450.00,18.75,450.00,18.75,450.00,0.000,0.000,99999.000,1),
  (770,'MOSTAZA VENECIA 3.9 KG',0,0,1,'x','','','','',1,35.00,0.00,0,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (771,'JUGO DEL VALLE 1 LT',0,0,1,'x','','','','',1,10.00,120.00,12,0.00,0.00,1,1,11.00,125.00,10.42,125.00,10.42,125.00,10.42,125.00,10.42,125.00,10.42,125.00,10.42,125.00,0.000,0.000,99999.000,1),
  (772,'SALSA CATSUP COSTEÑA 1 KG',0,0,3,'x','','','','',1,10.00,120.00,12,0.00,0.00,1,1,11.50,125.00,10.42,125.00,10.33,124.00,10.25,123.00,10.25,123.00,10.25,123.00,10.25,123.00,0.000,0.000,99999.000,1),
  (773,'FLAN ART 240 GR',0,0,1,'x','','','','',1,5.00,0.00,0,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,99993.000,1),
  (774,'SALCHICHA DE PAVO DYN',1,0,1,'APA850331PZ1','','','','',2,0.00,0.00,0,18.00,2.00,0,0,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,22.00,0.00,0.000,0.000,99999.000,1),
  (775,'SALCHICHA DE PAVO MONTEJANO',1,0,1,'CPA051124K21','','','','',2,0.00,0.00,0,16.00,2.00,0,0,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,0.000,0.000,999999.000,1),
  (776,'SALCHICHA MANANTIALES',1,0,1,'x','','','','',2,0.00,0.00,0,10.30,2.00,0,0,11.50,0.00,11.50,0.00,11.50,0.00,11.50,0.00,11.50,0.00,11.50,0.00,11.50,0.00,0.000,0.000,99999.000,1),
  (777,'MARGARINA CHANTILLY PRIMAVERA 400',0,0,1,'x','','','','',1,12.00,144.00,12,0.00,0.00,1,1,14.00,165.00,13.75,165.00,13.75,165.00,13.75,165.00,13.75,165.00,13.75,165.00,13.75,165.00,0.000,0.000,99999.000,1),
  (778,'MARGARINA CHANTILLY PRIMAVERA 800',0,0,1,'x','','','','',1,25.00,150.00,6,0.00,0.00,1,1,28.00,151.15,25.19,151.15,25.19,151.15,25.19,151.15,25.19,151.15,25.19,151.15,25.19,151.15,0.000,0.000,99999.000,1),
  (779,'JAMON AMERICANO DKAR',1,0,1,'x','','','','',2,0.00,0.00,0,25.00,5.00,0,0,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,27.50,0.00,0.000,0.000,99999.000,1),
  (780,'JAMON SABOREL',1,0,1,'x','','','','',2,0.00,0.00,0,24.00,5.00,0,0,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,999990.000,1),
  (781,'JAMON AMERICANO MANANTIALES',1,0,1,'x','','','','',2,0.00,0.00,0,29.00,5.00,0,0,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,99999.000,1),
  (782,'JAMON COCIDO S/M',1,0,1,'x','','','','',2,0.00,0.00,0,14.00,5.00,0,0,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,16.00,0.00,0.000,0.000,99999.000,1),
  (783,'JAMON SAGITARIO',1,0,1,'EHC951010S36','','','','',2,0.00,0.00,0,25.50,5.00,1,0,29.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,27.50,0.00,26.50,0.00,500.000,250.000,99999.000,1),
  (784,'JAMON DKAR',1,0,1,'x','','','','',2,0.00,0.00,0,24.00,5.00,1,0,32.50,0.00,30.00,0.00,29.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,99981.080,1),
  (785,'JAMON HORNEADO SABOREL',1,0,1,'x','','','','',2,0.00,0.00,0,34.00,5.00,0,0,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,36.00,0.00,0.000,0.000,99999.000,1),
  (786,'JAMON MANANTIALES',1,0,1,'x','','','','',2,0.00,0.00,0,23.00,5.00,0,0,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,0.000,0.000,999947.000,1),
  (787,'JAMON HACIENDA BLANCO',1,0,1,'x','','','','',2,0.00,0.00,0,16.00,5.00,0,0,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,0.000,0.000,99999.000,1),
  (788,'JAMON S/M',1,0,1,'x','','','','',2,0.00,0.00,0,14.00,5.00,0,0,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,17.00,0.00,0.000,0.000,999999.000,1),
  (789,'JAMON HORNEADO DE PIERNA SABADEL',1,0,1,'x','','','','',2,0.00,0.00,0,35.00,6.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (790,'JAMON PAR',1,0,1,'x','','','','',2,0.00,0.00,0,30.00,5.00,0,0,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,999999.000,1),
  (791,'JAMON DE PAVO SABADEL',1,0,1,'x','','','','',2,0.00,0.00,0,36.00,5.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,99999.000,1),
  (792,'JAMON VIRGINIA SABADEL',1,0,1,'x','','','','',2,0.00,0.00,0,36.00,5.00,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,0.000,0.000,99999.000,1),
  (793,'JAMON DE PAVO DOS RIOS',1,0,1,'x','','','','',2,0.00,0.00,0,38.00,5.00,0,0,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,42.00,0.00,0.000,0.000,99999.000,1),
  (794,'QUESO CANASTO LISTON ROJO',1,0,1,'x','','','','',2,0.00,0.00,0,45.00,6.00,0,0,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,48.00,0.00,0.000,0.000,9999.000,1),
  (795,'PECHUGA DE PAVO ZWAN',1,0,1,'QAO680613E91','','','','',2,0.00,0.00,0,66.00,5.00,0,0,69.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,69.00,0.00,0.000,0.000,99999.000,1),
  (796,'QUESO DELICIAS',1,0,1,'x','','','','',2,0.00,0.00,0,15.00,5.00,0,0,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,19.00,0.00,0.000,0.000,99999.000,1),
  (797,'LONGANIZA SABADEL',1,0,1,'x','','','','',2,0.00,0.00,0,28.00,1.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,99999.000,1),
  (798,'CHORIZO SABADEL',1,0,1,'x','','','','',2,0.00,0.00,0,30.00,1.00,0,0,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,99999.000,1),
  (799,'VIÑA REAL 2.5',0,1,2,'x','','','','',1,38.33,230.00,6,0.00,0.00,0,1,40.00,240.00,40.00,240.00,40.00,240.00,40.00,240.00,40.00,240.00,40.00,240.00,40.00,240.00,0.000,0.000,99981.000,1),
  (800,'PIÑA COLADA',0,1,2,'x','','','','',1,10.00,120.00,12,0.00,0.00,0,1,12.00,144.00,12.00,144.00,12.00,144.00,12.00,144.00,12.00,144.00,12.00,144.00,12.00,144.00,0.000,0.000,9999.000,1),
  (801,'VIÑA REAL 600 ML',0,0,1,'x','','','','',1,10.00,120.00,12,0.00,0.00,1,1,12.00,125.00,10.42,125.00,10.42,125.00,10.42,125.00,10.42,125.00,10.42,125.00,10.42,125.00,0.000,0.000,99999.000,1),
  (802,'COCA COLA LIGHT 2 LT',0,1,2,'x','','','','',1,11.87,95.00,8,0.00,0.00,1,1,15.00,100.00,12.50,100.00,12.50,100.00,12.50,100.00,12.50,100.00,12.50,100.00,12.50,100.00,0.000,0.000,9999.000,1),
  (803,'GATORADE CHUPON 600 ML',0,1,2,'x','','','','',1,10.00,240.00,24,0.00,0.00,1,1,13.00,245.00,10.21,245.00,10.21,245.00,10.21,245.00,10.21,245.00,10.21,245.00,10.21,245.00,0.000,0.000,9999.000,1),
  (804,'ACEITE CRISTAL 500 ML',0,0,3,'x','','','','',1,5.20,125.00,24,0.00,0.00,1,1,6.50,156.00,5.42,130.00,5.42,130.00,5.42,130.00,5.42,130.00,5.42,130.00,5.42,130.00,0.000,0.000,999999.000,1),
  (805,'PALOMA REAL 330 ML',0,0,2,'x','','','','',1,6.66,160.00,24,0.00,0.00,1,1,10.00,240.00,7.08,170.00,7.08,170.00,7.08,170.00,7.08,170.00,7.08,170.00,7.08,170.00,0.000,0.000,99999.000,1),
  (806,'RED MIX LATA',0,1,2,'x','','','','',1,7.29,175.00,24,0.00,0.00,1,1,10.00,175.00,7.29,175.00,7.29,175.00,7.29,175.00,7.29,175.00,7.29,175.00,7.29,175.00,0.000,0.000,99999.000,1),
  (807,'VINAGRE 500 ML',0,0,1,'x','','','','',1,4.00,0.00,0,0.00,0.00,0,0,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,5.00,0.00,0.000,0.000,99998.000,1),
  (808,'ADEREZO DE MAYONESA BACHI 3.8',0,0,3,'x','','','','',1,33.00,0.00,0,0.00,0.00,0,0,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,35.00,0.00,0.000,0.000,999998.000,1),
  (809,'MAYONESA MEGA',0,0,3,'DMA0106263S9','','','','',1,52.00,0.00,0,0.00,0.00,0,0,53.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,53.00,0.00,0.000,0.000,99999.000,1),
  (810,'PIERNA DE PAVO MADISON',1,0,1,'x','','','','',2,0.00,0.00,0,22.00,5.00,0,0,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,26.00,0.00,0.000,0.000,99999.000,1),
  (811,'LECHE LALA 1 LT',0,0,1,'x','','','','',1,9.00,108.00,12,0.00,0.00,1,1,10.50,126.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,9.83,118.00,0.000,0.000,99963.000,1),
  (812,'QUESO COTTAGE NORMEX 500 GR',0,0,1,'DMA0106263S9','','','','',1,19.50,0.00,0,0.00,0.00,0,0,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,21.00,0.00,0.000,0.000,9999.000,1),
  (813,'TOSTADA BORIS',0,0,1,'TBM9209297G9','','','','',1,4.71,141.50,30,0.00,0.00,0,1,4.90,147.00,4.90,147.00,4.90,147.00,4.90,147.00,4.90,147.00,4.90,147.00,4.90,147.00,0.000,0.000,9999.000,1),
  (814,'TOSTADA BORIS JUMBO',0,0,1,'TBM9209297G9','','','','',1,6.88,124.00,18,0.00,0.00,0,1,7.11,128.00,7.11,128.00,7.11,128.00,7.11,128.00,7.11,128.00,7.11,128.00,7.11,128.00,0.000,0.000,9999.000,1),
  (815,'QUESO PANELA CANASTA SELLO DE ORO',1,0,1,'AMO930202EQ6','','','','',2,0.00,0.00,0,43.50,2.20,0,0,46.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,46.00,0.00,500.000,250.000,500.000,1),
  (816,'QUESO OAXACA  MARTHA',1,0,1,'x','','','','',2,0.00,0.00,0,49.00,3.00,1,0,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,90.000,50.000,0.000,0),
  (817,'QUESO PANELA LORETO',1,0,1,'DMA0106263S9','','','','',2,0.00,0.00,0,36.50,2.50,0,0,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,40.00,0.00,150.000,50.000,9999999.000,1),
  (818,'QUESO ASADERO 3 KG',1,0,1,'GIC960719217','','','','',2,0.00,0.00,0,29.00,3.00,0,0,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,34.00,0.00,100.000,50.000,9999999.000,1),
  (819,'DON PUNCH LATA',0,1,2,'GKM0601209Z0','','','','',1,2.04,49.00,24,0.00,0.00,1,1,3.50,62.00,2.59,62.00,2.50,60.00,2.42,58.00,2.42,58.00,2.42,58.00,2.29,55.00,2400.000,480.000,9975.000,1),
  (820,'QUESO OAXACA MARTHA',1,0,1,'x','','','','',2,0.00,0.00,0,49.00,3.00,1,0,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,52.00,0.00,500.000,50.000,9995.600,1),
  (821,'QUESO OAXACA TEPILLO',1,0,1,'x','','','','',2,0.00,0.00,0,49.00,3.00,0,0,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,55.00,0.00,0.000,0.000,99999.000,1),
  (822,'YOGHURT SUIZER 4 LT',0,0,1,'PAL860319A25','','','','',1,38.00,0.00,0,0.00,0.00,1,0,42.00,0.00,42.00,0.00,40.00,0.00,39.00,0.00,39.00,0.00,39.00,0.00,39.00,0.00,0.000,0.000,99999.000,1),
  (823,'YOGHURT VIVE 0 LALA 250',0,0,1,'x','','','','',1,6.10,146.40,24,0.00,0.00,1,1,7.00,168.00,6.90,165.60,6.50,156.00,6.50,156.00,6.50,156.00,6.50,156.00,6.50,156.00,0.000,0.000,9999999.000,1);

COMMIT;

#
# Data for the `avisos` table  (LIMIT 0,500)
#

# automatico:3:49671
# frase:253:0
# activo:3:32768

INSERT INTO `avisos` (`automatico`, `frase`, `activo`) VALUES 
  (1,'Este 10 de Mayo en sus compras mayores a $300 lleve a mamá un regalo de sus amigo de \"El Retoño\"',1);

COMMIT;

