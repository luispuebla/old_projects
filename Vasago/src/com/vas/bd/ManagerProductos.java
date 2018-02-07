package com.vas.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerProductos" es la encargada de administrar los datos correspondientes a los Productos como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Mayo 2006)
*/

public class ManagerProductos {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerProductos es el constructor vacio de la clase.
*/

  public ManagerProductos()   { }


/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@param 	ciudad		String con la Ciudad del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add(String linea, String marca,String tipo, String proveedor1, String descripcion, String pxc, String costo, String p1, String p2, String p3, String p4, String p5,String existencia) {
		int verifica = 2;
		boolean revisa = true;
		if (tipo.equals("1")){
			revisa = ((linea != null) && (linea.length() > 0) &&
				(marca != null) && (marca.length() > 0) &&
				(proveedor1 != null) && (proveedor1.length() > 0) &&
				(descripcion != null) && (descripcion.length() > 0) &&
				(pxc != null) && (pxc.length() > 0) &&
				(costo != null) && (costo.length() > 0) &&
				(p1 != null) && (p1.length() > 0) &&
				(p2 != null) && (p2.length() > 0) &&
				(p3 != null) && (p3.length() > 0) &&
				(p4 != null) && (p4.length() > 0) &&
				(p5 != null) && (p5.length() > 0) &&
				(existencia != null) && (existencia.length() > 0));
		}
		else{
			revisa = ((linea != null) && (linea.length() > 0) &&
				(marca != null) && (marca.length() > 0) &&
				(proveedor1 != null) && (proveedor1.length() > 0) &&
				(descripcion != null) && (descripcion.length() > 0) &&
				(costo != null) && (costo.length() > 0) &&
				(p1 != null) && (p1.length() > 0) &&
				(p2 != null) && (p2.length() > 0) &&
				(p3 != null) && (p3.length() > 0) &&
				(p4 != null) && (p4.length() > 0) &&
				(p5 != null) && (p5.length() > 0) &&
				(existencia != null) && (existencia.length() > 0));
		}
		if(revisa){
			verifica = 1;
		}
		System.out.println("Regreso el verifica: " +verifica);
		return verifica;
  }

/**
* El método valida_add2 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@param 	ciudad		String con la Ciudad del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add2(String clave, String tipo,  String proveedor1, String descripcion, String pxc, String costo, String p1, String p2, String p3, String p4, String p5) {
		int verifica = 2;
		boolean revisa = true;
		if (tipo.equals("1")){
			revisa = ((clave != null) && (clave.length() > 0) &&
				(proveedor1 != null) && (proveedor1.length() > 0) &&
				(descripcion != null) && (descripcion.length() > 0) &&
				(pxc != null) && (pxc.length() > 0) &&
				(costo != null) && (costo.length() > 0) &&
				(p1 != null) && (p1.length() > 0) &&
				(p2 != null) && (p2.length() > 0) &&
				(p3 != null) && (p3.length() > 0) &&
				(p4 != null) && (p4.length() > 0) &&
				(p5 != null) && (p5.length() > 0));
		}
		else{
			revisa = ((clave != null) && (clave.length() > 0) &&
				(proveedor1 != null) && (proveedor1.length() > 0) &&
				(descripcion != null) && (descripcion.length() > 0) &&
				(costo != null) && (costo.length() > 0) &&
				(p1 != null) && (p1.length() > 0) &&
				(p2 != null) && (p2.length() > 0) &&
				(p3 != null) && (p3.length() > 0) &&
				(p4 != null) && (p4.length() > 0) &&
				(p5 != null) && (p5.length() > 0));
		}
		if(revisa){
			verifica = 1;
		}
		return verifica;
  }


/**
* El método add_Producto se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public boolean add_Producto(String linea, String marca, String tipo, String proveedor1, String proveedor2, String proveedor3, String proveedor4,String proveedor5, String descripcion, String pxc, String costo, String precio1, String precio2, String precio3, String precio4, String precio5, String maximo, String minimo, String existencia) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;

		costo = remueveComas(costo);
		precio1 = remueveComas(precio1);
		precio2 = remueveComas(precio2);
		precio3 = remueveComas(precio3);
		precio4 = remueveComas(precio4);
		precio5 = remueveComas(precio5);

		double co = cambiaADouble(costo);
		double p1 = cambiaADouble(precio1);
		double p2 = cambiaADouble(precio2);
		double p3 = cambiaADouble(precio3);
		double p4 = cambiaADouble(precio4);
		double p5 = cambiaADouble(precio5);
		double piezas = cambiaADouble(pxc);
		double max = cambiaADouble(maximo);
		double min = cambiaADouble(minimo);
		double exis = cambiaADouble(existencia);

		String clave = claveProducto(linea,marca);
		//System.out.println(clave);
		//System.out.println(clave);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement altaProducto;
				altaProducto = con.miConnection.prepareStatement("insert into productos values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				altaProducto.setString(1, clave);
				altaProducto.setString(2, linea);
				altaProducto.setString(3, marca);
				altaProducto.setInt(4, cambiaAInt(tipo));
				altaProducto.setString(5, proveedor1);
				altaProducto.setString(6, proveedor2);
				altaProducto.setString(7, proveedor3);
				altaProducto.setString(8, proveedor4);
				altaProducto.setString(9, proveedor5);
				altaProducto.setString(10, descripcion);
				altaProducto.setDouble(11, co);
				altaProducto.setDouble(12, p1);
				altaProducto.setDouble(13, p2);
				altaProducto.setDouble(14, p3);
				altaProducto.setDouble(15, p4);
				altaProducto.setDouble(16, p5);
				altaProducto.setDouble(17, max);
				altaProducto.setDouble(18, min);
				altaProducto.setDouble(19, exis);
				altaProducto.setDouble(20, piezas);
				altaProducto.setInt(21, 1);
				altaProducto.setInt(22, 0);

				altaProducto.execute();
				fin = true;
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada";
				throw new SQLException(error);
			}
			catch (Exception q){
				q.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerProductos metodo add_Producto");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
	 return fin;
	}


/**
* El método claveProducto se encarga de crear la Clave del Producto de acuerdo a la Marca, Línea, Sublína y consecutivo del conjunto.
*	@return valor 		String con la Clave del Producto Nuevo.
*/
	public String claveProducto(String linea, String marca) throws Exception{
		String valor = new String();
		String conse = new String();
		try{
			valor = linea+marca;
			conse = ultimo(valor);
			valor = valor+conse;
		}
		catch(Exception e){
			String error = "Ocurrio una excepcion mientras se obtenia la Clave del Producto."+e;
			throw new Exception(error);
		}
			return valor;
	}


/**
* El método ultimo se encarga de regresar el ultimo consecutivo correspondiente al conjunto de Línea, SubLínea y Marca para la Clave de un nuevo Producto.
*	@return ultima 		String con el siguiente consecutivo.
*/

