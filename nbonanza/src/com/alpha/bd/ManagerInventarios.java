package com.alpha.bd;

import com.alpha.bd.DateStamp;
import com.alpha.bd.TimeStamp;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.util.Calendar;
import java.util.TimeZone;
import java.io.InputStream;
import java.io.FileInputStream;
import java.math.*;

/**
* La clase "ManagerInventarios" es la encargada de administrar los datos correspondientes a los Inventarios como son Altas, Consultas, Actualizaciones, etc.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004)
*/

public class ManagerInventarios {

	String error;
	private static ConexionBD con = null;
	private static ConexionBD con2 = null;
	private DateStamp dt= null;
	protected TimeStamp tiempo = null;
	protected final static String PORMERMA = "0.5";

/**
* El método ManagerInventarios es el constructor vacio de la clase.
*/

  public ManagerInventarios()   { }

	// 0--> Realizada, 1--> No es necesaria, 2--> Fallo al realizar autoMerma
	public synchronized int autoMerma( )throws SQLException, Exception{
		int resultado = 0;
		dt = new DateStamp();
		String fecha = dt.obtenDatos();
		String mesMerma = fecha.substring(5,7);
		String anioMerma = fecha.substring(0,4);
		con = new ConexionBD();
		if(con != null){
			try{
				String query1 = "SELECT activo FROM autoMerma WHERE anio = "+cambiaAInt(anioMerma)+" AND mes = "+cambiaAInt(mesMerma)+" AND activo = 1 LIMIT 1";
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query1);
				while(rs.next()){
					if(rs.getInt("activo") == 1){
						resultado = 1;
					}
				}
				rs.close();
				stmt.close();
				if(resultado != 1){
					if(!procesoMermaAutomatica(mesMerma, anioMerma, fecha, con)){
						resultado = 2;
					}
				}
			}
			catch (SQLException sqle){
				con.realizaRollback();
				resultado = 2;
				System.out.println("ERROR SQL en metodo autoMerma, clase ManagerInventarios.");
				sqle.printStackTrace();
			}
			catch (Exception e){
				con.realizaRollback();
				resultado = 2;
				System.out.println("Excepcion en metodo autoMerma, clase ManagerInventarios.");
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					q.printStackTrace();
				}
			}
		}
		else{
			resultado = 2;
		}
System.out.println("Resultado Final proceso AutoMerma: " +resultado);
		return resultado;
	}

	public static void main (String [ ] args)throws Exception{
		ManagerInventarios mi = new ManagerInventarios();
		mi.autoMerma();
	}

	public synchronized boolean procesoMermaAutomatica(String mesMerma, String anioMerma, String fechaG,ConexionBD con)throws SQLException, Exception{
		boolean exito = true;
		if(con != null){
			con.cancelaAutoCommit();
			try{
				tiempo = new TimeStamp();
				String hoy = tiempo.date;
				String hora = tiempo.time;
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES modificainv  WRITE, productos WRITE, mermas WRITE");
				statement.close();
				String queryInicial = "SELECT ID_Pro, invTienda, invAlmacen FROM productos WHERE tipoPro = 1 AND activo = 1";
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(queryInicial);
				while(rs.next()){
					if(rs.getDouble("invTienda") > 0.00){
						BigDecimal cantidadActual = new BigDecimal(rs.getString("invTienda"));
						BigDecimal porcentajeMerma = new BigDecimal(PORMERMA);
						BigDecimal porTotal = new BigDecimal("100.00");
						BigDecimal cantidadARestar = new BigDecimal("0.00");
						BigDecimal nuevaCantidad = new BigDecimal("0.00");
						cantidadARestar = (porcentajeMerma.multiply(cantidadActual, new MathContext(100))).divide(porTotal, new MathContext(100));
						nuevaCantidad = cantidadActual.subtract(cantidadARestar);
						nuevaCantidad = nuevaCantidad.setScale(3, RoundingMode.HALF_UP);
						PreparedStatement altaMerma;
						altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?,?,?,?,?,?);");
						altaMerma.setInt(1, rs.getInt("ID_Pro"));
						altaMerma.setString(2, "Sistema");
						altaMerma.setString(3, hoy);
						altaMerma.setString(4, hora);
						altaMerma.setDouble(5, cambiaADouble(cantidadARestar.toString()));
						altaMerma.setDouble(6, cambiaADouble(cantidadActual.toString()));
						altaMerma.setDouble(7, cambiaADouble(nuevaCantidad.toString()));
						altaMerma.setString(8,"Automerma Mensual de: " +PORMERMA+"%");
						altaMerma.setInt(9,1);
						altaMerma.execute();
						altaMerma.close();
						PreparedStatement updateModInventario;
						updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
						updateModInventario.setNull(1, java.sql.Types.INTEGER);
						updateModInventario.setInt(2, rs.getInt("ID_Pro"));
						updateModInventario.setString(3, "Sistema");
						updateModInventario.setString(4, hoy);
						updateModInventario.setString(5, hora);
						updateModInventario.setDouble(6,  cambiaADouble(cantidadActual.toString()));
						updateModInventario.setDouble(7,  cambiaADouble(nuevaCantidad.toString()));
						updateModInventario.setString(8,  "Automerma Mensual de: " +PORMERMA+"%");
						updateModInventario.setInt(9, 2);
						updateModInventario.setInt(10, 1);
						updateModInventario.execute();
						updateModInventario.close();
						String updateexistencia = "UPDATE productos SET invTienda = "+cambiaADouble(nuevaCantidad.toString())+" WHERE ID_Pro = "+rs.getInt("ID_Pro")+" AND activo = 1";
						stmt = con.creaStatement();
						stmt.execute(updateexistencia);
						stmt.close();
					}
					if(rs.getDouble("invAlmacen") > 0.00){
						BigDecimal cantidadActual = new BigDecimal(rs.getString("invAlmacen"));
						BigDecimal porcentajeMerma = new BigDecimal(PORMERMA);
						BigDecimal porTotal = new BigDecimal("100.00");
						BigDecimal cantidadARestar = new BigDecimal("0.00");
						BigDecimal nuevaCantidad = new BigDecimal("0.00");
						cantidadARestar = (porcentajeMerma.multiply(cantidadActual, new MathContext(100))).divide(porTotal, new MathContext(100));
						nuevaCantidad = cantidadActual.subtract(cantidadARestar);
						nuevaCantidad = nuevaCantidad.setScale(3, RoundingMode.HALF_UP);
						PreparedStatement altaMerma;
						altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?,?,?,?,?,?);");
						altaMerma.setInt(1, rs.getInt("ID_Pro"));
						altaMerma.setString(2, "Sistema");
						altaMerma.setString(3, hoy);
						altaMerma.setString(4, hora);
						altaMerma.setDouble(5, cambiaADouble(cantidadARestar.toString()));
						altaMerma.setDouble(6, cambiaADouble(cantidadActual.toString()));
						altaMerma.setDouble(7, cambiaADouble(nuevaCantidad.toString()));
						altaMerma.setString(8,"Automerma Mensual de: " +PORMERMA+"%");
						altaMerma.setInt(9,2);
						altaMerma.execute();
						altaMerma.close();
						PreparedStatement updateModInventario;
						updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
						updateModInventario.setNull(1, java.sql.Types.INTEGER);
						updateModInventario.setInt(2, rs.getInt("ID_Pro"));
						updateModInventario.setString(3, "Sistema");
						updateModInventario.setString(4, hoy);
						updateModInventario.setString(5, hora);
						updateModInventario.setDouble(6,  cambiaADouble(cantidadActual.toString()));
						updateModInventario.setDouble(7,  cambiaADouble(nuevaCantidad.toString()));
						updateModInventario.setString(8,  "Automerma Mensual de: " +PORMERMA+"%");
						updateModInventario.setInt(9, 2);
						updateModInventario.setInt(10, 2);
						updateModInventario.execute();
						updateModInventario.close();
						String updateexistencia = "UPDATE productos SET invAlmacen = "+cambiaADouble(nuevaCantidad.toString())+" WHERE ID_Pro = "+rs.getInt("ID_Pro")+" AND activo = 1";
						stmt = con.creaStatement();
						stmt.execute(updateexistencia);
						stmt.close();
					}
				}
				rs.close();
				stmt.close();
				statement = con.creaStatement();
				statement.execute("UNLOCK TABLES");
				statement.close();
				PreparedStatement updateMermaAutomatica;
				updateMermaAutomatica = con.miConnection.prepareStatement ("insert into automerma  values(?,?,?,?)");
				updateMermaAutomatica.setInt(1, cambiaAInt(anioMerma));
				updateMermaAutomatica.setInt(2, cambiaAInt(mesMerma));
				updateMermaAutomatica.setString(3, fechaG);
				updateMermaAutomatica.setInt(4, 1);
				updateMermaAutomatica.execute();
				updateMermaAutomatica.close();
				con.realizaCommit();
			}
			catch (SQLException sqle){
				con.realizaRollback();
				exito = false;
				System.out.println("ERROR SQL en metodo procesoMermaAutomatica, clase ManagerInventarios.");
				sqle.printStackTrace();
			}
			catch (Exception e){
				con.realizaRollback();
				exito = false;
				System.out.println("Excepcion en metodo procesoMermaAutomatica, clase ManagerInventarios.");
				e.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
				}
				catch (Exception q){
					q.printStackTrace();
				}
			}
		}
		else{
			exito = false;
			System.out.println("No pude iniciar conexion a la BD ManagerInventarios, metodo procesoMermaAutomatica");
		}
		return exito;
	}







