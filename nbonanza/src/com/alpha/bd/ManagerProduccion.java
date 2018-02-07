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


public class ManagerProduccion {

	private String error = new String("");
	private TimeStamp tiempo;
	private ConexionBD con;
	private ConexionBD con2;
	private ConexionBD con3;

// METODOS DE MANAGER PRODUCCION:

	public String dameFechaHoy() throws Exception{
		tiempo = new TimeStamp();
		return  tiempo.date2;
	}

	public String dameFechaHoyBD() throws Exception{
		tiempo = new TimeStamp();
		return  tiempo.date;
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
			String query = ("SELECT descripcion FROM productos WHERE ID_Pro = "+cambiaAInt(clave) +" AND activo = 1");
			con3 = new ConexionBD();
			Statement stmt = con3.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				des = rs.getString("descripcion");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, dameDescripcionProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, dameDescripcionProducto ");
			e.printStackTrace();
		}
		finally{
			if(con3 != null){
				try{
					con3.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerProduccion, dameDescripcionProducto ");
					q.printStackTrace();
				}
			}
		}
		return des;
	}

/**
* El Método todosLosProductosConInv  nos da el listado de todos los productos con su existencia en Inventarios
*
*  @return ResultSet con el listado correspondiente.
*/
	public ResultSet todosLosProductosCortes() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT ID_Pro, descripcion, tipoPro FROM productos WHERE cortes = 1 AND activo = 1 ORDER BY descripcion");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, todosLosProductosCortes ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, todosLosProductosCortes ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método todosLosProductosConInv  nos da el listado de todos los productos con su existencia en Inventarios
