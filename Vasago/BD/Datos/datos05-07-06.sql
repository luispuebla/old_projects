# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `vasago`;



USE `vasago`;

#
# Structure for the `bancos` table : 
#

DROP TABLE IF EXISTS `bancos`;

CREATE TABLE `bancos` (
  `clave` int(1) NOT NULL auto_increment,
  `numero` varchar(30) collate latin1_spanish_ci default NULL,
  `banco` varchar(100) collate latin1_spanish_ci default NULL,
  `importeInicial` double(8,2) default NULL,
  `importeActual` double(8,2) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `rfc` varchar(13) collate latin1_spanish_ci NOT NULL default '',
  `nombre` varchar(80) collate latin1_spanish_ci NOT NULL default '',
  `direccion` varchar(80) collate latin1_spanish_ci NOT NULL default '',
  `colonia` varchar(25) collate latin1_spanish_ci default NULL,
  `delegacion` varchar(20) collate latin1_spanish_ci default NULL,
  `cp` varchar(5) collate latin1_spanish_ci default NULL,
  `ciudad` varchar(30) collate latin1_spanish_ci default NULL,
  `tipo` int(1) default NULL,
  `tel1` varchar(20) collate latin1_spanish_ci default NULL,
  `tel2` varchar(20) collate latin1_spanish_ci default NULL,
  `fax` varchar(20) collate latin1_spanish_ci default NULL,
  `email` varchar(80) collate latin1_spanish_ci default NULL,
  `diaCierran` int(1) default NULL,
  `horaComida` varchar(20) collate latin1_spanish_ci default NULL,
  `contacto` varchar(50) collate latin1_spanish_ci default NULL,
  `credito` double(8,2) default NULL,
  `pagoA` int(2) default NULL,
  `agente` varchar(8) collate latin1_spanish_ci default NULL,
  `alta` date default NULL,
  `activo` int(1) default '1',
  `saldoDisponible` double(8,2) default NULL,
  `bloqueoXPagoV` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `gastos` table : 
#

DROP TABLE IF EXISTS `gastos`;

CREATE TABLE `gastos` (
  `clave` int(8) NOT NULL auto_increment,
  `bancoCuenta` int(1) default NULL,
  `fecha` date default NULL,
  `concepto` varchar(100) collate latin1_spanish_ci default NULL,
  `importe` double(8,2) default NULL,
  `activo` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `ingresos` table : 
#

DROP TABLE IF EXISTS `ingresos`;

CREATE TABLE `ingresos` (
  `clave` int(8) NOT NULL auto_increment,
  `bancoCuenta` int(1) default NULL,
  `fecha` date default NULL,
  `concepto` varchar(100) collate latin1_spanish_ci default NULL,
  `importe` double(8,2) default NULL,
  `activo` int(1) default NULL,
  PRIMARY KEY  (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `linea` table : 
#

DROP TABLE IF EXISTS `linea`;

CREATE TABLE `linea` (
  `clave` char(3) collate latin1_spanish_ci default NULL,
  `nombre` varchar(20) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `marca` table : 
#

DROP TABLE IF EXISTS `marca`;

CREATE TABLE `marca` (
  `clave` char(3) collate latin1_spanish_ci default NULL,
  `nombre` varchar(40) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos` table : 
#

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `claveProducto` varchar(10) collate latin1_spanish_ci default NULL,
  `linea` char(3) collate latin1_spanish_ci default NULL,
  `marca` char(3) collate latin1_spanish_ci default NULL,
  `proveedor1` varchar(13) collate latin1_spanish_ci default NULL,
  `proveedor2` varchar(13) collate latin1_spanish_ci default NULL,
  `descripcion` varchar(100) collate latin1_spanish_ci default NULL,
  `costo` double(8,2) default NULL,
  `precio1` double(8,2) default NULL,
  `precio2` double(8,2) default NULL,
  `precio3` double(8,2) default NULL,
  `precio4` double(8,2) default NULL,
  `precio5` double(8,2) default NULL,
  `maximo` int(4) default NULL,
  `minimo` int(4) default NULL,
  `existencia` int(4) default NULL,
  `piezasXcaja` int(5) default NULL,
  `activo` int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
# Structure for the `usuarios` table : 
#

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `ClaveU` varchar(8) collate latin1_spanish_ci NOT NULL default '',
  `Contrasena` varchar(8) collate latin1_spanish_ci NOT NULL default '',
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
# Data for the `bancos` table  (LIMIT 0,500)
#

# clave:3:49667
# numero:253:0
# banco:253:0
# importeInicial:5:32768
# importeActual:5:32768

INSERT INTO `bancos` (`clave`, `numero`, `banco`, `importeInicial`, `importeActual`) VALUES 
  (1,'567890','SANTANDER',10000.00,14755.00);

COMMIT;

#
# Data for the `clientes` table  (LIMIT 0,500)
#

# rfc:253:1
# nombre:253:1
# direccion:253:1
# colonia:253:0
# delegacion:253:0
# cp:253:0
# ciudad:253:0
# tipo:3:32768
# tel1:253:0
# tel2:253:0
# fax:253:0
# email:253:0
# diaCierran:3:32768
# horaComida:253:0
# contacto:253:0
# credito:5:32768
# pagoA:3:32768
# agente:253:0
# alta:10:128
# activo:3:32768
# saldoDisponible:5:32768
# bloqueoXPagoV:3:32768

INSERT INTO `clientes` (`rfc`, `nombre`, `direccion`, `colonia`, `delegacion`, `cp`, `ciudad`, `tipo`, `tel1`, `tel2`, `fax`, `email`, `diaCierran`, `horaComida`, `contacto`, `credito`, `pagoA`, `agente`, `alta`, `activo`, `saldoDisponible`, `bloqueoXPagoV`) VALUES 
  ('MAPV601008RTA','Maldonado Villegas Patricia','Calle Canal de Apatlaco # G-75','Ejidos Del Moral','Iztapalapa','09040','Mexico D.F.',1,'56409887','','','',1,'','Rene Espinoza',0.00,0,'Piero','2006-06-07',0,0.00,0),
  ('DCN-040210NJO','Dinamica Comercial Nueva Orizaba S.A de C.V','Zona 1 Sector 1 Nave 1 bodega G 67 y 69','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'5694 2043','','','',7,'','Jose Luis Hernandez Saavedra',100000.00,10,'CHAVA','2006-06-07',0,100000.00,0),
  ('CLA-830615UC2','Comercializadora de Lacteos S.A de C.V.','Central de Abasto Iztapalapa G 93-95','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',3,'5694-1421','','','',7,'','Socorro  y  Federico',80000.00,6,'Piero','2006-06-07',0,80000.00,0),
  ('DCC-040210C48','Dinamica Comercial Central  S.A de C.V','Zona 1 Sector 1 Crujia 2 Local 118  CEDA','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',2,'','','','',7,'','Sergio  y  Alejandro',50000.00,10,'Piero','2006-06-07',0,50000.00,0),
  ('RARR7404053M1','Ramirez Rodriguez Roberto','Pasillo i j  Bodega 46','Ejidos del Moral','Iztapalapa','09310','Mexico D.F.',1,'5640-9230','','','',7,'','Roberto y Arturo',80000.00,10,'Piero','2006-06-07',1,80000.00,0),
  ('GAAY8110197E3','Garcia Almanza Yashira Tahide','Andador el condor Mz N Lote 8','Heroes de Chapultepec','Gustavo A Madero','07930','Mexico D.F.',2,'5547-6693','','','',7,'','Isrrael y Arturo Garcia',40000.00,5,'Piero','2006-06-07',1,40000.00,0),
  ('TEX931122JL3','La Texana S.A.de C.V','Bodega h 52 y 54','Aculco','Central de abasto','09410','Mexico D.F.',2,'5600-2034','','','',7,'','Alejandro Bolanos y Alfredo Carreon',150000.00,10,'Piero','2006-06-07',1,150000.00,0),
  ('CTC900503Q24','Cremeria Teresita de Central de Abasto S.A de C.V.','Zona 1 Sector 1 Nave1 Bodega G 39 y G 41','Central de Abastos','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Tomas y Sergio',250000.00,5,'Piero','2006-06-07',1,250000.00,0),
  ('DCC040210C48','Dinamica Comercial Central S.A de C.V','Zona 1 Sector 1 Crujia 2 Local 118','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'','','','',7,'','Sergio  y Alejandro',80000.00,15,'Piero','2006-06-07',1,80000.00,0),
  ('CLA830615UC2','Comercializadora De Lacteos S.A de C.V','Bodega G-93-95 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 1421','','','',7,'','Socorro y Federico',80000.00,10,'CHAVA','2006-06-07',1,80000.00,0),
  ('CSC880523NA1','Cremeria y Salchichoneria Cuadritos S.A de C. V.','Pasillo 2 Locs. 110 110A 112 114 116 letra G-H','Aculco','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Raul y David',200000.00,5,'CHAVA','2006-06-07',1,200000.00,0),
  ('MAVP601008RTA','Maldonado Villegas Patricia','Calle Canal de Apatlaco G75','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5640 9887','','','',7,'','Rene  Espinoza',150000.00,15,'Piero','2006-06-07',1,150000.00,0),
  ('LSF050118U75','Lacteos San Fransisco de Asis S.de R.L de C.V','Canal de Apatlaco Zona 1 Sector 1 Nave 1 Bod. G3','Central de Abasto','Iztapalapa','09040','Mexico D.F',1,'5694 2235','','','',7,'','Chucho y Luis',100000.00,10,'Piero','2006-06-07',1,100000.00,0),
  ('CSL0309122V5','Cremeria y Salchichoneria Lichus S.A. de C.V.','Bodega 58-59 Zona 1 Sector 1 Nave 3','Central de Abasto','iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','Fausto y el Abuelo',70000.00,10,'CHAVA','2006-06-07',1,70000.00,0),
  ('DCP040210S26','Dinamica Comercial Pastora s.a de C.V.','Pasillo 3 Local 52-53','ejidos del Moral','iztapalapa','09040','Mexico D.F.',2,'5694-3388','','','',7,'','Victor y Sergio',150000.00,15,'Piero','2006-06-07',1,150000.00,0),
  ('AEVJ741206QJ3','Avendano Villegas Jaime','Av.606-101 Agrup.A. Casa #56','San Juan de Aragon','Gustvo A. Madero','07050','Mexico D.F.',1,'','','','',7,'','Jaime',0.00,5,'Piero','2006-06-08',1,0.00,0),
  ('CSJ871008UQ4','Cremeria San Jose  S.A .de C.V.','Bodega G 79 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Don Poncho  y  Jose Castillo',50000.00,7,'Piero','2006-06-08',1,50000.00,0),
  ('FAVA670829598','Favian Veibar Artemio','Local G 50 Pasillo 3','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'56941403','','','',7,'','artemio y Ismael',50000.00,15,'Piero','2006-06-08',1,50000.00,0),
  ('CSS850907851','Cremeria Y Salchichoneria La Suiza S.A.de C.V','Bodega G7 y G9 ZNA1 SEC1 NVE1','Central de Abasto','Iztapalapa','09040','Mexico D.F.',1,'56007583','','','',7,'','Celso y Lucio',80000.00,7,'CHAVA','2006-06-08',1,80000.00,0),
  ('CME9109236F1','Cotija Mercantil S.A deC.V','Zona 1 Sector 1 Nave 2 Bodega G 83','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 1448','','','',7,'','Fransisco y Miguel de la Parra',50000.00,8,'CHAVA','2006-06-08',1,50000.00,0),
  ('PAPE720521P11','De La Parra Portocarrero Elsa','G H 81 y 83','Central de Abasto','Iztapalapa','09040','Mexico D.F.',1,'56943066','','','',7,'','Pablo y Francisco',80000.00,8,'CHAVA','2006-06-08',1,80000.00,0),
  ('DPL871024KN8','Distribuidora de Productos Lacteos Chiluca S.A. de C.V.','Bodega G91 CEDA','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Rafa y Alfredo',50000.00,3,'Piero','2006-06-08',1,50000.00,0),
  ('DCH040220NMA','Dinamica Comercial Higuera S.A de C.V.','Bodega H 52 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'5600 6809','','','',7,'','Leonardo yMonica',30000.00,15,'Piero','2006-06-08',1,30000.00,0),
  ('HESJ501028FJ3','Jose Hernandez Saavedra','Bodega G 51 ZNA1SEC1NVE2','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'56942875','','','',7,'','Juan',60000.00,8,'CHAVA','2006-06-08',1,60000.00,0),
  ('CSH870328B82','Cremeria y Salchichoneria la Holandesa S.A de C.V.','Bodega G 5 Central de Abasto','Ejidos del Moral','Iztapalapa','09030','Mexico D.F',1,'5694 0823','','','',7,'','Gerarado y Enrique',100000.00,5,'Piero','2006-06-08',1,100000.00,0),
  ('HESJ440722S33','Jorge Hernandez Saavedra','P 1 Loc 29 A  CEDA','Aculco','Iztapalapa','09040','Mexico D.F.',1,'56942100','','','',7,'','Primo y Luis',100000.00,15,'CHAVA','2006-06-08',1,100000.00,0),
  ('AAGF740817Q38','Fransisco Salvador Alvares del Castillo Gudiño','Bodega G 19 Central de Abasto','Ejidos del Moral','Iztapalapa','09030','Mexico D.F.',2,'','','','',7,'','Paco y Hugo',40000.00,8,'Piero','2006-06-08',1,40000.00,0),
  ('AAEF660414AJ1','Fernando Amador Espejo','Bodega G 79 A CEDA Iztapalapa','Ejidos del Moral','Iztapalapa','09030','Mexico D.F.',1,'56941397','','','',7,'','Luis y Alejandro',25000.00,3,'Piero','2006-06-08',1,25000.00,0),
  ('DLE920309PEO','Distribuidora de Lacteos y Embutidos El Zarco','Pasillo 2 Local F 85','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Gerardo y Roberto',25000.00,0,'CHAVA','2006-06-08',1,25000.00,0),
  ('CDO9612105D9','Comercializadora el Dorado S.A. de C.V.','Bodega G 21 CEDA','Ejidos del Moral','Iztapalapa','09040',' Mexico D.F.',1,'','','','',7,'','Hazan',10000.00,3,'Piero','2006-06-08',1,10000.00,0),
  ('AARZ770413CVA','Alcala Rivera Zeuz Avelino Baltazar','Zona1 Sector1 Nave 2 Bodega G 55','Urbana Ejidal','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Alcala  y  Zeuz',30000.00,8,'CHAVA','2006-06-08',1,30000.00,0),
  ('DCP000926455','Dinamica Comercial El Pato S.A de C.V.','Pas 2 Loc 138 entre I-J y G -H','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Jaime',15000.00,7,'CHAVA','2006-06-08',1,15000.00,0),
  ('CAS020724SE8','Consorcio de Alimentos san Salvador S.A. de C.V.','Pasillo 4 Anden I-J Local 133','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Camaron y Tono',60000.00,15,'CHAVA','2006-06-08',1,60000.00,0),
  ('RAPC670202135','Candelario Ramirez Pozos','Pasillo 3 E 32','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','Candido y Ana',150000.00,0,'Piero','2006-06-08',1,150000.00,0),
  ('RAPC670202','Candelario Ramirez Pozos','Pasillo 3 Local E 32','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','',150000.00,15,'Piero','2006-06-08',1,150000.00,0),
  ('EDE0402134B7','Especialidades Deli S.A. de C.V.','Circuito F y L Pasillo 4 Crujia 1 Loc. 137-139','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 3118','','','',7,'','Pancho  y  Yair',80000.00,10,'CHAVA','2006-06-08',1,80000.00,0),
  ('JUPF7706198H0','Flor de Maria Juarez Paredes','Local 51 Pasillo 1 y 3','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 2403','','','',7,'','Tono y Beto',80000.00,15,'Piero','2006-06-08',1,80000.00,0),
  ('Ramirez','Ramirez','central de abasto','ejidos del moral','iztapalapa','09040','Mexico D.F.',1,'5640 9230','','','',7,'','',80000.00,8,'Piero','2006-06-14',1,80000.00,0),
  ('Teresita','Teresita','G 41','CEDA','iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Tomas',200000.00,8,'Piero','2006-06-14',1,200000.00,0),
  ('Marga','Marga','G 15','CEDA','iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Tomas',100000.00,8,'CHAVA','2006-06-14',1,100000.00,0),
  ('Rigo','Rigo','G 1','CEDA','iztapalapa','09040','Mexico D.F.',1,'56407354','','','',7,'','Rigo',10000.00,3,'Piero','2006-06-14',1,10000.00,0),
  ('Union','Union',' Pasillo 1 Local 3','CEDA','iztapalapa','09040','Mexico D.F.',1,'56009947','','','',7,'','Nicolas',50000.00,15,'Piero','2006-06-14',1,50000.00,0),
  ('Chucho','Chucho','G 3','CEDA','Iztapalapa','09040','Mexico D.f.',1,'','','','',7,'','Chucho',50000.00,8,'CHAVA','2006-06-14',1,50000.00,0),
  ('Tapatio','Tapatio','G 15','CEDA','Iztapalapa','09040','Mexico D.F',1,'56407036','','','',7,'','Felipe',20000.00,5,'Piero','2006-06-14',1,20000.00,0),
  ('Gea','Gea','G 19','CEDA','Iztapalapa','09030','Mexico D:F',1,'','','','',7,'','',50000.00,8,'Piero','2006-06-14',1,50000.00,0),
  ('Normita','Normita','G 43','CEDA','Iztapalapa','09040','Mexico D:F.',1,'56948789','','','',7,'','Claudio',25000.00,5,'Piero','2006-06-14',1,25000.00,0),
  ('Texana','Texana','H 52-54','Aculco','Iztapalapa','09410','Mexico D.F',1,'5600 2034','','','',7,'','Alfredo y  Alejandro',20000.00,8,'Piero','2006-06-14',1,20000.00,0),
  ('Vanguardia','Vanguardia','G 61','CEDA','Iztapalapa','09040','Mexico D:F.',1,'5694 1459','','','',7,'','',40000.00,5,'CHAVA','2006-06-14',1,40000.00,0),
  ('Ranchito','Ranchito','G 79','CEDA','Iztapalapa','09040','Mexico D.F',1,'5694 1397','','','',7,'','Luis y Alejandro',25000.00,8,'Piero','2006-06-14',1,25000.00,0),
  ('Especial','Especial','G 77','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 4692','','','',7,'','Ulises',150000.00,15,'Piero','2006-06-14',1,150000.00,0),
  ('D`MargònZ','D`MargònZ','Local 51','CEDA','Iztapalapa','09040','Mexico D.F',1,'5694 2403','','','',7,'','Toño',40000.00,15,'Piero','2006-06-14',1,40000.00,0),
  ('LA GUERA','LA GUERA','Pasillo 3 Loc. 50 G-H','CEDA','Iztapalapa','09040','Mexico D.F',1,'56941403','','','',7,'','Artemio',40000.00,15,'Piero','2006-06-14',0,40000.00,0),
  ('CHILUCA','CHILUCA','G 91','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Rafael',40000.00,3,'Piero','2006-06-14',1,40000.00,0),
  ('Josè Manuel','Josè Manuel','G 87','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Josè Manuel',70000.00,15,'Piero','2006-06-14',1,70000.00,0),
  ('SURTIDOR','SURTIDOR','Pasillo 3 Loc 25','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56002097','','','',7,'','Jose y Beto',70000.00,15,'Piero','2006-06-14',0,70000.00,0),
  ('Nueva Merced','Nueva Merced','Pasillo 3 Local 30','CEDA','Iztapalapa','09040','Mexico D.f',1,'','','','',7,'','Puebla',20000.00,3,'Piero','2006-06-14',1,20000.00,0),
  ('ESPERANZA','ESPERANZA','Pasillo  3 Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56940435','','','',7,'','Pedro y Juana',130000.00,15,'Piero','2006-06-14',0,130000.00,0),
  ('Retoño','Retoño',' E 32 Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','Candido',150000.00,15,'Piero','2006-06-14',1,150000.00,0),
  ('L # 45','L # 45',' Pasillo 3 Loc. 45','CEDA','Iatapalapa','09040','Mexico D.F.',1,'','','','',7,'','Sr. Jose',50000.00,15,'Piero','2006-06-14',1,50000.00,0),
  ('Ruiseñor','Ruiseñor','Pasillo 3 Local  25','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 7263','','','',7,'','Bertha',20000.00,6,'Piero','2006-06-14',1,20000.00,0),
  ('Esperanza','Esperanza','Pasillo 3 Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56940435','','','',7,'','Pedro y Juana',130000.00,15,'Piero','2006-06-14',1,130000.00,0),
  ('Retoñito','Retoñito','Pasillo 3 Local 80','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5600 2607','','','',7,'','Rosa y Osbelia',150000.00,15,'CHAVA','2006-06-14',1,150000.00,0),
  ('Surtidor','Surtidor','Pasillo 3 Loc.','CEDA','Iztapalapa','09040','Mexico. D.F.',1,'56002097','','','',7,'','Jose y Beto',70000.00,15,'Piero','2006-06-14',1,70000.00,0),
  ('Yoely','Yoely','Pasillo 3 Local 78','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Alma y Elizabeth',50000.00,15,'CHAVA','2006-06-14',1,50000.00,0),
  ('La Guera','La Guera','Pasillo 3 Loc 50 G-H','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56941403','','','',7,'','Artemio',40000.00,15,'Piero','2006-06-14',1,40000.00,0),
  ('Lupita','Lupita','Pasillo 4  Local 124','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 3118','','','',7,'','Panchito',70000.00,10,'CHAVA','2006-06-14',1,70000.00,0),
  ('Super Palmas','Super Palmas','Pasillo I-J Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Meliton',20000.00,8,'CHAVA','2006-06-14',1,20000.00,0),
  ('Erik','Erik','I - J','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Erik',2000.00,3,'CHAVA','2006-06-19',1,2000.00,0),
  ('Bonanza','Bonanza','i - j  pasillo 5','CEDA','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Memo y Ivan',30000.00,5,'CHAVA','2006-06-19',1,30000.00,0),
  ('Max','Max','I-61  entre pasillo 2 y 3','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Max',5000.00,2,'Piero','2006-06-19',1,5000.00,0),
  ('Laura','Laura','Pasillo 1  g-h','CEDA','Iztapalapa','09040','Mexico D.F',3,'','','','',7,'','Alfredo',40000.00,8,'CHAVA','2006-06-19',1,40000.00,0),
  ('Perico','Perico','Av. Riva Palacio','Neza','Neza','000','Mexico D.F.',3,'','','','',7,'','Pedro',10000.00,10,'Piero','2006-06-19',1,10000.00,0),
  ('Rosa de oro','Rosa de oro','Pasillo 1 g-h','CEDA','Iztapalapa','09040','Mexico D.F.',5,'5694 8111','','','',7,'','Javier',20000.00,8,'CHAVA','2006-06-19',1,20000.00,0),
  ('Juan Munoz','Juan Munoz','Chalco','Chalco','Edo.Mex.','000','Edo. Mex.',1,'59751692','','','',7,'','Juan Munoz',40000.00,6,'Piero','2006-06-19',1,40000.00,0),
  ('Palomas','Palomas','E- F Pasillo 2','CEDA','Iztapalapa','09040','Mexico D.F.',3,'5694 6529','','','',7,'','Beto',50000.00,8,'Piero','2006-06-19',1,50000.00,0),
  ('Alfredo','Alfredo','Altamirano Guerrero','Altamirano Guerrero','Guerrero','000','Guerrero',3,'0176 76726774','','','',7,'','Alfredo',40000.00,5,'Piero','2006-06-19',1,40000.00,0),
  ('Jorge Montoya','Jorge Montoya','Neza','Neza','Edo. Mexico','000','Edo. Mexico.',3,'','','','',7,'','Jorge Montoya',15000.00,10,'Piero','2006-06-19',1,15000.00,0),
  ('Barca','Barca','O-P  Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F.',3,'5694 5586','','','',7,'','Josè Luis',15000.00,3,'Piero','2006-06-19',1,15000.00,0),
  ('Trinidad','Jose Trinidad','Tlaxcala','Tlaxcala','Tlaxcala','000','Tlaxcala',3,'','','','',7,'','Jose Trinidad',40000.00,3,'Piero','2006-06-19',1,40000.00,0),
  ('Juan Zepeda','Juan Zepeda','I-61','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Juan Zepada',1000.00,2,'Piero','2006-06-19',1,1000.00,0),
  ('Rojas','Rojas','Pasillo 3   I-J','Ceda','Iztapalapa','09040','Mexico D.F',3,'','','','',7,'','Rojas',1000.00,0,'Piero','2006-06-19',1,1000.00,0),
  ('Nochistlan','Nochistlan','O -P Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F',5,'','','','',7,'','Nochistlan',1000.00,0,'Piero','2006-06-19',1,1000.00,0),
  ('El Pico de O','El Pico De Orizaba','S-T  Pasillo 4','Ceda','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','',5000.00,0,'Piero','2006-06-19',1,5000.00,0),
  ('Yony','Yony','Neza','Neza','Neza','000','Mexico D.F.',3,'','','','',7,'','Yony',2000.00,0,'Piero','2006-06-19',1,2000.00,0),
  ('Mundo','Mundo','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Mundo',10000.00,10,'Piero','2006-06-19',1,10000.00,0),
  ('Paty','Paty','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Paty',10000.00,10,'Piero','2006-06-19',1,10000.00,0),
  ('Alejandro','Alejandro','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Alejandro',10000.00,10,'Piero','2006-06-19',1,10000.00,0),
  ('Sr. Zarco','Sr. Zarco','Texcoco','Texcoco','Edo. Mexico','000','Edo. Mexico',3,'56800428','','','',7,'','Sr. Zarco',30000.00,10,'Piero','2006-06-19',1,30000.00,0);

COMMIT;

#
# Data for the `gastos` table  (LIMIT 0,500)
#

# clave:3:49667
# bancoCuenta:3:32768
# fecha:10:128
# concepto:253:0
# importe:5:32768
# activo:3:32768

INSERT INTO `gastos` (`clave`, `bancoCuenta`, `fecha`, `concepto`, `importe`, `activo`) VALUES 
  (1,1,'2006-06-15','comidas',245.00,1),
  (2,1,'2006-06-16','',15000.00,1);

COMMIT;

#
# Data for the `ingresos` table  (LIMIT 0,500)
#

# clave:3:49667
# bancoCuenta:3:32768
# fecha:10:128
# concepto:253:0
# importe:5:32768
# activo:3:32768

INSERT INTO `ingresos` (`clave`, `bancoCuenta`, `fecha`, `concepto`, `importe`, `activo`) VALUES 
  (1,1,'2006-06-16','bonificacion',890.00,0),
  (2,1,'2006-06-16','',20000.00,1);

COMMIT;

#
# Data for the `linea` table  (LIMIT 0,500)
#

# clave:254:0
# nombre:253:0

INSERT INTO `linea` (`clave`, `nombre`) VALUES 
  ('lec','leche'),
  ('yog','yogurth'),
  ('mar','margarina'),
  ('man','mantequillas'),
  ('nar','naranjadas'),
  ('tos','tostadas'),
  ('pos','postre'),
  ('cre','crema'),
  ('gel','gelatina'),
  ('beb','bebida'),
  ('que','queso'),
  ('cho','chorizo'),
  ('hue','huevo'),
  ('jam','jamon');

COMMIT;

#
# Data for the `marca` table  (LIMIT 0,500)
#

# clave:254:0
# nombre:253:0

INSERT INTO `marca` (`clave`, `nombre`) VALUES 
  ('lal','lala'),
  ('alp','alpura'),
  ('ibe','iberia'),
  ('chi','chipilo'),
  ('dan','danone'),
  ('cha','charra'),
  ('car','carioca'),
  ('ama','amarillo'),
  ('bon','bonafina'),
  ('ran','rancherita'),
  ('man','manchego'),
  ('rio','riojano'),
  ('gal','galicia'),
  ('bac','bachoco'),
  ('cot','cotija'),
  ('gin','gina'),
  ('raa','rancherito'),
  ('lca','lcastel');

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

# claveProducto:253:0
# linea:254:0
# marca:254:0
# proveedor1:253:0
# proveedor2:253:0
# descripcion:253:0
# costo:5:32768
# precio1:5:32768
# precio2:5:32768
# precio3:5:32768
# precio4:5:32768
# precio5:5:32768
# maximo:3:32768
# minimo:3:32768
# existencia:3:32768
# piezasXcaja:3:32768
# activo:3:32768

INSERT INTO `productos` (`claveProducto`, `linea`, `marca`, `proveedor1`, `proveedor2`, `descripcion`, `costo`, `precio1`, `precio2`, `precio3`, `precio4`, `precio5`, `maximo`, `minimo`, `existencia`, `piezasXcaja`, `activo`) VALUES 
  ('leclal01','lec','lal','Ricardo','0','Leche Entera Tetrapac',95.00,98.00,100.00,101.00,103.00,103.00,200,50,0,12,1),
  ('crealp01','cre','alp','Joaquin','Ricardo','crema acida 250 gr.',114.70,116.00,116.80,117.00,117.00,117.00,800,50,0,24,1),
  ('yogalp01','yog','alp','Joaquin','Calderon','yogurth alpura 200gr.',58.46,59.50,60.00,61.50,62.50,64.80,1500,50,0,24,1),
  ('crealp02','cre','alp','Joaquin','Ricardo','crema acida 450 gr.',257.11,260.00,261.80,262.00,262.00,262.00,600,50,0,24,1),
  ('crealp03','cre','alp','Joaquin','Ricardo','crema acida 900gr.',257.11,260.00,261.80,262.00,262.00,262.00,250,50,0,12,1),
  ('toscha01','tos','cha','TNI920507GB8','0','tostada charra',145.44,147.50,148.00,149.00,150.00,150.00,1500,50,0,18,1),
  ('toscar01','tos','car','Carioca','0','tostada carioca',95.00,100.00,100.00,100.00,100.00,100.00,400,10,0,24,1),
  ('yogdan01','yog','dan','MEG0202151X5','0','fruix con cereal 151gr',87.74,90.00,92.00,93.00,95.00,95.00,600,50,0,24,1),
  ('yogdan02','yog','dan','MEG0202151X5','0','danonino para beber 100gr',95.21,98.00,100.00,102.00,102.00,102.00,100,10,0,25,1),
  ('yogdan03','yog','dan','MEG0202151X5','0','dan-up 250gr',140.28,142.00,143.00,143.00,143.00,143.00,1500,150,0,28,1),
  ('yogdan04','yog','dan','MEG0202151X5','0','licuado250gr',163.77,175.00,178.00,178.00,178.00,178.00,10,2,0,28,1),
  ('yogdan05','yog','dan','MEG0202151X5','0','danonino  180gr',175.48,178.00,178.50,179.00,180.00,180.00,2000,150,0,24,1),
  ('geldan01','gel','dan','MEG0202151X5','0','dany sabores 125gr',105.29,112.00,113.00,115.00,115.00,115.00,300,30,0,48,1),
  ('posdan01','pos','dan','MEG0202151X5','0','danette natilla 200gr',122.84,130.00,133.00,133.00,133.00,133.00,30,5,0,24,1),
  ('yogdan06','yog','dan','MEG0202151X5','0','vitalinea para beber 250gr',163.77,175.00,175.00,175.00,175.00,175.00,60,10,0,28,1),
  ('yogdan07','yog','dan','MEG0202151X5','0','vitalinea solido 150gr',181.33,195.00,195.00,195.00,195.00,195.00,5,2,0,48,1),
  ('yogdan08','yog','dan','MEG0202151X5','0','activia solido 150gr',141.60,155.00,160.00,160.00,160.00,160.00,90,15,0,48,1),
  ('yogdan09','yog','dan','MEG0202151X5','0','activia para beber 250gr',163.77,170.00,175.00,178.00,178.00,178.00,800,50,0,28,1),
  ('posdan02','pos','dan','MEG0202151X5','0','flan danette 200gr',122.84,130.00,133.00,133.00,133.00,133.00,200,20,0,24,1),
  ('posdan03','pos','dan','MEG0202151X5','0','arroz con leche 200gr',122.84,130.00,133.00,133.00,133.00,133.00,80,15,0,24,1),
  ('bebbon01','beb','bon','UNI9704247M2','0','naranjada 900ml',83.00,89.00,89.00,89.00,89.00,90.00,700,50,0,20,1),
  ('bebbon02','beb','bon','UNI9704247M2','0','naranjada 700ml',63.00,68.00,68.00,68.00,68.00,70.00,700,50,0,20,1),
  ('bebbon03','beb','bon','UNI9704247M2','0','naranjada de plastico 1lt',90.00,96.00,96.00,96.00,96.00,98.00,250,20,0,20,1),
  ('bebbon04','beb','bon','UNI9704247M2','0','naranjada shak',62.40,66.00,66.00,66.00,66.00,68.00,200,10,0,5,1),
  ('bebbon05','beb','bon','UNI9704247M2','0','naranjada 3.750',80.00,86.00,86.00,86.00,86.00,86.00,35,5,0,6,1),
  ('creran01','cre','ran','Joaquin','0','vegetal 900ml',126.70,132.00,135.00,138.00,138.00,138.00,30,5,0,12,1),
  ('queama01','que','ama','UNI9704247M2','0','la provinciana de 1kg',104.20,107.00,108.00,110.00,112.00,112.00,500,50,0,10,0),
  ('cregin01','cre','gin','UNI9704247M2','0','bolsa de 1kg',64.20,66.00,67.00,68.00,69.00,69.00,600,50,0,10,1),
  ('queama02','que','ama','UNI9704247M2','0','rancherito rebanado 2kg',300.00,293.00,295.00,298.00,298.00,298.00,700,30,0,6,0),
  ('queraa01','que','raa','UNI9704247M2','0','rebanado de 2kg',300.00,295.00,298.00,298.00,298.00,300.00,700,30,0,6,1),
  ('quechi01','que','chi','UNI9704247M2','0','rebanado de 2kg',345.00,345.00,345.00,345.00,345.00,345.00,700,30,0,6,1),
  ('quelca01','que','lca','UNI9704247M2','0','rebanado de 1.8kg',220.00,225.00,225.00,225.00,225.00,225.00,200,15,0,6,1),
  ('manchi01','man','chi','UNI9704247M2','0','pura de 90gr',91.54,93.00,95.50,95.50,95.50,95.50,250,20,0,24,1),
  ('manchi02','man','chi','UNI9704247M2','0','pura de 225gr',81.15,83.00,85.00,5.00,85.00,85.00,200,20,0,9,1),
  ('manchi03','man','chi','UNI9704247M2','0','pura de 1kg',376.50,385.00,385.00,385.00,385.00,385.00,20,2,0,10,1),
  ('manchi04','man','chi','UNI9704247M2','0','industial de 1kg',190.00,190.00,193.00,196.00,196.00,196.00,180,10,0,10,1),
  ('chorio01','cho','rio','Retonito','0','chorizo riojano',32.00,38.00,38.00,38.00,38.00,38.00,2,0,0,1,1),
  ('yogbon01','yog','bon','UNI9704247M2','0','para beber de 500ml',165.60,169.20,169.20,169.20,169.20,169.20,150,10,0,36,1),
  ('yogbon02','yog','bon','UNI9704247M2','0','para beber de 1lt',155.00,160.00,160.00,160.00,160.00,160.00,35,5,0,20,1),
  ('crelal01','cre','lal','CLD0507145H6','0','aciada de 200ml',106.80,107.00,108.00,108.50,109.00,110.00,250,30,0,24,1),
  ('crelal02','cre','lal','CLD0507145H6','0','acida de 450ml',106.80,107.00,108.00,108.50,109.00,110.00,700,30,0,12,1),
  ('crelal03','cre','lal','CLD0507145H6','0','acida de 900ml',106.80,107.00,108.00,108.50,109.00,110.00,1000,30,0,6,1),
  ('crelal04','cre','lal','CLD0507145H6','0','acida de cubeta',304.00,306.00,310.00,314.00,314.00,320.00,150,5,0,4,1);

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
  ('MEG0202151X5','MEGA COMER S.A DE C.V','POCHTECAS 37','PASEOS DE CHURUBUSCO','IZTAPALAPA','09040','MEXICO D.F.','56405668','56405666','','','','FERNANDO LUKE',2,'',0.00,2,0.00,0.00,0.00,0.00,'2006-06-02',1),
  ('TNI920507GB8','TOSTIRICAS NIETO S.A DE C.V.','Priv. ceylan 45-A','Industrial Vallejo','Azcapotzalco','02300','Mexico D.F.','53687475','0445520731372','','','','Luis Maldonado Villegas',2,'',0.00,30,20.00,0.00,0.00,0.00,'2006-06-02',1),
  ('UNI9704247M2','UNIFOOS S.A DE C.V.','Poniente 122  -459','Industrial Vallejo','Azcapotzalco','02300','Mexico D.F.','53331200','0445518668248 ABRHAM','0445518668244 PICOS','','','ABRHAM    PICOS   ALBERTO  TOÑO',2,'',0.00,0,0.00,0.00,0.00,0.00,'2006-06-02',1),
  ('Mateo','Mateo','Santa Maria La Rivera','Santa Maria La Rivera','Santa Maria La River','000','Mexico D. F.','S/N','','','','','Mateo',1,'',0.00,5,0.00,0.00,0.00,0.00,'2006-06-27',1),
  ('Ricardo','Ricardo Nava Butanda','Cuautitlan','Cuautitlan','Cuautitlan Izcali','000','Mexico D.F.','0445521413035','','','','','Ricardo Nava Butanda',1,'',0.00,4,0.00,0.00,0.00,0.00,'2006-06-27',1),
  ('Galdino','Galdino','','','','000','Mexico D.F.','0445525641900','','','','','Galdino',1,'',100000.00,5,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Ambrosio','Ambrosio Alvarado Martinez','','','','000','Mexico D.F.','S/N','','','','','Bocho',1,'',100000.00,3,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Calderon','Ernesto Calderon','Calle Miguel Hidalgo','Urbana','Xalostoc','000','Mexico D.F.','57141445','0445516329317','','','','Calderon',1,'',300000.00,10,0.00,0.00,0.00,300000.00,'2006-06-30',1),
  ('Teresita','Cremeria Teresita De La Central De Abasto','Central de Abasto Boega G-41','Ceda','Iztapalapa','09040','Mexico D.F.','5694','','','','','Tomas',1,'',150000.00,8,0.00,0.00,0.00,150000.00,'2006-06-30',1),
  ('CTC900503Q24','Cremeria Teresita De Central De Abasto S.A de C.V.','Zona 1 Sector1 Nave1 Bodega G-39 -41','Central de Abasto','Iztapalapa','09040','Mexico D.F.','5694','','','','','Tomas y Sergio',2,'',150000.00,8,0.00,0.00,0.00,150000.00,'2006-06-30',1),
  ('Candido','Candelario Ramirez Pozos','Pasillo 3 Local 32','Central de Abasto','Iztapalapa','09040','Mexico D.F.','5694 8759','','','','','Candido',1,'',100000.00,30,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Joaquin','Alfredo Joaquin Guevara','Zumpango','Zumpango','Zumpango','000','Pachuca Hgo.','015919173541','','','','','Marcos',1,'',300000.00,8,0.00,0.00,0.00,300000.00,'2006-06-30',1),
  ('Palomas','Palomas','Pasillo 2 Local E-F','CEDA','Iztapalapa','09040','Mexico D.F.','5694 6529','','','','','Beto',1,'',100000.00,15,0.00,0.00,0.00,100000.00,'2006-06-30',1),
  ('Carioca','Javier Vidal Mata','Cuautla','Cuatla','Morelos','000','Morelos','017353578634','','','','','Jose Luis',1,'',30000.00,2,0.00,0.00,0.00,30000.00,'2006-06-30',1),
  ('Charra','Charra','Privada Ceylan 45','Industrial Vallejo','Industial Vallejo','000','Mexico D.F.','0445520731372','','','','','Luis',1,'',15000.00,5,0.00,0.00,0.00,15000.00,'2006-06-30',1),
  ('Mario','Mario Figueroa Mundo','Taxco','Taxco','Taxco','000','Taxco Guerrero','017626253992','','','','','Mario',1,'',150000.00,5,0.00,0.00,0.00,150000.00,'2006-06-30',1),
  ('Chispeadero','Chispeadero','Pasillo G-H Local-47','CEDA','Iztapalapa','09040','Mexico D.F.','5694','','','','','Chispeadero',1,'',1000.00,2,0.00,0.00,0.00,1000.00,'2006-06-30',1),
  ('Retonito','Rosalva Cano Pozos','Pasillo 3 Local 80','CEDA','Iztapalapa','09040','Mexico D.F.','5600 2607','','','','','Rosalva',1,'',50000.00,15,0.00,0.00,0.00,50000.00,'2006-06-30',1),
  ('Ramirez','Ramirez','Pasillo 2 Local I-J','CEDA','Iztapalapa','09040','Mexico D.F.','5640 9230','','','','','Arturo',1,'',3000.00,8,0.00,0.00,0.00,3000.00,'2006-06-30',1),
  ('Rene','Rene Espinoza','G 75','CEDA','Iztapalapa','09040','Mexico D,F','56409887','','','','','Rene',1,'',40000.00,8,0.00,0.00,0.00,40000.00,'2006-06-30',1),
  ('Texana','La Texana S.A de C.V.','H 52-54','CEDA','Iztapalapa','09040','Mexico D.F.','56002034','56940238','','','','Alfredo',1,'',30000.00,8,0.00,0.00,0.00,30000.00,'2006-06-30',1),
  ('CLZ040329SD5','Comercializadora la Laguna De Zumpango S.A de C.V','Calle Braniff  s/n','B.de santiago 1ra seccion','','55600','Estado de Mexico','015919173541','','','','','Marco y Joaquin',2,'',500000.00,5,0.00,0.00,0.00,500000.00,'2006-07-04',1),
  ('CLD0507145H6','Comercializadora de Lacteos y Derivados S.A de C.V.','Lazaro Cardenas #185 Parque Industrial Lagunero','Canatatlan','Valle Guadina','35077','Durango','S/N','','','','','Rostro',2,'',200000.00,15,0.00,0.00,0.00,200000.00,'2006-07-04',1);

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
  ('CHAVA','CHAVA','Simple','Salvador','Gonzalez','Plascencia','Agente','Ventas','1'),
  ('Piero','piero','Simple','Piero','Gonzalez','Serrano','Agente','Ventas','1'),
  ('super','super','Admin','Administrador','Administrador','Administrador','Gerente','Admin','1');

COMMIT;

