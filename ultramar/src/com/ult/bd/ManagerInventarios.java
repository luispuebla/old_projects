package com.ult.bd;

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
			int cla = cambiaAInt(clave);
          String queryString = ("SELECT nombre, tipo, tipoA, inventarioKg, inventarioUnidad, inventarioBotella1, inventarioBotella2, costoBotella1, costoBotella2,  inventarioCopeo, litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+cla+" AND estatus = 1");
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



/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add(String clave, String existencia) {
		int verifica = 2;
		boolean revisa = ((clave != null) && (clave.length() > 0) &&
				(existencia != null) && (existencia.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método valida_add2 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add2(String clave, String existencia, String exi) {
		int verifica = 2;
		boolean revisa = ((clave != null) && (clave.length() > 0) &&
				(exi != null) && (exi.length() > 0) &&
				(existencia != null) && (existencia.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



 public boolean update_Producto_Inventario (String clave, String existencia, String existencia2, String area) throws SQLException, Exception{
	 boolean exito = true;
	 int ar = cambiaAInt(area);
	 int cla = cambiaAInt(clave);
	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		double exis = cambiaADouble(existencia);
		//System.out.println(ar);

		if(ar == 1){

			String updateexistencia = "UPDATE materiaprima SET inventarioKg = "+exis+" WHERE clave = "+cla+"";
			//System.out.println(updateexistencia);
			Statement stmt = con.creaStatement();
			stmt.execute(updateexistencia);
		}

		if(ar == 2){
			int exis2 = cambiaAInt(existencia2);

			String updateexistencia = "UPDATE materiaprima SET inventarioKg = "+exis+", inventarioUnidad = "+exis2+" WHERE clave = "+cla+"";
			//System.out.println(updateexistencia);
			Statement stmt = con.creaStatement();
			stmt.execute(updateexistencia);
		}

		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerInventarios, Metodo: update_Producto_Inventario.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = false;
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
	 return exito;
 }



 public boolean update_Producto_Inventario_B (String clave, String existenciaB, String existenciaB2, String existenciaC, String area) throws SQLException, Exception{
	 boolean exito = true;
	 int ar = cambiaAInt(area);
	 int cla = cambiaAInt(clave);
	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		double exisC = cambiaADouble(existenciaC);
		int exisB = cambiaAInt(existenciaB);
		int exisB2 = cambiaAInt(existenciaB2);
		//System.out.println(ar);

		if(ar == 2){

			String updateexistencia = "UPDATE materiaprima SET inventarioBotella1 = "+exisB+", inventarioBotella2 = "+exisB2+", inventarioCopeo = "+exisC+" WHERE clave = "+cla+"";
			Statement stmt = con.creaStatement();
			stmt.execute(updateexistencia);
		}
		 con.realizaCommit();
	 }

	 catch(SQLException sqle){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerInventarios, Metodo: update_Producto_Inventario_B.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion en bean ManagerInventarios, Metodo: update_Producto_Inventario_B.\n");
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
	 return exito;
 }




/**
* El Método todosLosProductosModInv  nos da el listado de todos los productos con su existencia en Inventarios
*
*  @return ResultSet con el listado correspondiente.
*/
	public ResultSet todosLosProductosModInv(String tipo) throws SQLException, Exception{
		ResultSet rs = null;
		int tip = cambiaAInt(tipo);
		try{
			String query = ("SELECT materiaprima.clave, materiaprima.tipo, materiaprima.tipoA, materiaprima.nombre AS descripcion, materiaprima.inventarioKg, materiaprima.inventarioUnidad, materiaprima.inventarioBotella1, materiaprima.inventarioBotella2, materiaprima.litrosXBotella1, materiaprima.litrosXBotella2, materiaprima.inventarioCopeo FROM materiaprima WHERE materiaprima.tipo = "+tip+" AND materiaprima.estatus = 1 ORDER BY materiaprima.nombre");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerInventarios, todosLosProductosModInv ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerInventarios, todosLosProductosModInv ");
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
	public int update_Inventarios(String clave, String inventario, String tipo) throws SQLException, Exception {
		//System.out.println("Empiezo");
		int fin = 0;

		int tip = cambiaAInt(tipo);
		int cla = cambiaAInt(clave);
		ResultSet rs = null;
		String aver = "";
		//System.out.println("Cambio a Int");

		con = new ConexionBD();
		con.cancelaAutoCommit();

		if (con.miConnection != null) {
			try {
				//System.out.println("Dentro del Try");

				if(tip == 1){
					double inv = cambiaADouble(inventario);

					String updateexistencia = "UPDATE materiaprima SET inventarioKg = "+inv+" WHERE clave = "+cla+"";
					Statement stmt = con.creaStatement();
					stmt.execute(updateexistencia);
					//System.out.println("Actualizo en productos");
				}

				if(tip == 2){
					int inv = cambiaAInt(inventario);

					String updateexistencia = "UPDATE materiaprima SET inventarioUnidad = "+inv+" WHERE clave = "+cla+"";
					Statement stmt = con.creaStatement();
					stmt.execute(updateexistencia);
					//System.out.println("Actualizo en productos");
				}

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
* El método update_Inventarios_B se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public int update_Inventarios_B(String clave, String inventarioB, String inventarioB2, String inventarioC) throws SQLException, Exception {
		//System.out.println("Empiezo");
		int fin = 0;

		double invC = cambiaADouble(inventarioC);
		int invB = cambiaAInt(inventarioB);
		int invB2 = cambiaAInt(inventarioB2);
		int cla = cambiaAInt(clave);
		ResultSet rs = null;
		String aver = "";
		//System.out.println("Cambio a Int");

		con = new ConexionBD();
		con.cancelaAutoCommit();

		if (con.miConnection != null) {
			try {
				//System.out.println("Dentro del Try");

					String updateexistencia = "UPDATE materiaprima SET inventarioBotella1 = "+invB+", inventarioBotella2 = "+invB2+", inventarioCopeo = "+invC+" WHERE clave = "+cla+"";
					Statement stmt = con.creaStatement();
					stmt.execute(updateexistencia);
					//System.out.println("Actualizo en productos");

				con.realizaCommit();
			}
			catch (SQLException sqle) {
				fin = 1;
		 		con.realizaRollback();
		 		sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerInventarios---update_Inventarios_B";
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
					System.out.println("Error al cerrar conexion de ManagerInventarios metodo update_Inventarios_B");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida. En ManagerInventarios----update_Inventarios_B";
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
	public boolean add_Mermas(String clave, String existencia, String tip) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;

		//int ti = cambiaAInt(tip);
		int cla = cambiaAInt(clave);
		tiempo = new TimeStamp();
		double exis = cambiaADouble(existencia);
		String hoy = tiempo.date;

		con = new ConexionBD();
		con.cancelaAutoCommit();

		if (con.miConnection != null) {
			try {

				if(exis > 0){


					PreparedStatement altaMerma;
					altaMerma = con.miConnection.prepareStatement("insert into mermas values(?,?,?,?);");
					altaMerma.setInt(1, cla);
					altaMerma.setDouble(2, exis);
					altaMerma.setString(3, hoy);
					altaMerma.setString(4, tip);

					altaMerma.execute();

						int exis2 = cambiaAInt(existencia);
					if(tip.equalsIgnoreCase("A")){

						String updateexistencia = "UPDATE materiaprima SET inventarioKg = inventarioKg-"+exis+" WHERE clave = '"+cla+"'";
						Statement stmt = con.creaStatement();
						stmt.execute(updateexistencia);
					}

					if(tip.equalsIgnoreCase("B")){

						String updateexistencia = "UPDATE materiaprima SET inventarioUnidad = inventarioUnidad-"+exis2+" WHERE clave = '"+cla+"'";
						Statement stmt = con.creaStatement();
						stmt.execute(updateexistencia);
					}

				}

				con.realizaCommit();
			}
			catch (SQLException sqle) {
				fin = false;
		 		con.realizaRollback();
		 		sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerInventarios";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
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
			error = "Exception: Conexión a la Base de Datos perdida. En ManagerInventarios";
			throw new Exception(error);
		}
	 return fin;
	}



/**
* El método add_Mermas_B se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public boolean add_Mermas_B(String clave, String existenciaB1, String existenciaB2, String existenciaC) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;

		int cla = cambiaAInt(clave);
		double exisC = cambiaADouble(existenciaC);
		int exisB1 = cambiaAInt(existenciaB1);
		int exisB2 = cambiaAInt(existenciaB2);
		tiempo = new TimeStamp();
		String hoy = tiempo.date;

		con = new ConexionBD();
		con.cancelaAutoCommit();

		if (con.miConnection != null) {
			try {

				if(exisB1 > 0 || exisB2 > 0 || exisC > 0){


					PreparedStatement altaMerma;
					altaMerma = con.miConnection.prepareStatement("insert into mermasB values(?,?,?,?,?,?);");
					altaMerma.setInt(1, cla);
					altaMerma.setInt(2, exisB1);
					altaMerma.setInt(3, exisB2);
					altaMerma.setDouble(4, exisC);
					altaMerma.setString(5, hoy);
					altaMerma.setInt(6, 2);

					altaMerma.execute();


						String updateexistencia = "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1-"+exisB1+", inventarioBotella2 = inventarioBotella2-"+exisB2+", inventarioCopeo = inventarioCopeo-"+exisC+" WHERE clave = "+cla+"";
						//System.out.println(updateexistencia);
						Statement stmt = con.creaStatement();
						stmt.execute(updateexistencia);

				}

				con.realizaCommit();
			}
			catch (SQLException sqle) {
				fin = false;
		 		con.realizaRollback();
		 		sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerInventarios";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
		 		con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
				 	con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerInventarios metodo add_Mermas_B");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida. En ManagerInventarios";
			throw new Exception(error);
		}
	 return fin;
	}




/**
* El método update_Traspaso se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public boolean update_Traspaso(String clave, String cantidad, String tipo) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;

		int can = cambiaAInt(cantidad);
		int cla = cambiaAInt(clave);
		String aver = "";
		ResultSet rs = null;

		con = new ConexionBD();
		con.cancelaAutoCommit();

		if (con.miConnection != null) {
			try {
					double lxb = 0.0;

					if(tipo.equalsIgnoreCase("C")){

          				String queryString = ("SELECT litrosXBotella1 FROM materiaprima  WHERE clave = "+cla+"");
          				Statement stmt = con.miConnection.createStatement();
          				rs = stmt.executeQuery(queryString);
          				while(rs.next()){

							lxb = rs.getDouble("litrosXBotella1");
						}

						lxb = lxb * can;

						String updateexistencia2 = "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1-"+can+", inventarioCopeo = inventarioCopeo+"+lxb+" WHERE clave = "+clave+"";
						Statement stmt3 = con.creaStatement();
						stmt3.execute(updateexistencia2);
					}

					if(tipo.equalsIgnoreCase("D")){

          				String queryString = ("SELECT litrosXBotella2 FROM materiaprima  WHERE clave = "+cla+"");
          				Statement stmt = con.miConnection.createStatement();
          				rs = stmt.executeQuery(queryString);
          				while(rs.next()){

							lxb = rs.getDouble("litrosXBotella2");
						}

						lxb = lxb * can;

						String updateexistencia2 = "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2-"+can+", inventarioCopeo = inventarioCopeo+"+lxb+" WHERE clave = "+clave+"";
						Statement stmt3 = con.creaStatement();
						stmt3.execute(updateexistencia2);
					}


				con.realizaCommit();
			}
			catch (SQLException sqle) {
				fin = false;
		 		con.realizaRollback();
		 		sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerInventarios---update_Traspaso";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
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
			error = "Exception: Conexión a la Base de Datos perdida. En ManagerInventarios----update_Traspaso";
			throw new Exception(error);
		}
	 return fin;
	}



/**
* El Método todosLosProductosConInv  nos da el listado de todos los productos con su existencia en Inventarios
*
*  @return ResultSet con el listado correspondiente.
*/
	public ResultSet todosLosProductosConInv(String tipo) throws SQLException, Exception{
		ResultSet rs = null;
		int tip = cambiaAInt(tipo);
		try{
			String query = ("SELECT materiaprima.clave, materiaprima.tipo, materiaprima.tipoA, materiaprima.nombre AS descripcion, materiaprima.litrosXBotella1, materiaprima.litrosXBotella2, materiaprima.costoKG, materiaprima.costoUnidad, materiaprima.costoBotella1, materiaprima.costoBotella2, materiaprima.inventarioKg, materiaprima.inventarioUnidad, materiaprima.inventarioBotella1, materiaprima.inventarioBotella2, materiaprima.inventarioCopeo FROM materiaprima WHERE materiaprima.tipo = "+tip+" AND materiaprima.estatus = 1 ORDER BY materiaprima.nombre");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVenta, todosLosProductosConInv ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVenta, todosLosProductosConInv ");
			e.printStackTrace();
		}
		return rs;
	}




/**
* El Método InventarioFisico nos muestra todos los Productos con su clave registradas en el Sistema
* @return rs ResultSet que contiene toda la información de todos los Productos.
*/
	public ResultSet InventarioFisico(String clave) throws SQLException, Exception{
		ResultSet rs = null;
		int cla = cambiaAInt(clave);
		try{
			String query = ("SELECT clave, nombre, tipoA FROM materiaprima WHERE tipo = "+cla+" AND estatus = 1 ORDER BY nombre;");
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
* El método Mermas_Mes se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	clave		String con la Clave del Producto solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Producto.
*/
 public ResultSet Mermas_Mes(String fecha) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT mermas.* FROM mermas  WHERE mermas.fecha like '"+fecha+"'");
          //System.out.println(queryString);
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
* El método Mermas_Mes_B se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	clave		String con la Clave del Producto solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Producto.
*/
 public ResultSet Mermas_Mes_B(String fecha) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT mermasB.* FROM mermasB  WHERE mermasB.fecha like '"+fecha+"'");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Mermas_Mes_B.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Mermas_Mes_B.";
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
* El método dameTraspasosAutomaticos se encarga de enviar la información de las Ordenes de Compra realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Ordenes de Compra
*/

	public ResultSet dameTraspasosAutomaticos(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT * FROM traspasoautomatico WHERE Fecha like '" +fecha+"%%%%%%%%%%%'");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameTraspasosAutomaticos.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameTraspasosAutomaticos.";
			throw new Exception(error);
		}
	return rs;
	}



 public void cierraConexion() throws SQLException, Exception
 {
	 if(con != null){
		try{
			con.cierraConexion();
		}
		catch (Exception q){
		System.out.println("Error al momento de cerrar conexion en ManagerPersonal, datosUsuario ");
		q.printStackTrace();
		}
	}

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