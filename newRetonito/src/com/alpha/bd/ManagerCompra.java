package com.alpha.bd;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Date;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Calendar;
import java.math.*;


public class ManagerCompra {

	private String error = new String("");
	private String claveProveedor = new String("");
	private String claveProducto = new String("");
	private String tipoS = new String("");
	private String observaciones = new String("");
	private String descuento1 = new String("");
	private String descuento2 = new String("");
	private String descuento3 = new String("");
	private String subtotal = new String("");
	private String descuento = new String("");
	private String iva = new String("");
	private String total = new String("");
	private String fechaentrega = new String("");
	private String cantNumProductos = new String("");
	private String claveOrden = new String("");
	private String compra = new String("");
	private String fechaCompra = new String("");
	private String tempProducto = new String("");
	private String tempUnidad = new String("");
	private String can1 = new String("");
	private String can2 = new String("");
	private String can3 = new String("");
	private String prod1 = new String("");
	private String prod2 = new String("");
	private String prod3 = new String("");
	private String tipoUni1 = new String("");
	private String tipoUni2 = new String("");
	private String tipoUni3 = new String("");
	private String docAval = new String("");
	private String recepcion = new String("");
	private	String usuario = new String("");
	private	String laRuta = new String("");
	private String fechaInicial = new String("");
	private String fechaFinal = new String("");
	private String tipoDocumento = new String("");
	private Properties p = new Properties();
	private String[] arrayCantidad   = null;
	private	String[] arrayProducto   = null;
	private	String[] arrayCunidad   = null;
	private	String[] arrayImporte   = null;
	private String[] arrayTipo = null;
	private String[] arrayCambio = null;
	private TimeStamp tiempo;
	private ConexionBD con;
	private ConexionBD con2;
	private ConexionBD con3;

	public void setFechaInicial(String fechaInicial){
		this.fechaInicial = fechaInicial;
	}

	public void setTipoDocumento(String tipoDocumento){
		this.tipoDocumento = tipoDocumento;
	}

	public void setFechaFinal(String fechaFinal){
		this.fechaFinal = fechaFinal;
	}

	public void setClaveProveedor(String claveProveedor){
		this.claveProveedor = claveProveedor;
	}

	public void setDocAval(String docAval){
		this.docAval = docAval;
	}


	public void setRecepcion(String recepcion){
		this.recepcion = recepcion;
	}

	public void setClaveProducto(String claveProducto){
		this.claveProducto = claveProducto;
	}

	public void setTipoS(String tipoS){
		this.tipoS = tipoS;
	}

public void setObservaciones(String observaciones){
			this.observaciones = observaciones;
	}

	public void setDescuento1(String descuento1){
			this.descuento1 = descuento1;
	}

	public void setDescuento2(String descuento2){
			this.descuento2 = descuento2;
	}

	public void setDescuento3(String descuento3){
			this.descuento3 = descuento3;
	}

	public void setSubtotal(String subtotal){
			this.subtotal = subtotal;
	}

	public void setDescuento(String descuento){
			this.descuento = descuento;
	}

	public void setIva(String iva){
			this.iva = iva;
	}

	public void setTotal(String total){
			this.total = total;
	}

	public void setCan1(String can1){
				this.can1 = can1;
		}

	public void setCan2(String can2){
				this.can2 = can2;
		}

	public void setCan3(String can3){
				this.can3 = can3;
	}


	public void setProd1(String prod1){
				this.prod1 = prod1;
	}

	public void setProd2(String prod2){
				this.prod2 = prod2;
	}

	public void setProd3(String prod3){
				this.prod3 = prod3;
	}


	public void setTipoUni1(String tipoUni1){
		if(tipoUni1.equalsIgnoreCase("Pieza")){
			tipoUni1 =  "0";
		}
		else if(tipoUni1.equalsIgnoreCase("Caja")){
			tipoUni1 =  "1";
		}
		else if(tipoUni1.equalsIgnoreCase("Kilo")){
			tipoUni1 =  "2";
		}
		this.tipoUni1 = tipoUni1;
	}

	public void setTipoUni2(String tipoUni2){
		if(tipoUni2.equalsIgnoreCase("Pieza")){
			tipoUni2 =  "0";
		}
		else if(tipoUni2.equalsIgnoreCase("Caja")){
			tipoUni2 =  "1";
		}
		else if(tipoUni2.equalsIgnoreCase("Kilo")){
			tipoUni2 =  "2";
		}
		this.tipoUni2 = tipoUni2;
	}

	public void setTipoUni3(String tipoUni3){
		if(tipoUni3.equalsIgnoreCase("Pieza")){
			tipoUni3 =  "0";
		}
		else if(tipoUni3.equalsIgnoreCase("Caja")){
			tipoUni3 =  "1";
		}
		else if(tipoUni3.equalsIgnoreCase("Kilo")){
			tipoUni3 =  "2";
		}
		this.tipoUni3 = tipoUni3;
	}

	public void setUsuario(String usuario){
				this.usuario = usuario;
	}

	public void setLaRuta(String laRuta){
			this.laRuta = laRuta;
	}

	public void setFechaentrega(String fechaentrega){
			this.fechaentrega = fechaentrega;
	}

	public void setCantNumProductos(String cantNumProductos){
			this.cantNumProductos = cantNumProductos;
	}

	public void setClaveOrden(String claveOrden){
				this.claveOrden = claveOrden;
	}

	public void setCompra(String compra){
					this.compra = compra;
	}

	public void setFechaCompra(String fechaCompra){
					this.fechaCompra = fechaCompra;
	}

	public void setTempProducto(String tempProducto){
						this.tempProducto = tempProducto;
	}

	public void setArrayTipo(String[] ArrayTipo) throws Exception{
		arrayTipo = new String[ArrayTipo.length];
		System.arraycopy(ArrayTipo, 0, this.arrayTipo, 0, ArrayTipo.length);
	}


	public void setArrayCantidad(String[] ArrayCantidad) throws Exception{
		arrayCantidad = new String[ArrayCantidad.length];
		System.arraycopy(ArrayCantidad, 0, this.arrayCantidad, 0, ArrayCantidad.length);
	}

	public void setArrayProducto(String[] ArrayProducto) throws Exception{
		arrayProducto = new String[ArrayProducto.length];
		System.arraycopy(ArrayProducto, 0, this.arrayProducto, 0, ArrayProducto.length);
	}


	public void setArrayCunidad(String[] ArrayCunidad) throws Exception{
		arrayCunidad = new String[ArrayCunidad.length];
		System.arraycopy(ArrayCunidad, 0, this.arrayCunidad, 0, ArrayCunidad.length);
	}

	public void setArrayImporte(String[] ArrayImporte) throws Exception{
		arrayImporte = new String[ArrayImporte.length];
		System.arraycopy(ArrayImporte, 0, this.arrayImporte, 0, ArrayImporte.length);
	}

	public void setArrayCambio(String[] ArrayCambio) throws Exception{
		arrayCambio = new String[ArrayCambio.length];
		System.arraycopy(ArrayCambio, 0, this.arrayCambio, 0, ArrayCambio.length);
	}


// BORRAME DESDE AQUI
	private String can4 = new String("");
	private String can5 = new String("");
	private String can6 = new String("");
	private String can7 = new String("");
	private String can8 = new String("");
	private String can9 = new String("");
	private String can10 = new String("");
	private String can11 = new String("");
	private String can12 = new String("");
	private String can13 = new String("");
	private String can14 = new String("");
	private String can15 = new String("");
	private String prod4 = new String("");
	private String prod5 = new String("");
	private String prod6 = new String("");
	private String prod7 = new String("");
	private String prod8 = new String("");
	private String prod9 = new String("");
	private String prod10 = new String("");
	private String prod11 = new String("");
	private String prod12 = new String("");
	private String prod13 = new String("");
	private String prod14 = new String("");
	private String prod15 = new String("");
// HASTA AQUI


/**
* El Método dameProductosComprados nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico y que fueron comprados NO regalados..
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet dameProductosComprados(String claveCompra) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT  ClaveProducto, Cantidad, Tipo, Costo, CambiaPrecio, Importe, Llegan  FROM productos_orden  WHERE ClaveOrden = "+claveCompra+" AND Adquisicion = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameProductosComprados ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameProductosComprados ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método dameProductosObsequiados nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico y que fueron regalados NO comprados..
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet dameProductosObsequiados(String claveCompra) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT  ClaveProducto, Cantidad, Tipo, Costo, Importe, Llegan  FROM productos_orden  WHERE ClaveOrden = "+claveCompra+" AND Adquisicion = 0");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameProductosObsequiados ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameProductosObsequiados ");
			e.printStackTrace();
		}
		return rs;
	}


	public ResultSet productosXProveedor(String claveProveedor) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = (	"SELECT ID_Pro, descripcion, tipoPro, precioUniCompra, preCaCompra, precioUnidadKG, uniCompra FROM productos WHERE (id_prov1 = '"+	claveProveedor+"' OR id_prov2 = '"+claveProveedor +"' OR  id_prov3 = '"+claveProveedor +"' OR  id_prov4 = '"+claveProveedor +"' OR  id_prov5 = '"+claveProveedor +"') AND activo = 1 ORDER BY descripcion");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerCompra, productosXProveedor ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerCompra, productosXProveedor ");
				e.printStackTrace();
			}
		}
		return rs;
	}


	public int dameCantidadProdXProv (String claveProveedor) throws SQLException, Exception{
		ResultSet rs = null;
		int cantProductos = 0;
		con = new ConexionBD();
		if(con !=null){
			try{
				String query = ("SELECT COUNT(ID_Pro) AS cantidad  FROM productos WHERE (id_prov1 = '"+claveProveedor +"' OR  id_prov2 = '"+claveProveedor 	+"' OR  id_prov3 = '"+claveProveedor +"' OR  id_prov4 = '"+claveProveedor +"' OR  id_prov5 = '"+claveProveedor +"')  AND activo = 1");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					cantProductos = rs.getInt("cantidad");
				}
				if(rs != null){
					rs.close();
					stmt.close();
				}
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerCompra, dameCantidadProdXProv ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerCompra, dameCantidadProdXProv ");
				e.printStackTrace();
			}
			finally{
				if(con != null){
					try{
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameCantidadProdXProv ");
						q.printStackTrace();
					}
				}
			}
		}
		return cantProductos;
	}



	public double precioAsignado(String claveProducto,String tipoProducto) throws SQLException, Exception{;
		ResultSet rs = null;
		double precioProducto = 0.00;
		String query = "";
		if(tipoProducto.equals("PZ")){ // Precio de compra por Pieza
			query = "SELECT (precioUniCompra)AS precio,  gravaIVA FROM productos WHERE ID_Pro = '"+claveProducto +"' AND activo = 1";
		}
		else if(tipoProducto.equals("CJ")){ // Precio de compra por Caja
			query = "SELECT (preCaCompra)AS precio, gravaIVA FROM productos WHERE ID_Pro = '"+claveProducto +"' AND activo = 1";
		}
		else{ // Precio de Compra por Kilo
			query = "SELECT (precioUnidadKG)AS precio, gravaIVA FROM productos WHERE ID_Pro = '"+claveProducto +"' AND activo = 1";
		}
		con = new ConexionBD();
		if(con != null){
			try{
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					precioProducto = rs.getDouble("precio");
				}
				if(rs != null){
					rs.close();
					stmt.close();
				}
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerCompra, precioAsignado ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerCompra, precioAsignado ");
				e.printStackTrace();
			}
			finally{
				if(con != null){
					try{
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al momento de cerrar conexion en ManagerCompra, precioAsignado ");
						q.printStackTrace();
					}
				}
			}
		}
		return precioProducto;
	}


	public ResultSet datosProveedorCompra(String claveProveedor) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = (	"SELECT nombre, IDCredito, credito, diasPago, descuento1, descuento2, descuento3, saldoDisponible FROM proveedores WHERE rfc = '"+claveProveedor+"' AND activo = 1 LIMIT 1");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerCompra, productosXProveedor ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerCompra, productosXProveedor ");
				e.printStackTrace();
			}
		}
		return rs;
	}

	public String dameFechaHoy() throws Exception{
		tiempo = new TimeStamp();
		return  tiempo.date2;
	}

/**
* El método tieneIva verifica que el Producto agrave IVA.
*	@return bandera 	Boolean si es igual 0 la Línea no exite y si es igual a 1 la Línea se encuentra en la Base de Datos.
*/

public boolean tieneIva(String producto) throws SQLException, Exception     {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		ConexionBD con2 = new ConexionBD();
  	  if (con2.miConnection !=null) {
  	  	try {
  	  		st = con2.creaStatement();
  	  		rs = st.executeQuery("select gravaIVA from productos where ID_Pro = "+producto +" AND activo = 1");
  	  		while(rs.next()){
  	  			if(rs.getInt("gravaIVA") == 1) {
  	  				bandera = true;
  	  			}
  	  		}
  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCompra metodo tieneIva");
					q.printStackTrace();
				}
			}
  	  }
  	  return bandera;
  }

/**
* El método piezasXCaja nos informa de cuantas piezas esta compuesta una caja..
*	@return bandera 	int  con la cantidad de piezas por Caja
*/

public int  piezasXCaja(String producto) throws SQLException, Exception     {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int cantidad  = 0;
		ConexionBD con2 = new ConexionBD();
  	  if (con2.miConnection !=null) {
  	  	try {
  	  		st = con2.creaStatement();
  	  		rs = st.executeQuery("select cantidadXCaja from productos where ID_Pro = "+producto +" AND activo = 1");
  	  		while(rs.next()){
  	  			cantidad = rs.getInt("cantidadXCaja");
  	  		}
  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCompra metodo piezasXCaja");
					q.printStackTrace();
				}
			}
  	  }
  	  return cantidad;
  }


/**
* El método dameKgXUnidad nos informa de cuantas piezas esta compuesta una caja..
*	@return bandera 	int  con la cantidad de piezas por Caja
*/

public double dameKgXUnidad(String producto) throws SQLException, Exception {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  double cantidad  = 0;
		ConexionBD con2 = new ConexionBD();
  	  if (con2.miConnection !=null) {
  	  	try {
  	  		st = con2.creaStatement();
  	  		rs = st.executeQuery("select kgXUnidad from productos where ID_Pro = "+producto +" AND activo = 1");
  	  		while(rs.next()){
  	  			cantidad = rs.getDouble("kgXUnidad");
  	  		}
  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCompra metodo dameKgXUnidad");
					q.printStackTrace();
				}
			}
  	  }
  	  return cantidad;
  }



public double quitaIVA(String valor) throws Exception{
	double regreso = cambiaADouble(valor);
	regreso = (regreso*100)/115;
	return regreso;
}


public double regresaIVA(String valor) throws Exception{
	double regreso = cambiaADouble(valor);
	regreso = (regreso*1.15);
	return regreso;
}

/**
* El Método dameDatosCompra nos regresa los Datos de una Compra
*
*  @return rs ResultSet con los Datos de la compra
*/
	public ResultSet dameDatosCompra(String claveCompra) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM orden_Compra WHERE claveOrden = "+claveCompra +" AND activo = 1 LIMIT 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameDatosCompra ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameDatosCompra ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método dameDatosCompra nos regresa los Datos de una Compra
*
*  @return rs ResultSet con los Datos de la compra
*/
	public ResultSet dameProductosCompra(String claveCompra) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM productos_orden WHERE ClaveOrden = "+claveCompra +" ORDER BY Adquisicion DESC ");
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameProductosCompra ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameProductosCompra ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método datosImpCheque nos regresa los Datos del cheque
*
*  @return rs ResultSet con los Datos del cheque.
*/
	public ResultSet datosImpCheque(String consePago) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT pagos.fechaPago, proveedores.nombre, pagos.monto  FROM pagos, proveedores  WHERE pagos.consecutivo = "+consePago +" AND proveedores.rfc = pagos.claveProveedor");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, datosImpCheque ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, datosImpCheque ");
			e.printStackTrace();
		}
		return rs;
	}



	public ResultSet dameRecepcionesPrevias(String clave) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT aval_por_documento.ConsecutivoRecepcion, aval_por_documento.ClaveProducto, productos.descripcion, aval_por_documento.Tipo, aval_por_documento.Cantidad, aval_por_documento.DocAval, aval_por_documento.TipoDocAval, aval_por_documento.FechaDocAval FROM aval_por_documento,  productos WHERE aval_por_documento.ClaveOrden = "+clave +" AND productos.ID_Pro = aval_por_documento.ClaveProducto AND aval_por_documento.Estatus = 1  ORDER BY aval_por_documento.ConsecutivoRecepcion " );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameRecepcionesPrevias ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameRecepcionesPrevias ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método datosOrdenCompra2 nos regresa los Datos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet datosOrdenCompra2(String clave) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT *, (subtotal-descuento)AS realDescuento FROM orden_compra WHERE ClaveOrden = "+clave +" LIMIT 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, datosOrdenCompra2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, datosOrdenCompra2 ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameProductosCompradosYEntregas nos regresa los Productos comprados para una Orden de Compra junto con sus entregas parciales y faltantes, este metodo es empleado por la reimpresion de una orden de compra.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet dameProductosCompradosYEntregas() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT productos_orden.Cantidad, productos_orden.Llegan, (productos_orden.Cantidad-productos_orden.Llegan)AS Faltantes, CONCAT(linea.nombre,' ', marca.nombre,' ',productos.descripcion) AS descripcion, productos_orden.Costo, productos_orden.Importe FROM productos, productos_orden, linea, marca WHERE productos_orden.ClaveOrden = "+claveOrden +" AND productos.claveProducto = productos_orden.ClaveProducto AND linea.clave=productos.linea AND marca.clave=productos.marca");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameProductosCompradosYEntregas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameProductosCompradosYEntregas ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameProductosRegaladosYEntregas nos regresa los Productos obsequiados para una Orden de Compra junto con sus entregas parciales y faltantes, este metodo es empleado por la reimpresion de una orden de compra.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet dameProductosRegaladosYEntregas() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT regalos_extras.Cantidad, regalos_extras.Llego, (regalos_extras.Cantidad-regalos_extras.Llego)AS Faltantes, productos.descripcion FROM productos, regalos_extras  WHERE regalos_extras.ClaveOrden = "+claveOrden +" AND productos.claveProducto = regalos_extras.ClaveProducto");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameProductosRegaladosYEntregas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameProductosRegaladosYEntregas ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameResumenCompra nos regresa los Datos correspondientes a una  Orden de Compra sin especificar los productos es empleado por la reimpresion de una orden de compra.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet dameResumenCompra() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT subtotal, observaciones, descuento1, descuento2, descuento3, descuento, iva, total  FROM orden_compra  WHERE claveOrden = "+claveOrden);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameResumenCompra ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameResumenCompra ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método dameFacturasCheque nos regresa el/los documento(s) que avalan una Compra
*
*  @return String con los documentos que avalan una compra.
*/
	public String dameFacturasCheque(String consePago) throws SQLException, Exception {
		ResultSet rs = null;
		String imprime = "Pago de la(s) factura(s):   ";
		String claveDeCompra = "";
		String facturas = "";
		try{
			con = new ConexionBD();
			Statement stmt1 = con.creaStatement();
			Statement stmt2 = con.creaStatement();
			Statement stmt3 = con.creaStatement();
			String query1 = "SELECT orden_compra.factura, orden_compra.claveOrden FROM orden_compra,  pagos WHERE pagos.consecutivo = "+consePago +" AND orden_compra.claveOrden = pagos.claveOrden";
			rs = stmt1.executeQuery(query1);
			while(rs.next()){
				claveDeCompra = rs.getString("claveOrden");
				facturas = rs.getString("factura");
			}
			imprime +=" \n"+facturas;
			String query2 = ("SELECT  facturas.factura FROM facturas, pagos WHERE pagos.consecutivo = "+consePago +" AND facturas.Clave_Orden = pagos.claveOrden");
			rs=stmt2.executeQuery(query2);
			while(rs.next()){
				imprime += "," +rs.getString("factura");
			}

		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameFacturasCheque ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameFacturasCheque ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameFacturasCheque ");
					q.printStackTrace();
				}
			}
		}
		return imprime;
	}

/**
* El Método precioProducto  nos regresa el nombre de la linea de acuerdo a la clave porporcionada.
*
*  @return String con el nombre de la Linea
*/
	public String precioProducto(String claveProducto2){
		ResultSet rs = null;
		String costo = null;
		try{
			String query = ("SELECT costo FROM productos WHERE claveProducto = '"+claveProducto2+"' ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				costo = rs.getString("costo");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, precioProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, precioProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPrecioProveedor, precioProducto ");
					q.printStackTrace();
				}
			}
		}
		return costo;
	}


/**
* El Método dameFacturasRemisionesAdicionales nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameFacturasRemisionesAdicionales(String claveDeOrden){
		ResultSet rs = null;
		try{
			String query = ("SELECT docAval FROM facturas WHERE claveOrden = '"+claveDeOrden  +"'");
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameFacturasRemisionesAdicionales ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameFacturasRemisionesAdicionales ");
			e.printStackTrace();
		}
		return rs;
	}




/**
* El Método dameComprasXProveedorXTiempo nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasXProveedorXTiempo(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT orden_compra.claveOrden, orden_compra.fechaEntrega, orden_compra.factura, orden_compra.total, CONCAT(usuarios.Nombre,' ',usuarios.APaterno) AS Nombre, orden_compra.Entrega FROM orden_compra, usuarios WHERE orden_compra.claveProveedor = '"+claveProveedor +"' AND orden_compra.activo = 1 AND (orden_compra.fechaEntrega BETWEEN '"+fechaInicial+"' AND  '"+fechaFinal+"') AND usuarios.ClaveU = orden_compra.usuario ORDER BY  orden_compra.fechaEntrega DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasXProveedorXTiempo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasXProveedorXTiempo ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPrecioProveedor, dameComprasXProveedorXTiempo ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}

/**
* El Método dameComprasXProveedorXTiempo2 nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasXProveedorXTiempo2(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT orden_compra.claveOrden, orden_compra.fechaRegistro, orden_compra.fechaEntrega, orden_compra.docAval, orden_compra.total, orden_compra.pago,  orden_compra.Entrega FROM orden_compra   WHERE orden_compra.claveProveedor = '"+claveProveedor +"' AND orden_compra.activo = 1 AND (orden_compra.fechaRegistro BETWEEN '"+fechaInicial+"' AND  '"+fechaFinal+"') ORDER BY  orden_compra.fechaEntrega DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasXProveedorXTiempo 2");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasXProveedorXTiempo2 ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameComprasFaltantesXProveedorXTiempo nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasFaltantesXProveedorXTiempo(){
		ResultSet rs = null;
		try{
			String query = ("SELECT orden_compra.claveOrden, proveedores.rfc, orden_compra.fechaEntrega, orden_compra.total, orden_compra.Entrega FROM orden_compra, proveedores WHERE orden_compra.activo = 1 AND (orden_compra.Entrega = 0 OR orden_compra.Entrega = 1) AND orden_compra.claveProveedor LIKE '"+claveProveedor +"' AND proveedores.rfc = orden_compra.claveProveedor AND fechaEntrega BETWEEN '"+fechaInicial+"' AND '"+fechaFinal+"' ORDER BY orden_compra.fechaEntrega DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasFaltantesXProveedorXTiempo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasFaltantesXProveedorXTiempo ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameComprasXProveedorXTiempoNueva nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComprasXProveedorXTiempoNueva(){
		ResultSet rs = null;
		try{
			String query = ("SELECT orden_compra.claveOrden, proveedores.rfc, proveedores.nombre, orden_compra.fechaRegistro, orden_compra.fechaEntrega, orden_compra.total, orden_compra.Entrega FROM orden_compra, proveedores WHERE orden_compra.activo = 1 AND (orden_compra.Entrega = 0 OR orden_compra.Entrega = 1 OR orden_compra.Entrega = 2) AND orden_compra.claveProveedor LIKE '"+claveProveedor +"' AND proveedores.rfc = orden_compra.claveProveedor AND fechaRegistro BETWEEN '"+fechaInicial+"' AND '"+fechaFinal+"' ORDER BY orden_compra.claveOrden  DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameComprasXProveedorXTiempoNueva ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameComprasXProveedorXTiempoNueva ");
			e.printStackTrace();
		}
		return rs;
	}


	public ResultSet datosProveedoresActivos(){
		ResultSet rs = null;
		try{
			String query = ("SELECT rfc, nombre FROM proveedores WHERE activo = 1 ORDER BY nombre");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, datosProveedoresActivos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, datosProveedoresActivos ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameNombreProveedor nos regresa el Nombre del Proveedor solicitado.
*
* @return String correspondiente al nombre vinculado a la Clave del proveedor dado.
*/
	public String dameNombreProveedor(String claveDeProveedor){
		String claveP = null;
		ResultSet rs = null;
		try{
			String query = ("SELECT nombre FROM proveedores WHERE rfc ='"+claveDeProveedor+"'");
			con3 = new ConexionBD();
			Statement stmt = con3.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				claveP = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameNombreProveedor ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameNombreProveedor ");
			e.printStackTrace();
		}
		finally{
			if(con3 != null){
				try{
					con3.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameNombreProveedor ");
					q.printStackTrace();
				}
			}
		}
		return claveP;
	}

