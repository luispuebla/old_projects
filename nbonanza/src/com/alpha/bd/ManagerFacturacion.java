package com.alpha.bd;

import com.alpha.bd.DateStamp;
import com.alpha.bd.TimeStamp;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.util.Calendar;
import java.util.TimeZone;
import java.math.*;


/**
* La clase "ManagerFacturacion" es la encargada de administrar los datos correspondientes a la Facturacion como son Altas, Consultas, Actualizaciones, etc.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004)
*/

public class ManagerFacturacion {

  String error;
  private ConexionBD con = null;
  private ConexionBD con2 = null;
  private DateStamp dt;
  protected TimeStamp ts;


/**
* El método ManagerFacturacion es el constructor vacio de la clase.
*/

  public ManagerFacturacion()   { }

	public String dameFechaHoy() throws Exception{
		ts = new TimeStamp();
		return  ts.date2;
	}

  	public String formateaFecha(String fecha){
  		return fecha.substring(6,10)+"-"+fecha.substring(0,2)+"-"+fecha.substring(3,5);
  	}

// NUEVAS CLASES ACTUALIZADAS..
	public boolean existeTicket(String numTicket, String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		boolean existe = false;
		numTicket = completaString(numTicket);
		con = new ConexionBD();
		try  {
			String queryString = ("(SELECT DISTINCT salidas.numTicket FROM salidas, contenidoticket WHERE salidas.numticket = "+cambiaAInt(numTicket) +" AND contenidoticket.fechaRealPago = '"+formateaFecha(fecha)+"' AND salidas.activo = 1)UNION (SELECT numTicket FROM creditos where numticket = "+cambiaAInt(numTicket) +" AND fechaCredito = '"+formateaFecha(fecha)+"' AND activo = 1)");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				if (rs.getInt("numTicket")==cambiaAInt(numTicket)){
					existe = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query existeTicket.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving existeTicket.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo existeTicket");
				q.printStackTrace();
			}
		}
		return existe;
	}


	public boolean existeFacturaPrevia(String numTicket, String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		boolean existe = false;
		con = new ConexionBD();
		try  {
			String queryString = ("(SELECT factura FROM salidas where numticket = "+cambiaAInt(numTicket) +"  AND activo = 1) UNION (SELECT factura FROM creditos where numticket = "+cambiaAInt(numTicket) +" AND activo = 1)	");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				if (rs.getInt("factura")==1){
					existe = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query existeFacturaPrevia.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving existeFacturaPrevia.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo existeFacturaPrevia");
				q.printStackTrace();
			}
		}
		return existe;
	}

	public synchronized ResultSet dameListadoTicketsFac (String ticket1, String ticket2, String ticket3, String ticket4, String ticket5) throws SQLException, Exception{
  	  Statement st = null;
  	  ResultSet rs= null;
  	  String complementoQuery=" (numTicket = "+cambiaAInt(ticket1) +" OR numTicket = " +cambiaAInt(ticket2) +" OR numTicket = "+cambiaAInt(ticket3) +" OR numTicket = "+cambiaAInt(ticket4) +" OR numTicket = "+cambiaAInt(ticket5) +") ";
	  con = new ConexionBD();
	  if(con != null){
		 try{
			 String query = "SELECT SUM(contenidoticket.cantidadProducto) AS cantidadProducto, productos.descripcion, productos.gravaIVA, contenidoticket.precioVenta, SUM(contenidoticket.precioAPagar) AS precioAPagar, contenidoticket.tipoVenta, SUM(contenidoticket.pesoEnPz) AS pesoEnPz  FROM contenidoticket, productos WHERE "+complementoQuery +" AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 AND contenidoticket.estatusPago != 0 GROUP BY contenidoticket.ID_Pro,contenidoticket.tipoPrecio,contenidoticket.tipoVenta,contenidoticket.precioVenta ORDER BY contenidoticket.fechaRegistro";
			 Statement stmt = con.creaStatement();
			 rs = stmt.executeQuery(query);
		 }
  	  	catch (SQLException sqle) {
  	  		sqle.printStackTrace();
  	  	}
  	  	catch (Exception ex) {
  	  		ex.printStackTrace();
  	  	}
	  }
	  return rs;
	}


	public synchronized ResultSet dameListadoTicketsFac (String[ ] ArrayTicket) throws SQLException, Exception{
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean primerTicket = true;
  	  String complementoQuery = "( numTicket = "+cambiaAInt(ArrayTicket[0]);
  	  for(int i = 1; i<ArrayTicket.length; i++){
		  complementoQuery += " OR numTicket = "+cambiaAInt(ArrayTicket[i]);
	  }
  	  complementoQuery +=" ) ";
	  con = new ConexionBD();
	  if(con != null){
		 try{
			 String query = "SELECT SUM(contenidoticket.cantidadProducto) AS cantidadProducto, productos.descripcion, productos.gravaIVA, contenidoticket.precioVenta, SUM(contenidoticket.precioAPagar) AS precioAPagar, contenidoticket.tipoVenta, SUM(contenidoticket.pesoEnPz) AS pesoEnPz  FROM contenidoticket, productos WHERE "+complementoQuery +" AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 AND contenidoticket.estatusPago != 0 GROUP BY contenidoticket.ID_Pro,contenidoticket.tipoPrecio,contenidoticket.tipoVenta,contenidoticket.precioVenta ORDER BY contenidoticket.fechaRegistro";
			 Statement stmt = con.creaStatement();
			 rs = stmt.executeQuery(query);
		 }
  	  	catch (SQLException sqle) {
  	  		sqle.printStackTrace();
  	  	}
  	  	catch (Exception ex) {
  	  		ex.printStackTrace();
  	  	}
	  }
	  return rs;
	}


	public void cierraConexion() throws SQLException, Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo cierraConexion");
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
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo cierraConexion2");
				q.printStackTrace();
			}
		}
	}