// REVISADAS...

	public void cierraConexion() throws SQLException, Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerInventarios");
				q.printStackTrace();
			}
		}
	}

	public void cierraConexion2() throws SQLException, Exception{
		if(con2 != null){
			try{
				con2.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion2 de ManagerInventarios");
				q.printStackTrace();
			}
		}
	}

  public ResultSet dameExistenciaProducto(String claveProducto) throws SQLException, Exception {
          ResultSet rs = null;
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT descripcion, invTienda, invAlmacen, tipoPro FROM productos WHERE activo = 1 AND ID_Pro = "+cambiaAInt(claveProducto)+" LIMIT 1");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          }
          catch (SQLException sqle) {
			 sqle.printStackTrace();
            error = "SQLException: Could not execute the query dameExistenciaProducto.";
            throw new SQLException(error);
          }
          catch (Exception e) {
			 e.printStackTrace();
            error = "An exception occured while retrieving dameExistenciaProducto.";
            throw new Exception(error);
          }
          return rs;
	  }


	 public synchronized int traspasaInventarios (String clave, String tipoT, String incrementa) throws SQLException, Exception{
		int exito = 1;
		int unicompra = 0;
		boolean huboTransaccionModificadora = false;
		 con = new ConexionBD();
		 if(con != null){
		 	try{
			 con.cancelaAutoCommit();
// PONGO UN CANDADO DE ESCRITURA A TABLA DE PRODUCTOS
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES productos WRITE");
				statement.close();
// PRIMERO PRODUCTO A VENTA...
				String queryInvActual = "SELECT invTienda, invAlmacen, uniCompra FROM productos WHERE ID_Pro = "+cambiaAInt(clave) +" AND activo = 1";
				statement=con.creaStatement();
				ResultSet rsActual = statement.executeQuery(queryInvActual);
				while(rsActual.next()){
					if(tipoT.equals("1")){ // Almacen a Tienda
						if(rsActual.getInt("uniCompra") == 1){ // Es por Enteros
							if(rsActual.getInt("invAlmacen") < cambiaAInt(dameEnteros(incrementa))){
								huboTransaccionModificadora = true;
							}
						}
						else{ // Es por decimales
							if(rsActual.getDouble("invAlmacen") < cambiaADouble(incrementa)){
								huboTransaccionModificadora = true;
							}
						}
					}
					else{ // De Tienda a Almacen
						if(rsActual.getInt("uniCompra") == 1){ // Es por Enteros
							if(rsActual.getInt("invTienda") < cambiaAInt(dameEnteros(incrementa))){
								huboTransaccionModificadora = true;
							}
						}
						else{ // Es por decimales
							if(rsActual.getDouble("invTienda") < cambiaADouble(incrementa)){
								huboTransaccionModificadora = true;
							}
						}
					}
				}
				rsActual.close();
				statement.close();
				if(!huboTransaccionModificadora){
					if(tipoT.equals("1")){ // Almacen a Tienda
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET invTienda = (invTienda + ?), invAlmacen = (invAlmacen - ?)  WHERE ID_Pro = ?");
						updateInventario.setDouble(1,  cambiaADouble(incrementa));
						updateInventario.setDouble(2,  cambiaADouble(incrementa));
						updateInventario.setInt(3, cambiaAInt(clave));
						updateInventario.execute();
						updateInventario.close();
					}
					else{
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET invTienda = (invTienda - ?), invAlmacen = (invAlmacen + ?)  WHERE ID_Pro = ?");
						updateInventario.setDouble(1,  cambiaADouble(incrementa));
						updateInventario.setDouble(2,  cambiaADouble(incrementa));
						updateInventario.setInt(3, cambiaAInt(clave));
						updateInventario.execute();
						updateInventario.close();
					}
				}
				else{
					exito = 2;
				}
				statement = con.creaStatement();
				statement.execute("UNLOCK TABLES");
				statement.close();
				con.realizaCommit();
			 }
			 catch(SQLException sqle){
				 exito = 0;
				 con.realizaRollback();
		 		System.out.println("Excepcion SQL en bean ManagerInventarios, Metodo: traspasaInventarios.\n");
		 		sqle.printStackTrace();
			 }
			 catch(Exception e){
				 exito = 0;
		 		con.realizaRollback();
		 		System.out.println("Excepcion en bean ManagerInventarios, Metodo: traspasaInventarios.\n");
		 		e.printStackTrace();
	 		}
			 finally{
				 if(con != null){
					 try{
						 con.habilitaAutoCommit();
						 con.cierraConexion();
					 }
					 catch (Exception e2){
						 e2.printStackTrace();
					 }
				 }
			 }
		 }
		 else{
			 exito = 0;
	 		System.out.println("Excepcion en bean ManagerInventarios, Metodo: update_Producto_Inventario.  3\n");
		 }
			 return exito;
 	}



	 public synchronized int update_Producto_Inventario (String clave, String existenciaOriT, String invTienda, String existenciaOriA, String invAlmacen,  String usuario, String causa) throws SQLException, Exception{
		int exito = 1;
		tiempo = new TimeStamp();
		String hoy = tiempo.date;
		String hora = tiempo.time;
		int unicompra = 0;
		boolean huboTransaccionModificadora = false;
		 con = new ConexionBD();
		 if(con != null){
		 	try{
			 con.cancelaAutoCommit();
				// PONGO UN CANDADO DE ESCRITURA A TABLA DE PRODUCTOS
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES productos WRITE, modificainv WRITE");
				statement.close();
			// PRIMERO PRODUCTO A VENTA...
				String queryInvActual = "SELECT invTienda, invAlmacen, uniCompra FROM productos WHERE ID_Pro = "+cambiaAInt(clave) +" AND activo = 1";
				statement=con.creaStatement();
				ResultSet rsActual = statement.executeQuery(queryInvActual);
				while(rsActual.next()){
					unicompra = rsActual.getInt("unicompra");
					if(rsActual.getInt("uniCompra") == 1){
						if(rsActual.getInt("invTienda") != cambiaAInt(dameEnteros(existenciaOriT))){
							huboTransaccionModificadora = true;
						}
						if(rsActual.getInt("invAlmacen") != cambiaAInt(dameEnteros(existenciaOriA))){
							huboTransaccionModificadora = true;
						}
					}
					else{
						if(rsActual.getDouble("invTienda") != cambiaADouble(existenciaOriT)){
							huboTransaccionModificadora = true;
						}
						if(rsActual.getDouble("invAlmacen") != cambiaADouble(existenciaOriA)){
							huboTransaccionModificadora = true;
						}
					}
				}
				rsActual.close();
				statement.close();
				if(!huboTransaccionModificadora){
					if(! (invTienda.equalsIgnoreCase(existenciaOriT)) ||  !( invAlmacen.equalsIgnoreCase(existenciaOriA))){
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET invTienda =  ?, invAlmacen = ?  WHERE ID_Pro = ?");
						updateInventario.setDouble(1,  cambiaADouble(invTienda));
						updateInventario.setDouble(2,  cambiaADouble(invAlmacen));
						updateInventario.setInt(3, cambiaAInt(clave));
						updateInventario.execute();
						if(unicompra == 1){ // HABLAMOS DE UN ENTERO.
							if(cambiaAInt(dameEnteros(existenciaOriT)) !=  cambiaAInt(dameEnteros(invTienda))){
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(existenciaOriT));
								updateModInventario.setDouble(7,  cambiaADouble(invTienda));
								updateModInventario.setString(8, causa);
								updateModInventario.setInt(9, 1);
								updateModInventario.setInt(10, 1);
								updateModInventario.execute();
							}
							if(cambiaAInt(dameEnteros(existenciaOriA)) != cambiaAInt(dameEnteros(invAlmacen))){
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(existenciaOriA));
								updateModInventario.setDouble(7,  cambiaADouble(invAlmacen));
								updateModInventario.setString(8, causa);
								updateModInventario.setInt(9, 1);
								updateModInventario.setInt(10, 2);
								updateModInventario.execute();
							}
						}
						else{ // Otra unidad con decimales:
							if(cambiaADouble(existenciaOriT) !=  cambiaADouble(invTienda)){
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(existenciaOriT));
								updateModInventario.setDouble(7,  cambiaADouble(invTienda));
								updateModInventario.setString(8, causa);
								updateModInventario.setInt(9, 1);
								updateModInventario.setInt(10, 1);
								updateModInventario.execute();
							}
							if(cambiaADouble(existenciaOriA) != cambiaADouble(invAlmacen)){
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(existenciaOriA));
								updateModInventario.setDouble(7,  cambiaADouble(invAlmacen));
								updateModInventario.setString(8, causa);
								updateModInventario.setInt(9, 1);
								updateModInventario.setInt(10, 2);
								updateModInventario.execute();
							}
						}
					}
				}
				else{
					exito = 2;
				}
				statement = con.creaStatement();
				statement.execute("UNLOCK TABLES");
				statement.close();
				con.realizaCommit();
			 }
			 catch(SQLException sqle){
				 exito = 0;
				 con.realizaRollback();
		 		System.out.println("Excepcion SQL en bean ManagerInventarios, Metodo: update_Producto_Inventario.\n");
		 		sqle.printStackTrace();
			 }
			 catch(Exception e){
				 exito = 0;
		 		con.realizaRollback();
		 		System.out.println("Excepcion en bean ManagerInventarios, Metodo: update_Producto_Inventario.\n");
		 		e.printStackTrace();
	 		}
			 finally{
				 if(con != null){
					 try{
						 con.habilitaAutoCommit();
						 con.cierraConexion();
					 }
					 catch (Exception e2){
						 e2.printStackTrace();
					 }
				 }
			 }
		 }
		 else{
			 exito = 0;
	 		System.out.println("Excepcion en bean ManagerInventarios, Metodo: update_Producto_Inventario.  3\n");
		 }
			 return exito;
 	}


