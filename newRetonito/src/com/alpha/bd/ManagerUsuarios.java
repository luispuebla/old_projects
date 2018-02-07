package com.alpha.bd;

import com.alpha.bd.DateStamp;
import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerClientes" es la encargada de administrar los datos correspondientes a los Usuarios como son Altas, Bajas, Consultas, etc.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Agosto 2005)
*/

public class ManagerUsuarios {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();


/**
* El método ManagerUsuarios es el constructor vacio de la clase.
*/

  public ManagerUsuarios()   { }


  public boolean Valida_Pass_Nuevo( String pass, String pass2, String pass3) {
  		return ((pass != null) && (pass.length() > 0) &&
  				(pass2 != null) && (pass2.length() > 0) &&
  				(pass3 != null) && (pass3.length() > 0));

  }


	public int cambioContraTipo(String pass, String pass2)   throws SQLException, Exception  {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 2; // EXITO!
		con = new ConexionBD();
		if (con.miConnection !=null)	{
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT * FROM permisos WHERE Tipo = 1 LIMIT 1");
				while(rs.next()){
					if(rs.getString("Clave").equalsIgnoreCase(pass)){
						Statement st2 = con.creaStatement();
						st2.execute("UPDATE permisos SET Clave = "+cambiaAInt(pass2.trim())+" WHERE Tipo = 1");
						st2.close();
					}
					else{
						bandera = 1; // No concuerda la Contraseña anterior
					}
				}
				rs.close();
				st.close();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		else{
			bandera = 0;
		}
		return bandera;
	}


	public int cambioContraDirecta(String pass, String pass2)   throws SQLException, Exception  {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 2; // EXITO!
		con = new ConexionBD();
		if (con.miConnection !=null)	{
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT * FROM permisos WHERE Tipo = 2 LIMIT 1");
				while(rs.next()){
					if(rs.getString("Clave").equalsIgnoreCase(pass)){
						Statement st2 = con.creaStatement();
						st2.execute("UPDATE permisos SET Clave = "+cambiaAInt(pass2.trim())+" WHERE Tipo = 2");
						st2.close();
					}
					else{
						bandera = 1; // No concuerda la Contraseña anterior
					}
				}
				rs.close();
				st.close();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		else{
			bandera = 0;
		}
		return bandera;
	}

/**
* El método existe verifica que el usuario solicitado existe dentro de nuestra Base de Datos.
*  	@param 	nombre 		String con el nombre del usuario solicitado.
*	@return bandera 	Int si es igual 0 el usuario no exite y si es igual a 1 el usuario se encuentra en la Base de Datos.
*/

public int existe(String nombre) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from usuario WHERE estatus = 1");
  	  		while(rs.next()){

  	  			if(nombre.equalsIgnoreCase(rs.getString("NombreE"))) {
  	  				bandera = 1;//realiza comparación con la base de datos
  	  				}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerUsuarios metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }

  /**
  * El método existe verifica que el usuario solicitado existe dentro de nuestra Base de Datos.
  *  	@param 	nombre 		String con el nombre del usuario solicitado.
  *	@return bandera 	Int si es igual 0 el usuario no exite y si es igual a 1 el usuario se encuentra en la Base de Datos.
  */

	public int existe(String nombre, String clave) throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("select * from usuario WHERE estatus = 1 AND claveVenta !=" +cambiaAInt(clave));
				while(rs.next()){
					if(nombre.equalsIgnoreCase(rs.getString("NombreE"))) {
						bandera = 1;//realiza comparación con la base de datos
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
					System.out.println("Error al cerrar conexion de ManagerUsuarios metodo existe");
					q.printStackTrace();
				}
			}
		}
	return bandera;
	}

/**
* El método existe2 verifica que el usuario solicitado existe dentro de nuestra Base de Datos.
*  	@param 	clave 		String con la clave del usuario solicitado.
*	@return bandera 	Int si es igual 0 el usuario no exite y si es igual a 1 el usuario se encuentra en la Base de Datos.
*/

public int existe2(String clave) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
  	  int cla = cambiaAInt(clave);
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from usuario WHERE claveVenta = "+cla+" AND estatus = 1");
  	  		while(rs.next()){

  	  			if(clave.equalsIgnoreCase(rs.getString("claveVenta"))) {
  	  				bandera = 1;//realiza comparación con la base de datos
  	  				}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerUsuarios metodo existe2");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }


/**
* El método add_Venedor se encarga de añadir los datos de un nuevo Usuario dentro de la Base de Datos.
*	@param 	nombre		String con el Nombre del Usuario
*/
	public boolean add_Venedor(String nombre, String permiso, String clavePermiso) throws SQLException, Exception {
		boolean exito = true;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement addUsuario;
				addUsuario = con.miConnection.prepareStatement("insert into usuario values(?, ?, ?, ?, ?, ?, ?, ?);");
				addUsuario.setString(1, "***");
				addUsuario.setNull(2, java.sql.Types.VARCHAR);
				addUsuario.setString(3, "Ventas");
				addUsuario.setString(4, nombre);
				addUsuario.setNull(5, java.sql.Types.INTEGER);
				addUsuario.setInt(6, cambiaAInt(clavePermiso));
				addUsuario.setInt(7, cambiaAInt(permiso));
				addUsuario.setInt(8, 1);
				addUsuario.execute();
				//System.out.println("todo bien");
			}
			catch (SQLException sqle) {
				exito = false;
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada";
				throw new SQLException(error);
			}
			catch (Exception q){
				exito = false;
				q.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerUsuarios metodo add_Venedor");
					q.printStackTrace();
				}
			}
		}
		else {
			exito = false;
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
		return exito;
	}