// Me regresa la cantidad de renglones dentro de un resultSet
	public  int getResultSetSize(ResultSet resultSet) {
		ResultSet temporal = resultSet;
	    int size = -1;
	    try {
	        temporal.last();
	        size = temporal.getRow();
	        temporal.beforeFirst();
	    }
	    catch(SQLException e) {
	       e.printStackTrace();
	    }
		return size;
	}


	public synchronized int almacenaFacturas(String rfc,String  nombre,String[ ] ArrayTicket, String ArrayFactura[], String fechaDeFactura,String produEnFac) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		int resultado = 3;
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				st = con.creaStatement();
				// Primero checo que los numero de Factura no esten ya usados.
				boolean facRepetida = false;
				String complementoNomFac =" '"+ArrayFactura[0]+"'";
				for(int i = 1; i < ArrayFactura.length; i++){
					complementoNomFac += " OR numFactura = '" +ArrayFactura[i] +"' ";
				}
				complementoNomFac +=") ";
				String query = "SELECT numFactura FROM facventas WHERE estatus = 1 AND (numFactura = "+complementoNomFac;
				rs = st.executeQuery(query);
				while(rs.next()){
					facRepetida = true;
					resultado = 0;
				}
				rs.close();
				st.close();
				// Si todo bien continuo, ahora checo que los tickets no hayan sido ya facturados.
				if(resultado == 3){
  					String complementoQuery = "( numTicket = "+cambiaAInt(ArrayTicket[0]);
  					for(int i = 1; i<ArrayTicket.length; i++){
						complementoQuery += " OR numTicket = "+cambiaAInt(ArrayTicket[i]);
					}
  					complementoQuery +=" ) ";
					query = "(SELECT factura FROM salidas where "+complementoQuery+"  AND activo = 1) UNION (SELECT factura FROM creditos where "+complementoQuery  +" AND activo = 1)";
					st = con.creaStatement();
					rs= st.executeQuery(query);
					while(rs.next()){
						if(rs.getInt("factura") == 1){
							resultado = 2;
						}
					}
					rs.close();
					st.close();
					// Si todo bien, sigo ahora voy a almacenar lo necesario y actualizar estatus de ticket a facturado.
					if(resultado != 2){
						int productosXFactura = cambiaAInt(dameEnteros(produEnFac));
						query = "SELECT SUM(contenidoticket.cantidadProducto) AS cantidadProducto, productos.descripcion, productos.gravaIVA, contenidoticket.precioVenta, SUM(contenidoticket.precioAPagar) AS precioAPagar, contenidoticket.tipoVenta  FROM contenidoticket, productos WHERE "+complementoQuery +" AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 AND contenidoticket.estatusPago != 0 GROUP BY contenidoticket.ID_Pro,contenidoticket.tipoPrecio,contenidoticket.tipoVenta,contenidoticket.precioVenta ORDER BY contenidoticket.fechaRegistro";
						st = con.creaStatement();
						rs = st.executeQuery(query);
						int cantidadProductos = getResultSetSize(rs);
						String comboTickets = cambiaAInt(ArrayTicket[0])+"";
						for(int i = 1; i<ArrayTicket.length; i++){
							complementoQuery += "%"+cambiaAInt(ArrayTicket[i]);
						}
						// Comienzo a almacenar en mi tabla de facturas
						ts = new TimeStamp();
						String fechaHoy = ts.date;
						for(int i=0; i<ArrayFactura.length; i++){
							rs.beforeFirst();
							int ultimoProducto = cantidadProductos;
							int primerProducto = ultimoProducto - (ultimoProducto-1);
							if(cantidadProductos > productosXFactura){
								ultimoProducto = productosXFactura*(i+1);
								primerProducto = ultimoProducto - (productosXFactura-1);
							}
							double tasa0 = 0.00;
							double tasa15 = 0.00;
							double iva = 0.00;
							double total = 0.00;
							BigDecimal porcentajeIva = new BigDecimal("115.00");
							BigDecimal porcentajeNeto = new BigDecimal("100.00");
							int contador = 0;
							while(rs.next()){
								contador ++;
								if((contador >= primerProducto) && (contador <= ultimoProducto)){
									if(rs.getInt("gravaIVA") == 0){
										tasa0 += rs.getDouble("precioAPagar");
									}
									else{
										BigDecimal precioOriginalConIVA = new BigDecimal(rs.getString("precioAPagar"));
										BigDecimal precioTotalP = new BigDecimal(rs.getString("precioAPagar"));
										precioTotalP = precioTotalP.multiply(porcentajeNeto);
										precioTotalP = precioTotalP.divide(porcentajeIva, new MathContext(100));
										precioOriginalConIVA = precioOriginalConIVA.subtract(precioTotalP);
										precioTotalP = precioTotalP.setScale(2, RoundingMode.HALF_UP);
										precioOriginalConIVA = precioOriginalConIVA.setScale(2, RoundingMode.HALF_UP);
										tasa15 += cambiaADouble(precioTotalP.toString());
										iva += cambiaADouble(precioOriginalConIVA.toString());
									}
								} // Cierro limite contador
							}//Cierro ResultSet
							PreparedStatement updateTablafacVentas;
							updateTablafacVentas = con.miConnection.prepareStatement("INSERT INTO facVentas VALUES(?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablafacVentas.setString(1, ArrayFactura[i]);
							updateTablafacVentas.setString(2, comboTickets);
							updateTablafacVentas.setString(3, rfc);
							updateTablafacVentas.setString(4, nombre);
							updateTablafacVentas.setString(5, formateaFecha(fechaDeFactura));
							updateTablafacVentas.setString(6, fechaHoy);
							updateTablafacVentas.setDouble(7, tasa0);
							updateTablafacVentas.setDouble(8, tasa15);
							updateTablafacVentas.setDouble(9, iva);
							updateTablafacVentas.setDouble(10, (tasa0+tasa15+iva));
							updateTablafacVentas.setInt(11, 1);
							updateTablafacVentas.setInt(12, productosXFactura);
							updateTablafacVentas.execute();
						}// Cierro for de Arreglo Factura
						rs.close();
						st.close();
						// finalmente Cambio estatus de Tickets a Facturados...
						query = "UPDATE ticket_ligado SET estatus = 1 WHERE estatus = 0 AND "+complementoQuery;
						st = con.creaStatement();
						 st.execute(query);
						 st.close();
						query = "UPDATE creditos SET factura = 1 WHERE activo = 1 AND "+complementoQuery;
						st = con.creaStatement();
						 st.execute(query);
						 st.close();
					}// Cierro Resultado != 2
				}// Cierro Resultado ==1
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				resultado = -1;
				con.realizaRollback();
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				resultado = -1;
				con.realizaRollback();
				ex.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerFacturacion metodo almacenaFacturas");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}


	public synchronized int almacenaFacturas(String rfc,String  nombre,String ticket1,String  ticket2, String ticket3, String ticket4,String ticket5, String ArrayFactura[], String fechaDeFactura,String produEnFac) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		int resultado = 3;
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				st = con.creaStatement();
				// Primero checo que los numero de Factura no esten ya usados.
				boolean facRepetida = false;
				String complementoNomFac =" '"+ArrayFactura[0]+"'";
				for(int i = 1; i < ArrayFactura.length; i++){
					complementoNomFac += " OR numFactura = '" +ArrayFactura[i] +"' ";
				}
				complementoNomFac +=") ";
				String query = "SELECT numFactura FROM facventas WHERE estatus = 1 AND (numFactura = "+complementoNomFac;
				rs = st.executeQuery(query);
				while(rs.next()){
					facRepetida = true;
					resultado = 0;
				}
				rs.close();
				st.close();
				// Si todo bien continuo, ahora checo que los tickets no hayan sido ya facturados.
				if(resultado == 3){
					String complementoQuery=" (numTicket = "+cambiaAInt(ticket1) +" OR numTicket = " +cambiaAInt(ticket2) +" OR numTicket = "+cambiaAInt(ticket3) +" OR numTicket = "+cambiaAInt(ticket4) +" OR numTicket = "+cambiaAInt(ticket5) +") ";
					query = "(SELECT factura FROM salidas where "+complementoQuery+"  AND activo = 1) UNION (SELECT factura FROM creditos where "+complementoQuery  +" AND activo = 1)";
					st = con.creaStatement();
					rs= st.executeQuery(query);
					while(rs.next()){
						if(rs.getInt("factura") == 1){
							resultado = 2;
						}
					}
					rs.close();
					st.close();
					// Si todo bien, sigo ahora voy a almacenar lo necesario y actualizar estatus de ticket a facturado.
					if(resultado != 2){
						int productosXFactura = cambiaAInt(dameEnteros(produEnFac));
						query = "SELECT SUM(contenidoticket.cantidadProducto) AS cantidadProducto, productos.descripcion, productos.gravaIVA, contenidoticket.precioVenta, SUM(contenidoticket.precioAPagar) AS precioAPagar, contenidoticket.tipoVenta  FROM contenidoticket, productos WHERE "+complementoQuery +" AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 AND contenidoticket.estatusPago != 0 GROUP BY contenidoticket.ID_Pro,contenidoticket.tipoPrecio,contenidoticket.tipoVenta,contenidoticket.precioVenta ORDER BY contenidoticket.fechaRegistro";
						st = con.creaStatement();
						rs = st.executeQuery(query);
						int cantidadProductos = getResultSetSize(rs);
						String comboTickets = "";
						if(!(ticket1.trim().equals(""))){
							comboTickets = ticket1;
						}
						if(!(ticket2.trim().equals(""))){
							if(comboTickets.length() >0){
								comboTickets +="%";
							}
							comboTickets += ticket2;
						}
						if(!(ticket3.trim().equals(""))){
							if(comboTickets.length() >0){
								comboTickets +="%";
							}
							comboTickets += ticket3;
						}
						if(!(ticket4.trim().equals(""))){
							if(comboTickets.length() >0){
								comboTickets +="%";
							}
							comboTickets += ticket4;
						}
						if(!(ticket5.trim().equals(""))){
							if(comboTickets.length() >0){
								comboTickets +="%";
							}
							comboTickets += ticket5;
						}
						// Comienzo a almacenar en mi tabla de facturas
						ts = new TimeStamp();
						String fechaHoy = ts.date;
						for(int i=0; i<ArrayFactura.length; i++){
							rs.beforeFirst();
							int ultimoProducto = cantidadProductos;
							int primerProducto = ultimoProducto - (ultimoProducto-1);
							if(cantidadProductos > productosXFactura){
								ultimoProducto = productosXFactura*(i+1);
								primerProducto = ultimoProducto - (productosXFactura-1);
							}
							double tasa0 = 0.00;
							double tasa15 = 0.00;
							double iva = 0.00;
							double total = 0.00;
							BigDecimal porcentajeIva = new BigDecimal("115.00");
							BigDecimal porcentajeNeto = new BigDecimal("100.00");
							int contador = 0;
							while(rs.next()){
								contador ++;
								if((contador >= primerProducto) && (contador <= ultimoProducto)){
									if(rs.getInt("gravaIVA") == 0){
										tasa0 += rs.getDouble("precioAPagar");
									}
									else{
										BigDecimal precioOriginalConIVA = new BigDecimal(rs.getString("precioAPagar"));
										BigDecimal precioTotalP = new BigDecimal(rs.getString("precioAPagar"));
										precioTotalP = precioTotalP.multiply(porcentajeNeto);
										precioTotalP = precioTotalP.divide(porcentajeIva, new MathContext(100));
										precioOriginalConIVA = precioOriginalConIVA.subtract(precioTotalP);
										precioTotalP = precioTotalP.setScale(2, RoundingMode.HALF_UP);
										precioOriginalConIVA = precioOriginalConIVA.setScale(2, RoundingMode.HALF_UP);
										tasa15 += cambiaADouble(precioTotalP.toString());
										iva += cambiaADouble(precioOriginalConIVA.toString());
									}
								} // Cierro limite contador
							}//Cierro ResultSet
							PreparedStatement updateTablafacVentas;
							updateTablafacVentas = con.miConnection.prepareStatement("INSERT INTO facVentas VALUES(?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablafacVentas.setString(1, ArrayFactura[i]);
							updateTablafacVentas.setString(2, comboTickets);
							updateTablafacVentas.setString(3, rfc);
							updateTablafacVentas.setString(4, nombre);
							updateTablafacVentas.setString(5, formateaFecha(fechaDeFactura));
							updateTablafacVentas.setString(6, fechaHoy);
							updateTablafacVentas.setDouble(7, tasa0);
							updateTablafacVentas.setDouble(8, tasa15);
							updateTablafacVentas.setDouble(9, iva);
							updateTablafacVentas.setDouble(10, (tasa0+tasa15+iva));
							updateTablafacVentas.setInt(11, 1);
							updateTablafacVentas.setInt(12, productosXFactura);
							updateTablafacVentas.execute();
						}// Cierro for de Arreglo Factura
						rs.close();
						st.close();
						// finalmente Cambio estatus de Tickets a Facturados...
						query = "UPDATE salidas SET factura = 1 WHERE activo = 1 AND "+complementoQuery;
						st = con.creaStatement();
						 st.execute(query);
						 st.close();
						query = "UPDATE creditos SET factura = 1 WHERE activo = 1 AND "+complementoQuery;
						st = con.creaStatement();
						 st.execute(query);
						 st.close();
					}// Cierro Resultado != 2
				}// Cierro Resultado ==1
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				resultado = -1;
				con.realizaRollback();
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				resultado = -1;
				con.realizaRollback();
				ex.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerFacturacion metodo almacenaFacturas");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}

	public boolean existeFactura(String claveFactura) throws SQLException, Exception {
		ResultSet rs = null;
		boolean existe = false;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT numFactura FROM facventas WHERE numFactura = '"+claveFactura.trim()+"' AND estatus = 1	");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				if (rs.getString("numFactura").equalsIgnoreCase(claveFactura.trim())){
					existe = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query existeFacturaPrevia.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving existeFacturaPrevia.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo existeFacturaPrevia");
				q.printStackTrace();
			}
		}
		return existe;
	}


	public ResultSet otrasFacsDeBaja(String claveFactura) throws SQLException, Exception {
		ResultSet rs = null;
		int resultado = 0;
		con2 = new ConexionBD();
		String todosTickets = "";
		try  {
			con2.cancelaAutoCommit();
			// Primero obtengo todos los posibles ticket que conforman mi factura(s)
			String queryString = ("SELECT tickets FROM facventas WHERE numFactura = '"+claveFactura.trim()+"' AND estatus = 1 LIMIT 1");
			Statement stmt = con2.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				todosTickets = rs.getString("tickets");
			}
			rs.close();
			stmt.close();
			queryString = ("SELECT numFactura FROM facventas WHERE tickets = '"+todosTickets+"' AND estatus = 1 ");
			 stmt = con2.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query otrasFacsDeBaja.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving otrasFacsDeBaja.";
			throw new Exception(error);
		}
		return rs;
	}



	public synchronized boolean bajaDeFactura(String claveFactura) throws SQLException, Exception {
		ResultSet rs = null;
		boolean  resultado = true;
		con = new ConexionBD();
		try  {
			con.cancelaAutoCommit();
			// Primero obtengo todos los posibles ticket que conforman mi factura(s)
			String queryString = ("SELECT tickets FROM facventas WHERE numFactura = '"+claveFactura.trim()+"' AND estatus = 1 LIMIT 1");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			String todosTickets = "";
			while(rs.next()){
				todosTickets = rs.getString("tickets");
			}
			rs.close();
			stmt.close();
			// Segundo borro las facturas que pertenecen a esa serie.
			queryString = "UPDATE facventas SET estatus = 0 WHERE tickets = '"+todosTickets +"' AND estatus = 1";
			stmt = con.creaStatement();
			stmt.execute(queryString);
			stmt.close();
			StringBuilder sb = new StringBuilder(todosTickets);
//			System.out.println("Sb original: " +sb.toString());
			while(sb.indexOf("%") != -1){
				String ticketParcial = sb.substring(0, sb.indexOf("%"));
//				System.out.println("Ticket Parcial: " +ticketParcial);
				sb = new StringBuilder(sb.substring((sb.indexOf("%")+1), sb.length()));
//				System.out.println("sb quedo:"+sb.toString());
				queryString = "UPDATE salidas SET factura = 0 WHERE numTicket = "+cambiaAInt(ticketParcial)+" AND activo = 1";
				stmt = con.creaStatement();
				stmt.execute(queryString);
				stmt.close();
				queryString = "UPDATE creditos SET factura = 0 WHERE numTicket = "+cambiaAInt(ticketParcial)+" AND activo = 1";
				stmt = con.creaStatement();
				stmt.execute(queryString);
				stmt.close();
			}
			queryString = "UPDATE salidas SET factura = 0 WHERE numTicket = "+cambiaAInt(sb.toString())+" AND activo = 1";
			stmt = con.creaStatement();
			stmt.execute(queryString);
			stmt.close();
			queryString = "UPDATE creditos SET factura = 0 WHERE numTicket = "+cambiaAInt(sb.toString())+" AND activo = 1";
			stmt = con.creaStatement();
			stmt.execute(queryString);
			stmt.close();
			con.realizaCommit();
		}
		catch (SQLException sqle) {
			resultado = false;
			con.realizaRollback();
			error = "SQLException: Could not execute the query bajaDeFactura.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			resultado = false;
			con.realizaRollback();
			error = "An exception occured while retrieving bajaDeFactura.";
			throw new Exception(error);
		}
		finally{
			try{
				con.habilitaAutoCommit();
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo bajaDeFactura");
				q.printStackTrace();
			}
		}
		return resultado;
	}


	public ResultSet dameFacturasXTiempo( String fechaInicial, String fechaFinal){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT * FROM  facventas WHERE  estatus = 1 AND (fechaFac BETWEEN '"+fechaInicial+"' AND  '"+fechaFinal+"') ORDER BY numFactura");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPrecioProveedor, dameVentasXClienteXTiempo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPrecioProveedor, dameVentasXClienteXTiempo ");
			e.printStackTrace();
		}
		return rs;
	}