/**
* El método existe verifica que el producto solicitado existe dentro de nuestra Base de Datos.
*  	@param 	plu  		String con el plu del producto solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

	public boolean existe(String idProducto) throws SQLException, Exception   {
		Statement st = null;
		ResultSet rs= null;
		boolean  bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT ID_Pro FROM productos WHERE ID_Pro = "+cambiaAInt(idProducto)+" AND activo = 1");
				while(rs.next()){
					if(rs.getString("ID_Pro").equalsIgnoreCase(idProducto)){
						bandera = true;
					}
				}
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerInventarios metodo existe");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}


/**
* El método dameProductos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Productos que se encuentren activos.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos.
*/
	  public ResultSet dameProductos() throws SQLException, Exception {
          ResultSet rs = null;
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT ID_Pro, descripcion, tipoPro, invTienda, invAlmacen FROM productos WHERE activo = 1 ORDER BY descripcion");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameProductos.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameProductos.";
            throw new Exception(error);
          }
          return rs;
	  }


/**
* El método update_Inventarios se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public synchronized int update_Inventarios(String[ ] clave,  String[ ] invTienda, String[ ] originalT, String[ ] invAlmacen, String[ ] originalA, String usuario, String causa) throws SQLException, Exception {
		tiempo = new TimeStamp();
		int fin = 0;
		String hoy = tiempo.date;
		String hora = tiempo.time;
		String [ ] unicompra = new String[clave.length ];
		boolean huboTransaccionModificadora = false;
		ResultSet rs = null;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
			con.cancelaAutoCommit();
			// PONGO UN CANDADO DE ESCRITURA A TABLA DE PRODUCTOS
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES productos WRITE, modificaInv WRITE");
				statement.close();
			// Verifico que del momento en que desplegue la info de inventario al que me mandan modificacion no hubiese otra transaccion que modificara la cantidad de producto existente.
			// PRIMERO PRODUCTO A VENTA...
				String queryInvActual = "SELECT ID_Pro, uniCompra, invTienda, invAlmacen FROM productos WHERE activo = 1 ORDER BY productos.ID_Pro";
				statement=con.creaStatement();
				ResultSet rsActual = statement.executeQuery(queryInvActual);
				for (int i = 0; i<clave.length; i++){
//System.out.println("originalT: "+originalT[i]);
//System.out.println("invTienda: "+invTienda[i]);
//System.out.println("originalA: "+originalA[i]);
//System.out.println("invAlmacen: "+invAlmacen[i]);
					rsActual.beforeFirst();
					while(rsActual.next()){
						unicompra[i] = rsActual.getString("uniCompra");
						if(rsActual.getString("ID_Pro").equalsIgnoreCase(clave[i])){
							if(rsActual.getInt("uniCompra") == 1){
								if(rsActual.getInt("invTienda") != cambiaAInt(dameEnteros(originalT[i]))){
									huboTransaccionModificadora = true;
								}
								if(rsActual.getInt("invAlmacen") != cambiaAInt(dameEnteros(originalA[i]))){
									huboTransaccionModificadora = true;
								}
							}
							else{
								if(rsActual.getDouble("invTienda") != cambiaADouble(originalT[i])){
									huboTransaccionModificadora = true;
								}
								if(rsActual.getDouble("invAlmacen") != cambiaADouble(originalA[i])){
									huboTransaccionModificadora = true;
								}
							}
						}
					}
				}
				rsActual.close();
				statement.close();
// Si no hubo Transaccion que modificara..., actualizo.
// Primero producto tal cual.
				if(!huboTransaccionModificadora){
					for (int i = 0; i<clave.length; i++){
						if(! (originalT[i].equalsIgnoreCase(invTienda[i])) ||  !( originalA[i].equalsIgnoreCase(invAlmacen[i]))){
							PreparedStatement updateInventario;
							updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET invTienda =  ?, invAlmacen = ?  WHERE ID_Pro = ?");
							updateInventario.setDouble(1,  cambiaADouble(invTienda[i]));
							updateInventario.setDouble(2,  cambiaADouble(invAlmacen[i]));
							updateInventario.setInt(3, cambiaAInt(clave[i]));
							updateInventario.execute();
							updateInventario.close();
							if(unicompra.equals("1")){ // HABLAMOS DE UN ENTERO.
								if(cambiaAInt(dameEnteros(originalT[i])) !=  cambiaAInt(dameEnteros(invTienda[i]))){
									PreparedStatement updateModInventario;
									updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
									updateModInventario.setNull(1, java.sql.Types.INTEGER);
									updateModInventario.setInt(2, cambiaAInt(clave[i]));
									updateModInventario.setString(3, usuario);
									updateModInventario.setString(4, hoy);
									updateModInventario.setString(5, hora);
									updateModInventario.setDouble(6,  cambiaADouble(originalT[i]));
									updateModInventario.setDouble(7,  cambiaADouble(invTienda[i]));
									updateModInventario.setString(8, causa);
									updateModInventario.setInt(9, 1);
									updateModInventario.setInt(10, 1);
									updateModInventario.execute();
								}
								if(cambiaAInt(dameEnteros(originalA[i])) != cambiaAInt(dameEnteros(invAlmacen[i]))){
									PreparedStatement updateModInventario;
									updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
									updateModInventario.setNull(1, java.sql.Types.INTEGER);
									updateModInventario.setInt(2, cambiaAInt(clave[i]));
									updateModInventario.setString(3, usuario);
									updateModInventario.setString(4, hoy);
									updateModInventario.setString(5, hora);
									updateModInventario.setDouble(6,  cambiaADouble(originalA[i]));
									updateModInventario.setDouble(7,  cambiaADouble(invAlmacen[i]));
									updateModInventario.setString(8, causa);
									updateModInventario.setInt(9, 1);
									updateModInventario.setInt(10, 2);
									updateModInventario.execute();
								}
							}
							else{
								if(cambiaADouble(originalT[i]) !=  cambiaADouble(invTienda[i])){
									PreparedStatement updateModInventario;
									updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
									updateModInventario.setNull(1, java.sql.Types.INTEGER);
									updateModInventario.setInt(2, cambiaAInt(clave[i]));
									updateModInventario.setString(3, usuario);
									updateModInventario.setString(4, hoy);
									updateModInventario.setString(5, hora);
									updateModInventario.setDouble(6,  cambiaADouble(originalT[i]));
									updateModInventario.setDouble(7,  cambiaADouble(invTienda[i]));
									updateModInventario.setString(8, causa);
									updateModInventario.setInt(9, 1);
									updateModInventario.setInt(10, 1);
									updateModInventario.execute();
								}
								if(cambiaADouble(originalA[i]) != cambiaADouble(invAlmacen[i])){
									PreparedStatement updateModInventario;
									updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
									updateModInventario.setNull(1, java.sql.Types.INTEGER);
									updateModInventario.setInt(2, cambiaAInt(clave[i]));
									updateModInventario.setString(3, usuario);
									updateModInventario.setString(4, hoy);
									updateModInventario.setString(5, hora);
									updateModInventario.setDouble(6,  cambiaADouble(originalA[i]));
									updateModInventario.setDouble(7,  cambiaADouble(invAlmacen[i]));
									updateModInventario.setString(8, causa);
									updateModInventario.setInt(9, 1);
									updateModInventario.setInt(10, 2);
									updateModInventario.execute();
								}
							}
						}
					}
				}
				else{
					fin = 2;
				}
				statement = con.creaStatement();
				statement.execute("UNLOCK TABLES");
				statement.close();
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				fin = 1;
		 		con.realizaRollback();
		 		sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerInventarios---update_Inventarios";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = 1;
		 		con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
				 	con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerInventarios metodo update_Inventarios");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida. En ManagerInventarios----update_Inventarios";
			throw new Exception(error);
		}
	 return fin;
	}


/**
* El método add_Mermas se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public synchronized  int add_Mermas(String clave, String invTienda, String invAlmacen, String usuario, String causa) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		int exito = 1;
		tiempo = new TimeStamp();
		String hoy = tiempo.date;
		String hora = tiempo.time;
		String laExistenciaActualT = "0";
		String laExistenciaActualA = "0";
		int uniCompra = 0;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				con.cancelaAutoCommit();
			// Bloqueo tablas para asegurar Transaccion
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES modificainv  WRITE, productos WRITE, mermas WRITE");
				statement.close();
				if(cambiaADouble(invTienda) > 0 || cambiaADouble(invAlmacen)>0){
					boolean sobrePasa = false;
					String queryVerificador = "SELECT invTienda, invAlmacen, uniCompra FROM productos  WHERE ID_Pro = "+cambiaAInt(clave) +" AND activo =1";
					statement = con.creaStatement();
					ResultSet verifica = statement.executeQuery(queryVerificador);
					while(verifica.next()){
						uniCompra = verifica.getInt("uniCompra");
						if(verifica.getDouble("invTienda") < cambiaADouble(invTienda)){
							sobrePasa = true;
						}
						else{
							laExistenciaActualT = verifica.getString("invTienda");
						}
						if(verifica.getDouble("invAlmacen") < cambiaADouble(invAlmacen)){
							sobrePasa = true;
						}
						else{
							laExistenciaActualA = verifica.getString("invAlmacen");
						}
					}
					verifica.close();
					statement.close();
					if(!sobrePasa){
//System.out.println("laExistenciaActualT: "+laExistenciaActualT);
//System.out.println("invTienda: "+invTienda);
//System.out.println("laExistenciaActualA: "+laExistenciaActualA);
//System.out.println("invAlmacen: "+invAlmacen);
						if(uniCompra == 1) { // Hablamos de Enteros.
							if(cambiaAInt(dameEnteros(invTienda)) > 0){
								BigDecimal actual = new BigDecimal(laExistenciaActualT);
								actual = actual.subtract(new BigDecimal(invTienda));
								actual = actual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement altaMerma;
								altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?,?,?,?,?,?);");
								altaMerma.setInt(1, cambiaAInt(clave));
								altaMerma.setString(2, usuario);
								altaMerma.setString(3, hoy);
								altaMerma.setString(4, hora);
								altaMerma.setDouble(5, cambiaADouble(invTienda));
								altaMerma.setDouble(6, cambiaADouble(laExistenciaActualT));
								altaMerma.setDouble(7, cambiaADouble(actual.toString()));
								altaMerma.setString(8,causa);
								altaMerma.setInt(9,1);
								altaMerma.execute();
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(laExistenciaActualT));
								updateModInventario.setDouble(7,  cambiaADouble(actual.toString()));
								updateModInventario.setString(8,  causa);
								updateModInventario.setInt(9, 2);
								updateModInventario.setInt(10, 1);
								updateModInventario.execute();
								String updateexistencia = "UPDATE productos SET invTienda = "+cambiaAInt(dameEnteros(actual.toString()))+" WHERE ID_Pro = "+cambiaAInt(clave)+" AND activo = 1";
								Statement stmt = con.creaStatement();
								stmt.execute(updateexistencia);
								stmt.close();
							}
							if(cambiaAInt(dameEnteros(invAlmacen)) > 0) {
								BigDecimal actual = new BigDecimal(laExistenciaActualA);
								actual = actual.subtract(new BigDecimal(invAlmacen));
								actual = actual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement altaMerma;
								altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?,?,?,?,?,?);");
								altaMerma.setInt(1, cambiaAInt(clave));
								altaMerma.setString(2, usuario);
								altaMerma.setString(3, hoy);
								altaMerma.setString(4, hora);
								altaMerma.setDouble(5, cambiaADouble(invAlmacen));
								altaMerma.setDouble(6, cambiaADouble(laExistenciaActualA));
								altaMerma.setDouble(7, cambiaADouble(actual.toString()));
								altaMerma.setString(8,causa);
								altaMerma.setInt(9,2);
								altaMerma.execute();
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(laExistenciaActualA));
								updateModInventario.setDouble(7,  cambiaADouble(actual.toString()));
								updateModInventario.setString(8,  causa);
								updateModInventario.setInt(9, 2);
								updateModInventario.setInt(10, 2);
								updateModInventario.execute();
								String updateexistencia = "UPDATE productos SET invAlmacen = "+cambiaAInt(dameEnteros(actual.toString()))+" WHERE ID_Pro = "+cambiaAInt(clave)+" AND activo = 1";
								Statement stmt = con.creaStatement();
								stmt.execute(updateexistencia);
								stmt.close();
							}
						}
						else { // Hablamos de Enteros.
							if(cambiaADouble(invTienda) > 0){
								BigDecimal actual = new BigDecimal(laExistenciaActualT);
								actual = actual.subtract(new BigDecimal(invTienda));
								actual = actual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement altaMerma;
								altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?,?,?,?,?,?);");
								altaMerma.setInt(1, cambiaAInt(clave));
								altaMerma.setString(2, usuario);
								altaMerma.setString(3, hoy);
								altaMerma.setString(4, hora);
								altaMerma.setDouble(5, cambiaADouble(invTienda));
								altaMerma.setDouble(6, cambiaADouble(laExistenciaActualT));
								altaMerma.setDouble(7, cambiaADouble(actual.toString()));
								altaMerma.setString(8,causa);
								altaMerma.setInt(9,1);
								altaMerma.execute();
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(laExistenciaActualT));
								updateModInventario.setDouble(7,  cambiaADouble(actual.toString()));
								updateModInventario.setString(8,  causa);
								updateModInventario.setInt(9, 2);
								updateModInventario.setInt(10, 1);
								updateModInventario.execute();
								String updateexistencia = "UPDATE productos SET invTienda = "+cambiaADouble(actual.toString())+" WHERE ID_Pro = "+cambiaAInt(clave)+" AND activo = 1";
								Statement stmt = con.creaStatement();
								stmt.execute(updateexistencia);
								stmt.close();
							}
							if(cambiaADouble(invAlmacen) > 0) {
								BigDecimal actual = new BigDecimal(laExistenciaActualA);
								actual = actual.subtract(new BigDecimal(invAlmacen));
								actual = actual.setScale(3, RoundingMode.HALF_UP);
								PreparedStatement altaMerma;
								altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?,?,?,?,?,?);");
								altaMerma.setInt(1, cambiaAInt(clave));
								altaMerma.setString(2, usuario);
								altaMerma.setString(3, hoy);
								altaMerma.setString(4, hora);
								altaMerma.setDouble(5, cambiaADouble(invAlmacen));
								altaMerma.setDouble(6, cambiaADouble(laExistenciaActualA));
								altaMerma.setDouble(7, cambiaADouble(actual.toString()));
								altaMerma.setString(8,causa);
								altaMerma.setInt(9,2);
								altaMerma.execute();
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?,?,?,?,?,?)");
								updateModInventario.setNull(1, java.sql.Types.INTEGER);
								updateModInventario.setInt(2, cambiaAInt(clave));
								updateModInventario.setString(3, usuario);
								updateModInventario.setString(4, hoy);
								updateModInventario.setString(5, hora);
								updateModInventario.setDouble(6,  cambiaADouble(laExistenciaActualA));
								updateModInventario.setDouble(7,  cambiaADouble(actual.toString()));
								updateModInventario.setString(8,  causa);
								updateModInventario.setInt(9, 2);
								updateModInventario.setInt(10, 2);
								updateModInventario.execute();
								String updateexistencia = "UPDATE productos SET invAlmacen = "+cambiaADouble(actual.toString())+" WHERE ID_Pro = "+cambiaAInt(clave)+" AND activo = 1";
								Statement stmt = con.creaStatement();
								stmt.execute(updateexistencia);
								stmt.close();
							}
						}
					}
					else{
						exito = 2;
					}
				}
				statement = con.creaStatement();
				statement.execute("UNLOCK TABLES");
				statement.close();
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				exito = 0;
		 		con.realizaRollback();
		 		sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerInventarios";
				throw new SQLException(error);
			}
			catch (Exception q){
				exito = 0;
		 		con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
				 	con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerInventarios metodo add_Mermas");
					q.printStackTrace();
				}
			}
		}
		else {
			exito = 0;
			error = "Exception: Conexión a la Base de Datos perdida. En ManagerInventarios";
			throw new Exception(error);
		}
	 return exito;
	}


/**
* El método dame_Maximo se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	clave		String con la Clave del Producto solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Producto.
*/
 public ResultSet dame_Maximo() throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT ID_Pro,  tipoPro,  descripcion, maxInv, invTienda, invAlmacen, (invTienda+invAlmacen)AS inventario FROM productos WHERE (invTienda+invAlmacen) >= maxInv AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query dame_Maximo.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dame_Maximo.";
          throw new Exception(error);
        }
        return rs;
  }

  /**
  * El método dame_Minimo se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
  *  	@param 	clave		String con la Clave del Producto solicitado.
  *	@return rs 			ResultSet que contiene todos los datos correspondiente a un Producto.
  */
   public ResultSet dame_Minimo() throws SQLException, Exception
   {
          ResultSet rs = null;
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT ID_Pro,  tipoPro,  descripcion, minInv, invTienda, invAlmacen, (invTienda+invAlmacen)AS inventario FROM productos WHERE (invTienda+invAlmacen)  <= minInv AND activo = 1");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
			  sqle.printStackTrace();
            error = "SQLException: Could not execute the query dame_Minimo.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dame_Minimo.";
            throw new Exception(error);
          }
          return rs;
  }

