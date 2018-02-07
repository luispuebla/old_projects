package com.ult.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerClientes" es la encargada de administrar los datos correspondientes a los Clientes como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Marzo 2006)
*/

public class ManagerClientes {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerClientes es el constructor vacio de la clase.
*/

  public ManagerClientes()   { }



/**
* El método existe verifica que el cliente solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del cliente solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean existe(String rfc) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from clientes WHERE activo = 1");
  	  		while(rs.next()){

  	  			if(rfc.equalsIgnoreCase(rs.getString("rfc"))) {
  	  				bandera = true;//realiza comparación con la base de datos
  	  				}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerClientes metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



/**
* El método existe2 verifica que el Cliente solicitado existe dentro de nuestra Base de Datos y se encuentre habilitado, es decir que no haya sido dado de baja.
*  	@param rfc  		String con el rfc del Cliente solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public int existe2(String rfc) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
  	  String estatus = "1";
	  con = new ConexionBD();

  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.miConnection.createStatement();
  	  		rs = st.executeQuery("select * from clientes WHERE rfc = '"+rfc+"' AND activo ='1'");
  	  		while(rs.next()){

  	  			if(estatus.equalsIgnoreCase(rs.getString("activo"))){
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
	  		 		System.out.println("Error al cerrar conexion de ManagerClientes metodo existe2");
	  		 		q.printStackTrace();
	  			}
			 }
  	  }
  	  return bandera;
  }



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
  public int valida_add(String rfc, String nombre, String direccion, String colonia, String delegacion, String cp, String ciudad) {
		int verifica = 2;
		boolean revisa = ((rfc != null) && (rfc.length() > 0) &&
				(nombre != null) && (nombre.length() > 0) &&
				(direccion != null) && (direccion.length() > 0) &&
				(colonia != null) && (colonia.length() > 0) &&
				(delegacion != null) && (delegacion.length() > 0) &&
				(ciudad != null) && (ciudad.length() > 0) &&
				(cp != null) && (cp.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método add_Cliente se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public boolean add_Cliente(String rfc, String curp, String nombre, String direccion, String colonia, String delegacion, String cp, String ciudad, String tel1, String tel2, String fax, String email, String contacto, String folio) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;

		tiempo = new TimeStamp();
		String hoy = tiempo.date;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement updateCliente;
				updateCliente = con.miConnection.prepareStatement("insert into clientes values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				updateCliente.setString(1, rfc);
				updateCliente.setString(2, curp);
				updateCliente.setString(3, nombre);
				updateCliente.setString(4, direccion);
				updateCliente.setString(5, colonia);
				updateCliente.setString(6, delegacion);
				updateCliente.setString(7, cp);
				updateCliente.setString(8, ciudad);
				updateCliente.setString(9, tel1);
				updateCliente.setString(10, tel2);
				updateCliente.setString(11, fax);
				updateCliente.setString(12, email);
				updateCliente.setString(13, contacto);
				updateCliente.setString(14, hoy);
				updateCliente.setInt(15, 1);
				updateCliente.setString(16, folio);


				updateCliente.execute();
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
					System.out.println("Error al cerrar conexion de ManagerClientes metodo add_Cliente");
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
  * El método baja_Cliente se encarga de colocar un 0 en el campo "activo" del Cliente en la Base de Datos, para realizar una Baja lógica del Cliente correspondiente.
  *  	@param 	rfc		String con el RFC del Cliente solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
  public boolean baja_Cliente(String rfc) throws SQLException, Exception {
              ResultSet rs = null;
              boolean bandera = false;
              con = new ConexionBD();
              try  {

               String queryString = "UPDATE clientes SET activo ='0' WHERE rfc ='"+rfc+"'";
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
			   		System.out.println("Error al cerrar conexion de ManagerClientes metodo baja_Cliente");
			   		q.printStackTrace();
			  	}
			 }
              return bandera;
        }



/**
* El método update_Cliente se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Cliente(String rfc, String curp, String nombre, String direccion, String colonia, String delegacion, String cp, String ciudad, String tel1, String tel2, String fax, String email, String contacto, String folio) throws SQLException, Exception {

	  boolean fin = true;
	  ResultSet rs = null;
	  con = new ConexionBD();

            try  {
				String queryString = "UPDATE clientes SET nombre = '"+nombre+"', curp = '"+curp+"', direccion = '"+direccion+"', colonia = '"+colonia+"', delegacion = '"+delegacion+"', cp = '"+cp+"', ciudad = '" +ciudad+"', tel1 = '" +tel1+"', tel2 = '" +tel2+"', fax = '" +fax+"', email = '" +email+"', contacto = '" +contacto+"', folio = '" +folio+"' WHERE rfc = '"+rfc+"' AND activo = 1" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Cliente.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Cliente.";
              throw new Exception(error);
            }
		return fin;
    }




/**
* El método datos_Cliente se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Cliente.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Cliente.
*/
 public ResultSet datos_Cliente(String rfc) throws SQLException, Exception
 {
	 	//System.out.println("Llego como RFC:" +rfc);
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM clientes WHERE rfc = '"+rfc+"' AND activo = 1 LIMIT 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Cliente.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Cliente.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método dameClientes se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Clientes que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Clientes.
*/
  public ResultSet dameClientes() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM clientes WHERE activo = '"+estatus+"' ORDER BY nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameClientes.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameClientes.";
            throw new Exception(error);
          }
          return rs;
  }



/**
* El método nombreCliente se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public String nombreCliente(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT nombre FROM clientes WHERE rfc = '"+clave+"'");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("nombre");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query nombreCliente.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving nombreCliente.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerProveedores metodo nombreCliente");
		   		q.printStackTrace();
		  	}
		}
        return nombre;
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