// Me envia los cobros realizado por TODOS los usuarios en una fecha especifica.
	public ResultSet dameCorteTodos(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT DISTINCT numticket, sumaVenta, usuario, tipoCobro, referenciaCobro, Tipo FROM (SELECT salidas.numTicket, salidas.sumaVenta, salidas.tipoCobro, salidas.usuario,  salidas.referenciaCobro, 1 AS Tipo FROM  salidas WHERE salidas.fechaVenta LIKE '"+fecha+"' AND activo = 1 UNION ALL SELECT creditos.numTicket,  creditos.cantidadAPagar AS sumaVenta,  creditos.tipoCobro, creditos.usuarioPago AS usuario, creditos.referenciaCobro, 2 AS Tipo FROM  creditos WHERE creditos.FechaRealPago like  '"+fecha+"'  AND activo = 1 ) AS temporal ORDER BY usuario,numticket,tipoCobro");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCorteTodos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteTodos.";
			throw new Exception(error);
		}
		return rs;
	}

	public ResultSet dameAbonos(String fecha)throws SQLException,Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT rfc, nombreCliente,fecha,monto,formatoPago,referenciaCobro, cobro FROM abonos WHERE fecha LIKE '"+fecha+"' AND estatus = 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCorteTodos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteTodos.";
			throw new Exception(error);
		}
		return rs;
	}

	public boolean hayTickets(String fecha)throws SQLException, Exception {
		ResultSet rs = null;
		boolean hayProductos = false;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT DISTINCT numticket  FROM (SELECT salidas.numTicket FROM  salidas WHERE salidas.fechaVenta LIKE '"+fecha+ "'   AND salidas.activo = 1 UNION ALL SELECT  creditos.numTicket FROM  creditos WHERE creditos.FechaRealPago LIKE  '"+fecha+"'  AND creditos.activo = 1 UNION ALL SELECT  (abonos.claveAbono)AS numTicket FROM  abonos WHERE abonos.fecha LIKE '"+fecha+"'  AND abonos.estatus = 1 ) AS temporal ORDER BY numticket  LIMIT 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				hayProductos = true;
			}
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query hayTickets.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving hayTickets.";
			throw new Exception(error);
		}
		 finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo hayTickets");
				q.printStackTrace();
			}
		 }
		return hayProductos;
	}


	public ResultSet dameConsecutivoTicketsSinCredito(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT MAX(salidas.numTicket)AS MaxTP, MIN(salidas.numTicket)MinTP FROM  salidas WHERE salidas.fechaVenta LIKE '"+fecha +"' AND activo = 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCorteTodos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteTodos.";
			throw new Exception(error);
		}
		return rs;
	}



	public ResultSet dameConsecutivoTicketsDeCredito(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT MAX(creditos.numTicket)AS MaxTP, MIN(creditos.numTicket)MinTP FROM  creditos WHERE creditos.fechaRealPago LIKE '"+fecha +"' AND activo = 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCorteTodos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteTodos.";
			throw new Exception(error);
		}
		return rs;
	}