/**
* El Método dameNombreProveedor nos regresa el Nombre del Proveedor solicitado.
*
* @return String correspondiente al nombre vinculado a la Clave del proveedor dado.
*/
	public String dameNombreProveedor(){
		String claveP = null;
		ResultSet rs = null;
		try{
			String query = ("SELECT nombre FROM proveedores WHERE rfc ='"+claveProveedor+"'");
			con3 = new ConexionBD();
			Statement stmt = con3.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				claveP = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameNombreProveedor ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameNombreProveedor ");
			e.printStackTrace();
		}
		finally{
			if(con3 != null){
				try{
					con3.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameNombreProveedor ");
					q.printStackTrace();
				}
			}
		}
		return claveP;
	}


/**
* El Método dameNombreProveedor2 nos regresa el Nombre del Proveedor solicitado de acuerdo a una orden solicitada.
*
* @return String correspondiente al nombre vinculado a la Clave del proveedor dado.
*/
	public String dameNombreProveedor2(){
		String claveP = null;
		ResultSet rs = null;
		try{
			String query = ("SELECT proveedores.nombre FROM proveedores, orden_compra WHERE orden_compra.claveOrden = "+claveOrden +" AND proveedores.rfc = orden_compra.claveProveedor");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				claveP = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameNombreProveedor2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameNombreProveedor2 ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameNombreProveedor2 ");
					q.printStackTrace();
				}
			}
		}
		return claveP;
	}


/**
* El Método dameDescripcionProducto nos regresa el Nombre del Producto solicitado.
*
* @return String correspondiente al nombre vinculado a la Clave del proveedor dado.
*/
	public String dameDescripcionProducto(String clave){
		String des = null;
		ResultSet rs = null;
		try{
			String query = ("SELECT descripcion FROM productos WHERE ID_Pro = "+clave +" AND activo = 1");
			con3 = new ConexionBD();
			Statement stmt = con3.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				des = rs.getString("descripcion");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameDescripcionProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameDescripcionProducto ");
			e.printStackTrace();
		}
		finally{
			if(con3 != null){
				try{
					con3.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameDescripcionProducto ");
					q.printStackTrace();
				}
			}
		}
		return des;
	}


// LE MANDO LOS DIAS QUE POSEE PARA PAGAR AL PROVEEDOR y ME Regresa cuando acaba.
	public String setFechaPago(String fechaInicial, String claveProveedor) throws SQLException, Exception{
		String nuevaFecha = fechaInicial;
		int diasParaPago = 0;
		con2 = new ConexionBD();
		if(con2 != null){
			try{
				String queryDiasPago = "SELECT diasPago FROM proveedores WHERE rfc = '"+claveProveedor+"' AND activo = 1";
				Statement st = con2.creaStatement();
				ResultSet rs = st.executeQuery(queryDiasPago);
				while(rs.next()){
					diasParaPago = rs.getInt("diasPago");
				}
			}
			catch (SQLException sqle){
				System.out.println("Error SQL en ManagerCompra, metodo setFechaPago");
				sqle.printStackTrace();
			}
			finally{
				con2.cierraConexion();
			}
		}
		Calendar fechita =  Calendar.getInstance();
		fechita.clear();
		fechita.set(cambiaAInt(nuevaFecha.substring(0,4)), cambiaAInt(nuevaFecha.substring(5,7))-1, cambiaAInt(nuevaFecha.substring(8,10)));
		fechita.add(Calendar.DATE, diasParaPago);
		int diaSemana = fechita.get(Calendar.DAY_OF_WEEK);
		// Si es domingo aumento un dia
		if(diaSemana == 1){
			fechita.add(Calendar.DATE, 1);
		}
		// Si es sabado aumento dos dias
		else if (diaSemana == 7){
			fechita.add(Calendar.DATE, 2);
		}
		StringBuilder cadena = new StringBuilder();
		String anio = new String (fechita.get(Calendar.YEAR) +"");
		int mesI = fechita.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mesI+""));
		int diaI = fechita.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(diaI+""));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		return cadena.toString();
	}




/**
* El método add_Orden_Compra se encarga de añadir a la Base de Datos una Orden de Compra.
*	@return exito 		Boolean con valor a true es que la transacción se realizó exitosamente y con valor a false existio algun problema en el registro.
*/
	public synchronized String add_Orden_Compra(String usuario) throws SQLException, Exception {
		con = new ConexionBD();
		con.cancelaAutoCommit();
		String claveOrden = "¡ERROR!";
		if (con.miConnection != null) {
			try {
				tiempo = new TimeStamp();
				String fecha = tiempo.date;
				PreparedStatement updateOrdenCompra;
				updateOrdenCompra = con.miConnection.prepareStatement("insert into orden_compra values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				updateOrdenCompra.setNull(1, java.sql.Types.INTEGER);
				updateOrdenCompra.setString(2, claveProveedor);
				updateOrdenCompra.setDate(3, cambiaADate(fecha));
				if(recepcion.equals("1")){ // Entrega Directa
					updateOrdenCompra.setString(4, fecha);
					updateOrdenCompra.setString(5, setFechaPago(fecha,claveProveedor));
					updateOrdenCompra.setString(15, "");
					updateOrdenCompra.setInt(16, 2);
				} else { // Entrega Programada
					updateOrdenCompra.setString(4, fechaentrega);
					updateOrdenCompra.setString(5, setFechaPago(fechaentrega,claveProveedor));
					updateOrdenCompra.setString(15, "");
					updateOrdenCompra.setInt(16, 0);
				}
				updateOrdenCompra.setString(6, observaciones);
				updateOrdenCompra.setDouble(7, cambiaADouble(descuento1));
				updateOrdenCompra.setDouble(8, cambiaADouble(descuento2));
				updateOrdenCompra.setDouble(9, cambiaADouble(descuento3));
				updateOrdenCompra.setDouble(10, cambiaADouble(subtotal));
				updateOrdenCompra.setDouble(11, cambiaADouble(descuento));
				updateOrdenCompra.setDouble(12, cambiaADouble(iva));
				updateOrdenCompra.setDouble(13, cambiaADouble(total));
				updateOrdenCompra.setInt(14, 1);
				updateOrdenCompra.setString(17, usuario);
				updateOrdenCompra.setInt(18, 0);
				updateOrdenCompra.execute();
				boolean conCredito = false;
				String buscaSiCredito= "SELECT IDcredito FROM proveedores WHERE  rfc = '"+claveProveedor+"' AND activo = 1";
				Statement stmt = con.creaStatement();
				ResultSet rsBuscaCredito = stmt.executeQuery(buscaSiCredito);
				while(rsBuscaCredito.next()){
					if(rsBuscaCredito.getInt("IDcredito") == 1){
						conCredito = true;
					}
				}
				rsBuscaCredito.close();
				stmt.close();
				if(conCredito){
					String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible-"+cambiaADouble(total)+" WHERE rfc = '"+claveProveedor+"' AND activo = 1";
					Statement cambiar = con.miConnection.createStatement();
	                cambiar.execute(cambiaSaldo);
	                cambiar.close();
				}
				String query = ("SELECT MAX(ClaveOrden) AS ultima FROM orden_compra WHERE activo = 1 AND claveProveedor =  '"+claveProveedor+"'");
				stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()){
					claveOrden =  rs.getString("ultima");
				}
				rs.close();
				stmt.close();
//				Guardo el Documento AVAL en caso de que sea Entrega Directa.
				if(recepcion.equals("1")){ // Entrega Directa
					PreparedStatement updateDocAval;
					updateDocAval = con.miConnection.prepareStatement("insert into facturas values(?,?,?,?,?);");
					updateDocAval.setInt(1, cambiaAInt(claveOrden));
					updateDocAval.setString(2, docAval);
					updateDocAval.setInt(3, cambiaAInt(tipoDocumento));
					if(tipoDocumento.equals("1")){
						updateDocAval.setString(4, docAval);
					}
					else{
						updateDocAval.setString(4, "");
					}
					updateDocAval.setDate(5, cambiaADate(fecha));
					updateDocAval.execute();
					updateDocAval.close();
					// Guardo mi producto relacionado con un documento Aval
					int consecutivoRecepcion = 1;
					// Checo si tengo recepciones previas.
					String queryRepPrevia = "SELECT MAX(consecutivoRecepcion) AS consecutivo FROM aval_por_documento WHERE ClaveOrden = "+claveOrden;
					Statement stRP = con.creaStatement();
					ResultSet rsRP = stRP.executeQuery(queryRepPrevia);
					while(rsRP.next()){
						consecutivoRecepcion += rsRP.getInt("consecutivo");
					}
					rsRP.close();
					stRP.close();
					for (int i = 0 ; i<arrayProducto.length; i++){
						if(!(arrayProducto[i].equalsIgnoreCase(""))) {
							int tipoProducto = 0;
							if(arrayTipo[i].equalsIgnoreCase("Caja")){
								tipoProducto = 1;
							}
							else if(arrayTipo[i].equalsIgnoreCase("Kilo")){
								tipoProducto = 2;
							}
							PreparedStatement updateProductoAval;
							updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
							updateProductoAval.setInt(1, cambiaAInt(claveOrden));
							updateProductoAval.setInt(2, cambiaAInt(arrayProducto[i]));
							updateProductoAval.setInt(3, consecutivoRecepcion);
							updateProductoAval.setInt(4, 1);
							updateProductoAval.setInt(5, tipoProducto);
							updateProductoAval.setDouble(6, cambiaADouble(arrayCantidad[i]));
							updateProductoAval.setString(7, docAval);
							updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
							updateProductoAval.setDate(9, cambiaADate(fecha));
							updateProductoAval.setInt(10, 1);
							updateProductoAval.execute();
							updateProductoAval.close();
						}
					}
					if(!prod1.equalsIgnoreCase("")){
						PreparedStatement updateProductoAval;
						updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
						updateProductoAval.setInt(1, cambiaAInt(claveOrden));
						updateProductoAval.setInt(2, cambiaAInt(prod1));
						updateProductoAval.setInt(3, consecutivoRecepcion);
						updateProductoAval.setInt(4, 0);
						updateProductoAval.setInt(5, cambiaAInt(tipoUni1));
						updateProductoAval.setDouble(6, cambiaADouble(can1));
						updateProductoAval.setString(7, docAval);
						updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
						updateProductoAval.setDate(9, cambiaADate(fecha));
						updateProductoAval.setInt(10, 1);
						updateProductoAval.execute();
						updateProductoAval.close();
					}
					if(!prod2.equalsIgnoreCase("")){
						PreparedStatement updateProductoAval;
						updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
						updateProductoAval.setInt(1, cambiaAInt(claveOrden));
						updateProductoAval.setInt(2, cambiaAInt(prod2));
						updateProductoAval.setInt(3, consecutivoRecepcion);
						updateProductoAval.setInt(4, 0);
						updateProductoAval.setInt(5, cambiaAInt(tipoUni2));
						updateProductoAval.setDouble(6, cambiaADouble(can2));
						updateProductoAval.setString(7, docAval);
						updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
						updateProductoAval.setDate(9, cambiaADate(fecha));
						updateProductoAval.setInt(10, 1);
						updateProductoAval.execute();
						updateProductoAval.close();
					}
					if(!prod3.equalsIgnoreCase("")){
						PreparedStatement updateProductoAval;
						updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
						updateProductoAval.setInt(1, cambiaAInt(claveOrden));
						updateProductoAval.setInt(2, cambiaAInt(prod3));
						updateProductoAval.setInt(3, consecutivoRecepcion);
						updateProductoAval.setInt(4, 0);
						updateProductoAval.setInt(5, cambiaAInt(tipoUni3));
						updateProductoAval.setDouble(6, cambiaADouble(can3));
						updateProductoAval.setString(7, docAval);
						updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
						updateProductoAval.setDate(9, cambiaADate(fecha));
						updateProductoAval.setInt(10, 1);
						updateProductoAval.execute();
						updateProductoAval.close();
					}
				}
				for (int i = 0 ; i<arrayProducto.length; i++){
					if(!(arrayProducto[i].equalsIgnoreCase(""))) {
						int tipoProducto = 0;
						if(arrayTipo[i].equalsIgnoreCase("Caja")){
							tipoProducto = 1;
						}
						else if(arrayTipo[i].equalsIgnoreCase("Kilo")){
							tipoProducto = 2;
						}
						PreparedStatement updateProductosOrdenCompra;
						updateProductosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
						updateProductosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
						updateProductosOrdenCompra.setInt(2, cambiaAInt(arrayProducto[i]));
						updateProductosOrdenCompra.setDouble(3, cambiaADouble(arrayCantidad[i]));
						updateProductosOrdenCompra.setInt(4,tipoProducto );
						if(tieneIva(arrayProducto[i])){
							updateProductosOrdenCompra.setDouble(5, quitaIVA(arrayCunidad[i]));
							updateProductosOrdenCompra.setDouble(7, quitaIVA(arrayImporte[i]));
						}
						else{
							updateProductosOrdenCompra.setDouble(5, cambiaADouble(arrayCunidad[i]));
							updateProductosOrdenCompra.setDouble(7, cambiaADouble(arrayImporte[i]));
						}
						updateProductosOrdenCompra.setInt(6, cambiaAInt(arrayCambio[i]));
						if(recepcion.equals("1")){
							updateProductosOrdenCompra.setDouble(8, cambiaADouble(arrayCantidad[i]));
						}
						else{
							updateProductosOrdenCompra.setDouble(8, 0.00);
						}
						updateProductosOrdenCompra.setInt(9, 1 ); // Productos Comprados
						updateProductosOrdenCompra.execute();
					}
				}
				if(!prod1.equalsIgnoreCase("")){
					PreparedStatement updateRegalosOrdenCompra;
					updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
					updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
					updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod1));
					updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can1));
					updateRegalosOrdenCompra.setInt(4, cambiaAInt(tipoUni1));
					updateRegalosOrdenCompra.setDouble(5, 0.00);
					updateRegalosOrdenCompra.setInt(6, 0);
					updateRegalosOrdenCompra.setDouble(7, 0.00);
					if(recepcion.equals("1")){
						updateRegalosOrdenCompra.setDouble(8, cambiaADouble(can1));
					}
					else{
						updateRegalosOrdenCompra.setDouble(8, 0.00);
					}
					updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
					updateRegalosOrdenCompra.execute();
				}
				if(!prod2.equalsIgnoreCase("")){
					PreparedStatement updateRegalosOrdenCompra;
					updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
					updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
					updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod2));
					updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can2));
					updateRegalosOrdenCompra.setInt(4,cambiaAInt(tipoUni2));
					updateRegalosOrdenCompra.setDouble(5, 0.00);
					updateRegalosOrdenCompra.setInt(6, 0);
					updateRegalosOrdenCompra.setDouble(7, 0.00);
					if(recepcion.equals("1")){
						updateRegalosOrdenCompra.setDouble(8, cambiaADouble(can2));
					}
					else{
						updateRegalosOrdenCompra.setDouble(8, 0.00);
					}
					updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
					updateRegalosOrdenCompra.execute();
				}
				if(!prod3.equalsIgnoreCase("")){
					PreparedStatement updateRegalosOrdenCompra;
					updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
					updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
					updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod3));
					updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can3));
					updateRegalosOrdenCompra.setInt(4,cambiaAInt(tipoUni3));
					updateRegalosOrdenCompra.setDouble(5, 0.00);
					updateRegalosOrdenCompra.setInt(6, 0);
					updateRegalosOrdenCompra.setDouble(7, 0.00);
					if(recepcion.equals("1")){
						updateRegalosOrdenCompra.setDouble(8, cambiaADouble(can3));
					}
					else{
						updateRegalosOrdenCompra.setDouble(8, 0.00);
					}
					updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
					updateRegalosOrdenCompra.execute();
				}
				// Voy a guardar en Inventario las nuevas adquisiciones si fue adquisicion inmediata.
				if(recepcion.equals("1")){
					String queryAgrupador = "SELECT ClaveProducto, SUM(Cantidad) AS Cantidad, Tipo FROM productos_orden WHERE claveOrden = "+claveOrden+" GROUP BY ClaveProducto,Tipo";
					Statement stmt2 = con.creaStatement();
					ResultSet rsInv = stmt2.executeQuery(queryAgrupador);
					while(rsInv.next()){
						PreparedStatement updateInventarioProductos;
						updateInventarioProductos = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda + ?) WHERE ID_Pro = ?  AND activo = 1");
						if(rsInv.getInt("Tipo") == 1 ){
							updateInventarioProductos.setDouble(1, (rsInv.getDouble("Cantidad")*piezasXCaja(rsInv.getString("ClaveProducto"))));
						}
						else{
							updateInventarioProductos.setDouble(1,rsInv.getDouble("Cantidad"));
						}
						updateInventarioProductos.setDouble(2,rsInv.getInt("ClaveProducto"));
						updateInventarioProductos.execute();
					}
					rsInv.close();
					stmt2.close();
					// Checo si cambiaron mis precios los modifico...
					String queryParaActualizarPrecios = "SELECT productos_orden.ClaveProducto, productos_orden.Costo, productos_orden.Tipo, productos_orden.CambiaPrecio, productos.tipoPrecio, productos.precioUniCompra, productos.cantidadXCaja, productos.preCaCompra, productos.kgXUnidad FROM productos_orden, productos WHERE productos_orden.ClaveOrden = "+claveOrden +" AND productos_orden.Adquisicion = 1 AND productos.ID_Pro = productos_orden.ClaveProducto";
					Statement stChecaP = con.creaStatement();
					ResultSet rsP = stChecaP.executeQuery(queryParaActualizarPrecios);
					while (rsP.next()){
						if(rsP.getInt("CambiaPrecio")==1){ // Si me solicitan cambio de precio....
							BigDecimal precioActual = null;
							BigDecimal precioNuevo = null;
							precioActual = new BigDecimal(Double.toString(damePrecioActual (rsP.getString("ClaveProducto"), rsP.getInt("Tipo"))));
							precioActual = precioActual.setScale(2, RoundingMode.HALF_UP);
							if(! tieneIva(rsP.getString("ClaveProducto"))){ // Producto Sin IVA
								precioNuevo = new BigDecimal(rsP.getString("Costo"));
							}
							else{
								precioNuevo = new BigDecimal(Double.toString(rsP.getDouble("Costo")));
								BigDecimal porcentajeImpuestos = new BigDecimal("1.15");
								precioNuevo = precioNuevo.multiply(porcentajeImpuestos);
								precioNuevo = precioNuevo.setScale(2, RoundingMode.HALF_UP);
							}
							if(precioActual.compareTo(precioNuevo) != 0){ // Realmente es precio diferente, asi que voy a cambiarlo.
								String actualizaPrecio = "";
								if(rsP.getInt("Tipo") == 0){
									actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
									// Checo si existe tambien compra por caja para actualizar su precio...
									if(rsP.getDouble("preCaCompra") > 0.00){
										BigDecimal precioCaja = precioNuevo.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
										precioCaja = precioCaja.setScale(2, RoundingMode.HALF_UP);
										actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioCaja.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
										stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
									}
								}
								else if(rsP.getInt("Tipo") == 1){
									// Actualizo el precio de Caja
									actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
									// Checo si existe tambien compra por unidad para actualizar su precio...
									if(rsP.getDouble("precioUniCompra") > 0.00){
										BigDecimal precioUnidad = precioNuevo.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
										precioUnidad = precioUnidad.setScale(2, RoundingMode.HALF_UP);
										actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioUnidad.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
										stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
									}
								}
								else if(rsP.getInt("Tipo") == 2){
									actualizaPrecio = "UPDATE productos SET precioUnidadKG = "+precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
								}
								Statement stAct = con.creaStatement();
								stAct.execute(actualizaPrecio);
								stAct.close();
								// Ahora actualizo precios de Venta de Acuerdo al porcentaje de ganancia por producto.
								if(rsP.getInt("tipoPrecio") != 2){ // No es de escalon asi que puedo actualizar...
									BigDecimal constante100 = new BigDecimal("100.0");
									String queryDamePorcentajes ="SELECT PrecioTipo, Porcentual FROM ganancia_porcentual WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
									Statement stNuevoPV = con.creaStatement();
									ResultSet rsNP = stNuevoPV.executeQuery(queryDamePorcentajes);
									while (rsNP.next()){
										BigDecimal porcentualG = new BigDecimal(rsNP.getString("Porcentual"));
										BigDecimal nuevoVenta  = new BigDecimal("0.00");
										nuevoVenta = (((precioNuevo.multiply(porcentualG)).divide(constante100, new MathContext(100))).add(precioNuevo));
										nuevoVenta = nuevoVenta.setScale(1, RoundingMode.HALF_UP);
										String actualizaPVenta = "";
										Statement actuPVenta = con.creaStatement();
										if(rsP.getInt("Tipo") == 2){ // Hablamos de un producto de pesaje
											if(rsNP.getInt("PrecioTipo") == 1){
												actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 2){
												BigDecimal tempPieza = new BigDecimal("0.00");
												tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
												tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 3){
												actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 4){
												BigDecimal tempPieza = new BigDecimal("0.00");
												tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
												tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 5){
												actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 6){
												BigDecimal tempPieza = new BigDecimal("0.00");
												tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
												tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
										} // Cierro es de Pesaje...
										else if(rsP.getInt("Tipo")== 0){ // Se compro por pieza.
											if(rsNP.getInt("PrecioTipo") == 1){
												actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 2){
												BigDecimal tempCaja = new BigDecimal("0.00");
												tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 3){
												actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 4){
												BigDecimal tempCaja = new BigDecimal("0.00");
												tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 5){
												actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 6){
												BigDecimal tempCaja = new BigDecimal("0.00");
												tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
										}
										else{ // Se Compro por Caja
											if(rsNP.getInt("PrecioTipo") == 1){
												BigDecimal tempUni = new BigDecimal("0.00");
												tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta = "UPDATE productos SET precioMenu = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 2){
												actualizaPVenta =  "UPDATE productos SET precioMenuC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 3){
												BigDecimal tempUni = new BigDecimal("0.00");
												tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 4){
												actualizaPVenta =  "UPDATE productos SET precioMMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 5){
												BigDecimal tempUni = new BigDecimal("0.00");
												tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 6){
												actualizaPVenta =  "UPDATE productos SET precioMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
										}
										actuPVenta.execute(actualizaPVenta);
										actuPVenta.close();
									}
									rsNP.close();
									stNuevoPV.close();
								}
								// Almacenado cambio de producto:
								PreparedStatement updatePrecioAnterior;
								updatePrecioAnterior = con.miConnection.prepareStatement("insert into precio_anterior_producto values(?,?,?,?,?);");
								updatePrecioAnterior.setInt(1, rsP.getInt("ClaveProducto"));
								updatePrecioAnterior.setInt(2, rsP.getInt("Tipo"));
								updatePrecioAnterior.setInt(3, cambiaAInt(claveOrden));
								updatePrecioAnterior.setDouble(4, cambiaADouble(precioActual.toString()));
								updatePrecioAnterior.setDouble(5, cambiaADouble(precioNuevo.toString()));
								updatePrecioAnterior.execute();
							} // Cierro solicitan cambio de Precio...
						}
					}
					rsP.close();
					stChecaP.close();
				}
				con.realizaCommit();
			} // Cierro Try
			catch (SQLException sqle) {
				con.realizaRollback();
				claveOrden = "¡ERROR!";
				sqle.printStackTrace();
				System.out.println(	"Error SQL clase ManagerCompra, método add_Orden_Compra"+sqle);
			}
			catch (Exception q){
				con.realizaRollback();
				claveOrden = "¡ERROR!";
				q.printStackTrace();
				System.out.println(	"Error clase ManagerCompra, método add_Orden_Compra");
			}
			finally{
				try{
				con.habilitaAutoCommit();
				con.cierraConexion();
				}
				catch (Exception q){
					System.out.println(	"Error al cerrar conexion de ManagerCompra metodo add_Orden_Compra");
					q.printStackTrace();
				}
			}
		}
		return claveOrden;
	}

