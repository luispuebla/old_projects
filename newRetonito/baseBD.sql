# EMS MySQL Manager 2.8.5.1
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : newretono


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS newretono;

CREATE DATABASE newretono;

USE newretono;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
  ('kiko','kiko','administrador','Administrador',1,2006,0,1),
  ('candela','candela','administrador','Administrador',2,2500,0,1);

COMMIT;

#
# Data for the `permisos` table  (LIMIT 0,500)
#

# Tipo:3:32768
# Clave:3:32768

INSERT INTO permisos (Tipo, Clave) VALUES 
  (1,1234),
  (2,4321);

COMMIT;

INSERT INTO avisos (automatico, frase, activo) VALUES
  (1,'Sus amigos del Retoño agradecemos su compra. ¡Lo esperamos pronto!',1);
  
COMMIT;