// Me envia los cobros realizado en una fecha especifica, dividido de acuerdo a la tienda de origen.
	public ResultSet damePorTipoProducto(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT SUM(contenidoticket.precioAPagar) AS Pago, productos.genero FROM contenidoticket, productos  WHERE contenidoticket.fechaRealPago LIKE  '"+fecha+"' AND contenidoticket.estatusTicket = 1 AND contenidoticket.estatusPago != 0 AND productos.ID_Pro = contenidoticket.ID_Pro GROUP BY   productos.genero ");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query damePorTipoProducto.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving damePorTipoProducto.";
			throw new Exception(error);
		}
		return rs;
	}


// Me envia los cobros realizado por TODOS los usuarios en una fecha especifica.
	public ResultSet dameTotalesCorteTodos(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT DISTINCT SUM(sumaVenta)AS Total, usuario FROM (SELECT SUM(salidas.sumaVenta) AS sumaVenta,  salidas.usuario FROM  salidas WHERE salidas.fechaVenta LIKE '"+fecha+"'  AND activo = 1 GROUP BY salidas.usuario UNION ALL SELECT SUM(creditos.cantidadAPagar) AS sumaVenta, creditos.usuarioPago AS usuario FROM  creditos WHERE creditos.FechaRealPago LIKE '"+fecha+"'  AND activo = 1 AND creditos.tipoCobro != 6 GROUP BY creditos.usuario) AS temporal GROUP BY usuario ORDER BY usuario");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCorteTodos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteTodos.";
			throw new Exception(error);
		}
		return rs;
	}