/**
* El método Mermas_Mes se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	clave		String con la Clave del Producto solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Producto.
*/
 public ResultSet Mermas_Mes(String fecha) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT mermas.*, productos.tipoPro, productos.descripcion FROM mermas, productos  WHERE mermas.fecha like '"+fecha+"' AND productos.ID_Pro = mermas.ID_Pro ORDER BY mermas.fecha,mermas.hora");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query Mermas_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Mermas_Mes.";
          throw new Exception(error);
        }
        return rs;
  }

	public ResultSet HistoricoInventario(String fecha) throws SQLException, Exception   {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT modificainv.*, productos.descripcion, productos.tipoPro FROM modificainv, productos WHERE modificainv.fecha like '"+fecha+"' AND productos.ID_Pro = modificainv.ID_Pro ORDER BY modificainv.ID_Modifica DESC");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query Mermas_Mes.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Mermas_Mes.";
			throw new Exception(error);
		}
		return rs;
	}

// ANTERIORES





















// CLASES PREVIAS


  public ResultSet dameProductos2() throws SQLException, Exception {
          ResultSet rs = null;

          con = new ConexionBD();
         // System.out.println("Estoy abriendo conexion en dameproductos.");
          try  {
            String queryString = ("SELECT * FROM productos WHERE activo = 1 ORDER BY textoArticulo");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameProductos2.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameProductos2.";
            throw new Exception(error);
          }
            finally{
				try{
			   		con.cierraConexion();
		//	   		System.out.println("Estoy cerrando conexion en dameproductos.");
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameProductos2");
			   		q.printStackTrace();
			 	}
		   }
          return rs;
  }