	public String ultimo(String empieza) throws SQLException, Exception {
		int consecutivo = 1;
		String ultima = "";
		ResultSet rt = null;
		Statement stmt = null;
		try  {
			con = new ConexionBD();
			String queryString = "SELECT * FROM productos WHERE claveProducto like '"+empieza+"%%'";
			//System.out.println(queryString);
			stmt = con.creaStatement();
			rt = stmt.executeQuery(queryString);
			while(rt.next()){
				consecutivo++;
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: Could not execute the query ultimo.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se obtenia la ultima clave del Producto."+e;
			throw new Exception(error);
		}
		finally{
			if(con != null){
				try{
					if(stmt != null){
						stmt.close();
					}
					if(rt != null){
						rt.close();
					}
					con.cierraConexion();
				}
				catch (Exception e){
					e.printStackTrace();
				}
			}
		}
		if(consecutivo > 0){
			ultima = String.valueOf(consecutivo);
		}
		ultima = checkSize(ultima);
		return ultima;
	}

/**
* El método productosBaja se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los productos que dentro de su cavle tengar el orden de linea+sublinea+marca solicitado.
*  	@param 	linea	String con la línea solicitada.
*  	@param 	subinea	String con la sublínea solicitada.
*  	@param 	marca	String con la marca solicitada.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a la solicitud.
*/
 public ResultSet productosBaja(String linea, String marca) throws SQLException, Exception
 {
        ResultSet rs = null;
        String clave = linea+marca;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM productos WHERE claveProducto like '"+clave+"%%' AND activo = 1 ORDER BY claveProducto");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query productosBaja.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving productosBaja.";
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
		   		System.out.println("Error al cerrar conexion de ManagerProductos");
		   		q.printStackTrace();
		  	}
		}
	}

