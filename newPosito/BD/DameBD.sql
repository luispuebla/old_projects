# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : nbonanza


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS nbonanza;

CREATE DATABASE nbonanza;

USE nbonanza;

#
# Structure for the `abono_general` table : 
#

DROP TABLE IF EXISTS abono_general;

CREATE TABLE abono_general (
  rfc varchar(13) collate latin1_spanish_ci default NULL,
  nombreCliente varchar(45) collate latin1_spanish_ci default NULL,
  montoDisponible double(9,2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `abonos` table : 
#

DROP TABLE IF EXISTS abonos;

CREATE TABLE abonos (
  claveAbono int(8) NOT NULL auto_increment,
  rfc varchar(13) collate latin1_spanish_ci default NULL,
  nombreCliente varchar(45) collate latin1_spanish_ci default NULL,
  fecha date default NULL,
  monto double(9,2) default NULL,
  formatoPago int(1) default NULL,
  referenciaCobro varchar(40) collate latin1_spanish_ci default NULL,
  cobro varchar(10) collate latin1_spanish_ci default NULL,
  estatus int(1) default NULL,
  PRIMARY KEY  (claveAbono),
  UNIQUE KEY claveAbono (claveAbono)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `automerma` table : 
#

DROP TABLE IF EXISTS automerma;

CREATE TABLE automerma (
  anio int(4) unsigned NOT NULL,
  mes int(2) unsigned NOT NULL,
  fecha date default NULL,
  activo int(1) unsigned default '1',
  PRIMARY KEY  (anio,mes)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `aval_por_documento` table : 
#

DROP TABLE IF EXISTS aval_por_documento;

CREATE TABLE aval_por_documento (
  ClaveOrden int(11) NOT NULL,
  ClaveProducto int(6) default NULL,
  ConsecutivoRecepcion int(6) unsigned default NULL,
  Adquisicion int(1) default '1',
  Tipo int(1) default NULL,
  Cantidad double(10,3) default NULL,
  DocAval varchar(11) collate latin1_spanish_ci default NULL,
  TipoDocAval int(1) default NULL,
  FechaDocAval date default NULL,
  Estatus int(1) default NULL,
  KEY ClaveOrden (ClaveOrden)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `avisos` table : 
#

DROP TABLE IF EXISTS avisos;

CREATE TABLE avisos (
  automatico int(6) NOT NULL auto_increment,
  frase varchar(200) collate latin1_spanish_ci default NULL,
  activo int(1) default '0',
  PRIMARY KEY  (automatico),
  UNIQUE KEY automatico (automatico)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `baja_prestamo` table : 
#

DROP TABLE IF EXISTS baja_prestamo;

CREATE TABLE baja_prestamo (
  claveBajaP int(8) NOT NULL auto_increment,
  clavePrestamo int(11) default NULL,
  fechaBaja date default NULL,
  horaBaja time default NULL,
  cancelo varchar(10) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (claveBajaP),
  UNIQUE KEY claveBajaP (claveBajaP)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `cancelacion` table : 
#

DROP TABLE IF EXISTS cancelacion;

CREATE TABLE cancelacion (
  claveCancela int(10) NOT NULL auto_increment,
  numTicket int(10) NOT NULL default '0',
  fechaTicket date default NULL,
  tipoTicket int(1) unsigned default NULL,
  cajeroTicket varchar(20) collate latin1_spanish_ci default NULL,
  montoTotal double(9,2) default NULL,
  fechaBaja date default NULL,
  horaBaja time default NULL,
  PRIMARY KEY  (claveCancela)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `clientes` table : 
#

DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
  rfc varchar(13) collate latin1_spanish_ci NOT NULL default '',
  curp varchar(20) collate latin1_spanish_ci NOT NULL default '',
  nombre varchar(45) collate latin1_spanish_ci NOT NULL default '',
  direccion varchar(35) collate latin1_spanish_ci NOT NULL default '',
  colonia varchar(25) collate latin1_spanish_ci default NULL,
  delegacion varchar(20) collate latin1_spanish_ci default NULL,
  cp varchar(5) collate latin1_spanish_ci default NULL,
  ciudad varchar(20) collate latin1_spanish_ci default NULL,
  contacto varchar(40) collate latin1_spanish_ci default NULL,
  tel1 varchar(12) collate latin1_spanish_ci default NULL,
  tel2 varchar(12) collate latin1_spanish_ci default NULL,
  alta date default NULL,
  tipoCliente int(1) NOT NULL default '0',
  credito double(9,2) default NULL,
  tiempoCredito int(2) default '0',
  saldo double(9,2) default NULL,
  bloqueoXPagoV int(1) default '0',
  activo int(1) default '1',
  PRIMARY KEY  (rfc,nombre)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `codigosb` table : 
#

DROP TABLE IF EXISTS codigosb;

CREATE TABLE codigosb (
  ID_Pro int(6) default NULL,
  codBarra varchar(15) collate latin1_spanish_ci default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `contenidoticket` table : 
#

DROP TABLE IF EXISTS contenidoticket;

CREATE TABLE contenidoticket (
  numTicket int(10) NOT NULL default '0',
  fechaRegistro date NOT NULL default '0000-00-00',
  horaRegistro time default NULL,
  ID_Pro int(6) NOT NULL default '0',
  claveVendedor int(4) NOT NULL default '0',
  tipoVenta int(1) NOT NULL default '0',
  tipoPrecio int(1) default NULL,
  precioVenta double(8,2) NOT NULL default '0.00',
  cantidadProducto double(8,3) default NULL,
  pesoEnPz double(8,3) default NULL,
  estatusPago int(1) default '0',
  precioAPagar double(8,2) NOT NULL default '0.00',
  estatusTicket int(1) default '0',
  fechaRealPago date default NULL,
  KEY numTicket (numTicket)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `creditos` table : 
#

DROP TABLE IF EXISTS creditos;

CREATE TABLE creditos (
  numTicket int(10) NOT NULL default '0',
  fechaCredito date default NULL,
  fechaAPagar date default NULL,
  rfc varchar(13) collate latin1_spanish_ci default NULL,
  nombreCliente varchar(45) collate latin1_spanish_ci default NULL,
  cantidadAPagar double(8,2) default NULL,
  factura int(1) default NULL,
  tipoCobro int(1) default NULL,
  referenciaCobro varchar(40) collate latin1_spanish_ci default NULL,
  usuario varchar(20) collate latin1_spanish_ci default NULL,
  fechaRealPago date default NULL,
  usuarioPago varchar(20) collate latin1_spanish_ci default NULL,
  estatusCredito int(1) default '0',
  activo int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `facturas` table : 
#

DROP TABLE IF EXISTS facturas;

CREATE TABLE facturas (
  claveOrden int(8) default NULL,
  docAval varchar(11) collate latin1_spanish_ci default NULL,
  tipoDoc int(1) default NULL,
  docPadre varchar(11) collate latin1_spanish_ci default NULL,
  fechaDoc date default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `facventas` table : 
#

DROP TABLE IF EXISTS facventas;

CREATE TABLE facventas (
  numFactura varchar(12) collate latin1_spanish_ci default NULL,
  tickets varchar(40) collate latin1_spanish_ci default NULL,
  rfc varchar(13) collate latin1_spanish_ci default NULL,
  nombre varchar(45) collate latin1_spanish_ci default NULL,
  fechaFac date default NULL,
  fechaCrea date default NULL,
  tasa0 double(8,2) default NULL,
  tasa15 double(8,2) default NULL,
  iva double(8,2) default NULL,
  total double(8,2) default NULL,
  estatus int(1) default NULL,
  cantXFac int(2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `ganancia_porcentual` table : 
#

DROP TABLE IF EXISTS ganancia_porcentual;

CREATE TABLE ganancia_porcentual (
  ID_Pro int(6) default NULL,
  PrecioTipo int(1) default NULL,
  Porcentual double(9,3) default NULL,
  tipoPro int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mermas` table : 
#

DROP TABLE IF EXISTS mermas;

CREATE TABLE mermas (
  ID_Pro int(6) default NULL,
  usuario varchar(8) collate latin1_spanish_ci default NULL,
  fecha date default NULL,
  hora time default NULL,
  descuenta double(10,3) default NULL,
  cantidadOriginal double(10,3) default NULL,
  nuevaCantidad double(10,3) default NULL,
  causa varchar(100) collate latin1_spanish_ci default NULL,
  sitio int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `modificainv` table : 
#

DROP TABLE IF EXISTS modificainv;

CREATE TABLE modificainv (
  ID_Modifica int(8) NOT NULL auto_increment,
  ID_Pro int(6) default NULL,
  claveUsuario varchar(8) collate latin1_spanish_ci default NULL,
  fecha date default NULL,
  hora time default NULL,
  cantidadOriginal double(10,3) default NULL,
  nuevaCantidad double(10,3) default NULL,
  causa varchar(100) collate latin1_spanish_ci default NULL,
  tipo int(1) default NULL,
  sitio int(1) default NULL,
  PRIMARY KEY  (ID_Modifica)
) ENGINE=InnoDB AUTO_INCREMENT=517 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `mp_orden_trabajo` table : 
#

DROP TABLE IF EXISTS mp_orden_trabajo;

CREATE TABLE mp_orden_trabajo (
  clave_Orden int(8) default NULL,
  clave_Producto int(6) default NULL,
  cantidad double(9,3) default NULL,
  tipo int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `orden_compra` table : 
#

DROP TABLE IF EXISTS orden_compra;

CREATE TABLE orden_compra (
  claveOrden int(11) NOT NULL auto_increment,
  claveProveedor varchar(13) collate latin1_spanish_ci default NULL,
  fechaRegistro date default NULL,
  fechaEntrega date default NULL,
  fechaPago date default NULL,
  observaciones varchar(250) collate latin1_spanish_ci default NULL,
  descuento1 double(4,2) default NULL,
  descuento2 double(4,2) default NULL,
  descuento3 double(4,2) default NULL,
  subtotal double(8,2) default NULL,
  descuento double(8,2) default NULL,
  iva double(8,2) default NULL,
  total double(8,2) default NULL,
  activo int(1) default NULL,
  docAval varchar(11) collate latin1_spanish_ci default NULL,
  entrega int(1) default NULL,
  usuario varchar(8) collate latin1_spanish_ci default NULL,
  pago int(1) default NULL,
  PRIMARY KEY  (claveOrden)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `orden_trabajo` table : 
#

DROP TABLE IF EXISTS orden_trabajo;

CREATE TABLE orden_trabajo (
  clave int(8) NOT NULL auto_increment,
  fechaAlta date default NULL,
  usuarioAlta varchar(10) collate latin1_spanish_ci default NULL,
  ObsAlta text collate latin1_spanish_ci,
  fechaBaja date default NULL,
  usuarioBaja varchar(10) collate latin1_spanish_ci default NULL,
  fechaConfirmacion date default NULL,
  usuarioConfirmacion varchar(10) collate latin1_spanish_ci default NULL,
  ObsConfirmacion text collate latin1_spanish_ci,
  estatus int(1) default NULL,
  PRIMARY KEY  (clave)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `pagos` table : 
#

DROP TABLE IF EXISTS pagos;

CREATE TABLE pagos (
  consecutivo int(11) NOT NULL auto_increment,
  claveOrden int(8) default NULL,
  claveProveedor varchar(13) collate latin1_spanish_ci default NULL,
  fechaPago date default NULL,
  monto double(8,2) default NULL,
  formaPago int(1) default NULL,
  numeroCheque varchar(12) collate latin1_spanish_ci default NULL,
  bancoCuenta int(1) default NULL,
  activo int(1) default NULL,
  usuario varchar(8) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (consecutivo)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `pagoxabono` table : 
#

DROP TABLE IF EXISTS pagoxabono;

CREATE TABLE pagoxabono (
  numTicket int(10) default NULL,
  monto double(9,2) default NULL,
  fechaFin date default NULL,
  cobro varchar(10) collate latin1_spanish_ci default NULL,
  estatus int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `permisos` table : 
#

DROP TABLE IF EXISTS permisos;

CREATE TABLE permisos (
  Tipo int(1) default NULL,
  Clave int(4) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `pescalonados` table : 
#

DROP TABLE IF EXISTS pescalonados;

CREATE TABLE pescalonados (
  ID_Pro int(6) NOT NULL default '0',
  ca_peEscalon int(6) default '0',
  campoPrecio double(8,2) default '0.00',
  activo int(1) default '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `precio_anterior_producto` table : 
#

DROP TABLE IF EXISTS precio_anterior_producto;

CREATE TABLE precio_anterior_producto (
  claveProducto int(6) default NULL,
  tipoProducto int(1) default NULL,
  claveOrden int(11) default NULL,
  precioAnterior double(8,2) default NULL,
  precioCompra double(8,2) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `prestamos` table : 
#

DROP TABLE IF EXISTS prestamos;

CREATE TABLE prestamos (
  clavePrestamo int(11) NOT NULL auto_increment,
  claveE int(4) default NULL,
  fechaPrestamo date default NULL,
  horaPrestamo time default NULL,
  cantidadAPagar double(9,2) default NULL,
  fechaFiniquito date default NULL,
  autorizo varchar(10) collate latin1_spanish_ci default NULL,
  estatus int(1) default NULL,
  PRIMARY KEY  (clavePrestamo),
  UNIQUE KEY clavePrestamo (clavePrestamo)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos` table : 
#

DROP TABLE IF EXISTS productos;

CREATE TABLE productos (
  ID_Pro int(6) NOT NULL auto_increment,
  descripcion varchar(35) collate latin1_spanish_ci default NULL,
  tipoPro int(1) default NULL,
  gravaIVA int(1) default '0',
  genero int(1) default NULL,
  materiaPrima int(1) default '0',
  cortes int(1) default '0',
  id_prov1 varchar(13) collate latin1_spanish_ci default NULL,
  id_prov2 varchar(13) collate latin1_spanish_ci default NULL,
  id_prov3 varchar(13) collate latin1_spanish_ci default NULL,
  id_prov4 varchar(13) collate latin1_spanish_ci default NULL,
  id_prov5 varchar(13) collate latin1_spanish_ci default NULL,
  uniCompra int(1) default NULL,
  precioUniCompra double(8,2) default NULL,
  preCaCompra double(8,2) default NULL,
  cantidadXCaja int(4) default NULL,
  precioUnidadKG double(8,2) default NULL,
  kgXUnidad double(8,2) default NULL,
  tipoPrecio int(1) default NULL,
  manejoPrecio int(1) default NULL,
  precioMenu double(8,2) NOT NULL default '0.00',
  precioMenuC double(8,2) NOT NULL default '0.00',
  precioMM double(8,2) default '0.00',
  precioMMC double(8,2) default '0.00',
  precioM double(8,2) default '0.00',
  precioMC double(8,2) default '0.00',
  maxInv double(8,3) default NULL,
  minInv double(8,3) default NULL,
  invTienda double(10,3) default '0.000',
  invAlmacen double(10,3) default '0.000',
  activo int(1) default '1',
  PRIMARY KEY  (ID_Pro),
  UNIQUE KEY ID_Pro (ID_Pro)
) ENGINE=InnoDB AUTO_INCREMENT=886 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos_orden` table : 
#

DROP TABLE IF EXISTS productos_orden;

CREATE TABLE productos_orden (
  ClaveOrden int(11) NOT NULL,
  ClaveProducto int(6) NOT NULL,
  Cantidad double(10,3) default NULL,
  Tipo int(1) NOT NULL,
  Costo double(8,2) default NULL,
  CambiaPrecio int(1) default NULL,
  Importe double(8,2) default NULL,
  Llegan double(10,3) default NULL,
  Adquisicion int(1) default NULL,
  KEY ClaveOrden (ClaveOrden)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `productos_orden_trabajo` table : 
#

DROP TABLE IF EXISTS productos_orden_trabajo;

CREATE TABLE productos_orden_trabajo (
  clave_Orden int(8) default NULL,
  clave_Producto int(6) default NULL,
  cantidad double(9,3) default NULL,
  tipo int(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `proveedores` table : 
#

DROP TABLE IF EXISTS proveedores;

CREATE TABLE proveedores (
  rfc varchar(13) collate latin1_spanish_ci default NULL,
  nombre varchar(80) collate latin1_spanish_ci default NULL,
  direccion varchar(50) collate latin1_spanish_ci default NULL,
  colonia varchar(25) collate latin1_spanish_ci default NULL,
  delegacion varchar(20) collate latin1_spanish_ci default NULL,
  cp varchar(5) collate latin1_spanish_ci default NULL,
  ciudad varchar(30) collate latin1_spanish_ci default NULL,
  tel1 varchar(20) collate latin1_spanish_ci default NULL,
  tel2 varchar(20) collate latin1_spanish_ci default NULL,
  fax varchar(20) collate latin1_spanish_ci default NULL,
  pagina varchar(75) collate latin1_spanish_ci default NULL,
  email varchar(80) collate latin1_spanish_ci default NULL,
  vendedor varchar(50) collate latin1_spanish_ci default NULL,
  formaPago int(1) default NULL,
  cuentas text collate latin1_spanish_ci,
  IDcredito int(1) default '1',
  credito double(9,2) default NULL,
  diasPago int(3) default NULL,
  descuento1 double(8,2) default NULL,
  descuento2 double(8,2) default NULL,
  descuento3 double(8,2) default NULL,
  saldoDisponible double(9,2) default NULL,
  alta date default NULL,
  activo int(1) default NULL,
  KEY rfc (rfc)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `salidas` table : 
#

DROP TABLE IF EXISTS salidas;

CREATE TABLE salidas (
  numTicket int(10) NOT NULL default '0',
  fechaVenta date NOT NULL default '0000-00-00',
  horaVenta time NOT NULL,
  sumaVenta double(8,2) default '0.00',
  factura int(1) default '0',
  tipoCobro int(1) default NULL,
  referenciaCobro varchar(40) collate latin1_spanish_ci default NULL,
  usuario varchar(20) collate latin1_spanish_ci default NULL,
  activo int(1) default '1',
  KEY numTicket (numTicket)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `ticket_ligado` table : 
#

DROP TABLE IF EXISTS ticket_ligado;

CREATE TABLE ticket_ligado (
  ID_Liga int(8) unsigned NOT NULL auto_increment,
  numTicket int(10) default NULL,
  fechaTicket date default NULL,
  rfc varchar(13) collate latin1_spanish_ci default NULL,
  nombre varchar(60) collate latin1_spanish_ci default NULL,
  claveVendedor int(4) default NULL,
  estatus int(1) unsigned default '0',
  PRIMARY KEY  (ID_Liga),
  UNIQUE KEY ID_Liga (ID_Liga)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `usuario` table : 
#

DROP TABLE IF EXISTS usuario;

CREATE TABLE usuario (
  USUARIO_ID varchar(8) collate latin1_spanish_ci NOT NULL default '',
  PASSWORD varchar(8) collate latin1_spanish_ci default NULL,
  TIPO varchar(15) collate latin1_spanish_ci default NULL,
  NombreE varchar(50) collate latin1_spanish_ci default NULL,
  claveVenta int(6) NOT NULL auto_increment,
  clavePermiso int(4) default NULL,
  permisoCobro int(1) unsigned default '0',
  estatus int(1) default '1',
  UNIQUE KEY claveVenta (claveVenta)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Structure for the `vendedores` table : 
#

DROP TABLE IF EXISTS vendedores;

CREATE TABLE vendedores (
  claveVenta int(4) NOT NULL auto_increment,
  NombreE varchar(50) collate latin1_spanish_ci default NULL,
  clavePermiso int(4) default NULL,
  permisoCobro int(1) unsigned default '0',
  salario double(9,2) default '0.00',
  direccion varchar(80) collate latin1_spanish_ci default ' ',
  telCasa varchar(15) collate latin1_spanish_ci default NULL,
  telCel varchar(15) collate latin1_spanish_ci default ' ',
  observacion varchar(80) collate latin1_spanish_ci default ' ',
  estatus int(1) default '1',
  PRIMARY KEY  (claveVenta),
  UNIQUE KEY claveVenta (claveVenta)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

#
# Data for the `vendedores` table  (LIMIT 0,500)
#

# claveVenta:3:49671
# NombreE:253:0
# clavePermiso:3:32768
# permisoCobro:3:32800
# salario:5:32768
# direccion:253:0
# telCasa:253:0
# telCel:253:0
# observacion:253:0
# estatus:3:32768

INSERT INTO vendedores (claveVenta, NombreE, clavePermiso, permisoCobro, salario, direccion, telCasa, telCel, observacion, estatus) VALUES 
  (1,'Martínez Pérez Guillermo',0,0,1500.00,'JILGUERO 10','55857668','0445518560232','',1),
  (2,'Domínguez Sales Limberg',0,0,1300.00,'','','','',1),
  (3,'Domínguez Ibarra María de los Angeles',0,0,1300.00,'','','','',1),
  (4,'Sanvicente Ponce Maricela',0,0,1500.00,'','','','',1),
  (5,'Cruz Ignacio José Manuel',0,0,1400.00,'','','','',1),
  (6,'Hernández Lozano José Manuel',0,0,1.00,'','','','',0),
  (7,'Rojo Castillo José Roberto',0,0,1200.00,'','','','',1),
  (8,'Casas Alarcón Concepción',0,0,1.00,'','','','',0),
  (9,'Vilchis Campuzano Jonathan',0,0,1300.00,'','','','',1),
  (10,'Silva García Victor',0,0,1300.00,'','','','',0),
  (11,'Martínez Pérez Guillermo.',0,0,1.00,'','','','',0),
  (12,'Cortes Garcia Iván Saúl',0,0,1500.00,'','','','',1),
  (13,'Vilchis Campuzano Jonathan',0,0,1300.00,'','','','',1),
  (14,'López Sanchez Carlos Manuel',0,0,1.00,'','','','',0),
  (15,'Maruno Guadalupe',0,0,600.00,'','','','',1),
  (16,'Martínez Pérez Guillermo',0,0,1500.00,'','','','',1),
  (17,'Pérez Sanvicente Fabiola',0,0,1.00,'','','','',0),
  (18,'Ventura Gloria',0,0,900.00,'','','','',1),
  (19,'JESSICA HERNANDEZ PERALTA',0,0,1000.00,'COL, TENORIOS CALLE CAOBA MANZANA 9 LOTE 121','','0445537188906','',1),
  (20,'SAUL PACHECO BELTRAN',0,0,900.00,'AV MORELOS 29 COL SAN PEDRO DELG CHIMALHUACAN EDO MEX','58531111','','AYUDANTE DEL GALLO',1),
  (21,'LUIS LOPEZ HERRERA',0,0,900.00,'CALLE PLAZA DE TEPOZAN NO 13 COL DR ALFONSO ORTIZ TIRADO','57562009','','PARIENTE DE MANUEL',1),
  (22,'Enrique Fernandez Jaimes',29,1,5000.00,'','','','',1),
  (23,'estela ',0,0,500.00,'carmelo','','','',1);

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

INSERT INTO usuario (USUARIO_ID, PASSWORD, TIPO, NombreE, claveVenta, clavePermiso, permisoCobro, estatus) VALUES 
  ('Super','super','administrador','Administrador',1,2006,0,1),
  ('Ivan','8687','administrador','Administrador',2,2500,0,1),
  ('candela','candela','administrador',NULL,3,2000,0,1);

COMMIT;

#
# Data for the `productos` table  (LIMIT 0,500)
#

# ID_Pro:3:49671
# descripcion:253:0
# tipoPro:3:32768
# gravaIVA:3:32768
# genero:3:32768
# materiaPrima:3:32768
# cortes:3:32768
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
# precioMenu:5:32769
# precioMenuC:5:32769
# precioMM:5:32768
# precioMMC:5:32768
# precioM:5:32768
# precioMC:5:32768
# maxInv:5:32768
# minInv:5:32768
# invTienda:5:32768
# invAlmacen:5:32768
# activo:3:32768

INSERT INTO productos (ID_Pro, descripcion, tipoPro, gravaIVA, genero, materiaPrima, cortes, id_prov1, id_prov2, id_prov3, id_prov4, id_prov5, uniCompra, precioUniCompra, preCaCompra, cantidadXCaja, precioUnidadKG, kgXUnidad, tipoPrecio, manejoPrecio, precioMenu, precioMenuC, precioMM, precioMMC, precioM, precioMC, maxInv, minInv, invTienda, invAlmacen, activo) VALUES 
  (1,'CREMA CORTES',1,0,1,0,1,'PAL010828UR4','PLP900316CV6','','','',2,0.00,0.00,0,15.00,1.00,1,0,20.00,0.00,18.50,0.00,16.00,0.00,5000.000,1000.000,500.000,1000.000,0),
  (2,'FABULOSO .500 ML',0,0,3,0,0,'TAB890412AK8','','','','',1,5.00,120.00,24,0.00,0.00,1,1,7.00,168.00,6.00,144.00,5.50,132.00,240.000,120.000,500.000,0.000,0),
  (3,'CREMA TAMBO POMAS',1,0,1,0,0,'PLP900316CV6','','','','',2,0.00,0.00,0,15.00,15.00,1,0,30.00,0.00,25.00,0.00,18.50,0.00,10000.000,3000.000,500.000,0.000,0),
  (4,'MAYONESA MC CORMIC 105 gr',0,0,3,0,0,'TAB890412AK8','','','','',1,10.00,240.00,24,0.00,0.00,1,1,12.00,288.00,11.00,264.00,10.50,252.00,10000.000,2.000,500.000,0.000,0),
  (5,'NESCAFE CLASICO 100G',0,0,3,0,0,'TAB890412AK8','','','','',1,25.00,300.00,12,0.00,0.00,1,1,30.00,360.00,28.00,336.00,27.00,324.00,10.000,2.000,500.000,0.000,0),
  (6,'LA LECHERA 397gr',0,0,3,0,0,'TAB890412AK8','','','','',1,12.00,576.00,48,0.00,0.00,1,1,13.50,648.00,12.80,614.40,12.50,600.00,480.000,48.000,500.000,0.000,0),
  (7,'RAJAS COSTEÑA 220gr',0,0,3,0,0,'TAB890412AK8','','','','',1,9.00,432.00,48,0.00,0.00,1,1,10.50,504.00,10.00,480.00,9.80,470.40,350.000,106.000,500.000,0.000,0),
  (8,'ACEITE 1-2-3  1 LT.',0,0,3,0,0,'SAHUAYO','','','','',1,14.58,175.00,12,0.00,0.00,0,1,20.00,240.00,20.00,240.00,20.00,240.00,0.000,0.000,500.000,0.000,1),
  (9,'ACEITE CAPULLO 1 LT.',0,0,3,0,0,'TAB890412AK8','','','','',1,20.00,240.00,12,0.00,0.00,1,1,23.00,240.00,20.00,240.00,20.00,240.00,0.000,0.000,500.000,0.000,1),
  (10,'ACEITE COCINERA 1 LT.',0,0,3,0,0,'SAHUAYO','','','','',1,13.17,158.00,12,0.00,0.00,1,1,15.00,180.00,13.75,165.00,13.75,165.00,0.000,0.000,500.000,0.000,1),
  (11,'ACEITE CRISTAL 1 LT.',0,0,3,0,0,'SOBA','','','','',1,14.30,171.60,12,0.00,0.00,1,1,19.00,198.00,19.00,198.00,19.00,198.00,0.000,0.000,500.000,0.000,1),
  (12,'ACEITE CRISTAL 1.5 LT.',0,0,3,0,0,'SOBA','','','','',1,21.45,171.60,8,0.00,0.00,1,1,28.00,198.00,28.00,198.00,28.00,198.00,0.000,0.000,500.000,0.000,1),
  (13,'ACEITE CRISTAL 5 LT.',0,0,3,0,0,'SOBA','','','','',1,73.00,146.00,2,0.00,0.00,0,1,85.00,170.00,85.00,170.00,85.00,170.00,0.000,0.000,500.000,0.000,1),
  (14,'ACEITE CAPILLA 900 ML.',0,0,3,0,0,'SOBA','','','','',1,13.91,166.90,12,0.00,0.00,0,1,16.00,178.00,16.00,178.00,16.00,178.00,0.000,0.000,500.000,0.000,1),
  (15,'ACEITE DE OLIVA ESPAÑOL 947.ML.',0,0,3,0,0,'NAMD590112997','','','','',1,56.39,646.72,12,0.00,0.00,1,1,68.00,775.00,68.00,775.00,68.00,775.00,0.000,0.000,500.000,0.000,1),
  (16,'ACEITE DE OLIVA ESPAÑOL 405 ML.',0,0,3,0,0,'NAMD590112997','','','','',1,24.30,485.92,20,0.00,0.00,1,1,30.00,535.00,30.00,535.00,30.00,535.00,0.000,0.000,500.000,0.000,1),
  (17,'ACEITE DE OLIVA ESPAÑOL 189 ML.',0,0,3,0,0,'NAMD590112997','','','','',1,13.90,333.51,24,0.00,0.00,1,1,17.00,370.00,17.00,370.00,17.00,370.00,0.000,0.000,500.000,0.000,1),
  (18,'ACEITE DE OLIVA YBARRA 946ML',0,0,3,0,0,'DAV831010LJ0','','','','',1,74.17,890.00,12,0.00,0.00,1,1,95.00,1140.00,93.50,1122.00,93.00,1116.00,0.000,0.000,500.000,0.000,1),
  (19,'ACEITE DE OLIVA CARBONELL 500 ML.',0,0,3,0,0,'CASA LUCERO','','','','',1,36.67,880.00,24,0.00,0.00,1,1,48.00,1152.00,46.50,1116.00,46.00,1104.00,0.000,0.000,500.000,500.000,1),
  (20,'ACEITUNA DESHUESADA COSTEÑA 420 GM',0,0,3,0,0,'CCO820507BV4','','','','',1,21.46,257.55,12,0.00,0.00,1,1,28.00,336.00,27.50,330.00,27.00,324.00,0.000,0.000,500.000,0.000,1),
  (21,'ACEITUNA LOLTUN C/H 900 GR',0,0,3,0,0,'xxxxxx','','','','',1,29.92,359.00,12,0.00,0.00,1,1,35.00,420.00,34.50,414.00,34.00,408.00,0.000,0.000,500.000,0.000,1),
  (22,'ADEREZO BACHI 3.8 KG.',0,0,3,0,0,'DMA0106263S9','','','','',1,29.50,118.00,4,0.00,0.00,1,1,35.00,140.00,34.50,138.00,34.00,136.00,0.000,0.000,500.000,300.000,1),
  (23,'ADEREZO HELLMANN´S 3.8 L',0,0,3,0,0,'DMA0106263S9','','','','',1,35.00,140.00,4,0.00,0.00,1,1,48.00,192.00,48.00,192.00,48.00,192.00,0.000,0.000,500.000,0.000,1),
  (24,'ADEREZO MC CORMICK 3.8 KG',0,0,3,0,0,'SAHUAYO','','','','',1,62.23,248.90,4,0.00,0.00,1,1,72.00,288.00,72.00,288.00,72.00,288.00,0.000,0.000,500.000,0.000,1),
  (25,'ADEREZO ROYAL 3 KG',0,0,3,0,0,'DMA0106263S9','','','','',1,33.75,135.00,4,0.00,0.00,1,1,43.00,172.00,42.50,170.00,42.00,168.00,0.000,0.000,500.000,0.000,1),
  (26,'ADEREZO VENECIA 3.8 LT.',0,0,3,0,0,'CVE9501177P3','','','','',1,34.25,137.00,4,0.00,0.00,1,1,39.00,151.00,39.00,151.00,39.00,151.00,0.000,0.000,500.000,0.000,1),
  (27,'ADEREZO VENECIA BOLSA 1 KG',0,0,3,0,0,'CVE9501177P3','','','','',1,8.05,80.50,10,0.00,0.00,1,1,11.00,110.00,10.50,105.00,10.00,100.00,0.000,0.000,500.000,0.000,1),
  (28,'AGUA BONAFONT 5 LT.',0,0,3,0,0,'NWM9709244W4','','','','',1,10.23,61.38,6,0.00,0.00,1,1,15.00,90.00,15.00,90.00,15.00,90.00,0.000,0.000,500.000,0.000,1),
  (29,'AGUA BONAFONT 1 LT.',0,0,3,0,0,'NWM9709244W4','','','','',1,4.58,55.00,12,0.00,0.00,1,1,7.00,84.00,6.50,78.00,6.00,72.00,0.000,0.000,500.000,0.000,1),
  (30,'AGUA BONAFONT 1.5 LT.',0,0,3,0,0,'NWM9709244W4','','','','',1,4.75,57.00,12,0.00,0.00,1,1,8.00,66.00,8.00,66.00,8.00,66.00,0.000,0.000,500.000,0.000,1),
  (31,'AGUA BONAFONT 500 ML',0,0,3,0,0,'NWM9709244W4','','','','',1,2.42,58.00,24,0.00,0.00,1,1,5.00,120.00,4.50,108.00,4.00,96.00,0.000,0.000,500.000,0.000,1),
  (32,'AGUA BONAFONT LEVITE 1.5 LT',0,0,3,0,0,'NWM9709244W4','','','','',1,9.00,108.00,12,0.00,0.00,1,1,13.00,156.00,12.50,150.00,12.00,144.00,0.000,0.000,500.000,0.000,1),
  (33,'AGUA MINERAL PEÑAFIEL 600 ML.',0,0,2,0,0,'MARCOS','','','','',1,4.29,103.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.00,144.00,0.000,0.000,500.000,0.000,1),
  (34,'ALCAPARRAS LOLTUN 135G',0,0,3,0,0,'xxxxxx','','','','',1,12.25,294.00,24,0.00,0.00,1,1,18.00,432.00,17.50,420.00,17.00,408.00,0.000,0.000,500.000,0.000,1),
  (35,'ALCAPARRAS LOLTUN 1KG',0,0,3,0,0,'xxxxxx','','','','',1,58.90,706.80,12,0.00,0.00,1,1,75.00,900.00,74.50,894.00,74.00,888.00,0.000,0.000,500.000,0.000,1),
  (36,'ACHIOTE LOLTUN 100 G',0,0,3,0,0,'xxxxxx','','','','',1,3.91,195.30,50,0.00,0.00,1,1,6.50,325.00,5.50,275.00,6.00,300.00,0.000,0.000,500.000,0.000,1),
  (37,'ACHIOTE LOLTUN 1 KG.',0,0,3,0,0,'xxxxxx','','','','',1,39.83,239.00,6,0.00,0.00,1,1,45.00,270.00,44.50,267.00,44.00,264.00,0.000,0.000,500.000,0.000,1),
  (38,'ATUN DOLORES ACEITE 170 G',0,0,3,0,0,'SAHUAYO','','','','',1,7.95,380.00,48,0.00,0.00,0,1,9.50,405.00,9.50,405.00,9.50,405.00,0.000,0.000,500.000,0.000,1),
  (39,'ATUN DOLORES AGUA 170 G',0,0,3,0,0,'TAB890412AK8','','','','',1,6.56,315.00,48,0.00,0.00,1,1,8.50,408.00,7.00,336.00,6.98,335.04,0.000,0.000,500.000,0.000,1),
  (40,'BOING  1 LT',0,0,3,0,0,'SCT8411179Q4','','','','',1,8.68,104.17,12,0.00,0.00,0,1,11.00,118.00,11.00,118.00,11.00,118.00,0.000,0.000,500.000,0.000,1),
  (41,'BOING   500 ML',0,0,3,0,0,'SCT8411179Q4','','','','',1,4.34,104.17,24,0.00,0.00,0,1,7.00,118.00,7.00,118.00,7.00,118.00,0.000,0.000,500.000,0.000,1),
  (42,'BOING  250 ML',0,0,3,0,0,'SCT8411179Q4','','','','',1,2.53,68.33,27,0.00,0.00,0,1,4.00,80.00,4.00,80.00,4.00,80.00,0.000,0.000,500.000,0.000,1),
  (43,'CAJETA QUEMADA CORONADO 660 G',0,0,3,0,0,'TAB890412AK8','','','','',1,25.94,415.00,16,0.00,0.00,1,0,30.00,0.00,29.00,0.00,28.00,0.00,0.000,0.000,500.000,0.000,1),
  (44,'CAFE CON LECHE NESCAFE 22 G C/U',0,0,3,0,0,'NWM9709244W4','','','','',1,2.40,24.00,10,0.00,0.00,1,1,30.00,27.00,30.00,27.00,30.00,27.00,0.000,0.000,500.000,0.000,1),
  (45,'CEREZAS EN ALMIBAR LOLTUN 132 G',0,0,3,0,0,'xxxxxx','','','','',1,10.67,256.00,24,0.00,0.00,1,1,16.00,384.00,15.50,372.00,15.00,360.00,0.000,0.000,500.000,0.000,1),
  (46,'CEREZAS EN ALMIBAR LOLTUN 304 G',0,0,3,0,0,'xxxxxx','','','','',1,18.54,445.00,24,0.00,0.00,1,1,24.00,576.00,23.50,564.00,23.00,552.00,0.000,0.000,500.000,0.000,1),
  (47,'CEREZAS EN ALMIBAR LOLTUN 1.100 G',0,0,3,0,0,'xxxxxx','','','','',1,58.42,701.00,12,0.00,0.00,1,1,70.00,840.00,69.50,834.00,69.00,828.00,0.000,0.000,500.000,0.000,1),
  (48,'CERVEZA MODELO 355 ML',0,0,3,0,0,'SNO950601EB5','','','','',1,6.67,160.00,24,0.00,0.00,0,1,10.00,185.00,10.00,185.00,10.00,185.00,0.000,0.000,500.000,0.000,1),
  (49,'COCKTEL FRUTAS DON AGUSTIN 850 G',0,0,3,0,0,'OCM870210PC6','','','','',1,14.58,175.00,12,0.00,0.00,1,0,18.00,0.00,17.00,0.00,16.00,0.00,0.000,0.000,500.000,0.000,1),
  (50,'CLORO LOS PATITOS 1 LT',0,0,3,0,0,'DDI870402E71','','','','',1,5.00,60.00,12,0.00,0.00,1,1,10.00,70.00,10.00,70.00,10.00,70.00,0.000,0.000,500.000,0.000,1),
  (51,'CLORO LOS PATITOS 4 LT',0,0,3,0,0,'DDI870402E71','','','','',1,16.50,99.00,6,0.00,0.00,1,1,22.00,115.00,22.00,115.00,22.00,115.00,0.000,0.000,500.000,0.000,1),
  (52,'SAL CON AJO FRENCH´S 213 G',0,0,3,0,0,'CCO820507BV4','','','','',1,9.81,117.76,12,0.00,0.00,1,1,14.00,168.00,14.00,168.00,14.00,168.00,0.000,0.000,500.000,0.000,1),
  (53,'SAL CON CEBOLLA FRENCH´S',0,0,3,0,0,'CCO820507BV4','','','','',1,10.74,128.92,12,0.00,0.00,1,1,15.00,180.00,15.00,180.00,15.00,180.00,0.000,0.000,500.000,0.000,1),
  (54,'SAL C/CHILE PIQUIN 128 G',0,0,3,0,0,'CCO820507BV4','','','','',1,11.59,139.07,12,0.00,0.00,1,1,16.00,192.00,16.00,192.00,16.00,192.00,0.000,0.000,500.000,0.000,1),
  (55,'SAL C/PIMIENTA FRENCH´S 185 G',0,0,3,0,0,'CCO820507BV4','','','','',1,13.96,167.50,12,0.00,0.00,1,1,18.00,216.00,18.00,216.00,18.00,216.00,0.000,0.000,500.000,0.000,1),
  (56,'ABLANDADOR DE CARNE FRENCH´S 199 G',0,0,3,0,0,'CCO820507BV4','','','','',1,9.90,118.77,12,0.00,0.00,1,1,14.00,168.00,14.00,168.00,14.00,168.00,0.000,0.000,500.000,0.000,1),
  (57,'PIMIENTA NEGRA MOLIDA FRENCH´S 78G',0,0,3,0,0,'CCO820507BV4','','','','',1,25.89,310.63,12,0.00,0.00,1,1,30.00,360.00,30.00,360.00,30.00,360.00,0.000,0.000,500.000,0.000,1),
  (58,'AJO EN POLVO FRENCH´S 78 G',0,0,3,0,0,'CCO820507BV4','','','','',1,13.11,157.35,12,0.00,0.00,1,1,17.00,204.00,17.00,204.00,17.00,204.00,0.000,0.000,500.000,0.000,1),
  (59,'CANELA EN POLVO FRENCH´S 86 G',0,0,3,0,0,'CCO820507BV4','','','','',1,19.29,231.45,12,0.00,0.00,1,1,24.00,288.00,24.00,288.00,24.00,288.00,0.000,0.000,500.000,0.000,1),
  (60,'CHAMOY MEGA 4 LT',0,0,3,0,0,'CASA LUCERO','','','','',1,22.00,132.00,6,0.00,0.00,1,1,28.00,168.00,27.50,165.00,27.00,162.00,0.000,0.000,500.000,0.000,1),
  (61,'CHAMOY MEGA 1 LT',0,0,3,0,0,'TAB890412AK8','','','','',1,7.42,89.00,12,0.00,0.00,1,1,12.00,144.00,11.50,138.00,11.00,132.00,0.000,0.000,500.000,0.000,1),
  (62,'CHOCOLATE ABUELITA 540 G',0,0,3,0,0,'SAHUAYO','','','','',1,27.60,662.50,24,0.00,0.00,1,1,33.00,792.00,32.50,780.00,32.00,768.00,0.000,0.000,500.000,0.000,1),
  (63,'CHOCOLATE YBARRA 630G',0,0,3,0,0,'SAHUAYO','','','','',1,23.75,285.00,12,0.00,0.00,1,1,30.00,360.00,29.50,354.00,29.00,348.00,0.000,0.000,500.000,0.000,1),
  (64,'CHOCOLATE MORELIA BOLSA 400 G',0,0,3,0,0,'SAHUAYO','MEG0202151X5','','','',1,11.64,291.00,25,0.00,0.00,0,1,16.00,320.00,16.00,320.00,16.00,320.00,0.000,0.000,500.000,0.000,1),
  (65,'CHOCO MILK BOLSA 400G',0,0,3,0,0,'SAHUAYO','','','','',1,18.71,449.00,24,0.00,0.00,1,1,23.00,552.00,22.50,540.00,22.00,528.00,0.000,0.000,500.000,0.000,1),
  (66,'CHAMPIÑONES REBANADOS RIOXAL 780 G',0,0,3,0,0,'TAB890412AK8','','','','',1,20.00,240.00,12,0.00,0.00,1,1,34.00,408.00,33.50,402.00,33.00,396.00,0.000,0.000,500.000,0.000,1),
  (67,'CHAMPIÑONES REBANADOS RIOXAL 3 KG',0,0,3,0,0,'TAB890412AK8','','','','',1,76.67,460.00,6,0.00,0.00,1,1,90.00,540.00,89.50,537.00,89.00,534.00,0.000,0.000,500.000,0.000,1),
  (68,'CHICHAROS COSTEÑA 420 G',0,0,3,0,0,'CCO820507BV4','','','','',1,5.06,121.40,24,0.00,0.00,1,1,9.00,216.00,8.50,204.00,8.00,192.00,0.000,0.000,500.000,0.000,1),
  (69,'CHICHAROS C/ ZANAHORIAS COSTEÑA 420',0,0,3,0,0,'CCO820507BV4','','','','',1,6.48,155.48,24,0.00,0.00,1,1,11.00,264.00,10.50,252.00,10.00,240.00,0.000,0.000,500.000,0.000,1),
  (70,'PIMIENTO MORRON RIOXAL 780 G',0,0,3,0,0,'TAB890412AK8','','','','',1,24.40,292.79,12,0.00,0.00,1,1,30.00,360.00,29.50,354.00,29.00,348.00,0.000,0.000,500.000,0.000,1),
  (71,'PIMIENTO MORRON TORRE 800G',0,0,3,0,0,'CTO840701QT0','','','','',1,24.40,292.79,12,0.00,0.00,1,1,30.00,360.00,29.50,354.00,29.00,348.00,0.000,0.000,500.000,0.000,1),
  (72,'PIMIENTO MORRON TORRE 2850 KG',0,0,3,0,0,'CTO840701QT0','','','','',1,62.64,375.82,6,0.00,0.00,1,1,70.00,420.00,69.50,417.00,69.00,414.00,0.000,0.000,500.000,0.000,1),
  (73,'CHILES HABANEROS LOLTUN  238G',0,0,3,0,0,'xxxxxx','','','','',1,9.30,111.60,12,0.00,0.00,1,0,14.00,0.00,13.00,0.00,12.00,0.00,0.000,0.000,500.000,0.000,0),
  (74,'CHILES JALAPEÑOS COSTEÑA  220G',0,0,3,0,0,'CCO820507BV4','','','','',1,3.18,152.87,48,0.00,0.00,1,1,7.00,336.00,6.50,312.00,6.00,288.00,0.000,0.000,500.000,0.000,1),
  (75,'CHILES JALAPEÑOS COSTEÑA  380G',0,0,3,0,0,'CCO820507BV4','','','','',1,5.24,125.76,24,0.00,0.00,0,1,7.00,148.00,7.00,148.00,7.00,148.00,0.000,0.000,500.000,0.000,1),
  (76,'CHILES JALAPEÑOS COSTEÑA  780G',0,0,3,0,0,'CCO820507BV4','','','','',1,10.10,121.22,12,0.00,0.00,0,1,13.00,145.00,13.00,145.00,13.00,145.00,0.000,0.000,500.000,0.000,1),
  (77,'CHILES JALAPEÑOS COSTEÑA  2.800KG',0,0,3,0,0,'CCO820507BV4','','','','',1,23.97,143.84,6,0.00,0.00,1,1,33.00,198.00,32.50,195.00,32.00,192.00,0.000,0.000,500.000,0.000,1),
  (78,'CHILES JALAPEÑOS TORRE 2.80KG',0,0,3,0,0,'CTO840701QT0','','','','',1,21.22,127.31,6,0.00,0.00,1,1,29.00,174.00,28.50,171.00,28.00,168.00,0.000,0.000,500.000,0.000,1),
  (79,'CHILES NACHOS COSTEÑA 800G',0,0,3,0,0,'CCO820507BV4','','','','',1,11.52,138.26,12,0.00,0.00,1,1,18.00,216.00,17.50,210.00,17.00,204.00,0.000,0.000,500.000,0.000,1),
  (80,'CHILES NACHOS COSTEÑA 2800KG',0,0,3,0,0,'CCO820507BV4','','','','',1,30.30,181.81,6,0.00,0.00,1,1,38.00,228.00,37.50,225.00,37.00,222.00,0.000,0.000,500.000,0.000,1),
  (81,'CHILES NACHOS NORTEÑA 3KG',0,0,3,0,0,'TAB890412AK8','','','','',1,30.00,180.00,6,0.00,0.00,1,1,35.00,210.00,34.50,207.00,34.00,204.00,0.000,0.000,500.000,0.000,1),
  (82,'CHILES PICADOS COSTEÑA 800G',0,0,3,0,0,'CCO820507BV4','','','','',1,13.14,157.63,12,0.00,0.00,1,1,18.00,216.00,17.50,210.00,17.00,204.00,0.000,0.000,500.000,0.000,1),
  (83,'CHIPOTLES COSTEÑA 380 G',0,0,3,0,0,'CCO820507BV4','','','','',1,12.20,292.72,24,0.00,0.00,1,1,16.00,384.00,15.50,372.00,15.00,360.00,0.000,0.000,500.000,0.000,1),
  (84,'CHIPOTLES COSTEÑA 220G',0,0,3,0,0,'CCO820507BV4','','','','',1,7.19,172.47,24,0.00,0.00,1,1,11.00,264.00,10.50,252.00,10.00,240.00,0.000,0.000,500.000,0.000,1),
  (85,'DETERGENTE SALVO 500G',0,0,3,0,0,'SAHUAYO','','','','',1,8.42,303.00,36,0.00,0.00,1,1,10.00,360.00,9.50,342.00,9.00,324.00,0.000,0.000,500.000,0.000,1),
  (86,'DURAZNOS TROZO CARRESA 820G',0,0,3,0,0,'IVAN CORTES','','','','',1,8.96,215.00,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (87,'DURAZNOS MITADES TORRE 800G',0,0,3,0,0,'CTO840701QT0','','','','',1,15.66,375.80,24,0.00,0.00,1,1,20.00,480.00,19.50,468.00,19.00,456.00,0.000,0.000,500.000,0.000,1),
  (88,'DURAZNOS MITADES AGUSTIN 820G',0,0,3,0,0,'OCM870210PC6','','','','',1,11.46,275.00,24,0.00,0.00,1,1,17.00,408.00,12.50,300.00,12.50,300.00,0.000,0.000,500.000,0.000,1),
  (89,'DURAZNOS MITADES AGUSTIN 3KG',0,0,3,0,0,'OCM870210PC6','','','','',1,47.50,285.00,6,0.00,0.00,1,1,55.00,330.00,54.50,327.00,54.00,324.00,0.000,0.000,500.000,0.000,1),
  (90,'GRANOLA SENCILLA MORENA 1KG',0,0,3,0,0,'LARM710929SD5','','','','',1,13.00,156.00,12,0.00,0.00,1,1,22.00,264.00,18.00,216.00,18.00,216.00,0.000,0.000,500.000,0.000,1),
  (91,'MAIZENA 750 G',0,0,3,0,0,'TAB890412AK8','','','','',1,17.13,411.00,24,0.00,0.00,1,1,22.00,528.00,21.50,516.00,21.00,504.00,0.000,0.000,500.000,0.000,1),
  (92,'MIEL MELISSA 1.4 KG',0,0,3,0,0,'TAB890412AK8','','','','',1,17.67,212.04,12,0.00,0.00,1,0,20.00,0.00,19.00,0.00,18.00,0.00,0.000,0.000,500.000,0.000,1),
  (93,'MOSTAZA FRENCH´S 226G',0,0,3,0,0,'CCO820507BV4','','','','',1,9.90,237.54,24,0.00,0.00,1,1,14.00,336.00,13.50,324.00,13.00,312.00,0.000,0.000,500.000,0.000,1),
  (94,'NESCAFE CLASICO SOBRES 2G C/U',0,0,3,0,0,'NWM9709244W4','','','','',1,1.00,22.71,24,0.00,0.00,1,0,10.00,0.00,9.00,0.00,8.00,0.00,0.000,0.000,500.000,0.000,0),
  (95,'NESCAFE CLASICO SOBRES 50 SOBRES',0,0,3,0,0,'NWM9709244W4','','','','',1,23.45,562.90,24,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,500.000,0.000,1),
  (96,'PALOMAS ACT II MANTEQUILLA EXTRA',0,0,3,0,0,'TAB890412AK8','','','','',1,3.22,57.90,18,0.00,0.00,1,1,4.50,81.00,4.00,72.00,4.00,72.00,0.000,0.000,500.000,0.000,1),
  (97,'PALOMAS ACT II CARAMELO',0,0,3,0,0,'TAB890412AK8','','','','',1,9.43,84.90,9,0.00,0.00,1,1,11.00,99.00,10.50,94.50,10.50,94.50,0.000,0.000,500.000,0.000,1),
  (98,'PALOMAS ACT II NATURAL',0,0,3,0,0,'TAB890412AK8','','','','',1,3.27,57.90,18,0.00,0.00,1,1,4.50,81.00,4.00,72.00,4.00,72.00,0.000,0.000,500.000,0.000,1),
  (99,'PURE DE TOMATE COSTEÑA 800G',0,0,3,0,0,'CCO820507BV4','','','','',1,9.44,113.31,12,0.00,0.00,1,1,14.00,168.00,13.50,162.00,13.00,156.00,0.000,0.000,500.000,0.000,1),
  (100,'CHILES PICADOS COSTEÑA 2800KG',0,0,3,0,0,'CCO820507BV4','','','','',1,32.51,195.04,6,0.00,0.00,1,1,40.00,240.00,39.50,237.00,39.00,234.00,0.000,0.000,500.000,0.000,1),
  (101,'CHILES SERRANOS COSTEÑA 105G',0,0,3,0,0,'CCO820507BV4','','','','',1,2.01,80.38,40,0.00,0.00,1,1,5.00,200.00,4.50,180.00,4.00,160.00,0.000,0.000,500.000,0.000,1),
  (102,'CHIPOTLES COSTEÑA 105G',0,0,3,0,0,'CCO820507BV4','','','','',1,3.70,148.05,40,0.00,0.00,1,1,8.00,320.00,7.50,300.00,7.00,280.00,0.000,0.000,500.000,0.000,1),
  (103,'CHIPOTLES TORRE 2.800KG',0,0,3,0,0,'CTO840701QT0','','','','',1,54.16,324.97,6,0.00,0.00,1,1,70.00,420.00,69.50,417.00,69.00,414.00,0.000,0.000,500.000,0.000,1),
  (104,'DETERGENTE ROMA 250G',0,0,3,0,0,'SCORPION','','','','',1,3.37,134.90,40,0.00,0.00,1,1,5.00,200.00,4.50,180.00,4.00,160.00,0.000,0.000,500.000,0.000,1),
  (105,'DETERGENTE ROMA 500G',0,0,3,0,0,'TAB890412AK8','','','','',1,6.50,130.00,20,0.00,0.00,1,1,8.00,160.00,7.50,150.00,7.00,140.00,0.000,0.000,500.000,0.000,1),
  (106,'DETERGENTE ROMA 1KG',0,0,3,0,0,'TAB890412AK8','','','','',1,12.90,129.00,10,0.00,0.00,1,1,16.00,160.00,15.00,150.00,14.50,145.00,0.000,0.000,500.000,0.000,1),
  (107,'DETERGENTE SALVO 900G',0,0,3,0,0,'SAHUAYO','','','','',1,14.30,286.01,20,0.00,0.00,1,1,18.00,360.00,17.50,350.00,17.00,340.00,0.000,0.000,500.000,0.000,1),
  (108,'DETERGENTE ARIEL 950G',0,0,3,0,0,'SAHUAYO','','','','',1,17.33,312.00,18,0.00,0.00,1,1,21.00,378.00,20.50,369.00,20.00,360.00,0.000,0.000,500.000,0.000,1),
  (109,'DETERGENTE ACE 1KG',0,0,3,0,0,'TAB890412AK8','','','','',1,16.66,299.90,18,0.00,0.00,1,1,22.00,396.00,21.50,387.00,21.00,378.00,0.000,0.000,500.000,0.000,1),
  (110,'DETERGENTE ACE 500G',0,0,3,0,0,'TAB890412AK8','','','','',1,9.90,198.00,20,0.00,0.00,1,1,15.00,300.00,14.50,290.00,14.00,280.00,0.000,0.000,500.000,0.000,1),
  (111,'AXION LIQUIDO 400ML',0,0,3,0,0,'SAHUAYO','','','','',1,7.58,91.00,12,0.00,0.00,1,1,13.00,156.00,12.50,150.00,12.00,144.00,0.000,0.000,500.000,0.000,1),
  (112,'AXION LIQUIDO LIMON 900ML',0,0,3,0,0,'SAHUAYO','','','','',1,16.00,192.00,12,0.00,0.00,1,1,21.00,252.00,20.50,246.00,20.00,240.00,0.000,0.000,500.000,0.000,1),
  (113,'SALVO GEL 400G',0,0,3,0,0,'SCORPION','','','','',1,7.92,190.10,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (114,'DURAZNOS TROZO AGUSTIN 3KG',0,0,3,0,0,'OCM870210PC6','','','','',1,44.17,265.00,6,0.00,0.00,1,1,55.00,330.00,49.50,297.00,49.00,294.00,0.000,0.000,500.000,0.000,1),
  (115,'ENSALADA DE VERDURAS COSTEÑA  410G',0,0,3,0,0,'CCO820507BV4','','','','',1,7.02,168.56,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (116,'FRIJOL BAYO TORRE 3.170KG',0,0,3,0,0,'CTO840701QT0','','','','',1,25.56,153.35,6,0.00,0.00,1,1,32.00,192.00,31.50,189.00,31.00,186.00,0.000,0.000,500.000,0.000,1),
  (117,'FRIJOLES BAYOS COSTEÑA 580G',0,0,3,0,0,'CCO820507BV4','','','','',1,7.44,89.24,12,0.00,0.00,1,1,11.00,132.00,10.50,126.00,10.00,120.00,0.000,0.000,500.000,0.000,1),
  (118,'FRIJOL NEGRO COSTEÑA 580G',0,0,1,0,0,'CCO820507BV4','','','','',1,7.44,89.24,12,0.00,0.00,1,1,11.00,132.00,10.50,126.00,10.00,120.00,0.000,0.000,500.000,0.000,1),
  (119,'FRIJOL BAYO ENTERO COSTEÑA 560G',0,0,3,0,0,'CCO820507BV4','','','','',1,5.61,67.34,12,0.00,0.00,1,1,9.50,114.00,9.00,108.00,8.50,102.00,0.000,0.000,500.000,0.000,1),
  (120,'FRIJOL NEGRO ENTERO COSTEÑA  560G',0,0,3,0,0,'CCO820507BV4','','','','',1,5.61,67.34,12,0.00,0.00,1,1,9.50,114.00,9.00,108.00,8.50,102.00,0.000,0.000,500.000,0.000,1),
  (121,'FRUTSI  250ML',0,0,3,0,0,'TAB890412AK8','','','','',1,1.90,45.48,24,0.00,0.00,1,1,3.00,51.00,2.13,51.00,2.13,51.00,0.000,0.000,500.000,0.000,1),
  (122,'GRANO DE ELOTE COSTEÑA  2.915KG',0,0,3,0,0,'CCO820507BV4','','','','',1,41.38,248.27,6,0.00,0.00,1,1,50.00,300.00,49.50,297.00,49.00,294.00,0.000,0.000,500.000,0.000,1),
  (123,'GRANO DE ELOTE COSTEÑA  410G',0,0,3,0,0,'CCO820507BV4','','','','',1,7.78,186.73,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (124,'HARINA DE TRIGO MODERNA 1KG',0,0,3,0,0,'TAB890412AK8','','','','',1,6.80,68.00,10,0.00,0.00,1,1,10.00,100.00,9.50,95.00,9.00,90.00,0.000,0.000,500.000,0.000,1),
  (125,'HARINA DE TRIGO 3 ESTRELLAS 1 KG',0,0,3,0,0,'TAB890412AK8','','','','',1,8.10,81.00,10,0.00,0.00,1,1,12.00,120.00,11.50,115.00,11.00,110.00,0.000,0.000,500.000,0.000,1),
  (126,'HARINA HOT CAKES 3 ESTRELLAS 1KG',0,0,3,0,0,'SAHUAYO','','','','',1,13.20,132.00,10,0.00,0.00,1,1,17.00,170.00,16.50,165.00,16.00,160.00,0.000,0.000,500.000,0.000,1),
  (127,'JUGO SAZONADOR MAGGI 100ML',0,0,3,0,0,'NWM9709244W4','','','','',1,12.96,77.75,6,0.00,0.00,1,1,16.00,96.00,16.00,96.00,16.00,96.00,0.000,0.000,500.000,0.000,1),
  (128,'JUGO SAZONADOR MAGGI  800ML',0,0,3,0,0,'MEG0202151X5','','','','',1,56.81,681.72,12,0.00,0.00,1,1,62.00,744.00,62.00,744.00,62.00,744.00,0.000,0.000,500.000,0.000,1),
  (129,'JARABE P/AGUA SAN PEDRO',0,0,3,0,0,'FERU9711033E7','','','','',1,10.74,257.81,24,0.00,0.00,1,1,13.50,282.00,13.50,282.00,13.50,282.00,0.000,0.000,500.000,0.000,1),
  (130,'KNORR SUIZA FCO. 225G',0,0,3,0,0,'TAB890412AK8','','','','',1,17.19,412.62,24,0.00,0.00,1,1,28.00,672.00,27.50,660.00,27.00,648.00,0.000,0.000,500.000,0.000,1),
  (131,'MANGO REBANADO COSTEÑA  800G',0,0,3,0,0,'CCO820507BV4','','','','',1,15.27,183.22,12,0.00,0.00,1,1,22.00,264.00,21.50,258.00,21.00,252.00,0.000,0.000,500.000,0.000,1),
  (132,'MAYONESA MC CORMICK 3.4 KG',0,0,3,0,0,'SAHUAYO','','','','',1,77.75,311.00,4,0.00,0.00,1,1,90.00,342.00,90.00,342.00,90.00,342.00,0.000,0.000,500.000,0.000,1),
  (133,'MAYONESA MC CORMICK NO. 64  1.730G',0,0,3,0,0,'SAHUAYO','','','','',1,47.00,282.00,6,0.00,0.00,1,1,58.00,348.00,57.50,345.00,57.00,342.00,0.000,0.000,500.000,0.000,1),
  (134,'MAYONESA MC CORMIC NO. 32  790G',0,0,3,0,0,'SAHUAYO','','','','',1,27.00,326.00,12,0.00,0.00,1,1,36.00,432.00,35.50,426.00,35.00,420.00,0.000,0.000,500.000,0.000,1),
  (135,'MAYONESA MC CORMIC NO. 16  390G',0,0,3,0,0,'SAHUAYO','','','','',1,15.00,181.00,12,0.00,0.00,0,1,26.00,225.00,26.00,225.00,26.00,225.00,0.000,0.000,500.000,0.000,1),
  (136,'MAYONESA MC CORMIC NO. 8  190G',0,0,3,0,0,'SAHUAYO','','','','',1,7.71,185.00,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (137,'MAYONESA MC CORMIC NO. 4 105G',0,0,3,0,0,'SAHUAYO','','','','',1,5.00,119.90,24,0.00,0.00,1,1,10.00,240.00,9.50,228.00,9.00,216.00,0.000,0.000,500.000,0.000,1),
  (138,'MAYONESA STAR VALUE 3.57KG',0,0,3,0,0,'DMA0106263S9','','','','',1,61.17,367.00,6,0.00,0.00,1,1,65.00,390.00,64.50,387.00,64.00,384.00,0.000,0.000,500.000,0.000,1),
  (139,'MIEL COMERCIAL MIELINA 7KG',0,0,3,0,0,'VAAE700316SS4','','','','',1,68.00,272.00,4,0.00,0.00,1,1,85.00,340.00,84.50,338.00,84.00,336.00,0.000,0.000,500.000,0.000,1),
  (140,'MOSTAZA MEGA  3.7KG',0,0,3,0,0,'DMA0106263S9','','','','',1,29.17,175.00,6,0.00,0.00,1,1,38.00,228.00,37.50,225.00,37.00,222.00,0.000,0.000,500.000,0.000,1),
  (141,'MOSTAZA FRENCH´S 397G',0,0,3,0,0,'CCO820507BV4','','','','',1,14.64,234.16,16,0.00,0.00,1,1,19.00,304.00,18.50,296.00,18.00,288.00,0.000,0.000,500.000,0.000,1),
  (142,'MOSTAZA FRENCH´S 567G',0,0,3,0,0,'CCO820507BV4','','','','',1,17.93,215.21,12,0.00,0.00,1,1,22.00,264.00,21.50,258.00,21.00,252.00,0.000,0.000,500.000,0.000,1),
  (143,'MOSTAZA VENECIA BOLSA 1 KG',0,0,3,0,0,'CVE9501177P3','','','','',1,7.20,72.00,10,0.00,0.00,1,1,11.00,110.00,8.50,85.00,8.00,80.00,0.000,0.000,500.000,0.000,1),
  (144,'ACEITE DE OLIVA DEL RIO 1 LT',0,0,3,0,0,'TAB890412AK8','','','','',1,35.00,420.00,12,0.00,0.00,1,0,40.00,0.00,39.00,0.00,38.00,0.00,0.000,0.000,500.000,0.000,0),
  (145,'ACEITE DE OLIVA DEL RIO 500 ML',0,0,3,0,0,'DEL RIO','','','','',1,18.00,432.00,24,0.00,0.00,1,0,22.00,0.00,21.00,0.00,20.00,0.00,0.000,0.000,500.000,0.000,0),
  (146,'CHILES GUEROS LOLTUN 350G',0,0,3,0,0,'xxxxxx','','','','',1,12.92,155.00,12,0.00,0.00,1,1,17.00,204.00,16.50,198.00,16.00,192.00,0.000,0.000,500.000,0.000,1),
  (147,'CEREZAS EN ALMIBAR LOLTUN 4KG',0,0,3,0,0,'xxxxxx','','','','',1,115.00,460.00,4,0.00,0.00,1,1,135.00,540.00,134.50,538.00,134.00,536.00,0.000,0.000,500.000,0.000,1),
  (148,'NARANJADA BONAFINA 700ML',0,0,3,0,0,'PIERO','','','','',1,3.90,78.00,20,0.00,0.00,0,1,5.00,90.00,5.00,90.00,5.00,90.00,0.000,0.000,500.000,0.000,1),
  (149,'NARANJADA BONAFINA 900ML',0,0,3,0,0,'PIERO','','','','',1,4.95,99.00,20,0.00,0.00,0,1,6.50,110.00,6.50,110.00,6.50,110.00,0.000,0.000,500.000,0.000,1),
  (150,'NARANJADA BONAFINA 3LT',0,0,3,0,0,'PIERO','','','','',1,14.67,88.00,6,0.00,0.00,0,1,19.00,99.00,19.00,99.00,19.00,99.00,0.000,0.000,500.000,0.000,1),
  (151,'NARANJADA BONAFINA PLASTICO 1LT',0,0,3,0,0,'PIERO','','','','',1,5.30,106.00,20,0.00,0.00,0,1,7.50,120.00,7.50,120.00,7.50,120.00,0.000,0.000,500.000,0.000,1),
  (152,'NARANJADA BONAFINA 220ML',0,0,3,0,0,'PIERO','','','','',1,1.49,82.00,55,0.00,0.00,1,1,2.00,91.00,2.00,91.00,2.00,91.00,0.000,0.000,500.000,0.000,1),
  (153,'NESCAFE CLASICO 200G',0,0,3,0,0,'TAB890412AK8','MEG0202151X5','','','',1,41.21,494.49,12,0.00,0.00,1,1,49.00,545.00,47.00,545.00,46.00,545.00,0.000,0.000,500.000,0.000,1),
  (154,'NESCAFE CLASICO 50G',0,0,3,0,0,'NWM9709244W4','','','','',1,12.74,152.00,12,0.00,0.00,1,1,18.00,216.00,17.50,210.00,17.00,204.00,0.000,0.000,500.000,0.000,1),
  (155,'PIÑA TROZO AGUSTIN 3.035KG',0,0,3,0,0,'TAB890412AK8','','','','',1,39.17,235.00,6,0.00,0.00,1,1,58.00,348.00,57.50,345.00,57.00,342.00,0.000,0.000,500.000,0.000,1),
  (156,'PIÑA REBANADA AGUSTIN 3.05KG',0,0,3,0,0,'TAB890412AK8','','','','',1,47.50,285.00,6,0.00,0.00,1,1,58.00,348.00,57.50,345.00,57.00,342.00,0.000,0.000,500.000,0.000,1),
  (157,'PIÑA TROZO Y REB AGUSTIN 820G',0,0,3,0,0,'OCM870210PC6','','','','',1,13.30,160.00,12,0.00,0.00,0,1,17.00,180.00,17.00,180.00,17.00,180.00,0.000,0.000,500.000,0.000,1),
  (158,'PURE DE MANZANA COSTEÑA 465G',0,0,3,0,0,'CCO820507BV4','','','','',1,5.61,67.34,12,0.00,0.00,1,1,12.00,144.00,11.50,138.00,11.00,132.00,0.000,0.000,500.000,0.000,1),
  (159,'RED BULL 250ML',0,0,2,0,0,'SNO950601EB5','','','','',1,14.38,345.00,24,0.00,0.00,1,1,22.00,528.00,19.00,456.00,19.00,456.00,0.000,0.000,500.000,0.000,1),
  (160,'MINI COCA COLA VIDRIO',0,0,2,0,0,'SNO950601EB5','','','','',1,3.96,95.00,24,0.00,0.00,1,0,6.00,0.00,5.00,0.00,48.00,0.00,0.000,0.000,500.000,0.000,1),
  (161,'COCA COLA 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,5.63,135.00,24,0.00,0.00,1,1,7.50,142.00,7.00,142.00,7.00,142.00,0.000,0.000,500.000,0.000,1),
  (162,'COCA COLA 1LT',0,0,2,0,0,'SNO950601EB5','','','','',1,7.92,95.00,12,0.00,0.00,1,1,10.00,120.00,9.50,114.00,9.50,114.00,0.000,0.000,500.000,0.000,1),
  (163,'COCA COLA 2.5 LT',0,0,2,0,0,'SNO950601EB5','','','','',1,14.88,119.00,8,0.00,0.00,1,1,18.00,144.00,17.50,140.00,17.00,136.00,0.000,0.000,500.000,0.000,1),
  (164,'COCA COLA LATA',0,0,2,0,0,'SNO950601EB5','','','','',1,3.96,95.00,24,0.00,0.00,1,1,6.00,108.96,4.54,108.96,4.54,108.96,0.000,0.000,500.000,0.000,1),
  (165,'COCA COLA LIGHT 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,6.13,147.00,24,0.00,0.00,1,1,8.50,204.00,8.00,192.00,8.00,192.00,0.000,0.000,500.000,0.000,1),
  (166,'COCA COLA ZERO 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,5.92,142.00,24,0.00,0.00,1,1,8.00,192.00,7.50,180.00,7.50,180.00,0.000,0.000,500.000,0.000,1),
  (167,'REFRESCO RED COLA MEGA 3.300LT',0,0,2,0,0,'SNO950601EB5','','','','',1,10.33,62.00,6,0.00,0.00,1,1,12.00,72.00,11.50,69.00,11.50,69.00,0.000,0.000,500.000,0.000,1),
  (168,'REFRESCO RED COLA 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,3.42,82.00,24,0.00,0.00,1,1,5.00,90.00,5.00,90.00,5.00,90.00,0.000,0.000,500.000,0.000,1),
  (169,'REFRESCO LINEA PEPSI 600ML',0,0,2,0,0,'CIR060621E27','','','','',1,4.17,100.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.50,156.00,0.000,0.000,500.000,0.000,1),
  (170,'REFRESCO LINEA PEPSI  1.5 LT',0,0,2,0,0,'SNO950601EB5','','','','',1,7.08,85.00,12,0.00,0.00,1,1,10.00,120.00,9.50,114.00,9.50,114.00,0.000,0.000,500.000,0.000,1),
  (171,'LINEA PEPSI LATA 355 ML',0,0,2,0,0,'NWM9709244W4','','','','',1,2.81,67.37,24,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (172,'RAJAS COSTEÑA 105G',0,0,3,0,0,'CCO820507BV4','','','','',1,2.17,86.72,40,0.00,0.00,1,1,5.00,200.00,4.50,180.00,4.00,160.00,0.000,0.000,500.000,0.000,1),
  (173,'RAJAS COSTEÑA 220G',0,0,3,0,0,'CCO820507BV4','','','','',1,3.80,182.18,48,0.00,0.00,0,1,5.00,205.00,5.00,205.00,5.00,205.00,0.000,0.000,500.000,0.000,1),
  (174,'RAJAS COSTEÑA 380G',0,0,3,0,0,'CCO820507BV4','','','','',1,6.98,155.62,24,0.00,0.00,0,1,9.00,175.00,9.00,175.00,9.00,175.00,0.000,0.000,500.000,0.000,1),
  (175,'RAJAS COSTEÑA 800G',0,0,3,0,0,'CCO820507BV4','','','','',1,12.09,145.12,12,0.00,0.00,1,1,17.00,204.00,16.50,198.00,16.00,192.00,4.000,0.000,500.000,0.000,1),
  (176,'RAJAS COSTEÑA 2800KG',0,0,3,0,0,'CCO820507BV4','','','','',1,35.07,210.41,6,0.00,0.00,1,1,43.00,258.00,42.50,255.00,42.00,252.00,0.000,0.000,500.000,0.000,1),
  (177,'REFRESCO LULU 3 LT',0,0,2,0,0,'SCT8411179Q4','','','','',1,10.00,60.00,6,0.00,0.00,1,1,13.00,78.00,12.50,75.00,12.50,75.00,0.000,0.000,500.000,0.000,1),
  (178,'SIDRAL MUNDET 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,4.08,98.00,24,0.00,0.00,1,0,8.00,0.00,7.00,0.00,6.00,0.00,0.000,0.000,500.000,0.000,0),
  (179,'REFRESCO JARRITOS 2LT',0,0,2,0,0,'SNO950601EB5','','','','',1,8.38,67.00,8,0.00,0.00,1,1,10.00,80.00,9.50,76.00,9.50,76.00,0.000,0.000,500.000,0.000,1),
  (180,'REFRESCO PEÑAFIEL SABORES 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,4.79,115.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.00,144.00,0.000,0.000,500.000,0.000,1),
  (181,'SAL DE GRANO BAHIA 1KG',0,0,3,0,0,'TAB890412AK8','','','','',1,2.28,57.00,25,0.00,0.00,1,0,6.00,0.00,5.00,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (182,'SALSA SABROSITA GALON 4KG',0,0,3,0,0,'MDD000728BL0','','','','',1,19.67,118.00,6,0.00,0.00,1,0,25.00,0.00,24.00,0.00,23.00,0.00,0.000,0.000,500.000,0.000,1),
  (183,'SALSA SABROSITA GALON  1.5 LT',0,0,3,0,0,'MDD000728BL0','','','','',1,9.42,113.00,12,0.00,0.00,1,1,13.50,162.00,13.00,156.00,12.50,150.00,0.000,0.000,500.000,0.000,1),
  (184,'SALSA BOTANERA 3KG',0,0,3,0,0,'TAB890412AK8','','','','',1,21.50,129.00,6,0.00,0.00,1,1,28.00,168.00,27.50,165.00,27.00,162.00,0.000,0.000,500.000,0.000,1),
  (185,'SALSA BOTANERA 1LT',0,0,3,0,0,'TAB890412AK8','','','','',1,7.25,87.00,12,0.00,0.00,1,1,12.00,144.00,11.50,138.00,11.50,138.00,0.000,0.000,500.000,0.000,1),
  (186,'CATSUP BACHI 4KG',0,0,3,0,0,'DMA0106263S9','','','','',1,31.25,125.00,4,0.00,0.00,0,1,36.00,145.00,36.00,145.00,36.00,145.00,0.000,0.000,500.000,0.000,1),
  (187,'CATSUP CLEMENTE JAQUES 3.1KG',0,0,3,0,0,'SAHUAYO','','','','',1,28.33,170.00,6,0.00,0.00,1,1,34.00,204.00,33.50,201.00,33.00,198.00,0.000,0.000,500.000,0.000,1),
  (188,'SALSA CATSUP COSTEÑA 3.250KG',0,0,3,0,0,'CCO820507BV4','','','','',1,40.32,241.92,6,0.00,0.00,1,1,45.00,270.00,44.50,267.00,44.00,264.00,0.000,0.000,500.000,0.000,1),
  (189,'CATSUP VENECIA 4KG',0,0,3,0,0,'CVE9501177P3','','','','',1,22.38,89.50,4,0.00,0.00,1,1,28.00,112.00,27.50,110.00,27.00,108.00,0.000,0.000,500.000,0.000,1),
  (190,'CATSUP VENECIA BOLSA 1KG',0,0,3,0,0,'CVE9501177P3','','','','',1,5.80,58.00,10,0.00,0.00,1,1,11.00,110.00,10.50,105.00,10.00,100.00,0.000,0.000,500.000,0.000,1),
  (191,'CATSUP EMBASA 1KG',0,0,3,0,0,'TAB890412AK8','','','','',1,9.75,117.00,12,0.00,0.00,1,1,14.00,168.00,13.50,162.00,13.50,162.00,0.000,0.000,500.000,0.000,1),
  (192,'CATSUP MEGA RIKA 4.5 KG',0,0,3,0,0,'DMA0106263S9','','','','',1,32.67,196.00,6,0.00,0.00,1,1,38.00,228.00,36.50,219.00,36.00,216.00,0.000,0.000,500.000,0.000,1),
  (193,'SALSA VALENTINA AMARILLA 1LT',0,0,3,0,0,'CASA BETY','','','','',1,8.00,96.00,12,0.00,0.00,1,1,11.00,132.00,10.50,126.00,10.00,120.00,0.000,0.000,500.000,0.000,1),
  (194,'SALSA VALENTINA AMARILLA 370ML',0,0,3,0,0,'CASA BETY','','','','',1,4.00,96.00,24,0.00,0.00,1,1,6.00,144.00,5.50,132.00,5.00,120.00,0.000,0.000,500.000,0.000,1),
  (195,'SALSA VALENTINA NEGRA 1LT',0,0,3,0,0,'CASA BETY','','','','',1,8.83,106.00,12,0.00,0.00,1,1,12.00,144.00,11.50,138.00,11.00,132.00,0.000,0.000,500.000,0.000,1),
  (196,'SALSA VALENTINA NEGRA 370ML',0,0,3,0,0,'CASA BETY','','','','',1,4.42,106.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.00,144.00,0.000,0.000,500.000,0.000,1),
  (197,'SALSA VALENTINA NEGRA PORCION CAJA',0,0,3,0,0,'CASA BETY','','','','',1,0.13,118.00,900,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (198,'SALSA VALENTINA AMARI. PORCION CAJA',0,0,3,0,0,'CASA BETY','','','','',1,0.12,106.00,900,0.00,0.00,1,0,4.00,0.00,3.00,0.00,2.00,0.00,0.000,0.000,500.000,0.000,1),
  (199,'SALSA DE CHIPOTLE LOLTUN 150G',0,0,3,0,0,'xxxxxx','','','','',1,5.23,183.21,35,0.00,0.00,1,1,11.00,385.00,10.50,367.50,10.00,350.00,0.000,0.000,500.000,0.000,1),
  (200,'SALSA DE HABANERO LOLTUN 150G',0,0,3,0,0,'xxxxxx','','','','',1,7.43,260.00,35,0.00,0.00,1,1,12.00,420.00,11.50,402.50,11.00,385.00,0.000,0.000,500.000,0.000,1),
  (201,'SERVILLETAS KIMLARK 500',0,0,3,0,0,'TAB890412AK8','','','','',1,15.33,184.00,12,0.00,0.00,0,1,18.50,205.00,18.50,205.00,18.50,205.00,0.000,0.000,500.000,0.000,1),
  (202,'TE PASTORA VARIOS 24PZ',0,0,3,0,0,'DDI870402E71','','','','',1,10.00,240.00,24,0.00,0.00,1,0,14.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,1),
  (203,'TE PASTORA JAM. CAN. 24 PZ',0,0,3,0,0,'DDI870402E71','','','','',1,14.00,336.00,24,0.00,0.00,1,0,18.00,0.00,18.00,0.00,16.50,0.00,0.000,0.000,500.000,0.000,1),
  (204,'GELATINA D GARY 170G',0,0,3,0,0,'SNO950601EB5','','','','',1,4.99,249.50,50,0.00,0.00,1,1,6.50,325.00,6.00,300.00,5.50,275.00,0.000,0.000,500.000,0.000,1),
  (205,'TOSTADAS NACHITOS 1KG',0,0,3,0,0,'MEG0202151X5','','','','',1,16.81,67.24,4,0.00,0.00,1,1,24.00,74.00,24.00,74.00,24.00,74.00,0.000,0.000,500.000,0.000,1),
  (206,'TOSTADAS CHARRAS 350G',0,0,3,0,0,'TCM951030A17','','','','',1,9.50,171.00,18,0.00,0.00,0,1,12.00,185.00,12.00,185.00,12.00,185.00,3.000,0.000,500.000,0.000,1),
  (207,'VASO DESECHABLE 50PZ',0,0,3,0,0,'MPR050809NK7','','','','',1,0.13,6.40,20,0.00,0.00,1,1,0.50,13.00,0.50,13.00,0.50,13.00,0.000,0.000,500.000,0.000,1),
  (208,'TORTILLA NACHO BARCEL BOLSA 3KG',0,0,3,0,0,'BAR011108CC6','','','','',1,18.00,54.00,3,0.00,0.00,1,1,22.00,60.00,22.00,60.00,22.00,60.00,0.000,0.000,500.000,0.000,1),
  (209,'VINAGRE BLANCO BARRILITO 1 LT',0,0,3,0,0,'DDI870402E71','','','','',1,5.00,60.00,12,0.00,0.00,1,1,7.00,84.00,6.50,78.00,6.00,72.00,0.000,0.000,500.000,0.000,1),
  (210,'VINAGRE OBSCURO BARRILITO 3.9LT',0,0,3,0,0,'DDI870402E71','','','','',1,14.90,59.60,4,0.00,0.00,1,0,18.00,0.00,17.00,0.00,16.00,0.00,0.000,0.000,500.000,0.000,1),
  (211,'VINAGRE OBSCURO BARRILITO 1LT',0,0,3,0,0,'DDI870402E71','','','','',1,5.00,60.00,12,0.00,0.00,1,1,7.00,84.00,6.50,78.00,6.00,72.00,0.000,0.000,500.000,0.000,1),
  (212,'VINAGRE MANZANA BARRILITO 1LT',0,0,3,0,0,'DDI870402E71','','','','',1,8.13,97.60,12,0.00,0.00,0,1,11.00,120.00,11.00,120.00,11.00,120.00,0.000,0.000,500.000,0.000,1),
  (213,'VINAGRE MANZANA BARRILITO 3.9LT',0,0,3,0,0,'DDI870402E71','','','','',1,24.40,97.60,4,0.00,0.00,1,1,29.00,116.00,28.50,114.00,28.00,112.00,0.000,0.000,500.000,0.000,1),
  (214,'ACEITE PAM 170G',0,0,3,0,0,'NWM9709244W4','','','','',1,26.60,53.20,2,0.00,0.00,1,1,32.00,64.00,31.50,63.00,31.00,62.00,0.000,0.000,500.000,0.000,1),
  (215,'ACEITE OLEICO 3.7LT',0,0,3,0,0,'NWM9709244W4','','','','',1,110.23,0.00,0,0.00,0.00,1,0,127.00,0.00,126.50,0.00,126.00,0.00,0.000,0.000,500.000,0.000,1),
  (216,'ACEITE DE OLIVA EXTRA VIRGEN 3LT',0,0,3,0,0,'NWM9709244W4','','','','',1,188.64,0.00,0,0.00,0.00,1,0,225.00,0.00,224.50,0.00,224.00,0.00,0.000,0.000,500.000,0.000,1),
  (217,'ADEREZOS  VARIOS 709ML',0,0,3,0,0,'NWM9709244W4','','','','',1,29.16,29.16,1,0.00,0.00,0,0,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,500.000,0.000,1),
  (218,'ARROZ MORELOS 1KG',0,0,3,0,0,'SAHUAYO','','','','',1,9.20,230.00,25,0.00,0.00,1,1,12.00,255.00,11.50,255.00,11.00,255.00,0.000,0.000,500.000,0.000,1),
  (219,'AVENA 3 MINUTOS  400G',0,0,3,0,0,'NWM9709244W4','','','','',1,9.04,333.00,36,0.00,0.00,1,1,15.00,540.00,14.50,522.00,14.00,504.00,0.000,0.000,500.000,0.000,1),
  (220,'AVENA QUAKER OATS 1.190KG',0,0,3,0,0,'NWM9709244W4','','','','',1,34.68,0.00,0,0.00,0.00,0,0,39.00,0.00,39.00,0.00,39.00,0.00,0.000,0.000,500.000,0.000,1),
  (221,'AJAX BICLORO 388G',0,0,3,0,0,'SCORPION','','','','',1,7.95,0.00,0,0.00,0.00,0,0,12.00,0.00,12.00,0.00,12.00,0.00,0.000,0.000,500.000,0.000,1),
  (222,'AJAX BICLORO 582G',0,0,3,0,0,'NWM9709244W4','','','','',1,10.01,40.03,4,0.00,0.00,1,1,14.50,58.00,14.00,56.00,13.50,54.00,0.000,0.000,500.000,0.000,1),
  (223,'CAFE LEGAL SOLUBLE EXH. C/20',0,0,3,0,0,'ABARR. ALEX','','','','',1,33.50,201.00,6,0.00,0.00,1,0,37.00,0.00,36.00,0.00,35.00,0.00,0.000,0.000,500.000,0.000,1),
  (224,'CAFE LEGAL BOLSA  400G',0,0,3,0,0,'SAHUAYO','','','','',1,22.71,545.00,24,0.00,0.00,1,1,28.00,672.00,27.50,660.00,27.00,648.00,0.000,0.000,500.000,0.000,1),
  (225,'CAFE LEGAL BOLSA  200G',0,0,3,0,0,'SAHUAYO','','','','',1,11.35,545.00,48,0.00,0.00,1,1,16.00,768.00,15.50,744.00,15.00,720.00,0.000,0.000,500.000,0.000,1),
  (226,'CAL-C-TOSE BOTE 1.900KG',0,0,3,0,0,'NWM9709244W4','','','','',1,86.96,86.96,1,0.00,0.00,1,0,98.00,0.00,98.00,0.00,98.00,0.00,0.000,0.000,500.000,0.000,1),
  (227,'CAL-C-TOSE BOTE 200G',0,0,3,0,0,'SAHUAYO','','','','',1,10.67,320.00,30,0.00,0.00,1,0,15.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,1),
  (228,'CANDEREL',0,0,3,0,0,'NWM9709244W4','','','','',1,0.24,144.75,600,0.00,0.00,1,1,0.38,228.00,0.28,168.00,0.28,168.00,0.000,0.000,500.000,0.000,1),
  (229,'CATSUP HEINZ PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.22,44.45,200,0.00,0.00,1,1,0.40,80.00,0.28,56.00,0.28,56.00,0.000,0.000,500.000,0.000,1),
  (230,'CERILLOS TALISMAN',0,0,3,0,0,'NWM9709244W4','','','','',1,0.65,32.50,50,0.00,0.00,1,1,1.00,38.00,1.00,50.00,1.00,38.00,0.000,0.000,500.000,0.000,1),
  (231,'CORN FLAKES 900G',0,0,3,0,0,'NWM9709244W4','','','','',1,33.66,0.00,0,0.00,0.00,0,0,42.00,0.00,42.00,0.00,42.00,0.00,0.000,0.000,500.000,0.000,1),
  (232,'CORN FLAKES 220G',0,0,3,0,0,'NWM9709244W4','','','','',1,9.67,58.00,6,0.00,0.00,1,0,15.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,1),
  (233,'CHOCO KRISPIS 1.19KG',0,0,3,0,0,'NWM9709244W4','','','','',1,54.73,0.00,0,0.00,0.00,0,0,68.00,0.00,68.00,0.00,68.00,0.00,0.000,0.000,500.000,0.000,1),
  (234,'CHOCO MILK BOTE 1.900KG',0,0,3,0,0,'NWM9709244W4','','','','',1,81.74,0.00,0,0.00,0.00,0,0,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,500.000,0.000,1),
  (235,'DECAF 50G',0,0,3,0,0,'NWM9709244W4','','','','',1,14.67,176.00,12,0.00,0.00,1,1,20.00,240.00,19.50,234.00,19.00,228.00,0.000,0.000,500.000,0.000,1),
  (236,'DECAF 200G',0,0,3,0,0,'NWM9709244W4','','','','',1,47.67,572.00,12,0.00,0.00,1,1,54.00,648.00,53.50,642.00,53.00,636.00,0.000,0.000,500.000,0.000,1),
  (237,'CHOCO MILK EXH. C/20 SOBRES 25G C/U',0,0,3,0,0,'NWM9709244W4','','','','',1,1.75,35.04,20,0.00,0.00,1,1,2.50,50.00,2.25,45.00,2.10,42.00,0.000,0.000,500.000,0.000,1),
  (238,'ENCENDEDOR TOKAI',0,0,3,0,0,'DULCERAMA','','','','',1,2.94,73.50,25,0.00,0.00,0,1,5.00,80.00,5.00,80.00,5.00,80.00,0.000,0.000,500.000,0.000,1),
  (239,'ENCENDEDOR TOKAI CAJA C/25',0,0,3,0,0,'DULCERAMA','','','','',1,2.76,69.00,25,0.00,0.00,1,0,5.00,0.00,4.00,0.00,39.00,0.00,0.000,0.000,500.000,0.000,0),
  (240,'FLAN JELLO-O 84G',0,0,3,0,0,'NWM9709244W4','','','','',1,5.02,30.13,6,0.00,0.00,1,1,8.00,39.00,8.00,39.00,8.00,39.00,0.000,0.000,500.000,0.000,1),
  (241,'CIGARROS MARLBORO',0,0,3,0,0,'NWM9709244W4','','','','',1,22.47,224.70,10,0.00,0.00,0,1,25.00,235.00,25.00,235.00,25.00,235.00,0.000,0.000,500.000,0.000,1),
  (242,'CIGARROS MONTANA',0,0,3,0,0,'NWM9709244W4','','','','',1,18.00,180.00,10,0.00,0.00,1,1,21.00,199.00,19.90,199.00,19.90,199.00,0.000,0.000,500.000,0.000,1),
  (243,'CIGARROS BENSON & HEDGES',0,0,3,0,0,'NWM9709244W4','','','','',1,22.47,224.70,10,0.00,0.00,0,1,25.00,235.00,25.00,235.00,25.00,235.00,0.000,0.000,500.000,0.000,1),
  (244,'CIGARROS CAMEL',0,0,3,0,0,'NWM9709244W4','','','','',1,22.49,224.90,10,0.00,0.00,0,1,25.00,235.00,25.00,235.00,25.00,235.00,0.000,0.000,500.000,0.000,1),
  (245,'PAN INTEGRAL 100% 680G',0,0,3,0,0,'BIM011108DJ5','','','','',1,14.35,0.00,0,0.00,0.00,1,0,18.00,0.00,17.00,0.00,16.00,0.00,0.000,0.000,500.000,0.000,1),
  (246,'SUPERPAN C/AJONJOLI 680G',0,0,3,0,0,'BIM011108DJ5','','','','',1,14.75,0.00,0,0.00,0.00,1,0,18.00,0.00,17.00,0.00,16.50,0.00,0.000,0.000,500.000,0.000,1),
  (247,'SUPER HOT-DOGS',0,0,3,0,0,'BIM011108DJ5','','','','',1,13.95,0.00,0,0.00,0.00,1,0,18.00,0.00,17.00,0.00,16.50,0.00,0.000,0.000,500.000,0.000,1),
  (248,'TUINKY  114G',0,0,3,0,0,'BIM011108DJ5','','','','',1,5.60,0.00,0,0.00,0.00,1,0,7.00,0.00,6.50,0.00,6.20,0.00,0.000,0.000,500.000,0.000,1),
  (249,'BASE P/PIZZA FIGATZA 345G',0,0,3,0,0,'BIM011108DJ5','','','','',1,9.60,9.00,1,0.00,0.00,1,0,12.00,0.00,11.80,0.00,11.50,0.00,0.000,0.000,500.000,0.000,1),
  (250,'GALLETA AVENA TIA ROSA',0,0,3,0,0,'BIM011108DJ5','','','','',1,3.20,0.00,0,0.00,0.00,1,0,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (251,'POLVORON TIA ROSA',0,0,3,0,0,'BIM011108DJ5','','','','',1,2.00,0.00,0,0.00,0.00,1,0,2.50,0.00,2.50,0.00,2.50,0.00,0.000,0.000,501.000,0.000,1),
  (252,'MANTECADAS TIA ROSA 2PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,4.80,0.00,0,0.00,0.00,1,0,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,500.000,0.000,1),
  (253,'CONCHAS TIA ROSA 2 PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,6.40,0.00,0,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.50,0.00,0.000,0.000,500.000,0.000,1),
  (254,'BIGOTE CHOCOLATE  TIA ROSA',0,0,3,0,0,'BIM011108DJ5','','','','',1,4.00,0.00,0,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,1),
  (255,'MINI BIGOTES TIA ROSA 65G',0,0,3,0,0,'BIM011108DJ5','','','','',1,4.80,0.00,0,0.00,0.00,1,0,6.00,0.00,6.00,0.00,5.80,0.00,0.000,0.000,500.000,0.000,1),
  (256,'CUERNITOS TIA ROSA 2PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,5.60,0.00,0,0.00,0.00,1,0,7.00,0.00,7.00,0.00,6.50,0.00,0.000,0.000,500.000,0.000,1),
  (257,'DORADITAS TIA ROSA 2PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,4.00,0.00,0,0.00,0.00,1,0,5.00,0.00,5.00,0.00,4.80,0.00,0.000,0.000,500.000,0.000,1),
  (258,'FROOT LOOPS 765G',0,0,3,0,0,'NWM9709244W4','','','','',1,50.02,50.02,1,0.00,0.00,0,0,63.00,0.00,63.00,0.00,63.00,0.00,0.000,0.000,500.000,0.000,1),
  (259,'FABULOSO  1LT',0,0,3,0,0,'SAHUAYO','','','','',1,11.21,134.50,12,0.00,0.00,1,1,15.00,150.00,15.00,150.00,15.00,150.00,0.000,0.000,500.000,0.000,1),
  (260,'FABULOSO 500ML',0,0,3,0,0,'SAHUAYO','','','','',1,5.90,141.50,24,0.00,0.00,1,1,10.00,155.00,10.00,155.00,10.00,155.00,0.000,0.000,500.000,0.000,1),
  (261,'SALADITAS PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.25,50.00,200,0.00,0.00,1,1,0.38,76.00,0.38,76.00,0.38,76.00,0.000,0.000,500.000,0.000,1),
  (262,'GALLETAS SURTIDAS MINI PAKETINES',0,0,3,0,0,'OCM870210PC6','','','','',1,1.55,62.00,40,0.00,0.00,0,1,2.50,72.00,2.50,72.00,2.50,72.00,0.000,0.000,500.000,0.000,1),
  (263,'GALLETAS MINI PAKETINES CAJA C/40',0,0,3,0,0,'OCM870210PC6','','','','',1,1.63,65.00,40,0.00,0.00,1,0,5.00,0.00,49.00,0.00,38.00,0.00,0.000,0.000,500.000,0.000,1),
  (264,'GALLETAS BOMBITOS 135G',0,0,3,0,0,'DULCERAMA','','','','',1,3.30,33.00,10,0.00,0.00,0,1,5.00,42.00,5.00,42.00,5.00,42.00,0.000,0.000,500.000,0.000,1),
  (265,'GALLETAS BOMBITOS CAJA C/10',0,0,3,0,0,'DULCERAMA','','','','',1,3.30,33.00,10,0.00,0.00,1,0,6.00,0.00,5.00,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (266,'SALADITAS 215G',0,0,3,0,0,'NWM9709244W4','','','','',1,5.00,50.00,10,0.00,0.00,1,0,8.00,0.00,7.00,0.00,6.00,0.00,0.000,0.000,500.000,0.000,0),
  (267,'SALADITAS CAJA C/10PZ 215G C/U',0,0,3,0,0,'OCM870210PC6','','','','',1,5.10,51.00,10,0.00,0.00,1,1,7.00,70.00,6.50,65.00,6.50,65.00,0.000,0.000,500.000,0.000,1),
  (268,'HERSHEY´S BEBIDA 236ML',0,0,3,0,0,'DMA0106263S9','MEG0202151X5','','','',1,4.63,125.00,27,0.00,0.00,0,1,6.50,143.00,6.50,143.00,6.50,143.00,0.000,0.000,500.000,0.000,1),
  (269,'HARINA HOT CAKES PRONTO 500G',0,0,3,0,0,'NWM9709244W4','','','','',1,12.98,38.93,3,0.00,0.00,1,1,17.00,51.00,16.50,49.50,16.00,48.00,0.000,0.000,500.000,0.000,1),
  (270,'JARABE HERSEY 3.4LT',0,0,3,0,0,'NWM9709244W4','','','','',1,80.25,0.00,0,0.00,0.00,0,0,98.00,0.00,98.00,0.00,98.00,0.00,0.000,0.000,500.000,0.000,1),
  (271,'JABON ZOTE 400G',0,0,3,0,0,'TAB890412AK8','','','','',1,5.34,133.50,25,0.00,0.00,0,1,8.00,150.00,8.00,150.00,8.00,150.00,0.000,0.000,500.000,0.000,1),
  (272,'JABON LIRIO 400G',0,0,3,0,0,'NWM9709244W4','','','','',1,4.63,55.60,12,0.00,0.00,0,1,7.00,62.00,7.00,62.00,7.00,62.00,0.000,0.000,500.000,0.000,1),
  (273,'JABON ZEST 200G',0,0,3,0,0,'SCORPION','','','','',1,7.08,509.76,72,0.00,0.00,0,1,8.50,535.00,8.50,535.00,8.50,535.00,0.000,0.000,500.000,0.000,1),
  (274,'JABON PALMOLIVE 200G',0,0,3,0,0,'NWM9709244W4','','','','',1,5.71,411.00,72,0.00,0.00,0,1,8.00,430.00,8.00,430.00,8.00,430.00,0.000,0.000,500.000,0.000,1),
  (275,'HARINA DE ARROZ 3 ESTRELLAS 500G',0,0,3,0,0,'SCORPION','','','','',1,5.16,123.90,24,0.00,0.00,1,1,9.00,216.00,8.50,204.00,8.00,192.00,0.000,0.000,500.000,0.000,1),
  (276,'LECHE EVAPORADA CLAVEL 1LT',0,0,3,0,0,'MEG0202151X5','','','','',1,23.75,285.00,12,0.00,0.00,1,1,30.00,360.00,29.50,354.00,29.00,348.00,0.000,0.000,500.000,0.000,1),
  (277,'LECHE NIDO 2.5KG',0,0,3,0,0,'NWM9709244W4','','','','',1,181.58,181.58,1,0.00,0.00,0,1,185.00,185.00,185.00,185.00,185.00,185.00,0.000,0.000,500.000,0.000,1),
  (278,'MAIZENA SABORES 47G',0,0,3,0,0,'SCORPION','','','','',1,2.91,116.52,40,0.00,0.00,1,1,4.00,160.00,3.30,132.00,3.30,132.00,0.000,0.000,500.000,0.000,1),
  (279,'MAIZENA 160G',0,0,3,0,0,'NWM9709244W4','','','','',1,5.07,60.82,12,0.00,0.00,1,1,9.00,108.00,8.50,102.00,8.00,96.00,0.000,0.000,500.000,0.000,1),
  (280,'MANTECA INCA 1KG',0,0,3,0,0,'SAHUAYO','','','','',1,15.00,180.00,12,0.00,0.00,1,1,19.00,228.00,18.50,222.00,18.00,216.00,0.000,0.000,500.000,0.000,1),
  (281,'LAUTREC PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.27,68.44,250,0.00,0.00,1,1,0.40,100.00,0.31,77.50,0.31,77.50,0.000,0.000,500.000,0.000,1),
  (282,'VELADORA ESMERALDA NO.2',0,0,3,0,0,'SCORPION','','','','',1,28.67,172.00,6,0.00,0.00,1,0,31.00,0.00,30.00,0.00,29.00,0.00,0.000,0.000,500.000,0.000,0),
  (283,'PASTA DENTAL CREST 124G',0,0,3,0,0,'TAB890412AK8','','','','',1,6.75,269.90,40,0.00,0.00,1,1,10.00,290.00,10.00,400.00,10.00,400.00,0.000,0.000,500.000,0.000,1),
  (284,'CAL-C-TOSE C/LECHE BOTE 360G',0,0,3,0,0,'NWM9709244W4','','','','',1,39.00,39.00,1,0.00,0.00,1,1,47.00,47.00,47.00,47.00,47.00,47.00,0.000,0.000,500.000,0.000,1),
  (285,'PAPEL HIGIENICO CHARMIN MANZ, C/4',0,0,3,0,0,'SAHUAYO','NWM9709244W4','','','',1,9.50,95.00,10,0.00,0.00,1,1,13.00,130.00,11.00,110.00,10.50,105.00,0.000,0.000,500.000,0.000,1),
  (286,'PAPEL HIGIENICO PETALO C/4 PZ',0,0,3,0,0,'SAHUAYO','','','','',1,8.73,209.50,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (287,'PINOL 1LT',0,0,3,0,0,'SAHUAYO','','','','',1,12.40,186.00,15,0.00,0.00,1,1,15.00,225.00,14.50,217.50,14.00,210.00,0.000,0.000,500.000,0.000,1),
  (288,'PINOL 500ML',0,0,3,0,0,'NWM9709244W4','','','','',1,7.10,142.00,20,0.00,0.00,1,1,9.00,180.00,8.50,170.00,8.00,160.00,0.000,0.000,500.000,0.000,1),
  (289,'CIGARROS RALEIGH',0,0,3,0,0,'NWM9709244W4','','','','',1,18.95,189.50,10,0.00,0.00,1,1,22.00,208.00,20.80,208.00,20.80,208.00,0.000,0.000,500.000,0.000,1),
  (290,'SARDINA YAVAROS 425G',0,0,3,0,0,'TAB890412AK8','','','','',1,7.98,47.88,6,0.00,0.00,1,1,12.50,75.00,12.00,72.00,11.50,69.00,0.000,0.000,500.000,0.000,1),
  (291,'SALSA INGLESA 980ML',0,0,3,0,0,'NWM9709244W4','','','','',1,40.82,244.92,6,0.00,0.00,1,1,48.00,288.00,47.50,285.00,47.00,282.00,0.000,0.000,500.000,0.000,1),
  (292,'SALSA INGLESA 145ML',0,0,3,0,0,'NWM9709244W4','','','','',1,10.54,63.22,6,0.00,0.00,1,1,16.00,96.00,15.50,93.00,15.00,90.00,0.000,0.000,500.000,0.000,1),
  (293,'SALSA DE SOYA KIKKOMAN 296ML',0,0,3,0,0,'NWM9709244W4','','','','',1,23.99,47.98,2,0.00,0.00,0,0,29.00,0.00,29.00,0.00,29.00,0.00,0.000,0.000,500.000,0.000,1),
  (294,'CREMA CAMPBELL´S ELOTE 430G',0,0,3,0,0,'NWM9709244W4','','','','',1,13.56,54.22,4,0.00,0.00,1,0,16.00,0.00,15.00,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (295,'PALOMAS ACT II MANTEQUILLA',0,0,3,0,0,'SAHUAYO','','','','',1,3.22,57.90,18,0.00,0.00,1,1,4.50,81.00,4.00,72.00,4.00,72.00,0.000,0.000,500.000,0.000,1),
  (296,'MAYONESA SQUEEZABLE COSTEÑA 330G',0,0,3,0,0,'CCO820507BV4','','','','',1,10.90,261.69,24,0.00,0.00,1,1,14.00,336.00,13.50,324.00,13.00,312.00,0.000,0.000,500.000,0.000,1),
  (297,'MAYONESA SQUEEZABLE COSTEÑA 450G',0,0,3,0,0,'CCO820507BV4','','','','',1,14.34,172.02,12,0.00,0.00,1,1,17.00,204.00,16.50,198.00,16.00,192.00,0.000,0.000,500.000,0.000,1),
  (298,'CHILE TAJIN POLVO 150G',0,0,3,0,0,'NWM9709244W4','','','','',1,8.90,35.60,4,0.00,0.00,1,1,15.00,60.00,14.50,58.00,14.00,56.00,0.000,0.000,500.000,0.000,1),
  (299,'GERBER 100G',0,0,3,0,0,'SAHUAYO','','','','',1,4.08,97.90,24,0.00,0.00,1,1,6.50,156.00,6.00,144.00,5.50,132.00,0.000,0.000,500.000,0.000,1),
  (300,'MISTY LIMPIADOR 1LT',0,0,3,0,0,'DDI870402E71','','','','',1,8.00,96.00,12,0.00,0.00,1,1,11.00,132.00,10.50,126.00,10.00,120.00,0.000,0.000,500.000,0.000,1),
  (301,'GATORADE 500ML',0,0,2,0,0,'SNO950601EB5','','','','',1,8.08,194.00,24,0.00,0.00,1,1,13.00,312.00,9.50,228.00,9.50,228.00,0.000,0.000,500.000,0.000,1),
  (302,'PURE DE TOMATE COSTEÑA COND. 1KG',0,0,3,0,0,'CCO820507BV4','','','','',1,7.20,86.41,12,0.00,0.00,1,1,11.00,132.00,10.50,126.00,10.00,120.00,0.000,0.000,500.000,0.000,1),
  (303,'CATSUP SQUEZABLE COSTEÑA 400G',0,0,3,0,0,'CCO820507BV4','','','','',1,8.22,197.29,24,0.00,0.00,1,0,15.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,1),
  (304,'ALL BRAN FLAKES 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,43.99,43.99,1,0.00,0.00,0,0,48.00,0.00,48.00,0.00,48.00,0.00,0.000,0.000,500.000,0.000,1),
  (305,'EXTRA KELLOGG´S 725G',0,0,3,0,0,'NWM9709244W4','','','','',1,46.96,46.96,1,0.00,0.00,0,0,55.00,0.00,55.00,0.00,55.00,0.00,0.000,0.000,500.000,0.000,1),
  (306,'ZUCARITAS 1.120KG',0,0,3,0,0,'NWM9709244W4','','','','',1,42.86,0.00,0,0.00,0.00,1,0,53.00,0.00,53.00,0.00,50.00,0.00,0.000,0.000,500.000,0.000,1),
  (307,'NESCAFE TASTER´S CHOICE 283G',0,0,3,0,0,'NWM9709244W4','','','','',1,126.85,126.85,1,0.00,0.00,0,0,130.00,0.00,130.00,0.00,130.00,0.00,0.000,0.000,500.000,0.000,1),
  (308,'VAINILLA ARVI 1LT',0,0,3,0,0,'DDI870402E71','','','','',1,10.00,150.00,15,0.00,0.00,1,0,15.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,1),
  (309,'NESCAFE CLASICO BOTE 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,184.65,184.65,1,0.00,0.00,0,0,195.00,0.00,195.00,0.00,195.00,0.00,0.000,0.000,500.000,0.000,1),
  (310,'NESCAFE CLASICO 300G',0,0,3,0,0,'NWM9709244W4','','','','',1,60.62,121.23,2,0.00,0.00,1,1,69.00,138.00,68.50,137.00,68.00,136.00,0.000,0.000,500.000,0.000,1),
  (311,'LECHE POLVO SVELTY 1.8KG',0,0,3,0,0,'NWM9709244W4','','','','',1,152.22,152.22,1,0.00,0.00,0,0,175.00,0.00,175.00,0.00,175.00,0.00,0.000,0.000,500.000,0.000,1),
  (312,'CLAMATO 1LT',0,0,3,0,0,'SNO950601EB5','','','','',1,21.00,252.00,12,0.00,0.00,1,0,26.00,0.00,25.00,0.00,24.00,0.00,0.000,0.000,500.000,0.000,1),
  (313,'CAJETA CORONADO 370G',0,0,3,0,0,'NWM9709244W4','','','','',1,21.58,539.60,25,0.00,0.00,1,1,28.00,700.00,27.50,687.50,27.00,675.00,0.000,0.000,500.000,0.000,1),
  (314,'MAYONESA HELLMANN´S MAYO 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,33.45,0.00,0,0.00,0.00,1,0,48.00,0.00,48.00,0.00,48.00,0.00,0.000,0.000,500.000,0.000,1),
  (315,'MOLE DOÑA MARIA 235G',0,0,3,0,0,'NWM9709244W4','','','','',1,14.98,59.95,4,0.00,0.00,1,1,19.00,76.00,18.50,74.00,18.00,72.00,0.000,0.000,500.000,0.000,1),
  (316,'COFFEE-MATE 311G',0,0,3,0,0,'SCORPION','','','','',1,18.54,222.50,12,0.00,0.00,1,1,26.00,312.00,25.50,306.00,25.00,300.00,0.000,0.000,500.000,0.000,1),
  (317,'ALL BRAN BEBIDA 235ML',0,0,3,0,0,'NWM9709244W4','','','','',1,5.66,158.46,28,0.00,0.00,0,1,7.00,168.00,7.00,168.00,7.00,168.00,0.000,0.000,500.000,800.000,1),
  (318,'SUAVITEL 850ML',0,0,3,0,0,'NWM9709244W4','','','','',1,8.58,103.00,12,0.00,0.00,1,1,15.00,180.00,14.50,174.00,14.00,168.00,0.000,0.000,500.000,0.000,1),
  (319,'SUAVITEL 500ML',0,0,3,0,0,'SCORPION','','','','',1,6.62,158.90,24,0.00,0.00,1,1,9.50,180.00,7.50,180.00,7.50,180.00,0.000,0.000,500.000,0.000,1),
  (320,'MICRODYN 15ML',0,0,3,0,0,'TCM951030A17','','','','',1,11.84,0.00,0,0.00,0.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,500.000,0.000,1),
  (321,'SOPA MODERNA 200G *',0,0,3,0,0,'LA CONCHITA','','','','',1,2.60,52.00,20,0.00,0.00,1,1,3.00,60.00,2.90,58.00,2.90,58.00,0.000,0.000,500.000,0.000,0),
  (322,'SOPA MODERNA 200G',0,0,3,0,0,'LA CONCHITA','','','','',1,2.60,51.50,20,0.00,0.00,0,1,3.50,58.00,3.50,58.00,3.50,58.00,0.000,0.000,500.000,0.000,1),
  (323,'DURAZNOS COSTEÑA MITADES 3KG',0,0,3,0,0,'CCO820507BV4','','','','',1,45.05,270.31,6,0.00,0.00,1,1,58.00,348.00,57.50,345.00,57.00,342.00,0.000,0.000,500.000,0.000,1),
  (324,'JUGO DE PIÑA TORRE 2850ML',0,0,3,0,0,'CTO840701QT0','','','','',1,35.69,214.13,6,0.00,0.00,1,1,45.00,270.00,44.50,267.00,44.00,264.00,0.000,0.000,500.000,0.000,1),
  (325,'CHONGOS ZAMORANOS MISION 3.5KG',0,0,3,0,0,'NORTEÑA','','','','',1,102.00,612.00,6,0.00,0.00,0,1,125.00,670.00,125.00,670.00,125.00,670.00,0.000,0.000,500.000,0.000,1),
  (326,'OREJITAS 9PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,6.40,5.60,1,0.00,0.00,1,0,8.00,0.00,8.00,0.00,7.50,0.00,0.000,0.000,500.000,0.000,1),
  (327,'JUGO DEL VALLE 408ML',0,0,3,0,0,'MARCOS','','','','',1,5.21,125.00,24,0.00,0.00,1,1,8.00,192.00,7.50,180.00,7.00,168.00,0.000,0.000,500.000,0.000,1),
  (328,'KNOOR SUIZA C/2 CUBOS',0,0,3,0,0,'NWM9709244W4','','','','',1,2.21,110.48,50,0.00,0.00,1,1,3.00,150.00,3.00,150.00,3.00,150.00,0.000,0.000,500.000,0.000,1),
  (329,'PINOL 10LT',0,0,3,0,0,'NWM9709244W4','','','','',1,91.54,0.00,0,0.00,0.00,0,0,125.00,0.00,125.00,0.00,125.00,0.00,0.000,0.000,500.000,0.000,1),
  (330,'AVENA QUAKER OATS 510G',0,0,3,0,0,'OCM870210PC6','','','','',1,13.50,324.00,24,0.00,0.00,1,1,19.00,456.00,18.50,444.00,18.00,432.00,0.000,0.000,500.000,0.000,1),
  (331,'ALUMINIO ALU-REY',0,0,3,0,0,'SAHUAYO','','','','',1,7.88,189.00,24,0.00,0.00,1,1,11.00,264.00,10.50,252.00,10.00,240.00,0.000,0.000,500.000,0.000,1),
  (332,'SUSTITUTO DE CREMA 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,27.75,333.12,12,0.00,0.00,0,1,35.00,360.00,35.00,360.00,35.00,360.00,0.000,0.000,500.000,0.000,1),
  (333,'CEPILLO DENTAL',0,0,3,0,0,'NWM9709244W4','','','','',1,3.65,43.75,12,0.00,0.00,0,0,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (334,'KNORR SUIZA 2KG',0,0,3,0,0,'NWM9709244W4','','','','',1,95.60,95.60,1,0.00,0.00,0,0,100.00,0.00,100.00,0.00,100.00,0.00,0.000,0.000,500.000,0.000,1),
  (335,'KNORR SUIZA  BOLSA 800G',0,0,3,0,0,'SAHUAYO','','','','',1,39.50,475.00,12,0.00,0.00,1,1,48.00,576.00,47.50,570.00,47.00,564.00,0.000,0.000,500.000,0.000,1),
  (336,'NESQUIK POLVO BOTE 2KG',0,0,3,0,0,'NWM9709244W4','','','','',1,77.24,0.00,0,0.00,0.00,0,0,90.00,0.00,90.00,0.00,90.00,0.00,0.000,0.000,500.000,0.000,1),
  (337,'CAL-CTOSE LECHE C/CHOC.  BOTE 920G',0,0,3,0,0,'TCM951030A17','','','','',1,84.50,84.50,1,0.00,0.00,1,1,95.00,95.00,95.00,95.00,95.00,95.00,0.000,0.000,500.000,0.000,1),
  (338,'MINSA 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,5.79,57.90,10,0.00,0.00,1,1,9.50,95.00,9.00,90.00,8.50,85.00,0.000,0.000,500.000,0.000,1),
  (339,'COFFEE-MATE 170G',0,0,3,0,0,'SCORPION','','','','',1,11.53,138.40,12,0.00,0.00,1,0,15.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,1),
  (340,'KNORR SUIZA 3.5KG',0,0,3,0,0,'NWM9709244W4','','','','',1,180.00,720.00,4,0.00,0.00,1,0,195.00,0.00,194.00,0.00,193.00,0.00,0.000,0.000,500.000,0.000,1),
  (341,'SAL DE MESA LA NUESTRA 1KG',0,0,3,0,0,'SAHUAYO','','','','',1,2.80,70.00,25,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (342,'MERMELADA SMUCKER´S 340G',0,0,3,0,0,'NWM9709244W4','','','','',1,15.99,47.98,3,0.00,0.00,1,1,21.00,63.00,20.50,61.50,20.00,60.00,0.000,0.000,500.000,0.000,1),
  (343,'PALILLO SALERO C/250PZ',0,0,3,0,0,'ALCEDA','','','','',1,2.59,51.75,20,0.00,0.00,0,1,5.00,58.00,5.00,58.00,5.00,58.00,0.000,0.000,500.000,0.000,1),
  (344,'KNORR SUIZA 100G',0,0,3,0,0,'NWM9709244W4','','','','',1,9.02,216.50,24,0.00,0.00,1,1,18.00,432.00,17.50,420.00,17.00,408.00,0.000,0.000,500.000,0.000,1),
  (345,'CERVEZA SOL BRAVA 1.180ML',0,0,3,0,0,'CUAUHTEMOC','','','','',1,10.83,130.00,12,0.00,0.00,1,0,14.00,0.00,13.00,0.00,12.00,0.00,0.000,0.000,500.000,0.000,0),
  (346,'TOALLA ALWAYS  C/10PZ',0,0,3,0,0,'NWM9709244W4','','','','',1,1.38,165.00,120,0.00,0.00,1,1,3.50,190.00,1.90,190.00,1.90,190.00,0.000,0.000,500.000,0.000,1),
  (347,'SOPA MARUCHAN C/12PZ',0,0,3,0,0,'LA CONCHITA','','','','',1,3.08,36.90,12,0.00,0.00,1,1,5.00,40.00,5.00,40.00,5.00,39.50,0.000,0.000,500.000,0.000,1),
  (348,'LECHERA CUBETA',1,0,1,0,0,'PAL010828UR4','','','','',2,0.00,0.00,0,18.00,25.00,0,2,25.00,19.60,25.00,19.60,25.00,19.60,0.000,0.000,490.075,0.000,1),
  (349,'AZUCAR BULTO 50KG',1,0,3,0,0,'TAB890412AK8','','','','',2,0.00,0.00,0,6.50,50.00,1,0,8.00,0.00,8.00,0.00,8.00,0.00,0.000,0.000,490.075,0.000,1),
  (350,'ACEITUNA VERDE',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,23.08,13.00,1,0,26.00,0.00,25.00,0.00,24.00,0.00,0.000,0.000,490.075,24.012,1),
  (351,'ACEITUNA VERDE BARRICA',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,25.00,150.00,1,0,30.00,0.00,29.00,0.00,28.00,0.00,0.000,0.000,490.075,0.000,1),
  (352,'ATE FLOR DE MORELIA',1,0,1,0,0,'DMA0106263S9','','','','',2,0.00,0.00,0,17.50,6.00,1,2,28.00,22.50,28.00,22.50,28.00,22.50,0.000,0.000,490.075,0.000,1),
  (353,'CHILES GUEROS 36KG',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,33.00,10.00,1,0,40.00,0.00,39.00,0.00,38.00,0.00,0.000,0.000,490.075,0.000,1),
  (354,'CHILES SUELTOS',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,25.00,1.00,1,0,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,490.075,0.000,1),
  (355,'CAJETA NATURAL 25KG',1,0,1,0,0,'NATURAL FRUT','','','','',2,0.00,0.00,0,13.60,25.00,1,2,18.00,365.00,18.00,365.00,18.00,365.00,0.000,0.000,490.075,0.000,1),
  (356,'CAJETA RICA FRUT 25KG',1,0,1,0,0,'RICA FRUT','','','','',2,0.00,0.00,0,12.40,25.00,1,2,18.00,360.00,18.00,360.00,18.00,360.00,0.000,0.000,490.075,0.000,1),
  (357,'CAJETA NATURAL 5KG',1,0,1,0,0,'NATURAL FRUT','','','','',2,0.00,0.00,0,15.00,5.00,1,0,18.00,0.00,17.00,0.00,16.00,0.00,0.000,0.000,490.075,0.000,1),
  (358,'Pan Blanco Bimbo Grande',0,0,3,0,0,'BIM011108DJ5','','','','',1,13.70,0.00,0,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,300.000,10.000,500.000,0.000,0),
  (359,'PAN BLANCO GRANDE BIMBO',0,0,3,0,0,'BIM011108DJ5','','','','',1,14.95,0.00,0,0.00,0.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,500.000,0.000,1),
  (360,'PAN INTEGRAL GRANDE BIMBO',0,0,3,0,0,'BIM011108DJ5','','','','',1,15.60,0.00,0,0.00,0.00,0,0,19.00,0.00,19.00,0.00,19.00,0.00,0.000,0.000,500.000,0.000,1),
  (361,'PAN TOSTADO DOBLE FIBRA BIMBO',0,0,3,0,0,'BIM011108DJ5','','','','',1,9.00,0.00,0,0.00,0.00,1,0,12.00,0.00,11.50,0.00,11.50,0.00,0.000,0.000,500.000,0.000,1),
  (362,'PAN MOLIDO BIMBO  210G',0,0,3,0,0,'BIM011108DJ5','','','','',1,4.10,0.00,0,0.00,0.00,1,0,5.50,0.00,5.00,0.00,5.00,0.00,0.000,0.000,500.000,0.000,1),
  (363,'MEDIAS NOCHES BIMBO 8PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,9.40,0.00,0,0.00,0.00,0,0,12.50,0.00,12.50,0.00,12.50,0.00,0.000,0.000,500.000,0.000,1),
  (364,'BIMBOLLOS  BIMBO 8PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,13.50,0.00,0,0.00,0.00,1,0,16.50,0.00,16.50,0.00,16.50,0.00,0.000,0.000,501.000,0.000,1),
  (365,'BIMBOLLOS GIGANTES BIMBO  15PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,28.30,0.00,0,0.00,0.00,0,0,32.00,0.00,32.00,0.00,32.00,0.00,0.000,0.000,500.000,0.000,1),
  (366,'TORTILLINAS 10PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,6.40,0.00,0,0.00,0.00,0,0,7.50,0.00,7.50,0.00,7.50,0.00,0.000,0.000,500.000,0.000,1),
  (367,'CONSOME SUELTO 50KG',1,0,3,0,0,'CASA BETY','','','','',2,0.00,0.00,0,10.50,50.00,1,2,15.00,13.00,15.00,13.00,15.00,13.00,0.000,0.000,490.075,0.000,1),
  (368,'CHILE PIQUIN C/LIMON 50KG',1,0,3,0,0,'JOSE LUIS','','','','',2,0.00,0.00,0,10.50,50.00,0,2,15.00,13.00,15.00,13.00,15.00,13.00,0.000,0.000,490.075,0.000,1),
  (369,'HUEVO BLANCO',1,0,3,0,0,'DGR891024CV5','','','','',2,0.00,0.00,0,14.00,22.00,0,2,15.50,15.00,15.50,15.00,15.50,15.00,0.000,0.000,490.075,0.000,1),
  (370,'MERMELADA NATURAL FRUT FRESA 25KG',1,0,3,0,0,'NATURAL FRUT','','','','',2,0.00,0.00,0,8.40,25.00,0,2,15.00,245.00,15.00,245.00,15.00,245.00,0.000,0.000,490.075,0.000,1),
  (371,'MERMELADA',1,0,1,0,0,'MARCO','','','','',2,0.00,0.00,0,7.80,25.00,1,0,9.00,0.00,8.50,0.00,8.00,0.00,0.000,0.000,490.075,0.000,1),
  (372,'MEMELADA RICA FRUT FRESA 25KG',0,0,1,0,0,'GOPJ770312FM9','','','','',1,8.00,200.00,25,0.00,0.00,1,1,15.00,235.00,15.00,235.00,15.00,235.00,0.000,0.000,500.000,0.000,1),
  (373,'MIEL NATURAL FRUT 25KG',1,0,1,0,0,'NATURAL FRUT','','','','',2,0.00,0.00,0,9.20,25.00,0,2,15.00,13.00,15.00,13.00,15.00,13.00,0.000,0.000,490.075,0.000,1),
  (374,'MIEL RICA FRUT 25 KG',1,0,1,0,0,'GOPJ770312FM9','','','','',2,0.00,0.00,0,8.40,25.00,0,2,15.00,13.00,15.00,13.00,15.00,13.00,0.000,0.000,490.075,0.000,1),
  (375,'MOLE SAN FRANCISCO 10KG',1,0,1,0,0,'MOLE','','','','',2,0.00,0.00,0,18.00,10.00,1,2,28.00,220.00,22.00,220.00,22.00,220.00,0.000,0.000,490.075,0.000,1),
  (376,'MOLE CON CAMARON',1,0,1,0,0,'MOLE','','','','',2,0.00,0.00,0,37.00,10.00,1,0,40.00,0.00,49.50,0.00,49.00,0.00,0.000,0.000,490.075,0.000,1),
  (377,'PALO ELOTERO',1,0,1,0,0,'JOSE LUIS','','','','',2,0.00,0.00,0,11.00,30.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,490.075,0.000,1),
  (378,'PALO PARA BANDERILLA',1,0,1,0,0,'JOSE LUIS','','','','',2,0.00,0.00,0,13.50,25.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,0),
  (379,'MANTEQUILLA GLORIA 1KG',0,0,1,0,0,'CAM830905DJ8','','','','',1,41.80,418.00,10,0.00,0.00,1,1,48.00,450.00,48.00,450.00,48.00,450.00,0.000,0.000,500.000,0.000,1),
  (380,'MANTEQUILLA CHIPILO 1KG',0,0,1,0,0,'UNIFOODS','','','','',1,24.20,242.00,10,0.00,0.00,1,1,29.00,290.00,26.50,265.00,26.50,265.00,0.000,0.000,500.000,0.000,1),
  (381,'MARGARINA IBERIA 1KG',0,0,1,0,0,'PLASENCIA','','','','',1,21.50,215.00,10,0.00,0.00,0,1,28.00,250.00,28.00,250.00,28.00,250.00,0.000,0.000,500.000,0.000,1),
  (382,'MARGARINA IBERIA 225 G',0,0,1,0,0,'GLORIA','','','','',1,9.33,84.00,9,0.00,0.00,1,1,12.00,108.00,10.88,98.00,10.88,98.00,0.000,0.000,500.000,0.000,1),
  (383,'MARGARINA IBERIA 90G',0,0,1,0,0,'GLORIA','','','','',1,4.42,106.00,24,0.00,0.00,1,1,7.00,168.00,5.16,124.00,5.16,124.00,0.000,0.000,500.000,0.000,1),
  (384,'MARGARINA FLEX AZUL',0,0,1,0,0,'UNILEVER','','','','',1,15.40,154.00,1,0.00,0.00,1,0,17.00,0.00,16.50,0.00,16.00,0.00,0.000,0.000,500.000,0.000,1),
  (385,'MARGARINA FLEX ROJA',0,0,1,0,0,'UNILEVER','','','','',1,15.40,154.00,10,0.00,0.00,1,0,17.00,0.00,16.50,0.00,16.00,0.00,0.000,0.000,500.000,0.000,1),
  (386,'MARGARINA PRIMAVERA CHANTILLY190G',0,0,1,0,0,'COGM680129LYO','','','','',1,9.83,118.00,12,0.00,0.00,0,1,13.00,130.00,13.00,130.00,13.00,130.00,0.000,0.000,500.000,0.000,1),
  (387,'MARGARINA VENECIA 1 KG',0,0,1,0,0,'CVE9501177P3','','','','',1,18.00,180.00,10,0.00,0.00,1,1,22.00,195.00,22.00,195.00,22.00,195.00,0.000,0.000,500.000,0.000,1),
  (388,'DAN UP',0,0,1,0,0,'PLASENCIA','','','','',1,5.36,150.00,28,0.00,0.00,1,1,7.50,170.00,7.50,170.00,7.50,170.00,0.000,0.000,500.000,0.000,1),
  (389,'DANONINO',0,0,1,0,0,'PLASENCIA','','','','',1,7.67,184.00,24,0.00,0.00,1,1,10.00,198.00,10.00,198.00,10.00,198.00,0.000,0.000,500.000,0.000,1),
  (390,'YOGURTH ALPURA 170G',0,0,1,0,0,'GPL860521FW8','','','','',1,2.86,68.73,24,0.00,0.00,1,1,4.00,96.00,3.08,74.00,3.08,74.00,0.000,0.000,500.000,0.000,1),
  (391,'YOGURTH CHILCHOTA 4LT',0,0,1,0,0,'DPL910404V73','','','','',1,70.00,70.00,1,0.00,0.00,0,0,82.50,0.00,82.50,0.00,82.50,0.00,0.000,0.000,500.000,0.000,1),
  (392,'YOGURTH CHILCHOTA 1LT',1,0,1,0,0,'DPL910404V73','','','','',2,0.00,0.00,0,19.50,1.00,0,2,25.00,23.00,25.00,23.00,25.00,23.00,0.000,0.000,490.075,0.000,1),
  (393,'YOGURTH PALMALAC 4LT',0,0,1,0,0,'PAL860319A25','','','','',1,64.50,64.50,1,0.00,0.00,0,1,68.50,68.50,68.50,68.50,68.50,68.50,0.000,0.000,500.000,0.000,1),
  (394,'YOGURTH BALCAM 4LT',0,0,1,0,0,'PLR86022136M3','','','','',1,41.00,0.00,0,0.00,0.00,0,0,45.00,0.00,45.00,0.00,45.00,0.00,0.000,0.000,500.000,0.000,1),
  (395,'YOGURTH TARASCO 4 LT',0,0,1,0,0,'PLR86022136M3','','','','',1,34.00,0.00,0,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,500.000,0.000,1),
  (396,'YOGURTH SABINO 4LT',0,0,1,0,0,'DMA0106263S9','','','','',1,37.50,0.00,0,0.00,0.00,0,0,42.50,0.00,42.50,0.00,42.50,0.00,0.000,0.000,500.000,0.000,1),
  (397,'YOGURTH ACTIVIA P/BEBER',0,0,1,0,0,'PLASENCIA','','','','',1,6.82,191.00,28,0.00,0.00,1,1,8.50,238.00,7.32,205.00,7.32,205.00,0.000,0.000,500.000,0.000,1),
  (398,'CREMA ALPURA 250G',0,0,1,0,0,'GPL860521FW8','','','','',1,5.50,132.00,24,0.00,0.00,0,1,7.00,150.00,7.00,150.00,7.00,150.00,0.000,0.000,500.000,0.000,1),
  (399,'CREMA ALPURA 500G',0,0,1,0,0,'GPL860521FW8','','','','',1,12.20,292.80,24,0.00,0.00,0,1,15.00,315.00,15.00,315.00,15.00,315.00,0.000,0.000,500.000,0.000,1),
  (400,'CREMA ALPURA 900G',0,0,1,0,0,'GPL860521FW8','','','','',1,24.40,292.80,12,0.00,0.00,0,1,28.00,315.00,28.00,315.00,28.00,315.00,0.000,0.000,500.000,0.000,1),
  (401,'CREMA ALPURA 4LT',0,0,1,0,0,'GPL860521FW8','','','','',1,107.60,0.00,0,0.00,0.00,0,0,118.00,0.00,118.00,0.00,118.00,0.00,0.000,0.000,500.000,0.000,1),
  (402,'CREMA BATIDA CARRANCEDO 1KG',0,0,1,0,0,'CARRANCEDO','','','','',1,23.00,0.00,0,0.00,0.00,1,0,28.00,0.00,26.00,0.00,26.00,0.00,0.000,0.000,500.000,0.000,1),
  (403,'CREMA BATIDA CARRANCEDO 5KG',0,0,1,0,0,'CARRANCEDO','','','','',1,95.00,95.00,1,0.00,0.00,0,1,100.00,100.00,100.00,100.00,100.00,100.00,0.000,0.000,500.000,0.000,1),
  (404,'CREMA BATIDA DULCIMA 1KG',0,0,1,0,0,'LPL8603272D4','','','','',1,20.00,20.00,1,0.00,0.00,0,1,25.00,23.00,25.00,23.00,25.00,23.00,0.000,0.000,500.000,0.000,1),
  (405,'CREMA BATIDA DULCIMA 5KG',0,0,1,0,0,'LPL8603272D4','','','','',1,78.00,0.00,0,0.00,0.00,1,0,85.00,0.00,83.00,0.00,83.00,0.00,0.000,0.000,500.000,0.000,1),
  (406,'CREMA DULCE P/BATIR 980ML',0,0,1,0,0,'LYNCOTT','','','','',1,33.00,0.00,0,0.00,0.00,1,0,39.00,0.00,37.00,0.00,37.00,0.00,0.000,0.000,500.000,0.000,1),
  (407,'CREMA P/CAFE CREMERO',0,0,1,0,0,'LYNCOTT','','','','',1,0.28,56.00,200,0.00,0.00,0,1,0.50,100.00,0.50,100.00,0.50,100.00,0.000,0.000,500.000,0.000,1),
  (408,'CREMA GINA 1KG',0,0,1,0,0,'UNIFOODS','','','','',1,8.20,82.00,10,0.00,0.00,1,1,11.00,95.00,9.50,95.00,9.50,95.00,0.000,0.000,500.000,0.000,1),
  (409,'CREMA LALA 500G',0,0,1,0,0,'CLD0507145H6','','','','',1,10.60,127.20,12,0.00,0.00,1,1,14.00,168.00,11.00,132.00,11.00,132.00,0.000,0.000,500.000,0.000,1),
  (410,'CREMA LALA 900G',0,0,1,0,0,'CLD0507145H6','','','','',1,23.98,143.88,6,0.00,0.00,1,1,27.00,155.00,27.00,155.00,27.00,150.00,0.000,0.000,500.000,0.000,1),
  (411,'CREMA LALA 4KG',0,0,1,0,0,'CLD0507145H6','','','','',1,88.30,353.20,4,0.00,0.00,0,0,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,500.000,0.000,1),
  (412,'MEDIA CREMA NESTLE 225G',0,0,1,0,0,'NWM9709244W4','','','','',1,9.66,77.34,8,0.00,0.00,1,1,13.50,108.00,13.00,104.00,12.50,100.00,0.000,0.000,500.000,0.000,1),
  (413,'LA LECHERA NESTLE  397G',0,0,1,0,0,'MEG0202151X5','','','','',1,11.47,550.56,48,0.00,0.00,1,1,13.50,648.00,13.00,624.00,12.50,600.00,0.000,0.000,500.000,0.000,1),
  (414,'LECHE EVAPORADA CLAVEL 356ML',0,0,1,0,0,'MEG0202151X5','','','','',1,8.37,401.76,48,0.00,0.00,1,1,11.00,440.00,10.50,435.00,10.00,430.00,0.000,0.000,500.000,0.000,1),
  (415,'LECHE ALPURA 2000 1LT',0,0,1,0,0,'GPL860521FW8','','','','',1,10.07,120.84,12,0.00,0.00,1,1,12.00,126.00,12.00,126.00,12.00,126.00,0.000,0.000,500.000,0.000,1),
  (416,'LECHE ALPURA  LIGTH  1LT',0,0,1,0,0,'GPL860521FW8','','','','',1,10.07,120.84,12,0.00,0.00,1,1,12.00,126.00,12.00,126.00,12.00,126.00,0.000,0.000,500.000,0.000,1),
  (417,'MILECHE 1LT',0,0,1,0,0,'SAHUAYO','CBA871214MS6','','','',1,7.50,90.00,12,0.00,0.00,0,1,8.50,96.00,8.50,96.00,8.50,96.00,0.000,0.000,500.000,0.000,1),
  (418,'NUTRI LECHE',0,0,1,0,0,'CLD0507145H6','','','','',1,8.25,99.00,12,0.00,0.00,1,1,9.50,105.00,9.50,105.00,9.50,105.00,0.000,0.000,500.000,0.000,1),
  (419,'LECHE RICALAC 1LT',0,0,1,0,0,'EL FENIX','','','','',1,6.67,80.00,12,0.00,0.00,1,1,8.00,96.00,7.41,89.00,7.41,89.00,0.000,0.000,500.000,0.000,1),
  (420,'AMARILLO FUNDIDO RANCHERITO 1KG',0,0,1,0,0,'UNIFOODS','','','','',1,11.50,115.00,10,0.00,0.00,1,1,14.50,135.00,14.50,135.00,14.50,135.00,0.000,0.000,500.000,0.000,1),
  (421,'AMARILLO FUNDIDO QUENACHO 1KG',0,0,1,0,0,'CVE9501177P3','','','','',1,9.60,96.00,10,0.00,0.00,1,0,13.00,0.00,12.50,0.00,12.00,0.00,0.000,0.000,500.000,0.000,1),
  (422,'QUESO AMARILLO CHIPILO',1,0,1,0,0,'UNIFOODS','','','','',2,0.00,0.00,0,32.50,2.00,1,2,42.00,37.50,42.00,37.50,42.00,37.50,0.000,0.000,490.075,0.000,1),
  (423,'QUESO AMARILLO CASTELL',1,0,1,0,0,'PLASENCIA','','','','',2,0.00,0.00,0,25.52,1.75,0,2,35.00,29.71,35.00,29.71,35.00,29.71,0.000,0.000,490.075,0.000,1),
  (424,'QUESO AMARILLO RANCHERITO',1,0,1,0,0,'UNIFOODS','','','','',2,0.00,0.00,0,28.75,2.00,1,0,32.00,0.00,31.00,0.00,30.00,0.00,0.000,0.000,490.075,0.000,1),
  (425,'MORTADELA TIPO AMERICANO DUBY',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,15.79,5.85,1,2,25.00,134.55,23.00,134.55,23.00,134.55,0.000,0.000,490.075,0.000,1),
  (426,'JAMON VIRGINIA PAVO ALPINO',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,36.03,3.20,0,2,42.00,39.00,42.00,39.00,42.00,39.00,0.000,0.000,490.075,0.000,1),
  (427,'JAMON DE PIERNA RIOJANO MANDOLINA',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,45.47,7.39,1,2,52.00,369.50,50.00,369.50,50.00,369.50,0.000,0.000,490.075,0.000,1),
  (428,'JAMON NAPOLES DUBY',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,30.15,6.10,1,2,40.00,231.80,38.00,231.80,38.00,231.80,0.000,0.000,490.075,0.000,1),
  (429,'JAMON DE PAVO DUBY',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,31.07,6.00,1,2,38.00,216.00,36.00,216.00,36.00,216.00,0.000,0.000,490.075,0.000,1),
  (430,'JAMON DE PIERNA KIR REGIO',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,64.62,6.10,1,2,72.00,427.00,70.00,427.00,70.00,427.00,0.000,0.000,490.075,0.000,1),
  (431,'JAMON TIPO AMERICANO KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,32.91,6.00,1,2,40.00,228.00,38.00,228.00,38.00,228.00,0.000,0.000,490.075,0.000,1),
  (432,'JAMON PAVO AMERICANO KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,35.66,4.00,1,2,45.00,172.00,43.00,172.00,43.00,172.00,0.000,0.000,490.075,0.000,1),
  (433,'JAMON LUNCH KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,27.06,2.80,1,2,34.00,30.00,34.00,30.00,34.00,30.00,0.000,0.000,490.075,0.000,1),
  (434,'JAMON PIERNA ZWAN PREMIUM',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,75.03,6.12,1,2,85.00,507.96,83.00,507.96,83.00,507.96,0.000,0.000,490.075,0.000,1),
  (435,'CUEROS RAYADOS Y ENTEROS CHICOS',1,0,1,0,0,'GONZALEZ','','','','',2,0.00,0.00,0,6.00,1.00,0,2,8.50,8.50,8.50,8.50,8.50,8.50,0.000,0.000,490.075,0.000,1),
  (436,'CUEROS RAYADOS Y ENTEROS GDES.',1,0,1,0,0,'GONZALEZ','','','','',2,0.00,0.00,0,10.50,1.00,0,2,14.00,14.00,14.00,14.00,14.00,14.00,0.000,0.000,490.075,0.000,1),
  (437,'CHICHARRON PRENSADO',1,0,1,0,0,'FOPA5302023U4','','','','',2,0.00,0.00,0,36.00,30.00,0,2,43.00,1170.00,43.00,1170.00,43.00,1170.00,0.000,0.000,490.075,0.000,1),
  (438,'CHORIZO RIOJANO',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,32.76,8.50,0,2,38.00,36.00,38.00,36.00,38.00,36.00,0.000,0.000,490.075,0.000,1),
  (439,'CHORIZO Y LONGANIZA RANCHERITO',1,0,1,0,0,'RANCHERITO','','','','',2,0.00,0.00,0,25.50,10.00,0,2,33.00,30.00,33.00,30.00,33.00,30.00,0.000,0.000,490.075,0.000,1),
  (440,'CHORIZO CANTIMPALO ZWAN',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,42.07,3.94,0,2,50.00,46.00,50.00,46.00,50.00,46.00,0.000,0.000,490.075,0.000,1),
  (441,'CHORIZO Y LONGANIZA ALBERTO`S',1,0,1,0,0,'ALBERTO`S','','','','',2,0.00,0.00,0,21.00,8.15,0,2,29.00,25.00,29.00,25.00,29.00,25.00,0.000,0.000,490.075,0.000,1),
  (442,'CHULETA TROZO',1,0,1,0,0,'EALJ7711186Z3','','','','',2,0.00,0.00,0,34.00,5.65,0,2,44.00,38.00,44.00,38.00,44.00,38.00,0.000,0.000,490.075,0.000,1),
  (443,'LONGANIZA RIOJANO A GRANEL',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,33.00,8.50,0,2,39.00,36.50,39.00,36.50,39.00,36.50,0.000,0.000,490.075,0.000,1),
  (444,'LONGANIZA Y CHORIZO GALICIA',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,21.86,1.00,0,2,30.00,25.00,30.00,25.00,30.00,25.00,0.000,0.000,490.075,0.000,1),
  (445,'JAMON VIRGINIA ZWAN',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,43.10,5.90,0,2,53.00,47.00,53.00,47.00,53.00,47.00,0.000,0.000,490.075,0.000,1),
  (446,'JAMON GALICIA HORNEADO',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,32.80,4.96,1,2,42.00,36.50,42.00,36.50,42.00,34.50,0.000,0.000,490.075,0.000,1),
  (447,'JAMON MANDOLINA GALICIA',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,33.27,6.10,1,2,46.00,37.50,46.00,37.50,46.00,35.00,0.000,0.000,490.075,0.000,1),
  (448,'JAMON GALI ECO OVALADO',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,15.21,4.80,1,2,22.00,96.00,20.00,96.00,20.00,96.00,0.000,0.000,490.075,0.000,1),
  (449,'JAMON DE PAVO GALICIA',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,26.14,3.72,1,2,35.00,111.60,30.00,111.60,30.00,111.60,0.000,0.000,490.075,0.000,1),
  (450,'PIERNA ADOBADA D´HECTOR',1,0,1,0,0,'D`HECTOR','','','','',2,0.00,0.00,0,30.00,5.30,1,2,35.60,178.10,33.60,178.10,33.60,178.10,0.000,0.000,490.075,0.000,1),
  (451,'PIERNA ESPAÑOLA',1,0,1,0,0,'XXX','','','','',2,0.00,0.00,0,28.00,4.20,0,2,36.00,32.00,36.00,32.00,36.00,32.00,0.000,0.000,490.075,0.000,1),
  (452,'PECHUGA DE PAVO ZWAN',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,82.31,3.40,1,2,95.00,87.00,95.00,87.00,95.00,87.00,0.000,0.000,490.075,0.000,1),
  (453,'PECHUGA DE PAVO HIDALMEX',1,0,1,0,0,'COGM680129LYO','','','','',2,0.00,0.00,0,46.00,4.60,1,0,50.00,0.00,49.50,0.00,49.00,0.00,0.000,0.000,500.000,0.000,0),
  (454,'QUESO DE PUERCO GALICIA TROMPA',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,23.29,3.91,1,2,30.00,26.00,30.00,26.00,30.00,26.00,0.000,0.000,490.075,0.000,1),
  (455,'QUESO DE PUERCO GALICIA MASCARA',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,18.73,3.91,1,2,30.00,109.48,28.00,109.48,28.00,109.48,0.000,0.000,490.075,0.000,1),
  (456,'RECORTE',1,0,1,0,0,'BONANZA','','','','',2,0.00,0.00,0,14.00,1.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,490.075,0.000,1),
  (457,'SALCHICHA VIENA ALYS',1,0,1,0,0,'D`HECTOR','','','','',2,0.00,0.00,0,11.04,2.50,0,2,18.00,14.60,18.00,14.60,18.00,14.60,0.000,0.000,490.075,0.000,1),
  (458,'SALCHICHA VIENA D`HECTOR',1,0,1,0,0,'D`HECTOR','','','','',2,0.00,0.00,0,13.40,2.50,0,2,18.00,14.60,18.00,14.60,18.00,14.60,0.000,0.000,490.075,0.000,1),
  (459,'SALCHICHA DE PAVO D`HECTOR',1,0,1,0,0,'D`HECTOR','','','','',2,0.00,0.00,0,18.61,2.00,0,2,25.00,21.00,25.00,21.00,25.00,21.00,0.000,0.000,490.075,0.000,1),
  (460,'SALCHICHA VIENA TORINO',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,14.08,2.00,0,2,19.00,15.45,19.00,15.45,19.00,15.45,0.000,0.000,490.075,0.000,1),
  (461,'SALCHICHA COCKTAIL ZWAN',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,28.06,2.90,1,2,43.00,118.90,41.00,118.90,41.00,118.90,0.000,0.000,490.075,0.000,1),
  (462,'SALCHICHA VIENA ALPINO',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,18.73,2.06,1,2,22.00,41.20,20.00,41.20,20.00,41.20,0.000,0.000,490.075,0.000,1),
  (463,'SALCHICHA DE PAVO ZWAN',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,27.82,3.12,0,2,35.00,32.00,35.00,32.00,35.00,32.00,0.000,0.000,490.075,0.000,1),
  (464,'SALCHICHA VIENESA ZWAN',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,24.13,3.10,0,2,30.00,28.00,30.00,28.00,30.00,28.00,0.000,0.000,490.075,0.000,1),
  (465,'SALCHICHA  HOT DOG CHERO',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,13.91,3.10,0,2,22.00,17.00,22.00,17.00,22.00,17.00,0.000,0.000,490.075,0.000,1),
  (466,'SALCHICHA DE PAVO KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,26.33,2.20,0,2,36.00,34.00,36.00,34.00,36.00,34.00,0.000,0.000,490.075,0.000,1),
  (467,'SALCHICHA Z ZWAN',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,18.48,3.21,1,2,26.00,77.04,24.00,77.04,24.00,77.04,0.000,0.000,490.075,0.000,1),
  (468,'SALCHICHA PARA ASAR KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,22.68,0.80,0,0,28.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,490.075,0.000,1),
  (469,'QUESO BARRA SELLO DE ORO',1,0,1,0,0,'DPL910404V73','','','','',2,0.00,0.00,0,52.50,4.18,0,2,63.00,58.00,63.00,58.00,63.00,58.00,0.000,0.000,490.075,0.000,1),
  (470,'QUESO CANASTO LISTON ROJO',1,0,1,0,0,'DMA0106263S9','','','','',2,0.00,0.00,0,43.50,5.90,0,0,64.00,0.00,64.00,0.00,64.00,0.00,0.000,0.000,490.075,0.000,1),
  (471,'QUESO PANELA CAPERUCITA ROJA',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,63.51,3.30,1,2,77.00,68.00,77.00,68.00,77.00,68.00,0.000,0.000,490.075,0.000,1),
  (472,'QUESO PARMESANO KRAFT.227G',0,0,1,0,0,'SAN FRANCISCO','','','','',1,32.13,771.00,24,0.00,0.00,1,1,38.00,912.00,37.50,900.00,37.00,888.00,0.000,0.000,500.000,0.000,1),
  (473,'QUESO PARMESANO KRAFT.453G',0,0,1,0,0,'NWM9709244W4','','','','',1,55.75,669.00,12,0.00,0.00,1,1,68.00,816.00,59.50,714.00,59.00,708.00,0.000,0.000,500.000,0.000,1),
  (474,'PEPERAMI',0,0,1,0,0,'ZWAN','','','','',1,6.64,0.00,0,0.00,0.00,0,0,10.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,500.000,0.000,1),
  (475,'PATHE DE HIGADO ZWAN 209G',0,0,1,0,0,'ZWAN','','','','',1,9.49,0.00,0,0.00,0.00,0,0,14.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (476,'QUESO PHILADELPHIA 190G',0,0,1,0,0,'SAN FRANCISCO','','','','',1,15.21,365.00,24,0.00,0.00,0,1,22.00,400.00,22.00,400.00,22.00,400.00,0.000,0.000,500.000,0.000,1),
  (477,'YAKULT',0,0,3,0,0,'YAK800303JA7','','','','',1,2.58,77.40,30,0.00,0.00,1,1,3.65,85.00,3.65,85.00,3.65,85.00,0.000,0.000,500.000,0.000,1),
  (478,'PASTA DENTAL COLGATE 100ML',0,0,3,0,0,'NWM9709244W4','','','','',1,12.34,49.37,4,0.00,0.00,0,1,15.00,55.00,15.00,55.00,15.00,55.00,0.000,0.000,500.000,0.000,1),
  (479,'TORTILLA DE HARINA 1KG',0,0,3,0,0,'BELEN','','','','',1,9.00,9.00,1,0.00,0.00,1,1,13.00,12.00,13.00,12.00,13.00,12.00,0.000,0.000,500.000,0.000,1),
  (480,'TORTILLA INTEGRAL 1KG',0,0,3,0,0,'BELEN','','','','',1,9.00,0.00,0,0.00,0.00,1,0,13.00,0.00,13.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,1),
  (481,'MANTECA  17KG',1,0,1,0,0,'FOPA5302023U4','','','','',2,0.00,0.00,0,10.00,17.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,490.075,0.000,1),
  (482,'MERMELADA 5KG',1,0,1,0,0,'MARCO','','','','',2,0.00,0.00,0,13.00,5.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,490.075,0.000,1),
  (483,'MERMELADA  ZARZAMORA  25KG',1,0,1,0,0,'MARCO','','','','',2,0.00,0.00,0,14.00,25.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,0),
  (484,'TOCINO TROZO',1,0,1,0,0,'MANTAÑEZA','','','','',2,0.00,0.00,0,38.00,5.50,1,0,43.00,0.00,42.50,0.00,42.00,0.00,0.000,0.000,500.000,0.000,0),
  (485,'PAN TOSTADO BIMBO  210G',0,0,3,0,0,'BIM011108DJ5','','','','',1,8.20,0.00,0,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.50,0.00,0.000,0.000,500.000,0.000,1),
  (486,'CAFE CAPUCHINO .23G',0,0,3,0,0,'NWM9709244W4','','','','',1,28.40,340.80,12,0.00,0.00,1,1,35.00,365.00,35.00,365.00,35.00,365.00,0.000,0.000,500.000,0.000,1),
  (487,'CAFE CON VAINILLA .23G',0,0,3,0,0,'NWM9709244W4','','','','',1,3.10,31.00,10,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,0),
  (488,'CAFE MOKASINO .23G',0,0,3,0,0,'MEG0202151X5','','','','',1,32.25,387.00,12,0.00,0.00,1,1,36.00,432.00,34.00,408.00,33.00,396.00,0.000,0.000,500.000,0.000,1),
  (489,'CEREZA MARASCHINO 4.25KG',0,0,3,0,0,'CASA LUCERO','','','','',1,135.00,540.00,4,0.00,0.00,1,0,148.00,0.00,147.50,0.00,147.00,0.00,0.000,0.000,500.000,0.000,0),
  (490,'CERVEZA INDIO CAGUAMA',0,0,3,0,0,'CUAUHTEMOC','','','','',1,10.94,131.31,12,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,0),
  (491,'CERVEZA SOL CAGUAMA',0,0,3,0,0,'CUAUHTEMOC','','','','',1,10.94,131.30,12,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,0),
  (492,'CARIBE COOLER',0,0,3,0,0,'CBA871214MS6','','','','',1,8.67,208.00,24,0.00,0.00,1,1,11.00,264.00,10.50,252.00,10.00,240.00,0.000,0.000,500.000,0.000,1),
  (493,'COCKTEL FRUTAS COSTEÑA 2.800G',0,0,3,0,0,'CCO820507BV4','','','','',1,49.46,296.78,6,0.00,0.00,1,0,55.00,0.00,54.50,0.00,54.00,0.00,0.000,0.000,500.000,0.000,0),
  (494,'COCKTEL FRUTAS AGUSTIN .800',0,0,3,0,0,'OCM870210PC6','','','','',1,15.42,185.00,12,0.00,0.00,1,1,21.00,252.00,20.50,246.00,20.00,240.00,0.000,0.000,500.000,0.000,0),
  (495,'COCKTEL FRUTAS PASIEGA 850G',0,0,3,0,0,'NWM9709244W4','','','','',1,16.13,48.39,3,0.00,0.00,1,0,20.00,0.00,19.50,0.00,19.00,0.00,0.000,0.000,500.000,0.000,0),
  (496,'CHOCO MILK LATA 400G',0,0,3,0,0,'SAHUAYO','','','','',1,21.17,254.01,12,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,0),
  (497,'CHOCO MILK BOLSA CANELA 400G',0,0,3,0,0,'SAHUAYO','','','','',1,20.61,494.60,24,0.00,0.00,1,0,26.00,0.00,25.50,0.00,25.00,0.00,0.000,0.000,500.000,0.000,0),
  (498,'CHIPOTLE COSTEÑA 2.800KG',0,0,3,0,0,'CCO820507BV4','','','','',1,67.84,407.02,6,0.00,0.00,1,1,70.00,420.00,89.50,537.00,89.00,534.00,0.000,0.000,500.000,0.000,1),
  (499,'CHIPOTLES SAN MARCOS 800G',0,0,3,0,0,'SAHUAYO','','','','',1,21.67,260.00,12,0.00,0.00,1,1,28.00,336.00,27.50,330.00,27.00,324.00,0.000,0.000,500.000,0.000,1),
  (500,'DETERGENTE ROMA 5KG',0,0,3,0,0,'TAB890412AK8','','','','',1,63.75,255.00,4,0.00,0.00,1,1,70.00,280.00,70.00,280.00,70.00,280.00,0.000,0.000,500.000,0.000,1);

COMMIT;

#
# Data for the `productos` table  (LIMIT 500,500)
#

# ID_Pro:3:49671
# descripcion:253:0
# tipoPro:3:32768
# gravaIVA:3:32768
# genero:3:32768
# materiaPrima:3:32768
# cortes:3:32768
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
# precioMenu:5:32769
# precioMenuC:5:32769
# precioMM:5:32768
# precioMMC:5:32768
# precioM:5:32768
# precioMC:5:32768
# maxInv:5:32768
# minInv:5:32768
# invTienda:5:32768
# invAlmacen:5:32768
# activo:3:32768

INSERT INTO productos (ID_Pro, descripcion, tipoPro, gravaIVA, genero, materiaPrima, cortes, id_prov1, id_prov2, id_prov3, id_prov4, id_prov5, uniCompra, precioUniCompra, preCaCompra, cantidadXCaja, precioUnidadKG, kgXUnidad, tipoPrecio, manejoPrecio, precioMenu, precioMenuC, precioMM, precioMMC, precioM, precioMC, maxInv, minInv, invTienda, invAlmacen, activo) VALUES 
  (501,'DETERGENTE ROMA 10 KG',0,0,3,0,0,'SCORPION','','','','',1,123.90,0.00,0,0.00,0.00,1,0,140.00,0.00,140.00,0.00,140.00,0.00,0.000,0.000,500.000,0.000,1),
  (502,'DETERGENTE ARIEL 680G',0,0,3,0,0,'SCORPION','','','','',1,10.10,202.00,20,0.00,0.00,1,1,16.00,320.00,15.50,310.00,15.00,300.00,0.000,0.000,500.000,0.000,1),
  (503,'DETERGENTE ARIEL QUITA GRASA 3KG',0,0,3,0,0,'SCORPION','','','','',1,49.17,295.00,6,0.00,0.00,1,0,53.00,0.00,52.50,0.00,52.00,0.00,0.000,0.000,500.000,0.000,0),
  (504,'DETERGENTE ARIEL C/DOWNY 900G',0,0,3,0,0,'SCORPION','','','','',1,17.70,354.00,20,0.00,0.00,1,0,20.00,0.00,19.50,0.00,19.00,0.00,0.000,0.000,500.000,0.000,0),
  (505,'DETERGENTE MAESTRO LIMPIO FLORAL',0,0,3,0,0,'SCORPION','','','','',1,11.25,112.50,10,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,0),
  (506,'DETERGENTE BLANCA NIEVES 1KG',0,0,3,0,0,'SCORPION','','','','',1,11.15,111.50,10,0.00,0.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,0),
  (507,'DETERGENTE BLANCA NIEVES 500G',0,0,3,0,0,'SCORPION','','','','',1,5.60,112.00,20,0.00,0.00,1,0,9.00,0.00,8.50,0.00,8.00,0.00,0.000,0.000,500.000,0.000,0),
  (508,'DETERGENTE AXION PASTA 400G',0,0,3,0,0,'SCORPION','','','','',1,12.33,185.00,15,0.00,0.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,0),
  (509,'DURAZNOS TROZO AGUSTIN 800G',0,0,3,0,0,'SAHUAYO','','','','',1,9.38,225.00,24,0.00,0.00,1,0,13.00,0.00,12.50,0.00,12.00,0.00,0.000,0.000,500.000,0.000,1),
  (510,'GELATINA DANY 125G',0,0,3,0,0,'NWM9709244W4','','','','',1,23.00,115.00,5,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,0),
  (511,'GELATINA MOSAICO GDE.',0,0,3,0,0,'CHUY','','','','',1,4.00,232.00,58,0.00,0.00,1,1,6.50,377.00,5.50,319.00,5.50,319.00,0.000,0.000,500.000,0.000,1),
  (512,'GELATINA LECHE',0,0,3,0,0,'CHUY','','','','',1,4.00,232.00,58,0.00,0.00,1,1,7.00,406.00,6.00,348.00,6.00,348.00,0.000,0.000,500.000,0.000,1),
  (513,'ELOTE DORADO EN GRANO 2.950G',0,0,3,0,0,'DCP040210F26','','','','',1,32.83,197.00,6,0.00,0.00,1,0,38.00,0.00,37.50,0.00,37.00,0.00,0.000,0.000,500.000,0.000,0),
  (514,'IMPULSE BEBIDA 250ML',0,0,2,0,0,'SAHUAYO','','','','',1,12.63,303.18,24,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,0),
  (515,'JUGO DEL VALLE 250ML',0,0,2,0,0,'MARCOS','','','','',1,3.38,81.00,24,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,0),
  (516,'JUGO MAGGI SAZONADOR 200G',0,0,3,0,0,'SAHUAYO','','','','',1,18.63,447.00,24,0.00,0.00,1,0,23.00,0.00,22.50,0.00,22.00,0.00,0.000,0.000,500.000,0.000,0),
  (517,'MAYONESA COSTEÑA INSTITUC. 3.6KG',0,0,3,0,0,'CCO820507BV4','','','','',1,78.75,315.00,4,0.00,0.00,1,1,85.00,340.00,82.00,328.00,82.00,328.00,0.000,0.000,500.000,0.000,1),
  (518,'MAYONESA SQUEEZ COSTEÑA LIGTH 370G',0,0,3,0,0,'CCO820507BV4','','','','',1,9.69,232.48,24,0.00,0.00,1,1,13.00,312.00,12.50,300.00,12.50,300.00,0.000,0.000,500.000,0.000,1),
  (519,'MAYONESA VENCECIA',0,0,3,0,0,'DMA0106263S9','','','','',1,60.16,240.65,4,0.00,0.00,1,0,65.00,0.00,64.50,0.00,64.00,0.00,0.000,0.000,500.000,0.000,0),
  (520,'MAYONESA MEGA 3.57KG',0,0,3,0,0,'DMA0106263S9','','','','',1,69.29,415.75,6,0.00,0.00,1,0,75.00,0.00,74.50,0.00,74.00,0.00,0.000,0.000,500.000,0.000,0),
  (521,'MERMELADA PORCION LYNCOTT',0,0,3,0,0,'LYNCOTT','','','','',1,0.50,160.00,320,0.00,0.00,1,1,0.80,256.00,0.65,208.00,0.65,208.00,0.000,0.000,500.000,0.000,1),
  (522,'MERMELADA COSTEÑA FRESA 540G',0,0,3,0,0,'CCO820507BV4','','','','',1,14.73,176.75,12,0.00,0.00,1,1,20.00,240.00,19.50,234.00,19.00,228.00,0.000,0.000,500.000,0.000,1),
  (523,'MERMELADA ZARZAMORA COSTEÑA 540G',0,0,3,0,0,'CCO820507BV4','','','','',1,14.73,176.75,12,0.00,0.00,1,1,20.00,240.00,19.50,234.00,19.00,228.00,0.000,0.000,500.000,0.000,1),
  (524,'MERMELADA MC.CORMICK 550G',0,0,3,0,0,'SAHUAYO','','','','',1,17.92,215.00,12,0.00,0.00,1,1,23.00,276.00,22.50,270.00,22.00,264.00,0.000,0.000,500.000,0.000,1),
  (525,'MIEL COMERCIAL MIELINA  5LT',0,0,3,0,0,'ALBERTO`S','','','','',1,60.00,240.00,4,0.00,0.00,1,0,65.00,0.00,64.50,0.00,64.00,0.00,0.000,0.000,500.000,0.000,0),
  (526,'MOSTAZA HELLMANS 3.9 KG',0,0,3,0,0,'DMA0106263S9','','','','',1,47.13,188.50,4,0.00,0.00,1,1,55.00,220.00,52.00,208.00,50.88,203.52,0.000,0.000,500.000,0.000,1),
  (527,'MOSTAZA DE PORCION',0,0,3,0,0,'SNO950601EB5','','','','',1,0.14,28.85,200,0.00,0.00,1,0,2.00,0.00,1.50,0.00,1.00,0.00,0.000,0.000,500.000,0.000,1),
  (528,'NEW-MIX VERDE',0,0,2,0,0,'SNO950601EB5','','','','',1,7.79,186.99,24,0.00,0.00,1,1,10.00,240.00,8.50,204.00,8.50,204.00,0.000,0.000,500.000,0.000,1),
  (529,'NEW-MIX ROJA',0,0,2,0,0,'SNO950601EB5','','','','',1,7.79,186.99,24,0.00,0.00,1,1,10.00,240.00,8.50,204.00,8.50,204.00,0.000,0.000,500.000,0.000,1),
  (530,'PIÑA REBANADA TORRE 2.8K',0,0,3,0,0,'CTO840701QT0','','','','',1,55.35,332.12,6,0.00,0.00,1,1,62.00,372.00,61.50,369.00,61.00,366.00,0.000,0.000,500.000,0.000,1),
  (531,'PIÑA REBANADA AGUSTIN 840G',0,0,3,0,0,'OCM870210PC6','','','','',1,11.88,285.00,24,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,0),
  (532,'PINA REBANADA AGUSTIN 840G',0,0,3,0,0,'OCM870210PC6','','','','',1,11.25,135.00,12,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,1),
  (533,'PIÑA REBANADA PRATERIA 825G',0,0,3,0,0,'DIESS','','','','',1,11.04,265.00,24,0.00,0.00,0,1,13.50,295.00,13.50,295.00,13.50,295.00,0.000,0.000,500.000,0.000,1),
  (534,'PIÑA REBANADA PRATERIA 3.030G',0,0,3,0,0,'DIESS','','','','',1,44.17,265.00,6,0.00,0.00,1,0,52.00,0.00,51.50,0.00,51.00,0.00,0.000,0.000,500.000,0.000,1),
  (535,'PIÑA TROZO PRATERIA 3.030G',0,0,3,0,0,'DIESS','','','','',1,40.00,240.00,6,0.00,0.00,1,0,45.00,0.00,44.50,0.00,44.00,0.00,0.000,0.000,500.000,0.000,1),
  (536,'PINA TROZO PRATERIA 825G',0,0,3,0,0,'DIESS','','','','',1,11.88,285.00,24,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,1),
  (537,'PIÑA TERRE 840G',0,0,3,0,0,'DIESS','','','','',1,11.04,265.00,24,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,1),
  (538,'PIÑA COSTEÑA RABANADA 2.800KG',0,0,3,0,0,'CCO820507BV4','','','','',1,40.74,244.00,6,0.00,0.00,1,0,46.00,0.00,45.50,0.00,45.00,0.00,0.000,0.000,500.000,0.000,1),
  (539,'POLVO P/HORNEAR ROYAL 110G',0,0,3,0,0,'SAHUAYO','','','','',1,3.22,154.78,48,0.00,0.00,1,0,7.00,0.00,6.50,0.00,6.00,0.00,0.000,0.000,500.000,0.000,1),
  (540,'RAJAS CASERAS FRASCO 4KG',0,0,3,0,0,'CHILIMEX','','','','',1,22.00,22.00,1,0.00,0.00,0,1,28.00,26.00,28.00,26.00,28.00,26.00,0.000,0.000,500.000,0.000,1),
  (541,'RAJAS TORRE 2.800KG',0,0,3,0,0,'CTO840701QT0','','','','',1,34.38,206.26,6,0.00,0.00,1,1,38.00,228.00,37.50,225.00,37.00,222.00,0.000,0.000,500.000,0.000,1),
  (542,'RAJAS DE CHILE HABANERO 110G',0,0,3,0,0,'xxxxxx','','','','',1,5.92,142.00,24,0.00,0.00,1,1,10.00,240.00,9.50,228.00,9.00,216.00,0.000,0.000,500.000,0.000,1),
  (543,'RAJAS DE CHILE HABANERO 238G',0,0,3,0,0,'xxxxxx','','','','',1,10.75,258.00,24,0.00,0.00,1,1,15.00,360.00,14.50,348.00,14.00,336.00,0.000,0.000,500.000,0.000,1),
  (544,'REFRESCO BIG COLA',0,0,2,0,0,'SNO950601EB5','','','','',1,7.01,56.10,8,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,1),
  (545,'REFRESCO BIG COLA 620ML',0,0,2,0,0,'SNO950601EB5','','','','',1,3.29,79.00,24,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (546,'REFRESCO SANGRIA',0,0,2,0,0,'SNO950601EB5','','','','',1,4.58,110.00,24,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (547,'COCA COLA LATA LIGTH',0,0,2,0,0,'SNO950601EB5','','','','',1,4.58,110.00,24,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,0),
  (548,'REFRESCO LINEA COCA 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,5.00,120.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.50,156.00,0.000,0.000,500.000,0.000,1),
  (549,'PIÑA COSTEÑA REBANADO 800G',0,0,3,0,0,'CCO820507BV4','','','','',1,16.60,199.92,12,0.00,0.00,1,0,19.00,0.00,18.50,0.00,18.00,0.00,0.000,0.000,500.000,0.000,1),
  (550,'PIÑA COSTEÑA TROZO 2.880KG',0,0,3,0,0,'CCO820507BV4','','','','',1,38.89,233.34,6,0.00,0.00,1,0,45.00,0.00,44.50,0.00,44.00,0.00,0.000,0.000,500.000,0.000,1),
  (551,'PIÑA COSTEÑA TROZO 800G',0,0,3,0,0,'CCO820507BV4','','','','',1,16.35,196.14,12,0.00,0.00,1,0,20.00,0.00,19.50,0.00,19.00,0.00,0.000,0.000,500.000,0.000,1),
  (552,'REFRESCO LINEA PEPSI  2.5LT',0,0,2,0,0,'SNO950601EB5','','','','',1,10.00,80.00,8,0.00,0.00,1,1,14.00,112.00,13.50,108.00,13.50,108.00,0.000,0.000,500.000,0.000,1),
  (553,'REFRESCO RED COLA 2LT',0,0,2,0,0,'SNO950601EB5','','','','',1,8.38,67.00,8,0.00,0.00,1,0,12.00,0.00,11.50,0.00,11.00,0.00,0.000,0.000,500.000,0.000,0),
  (554,'REFRESCO PEÑAFIEL TWIST',0,0,2,0,0,'MARCOS','','','','',1,5.00,120.00,24,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,0),
  (555,'REFRESCO SQUIRT 2.5LT',0,0,2,0,0,'SNO950601EB5','','','','',1,10.63,85.00,8,0.00,0.00,1,1,18.00,144.00,17.50,140.00,17.50,140.00,0.000,0.000,500.000,0.000,1),
  (556,'REFRESCO SQUIRT 1.5LT',0,0,2,0,0,'SNO950601EB5','','','','',1,6.50,78.00,12,0.00,0.00,1,1,10.00,120.00,9.50,114.00,9.50,114.00,0.000,0.000,500.000,0.000,1),
  (557,'REFRESCO JARRITO DE 600ML',0,0,2,0,0,'SNO950601EB5','','','','',1,3.75,90.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.50,156.00,0.000,0.000,500.000,0.000,1),
  (558,'REFRESCO ORANGE CRUSH',0,0,2,0,0,'SNO950601EB5','','','','',1,4.58,110.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.50,156.00,0.000,0.000,500.000,0.000,1),
  (559,'SAL DE MESA UNISAL 25KG',0,0,3,0,0,'SAHUAYO','','','','',1,2.64,66.00,25,0.00,0.00,1,0,5.00,0.00,4.50,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (560,'SAL DE COCINA ELEFANTE',0,0,3,0,0,'SAHUAYO','','','','',1,2.56,64.00,25,0.00,0.00,1,1,4.00,100.00,3.50,87.50,3.00,75.00,0.000,0.000,500.000,0.000,1),
  (561,'SALSA CATSUP COSTEÑA 555G',0,0,3,0,0,'CCO820507BV4','','','','',1,10.86,130.27,12,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (562,'SALSA CATSUP COSTEÑA SQUEEZ. 765G',0,0,3,0,0,'CCO820507BV4','','','','',1,14.87,178.42,12,0.00,0.00,1,1,24.00,288.00,23.30,279.60,23.00,276.00,0.000,0.000,500.000,0.000,1),
  (563,'SALSA CATSUP COSTEÑA 900G',0,0,3,0,0,'CCO820507BV4','','','','',1,14.93,179.20,12,0.00,0.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,1),
  (564,'SALSA CATSUP COSTEÑA PACK',0,0,3,0,0,'CCO820507BV4','','','','',1,7.60,91.24,12,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (565,'SALSA CATSUP VECECIA 4 KG',0,0,3,0,0,'CVE9501177P3','','','','',1,28.00,0.00,0,0.00,0.00,1,0,32.00,0.00,31.50,0.00,31.00,0.00,0.000,0.000,500.000,0.000,0),
  (566,'SALSA BUFALO',0,0,3,0,0,'SAHUAYO','','','','',1,4.41,105.90,24,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,0),
  (567,'JAMON VIRGINIA PAVO KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,47.30,3.20,0,2,55.00,52.00,55.00,52.00,55.00,52.00,0.000,0.000,490.075,0.000,1),
  (568,'JAMON D`GUSTE PAVO AHUMADO',1,0,1,0,0,'MANTAÑEZA','','','','',2,0.00,0.00,0,36.00,2.20,1,2,45.00,92.40,42.00,92.40,42.00,92.40,0.000,0.000,490.075,0.000,1),
  (569,'PASTEL PIMIENTO DUBY',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,17.31,3.80,1,2,25.00,87.40,23.00,87.40,23.00,87.40,0.000,0.000,490.075,0.000,1),
  (570,'SALCHICHA GALY',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,10.93,2.20,0,2,16.00,14.09,16.00,14.09,16.00,14.09,0.000,0.000,490.075,0.000,1),
  (571,'TROZO MOZAICO',1,0,1,0,0,'HERS','','','','',2,0.00,0.00,0,33.00,1.10,1,0,37.00,0.00,36.50,0.00,36.00,0.00,0.000,0.000,490.075,0.000,1),
  (572,'TOCINO C/GRASA',1,0,1,0,0,'HERS','','','','',2,0.00,0.00,0,34.00,5.50,1,2,48.00,247.50,45.00,247.50,45.00,247.50,0.000,0.000,490.075,0.000,1),
  (573,'QUESO AMARILLO PREMIER',1,0,1,0,0,'GIC9607192J7','','','','',2,0.00,0.00,0,28.20,2.00,0,2,38.00,31.50,38.00,31.50,38.00,31.50,0.000,0.000,490.075,0.000,1),
  (574,'QUESO CANASTO DURANGUEÑO',1,0,1,0,0,'DPL910404V73','','','','',2,0.00,0.00,0,34.80,6.00,0,2,44.00,39.00,44.00,39.00,44.00,39.00,0.000,0.000,490.075,0.000,1),
  (575,'QUESO DOBLE CREMA CHILCHOTA',1,0,1,0,0,'DPL910404V73','','','','',2,0.00,0.00,0,44.50,4.00,0,2,52.00,47.50,52.00,47.50,52.00,47.50,0.000,0.000,490.075,0.000,1),
  (576,'QUESO BARRA CANASTO CHILCHOTA',1,0,1,0,0,'DPL910404V73','','','','',2,0.00,0.00,0,54.50,4.00,1,2,63.00,59.00,63.00,59.00,63.00,59.00,0.000,0.000,490.075,0.000,1),
  (577,'TE PASTORA 7 AZARES',0,0,3,0,0,'DDI870402E71','','','','',1,14.00,312.00,24,0.00,0.00,1,0,18.00,0.00,18.00,0.00,16.50,0.00,0.000,0.000,500.000,0.000,1),
  (578,'VAINILLA ARVI 1/2 LT',0,0,3,0,0,'SAHUAYO','','','','',1,7.50,270.00,36,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,1),
  (579,'VAINILLA ARVI GALON 4LT',0,0,3,0,0,'SAHUAYO','','','','',1,26.00,104.00,4,0.00,0.00,1,1,33.00,132.00,32.50,130.00,32.00,128.00,0.000,0.000,500.000,0.000,1),
  (580,'VIÑA REAL',0,0,2,0,0,'MARCOS','','','','',1,6.75,162.00,24,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,1),
  (581,'VINAGRE BLANCO GALON 3.900ML',0,0,3,0,0,'DDI870402E71','','','','',1,14.90,59.60,4,0.00,0.00,1,1,18.00,72.00,17.50,70.00,17.00,68.00,0.000,0.000,500.000,0.000,1),
  (582,'VINAGRE OBSCURO 1.050 ML',0,0,3,0,0,'CCO820507BV4','','','','',1,5.13,61.59,12,0.00,0.00,1,0,9.00,0.00,8.50,0.00,8.00,0.00,0.000,0.000,500.000,0.000,0),
  (583,'VINAGRE OBSCURO GALON 3.900ML',0,0,3,0,0,'CCO820507BV4','','','','',1,14.90,59.60,4,0.00,0.00,1,1,18.00,72.00,17.50,70.00,17.00,68.00,0.000,0.000,500.000,0.000,0),
  (584,'VINAGRE BLANCO 1.050 ML',0,0,3,0,0,'CCO820507BV4','','','','',1,5.13,61.59,12,0.00,0.00,1,0,9.00,0.00,8.50,0.00,8.00,0.00,0.000,0.000,500.000,0.000,0),
  (585,'VINAGRE BLANCO GALON 3.750ML',0,0,3,0,0,'CCO820507BV4','','','','',1,14.90,59.60,4,0.00,0.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,0),
  (586,'PAN BLANCO GRANDE WONDER',0,0,3,0,0,'BIM011108DJ5','WONDER','','','',1,13.53,0.00,0,0.00,0.00,1,0,16.50,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,1),
  (587,'PAN INTEGRAL BLANCO WONDER',0,0,3,0,0,'BIM011108DJ5','WONDER','','','',1,14.75,0.00,0,0.00,0.00,1,0,17.00,0.00,16.50,0.00,16.00,0.00,0.000,0.000,500.000,0.000,1),
  (588,'HOT DOGS WONDER 8PZ',0,0,3,0,0,'BIM011108DJ5','WONDER','','','',1,9.43,0.00,0,0.00,0.00,1,0,12.00,0.00,11.50,0.00,11.00,0.00,0.000,0.000,500.000,0.000,1),
  (589,'PAN MOLIDO WONDER',0,0,3,0,0,'BIM011108DJ5','WONDER','','','',1,4.10,0.00,0,0.00,0.00,1,0,5.50,0.00,5.30,0.00,5.00,0.00,0.000,0.000,500.000,0.000,1),
  (590,'TORTILLA DE HARINA WONDER 20PZ',0,0,3,0,0,'WONDER','BIM011108DJ5','','','',1,11.20,0.00,0,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (591,'TORTILLA DE HARINA WONDER 10PZ',0,0,3,0,0,'WONDER','BIM011108DJ5','','','',1,6.00,0.00,0,0.00,0.00,1,0,7.50,0.00,7.30,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (592,'MANTACADAS CHOC. TIA ROSA 2PZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,5.60,0.00,0,0.00,0.00,1,0,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (593,'MANTECADAS VAINILLA NUEZ',0,0,3,0,0,'BIM011108DJ5','','','','',1,5.60,0.00,0,0.00,0.00,1,0,7.00,0.00,7.00,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (594,'SEMITAS 2PZ',0,0,3,0,0,'WONDER','BIM011108DJ5','','','',1,6.00,0.00,0,0.00,0.00,1,0,7.50,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (595,'OREJAS 2PZ',0,0,3,0,0,'WONDER','BIM011108DJ5','','','',1,4.80,0.00,0,0.00,0.00,1,0,6.00,0.00,6.00,0.00,5.80,0.00,0.000,0.000,500.000,0.000,1),
  (596,'ACEITE PAM DE OLIVO',0,0,3,0,0,'NWM9709244W4','','','','',1,26.34,0.00,0,0.00,0.00,1,0,30.00,0.00,29.50,0.00,29.00,0.00,0.000,0.000,500.000,0.000,1),
  (597,'ACEITE OLEICO 900ML',0,0,3,0,0,'NWM9709244W4','','','','',1,29.67,0.00,0,0.00,0.00,1,0,34.00,0.00,34.00,0.00,34.00,0.00,0.000,0.000,500.000,0.000,1),
  (598,'ACEITE NUTRIOLLI 1LT',0,0,3,0,0,'NWM9709244W4','','','','',1,15.86,47.57,3,0.00,0.00,1,1,20.00,60.00,20.00,60.00,20.00,60.00,0.000,0.000,500.000,0.000,1),
  (599,'ACEITE CAPULLO GALON 3.7LT',0,0,3,0,0,'NWM9709244W4','','','','',1,60.36,60.36,1,0.00,0.00,1,1,80.00,79.00,80.00,79.00,80.00,79.00,0.000,0.000,500.000,0.000,1),
  (600,'ACEITE CAPULLO SPRAY',0,0,3,0,0,'NWM9709244W4','','','','',1,24.55,49.10,2,0.00,0.00,1,0,31.00,0.00,29.50,0.00,29.00,0.00,0.000,0.000,500.000,2000.000,1),
  (601,'ACEITE SUPER FRAY 3.5LT',0,0,3,0,0,'NWM9709244W4','','','','',1,47.57,0.00,0,0.00,0.00,1,0,53.00,0.00,52.50,0.00,52.00,0.00,0.000,0.000,500.000,0.000,1),
  (602,'ACEITE DE OLIVA HOJI BLANCA',0,0,3,0,0,'NWM9709244W4','','','','',1,76.62,460.00,6,0.00,0.00,1,1,89.00,534.00,89.00,534.00,89.00,534.00,0.000,0.000,500.000,0.000,1),
  (603,'ACEITE DE OLIVO EN AEROSOL',0,0,3,0,0,'NWM9709244W4','','','','',1,23.84,0.00,0,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,1),
  (604,'ADEREZO MEMBERS MARK 709ML',0,0,3,0,0,'NWM9709244W4','','','','',1,29.16,0.00,0,0.00,0.00,1,0,36.00,0.00,36.00,0.00,33.00,0.00,0.000,0.000,500.000,0.000,1),
  (605,'ADEREZO DE MAYONESA PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.20,40.20,200,0.00,0.00,1,1,0.40,50.00,0.40,50.00,0.40,50.00,0.000,0.000,500.000,0.000,1),
  (606,'ARROZ MORELOS',0,0,3,0,0,'NWM9709244W4','','','','',1,145.00,0.00,0,0.00,0.00,1,0,150.00,0.00,149.50,0.00,149.00,0.00,0.000,0.000,500.000,0.000,1),
  (607,'AZUCAR GLORIA 1000PZ',0,0,3,0,0,'NWM9709244W4','','','','',1,0.08,83.37,1000,0.00,0.00,1,1,0.12,120.00,0.12,120.00,0.12,120.00,0.000,0.000,500.000,0.000,1),
  (608,'ATUN BAKERS 1.8 KG',0,0,3,0,0,'NWM9709244W4','','','','',1,83.33,500.00,6,0.00,0.00,0,1,98.00,525.00,98.00,525.00,98.00,525.00,0.000,0.000,500.000,0.000,1),
  (609,'AXION PASTA',0,0,3,0,0,'NWM9709244W4','','','','',1,10.23,30.69,3,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (610,'BRAN FLAKES 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,50.02,0.00,0,0.00,0.00,1,0,63.00,0.00,63.00,0.00,63.00,0.00,0.000,0.000,500.000,0.000,1),
  (611,'BAYGON 230ML',0,0,3,0,0,'NWM9709244W4','','','','',1,16.67,200.00,12,0.00,0.00,1,0,20.00,0.00,19.50,0.00,19.00,0.00,0.000,0.000,500.000,0.000,1),
  (612,'BRAZZO',0,0,3,0,0,'NWM9709244W4','','','','',1,9.17,110.00,12,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (613,'CAFE LEGAL 0.28G',0,0,3,0,0,'NWM9709244W4','','','','',1,2.39,143.18,60,0.00,0.00,1,1,3.00,165.00,3.00,160.00,3.00,155.00,0.000,0.000,500.000,0.000,1),
  (614,'CAFE LEGAL C/CANELA',0,0,3,0,0,'ABARR. ALEX','','','','',1,2.58,77.53,30,0.00,0.00,1,1,3.00,90.00,2.80,84.00,2.80,84.00,0.000,0.000,500.000,0.000,1),
  (615,'CAFE LEGAL DESCAFEINADO 200G',0,0,3,0,0,'TCM951030A17','','','','',1,42.94,0.00,0,0.00,0.00,1,0,49.00,0.00,48.50,0.00,48.00,0.00,0.000,0.000,500.000,0.000,1),
  (616,'CAFE DOLCA C/CANELA',0,0,3,0,0,'TCM951030A17','','','','',1,38.85,0.00,0,0.00,0.00,1,0,42.00,0.00,41.50,0.00,41.00,0.00,0.000,0.000,500.000,0.000,1),
  (617,'CALAHUA CREMA DE COCO 480G',0,0,3,0,0,'NWM9709244W4','','','','',1,13.10,0.00,0,0.00,0.00,0,0,18.00,0.00,18.00,0.00,18.00,0.00,0.000,0.000,500.000,0.000,1),
  (618,'CLAMATO 1.890',0,0,3,0,0,'SNO950601EB5','','','','',1,34.70,69.39,2,0.00,0.00,1,0,38.00,0.00,37.50,0.00,37.00,0.00,0.000,0.000,500.000,0.000,1),
  (619,'CLAMATO LATA 340 ML',0,0,3,0,0,'SNO950601EB5','','','','',1,7.67,92.00,12,0.00,0.00,1,1,11.00,132.00,9.50,114.00,9.00,108.00,0.000,0.000,500.000,0.000,1),
  (620,'CAJETA CORONADO SQUEEZE 660G',0,0,3,0,0,'NWM9709244W4','','','','',1,30.95,61.29,2,0.00,0.00,1,0,35.00,0.00,34.00,0.00,33.00,0.00,0.000,0.000,500.000,0.000,1),
  (621,'CAJETA REAL LECHE CABRA 1.2KG',0,0,3,0,0,'NWM9709244W4','','','','',1,50.54,0.00,0,0.00,0.00,1,0,55.00,0.00,54.50,0.00,54.00,0.00,0.000,0.000,500.000,0.000,1),
  (622,'CAL-CTOSE BOLSA 400 G',0,0,3,0,0,'SAHUAYO','','','','',1,19.96,479.00,24,0.00,0.00,1,1,25.00,600.00,24.50,588.00,24.00,576.00,0.000,0.000,500.000,0.000,1),
  (623,'CAL-CTOSE C/LECHE 1.5KG',0,0,3,0,0,'ABARR. ALEX','','','','',1,45.00,540.00,12,0.00,0.00,1,0,48.00,0.00,47.50,0.00,47.00,0.00,0.000,0.000,500.000,0.000,1),
  (624,'CEREZAS MEMBERS 1.892KG',0,0,3,0,0,'NWM9709244W4','','','','',1,81.74,0.00,0,0.00,0.00,1,0,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,500.000,0.000,1),
  (625,'COFFE MATE 460G',0,0,3,0,0,'SCORPION','','','','',1,24.67,296.00,12,0.00,0.00,1,0,30.00,0.00,29.00,0.00,28.00,0.00,0.000,0.000,500.000,0.000,1),
  (626,'COFFE MATE PORCION',0,0,3,0,0,'SCORPION','','','','',1,0.29,57.08,200,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (627,'CREMA DE COCO KURUMBA 1LT',0,0,3,0,0,'NWM9709244W4','','','','',1,20.16,60.49,3,0.00,0.00,1,0,25.00,0.00,24.50,0.00,24.00,0.00,0.000,0.000,500.000,0.000,1),
  (628,'CHOCO KRISPIS 320G',0,0,3,0,0,'TAB890412AK8','','','','',1,18.75,449.90,24,0.00,0.00,1,0,25.00,0.00,24.50,0.00,24.00,0.00,0.000,0.000,500.000,0.000,1),
  (629,'DECAF 100G',0,0,3,0,0,'NWM9709244W4','','','','',1,26.08,626.00,24,0.00,0.00,1,1,31.00,744.00,29.50,708.00,29.00,696.00,0.000,0.000,500.000,0.000,1),
  (630,'NESCAFE DECAF SOBRE 14G',0,0,3,0,0,'NWM9709244W4','','','','',1,2.81,56.17,20,0.00,0.00,1,0,8.00,0.00,7.00,0.00,6.00,0.00,0.000,0.000,500.000,0.000,1),
  (631,'CIGARROS DELICADOS S/FILTRO',0,0,3,0,0,'NWM9709244W4','','','','',1,14.05,140.50,10,0.00,0.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,1),
  (632,'DOWNY SUAVIZANTE 850ML',0,0,3,0,0,'NWM9709244W4','','','','',1,9.99,119.90,12,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (633,'FLAN DE GARY  140G',0,0,3,0,0,'NWM9709244W4','','','','',1,3.00,150.00,50,0.00,0.00,1,0,8.00,0.00,7.00,0.00,6.00,0.00,0.000,0.000,500.000,0.000,1),
  (634,'GALLETAS SALADITAS',0,0,3,0,0,'NWM9709244W4','','','','',1,4.31,34.51,8,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,1),
  (635,'GALLETAS SURTIDO RICO 1.420KG',0,0,3,0,0,'NWM9709244W4','','','','',1,51.50,0.00,0,0.00,0.00,1,0,58.00,0.00,57.50,0.00,57.00,0.00,0.000,0.000,500.000,0.000,1),
  (636,'GALLETAS MARIAS 170G',0,0,3,0,0,'TAB890412AK8','','','','',1,3.92,70.48,18,0.00,0.00,1,1,5.00,81.00,5.00,81.00,5.00,81.00,0.000,0.000,500.000,0.000,1),
  (637,'GALLETAS PAKETINES',0,0,3,0,0,'NWM9709244W4','','','','',1,3.06,42.86,14,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,1),
  (638,'GALLETAS EMPERADOR 18PZ',0,0,3,0,0,'NWM9709244W4','','','','',1,3.12,56.16,18,0.00,0.00,1,0,5.00,0.00,4.50,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (639,'GALLETAS RITZ',0,0,3,0,0,'NWM9709244W4','','','','',1,2.25,45.01,20,0.00,0.00,1,0,5.00,0.00,4.50,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (640,'GRANO DE ELOTE DEL FUERTE 2.9KG',0,0,3,0,0,'NWM9709244W4','','','','',1,39.90,0.00,0,0.00,0.00,1,0,45.00,0.00,44.50,0.00,44.00,0.00,0.000,0.000,500.000,0.000,1),
  (641,'HARINA DE TRIGO SAN BLAS 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,5.12,20.46,4,0.00,0.00,1,1,10.00,40.00,9.50,38.00,9.00,36.00,0.000,0.000,500.000,0.000,1),
  (642,'JARABE HERSEY 680ML',0,0,3,0,0,'NWM9709244W4','','','','',1,21.48,64.45,3,0.00,0.00,1,1,29.00,87.00,28.50,85.50,28.00,84.00,0.000,0.000,500.000,0.000,1),
  (643,'JALAPEÑO HEINZ PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.17,33.25,200,0.00,0.00,1,1,0.40,80.00,0.23,46.00,0.23,46.00,0.000,0.000,500.000,0.000,1),
  (644,'KELLOGS SPECIAL 765G',0,0,3,0,0,'NWM9709244W4','','','','',1,36.73,0.00,0,0.00,0.00,1,0,40.00,0.00,39.50,0.00,39.00,0.00,0.000,0.000,500.000,0.000,1),
  (645,'KNOOR SUIZA 24CUBOS',0,0,3,0,0,'SAHUAYO','','','','',1,21.72,782.00,36,0.00,0.00,1,1,27.00,972.00,26.50,954.00,26.00,936.00,0.000,0.000,500.000,0.000,1),
  (646,'KNOOR SUIZA 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,53.00,0.00,0,0.00,0.00,1,0,58.00,0.00,57.50,0.00,57.00,0.00,0.000,0.000,500.000,0.000,1),
  (647,'KNOOR SUIZA 1.6KG',0,0,3,0,0,'NWM9709244W4','','','','',1,81.74,0.00,0,0.00,0.00,1,0,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,500.000,0.000,1),
  (648,'KOTEX NATUREL',0,0,3,0,0,'NWM9709244W4','','','','',1,13.30,53.20,4,0.00,0.00,1,0,17.00,0.00,16.50,0.00,16.00,0.00,0.000,0.000,500.000,0.000,1),
  (649,'KURUMBA CREMA COCO 908ML',0,0,3,0,0,'NWM9709244W4','','','','',1,22.18,66.54,3,0.00,0.00,1,1,28.00,84.00,27.50,82.50,27.00,81.00,0.000,0.000,500.000,0.000,1),
  (650,'LECHE EVAPORADA CLAVEL 2.9LT',0,0,3,0,0,'NWM9709244W4','','','','',1,85.83,0.00,0,0.00,0.00,1,0,90.00,0.00,89.00,0.00,88.00,0.00,0.000,0.000,500.000,0.000,0),
  (651,'LECHE NIDO 400G',0,0,3,0,0,'NWM9709244W4','','','','',1,26.60,159.59,6,0.00,0.00,1,1,30.00,180.00,29.50,177.00,29.00,174.00,0.000,0.000,500.000,0.000,1),
  (652,'LECHE NIDO KINDER 2.5KG',0,0,3,0,0,'NWM9709244W4','','','','',1,181.58,0.00,0,0.00,0.00,1,0,186.00,0.00,185.50,0.00,185.00,0.00,0.000,0.000,500.000,0.000,1),
  (653,'LECHE NIDO KINDER 800 G',0,0,3,0,0,'SCORPION','','','','',1,70.50,846.00,12,0.00,0.00,1,1,83.00,996.00,82.50,990.00,82.00,984.00,0.000,0.000,500.000,0.000,0),
  (654,'JABON ZOTE 200G',0,0,3,0,0,'NWM9709244W4','','','','',1,3.02,151.50,50,0.00,0.00,1,1,6.00,300.00,5.50,275.00,5.00,250.00,0.000,0.000,500.000,0.000,1),
  (655,'LECHE NIDO KINDER 1 1.8KG',0,0,3,0,0,'NWM9709244W4','','','','',1,146.67,880.00,6,0.00,0.00,1,1,160.00,960.00,159.50,957.00,159.00,954.00,0.000,0.000,500.000,0.000,1),
  (656,'LECHE NIDO CLASICA 1.8K',0,0,3,0,0,'NWM9709244W4','','','','',1,137.00,0.00,0,0.00,0.00,0,0,150.00,0.00,150.00,0.00,150.00,0.00,0.000,0.000,500.000,0.000,1),
  (657,'LECHERA SQUEEZE 450G',0,0,3,0,0,'NWM9709244W4','','','','',1,18.42,36.83,2,0.00,0.00,1,0,25.00,0.00,24.50,0.00,24.00,0.00,0.000,0.000,500.000,0.000,1),
  (658,'MAESTRO LIMPIO 6LT',0,0,3,0,0,'NWM9709244W4','','','','',1,53.29,0.00,0,0.00,0.00,1,0,58.00,0.00,57.50,0.00,57.00,0.00,0.000,0.000,500.000,0.000,1),
  (659,'MAPLE LOG CABIN 951G',0,0,3,0,0,'NWM9709244W4','','','','',1,32.48,64.96,2,0.00,0.00,1,1,37.00,74.00,36.50,73.00,36.00,72.00,0.000,0.000,500.000,0.000,1),
  (660,'MAPLE PORCION  30G',0,0,3,0,0,'NWM9709244W4','','','','',1,0.82,58.72,72,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (661,'MAYONESA HELLMANS LIGTH 800G',0,0,3,0,0,'SAHUAYO','','','','',1,29.11,58.21,2,0.00,0.00,1,0,35.00,0.00,34.54,0.00,34.00,0.00,0.000,0.000,500.000,0.000,1),
  (662,'MAYONESA HELLMANS 1.9KG',0,0,3,0,0,'SAHUAYO','','','','',1,43.58,0.00,0,0.00,0.00,1,0,48.00,0.00,47.50,0.00,47.00,0.00,0.000,0.000,500.000,0.000,1),
  (663,'MASECA',0,0,3,0,0,'NWM9709244W4','','','','',1,5.93,59.33,10,0.00,0.00,1,1,9.00,90.00,8.00,80.00,7.50,75.00,0.000,0.000,500.000,0.000,1),
  (664,'MIEL DE ABEJA PORCION 20G',0,0,3,0,0,'NWM9709244W4','','','','',1,0.84,100.25,120,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (665,'MERMELADA PORCION',0,0,3,0,0,'LYNCOTT','','','','',1,0.50,160.00,320,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (666,'MERMELADA MC.CORMICK 270G',0,0,3,0,0,'NWM9709244W4','','','','',1,9.92,59.54,6,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (667,'MERMELADA FRESA ABAL PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.37,74.17,200,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (668,'MAPLE ABAL PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.76,54.73,72,0.00,0.00,1,0,5.00,0.00,4.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (669,'MERMELADA SQUEEZE',0,0,3,0,0,'NWM9709244W4','','','','',1,14.90,59.60,4,0.00,0.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,1),
  (670,'MERMELADA SMUCKERS 907G',0,0,3,0,0,'NWM9709244W4','','','','',1,30.69,0.00,0,0.00,0.00,0,0,38.00,0.00,38.00,0.00,38.00,0.00,0.000,0.000,500.000,0.000,1),
  (671,'MERMELADA  SMUCKERS 907G',0,0,3,0,0,'NWM9709244W4','','','','',1,30.69,0.00,0,0.00,0.00,1,0,35.00,0.00,34.54,0.00,34.00,0.00,0.000,0.000,500.000,0.000,1),
  (672,'MERMELADA 907G',0,0,3,0,0,'NWM9709244W4','','','','',1,33.25,0.00,0,0.00,0.00,1,0,37.00,0.00,36.50,0.00,36.00,0.00,0.000,0.000,500.000,0.000,1),
  (673,'MIEL DE ABEJA MEMBERS 2KG',0,0,3,0,0,'NWM9709244W4','','','','',1,76.21,0.00,0,0.00,0.00,1,0,98.00,0.00,98.00,0.00,98.00,0.00,0.000,0.000,500.000,0.000,1),
  (674,'MIEL NATURAL PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,2.42,173.91,72,0.00,0.00,1,1,2.80,201.60,2.60,187.20,2.60,187.20,0.000,0.000,500.000,0.000,1),
  (675,'MOSTAZA PORCION',0,0,3,0,0,'NWM9709244W4','','','','',1,0.14,28.85,200,0.00,0.00,1,1,0.20,40.00,0.20,40.00,0.20,40.00,0.000,0.000,500.000,0.000,1),
  (676,'NESCAFE CLASICO 10G',0,0,3,0,0,'NWM9709244W4','','','','',1,55.06,0.00,0,0.00,0.00,0,0,59.00,0.00,59.00,0.00,59.00,0.00,0.000,0.000,500.000,0.000,1),
  (677,'NESCAFE TOSTER CHOICE  340G',0,0,3,0,0,'NWM9709244W4','','','','',1,126.85,0.00,0,0.00,0.00,1,0,130.00,0.00,129.50,0.00,129.00,0.00,0.000,0.000,500.000,0.000,1),
  (678,'NUTRIGRAIN CIRUELA',0,0,3,0,0,'NWM9709244W4','','','','',1,3.03,36.32,12,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,1),
  (679,'NESQUIK BEBIDA 240ML',0,0,3,0,0,'NWM9709244W4','','','','',1,4.51,121.76,27,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (680,'NESQUIK BOLSA 200G',0,0,3,0,0,'NWM9709244W4','','','','',1,9.50,95.00,10,0.00,0.00,1,1,13.00,110.00,13.00,110.00,13.00,110.00,0.000,0.000,500.000,0.000,1),
  (681,'NUTELLA 700G',0,0,3,0,0,'NWM9709244W4','','','','',1,48.59,0.00,0,0.00,0.00,1,0,52.00,0.00,51.50,0.00,51.00,0.00,0.000,0.000,500.000,0.000,1),
  (682,'JAMON VIRGINIA ALPINO',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,38.16,3.84,1,0,42.00,0.00,41.50,0.00,41.00,0.00,0.000,0.000,500.000,0.000,0),
  (683,'MORTEDELA TIPO AMERICANO KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,18.38,5.85,1,2,28.00,152.10,26.00,152.10,26.00,152.10,0.000,0.000,490.075,0.000,1),
  (684,'SALCHICHA VIENA PAVINO',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,24.45,2.36,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,490.075,0.000,1),
  (685,'SALCHICHA DE PAVO DUBY',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,21.30,2.20,1,0,25.00,0.00,24.50,0.00,24.00,0.00,0.000,0.000,490.075,0.000,1),
  (686,'SALCHICHA JUMBO KIR',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,25.17,1.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,490.075,0.000,1),
  (687,'SALCHICHA COCKTAIL DE PAVO ZWAN',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,19.32,0.50,1,0,23.00,0.00,22.50,0.00,22.00,0.00,0.000,0.000,490.075,0.000,1),
  (688,'QUESO AMARILLO CAPERUCITA 180G',0,0,1,0,0,'ZWAN','','','','',1,12.15,145.80,12,0.00,0.00,0,1,15.00,165.00,15.00,165.00,15.00,165.00,0.000,0.000,500.000,0.000,1),
  (689,'QUESO AMARILLO PREMIER 4KG',0,0,1,0,0,'GIC9607192J7','','','','',1,55.30,0.00,0,0.00,0.00,0,0,63.00,0.00,63.00,0.00,63.00,0.00,0.000,0.000,500.000,0.000,1),
  (690,'QUESO CANASTO MICRO CLAVEL',1,0,1,0,0,'DMA0106263S9','','','','',2,0.00,0.00,0,56.80,5.65,1,2,65.00,350.30,62.00,350.30,62.00,350.30,0.000,0.000,490.075,0.000,1),
  (691,'QUESO CANASTO MICRO CAMELIA',1,0,1,0,0,'DMA0106263S9','','','','',2,0.00,0.00,0,54.40,5.90,0,2,65.00,62.00,65.00,62.00,65.00,62.00,0.000,0.000,490.075,0.000,1),
  (692,'QUESO RAYADO SUPREMO 5KG',1,0,1,0,0,'SALCEDO','','','','',2,0.00,0.00,0,13.00,5.00,1,2,22.00,17.00,22.00,17.00,22.00,17.00,0.000,0.000,490.075,0.000,1),
  (693,'QUESO RAYADO DE PRIMERA 10KG',1,0,1,0,0,'IXT041110QX3','','','','',2,0.00,0.00,0,9.50,10.00,1,2,16.50,140.00,16.50,140.00,16.50,140.00,0.000,0.000,490.075,0.000,1),
  (694,'QUESO MOLIDO',1,0,1,0,0,'IXT041110QX3','','','','',2,0.00,0.00,0,4.80,10.00,1,2,8.00,65.00,6.50,65.00,6.50,65.00,0.000,0.000,490.075,0.000,1),
  (695,'QUESO COTIJA',1,0,1,0,0,'GLORIA','','','','',2,0.00,0.00,0,50.00,29.00,1,2,60.00,1392.00,53.00,1537.00,53.00,1537.00,0.000,0.000,490.075,0.000,1),
  (696,'QUESO BARRA DEL CAMPO',1,0,1,0,0,'PLP900316CV6','','','','',2,0.00,0.00,0,41.00,2.30,1,2,50.00,45.00,50.00,45.00,50.00,44.50,0.000,0.000,490.075,0.000,1),
  (697,'QUESO MENONITA BARRA',1,0,1,0,0,'COGM680129LYO','','','','',2,0.00,0.00,0,59.00,2.53,1,2,68.00,164.45,65.00,164.45,65.00,164.45,0.000,0.000,490.075,0.000,1),
  (698,'QUESO MANCHEGO NUEVA ZELANDA',1,0,1,0,0,'HECTOR','','','','',2,0.00,0.00,0,54.50,21.00,0,2,75.00,72.00,75.00,72.00,75.00,72.00,0.000,0.000,490.075,0.000,1),
  (699,'QUESO MANCHEGO CAJA BLANCA',1,0,1,0,0,'MEYER','','','','',2,0.00,0.00,0,44.00,8.80,1,0,48.00,0.00,47.50,0.00,47.00,0.00,0.000,0.000,490.075,0.000,1),
  (700,'QUESO MANCHEGO CAJA CAFE',1,0,1,0,0,'SAN FRANCISCO','','','','',2,0.00,0.00,0,54.50,10.00,1,0,58.00,0.00,57.50,0.00,57.00,0.00,0.000,0.000,490.075,0.000,1),
  (701,'QUESO MANCHEGO VILLASANTA',1,0,1,0,0,'SAN FRANCISCO','','','','',2,0.00,0.00,0,44.00,10.00,1,0,48.00,0.00,47.50,0.00,47.00,0.00,0.000,0.000,490.075,0.000,1),
  (702,'QUESO CHIHUAHUA',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,64.61,1.90,1,0,68.00,0.00,67.50,0.00,67.00,0.00,0.000,0.000,490.075,0.000,1),
  (703,'QUESO MANCHEGO CAPERUCITA',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,15.87,1.00,0,0,22.00,0.00,22.00,0.00,22.00,0.00,0.000,0.000,490.075,0.000,1),
  (704,'QUESO OAXACA LA VAQUITA',1,0,1,0,0,'BLAS','','','','',2,0.00,0.00,0,52.00,2.25,1,2,62.00,59.00,59.00,59.00,59.00,59.00,0.000,0.000,490.075,0.000,1),
  (705,'QUESO AZUL DANES ROSEMBERG',0,0,1,0,0,'LYNCOTT','','','','',1,15.00,270.00,18,0.00,0.00,0,0,22.00,0.00,22.00,0.00,22.00,0.00,0.000,0.000,500.000,0.000,1),
  (706,'QUESO OAXACA KARINA',1,0,1,0,0,'IXT041110QX3','','','','',2,0.00,0.00,0,53.00,1.00,0,2,57.00,55.00,57.00,55.00,57.00,55.00,0.000,0.000,490.075,0.000,1),
  (707,'QUESO OAXACA S/MARCA',1,0,1,0,0,'MANCHA','','','','',2,0.00,0.00,0,40.00,1.00,1,0,45.00,0.00,44.50,0.00,44.00,0.00,0.000,0.000,490.075,0.000,1),
  (708,'QUESO RANCHERO PZA',1,0,1,0,0,'HUAPALCALCO','','','','',2,0.00,0.00,0,58.00,1.00,1,0,64.00,0.00,63.50,0.00,63.00,0.00,0.000,0.000,490.075,0.000,1),
  (709,'QUESO CHIHUAHUA PZA',1,0,1,0,0,'HUAPALCALCO','','','','',2,0.00,0.00,0,58.00,1.00,1,0,65.00,0.00,64.50,0.00,64.00,0.00,0.000,0.000,490.075,0.000,1),
  (710,'QUESO BOTANERO',1,0,1,0,0,'HUAPALCALCO','','','','',2,0.00,0.00,0,58.00,1.00,1,0,665.00,0.00,64.50,0.00,64.00,0.00,0.000,0.000,490.075,0.000,1),
  (711,'QUESO AZADERO TIPO OAX. CASA BCA.',1,0,1,0,0,'GIC9607192J7','','','','',2,0.00,0.00,0,26.80,1.00,0,2,36.00,34.00,36.00,34.00,36.00,34.00,0.000,0.000,490.075,0.000,1),
  (712,'QUESO PARMESANO KRAFT 85G',0,0,1,0,0,'SAN FRANCISCO','','','','',1,16.25,390.00,24,0.00,0.00,1,1,22.00,528.00,21.50,516.00,20.00,480.00,0.000,0.000,500.000,0.000,1),
  (713,'QUESO PANELA ABUELO',1,0,1,0,0,'AIÑ911217SF4','','','','',2,0.00,0.00,0,51.50,2.40,1,2,62.00,59.00,62.00,59.00,62.00,59.00,0.000,0.000,490.075,0.000,1),
  (714,'QUESO TORTERO BARRA',1,0,1,0,0,'AIÑ911217SF4','','','','',2,0.00,0.00,0,27.00,4.28,1,2,36.00,145.52,34.00,145.52,34.00,145.52,0.000,0.000,490.075,0.000,1),
  (715,'QUESO REQUESON BOLSA',1,0,1,0,0,'BLAS','','','','',2,0.00,0.00,0,10.00,10.00,1,2,14.00,120.00,12.00,120.00,12.00,120.00,0.000,0.000,490.075,0.000,1),
  (716,'QUESO COTAGE AMERICANO 380G',0,0,1,0,0,'LYNCOTT','','','','',1,26.50,0.00,0,0.00,0.00,0,0,31.00,0.00,31.00,0.00,31.00,0.00,0.000,0.000,500.000,0.000,1),
  (717,'CREMA CUBETA $15',1,0,1,0,1,'IVAN CORTES','','','','',2,0.00,0.00,0,12.00,1.00,0,2,15.00,14.00,15.00,14.00,15.00,14.00,0.000,0.000,490.075,0.000,1),
  (718,'CREMA CUBETA $30',1,0,1,0,1,'IVAN CORTES','','','','',2,0.00,0.00,0,25.00,12.20,1,0,30.00,0.00,28.00,0.00,28.00,0.00,0.000,0.000,490.075,0.000,1),
  (719,'CREMA CUBETA $25',1,0,1,0,1,'IVAN CORTES','','','','',2,0.00,0.00,0,12.00,13.00,0,2,25.00,22.50,25.00,22.50,25.00,22.50,0.000,0.000,490.075,0.000,1),
  (720,'CREMA VEGETAL SABINO',1,0,1,0,0,'DMA0106263S9','','','','',2,0.00,0.00,0,3.71,17.00,0,2,8.00,4.12,8.00,4.12,8.00,4.12,0.000,0.000,490.075,0.000,1),
  (721,'LECHE CONDENSADA NORDIKA 1KG',0,0,1,0,0,'CCM8104201F2','','','','',1,23.50,564.00,24,0.00,0.00,1,1,29.00,696.00,28.50,684.00,28.00,672.00,0.000,0.000,500.000,0.000,1),
  (722,'LECHERA GELARA 1KG',0,0,1,0,0,'PAL010828UR4','','','','',1,20.00,240.00,12,0.00,0.00,1,0,28.00,0.00,27.00,0.00,26.00,0.00,0.000,0.000,500.000,0.000,1),
  (723,'LECHE ALPURA DESLACTOSADA 1LT',0,0,1,0,0,'GPL860521FW8','','','','',1,11.40,136.80,12,0.00,0.00,1,1,13.00,156.00,11.83,142.00,11.83,142.00,0.000,0.000,500.000,0.000,1),
  (724,'LECHE ALPURA NATURAL 250ML',0,0,1,0,0,'GPL860521FW8','','','','',1,2.80,75.60,27,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,0),
  (725,'BONALECHE 1LT',0,0,1,0,0,'EL FENIX','','','','',1,7.08,85.00,12,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (726,'MANTEQUILLA CHIPILO  225G',0,0,1,0,0,'UNIFOODS','','','','',1,10.67,96.00,9,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (727,'MANTEQUILLA CHIPILO  90G',0,0,1,0,0,'UNIFOODS','','','','',1,4.40,105.50,24,0.00,0.00,1,0,10.00,0.00,9.00,0.00,8.00,0.00,0.000,0.000,500.000,0.000,1),
  (728,'MARGARINA PORCION BOLSA C/100PZ',0,0,1,0,0,'LYNCOTT','','','','',1,30.00,0.00,0,0.00,0.00,1,0,35.00,0.00,34.50,0.00,34.00,0.00,0.000,0.000,500.000,0.000,1),
  (729,'MARGARINA VENECIA 90G',0,0,1,0,0,'CVE9501177P3','','','','',1,2.08,50.00,24,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,0),
  (730,'DANONINO MAXI 360G',0,0,1,0,0,'PLASENCIA','','','','',1,13.17,158.00,12,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,0),
  (731,'YOGURTH PALMALAC 1LT',0,0,1,0,0,'PAL860319A25','','','','',1,18.00,0.00,0,0.00,0.00,1,0,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,500.000,0.000,1),
  (732,'CREMA CORTES BOLSA',1,0,1,0,1,'IVAN CORTES','','','','',2,0.00,0.00,0,16.50,5.50,1,2,23.00,21.00,23.00,21.00,23.00,19.50,0.000,0.000,490.075,0.000,1),
  (733,'CREMA VEGETAL SAN JOSE',0,0,1,0,0,'IVAN CORTES','','','','',1,63.00,63.00,1,0.00,0.00,0,1,68.00,68.00,68.00,68.00,68.00,68.00,0.000,0.000,500.000,0.000,1),
  (734,'JAMON CAMPO VIEJO',1,0,1,0,0,'PCD9705292H1','','','','',2,0.00,0.00,0,12.50,4.86,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,0),
  (735,'BACALAO NORUEGO',1,0,1,0,0,'XXX','','','','',2,0.00,0.00,0,132.00,25.00,1,0,138.00,0.00,137.50,0.00,137.00,0.00,0.000,0.000,490.075,0.000,1),
  (736,'ACEITE CRISTAL BIDON 20LT',0,0,3,0,0,'SOBA','','','','',1,284.00,0.00,0,0.00,0.00,0,0,340.00,0.00,340.00,0.00,340.00,0.00,0.000,0.000,500.000,0.000,1),
  (737,'ACEITE DE OLIVA CARBONELL 1LT',0,0,3,0,0,'LUCERO','','','','',1,71.67,860.00,12,0.00,0.00,1,0,85.00,0.00,84.50,0.00,84.00,0.00,0.000,0.000,500.000,0.000,0),
  (738,'ACEITUNA DESHUESADA COSTEÑA 200G',0,0,3,0,0,'CCO820507BV4','','','','',1,14.50,173.99,12,0.00,0.00,1,1,20.00,240.00,19.50,234.00,19.00,228.00,0.000,0.000,500.000,0.000,1),
  (739,'ACEITUNA C/HUESO COSTEÑA 408G',0,0,3,0,0,'CCO820507BV4','','','','',1,20.16,241.96,12,0.00,0.00,1,1,26.00,312.00,25.50,306.00,25.00,300.00,0.000,0.000,500.000,0.000,1),
  (740,'ACEITUNA C/HUESO COSTEÑA 192G',0,0,3,0,0,'CCO820507BV4','','','','',1,13.49,161.92,12,0.00,0.00,1,0,18.00,0.00,17.50,0.00,17.00,0.00,0.000,0.000,500.000,0.000,1),
  (741,'CLORO BANDERB 1.9ML',0,0,3,0,0,'MANUEL','','','','',1,11.88,95.00,8,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,0),
  (742,'SABROZEADOR MC. CORMICK',0,0,3,0,0,'TAB890412AK8','','','','',1,18.00,0.00,0,0.00,0.00,1,0,25.00,0.00,24.50,0.00,24.00,0.00,0.000,0.000,500.000,0.000,1),
  (743,'CHAMPIÑONES PRATERIA 1KG',0,0,3,0,0,'CONTINENTAL','','','','',1,14.58,175.00,12,0.00,0.00,1,0,18.00,0.00,17.00,0.00,16.00,0.00,0.000,0.000,500.000,0.000,0),
  (744,'CHAMPIÑONES PRATERIA REBANADO 2.840',0,0,3,0,0,'CONTINENTAL','','','','',1,50.83,305.00,6,0.00,0.00,1,0,56.00,0.00,55.50,0.00,55.00,0.00,0.000,0.000,500.000,0.000,0),
  (745,'CHIPOTLE MOLIDO CHEPINA',0,0,3,0,0,'XXX','','','','',1,22.00,0.00,0,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,1),
  (746,'LIMONERA 1LT',0,0,3,0,0,'MDD000728BL0','','','','',1,8.08,97.00,12,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,0),
  (747,'MAIZ  POZOLERO EL REY A/VACIO',0,0,1,0,0,'CRISANTOS','','','','',1,6.00,120.00,20,0.00,0.00,1,0,9.00,0.00,8.50,0.00,8.50,0.00,0.000,0.000,500.000,0.000,1),
  (748,'PALOMAS ACT II CHILE LIMON',0,0,3,0,0,'SAHUAYO','','','','',1,8.06,72.50,15,0.00,0.00,1,0,14.00,0.00,13.50,0.00,13.00,0.00,0.000,0.000,500.000,0.000,0),
  (749,'PALOMAS ACT II QUESO AMARILLO',0,0,3,0,0,'SAHUAYO','','','','',1,8.06,72.50,15,0.00,0.00,1,0,15.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,0),
  (750,'PALOMAS ACT II QUESO BLANCO',0,0,3,0,0,'SAHUAYO','','','','',1,8.06,72.50,15,0.00,0.00,1,0,15.00,0.00,14.00,0.00,13.00,0.00,0.000,0.000,500.000,0.000,0),
  (751,'SALSA VALENTINA AMARILLA 4LT',0,0,3,0,0,'NWM9709244W4','','','','',1,37.03,0.00,0,0.00,0.00,0,0,42.00,0.00,42.00,0.00,42.00,0.00,0.000,0.000,500.000,0.000,1),
  (752,'SERVILLETAS FANCY 125PZ',0,0,3,0,0,'SCORPION','','','','',1,3.43,164.70,48,0.00,0.00,1,0,8.00,0.00,7.00,0.00,6.00,0.00,0.000,0.000,500.000,0.000,0),
  (753,'TARJETA LADATEL',0,0,3,0,0,'ANICETOS','','','','',1,27.10,0.00,0,0.00,0.00,1,0,30.00,0.00,29.59,0.00,29.00,0.00,0.000,0.000,500.000,0.000,0),
  (754,'TOSTADAS C/100 PZ',0,0,3,0,0,'MEG0202151X5','','','','',1,25.00,100.00,4,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,1),
  (755,'TOSTADAS C/50 PZ',0,0,3,0,0,'MEG0202151X5','','','','',1,12.50,112.50,9,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (756,'VAINILLA LA PALOMA 1LT',0,0,3,0,0,'XXX','','','','',1,11.00,165.00,15,0.00,0.00,1,1,19.00,285.00,18.50,277.50,18.00,270.00,0.000,0.000,500.000,0.000,1),
  (757,'VAINILLA LA PALOMA 500ML',0,0,3,0,0,'XXX','','','','',1,7.50,180.00,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (758,'VAINILLA LA PALOMA 4LT',0,0,3,0,0,'XXX','','','','',1,40.00,160.00,4,0.00,0.00,1,0,48.00,0.00,47.00,0.00,46.00,0.00,0.000,0.000,500.000,0.000,1),
  (759,'VELADORA SEMANAL',0,0,3,0,0,'SCORPION','','','','',1,6.16,147.90,24,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (760,'VELADORA MEDIA SEMANA',0,0,3,0,0,'SCORPION','','','','',1,12.49,149.90,12,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,0),
  (761,'VELADORA SEM. Y MEDIA SAN JUAN',0,0,3,0,0,'SCORPION','','','','',1,18.74,224.90,12,0.00,0.00,1,0,23.00,0.00,22.50,0.00,22.00,0.00,0.000,0.000,500.000,0.000,0),
  (762,'VELADORA ESMERALDA NO. 3',0,0,3,0,0,'SCORPION','','','','',1,16.08,193.00,12,0.00,0.00,1,0,19.00,0.00,18.50,0.00,18.00,0.00,0.000,0.000,500.000,0.000,0),
  (763,'VELADORA TAZA FLOR',0,0,3,0,0,'SCORPION','','','','',1,9.00,179.90,20,0.00,0.00,1,0,13.00,0.00,12.50,0.00,12.00,0.00,0.000,0.000,500.000,0.000,0),
  (764,'VELADORA FLORAL SATURNO',0,0,3,0,0,'SCORPION','','','','',1,6.20,123.90,20,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (765,'VELADORA MAGNO SATURNO',0,0,3,0,0,'SCORPION','','','','',1,11.41,136.90,12,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,0),
  (766,'VELADORA CAFETERO',0,0,3,0,0,'SCORPION','','','','',1,7.00,140.00,20,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (767,'VELADORA POPULAR',0,0,3,0,0,'SCORPION','','','','',1,7.00,140.00,20,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (768,'VELADORA LEO INFANTIL',0,0,3,0,0,'SCORPION','','','','',1,6.85,137.00,20,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (769,'VELADORA MURALLA',0,0,3,0,0,'SCORPION','','','','',1,7.95,159.00,20,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (770,'VELADORA LIMONERO',0,0,3,0,0,'SCORPION','','','','',1,7.60,151.90,20,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (771,'VELADORA CUBERO',0,0,3,0,0,'SCORPION','','','','',1,7.50,150.00,20,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (772,'VELADORA FAROLITO NO. 5',0,0,3,0,0,'SCORPION','','','','',1,5.25,209.90,40,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,0),
  (773,'VELADORA SAL FELIPE PAPEL',0,0,3,0,0,'SCORPION','','','','',1,2.57,256.90,100,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,0),
  (774,'MARGARITA GALLETA 60G',0,0,3,0,0,'WONDER','BIM011108DJ5','','','',1,2.00,0.00,0,0.00,0.00,1,0,4.00,0.00,3.50,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (775,'CHOCOTORRO',0,0,3,0,0,'WONDER','BIM011108DJ5','','','',1,3.20,0.00,0,0.00,0.00,1,0,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,501.000,0.000,1),
  (776,'DALMATA',0,0,3,0,0,'WONDER','BIM011108DJ5','','','',1,3.20,0.00,0,0.00,0.00,1,0,4.00,0.00,4.00,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (777,'CORN FLAKES 350G',0,0,3,0,0,'SCORPION','','','','',1,18.04,432.90,24,0.00,0.00,0,0,23.00,0.00,23.00,0.00,23.00,0.00,0.000,0.000,500.000,0.000,1),
  (778,'CAFE CAPEH',1,0,3,0,0,'SCORPION','','','','',2,0.00,0.00,0,65.00,20.00,0,2,75.00,75.00,75.00,75.00,75.00,75.00,0.000,0.000,490.075,0.000,1),
  (779,'FABULOSO  10LT',0,0,3,0,0,'SAHUAYO','','','','',1,79.86,79.86,1,0.00,0.00,0,0,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,500.000,0.000,1),
  (780,'KNOOR TOMATE C/2 CUBOS',0,0,3,0,0,'SAHUAYO','','','','',1,2.50,60.00,24,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,1),
  (781,'LECHE NIDO CLASICA 2.5G',0,0,3,0,0,'TCM951030A17','','','','',1,180.56,1083.30,6,0.00,0.00,1,1,194.00,1164.00,193.50,1161.00,193.00,1158.00,0.000,0.000,500.000,0.000,1),
  (782,'LECHE NIDO KINDER 3.900G',0,0,3,0,0,'TCM951030A17','','','','',1,79.50,0.00,0,0.00,0.00,1,0,85.00,0.00,84.50,0.00,84.00,0.00,0.000,0.000,500.000,0.000,1),
  (783,'MAC COFFE',0,0,3,0,0,'NWM9709244W4','','','','',1,3.67,73.48,20,0.00,0.00,1,0,5.00,0.00,4.50,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (784,'PAPEL PETALO JUMBO',0,0,3,0,0,'NWM9709244W4','','','','',1,2.02,80.73,40,0.00,0.00,1,0,5.00,0.00,4.50,0.00,4.00,0.00,0.000,0.000,500.000,0.000,1),
  (785,'PAPEL CHARMIN JUMBO',0,0,3,0,0,'NWM9709244W4','','','','',1,2.44,97.77,40,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,1),
  (786,'PAPEL SUAVEL JUMBO',0,0,3,0,0,'NWM9709244W4','','','','',1,1.58,75.79,48,0.00,0.00,1,0,4.00,0.00,3.50,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (787,'PAPEL HIGIENICO FLAMINGO C/4',0,0,3,0,0,'NWM9709244W4','','','','',1,4.38,105.00,24,0.00,0.00,1,0,7.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (788,'PAPEL PETALO C/4 PZ',0,0,3,0,0,'NWM9709244W4','','','','',1,8.73,209.50,24,0.00,0.00,1,1,12.00,288.00,13.50,324.00,13.00,312.00,0.000,0.000,500.000,0.000,1),
  (789,'PEPINILLOS GALON 3.7 KG',0,0,3,0,0,'NWM9709244W4','','','','',1,40.92,0.00,0,0.00,0.00,1,0,48.00,0.00,47.50,0.00,47.00,0.00,0.000,0.000,500.000,0.000,1),
  (790,'PURE DE TOMATE DEL FUERTE 1LT',0,0,3,0,0,'NWM9709244W4','','','','',1,9.21,36.83,4,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,1),
  (791,'PURE DE TOMATE DEL FUERTE 250G',0,0,3,0,0,'NWM9709244W4','','','','',1,3.35,70.28,21,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (792,'RAISIN BRAN  1.24KG',0,0,3,0,0,'NWM9709244W4','','','','',1,77.75,0.00,0,0.00,0.00,1,0,93.00,0.00,93.00,0.00,90.00,0.00,0.000,0.000,500.000,0.000,1),
  (793,'SHAMPOO PALMOLIVE OPTIM',0,0,3,0,0,'NWM9709244W4','','','','',1,1.24,29.75,24,0.00,0.00,0,1,2.00,35.00,2.00,35.00,2.00,35.00,0.000,0.000,500.000,0.000,1),
  (794,'SAL LA FINA 1KG',0,0,3,0,0,'NWM9709244W4','','','','',1,5.08,15.24,3,0.00,0.00,0,1,8.00,20.00,8.00,20.00,8.00,20.00,0.000,0.000,500.000,0.000,1),
  (795,'SALVO LIQUIDO 1.5 ML',0,0,3,0,0,'NWM9709244W4','','','','',1,35.50,0.00,0,0.00,0.00,0,0,42.00,0.00,42.00,0.00,42.00,0.00,0.000,0.000,500.000,0.000,1),
  (796,'SALVO LIQUIDO 500ML',0,0,3,0,0,'NWM9709244W4','','','','',1,22.20,0.00,0,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,1),
  (797,'SALVO LIBRE TALLADO 375ML',0,0,3,0,0,'NWM9709244W4','','','','',1,22.20,0.00,0,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,1),
  (798,'SALSA TABASCO 60ML',0,0,3,0,0,'NWM9709244W4','','','','',1,18.41,73.66,4,0.00,0.00,1,1,22.00,88.00,21.50,86.00,21.00,84.00,0.000,0.000,500.000,0.000,1),
  (799,'SALSA DE SOYA KIKK SOYA 296ML',0,0,3,0,0,'NWM9709244W4','','','','',1,23.99,47.98,2,0.00,0.00,1,0,28.00,0.00,27.50,0.00,27.00,0.00,0.000,0.000,500.000,0.000,1),
  (800,'SALSA BBQ  KRAFT 2.15KG',0,0,3,0,0,'NWM9709244W4','','','','',1,50.12,0.00,0,0.00,0.00,1,0,68.00,0.00,68.00,0.00,68.00,0.00,0.000,0.000,500.000,0.000,1),
  (801,'SALSA BBQ 612G',0,0,3,0,0,'NWM9709244W4','','','','',1,12.58,37.75,3,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,1),
  (802,'SALSA BUFALO',0,0,3,0,0,'NWM9709244W4','','','','',1,4.01,24.04,6,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,0),
  (803,'SERVILLETAS DELSEY  125PZ',0,0,3,0,0,'NWM9709244W4','','','','',1,3.75,45.01,12,0.00,0.00,1,1,6.50,78.00,6.00,72.00,5.50,66.00,0.000,0.000,500.000,0.000,1),
  (804,'SOPA CAMPBELLS 430G',0,0,3,0,0,'NWM9709244W4','','','','',1,13.56,54.22,4,0.00,0.00,0,1,19.00,76.00,19.00,76.00,19.00,76.00,0.000,0.000,500.000,0.000,1),
  (805,'SOPA CAMPBELLS ELOTE 735 G',0,0,3,0,0,'NWM9709244W4','','','','',1,23.00,552.00,24,0.00,0.00,1,1,35.00,840.00,34.50,828.00,34.00,816.00,0.000,0.000,500.000,0.000,1),
  (806,'SPLENDA 700 SOBRES',0,0,3,0,0,'MEG0202151X5','','','','',1,0.19,136.00,700,0.00,0.00,1,1,0.21,147.00,0.36,252.00,0.36,252.00,0.000,0.000,500.000,0.000,1),
  (807,'SUAVITEL GALON 5LT',0,0,3,0,0,'NWM9709244W4','','','','',1,48.84,0.00,0,0.00,0.00,1,0,55.00,0.00,54.50,0.00,54.00,0.00,0.000,0.000,500.000,0.000,1),
  (808,'SWETT N LOW 50PZ 1G C/U',0,0,3,0,0,'NWM9709244W4','','','','',1,0.43,21.63,50,0.00,0.00,0,1,28.00,28.00,28.00,28.00,28.00,28.00,0.000,0.000,500.000,0.000,1),
  (809,'TANG SOBRES',0,0,3,0,0,'TAB890412AK8','','','','',1,2.71,73.23,27,0.00,0.00,0,1,4.00,80.00,4.00,80.00,4.00,80.00,0.000,0.000,500.000,0.000,1),
  (810,'TOALLAS KOTEX CLASICA',0,0,3,0,0,'NWM9709244W4','','','','',1,6.65,26.60,4,0.00,0.00,1,0,8.00,0.00,7.50,0.00,7.00,0.00,0.000,0.000,500.000,0.000,1),
  (811,'TOALLAS ANATOMICAS C/ALAS',0,0,3,0,0,'NWM9709244W4','','','','',1,8.79,35.14,4,0.00,0.00,1,0,10.00,0.00,9.50,0.00,9.00,0.00,0.000,0.000,500.000,0.000,1),
  (812,'TOALLAS NATURELLE 10PZ',0,0,3,0,0,'NWM9709244W4','','','','',1,10.61,84.90,8,0.00,0.00,1,0,15.00,0.00,14.50,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (813,'VAINILLA PASA  250ML',0,0,3,0,0,'NWM9709244W4','','','','',1,6.50,156.00,24,0.00,0.00,1,1,10.00,240.00,9.50,228.00,9.00,216.00,0.000,0.000,500.000,0.000,1),
  (814,'VELADORA AZUCENA',0,0,3,0,0,'NWM9709244W4','','','','',1,2.71,65.12,24,0.00,0.00,1,0,6.00,0.00,5.50,0.00,5.00,0.00,0.000,0.000,500.000,0.000,0),
  (815,'ZUCARITAS 300G',0,0,3,0,0,'NWM9709244W4','','','','',1,13.91,333.90,24,0.00,0.00,1,0,16.00,0.00,15.50,0.00,15.00,0.00,0.000,0.000,500.000,0.000,1),
  (816,'ZUCARITAS 950G',0,0,3,0,0,'NWM9709244W4','','','','',1,20.36,285.00,14,0.00,0.00,1,0,25.00,0.00,24.50,0.00,24.00,0.00,0.000,0.000,500.000,0.000,1),
  (817,'ZUCARITAS 1.460G',0,0,3,0,0,'NWM9709244W4','','','','',1,57.29,0.00,0,0.00,0.00,1,0,65.00,0.00,64.50,0.00,64.00,0.00,0.000,0.000,500.000,0.000,1),
  (818,'AGUA BONAFON 330ML',0,0,3,0,0,'NWM9709244W4','','','','',1,2.66,63.94,24,0.00,0.00,1,1,4.00,96.00,3.50,84.00,3.00,72.00,0.000,0.000,500.000,0.000,1),
  (819,'COCA COLA MINI VIDRIO',0,0,2,0,0,'SNO950601EB5','','','','',1,3.96,95.00,24,0.00,0.00,1,1,5.00,105.00,5.00,105.00,5.00,105.00,0.000,0.000,500.000,0.000,1),
  (820,'CHONGOS ZAMORANOS MISION 1KG',0,0,3,0,0,'NORTEÑA','','','','',1,30.00,360.00,12,0.00,0.00,1,1,36.00,432.00,35.00,420.00,34.00,408.00,0.000,0.000,500.000,0.000,1),
  (821,'SAL DE MESA STARS 1KG',0,0,3,0,0,'SAHUAYO','','','','',1,2.64,66.00,25,0.00,0.00,1,1,5.00,80.00,5.00,80.00,5.00,80.00,0.000,0.000,500.000,0.000,1),
  (822,'AXION LIQUIDO ANTIBACTERIAL 900ML',0,0,3,0,0,'SAHUAYO','','','','',1,16.00,192.00,12,0.00,0.00,1,1,22.00,264.00,21.50,258.00,21.00,252.00,0.000,0.000,500.000,0.000,1),
  (823,'MARCEL COFFE 20PZ',0,0,3,0,0,'SAHUAYO','','','','',1,3.25,65.00,20,0.00,0.00,1,1,3.75,75.00,3.75,75.00,3.75,75.00,0.000,0.000,500.000,0.000,1),
  (824,'MEDIA CREMA NESTLE 1LT',0,0,3,0,0,'MEG0202151X5','','','','',1,34.00,408.00,12,0.00,0.00,1,1,40.00,480.00,38.00,456.00,38.00,456.00,0.000,0.000,500.000,0.000,1),
  (825,'KNOOR SUIZA C/8 CUBOS 22G',0,0,3,0,0,'TAB890412AK8','','','','',1,8.55,470.12,55,0.00,0.00,1,1,11.00,605.00,10.50,577.50,10.00,550.00,0.000,0.000,500.000,0.000,1),
  (826,'SALSA CATSUP COSTEÑA 400G',0,0,3,0,0,'CCO820507BV4','','','','',1,8.22,197.29,24,0.00,0.00,1,1,12.00,288.00,11.50,276.00,11.00,264.00,0.000,0.000,500.000,0.000,1),
  (827,'CHILES NACHOS COSTEÑA 220G',0,0,3,0,0,'CCO820507BV4','','','','',1,3.67,88.13,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.00,144.00,0.000,0.000,500.000,0.000,1),
  (828,'CHILES JAL. PICADOS COSTEÑA 220G',0,0,3,0,0,'CCO820507BV4','','','','',1,4.23,101.63,24,0.00,0.00,1,1,8.00,192.00,7.50,180.00,7.00,168.00,0.000,0.000,500.000,0.000,1),
  (829,'PURE DE TOMATE COSTEÑA 2.920G',0,0,3,0,0,'CCO820507BV4','','','','',1,29.56,177.37,6,0.00,0.00,1,1,34.00,204.00,33.50,201.00,33.00,198.00,0.000,0.000,500.000,0.000,1),
  (830,'MAIZENA 0.95G',0,0,3,0,0,'TAB890412AK8','','','','',1,3.57,0.00,0,0.00,0.00,1,0,6.00,0.00,6.00,0.00,6.00,0.00,0.000,0.000,500.000,0.000,1),
  (831,'CEREZA ROJA TERRE C/RABO 2KG',0,0,3,0,0,'OCM870210PC6','','','','',1,61.25,490.00,8,0.00,0.00,1,1,76.00,608.00,75.50,604.00,75.00,600.00,0.000,0.000,500.000,0.000,1),
  (832,'RAID CASA Y JARDIN 260ML',0,0,3,0,0,'TAB890412AK8','','','','',1,23.79,0.00,0,0.00,0.00,0,0,30.00,0.00,30.00,0.00,30.00,0.00,0.000,0.000,500.000,0.000,1),
  (833,'SALSA DE SOYA BAKERS Y CHEFS 2LT',0,0,3,0,0,'NWM9709244W4','','','','',1,64.45,0.00,0,0.00,0.00,0,0,80.00,0.00,80.00,0.00,80.00,0.00,0.000,0.000,500.000,0.000,1),
  (834,'NESCAFE CLASICO 100G',0,0,3,0,0,'MEG0202151X5','','','','',1,24.17,580.00,24,0.00,0.00,0,1,29.00,620.00,29.00,620.00,29.00,620.00,0.000,0.000,500.000,0.000,1),
  (835,'CAFE LEGAL SOLUBLE 50G',0,0,3,0,0,'SAHUAYO','','','','',1,10.50,126.00,12,0.00,0.00,1,1,16.00,192.00,15.50,186.00,15.00,180.00,0.000,0.000,500.000,0.000,1),
  (836,'LECHE CONDENSADA G-LARA 1KG',0,0,3,0,0,'PAL010828UR4','','','','',1,20.00,0.00,0,0.00,0.00,0,0,25.00,0.00,25.00,0.00,25.00,0.00,0.000,0.000,500.000,0.000,1),
  (837,'LA LECHERA NESTLE 110 G',0,0,3,0,0,'NWM9709244W4','','','','',1,5.46,32.74,6,0.00,0.00,1,1,8.00,48.00,7.50,45.00,7.00,42.00,0.000,0.000,500.000,0.000,1),
  (838,'ALL- BRAN 800G',0,0,3,0,0,'NWM9709244W4','','','','',1,41.84,0.00,0,0.00,0.00,0,0,52.00,0.00,52.00,0.00,52.00,0.00,0.000,0.000,500.000,0.000,1),
  (839,'CALC-TOSE C/LECHE 920G',0,0,3,0,0,'TCM951030A17','','','','',1,84.50,0.00,0,0.00,0.00,0,0,95.00,0.00,95.00,0.00,95.00,0.00,0.000,0.000,500.000,0.000,1),
  (840,'LECHE NIDO CLASICA 900G',0,0,3,0,0,'NWM9709244W4','','','','',1,71.00,0.00,0,0.00,0.00,0,0,83.00,0.00,83.00,0.00,83.00,0.00,0.000,0.000,500.000,0.000,1),
  (841,'LECHE NIDO KINDER 1 400G',0,0,3,0,0,'NWM9709244W4','','','','',1,36.75,0.00,0,0.00,0.00,0,0,49.00,0.00,49.00,0.00,49.00,0.00,0.000,0.000,500.000,0.000,1),
  (842,'DURAZNOS MITADES AGUSTIN 820 C/12',0,0,3,0,0,'OCM870210PC6','','','','',1,12.92,155.00,12,0.00,0.00,1,1,17.00,204.00,14.50,174.00,14.00,168.00,0.000,0.000,500.000,0.000,1),
  (843,'JUGO JUMEX BRICK 1LT',0,0,3,0,0,'OCM870210PC6','','','','',1,10.30,103.00,10,0.00,0.00,1,1,13.00,130.00,12.00,120.00,12.00,120.00,0.000,0.000,500.000,0.000,1),
  (844,'MIEL COMERCIAL MELINA 1LT',0,0,3,0,0,'DIESS','','','','',1,17.67,212.04,12,0.00,0.00,1,1,22.00,264.00,22.00,264.00,22.00,264.00,0.000,0.000,500.000,0.000,1),
  (845,'PIÑA REBANADA VALENCIA 840G',0,0,3,0,0,'SNO950601EB5','','','','',1,13.33,320.00,24,0.00,0.00,1,1,16.00,384.00,15.50,372.00,15.00,360.00,0.000,0.000,500.000,0.000,1),
  (846,'REFRESCO LINEA PEPSI LATA',0,0,2,0,0,'NWM9709244W4','','','','',1,2.81,67.37,24,0.00,0.00,1,1,5.00,120.00,4.50,108.00,4.50,108.00,0.000,0.000,500.000,0.000,1),
  (847,'REFRESCO SIDRAL MUNDET',0,0,3,0,0,'NORTEÑA','','','','',1,4.08,98.00,24,0.00,0.00,1,1,7.00,168.00,6.50,156.00,6.50,156.00,0.000,0.000,500.000,0.000,1),
  (848,'CAFE TOSTER REGULAR .340 GM',1,0,3,0,0,'NWM9709244W4','','','','',2,0.00,0.00,0,127.88,127.88,0,0,145.00,0.00,145.00,0.00,145.00,0.00,0.000,0.000,490.075,0.000,1),
  (849,'CAFE TOSTER DESCAFEINADO .283 GM',0,0,3,0,0,'','','','','NWM9709244W4',1,147.21,147.21,1,0.00,0.00,0,1,158.00,158.00,158.00,158.00,158.00,158.00,0.000,0.000,500.000,0.000,1),
  (850,'PAU PAU',0,0,3,0,0,'XXX','','','','',1,1.86,44.69,24,0.00,0.00,0,1,3.00,50.00,3.00,50.00,3.00,50.00,0.000,0.000,500.000,0.000,1),
  (851,'SHAMPOO PANTENE SOBRES',0,0,3,0,0,'TAB890412AK8','','','','',1,1.30,31.28,24,0.00,0.00,0,1,2.00,36.00,2.00,36.00,2.00,36.00,0.000,0.000,500.000,0.000,1),
  (852,'JAMON AMERICANO MANDOLINA GALY',1,0,1,0,0,'EEC960514GY0','','','','',2,0.00,0.00,0,28.52,6.46,1,2,35.00,32.00,35.00,32.00,35.00,32.00,0.000,0.000,490.075,0.000,1),
  (853,'SALCHICHA FRANKFURT PAVO ALPINO',1,0,1,0,0,'ZWAN','','','','',2,0.00,0.00,0,20.65,2.60,0,2,30.00,25.00,30.00,25.00,30.00,25.00,0.000,0.000,490.075,0.000,1),
  (854,'TOCINETA',1,0,1,0,0,'HERS','','','','',2,0.00,0.00,0,36.00,1.10,0,2,42.00,39.50,42.00,39.50,42.00,39.50,0.000,0.000,490.075,0.000,1),
  (855,'QUESO AMARILLO FUNDIDO RANCHERITO',0,0,1,0,0,'PLASENCIA','','','','',1,11.50,115.00,10,0.00,0.00,1,1,14.00,125.00,14.00,140.00,14.00,140.00,0.000,0.000,500.000,0.000,1),
  (856,'QUESO AMARILLO FUNDIDO QUENACHO',0,0,1,0,0,'CVE9501177P3','','','','',1,9.60,96.00,10,0.00,0.00,1,1,13.00,118.00,13.00,130.00,13.00,130.00,0.000,0.000,500.000,0.000,1),
  (857,'VELADORA CUBERO ANGELITOS',0,0,3,0,0,'TAB890412AK8','','','','',1,8.00,160.00,20,0.00,0.00,1,1,12.00,240.00,9.50,190.00,9.50,190.00,0.000,0.000,500.000,5000.000,1),
  (858,'VELADORA CUBERO LUZ ETERNA',0,0,3,0,0,'TAB890412AK8','','','','',1,8.15,163.00,20,0.00,0.00,1,1,12.00,240.00,9.65,193.00,9.65,193.00,0.000,0.000,500.000,50000.000,1),
  (859,'VELA. REPUESTO LUZ ETERNA PAPEL',0,0,3,0,0,'TAB890412AK8','','','','',1,5.28,211.00,40,0.00,0.00,1,1,9.00,360.00,6.00,240.00,6.00,240.00,0.000,0.000,500.000,5000.000,1),
  (860,'VELADORA VIRGO',0,0,3,0,0,'TAB890412AK8','','','','',1,6.35,126.99,20,0.00,0.00,1,1,10.00,200.00,7.85,157.00,7.85,157.00,0.000,0.000,500.000,5000.000,1),
  (861,'VELADORA MURALLA',0,0,3,0,0,'TAB890412AK8','','','','',1,8.00,160.00,20,0.00,0.00,1,1,12.00,240.00,9.50,190.00,9.50,190.00,0.000,0.000,500.000,5000.000,1),
  (862,'VELADIRA LIMONERO PATRONA',0,0,3,0,0,'TAB890412AK8','','','','',1,7.50,149.99,20,0.00,0.00,1,1,12.00,240.00,9.00,180.00,9.00,180.00,0.000,0.000,500.000,5000.000,1),
  (863,'VELADORA FILO DE ORO SAN RAMON',0,0,3,0,0,'TAB890412AK8','','','','',1,10.83,130.00,12,0.00,0.00,1,1,15.00,180.00,13.33,159.96,13.33,159.96,0.000,0.000,500.000,5000.000,1),
  (864,'VELADORA NORTEÑO FILO DE ORO',0,0,3,0,0,'TAB890412AK8','','','','',1,6.80,136.00,20,0.00,0.00,1,1,11.00,220.00,8.30,166.00,8.30,166.00,0.000,0.000,500.000,5000.000,1),
  (865,'VELADORA ARAMO SEMANAL',0,0,3,0,0,'TAB890412AK8','','','','',1,14.50,174.00,12,0.00,0.00,1,1,18.00,216.00,17.00,204.00,17.00,204.00,0.000,0.000,500.000,5000.000,1),
  (866,'VELADORA ARAMO QUINCENAL',0,0,3,0,0,'TAB890412AK8','','','','',1,21.25,255.00,12,0.00,0.00,1,1,24.00,288.00,22.50,270.00,22.50,270.00,0.000,0.000,500.000,5000.000,1),
  (867,'VELADORA ARAMO ESMERALDA 2',0,0,3,0,0,'TAB890412AK8','','','','',1,29.50,177.00,6,0.00,0.00,1,1,34.00,204.00,32.50,195.00,32.50,195.00,0.000,0.000,500.000,5000.000,1),
  (868,'VELADORA ARAMO ESMERALDA 3',0,0,3,0,0,'TAB890412AK8','','','','',1,15.83,190.00,12,0.00,0.00,1,1,22.00,264.00,17.92,215.04,17.92,215.04,0.000,0.000,500.000,5000.000,1),
  (869,'VELADORA TAZA FLOR',0,0,3,0,0,'TAB890412AK8','','','','',1,7.78,140.00,18,0.00,0.00,1,1,11.00,198.00,9.44,169.92,9.44,169.92,0.000,0.000,500.000,5000.000,1),
  (870,'VELADORA MARINO SATURNO',0,0,3,0,0,'TAB890412AK8','','','','',1,7.15,142.90,20,0.00,0.00,1,1,11.00,220.00,8.60,172.00,8.60,172.00,0.000,0.000,500.000,5000.000,1),
  (871,'VIÑA REAL 2.6 LT',0,0,2,0,0,'CBA871214MS6','','','','',1,36.50,219.00,6,0.00,0.00,1,1,40.00,240.00,38.00,228.00,38.00,228.00,0.000,0.000,500.000,0.000,1),
  (872,'ALKA SELTZER',0,0,3,0,0,'TAB890412AK8','','','','',1,1.12,111.82,100,0.00,0.00,0,0,2.00,0.00,2.00,0.00,2.00,0.00,0.000,0.000,500.000,50000.000,1),
  (873,'ASPIRINA EFERVECENTE 2PZ',0,0,3,0,0,'TAB890412AK8','','','','',1,2.06,61.90,30,0.00,0.00,0,0,3.00,0.00,3.00,0.00,3.00,0.00,0.000,0.000,500.000,0.000,1),
  (874,'DECAF SOLUBLE SOBRE 14G',0,0,3,0,0,'NWM9709244W4','','','','',1,2.81,56.17,20,0.00,0.00,1,1,3.50,70.00,3.00,60.00,3.00,60.00,0.000,0.000,500.000,0.000,1),
  (875,'SALSA DE SOYA KIKOMAN 1.890ML',0,0,1,0,0,'NWM9709244W4','','','','',1,80.82,0.00,0,0.00,0.00,0,0,92.00,0.00,92.00,0.00,92.00,0.00,0.000,0.000,500.000,0.000,1),
  (876,'SPLENDA 500 SOBRES',0,0,3,0,0,'NWM9709244W4','','','','',1,0.27,136.57,500,0.00,0.00,1,1,0.36,180.00,0.30,152.00,0.30,152.00,0.000,0.000,500.000,5000.000,1),
  (877,'QUESO PANELA PAULET',1,0,1,0,0,'SJM880607FU8','','','','',2,0.00,0.00,0,51.50,2.07,1,2,62.00,117.99,57.00,117.99,57.00,117.99,0.000,0.000,490.075,0.000,1),
  (878,'YOGURTH DULAIT 1LT',0,0,3,0,0,'PLR86022136M3','','','','',1,12.00,192.00,16,0.00,0.00,1,0,15.00,0.00,14.00,0.00,14.00,0.00,0.000,0.000,500.000,0.000,1),
  (879,'MAIZ POZOLERO A GRANEL',1,0,1,0,0,'CRISANTOS','','','','',2,0.00,0.00,0,6.50,1.00,1,0,11.00,0.00,10.00,0.00,10.00,0.00,0.000,0.000,490.075,0.000,1),
  (880,'LONGANIZA Y CHORIZO ALBERTOS',1,0,1,0,0,'XXX','','','','',2,0.00,0.00,0,21.00,1.00,1,0,29.00,0.00,29.00,0.00,29.00,0.00,0.000,0.000,490.075,0.000,1),
  (881,'COFFE MATE STICK',0,0,3,0,0,'MEG0202151X5','','','','',1,0.30,59.70,200,0.00,0.00,1,1,1.00,65.00,1.00,65.00,1.00,65.00,0.000,0.000,500.000,0.000,1),
  (882,'NESCAFE CAPUCHINO VAINILLA',0,0,3,0,0,'MEG0202151X5','','','','',1,32.25,387.00,12,0.00,0.00,1,1,39.00,425.00,39.00,425.00,39.00,425.00,0.000,0.000,500.000,0.000,1),
  (883,'PECHUGA DE PAVO HIDALMEX',1,0,1,0,0,'COGM680129LYO','','','','',2,0.00,0.00,0,48.00,4.00,1,2,55.00,50.00,55.00,50.00,55.00,50.00,0.000,0.000,490.075,0.000,1),
  (884,'JAMON VIRGINIA DE PAVO SWAN',1,0,1,0,0,'QAO680613E91','','','','',2,0.00,0.00,0,46.50,4.00,1,2,58.00,52.00,58.00,52.00,58.00,52.00,0.000,0.000,490.075,0.000,1),
  (885,'jamon de prueba',1,0,1,0,0,'VAPB730831UM9','','','','',2,0.00,0.00,0,110.00,1.00,1,0,121.00,0.00,118.80,0.00,115.50,0.00,100.000,1.000,490.075,0.000,1);

COMMIT;

#
# Data for the `codigosb` table  (LIMIT 0,500)
#

# ID_Pro:3:32768
# codBarra:253:0

INSERT INTO codigosb (ID_Pro, codBarra) VALUES 
  (43,'074323046199'),
  (92,'7502008081232'),
  (49,'7501728008253'),
  (171,'7501031311309'),
  (171,'7501031360130'),
  (171,'7501031346301'),
  (171,'7501031323302'),
  (181,'7501369816224'),
  (182,'783760100820'),
  (197,'097339092011'),
  (198,'097339090017'),
  (210,'7501083100050'),
  (223,'7501052412016'),
  (232,'7501008001028'),
  (263,'1750100066497'),
  (265,'1750100061182'),
  (277,'7616100011568'),
  (294,'7501011361492'),
  (303,'7501017050161'),
  (304,'7501008089545'),
  (217,'681131004961'),
  (217,'681131898362'),
  (217,'681131898379'),
  (307,'028000363307'),
  (312,'014800515336'),
  (334,'7501005117968'),
  (339,'050000131457'),
  (340,'7501005119115'),
  (341,'7646441030386'),
  (254,'7501000142200'),
  (384,'1750102429237'),
  (385,'1750102429236'),
  (421,'7501868721098'),
  (424,'7501032605418'),
  (105,'7501026004612'),
  (106,'7501026004605'),
  (107,'7501007452876'),
  (85,'7501001130657'),
  (108,'7501007455761'),
  (287,'7501025403034'),
  (225,'7501052411316'),
  (225,'7501052411132'),
  (65,'7501095467042'),
  (286,'7501943459038'),
  (285,'7501007444772'),
  (112,'7509546017150'),
  (126,'7501069210223'),
  (335,'7501005181044'),
  (111,'7509546017143'),
  (111,'7509546000329'),
  (18,'048327102038'),
  (19,'8410010811749'),
  (20,'7501017004218'),
  (21,'7503000208054'),
  (22,'7502006273004'),
  (27,'7501868722064'),
  (28,'758104001729'),
  (29,'758104100422'),
  (31,'758104000357'),
  (32,'758104001088'),
  (33,'7501073830509'),
  (35,'7503000208023'),
  (34,'7503000208016'),
  (331,'7503008846012'),
  (36,'7501037217162'),
  (37,'7501037217070'),
  (39,'7501045400068'),
  (485,'7501000111800'),
  (361,'7501000112333'),
  (362,'7501000111855'),
  (364,'7501000111602'),
  (47,'7503000208191'),
  (60,'738545020206'),
  (62,'7501073411173'),
  (52,'7501058714121'),
  (53,'7501058714329'),
  (54,'7501058714428'),
  (55,'7501058714527'),
  (57,'7501058715128'),
  (58,'7501058716125'),
  (59,'7501058718129'),
  (63,'7501014300016'),
  (67,'7501020200379'),
  (66,'7501020200386'),
  (131,'7501017003341'),
  (79,'7501017003075'),
  (82,'7501017003181'),
  (175,'7501017003020'),
  (99,'7501017003037'),
  (70,'7501020200829'),
  (71,'7501067491341'),
  (146,'7503000208573'),
  (473,'021000615445'),
  (472,'021000615315'),
  (315,'7501003150233'),
  (128,'7501001604004'),
  (127,'7501001604103'),
  (291,'7501001604387'),
  (292,'7501001604318'),
  (195,'097339000047'),
  (193,'097339000030'),
  (196,'097339000061'),
  (194,'097339000054'),
  (200,'7501037217179'),
  (199,'7503000208399'),
  (214,'064144030323'),
  (314,'7501005103022'),
  (296,'7501017050178'),
  (297,'7501017040490'),
  (93,'041500750903'),
  (141,'041500763668'),
  (142,'041500767574'),
  (123,'7501017004515'),
  (68,'7501017004140'),
  (69,'7501017004171'),
  (115,'7501017004157'),
  (120,'7501017004294'),
  (118,'7501017004423'),
  (117,'7501017004270'),
  (119,'7501017004362'),
  (83,'7501017004911'),
  (74,'7501017005000'),
  (172,'7501017006014'),
  (84,'7501017005031'),
  (102,'7501017006021'),
  (101,'7501017006007'),
  (299,'7501000913312'),
  (299,'7501000903252'),
  (299,'7501000913305'),
  (299,'7501000903443'),
  (299,'7501000913343'),
  (299,'7501000913572'),
  (328,'7501005180306'),
  (158,'7501017004805'),
  (130,'7501005181228'),
  (344,'7501005180658'),
  (298,'633148100013'),
  (209,'7501083100029'),
  (211,'7501083100012'),
  (213,'7501083100074'),
  (216,'681131004596'),
  (215,'7501491000966'),
  (290,'017479831011'),
  (25,'7501002622526'),
  (140,'738545010788'),
  (138,'738545060042'),
  (77,'7501017002009'),
  (176,'7501017002023'),
  (80,'7501017002061'),
  (100,'7501017002238'),
  (188,'7501017002054'),
  (116,'7501067476218'),
  (78,'034522260109'),
  (72,'7501067491365'),
  (103,'7501067472715'),
  (81,'7501324102621'),
  (187,'7501052472034'),
  (122,'7501017002139'),
  (61,'738545020046'),
  (104,'7501026004629'),
  (109,'7501001117290'),
  (113,'7501001121051'),
  (86,'7501078500391'),
  (87,'7501067474153'),
  (137,'7501003340115'),
  (136,'7501003340122'),
  (134,'7501003340146'),
  (133,'7501003340153'),
  (276,'7501001619046'),
  (279,'7501005110389'),
  (91,'7501005110563'),
  (275,'7501069210759'),
  (269,'7501024207022'),
  (124,'7501018316006'),
  (338,'7501586300018'),
  (280,'7502223774025'),
  (204,'735257001110'),
  (204,'735257001073'),
  (204,'735257001097'),
  (204,'735257001042'),
  (204,'735257001196'),
  (204,'735257001141'),
  (204,'735257001028'),
  (204,'735257001066'),
  (267,'1750101160807'),
  (45,'7501037217124'),
  (46,'7501037217063'),
  (183,'783760100806'),
  (110,'7501007445557'),
  (318,'7509546016344'),
  (318,'7509546016375'),
  (318,'7509546016306'),
  (288,'7501025403027'),
  (300,'7501268200247'),
  (300,'7501268200223'),
  (222,'7501035910089'),
  (221,'7501035910072'),
  (114,'7501728028176'),
  (89,'7501728028053'),
  (155,'7501728029135'),
  (156,'7501728029142'),
  (323,'7501017002368'),
  (324,'7501067475150'),
  (189,'7501868724037'),
  (184,'738545010726'),
  (310,'7501059211322'),
  (320,'7501119500366'),
  (154,'7501001602918'),
  (235,'7501001602406'),
  (236,'7501001602420'),
  (316,'050000131655'),
  (342,'051500037997'),
  (313,'074323083620'),
  (313,'074323083644'),
  (413,'7501001600105'),
  (231,'7501008061251'),
  (237,'7501095467028'),
  (219,'7501761810394'),
  (270,'7501024577217'),
  (220,'030000010402'),
  (336,'7501001603755'),
  (234,'7501095425110'),
  (330,'036731135513'),
  (10,'7501049552169'),
  (88,'7501728028114'),
  (301,'036731125750'),
  (301,'036731125774'),
  (301,'03673112576'),
  (90,'0750222406325'),
  (125,'7501069210032'),
  (327,'032239052000'),
  (327,'032239052017'),
  (143,'7501868735033'),
  (302,'7501017003716'),
  (159,'9002490100070'),
  (162,'7501055302451'),
  (163,'7501055305247'),
  (165,'7501055305339'),
  (166,'7501055320639'),
  (169,'7501031322558'),
  (169,'7501071120183'),
  (169,'7501031360024'),
  (169,'7501031340071'),
  (170,'7501071120176'),
  (170,'7501031323449'),
  (170,'7501031360154'),
  (170,'7501031346646'),
  (170,'7501031311682'),
  (180,'7501073831902'),
  (180,'7501073831926'),
  (180,'7501073831896'),
  (167,'7503006897023'),
  (177,'019836202038'),
  (177,'019836202045'),
  (177,'019836202052'),
  (177,'019836202069'),
  (177,'01983620202'),
  (177,'019836202076'),
  (179,'74488637505'),
  (179,'744886405053'),
  (179,'744886365050'),
  (179,'744886385058'),
  (179,'744886395057'),
  (185,'738545010016'),
  (191,'7501018203849'),
  (192,'738545070010'),
  (190,'7501868724075'),
  (329,'7501025403218'),
  (245,'7501000139699'),
  (246,'7501000101009'),
  (249,'7501000306657'),
  (247,'7501000101450'),
  (248,'7501000103232'),
  (248,'7501000103287'),
  (248,'7501000103259'),
  (251,'7501000149469'),
  (250,'7501030428695'),
  (252,'7501000142408'),
  (253,'7501000142453'),
  (255,'7501000125050'),
  (256,'7501000142705'),
  (326,'7501030441397'),
  (257,'7501000142804'),
  (347,'041789901911'),
  (347,'041789901997'),
  (347,'041789901843'),
  (347,'041789901850'),
  (347,'041789901928'),
  (347,'041789901959'),
  (203,'086141001564'),
  (203,'086141001557'),
  (202,'086141001519'),
  (202,'086141001502'),
  (202,'086141001526'),
  (205,'730399003343'),
  (306,'7501008050934'),
  (233,'7501008055830'),
  (218,'7501047600206'),
  (224,'7501052411323'),
  (284,'7501095425028'),
  (337,'7501095425059'),
  (226,'7501095425103'),
  (227,'7501095450341'),
  (333,'7501084474363'),
  (230,'75025120'),
  (305,'7501008081525'),
  (240,'7501002634154'),
  (258,'7501008055823'),
  (262,'7501000626229'),
  (262,'7501000626236'),
  (262,'7501000624089'),
  (262,'7501000651375'),
  (262,'7501000663996'),
  (262,'7501000614530'),
  (264,'7501000611829'),
  (271,'7501026005671'),
  (272,'012388000015'),
  (273,'7501007419367'),
  (273,'7501001126209'),
  (273,'7590002012550'),
  (273,'7501001164232'),
  (273,'7501001121792'),
  (274,'7501035902022'),
  (274,'7509546011943'),
  (311,'7501001617943'),
  (317,'7501008072288'),
  (309,'7501059209633'),
  (343,'7503003951223'),
  (283,'7501001303600'),
  (478,'7501035911031'),
  (332,'605388833563'),
  (809,'7501002600661'),
  (809,'7501002669286'),
  (809,'7501002600074'),
  (346,'7896093092113'),
  (475,'7501057730207'),
  (474,'7501057740411'),
  (468,'7501147515035'),
  (711,'7501639302136'),
  (402,'7750108471411'),
  (405,'612154000036'),
  (9,'75000578'),
  (408,'7501032602482'),
  (429,'7501147522859'),
  (430,'7501147514571'),
  (427,'7501428300794'),
  (428,'7501147525201'),
  (432,'7501147510405'),
  (434,'7501057710124'),
  (431,'7501147515103'),
  (425,'7501147521623'),
  (450,'7503004126163'),
  (569,'7501147525157'),
  (461,'7501057720246'),
  (462,'7501325700123'),
  (467,'7501057720130'),
  (295,'076150200393'),
  (96,'076150430516'),
  (98,'076150200386'),
  (97,'076150420098'),
  (229,'013000580403'),
  (228,'7792129001510'),
  (261,'7501000608089'),
  (281,'010387082001'),
  (278,'7501005106979'),
  (278,'7501005145800'),
  (278,'7501005107013'),
  (278,'7501005107297'),
  (278,'7501005107150'),
  (242,'08304319'),
  (289,'08300216'),
  (293,'041390000706'),
  (319,'75001520'),
  (319,'75001513'),
  (412,'7501001600426'),
  (409,'7501020511451'),
  (419,'7501512805006'),
  (380,'7501032600273'),
  (390,'7501055901111'),
  (390,'7501055901104'),
  (390,'7501055901128'),
  (397,'7501032346362'),
  (397,'7501032346324'),
  (383,'1750103260068'),
  (382,'1750103260083'),
  (698,'7501040084102'),
  (56,'7501058714916'),
  (164,'7501055300075'),
  (161,'75007614'),
  (697,'7501642301027'),
  (414,'7501059225626'),
  (153,'7501001602932'),
  (387,'7501868732049'),
  (168,'7503006897016'),
  (17,'7502006460022'),
  (16,'7502006460039'),
  (15,'7502006460305'),
  (452,'7501057710476'),
  (471,'7501002203251'),
  (415,'7501055900039'),
  (30,'758104000159'),
  (132,'7501003340160'),
  (121,'75001940'),
  (121,'75001971'),
  (121,'75001957'),
  (121,'75001988'),
  (418,'7502217040556'),
  (433,'7501147515769'),
  (12,'7501048100248'),
  (11,'7501048100163'),
  (23,'7501005152822'),
  (24,'7501003334367'),
  (731,'7501315000516'),
  (731,'7501315000837'),
  (731,'7501315000820'),
  (416,'7501055900800'),
  (477,'7501025511036'),
  (388,'7501032334000'),
  (388,'7501032334703'),
  (389,'75020613'),
  (404,'612154000029'),
  (420,'7501032601164'),
  (476,'7501002615122'),
  (422,'7501032601256'),
  (13,'7501048100460'),
  (423,'7501611401314'),
  (573,'7501639334915'),
  (466,'7501147534968'),
  (325,'2000012397707'),
  (381,'1750103260062'),
  (470,'7501044814040'),
  (411,'7501020512373'),
  (359,'7501000122332'),
  (241,'75001322'),
  (241,'75014551'),
  (241,'75017231'),
  (241,'75020217'),
  (243,'75016760'),
  (243,'75016777'),
  (244,'0830831'),
  (244,'08305114'),
  (366,'7501000111251'),
  (38,'7501045400044'),
  (201,'7501943480278'),
  (151,'7501032605254'),
  (152,'7501032604615'),
  (150,'7501032604585'),
  (148,'7501032604408'),
  (149,'7501032604578'),
  (399,'7501055900336'),
  (398,'7501055900121'),
  (410,'7501020511468'),
  (44,'7501059216310'),
  (50,'7501268200025'),
  (51,'7501268200070'),
  (259,'7509546009889'),
  (259,'7509546008295'),
  (259,'7509546006437'),
  (259,'7501035910034'),
  (259,'7509546008202'),
  (259,'7501035910096'),
  (260,'75001186'),
  (260,'75001162'),
  (26,'7501868722095'),
  (129,'7501764801061'),
  (129,'7501764801023'),
  (129,'7501764801078'),
  (129,'7501764801153'),
  (129,'7501764801085'),
  (379,'5750101361005'),
  (41,'75003111'),
  (41,'75003135'),
  (41,'75003159'),
  (41,'75003173'),
  (41,'75003104'),
  (41,'75003180'),
  (40,'7501039400449'),
  (40,'7501039400418'),
  (40,'7501039400456'),
  (40,'7501039400432'),
  (40,'7501039400500'),
  (42,'75001773'),
  (42,'75001759'),
  (42,'75001797'),
  (42,'75001810'),
  (42,'75001834'),
  (696,'7501103910409'),
  (417,'7502217040600'),
  (391,'7501303904604'),
  (391,'7501303904659'),
  (391,'7501303904642'),
  (391,'7501303904611'),
  (391,'7501303904628'),
  (392,'7501303904208'),
  (392,'7501303904253'),
  (392,'7501303904239'),
  (392,'7501303904246'),
  (392,'7501303904215'),
  (392,'7501303904222'),
  (392,'7501303915273');

COMMIT;

#
# Data for the `codigosb` table  (LIMIT 500,500)
#

# ID_Pro:3:32768
# codBarra:253:0

INSERT INTO codigosb (ID_Pro, codBarra) VALUES 
  (574,'7501303908657'),
  (575,'7501303907209'),
  (469,'7501303902501'),
  (576,'7501303903409'),
  (567,'7501147513222'),
  (465,'7501147542994'),
  (322,'7501018310516'),
  (322,'7501018310257'),
  (322,'7501018310103'),
  (173,'7501017005024'),
  (174,'7501017004027'),
  (75,'7501017004003'),
  (76,'7501017003006'),
  (445,'7501057710162'),
  (426,'7501325700635'),
  (463,'7501057720178'),
  (464,'7501057720154'),
  (460,'7501325702448'),
  (64,'7501073412804'),
  (268,'7501024579327'),
  (8,'75002343'),
  (363,'7501000111503'),
  (95,'7501059211728'),
  (48,'7501064112546'),
  (135,'7501003340139'),
  (403,'8750108471146'),
  (212,'7501083100036'),
  (206,'756702131305'),
  (386,'1750102420324'),
  (400,'7501055900343'),
  (401,'7501055901364'),
  (186,'7502006273011'),
  (14,'764644101935'),
  (459,'7503004126262'),
  (458,'7503004126378'),
  (457,'7503004126088'),
  (360,'7501000111466');

COMMIT;

