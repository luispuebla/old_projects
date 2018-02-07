package com.ult.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerVentas" es la encargada de administrar los datos correspondientes a los Productos como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Mayo 2006)
*/

public class ManagerConsultas {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerVentas es el constructor vacio de la clase.
*/

  public ManagerConsultas()   { }




	public boolean almacenaDescuento(String [][] datos, String comanda, int numComensales) throws SQLException, Exception{
		boolean exito = true;
		boolean yaHayEntrada = false;
		int cantidadMaximaEP = 0;
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				ResultSet rs = null;
				String queryExistenciaD = "SELECT MAX(numComensal)AS maximo FROM descuentos WHERE comanda = "+comanda +" LIMIT 1";
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryExistenciaD);
				while(rs.next()){
					yaHayEntrada = true;
					cantidadMaximaEP = rs.getInt("maximo");
				}
				if(yaHayEntrada){
					String queryBorra = "DELETE FROM descuentos WHERE comanda = "+comanda;
					Statement stmtB = con.creaStatement();
					stmtB.execute(queryBorra);
				}
				for(int i = 0; i<numComensales; i++){
					int porcentajeD = cambiaAInt(datos[i][1].trim());
					if(porcentajeD > 100){
						porcentajeD = 100;
					}
					PreparedStatement updateAltaDescuento;
					updateAltaDescuento = con.miConnection.prepareStatement("insert into descuentos values(?,?,?);");
					updateAltaDescuento.setInt(1, cambiaAInt(comanda.trim()));
					updateAltaDescuento.setInt(2, cambiaAInt(datos[i][0].trim()));
					updateAltaDescuento.setInt(3, porcentajeD);
					updateAltaDescuento.execute();
				}
				con.realizaCommit();
			}
			catch(SQLException sqle){
				exito = false;
				con.realizaRollback();
				System.out.println("Error SQL en metodo almacenaDescuento, Bean ManagerConsultas");
				sqle.printStackTrace();
			}
			catch(Exception e){
				exito = false;
				con.realizaRollback();
				System.out.println("Error en metodo almacenaDescuento, Bean ManagerConsultas");
				e.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de almacenaDescuento metodo existeEmpleado");
			   		q.printStackTrace();
			  	}
			}
		}
		return exito;
	}



	public boolean existeEmpleado (String claveEmpleadoS) throws SQLException, Exception{
		int claveEmpleado = cambiaAInt(claveEmpleadoS.trim());
		boolean existencia = false;
		String queryExistenciaE = "SELECT IDEmpleado FROM empleados WHERE IDEmpleado = "+claveEmpleado +" AND Activo = 1";
		con = new ConexionBD();
		if(con != null){
			try{
				ResultSet rs = null;
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryExistenciaE);
				while(rs.next()){
					if(rs.getInt("IDEmpleado") == claveEmpleado){
						existencia = true;
					}
				}
			}
			catch(SQLException sqle){
				System.out.println("Error SQL en metodo existeEmpleado, Bean ManagerConsultas");
				sqle.printStackTrace();
			}
			catch(Exception e){
				System.out.println("Error en metodo existeEmpleado, Bean ManagerConsultas");
				e.printStackTrace();
			}
			finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerConsultas metodo existeEmpleado");
			   		q.printStackTrace();
			  	}
			}
		}
		return existencia;
	}


	public ResultSet dameConsumo(String elEmpleado, String inicio, String fin) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		String queryConsumo = "SELECT CONCAT(empleados.Nombre COLLATE latin1_spanish_ci,' ',empleados.APaterno COLLATE latin1_spanish_ci,' ',empleados.AMaterno COLLATE latin1_spanish_ci) AS Nombre, SUM(internopro.CanPro) AS CanPro, internopro.ClPro, internopro.Ge, internopro.Di, internopro.Tipo, internopro.DiA, SUM(internopro.PT) AS PT FROM internopro, empleados WHERE internopro.IDPersonal LIKE '"+elEmpleado +"' AND empleados.IDEmpleado = internopro.IDPersonal AND internopro.DiA BETWEEN '"+inicio +"' AND '"+fin +"' GROUP BY(CONCAT(empleados.IDEmpleado,internopro.ClPro,internopro.Ge, internopro.Tipo, internopro.DiA)) ORDER BY empleados.IDEmpleado";
		if(con != null){
			try{
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryConsumo);
			}
			catch(SQLException sqle){
				System.out.println("Error SQL en metodo dameConsumo, Bean ManagerConsultas");
				sqle.printStackTrace();
			}
			catch(Exception e){
				System.out.println("Error en metodo dameConsumo, Bean ManagerConsultas");
				e.printStackTrace();
			}
		}
		return rs;
	}

 public int dameComensales(String comanda) throws SQLException, Exception  {
        ResultSet rs = null;
        int comensales = 0;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT NC FROM comanda WHERE IDC = "+comanda+" AND Es = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
          while(rs.next()){
		  		comensales = rs.getInt("NC");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameComanda.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameComanda.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerVentas metodo dameComanda");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println(nombre);
        return comensales;
  }



 public String dameNombreAlimento(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        int cla = cambiaAInt(clave);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT nombre FROM alimentos WHERE clave = "+cla+"");
          System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("nombre");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameNombreAlimento.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameNombreAlimento.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerConsultas metodo dameNombreAlimento");
		   		q.printStackTrace();
		  	}
		}
		System.out.println(nombre);
        return nombre;
  }


 public String dameNombreBebida(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        int cla = cambiaAInt(clave);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT nombre FROM bebidas WHERE clave = "+cla+"");
          System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("nombre");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameNombreBebida.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameNombreBebida.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerConsultas metodo dameNombreBebida");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println(nombre);
        return nombre;
  }


 public void cierraConexion() throws SQLException, Exception
 {
	 if(con != null){
		try{
			con.cierraConexion();
		}
		catch (Exception q){
		System.out.println("Error al momento de cerrar conexion en ManagerConsultas, cierraConexion ");
		q.printStackTrace();
		}
	}

}

/**
* El método dameComanda se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public int dameComanda(String mesa) throws SQLException, Exception
 {
        ResultSet rs = null;
        int comanda = 0;
        int cla = cambiaAInt(mesa);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT IDC FROM comanda WHERE IDMM = "+cla+" AND Es = 1");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		comanda = rs.getInt("IDC");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameComanda.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameComanda.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerVentas metodo dameComanda");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println(nombre);
        return comanda;
  }


/**
* El método tieneComanda verifica que el cliente solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del cliente solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean tieneComanda(String mesa) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select IDMM from comanda WHERE es = 1");
  	  		while(rs.next()){

  	  			if(mesa.equalsIgnoreCase(rs.getString("IDMM"))) {
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
					System.out.println("Error al cerrar conexion de ManagerVentas metodo tieneComanda");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
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