/**
* El método dameProductos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Productos que se encuentren activos.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos.
*/

	public ResultSet listadoProductos(String orden) throws SQLException, Exception {
		ResultSet rs = null;
		String complemento = " descripcion";
		int tipo = cambiaAInt(orden);
		if(tipo == 2){
			complemento = " ID_Pro";
		}
		else if(tipo == 3){
			complemento = " genero,descripcion";
		}
		else if(tipo ==4){
			complemento = " genero,ID_Pro";
		}
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = ("SELECT * FROM productos WHERE activo = 1 ORDER BY "+complemento);
				System.out.println(queryString);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL metodo listadoProductos en ManagerInventarios");
				error = "SQLException: Could not execute the query listadoProductos.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				System.out.println("Error metodo listadoProductos en ManagerInventarios");
				error = "An exception occured while retrieving listadoProductos.";
				throw new Exception(error);
			}
		}
	return rs;
	}


/**
* El método dameProductos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Productos que se encuentren activos.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos.
*/

	public ResultSet dameInfoEscalon(String claveProducto) throws SQLException, Exception {
		ResultSet rs = null;
		con2 = new ConexionBD();
		if(con2 != null){
			try  {
				String queryString = ("SELECT ca_peEscalon, campoPrecio FROM pescalonados WHERE ID_Pro = "+claveProducto +" AND  activo = 1 ORDER BY ca_peEscalon");
				System.out.println(queryString);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL metodo dameInfoEscalon en ManagerInventarios");
				error = "SQLException: Could not execute the query dameInfoEscalon.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				System.out.println("Error metodo dameInfoEscalon en ManagerInventarios");
				error = "An exception occured while retrieving dameInfoEscalon.";
				throw new Exception(error);
			}
		}
	return rs;
	}


