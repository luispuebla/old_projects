# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : vasago


SET FOREIGN_KEY_CHECKS=0;

USE `vasago`;

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

