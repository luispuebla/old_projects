package com.alpha.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerProveedores" es la encargada de administrar los datos correspondientes a los Proveedores como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Abril 2006)
*/

public class ManagerProveedores {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerProveedores es el constructor vacio de la clase.
*/

  public ManagerProveedores()   { }


/**
* El método existe verifica que el proveedor solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

	public boolean existe(String rfc) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		boolean bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT * FROM proveedores WHERE activo = 1 AND rfc = '"+rfc.trim()+"'");
				while(rs.next()){
					if(rfc.trim().equalsIgnoreCase(rs.getString("rfc"))) {
						bandera = true;//realiza comparación con la base de datos
					}
				}
			}
			catch (SQLException sql){
				System.out.println("Excepcion SQL en  ManagerProveedores metodo existe");
				sql.printStackTrace();
		        error = "SQLException! Error Method existe, Class ManagerProveedores ";
				throw new SQLException(error);
			}
			catch (Exception ex) {
				System.out.println("Excepcion en  ManagerProveedores metodo existe");
				ex.printStackTrace();
		        error = "Exception! Error Method existe, Class ManagerProveedores ";
				throw new SQLException(error);
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerProveedores metodo existe");
					q.printStackTrace();
			        error = "Exception! Closing BD Method existe, Class ManagerProveedores ";
					throw new SQLException(error);
				}
			}
		}
		return bandera;
	}



/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Teléfono del Proveedor.
*/
	public int valida_add(String rfc, String nombre, String tel1) {
		int verifica = 2;
		boolean revisa = ((rfc != null) && (rfc.length() > 0) && (nombre != null) && (nombre.length() > 0) && (tel1 != null) && (tel1.length() > 0));
		if(revisa){
			verifica = 1;
		}
	return verifica;
	}


/**
* El método add_Proveedor se encarga de añadir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public boolean add_Proveedor(String rfc, String nombre, String direccion, String colonia, String delegacion, String cp, String ciudad, String tel1, String tel2, String fax, String pagina, String email, String vendedor, String formaPago, String cuentas, String credito, String pagoA, String des1, String des2, String des3, String idCredito) throws SQLException, Exception {
		boolean fin = true;
		credito = remueveComas(credito);
		des1 = remueveComas(des1);
		des2 = remueveComas(des2);
		des3 = remueveComas(des3);
		int formaPago2 = cambiaAInt(formaPago);
		double cre = cambiaADouble(credito);
		int paga = cambiaAInt(pagoA);
		double d1 = cambiaADouble(des1);
		double d2 = cambiaADouble(des2);
		double d3 = cambiaADouble(des3);
		tiempo = new TimeStamp();
		String hoy = tiempo.date;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement altaProveedor;
				altaProveedor = con.miConnection.prepareStatement("insert into proveedores values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				altaProveedor.setString(1, rfc);
				altaProveedor.setString(2, nombre);
				altaProveedor.setString(3, direccion);
				altaProveedor.setString(4, colonia);
				altaProveedor.setString(5, delegacion);
				altaProveedor.setString(6, cp);
				altaProveedor.setString(7, ciudad);
				altaProveedor.setString(8, tel1);
				altaProveedor.setString(9, tel2);
				altaProveedor.setString(10, fax);
				altaProveedor.setString(11, pagina);
				altaProveedor.setString(12, email);
				altaProveedor.setString(13, vendedor);
				altaProveedor.setInt(14, formaPago2);
				altaProveedor.setString(15, cuentas);
				altaProveedor.setInt(16, cambiaAInt(idCredito));
				altaProveedor.setDouble(17, cre);
				altaProveedor.setInt(18, paga);
				altaProveedor.setDouble(19, d1);
				altaProveedor.setDouble(20, d2);
				altaProveedor.setDouble(21, d3);
				altaProveedor.setDouble(22, cre);
				altaProveedor.setString(23, hoy);
				altaProveedor.setInt(24, 1);
				altaProveedor.execute();
			}
			catch (SQLException sql) {
				fin = false;
				System.out.println("Excepcion SQL en  ManagerProveedores metodo add_Proveedor");
				sql.printStackTrace();
		        error = "SQLException! Error Method add_Proveedor, Class ManagerProveedores ";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
				System.out.println("Excepcion en  ManagerProveedores metodo add_Proveedor");
				q.printStackTrace();
		        error = "Exception! Error Method add_Proveedor, Class ManagerProveedores ";
				throw new SQLException(error);
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerProveedores metodo add_Proveedor");
					q.printStackTrace();
			        error = "Exception! Closing BD Method add_Proveedor, Class ManagerProveedores ";
					throw new SQLException(error);
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
  * El método baja_Proveedor se encarga de colocar un 0 en el campo "activo" del Proveedor en la Base de Datos, para realizar una Baja lógica del Proveedor correspondiente.
  *  	@param 	rfc		String con el RFC del Proveedor solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
	public boolean baja_Proveedor(String rfc) throws SQLException, Exception {
		ResultSet rs = null;
		boolean bandera = true;
		con = new ConexionBD();
		try  {
			PreparedStatement bajaProveedor;
			bajaProveedor = con.miConnection.prepareStatement("UPDATE proveedores SET activo = ?  WHERE rfc = ?");
			bajaProveedor.setInt(1, 0); // Baja Logica
			bajaProveedor.setString(2, rfc);
			bajaProveedor.execute();
		}
		catch (SQLException sqle) {
			bandera = false;
			System.out.println("Excepcion SQL en  ManagerProveedores metodo baja_Proveedor");
			sqle.printStackTrace();
			error = "SQLException! Error Method baja_Proveedor, Class ManagerProveedores";
			throw new SQLException(error);
		}
		catch (Exception e) {
			bandera = false;
			System.out.println("Excepcion en  ManagerProveedores metodo baja_Proveedor");
			e.printStackTrace();
			error = "Exception! Error Method baja_Proveedor, Class ManagerProveedores ";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerProveedores metodo baja_Proveedor");
				q.printStackTrace();
			}
		}
	return bandera;
	}



/**
* El método datos_Proveedor se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet datos_Proveedor(String rfc) throws SQLException, Exception  {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM proveedores WHERE rfc = '"+rfc+"' AND activo = 1 LIMIT 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Proveedor.";
          sqle.printStackTrace();
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Proveedor.";
          e.printStackTrace();
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método update_Proveedor se encarga de actualizar los datos de un Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Proveedor a actualizar.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*	@param	colonia		String con la Colonia del Proveedor
*	@param	delegacion	String con la Delegación del Proveedor.
*	@param	cp			String con el Código Postal del Proveedor.
*/
	public boolean update_Proveedor(String rfc, String nombre, String direccion, String colonia, String delegacion, String cp, String ciudad, String tel1, String tel2, String fax, String pagina, String email, String vendedor, String formaPago, String cuentas, String credito, String pagoA, String des1, String des2, String des3, String idCredito) throws SQLException, Exception {
		boolean fin = true;
		ResultSet rs = null;
		credito = remueveComas(credito);
		des1 = remueveComas(des1);
		des2 = remueveComas(des2);
		des3 = remueveComas(des3);
		int formaPago2 = cambiaAInt(formaPago);
		double cre = cambiaADouble(credito);
		int paga = cambiaAInt(pagoA);
		double d1 = cambiaADouble(des1);
		double d2 = cambiaADouble(des2);
		double d3 = cambiaADouble(des3);
		double credPrev = 0.00;
		double saldoDisp = 0.00;
		con = new ConexionBD();
		try  {
			String queryCrePrev = "SELECT credito, saldoDisponible FROM proveedores WHERE rfc = '"+rfc+"' AND activo = 1";
			Statement st = con.miConnection.createStatement();
			rs = st.executeQuery(queryCrePrev);
			while (rs.next()){
				credPrev = rs.getDouble("credito");
				saldoDisp = rs.getDouble("saldoDisponible");
			}
			double nuevoSD = 0.00;
			if(cre == 0.00){
				if(saldoDisp < 0.00){
					nuevoSD = saldoDisp;
				}
			}
			else if(credPrev == saldoDisp){
				nuevoSD = cre;
			}
			else if(cre > 0.00){
				nuevoSD = cre - (credPrev - saldoDisp);
			}
			PreparedStatement modProveedor;
			modProveedor = con.miConnection.prepareStatement("UPDATE proveedores SET nombre = ?,  direccion = ?, colonia = ?, delegacion = ?, cp = ?, ciudad = ?,  tel1 = ?, tel2 = ?, fax = ?, pagina = ?, email = ?, vendedor = ?, formaPago = ?, cuentas = ?, IDCredito = ?,  credito = ?, diasPago = ?, descuento1 = ?,  descuento2 = ?, descuento3 = ?, saldoDisponible = ?  WHERE rfc = ? AND activo = 1");
			modProveedor.setString(1, nombre);
			modProveedor.setString(2, direccion);
			modProveedor.setString(3, colonia);
			modProveedor.setString(4, delegacion);
			modProveedor.setString(5, cp);
			modProveedor.setString(6, ciudad);
			modProveedor.setString(7, tel1);
			modProveedor.setString(8, tel2);
			modProveedor.setString(9, fax);
			modProveedor.setString(10, pagina);
			modProveedor.setString(11, email);
			modProveedor.setString(12, vendedor);
			modProveedor.setInt(13, formaPago2);
			modProveedor.setString(14, cuentas);
			modProveedor.setDouble(15, cambiaAInt(idCredito));
			modProveedor.setDouble(16, cre);
			modProveedor.setInt(17, paga);
			modProveedor.setDouble(18, d1);
			modProveedor.setDouble(19, d2);
			modProveedor.setDouble(20, d3);
			modProveedor.setDouble(21, nuevoSD);
			modProveedor.setString(22,rfc);
			modProveedor.execute();
		}
		catch (SQLException sqle) {
			fin=false;
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query update_Proveedor.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			fin=false;
			error = "Ocurrió una excepción mientras se actualizaba update_Proveedor.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerProveedores metodo update_Proveedor");
				q.printStackTrace();
			}
		}
		return fin;
	}



