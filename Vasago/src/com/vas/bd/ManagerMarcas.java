package com.vas.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerMarcas" es la encargada de administrar los datos correspondientes a las Líneas como son Altas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Abril 2006)
*/

public class ManagerMarcas {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerMarcas es el constructor vacio de la clase.
*/

  public ManagerMarcas()   { }


/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Teléfono del Proveedor.
*/
  public int valida_add(String clave, String nombre) {
		int verifica = 2;
		boolean revisa = ((clave != null) && (clave.length() > 0) &&
				(nombre != null) && (nombre.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }


/**
* El método existe verifica que la Clave de la Línea solicitado existe dentro de nuestra Base de Datos.
*  	@param 	clave  		String con la Clave de la Línea solicitada.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean existe(String clave) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from marca");
  	  		while(rs.next()){

  	  			if(clave.equalsIgnoreCase(rs.getString("clave"))) {
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
					System.out.println("Error al cerrar conexion de ManagerMarcas metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }


/**
* El método add_Marca se encarga de añadir los datos de una nueva Marca dentro de la Base de Datos.
*  	@param 	clave  		String con la clave de la Marca.
*	@param 	nombre		String con el Nombre de la Marca.
*/
	public boolean add_Marca(String clave, String nombre) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {

				PreparedStatement altaMarca;
				altaMarca = con.miConnection.prepareStatement("insert into marca values(?,?);");
				altaMarca.setString(1, clave);
				altaMarca.setString(2, nombre);


				altaMarca.execute();
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
					System.out.println("Error al cerrar conexion de ManagerMarcas metodo add_Marca");
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
* El método dameMarcas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Proveedores que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Proveedores.
*/
  public ResultSet dameMarcas() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM marca ORDER BY nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameMarcas.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameMarcas.";
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
				System.out.println("Error al cerrar conexion de ManagerMarcas metodo dameMarcas");
				q.printStackTrace();
			}
	   }
	}

/**
* El método nombreMarca se encarga de enviar el Nombre de la Marca registrado dentro de la Base de Datos correspondientes a una Marca.
*  	@param 	clave  		String con la Clave de la Marca Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Marca.
*/
 public String nombreMarca(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT nombre FROM marca WHERE clave = '"+clave+"'");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("nombre");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query nombreMarca.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving nombreMarca.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerMarcas metodo nombreMarca");
		   		q.printStackTrace();
		  	}
		}
        return nombre;
  }

/**
* El método datos_Marca se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a una MArca.
*  	@param 	clave  		String con la Clave de la Marca Solicitada.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a una Marca.
*/
 public ResultSet datos_Marca(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM marca WHERE clave = '"+clave+"'");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Marca.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Marca.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método update_Marca se encarga de actualizar los datos de una Marca dentro de la Base de Datos.
*  	@param 	clave  		String con la Clave de la Marca a actualizar.
*	@param 	nombre		String con el Nombre de la Marca.
*/
  public boolean update_Marca(String clave, String nombre) throws SQLException, Exception {

	  boolean fin = false;

	  con = new ConexionBD();
            try  {
				String queryString = "UPDATE marca SET nombre = '"+nombre+"' WHERE clave = '"+clave+"'" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              fin = true;
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query update_Marca.";
              throw new SQLException(error);
            } catch (Exception e) {
              error = "Ocurrió una excepción mientras se actualizaba update_Marca.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerMarcas metodo update_Marca");
			   		q.printStackTrace();
			 	}
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