/**
* El método descripcionProducto se encarga de enviar el Nombre de la Línea registrado dentro de la Base de Datos correspondientes a una Línea.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public String descripcionProducto(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT CONCAT(linea.nombre,' ',marca.nombre,' ',productos.descripcion) AS descripcion FROM productos, linea, marca WHERE productos.claveProducto = '"+clave+"' AND marca.clave = productos.marca AND linea.clave = productos.linea");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
          while(rs.next()){
		  		nombre = rs.getString("descripcion");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query descripcionProducto.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving descripcionProducto.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerProductos metodo descripcionProducto");
		   		q.printStackTrace();
		  	}
		}
        return nombre;
  }

  /**
  * El método bajaProducto se encarga de colocar un 0 en el campo "activo" del Producto en la Base de Datos, para realizar una Baja lógica del Producto correspondiente.
  *  	@param 	clave	String con la Clave del Producto solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
  public boolean bajaProducto(String clave) throws SQLException, Exception {
              ResultSet rs = null;
              boolean bandera = false;
              con = new ConexionBD();
              try  {

               String queryString = "UPDATE productos SET activo ='0' WHERE claveProducto ='"+clave+"'";
      		  Statement stmt = con.miConnection.createStatement();
      		  stmt.execute(queryString);
      		  bandera = true;

              } catch (SQLException sqle) {
                error = "SQLException: Could not execute the query.";
                throw new SQLException(error);
              } catch (Exception e) {
                error = "An exception occured while retrieving.";
                throw new Exception(error);
              }
              finally{
			   	try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerProductos metodo bajaProducto");
			   		q.printStackTrace();
			  	}
			 }
              return bandera;
        }

/**
* El método datos_Producto se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Producto.
*  	@param 	clave		String con la Clave del Producto solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Producto.
*/
 public ResultSet datos_Producto(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM productos WHERE claveProducto = '"+clave+"' AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Producto.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Producto.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método update_Producto se encarga de actualizar los datos de un Producto dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Producto(String clave, String tipo, String proveedor1, String proveedor2, String proveedor3, String proveedor4, String proveedor5, String descripcion, String pxc, String costo, String pe1, String pe2, String pe3, String pe4, String pe5, String max, String min) throws SQLException, Exception {

	  boolean fin = false;

	  costo = remueveComas(costo);
	  pe1 = remueveComas(pe1);
	  pe2 = remueveComas(pe2);
	  pe3 = remueveComas(pe3);
	  pe4 = remueveComas(pe4);
	  pe5 = remueveComas(pe5);

	  double ma = cambiaADouble(max);
	  double mi = cambiaADouble(min);
	  int piezas = cambiaAInt(pxc);
	  double cos = cambiaADouble(costo);
	  double p1 = cambiaADouble(pe1);
	  double p2 = cambiaADouble(pe2);
	  double p3 = cambiaADouble(pe3);
	  double p4 = cambiaADouble(pe4);
	  double p5 = cambiaADouble(pe5);

	  con = new ConexionBD();
            try  {
				String queryString = "UPDATE productos SET tipo = "+tipo+", proveedor1 = '"+proveedor1+"', proveedor2 = '"+proveedor2 +"', proveedor3 = '"+proveedor3 +"', proveedor4 = '"+proveedor4 +"', proveedor5 = '"+proveedor5 +"', descripcion = '"+descripcion+"', costo = "+cos+", precio1 = "+p1+", precio2 = " +p2+", precio3 = " +p3+", precio4 = " +p4+", precio5 = " +p5+", maximo = " +ma+", minimo = " +mi+", piezasXcaja = " +piezas+" WHERE claveProducto = '"+clave+"' AND activo = 1" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              fin = true;
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query update_Producto.";
              throw new SQLException(error);
            } catch (Exception e) {
              error = "Ocurrió una excepción mientras se actualizaba update_Producto.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerProductos metodo update_Producto");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }


/**
* El método update_Iva se encarga de actualizar los datos de los Productos que agravan IVA para identificarlos dentro de la Base de Datos.
*  	@param 	plu  		String con el PLU del Producto a actualizar.
*	@return todobien	Entero que indica un 0 si los datos fueron ingresados correctamente y 1 de ser lo contrario.
*/
  public int update_Iva(String clave) throws SQLException, Exception {
            int todobien = 1;
            con = new ConexionBD();

            try  {
				String queryString = "UPDATE productos SET iva = 1 WHERE claveProducto = '"+clave+"' ";
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

          String clave = new String();

          while(rs.next()){
          	clave = rs.getString("claveProducto");
          	String queryString = "UPDATE productos SET iva = 0 WHERE claveProducto = '"+clave+"' ";
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
* El Método todosLosProductos nos muestra todos los Productos con su clave registradas en el Sistema
* @return rs ResultSet que contiene toda la información de todos los Productos.
*/
	public ResultSet todosLosProductos() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM productos WHERE activo = 1 ORDER BY claveProducto;");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProductos, todosLosProductos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProductos, todosLosProductos ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método todosLosProductos2 nos muestra todos los Productos con su clave registradas en el Sistema
* @return rs ResultSet que contiene toda la información de todos los Productos.
*/
	public ResultSet todosLosProductos2() throws SQLException, Exception{
		ResultSet rs = null;
		try{
			String query = ("SELECT pro.claveProducto, pro.descripcion, li.nombre AS Nombre_Linea, ma.nombre AS Nombre_Marca FROM productos pro, marca ma, linea li WHERE pro.activo = 1 AND ma.clave = pro.marca AND li.clave = pro.linea ORDER BY pro.claveProducto");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProductos, todosLosProductos2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProductos, todosLosProductos2 ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método Lista_Precios nos regresa la Lista de Precios para Ventas.
*
*  @return rs ResultSet con la Lista de Precios.
*/
	public ResultSet Lista_Precios()throws SQLException, Exception{
		ResultSet rs = null;
		try{

			String query = ("SELECT pro.claveProducto, pro.descripcion, pro.precio1, pro.precio2, pro.precio3, pro.precio4, pro.precio5, li.nombre AS Nombre_Linea, ma.nombre AS Nombre_Marca FROM productos pro, marca ma, linea li WHERE pro.activo = 1 AND ma.clave = pro.marca AND li.clave = pro.linea ORDER BY pro.claveProducto");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProductos, Lista_Precios ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProductos, Lista_Precios ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método Lista_Costos nos regresa la Lista de Costos.
*
*  @return rs ResultSet con la Lista de Costos.
*/
	public ResultSet Lista_Costos()throws SQLException, Exception{
		ResultSet rs = null;
		try{

			String query = ("SELECT pro.claveProducto, pro.descripcion, pro.costo, li.nombre AS Nombre_Linea, ma.nombre AS Nombre_Marca FROM productos pro, marca ma, linea li WHERE pro.activo = 1 AND ma.clave = pro.marca AND li.clave = pro.linea ORDER BY pro.claveProducto");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerProductos, Lista_Costos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerProductos, Lista_Costos ");
			e.printStackTrace();
		}
		return rs;
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
			StringBuilder verificador = new StringBuilder(revisa);
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