// Me envia los cobros realizado por TODOS los usuarios en una fecha especifica.
	public ResultSet dameTotalesCorteAbonos(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT cobro, SUM(monto)AS Total FROM abonos WHERE fecha LIKE '"+fecha+"' GROUP BY cobro ORDER BY cobro");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCorteTodos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteTodos.";
			throw new Exception(error);
		}
		return rs;
	}

// Me envia los credito asignados en una fecha especifica, nuevo modulo de ventas:
	public ResultSet dameCreditosTodos() throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT numTicket, cantidadAPagar, rfc, nombreCliente, fechaCredito, fechaAPagar, estatusCredito FROM creditos WHERE estatusCredito != 2 AND activo = 1 AND nombreCliente != 'creditoInterno' ORDER BY rfc,nombreCliente");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCreditosTodos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCreditosTodos.";
			throw new Exception(error);
		}
		return rs;
	}


// Me envia los credito asignados en una fecha especifica, nuevo modulo de ventas:
	public ResultSet dameCreditosTodosV() throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT creditos.numTicket, creditos.cantidadAPagar, creditos.rfc, vendedores.NombreE, creditos.fechaCredito, creditos.fechaAPagar, creditos.estatusCredito FROM creditos, vendedores WHERE creditos.estatusCredito != 2 AND creditos.activo = 1 AND creditos.nombreCliente = 'creditoInterno' AND vendedores.claveVenta = creditos.rfc ORDER BY creditos.rfc, vendedores.claveVenta");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCreditosTodosV.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCreditosTodosV.";
			throw new Exception(error);
		}
		return rs;
	}


// Me envia los credito asignados en una fecha especifica, nuevo modulo de ventas:
	public ResultSet dameCreditosXFecha(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT numTicket, cantidadAPagar, rfc, nombreCliente, fechaAPagar, estatusCredito FROM creditos WHERE fechaCredito like '"+fecha+"' AND activo = 1 AND nombreCliente != 'creditoInterno' ORDER BY rfc");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCreditosXFecha.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCreditosXFecha.";
			throw new Exception(error);
		}
		return rs;
	}


// Me envia los credito asignados en una fecha especifica, nuevo modulo de ventas:
	public ResultSet dameCreditosXFechaV(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT creditos.numTicket, creditos.cantidadAPagar, creditos.rfc, vendedores.NombreE, creditos.fechaCredito, creditos.fechaAPagar, creditos.estatusCredito FROM creditos, vendedores WHERE creditos.fechaCredito like '"+fecha+"' AND creditos.activo = 1 AND creditos.nombreCliente = 'creditoInterno' AND vendedores.claveVenta = creditos.rfc ORDER BY creditos.rfc, vendedores.claveVenta");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCreditosXFecha.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCreditosXFecha.";
			throw new Exception(error);
		}
		return rs;
	}


// Me envia los credito vencidos en una fecha especifica, nuevo modulo de ventas:
	public ResultSet dameCreditosXFechaVencidos(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT numTicket, cantidadAPagar, rfc, nombreCliente, fechaAPagar, estatusCredito FROM creditos WHERE FechaAPagar like '"+fecha+"' AND estatusCredito = 1 AND activo = 1 AND nombreCliente != 'creditoInterno' ORDER BY rfc");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCreditosXFechaVencidos.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCreditosXFechaVencidos.";
			throw new Exception(error);
		}
		return rs;
	}


	public ResultSet productosVendidosXFechaRetonito(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT SUM(contenidoticket.cantidadProducto) AS Cantidad, contenidoticket.ID_Pro, contenidoticket.tipoVenta, productos.descripcion FROM contenidoticket, productos WHERE contenidoticket.fechaRealPago LIKE '"+fecha+"' OR (contenidoticket.fechaRealPago IS NULL AND contenidoticket.fechaRegistro LIKE '"+fecha+"') AND contenidoticket.estatusTicket = 1 AND (contenidoticket.estatusPago = 1 OR contenidoticket.estatusPago = 2) AND productos.ID_Pro = contenidoticket.ID_Pro GROUP BY contenidoticket.ID_Pro,contenidoticket.tipoVenta ORDER BY productos.descripcion");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			System.out.println("SQLException: Could not execute the query productosVendidosXFechaRetonito.");
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving productosVendidosXFechaRetonito.";
			throw new Exception(error);
		}
		return rs;
	}


	public ResultSet dameFacturas(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT numFactura, tickets, CONCAT(rfc,' /  ',nombre)AS cliente, fechaCrea, fechaFac, total FROM facventas WHERE estatus = 1 AND fechaCrea LIKE '"+fecha+"' ORDER BY fechaCrea,numFactura ASC");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameFacturas.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameFacturas.";
			throw new Exception(error);
		}
		return rs;
	}


	/**
	* El método dameFactura se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a una Factura.
	*  	@param 	numfactura	String con el Número de la Factura solicitada.
	*	@return rs 			ResultSet que contiene todos los datos correspondiente a una Factura.
	*/
	public ResultSet dameFactura(String numFactura) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = "SELECT * FROM facventas WHERE numFactura = '"+numFactura.trim()+"' AND estatus = 1 LIMIT 1";
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameFactura.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameFactura.";
			throw new Exception(error);
		}
		return rs;
	}