/**
* El método dameProveedores se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Proveedores que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Proveedores.
*/
  public ResultSet dameProveedores() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM proveedores WHERE activo = "+estatus+" ORDER BY nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameProveedores.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameProveedores.";
            throw new Exception(error);
          }
          return rs;
  }


/**
* El método dameProveedoresConComprasActivas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Proveedores que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Proveedores.
*/
  public ResultSet dameProveedoresConComprasActivas() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT DISTINCT proveedores.rfc, proveedores.nombre FROM orden_compra, proveedores WHERE proveedores.rfc = orden_compra.claveProveedor AND orden_compra.activo = 1 AND orden_compra.Entrega != 2 GROUP BY proveedores.rfc ORDER BY proveedores.nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameProveedoresConComprasActivas.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameProveedoresConComprasActivas.";
            throw new Exception(error);
          }
          return rs;
  }

/**
* El método dameProveedoresConComprasActivas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Proveedores que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Proveedores.
*/
  public ResultSet dameProveedoresConComprasActivasParaPago() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT DISTINCT proveedores.rfc, proveedores.nombre FROM orden_compra, proveedores WHERE proveedores.rfc = orden_compra.claveProveedor AND orden_compra.activo = 1 AND orden_compra.Entrega = 2 AND orden_compra.pago != 2  GROUP BY proveedores.rfc ORDER BY proveedores.nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameProveedoresConComprasActivas.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameProveedoresConComprasActivas.";
            throw new Exception(error);
          }
          return rs;
  }