/**
* El método listadoProductosRetonito se encarga de enviar la lista de todos los productos que pertenecen a la tiendad de origen 0, es decir para este caso el Retoñito.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos del Retoñito.
*/
  public ResultSet listadoProductosRetonito() throws SQLException, Exception {
          ResultSet rs = null;
          con = new ConexionBD();
          try  {

            String queryString = ("SELECT PLU, textoArticulo FROM productos WHERE activo = 1 AND origen = 0 ORDER BY  textoArticulo");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query listadoProductosRetonito.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving listadoProductosRetonito.";
            throw new Exception(error);
          }
            finally{
				try{
			   		con.cierraConexion();
		//	   		System.out.println("Estoy cerrando conexion en dameproductos.");
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo listadoProductosRetonito");
			   		q.printStackTrace();
			 	}
		   }
          return rs;
  }


/**
* El método listadoProductosPozito se encarga de enviar la lista de todos los productos que pertenecen a la tiendad de origen 1, es decir para este caso el Pozito.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos del Retoñito.
*/
  public ResultSet listadoProductosPozito() throws SQLException, Exception {
          ResultSet rs = null;
          con = new ConexionBD();
          try  {

            String queryString = ("SELECT PLU, textoArticulo FROM productos WHERE activo = 1 AND origen = 1 ORDER BY  textoArticulo");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query listadoProductosPozito.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving listadoProductosPozito.";
            throw new Exception(error);
          }
            finally{
				try{
			   		con.cierraConexion();
		//	   		System.out.println("Estoy cerrando conexion en dameproductos.");
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo listadoProductosPozito");
			   		q.printStackTrace();
			 	}
		   }
          return rs;
  }


/**
* El método listadoPorCodigos se encarga de enviar la lista de todos los productos que tienen registrados por lo menos un codigo de barras.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a todos los Productos con codigo.
*/
  public ResultSet listadoPorCodigos(String orden) throws SQLException, Exception {
		String complemento = " productos.descripcion";
		int tipo = cambiaAInt(orden);
		if(tipo == 2){
			complemento = " productos.ID_Pro";
		}
		else if(tipo == 3){
			complemento = " productos.genero, productos.descripcion";
		}
		else if(tipo ==4){
			complemento = " productos.genero, productos.ID_Pro";
		}
          ResultSet rs = null;
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT productos.ID_Pro, productos.descripcion, productos.genero, codigosb.codBarra FROM codigosb, productos WHERE productos.ID_Pro = codigosb.ID_Pro AND productos.activo = 1 ORDER BY " +complemento);
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query listadoPorCodigos.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving listadoPorCodigos.";
            throw new Exception(error);
          }
          return rs;
  }




  public ResultSet listadoProductosConPrecio(String plu1) throws SQLException, Exception {
          ResultSet rs = null;
          con = new ConexionBD();
         //System.out.println("2.5.");
          try  {

            String queryString = ("SELECT PLU, textoArticulo, precioBase1, precioBase1Caja, precioG1, precioG1Caja, precioG2, precioG2Caja, precioG3, precioG3Caja, tipoPrecio  FROM productos WHERE plu = '"+plu1+"' AND activo = 1 ORDER BY PLU");
            //System.out.println("queryString: "+queryString);
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query listadoProductosConPrecio.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving listadoProductosConPrecio.";
            throw new Exception(error);
          }
            finally{
				try{
			   		con.cierraConexion();
		//	   		System.out.println("Estoy cerrando conexion en dameproductos.");
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo listadoProductosConPrecio");
			   		q.printStackTrace();
			 	}
		   }
          return rs;
  }


   public ResultSet dameProductosNegativos() throws SQLException, Exception {
           ResultSet rs = null;

           con = new ConexionBD();
           try  {
             String queryString = ("SELECT * FROM productos WHERE activo = 1 AND (cast(cantidad as signed) < 0 OR cantidad = '0' OR (cast(peso as signed) < 0 OR peso = '0')) ORDER BY textoArticulo");
             Statement stmt = con.miConnection.createStatement();
             rs = stmt.executeQuery(queryString);
           } catch (SQLException sqle) {
             error = "SQLException: Could not execute the query dameProductos.";
             throw new SQLException(error);
           } catch (Exception e) {
             error = "An exception occured while retrieving dameProductos.";
             throw new Exception(error);
           }
             finally{
 				try{
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameClientes");
 			   		q.printStackTrace();
 			 	}
 		   }
           return rs;
  }

/**
* El método update_Inventarios se encarga de actualizar los datos de los Inventarios de cada Producto dentro de la Base de Datos.
*  	@param 	plu  		String con el PLU del Producto a actualizar.
*	@param 	inv			String con el Inventario Nuevo.
*	@return int			Entero que indica un 0 si los datos fueron ingresados correctamente y 1 de ser lo contrario.
*/
  public int update_Inventarios(String plu, String inv) throws SQLException, Exception {

            int todobien = 1;
            ResultSet pro = datos_Producto(plu);
            String peso = new String();
            while(pro.next()){
            	peso = pro.getString("peso");}
             con = new ConexionBD();
          //   System.out.println("Estoy abriendo conexion en update_Inventarios.");
            if(peso.equalsIgnoreCase("NO"))
			{
            try  {
				String queryString = "UPDATE productos SET cantidad = '"+inv+"' WHERE plu = '"+plu+"' ";
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              todobien = 0;
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query update_Inventarios.";
              throw new SQLException(error);
            } catch (Exception e) {
              error = "Ocurrió una excepción mientras se actualizaba update_Inventarios.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			//   		 System.out.println("Estoy cerrando conexion en update_Inventarios. Caso 1");
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo update_Inventarios");
			   		q.printStackTrace();
			 	}
		   }
		   }
		   else
			{
            try  {
				String queryString = "UPDATE productos SET peso = '"+inv+"' WHERE plu = '"+plu+"' ";
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              todobien = 0;
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query update_Inventarios.";
              throw new SQLException(error);
            } catch (Exception e) {
              error = "Ocurrió una excepción mientras se actualizaba update_Inventarios.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			//   		System.out.println("Estoy cerrando conexion en update_Inventarios. Caso 2");
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo update_Inventarios");
			   		q.printStackTrace();
			 	}
		   }
		   }
	return todobien;
    }