*
*  @return ResultSet con el listado correspondiente.
*/
	public ResultSet dameProductosMP() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT ID_Pro, descripcion, tipoPro, precioUniCompra, preCaCompra, precioUnidadKG, uniCompra FROM productos WHERE materiaPrima = 1 AND  activo = 1 ORDER BY descripcion");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, dameProductosMP ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, dameProductosMP ");
			e.printStackTrace();
		}
		return rs;
	}


	public double dameCantidadEnInve(String claveProdu, String tempTipo) throws SQLException, Exception{
		ResultSet rs = null;
		double cantidad = 0.00;
		try{
			String query = "";
			if (tempTipo.equalsIgnoreCase("caja")){
				query = ("SELECT SUM((invTienda+invAlmacen)/cantidadXCaja)AS Total FROM productos WHERE ID_Pro = "+cambiaAInt(claveProdu)+" AND materiaPrima = 1 AND  activo = 1 LIMIT 1");
			}
			else{
				query = ("SELECT SUM(invTienda+invAlmacen)AS Total FROM productos WHERE ID_Pro = "+cambiaAInt(claveProdu)+" AND materiaPrima = 1 AND  activo = 1 LIMIT 1");
			}
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				cantidad = rs.getDouble("Total");
			}
			rs.close();
			stmt.close();

		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, dameCantidadEnInve ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, dameCantidadEnInve ");
			e.printStackTrace();
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerProduccion metodo dameCantidadEnInve");
				q.printStackTrace();
			}
		}
		return cantidad;
	}


	public synchronized int  realizaConfirmacion(String clave, String[ ] ArrayProducto, String [ ]ArrayCantidad, String [ ]ArrayCantidadMP, String [ ]ArrayProductoMP, String [ ]ArrayTipoUMP, String fechaEntrega, String observaciones, String usuario) throws SQLException, Exception{
		fechaEntrega = fechaEntrega.substring(6,10)+"-"+fechaEntrega.substring(0,2)+"-"+fechaEntrega.substring(3,5);
		int resultado = 0; // 0 ->Exito, 1--> No alcanzo Inventario, 2 --> ErrorBD
 		con = new ConexionBD();
		if(con!=null){
			try  {
				con.cancelaAutoCommit();
// Primero checo que me alcanze lo que hay en el inventario de Materia Prima para satisfacer la demanda.
				for(int i = 0; i < ArrayProductoMP.length; i++){
					String query = "SELECT (invTienda+invAlmacen)AS Total, cantidadXCaja FROM productos WHERE ID_Pro = "+cambiaAInt(ArrayProductoMP[i])+"";
					Statement stmt = con.creaStatement();
					ResultSet rs = stmt.executeQuery(query);
					while(rs.next()){
						if(ArrayTipoUMP[i].equalsIgnoreCase("Caja")){
							if((cambiaAInt(ArrayCantidadMP[i])*rs.getInt("cantidadXCaja")) > rs.getInt("Total")){
								resultado = 1;
							}
						}
						else if(ArrayTipoUMP[i].equalsIgnoreCase("Pieza")){
							if(cambiaAInt(ArrayCantidadMP[i]) > rs.getInt("Total")){
								resultado = 1;
							}
						}
						else{
							if(cambiaADouble(ArrayCantidadMP[i]) > rs.getDouble("Total")){
								resultado = 1;
							}
						}
					}
					rs.close();
					stmt.close();
				}
				if(resultado != 1){
// Confirmo orden
					PreparedStatement ConfOrden = con.miConnection.prepareStatement("UPDATE orden_trabajo SET fechaConfirmacion = ?, usuarioConfirmacion = ?, ObsConfirmacion = ?, estatus = ?  WHERE clave = ? ");
					ConfOrden.setString(1, fechaEntrega);
					ConfOrden.setString(2, usuario);
					ConfOrden.setString(3, observaciones);
					ConfOrden.setInt(4, 2);
					ConfOrden.setInt(5, cambiaAInt(clave));
					ConfOrden.execute();
					ConfOrden.close();
// Cancel acceso a tabla de productos
					Statement statement = con.creaStatement();
					statement.execute("LOCK TABLES productos WRITE, productos_orden_trabajo WRITE, mp_orden_trabajo WRITE");
					statement.close();
// Actualizo cantidad de Producto Creado
					for(int i = 0; i<ArrayProducto.length; i++){
						PreparedStatement ConfProductoOrden = con.miConnection.prepareStatement("UPDATE productos_orden_trabajo SET cantidad = ?  WHERE clave_Orden = ? AND clave_Producto = ?");
						ConfProductoOrden.setDouble(1, cambiaADouble(ArrayCantidad[i]));
						ConfProductoOrden.setInt(2, cambiaAInt(clave));
						ConfProductoOrden.setInt(3,cambiaAInt(ArrayProducto[i]));
						ConfProductoOrden.execute();
						ConfProductoOrden.close();
						PreparedStatement actualizaInv = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda + ?)  WHERE ID_Pro = ? AND activo = 1");
						actualizaInv.setDouble(1, cambiaADouble(ArrayCantidad[i]));
						actualizaInv.setInt(2, cambiaAInt(ArrayProducto[i]));
						actualizaInv.execute();
						actualizaInv.close();
					}
// Actualizo cantidad de Producto Creado
					for(int i = 0; i<ArrayProductoMP.length; i++){
						int tipo = 0;
						if(ArrayTipoUMP[i].equals("Pieza")){
							tipo = 1;
						}
						else if(ArrayTipoUMP[i].equals("Caja")){
							tipo = 2;
						}
						else if(ArrayTipoUMP[i].equals("Kilo")){
							tipo = 3;
						}
						PreparedStatement almacena_MP_OT = con.miConnection.prepareStatement("insert into mp_orden_trabajo values(?,?,?,?)");
						almacena_MP_OT.setInt(1, cambiaAInt(clave));
						almacena_MP_OT.setInt(2, cambiaAInt(ArrayProductoMP[i]));
						almacena_MP_OT.setDouble(3, cambiaADouble(ArrayCantidadMP[i]));
						almacena_MP_OT.setInt(4, tipo);
						almacena_MP_OT.execute();
						almacena_MP_OT.close();
// Voya a descontar de Inventario primero del de Almacen y luego Tienda
						double enTienda = 0.00;
						double enAlmacen = 0.00;
						double quitan = cambiaADouble(ArrayCantidadMP[i]);
						String query = "SELECT invTienda, invAlmacen, cantidadXCaja FROM productos WHERE ID_Pro = "+ArrayProductoMP[i]+" AND activo = 1 LIMIT 1";
						Statement stmt = con.creaStatement();
						ResultSet rs = stmt.executeQuery(query);
						while(rs.next()){
							enAlmacen = rs.getDouble("invAlmacen");
							enTienda = rs.getDouble("invTienda");
							if(tipo ==2){ // ES caja
								quitan = quitan*rs.getDouble("cantidadXCaja");
							}
							if(quitan > 0){ // Si existe una cantidad a descontar
								if(enAlmacen > 0) {// HAy producto en almacen
									if(quitan>enAlmacen || quitan == enAlmacen){
										quitan = quitan-enAlmacen;
										enAlmacen = 0.00;
									}
									else if(quitan<enAlmacen){
										enAlmacen = enAlmacen-quitan;
										quitan = 0.00;
									}
								}
								if(enTienda > 0 && quitan > 0){ // Hay Producto en Tienda y aun no cubro lo usado.
									if(quitan == enTienda){
										enTienda = 0.00;
									}
									else{
										enTienda = enTienda-quitan;
									}
								}
							}
						}// Cierro RS.
						rs.close();
						stmt.close();
						PreparedStatement actualizaInv = con.miConnection.prepareStatement("UPDATE productos SET invTienda =  ?, invAlmacen =  ?  WHERE ID_Pro = ? AND activo = 1");
						actualizaInv.setDouble(1, enTienda);
						actualizaInv.setDouble(2, enAlmacen);
						actualizaInv.setInt(3, cambiaAInt(ArrayProductoMP[i]));
						actualizaInv.execute();
						actualizaInv.close();
					}
					statement = con.creaStatement();
					statement.execute("UNLOCK TABLES");
					statement.close();
				}// Cierro el if de MP completa para descontar..
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				resultado = 2;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query realizaEntrega.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				e.printStackTrace();
				resultado = 2;
				con.realizaRollback();
				error = "Ocurrió una excepción mientras se actualizaba realizaEntrega.";
				throw new Exception(error);
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerEntregas metodo realizaConfirmacion");
					q.printStackTrace();
				}
			}
		}
		else{
			resultado = 2;
			System.out.println("No pude conectar a la BD, ManagerEntregas, metodo realizaConfirmacion");
		}
		return resultado;
	}


	public ResultSet dameOrdenesPendientes() throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT * FROM orden_trabajo WHERE estatus = 1");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerProduccion, dameOrdenesPendientes ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerProduccion, dameOrdenesPendientes ");
				e.printStackTrace();
			}
		}
		return rs;
	}

	public ResultSet dameOrdenesCanceladas() throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT * FROM orden_trabajo WHERE estatus = 0 ORDER BY fechaBaja DESC");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerProduccion, dameOrdenesPendientes ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerProduccion, dameOrdenesPendientes ");
				e.printStackTrace();
			}
		}
		return rs;
	}


	public ResultSet dameOrdenesFiniquitadas(String fecha) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT * FROM orden_trabajo WHERE fechaConfirmacion like '"+fecha+"' AND estatus = 2");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerProduccion, dameOrdenesPendientes ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerProduccion, dameOrdenesPendientes ");
				e.printStackTrace();
			}
		}
		return rs;
	}

	public ResultSet dameDatosOrdenProductos(String clave) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT * FROM productos_orden_trabajo WHERE clave_Orden= "+cambiaAInt(clave)+" AND tipo = 1");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerProduccion, dameDatosOrdenProductos ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerProduccion, dameDatosOrdenProductos ");
				e.printStackTrace();
			}
		}
		return rs;
	}


	public ResultSet dameDatosOrdenProductosMP(String clave) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT * FROM mp_orden_trabajo WHERE clave_Orden= "+cambiaAInt(clave));
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerProduccion, dameDatosOrdenProductosMP ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerProduccion, dameDatosOrdenProductosMP ");
				e.printStackTrace();
			}
		}
		return rs;
	}


	public int dameCantidadProdMP() throws SQLException, Exception{
		ResultSet rs = null;
		int cantidad = 0;
		try{
			String query = ("SELECT COUNT(ID_Pro)AS Total FROM productos WHERE materiaPrima = 1 AND  activo = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				cantidad = rs.getInt("Total");
			}
			rs.close();
			stmt.close();

		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, dameCantidadProdMP ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, dameCantidadProdMP ");
			e.printStackTrace();
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerProduccion metodo dameCantidadProdMP");
				q.printStackTrace();
			}
		}
		return cantidad;
	}

	public synchronized String  add_Orden_Trabajo(String fechaAlta, String[ ] ArrayCantidad, String[ ] ArrayProducto, String observaciones, String usuario) throws SQLException, Exception {
//System.out.println("Empiezo");
		con = new ConexionBD();
		String resultado = "OK";
		boolean yaNoHay = false;
		if (con.miConnection != null) {
			try {
				con.cancelaAutoCommit();
				ResultSet rs= null;
				tiempo = new TimeStamp();
//System.out.println("Voy a guardar Venta");
				PreparedStatement updateOrdenTrabajo;
				updateOrdenTrabajo = con.miConnection.prepareStatement("insert into orden_trabajo values(?,?,?,?,?,?,?,?,?,?);");
				updateOrdenTrabajo.setNull(1, java.sql.Types.INTEGER);
				updateOrdenTrabajo.setString(2, fechaAlta);
				updateOrdenTrabajo.setString(3, usuario);
				updateOrdenTrabajo.setString(4, observaciones);
				updateOrdenTrabajo.setNull(5, java.sql.Types.DATE);
				updateOrdenTrabajo.setString(6, "");
				updateOrdenTrabajo.setNull(7, java.sql.Types.DATE);
				updateOrdenTrabajo.setString(8, "");
				updateOrdenTrabajo.setString(9,"");
				updateOrdenTrabajo.setInt(10,1);
				updateOrdenTrabajo.execute();
				updateOrdenTrabajo.close();
		// Obtengo la claveDelaVenta
				String query = ("SELECT MAX(clave)AS ultima FROM orden_trabajo WHERE estatus = 1");
				Statement stmt = con.creaStatement();
				ResultSet rs3 = stmt.executeQuery(query);
				String ordenTrabajo = "";
				while (rs3.next()){
					ordenTrabajo = rs3.getString("ultima");
					resultado = resultado +"**"+rs3.getString("ultima");
				}
				rs3.close();
				stmt.close();
//System.out.println("Guardo cada Producto");
	// Comienzo a guardar los productos vendidos correspondientes:
				if(ArrayProducto != null){
					for (int i = 0; i<ArrayProducto.length; i++){
						if(!(ArrayProducto[i].equalsIgnoreCase("")) ){
							PreparedStatement updateProductosOrdenTrabajo;
							updateProductosOrdenTrabajo = con.miConnection.prepareStatement("insert into productos_orden_trabajo values(?,?,?,?);");
							updateProductosOrdenTrabajo.setInt(1, cambiaAInt(ordenTrabajo));
							updateProductosOrdenTrabajo.setInt(2, cambiaAInt(ArrayProducto[i]));
							updateProductosOrdenTrabajo.setDouble(3, cambiaADouble(ArrayCantidad[i]));
							updateProductosOrdenTrabajo.setInt(4, 1);
							updateProductosOrdenTrabajo.execute();
							updateProductosOrdenTrabajo.close();
						}
					}
				}
			con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				resultado = "ERROR SQL";
				sqle.printStackTrace();
				System.out.println(	"Error SQL clase ManagerProduccion, método add_Orden_Trabajo"+sqle);
			}
			catch (Exception q){
				con.realizaRollback();
				resultado = "ERROR";
				q.printStackTrace();
				System.out.println(	"Error clase ManagerProduccion, método add_Orden_Trabajo"+q);
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerProduccion metodo add_Orden_Trabajo");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}



  /**
  * El método baja_Orden se encarga de colocar un 0 en el campo "activo" del Cliente en la Base de Datos, para realizar una Baja lógica del Cliente correspondiente.
  *  	@param 	rfc		String con el RFC del Cliente solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
	public int baja_Orden(String clave, String usuario) throws SQLException, Exception {
		ResultSet rs = null;
		int bandera = 0;
		con = new ConexionBD();
		try  {
			String fechaDeHoy = dameFechaHoyBD();
			PreparedStatement bajaOrden;
			bajaOrden = con.miConnection.prepareStatement("UPDATE orden_trabajo SET fechaBaja = ?, usuarioBaja = ?, estatus = ?  WHERE clave = ?  AND estatus = 1");
			bajaOrden.setString(1, fechaDeHoy);
			bajaOrden.setString(2, usuario);
			bajaOrden.setInt(3, 0);
			bajaOrden.setInt(4, cambiaAInt(clave));
			bajaOrden.execute();
			bajaOrden.close();
			bandera = 1;
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerProduccion metodo baja_Orden");
				q.printStackTrace();
			}
		}
		return bandera;
	}

/**
* El Método datosOrdenImp nos regresa los datos extras de la impresion de una venta tales como subtotal, iva, total y observaciones
* @return ResultSet correspondiente al listado de datos extras de una venta.
*/
	public ResultSet datosOrdenImp(String claveOrden){
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM orden_trabajo WHERE clave = "+claveOrden +" AND estatus = 1 LIMIT 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, datosOrdenImp ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, datosOrdenImp ");
			e.printStackTrace();
		}
		return rs;
	}



	public ResultSet DameProductosOrdenAlta(String clave) throws SQLException,Exception{
		ResultSet rs = null;
		try{
			String query = "SELECT productos_orden_trabajo.*, productos.descripcion FROM productos_orden_trabajo, productos WHERE productos_orden_trabajo.clave_Orden = "+cambiaAInt(clave)+" AND productos.ID_Pro = productos_orden_trabajo.clave_Producto";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, DameProductosOrdenAlta ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, DameProductosOrdenAlta ");
			e.printStackTrace();
		}
		return rs;
	}


	public ResultSet dameOrdenesTrabajoActivos() throws SQLException,Exception{
		ResultSet rs = null;
		try{
			String query = "SELECT clave, fechaAlta, usuarioAlta FROM orden_trabajo WHERE estatus = 1";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProduccion, dameOrdenesTrabajoActivos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProduccion, dameOrdenesTrabajoActivos ");
			e.printStackTrace();
		}
		return rs;
	}

	public boolean existeOrden(String clave) throws SQLException, Exception    {
		Statement st = null;
		ResultSet rs= null;
		boolean bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.miConnection.createStatement();
				rs = st.executeQuery("SELECT clave FROM orden_trabajo WHERE clave = "+cambiaAInt(clave)+" AND estatus = 1");
				while(rs.next()){
					if(rs.getString("clave").equalsIgnoreCase(clave)){
						bandera = true; //realiza comparación con la base de datos
					}
				}
				rs.close();
				st.close();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerProduccion metodo existe2");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}


	public void cierraConexion ()throws SQLException, Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ManagerProduccion, cierraConexion ");
				q.printStackTrace();
			}
		}
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