/**
* El método dameProveedoresPetit se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Proveedores que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Proveedores.
*/
  public ResultSet dameProveedoresPetit() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT rfc, nombre, CONCAT(direccion COLLATE latin1_spanish_ci,', ',colonia COLLATE latin1_spanish_ci,', ',delegacion COLLATE latin1_spanish_ci,', ',cp,', ',ciudad COLLATE latin1_spanish_ci) AS direccion, CONCAT(tel1,',  ',tel2,',  ',fax)AS tel, vendedor FROM proveedores WHERE activo = "+estatus +" ORDER BY nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameProveedoresPetit.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameProveedoresPetit.";
            throw new Exception(error);
          }
          return rs;
  }

/**
* El método nombreProveedor se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public String nombreProveedor(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT nombre FROM proveedores WHERE rfc = '"+clave+"' AND activo = 1 LIMIT 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("nombre");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query nombreProveedor.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving nombreProveedor.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerProveedores metodo nombreProveedor");
		   		q.printStackTrace();
		  	}
		}
        return nombre;
  }


	public void cierraConexion(){
		try{
			con.cierraConexion();
		}
		catch (Exception q){
			System.out.println("Error en cierraConexion metodo ManagerProveedores");
			q.printStackTrace();
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
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf("\"") != -1){
			sb.deleteCharAt(sb.indexOf("\""));
		}
		return formato = new String(sb.toString());
	}

	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}



	public String remueveCaracteres(String formato){
//		System.out.println("Entro: " +formato);
		StringBuilder sb = new StringBuilder (formato);
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
		StringBuilder losEnteros = new StringBuilder(dameEnteros(formato));
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
		StringBuilder sb = new StringBuilder (muchosDecimales);
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
			StringBuilder sb = new StringBuilder (enteros);
			boolean existieron = false;
			if(sb.indexOf(".") != -1){
				sb=sb.delete(0, sb.indexOf(".")+1);
				existieron = true;
			}
			if (!existieron){
				sb = new StringBuilder ("00");
			}
			return sb.toString();
		}

		public String dameEnteros(String enteros){
			StringBuilder sb = new StringBuilder (enteros);
			if(sb.indexOf(".") != -1){
				sb=sb.delete(sb.indexOf("."),sb.length() );
			}
			return sb.toString();
		}

		public String remueveEspacioWeb(String query){
			StringBuilder sb = new StringBuilder (query);
			while (sb.indexOf("%20") != -1){
				sb.replace(sb.indexOf("%20"),sb.indexOf("%20")+3," ");
			}
//			System.out.println(sb.toString());
			return sb.toString();
		}


		private String checkSize (String revisa){
			StringBuilder verificador = new StringBuilder(revisa);
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