// CLASES PREVIAS..



/**
* El método existe2 verifica que la Factura solicitada existe dentro de nuestra Base de Datos y se encuentre habilitada, es decir que no haya sido dado de baja.
*  	@param numFactura	String con el Número de la Factura solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public int existe2(String numFactura) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
  	  String estatus = "1";
	  con = new ConexionBD();

  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.miConnection.createStatement();
  	  		rs = st.executeQuery("select * from salidas WHERE numFactura = '"+numFactura+"'");
  	  		while(rs.next()){

  	  			if(estatus.equals(rs.getString("factura"))){
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
	  		 		System.out.println("Error al cerrar conexion de ManagerFacturacion metodo existe2");
	  		 		q.printStackTrace();
	  			}
			 }
  	  }
  	  return bandera;
  }

  /**
  * El método baja_Factura se encarga de colocar un 0 en el campo "factura" de Salidas en la Base de Datos, para realizar una Baja lógica de la Factura correspondiente.
  *  	@param 	numFactura	String con el Número de la Factura solicitada.
  *		@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
  public int baja_Factura(String numFactura) throws SQLException, Exception {
              ResultSet rs = null;
              int bandera = 0;
              con = new ConexionBD();
              try  {

               String queryString = "UPDATE salidas SET factura ='0', numFactura='' WHERE numFactura ='"+numFactura+"'";
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
			   		System.out.println("Error al cerrar conexion de ManagerInventarios metodo baja_Factura");
			   		q.printStackTrace();
			  	}
			 }
              return bandera;
        }

/**
* El método dameFacturas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todas las Facturas que se encuentren activos, es decir que no hayan sido dados de baja, MODIFICADO PARA NUEVO MODULO DE VENTAS...
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todas las Facturas.
*/

/**
* El método consecutivoFacturas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todas las Facturas por mes que se encuentren activos, es decir que no hayan sido dados de baja, MODIFICADO PARA NUEVO MODULO DE VENTAS...
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todas las Facturas.
*/
	public ResultSet consecutivoFacturas(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT numFactura, rfc, fechaFactura, nombreCliente, SUM(totalPago) FROM (SELECT SUM(sumaVenta) AS totalPago, fechaFactura, nombreCliente, numFactura FROM salidas WHERE fechaFactura like '"+fecha+"' AND factura = 1 AND activo = 1 GROUP BY numFactura UNION ALL SELECT SUM(cantidadAPagar) AS totalPago, fechaFactura, nombreClieFac AS nombreCliente, numFactura FROM creditos WHERE fechaFactura like '"+fecha+"' AND factura = 1 AND activo = 1 GROUP BY numFactura)AS TEMPORAL, clientes WHERE clientes.nombre = nombreCliente GROUP BY numFactura ORDER BY fechaFactura");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query consecutivoFacturas.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving consecutivoFacturas.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo consecutivoFacturas");
				q.printStackTrace();
			}
		}
		return rs;
	}


// NUEVO POR TIPO PRODUCTO PARA RETOÑITO
	public double sumaProductosVendidosLiquidos(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		double total = 0.00;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT SUM(contenidoticket.precioAPagar)AS Cantidad FROM  contenidoticket, productos WHERE (contenidoticket.fechaRealPago LIKE '"+fecha +"' OR (contenidoticket.fechaRealPago IS NULL AND contenidoTicket.FechaTicket = '"+fecha +"' )) AND  contenidoticket.estatusPago != 0 AND productos.PLU =  contenidoticket.numArticulo AND productos.origen = 0 AND productos.esLiquido = 1 ORDER BY contenidoticket.numArticulo");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while (rs.next()){
				if(rs.getString("Cantidad") != null){
					total = rs.getInt("Cantidad");
				}
			}
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			System.out.println("SQLException: Could not execute the query sumaProductosVendidosLiquidos.");
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving sumaProductosVendidosLiquidos.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo sumaProductosVendidosLiquidos");
				q.printStackTrace();
			}
		}
		return total;
	}

// NUEVO POR TIPO PRODUCTO PARA RETOÑITO
	public ResultSet productosVendidosLiquidos(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT SUM(contenidoticket.pesoProducto)AS Cantidad, contenidoticket.tipoPrecio, contenidoticket.numArticulo, contenidoticket.descripcionArticulo, productos.clasePLU, contenidoticket.tipoUnidad  FROM  contenidoticket, productos WHERE (contenidoticket.fechaRealPago LIKE '"+fecha +"' OR (contenidoticket.fechaRealPago IS NULL AND contenidoTicket.FechaTicket = '"+fecha +"' )) AND  contenidoticket.estatusPago != 0 AND productos.PLU =  contenidoticket.numArticulo AND productos.origen = 0 AND productos.esLiquido = 1 GROUP BY CONCAT(contenidoticket.numArticulo,'',contenidoticket.tipoUnidad,'',contenidoticket.tipoPrecio) ORDER BY contenidoticket.numArticulo");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			System.out.println("SQLException: Could not execute the query productosVendidosLiquidos.");
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving productosVendidosLiquidos.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo productosVendidosLiquidos");
				q.printStackTrace();
			}
		}
		return rs;
	}


// NUEVO PARA TOTAL PRODUCTOS MOD VENTAAS

	public ResultSet productosVendidosXFechaPozito(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT SUM(contenidoticket.pesoProducto)AS Cantidad, contenidoticket.numArticulo, contenidoticket.descripcionArticulo, productos.clasePLU, contenidoticket.tipoUnidad FROM  contenidoticket, productos WHERE (contenidoticket.fechaRealPago LIKE '"+fecha +"' OR (contenidoticket.fechaRealPago IS NULL AND contenidoTicket.FechaTicket = '"+fecha +"' )) AND  contenidoticket.estatusPago != 0 AND productos.PLU =  contenidoticket.numArticulo AND productos.origen = 1 GROUP BY CONCAT(contenidoticket.numArticulo,'',contenidoticket.tipoUnidad) ORDER BY descripcionArticulo");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			System.out.println("SQLException: Could not execute the query productosVendidosXFechaPozito.");
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving productosVendidosXFechaPozito.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo productosVendidosXFechaPozito");
				q.printStackTrace();
			}
		}
		return rs;
	}