/**
* El Método dameNombreProducto  nos da la descripción de un producto de acuerdo a su linea, marca y descripcion
*
*  @return String con la descripcion completa del producto
*/
	public String dameNombreProducto(String claveDeProducto){
		ResultSet rs = null;
		String nombreP = null;
		try{
			String query = ("SELECT CONCAT(linea.nombre,' ',marca.nombre,' ',productos.descripcion) AS descripcion FROM productos, linea, marca WHERE productos.claveProducto = '"+claveDeProducto+"' AND marca.clave = productos.marca AND linea.clave = productos.linea");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				nombreP = rs.getString("descripcion");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, dameNombreProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, dameNombreProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVenta, dameNombreProducto ");
					q.printStackTrace();
				}
			}
		}
		return nombreP;
	}

/**
* El Método dameRegalosRegistrados nos regresa todos los regalos que corresponden a una orden de Compra
*
*  @return rs ResultSet con los obsequios correspondientes a la compra.
*/
	public ResultSet dameRegalosRegistrados(String claveDeOrden){
		ResultSet rs = null;
		try{
			String query = ("SELECT regalos_extras.Cantidad, productos.descripcion FROM regalos_extras, productos WHERE regalos_extras.ClaveOrden = "+cambiaAInt(claveDeOrden)+" AND productos.claveProducto = regalos_extras.ClaveProducto");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameRegalosRegistrados ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameRegalosRegistrados ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método todasLasOrdenesXProveedores nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet todasLasOrdenesXProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fechaRegistro, total FROM orden_compra WHERE claveProveedor = '"+claveProveedor +"' AND activo = 1 ORDER BY claveOrden DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método todasLasOrdenesXProveedores2 nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet todasLasOrdenesXProveedores2(){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fechaRegistro, total FROM orden_compra WHERE claveProveedor = '"+claveProveedor +"' AND activo = 1 AND docAval = '' AND Entrega != 2 ORDER BY claveOrden DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores2 ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método todasLasComprasXProveedores nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet todasLasComprasXProveedores(String claveProveedor){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fechaRegistro, total, pago, entrega FROM orden_compra WHERE claveProveedor = '"+claveProveedor +"' AND activo = 1 ORDER BY claveOrden DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasComprasXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasComprasXProveedores ");
			e.printStackTrace();
		}
		return rs;
	}


	public void cierraConexion() throws Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ManagerCompra ");
				q.printStackTrace();
			}
		}
	}

	public void cierraConexion2() throws Exception{
		if(con2 != null){
			try{
				con2.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ManagerCompra ");
				q.printStackTrace();
			}
		}
	}

	public boolean existenModPrecios(String claveOrden) throws SQLException, Exception{
		boolean existe = false;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT CambiaPrecio FROM productos_orden WHERE ClaveOrden = "+claveOrden+"");
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while(rs.next() && !existe){
					if(rs.getInt("CambiaPrecio") == 1){
						existe = true;
					}
				}
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return existe;
	}

 /**
 * El método bajaOrden se encarga de actualizar campo Estatus a Baja en la Base de Datos de una Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */

	public synchronized boolean  bajaOrden(String cambioPrecio) throws SQLException, Exception {
		boolean resultado = true;
		con = new ConexionBD();
		String claveDeProveedor = "";
		double importeVenta = 0.00;
		if(con != null){
			try{
				con.cancelaAutoCommit();
				boolean exito = true;
				boolean conCredito = false;
				String datosPro = "SELECT orden_compra.claveProveedor, orden_compra.total, proveedores.IDCredito FROM orden_compra, proveedores WHERE orden_compra.claveOrden = "+claveOrden +" AND orden_compra.activo = 1 AND proveedores.rfc = orden_compra.claveProveedor";
				Statement dame = con.creaStatement();
				ResultSet rs = dame.executeQuery(datosPro);
				while(rs.next()){
					claveDeProveedor = rs.getString("claveProveedor");
					importeVenta = rs.getDouble("total");
					if(rs.getInt("IDCredito") == 1){
						conCredito = true;
					}
				}
				rs.close();
				dame.close();
				String bajaXDocumento ="UPDATE aval_por_documento SET Estatus = 0 WHERE ClaveOrden = "+claveOrden+" AND Estatus = 1";
				dame = con.creaStatement();
				dame.execute(bajaXDocumento);
				dame.close();
				String eliminaNotas = "DELETE FROM facturas WHERE claveOrden = "+claveOrden+"";
				dame = con.creaStatement();
				dame.execute(eliminaNotas);
				dame.close();
				if(conCredito){
					String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible+"+importeVenta+" WHERE rfc = '"+claveDeProveedor+"' ";
					Statement cambiar = con.miConnection.createStatement();
					cambiar.execute(cambiaSaldo);
					cambiar.close();
				}
				String queryString = "UPDATE orden_compra SET activo = 0 AND usuario = '"+usuario+"' WHERE ClaveOrden = "+claveOrden;
				Statement stmt = con.miConnection.createStatement();
				stmt.execute(queryString);
				stmt.close();
				String query = "SELECT ClaveProducto, Tipo, SUM(Llegan) AS Llegan FROM productos_orden WHERE ClaveOrden = "+claveOrden +" GROUP BY ClaveOrden, Tipo";
				Statement stmt2 = con.creaStatement();
				rs = stmt2.executeQuery(query);
				while(rs.next()){
					double cantidad = rs.getDouble("Llegan");
					if(rs.getInt("Tipo") == 1){	// Es Caja...
						cantidad = cantidad * piezasXCaja(rs.getString("ClaveProducto"));
					}
					queryString = "UPDATE productos SET invTienda = (invTienda - "+cantidad+") WHERE ID_Pro = "+rs.getString("ClaveProducto")+" AND activo = 1";
					Statement st = con.creaStatement();
					st.execute(queryString);
					st.close();
				}
				rs.close();
				stmt2.close();
				query = "SELECT productos_orden.ClaveProducto, productos_orden.Costo, productos_orden.Tipo, productos_orden.CambiaPrecio, productos.tipoPrecio, productos.precioUniCompra, productos.cantidadXCaja, productos.preCaCompra, productos.kgXUnidad FROM productos_orden, productos WHERE productos_orden.ClaveOrden = "+claveOrden +" AND productos_orden.Adquisicion = 1 AND productos_orden.CambiaPrecio = 1 AND productos.ID_Pro = productos_orden.ClaveProducto";
				stmt2 = con.creaStatement();
				rs= stmt2.executeQuery(query);
				while(rs.next()){
					if(cambioPrecio.equals("1")){ // PIDIERON REGRESO DE PRECIO
						// Regreso precio previo si hubo un cambio
						String checaExistenciaCambioPrecio = "SELECT precioAnterior, precioCompra,  tipoProducto FROM precio_anterior_producto WHERE claveProducto = "+rs.getString("ClaveProducto")+"  AND claveOrden = "+claveOrden;
						Statement rsTempis = con.creaStatement();
						ResultSet rsRegPrecio = rsTempis.executeQuery(checaExistenciaCambioPrecio);
						while(rsRegPrecio.next()){
							if(rsRegPrecio.getString("precioCompra") != null){
								String actualizaPrecio = "";
								if(rs.getInt("Tipo") == 0){
									actualizaPrecio = "UPDATE productos SET precioUniCompra = " +rsRegPrecio.getString("precioAnterior") +" WHERE ID_Pro = "+rs.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
									if(rs.getDouble("preCaCompra") > 0.00){
										BigDecimal precioCaja = new BigDecimal(rsRegPrecio.getString("precioAnterior")).multiply(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
										precioCaja = precioCaja.setScale(2, RoundingMode.HALF_UP);
										actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioCaja.toString() +" WHERE ID_Pro = "+rs.getString("ClaveProducto")+" AND activo = 1";
										stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
									}
								}
								else if(rs.getInt("Tipo") == 1){
									// Actualizo el precio de Caja
									actualizaPrecio = "UPDATE productos SET preCaCompra = " +rsRegPrecio.getString("precioAnterior") +" WHERE ID_Pro = "+rs.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
									if(rs.getDouble("precioUniCompra") > 0.00){
										BigDecimal precioUnidad = new BigDecimal(rsRegPrecio.getString("precioAnterior")).divide(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
										precioUnidad = precioUnidad.setScale(2, RoundingMode.HALF_UP);
										actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioUnidad.toString() +" WHERE ID_Pro = "+rs.getString("ClaveProducto")+" AND activo = 1";
										stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
									}
								}
								if(rs.getInt("Tipo") == 2){
									actualizaPrecio = "UPDATE productos SET precioUnidadKG = "+rsRegPrecio.getString("precioAnterior") +" WHERE ID_Pro = "+rs.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
								}
								BigDecimal constante100 = new BigDecimal("100.0");
								String queryDamePorcentajes ="SELECT PrecioTipo, Porcentual FROM ganancia_porcentual WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
								Statement stNuevoPV = con.creaStatement();
								ResultSet rsNP = stNuevoPV.executeQuery(queryDamePorcentajes);
								while (rsNP.next()){
									BigDecimal porcentualG = new BigDecimal(rsNP.getString("Porcentual"));
									BigDecimal nuevoVenta  = new BigDecimal("0.00");
									nuevoVenta = (((new BigDecimal(rsRegPrecio.getString("precioAnterior")).multiply(porcentualG)).divide(constante100, new MathContext(100))).add(new BigDecimal(rsRegPrecio.getString("precioAnterior"))));
									nuevoVenta = nuevoVenta.setScale(1, RoundingMode.HALF_UP);
									String actualizaPVenta = "";
									Statement actuPVenta = con.creaStatement();
									if(rs.getInt("Tipo") == 2){ // Hablamos de un producto de pesaje
										if(rsNP.getInt("PrecioTipo") == 1){
											actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 2){
											BigDecimal tempPieza = new BigDecimal("0.00");
											tempPieza = nuevoVenta.multiply(new BigDecimal(rs.getString("kgXUnidad")), new MathContext(100));
											tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempPieza.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 3){
											actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 4){
											BigDecimal tempPieza = new BigDecimal("0.00");
											tempPieza = nuevoVenta.multiply(new BigDecimal(rs.getString("kgXUnidad")), new MathContext(100));
											tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 5){
											actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 6){
											BigDecimal tempPieza = new BigDecimal("0.00");
											tempPieza = nuevoVenta.multiply(new BigDecimal(rs.getString("kgXUnidad")), new MathContext(100));
											tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
									} // Cierro es de Pesaje...
									else if(rs.getInt("Tipo")== 0){ // Se compro por pieza.
										if(rsNP.getInt("PrecioTipo") == 1){
											actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 2){
											BigDecimal tempCaja = new BigDecimal("0.00");
											tempCaja = nuevoVenta.multiply(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
											tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempCaja.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 3){
											actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 4){
											BigDecimal tempCaja = new BigDecimal("0.00");
											tempCaja = nuevoVenta.multiply(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
											tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 5){
											actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 6){
											BigDecimal tempCaja = new BigDecimal("0.00");
											tempCaja = nuevoVenta.multiply(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
											tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
									}
									else{ // Se Compro por Caja
										if(rsNP.getInt("PrecioTipo") == 1){
											BigDecimal tempUni = new BigDecimal("0.00");
											tempUni = nuevoVenta.divide(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
											tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta = "UPDATE productos SET precioMenu = "+tempUni.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 2){
											actualizaPVenta =  "UPDATE productos SET precioMenuC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 3){
											BigDecimal tempUni = new BigDecimal("0.00");
											tempUni = nuevoVenta.divide(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
											tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioMM = "+tempUni.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 4){
											actualizaPVenta =  "UPDATE productos SET precioMMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 5){
											BigDecimal tempUni = new BigDecimal("0.00");
											tempUni = nuevoVenta.divide(new BigDecimal(rs.getString("cantidadXCaja")), new MathContext(100));
											tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
											actualizaPVenta =  "UPDATE productos SET precioM = "+tempUni.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
										else if(rsNP.getInt("PrecioTipo") == 6){
											actualizaPVenta =  "UPDATE productos SET precioMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rs.getString("ClaveProducto")+"";
										}
									}
									actuPVenta.execute(actualizaPVenta);
									actuPVenta.close();
								}
								rsNP.close();
								stNuevoPV.close();
							}
						}
						rsRegPrecio.close();
						rsTempis.close();
					}
				}
				rs.close();
				stmt2.close();
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				resultado = false;
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query bajaOrden.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				e.printStackTrace();
				con.realizaRollback();
				resultado = false;
				error = "Ocurrió una excepción mientras se actualizaba bajaOrden.";
				throw new Exception(error);
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCompra metodo bajaOrden");
					q.printStackTrace();
				}
			}
		}
		else{
			resultado = false;
		}
	return resultado;
	}



 /**
 * El método cambiaSaldo se encarga de actualizar campo Estatus a Baja en la Base de Datos de una Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public void cambiaSaldo(String proveedor, String claveOrden) throws SQLException, Exception {
	 		con = new ConexionBD();
	 		con.cancelaAutoCommit();
			boolean resultado = false;
			int cla = cambiaAInt(claveOrden);
			ResultSet rs0 = null;
			String rfc = "";
			double importe = 0.0;
          try  {
			   String datosPro = "SELECT claveProveedor, total FROM orden_compra WHERE claveOrden = "+cla+"";
			   Statement dame = con.creaStatement();
			   rs0 = dame.executeQuery(datosPro);
			   while(rs0.next()){
				   rfc = rs0.getString("claveProveedor");
				   importe = rs0.getDouble("total");
			   }
			   String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible+"+importe+" WHERE rfc = '"+rfc+"' ";
			   Statement cambiar = con.miConnection.createStatement();
               cambiar.execute(cambiaSaldo);


             } catch (SQLException sqle) {
					con.realizaRollback();
					sqle.printStackTrace();
               		error = "SQLException: Could not execute the query cambiaSaldo.";
               throw new SQLException(error);
             } catch (Exception e) {
					con.realizaRollback();
					error = "Ocurrió una excepción mientras se actualizaba cambiaSaldo.";
               		throw new Exception(error);
             }
             finally{
 				try{
					con.habilitaAutoCommit();
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo cambiaSaldo");
 			   		q.printStackTrace();
 			 	}
 		   }
     }



/**
* El Método cuentaTodosProductosOrden nos regresa la Cantidad de Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public int cuentaTodosProductosOrden() throws SQLException, Exception {
		ResultSet rs = null;
		String aver = new String();
		int resul = 0;
		try{
			//System.out.println("La ClaveString: "+claveOrden);
			int cla = cambiaAInt(claveOrden);
			//System.out.println("La Clave: "+cla);
			String query = ("SELECT COUNT(ClaveProducto) AS todos FROM productos_orden WHERE ClaveOrden = "+cla+"");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				resul = rs.getInt("todos");
			}
			//resul = cambiaAInt(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, cuentaTodosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, cuentaTodosProductosOrden ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, cuentaTodosProductosOrden ");
					q.printStackTrace();
				}
			}
		}
		//System.out.println("En el java salida: "+resul);
		return resul;
	}


/**
* El Método datosOrdenCompra nos regresa los Datos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet datosOrdenCompra() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT *, (subtotal-descuento)AS realDescuento FROM orden_compra WHERE ClaveOrden = '"+cla+"'");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, datosOrdenCompra ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, datosOrdenCompra ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método todosProductosOrden2 nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet todosProductosOrden2() throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT pro.* FROM productos_orden pro WHERE pro.ClaveOrden = "+cla+"");
			//System.out.println("da lata: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todosProductosOrden ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método DameFechaEntrega nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public String DameFechaEntrega() throws SQLException, Exception {
		ResultSet rs = null;
		String fecha = "";
		try{
			String query = ("SELECT fechaEntrega FROM orden_compra WHERE ClaveOrden = "+claveOrden+"");
			//System.out.println("da lata: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				fecha = rs.getString("fechaEntrega");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, DameFechaEntrega ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, DameFechaEntrega ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, DameFechaEntrega ");
					q.printStackTrace();
				}
			}
		}
		return fecha;
	}


	public synchronized boolean eliminaRecepcion(String proveedor, String clave, String  ArrayConsecutivos[]) throws SQLException, Exception{
		boolean exito = true;
		con = new ConexionBD();
		Statement stmt = null;
		if(con != null){
			try{
				con.cancelaAutoCommit();
				// Itero a traves de todo mi arreglo.
				for (int i = 0; i < ArrayConsecutivos.length; i++){
					boolean primerEntrada = true; // Usada para eliminar la nota o factura que corresponde.
					String dameComponentes ="SELECT * FROM aval_por_documento WHERE ClaveOrden = "+clave +" AND ConsecutivoRecepcion = "+ArrayConsecutivos[i] +" AND Estatus = 1";
					stmt = con.creaStatement();
					ResultSet rs = stmt.executeQuery(dameComponentes);
					String actualizaEstado = "UPDATE aval_por_documento SET Estatus = 0 WHERE ClaveOrden = "+clave +" AND ConsecutivoRecepcion = "+ArrayConsecutivos[i] +" AND Estatus = 1";
					Statement stmt2 = con.creaStatement();
					stmt2.execute(actualizaEstado);
					stmt2.close();
					while(rs.next()){
						String descuentaIngreso = "UPDATE productos_orden SET Llegan = Llegan - "+rs.getDouble("Cantidad")+" WHERE ClaveOrden = "+clave +" AND ClaveProducto = "+rs.getString("ClaveProducto") +" AND Tipo = "+rs.getInt("Tipo")+" AND Adquisicion = "+rs.getInt("Adquisicion")+"";
						stmt2 = con.creaStatement();
						stmt2.execute(descuentaIngreso);
						// Tambien descuento de Inventario
						double cantidad = rs.getDouble("Cantidad");
						if(rs.getInt("Tipo") == 1){	// Es Caja...
							cantidad = cantidad * piezasXCaja(rs.getString("ClaveProducto"));
						}
						String queryString = "UPDATE productos SET invTienda = (invTienda - "+cantidad+") WHERE ID_Pro = "+rs.getString("ClaveProducto")+" AND activo = 1";
						Statement st = con.creaStatement();
						st.execute(queryString);
						st.close();
						if(primerEntrada){
							primerEntrada = false;
							String eliminaDocumento = "DELETE FROM facturas WHERE claveOrden = "+clave +" AND docAval = '"+rs.getString("DocAval") +"' AND tipoDoc = "+rs.getInt("TipoDocAval")+" LIMIT 1";
							stmt2 = con.creaStatement();
							stmt2.execute(eliminaDocumento);
						}
					}
					rs.close();
					stmt.close();
				}
				// Checo si no he recibido nada para cambiar el estado general de la compra a Sin recibir....
				boolean siHayRecepcionesPrevias = false;
				String hayCompras = "SELECT Estatus FROM aval_por_documento  WHERE Estatus = 1 AND ClaveOrden = "+clave+"";
				stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(hayCompras);
				while(rs.next()){
					siHayRecepcionesPrevias = true;
				}
				rs.close();
				stmt.close();
				if(!siHayRecepcionesPrevias){
					String cambiaEstadoRecepcion = "UPDATE orden_compra SET entrega = 0 WHERE claveOrden = "+clave+"";
					stmt = con.creaStatement();
					stmt.execute(cambiaEstadoRecepcion);
					stmt.close();
				}
				con.realizaCommit();
			}
			 catch (SQLException sqle){
				 exito = false;
				 con.realizaRollback();
				 sqle.printStackTrace();
			 }
			 catch (Exception e) {
				 exito = false;
				 con.realizaRollback();
				 e.printStackTrace();
			 }
			 finally{
				 try{
					 con.habilitaAutoCommit();
					 con.cierraConexion();
				 }
				 catch(Exception q){
					 q.printStackTrace();
				 }
			 }
		}
		else{
			exito = false;
		}
		return exito;
	}

 /**
 * El método update_Orden_Compra se encarga de actualizar los datos referentes a una Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public synchronized String  update_Orden_Compra(String usuario) throws SQLException, Exception {
		String  resultado = "OK";
		boolean hayPrevios = false;
		boolean noCuadra = false;
		boolean hayQueBorrar = false;
		con = new ConexionBD();
		if(con != null){
             try  {
				con.cancelaAutoCommit();
				 // Tengo credito con el proveedor???
				boolean conCredito = false;
				String buscaSiCredito= "SELECT IDcredito FROM proveedores WHERE  rfc = '"+claveProveedor+"' AND activo = 1";
				Statement stmt = con.creaStatement();
				ResultSet rsBuscaCredito = stmt.executeQuery(buscaSiCredito);
				while(rsBuscaCredito.next()){
					if(rsBuscaCredito.getInt("IDcredito") == 1){
						conCredito = true;
					}
				}
				rsBuscaCredito.close();
				stmt.close();
//System.out.println("Sali del credito");
				// Si tengo credito voy a regresar el de la transaccion previa y descontar lo de la nueva.
				if(conCredito){
					double montoPrevio = 0.00;
					String dameCreditoPrevio = "SELECT total FROM orden_Compra WHERE claveOrden = "+claveOrden +" AND activo = 1  LIMIT 1";
					stmt = con.creaStatement();
					ResultSet rsCreditoPrevio = stmt.executeQuery(dameCreditoPrevio);
					while(rsCreditoPrevio.next()){
						montoPrevio = rsCreditoPrevio.getDouble("total");
					}
					String cambiaSaldo1 = "UPDATE proveedores SET saldoDisponible = saldoDisponible+"+montoPrevio +" WHERE rfc = '"+claveProveedor+"' AND activo = 1";
					Statement cambiar = con.miConnection.createStatement();
	                cambiar.execute(cambiaSaldo1);
	                cambiar.close();
					String cambiaSaldo2 = "UPDATE proveedores SET saldoDisponible = saldoDisponible-"+cambiaADouble(total)+" WHERE rfc = '"+claveProveedor+"' AND activo = 1";
					cambiar = con.miConnection.createStatement();
	                cambiar.execute(cambiaSaldo2);
	                cambiar.close();
				} // Cierro con credito
				tiempo = new TimeStamp();
				String fecha = tiempo.date;
// Antes de Actualizar voy a checar si ya tengo recepciones previas y si esta no concuerdan con los nuevos datos sobre todo de productos.
				String queryExistePrevio = "SELECT * FROM aval_por_Documento WHERE ClaveOrden = "+claveOrden+" AND Estatus = 1 LIMIT 1";
				Statement st = con.creaStatement();
				ResultSet rsPrev = st .executeQuery(queryExistePrevio);
				while(rsPrev.next()){
					if(rsPrev.getString("ClaveOrden").equals(claveOrden)){
						hayPrevios = true;
					}
				}
				rsPrev.close();
				st.close();
//System.out.println("Sali de checar previos.");
				if(hayPrevios){
					String dameRecibidosPrevios = "SELECT ClaveProducto, Cantidad, Tipo, Llegan, Adquisicion FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND Adquisicion = 1";
					st = con.creaStatement();
					ResultSet verificador = st.executeQuery(dameRecibidosPrevios);
					while(verificador.next() && !noCuadra){
						for (int i = 0 ; i<arrayProducto.length; i++){
							if(!(arrayProducto[i].equalsIgnoreCase(""))) {
								int tipoProducto = 0;
								if(arrayTipo[i].equalsIgnoreCase("Caja")){
									tipoProducto = 1;
								}
								else if(arrayTipo[i].equalsIgnoreCase("Kilo")){
									tipoProducto = 2;
								}
								if(verificador.getString("ClaveProducto").equals(arrayProducto[i]) && verificador.getInt("Tipo")==tipoProducto){
									if(verificador.getDouble("Llegan") > cambiaADouble(arrayCantidad[i])){
										noCuadra = true;
										resultado = "Se pide ahora "+arrayCantidad[i] +" unidades del producto: "+dameDescripcionProducto(arrayProducto[i])+", pero  existen en total  recepcion(es) previas  por <br/>"+verificador.getDouble("Llegan")+" unidades de este producto, elimine esa(s) Recepcion(es) o vuelva a modificar la compra.";
									}
									i = arrayProducto.length;
								}
								// Aqui pones que si es igual al arreglo menos uno y no encontro entonces no se pidio de ese producto y checas si se pidio o pelas....
								else if(i==(arrayProducto.length-1)){
									hayQueBorrar = true;
									if(verificador.getDouble("Llegan") >0.00){
										noCuadra = true;
										resultado = "Se pidio previamente del producto: "+dameDescripcionProducto(verificador.getString("ClaveProducto"))+" la Cantidad de "+verificador.getString("Cantidad")+",<br/> unidades  y  existe al menos una recepcion  por "+verificador.getDouble("Llegan")+" unidades de ese producto, elimine esa Recepcion o modifique la compra.";
									}
								}
							} // Cierro if
						}// Cierro for
					} // Cierro While
					verificador.close();
					st.close();
					dameRecibidosPrevios = "SELECT ClaveProducto, Cantidad, Tipo, Llegan, Adquisicion FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND Adquisicion = 0";
					st = con.creaStatement();
					verificador = st.executeQuery(dameRecibidosPrevios);
					while(verificador.next() && !noCuadra){
//						System.out.println("Verificador C Producto: :" +verificador.getString("ClaveProducto")+", Tipo: "+verificador.getString("Tipo")+", LLegan:"+verificador.getDouble("Llegan"));
//						System.out.println("Producto Ob 1: " +prod1+", Prod. Ob. 2: " +prod2 +", Prod. Ob. 3: " +prod3);
						if(verificador.getString("ClaveProducto").equals(prod1) && verificador.getString("Tipo").equals(tipoUni1)){
//							System.out.println("De obsequios entre al 1");
							if(verificador.getDouble("Llegan") > cambiaADouble(can1)){
								noCuadra = true;
								resultado = "Se pide ahora "+can1 +" unidades del producto de obsequio: "+dameDescripcionProducto(verificador.getString("ClaveProducto"))+", pero  existen en total  recepcion(es) previas  por <br/> "+verificador.getDouble("Llegan")+" unidades de este producto, elimine esa(s) Recepcion(es) o vuelva a modificar la compra";
							}
						}
						else if(verificador.getString("ClaveProducto").equals(prod2) && verificador.getString("Tipo").equals(tipoUni2)){
							if(verificador.getDouble("Llegan") > cambiaADouble(can2)){
//							System.out.println("De obsequios entre al 2");
								noCuadra = true;
								resultado = "Se pide ahora "+can2 +" unidades del producto de obsequio: "+dameDescripcionProducto(verificador.getString("ClaveProducto"))+", pero  existen en total  recepcion(es) previas  por <br/>"+verificador.getDouble("Llegan")+" unidades de este producto, elimine esa(s) Recepcion(es) o vuelva a modificar la compra";
							}
						}
						else if(verificador.getString("ClaveProducto").equals(prod3) && verificador.getString("Tipo").equals(tipoUni3)){
							if(verificador.getDouble("Llegan") > cambiaADouble(can3)){
//							System.out.println("De obsequios entre al 3");
								noCuadra = true;
								resultado = "Se pide ahora "+can3 +" unidades del producto de obsequio: "+dameDescripcionProducto(verificador.getString("ClaveProducto"))+", pero  existen en total  recepcion(es) previas  por <br/>"+verificador.getDouble("Llegan")+" unidades de este producto, elimine esa(s) Recepcion(es) o vuelva a modificar la compra";
							}
						}
						// Borraron ese producto
						else{
//							System.out.println("De obsequios entre al else");
							hayQueBorrar = true;
							if(verificador.getDouble("Llegan") >0.00){
								noCuadra = true;
								resultado = "Se pidio previamente del producto por Obsequio: "+dameDescripcionProducto(verificador.getString("ClaveProducto"))+" la Cantidad de "+verificador.getString("Cantidad")+", unidades  <br/> y  existe al menos una recepcion  por "+verificador.getDouble("Llegan")+" unidades de ese producto, elimine esa Recepcion o modifique la compra.";
							}
						}
					} // Cierro While
					verificador.close();
					st.close();
					// No hay problemas con recepciones previas, asi que voy a actualizar mis datos....
					if(!noCuadra){
						PreparedStatement updateOrdenCompra;
						updateOrdenCompra = con.miConnection.prepareStatement("UPDATE orden_compra SET fechaRegistro = ?, fechaEntrega = ?, observaciones = ?, descuento1 = ?, descuento2 = ?, descuento3 = ?, subtotal = ?, descuento = ?, iva = ?, total = ?, docAval = ?, Entrega = ?, usuario = ?, fechaPago = ? WHERE claveOrden = ?  AND activo = 1");
						updateOrdenCompra.setDate(1, cambiaADate(fecha));
						updateOrdenCompra.setString(3, observaciones);
						updateOrdenCompra.setDouble(4, cambiaADouble(descuento1));
						updateOrdenCompra.setDouble(5, cambiaADouble(descuento2));
						updateOrdenCompra.setDouble(6, cambiaADouble(descuento3));
						updateOrdenCompra.setDouble(7, cambiaADouble(subtotal));
						updateOrdenCompra.setDouble(8, cambiaADouble(descuento));
						updateOrdenCompra.setDouble(9, cambiaADouble(iva));
						updateOrdenCompra.setDouble(10, cambiaADouble(total));
						if(recepcion.equals("1")){ // Entrega Directa
							updateOrdenCompra.setString(2, fecha);
							updateOrdenCompra.setString(11, "");
							updateOrdenCompra.setInt(12, 2);
							updateOrdenCompra.setString(14, setFechaPago(fecha, claveProveedor));
						} else { // Entrega Programada
							updateOrdenCompra.setString(2, fechaentrega);
							updateOrdenCompra.setString(11, "");
							updateOrdenCompra.setInt(12, 0);
							updateOrdenCompra.setString(14, setFechaPago(fechaentrega, claveProveedor));
						}
						updateOrdenCompra.setString(13, usuario);
						updateOrdenCompra.setInt(15, cambiaAInt(claveOrden));
						updateOrdenCompra.execute();
						String damePrevios = "SELECT ClaveProducto, Tipo  FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND Adquisicion = 1";
						Statement st2 = con.creaStatement();
						ResultSet interno = st2.executeQuery(damePrevios);
// Si tengo productos nuevos que se agregaron de una vez los meto....
						for (int i = 0 ; i<arrayProducto.length; i++){
							interno.beforeFirst();
							boolean existePreviamente = false;
							if(!(arrayProducto[i].equalsIgnoreCase(""))) {
								int tipoProducto = 0;
								if(arrayTipo[i].equalsIgnoreCase("Caja")){
									tipoProducto = 1;
								}
								else if(arrayTipo[i].equalsIgnoreCase("Kilo")){
									tipoProducto = 2;
							 	}
							 	while(interno.next()){
									if(interno.getString("ClaveProducto").equals(arrayProducto[i])){
										existePreviamente = true;
									}
								}
								if(!existePreviamente){
									PreparedStatement updateProductosOrdenCompra;
									updateProductosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
									updateProductosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
									updateProductosOrdenCompra.setInt(2, cambiaAInt(arrayProducto[i]));
									updateProductosOrdenCompra.setDouble(3, cambiaADouble(arrayCantidad[i]));
									updateProductosOrdenCompra.setInt(4,tipoProducto );
									if(tieneIva(arrayProducto[i])){
										updateProductosOrdenCompra.setDouble(5, quitaIVA(arrayCunidad[i]));
										updateProductosOrdenCompra.setDouble(7, quitaIVA(arrayImporte[i]));
									}
									else{
										updateProductosOrdenCompra.setDouble(5, cambiaADouble(arrayCunidad[i]));
										updateProductosOrdenCompra.setDouble(7, cambiaADouble(arrayImporte[i]));
									}
									updateProductosOrdenCompra.setInt(6, cambiaAInt(arrayCambio[i]));
									updateProductosOrdenCompra.setDouble(8, 0.00);
									updateProductosOrdenCompra.setInt(9, 1 ); // Productos Comprados
									updateProductosOrdenCompra.execute();
								}// Cierro if de existePreviamente
							}// Cierro if de Producto
						} //Cierro for
						interno.close();
						st2.close();
						damePrevios = "SELECT ClaveProducto, Tipo  FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND Adquisicion = 0";
						 st2 = con.creaStatement();
						interno = st2.executeQuery(damePrevios);
//System.out.println("Seccion para borrado de obsequio.....");
						while(interno.next()){
							if(	(interno.getString("ClaveProducto").equals(prod1) && interno.getString("Tipo").equals(tipoUni1)) ||  (interno.getString("ClaveProducto").equals(prod2) && interno.getString("Tipo").equals(tipoUni2)) || (interno.getString("ClaveProducto").equals(prod3) && interno.getString("Tipo").equals(tipoUni3)) ){
//System.out.println("Si existe....");
							}
							// No esta voy a borrarlo
							else{
//System.out.println("No esta voy a borrar.....");
								Statement stBorra = con.creaStatement();
								String borraObsequio = "DELETE FROM productos_orden WHERE ClaveProducto = "+interno.getString("ClaveProducto")+" AND Tipo = "+interno.getString("Tipo")+" AND Adquisicion = 0 AND Llegan <= 0.00";
								stBorra.execute(borraObsequio);
								stBorra.close();
							}
						}
//System.out.println("Seccion para ver si agrego nuevo producto de obsequio...");
						interno.close();
						st2.close();
						damePrevios = "SELECT ClaveProducto, Tipo  FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND Adquisicion = 0";
						 st2 = con.creaStatement();
						interno = st2.executeQuery(damePrevios);
						boolean existePreviamente = false;
						if(prod1!= null && !prod1.equals("")){
							while(interno.next()){
								if(	(interno.getString("ClaveProducto").equals(prod1) && interno.getString("Tipo").equals(tipoUni1))){
									existePreviamente = true;
								}
							}
							interno.beforeFirst();
							if (!existePreviamente){
//System.out.println("No existio mi producto 1:  "+prod1+", tipo: " +tipoUni1+" Lo voy a agregar");
								PreparedStatement updateRegalosOrdenCompra;
								updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
								updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
								updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod1));
								updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can1));
								updateRegalosOrdenCompra.setInt(4, cambiaAInt(tipoUni1));
								updateRegalosOrdenCompra.setDouble(5, 0.00);
								updateRegalosOrdenCompra.setInt(6, 0);
								updateRegalosOrdenCompra.setDouble(7, 0.00);
								updateRegalosOrdenCompra.setDouble(8, 0.00);
								updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
								updateRegalosOrdenCompra.execute();
							}
						}
						existePreviamente = false;
						if(prod2!= null && !prod2.equals("")){
							while(interno.next()){
								if(	(interno.getString("ClaveProducto").equals(prod2) && interno.getString("Tipo").equals(tipoUni2))){
									existePreviamente = true;
								}
							}
							interno.beforeFirst();
							if (!existePreviamente){
//System.out.println("No existio mi producto 2:  "+prod2+", tipo: " +tipoUni2+" Lo voy a agregar");
								PreparedStatement updateRegalosOrdenCompra;
								updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
								updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
								updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod2));
								updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can2));
								updateRegalosOrdenCompra.setInt(4, cambiaAInt(tipoUni2));
								updateRegalosOrdenCompra.setDouble(5, 0.00);
								updateRegalosOrdenCompra.setInt(6, 0);
								updateRegalosOrdenCompra.setDouble(7, 0.00);
								updateRegalosOrdenCompra.setDouble(8, 0.00);
								updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
								updateRegalosOrdenCompra.execute();
							}
						}
						existePreviamente = false;
						if(prod3!= null && !prod3.equals("")){
							while(interno.next()){
								if(	(interno.getString("ClaveProducto").equals(prod3) && interno.getString("Tipo").equals(tipoUni3))){
									existePreviamente = true;
								}
							}
							interno.close();
							st2.close();
							if (!existePreviamente){
//System.out.println("No existio mi producto 3:  "+prod3+", tipo: " +tipoUni3+" Lo voy a agregar");
								PreparedStatement updateRegalosOrdenCompra;
								updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
								updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
								updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod3));
								updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can3));
								updateRegalosOrdenCompra.setInt(4, cambiaAInt(tipoUni3));
								updateRegalosOrdenCompra.setDouble(5, 0.00);
								updateRegalosOrdenCompra.setInt(6, 0);
								updateRegalosOrdenCompra.setDouble(7, 0.00);
								updateRegalosOrdenCompra.setDouble(8, 0.00);
								updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
								updateRegalosOrdenCompra.execute();
							}
						}
// Ahora actualizo mis productos...
						String dameTodosRecibidosPrevios = "SELECT ClaveProducto, Cantidad, Tipo, Llegan, Adquisicion FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND Adquisicion = 1";
						st = con.creaStatement();
						ResultSet modificador = st.executeQuery(dameTodosRecibidosPrevios);
						// Checo si tengo recepciones previas.
						int consecutivoRecepcion = 1;
						// Checo si tengo recepciones previas.
						String queryRepPrevia = "SELECT MAX(consecutivoRecepcion) AS consecutivo FROM aval_por_documento WHERE ClaveOrden = "+claveOrden;
						Statement stRP = con.creaStatement();
						ResultSet rsRP = stRP.executeQuery(queryRepPrevia);
						while(rsRP.next()){
							consecutivoRecepcion += rsRP.getInt("consecutivo");
						}
						while(modificador.next()){
							boolean siExistioProducto = false;
							for (int i = 0 ; i<arrayProducto.length; i++){
								if(!(arrayProducto[i].equalsIgnoreCase(""))) {
									int tipoProducto = 0;
									if(arrayTipo[i].equalsIgnoreCase("Caja")){
										tipoProducto = 1;
									}
									else if(arrayTipo[i].equalsIgnoreCase("Kilo")){
										tipoProducto = 2;
									}
									if(modificador.getString("ClaveProducto").equals(arrayProducto[i]) && modificador.getInt("Tipo")==tipoProducto){
										siExistioProducto = true;
										if(recepcion.equals("2")){ // Recepcion Programada
										// Primero los productos pagados
											PreparedStatement updateCantidadProducto;
											updateCantidadProducto = con.miConnection.prepareStatement("UPDATE productos_orden SET Cantidad = ?, Costo = ?, Importe = ?,  CambiaPrecio = ? WHERE  ClaveOrden = ? AND ClaveProducto = ?  AND Tipo = ? 	AND Adquisicion = ?");
											updateCantidadProducto.setDouble(1, cambiaADouble(arrayCantidad[i]));
											if(tieneIva(arrayProducto[i])){
												updateCantidadProducto.setDouble(2, quitaIVA(arrayCunidad[i]));
												updateCantidadProducto.setDouble(3, quitaIVA(arrayImporte[i]));
											}
											else{
												updateCantidadProducto.setDouble(2, cambiaADouble(arrayCunidad[i]));
												updateCantidadProducto.setDouble(3, cambiaADouble(arrayImporte[i]));
											}
											updateCantidadProducto.setInt(4, cambiaAInt(arrayCambio[i]));
											updateCantidadProducto.setInt(5, cambiaAInt(claveOrden));
											updateCantidadProducto.setInt(6, cambiaAInt(arrayProducto[i]));
											updateCantidadProducto.setInt(7,tipoProducto );
											updateCantidadProducto.setInt(8, 1);
											updateCantidadProducto.execute();
										// Ahora los productos obsequiados.
											if(!prod1.equalsIgnoreCase("")){
												updateCantidadProducto = con.miConnection.prepareStatement("UPDATE productos_orden SET Cantidad = ?, Costo = ?, Importe = ?  WHERE  ClaveOrden = ? AND ClaveProducto = ?  AND Tipo = ? 	AND Adquisicion = ?");
												updateCantidadProducto.setDouble(1, cambiaADouble(can1));
												updateCantidadProducto.setDouble(2, 0.00);
												updateCantidadProducto.setDouble(3, 0.00);
												updateCantidadProducto.setInt(4, cambiaAInt(claveOrden));
												updateCantidadProducto.setInt(5, cambiaAInt(prod1));
												updateCantidadProducto.setInt(6,cambiaAInt(tipoUni1) );
												updateCantidadProducto.setInt(7, 0);
												updateCantidadProducto.execute();
											}
											if(!prod2.equalsIgnoreCase("")){
												updateCantidadProducto = con.miConnection.prepareStatement("UPDATE productos_orden SET Cantidad = ?, Costo = ?, Importe = ?  WHERE  ClaveOrden = ? AND ClaveProducto = ?  AND Tipo = ? 	AND Adquisicion = ?");
												updateCantidadProducto.setDouble(1, cambiaADouble(can2));
												updateCantidadProducto.setDouble(2, 0.00);
												updateCantidadProducto.setDouble(3, 0.00);
												updateCantidadProducto.setInt(4, cambiaAInt(claveOrden));
												updateCantidadProducto.setInt(5, cambiaAInt(prod2));
												updateCantidadProducto.setInt(6,cambiaAInt(tipoUni2) );
												updateCantidadProducto.setInt(7, 0);
												updateCantidadProducto.execute();
											}
											if(!prod3.equalsIgnoreCase("")){
												updateCantidadProducto = con.miConnection.prepareStatement("UPDATE productos_orden SET Cantidad = ?, Costo = ?, Importe = ?  WHERE  ClaveOrden = ? AND ClaveProducto = ?  AND Tipo = ? 	AND Adquisicion = ?");
												updateCantidadProducto.setDouble(1, cambiaADouble(can3));
												updateCantidadProducto.setDouble(2, 0.00);
												updateCantidadProducto.setDouble(3, 0.00);
												updateCantidadProducto.setInt(4, cambiaAInt(claveOrden));
												updateCantidadProducto.setInt(5, cambiaAInt(prod3));
												updateCantidadProducto.setInt(6,cambiaAInt(tipoUni3) );
												updateCantidadProducto.setInt(7, 0);
												updateCantidadProducto.execute();
											}
										} // Cierro if de recepcion programada.
										else if(recepcion.equals("1")){ // Cambio a recepcion directa.
											// Actualizo inventario...
											PreparedStatement updateInventarioProductos;
											updateInventarioProductos = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda + ?) WHERE ID_Pro = ?  AND activo = 1");
											if(tipoProducto == 1 ){
												updateInventarioProductos.setDouble(1, ((cambiaADouble(arrayCantidad[i])-modificador.getDouble("Llegan")) *piezasXCaja(modificador.getString("ClaveProducto"))));
											}
											else{
												updateInventarioProductos.setDouble(1,(cambiaADouble(arrayCantidad[i])-modificador.getDouble("Llegan")));
											}
											updateInventarioProductos.setInt(2,modificador.getInt("ClaveProducto"));
											updateInventarioProductos.execute();
//System.out.println(updateInventarioProductos.toString());
											updateInventarioProductos.close();
											// Lleno recepcion...
											PreparedStatement updateProductoAval;
											updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
											updateProductoAval.setInt(1, cambiaAInt(claveOrden));
											updateProductoAval.setInt(2, cambiaAInt(arrayProducto[i]));
											updateProductoAval.setInt(3, consecutivoRecepcion);
											updateProductoAval.setInt(4, 1);
											updateProductoAval.setInt(5, tipoProducto);
											updateProductoAval.setDouble(6, cambiaADouble(arrayCantidad[i])-modificador.getDouble("Llegan"));
											updateProductoAval.setString(7, docAval);
											updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
											updateProductoAval.setDate(9, cambiaADate(fechaentrega));
											updateProductoAval.setInt(10, 1);
											updateProductoAval.execute();

											if(!prod1.equalsIgnoreCase("")){
												updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
												updateProductoAval.setInt(1, cambiaAInt(claveOrden));
												updateProductoAval.setInt(2, cambiaAInt(prod1));
												updateProductoAval.setInt(3, consecutivoRecepcion);
												updateProductoAval.setInt(4, 0);
												updateProductoAval.setInt(5, cambiaAInt(tipoUni1));
												updateProductoAval.setDouble(6, cambiaADouble(can1) -  damePrevioObsequio(claveOrden, prod1, tipoUni1 ));
												updateProductoAval.setString(7, docAval);
												updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
												updateProductoAval.setDate(9, cambiaADate(fechaentrega));
												updateProductoAval.setInt(10, 1);
												updateProductoAval.execute();
											}
											if(!prod2.equalsIgnoreCase("")){
												updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
												updateProductoAval.setInt(1, cambiaAInt(claveOrden));
												updateProductoAval.setInt(2, cambiaAInt(prod2));
												updateProductoAval.setInt(3, consecutivoRecepcion);
												updateProductoAval.setInt(4, 0);
												updateProductoAval.setInt(5, cambiaAInt(tipoUni2));
												updateProductoAval.setDouble(6, cambiaADouble(can2) -  damePrevioObsequio(claveOrden, prod2, tipoUni2 ));
												updateProductoAval.setString(7, docAval);
												updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
												updateProductoAval.setDate(9, cambiaADate(fechaentrega));
												updateProductoAval.setInt(10, 1);
												updateProductoAval.execute();
											}
											if(!prod3.equalsIgnoreCase("")){
												updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
												updateProductoAval.setInt(1, cambiaAInt(claveOrden));
												updateProductoAval.setInt(2, cambiaAInt(prod3));
												updateProductoAval.setInt(3, consecutivoRecepcion);
												updateProductoAval.setInt(4, 0);
												updateProductoAval.setInt(5, cambiaAInt(tipoUni3));
												updateProductoAval.setDouble(6, cambiaADouble(can3) -  damePrevioObsequio(claveOrden, prod3, tipoUni3 ));
												updateProductoAval.setString(7, docAval);
												updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
												updateProductoAval.setDate(9, cambiaADate(fechaentrega));
												updateProductoAval.setInt(10, 1);
												updateProductoAval.execute();
											}
//System.out.println("Array Cantidad --> "+arrayCantidad[i]);
//System.out.println("Modificador: "+modificador.getDouble("Llegan"));
//System.out.println(updateProductoAval.toString());
											updateProductoAval.close();
											PreparedStatement updateDocAval;
											updateDocAval = con.miConnection.prepareStatement("insert into facturas values(?,?,?,?,?);");
											updateDocAval.setInt(1, cambiaAInt(claveOrden));
											updateDocAval.setString(2, docAval);
											updateDocAval.setInt(3, cambiaAInt(tipoDocumento));
											if(tipoDocumento.equals("1")){
												updateDocAval.setString(4, docAval);
											}
											else{
												updateDocAval.setString(4, "");
											}
											updateDocAval.setDate(5, cambiaADate(fechaentrega));
											updateDocAval.execute();
											updateDocAval.close();
											if(tipoDocumento.equals("1")){
												updateDocAval = con.miConnection.prepareStatement("UPDATE facturas SET docPadre = ?, fechaDoc = ?  WHERE claveOrden = ? AND docAval != ? AND tipoDoc = ?");
												updateDocAval.setString(1, docAval);
												updateDocAval.setDate(2, cambiaADate(fechaentrega));
												updateDocAval.setInt(3, cambiaAInt(claveOrden));
												updateDocAval.setString(4, docAval);
												updateDocAval.setInt(5,2);
												updateDocAval.execute();
												updateDocAval.close();
											}
											PreparedStatement updateCantidadProducto;
											updateCantidadProducto = con.miConnection.prepareStatement("UPDATE productos_orden SET Cantidad = ?,  Costo = ?, Importe = ?, Llegan = ?  WHERE  ClaveOrden = ? AND ClaveProducto = ?  AND Tipo = ? 	AND Adquisicion = ?");
											updateCantidadProducto.setDouble(1, cambiaADouble(arrayCantidad[i]));
											if(tieneIva(arrayProducto[i])){
												updateCantidadProducto.setDouble(2, quitaIVA(arrayCunidad[i]));
												updateCantidadProducto.setDouble(3, quitaIVA(arrayImporte[i]));
											}
											else{
												updateCantidadProducto.setDouble(2, cambiaADouble(arrayCunidad[i]));
												updateCantidadProducto.setDouble(3, cambiaADouble(arrayImporte[i]));
											}
											updateCantidadProducto.setDouble(4,  cambiaADouble(arrayCantidad[i]));
											updateCantidadProducto.setInt(5, cambiaAInt(claveOrden));
											updateCantidadProducto.setInt(6, cambiaAInt(arrayProducto[i]));
											updateCantidadProducto.setInt(7,tipoProducto );
											updateCantidadProducto.setInt(8, 1);
											updateCantidadProducto.execute();
//System.out.println(updateCantidadProducto.toString());
										} // Cierro recepcion directa
// Ahora voy a checar si finalizo ya mi venta de acuerdo a las modificaciones nuevas......
//System.out.println("Voy a checar si se finalizo la venta.....");
										boolean finalizadosProductos = true;
										String queryFinProductosC = "SELECT Cantidad, Llegan FROM productos_orden WHERE ClaveOrden = "+claveOrden;
										Statement estadoPC = con.creaStatement();
										ResultSet rsPC = estadoPC.executeQuery(queryFinProductosC);
										while (rsPC.next()){
											if(rsPC.getDouble("Cantidad") > rsPC.getDouble("Llegan")){
												finalizadosProductos = false;
											}
										}
										rsPC.close();
										estadoPC.close();
										if(finalizadosProductos){
//System.out.println("Si finalizo, asi que voy a cerrar mis documentos.");
											tiempo = new TimeStamp();
											String fechaHoy = tiempo.date;
											String updateFinalizadaEntradas = "UPDATE orden_compra SET  Entrega = 2, fechaPago = '"+setFechaPago(fechaHoy, claveProveedor) +"', fechaEntrega = '"+fechaHoy+"' WHERE ClaveOrden = "+claveOrden;
											Statement temp2 = con.creaStatement();
											temp2.execute(updateFinalizadaEntradas);
											temp2.close();
											// Si cambio el precio saco un promedio y lo almaceno en productos verificando que la transacción haya sido finalizada....
											String queryParaActualizarPrecios = "SELECT productos_orden.ClaveProducto, productos_orden.Costo, productos_orden.Tipo, productos_orden.CambiaPrecio, productos.tipoPrecio, productos.precioUniCompra, productos.cantidadXCaja, productos.preCaCompra, productos.kgXUnidad FROM productos_orden, productos WHERE productos_orden.ClaveOrden = "+claveOrden +" AND productos_orden.Adquisicion = 1 AND productos.ID_Pro = productos_orden.ClaveProducto";
											Statement stChecaP = con.creaStatement();
											ResultSet rsP = stChecaP.executeQuery(queryParaActualizarPrecios);
											while (rsP.next()){
												if(rsP.getInt("CambiaPrecio")==1){ // Si me solicitan cambio de precio....
													BigDecimal precioActual = null;
													BigDecimal precioNuevo = null;
													precioActual = new BigDecimal(Double.toString(damePrecioActual (rsP.getString("ClaveProducto"), rsP.getInt("Tipo"))));
													precioActual = precioActual.setScale(2, RoundingMode.HALF_UP);
													if(! tieneIva(rsP.getString("ClaveProducto"))){ // Producto Sin IVA
														precioNuevo = new BigDecimal(rsP.getString("Costo"));
													}
													else{
														precioNuevo = new BigDecimal(Double.toString(rsP.getDouble("Costo")));
														BigDecimal porcentajeImpuestos = new BigDecimal("1.15");
														precioNuevo = precioNuevo.multiply(porcentajeImpuestos);
														precioNuevo = precioNuevo.setScale(2, RoundingMode.HALF_UP);
													}
													if(precioActual.compareTo(precioNuevo) != 0){ // Realmente es precio diferente, asi que voy a cambiarlo.
														String actualizaPrecio = "";
														if(rsP.getInt("Tipo") == 0){
															actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
															Statement stAct = con.creaStatement();
															stAct.execute(actualizaPrecio);
															stAct.close();
															// Checo si existe tambien compra por caja para actualizar su precio...
															if(rsP.getDouble("preCaCompra") > 0.00){
																BigDecimal precioCaja = precioNuevo.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																precioCaja = precioCaja.setScale(2, RoundingMode.HALF_UP);
																actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioCaja.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
																stAct = con.creaStatement();
																stAct.execute(actualizaPrecio);
																stAct.close();
															}
														}
														else if(rsP.getInt("Tipo") == 1){
															// Actualizo el precio de Caja
															actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
															Statement stAct = con.creaStatement();
															stAct.execute(actualizaPrecio);
															stAct.close();
															// Checo si existe tambien compra por unidad para actualizar su precio...
															if(rsP.getDouble("precioUniCompra") > 0.00){
																BigDecimal precioUnidad = precioNuevo.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																precioUnidad = precioUnidad.setScale(2, RoundingMode.HALF_UP);
																actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioUnidad.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
																stAct = con.creaStatement();
																stAct.execute(actualizaPrecio);
																stAct.close();
															}
														}
														else if(rsP.getInt("Tipo") == 2){
															actualizaPrecio = "UPDATE productos SET precioUnidadKG = "+precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
															Statement stAct = con.creaStatement();
															stAct.execute(actualizaPrecio);
															stAct.close();
														}
														Statement stAct = con.creaStatement();
														stAct.execute(actualizaPrecio);
														stAct.close();
														// Ahora actualizo precios de Venta de Acuerdo al porcentaje de ganancia por producto.
														if(rsP.getInt("tipoPrecio") != 2){ // No es de escalon asi que puedo actualizar...
															BigDecimal constante100 = new BigDecimal("100.0");
															String queryDamePorcentajes ="SELECT PrecioTipo, Porcentual FROM ganancia_porcentual WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
															Statement stNuevoPV = con.creaStatement();
															ResultSet rsNP = stNuevoPV.executeQuery(queryDamePorcentajes);
															while (rsNP.next()){
																BigDecimal porcentualG = new BigDecimal(rsNP.getString("Porcentual"));
																BigDecimal nuevoVenta  = new BigDecimal("0.00");
																nuevoVenta = (((precioNuevo.multiply(porcentualG)).divide(constante100, new MathContext(100))).add(precioNuevo));
																nuevoVenta = nuevoVenta.setScale(1, RoundingMode.HALF_UP);
																String actualizaPVenta = "";
																Statement actuPVenta = con.creaStatement();
																if(rsP.getInt("Tipo") == 2){ // Hablamos de un producto de pesaje
																	if(rsNP.getInt("PrecioTipo") == 1){
																		actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 2){
																		BigDecimal tempPieza = new BigDecimal("0.00");
																		tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
																		tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 3){
																		actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 4){
																		BigDecimal tempPieza = new BigDecimal("0.00");
																		tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
																		tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 5){
																		actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 6){
																		BigDecimal tempPieza = new BigDecimal("0.00");
																		tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
																		tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																} // Cierro es de Pesaje...
																else if(rsP.getInt("Tipo")== 0){ // Se compro por pieza.
																	if(rsNP.getInt("PrecioTipo") == 1){
																		actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 2){
																		BigDecimal tempCaja = new BigDecimal("0.00");
																		tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																		tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 3){
																		actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 4){
																		BigDecimal tempCaja = new BigDecimal("0.00");
																		tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																		tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 5){
																		actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 6){
																		BigDecimal tempCaja = new BigDecimal("0.00");
																		tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																		tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																}
																else{ // Se Compro por Caja
																	if(rsNP.getInt("PrecioTipo") == 1){
																		BigDecimal tempUni = new BigDecimal("0.00");
																		tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																		tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta = "UPDATE productos SET precioMenu = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 2){
																		actualizaPVenta =  "UPDATE productos SET precioMenuC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 3){
																		BigDecimal tempUni = new BigDecimal("0.00");
																		tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																		tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioMM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 4){
																		actualizaPVenta =  "UPDATE productos SET precioMMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 5){
																		BigDecimal tempUni = new BigDecimal("0.00");
																		tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
																		tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
																		actualizaPVenta =  "UPDATE productos SET precioM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																	else if(rsNP.getInt("PrecioTipo") == 6){
																		actualizaPVenta =  "UPDATE productos SET precioMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
																	}
																}
																actuPVenta.execute(actualizaPVenta);
																actuPVenta.close();
															}
															rsNP.close();
															stNuevoPV.close();
														}
														// Almacenado cambio de producto:
														PreparedStatement updatePrecioAnterior;
														updatePrecioAnterior = con.miConnection.prepareStatement("insert into precio_anterior_producto values(?,?,?,?,?);");
														updatePrecioAnterior.setInt(1, rsP.getInt("ClaveProducto"));
														updatePrecioAnterior.setInt(2, rsP.getInt("Tipo"));
														updatePrecioAnterior.setInt(3, cambiaAInt(claveOrden));
														updatePrecioAnterior.setDouble(4, cambiaADouble(precioActual.toString()));
														updatePrecioAnterior.setDouble(5, cambiaADouble(precioNuevo.toString()));
														updatePrecioAnterior.execute();
													} // Cierro solicitan cambio de Precio...
												}
											}
											rsP.close();
											stChecaP.close();
										}
										// Si tengo recepciones previas significa que el estado de entrega es de finalizado o bien de Entrega Parcial
										boolean siHayRecepcionesPrevias = false;
										String hayCompras = "SELECT Estatus FROM aval_por_documento  WHERE Estatus = 1 AND ClaveOrden = "+claveOrden+"";
//System.out.println(siHayRecepcionesPrevias);
										Statement stmt4 = con.creaStatement();
										ResultSet rs4 = stmt4.executeQuery(hayCompras);
										while(rs4.next()){
											siHayRecepcionesPrevias = true;
										}
										rs4.close();
										stmt4.close();
										if(siHayRecepcionesPrevias){
											String cambiaEstadoRecepcion = "UPDATE orden_compra SET entrega = 1 WHERE claveOrden = "+claveOrden+" AND entrega != 2";
											stmt4 = con.creaStatement();
											stmt4.execute(cambiaEstadoRecepcion);
											stmt4.close();
										}
									} // Cierro if
									else if(i==(arrayProducto.length-1)){
										if(!siExistioProducto){
											stmt = con.creaStatement();
											String queryEliminador = "DELETE FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND ClaveProducto = "+modificador.getInt("ClaveProducto")+" AND Tipo = "+modificador.getInt("Tipo")+" AND Cantidad = "+modificador.getDouble("Cantidad")+" AND Adquisicion = 1";
//System.out.println(queryEliminador);
											stmt.execute(queryEliminador);
											stmt.close();
										} // Cierre if de Existencia
									} // Cierro else final
								} // Cierro if
							}// Cierro for
						}// Cierro While
						modificador.close();
						st.close();
					}
				} // Cierro hay Previos
				else{
//System.out.println("No hay previos");
					PreparedStatement updateOrdenCompra;
					updateOrdenCompra = con.miConnection.prepareStatement("UPDATE orden_compra SET fechaRegistro = ?, fechaEntrega = ?, observaciones = ?, descuento1 = ?, descuento2 = ?, descuento3 = ?, subtotal = ?, descuento = ?, iva = ?, total = ?, docAval = ?, Entrega = ?, usuario = ?, fechaPago = ? WHERE claveOrden = ?  AND activo = 1");
					updateOrdenCompra.setDate(1, cambiaADate(fecha));
					updateOrdenCompra.setString(3, observaciones);
					updateOrdenCompra.setDouble(4, cambiaADouble(descuento1));
					updateOrdenCompra.setDouble(5, cambiaADouble(descuento2));
					updateOrdenCompra.setDouble(6, cambiaADouble(descuento3));
					updateOrdenCompra.setDouble(7, cambiaADouble(subtotal));
					updateOrdenCompra.setDouble(8, cambiaADouble(descuento));
					updateOrdenCompra.setDouble(9, cambiaADouble(iva));
					updateOrdenCompra.setDouble(10, cambiaADouble(total));
					if(recepcion.equals("1")){ // Entrega Directa
						updateOrdenCompra.setString(2, fecha);
						updateOrdenCompra.setString(11, "");
						updateOrdenCompra.setInt(12, 2);
						updateOrdenCompra.setString(14, setFechaPago(fecha, claveProveedor));
					} else { // Entrega Programada
						updateOrdenCompra.setString(2, fechaentrega);
						updateOrdenCompra.setString(11, "");
						updateOrdenCompra.setInt(12, 0);
						updateOrdenCompra.setString(14, setFechaPago(fechaentrega, claveProveedor));
					}
					updateOrdenCompra.setString(13, usuario);
					updateOrdenCompra.setInt(15, cambiaAInt(claveOrden));
					updateOrdenCompra.execute();
					// Borro los productos de esta transaccion y los vuelvo a ingresar.
					stmt = con.creaStatement();
					String queryEliminador = "DELETE FROM productos_orden WHERE ClaveOrden = "+claveOrden;
					stmt.execute(queryEliminador);
					stmt.close();
					stmt = con.creaStatement();
					queryEliminador = "DELETE FROM aval_por_documento WHERE ClaveOrden = "+claveOrden;
					stmt.execute(queryEliminador);
					stmt.close();
					//***
					if(recepcion.equals("1")){ // Entrega Directa
						PreparedStatement updateDocAval;
						updateDocAval = con.miConnection.prepareStatement("insert into facturas values(?,?,?,?,?);");
						updateDocAval.setInt(1, cambiaAInt(claveOrden));
						updateDocAval.setString(2, docAval);
						updateDocAval.setInt(3, cambiaAInt(tipoDocumento));
						if(tipoDocumento.equals("1")){
							updateDocAval.setString(4, docAval);
						}
						else{
							updateDocAval.setString(4, "");
						}
						updateDocAval.setDate(5, cambiaADate(fecha));
						updateDocAval.execute();
						updateDocAval.close();
						int consecutivoRecepcion = 1;
						// Checo si tengo recepciones previas.
						String queryRepPrevia = "SELECT MAX(consecutivoRecepcion) AS consecutivo FROM aval_por_documento WHERE ClaveOrden = "+claveOrden;
						Statement stRP = con.creaStatement();
						ResultSet rsRP = stRP.executeQuery(queryRepPrevia);
						while(rsRP.next()){
							consecutivoRecepcion += rsRP.getInt("consecutivo");
						}
						// Guardo mi producto relacionado con un documento Aval
						for (int i = 0 ; i<arrayProducto.length; i++){
							if(!(arrayProducto[i].equalsIgnoreCase(""))) {
								int tipoProducto = 0;
								if(arrayTipo[i].equalsIgnoreCase("Caja")){
									tipoProducto = 1;
								}
								else if(arrayTipo[i].equalsIgnoreCase("Kilo")){
									tipoProducto = 2;
								}
								PreparedStatement updateProductoAval;
								updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
								updateProductoAval.setInt(1, cambiaAInt(claveOrden));
								updateProductoAval.setInt(2, cambiaAInt(arrayProducto[i]));
								updateProductoAval.setInt(3, consecutivoRecepcion);
								updateProductoAval.setInt(4, 1);
								updateProductoAval.setInt(5, tipoProducto);
								updateProductoAval.setDouble(6, cambiaADouble(arrayCantidad[i]));
								updateProductoAval.setString(7, docAval);
								updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
								updateProductoAval.setDate(9, cambiaADate(fecha));
								updateProductoAval.setInt(10, 1);
								updateProductoAval.execute();
								updateProductoAval.close();
							}
						}
						if(!prod1.equalsIgnoreCase("")){
							PreparedStatement updateProductoAval;
							updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
							updateProductoAval.setInt(1, cambiaAInt(claveOrden));
							updateProductoAval.setInt(2, cambiaAInt(prod1));
							updateProductoAval.setInt(3, consecutivoRecepcion);
							updateProductoAval.setInt(4, 0);
							updateProductoAval.setInt(5, cambiaAInt(tipoUni1));
							updateProductoAval.setDouble(6, cambiaADouble(can1));
							updateProductoAval.setString(7, docAval);
							updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
							updateProductoAval.setDate(9, cambiaADate(fecha));
							updateProductoAval.setInt(10, 1);
							updateProductoAval.execute();
							updateProductoAval.close();
						}
						if(!prod2.equalsIgnoreCase("")){
							PreparedStatement updateProductoAval;
							updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
							updateProductoAval.setInt(1, cambiaAInt(claveOrden));
							updateProductoAval.setInt(2, cambiaAInt(prod2));
							updateProductoAval.setInt(3, consecutivoRecepcion);
							updateProductoAval.setInt(4, 0);
							updateProductoAval.setInt(5, cambiaAInt(tipoUni2));
							updateProductoAval.setDouble(6, cambiaADouble(can2));
							updateProductoAval.setString(7, docAval);
							updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
							updateProductoAval.setDate(9, cambiaADate(fecha));
							updateProductoAval.setInt(10, 1);
							updateProductoAval.execute();
							updateProductoAval.close();
						}
						if(!prod3.equalsIgnoreCase("")){
							PreparedStatement updateProductoAval;
							updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
							updateProductoAval.setInt(1, cambiaAInt(claveOrden));
							updateProductoAval.setInt(2, cambiaAInt(prod3));
							updateProductoAval.setInt(3, consecutivoRecepcion);
							updateProductoAval.setInt(4, 0);
							updateProductoAval.setInt(5, cambiaAInt(tipoUni3));
							updateProductoAval.setDouble(6, cambiaADouble(can3));
							updateProductoAval.setString(7, docAval);
							updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
							updateProductoAval.setDate(9, cambiaADate(fecha));
							updateProductoAval.setInt(10, 1);
							updateProductoAval.execute();
							updateProductoAval.close();
						}
					}
					for (int i = 0 ; i<arrayProducto.length; i++){
						if(!(arrayProducto[i].equalsIgnoreCase(""))) {
							int tipoProducto = 0;
							if(arrayTipo[i].equalsIgnoreCase("Caja")){
								tipoProducto = 1;
							}
							else if(arrayTipo[i].equalsIgnoreCase("Kilo")){
								tipoProducto = 2;
							}
							PreparedStatement updateProductosOrdenCompra;
							updateProductosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
							updateProductosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
							updateProductosOrdenCompra.setInt(2, cambiaAInt(arrayProducto[i]));
							updateProductosOrdenCompra.setDouble(3, cambiaADouble(arrayCantidad[i]));
							updateProductosOrdenCompra.setInt(4,tipoProducto );
							if(tieneIva(arrayProducto[i])){
								updateProductosOrdenCompra.setDouble(5, quitaIVA(arrayCunidad[i]));
								updateProductosOrdenCompra.setDouble(7, quitaIVA(arrayImporte[i]));
							}
							else{
								updateProductosOrdenCompra.setDouble(5, cambiaADouble(arrayCunidad[i]));
								updateProductosOrdenCompra.setDouble(7, cambiaADouble(arrayImporte[i]));
							}
							updateProductosOrdenCompra.setInt(6, cambiaAInt(arrayCambio[i]));
							if(recepcion.equals("1")){
								updateProductosOrdenCompra.setDouble(8, cambiaADouble(arrayCantidad[i]));
							}
							else{
								updateProductosOrdenCompra.setDouble(8, 0.00);
							}
							updateProductosOrdenCompra.setInt(9, 1 ); // Productos Comprados
							updateProductosOrdenCompra.execute();
						}
					}
					if(!prod1.equalsIgnoreCase("")){
						PreparedStatement updateRegalosOrdenCompra;
						updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
						updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
						updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod1));
						updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can1));
						updateRegalosOrdenCompra.setInt(4, cambiaAInt(tipoUni1));
						updateRegalosOrdenCompra.setDouble(5, 0.00);
						updateRegalosOrdenCompra.setInt(6, 0);
						updateRegalosOrdenCompra.setDouble(7, 0.00);
						if(recepcion.equals("1")){
							updateRegalosOrdenCompra.setDouble(8, cambiaADouble(can1));
						}
						else{
							updateRegalosOrdenCompra.setDouble(8, 0.00);
						}
						updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
						updateRegalosOrdenCompra.execute();
					}
					if(!prod2.equalsIgnoreCase("")){
						PreparedStatement updateRegalosOrdenCompra;
						updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
						updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
						updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod2));
						updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can2));
						updateRegalosOrdenCompra.setInt(4,cambiaAInt(tipoUni2));
						updateRegalosOrdenCompra.setDouble(5, 0.00);
						updateRegalosOrdenCompra.setInt(6, 0);
						updateRegalosOrdenCompra.setDouble(7, 0.00);
						if(recepcion.equals("1")){
							updateRegalosOrdenCompra.setDouble(8, cambiaADouble(can2));
						}
						else{
							updateRegalosOrdenCompra.setDouble(8, 0.00);
						}
						updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
						updateRegalosOrdenCompra.execute();
					}
					if(!prod3.equalsIgnoreCase("")){
						PreparedStatement updateRegalosOrdenCompra;
						updateRegalosOrdenCompra = con.miConnection.prepareStatement("insert into productos_orden values(?,?,?,?,?,?,?,?,?);");
						updateRegalosOrdenCompra.setInt(1, cambiaAInt(claveOrden));
						updateRegalosOrdenCompra.setInt(2, cambiaAInt(prod3));
						updateRegalosOrdenCompra.setDouble(3, cambiaADouble(can3));
						updateRegalosOrdenCompra.setInt(4,cambiaAInt(tipoUni3));
						updateRegalosOrdenCompra.setDouble(5, 0.00);
						updateRegalosOrdenCompra.setInt(6, 0);
						updateRegalosOrdenCompra.setDouble(7, 0.00);
						if(recepcion.equals("1")){
							updateRegalosOrdenCompra.setDouble(8, cambiaADouble(can3));
						}
						else{
							updateRegalosOrdenCompra.setDouble(8, 0.00);
						}
						updateRegalosOrdenCompra.setInt(9, 0 ); // Producto Obsequiado
						updateRegalosOrdenCompra.execute();
					}

					// Voy a guardar en Inventario las nuevas adquisiciones si fue adquisicion inmediata.
					if(recepcion.equals("1")){
						String queryAgrupador = "SELECT ClaveProducto, SUM(Cantidad) AS Cantidad, Tipo FROM productos_orden WHERE claveOrden = "+claveOrden+" GROUP BY ClaveProducto,Tipo";
						Statement stmt2 = con.creaStatement();
						ResultSet rsInv = stmt2.executeQuery(queryAgrupador);
						while(rsInv.next()){
							PreparedStatement updateInventarioProductos;
							updateInventarioProductos = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda + ?) WHERE ID_Pro = ?  AND activo = 1");
							if(rsInv.getInt("Tipo") == 1 ){
								updateInventarioProductos.setDouble(1, (rsInv.getDouble("Cantidad")*piezasXCaja(rsInv.getString("ClaveProducto"))));
							}
							else{
								updateInventarioProductos.setDouble(1,rsInv.getDouble("Cantidad"));
							}
							updateInventarioProductos.setDouble(2,rsInv.getInt("ClaveProducto"));
							updateInventarioProductos.execute();
						}
						rsInv.close();
						stmt2.close();
						// Checo si cambiaron mis precios los modifico...
						String queryParaActualizarPrecios = "SELECT productos_orden.ClaveProducto, productos_orden.Costo, productos_orden.Tipo, productos_orden.CambiaPrecio, productos.tipoPrecio, productos.precioUniCompra, productos.cantidadXCaja, productos.preCaCompra, productos.kgXUnidad FROM productos_orden, productos WHERE productos_orden.ClaveOrden = "+claveOrden +" AND productos_orden.Adquisicion = 1 AND productos.ID_Pro = productos_orden.ClaveProducto";
						Statement stChecaP = con.creaStatement();
						ResultSet rsP = stChecaP.executeQuery(queryParaActualizarPrecios);
						while (rsP.next()){
							if(rsP.getInt("CambiaPrecio")==1){ // Si me solicitan cambio de precio....
								BigDecimal precioActual = null;
								BigDecimal precioNuevo = null;
								precioActual = new BigDecimal(Double.toString(damePrecioActual (rsP.getString("ClaveProducto"), rsP.getInt("Tipo"))));
								precioActual = precioActual.setScale(2, RoundingMode.HALF_UP);
								if(! tieneIva(rsP.getString("ClaveProducto"))){ // Producto Sin IVA
									precioNuevo = new BigDecimal(rsP.getString("Costo"));
								}
								else{
									precioNuevo = new BigDecimal(Double.toString(rsP.getDouble("Costo")));
									BigDecimal porcentajeImpuestos = new BigDecimal("1.15");
									precioNuevo = precioNuevo.multiply(porcentajeImpuestos);
									precioNuevo = precioNuevo.setScale(2, RoundingMode.HALF_UP);
								}
								if(precioActual.compareTo(precioNuevo) != 0){ // Realmente es precio diferente, asi que voy a cambiarlo.
									String actualizaPrecio = "";
									if(rsP.getInt("Tipo") == 0){
										actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
										Statement stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
										// Checo si existe tambien compra por caja para actualizar su precio...
										if(rsP.getDouble("preCaCompra") > 0.00){
											BigDecimal precioCaja = precioNuevo.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
											precioCaja = precioCaja.setScale(2, RoundingMode.HALF_UP);
											actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioCaja.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
											stAct = con.creaStatement();
											stAct.execute(actualizaPrecio);
											stAct.close();
										}
									}
									else if(rsP.getInt("Tipo") == 1){
										// Actualizo el precio de Caja
										actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
										Statement stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
										// Checo si existe tambien compra por unidad para actualizar su precio...
										if(rsP.getDouble("precioUniCompra") > 0.00){
											BigDecimal precioUnidad = precioNuevo.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
											precioUnidad = precioUnidad.setScale(2, RoundingMode.HALF_UP);
											actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioUnidad.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
											stAct = con.creaStatement();
											stAct.execute(actualizaPrecio);
											stAct.close();
										}
									}
									else if(rsP.getInt("Tipo") == 2){
										actualizaPrecio = "UPDATE productos SET precioUnidadKG = "+precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
										Statement stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
									}
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
									// Ahora actualizo precios de Venta de Acuerdo al porcentaje de ganancia por producto.
									if(rsP.getInt("tipoPrecio") != 2){ // No es de escalon asi que puedo actualizar...
										BigDecimal constante100 = new BigDecimal("100.0");
										String queryDamePorcentajes ="SELECT PrecioTipo, Porcentual FROM ganancia_porcentual WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
										Statement stNuevoPV = con.creaStatement();
										ResultSet rsNP = stNuevoPV.executeQuery(queryDamePorcentajes);
										while (rsNP.next()){
											BigDecimal porcentualG = new BigDecimal(rsNP.getString("Porcentual"));
											BigDecimal nuevoVenta  = new BigDecimal("0.00");
											nuevoVenta = (((precioNuevo.multiply(porcentualG)).divide(constante100, new MathContext(100))).add(precioNuevo));
											nuevoVenta = nuevoVenta.setScale(1, RoundingMode.HALF_UP);
											String actualizaPVenta = "";
											Statement actuPVenta = con.creaStatement();
											if(rsP.getInt("Tipo") == 2){ // Hablamos de un producto de pesaje
												if(rsNP.getInt("PrecioTipo") == 1){
													actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 2){
													BigDecimal tempPieza = new BigDecimal("0.00");
													tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
													tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 3){
													actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 4){
													BigDecimal tempPieza = new BigDecimal("0.00");
													tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
													tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 5){
													actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 6){
													BigDecimal tempPieza = new BigDecimal("0.00");
													tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
													tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
											} // Cierro es de Pesaje...
											else if(rsP.getInt("Tipo")== 0){ // Se compro por pieza.
												if(rsNP.getInt("PrecioTipo") == 1){
													actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 2){
													BigDecimal tempCaja = new BigDecimal("0.00");
													tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
													tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 3){
													actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 4){
													BigDecimal tempCaja = new BigDecimal("0.00");
													tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
													tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 5){
													actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 6){
													BigDecimal tempCaja = new BigDecimal("0.00");
													tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
													tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
											}
											else{ // Se Compro por Caja
												if(rsNP.getInt("PrecioTipo") == 1){
													BigDecimal tempUni = new BigDecimal("0.00");
													tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
													tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta = "UPDATE productos SET precioMenu = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 2){
													actualizaPVenta =  "UPDATE productos SET precioMenuC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 3){
													BigDecimal tempUni = new BigDecimal("0.00");
													tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
													tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioMM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 4){
													actualizaPVenta =  "UPDATE productos SET precioMMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 5){
													BigDecimal tempUni = new BigDecimal("0.00");
													tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
													tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
													actualizaPVenta =  "UPDATE productos SET precioM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
												else if(rsNP.getInt("PrecioTipo") == 6){
													actualizaPVenta =  "UPDATE productos SET precioMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
												}
											}
											actuPVenta.execute(actualizaPVenta);
											actuPVenta.close();
										}
										rsNP.close();
										stNuevoPV.close();
									}
									// Almacenado cambio de producto:
									PreparedStatement updatePrecioAnterior;
									updatePrecioAnterior = con.miConnection.prepareStatement("insert into precio_anterior_producto values(?,?,?,?,?);");
									updatePrecioAnterior.setInt(1, rsP.getInt("ClaveProducto"));
									updatePrecioAnterior.setInt(2, rsP.getInt("Tipo"));
									updatePrecioAnterior.setInt(3, cambiaAInt(claveOrden));
									updatePrecioAnterior.setDouble(4, cambiaADouble(precioActual.toString()));
									updatePrecioAnterior.setDouble(5, cambiaADouble(precioNuevo.toString()));
									updatePrecioAnterior.execute();
								} // Cierro solicitan cambio de Precio...
							}
						}
						rsP.close();
						stChecaP.close();
					}
				}
				con.realizaCommit();
             }
             catch (SQLException sqle) {
				 resultado =  "Error";
				con.realizaRollback();
 				sqle.printStackTrace();
             	error = "SQLException: Could not execute the query update_Orden_Compra.";
             	throw new SQLException(error);
             }
             catch (Exception e) {
				 resultado =  "Error";
				con.realizaRollback();
             	error = "Ocurrió una excepción mientras se actualizaba update_Orden_Compra.";
             	throw new Exception(error);
             }
             finally{
 				try{
					con.habilitaAutoCommit();
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo update_Orden_Compra");
 			   		q.printStackTrace();
 			 	}
 		   }
	   }
	   else{
		   resultado = "Error";
	   }
	return resultado;
    }


	public double damePrevioObsequio(String claveOrdenF, String prodF, String tipoUniF ) throws SQLException, Exception{
		double cantidadPrevia = 0.00;
		con2 = new ConexionBD();
		if(con2!=null){
			try{
				String damePrevios = "SELECT  Llegan  FROM productos_orden WHERE ClaveOrden = "+claveOrdenF +" AND ClaveProducto = "+prodF +" AND Tipo = "+tipoUniF+" AND Adquisicion = 0 ";
				Statement st = con2.creaStatement();
				ResultSet rs = st.executeQuery(damePrevios);
				while(rs.next()){
					cantidadPrevia = rs.getDouble("Llegan");
				}
				rs.close();
				st.close();
			}
			catch(SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				try{
					con2.cierraConexion();
				}
				catch(Exception q){
					q.printStackTrace();
				}
			}
		}
		return cantidadPrevia;
	}

	public ResultSet todasLasOrdenesXProveedoresAgregada(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT orden_compra.ClaveOrden, orden_compra.Fecha, orden_compra.total FROM orden_compra, productos_orden WHERE orden_compra.ClaveProveedor = '"+claveProveedor +"' AND orden_compra.activo = 1 AND productos_orden.ClaveOrden = orden_compra.ClaveOrden AND productos_orden.Cantidad > productos_Orden.Llegan");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, todasLasOrdenesXProveedores ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}


	public ResultSet todasLasOrdenesXProveedoresAgregada2(){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT ClaveOrden, fechaRegistro, total FROM orden_compra WHERE ClaveProveedor = '"+claveProveedor +"' AND activo = 1 AND entrega !=2 ORDER BY claveOrden DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedoresAgregada2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedoresAgregada2 ");
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet dameFacturas(String claveOrden) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String dameFacturas = "SELECT docAval, fechaDoc FROM facturas WHERE claveOrden = "+claveOrden +" AND tipoDoc = 1";
//				System.out.println(dameFacturas);
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(dameFacturas);
			}
			catch(SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return rs;
	}

	public ResultSet dameNotas(String claveOrden) throws SQLException, Exception{
		ResultSet rs = null;
		con2 = new ConexionBD();
		if(con2 != null){
			try{
				String dameNotas = "SELECT docAval, fechaDoc, docPadre FROM facturas WHERE claveOrden = "+claveOrden +" AND tipoDoc = 2";
//				System.out.println(dameNotas);
				Statement stmt = con2.creaStatement();
				rs = stmt.executeQuery(dameNotas);
			}
			catch(SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return rs;
	}


	public ResultSet todosProductosOrden3(){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT DISTINCT productos_orden.*, orden_compra.ClaveProveedor FROM productos_orden, orden_compra WHERE orden_compra.ClaveOrden = "+cla+" AND productos_orden.ClaveOrden = orden_compra.ClaveOrden  AND productos_orden.Adquisicion = 1");
//			System.out.println("da lata: \n"+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todosProductosOrden ");
			e.printStackTrace();
		}
		return rs;
	}

	public synchronized ResultSet facturasComprasXTiempo(String fechaInicial, String fechaFinal) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String dameFacturasProd = "SELECT DISTINCT facturas.claveOrden, facturas.docPadre, aval_por_documento.ConsecutivoRecepcion, aval_por_documento.ClaveProducto, facturas.fechaDoc, orden_compra.descuento1, orden_compra.descuento2, orden_compra.descuento3, SUM(aval_por_documento.Cantidad) AS Cantidad, aval_por_documento.Tipo, aval_por_documento.Adquisicion, proveedores.nombre, (SUM(aval_por_documento.Cantidad) * productos_orden.Costo)  AS Costo, orden_compra.claveProveedor, proveedores.nombre, productos.gravaIVA FROM facturas, aval_por_documento, productos_orden, productos, proveedores, orden_compra WHERE  facturas.fechaDoc BETWEEN '"+fechaInicial +"' AND '"+fechaFinal +"' AND facturas.docPadre != '"+""+"' AND aval_por_documento.DocAval = facturas.docAval AND aval_por_documento.Estatus = 1 AND orden_compra.claveOrden = productos_orden.ClaveOrden AND productos_orden.ClaveOrden = aval_por_documento.ClaveOrden AND productos_orden.ClaveProducto = aval_por_documento.ClaveProducto AND productos_orden.Tipo = aval_por_documento.Tipo AND productos_orden.Adquisicion = aval_por_documento.Adquisicion AND orden_compra.claveOrden = facturas.claveOrden AND proveedores.rfc = orden_compra.claveProveedor AND productos.ID_Pro = aval_por_documento.ClaveProducto  GROUP BY aval_por_documento.ClaveOrden, aval_por_documento.ClaveProducto, aval_por_documento.Tipo, aval_por_documento.DocAval,  aval_por_documento.Adquisicion ORDER BY facturas.fechaDoc,facturas.docPadre,orden_compra.claveProveedor";
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(dameFacturasProd);
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return rs;
	}


	public synchronized  void guardaNuevaFactura(String docAval, String fechaDocAval, String claveOrden) throws SQLException, Exception{
		con = new ConexionBD();
		fechaDocAval = fechaDocAval.substring(6,10)+"-"+fechaDocAval.substring(0,2)+"-"+fechaDocAval.substring(3,5);
		if(con!= null){
			try{
				PreparedStatement updateDocAval;
				updateDocAval = con.miConnection.prepareStatement("insert into facturas values(?,?,?,?,?);");
				updateDocAval.setInt(1, cambiaAInt(claveOrden));
				updateDocAval.setString(2, docAval);
				updateDocAval.setInt(3, 1);
				updateDocAval.setString(4, docAval);
				updateDocAval.setDate(5, cambiaADate(fechaDocAval));
				updateDocAval.execute();
				updateDocAval.close();
			}
			catch(SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch(Exception q){
					q.printStackTrace();
				}
			}
		}
	}

	public synchronized  void eliminaFactura(String docAval,  String claveOrden) throws SQLException, Exception{
		con = new ConexionBD();
		if(con!= null){
			try{
				String updateEntrada = "UPDATE aval_por_documento  SET TipoDocAval = 2 WHERE DocAval = '"+docAval+"' AND TipoDocAval = 1 AND Estatus = 1";
				Statement stmt = con.creaStatement();
				stmt.execute(updateEntrada);
				stmt.close();
				// Verifico si hay entradas de esa Factura en aval_por_documento
				boolean existePreviamente = false;
				String  existePrevio = "SELECT DocAval FROM aval_por_documento WHERE DocAval = '"+docAval +"' AND Estatus = 1 LIMIT 1";
				stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(existePrevio);
				while(rs.next()){
					if(rs.getString("DocAval").equalsIgnoreCase(docAval)){
						existePreviamente = true;
					}
				}
				rs.close();
				stmt.close();
				if(!existePreviamente){
					String borrarEntrada = "DELETE FROM facturas WHERE claveOrden = "+claveOrden +" AND docAval = '"+docAval +"' AND tipoDoc = 1";
					stmt = con.creaStatement();
					stmt.execute(borrarEntrada);
					stmt.close();
				}
				else{
					String cambiaEntrada ="UPDATE facturas SET tipoDoc = 2 WHERE claveOrden = "+claveOrden +" AND docAval = "+docAval +" AND tipoDoc = 1";
					stmt = con.creaStatement();
					stmt.execute(cambiaEntrada);
					stmt.close();
				}
				String cambiaEntrada ="UPDATE facturas SET docPadre = '"+""+"'  WHERE claveOrden = "+claveOrden +" AND  docPadre = '"+docAval +"'";
				stmt = con.creaStatement();
				stmt.execute(cambiaEntrada);
				stmt.close();
			}
			catch(SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch(Exception q){
					q.printStackTrace();
				}
			}
		}
	}

	public synchronized  void asignaFactura(String [ ] notas, String [ ] facturas, String claveOrden) throws SQLException, Exception{
		con = new ConexionBD();
		if(con!= null){
			try{
				con.cancelaAutoCommit();
				for(int i = 0; i<notas.length; i++){
					// Desasigno Factura:
					if(facturas[i].equals("")){
						// Averiguo fecha del documento (Creacion):
						String dameFechaEnNota = "SELECT FechaDocAval FROM aval_por_documento WHERE DocAval = '"+notas[i]+"' AND ClaveOrden = "+claveOrden +" LIMIT 1";
						Statement stmtP = con.creaStatement();
						ResultSet rs = stmtP.executeQuery(dameFechaEnNota);
						String fechaPrevia = "";
						while(rs.next()){
							fechaPrevia = rs.getString("FechaDocAval");
						}
						rs.close();
						stmtP.close();
						String updateEntrada = "UPDATE facturas  SET docPadre = '"+"" +", fechaDoc = '"+fechaPrevia+"'' WHERE DocAval = '"+notas[i]+"' AND TipoDoc = 2 AND ClaveOrden = "+claveOrden;
						Statement stmt = con.creaStatement();
						stmt.execute(updateEntrada);
						stmt.close();
					} // Asigno Factura modificando su fecha deacuerdo a la existente en la Factura:
					else{
						String dameFechaEnFactura = "SELECT FechaDoc FROM facturas WHERE DocAval = '"+facturas[i]+"' AND ClaveOrden = "+claveOrden +" LIMIT 1";
						Statement stmtP = con.creaStatement();
						ResultSet rs = stmtP.executeQuery(dameFechaEnFactura);
						String fechaNueva = "";
						while(rs.next()){
							fechaNueva = rs.getString("FechaDoc");
						}
						rs.close();
						stmtP.close();
						String updateEntrada = "UPDATE facturas  SET docPadre = '"+facturas[i] +"', fechaDoc = '"+fechaNueva+"' WHERE DocAval = '"+notas[i]+"' AND TipoDoc = 2 AND ClaveOrden = "+claveOrden;
						Statement stmt = con.creaStatement();
						stmt.execute(updateEntrada);
						stmt.close();
					}
				}
				con.realizaCommit();
			}
			catch(SQLException sqle){
				con.realizaRollback();
				sqle.printStackTrace();
			}
			catch(Exception e){
				con.realizaRollback();
				e.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch(Exception q){
					q.printStackTrace();
				}
			}
		}
	}




/**
* El Método datosRegalosOrdenCompra nos regresa los Datos de los Regalos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de los Regalos de la Orden de Compra.
*/
	public ResultSet datosRegalosOrdenCompra(){
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM productos_orden WHERE ClaveOrden = "+claveOrden +" AND Adquisicion = 0");
//			System.out.println("query: \n"+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, datosRegalosOrdenCompra ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, datosRegalosOrdenCompra ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameLlegaron nos regresa la Cantidad de Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public double dameLlegaron(String producto){
		ResultSet rs = null;
		String aver = new String();
		double resul = 0.00;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT llegan FROM productos_orden WHERE ClaveOrden = "+cla+" AND ClaveProducto = '"+producto+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("llegan");
			}
			resul = cambiaADouble(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameLlegaron ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameLlegaron ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameLlegaron ");
					q.printStackTrace();
				}
			}
		}
		return resul;
	}


 /**
 * El método validaCantidadIngreso se encarga de verificar que la Cantidad a ingresar de producto entregado NO sea mayor a la estipulada originalmente.
 *	@return int 0 --> OK, 1 --> Errror en Comprados, 2--> Error en Obsequio, 3 --> Excepcion.
 */

 public synchronized int  finalizaRecepcion(String usuario) throws SQLException, Exception{
	int resultadoValidacion = 0;
	con = new ConexionBD();
	if(con != null){
		try{
			con.cancelaAutoCommit();
			// CHECO PRODUCTOS COMPRADOS....
			String query = "SELECT Cantidad, Llegan, Tipo, ClaveProducto FROM productos_orden WHERE ClaveOrden =  "+claveOrden +" AND Adquisicion = 1";
			ResultSet rs = null;
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next() && resultadoValidacion ==0){
				for (int i = 0; i < arrayProducto.length ; i++){
					if (rs.getString("ClaveProducto").equals(arrayProducto[i]) && rs.getString("Tipo").equals(arrayTipo[i])){
						BigDecimal cantidadPedida = new BigDecimal(rs.getString("Cantidad"));
						BigDecimal cantidadYaRecibida = new BigDecimal(rs.getString("Llegan"));
						BigDecimal cantidadRecibida = new BigDecimal(arrayCantidad[i]);
						cantidadRecibida = cantidadRecibida.setScale(3, RoundingMode.HALF_UP);
						if((cantidadRecibida.add(cantidadYaRecibida)).compareTo(cantidadPedida) ==1){
							resultadoValidacion = 1;
						}
					}
				}
			}
			rs.close();
			stmt.close();
			if(resultadoValidacion == 0) {
				query = "SELECT Cantidad, Llegan, Tipo, ClaveProducto FROM productos_orden WHERE ClaveOrden =  "+claveOrden +" AND Adquisicion = 0";
				rs = null;
				stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next() && resultadoValidacion ==0){
					if(prod1.equals(rs.getString("ClaveProducto")) && rs.getString("Tipo").equals(tipoUni1)){
						BigDecimal cantidadPedida = new BigDecimal(rs.getString("Cantidad"));
						BigDecimal cantidadYaRecibida = new BigDecimal(rs.getString("Llegan"));
						BigDecimal cantidadRecibida = new BigDecimal(can1);
						cantidadRecibida = cantidadRecibida.setScale(3, RoundingMode.HALF_UP);
						if((cantidadPedida.add(cantidadYaRecibida)).compareTo(cantidadRecibida) == -1){
							resultadoValidacion = 2;
						}
					}
					if(prod2.equals(rs.getString("ClaveProducto")) && rs.getString("Tipo").equals(tipoUni2)){
						BigDecimal cantidadPedida = new BigDecimal(rs.getString("Cantidad"));
						BigDecimal cantidadYaRecibida = new BigDecimal(rs.getString("Llegan"));
						BigDecimal cantidadRecibida = new BigDecimal(can2);
						cantidadRecibida = cantidadRecibida.setScale(3, RoundingMode.HALF_UP);
						if((cantidadPedida.add(cantidadYaRecibida)).compareTo(cantidadRecibida) == -1){
							resultadoValidacion = 2;
						}
					}
					if(prod3.equals(rs.getString("ClaveProducto")) && rs.getString("Tipo").equals(tipoUni3)){
						BigDecimal cantidadPedida = new BigDecimal(rs.getString("Cantidad"));
						BigDecimal cantidadYaRecibida = new BigDecimal(rs.getString("Llegan"));
						BigDecimal cantidadRecibida = new BigDecimal(can3);
						cantidadRecibida = cantidadRecibida.setScale(3, RoundingMode.HALF_UP);
						if((cantidadPedida.add(cantidadYaRecibida)).compareTo(cantidadRecibida) == -1){
							resultadoValidacion = 2;
						}
					}
				}
			}
			rs.close();
			stmt.close();
			if(resultadoValidacion == 0) {
// Almaceno el documento aval y la cantidad de productos que le corresponden.
				PreparedStatement updateDocAval;
				updateDocAval = con.miConnection.prepareStatement("insert into facturas values(?,?,?,?,?);");
				updateDocAval.setInt(1, cambiaAInt(claveOrden));
				updateDocAval.setString(2, compra);
				updateDocAval.setInt(3, cambiaAInt(tipoDocumento));
				if(tipoDocumento.equals("1")){
					updateDocAval.setString(4, compra);
				}
				else{
					updateDocAval.setString(4, "");
				}
				updateDocAval.setDate(5, cambiaADate(fechaCompra));
				updateDocAval.execute();
				updateDocAval.close();
				// Guardo mi producto relacionado con un documento Aval
				int consecutivoRecepcion = 1;
				// Checo si tengo recepciones previas.
				String queryRepPrevia = "SELECT MAX(consecutivoRecepcion) AS consecutivo FROM aval_por_documento WHERE ClaveOrden = "+claveOrden;
				Statement stRP = con.creaStatement();
				ResultSet rsRP = stRP.executeQuery(queryRepPrevia);
				while(rsRP.next()){
					consecutivoRecepcion += rsRP.getInt("consecutivo");
				}
				for (int i = 0 ; i<arrayProducto.length; i++){
					if(!(arrayProducto[i].equalsIgnoreCase(""))) {
						BigDecimal canti = new BigDecimal(arrayCantidad[i]);
						canti = canti.setScale(3, RoundingMode.HALF_UP);
						int tipoPro = cambiaAInt(arrayTipo[i]);
						PreparedStatement updateProductoAval;
						updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
						updateProductoAval.setInt(1, cambiaAInt(claveOrden));
						updateProductoAval.setInt(2, cambiaAInt(arrayProducto[i]));
						updateProductoAval.setInt(3, consecutivoRecepcion);
						updateProductoAval.setInt(4, 1);
						updateProductoAval.setInt(5, tipoPro);
						updateProductoAval.setDouble(6, cambiaADouble(canti.toString()));
						updateProductoAval.setString(7, compra);
						updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
						updateProductoAval.setDate(9, cambiaADate(fechaCompra));
						updateProductoAval.setInt(10, 1);
						updateProductoAval.execute();
						updateProductoAval.close();
					}
				}
				if((!prod1.equalsIgnoreCase("")) && cambiaADouble(can1)>0.00){
					PreparedStatement updateProductoAval;
					updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
					updateProductoAval.setInt(1, cambiaAInt(claveOrden));
					updateProductoAval.setInt(2, cambiaAInt(prod1));
					updateProductoAval.setInt(3, consecutivoRecepcion);
					updateProductoAval.setInt(4, 0);
					updateProductoAval.setInt(5, cambiaAInt(tipoUni1));
					updateProductoAval.setDouble(6, cambiaADouble(can1));
					updateProductoAval.setString(7, compra);
					updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
					updateProductoAval.setDate(9, cambiaADate(fechaCompra));
					updateProductoAval.setInt(10, 1);
					updateProductoAval.execute();
					updateProductoAval.close();
				}
				if((!prod2.equalsIgnoreCase("")) && cambiaADouble(can2)>0.00){
					PreparedStatement updateProductoAval;
					updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
					updateProductoAval.setInt(1, cambiaAInt(claveOrden));
					updateProductoAval.setInt(2, cambiaAInt(prod2));
					updateProductoAval.setInt(3, consecutivoRecepcion);
					updateProductoAval.setInt(4, 0);
					updateProductoAval.setInt(5, cambiaAInt(tipoUni2));
					updateProductoAval.setDouble(6, cambiaADouble(can2));
					updateProductoAval.setString(7, compra);
					updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
					updateProductoAval.setDate(9, cambiaADate(fechaCompra));
					updateProductoAval.setInt(10, 1);
					updateProductoAval.execute();
					updateProductoAval.close();
				}
				if((!prod3.equalsIgnoreCase("")) && cambiaADouble(can3)>0.00){
					PreparedStatement updateProductoAval;
					updateProductoAval = con.miConnection.prepareStatement("insert into aval_por_documento values(?,?,?,?,?,?,?,?,?,?);");
					updateProductoAval.setInt(1, cambiaAInt(claveOrden));
					updateProductoAval.setInt(2, cambiaAInt(prod3));
					updateProductoAval.setInt(3, consecutivoRecepcion);
					updateProductoAval.setInt(4, 0);
					updateProductoAval.setInt(5, cambiaAInt(tipoUni3));
					updateProductoAval.setDouble(6, cambiaADouble(can3));
					updateProductoAval.setString(7, compra);
					updateProductoAval.setInt(8, cambiaAInt(tipoDocumento));
					updateProductoAval.setDate(9, cambiaADate(fechaCompra));
					updateProductoAval.setInt(10, 1);
					updateProductoAval.execute();
					updateProductoAval.close();
				}
				// Actualizo mis productos por los que pague
				for (int i =0; i<arrayProducto.length; i++){
					Statement stmt2 = con.creaStatement();
					BigDecimal canti = new BigDecimal(arrayCantidad[i]);
					canti = canti.setScale(3, RoundingMode.HALF_UP);
					int tipoPro = cambiaAInt(arrayTipo[i]);
					String queryString = "UPDATE productos_orden SET Llegan = (Llegan+"+canti.toString()+") WHERE ClaveOrden = "+claveOrden+" AND Tipo = "+tipoPro +" AND ClaveProducto = "+arrayProducto[i]+" AND Adquisicion = 1";
					stmt2.execute(queryString);
					stmt2.close();
				}
				// Aumento mi existencia de productos a la venta (Inventario)
				Statement stmt2 = con.creaStatement();
				for (int i =0; i<arrayProducto.length; i++){
					BigDecimal canti = new BigDecimal(arrayCantidad[i]);
					canti = canti.setScale(2, RoundingMode.HALF_UP);
					if(arrayTipo[i].equals("1")){	// Es Caja...
						BigDecimal multiplicador = new BigDecimal(Integer.toString(piezasXCaja(arrayProducto[i])));
						canti = canti.multiply(multiplicador);
						canti = canti.setScale(3, RoundingMode.HALF_UP);
					}
					String queryString = "UPDATE productos SET invTienda = (invTienda+"+canti.toString()+") WHERE ID_Pro = "+arrayProducto[i]+" AND activo = 1";
					stmt2.execute(queryString);
				}
				stmt2.close();
				// Actualizo mis productos obsequiados...
				if(!prod1.equalsIgnoreCase("") && cambiaADouble(can1) > 0.00){
					BigDecimal canti = new BigDecimal(can1);
					canti = canti.setScale(3, RoundingMode.HALF_UP);
					int tipoProd = cambiaAInt(tipoUni1);
					String updateObsequio = "UPDATE productos_orden SET Llegan = (Llegan+"+canti.toString()+") WHERE ClaveOrden = "+claveOrden+" AND ClaveProducto = '"+prod1+"' AND tipo = "+tipoProd +" AND Cantidad != Llegan AND Adquisicion = 0 LIMIT 1 ";
					Statement stmt3 = con.creaStatement();
					stmt3.execute(updateObsequio);
					stmt3.close();
					// AUMENTO EXISTENCIA DENTRO DE TABLA INVENTARIO
					if(tipoUni1.equals("1")){	// Es Caja...
						BigDecimal multiplicador = new BigDecimal(Integer.toString(piezasXCaja(prod1)));
						canti = canti.multiply(multiplicador);
						canti = canti.setScale(3, RoundingMode.HALF_UP);
					}
					String updateInventarioObsequio = "UPDATE productos SET invTienda = (invTienda+"+canti.toString()+") WHERE ID_Pro =  "+prod1+" AND activo = 1";
					Statement temp2 = con.creaStatement();
					temp2.execute(updateInventarioObsequio);
					temp2.close();
				}
				if(!prod2.equalsIgnoreCase("") && cambiaADouble(can2) > 0.00){
					BigDecimal canti = new BigDecimal(can2);
					canti = canti.setScale(3, RoundingMode.HALF_UP);
					int tipoProd = cambiaAInt(tipoUni2);
					String updateObsequio = "UPDATE productos_orden SET Llegan = (Llegan+"+canti.toString()+") WHERE ClaveOrden = "+claveOrden+" AND ClaveProducto = '"+prod2+"' AND tipo = "+tipoProd +" AND Cantidad != Llegan AND Adquisicion = 0 LIMIT 1 ";
					Statement stmt3 = con.creaStatement();
					stmt3.execute(updateObsequio);
					stmt3.close();
					// AUMENTO EXISTENCIA DENTRO DE TABLA INVENTARIO
					if(tipoUni2.equals("1")){	// Es Caja...
						BigDecimal multiplicador = new BigDecimal(Integer.toString(piezasXCaja(prod2)));
						canti = canti.multiply(multiplicador);
						canti = canti.setScale(3, RoundingMode.HALF_UP);
					}
					String updateInventarioObsequio = "UPDATE productos SET invTienda = (invTienda+"+canti.toString()+") WHERE ID_Pro = "+prod2+" AND activo = 1";
					Statement temp2 = con.creaStatement();
					temp2.execute(updateInventarioObsequio);
					temp2.close();
				}
				if(!prod3.equalsIgnoreCase("") && cambiaADouble(can3) > 0.00){
					BigDecimal canti = new BigDecimal(can3);
					canti = canti.setScale(3, RoundingMode.HALF_UP);
					int tipoProd = cambiaAInt(tipoUni3);
					String updateObsequio = "UPDATE productos_orden SET Llegan = (Llegan+"+canti.toString()+") WHERE ClaveOrden = "+claveOrden+" AND ClaveProducto = '"+prod3+"' AND tipo = "+tipoProd +" AND Cantidad != Llegan AND Adquisicion = 0 LIMIT 1 ";
					Statement stmt3 = con.creaStatement();
					stmt3.execute(updateObsequio);
					stmt3.close();
					// AUMENTO EXISTENCIA DENTRO DE TABLA INVENTARIO
					if(tipoUni3.equals("1")){	// Es Caja...
						BigDecimal multiplicador = new BigDecimal(Integer.toString(piezasXCaja(prod3)));
						canti = canti.multiply(multiplicador);
						canti = canti.setScale(3, RoundingMode.HALF_UP);
					}
					String updateInventarioObsequio = "UPDATE productos SET invTienda = (invTienda+"+canti.toString()+") WHERE ID_Pro = "+prod3+" AND activo = 1";
					Statement temp2 = con.creaStatement();
					temp2.execute(updateInventarioObsequio);
					temp2.close();
				}

				// Si tengo recepciones previas significa que el estado de entrega es de finalizado o bien de Entrega Parcial
				boolean siHayRecepcionesPrevias = false;
				String hayCompras = "SELECT Estatus FROM aval_por_documento  WHERE Estatus = 1 AND ClaveOrden = "+claveOrden+"";
//System.out.println(siHayRecepcionesPrevias);
				Statement stmt4 = con.creaStatement();
				ResultSet rs4 = stmt4.executeQuery(hayCompras);
				while(rs4.next()){
					siHayRecepcionesPrevias = true;
				}
				rs4.close();
				stmt4.close();
				if(siHayRecepcionesPrevias){
					String cambiaEstadoRecepcion = "UPDATE orden_compra SET entrega = 1 WHERE claveOrden = "+claveOrden+" AND entrega != 2";
					stmt4 = con.creaStatement();
					stmt4.execute(cambiaEstadoRecepcion);
					stmt4.close();
				}




				boolean finalizadosProductos = true;
				String queryFinProductosC = "SELECT Cantidad, Llegan FROM productos_orden WHERE ClaveOrden = "+claveOrden;
				Statement estadoPC = con.creaStatement();
				ResultSet rsPC = estadoPC.executeQuery(queryFinProductosC);
				while (rsPC.next()){
					if(rsPC.getDouble("Cantidad") > rsPC.getDouble("Llegan")){
						finalizadosProductos = false;
					}
				}
				rsPC.close();
				estadoPC.close();
				if(finalizadosProductos){
					tiempo = new TimeStamp();
					String fechaHoy = tiempo.date;
					String updateFinalizadaEntradas = "UPDATE orden_compra SET  Entrega = 2, fechaPago = '"+setFechaPago(fechaHoy, claveProveedor) +"', fechaEntrega = '"+fechaHoy+"' WHERE ClaveOrden = "+claveOrden;
					Statement temp2 = con.creaStatement();
					temp2.execute(updateFinalizadaEntradas);
					temp2.close();
					// Si cambio el precio saco un promedio y lo almaceno en productos verificando que la transacción haya sido finalizada....
					String queryParaActualizarPrecios = "SELECT productos_orden.ClaveProducto, productos_orden.Costo, productos_orden.Tipo, productos_orden.CambiaPrecio, productos.tipoPrecio, productos.precioUniCompra, productos.cantidadXCaja, productos.preCaCompra, productos.kgXUnidad FROM productos_orden, productos WHERE productos_orden.ClaveOrden = "+claveOrden +" AND productos_orden.Adquisicion = 1 AND productos.ID_Pro = productos_orden.ClaveProducto";
					Statement stChecaP = con.creaStatement();
					ResultSet rsP = stChecaP.executeQuery(queryParaActualizarPrecios);
					while (rsP.next()){
						if(rsP.getInt("CambiaPrecio")==1){ // Si me solicitan cambio de precio....
							BigDecimal precioActual = null;
							BigDecimal precioNuevo = null;
							precioActual = new BigDecimal(Double.toString(damePrecioActual (rsP.getString("ClaveProducto"), rsP.getInt("Tipo"))));
							precioActual = precioActual.setScale(2, RoundingMode.HALF_UP);
							if(! tieneIva(rsP.getString("ClaveProducto"))){ // Producto Sin IVA
								precioNuevo = new BigDecimal(rsP.getString("Costo"));
							}
							else{
								precioNuevo = new BigDecimal(Double.toString(rsP.getDouble("Costo")));
								BigDecimal porcentajeImpuestos = new BigDecimal("1.15");
								precioNuevo = precioNuevo.multiply(porcentajeImpuestos);
								precioNuevo = precioNuevo.setScale(2, RoundingMode.HALF_UP);
							}
							if(precioActual.compareTo(precioNuevo) != 0){ // Realmente es precio diferente, asi que voy a cambiarlo.
								String actualizaPrecio = "";
								if(rsP.getInt("Tipo") == 0){
									actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
									// Checo si existe tambien compra por caja para actualizar su precio...
									if(rsP.getDouble("preCaCompra") > 0.00){
										BigDecimal precioCaja = precioNuevo.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
										precioCaja = precioCaja.setScale(2, RoundingMode.HALF_UP);
										actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioCaja.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
										stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
									}
								}
								else if(rsP.getInt("Tipo") == 1){
									// Actualizo el precio de Caja
									actualizaPrecio = "UPDATE productos SET preCaCompra = " +precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
									// Checo si existe tambien compra por unidad para actualizar su precio...
									if(rsP.getDouble("precioUniCompra") > 0.00){
										BigDecimal precioUnidad = precioNuevo.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
										precioUnidad = precioUnidad.setScale(2, RoundingMode.HALF_UP);
										actualizaPrecio = "UPDATE productos SET precioUniCompra = " +precioUnidad.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
										stAct = con.creaStatement();
										stAct.execute(actualizaPrecio);
										stAct.close();
									}
								}
								else if(rsP.getInt("Tipo") == 2){
									actualizaPrecio = "UPDATE productos SET precioUnidadKG = "+precioNuevo.toString() +" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+" AND activo = 1";
									Statement stAct = con.creaStatement();
									stAct.execute(actualizaPrecio);
									stAct.close();
								}
								Statement stAct = con.creaStatement();
								stAct.execute(actualizaPrecio);
								stAct.close();
								// Ahora actualizo precios de Venta de Acuerdo al porcentaje de ganancia por producto.
								if(rsP.getInt("tipoPrecio") != 2){ // No es de escalon asi que puedo actualizar...
									BigDecimal constante100 = new BigDecimal("100.0");
									String queryDamePorcentajes ="SELECT PrecioTipo, Porcentual FROM ganancia_porcentual WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
									Statement stNuevoPV = con.creaStatement();
									ResultSet rsNP = stNuevoPV.executeQuery(queryDamePorcentajes);
									while (rsNP.next()){
										BigDecimal porcentualG = new BigDecimal(rsNP.getString("Porcentual"));
										BigDecimal nuevoVenta  = new BigDecimal("0.00");
										nuevoVenta = (((precioNuevo.multiply(porcentualG)).divide(constante100, new MathContext(100))).add(precioNuevo));
										nuevoVenta = nuevoVenta.setScale(1, RoundingMode.HALF_UP);
										String actualizaPVenta = "";
										Statement actuPVenta = con.creaStatement();
										if(rsP.getInt("Tipo") == 2){ // Hablamos de un producto de pesaje
											if(rsNP.getInt("PrecioTipo") == 1){
												actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 2){
												BigDecimal tempPieza = new BigDecimal("0.00");
												tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
												tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 3){
												actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 4){
												BigDecimal tempPieza = new BigDecimal("0.00");
												tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
												tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 5){
												actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 6){
												BigDecimal tempPieza = new BigDecimal("0.00");
												tempPieza = nuevoVenta.multiply(new BigDecimal(rsP.getString("kgXUnidad")), new MathContext(100));
												tempPieza = tempPieza.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMC = "+tempPieza.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
										} // Cierro es de Pesaje...
										else if(rsP.getInt("Tipo")== 0){ // Se compro por pieza.
											if(rsNP.getInt("PrecioTipo") == 1){
												actualizaPVenta = "UPDATE productos SET precioMenu = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 2){
												BigDecimal tempCaja = new BigDecimal("0.00");
												tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMenuC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 3){
												actualizaPVenta =  "UPDATE productos SET precioMM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 4){
												BigDecimal tempCaja = new BigDecimal("0.00");
												tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 5){
												actualizaPVenta =  "UPDATE productos SET precioM = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 6){
												BigDecimal tempCaja = new BigDecimal("0.00");
												tempCaja = nuevoVenta.multiply(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempCaja = tempCaja.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMC = "+tempCaja.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
										}
										else{ // Se Compro por Caja
											if(rsNP.getInt("PrecioTipo") == 1){
												BigDecimal tempUni = new BigDecimal("0.00");
												tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta = "UPDATE productos SET precioMenu = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 2){
												actualizaPVenta =  "UPDATE productos SET precioMenuC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 3){
												BigDecimal tempUni = new BigDecimal("0.00");
												tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioMM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 4){
												actualizaPVenta =  "UPDATE productos SET precioMMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 5){
												BigDecimal tempUni = new BigDecimal("0.00");
												tempUni = nuevoVenta.divide(new BigDecimal(rsP.getString("cantidadXCaja")), new MathContext(100));
												tempUni = tempUni.setScale(1, RoundingMode.HALF_UP);
												actualizaPVenta =  "UPDATE productos SET precioM = "+tempUni.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
											else if(rsNP.getInt("PrecioTipo") == 6){
												actualizaPVenta =  "UPDATE productos SET precioMC = "+nuevoVenta.toString()+" WHERE ID_Pro = "+rsP.getString("ClaveProducto")+"";
											}
										}
										actuPVenta.execute(actualizaPVenta);
										actuPVenta.close();
									}
									rsNP.close();
									stNuevoPV.close();
								}
								// Almacenado cambio de producto:
								PreparedStatement updatePrecioAnterior;
								updatePrecioAnterior = con.miConnection.prepareStatement("insert into precio_anterior_producto values(?,?,?,?,?);");
								updatePrecioAnterior.setInt(1, rsP.getInt("ClaveProducto"));
								updatePrecioAnterior.setInt(2, rsP.getInt("Tipo"));
								updatePrecioAnterior.setInt(3, cambiaAInt(claveOrden));
								updatePrecioAnterior.setDouble(4, cambiaADouble(precioActual.toString()));
								updatePrecioAnterior.setDouble(5, cambiaADouble(precioNuevo.toString()));
								updatePrecioAnterior.execute();
							} // Cierro solicitan cambio de Precio...
						}
					}
					rsP.close();
					stChecaP.close();
				}
			}
			if(resultadoValidacion != 0){
				con.realizaRollback();
			}
			con.realizaCommit();
		}
		catch(SQLException sqle){
			 con.realizaRollback();
			 resultadoValidacion =  3;
			System.out.println("Excepcion SQL en bean ManagerCompra, Metodo: finalizaRecepcion.\n");
			sqle.printStackTrace();
		 }
		catch(Exception e){
			con.realizaRollback();
			resultadoValidacion =  3;
			System.out.println("Excepcion en bean ManagerCompra, Metodo: finalizaRecepcion.\n");
			e.printStackTrace();
		}
		finally{
			try{
				con.habilitaAutoCommit();
				 con.cierraConexion();
			 }
			 catch (Exception e2){
				 e2.printStackTrace();
			 }
		 }
	 }
	 else{
			System.out.println("No pude inicializar la conexion a la BD Metodo: finalizaRecepcion.\n");
 			 resultadoValidacion =  3;
	 }
	 return resultadoValidacion;
 }



 /**
 * El método addFactura se encarga de asignar una Factura a la Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
	public boolean addFactura(String usuario) throws SQLException, Exception {
		String tiene = tieneFactura2();
		ResultSet produc = todosProductosOrden();
		con = new ConexionBD();
		boolean resultado = false;
		try  {
			//Date fec = cambiaADate(fechaCompra);
			int cla = cambiaAInt(claveOrden);
			// System.out.println("La fexcha: "+fechaCompra);
			if(tiene.equalsIgnoreCase("0")){
				//System.out.println("No tiene");
				String queryString = "UPDATE orden_compra SET factura = '"+compra+"', fechaEntrega = '"+fechaCompra+"', Entrega = 1, usuario = '"+usuario+	"' WHERE ClaveOrden = "+cla+" ";
				//System.out.println("query: "+queryString);
				//System.out.println("queryString: "+queryString);
				Statement stmt = con.miConnection.createStatement();
				resultado = stmt.execute(queryString);
				if(resultado == false)
					resultado = true;
				else
					resultado = false;
			}
			else{
				//System.out.println("Si tiene");
				PreparedStatement updateFacturas;
				updateFacturas = con.miConnection.prepareStatement("insert into facturas values(?,?,?);");
				updateFacturas.setInt(1, cla);
				updateFacturas.setString(2, compra);
				updateFacturas.setString(3, fechaCompra);
				updateFacturas.execute();
				resultado = true;
			}
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query addFactura.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Ocurrió una excepción mientras se actualizaba addFactura.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerCompra metodo addFactura");
				q.printStackTrace();
			}
		}
		return resultado;
	}

/**
* El Método damePrecioActual nos regresa los precios registrados actualmente en el Sistema.
*
*  @return double  con el precio correspondiente al producto.
*/

	public double damePrecioActual(String claveDelProducto) throws SQLException, Exception{
		double precioAc = 0.00;
		ResultSet rs = null;
		try{
			String query = ("SELECT costo FROM productos WHERE claveProducto = '"+claveDelProducto +"'");
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				precioAc = rs.getDouble("costo");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, damePrecioActual ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, damePrecioActual ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, damePrecioActual ");
					q.printStackTrace();
				}
			}
		}
		return precioAc;
	}




/**
* El Método damePrecioActual nos regresa los precios registrados actualmente en el Sistema.
*
*  @return double  con el precio correspondiente al producto.
*/

	public double damePrecioActual(String claveDelProducto, int tipoDeProducto) throws SQLException, Exception{
		double precioAc = 0.00;
		ResultSet rs = null;
		String query = "";
		try{
			if(tipoDeProducto == 0){
				query = ("SELECT precioUniCompra AS costo FROM productos WHERE ID_Pro = '"+claveDelProducto +"' AND activo = 1");
			}
			else if(tipoDeProducto == 1){
				query = ("SELECT preCaCompra AS costo FROM productos WHERE ID_Pro = '"+claveDelProducto +"' AND activo = 1");
			}
			else if(tipoDeProducto == 2){
				query = ("SELECT (precioUnidadKG) AS costo FROM productos WHERE ID_Pro = '"+claveDelProducto +"' AND activo = 1");
			}
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				precioAc = rs.getDouble("costo");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, damePrecioActual ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, damePrecioActual ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, damePrecioActual ");
					q.printStackTrace();
				}
			}
		}
		return precioAc;
	}




/**
* El Método todosProductosOrden nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet todosProductosOrden(){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT DISTINCT pro.*, ord.ClaveProveedor FROM productos_orden pro, orden_compra ord WHERE ord.ClaveOrden = "+cla+" AND  pro.ClaveOrden = ord.ClaveOrden");
			//System.out.println("da lata: "+query);
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todosProductosOrden ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todosProductosOrden ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, todosProductosOrden ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}


 /**
 * El método actualiza_llego1 se encarga de asignar las Cantidades recibidas en los pordutos normales.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public boolean actualiza_llego1() throws SQLException, Exception {
 			con = new ConexionBD();
			boolean resultado = false;
             try  {
				 int cla = cambiaAInt(claveOrden);
				int cantNum = cambiaAInt(cantNumProductos);
				String cambio = "";

				for (int i =1; i<=cantNum; i++){

					int canti = cambiaAInt(arrayCantidad[i]);

					//System.out.println("Unidad: "+ArrayUnidad[i]);

					String queryString = "UPDATE productos_orden SET Llegan = (Llegan+"+canti+") WHERE ClaveOrden = "+cla+" AND ClaveProducto = '"+arrayProducto[i]+"'";
 					//System.out.println("queryString Productos: "+queryString);

               		Statement stmt = con.miConnection.createStatement();
               		resultado = stmt.execute(queryString);

               		if(resultado == false)
               			resultado = true;
               		else
               			resultado = false;
				}
             } catch (SQLException sqle) {
 				sqle.printStackTrace();
               error = "SQLException: Could not execute the query actualiza_llego1."+sqle;
               throw new SQLException(error);
             } catch (Exception e) {
               error = "Ocurrió una excepción mientras se actualizaba actualiza_llego1."+e;
               throw new Exception(error);
             }
             finally{
 				try{
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo actualiza_llego1");
 			   		q.printStackTrace();
 			 	}
 		   }
		return resultado;
     }



      /**
	  * El método actualiza_llego2 se encarga de asignar las Cantidades recibidas en los pordutos de regalos extras.
	  *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
	  */
	    public boolean actualiza_llego2() throws SQLException, Exception {
	  			con = new ConexionBD();
	 			boolean resultado = true;
	              try  {
	 				 //Date fec = cambiaADate(fechaCompra);
	 				 int cla = cambiaAInt(claveOrden);

	 				if(!prod1.equalsIgnoreCase("")){
	 					//System.out.println("Entro a prod1");
	 					//System.out.println("De entrada: "+prod1+", "+uni1+", "+can1);
	 					int ouni = 1;

	 					//System.out.println("Unidad1: "+ouni);
	 					int ocan = cambiaAInt(remueveComas(can1));
	 					//System.out.println("Cantidad1: "+ocan);

	  					String queryString = "UPDATE regalos_extras SET Llego = (Llego+"+ocan+") WHERE ClaveOrden = "+cla+" AND ClaveProducto = '"+prod1+"'";
	  					//System.out.println("queryString1: "+queryString);
	                		Statement stmt = con.miConnection.createStatement();
	                		resultado = stmt.execute(queryString);
	                		if(resultado == false)
	                			resultado = true;
	                		else
	                			resultado = false;

	 				}


	 				if(!prod2.equalsIgnoreCase("")){

	 					int oun = 1;
	 					int oca = cambiaAInt(remueveComas(can2));

	  					String queryString = "UPDATE regalos_extras SET Llego = (Llego+"+oca+") WHERE ClaveOrden = "+cla+" AND ClaveProducto = '"+prod2+"'";
	  					//System.out.println("queryString2: "+queryString);
	                		Statement stmt = con.miConnection.createStatement();
	                		resultado = stmt.execute(queryString);
	                		if(resultado == false)
	                			resultado = true;
	                		else
	                			resultado = false;

	 				}

	 				if(!prod3.equalsIgnoreCase("")){

	 					int ou = 1;
	 										int oc = cambiaAInt(remueveComas(can3));

	  					String queryString = "UPDATE regalos_extras SET Llego = (Llego+"+oc+") WHERE ClaveOrden = "+cla+" AND ClaveProducto = '"+prod3+"'";
	  					//System.out.println("queryString3: "+queryString);
	                		Statement stmt = con.miConnection.createStatement();
	                		resultado = stmt.execute(queryString);
	                		if(resultado == false)
	                			resultado = true;
	                		else
	                			resultado = false;

	 				}

	              } catch (SQLException sqle) {
	  				sqle.printStackTrace();
	                error = "SQLException: Could not execute the query actualiza_llego2.";
	                throw new SQLException(error);
	              } catch (Exception e) {
	                error = "Ocurrió una excepción mientras se actualizaba actualiza_llego2.";
	                throw new Exception(error);
	              }
	              finally{
	  				try{
	  			   		con.cierraConexion();
	  			  	}
	  			   	catch (Exception q){
	  			   		System.out.println("Error al cerrar conexion de ManagerCompra metodo actualiza_llego2");
	  			   		q.printStackTrace();
	  			 	}
	  		   }
	 		return resultado;
	      }


/**
* El método Facturas_Dia se encarga de enviar la información de las Facturas realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Facturas
*/

	public ResultSet Facturas_Dia(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fechaRegistro like '" +fecha+"' AND activo = 1 ORDER BY claveOrden");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Facturas_Dia.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Facturas_Dia.";
			throw new Exception(error);
		}
	return rs;
	}


/**
* El Método dameFacturasExtras nos regresa todas las Devoluciones correspondientes a una Compra.
*
*  @return rs ResultSet con las Devoluciones de una Compra.
*/
	public ResultSet dameFacturasExtras(String clave){
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM facturas WHERE claveOrden = "+clave);
			//System.out.println("query: "+query);
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameFacturasExtras ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameFacturasExtras ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El método Facturas_Semana se encarga de enviar la información de Facturas para una periodo de una semana de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos la información de las Facturas
*/

	public ResultSet Facturas_Semana(String semana, String fecha) throws SQLException, Exception {
		//System.out.println("Me llego : " +semana +", " +fecha);
		String diaInicial = "01";
		String diaFinal = "08";
		ResultSet rs = null;
		con = new ConexionBD();
		if (semana.equalsIgnoreCase("02")){
			diaInicial = "08";
			diaFinal = "16";

		}
		else if (semana.equalsIgnoreCase("03")){
			diaInicial = "16";
			diaFinal = "24";

		}
		else if (semana.equalsIgnoreCase("04")) {
			diaInicial = "24";
			diaFinal = "31";

		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fechaRegistro >= '" +fecha+"-"+diaInicial+"%%%%%%%%%%%' AND fechaRegistro <'"+fecha+"-"+diaFinal+"%%%%%%%%%%%'  AND activo = 1  ORDER BY claveOrden");
			//System.out.println(queryString);
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Facturas_Semana.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Facturas_Semana.";
			throw new Exception(error);
		}
	return rs;
	}


 public ResultSet Facturas_Mes(String fecha0) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT * FROM orden_compra WHERE fechaRegistro like '"+fecha0+"%%%%%%%%%' AND activo = 1  ORDER BY claveOrden");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query Facturas_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Facturas_Mes.";
          throw new Exception(error);
        }
        return rs;
  }



/**
* El Método tieneFactura nos regresa si la orden de compra tiene factura.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public int tieneFactura(){
		ResultSet rs = null;
		String aver = new String();
		int resul = 0;
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT factura FROM orden_compra WHERE ClaveOrden = "+cla+" ");
			//System.out.println("A ver si tiene: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("factura");
			}
			//System.out.println("antes del entero: "+aver);
			resul = cambiaAInt(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, tieneFactura ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, tieneFactura ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, tieneFactura ");
					q.printStackTrace();
				}
			}
		}
		//System.out.println("Regreso: "+resul);
		return resul;
	}


	public String tieneFactura2(){
		ResultSet rs = null;
		String aver = new String();
		try{
			int cla = cambiaAInt(claveOrden);
			String query = ("SELECT docAval FROM orden_compra WHERE ClaveOrden = "+cla+" ");
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("docAval");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, tieneFactura2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, tieneFactura2 ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, tieneFactura2 ");
					q.printStackTrace();
				}
			}
		}
		return aver;
	}


/**
* El método Ordenes_Dia se encarga de enviar la información de las Ordenes de Compra realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Ordenes de Compra
*/

	public ResultSet Ordenes_Dia(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fechaEntrega like '" +fecha+"%%%%%%%%%%%' AND activo = 1  AND Entrega != 2 ORDER BY ClaveOrden");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Ordenes_Dia.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Ordenes_Dia.";
			throw new Exception(error);
		}
	return rs;
	}


/**
* El método Ordenes_Semana se encarga de enviar la información de Ordenes de Compra para una periodo de una semana de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos la información de las Ordenes de Compra
*/

	public ResultSet Ordenes_Semana(String semana, String fecha) throws SQLException, Exception {
		//System.out.println("Me llego : " +semana +", " +fecha);
		String diaInicial = "01";
		String diaFinal = "08";
		ResultSet rs = null;
		con = new ConexionBD();
		if (semana.equalsIgnoreCase("02")){
			diaInicial = "08";
			diaFinal = "16";

		}
		else if (semana.equalsIgnoreCase("03")){
			diaInicial = "16";
			diaFinal = "24";

		}
		else if (semana.equalsIgnoreCase("04")) {
			diaInicial = "24";
			diaFinal = "31";

		}
		try  {
			String queryString = ("SELECT * FROM orden_compra WHERE fechaEntrega >= '" +fecha+"-"+diaInicial+"%%%%%%%%%%%' AND fechaEntrega <'"+fecha+"-"+diaFinal+"%%%%%%%%%%%' AND activo = 1  AND Entrega != 2 ORDER BY ClaveOrden");
			//System.out.println(queryString);
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Ordenes_Semana.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Ordenes_Semana.";
			throw new Exception(error);
		}
	return rs;
	}

 public ResultSet Ordenes_Mes(String fecha0) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT * FROM orden_compra WHERE fechaEntrega like '"+fecha0+"%%%%%%%%%' AND activo = 1  AND Entrega != 2 ORDER BY ClaveOrden");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Ordenes_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Ordenes_Mes.";
          throw new Exception(error);
        }
        return rs;
  }


 public ResultSet Producto_Mes(String fecha0, String producto) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
  		//System.out.println(fecha0);
  		//System.out.println(producto);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT ord.claveOrden, ord.claveProveedor, ord.fechaEntrega, ord.factura, pr.Cantidad FROM orden_compra ord, productos_orden pr WHERE ord.FechaEntrega like '"+fecha0+"%%' AND ord.activo = 1 AND ord.factura != '0' AND ord.ClaveOrden = pr.ClaveOrden AND pr.ClaveProducto = '"+producto+"' ORDER BY ord.fechaEntrega");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query Producto_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Producto_Mes.";
          throw new Exception(error);
        }
        return rs;
  }