/**
* El método update_Iva se encarga de actualizar los datos de los Productos que agravan IVA para identificarlos dentro de la Base de Datos.
*  	@param 	plu  		String con el PLU del Producto a actualizar.
*	@return todobien	Entero que indica un 0 si los datos fueron ingresados correctamente y 1 de ser lo contrario.
*/
  public int update_Iva(String plu) throws SQLException, Exception {
            int todobien = 1;
            con = new ConexionBD();

            try  {
				String queryString = "UPDATE productos SET gravaIVA = '1' WHERE plu = '"+plu+"' ";
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              todobien = 0;
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query update_Iva.";
              throw new SQLException(error);
            } catch (Exception e) {
              e.printStackTrace();
              error = "Ocurrió una excepción mientras se actualizaba update_Iva.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo update_Iva");
			   		q.printStackTrace();
			 	}
		   }

	return todobien;
    }


/**
* El método todosCero se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*/
 public void todosCero() throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString1 = ("SELECT * FROM productos");
          Statement stmt1 = con.miConnection.createStatement();
          rs = stmt1.executeQuery(queryString1);

          String plu = new String();

          while(rs.next()){
          plu = rs.getString("plu");
          String queryString = "UPDATE productos SET gravaIVA = '0' WHERE plu = '"+plu+"' ";
		  Statement stmt = con.miConnection.createStatement();
          stmt.execute(queryString);
          }

        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query todosCero.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving todosCero.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo todosCero");
		   		q.printStackTrace();
		  	}
		}
          }

/**
* El método datos_Producto se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	plu  		String con el PLU del Producto solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Producto.
*/
 public ResultSet datos_Producto(String plu) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
   //     System.out.println("Abriendo conexion datos_Producto");
        try  {
          String queryString = ("SELECT * FROM productos WHERE plu = '"+plu+"' AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Producto.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Producto.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		   	//	   System.out.println("Cerrando conexion datos_Producto");
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo datos_Producto");
		   		q.printStackTrace();
		  	}
		}
        return rs;
  }