//FINALIZA NUEVO


  /**
  * El método dameNombreCliente se encarga de enviar el nombre del Cliente solicitado de acuerdo a su RFC.
  *  	@param 	rfc			String con el RFC del Cliente solicitado.
  *		@return rs			String con el Nombre del Cliente.
  */

  public String dameNombreCliente(String rfc) throws SQLException, Exception {

       String rs = new String();
       ResultSet rz = null;
		con = new ConexionBD();
       try  {
            String queryString = ("SELECT * FROM clientes WHERE rfc = '"+rfc+"' ");
            Statement stmt = con.miConnection.createStatement();
            rz = stmt.executeQuery(queryString);
            while(rz.next()){
  	              	rs = rz.getString("nombre");
             }
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query dameNombreCliente.";
              throw new SQLException(error);
            } catch (Exception e) {
  	              error = "An exception occured while retrieving dameNombreCliente.";
  	              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameNombreCliente");
			   		q.printStackTrace();
			 	}
		   }

          return rs;
      }


// PARA ENVIAR TODOS LOS TICKETS QUE COMPONEN UNA FACTURA
 public ResultSet ticketsComponentes(String numFactura) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = "SELECT numTicket, fecha FROM (SELECT numTicket, fecha FROM salidas where numFactura='"+numFactura +"' AND activo = 1 UNION ALL SELECT numTicket, fechaCredito AS fecha FROM creditos where numFactura='"+numFactura +"' AND activo = 1) AS KIKO";
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query ticketsComponentes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving ticketsComponentes.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerFacturacion metodo ticketsComponentes");
		   		q.printStackTrace();
		  	}
		}
        return rs;
  }
  // TERMINA RECEPCION DE TICKETS DE FACTURA




   public String dameFacturaTicket(String numfactura) throws SQLException, Exception
   {
          ResultSet rs = null;
          String ti = new String();
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM salidas WHERE numfactura = '"+numfactura+"'");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
            while(rs.next()){
            	ti = rs.getString("numTicket");
            	}
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameFacturaTicket.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameFacturaTicket.";
            throw new Exception(error);
          }
          finally{
  			try{
  		   		con.cierraConexion();
  		  	}
  		   	catch (Exception q){
  		   		System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameFacturaTicket");
  		   		q.printStackTrace();
  		  	}
  		}
          return ti;
    }

   public String dameFacturaBascula(String numfactura) throws SQLException, Exception
   {
          ResultSet rs = null;
          String ti = new String();
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM salidas WHERE numfactura = '"+numfactura+"'");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
            while(rs.next()){
            	ti = rs.getString("balanza");
            	}
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameFacturaBascula.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameFacturaBascula.";
            throw new Exception(error);
          }
          finally{
  			try{
  		   		con.cierraConexion();
  		  	}
  		   	catch (Exception q){
  		   		System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameFacturaBascula");
  		   		q.printStackTrace();
  		  	}
  		}
          return ti;
    }

   public String dameFacturaFecha(String numfactura) throws SQLException, Exception
   {
          ResultSet rs = null;
          String ti = new String();
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM salidas WHERE numfactura = '"+numfactura+"'");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
            while(rs.next()){
            	ti = rs.getString("fecha");
            	}
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameFacturaFecha.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameFacturaFecha.";
            throw new Exception(error);
          }
          finally{
  			try{
  		   		con.cierraConexion();
  		  	}
  		   	catch (Exception q){
  		   		System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameFacturaFecha");
  		   		q.printStackTrace();
  		  	}
  		}
          return ti;
    }


// NUEVAS FUNCIONES NUEVAS FACTURAS!!!:



// CON ESTA CHECO QUE NO EXISTA UNA FACTURA PREVIA...


// Me envia el total por Usuario de cobros realizado en una fecha especifica.
	public ResultSet dameImpresionXUsuario(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		if(fecha.length() <= 7){
			fecha = fecha+"-%%";
		}
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT SUM(sumaVenta)AS total, nombreE, tipo FROM (SELECT DISTINCT  salidas.numTicket,  salidas.sumaVenta,  usuario.NombreE,  salidas.activo+1 AS tipo FROM  salidas, usuario  WHERE  (usuario.claveVenta = salidas.usuario OR usuario.USUARIO_ID = salidas.usuario)  AND salidas.fecha LIKE '"+fecha+"' AND activo = 1  UNION ALL  SELECT DISTINCT  creditos.numTicket, creditos.cantidadAPagar AS sumaVenta,  usuario.NombreE,  creditos.activo+2 AS tipo  FROM  creditos,usuario  WHERE  (usuario.claveVenta = creditos.usuarioPago OR usuario.USUARIO_ID = creditos.usuarioPago)  AND creditos.FechaRealPago like '"+fecha+"'  AND activo = 1 ) AS temporal  GROUP BY CONCAT(nombreE,' ',tipo)  ORDER BY CONCAT(nombreE,' ',tipo,' ',numTicket)");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameImpresionXUsuario.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameImpresionXUsuario.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameImpresionXUsuario");
				q.printStackTrace();
			}
		}
		return rs;
	}

// CON ESTA CHECO QUE EXISTA LA FACTURA QUE SE DESEA ELIMINAR..
// 0 --> no existe
// 1 --> si existe, pero no pude eliminar
// 2 --> existio y ya elimine.

	public int existeFacBorro(String nombreFactura) throws SQLException, Exception {
		int accion = 0;
		ResultSet rs = null;
		String obj = null;
		nombreFactura = nombreFactura.trim();
		String nombreOK = "";
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
					if(nombreFactura.equalsIgnoreCase(temporal.trim())){
						accion = 1;
						nombreOK = rs.getString("numFactura");
					}
					sb=sb.delete(0,(sb.indexOf("?")+1));
				}
				temporal = sb.toString().trim();
				if(nombreFactura.equalsIgnoreCase(temporal.trim())){
					accion = 1;
					nombreOK = rs.getString("numFactura");
				}
				if(nombreFactura.equalsIgnoreCase(facturas.trim())){
					accion = 1;
					nombreOK = rs.getString("numFactura");
				}
			}
			if(accion==1){
				queryString = "UPDATE salidas SET factura = 0, numFactura='', fechaFactura='',rfcClie='', nombreCliente='' WHERE numFactura='"+nombreOK +"' AND activo =1";
				stmt = con.creaStatement();
				stmt.execute(queryString);
				accion = 2;
				queryString = "UPDATE creditos SET factura = 0, numFactura='', fechaFactura='' WHERE numFactura='"+nombreOK +"' AND activo =1";
				stmt = con.creaStatement();
				stmt.execute(queryString);
				accion = 2;
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta existeFac.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de existeFac."+e;
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
		return accion;
	}