/**************************************************************************************************************************/

/**
* El Método datosProveedores nos regresa todos los Proveedores registrados.
*
*  @return ResultSet con los proveedores
*/
	public ResultSet datosProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT Clave_Proveedor, Nombre_Proveedor FROM proveedores WHERE Habilitado = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, datosProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, datosProveedores ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPrecioProveedor, datosProveedores ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}



/**
* El Método todasLasFacturasXProveedores nos regresa todas las Facturas de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Facturas de Compra.
*/
	public ResultSet todasLasFacturasXProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveOrden,Compra,FechaCompra FROM orden_compra WHERE ClaveProveedor = '"+claveProveedor +"' AND Estatus = 1 AND Compra != '0' ORDER BY FechaCompra");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasFacturasXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasFacturasXProveedores ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, todasLasFacturasXProveedores ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}




/**
* El Método dameCantidadOriginalFactura nos regresa la Cantidad del Producto correspondientes a una Factura.
*
*  @return aver Int con la cantidad de Productos de una Factura.
*/
	public String dameCantidadOriginalFactura(){
		ResultSet rs = null;
		String aver = new String();
		try{
			int cla = cambiaAInt(claveOrden);
			int unid = cambiaAInt(tempUnidad);
			String query = ("SELECT Cantidad FROM productos_orden WHERE ClaveOrden = "+cla+" AND  ClaveProducto = '"+tempProducto+"' AND Unidad = "+unid+"");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("Cantidad");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, dameCantidadOriginalFactura ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, dameCantidadOriginalFactura ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, dameCantidadOriginalFactura ");
					q.printStackTrace();
				}
			}
		}
		return aver;
	}


