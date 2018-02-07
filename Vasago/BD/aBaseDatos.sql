# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;


USE `vasago`;


#
# Data for the `bancos` table  (LIMIT 0,500)
#

# clave:3:49667
# numero:253:0
# banco:253:0
# importeInicial:5:32768
# importeActual:5:32768

INSERT INTO `bancos` (`clave`, `numero`, `banco`, `importeInicial`, `importeActual`) VALUES 
  (1,'60508612609','Santander-Serfin',0.00,300143.06),
  (2,'60508163783','Santander-Serfin',0.00,832.11),
  (3,'1','Caja-Universal',0.00,123290.00),
  (4,'1','Cheques',0.00,911079.79),
  (5,'Tarde','Cheques',0.00,194819.00);

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
  ('RARR7404053M1','Ramirez Rodriguez Roberto','Pasillo i j  Bodega 46','Ejidos del Moral','Iztapalapa','09310','Mexico D.F.',1,'5640-9230','','','',7,'','Roberto y Arturo',80000.00,10,'Piero1','2006-06-07',1,80000.00,0),
  ('GAAY8110197E3','Garcia Almanza Yashira Tahide','Andador el condor Mz N Lote 8','Heroes de Chapultepec','Gustavo A Madero','07930','Mexico D.F.',2,'5547-6693','','','',7,'','Isrrael y Arturo Garcia',40000.00,5,'Piero1','2006-06-07',1,40000.00,0),
  ('TEX931122JL3','La Texana S.A.de C.V','Bodega h 52 y 54','Aculco','Central de abasto','09410','Mexico D.F.',2,'5600-2034','','','',7,'','Alejandro Bolanos y Alfredo Carreon',150000.00,10,'Piero1','2006-06-07',1,120328.00,0),
  ('CTC900503Q24','Cremeria Teresita de Central de Abasto S.A de C.V.','Zona 1 Sector 1 Nave1 Bodega G 39 y G 41','Central de Abastos','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Tomas y Sergio',250000.00,5,'Piero1','2006-06-07',1,231935.00,0),
  ('DCC040210C48','Dinamica Comercial Central S.A de C.V','Zona 1 Sector 1 Crujia 2 Local 118','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'','','','',7,'','Sergio  y Alejandro',80000.00,15,'Piero1','2006-06-07',1,80000.00,0),
  ('CLA830615UC2','Comercializadora De Lacteos S.A de C.V','Bodega G-93-95 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 1421','','','',7,'','Socorro y Federico',80000.00,10,'CHAVA','2006-06-07',1,73392.00,0),
  ('CSC880523NA1','Cremeria y Salchichoneria Cuadritos S.A de C. V.','Pasillo 2 Locs. 110 110A 112 114 116 letra G-H','Aculco','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Raul y David',200000.00,5,'CHAVA','2006-06-07',1,188880.00,0),
  ('MAVP601008RTA','Maldonado Villegas Patricia','Calle Canal de Apatlaco G75','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5640 9887','','','',7,'','Rene  Espinoza',150000.00,15,'Piero1','2006-06-07',1,139260.00,0),
  ('LSF050118U75','Lacteos San Fransisco de Asis S.de R.L de C.V','Canal de Apatlaco Zona 1 Sector 1 Nave 1 Bod. G3','Central de Abasto','Iztapalapa','09040','Mexico D.F',1,'5694 2235','','','',7,'','Chucho y Luis',100000.00,10,'Piero1','2006-06-07',1,90035.00,0),
  ('CSL0309122V5','Cremeria y Salchichoneria Lichus S.A. de C.V.','Bodega 58-59 Zona 1 Sector 1 Nave 3','Central de Abasto','iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','Fausto y el Abuelo',70000.00,10,'CHAVA','2006-06-07',1,58561.00,0),
  ('DCP040210S26','Dinamica Comercial Pastora s.a de C.V.','Pasillo 3 Local 52-53','ejidos del Moral','iztapalapa','09040','Mexico D.F.',2,'5694-3388','','','',7,'','Victor y Sergio',150000.00,15,'Piero','2006-06-07',0,150000.00,0),
  ('AEVJ741206QJ3','Avendano Villegas Jaime','Av.606-101 Agrup.A. Casa #56','San Juan de Aragon','Gustvo A. Madero','07050','Mexico D.F.',1,'','','','',7,'','Jaime',0.00,5,'Piero1','2006-06-08',1,-20089.40,0),
  ('CSJ871008UQ4','Cremeria San Jose  S.A .de C.V.','Bodega G 79 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Don Poncho  y  Jose Castillo',50000.00,7,'Piero1','2006-06-08',1,50000.00,0),
  ('FAVA670829598','Favian Veibar Artemio','Local G 50 Pasillo 3','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'56941403','','','',7,'','artemio y Ismael',50000.00,15,'Piero1','2006-06-08',1,50000.00,0),
  ('CSS850907851','Cremeria Y Salchichoneria La Suiza S.A.de C.V','Bodega G7 y G9 ZNA1 SEC1 NVE1','Central de Abasto','Iztapalapa','09040','Mexico D.F.',1,'56007583','','','',7,'','Celso y Lucio',80000.00,7,'CHAVA','2006-06-08',1,37542.00,0),
  ('CME9109236F1','Cotija Mercantil S.A deC.V','Zona 1 Sector 1 Nave 2 Bodega G 83','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 1448','','','',7,'','Fransisco y Miguel de la Parra',50000.00,8,'CHAVA','2006-06-08',1,50000.00,0),
  ('PAPE720521P11','De La Parra Portocarrero Elsa','G H 81 y 83','Central de Abasto','Iztapalapa','09040','Mexico D.F.',1,'56943066','','','',7,'','Pablo y Francisco',80000.00,8,'CHAVA','2006-06-08',1,68223.60,0),
  ('DPL871024KN8','Distribuidora de Productos Lacteos Chiluca S.A. de C.V.','Bodega G91 CEDA','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Rafa y Alfredo',50000.00,3,'Piero1','2006-06-08',1,50000.00,0),
  ('DCH040220NMA','Dinamica Comercial Higuera S.A de C.V.','Bodega H 52 Central de Abasto','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',2,'5600 6809','','','',7,'','Leonardo yMonica',30000.00,15,'Piero1','2006-06-08',1,27698.00,0),
  ('HESJ501028FJ3','Jose Hernandez Saavedra','Bodega G 51 ZNA1SEC1NVE2','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'56942875','','','',7,'','Juan',60000.00,8,'CHAVA','2006-06-08',1,54735.00,0),
  ('CSH870328B82','Cremeria y Salchichoneria la Holandesa S.A de C.V.','Bodega G 5 Central de Abasto','Ejidos del Moral','Iztapalapa','09030','Mexico D.F',1,'5694 0823','','','',7,'','Gerarado y Enrique',100000.00,5,'CHAVA','2006-06-08',1,100000.00,0),
  ('HESJ440722S33','Jorge Hernandez Saavedra','P 1 Loc 29 A  CEDA','Aculco','Iztapalapa','09040','Mexico D.F.',1,'56942100','','','',7,'','Primo y Luis',100000.00,15,'CHAVA','2006-06-08',1,83227.00,0),
  ('AAGF740817Q38','Fransisco Salvador Alvares del Castillo Gudiño','Bodega G 19 Central de Abasto','Ejidos del Moral','Iztapalapa','09030','Mexico D.F.',2,'','','','',7,'','Paco y Hugo',40000.00,8,'Piero1','2006-06-08',1,31580.00,0),
  ('AAEF660414AJ1','Fernando Amador Espejo','Bodega G 79 A CEDA Iztapalapa','Ejidos del Moral','Iztapalapa','09030','Mexico D.F.',1,'56941397','','','',7,'','Luis y Alejandro',25000.00,3,'Piero1','2006-06-08',1,25000.00,0),
  ('DLE920309PEO','Distribuidora de Lacteos y Embutidos El Zarco','Pasillo 2 Local F 85','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Gerardo y Roberto',25000.00,0,'CHAVA','2006-06-08',1,25000.00,0),
  ('CDO9612105D9','Comercializadora el Dorado S.A. de C.V.','Bodega G 21 CEDA','Ejidos del Moral','Iztapalapa','09040',' Mexico D.F.',1,'','','','',7,'','Hazan',10000.00,3,'Piero1','2006-06-08',1,10000.00,0),
  ('AARZ770413CVA','Alcala Rivera Zeuz Avelino Baltazar','Zona1 Sector1 Nave 2 Bodega G 55','Urbana Ejidal','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Alcala  y  Zeuz',30000.00,8,'CHAVA','2006-06-08',1,29288.00,0),
  ('DCP000926455','Dinamica Comercial El Pato S.A de C.V.','Pas 2 Loc 138 entre I-J y G -H','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Jaime',15000.00,7,'CHAVA','2006-06-08',1,15000.00,0),
  ('CAS020724SE8','Consorcio de Alimentos san Salvador S.A. de C.V.','Pasillo 4 Anden I-J Local 133','Ejidos del Moral','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Camaron y Tono',60000.00,15,'CHAVA','2006-06-08',1,60000.00,0),
  ('RAPC670202135','Candelario Ramirez Pozos','Pasillo 3 E 32','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','Candido y Ana',150000.00,0,'Piero1','2006-06-08',1,150000.00,0),
  ('RAPC670202','Candelario Ramirez Pozos','Pasillo 3 Local E 32','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','',150000.00,15,'Piero','2006-06-08',0,150000.00,0),
  ('EDE0402134B7','Especialidades Deli S.A. de C.V.','Circuito F y L Pasillo 4 Crujia 1 Loc. 137-139','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 3118','','','',7,'','Pancho  y  Yair',80000.00,10,'CHAVA','2006-06-08',1,80000.00,0),
  ('JUPF7706198H0','Flor de Maria Juarez Paredes','Local 51 Pasillo 1 y 3','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',1,'5694 2403','','','',7,'','Tono y Beto',80000.00,15,'Piero1','2006-06-08',1,80000.00,0),
  ('Ramirez','Ramirez','central de abasto','ejidos del moral','iztapalapa','09040','Mexico D.F.',1,'5640 9230','','','',7,'','',80000.00,8,'Piero1','2006-06-14',1,77298.00,0),
  ('Teresita','Teresita','G 41','CEDA','iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Tomas',200000.00,8,'Piero1','2006-06-14',1,193270.00,0),
  ('Marga','Marga','G 15','CEDA','iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Tomas',100000.00,8,'CHAVA','2006-06-14',1,100000.00,0),
  ('Rigo','Rigo','G 1','CEDA','iztapalapa','09040','Mexico D.F.',1,'56407354','','','',7,'','Rigo',10000.00,3,'Piero1','2006-06-14',1,5000.00,0),
  ('Union','Union',' Pasillo 1 Local 3','CEDA','iztapalapa','09040','Mexico D.F.',1,'56009947','','','',7,'','Nicolas',50000.00,15,'Piero1','2006-06-14',1,42370.00,0),
  ('Chucho','Chucho','G 3','CEDA','Iztapalapa','09040','Mexico D.f.',1,'','','','',7,'','Chucho',50000.00,8,'CHAVA','2006-06-14',1,48000.00,0),
  ('Tapatio','Tapatio','G 15','CEDA','Iztapalapa','09040','Mexico D.F',1,'56407036','','','',7,'','Felipe',20000.00,5,'Piero1','2006-06-14',1,20000.00,0),
  ('Gea','Gea','G 19','CEDA','Iztapalapa','09030','Mexico D:F',1,'','','','',7,'','',50000.00,8,'Piero1','2006-06-14',1,50000.00,0),
  ('Normita','Normita','G 43','CEDA','Iztapalapa','09040','Mexico D:F.',1,'56948789','','','',7,'','Claudio',25000.00,5,'Piero1','2006-06-14',1,17253.40,0),
  ('Texana','Texana','H 52-54','Aculco','Iztapalapa','09410','Mexico D.F',1,'5600 2034','','','',7,'','Alfredo y  Alejandro',20000.00,8,'Piero1','2006-06-14',1,20000.00,0),
  ('Vanguardia','Vanguardia','G 61','CEDA','Iztapalapa','09040','Mexico D:F.',1,'5694 1459','','','',7,'','',40000.00,5,'CHAVA','2006-06-14',1,40000.00,0),
  ('Ranchito','Ranchito','G 79','CEDA','Iztapalapa','09040','Mexico D.F',1,'5694 1397','','','',7,'','Luis y Alejandro',25000.00,8,'Piero1','2006-06-14',1,21700.00,0),
  ('Especial','Especial','G 77','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 4692','','','',7,'','Ulises',150000.00,15,'Piero1','2006-06-14',1,126005.00,0),
  ('D`MargònZ','D`MargònZ','Local 51','CEDA','Iztapalapa','09040','Mexico D.F',1,'5694 2403','','','',7,'','Toño',40000.00,15,'Piero1','2006-06-14',1,34000.00,0),
  ('LA GUERA','LA GUERA','Pasillo 3 Loc. 50 G-H','CEDA','Iztapalapa','09040','Mexico D.F',1,'56941403','','','',7,'','Artemio',40000.00,15,'Piero','2006-06-14',0,40000.00,0),
  ('CHILUCA','CHILUCA','G 91','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Rafael',40000.00,3,'Piero1','2006-06-14',1,40000.00,0),
  ('Josè Manuel','Josè Manuel','G 87','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Josè Manuel',70000.00,15,'Piero1','2006-06-14',1,57237.00,0),
  ('SURTIDOR','SURTIDOR','Pasillo 3 Loc 25','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56002097','','','',7,'','Jose y Beto',70000.00,15,'Piero','2006-06-14',0,61482.00,0),
  ('Nueva Merced','Nueva Merced','Pasillo 3 Local 30','CEDA','Iztapalapa','09040','Mexico D.f',1,'','','','',7,'','Puebla',20000.00,3,'Piero1','2006-06-14',1,20000.00,0),
  ('ESPERANZA','ESPERANZA','Pasillo  3 Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56940435','','','',7,'','Pedro y Juana',130000.00,15,'Piero','2006-06-14',0,71932.60,0),
  ('Retoño','Retoño',' E 32 Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 8759','','','',7,'','Candido',150000.00,15,'Piero1','2006-06-14',1,109331.50,0),
  ('L # 45','L # 45',' Pasillo 3 Loc. 45','CEDA','Iatapalapa','09040','Mexico D.F.',1,'','','','',7,'','Sr. Jose',50000.00,15,'Piero1','2006-06-14',1,48100.00,0),
  ('Ruiseñor','Ruiseñor','Pasillo 3 Local  25','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 7263','','','',7,'','Bertha',20000.00,6,'Piero1','2006-06-14',1,7652.80,0),
  ('Esperanza','Esperanza','Pasillo 3 Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56940435','','','',7,'','Pedro y Juana',130000.00,15,'Piero1','2006-06-14',1,71932.60,0),
  ('Retoñito','Retoñito','Pasillo 3 Local 80','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5600 2607','','','',7,'','Rosa y Osbelia',150000.00,15,'CHAVA','2006-06-14',1,116042.50,0),
  ('Surtidor','Surtidor','Pasillo 3 Loc.','CEDA','Iztapalapa','09040','Mexico. D.F.',1,'56002097','','','',7,'','Jose y Beto',70000.00,15,'Piero1','2006-06-14',1,61482.00,0),
  ('Yoely','Yoely','Pasillo 3 Local 78','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Alma y Elizabeth',50000.00,15,'CHAVA','2006-06-14',1,45474.00,0),
  ('La Guera','La Guera','Pasillo 3 Loc 50 G-H','CEDA','Iztapalapa','09040','Mexico D.F.',1,'56941403','','','',7,'','Artemio',40000.00,15,'Piero1','2006-06-14',1,40000.00,0),
  ('Lupita','Lupita','Pasillo 4  Local 124','CEDA','Iztapalapa','09040','Mexico D.F.',1,'5694 3118','','','',7,'','Panchito',70000.00,10,'CHAVA','2006-06-14',1,47831.00,0),
  ('Super Palmas','Super Palmas','Pasillo I-J Loc','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Meliton',20000.00,8,'CHAVA','2006-06-14',1,17165.00,0),
  ('Erik','Erik','I - J','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Erik',2000.00,3,'CHAVA','2006-06-19',1,2000.00,0),
  ('Bonanza','Bonanza','i - j  pasillo 5','CEDA','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Memo y Ivan',30000.00,5,'CHAVA','2006-06-19',1,25506.00,0),
  ('Max','Max','I-61  entre pasillo 2 y 3','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Max',5000.00,2,'Piero1','2006-06-19',1,5000.00,0),
  ('Laura','Laura','Pasillo 1  g-h','CEDA','Iztapalapa','09040','Mexico D.F',3,'','','','',7,'','Alfredo',40000.00,8,'CHAVA','2006-06-19',1,31365.00,0),
  ('Perico','Perico','Av. Riva Palacio','Neza','Neza','000','Mexico D.F.',3,'','','','',7,'','Pedro',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Rosa de oro','Rosa de oro','Pasillo 1 g-h','CEDA','Iztapalapa','09040','Mexico D.F.',5,'5694 8111','','','',7,'','Javier',20000.00,8,'CHAVA','2006-06-19',1,18815.00,0),
  ('Juan Munoz','Juan Munoz','Chalco','Chalco','Edo.Mex.','000','Edo. Mex.',1,'59751692','','','',7,'','Juan Munoz',40000.00,6,'Piero1','2006-06-19',1,25000.00,0),
  ('Palomas','Palomas','E- F Pasillo 2','CEDA','Iztapalapa','09040','Mexico D.F.',3,'5694 6529','','','',7,'','Beto',50000.00,8,'Piero1','2006-06-19',1,46050.00,0),
  ('Alfredo','Alfredo','Altamirano Guerrero','Altamirano Guerrero','Guerrero','000','Guerrero',3,'0176 76726774','','','',7,'','Alfredo',40000.00,5,'Piero1','2006-06-19',1,40000.00,0),
  ('Jorge Montoya','Jorge Montoya','Neza','Neza','Edo. Mexico','000','Edo. Mexico.',3,'','','','',7,'','Jorge Montoya',15000.00,10,'Piero1','2006-06-19',1,15000.00,0),
  ('Barca','Barca','O-P  Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F.',3,'5694 5586','','','',7,'','Josè Luis',15000.00,3,'Piero1','2006-06-19',1,10051.00,0),
  ('Trinidad','Jose Trinidad','Tlaxcala','Tlaxcala','Tlaxcala','000','Tlaxcala',3,'','','','',7,'','Jose Trinidad',40000.00,3,'Piero1','2006-06-19',1,40000.00,0),
  ('Juan Zepeda','Juan Zepeda','I-61','CEDA','Iztapalapa','09040','Mexico D.F.',1,'','','','',7,'','Juan Zepada',1000.00,2,'Piero1','2006-06-19',1,1000.00,0),
  ('Rojas','Rojas','Pasillo 3   I-J','Ceda','Iztapalapa','09040','Mexico D.F',3,'','','','',7,'','Rojas',1000.00,0,'Piero1','2006-06-19',1,1000.00,0),
  ('Nochistlan','Nochistlan','O -P Pasillo 3','CEDA','Iztapalapa','09040','Mexico D.F',5,'','','','',7,'','Nochistlan',1000.00,0,'Piero1','2006-06-19',1,1000.00,0),
  ('El Pico de O','El Pico De Orizaba','S-T  Pasillo 4','Ceda','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','',5000.00,0,'Piero1','2006-06-19',1,5000.00,0),
  ('Yony','Yony','Neza','Neza','Neza','000','Mexico D.F.',3,'','','','',7,'','Yony',2000.00,0,'Piero1','2006-06-19',1,2000.00,0),
  ('Mundo','Mundo','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Mundo',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Paty','Paty','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Paty',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Alejandro','Alejandro','Calpulalpan','Calpulalpan','Calpulalpan','000','Calpulalpan',3,'','','','',7,'','Alejandro',10000.00,10,'Piero1','2006-06-19',1,10000.00,0),
  ('Sr. Zarco','Sr. Zarco','Texcoco','Texcoco','Edo. Mexico','000','Edo. Mexico',3,'56800428','','','',7,'','Sr. Zarco',30000.00,10,'Piero1','2006-06-19',1,13391.00,0),
  ('Mario','Mario Figueroa','Taxco','Taxco','Taxco','000','Taxco Guerrero',1,'','','','',7,'','Mario Figueroa',30000.00,8,'Piero1','2006-07-13',1,30000.00,0),
  ('Israel','Israel Melchor','Desconocida','Desconocida','Desconocida','000','Mexico D.F',1,'','','','',7,'','Israel',0.00,0,'Piero1','2006-07-13',1,0.00,0),
  ('Rene','Rene','Bodega G-75','CEDA','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','',50000.00,10,'Piero1','2006-07-13',1,50000.00,0),
  ('DCP040210F26','Dinamica Comercial Pastora S.A de C.V.','Pasillo 3 locales 52-53','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',5,'','','','',7,'','Victor',115000.00,15,'Piero1','2006-07-17',1,113660.00,0),
  ('DCS0402101N9','Dinamica comercial soledad,S.A. DE C.V.','Pasillo 2 local 198-200-202- KL','Col. Ejidos del Moral','Iztapalapa','09040','Mexico,D.F.',5,'','','','',7,'','Pepe',20000.00,5,'CHAVA','2006-07-19',1,18026.00,0),
  ('DCL0402164N0','Deinne Club,S.A.DEC.V.','Guanajuato No.240 Int.1','Roma','Cuahutemoc','06700','Mexico,D.F.',1,'57119706','','','',7,'','',40000.00,5,'Piero1','2006-07-19',1,40000.00,0),
  ('DCP040210J5A',' Dinamica Comercial Parroquia,S.A.DE C.V.','Pasillo 2 Local  128','Ejidos del Moral','Iztapalapa','09040','Mexico,D.F.',3,'56942355','','','',7,'','PEPE',20000.00,5,'CHAVA','2006-07-19',1,18916.00,0),
  ('Rancherita','La Rancherita','Pasillo 4','Ejidos Del Moral','Iztapalapa','09040','Mexico,D.F.',3,'56009548','','','',7,'','',40000.00,10,'CHAVA','2006-07-19',1,30900.00,0),
  ('melo','melo','melo','melo','melo','000','mexico',3,'','','','',7,'','melo',10000.00,3,'Piero1','2006-08-02',1,10000.00,0),
  ('toro','toro','toro','toro','toro','000','mexico',5,'','','','',7,'','toro',100.00,0,'Piero1','2006-08-02',1,100.00,0),
  ('Moro','Moro','Moro','Moro','Moro','09040','Mexico D.F.',3,'','','','',7,'','Moro',40000.00,8,'Piero1','2006-08-02',1,34010.00,0),
  ('DCP040210NJO','Dinamica Comercial Parroquia S.A de C.V','Central de Abasto Local 128 Pasillo 2','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','Laura',10000.00,0,'CHAVA','2006-08-02',0,10000.00,0),
  ('DCN040210NJO','Dinamica Comercial Nueva Orizaba S.A de C.V','Central de Abasto G 67 y 69','Ejidos del Moral','Iztapalapa','09040','Mexico D.F.',3,'','','','',7,'','Pepe',50000.00,8,'Piero1','2006-08-02',1,45860.00,0),
  ('Galdino','Galdino','mexico','emexico','mexico','000','Mexico',1,'','','','',7,'','',20000.00,4,'Piero1','2006-08-03',1,14630.00,0),
  ('celestino','celestino','ceda','ceda','iztapalapa','09040','mexico',3,'','','','',7,'','',7000.00,5,'Piero1','2006-08-03',1,4764.50,0),
  ('DMA0106263S9','Distribuidora Marga S.A de C.V','Zona 1 sector 1 nave1','central de abasto','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Tomas',80000.00,8,'CHAVA','2006-08-03',1,66035.00,0),
  ('Yovany','Yovany','ceda','ceda','Iztapalapa','09040','Mexico D.F',1,'','','','',7,'','Yovany',0.00,1,'Piero1','2006-08-04',1,0.00,0);

COMMIT;

#
# Data for the `cobros` table  (LIMIT 0,500)
#

# consecutivo:3:49667
# claveVenta:3:32768
# claveCliente:253:0
# fechaCobro:10:128
# monto:5:32768
# formaPago:3:32768
# observaciones:253:0
# bancoCuenta:3:32768
# activo:3:32768

INSERT INTO `cobros` (`consecutivo`, `claveVenta`, `claveCliente`, `fechaCobro`, `monto`, `formaPago`, `observaciones`, `bancoCuenta`, `activo`) VALUES 
  (1,3,'La Guera','2006-08-02',1780.00,1,'',0,1),
  (2,4,'melo','2006-08-02',2477.00,1,'',0,1),
  (3,17,'Rojas','2006-08-02',74.00,1,'',0,1),
  (4,18,'toro','2006-08-02',157.00,1,'',0,1),
  (5,24,'El Pico de O','2006-08-02',1003.20,1,'',0,1),
  (6,42,'AEVJ741206QJ3','2006-08-02',5421.00,1,'',0,1),
  (7,41,'Juan Munoz','2006-08-02',3141.00,1,'',0,1),
  (8,11,'Erik','2006-08-03',552.00,1,'',0,1),
  (9,2,'Normita','2006-08-03',5000.00,1,'',0,1),
  (10,54,'Rojas','2006-08-03',112.00,1,'',0,1),
  (11,53,'Rojas','2006-08-03',157.00,1,'',0,1),
  (12,2,'Normita','2006-08-04',6890.00,1,'',0,1),
  (13,20,'Ranchito','2006-08-04',3982.00,1,'',0,1),
  (14,50,'Erik','2006-08-04',363.00,1,'',0,1),
  (15,66,'Rosa de oro','2006-08-04',1899.20,1,'',0,1),
  (16,27,'Vanguardia','2006-08-04',1975.00,1,'',0,1),
  (17,13,'Juan Munoz','2006-08-04',19181.00,1,'',0,1),
  (18,104,'Juan Munoz','2006-08-04',10104.50,1,'',0,1),
  (19,112,'Juan Munoz','2006-08-04',398.00,1,'',0,1),
  (20,119,'GAAY8110197E3','2006-08-04',12143.60,1,'',0,1),
  (21,103,'Yovany','2006-08-04',445.00,1,'',0,1),
  (22,121,'AEVJ741206QJ3','2006-08-04',9722.00,2,'',0,1),
  (23,10,'Bonanza','2006-08-04',3546.00,1,'',0,1);

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
  (1,1,'2006-08-02','Pago a la Compra #3',55510.50,0),
  (2,1,'2006-08-02','Pago a la Compra #5',9500.00,1),
  (3,1,'2006-08-02','Pago a la Compra #4',23571.62,1),
  (4,1,'2006-08-04','Pago a la Compra #3',55510.50,1),
  (5,1,'2006-08-04','Pago a la Compra #10',36633.69,1),
  (6,0,'2006-08-04','Pago a la Compra #10',1368.06,1),
  (7,1,'2006-08-04','Pago a la Compra #12',59312.24,1);

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
  (1,0,'2006-07-27','Cobro de la Venta #1',32400.00,1),
  (2,1,'2006-08-02','deposito',352006.51,1),
  (3,2,'2006-08-02','deposito',832.11,0),
  (4,2,'2006-08-02','deposito',832.11,1),
  (5,4,'2006-08-02','suma de cheques',911079.79,1),
  (6,0,'2006-08-02','Cobro de la Venta #3',1780.00,1),
  (7,0,'2006-08-02','Cobro de la Venta #4',2477.00,1),
  (8,0,'2006-08-02','Cobro de la Venta #17',74.00,1),
  (9,0,'2006-08-02','Cobro de la Venta #18',157.00,1),
  (10,0,'2006-08-02','Cobro de la Venta #24',1003.20,1),
  (11,0,'2006-08-02','Cobro de la Venta #42',5421.00,1),
  (12,0,'2006-08-02','Cobro de la Venta #41',3141.00,1),
  (13,5,'2006-08-02','cobro',194819.00,1),
  (14,3,'2006-08-02','cobro',123290.00,1),
  (15,0,'2006-08-03','Cobro de la Venta #11',552.00,1),
  (16,0,'2006-08-03','Cobro de la Venta #2',5000.00,1),
  (17,0,'2006-08-03','Cobro de la Venta #54',112.00,1),
  (18,0,'2006-08-03','Cobro de la Venta #53',157.00,1),
  (19,0,'2006-08-04','Cobro de la Venta #2',6890.00,1),
  (20,0,'2006-08-04','Cobro de la Venta #20',3982.00,1),
  (21,0,'2006-08-04','Cobro de la Venta #50',363.00,1),
  (22,0,'2006-08-04','Cobro de la Venta #66',1899.20,1),
  (23,0,'2006-08-04','Cobro de la Venta #27',1975.00,1),
  (24,1,'2006-08-04','deposito del dia',132664.60,1),
  (25,0,'2006-08-04','Cobro de la Venta #13',19181.00,1),
  (26,0,'2006-08-04','Cobro de la Venta #104',10104.50,1),
  (27,0,'2006-08-04','Cobro de la Venta #112',398.00,1),
  (28,0,'2006-08-04','Cobro de la Venta #119',12143.60,1),
  (29,0,'2006-08-04','Cobro de la Venta #103',445.00,1),
  (30,0,'2006-08-04','Cobro de la Venta #121',9722.00,1),
  (31,0,'2006-08-04','Cobro de la Venta #10',3546.00,1);

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
  ('jam','jamon'),
  ('Pal','Palomitas');

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
  ('lca','lcastel'),
  ('pri','primavera chantilly'),
  ('fru','frutsy'),
  ('gen','generosa'),
  ('bot','botellin'),
  ('new','new mix'),
  ('Act','Act II');

COMMIT;

#
# Data for the `orden_compra` table  (LIMIT 0,500)
#

# claveOrden:3:49667
# claveProveedor:253:0
# fecha:10:128
# fechaEntrega:10:128
# observaciones:253:0
# descuento1:5:32768
# descuento2:5:32768
# descuento3:5:32768
# subtotal:5:32768
# descuento:5:32768
# iva:5:32768
# total:5:32768
# activo:3:32768
# factura:253:0
# Entrega:3:32768
# usuario:253:0
# pago:3:32768

INSERT INTO `orden_compra` (`claveOrden`, `claveProveedor`, `fecha`, `fechaEntrega`, `observaciones`, `descuento1`, `descuento2`, `descuento3`, `subtotal`, `descuento`, `iva`, `total`, `activo`, `factura`, `Entrega`, `usuario`, `pago`) VALUES 
  (1,'DCL0402164N0','2006-08-02','2006-08-02','',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0,'0',0,'piero',0),
  (2,'DCL0402164N0','2006-08-02','2006-08-02','',0.00,0.00,0.00,55500.00,55500.00,0.00,55500.00,0,'0',0,'piero',0),
  (3,'DCL0402164N0','2006-08-02','2006-08-02','',0.00,0.00,0.00,48270.00,48270.00,7240.50,55510.50,1,'20616',2,'piero',2),
  (4,'MEG0202151X5','2006-08-02','2006-08-02','',0.00,0.00,0.00,23571.62,23571.62,0.00,23571.62,1,'41023/41024',2,'piero',2),
  (5,'Carioca','2006-08-02','2006-08-02','',0.00,0.00,0.00,9500.00,9500.00,0.00,9500.00,1,'2105',2,'piero',2),
  (6,'UNI9704247M2','2006-08-02','2006-08-02','',0.00,0.00,0.00,44800.00,44800.00,0.00,44800.00,1,'34084',2,'piero',0),
  (7,'UNI9704247M2','2006-08-02','2006-08-02','',0.00,0.00,0.00,7780.90,7780.90,0.00,7780.90,1,'34089',2,'piero',0),
  (8,'TNI920507GB8','2006-08-03','2006-08-03','',20.00,0.00,0.00,215978.40,172782.72,0.00,172782.72,1,'3003',2,'piero',0),
  (9,'Carioca','2006-08-03','2006-08-03','',0.00,0.00,0.00,19475.00,19475.00,0.00,19475.00,1,'2106',2,'piero',0),
  (10,'DCL0402164N0','2006-08-03','2006-08-03','',0.00,0.00,0.00,33045.00,33045.00,4956.75,38001.75,1,'20622',2,'piero',2),
  (11,'UNI9704247M2','2006-08-03','2006-08-03','',0.00,0.00,0.00,26225.35,26225.35,0.00,26225.35,1,'34151',2,'piero',0),
  (12,'MEG0202151X5','2006-08-04','2006-08-04','',0.00,0.00,0.00,59312.24,59312.24,0.00,59312.24,1,'41074',2,'bety',2);

COMMIT;

#
# Data for the `pagos` table  (LIMIT 0,500)
#

# consecutivo:3:49667
# claveOrden:3:32768
# claveProveedor:253:0
# fechaPago:10:128
# monto:5:32768
# formaPago:3:32768
# numeroCheque:3:32768
# bancoCuenta:3:32768
# activo:3:32768

INSERT INTO `pagos` (`consecutivo`, `claveOrden`, `claveProveedor`, `fechaPago`, `monto`, `formaPago`, `numeroCheque`, `bancoCuenta`, `activo`) VALUES 
  (1,3,'DCL0402164N0','2006-08-02',55510.50,2,1911,1,0),
  (2,5,'Carioca','2006-08-02',9500.00,2,1910,1,1),
  (3,4,'MEG0202151X5','2006-08-02',23571.62,2,1909,1,1),
  (4,3,'DCL0402164N0','2006-08-04',55510.50,2,0,1,1),
  (5,10,'DCL0402164N0','2006-08-04',36633.69,2,0,1,1),
  (6,10,'DCL0402164N0','2006-08-04',1368.06,1,0,0,1),
  (7,12,'MEG0202151X5','2006-08-04',59312.24,2,0,1,1);

COMMIT;

#
# Data for the `precio_anterior_producto` table  (LIMIT 0,500)
#

# claveProducto:253:0
# claveOrden:3:32768
# precioAnterior:5:32768
# precioCompra:5:32768

INSERT INTO `precio_anterior_producto` (`claveProducto`, `claveOrden`, `precioAnterior`, `precioCompra`) VALUES 
  ('bebfru01',3,37.50,32.18),
  ('marpri01',6,81.50,80.00),
  ('bebbot01',10,78.00,66.09);

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

# claveProducto:253:0
# linea:254:0
# marca:254:0
# proveedor1:253:0
# proveedor2:253:0
# proveedor3:253:0
# proveedor4:253:0
# proveedor5:253:0
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
# iva:3:32768

INSERT INTO `productos` (`claveProducto`, `linea`, `marca`, `proveedor1`, `proveedor2`, `proveedor3`, `proveedor4`, `proveedor5`, `descripcion`, `costo`, `precio1`, `precio2`, `precio3`, `precio4`, `precio5`, `maximo`, `minimo`, `existencia`, `piezasXcaja`, `activo`, `iva`) VALUES 
  ('leclal01','lec','lal','Ricardo','0','0','0','0','Leche Entera Tetrapac',95.00,98.00,100.00,101.00,103.00,103.00,200,50,0,12,1,0),
  ('crealp01','cre','alp','Joaquin','Ricardo','0','0','0',' acida 250 gr.',114.70,116.00,116.80,117.00,117.00,117.00,800,50,16,24,1,0),
  ('yogalp01','yog','alp','Joaquin','Calderon','0','0','0','de200gr',58.46,59.50,60.00,61.50,62.50,64.80,1500,50,603,24,1,0),
  ('crealp02','cre','alp','Joaquin','Ricardo','0','0','0',' acida 450 gr.',257.11,260.00,261.80,262.00,262.00,262.00,600,50,6,24,1,0),
  ('crealp03','cre','alp','Joaquin','Ricardo','0','0','0',' acida 900gr.',257.11,260.00,261.80,262.00,262.00,262.00,250,50,0,12,1,0),
  ('toscha01','tos','cha','TNI920507GB8','0','0','0','0','con 18 pz',145.44,147.50,148.00,149.00,150.00,150.00,1500,50,1051,18,1,0),
  ('toscar01','tos','car','Carioca','0','0','0','0','con 24pz',95.00,100.00,100.00,100.00,100.00,100.00,400,10,0,24,1,0),
  ('yogdan01','yog','dan','MEG0202151X5','0','0','0','0','fruix con cereal 151gr',87.74,90.00,92.00,93.00,95.00,95.00,600,50,0,24,1,0),
  ('yogdan02','yog','dan','MEG0202151X5','0','0','0','0','danonino para beber 100gr',95.21,98.00,100.00,102.00,102.00,102.00,100,10,19,25,1,0),
  ('yogdan03','yog','dan','MEG0202151X5','0','0','0','0','dan-up 250gr',140.28,142.00,143.00,143.00,143.00,143.00,1500,150,177,28,1,0),
  ('yogdan04','yog','dan','MEG0202151X5','0','0','0','0','licuado250gr',163.77,175.00,178.00,178.00,178.00,178.00,10,2,0,28,1,0),
  ('yogdan05','yog','dan','MEG0202151X5','0','0','0','0','danonino  180gr',175.48,178.00,178.50,179.00,180.00,180.00,2000,150,332,24,1,0),
  ('geldan01','gel','dan','MEG0202151X5','0','0','0','0','dany sabores 125gr',105.29,112.00,113.00,115.00,115.00,115.00,300,30,8,48,1,0),
  ('posdan01','pos','dan','MEG0202151X5','0','0','0','0','danette natilla 200gr',122.84,130.00,133.00,133.00,133.00,133.00,30,5,0,24,1,0),
  ('yogdan06','yog','dan','MEG0202151X5','0','0','0','0','vitalinea para beber 250gr',163.77,175.00,175.00,175.00,175.00,175.00,60,10,9,28,1,0),
  ('yogdan07','yog','dan','MEG0202151X5','0','0','0','0','vitalinea solido 150gr',181.33,195.00,195.00,195.00,195.00,195.00,5,2,0,48,1,0),
  ('yogdan08','yog','dan','MEG0202151X5','0','0','0','0','activia solido 150gr',141.60,155.00,160.00,160.00,160.00,160.00,90,15,3,48,1,0),
  ('yogdan09','yog','dan','MEG0202151X5','0','0','0','0','activia para beber 250gr',163.77,170.00,175.00,178.00,178.00,178.00,800,50,404,28,1,0),
  ('posdan02','pos','dan','MEG0202151X5','0','0','0','0','flan danette 200gr',122.84,130.00,133.00,133.00,133.00,133.00,200,20,1,24,1,0),
  ('posdan03','pos','dan','MEG0202151X5','0','0','0','0','arroz con leche 200gr',122.84,130.00,133.00,133.00,133.00,133.00,80,15,0,24,1,0),
  ('bebbon01','beb','bon','UNI9704247M2','0','0','0','0','naranjada 900ml',83.00,89.00,89.00,89.00,89.00,90.00,700,50,137,20,1,0),
  ('bebbon02','beb','bon','UNI9704247M2','0','0','0','0','naranjada 700ml',63.00,68.00,68.00,68.00,68.00,70.00,700,50,41,20,1,0),
  ('bebbon03','beb','bon','UNI9704247M2','0','0','0','0','naranjada de plastico 1lt',90.00,96.00,96.00,96.00,96.00,98.00,250,20,1,20,1,0),
  ('bebbon04','beb','bon','UNI9704247M2','0','0','0','0','naranjada shak',62.40,66.00,66.00,66.00,66.00,68.00,200,10,6,5,1,0),
  ('bebbon05','beb','bon','UNI9704247M2','0','0','0','0','naranjada 3.750',80.00,86.00,86.00,86.00,86.00,86.00,35,5,0,6,1,0),
  ('creran01','cre','ran','Joaquin','0','0','0','0','vegetal 900ml',126.70,132.00,135.00,138.00,138.00,138.00,30,5,20,12,1,0),
  ('queama01','que','ama','UNI9704247M2','0','0','0','0','la provinciana de 1kg',104.20,107.00,108.00,110.00,112.00,112.00,500,50,0,10,0,0),
  ('cregin01','cre','gin','UNI9704247M2','0','0','0','0','bolsa de 1kg',64.20,66.00,67.00,68.00,69.00,69.00,600,50,110,10,1,0),
  ('queama02','que','ama','UNI9704247M2','0','0','0','0','rancherito rebanado 2kg',300.00,293.00,295.00,298.00,298.00,298.00,700,30,0,6,0,0),
  ('queraa01','que','raa','UNI9704247M2','0','0','0','0','rebanado de 2kg',300.00,290.00,293.00,295.00,296.00,298.00,700,30,459,6,1,0),
  ('quechi01','que','chi','UNI9704247M2','0','0','0','0','rebanado de 2kg',345.00,345.00,345.00,345.00,345.00,345.00,700,30,343,6,1,0),
  ('quelca01','que','lca','UNI9704247M2','0','0','0','0','rebanado de 1.8kg',225.00,225.00,225.00,225.00,225.00,225.00,200,15,222,6,1,0),
  ('manchi01','man','chi','UNI9704247M2','0','0','0','0','pura de 90gr',91.54,93.00,95.50,95.50,95.50,95.50,250,20,34,24,1,0),
  ('manchi02','man','chi','UNI9704247M2','0','0','0','0','pura de 225gr',81.15,83.00,85.00,5.00,85.00,85.00,200,20,41,9,1,0),
  ('manchi03','man','chi','UNI9704247M2','0','0','0','0','pura de 1kg',376.50,385.00,385.00,385.00,385.00,385.00,20,2,0,10,1,0),
  ('manchi04','man','chi','UNI9704247M2','0','0','0','0','industial de 1kg',190.00,190.00,193.00,196.00,196.00,196.00,180,10,87,10,1,0),
  ('chorio01','cho','rio','Retonito','0','0','0','0','por atado',32.00,38.00,38.00,38.00,38.00,38.00,2,0,0,1,1,0),
  ('yogbon01','yog','bon','UNI9704247M2','0','0','0','0','para beber de 500ml',165.60,169.20,169.20,169.20,169.20,169.20,150,10,0,36,1,0),
  ('yogbon02','yog','bon','UNI9704247M2','0','0','0','0','para beber de 1lt',155.00,160.00,160.00,160.00,160.00,160.00,35,5,4,20,1,0),
  ('crelal01','cre','lal','CLD0507145H6','0','0','0','0','aciada de 200ml',106.80,107.00,108.00,108.50,109.00,110.00,250,30,108,24,1,0),
  ('crelal02','cre','lal','CLD0507145H6','0','0','0','0','acida de 450ml',106.80,107.00,108.00,108.50,109.00,110.00,700,30,187,12,1,0),
  ('crelal03','cre','lal','CLD0507145H6','0','0','0','0','acida de 900ml',106.80,107.00,108.00,108.50,109.00,110.00,1000,30,70,6,1,0),
  ('crelal04','cre','lal','CLD0507145H6','0','0','0','0','acida de cubeta',304.00,306.00,310.00,314.00,314.00,320.00,150,5,1,4,1,0),
  ('maribe01','mar','ibe','UNI9704247M2','0','0','0','0','sin sal de 90gr',75.50,71.50,72.00,72.50,73.00,74.00,8000,200,5596,24,1,0),
  ('maribe02','mar','ibe','UNI9704247M2','0','0','0','0','sin sal 225 grs.',63.50,60.50,61.00,61.50,62.00,63.00,4500,200,2732,9,1,0),
  ('maribe03','mar','ibe','UNI9704247M2','0','0','0','0','sin sal de .500 grs.',145.33,146.00,146.50,147.00,147.50,148.00,200,10,0,10,1,0),
  ('maribe04','mar','ibe','UNI9704247M2','0','0','0','0','sin sal de 1kl.',183.00,171.00,172.00,173.00,174.00,178.00,3000,100,464,10,1,0),
  ('manchi05','man','chi','UNI9704247M2','0','0','0','0','pura de 500gr',301.00,325.00,325.00,325.00,325.00,325.00,10,0,0,10,1,0),
  ('marpri01','mar','pri','UNI9704247M2','0','0','0','0','sin sal de190gr',80.75,83.00,84.00,84.00,84.00,85.00,2000,30,679,12,1,0),
  ('bebfru01','beb','fru','Yordy','0','0','0','0','con 24pz.',32.17,39.50,40.00,41.00,41.00,41.00,5000,10,445,24,1,1),
  ('bebgen01','beb','gen','Yordy','0','0','0','0','con 24pz',105.00,110.00,111.00,112.00,112.00,114.00,1000,10,0,24,1,1),
  ('bebbot01','beb','bot','Yordy','0','0','0','0','con 24pz',66.08,80.00,81.00,82.00,83.00,84.00,500,10,142,24,1,1),
  ('quecot01','que','cot','Candido','0','0','0','0','29 kg aprox.',32.00,32.50,33.00,33.50,34.00,34.00,50,0,0,1,1,0),
  ('bebnew01','beb','new','Candido','0','0','0','0','de 355ml',148.00,150.00,151.00,152.00,153.00,154.00,3000,0,0,24,1,0),
  ('queama03','que','ama','UNI9704247M2','0','0','0','0','fundido la provinciana de kg',104.20,107.00,108.00,109.00,110.00,112.00,600,20,141,10,1,0),
  ('PalAct01','Pal','Act','DCL0402164N0','0','0','0','0','de mantequilla c/18',186.50,190.00,191.00,192.00,193.00,195.00,50,5,6,4,1,0),
  ('PalAct02','Pal','Act','DCL0402164N0','0','0','0','0','natural c/18pz',186.50,190.00,191.00,192.00,193.00,195.00,50,5,10,4,1,0),
  ('PalAct03','Pal','Act','DCL0402164N0','0','0','0','0','de caramelo c/ 9pz',280.00,284.00,285.00,286.00,288.00,290.00,20,1,0,4,1,0);

COMMIT;

#
# Data for the `productos_orden` table  (LIMIT 0,500)
#

# ClaveOrden:3:32768
# ClaveProducto:253:0
# Cantidad:3:32768
# Costo:5:32768
# Importe:5:32768
# Llegan:3:32768

INSERT INTO `productos_orden` (`ClaveOrden`, `ClaveProducto`, `Cantidad`, `Costo`, `Importe`, `Llegan`) VALUES 
  (2,'bebfru01',1500,37.00,55500.00,0),
  (3,'bebfru01',1500,32.18,48270.00,1500),
  (4,'yogdan02',20,95.21,1904.20,20),
  (4,'geldan01',90,105.29,9476.10,90),
  (4,'posdan03',38,122.84,4667.92,38),
  (4,'yogdan06',20,163.77,3275.40,20),
  (4,'yogdan08',30,141.60,4248.00,30),
  (5,'toscar01',100,95.00,9500.00,100),
  (6,'marpri01',560,80.00,44800.00,560),
  (7,'manchi01',85,91.54,7780.90,85),
  (8,'toscha01',1188,181.80,215978.40,1188),
  (9,'toscar01',205,95.00,19475.00,205),
  (10,'bebbot01',500,66.09,33045.00,500),
  (11,'manchi02',45,81.15,3651.75,45),
  (11,'queama03',168,104.20,17505.60,168),
  (11,'creran01',40,126.70,5068.00,40),
  (12,'yogdan05',338,175.48,59312.24,338);

COMMIT;

#
# Data for the `productos_venta` table  (LIMIT 0,500)
#

# claveVenta:3:32768
# ClaveProducto:253:0
# Cantidad:3:32768
# Costo:5:32768
# Importe:5:32768
# Llegan:3:32768

INSERT INTO `productos_venta` (`claveVenta`, `ClaveProducto`, `Cantidad`, `Costo`, `Importe`, `Llegan`) VALUES 
  (1,'bebbon05',20,86.00,1720.00,20),
  (2,'yogdan03',10,143.00,1430.00,10),
  (2,'yogdan05',10,178.00,1780.00,10),
  (2,'yogdan01',5,95.00,475.00,5),
  (2,'yogdan09',10,170.00,1700.00,10),
  (2,'posdan02',5,133.00,665.00,5),
  (2,'posdan03',5,133.00,665.00,5),
  (2,'maribe01',50,73.00,3650.00,50),
  (2,'maribe02',25,61.00,1525.00,25),
  (3,'bebbon01',20,89.00,1780.00,20),
  (4,'maribe01',8,73.00,584.00,8),
  (4,'maribe02',8,61.00,488.00,8),
  (4,'maribe04',2,178.00,356.00,2),
  (4,'bebbon01',4,89.00,356.00,4),
  (4,'bebbon02',1,68.00,68.00,1),
  (4,'yogalp01',10,62.50,625.00,10),
  (5,'crelal02',5,108.00,540.00,5),
  (5,'crelal03',100,108.00,10800.00,100),
  (5,'yogdan01',2,95.00,190.00,2),
  (5,'yogdan09',5,178.00,890.00,5),
  (5,'posdan02',2,133.00,266.00,2),
  (5,'posdan03',1,133.00,133.00,1),
  (6,'yogdan05',5,180.00,900.00,5),
  (6,'yogdan01',5,95.00,475.00,5),
  (6,'yogdan08',1,160.00,160.00,1),
  (6,'posdan02',2,133.00,266.00,2),
  (6,'posdan03',1,133.00,133.00,1),
  (6,'bebbon01',5,89.00,445.00,5),
  (6,'yogbon01',1,169.20,169.20,1),
  (7,'bebfru01',200,39.50,7900.00,200),
  (8,'geldan01',3,115.00,345.00,3),
  (8,'bebbon03',1,96.00,96.00,1),
  (9,'bebfru01',200,39.50,7900.00,200),
  (9,'yogalp01',100,62.50,6250.00,100),
  (9,'marpri01',20,84.00,1680.00,20),
  (9,'manchi04',1,196.00,196.00,1),
  (10,'crelal03',10,110.00,1100.00,10),
  (10,'yogdan03',4,143.00,572.00,4),
  (10,'yogdan09',3,178.00,534.00,3),
  (10,'maribe01',10,73.00,730.00,10),
  (10,'maribe02',10,61.00,610.00,10),
  (11,'bebfru01',10,39.50,395.00,10),
  (11,'bebbon01',1,89.00,89.00,1),
  (11,'bebbon02',1,68.00,68.00,1),
  (12,'bebfru01',30,39.50,1185.00,30),
  (12,'yogdan05',5,180.00,900.00,5),
  (13,'queraa01',10,295.00,2950.00,10),
  (13,'maribe04',20,174.00,3480.00,20),
  (13,'crelal02',60,108.00,6480.00,60),
  (13,'maribe01',10,73.00,730.00,10),
  (13,'maribe02',10,61.00,610.00,10),
  (13,'bebbon02',1,68.00,68.00,1),
  (13,'bebbon01',1,89.00,89.00,1),
  (13,'cregin01',2,69.00,138.00,2),
  (13,'queama03',1,112.00,112.00,1),
  (13,'yogdan02',2,102.00,204.00,2),
  (13,'crelal03',40,108.00,4320.00,40),
  (14,'crelal02',20,107.00,2140.00,20),
  (14,'crelal03',20,107.00,2140.00,20),
  (14,'posdan02',5,133.00,665.00,5),
  (14,'geldan01',10,112.00,1120.00,10),
  (14,'posdan03',5,133.00,665.00,5),
  (15,'toscar01',50,100.00,5000.00,50),
  (16,'yogdan01',2,95.00,190.00,2),
  (16,'yogdan09',3,178.00,534.00,3),
  (16,'posdan01',1,133.00,133.00,1),
  (16,'geldan01',4,115.00,460.00,4),
  (17,'maribe01',1,74.00,74.00,1),
  (18,'bebbon01',1,89.00,89.00,1),
  (18,'bebbon02',1,68.00,68.00,1),
  (19,'bebfru01',50,39.50,1975.00,50),
  (20,'crealp01',10,116.80,1168.00,10),
  (20,'crealp02',5,261.80,1309.00,5),
  (20,'yogdan01',3,95.00,285.00,3),
  (20,'maribe02',20,61.00,1220.00,20),
  (21,'bebbon01',5,89.00,445.00,5),
  (22,'yogalp01',100,62.50,6250.00,100),
  (22,'crealp01',50,116.80,5840.00,50),
  (22,'crealp02',40,261.80,10472.00,40),
  (22,'bebbon05',5,86.00,430.00,5),
  (22,'cregin01',10,69.00,690.00,10),
  (23,'bebfru01',30,39.50,1185.00,30),
  (24,'yogdan09',2,178.00,356.00,2),
  (24,'yogdan03',2,143.00,286.00,2),
  (24,'yogbon01',1,169.20,169.20,1),
  (24,'bebbon03',2,96.00,192.00,2),
  (25,'bebfru01',80,39.50,3160.00,80),
  (25,'yogdan05',10,180.00,1800.00,10),
  (25,'yogdan01',3,95.00,285.00,3),
  (25,'posdan02',1,133.00,133.00,1),
  (25,'posdan03',1,133.00,133.00,1),
  (25,'bebbon02',6,68.00,408.00,6),
  (25,'bebbon01',10,89.00,890.00,10),
  (26,'bebfru01',100,39.50,3950.00,100),
  (27,'bebfru01',50,39.50,1975.00,50),
  (28,'yogdan05',10,180.00,1800.00,10),
  (28,'yogdan08',2,160.00,320.00,2),
  (28,'posdan02',3,133.00,399.00,3),
  (28,'geldan01',6,115.00,690.00,6),
  (28,'maribe04',10,174.00,1740.00,10),
  (29,'maribe02',25,61.00,1525.00,25),
  (29,'manchi01',10,95.50,955.00,10),
  (29,'quechi01',15,345.00,5175.00,15),
  (29,'queraa01',15,298.00,4470.00,15),
  (29,'geldan01',3,115.00,345.00,3),
  (29,'yogdan01',2,95.00,190.00,2),
  (29,'posdan02',1,133.00,133.00,1),
  (29,'yogdan08',1,160.00,160.00,1),
  (29,'yogdan06',1,175.00,175.00,1),
  (29,'toscha01',22,148.00,3256.00,22),
  (29,'quelca01',1,225.00,225.00,1),
  (30,'yogdan05',10,180.00,1800.00,10),
  (30,'yogdan01',5,95.00,475.00,5),
  (31,'yogdan09',20,170.00,3400.00,20),
  (31,'posdan03',5,130.00,650.00,5),
  (32,'toscar01',50,100.00,5000.00,50),
  (33,'toscha01',15,149.00,2235.00,15),
  (33,'maribe01',50,73.00,3650.00,50),
  (33,'maribe02',50,61.00,3050.00,50),
  (34,'yogdan08',2,160.00,320.00,2),
  (34,'queraa01',10,295.00,2950.00,10),
  (34,'quechi01',10,345.00,3450.00,10),
  (34,'posdan03',5,133.00,665.00,5),
  (35,'yogdan05',10,180.00,1800.00,10),
  (35,'yogdan06',4,175.00,700.00,4),
  (35,'bebfru01',50,39.50,1975.00,50),
  (35,'posdan03',5,133.00,665.00,5),
  (36,'geldan01',3,115.00,345.00,3),
  (36,'yogdan01',2,95.00,190.00,2),
  (36,'posdan02',2,133.00,266.00,2),
  (37,'yogdan09',3,178.00,534.00,3),
  (38,'yogalp01',30,62.50,1875.00,30),
  (39,'bebfru01',50,39.50,1975.00,50),
  (39,'cregin01',20,69.00,1380.00,20),
  (39,'bebbon02',5,68.00,340.00,5),
  (39,'bebbon01',5,89.00,445.00,5),
  (40,'crealp03',10,261.80,2618.00,10),
  (41,'manchi02',1,85.00,85.00,1),
  (41,'posdan02',1,133.00,133.00,1),
  (41,'cregin01',3,69.00,207.00,3),
  (41,'marpri01',3,84.00,252.00,3),
  (41,'posdan03',1,133.00,133.00,1),
  (41,'maribe02',5,61.00,305.00,5),
  (41,'maribe01',25,73.00,1825.00,25),
  (41,'queama03',1,112.00,112.00,1),
  (41,'bebbon01',1,89.00,89.00,1),
  (42,'yogdan05',5,180.00,900.00,5),
  (42,'geldan01',3,115.00,345.00,3),
  (42,'yogdan01',2,95.00,190.00,2),
  (42,'maribe01',15,73.00,1095.00,15),
  (42,'maribe02',15,61.00,915.00,15),
  (42,'cregin01',5,69.00,345.00,5),
  (42,'queraa01',2,298.00,596.00,2),
  (42,'quechi01',3,345.00,1035.00,3),
  (43,'bebfru01',50,39.50,1975.00,50),
  (43,'yogdan03',40,143.00,5720.00,40),
  (43,'crealp01',20,116.80,2336.00,20),
  (43,'crealp02',20,261.80,5236.00,20),
  (43,'crealp03',10,261.80,2618.00,10),
  (43,'yogdan05',10,180.00,1800.00,10),
  (43,'yogdan01',5,95.00,475.00,5),
  (43,'yogdan08',3,160.00,480.00,3),
  (43,'posdan03',4,133.00,532.00,4),
  (44,'geldan01',3,115.00,345.00,3),
  (44,'yogdan01',2,95.00,190.00,2),
  (44,'posdan02',2,133.00,266.00,2),
  (44,'posdan03',1,133.00,133.00,1),
  (45,'yogdan05',20,178.00,3560.00,20),
  (45,'yogdan08',5,155.00,775.00,5),
  (45,'posdan01',3,133.00,399.00,3),
  (45,'yogbon01',3,169.20,507.60,3),
  (45,'maribe02',5,61.00,305.00,5),
  (46,'yogdan05',30,179.00,5370.00,30),
  (47,'crelal03',30,110.00,3300.00,30),
  (47,'yogalp01',10,62.50,625.00,10),
  (48,'yogdan05',20,180.00,3600.00,20),
  (48,'yogdan01',10,95.00,950.00,10),
  (48,'posdan01',2,133.00,266.00,2),
  (48,'geldan01',5,115.00,575.00,5),
  (48,'posdan03',5,133.00,665.00,5),
  (48,'bebbon01',10,89.00,890.00,10),
  (48,'bebbon02',10,68.00,680.00,10),
  (48,'bebbon03',5,96.00,480.00,5),
  (48,'bebbon04',10,66.00,660.00,10),
  (48,'manchi01',5,95.50,477.50,5),
  (48,'manchi02',5,85.00,425.00,5),
  (48,'maribe01',100,73.00,7300.00,100),
  (48,'toscha01',15,150.00,2250.00,15),
  (48,'quechi01',5,345.00,1725.00,5),
  (48,'quelca01',5,225.00,1125.00,5),
  (49,'yogdan03',20,143.00,2860.00,20),
  (49,'yogdan09',3,178.00,534.00,3),
  (49,'posdan02',2,133.00,266.00,2),
  (49,'manchi02',5,85.00,425.00,5),
  (50,'crelal03',2,110.00,220.00,2),
  (50,'yogdan03',1,143.00,143.00,1),
  (51,'toscha01',5,150.00,750.00,5),
  (52,'crelal01',5,110.00,550.00,5),
  (52,'posdan03',2,133.00,266.00,2),
  (52,'bebbon01',10,89.00,890.00,10),
  (52,'bebbon02',10,68.00,680.00,10),
  (52,'manchi01',5,95.50,477.50,5),
  (52,'manchi04',10,196.00,1960.00,10),
  (52,'maribe01',30,73.00,2190.00,30),
  (52,'maribe02',20,61.00,1220.00,20),
  (53,'bebbon02',1,68.00,68.00,1),
  (53,'bebbon01',1,89.00,89.00,1),
  (54,'queama03',1,112.00,112.00,1),
  (55,'yogdan03',20,143.00,2860.00,20),
  (55,'yogdan05',20,180.00,3600.00,20),
  (55,'yogdan01',5,95.00,475.00,5),
  (55,'posdan01',2,133.00,266.00,2),
  (55,'geldan01',15,115.00,1725.00,15),
  (55,'bebbon02',5,68.00,340.00,5),
  (55,'bebbon01',15,89.00,1335.00,15),
  (55,'yogbon01',2,169.20,338.40,2),
  (55,'maribe01',50,73.00,3650.00,50),
  (56,'manchi04',4,190.00,760.00,4),
  (57,'yogdan05',2,180.00,360.00,2),
  (57,'yogdan09',2,178.00,356.00,2),
  (57,'yogdan02',1,98.00,98.00,1),
  (57,'manchi04',1,196.00,196.00,1),
  (57,'maribe01',10,73.00,730.00,10),
  (57,'toscha01',2,149.00,298.00,2),
  (57,'bebfru01',5,39.50,197.50,5),
  (58,'manchi01',20,95.50,1910.00,20),
  (58,'toscha01',10,148.00,1480.00,10),
  (59,'toscar01',20,100.00,2000.00,20),
  (60,'bebbon02',5,68.00,340.00,5),
  (60,'bebbon01',5,89.00,445.00,5),
  (60,'toscha01',10,149.00,1490.00,10),
  (61,'crelal01',20,110.00,2200.00,20),
  (61,'crelal02',30,110.00,3300.00,30),
  (61,'crelal03',30,110.00,3300.00,30),
  (61,'crealp01',50,116.80,5840.00,50),
  (61,'crealp02',30,261.80,7854.00,30),
  (62,'yogdan05',10,180.00,1800.00,10),
  (62,'toscha01',10,150.00,1500.00,10),
  (63,'toscha01',25,148.00,3700.00,25),
  (63,'toscar01',40,100.00,4000.00,40),
  (63,'quechi01',10,345.00,3450.00,10),
  (64,'toscar01',60,100.00,6000.00,60),
  (65,'yogdan01',5,95.00,475.00,5),
  (65,'yogdan09',5,178.00,890.00,5),
  (65,'posdan03',2,133.00,266.00,2),
  (65,'cregin01',2,69.00,138.00,2),
  (65,'bebbon02',5,68.00,340.00,5),
  (66,'bebbon02',10,68.00,680.00,10),
  (66,'bebbon01',10,89.00,890.00,10),
  (66,'yogbon01',1,169.20,169.20,1),
  (66,'yogbon02',1,160.00,160.00,1),
  (67,'yogdan09',4,178.00,712.00,4),
  (68,'yogdan06',1,175.00,175.00,1),
  (69,'bebbon02',1,68.00,68.00,1),
  (69,'bebbon01',1,89.00,89.00,1),
  (70,'yogdan08',5,160.00,800.00,5),
  (71,'geldan01',9,115.00,1035.00,9),
  (71,'yogdan09',10,178.00,1780.00,10),
  (71,'posdan03',2,133.00,266.00,2),
  (72,'maribe01',40,73.00,2920.00,40),
  (72,'maribe02',20,61.00,1220.00,20),
  (72,'maribe04',10,174.00,1740.00,10),
  (72,'queama03',5,112.00,560.00,5),
  (72,'queraa01',5,298.00,1490.00,5),
  (73,'maribe01',10,73.00,730.00,10),
  (73,'maribe02',10,61.00,610.00,10),
  (74,'crealp01',50,116.00,5800.00,50),
  (74,'crealp02',30,260.00,7800.00,30),
  (74,'crealp03',11,260.00,2860.00,11),
  (74,'crelal01',15,107.00,1605.00,15),
  (75,'yogdan03',20,143.00,2860.00,20),
  (76,'maribe02',30,61.00,1830.00,30),
  (77,'posdan02',8,130.00,1040.00,8),
  (77,'posdan01',2,130.00,260.00,2),
  (77,'yogdan08',3,155.00,465.00,3),
  (77,'yogdan06',3,175.00,525.00,3),
  (78,'crealp01',10,116.80,1168.00,10),
  (78,'yogdan09',10,178.00,1780.00,10),
  (79,'toscar01',85,100.00,8500.00,85),
  (80,'bebbon01',3,89.00,267.00,3),
  (81,'queraa01',30,293.00,8790.00,30),
  (82,'yogdan03',10,143.00,1430.00,10),
  (82,'yogdan09',5,178.00,890.00,5),
  (82,'yogdan06',1,175.00,175.00,1),
  (82,'yogdan02',1,98.00,98.00,1),
  (83,'yogdan03',10,143.00,1430.00,10),
  (84,'yogdan05',10,180.00,1800.00,10),
  (84,'geldan01',3,115.00,345.00,3),
  (84,'maribe01',100,73.00,7300.00,100),
  (84,'cregin01',30,69.00,2070.00,30),
  (84,'queraa01',5,298.00,1490.00,5),
  (84,'bebbon02',25,68.00,1700.00,25),
  (84,'yogdan01',3,95.00,285.00,3),
  (84,'bebbon01',35,89.00,3115.00,35),
  (84,'yogbon01',7,169.20,1184.40,7),
  (84,'yogbon02',5,160.00,800.00,5),
  (85,'geldan01',3,115.00,345.00,3),
  (85,'yogdan01',2,95.00,190.00,2),
  (85,'posdan02',2,133.00,266.00,2),
  (85,'posdan03',1,133.00,133.00,1),
  (86,'bebfru01',50,41.00,2050.00,0),
  (86,'bebbot01',40,82.00,3280.00,0),
  (87,'bebfru01',50,39.50,1975.00,50),
  (87,'bebbot01',40,80.00,3200.00,40),
  (88,'yogdan09',1,178.00,178.00,1),
  (88,'PalAct01',10,190.00,1900.00,10),
  (88,'PalAct02',10,190.00,1900.00,10),
  (88,'PalAct03',20,286.00,5720.00,20),
  (89,'maribe01',20,73.00,1460.00,20),
  (89,'maribe02',6,61.00,366.00,6),
  (90,'yogdan08',1,160.00,160.00,1),
  (90,'bebbon01',10,89.00,890.00,10),
  (91,'bebbon02',5,68.00,340.00,5),
  (91,'bebbon01',15,89.00,1335.00,15),
  (91,'bebbon04',6,66.00,396.00,6),
  (91,'quechi01',5,345.00,1725.00,5),
  (91,'bebbot01',200,80.00,16000.00,200),
  (92,'crelal03',10,110.00,1100.00,10),
  (92,'yogdan03',2,143.00,286.00,2),
  (92,'yogdan05',3,180.00,540.00,3),
  (92,'bebbon03',2,96.00,192.00,2),
  (92,'toscha01',5,149.00,745.00,5),
  (92,'queraa01',2,298.00,596.00,2),
  (92,'quechi01',3,345.00,1035.00,3),
  (93,'bebfru01',100,39.50,3950.00,100),
  (93,'crelal03',50,108.00,5400.00,50),
  (94,'toscha01',25,148.00,3700.00,25),
  (94,'queama03',5,108.00,540.00,5),
  (95,'yogdan01',5,90.00,450.00,5),
  (95,'geldan01',15,115.00,1725.00,15),
  (96,'yogdan01',6,95.00,570.00,6),
  (96,'yogdan08',2,160.00,320.00,2),
  (96,'posdan01',2,133.00,266.00,2),
  (96,'geldan01',3,115.00,345.00,3),
  (97,'yogdan01',5,95.00,475.00,5),
  (97,'geldan01',15,115.00,1725.00,15),
  (98,'crealp01',10,116.80,1168.00,10),
  (99,'yogdan01',5,95.00,475.00,5),
  (99,'yogdan08',5,160.00,800.00,5),
  (99,'geldan01',10,115.00,1150.00,10),
  (99,'yogdan02',2,102.00,204.00,2),
  (99,'toscha01',20,150.00,3000.00,20),
  (99,'PalAct01',4,195.00,780.00,4),
  (100,'PalAct01',15,190.00,2850.00,15),
  (100,'PalAct02',15,190.00,2850.00,15),
  (100,'bebbot01',100,80.00,8000.00,100),
  (101,'crelal01',1,110.00,110.00,1),
  (101,'crelal02',2,110.00,220.00,2),
  (101,'crelal03',2,110.00,220.00,2),
  (101,'yogdan05',10,180.00,1800.00,10),
  (101,'yogdan02',2,102.00,204.00,2),
  (101,'bebbon02',5,68.00,340.00,5),
  (101,'manchi04',30,190.00,5700.00,30),
  (101,'bebbon01',5,89.00,445.00,5),
  (102,'maribe04',10,174.00,1740.00,10),
  (103,'bebbon01',5,89.00,445.00,5),
  (104,'queraa01',13,295.00,3835.00,13),
  (104,'yogalp01',3,60.00,180.00,3),
  (104,'maribe01',65,73.00,4745.00,65),
  (104,'maribe02',20,61.00,1220.00,20),
  (104,'maribe04',30,174.00,5220.00,30),
  (104,'bebbon02',2,68.00,136.00,2),
  (104,'cregin01',7,69.00,483.00,7),
  (104,'creran01',20,132.00,2640.00,20),
  (104,'bebbon01',1,89.00,89.00,1),
  (104,'queama03',1,112.00,112.00,1),
  (104,'manchi01',1,95.50,95.50,1),
  (104,'manchi02',1,85.00,85.00,1),
  (104,'crelal01',8,108.00,864.00,8),
  (104,'crelal03',50,108.00,5400.00,50),
  (105,'yogalp01',40,62.50,2500.00,40),
  (105,'yogdan09',5,178.00,890.00,5),
  (106,'maribe02',15,61.00,915.00,15),
  (106,'queama03',10,112.00,1120.00,10),
  (107,'yogdan05',10,180.00,1800.00,10),
  (107,'geldan01',6,115.00,690.00,6),
  (107,'yogdan01',5,95.00,475.00,5),
  (107,'yogdan08',2,160.00,320.00,2),
  (108,'quechi01',15,345.00,5175.00,15),
  (109,'crealp01',80,116.00,9280.00,80),
  (109,'crealp02',13,260.00,3380.00,13),
  (109,'crelal03',15,107.00,1605.00,15),
  (109,'yogdan05',62,178.00,11036.00,62),
  (109,'yogdan03',20,143.00,2860.00,20),
  (109,'geldan01',24,115.00,2760.00,24),
  (109,'yogdan01',12,93.00,1116.00,12),
  (109,'posdan01',3,130.00,390.00,3),
  (109,'yogdan09',15,170.00,2550.00,15),
  (109,'yogdan08',3,155.00,465.00,3),
  (109,'yogdan06',2,175.00,350.00,2),
  (109,'yogdan02',2,98.00,196.00,2),
  (109,'posdan03',1,130.00,130.00,1),
  (110,'geldan01',3,115.00,345.00,3),
  (110,'yogdan09',5,178.00,890.00,5),
  (110,'PalAct01',5,190.00,950.00,5),
  (110,'PalAct02',5,190.00,950.00,5),
  (111,'crelal03',5,110.00,550.00,5),
  (112,'bebbon01',2,89.00,178.00,2),
  (112,'bebbon02',2,68.00,136.00,2),
  (112,'marpri01',1,84.00,84.00,1),
  (113,'PalAct01',5,190.00,950.00,5),
  (113,'PalAct02',5,190.00,950.00,5),
  (113,'bebbot01',100,80.00,8000.00,100),
  (114,'yogdan03',40,143.00,5720.00,40),
  (114,'yogdan05',30,180.00,5400.00,30),
  (115,'PalAct01',5,190.00,950.00,5),
  (115,'PalAct02',5,190.00,950.00,5),
  (116,'bebbon01',10,89.00,890.00,10),
  (116,'bebbon02',5,68.00,340.00,5),
  (116,'bebbon03',1,96.00,96.00,1),
  (116,'bebbon04',5,66.00,330.00,5),
  (117,'manchi04',10,196.00,1960.00,10),
  (117,'cregin01',10,68.00,680.00,10),
  (117,'PalAct01',10,190.00,1900.00,10),
  (117,'PalAct02',10,190.00,1900.00,10),
  (118,'manchi01',10,95.50,955.00,10),
  (118,'manchi02',10,85.00,850.00,10),
  (119,'crealp01',2,116.80,233.60,2),
  (119,'yogdan03',10,143.00,1430.00,10),
  (119,'yogdan01',3,95.00,285.00,3),
  (119,'toscha01',10,148.00,1480.00,10),
  (119,'maribe04',20,178.00,3560.00,20),
  (119,'queraa01',10,298.00,2980.00,10),
  (119,'quechi01',5,345.00,1725.00,5),
  (119,'quelca01',2,225.00,450.00,2),
  (120,'bebbon01',10,89.00,890.00,10),
  (120,'yogbon01',2,169.20,338.40,2),
  (121,'yogdan05',20,180.00,3600.00,20),
  (121,'geldan01',6,115.00,690.00,6),
  (121,'yogdan01',5,95.00,475.00,5),
  (121,'posdan01',2,133.00,266.00,2),
  (121,'yogdan08',1,160.00,160.00,1),
  (121,'maribe01',20,73.00,1460.00,20),
  (121,'maribe04',5,178.00,890.00,5),
  (121,'quechi01',3,345.00,1035.00,3),
  (121,'queraa01',3,298.00,894.00,3),
  (121,'marpri01',3,84.00,252.00,3),
  (122,'yogdan05',3,180.00,540.00,3),
  (122,'queama03',10,112.00,1120.00,10),
  (122,'bebbon01',2,89.00,178.00,2),
  (122,'bebbon02',2,68.00,136.00,2),
  (123,'yogdan09',15,178.00,2670.00,15),
  (123,'cregin01',3,69.00,207.00,3),
  (123,'queama03',3,112.00,336.00,3),
  (124,'yogdan08',2,160.00,320.00,2),
  (124,'bebbon01',10,89.00,890.00,10),
  (125,'crelal02',87,107.00,9309.00,0);

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
  ('TNI920507GB8','TOSTIRICAS NIETO S.A DE C.V.','Priv. ceylan 45-A','Industrial Vallejo','Azcapotzalco','02300','Mexico D.F.','53687475','0445520731372','','','','Luis Maldonado Villegas',2,'',0.00,30,0.00,0.00,0.00,-172782.72,'2006-06-02',1),
  ('UNI9704247M2','UNIFOOS S.A DE C.V.','Poniente 122  -459','Industrial Vallejo','Azcapotzalco','02300','Mexico D.F.','53331200','0445518668248 ABRHAM','0445518668244 PICOS','','','ABRHAM    PICOS   ALBERTO  TOÑO',2,'',0.00,0,0.00,0.00,0.00,-78806.25,'2006-06-02',1),
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
  ('Carioca','Javier Vidal Mata','Cuautla','Cuatla','Morelos','000','Morelos','017353578634','','','','','Jose Luis',1,'',30000.00,2,0.00,0.00,0.00,10525.00,'2006-06-30',1),
  ('Charra','Charra','Privada Ceylan 45','Industrial Vallejo','Industial Vallejo','000','Mexico D.F.','0445520731372','','','','','Luis',1,'',15000.00,5,0.00,0.00,0.00,15000.00,'2006-06-30',1),
  ('Mario','Mario Figueroa Mundo','Taxco','Taxco','Taxco','000','Taxco Guerrero','017626253992','','','','','Mario',1,'',150000.00,5,0.00,0.00,0.00,150000.00,'2006-06-30',1),
  ('Chispeadero','Chispeadero','Pasillo G-H Local-47','CEDA','Iztapalapa','09040','Mexico D.F.','5694','','','','','Chispeadero',1,'',1000.00,2,0.00,0.00,0.00,1000.00,'2006-06-30',1),
  ('Retonito','Rosalva Cano Pozos','Pasillo 3 Local 80','CEDA','Iztapalapa','09040','Mexico D.F.','5600 2607','','','','','Rosalva',1,'',50000.00,15,0.00,0.00,0.00,50000.00,'2006-06-30',1),
  ('Ramirez','Ramirez','Pasillo 2 Local I-J','CEDA','Iztapalapa','09040','Mexico D.F.','5640 9230','','','','','Arturo',1,'',3000.00,8,0.00,0.00,0.00,3000.00,'2006-06-30',1),
  ('Rene','Rene Espinoza','G 75','CEDA','Iztapalapa','09040','Mexico D,F','56409887','','','','','Rene',1,'',40000.00,8,0.00,0.00,0.00,40000.00,'2006-06-30',1),
  ('Texana','La Texana S.A de C.V.','H 52-54','CEDA','Iztapalapa','09040','Mexico D.F.','56002034','56940238','','','','Alfredo',1,'',30000.00,8,0.00,0.00,0.00,30000.00,'2006-06-30',1),
  ('CLZ040329SD5','Comercializadora la Laguna De Zumpango S.A de C.V','Calle Braniff  s/n','B.de santiago 1ra seccion','','55600','Estado de Mexico','015919173541','','','','','Marco y Joaquin',2,'',500000.00,5,0.00,0.00,0.00,500000.00,'2006-07-04',1),
  ('CLD0507145H6','Comercializadora de Lacteos y Derivados S.A de C.V.','Lazaro Cardenas #185 Parque Industrial Lagunero','Canatatlan','Valle Guadina','35077','Durango','S/N','','','','','Rostro',2,'',200000.00,15,0.00,0.00,0.00,200000.00,'2006-07-04',1),
  ('Yordy','Yordy','Bodega H-32b','CEDA','Iztapalapa','09040','Mexico D.F.','s/n','','','','','Fausto y Yordy',1,'',200000.00,15,0.00,0.00,0.00,200000.00,'2006-07-13',1),
  ('DCL0402164N0','DeinneClub,S.A.DEC.V.','Guanajuato No.240 Int.1','Roma','Cuahutemoc','06700','Mexico,D.F.','57119706','91525620','','','','Fernando y Roberto',2,'',300000.00,5,0.00,0.00,0.00,300000.00,'2006-07-19',1);

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
  ('bety','2431','Admin','Beatriz','Vazquez','Perez','Gerente','Admin','1'),
  ('CHAVA','CHAVA','Simple','Salvador','Gonzalez','Plascencia','Agente','Ventas','1'),
  ('marcial','marcial','Simple','marcial','marcial','marcial','Repartidor','Ventas','1'),
  ('piero','1127','Admin','Piero','Gonzalez','Serrano','Gerente','Admin','1'),
  ('Piero1','piero1','Simple','Piero','Gonzalez','Serrano','Agente','Ventas','1'),
  ('salvador','chavol','Admin','Salvador','Gonzalez','Plascencia','Gerente','Admin','1');

COMMIT;

#
# Data for the `ventas` table  (LIMIT 0,500)
#

# claveVenta:3:49667
# claveCliente:253:0
# fechaAlta:10:128
# fechaEntrega:10:128
# observaciones:253:0
# subtotal:5:32768
# iva:5:32768
# total:5:32768
# activo:3:32768
# tipo:3:32768
# factura:253:0
# remision:3:32768
# Entrega:3:32768
# usuario:253:0
# pago:3:32768
# repartidor:253:0

INSERT INTO `ventas` (`claveVenta`, `claveCliente`, `fechaAlta`, `fechaEntrega`, `observaciones`, `subtotal`, `iva`, `total`, `activo`, `tipo`, `factura`, `remision`, `Entrega`, `usuario`, `pago`, `repartidor`) VALUES 
  (1,'CME9109236F1','2006-08-01','2006-08-01',' Repartidor: marcial',1720.00,0.00,1720.00,0,2,'',1,2,'piero',0,'marcial'),
  (2,'Normita','2006-08-02','2006-08-02',' Repartidor: marcial',11890.00,0.00,11890.00,1,2,'',2,2,'piero',2,'marcial'),
  (3,'La Guera','2006-08-02','2006-08-02',' Repartidor: marcial',1780.00,0.00,1780.00,1,2,'',3,2,'piero',2,'marcial'),
  (4,'melo','2006-08-02','2006-08-02',' Repartidor: marcial',2477.00,0.00,2477.00,1,2,'',4,2,'piero',2,'marcial'),
  (5,'Lupita','2006-08-02','2006-08-02',' Repartidor: marcial',12819.00,0.00,12819.00,1,2,'',5,2,'piero',0,'marcial'),
  (6,'Ruiseñor','2006-08-02','2006-08-02',' Repartidor: marcial',2548.20,0.00,2548.20,1,2,'',6,2,'piero',0,'marcial'),
  (7,'Retoño','2006-08-02','2006-08-02',' Repartidor: marcial',7900.00,1185.00,7900.00,1,2,'',7,2,'piero',0,'marcial'),
  (8,'Yoely','2006-08-02','2006-08-02',' Repartidor: marcial',441.00,0.00,441.00,1,2,'',8,2,'piero',0,'marcial'),
  (9,'Retoñito','2006-08-02','2006-08-02',' Repartidor: marcial',16026.00,1185.00,16026.00,1,2,'',9,2,'piero',0,'marcial'),
  (10,'Bonanza','2006-08-02','2006-08-02',' Repartidor: marcial',3546.00,0.00,3546.00,1,2,'',10,2,'piero',2,'marcial'),
  (11,'Erik','2006-08-02','2006-08-02',' Repartidor: marcial',552.00,59.25,552.00,1,2,'',11,2,'piero',2,'marcial'),
  (12,'Super Palmas','2006-08-02','2006-08-02',' Repartidor: marcial',2085.00,177.75,2085.00,1,2,'',12,2,'piero',0,'marcial'),
  (13,'Juan Munoz','2006-08-02','2006-08-02',' Repartidor: marcial',19181.00,0.00,19181.00,1,2,'',13,2,'piero',2,'marcial'),
  (14,'Teresita','2006-08-02','2006-08-02',' Repartidor: marcial',6730.00,0.00,6730.00,1,2,'',14,2,'piero',0,'marcial'),
  (15,'Rigo','2006-08-02','2006-08-02',' Repartidor: marcial',5000.00,0.00,5000.00,1,2,'',15,2,'piero',0,'marcial'),
  (16,'Ramirez','2006-08-02','2006-08-02',' Repartidor: marcial',1317.00,0.00,1317.00,1,2,'',16,2,'piero',0,'marcial'),
  (17,'Rojas','2006-08-02','2006-08-02',' Repartidor: marcial',74.00,0.00,74.00,1,2,'',17,2,'piero',2,'marcial'),
  (18,'toro','2006-08-02','2006-08-02',' Repartidor: marcial',157.00,0.00,157.00,1,2,'',18,2,'piero',2,'marcial'),
  (19,'Moro','2006-08-02','2006-08-02',' Repartidor: marcial',1975.00,296.25,1975.00,1,2,'',19,2,'piero',0,'marcial'),
  (20,'Ranchito','2006-08-02','2006-08-02',' Repartidor: marcial',3982.00,0.00,3982.00,1,2,'',20,2,'piero',2,'marcial'),
  (21,'Josè Manuel','2006-08-02','2006-08-02',' Repartidor: marcial',445.00,0.00,445.00,1,2,'',21,2,'piero',0,'marcial'),
  (22,'Esperanza','2006-08-02','2006-08-02',' Repartidor: marcial',23682.00,0.00,23682.00,1,2,'',22,2,'piero',0,'marcial'),
  (23,'Rosa de oro','2006-08-02','2006-08-02',' Repartidor: marcial',1185.00,177.75,1185.00,1,2,'',23,2,'piero',0,'marcial'),
  (24,'El Pico de O','2006-08-02','2006-08-02',' Repartidor: marcial',1003.20,0.00,1003.20,1,2,'',24,2,'piero',2,'marcial'),
  (25,'Laura','2006-08-02','2006-08-02',' Repartidor: marcial',6809.00,474.00,6809.00,1,2,'',25,2,'piero',0,'marcial'),
  (26,'Palomas','2006-08-02','2006-08-02',' Repartidor: marcial',3950.00,592.50,3950.00,1,2,'',26,2,'piero',0,'marcial'),
  (27,'Vanguardia','2006-08-02','2006-08-02',' Repartidor: marcial',1975.00,296.25,1975.00,1,2,'',27,2,'piero',2,'marcial'),
  (28,'Barca','2006-08-02','2006-08-02',' Repartidor: marcial',4949.00,0.00,4949.00,1,2,'',28,2,'piero',0,'marcial'),
  (29,'Sr. Zarco','2006-08-02','2006-08-02',' Repartidor: marcial',16609.00,0.00,16609.00,1,2,'',29,2,'piero',0,'marcial'),
  (30,'AAGF740817Q38','2006-08-02','2006-08-02',' Repartidor: marcial',2275.00,0.00,2275.00,1,1,'1',0,2,'piero',0,'marcial'),
  (31,'CSS850907851','2006-08-02','2006-08-02',' Repartidor: marcial',4050.00,0.00,4050.00,1,1,'2',0,2,'piero',0,'marcial'),
  (32,'LSF050118U75','2006-08-02','2006-08-02',' Repartidor: marcial',5000.00,0.00,5000.00,1,1,'3',0,2,'BETY',0,'marcial'),
  (33,'MAVP601008RTA','2006-08-02','2006-08-02',' Repartidor: marcial',8935.00,0.00,8935.00,1,1,'4',0,2,'piero',0,'marcial'),
  (34,'HESJ440722S33','2006-08-02','2006-08-02',' Repartidor: marcial',7385.00,0.00,7385.00,1,1,'5',0,2,'piero',0,'marcial'),
  (35,'CSL0309122V5','2006-08-02','2006-08-02',' Repartidor: marcial',5140.00,296.25,5140.00,1,1,'6',0,2,'piero',0,'marcial'),
  (36,'CLA830615UC2','2006-08-02','2006-08-02',' Repartidor: marcial',801.00,0.00,801.00,0,1,'7',0,2,'piero',0,'marcial'),
  (37,'DCP040210J5A','2006-08-02','2006-08-02',' Repartidor: marcial',534.00,0.00,534.00,1,1,'8',0,2,'BETY',0,'marcial'),
  (38,'HESJ501028FJ3','2006-08-02','2006-08-02',' Repartidor: marcial',1875.00,0.00,1875.00,1,1,'9',0,2,'piero',0,'marcial'),
  (39,'DCN040210NJO','2006-08-02','2006-08-02',' Repartidor: marcial',4140.00,296.25,4140.00,1,1,'10',0,2,'piero',0,'marcial'),
  (40,'PAPE720521P11','2006-08-02','2006-08-02',' Repartidor: marcial',2618.00,0.00,2618.00,1,1,'11',0,2,'piero',0,'marcial'),
  (41,'Juan Munoz','2006-08-02','2006-08-02',' Repartidor: marcial',3141.00,0.00,3141.00,1,2,'',30,2,'BETY',2,'marcial'),
  (42,'AEVJ741206QJ3','2006-08-02','2006-08-02',' Repartidor: marcial',5421.00,0.00,5421.00,1,1,'12',0,2,'piero',2,'marcial'),
  (43,'TEX931122JL3','2006-08-02','2006-08-02',' Repartidor: marcial',21172.00,296.25,21172.00,1,1,'13',0,2,'BETY',0,'marcial'),
  (44,'CLA830615UC2','2006-08-03','2006-08-03',' Repartidor: marcial',934.00,0.00,934.00,0,1,'16062',0,2,'piero',0,'marcial'),
  (45,'Normita','2006-08-03','2006-08-03',' Repartidor: marcial',5546.60,0.00,5546.60,1,2,'',31,2,'piero',0,'marcial'),
  (46,'Galdino','2006-08-03','2006-08-03',' Repartidor: marcial',5370.00,0.00,5370.00,1,2,'',32,2,'piero',0,'marcial'),
  (47,'Rancherita','2006-08-03','2006-08-03',' Repartidor: marcial',3925.00,0.00,3925.00,1,2,'',33,2,'piero',0,'marcial'),
  (48,'Retoño','2006-08-03','2006-08-03',' Repartidor: marcial',22068.50,0.00,22068.50,1,2,'',34,2,'piero',0,'marcial'),
  (49,'Yoely','2006-08-03','2006-08-03',' Repartidor: marcial',4085.00,0.00,4085.00,1,2,'',35,2,'piero',0,'marcial'),
  (50,'Erik','2006-08-03','2006-08-03',' Repartidor: marcial',363.00,0.00,363.00,1,2,'',36,2,'piero',2,'marcial'),
  (51,'Super Palmas','2006-08-03','2006-08-03',' Repartidor: marcial',750.00,0.00,750.00,1,2,'',37,2,'piero',0,'marcial'),
  (52,'Retoñito','2006-08-03','2006-08-03',' Repartidor: marcial',8233.50,0.00,8233.50,1,2,'',38,2,'piero',0,'marcial'),
  (53,'Rojas','2006-08-03','2006-08-03',' Repartidor: marcial',157.00,0.00,157.00,1,2,'',39,2,'piero',2,'marcial'),
  (54,'Rojas','2006-08-03','2006-08-03',' Repartidor: marcial',112.00,0.00,112.00,1,2,'',40,2,'piero',2,'marcial'),
  (55,'Esperanza','2006-08-03','2006-08-03',' Repartidor: marcial',14589.40,0.00,14589.40,1,2,'',41,2,'piero',0,'marcial'),
  (56,'Ruiseñor','2006-08-03','2006-08-03',' Repartidor: marcial',760.00,0.00,760.00,1,2,'',42,2,'piero',0,'marcial'),
  (57,'celestino','2006-08-03','2006-08-03',' Repartidor: marcial',2235.50,29.63,2235.50,1,2,'',43,2,'piero',0,'marcial'),
  (58,'Union','2006-08-03','2006-08-03',' Repartidor: marcial',3390.00,0.00,3390.00,1,2,'',44,2,'piero',0,'marcial'),
  (59,'Chucho','2006-08-03','2006-08-03',' Repartidor: marcial',2000.00,0.00,2000.00,1,2,'',45,2,'piero',0,'marcial'),
  (60,'Moro','2006-08-03','2006-08-03',' Repartidor: marcial',2275.00,0.00,2275.00,1,2,'',46,2,'piero',0,'marcial'),
  (61,'Especial','2006-08-03','2006-08-03',' Repartidor: marcial',22494.00,0.00,22494.00,1,2,'',47,2,'salvador',0,'marcial'),
  (62,'Ranchito','2006-08-03','2006-08-03',' Repartidor: marcial',3300.00,0.00,3300.00,1,2,'',48,2,'salvador',0,'marcial'),
  (63,'Josè Manuel','2006-08-03','2006-08-03',' Repartidor: marcial',11150.00,0.00,11150.00,1,2,'',49,2,'salvador',0,'marcial'),
  (64,'D`MargònZ','2006-08-03','2006-08-03',' Repartidor: marcial',6000.00,0.00,6000.00,1,2,'',50,2,'salvador',0,'marcial'),
  (65,'Surtidor','2006-08-03','2006-08-03',' Repartidor: marcial',2109.00,0.00,2109.00,1,2,'',51,2,'salvador',0,'marcial'),
  (66,'Rosa de oro','2006-08-03','2006-08-03',' Repartidor: marcial',1899.20,0.00,1899.20,1,2,'',52,2,'salvador',2,'marcial'),
  (67,'AARZ770413CVA','2006-08-03','2006-08-03',' Repartidor: marcial',712.00,0.00,712.00,1,2,'',53,2,'salvador',0,'marcial'),
  (68,'Ramirez','2006-08-03','2006-08-03',' Repartidor: marcial',175.00,0.00,175.00,1,2,'',54,2,'salvador',0,'marcial'),
  (69,'Rojas','2006-08-03','2006-08-03',' Repartidor: marcial',157.00,0.00,157.00,0,2,'',55,2,'salvador',0,'marcial'),
  (70,'Retoño','2006-08-03','2006-08-03',' Repartidor: marcial',800.00,0.00,800.00,1,2,'',56,2,'salvador',0,'marcial'),
  (71,'CLA830615UC2','2006-08-03','2006-08-03',' Repartidor: marcial',3081.00,0.00,3081.00,1,1,'16066',0,2,'piero',0,'marcial'),
  (72,'PAPE720521P11','2006-08-03','2006-08-03',' Repartidor: marcial',7930.00,0.00,7930.00,1,1,'16067',0,2,'piero',0,'marcial'),
  (73,'DCP040210F26','2006-08-03','2006-08-03',' Repartidor: marcial',1340.00,0.00,1340.00,1,1,'16068',0,2,'piero',0,'marcial'),
  (74,'CTC900503Q24','2006-08-03','2006-08-03',' Repartidor: marcial',18065.00,0.00,18065.00,1,1,'16070',0,2,'piero',0,'marcial'),
  (75,'AAGF740817Q38','2006-08-03','2006-08-03',' Repartidor: marcial',2860.00,0.00,2860.00,1,1,'16071',0,2,'piero',0,'marcial'),
  (76,'LSF050118U75','2006-08-03','2006-08-03',' Repartidor: marcial',1830.00,0.00,1830.00,1,1,'16072',0,2,'piero',0,'marcial'),
  (77,'CSS850907851','2006-08-03','2006-08-03',' Repartidor: marcial',2290.00,0.00,2290.00,1,1,'16073',0,2,'piero',0,'marcial'),
  (78,'HESJ440722S33','2006-08-03','2006-08-03',' Repartidor: marcial',2948.00,0.00,2948.00,1,1,'16074',0,2,'piero',0,'marcial'),
  (79,'TEX931122JL3','2006-08-03','2006-08-03',' Repartidor: marcial',8500.00,0.00,8500.00,1,1,'16075',0,2,'piero',0,'marcial'),
  (80,'DCH040220NMA','2006-08-03','2006-08-03',' Repartidor: marcial',267.00,0.00,267.00,1,1,'16076',0,2,'piero',0,'marcial'),
  (81,'DMA0106263S9','2006-08-03','2006-08-03',' Repartidor: marcial',8790.00,0.00,8790.00,1,1,'16077',0,2,'piero',0,'marcial'),
  (82,'CLA830615UC2','2006-08-03','2006-08-03',' Repartidor: marcial',2593.00,0.00,2593.00,1,1,'16078',0,2,'piero',0,'marcial'),
  (83,'CSL0309122V5','2006-08-03','2006-08-03',' Repartidor: marcial',1430.00,0.00,1430.00,1,1,'16080',0,2,'piero',0,'marcial'),
  (84,'AEVJ741206QJ3','2006-08-03','2006-08-03',' Repartidor: marcial',20089.40,0.00,20089.40,1,2,'',57,2,'piero',0,'marcial'),
  (85,'CLA830615UC2','2006-08-03','2006-08-02',' Repartidor: marcial',934.00,0.00,934.00,1,1,'16062',0,2,'piero',0,'marcial'),
  (86,'Rancherita','2006-08-04','2006-08-04','',5330.00,799.50,5330.00,0,2,'',58,0,'salvador',0,''),
  (87,'Rancherita','2006-08-04','2006-08-04',' Repartidor: marcial',5175.00,776.25,5175.00,1,2,'',59,2,'salvador',0,'marcial'),
  (88,'Retoñito','2006-08-04','2006-08-04',' Repartidor: marcial',9698.00,0.00,9698.00,1,2,'',60,2,'salvador',0,'marcial'),
  (89,'Laura','2006-08-04','2006-08-04',' Repartidor: marcial',1826.00,0.00,1826.00,1,2,'',61,2,'salvador',0,'marcial'),
  (90,'Ramirez','2006-08-04','2006-08-04',' Repartidor: marcial',1050.00,0.00,1050.00,0,2,'',62,2,'salvador',0,'marcial'),
  (91,'Esperanza','2006-08-04','2006-08-04',' Repartidor: marcial',19796.00,2400.00,19796.00,1,2,'',63,2,'salvador',0,'marcial'),
  (92,'Bonanza','2006-08-04','2006-08-04',' Repartidor: marcial',4494.00,0.00,4494.00,1,2,'',64,2,'salvador',0,'marcial'),
  (93,'Lupita','2006-08-04','2006-08-04',' Repartidor: marcial',9350.00,592.50,9350.00,1,2,'',65,2,'salvador',0,'marcial'),
  (94,'Union','2006-08-04','2006-08-04',' Repartidor: marcial',4240.00,0.00,4240.00,1,2,'',66,2,'salvador',0,'marcial'),
  (95,'Normita','2006-08-04','2006-08-04',' Repartidor: marcial',2175.00,0.00,2175.00,0,2,'',67,2,'salvador',0,'marcial'),
  (96,'Especial','2006-08-04','2006-08-04',' Repartidor: marcial',1501.00,0.00,1501.00,1,2,'',68,2,'salvador',0,'marcial'),
  (97,'Normita','2006-08-04','2006-08-04',' Repartidor: marcial',2200.00,0.00,2200.00,1,2,'',69,2,'salvador',0,'marcial'),
  (98,'Josè Manuel','2006-08-04','2006-08-04',' Repartidor: marcial',1168.00,0.00,1168.00,1,2,'',70,2,'salvador',0,'marcial'),
  (99,'Surtidor','2006-08-04','2006-08-04',' Repartidor: marcial',6409.00,0.00,6409.00,1,2,'',71,2,'salvador',0,'marcial'),
  (100,'Retoño','2006-08-04','2006-08-04',' Repartidor: marcial',13700.00,1200.00,13700.00,0,2,'',72,2,'salvador',0,'marcial'),
  (101,'Ruiseñor','2006-08-04','2006-08-04',' Repartidor: marcial',9039.00,0.00,9039.00,1,2,'',73,2,'salvador',0,'marcial'),
  (102,'Moro','2006-08-04','2006-08-04',' Repartidor: marcial',1740.00,0.00,1740.00,1,2,'',74,2,'salvador',0,'marcial'),
  (103,'Yovany','2006-08-04','2006-08-04',' Repartidor: marcial',445.00,0.00,445.00,1,2,'',75,2,'bety',2,'marcial'),
  (104,'Juan Munoz','2006-08-04','2006-08-04',' Repartidor: marcial',25104.50,0.00,25104.50,1,2,'',76,2,'bety',1,'marcial'),
  (105,'HESJ501028FJ3','2006-08-04','2006-08-04',' Repartidor: marcial',3390.00,0.00,3390.00,1,1,'16084',0,2,'bety',0,'marcial'),
  (106,'DCH040220NMA','2006-08-04','2006-08-04',' Repartidor: marcial',2035.00,0.00,2035.00,1,1,'16085',0,2,'bety',0,'marcial'),
  (107,'AAGF740817Q38','2006-08-04','2006-08-04',' Repartidor: marcial',3285.00,0.00,3285.00,1,1,'16086',0,2,'bety',0,'marcial'),
  (108,'DMA0106263S9','2006-08-04','2006-08-04',' Repartidor: marcial',5175.00,0.00,5175.00,1,1,'16091',0,2,'bety',0,'marcial'),
  (109,'CSS850907851','2006-08-04','2006-08-04',' Repartidor: marcial',36118.00,0.00,36118.00,1,1,'16089',0,2,'bety',0,'marcial'),
  (110,'LSF050118U75','2006-08-04','2006-08-04',' Repartidor: marcial',3135.00,0.00,3135.00,1,1,'16090',0,2,'bety',0,'marcial'),
  (111,'DCP040210J5A','2006-08-04','2006-08-04',' Repartidor: marcial',550.00,0.00,550.00,1,1,'16093',0,2,'bety',0,'marcial'),
  (112,'Juan Munoz','2006-08-04','2006-08-04',' Repartidor: marcial',398.00,0.00,398.00,1,2,'',77,2,'bety',2,'marcial'),
  (113,'Retoño','2006-08-04','2006-08-04',' Repartidor: marcial',9900.00,1200.00,9900.00,1,2,'',78,2,'salvador',0,'marcial'),
  (114,'CSC880523NA1','2006-08-04','2006-08-04',' Repartidor: marcial',11120.00,0.00,11120.00,1,1,'16082',0,2,'bety',0,'marcial'),
  (115,'L # 45','2006-08-04','2006-08-04',' Repartidor: marcial',1900.00,0.00,1900.00,1,2,'',79,2,'salvador',0,'marcial'),
  (116,'CSL0309122V5','2006-08-04','2006-08-04',' Repartidor: marcial',1656.00,0.00,1656.00,1,1,'16094',0,2,'bety',0,'marcial'),
  (117,'HESJ440722S33','2006-08-04','2006-08-04',' Repartidor: marcial',6440.00,0.00,6440.00,1,1,'16095',0,2,'bety',0,'marcial'),
  (118,'MAVP601008RTA','2006-08-04','2006-08-04',' Repartidor: marcial',1805.00,0.00,1805.00,1,1,'16097',0,2,'bety',0,'marcial'),
  (119,'GAAY8110197E3','2006-08-04','2006-08-04',' Repartidor: marcial',12143.60,0.00,12143.60,1,1,'16098',0,2,'bety',2,'marcial'),
  (120,'PAPE720521P11','2006-08-04','2006-08-04',' Repartidor: marcial',1228.40,0.00,1228.40,1,1,'16096',0,2,'bety',0,'marcial'),
  (121,'AEVJ741206QJ3','2006-08-04','2006-08-04',' Repartidor: marcial',9722.00,0.00,9722.00,1,1,'16099',0,2,'bety',2,'marcial'),
  (122,'DCS0402101N9','2006-08-04','2006-08-04',' Repartidor: marcial',1974.00,0.00,1974.00,1,1,'16100',0,2,'bety',0,'marcial'),
  (123,'CSL0309122V5','2006-08-04','2006-08-04',' Repartidor: marcial',3213.00,0.00,3213.00,1,1,'16101',0,2,'bety',0,'marcial'),
  (124,'Ramirez','2006-08-04','2006-08-04',' Repartidor: marcial',1210.00,0.00,1210.00,1,2,'',80,2,'bety',0,'marcial'),
  (125,'DCL0402164N0','2006-08-05','2006-08-05','',9309.00,0.00,9309.00,0,2,'',81,0,'salvador',0,'');

COMMIT;