/**
* El método dameClave se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Vendedor.
*  	@param 	nombre 		String con el Nombre del Vendedor solicitado.
*	@return nom			String que contiene todos el Nombre del Vendedor.
*/
 public String dameClave(String nombre) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nom = new String();
        //System.out.println("Llego: +"nombre);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM usuario WHERE NombreE = '"+nombre+"' AND estatus = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){

			  nom = rs.getString("claveVenta");
		  }
        }
        catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameClave.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameClave.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerUsuarios metodo dameClave");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println("Clave: "+nom);
        return nom;
  }

	public boolean actualizaUser(String claveU, String nombre, String  permiso, String claveP) throws Exception{
		boolean exito = true;
		con = new ConexionBD();
		try  {
			String queryString = "UPDATE usuario SET NombreE = '"+nombre +"', permisoCobro = "+cambiaAInt(permiso) +", clavePermiso = "+cambiaAInt(claveP) +" WHERE claveVenta = "+cambiaAInt(claveU);
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
		}
		catch (SQLException sqle) {
			exito = false;
			System.out.println("Error Clase ManagerUsuarios, metodo actualizaUser");
			sqle.printStackTrace();
		}
		catch (Exception e) {
			exito = false;
			System.out.println("Error Clase ManagerUsuarios, metodo actualizaUser" );
			e.printStackTrace();
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
			}
		}
		return exito;
	}

  /**
  * El método baja_Usuario se encarga de colocar un 0 en el campo "estatus" del Usuario en la Base de Datos, para realizar una Baja lógica del Vendedor correspondiente.
  *  	@param 	clave	String con la Clave de Venta del Usuario solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
  public int baja_Usuario(String clave) throws SQLException, Exception {
              ResultSet rs = null;
              int bandera = 0;
              int cla = cambiaAInt(clave);
              con = new ConexionBD();
              try  {

               String queryString = "UPDATE usuario SET estatus = 0 WHERE claveVenta = "+cla+" AND estatus = 1";
      		  Statement stmt = con.miConnection.createStatement();
      		  stmt.execute(queryString);
      		  bandera = 1;

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
			   		System.out.println("Error al cerrar conexion de ManagerClientes metodo baja_Usuario");
			   		q.printStackTrace();
			  	}
			 }
              return bandera;
        }



/**
* El método dameUsuarios se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Usuarios que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Usuarios.
*/
  public ResultSet dameUsuarios() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM usuario WHERE tipo = 'ventas' AND estatus = 1 ORDER BY NombreE");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameUsuarios.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameUsuarios.";
            throw new Exception(error);
          }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerUsuarios metodo dameUsuarios");
			   		q.printStackTrace();
			 	}
		   }
          return rs;
  }

  public ResultSet dameUsuario(String claveU) throws SQLException, Exception {
	  ResultSet rs = null;
	  con = new ConexionBD();
	  try  {
		String queryString = ("SELECT * FROM usuario WHERE claveVenta= "+cambiaAInt(claveU) +" AND tipo = 'ventas' AND estatus = 1 ORDER BY NombreE");
		Statement stmt = con.miConnection.createStatement();
		rs = stmt.executeQuery(queryString);
	  } catch (SQLException sqle) {
		error = "SQLException: Could not execute the query dameUsuarios.";
		throw new SQLException(error);
	  } catch (Exception e) {
		error = "An exception occured while retrieving dameUsuarios.";
		throw new Exception(error);
	  }
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerUsuarios metodo dameUsuarios");
				q.printStackTrace();
			}
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

}