/**
* El Método todasLasComprasXProveedores nos regresa todas las Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Compras.
*/
	public ResultSet todasLasComprasXProveedores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM orden_compra WHERE ClaveProveedor = '"+claveProveedor +"' AND Estatus = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todasLasOrdenesXProveedores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todasLasOrdenesXProveedores ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, todasLasOrdenesXProveedores ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}




/**
* El Método Lista_Precios nos regresa la Lista de Precios para Ventas.
*
*  @return rs ResultSet con la Lista de Precios.
*/
	public ResultSet Lista_Precios(){
		ResultSet rs = null;
		try{

			String query = ("SELECT pre.*, propv.Clave_Producto, ma.Nombre_Marca, li.Nombre_Linea, su.Nombre_Sublinea FROM precio_prod_x_prov pre, producto_proveedor propv, productos pro, marca ma, sublinea su, lineas li WHERE propv.ClaveP_P = pre.ClaveP_P AND pre.Estatus = 1 AND pro.Clave_Producto = propv.Clave_Producto AND ma.Clave_Marca = pro.Clave_Marca AND su.Clave_Sublinea = pro.Clave_Sublinea AND su.Clave_Linea = pro.Clave_Linea AND li.Clave_Linea = pro.Clave_Linea ORDER BY propv.Clave_Producto");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, Lista_Precios ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, Lista_Precios ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, Lista_Precios ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}




 public ResultSet Proveedor_Mes(String fecha0, String proveedor) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT ClaveOrden, Total, FechaCompra, Compra FROM orden_compra WHERE FechaCompra like '"+fecha0+"%%%%%%%%%' AND Estatus = 1 AND Compra != '0' AND ClaveProveedor = '"+proveedor+"' ORDER BY FechaCompra");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Proveedor_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Proveedor_Mes.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerCompra metodo Proveedor_Mes");
		   		q.printStackTrace();
		  	}
		}
        return rs;
  }



 public ResultSet Entrega_Mes(String fecha0, String entrega) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println("Antes del query");
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = (
          "SELECT ord.* FROM orden_compra ord WHERE ord.FechaCompra like '"+fecha0+"%%%%%%%%%' AND ord.Estatus = 1 AND ord.Compra != '0' AND ord.Entrega = '"+entrega+"' ORDER BY  ord.ClaveOrden");
       //   System.out.println("query: "+queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
       //   System.out.println("Despues del ResultSet");
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Entrega_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Entrega_Mes.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerCompra metodo Entrega_Mes");
		   		q.printStackTrace();
		  	}
		}
        return rs;
  }



