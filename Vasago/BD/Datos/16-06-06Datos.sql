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
# Structure for the `ingresos` table : 
#

DROP TABLE IF EXISTS `ingresos`;

CREATE TABLE `ingresos` (
  `bancoCuenta` int(1) default NULL,
  `fecha` date default NULL,
  `concepto` varchar(100) collate latin1_spanish_ci default NULL,
  `importe` double(8,2) default NULL,
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
  ('Super Palmas','Super Palmas','Pasillo I-J Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Meliton',20000.00,8,'CHAVA','2006-06-14',1,20000.00,0);

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
  ('UNI9704247M2','UNIFOOS S.A DE C.V.','Poniente 122  -459','Industrial Vallejo','Azcapotzalco','02300','Mexico D.F.','53331200','0445518668248 ABRHAM','0445518668244 PICOS','','','ABRHAM    PICOS   ALBERTO  TOÑO',2,'',0.00,0,0.00,0.00,0.00,0.00,'2006-06-02',1);

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

