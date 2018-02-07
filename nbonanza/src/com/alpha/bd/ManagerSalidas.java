package com.alpha.bd;

import java.sql.SQLException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import com.alpha.bd.DateStamp;


public class ManagerSalidas {

	private ConexionBD con = null;
	public String ClaveDelProducto = new String("");

  	public ManagerSalidas() { }



	public int yaEstabaPagado(String numticket0, String fecha) throws SQLException, Exception  {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  String numticket = completaString(numticket0);
  	  int bandera = 0;
	  ConexionBD	con2 = new ConexionBD();
  	  if (con2.miConnection !=null) {
  	  	try {

  	  		st = con2.creaStatement();
  	  		rs = st.executeQuery("select numticket from salidas WHERE numTicket = '" +numticket +"' AND fecha ='"+cambiaADate(fecha)+"' AND ACTIVO = 1");
  	  		while(rs.next()){
  	  			if(numticket.equals(rs.getString("numticket"))) {
  	  				bandera = 1;//realiza comparación con la base de datos
  	  			}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de Cobrador metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }


// Cambia el estado de la transacción de salida a Cancelado modificando el campo de activo.
	public boolean CambiaActivoSalida(String numTicket, String fecha) throws SQLException, Exception {
		boolean bandera = true;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try  {
				String queryString = 	"UPDATE salidas SET activo = 0 WHERE numTicket = '"+completaString(numTicket) +"' AND fecha = '" +cambiaADate(fecha) +"'";
				Statement stmt = con.creaStatement();
				stmt.execute(queryString);
			}
			catch (SQLException sqle) {
				bandera = false;
				String error = "SQLException: No se puedo realizar CambiaActivoSalida.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch(Exception e){
				e.printStackTrace();
				bandera = false;
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println(	"Error al cerrar conexion de mticket metodo CambiaActivoSalida");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}




// Funcion para insertar salida desde Cobrador.java
	public synchronized boolean datosSalida(String numTicket, String balanza, String fecha, double aPagarSubTotal, String usuario) throws Exception {
		int repetido = yaEstabaPagado(numTicket, fecha);
		DateStamp ds = new DateStamp();
		boolean salida = false;
		if(repetido == 0){
			try{
				con = new ConexionBD();
				con.cancelaAutoCommit();
				if (con.miConnection != null) {
					String queryString = 	"UPDATE contenidoTicket SET fechaRealPago = '"+ds.obtenDatos() +"'  WHERE numTicket = '"+completaString(numTicket) +"' AND FechaTicket = '"+fecha +"'";
					Statement stmt = con.creaStatement();
					stmt.execute(queryString);
					PreparedStatement updateTablaSalida;
					updateTablaSalida = con.miConnection.prepareStatement("INSERT INTO salidas VALUES(?,?,?,?,?,?,?,?,?,?,?);");
					updateTablaSalida.setString(1, completaString(numTicket));
					updateTablaSalida.setString(2, checkSize(balanza));
					updateTablaSalida.setDate(3, cambiaADate(ds.obtenDatos()));
					updateTablaSalida.setDouble(4, aPagarSubTotal );
					updateTablaSalida.setInt(5, 0);
					updateTablaSalida.setNull(6,java.sql.Types.DATE);
					updateTablaSalida.setString(7, "");
					updateTablaSalida.setString(8, "");
					updateTablaSalida.setString(9, "");
					updateTablaSalida.setString(10, usuario);
					updateTablaSalida.setInt(11, 1);
					int reIntenta = yaEstabaPagado(numTicket, fecha);
					if(reIntenta == 0){
						updateTablaSalida.execute();
						con.realizaCommit();
					}
				}
			}
			catch (SQLException sqle) {
				salida = true;
				con.realizaRollback();
				System.out.println("Error SQL dentro de ManagerSalidas metodo datosSalida");
				sqle.printStackTrace();
			}
			catch (Exception e){
				salida = true;
				con.realizaRollback();
				System.out.println("Error! Excepcion dentro de ManagerSalidas metodo datosSalida");
				e.printStackTrace();
			}
			finally{
				if(con != null){
					try{
						con.realizaCommit();
						con.habilitaAutoCommit();
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al cerrar conexion de InsercionesBD metodo ddDatosProducto");
						q.printStackTrace();
					}
				}
			}
		}
		if(salida){
			System.out.println("No pude guardar el Ticket en la tabla de Salida No: "+numTicket);
		}
		return salida;
	}



	public String nombreClienteOK(String nombre) throws SQLException, Exception {
		String queryString;
//		System.out.println("Entro: "+nombre);
		queryString = ("SELECT nombre FROM clientes WHERE nombre like '" +nombre +"' AND ACTIVO = 1" );
		ResultSet rs = null;
		String rfc = null;
		try {
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				rfc = rs.getString(1);
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta ClaveLinea.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraia la clave de Lineas."+e;
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
//		System.out.println("Salio: "+rfc);
		return rfc;
	}



// Voy a cambiar el Estatus de las Factura a 1 e ingresar la serie de facturas..
	public boolean cierraSalida(String numTicket, String numFactura, String rFCClie, String nombre, String fechaFactura, String fechaTicket) throws Exception {
		boolean fin = false;
		String completo = nombreClienteOK(nombre);
		numTicket=completaString(numTicket);
		try  {
			String queryString = "UPDATE salidas SET factura = 1, fechaFactura='"+cambiaADate(fechaFactura) +"',rfcClie='"+rFCClie +"', nombreCliente='"+nombre +"', numFactura='"+numFactura +"' WHERE numticket='"+numTicket+"'  AND factura = 0";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			stmt.execute(queryString);
			queryString = "UPDATE creditos SET factura = 1, numFactura='"+numFactura +"', fechaFactura='"+cambiaADate(fechaFactura) +"', nombreClieFac = '"+nombre+"' WHERE numticket='"+numTicket+"' AND fechaCredito='"+cambiaADate(fechaTicket) +"' AND factura = 0";
			stmt = con.creaStatement();
			stmt.execute(queryString);
			fin = true;
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo realizar cierraSalida.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrió una excepción mientras se ejecutaba cierraSalida."+e;
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return fin;
	}




// Se emplea para saber si ya se asigno el numero de factura anteriormente, tanto en salidas, como en creditos
	public boolean existeNomFac(String nombreFactura) throws SQLException, Exception {
		boolean bandera= false;
		ResultSet rs = null;
		String obj = null;
		nombreFactura = nombreFactura.trim();
		try  {
			String queryString = ("(SELECT numFactura FROM salidas where factura = 1 AND activo = 1) UNION (SELECT numfactura FROM creditos where factura = 1 AND activo = 1);");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				String facturas = rs.getString("numFactura");
				StringBuffer sb = new StringBuffer (facturas);
				String temporal="";
				while (sb.indexOf("?") != -1){
					temporal= sb.substring(0,(sb.indexOf("?")));
//					System.out.println("Valor de nombreFactura -->" +nombreFactura +" "+temporal+" <--Valor de temporal");
					if(nombreFactura.equalsIgnoreCase(temporal.trim())){
						bandera = true;
					}
					sb=sb.delete(0,(sb.indexOf("?")+1));
//					System.out.println("SB= "+sb);
				}
				temporal = sb.toString().trim();
				if(nombreFactura.equalsIgnoreCase(temporal.trim())){
					bandera = true;
				}
				if(nombreFactura.equalsIgnoreCase(facturas.trim())){
					bandera = true;
				}
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta existeNomFac.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de existeNomFac."+e;
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
//		System.out.println("Voy a regresar el valor booleano: "+bandera);
		return bandera;
	}


// Esta funcion se emplea para averiguar si ya se facturo un ticket.
	public int existeFacturaPrevia(String numTicket, String balanza, String fecha) throws SQLException, Exception {
//		System.out.println("Me llego a existeFacturaPrevia: " +numTicket +" " +balanza +" " +fecha);
		ResultSet rs = null;
		int nombre = -1;
		try {
			String queryString = ("SELECT factura FROM salidas WHERE numTicket = '" +completaString(numTicket) +"' AND fecha = '" +fecha +"' AND ACTIVO = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				nombre = rs.getInt(1);
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta existeFacturaPrevia.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraia la factura de existeFacturaPrevia."+e;
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
//		System.out.println("voy a regresar: " +nombre);
		return nombre;
	}



	public boolean CambiaAviso(String aviso) throws SQLException, Exception {
		boolean bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try  {
				String queryString ="UPDATE avisos SET frase = '"+aviso+"' WHERE automatico = 1 ";
				//System.out.println("Query: "+queryString);
				Statement stmt = con.creaStatement();
				stmt.execute(queryString);
				bandera = true;
			}
			catch (SQLException sqle) {
				String error = "SQLException: No se puedo realizar CambiaActivoSalida.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println(	"Error al cerrar conexion de mticket metodo CambiaActivoSalida");
					q.printStackTrace();
				}
			}
		}
		//System.out.println("Bandera: "+bandera);
		return bandera;
	}

// Funciones Genericas de Transformacion:

	private String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
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

	public String completaString(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 7 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}

	public String remuevePuntuacion(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		while (sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length());
		}
		return formato = new String(sb.toString());
	}


}