/**
* Revisa que el tamaño del dato sea mayor a un solo dígito para cumplir con el formato, en caso de no ser así se le agrega un 0 al inicio, los casos en que se verifica son: mes, día,  hora, minuto, segundo.
* @return String que representa el valor recibido probablemente en caso de que haya sido necesario ya modificado.
*/
	public String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}

 /**
 * El método dameSalidas se encarga de enviar todos los datos sobre salidas registradas dentro de la Base de Datos.
 *  	@param 	fecha0 		String con fecha en que deseamos obtener las Salidas.
 *		@return rs 			ResultSet que contiene todas las salidas correspondientes a la fecha seleccionada.
 */
  public ResultSet dameSalidas(String fecha) throws SQLException, Exception   {
         ResultSet rs = null;
         con = new ConexionBD();
         try  {
           String queryString = ("SELECT SUM(contenidoticket.pesoProducto)AS Cantidad, contenidoticket.numArticulo, contenidoticket.descripcionArticulo, productos.clasePLU, contenidoticket.tipoUnidad FROM  contenidoticket, productos WHERE (contenidoticket.fechaRealPago LIKE '"+fecha +"' OR (contenidoticket.fechaRealPago IS NULL AND contenidoTicket.FechaTicket = '"+fecha +"' )) AND  contenidoticket.estatusPago != 0 AND productos.PLU =  contenidoticket.numArticulo GROUP BY CONCAT(contenidoticket.numArticulo,'',contenidoticket.tipoUnidad) ORDER BY descripcionArticulo");
           Statement stmt = con.miConnection.createStatement();
           rs = stmt.executeQuery(queryString);
         } catch (SQLException sqle) {
           error = "SQLException: Could not execute the query dameSalidas.";
           throw new SQLException(error);
         } catch (Exception e) {
           error = "An exception occured while retrieving dameSalidas.";
           throw new Exception(error);
         }
         finally{
 			try{
 		   		con.cierraConexion();
 		  	}
 		   	catch (Exception q){
 		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameSalidas");
 		   		q.printStackTrace();
 		  	}
 		}
         return rs;
  }

 /**
 * El método dameSalidasXSemanas se encarga de enviar todos los datos sobre salidas registradas dentro de la Base de Datos.
 *  	@param 	fecha0 		String con fecha en que deseamos obtener las Salidas.
 *		@return rs 			ResultSet que contiene todas las salidas correspondientes a la fecha seleccionada.
 */
  public ResultSet dameSalidasXSemanas(String fecha, String semana) throws SQLException, Exception   {
         ResultSet rs = null;
         int iSemana = cambiaAInt(semana);
         if(iSemana == 1){
			 fecha = fecha+"01"+"' AND '" +fecha+"07";
		 }
         else if(iSemana == 2){
			 fecha = fecha+"08"+"' AND '" +fecha+"14";
		 }
         else if(iSemana == 3){
			 fecha = fecha+"15"+"' AND '" +fecha+"21";
		 }
         else if(iSemana == 4){
			 fecha = fecha+"22"+"' AND '" +fecha+"31";
		 }
         con = new ConexionBD();
         Properties p = new Properties();
         try  {
           String queryString = ("SELECT SUM(contenidoticket.pesoProducto)AS Cantidad, contenidoticket.numArticulo, contenidoticket.descripcionArticulo, productos.clasePLU, contenidoticket.tipoUnidad FROM  contenidoticket, productos WHERE (contenidoticket.fechaRealPago BETWEEN  '"+fecha+"' OR (contenidoticket.fechaRealPago IS NULL AND contenidoTicket.FechaTicket BETWEEN  '"+fecha+"' )) AND  contenidoticket.estatusPago != 0 AND productos.PLU =  contenidoticket.numArticulo GROUP BY CONCAT(contenidoticket.numArticulo,'',contenidoticket.tipoUnidad) ORDER BY descripcionArticulo");
           Statement stmt = con.miConnection.createStatement();
           rs = stmt.executeQuery(queryString);
         } catch (SQLException sqle) {
           error = "SQLException: Could not execute the query dameSalidasXSemanas.";
           throw new SQLException(error);
         } catch (Exception e) {
           error = "An exception occured while retrieving dameSalidasXSemanas.";
           throw new Exception(error);
         }
         finally{
 			try{
 		   		con.cierraConexion();
 		  	}
 		   	catch (Exception q){
 		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameSalidasXSemanas");
 		   		q.printStackTrace();
 		  	}
 		}
         return rs;
  }


 /**
 * El método dameSalidasMes se encarga de enviar todos los datos sobre salidas registradas dentro de la Base de Datos.
 *  	@param 	fecha0 		String con fecha en que deseamos obtener las Salidas.
 *		@return rs 			ResultSet que contiene todas las salidas correspondientes a la fecha seleccionada.
 */
  public ResultSet dameSalidasMes(String fecha) throws SQLException, Exception   {
         ResultSet rs = null;
         con = new ConexionBD();
         try  {
           String queryString = ("SELECT SUM(contenidoticket.pesoProducto)AS Cantidad, contenidoticket.numArticulo, contenidoticket.descripcionArticulo, productos.clasePLU, contenidoticket.tipoUnidad FROM  contenidoticket, productos WHERE (contenidoticket.fechaRealPago LIKE '"+fecha +"' OR (contenidoticket.fechaRealPago IS NULL AND contenidoTicket.FechaTicket LIKE '"+fecha +"' )) AND  contenidoticket.estatusPago != 0 AND productos.PLU =  contenidoticket.numArticulo GROUP BY CONCAT(contenidoticket.numArticulo,'',contenidoticket.tipoUnidad) ORDER BY descripcionArticulo");
           Statement stmt = con.miConnection.createStatement();
           rs = stmt.executeQuery(queryString);
         } catch (SQLException sqle) {
           error = "SQLException: Could not execute the query dameSalidasMes.";
           throw new SQLException(error);
         } catch (Exception e) {
           error = "An exception occured while retrieving dameSalidasMes.";
           throw new Exception(error);
         }
         finally{
 			try{
 		   		con.cierraConexion();
 		  	}
 		   	catch (Exception q){
 		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameSalidasMes");
 		   		q.printStackTrace();
 		  	}
 		}
         return rs;
  }

 /**
 * El método dameSalidas se encarga de enviar todos los datos sobre salidas registradas dentro de la Base de Datos.
 *  	@param 	fecha0 		String con fecha en que deseamos obtener las Salidas.
 *		@return rs 			ResultSet que contiene todas las salidas correspondientes a la fecha seleccionada.
 */
  public ResultSet dameEntradas(String fecha) throws SQLException, Exception   {
         ResultSet rs = null;
         con = new ConexionBD();
         Properties p = new Properties();
         try  {
           String queryString = ("SELECT SUM(entradas.cantidad)AS cantidad, entradas.PLU, entradas.textoArticulo, entradas.tipoUnidad, productos.origen FROM entradas, productos WHERE entradas.fecha = '"+fecha+"' AND productos.PLU = entradas.PLU AND productos.activo = 1 AND entradas.activo = 1 GROUP BY CONCAT(entradas.PLU,entradas.textoArticulo,entradas.tipoUnidad,productos.origen) ORDER BY CONCAT(productos.origen,entradas.textoArticulo)");
           Statement stmt = con.miConnection.createStatement();
           rs = stmt.executeQuery(queryString);
         } catch (SQLException sqle) {
           error = "SQLException: Could not execute the query dameEntradas.";
           throw new SQLException(error);
         } catch (Exception e) {
           error = "An exception occured while retrieving dameEntradas.";
           throw new Exception(error);
         }
         finally{
 			try{
 		   		con.cierraConexion();
 		  	}
 		   	catch (Exception q){
 		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameEntradas");
 		   		q.printStackTrace();
 		  	}
 		}
         return rs;
  }


 /**
 * El método dameSalidasMes se encarga de enviar todos los datos sobre salidas registradas dentro de la Base de Datos.
 *  	@param 	fecha0 		String con fecha en que deseamos obtener las Salidas.
 *		@return rs 			ResultSet que contiene todas las salidas correspondientes a la fecha seleccionada.
 */
  public ResultSet dameEntradasMes(String fecha) throws SQLException, Exception
  {
         ResultSet rs = null;
         con = new ConexionBD();
         try  {
           String queryString = ("SELECT SUM(entradas.cantidad)AS cantidad, entradas.PLU, entradas.textoArticulo, entradas.tipoUnidad, productos.origen FROM entradas, productos WHERE entradas.fecha LIKE '"+fecha +"' AND productos.PLU = entradas.PLU AND productos.activo = 1 AND entradas.activo = 1 GROUP BY CONCAT(entradas.PLU,entradas.textoArticulo,entradas.tipoUnidad,productos.origen) ORDER BY CONCAT(productos.origen,entradas.textoArticulo)");
           Statement stmt = con.miConnection.createStatement();
           rs = stmt.executeQuery(queryString);
         } catch (SQLException sqle) {
           error = "SQLException: Could not execute the query dameEntradasMes.";
           throw new SQLException(error);
         } catch (Exception e) {
           error = "An exception occured while retrieving dameEntradasMes.";
           throw new Exception(error);
         }
         finally{
 			try{
 		   		con.cierraConexion();
 		  	}
 		   	catch (Exception q){
 		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameEntradasMes");
 		   		q.printStackTrace();
 		  	}
 		}
         return rs;
  }

 /**
 * El método dameEntradasXSemanas se encarga de enviar todos los datos sobre salidas registradas dentro de la Base de Datos.
 *  	@param 	fecha0 		String con fecha en que deseamos obtener las Salidas.
 *		@return rs 			ResultSet que contiene todas las salidas correspondientes a la fecha seleccionada.
 */
  public ResultSet dameEntradasXSemanas(String fecha, String semana) throws SQLException, Exception   {
         ResultSet rs = null;
         int iSemana = cambiaAInt(semana);
         if(iSemana == 1){
			 fecha = fecha+"01"+"' AND '" +fecha+"07";
		 }
         else if(iSemana == 2){
			 fecha = fecha+"08"+"' AND '" +fecha+"14";
		 }
         else if(iSemana == 3){
			 fecha = fecha+"15"+"' AND '" +fecha+"21";
		 }
         else if(iSemana == 4){
			 fecha = fecha+"22"+"' AND '" +fecha+"31";
		 }
         con = new ConexionBD();
         Properties p = new Properties();
         try  {
           String queryString = ("SELECT SUM(entradas.cantidad)AS cantidad, entradas.PLU, entradas.textoArticulo, entradas.tipoUnidad, productos.origen FROM entradas, productos WHERE entradas.fecha BETWEEN '"+fecha+"' AND entradas.activo = 1 AND productos.PLU = entradas.PLU AND productos.activo = 1 GROUP BY CONCAT(entradas.PLU,entradas.textoArticulo,entradas.tipoUnidad,productos.origen) ORDER BY CONCAT(productos.origen,entradas.textoArticulo)");
           Statement stmt = con.miConnection.createStatement();
           rs = stmt.executeQuery(queryString);
         } catch (SQLException sqle) {
           error = "SQLException: Could not execute the query dameEntradasXSemanas.";
           throw new SQLException(error);
         } catch (Exception e) {
           error = "An exception occured while retrieving dameEntradasXSemanas.";
           throw new Exception(error);
         }
         finally{
 			try{
 		   		con.cierraConexion();
 		  	}
 		   	catch (Exception q){
 		   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo dameEntradasXSemanas");
 		   		q.printStackTrace();
 		  	}
 		}
         return rs;
  }





/**
* El método completaPlu se encarga de insertar los ceros suficientes para completar el tamaño de 6 del PLU de Productos.
*  	@param 	plu			String a completar.
*	@return valor 		String con el valor de la variable.
*/
	public String completaPlu(String plu) throws Exception{
		int valor;
		String finalplu = plu;
		try{
			valor = plu.length();
			valor = 6 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}


/**
* El método cambiaAInt se encarga de transformar a un Entero una variables en formato String.
*  	@param 	variable	String a tranformar a Entero.
*	@return valor 		Entero con el valor de la variable.
*/
	public double cambiaADouble(String variable) throws Exception{
		variable = remueveComas(variable);
		double valor;
		if(variable == null){
			variable = "";
		}
		try{
			Double val = (Double.valueOf(variable));
			valor = val.doubleValue();
		}
		catch(NumberFormatException nfe){
			valor =0;
		}
			return valor;
	}

	public int cambiaAInt(String variable) throws Exception{
		variable = remueveComas(variable);
		int valor;
		try{
			valor = (Integer.parseInt(variable));
		}
		catch(NumberFormatException nfe){
			valor = 0;
		}
			return valor;
	}

	public String formatoDinero(String formato){
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

	public String dameEnteros(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		if(sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length() );
		}
		return sb.toString();
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

	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}


/**
* El método cambiaADate se encarga de transformar a un Date una variables en formato String.
*  	@param 	fecha	String a tranformar a Date.
*	@return Date 	Date con el valor de la variable.
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


}