// Me envia el total de los cobros realizado por TODOS los usuarios en una fecha especifica.
	public double dameTotal(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		double elTotal = 0.00;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT SUM(sumaVenta) AS total FROM salidas WHERE fecha LIKE '"+fecha+"' AND activo = 1");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while (rs.next()){
				elTotal = rs.getDouble("total");
			}
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameTotal.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameTotal.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameTotal");
				q.printStackTrace();
			}
		}
		return elTotal;
	}

// TERMINAN NUEVAS FUNCIONES

 public ResultSet dameCobros(String usuario) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM salidas WHERE usuario = '"+usuario+"'");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCobros.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCobros.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameCobros");
		   		q.printStackTrace();
		  	}
		}
        return rs;
  }


// Me envia los cobros realizado en una fecha especifica, modificado para nuevo modulo de ventas:
	public ResultSet dameCobros2(String usuario, String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM salidas WHERE usuario = '"+usuario+"' AND fecha like '"+fecha+"' AND activo = 1 ORDER BY numTicket");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCobros.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCobros.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameCobros");
				q.printStackTrace();
			}
		}
		return rs;
	}

// Me envia los cobros realizado en una fecha especifica por creditos, nuevo modulo de ventas:
	public ResultSet dameCobros3(String usuario, String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT numTicket, cantidadAPagar FROM creditos WHERE usuarioPago = '"+usuario+"' AND FechaRealPago like '"+fecha+"' AND activo = 1 ORDER BY numTicket");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCobros.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCobros.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameCobros");
				q.printStackTrace();
			}
		}
		return rs;
	}








// Me envia los cobros realizado en una fecha especifica, dividido de acuerdo a la tienda de origen.
	public ResultSet dameCobrosXTienda(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT TotalR, TotalR2, TotalP, TotalP2 FROM ((SELECT DISTINCT SUM(contenidoticket.precioAPagar)AS TotalR FROM contenidoticket, productos WHERE contenidoticket.fechaRealPago LIKE '"+fecha+"' AND contenidoticket.estatusPago = 1 AND productos.PLU =  contenidoticket.numArticulo AND productos.origen = 0) AS retonito, (SELECT DISTINCT SUM(contenidoticket.precioAPagar)AS TotalP FROM  contenidoticket, productos WHERE contenidoticket.fechaRealPago LIKE '"+fecha+"' AND contenidoticket.estatusPago = 1 AND productos.PLU =  contenidoticket.numArticulo AND productos.origen = 1) AS pozito, (SELECT DISTINCT SUM(contenidoticket.precioAPagar)AS TotalR2 FROM contenidoticket, productos, creditos WHERE contenidoticket.fechaRealPago LIKE '"+fecha+"' AND contenidoticket.estatusPago = 2 AND productos.PLU =  contenidoticket.numArticulo AND productos.origen = 0 AND creditos.numTicket = contenidoticket.numTicket AND creditos.estatusCredito = 2 AND creditos.activo = 1) AS retonitoCred, (SELECT DISTINCT SUM(contenidoticket.precioAPagar)AS TotalP2 FROM contenidoticket, productos, creditos WHERE contenidoticket.fechaRealPago LIKE '"+fecha+"' AND contenidoticket.estatusPago = 2 AND productos.PLU =  contenidoticket.numArticulo AND productos.origen = 1 AND creditos.numTicket = contenidoticket.numTicket AND creditos.estatusCredito = 2 AND creditos.activo = 1) AS pozitoCred )");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCobrosXTienda.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCobrosXTienda.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameCobrosXTienda");
				q.printStackTrace();
			}
		}
		return rs;
	}







/**
* El método obtenDatos se encarga de almacenar en un String el formato de fecha y tiempo de acuerdo con el horario GMT de la siguiente manera: yyyymmddhhmmss, en los casos donde es posible que se regrese un solo dígito (por ejemplo día: 2) se manda checar y en caso de que esto ocurra se agrega un 0 para poder cumplir con el formato.
*/
	public String obtenDatos(){
		String time;
		Calendar tiempoSistema = Calendar.getInstance();
		StringBuffer cadena = new StringBuffer();
		String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
		int mes = tiempoSistema.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mes));
		int dia = tiempoSistema.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(dia));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		return (time = new String(cadena));
	}

/**
* Revisa que el tamaño del dato sea mayor a un solo dígito para cumplir con el formato, en caso de no ser así se le agrega un 0 al inicio, los casos en que se verifica son: mes, día,  hora, minuto, segundo.
* @return String que representa el valor recibido probablemente en caso de que haya sido necesario ya modificado.
*/
	private String checkSize (int revisa){
		StringBuffer verificador = new StringBuffer(revisa+"");
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
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


/**
* El método cambiaADouble se encarga de transformar a un Double una variables en formato String.
*  	@param 	variable	String a tranformar a double.
*	@return valor 		double con el valor de la variable.
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


	public String acortaLongitud(String muchosDecimales){
		//System.out.println("muchosDecimales: "+muchosDecimales);
		StringBuffer sb = new StringBuffer (muchosDecimales);
		if(sb.indexOf(".") != -1){
			String decimales=sb.substring(sb.indexOf("."));
			String decima;
			decima = sb.substring(0, sb.indexOf("."));
			sb.delete(0,sb.length());
			if (decimales.length()>3){
				decimales = decimales.substring(0,3);
			}
			else if(decimales.length()<=2){
				decimales =  decimales+"0";
			}
		sb.append(decima);
		sb.append(decimales);
		}
		//System.out.println("muchosDecimales Salida: "+sb);
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

	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}

	public String formatoMaxUnDecimal(String numero){
		StringBuilder  sb = new StringBuilder(numero);
		if(sb.indexOf(".5")!= -1){
			sb = sb.delete(sb.indexOf(".")+2, sb.length());
		}
		else{
			sb = sb.delete(sb.indexOf("."), sb.length());
		}
		return sb.toString();
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


	public String formatoDinero(String formato){
		StringBuffer losEnteros = new StringBuffer(dameEnteros(formato));
		String losDecimales = dameDecimales(formato);
		if(losEnteros.length() == 7){
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


}