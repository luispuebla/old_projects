package com.vas.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerInventarios" es la encargada de administrar los datos correspondientes a los Productos como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Mayo 2006)
*/

public class ManagerInventarios {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerInventarios es el constructor vacio de la clase.
*/

  public ManagerInventarios()   { }



/**
* El método Inventario_Producto se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los productos que dentro de su cavle tengar el orden de linea+sublinea+marca solicitado.
*  	@param 	linea	String con la línea solicitada.
*  	@param 	subinea	String con la sublínea solicitada.
*  	@param 	marca	String con la marca solicitada.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a la solicitud.
*/
 public ResultSet Inventario_Producto(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT descripcion, tipo, existencia FROM productos WHERE claveProducto = '"+clave+"' AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Inventario_Producto.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Inventario_Producto.";
          throw new Exception(error);
        }
        return rs;
  }

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


/**
* El método Inventario_Producto_Regalo se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los productos que dentro de su cavle tengar el orden de linea+sublinea+marca solicitado.
*  	@param 	linea	String con la línea solicitada.
*  	@param 	subinea	String con la sublínea solicitada.
*  	@param 	marca	String con la marca solicitada.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a la solicitud.
*/
 public ResultSet Inventario_Producto_Regalo(String clave) throws SQLException, Exception  {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT existencia FROM producto_obsequio WHERE claveProducto = '"+clave+"'");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Inventario_Producto_Regalo.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Inventario_Producto_Regalo.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add(String clave, String existencia, String regalos) {
		int verifica = 2;
		boolean revisa = ((clave != null) && (clave.length() > 0) &&
				(existencia != null) && (existencia.length() > 0) &&
				(regalos != null) && (regalos.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }

	 public synchronized int update_Producto_Inventario (String clave, String existenciaOri, String existencia, String existenciaOriR, String regalos, String usuario) throws SQLException, Exception{
		int exito = 1;
		tiempo = new TimeStamp();
		String hoy = tiempo.date;
		boolean huboTransaccionModificadora = false;
		 con = new ConexionBD();
		 con.cancelaAutoCommit();
		 if(con != null){
		 	try{
				// PONGO UN CANDADO DE ESCRITURA A TABLA DE PRODUCTOS
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES productos WRITE, producto_obsequio WRITE, modificaInv WRITE");
				statement.close();
			// PRIMERO PRODUCTO A VENTA...
				String queryInvActual = "SELECT existencia FROM productos WHERE claveProducto = '"+clave +"' AND activo = 1";
				statement=con.creaStatement();
				ResultSet rsActual = statement.executeQuery(queryInvActual);
				while(rsActual.next()){
					if(rsActual.getDouble("existencia") != cambiaADouble(existenciaOri)){
							huboTransaccionModificadora = true;
					}
				}
				rsActual.close();
				statement.close();
			// SEGUNDO PRODUCTO DE OBSEQUIO...
				String queryInvActual2 = "SELECT  existencia FROM producto_obsequio WHERE claveProducto  = '"+clave +"'";
				statement=con.creaStatement();
				rsActual = statement.executeQuery(queryInvActual2);
				rsActual.beforeFirst();
				while(rsActual.next()){
					if(rsActual.getDouble("existencia") != cambiaADouble(existenciaOriR)){
						huboTransaccionModificadora = true;
					}
				}
				rsActual.close();
				statement.close();
				if(!huboTransaccionModificadora){
					if(! (existencia.equalsIgnoreCase(existenciaOri))){
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET existencia =  ?  WHERE claveProducto = ?");
						updateInventario.setDouble(1,  cambiaADouble(existencia));
						updateInventario.setString(2, clave);
						updateInventario.execute();
						PreparedStatement updateModInventario;
						updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?)");
						updateModInventario.setString(1, clave);
						updateModInventario.setString(2, usuario);
						updateModInventario.setString(3, hoy);
						updateModInventario.setDouble(4,  cambiaADouble(existencia));
						updateModInventario.setInt(5,1);
						updateModInventario.execute();
					}
					if(! (regalos.equalsIgnoreCase(existenciaOriR))){
						PreparedStatement updateInventarioR;
						updateInventarioR = con.miConnection.prepareStatement ("UPDATE producto_obsequio SET existencia =  ?  WHERE claveProducto = ?");
						updateInventarioR.setDouble(1,  cambiaADouble(regalos));
						updateInventarioR.setString(2, clave);
						updateInventarioR.execute();
						PreparedStatement updateModInventario;
						updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?)");
						updateModInventario.setString(1, clave);
						updateModInventario.setString(2, usuario);
						updateModInventario.setString(3, hoy);
						updateModInventario.setDouble(4,  cambiaADouble(regalos));
						updateModInventario.setInt(5,2);
						updateModInventario.execute();
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
* El método add_Mermas se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public synchronized  int add_Mermas(String clave, String existencia, String regalos) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		int exito = 1;
		tiempo = new TimeStamp();
		String hoy = tiempo.date;
		con = new ConexionBD();
		con.cancelaAutoCommit();
		if (con.miConnection != null) {
			try {
				boolean faltanteMaestro = false;
				boolean faltanteMaestro2 = false;
			// Bloqueo tablas para asegurar Transaccion
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES producto_obsequio WRITE, productos WRITE, mermas WRITE");
				statement.close();
				if(cambiaADouble(existencia) > 0){
					boolean sobrePasa = false;
					String queryVerificador = "SELECT existencia FROM productos  WHERE claveProducto = '"+clave +"' AND activo =1";
					statement = con.creaStatement();
					ResultSet verifica = statement.executeQuery(queryVerificador);
					while(verifica.next()){
						if(verifica.getDouble("existencia") < cambiaADouble(existencia)){
							sobrePasa = true;
						}
					}
					verifica.close();
					statement.close();
					if(!sobrePasa){
						PreparedStatement altaMerma;
						altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?);");
						altaMerma.setString(1, clave);
						altaMerma.setDouble(2, cambiaADouble(existencia));
						altaMerma.setString(3, hoy);
						altaMerma.setInt(4, 1);
						altaMerma.execute();
						String updateexistencia = "UPDATE productos SET existencia = existencia-"+cambiaADouble(existencia)+" WHERE claveProducto = '"+clave+"' AND activo = 1";
						Statement stmt = con.creaStatement();
						stmt.execute(updateexistencia);
						stmt.close();
					}
					else{
						exito = 2;
						faltanteMaestro = true;
					}
				}
				if(cambiaADouble(regalos) > 0 && !faltanteMaestro){
					boolean sobrePasa = true;
					String queryVerificador = "SELECT existencia FROM producto_obsequio  WHERE claveProducto = '"+clave +"'";
					statement = con.creaStatement();
					ResultSet verifica = statement.executeQuery(queryVerificador);
					while(verifica.next()){
						if(verifica.getDouble("existencia") < cambiaADouble(regalos)){
							sobrePasa = false;
						}
					}
					verifica.close();
					statement.close();
					if(sobrePasa){
						PreparedStatement altaMermaR;
						altaMermaR = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?);");
						altaMermaR.setString(1, clave);
						altaMermaR.setDouble(2, cambiaADouble(regalos));
						altaMermaR.setString(3, hoy);
						altaMermaR.setInt(4, 2);
						altaMermaR.execute();
						String updateObsequio = "UPDATE producto_obsequio SET existencia = existencia-"+cambiaADouble(regalos)+" WHERE claveProducto = '"+clave+"'";
						Statement stmt2 = con.creaStatement();
						stmt2.execute(updateObsequio);
						stmt2.close();
					}
					else{
						exito = 2;
						faltanteMaestro = true;
						faltanteMaestro2 = true;
					}
				}
				statement = con.creaStatement();
				statement.execute("UNLOCK TABLES");
				statement.close();
				if(faltanteMaestro){
					if(cambiaADouble(existencia) > 0){
						boolean sobrePasa = false;
						String queryVerificador = "SELECT existencia FROM productos  WHERE claveProducto = '"+clave +"' AND activo =1";
						statement = con.creaStatement();
						ResultSet verifica = statement.executeQuery(queryVerificador);
						while(verifica.next()){
							if(verifica.getDouble("existencia") < cambiaADouble(existencia)){
								sobrePasa = true;
							}
						}
						verifica.close();
						statement.close();
						if(!sobrePasa){
							String borraMerma = "DELETE FROM mermas WHERE claveProducto = '"+clave+"' AND cantidad = "+cambiaADouble(existencia)+	" AND fecha = '"+hoy +"' AND tipo = 1";
							Statement stmt1 = con.creaStatement();
							stmt1.execute(borraMerma);
							stmt1.close();
							String updateexistencia = "UPDATE productos SET existencia = existencia+"+cambiaADouble(existencia)+" WHERE claveProducto = '"+clave+	"' AND activo = 1";
							Statement stmt = con.creaStatement();
							stmt.execute(updateexistencia);
							stmt.close();
						}
					}
				}
				else{
					con.realizaCommit();
				}
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
* El método update_Traspaso se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*  0--> Error SQL, 1 --> Exito, 2--> La Cantidad Solicitada a pasar sobre pasa la Existencia Actual.
*/
	public synchronized int update_Traspaso(String clave, String cantidad, String tipo) throws SQLException, Exception {
		int ti = cambiaAInt(tipo);
		int exito = 1; // 0--> Error SQL, 1 --> Exito, 2--> La Cantidad Solicitada a pasar sobre pasa la Existencia Actual.
		boolean sobrePasa = false;
		ResultSet rs = null;
		con = new ConexionBD();
		con.cancelaAutoCommit();
		if (con.miConnection != null) {
			try {
				// Caso de Inventario de Producto a Inventario de Regalo.
				if(ti == 1){
				// Bloqueo tablas para asegurar Transaccion
					Statement statement = con.creaStatement();
					statement.execute("LOCK TABLES producto_obsequio WRITE, productos WRITE");
					statement.close();
				// Averiguo si sobrepaso Cantidad solicitada.
					String queryVerificador = "SELECT existencia FROM productos WHERE claveProducto = '"+clave +"' AND activo = 1";
					statement = con.creaStatement();
					ResultSet verifica = statement.executeQuery(queryVerificador);
					while(verifica.next()){
						if(verifica.getDouble("existencia") < cambiaADouble(cantidad)){
							sobrePasa = true;
						}
					}
					verifica.close();
					statement.close();
				// No se sobre Pasa la cantidad requerida.
					if(!sobrePasa){
						String updateexistencia = "UPDATE productos SET existencia = existencia-"+cambiaADouble(cantidad)+" WHERE claveProducto = '"+clave+"'";
						Statement stmt = con.creaStatement();
						stmt.execute(updateexistencia);
						stmt.close();
				// Checo si ya existe una entrada en el Inventario de regalos...
						boolean yaHayEntrada = false;
						String query = ("SELECT claveProducto FROM producto_obsequio WHERE claveProducto = '"+clave+"'");
						Statement stmt3 = con.creaStatement();
						rs = stmt3.executeQuery(query);
						while(rs.next()){
							if(rs.getString("claveProducto").equalsIgnoreCase(clave)){
								yaHayEntrada = true;
							}
						}
						rs.close();
						stmt3.close();
						if(!yaHayEntrada){
							PreparedStatement altaRegalos;
							altaRegalos = con.miConnection.prepareStatement("insert into producto_obsequio values(?,?);");
							altaRegalos.setString(1, clave);
							altaRegalos.setDouble(2, cambiaADouble(cantidad));
							altaRegalos.execute();
						}
						else{
							String updateObsequio = "UPDATE producto_obsequio SET existencia = existencia+"+cambiaADouble(cantidad)+" WHERE claveProducto = '"+clave+"'";
							Statement stmt2 = con.creaStatement();
							stmt2.execute(updateObsequio);
							stmt2.close();
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
				else if(ti == 2){
				// Bloqueo tablas para asegurar Transaccion
					Statement statement = con.creaStatement();
					statement.execute("LOCK TABLES producto_obsequio WRITE, productos WRITE");
					statement.close();
				// Averiguo si sobrepaso Cantidad solicitada.
					String queryVerificador = "SELECT existencia FROM producto_obsequio WHERE claveProducto = '"+clave +"'";
					boolean siExisteEnPO = false;
					statement = con.creaStatement();
					ResultSet verifica = statement.executeQuery(queryVerificador);
					while(verifica.next()){
						siExisteEnPO = true;
						if(verifica.getDouble("existencia") < cambiaADouble(cantidad)){
							sobrePasa = true;
						}
					}
					verifica.close();
					statement.close();
					if(!siExisteEnPO){
						sobrePasa = true;
					}
					if(!sobrePasa){
						String updateexistencia2 = "UPDATE productos SET existencia = existencia+"+cambiaADouble(cantidad)+" WHERE claveProducto = '"+clave+"'";
						Statement stmt3 = con.creaStatement();
						stmt3.execute(updateexistencia2);
						stmt3.close();
						String updateObsequio2 = "UPDATE producto_obsequio SET existencia = existencia-"+cambiaADouble(cantidad)+" WHERE claveProducto = '"+clave+"'";
						Statement stmt4 = con.creaStatement();
						stmt4.execute(updateObsequio2);
						stmt4.close();
					}
					else{
						exito = 2;
					}
					statement = con.creaStatement();
					statement.execute("UNLOCK TABLES");
					statement.close();
					con.realizaCommit();
				}
			}
			catch (SQLException sqle) {
				exito = 1;
		 		con.realizaRollback();
		 		sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerInventarios---update_Traspaso";
				throw new SQLException(error);
			}
			catch (Exception q){
				exito = 1;
		 		con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
				 	con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerInventarios metodo update_Traspaso");
					q.printStackTrace();
				}
			}
		}
		else {
			exito = 1;
			System.out.println("Exception: Conexión a la Base de Datos perdida. En ManagerInventarios----update_Traspaso");
			error = "Exception: Conexión a la Base de Datos perdida. En ManagerInventarios----update_Traspaso";
			throw new Exception(error);
		}
	 return exito;
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
          String queryString = ("SELECT mermas.*, productos.tipo FROM mermas, productos  WHERE mermas.fecha like '"+fecha+"' AND productos.claveProducto = mermas.claveProducto");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Mermas_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Mermas_Mes.";
          throw new Exception(error);
        }
        return rs;
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
          String queryString = ("SELECT claveProducto, tipo,  descripcion, maximo, existencia FROM productos WHERE existencia >= maximo AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
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
          String queryString = ("SELECT claveProducto, tipo,  descripcion, minimo, existencia FROM productos WHERE existencia <= minimo AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dame_Minimo.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dame_Minimo.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El Método InventarioFisico nos muestra todos los Productos con su clave registradas en el Sistema
* @return rs ResultSet que contiene toda la información de todos los Productos.
*/
	public ResultSet InventarioFisico() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT claveProducto, tipo,  descripcion FROM productos WHERE activo = 1 ORDER BY claveProducto;");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerInventarios, InventarioFisico ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerInventarios, InventarioFisico ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El método update_Inventarios se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public synchronized int update_Inventarios(String[ ] clave, String[ ] original, String[ ] inventario,String[ ] existenteR, String[ ] regalo, String usuario) throws SQLException, Exception {
		tiempo = new TimeStamp();
		int fin = 0;
		String hoy = tiempo.date;
		boolean huboTransaccionModificadora = false;
		ResultSet rs = null;
		con = new ConexionBD();
		con.cancelaAutoCommit();
		if (con.miConnection != null) {
			try {
			// PONGO UN CANDADO DE ESCRITURA A TABLA DE PRODUCTOS
				Statement statement = con.creaStatement();
				statement.execute("LOCK TABLES productos WRITE, producto_obsequio WRITE, modificaInv WRITE");
				statement.close();
			// Verifico que del momento en que desplegue la info de inventario al que me mandan modificacion no hubiese otra transaccion que modificara la cantidad de producto existente.
			// PRIMERO PRODUCTO A VENTA...
				String queryInvActual = "SELECT claveProducto, existencia FROM productos WHERE activo = 1 ORDER BY productos.claveProducto";
				statement=con.creaStatement();
				ResultSet rsActual = statement.executeQuery(queryInvActual);
				for (int i = 0; i<clave.length; i++){
					rsActual.beforeFirst();
					while(rsActual.next()){
						if(rsActual.getString("claveProducto").equalsIgnoreCase(clave[i])){
							if(rsActual.getDouble("existencia") != cambiaADouble(original[i])){
								huboTransaccionModificadora = true;
							}
						}
					}
				}
				rsActual.close();
				statement.close();
			// SEGUNDO PRODUCTO DE OBSEQUIO...
				String queryInvActual2 = "SELECT claveProducto, existencia FROM producto_obsequio ORDER BY producto_obsequio.claveProducto";
				statement=con.creaStatement();
				rsActual = statement.executeQuery(queryInvActual2);
				for (int i = 0; i<clave.length; i++){
					rsActual.beforeFirst();
					while(rsActual.next()){
						if(rsActual.getString("claveProducto").equalsIgnoreCase(clave[i])){
							if(rsActual.getDouble("existencia") != cambiaADouble(existenteR[i])){
								huboTransaccionModificadora = true;
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
						if(! (original[i].equalsIgnoreCase(inventario[i]))){
							PreparedStatement updateInventario;
							updateInventario = con.miConnection.prepareStatement ("UPDATE productos SET existencia =  ?  WHERE claveProducto = ?");
							updateInventario.setDouble(1,  cambiaADouble(inventario[i]));
							updateInventario.setString(2, clave[i]);
							updateInventario.execute();
							PreparedStatement updateModInventario;
							updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?)");
							updateModInventario.setString(1, clave[i]);
							updateModInventario.setString(2, usuario);
							updateModInventario.setString(3, hoy);
							updateModInventario.setDouble(4,  cambiaADouble(inventario[i]));
							updateModInventario.setInt(5,1);
							updateModInventario.execute();
						}
					}
// Segundo producto de regalo.
					for (int i = 0; i<clave.length; i++){
						if(! (existenteR[i].equalsIgnoreCase(regalo[i]))){
							boolean yaExiste = false;
							String query = ("SELECT claveProducto FROM producto_obsequio WHERE claveProducto = '"+clave[i]+"'");
							Statement stmt3 = con.creaStatement();
							rs = stmt3.executeQuery(query);
							while(rs.next()){
								if(rs.getString("claveProducto").equalsIgnoreCase(clave[i])){
									yaExiste = true;
								}
							}
							rs.close();
							stmt3.close();
							if(yaExiste){
								PreparedStatement updateInventarioR;
								updateInventarioR = con.miConnection.prepareStatement ("UPDATE producto_obsequio SET existencia =  ?  WHERE claveProducto = ?");
								updateInventarioR.setDouble(1,  cambiaADouble(regalo[i]));
								updateInventarioR.setString(2, clave[i]);
								updateInventarioR.execute();
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?)");
								updateModInventario.setString(1, clave[i]);
								updateModInventario.setString(2, usuario);
								updateModInventario.setString(3, hoy);
								updateModInventario.setDouble(4,  cambiaADouble(regalo[i]));
								updateModInventario.setInt(5,2);
								updateModInventario.execute();
							}
							else{
								PreparedStatement altaRegalos;
								altaRegalos = con.miConnection.prepareStatement("insert into producto_obsequio values(?,?);");
								altaRegalos.setString(1, clave[i]);
								altaRegalos.setDouble(2, cambiaADouble(regalo[i]));
								altaRegalos.execute();
								PreparedStatement updateModInventario;
								updateModInventario = con.miConnection.prepareStatement ("insert into modificaInv  values(?,?,?,?,?)");
								updateModInventario.setString(1, clave[i]);
								updateModInventario.setString(2, usuario);
								updateModInventario.setString(3, hoy);
								updateModInventario.setDouble(4,  cambiaADouble(regalo[i]));
								updateModInventario.setInt(5,2);
								updateModInventario.execute();
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
* El método cambiaAInt se encarga de transformar a un Entero una variables en formato String.
*  	@param 	variable	String a tranformar a Entero.
*	@return valor 		Entero con el valor de la variable.
*/
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


/**
* El método cambiaADouble se encarga de transformar a un Double una variables en formato String.
*  	@param 	variable	String a tranformar a double.
*	@return valor 		double con el valor de la variable.
*/
	public double cambiaADouble(String variable) throws Exception{
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


	public String remueveComillas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf("\"") != -1){
			sb.deleteCharAt(sb.indexOf("\""));
		}
		return formato = new String(sb.toString());
	}

	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}



	public String remueveCaracteres(String formato){
//		System.out.println("Entro: " +formato);
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf("ñ") != -1){
			sb=sb.replace(sb.indexOf("ñ"),sb.indexOf("ñ")+1,"%");
		}
		while (sb.indexOf("á") != -1){
			sb=sb.replace(sb.indexOf("á"),sb.indexOf("á")+1,"%");
		}
		while (sb.indexOf("é") != -1){
			sb=sb.replace(sb.indexOf("é"),sb.indexOf("é")+1,"%");
		}
		while (sb.indexOf("í") != -1){
			sb=sb.replace(sb.indexOf("í"),sb.indexOf("í")+1,"%");
		}
		while (sb.indexOf("ó") != -1){
			sb=sb.replace(sb.indexOf("ó"),sb.indexOf("ó")+1,"%");
		}
		while (sb.indexOf("ú") != -1){
			sb=sb.replace(sb.indexOf("ú"),sb.indexOf("ú")+1,"%");
		}
//		System.out.println("Salio: " +sb);
		return formato = new String(sb.toString());
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

		private String checkSize (String revisa){
			StringBuffer verificador = new StringBuffer(revisa);
			if (verificador.length() ==1){
				verificador.insert(0,"0");
			}
			return verificador.toString();
	}


		private String checkSize2 (String revisa){
			StringBuffer verificador = new StringBuffer(revisa);
			if (verificador.length() ==1){
				verificador.insert(0,"0");
				verificador.insert(1,"0");
			}
			if (verificador.length() ==2){
				verificador.insert(0,"0");
			}
			return verificador.toString();
	}


// Funcion generica que regresa un objeto Calendar a partir de un String tipo Fecha.(aaaa-mm-dd)
	public Calendar formatoCalendar(String formato) throws Exception{
		//System.out.println("Entro: "+formato);
		int anio =  Integer.parseInt(formato.substring(0,formato.indexOf("-")));
		int mes = Integer.parseInt(formato.substring((formato.indexOf("-")+1), formato.lastIndexOf("-")));
		int dia = Integer.parseInt(formato.substring((formato.lastIndexOf("-")+1), formato.length()));
		//System.out.println("año: "+anio);
		//System.out.println("mes: "+mes);
		//System.out.println("dia: "+dia);
		Calendar temporal = Calendar.getInstance();
		temporal.clear();
		temporal.set(anio, mes-1, dia);
		//System.out.println("Temporal: "+temporal);
		return temporal;
	}

}