// Funciones Genericas de Transformacion:

/**
* El método cambiaADate se encarga de transformar a un Date una variables en formato String.
*  	@param 	fecha	String a tranformar a Date.
*	@return Date	double con el valor de la variable.
*/
	public Date cambiaADate(String fecha) {
		java.sql.Date elDia;
		try {
			elDia = java.sql.Date.valueOf(new String(fecha));
		}
		catch(IllegalArgumentException iae){
			elDia = java.sql.Date.valueOf(new String("9999-10-10"));
		}
		return elDia;
	}


	public int cambiaAInt(String variable) throws Exception{
		int valor;
		try{
			valor = (Integer.parseInt(variable));
		}
		catch(NumberFormatException nfe){
			valor = 0;
		}
			return valor;
	}


	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}

	public double cambiaADouble(String variable) throws Exception{
		if(variable == null){
			variable = "";
		}
		variable = remueveComas(variable);
		double valor;
		try{
			Double val = (Double.valueOf(variable));
			valor = val.doubleValue();
		}
		catch(NumberFormatException nfe){
			valor =0;
		}
			return valor;
	}


	public String acortaLongitud(String muchosDecimales){
		StringBuffer sb = new StringBuffer (muchosDecimales);
		if(sb.indexOf(".") != -1){
			String decimales=sb.substring(sb.indexOf("."));
			String decima;
			decima = sb.substring(0, sb.indexOf("."));
			sb.delete(0,sb.length());
			if (decimales.length()>3){
				decimales = decimales.substring(0,3);
			}
			if(decimales.length()<=2){
				decimales = decimales+"0";
			}
			sb.append(decima);
			sb.append(decimales);
		}
		return sb.toString();
	}

	public String formatoDinero(String formato){
		//System.out.println("formato es: "+formato);
		formato = remueveComas(formato);
		formato = acortaLongitud(formato);
		StringBuffer losEnteros = new StringBuffer(dameEnteros(formato));
		String losDecimales = dameDecimales(formato);
		if(losEnteros.length() == 8){
			losEnteros.insert(2,',');
			losEnteros.insert(6,',');
		}
		else if(losEnteros.length() == 7){
			losEnteros.insert(1,',');
			losEnteros.insert(5,',');
		}
		else if(losEnteros.length() == 4 ){
			losEnteros.insert(1,',');
		}
		else if(losEnteros.length() == 5 ){
			losEnteros.insert(2,',');
		}
		else if(losEnteros.length() == 6 ){
			losEnteros.insert(3,',');
		}
		//System.out.println("Sale: "+losEnteros.toString()+"."+losDecimales);
		return losEnteros.toString()+"."+losDecimales;
	}

	public String dameDecimales(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			sb=sb.delete(0, sb.indexOf(".")+1);
			existieron = true;
		}
		if (!existieron){
			sb = new StringBuffer ("00");
		}
		return sb.toString();
	}

	public String formatoCortoDinero(String enteros) throws Exception{
		StringBuilder sb1 = new StringBuilder (enteros);
		if(sb1.indexOf(".") != -1){
			sb1=sb1.delete(sb1.indexOf("."),sb1.length() );
		}
		boolean aumentaEnteros = false;
		StringBuilder sb = new StringBuilder (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			existieron = true;
			sb=sb.delete(0, sb.indexOf(".")+1);
			if(sb.length() == 1){
				sb.append("0");
			}
			else if(sb.length()>2){
				int primero = cambiaAInt(sb.substring(0,1));
				int anterior = cambiaAInt(sb.substring(1,2));
				int posterior = cambiaAInt(sb.substring(2,3));
				if(posterior >= 5){
					anterior +=1;
					if(anterior == 10){
						anterior = 0;
						primero +=1;
						if(primero == 10){
							primero = 0;
							aumentaEnteros = true;
						}
					}
					sb = new StringBuilder(primero+""+anterior+"");
				}
				else{
					sb = new StringBuilder(primero+""+anterior+"");
				}
			}
		}
		if (!existieron){
			sb = new StringBuilder ("00");
		}
		if(aumentaEnteros){
			int enteros2 = cambiaAInt(sb1.toString());
			enteros2 +=1;
			sb1 = new StringBuilder(enteros2+"");
		}
		return sb1.toString()+"."+sb.toString();
	}


	public String dameEnteros(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		if(sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length() );
		}
		return sb.toString();
	}

	private String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}
}