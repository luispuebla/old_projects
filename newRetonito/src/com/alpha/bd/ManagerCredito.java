package com.alpha.bd;

import java.sql.SQLException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Vector;
import java.util.Calendar;
import com.alpha.bd.CalculaDate;
import com.alpha.bd.DateStamp;
import com.alpha.bd.TimeStamp;


public class ManagerCredito {

	private ConexionBD con = null;
	private String numTicket;
	private String fecha;
	private String cliente;
	private String rfc;
	private String incrementoDias;
	private String usuario;
	private int diasAPagar;
	private double cantidadAPagar;
	public String fechaPago ="";
	public String formaPago = "0";
	public String referenciaC = "";
	protected TimeStamp tiempo = null;
	protected DateStamp ds = null;

  	public ManagerCredito()   { }


	public ResultSet dameClientesConRemisionesActivas() throws SQLException, Exception{
		ResultSet rs = null;
		try  {
			String queryString = ("SELECT DISTINCT ticket_ligado.ID_Liga, ticket_ligado.rfc, ticket_ligado.nombre FROM ticket_ligado, creditos WHERE ticket_ligado.estatus = 0 AND creditos.numTicket = ticket_ligado.numTicket AND creditos.activo = 1 AND creditos.factura != 1 GROUP BY ticket_ligado.rfc,ticket_ligado.nombre ORDER BY ticket_ligado.nombre" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta dameClientesConRemisionesActivas.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de dameClientesConRemisionesActivas."+e;
		}
		return rs;
	}



	public String dameNombreClieXTicketLigado(String remision) throws SQLException, Exception{
		ResultSet rs = null;
		String nombreClie = "";
		try  {
			String queryString = ("SELECT ticket_ligado.nombre FROM ticket_ligado WHERE ticket_ligado.ID_Liga = "+cambiaAInt(remision));
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while (rs.next()){
				nombreClie = rs.getString("nombre");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta dameNombreClieXTicketLigado.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de dameNombreClieXTicketLigado."+e;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				q.printStackTrace();
			}
		}
		return nombreClie;
	}

	public String dameRFCClieXTicketLigado(String remision) throws SQLException, Exception{
		ResultSet rs = null;
		String rfcClie = "";
		try  {
			String queryString = ("SELECT ticket_ligado.rfc  FROM ticket_ligado WHERE ticket_ligado.ID_Liga = "+cambiaAInt(remision));
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while (rs.next()){
				rfcClie = rs.getString("rfc");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta dameRFCClieXTicketLigado.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de dameRFCClieXTicketLigado."+e;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				q.printStackTrace();
			}
		}
		return rfcClie;
	}

	public void cambiaEstatusNoSeFactura(String numRemision) throws SQLException, Exception{
		try  {
			String queryString = ("UPDATE ticket_ligado SET estatus = 2 WHERE ID_Liga = '"+cambiaAInt(numRemision)+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			stmt.execute(queryString);
			stmt.close();
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta cambiaEstatusNoSeFactura.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de cambiaEstatusNoSeFactura."+e;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				q.printStackTrace();
			}
		}
	}

	public ResultSet dameRemisionesDeCliente(String nombreClie, String rfcClie) throws SQLException, Exception{
		ResultSet rs = null;
		try  {
			String queryString = ("SELECT ticket_ligado.ID_Liga, ticket_ligado.rfc, ticket_ligado.nombre, creditos.numTicket, creditos.cantidadAPagar, creditos.fechaCredito FROM ticket_ligado, creditos WHERE ticket_ligado.estatus = 0 AND ticket_ligado.rfc = '"+rfcClie +"' AND ticket_ligado.nombre = '"+nombreClie +"' AND creditos.numTicket = ticket_ligado.numTicket AND creditos.activo = 1 AND creditos.factura != 1 ORDER BY ticket_ligado.ID_Liga" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta dameClientesConRemisionesActivas.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de dameClientesConRemisionesActivas."+e;
		}
		return rs;
	}


  	public void setIncrementoDias(String incrementoDias){
		this.incrementoDias = incrementoDias;
	}

	public void setFormaPago(String formaPago){
		this.formaPago = formaPago;
	}

	public void setReferenciaC(String referenciaC){
		this.referenciaC = referenciaC;
	}

  	public void setCliente(String cliente){
		this.cliente = cliente;
	}

	public void setRfc(String rfc){
		this.rfc = rfc;
	}

	public void setUsuario(String usuario){
		this.usuario = usuario;
	}

	public void setDiasAPagar(int diasAPagar){
		this.diasAPagar = diasAPagar;
	}

	public void setCantidadAPagar(double cantidadAPagar){
		this.cantidadAPagar = cantidadAPagar;
	}

  	public void setNumTicket(String numTicket) throws Exception{
		this.numTicket = completaString(numTicket);
	}

	public void setFecha(String fecha) throws Exception{
		this.fecha = fecha;
	}



	public String dameFechaHoy() throws Exception{
		tiempo = new TimeStamp();
		return  tiempo.date2;
	}


// VOY A CHECAR SI EXISTE EL TICKET
// 3 --> SI EXISTE PERO YA ESTA ASIGNADO A CREDITO
// 2 --> SI EXISTE PERO YA ESTA PAGADO
// 1 --> SI EXISTE Y NO ESTA PAGADO
// 0 --> NO EXISTE
	public int existe() throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT numTicket, estatusPago FROM contenidoticket WHERE numTicket = " +cambiaAInt(numTicket) +" AND fechaRegistro = '" +formateaFecha(fecha)+"'");
				while(rs.next()){
					if(cambiaAInt(numTicket) ==rs.getInt("numTicket")) {
						bandera = 1;//SI EXISTE
					}
					if(rs.getInt("estatusPago")==1) {
						bandera = 2;//ya esta pagado.
					}
					if(rs.getInt("estatusPago")==2) {
						bandera = 3;//ya esta dado a credito.
					}
				}
				rs.close();
				st.close();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de Cobrador metodo existe");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}

/**
* El método cancelaTicket sirve para cambiar el estado del ticket a No pagado...
*  	@param 	numticket	String con el número de Ticket solicitado.
*	@return bandera 	boolean True --> se cambio estado con exito, False -->existio un problema...
*/

	public boolean cancelaTicket(String numTicket, String user) throws SQLException, Exception {
		boolean bandera = true;
		double totalTicket =  0.00;
		String fechaTicket = "";
		String elRFC = "";
		String elCliente = "";
		boolean yaFuePagado = false;
		con = new ConexionBD();
		if (con !=null) {
			try  {
				con.cancelaAutoCommit();
				// Primero restauro el Ticket en ContenidoTicket a no Pagado y borro la fecha de pago registrada.
				String queryString = 	"UPDATE contenidoticket SET estatusPago = 0, fechaRealPago = NULL  WHERE numTicket = "+cambiaAInt(numTicket) + " AND estatusTicket = 1";
				Statement stmt = con.creaStatement();
				stmt.execute(queryString);
				stmt.close();
				// Averiguo la fecha del Ticket que estoy cancelando...
				queryString = "SELECT fechaRegistro FROM contenidoTicket  WHERE numTicket = "+cambiaAInt(numTicket) +" AND estatusTicket = 1  LIMIT 1";
				stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(queryString);
				while(rs.next()){
					fechaTicket = rs.getString("fechaRegistro");
				}
				rs.close();
				stmt.close();
				// Ahora como es a credito elimino de forma logica la entrada en mi tabla de salidas, pero antes averiguo si ya esta facturado el Ticket para también cancelar la Factura, tambien averiguo el total de la venta para almacenarlo en mi tabla de cancelacion y si ya fue pagado para devolver o no el saldo al cliente.
				boolean existeFactura = false;
				queryString = "SELECT factura, cantidadAPagar, estatusCredito, rfc, nombreCliente FROM creditos WHERE numTicket = "+cambiaAInt(numTicket) +" AND activo = 1 ";
				stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){
					if(rs.getInt("factura") == 1){
						existeFactura = true;
					}
					if(rs.getInt("estatusCredito") == 2){
						yaFuePagado = true;
					}
					totalTicket = rs.getDouble("cantidadAPagar");
					elRFC = rs.getString("rfc");
					elCliente = rs.getString("nombreCliente");
				}
				rs.close();
				stmt.close();
				queryString="UPDATE creditos SET activo = 0 WHERE numTicket = "+cambiaAInt(numTicket) +" AND activo = 1";
				stmt = con.creaStatement();
				stmt.execute(queryString);
				stmt.close();
				// AQUI CANCELARIA LA (S) FACTURAS...
				if(existeFactura){
					// voy a buscar la factura que al menos tenga una entrada similar a mi ticket.....
					queryString = "SELECT tickets, numFactura FROM facventas WHERE estatus = 1 AND tickets LIKE '%"+numTicket +"%'";
					stmt = con.creaStatement();
					rs = stmt.executeQuery(queryString);
					boolean encontrado = false;
					String numFacturaCorrespondiente = "";
					while(rs.next() && !encontrado){
						StringBuilder sb = new StringBuilder(rs.getString("tickets"));
						while(sb.indexOf("%") != -1){
							String ticketParcial = sb.substring(0, sb.indexOf("%"));
							sb = new StringBuilder(sb.substring((sb.indexOf("%")+1), sb.length()));
							if(ticketParcial.equalsIgnoreCase(numTicket.trim())){
								numFacturaCorrespondiente = rs.getString("numFactura");
								encontrado = true;
							}
						}
						String ticketParcial = sb.toString();
						if(ticketParcial.equalsIgnoreCase(numTicket.trim())){
							numFacturaCorrespondiente = rs.getString("numFactura");
							encontrado = true;
						}
					}
					// Si ya la encontre ahora la elimino..
					queryString = ("SELECT tickets FROM facventas WHERE numFactura = '"+numFacturaCorrespondiente.trim()+"' AND estatus = 1 LIMIT 1");
					stmt = con.miConnection.createStatement();
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
					while(sb.indexOf("%") != -1){
						String ticketParcial = sb.substring(0, sb.indexOf("%"));
						sb = new StringBuilder(sb.substring((sb.indexOf("%")+1), sb.length()));
						queryString = "UPDATE salidas SET factura = 0 WHERE numTicket = "+cambiaAInt(ticketParcial)+"";
						stmt = con.creaStatement();
						stmt.execute(queryString);
						stmt.close();
						queryString = "UPDATE creditos SET factura = 0 WHERE numTicket = "+cambiaAInt(ticketParcial)+"";
						stmt = con.creaStatement();
						stmt.execute(queryString);
						stmt.close();
					}
					queryString = "UPDATE salidas SET factura = 0 WHERE numTicket = "+cambiaAInt(sb.toString())+"";
					stmt = con.creaStatement();
					stmt.execute(queryString);
					stmt.close();
					queryString = "UPDATE creditos SET factura = 0 WHERE numTicket = "+cambiaAInt(sb.toString())+" ";
					stmt = con.creaStatement();
					stmt.execute(queryString);
					stmt.close();
				}
				// AQUI REINGRESO EL CREDITO A MI CLIENTE SOLO SI NO HA PAGADO AUN.
				if(!yaFuePagado &&  !(elCliente.equalsIgnoreCase("creditoInterno"))){
//					System.out.println("Si reingrese el Saldo...");
				//Regreso Saldo al Cliente
					PreparedStatement updateSaldoClie;
					updateSaldoClie = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo + ? ) WHERE rfc  = ? AND nombre = ?  AND activo = ?");
					updateSaldoClie.setDouble(1, totalTicket); // El  monto del Ticket a prestamo
					updateSaldoClie.setString(2, elRFC); // Identificador Del Cliente (rfc)
					updateSaldoClie.setString(3, elCliente); // Identificador Del Cliente (nombre)
					updateSaldoClie.setInt(4, 1); // Activo
					updateSaldoClie.execute();
				}
				// AHORA REINTEGRO A INVENTARIO
				queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(numTicket) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
				stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){
					int ID_Pro = rs.getInt("ID_Pro");
					int tipoVenta = rs.getInt("tipoVenta");
					double laCantidad = rs.getDouble("cantidadProducto");
					double losKgEnPz = rs.getDouble("pesoEnPz");
					if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda + ?) WHERE ID_Pro = ? AND activo = ?");
						updateInventario.setDouble(1, laCantidad); // Cantidad
						updateInventario.setInt(2, ID_Pro); // Identificador Producto
						updateInventario.setInt(3, 1); // Activo
						updateInventario.execute();
					}
					else if(tipoVenta == 3){ // Caja
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda + (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
						updateInventario.setDouble(1, laCantidad); // Cantidad
						updateInventario.setInt(2, ID_Pro); // Identificador Producto
						updateInventario.setInt(3, 1); // Activo
						updateInventario.execute();
					}
					else if(tipoVenta ==4){ // Pieza
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda + ? ) WHERE ID_Pro = ? AND activo = ?");
						updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
						updateInventario.setInt(2, ID_Pro); // Identificador Producto
						updateInventario.setInt(3, 1); // Activo
						updateInventario.execute();
					}
				}
				// FINALMENTE GUARDO CANCELACION EN LA TABLA CORRESPONDIENTE
				tiempo = new TimeStamp();
				ds = new DateStamp();
				PreparedStatement updateCancelaTicket;
				updateCancelaTicket = con.miConnection.prepareStatement(	"INSERT INTO cancelacion VALUES(?,?,?,?,?,?,?,?);");
				updateCancelaTicket.setNull(1, java.sql.Types.INTEGER);
				updateCancelaTicket.setInt(2, cambiaAInt(numTicket));
				updateCancelaTicket.setDate(3, cambiaADate(fechaTicket));
				updateCancelaTicket.setInt(4, 2);
				updateCancelaTicket.setString(5, user);
				updateCancelaTicket.setDouble(6, totalTicket );
				updateCancelaTicket.setDate(7, cambiaADate(ds.obtenDatos()));
				updateCancelaTicket.setString(8, tiempo.time);
				updateCancelaTicket.execute();
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				bandera = false;
				con.realizaRollback();
				String error = "SQLException: No se puedo realizar CambioEstatusNoPagado.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch(Exception e){
				con.realizaRollback();
				bandera = false;
				e.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println(	"Error al cerrar conexion de mticket metodo cancelaTicket");
					q.printStackTrace();
				}
			}
		}
		else{
			bandera = false;
		}
		return bandera;
	}


// ME REGRESA LA LISTA DE CREDITOS VENCIDOS
	public synchronized ResultSet dameTicketsVencidos() throws SQLException, Exception{
		BloqueaClientes bc = new BloqueaClientes();
		bc.depura();
		ResultSet rs = null;
		try  {
			String queryString = ("SELECT numTicket, rfc, nombreCliente, fechaAPagar FROM creditos WHERE estatusCredito = 1 AND activo = 1" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta dameTicketsVencidos.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de dameTicketsVencidos."+e;
		}
		return rs;
	}

	public void cierraConexion() throws SQLException, Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerCredito metodo cierraConexion");
				q.printStackTrace();
			}
		}
	}


// MODIFICA LA FECHA DE ENTREGA DE ACUERDO A LOS DIAS SELECCIONADOS
	public boolean modificaFechaTicketVencido(){
		boolean exito = false;
		ResultSet rs = null;
		String fechaAIncrementar ="";
		try  {
			String queryString = ("SELECT fechaAPagar FROM creditos WHERE numTicket='"+numTicket+"' AND activo = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				fechaAIncrementar = rs.getString("fechaAPagar");
			}
			String nuevaFecha = parseaFecha(fechaAIncrementar);
			queryString = "UPDATE creditos SET estatusCredito = 0, fechaAPagar ='"+nuevaFecha +"' WHERE numTicket = '"+numTicket +"' AND activo = 1";
			stmt = con.creaStatement();
			stmt.execute(queryString);
			exito = true;
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta modificaFechaTicketVencido.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de modificaFechaTicketVencido."+e;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return exito;
	}


// ME REGRESA LA CANTIDAD A PAGAR DE UN TICKET!
	public double obtenVentasTicket(){
		double cantidadAPagar=0;
		ResultSet rs = null;
		try  {
			String queryString = ("SELECT SUM(precioAPagar) AS total from contenidoticket WHERE numTicket = "+cambiaAInt(numTicket) +" AND fechaRegistro = '" +formateaFecha(fecha) +"' AND estatusPago = 0 AND estatusTicket = 1" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				cantidadAPagar=rs.getDouble("total");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta obtenVentasTicket.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de obtenVentasTicket."+e;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return cantidadAPagar;
	}


// 0 --> OK,  1 --> Falta Producto,  2 --> Ya dado a credito,  3 --> ERROR
	public synchronized int daTicketACredito(String fecha,String ticket1,String ticket2,String ticket3, String ticket4,String  ticket5, String pago1,String  pago2,String  pago3, String pago4, String pago5,String nombre,String rfc, String diasAPagarL, String usuario) throws SQLException, Exception{
		this.fecha = fecha;
		this.cliente = nombre;
		this.rfc = rfc;
		this.diasAPagar = Integer.parseInt(diasAPagarL);
		this.usuario = usuario;
		int resultado = 0;
		boolean faltaProducto = false;
		boolean yaPagado = false;
		String serieTickets = "(";
		// Existe el ticket y es a pagar al contado.
		if(ticket1.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket1 +" ";
			}
		}
		if(ticket2.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket2 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket2 +" ";
			}
		}
		if(ticket3.length() > 0 ){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket3 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket3 +" ";
			}
		}
		if(ticket4.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket4 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket4 +" ";
			}
		}
		if(ticket5.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket5 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket5 +" ";
			}
		}
		serieTickets +=") ";
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				ResultSet rs = null;
				Statement stmt = null;
				String query = "SELECT SUM(Suma) AS Suma, ID_Pro FROM (SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 1 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 2 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto*productos.cantidadXCaja) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM  contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 3 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.pesoEnPz) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 4 AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta) as kiko GROUP BY ID_Pro";
				stmt =  con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					String existenciaQ = "SELECT invTienda, tipoPro FROM productos WHERE ID_Pro = "+rs.getInt("ID_Pro");
					Statement stmt2 = con.miConnection.createStatement();
					ResultSet rs2 = stmt2.executeQuery(existenciaQ);
					while (rs2.next() && !faltaProducto){
						if(rs2.getDouble("invTienda") < rs.getDouble("Suma")){
							faltaProducto = true;
						}
					} // Cierro while rs2
					rs2.close();
					stmt2.close();
				}// Cierro while rs
				rs.close();
				stmt.close();
				if(faltaProducto){
					resultado = 1;
				}
				else{
					if(ticket1.length() > 0 && !yaPagado){ // El ticket1 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket1) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket1.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket1) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							CalculaDate cd = new CalculaDate();
							cd.parseaADate(formateaFecha(fecha));
							cd.setNuevaFecha(cambiaAInt(diasAPagarL));
							fechaPago = cd.obtenDatos();
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket1));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(fechaPago));
							updateTablaCredito.setString(4, rfc);
							updateTablaCredito.setString(5, cliente);
							updateTablaCredito.setDouble(6, cambiaADouble(pago1));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket1) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
							// Quito de Saldo al Cliente
							PreparedStatement updateSaldoClie;
							updateSaldoClie = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo - ? ) WHERE rfc  = ? AND nombre = ?  AND activo = ?");
							updateSaldoClie.setDouble(1, cambiaADouble(pago1)); // El  monto del Ticket a prestamo
							updateSaldoClie.setString(2, rfc); // Identificador Del Cliente (rfc)
							updateSaldoClie.setString(3, cliente); // Identificador Del Cliente (nombre)
							updateSaldoClie.setInt(4, 1); // Activo
							updateSaldoClie.execute();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket1

					if(ticket2.length() > 0 && !yaPagado){ // El ticket2 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket2) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket2.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket2) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							CalculaDate cd = new CalculaDate();
							cd.parseaADate(formateaFecha(fecha));
							cd.setNuevaFecha(cambiaAInt(diasAPagarL));
							fechaPago = cd.obtenDatos();
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket2));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(fechaPago));
							updateTablaCredito.setString(4, rfc);
							updateTablaCredito.setString(5, cliente);
							updateTablaCredito.setDouble(6, cambiaADouble(pago2));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket2) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
							// Quito de Saldo al Cliente
							PreparedStatement updateSaldoClie;
							updateSaldoClie = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo - ? ) WHERE rfc  = ? AND nombre = ?  AND activo = ?");
							updateSaldoClie.setDouble(1, cambiaADouble(pago2)); // El  monto del Ticket a prestamo
							updateSaldoClie.setString(2, rfc); // Identificador Del Cliente (rfc)
							updateSaldoClie.setString(3, cliente); // Identificador Del Cliente (nombre)
							updateSaldoClie.setInt(4, 1); // Activo
							updateSaldoClie.execute();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket2

					if(ticket3.length() > 0 && !yaPagado){ // El ticket3 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket3) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket3.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket3) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							CalculaDate cd = new CalculaDate();
							cd.parseaADate(formateaFecha(fecha));
							cd.setNuevaFecha(cambiaAInt(diasAPagarL));
							fechaPago = cd.obtenDatos();
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket3));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(fechaPago));
							updateTablaCredito.setString(4, rfc);
							updateTablaCredito.setString(5, cliente);
							updateTablaCredito.setDouble(6, cambiaADouble(pago3));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket3) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
							// Quito de Saldo al Cliente
							PreparedStatement updateSaldoClie;
							updateSaldoClie = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo - ? ) WHERE rfc  = ? AND nombre = ?  AND activo = ?");
							updateSaldoClie.setDouble(1, cambiaADouble(pago3)); // El  monto del Ticket a prestamo
							updateSaldoClie.setString(2, rfc); // Identificador Del Cliente (rfc)
							updateSaldoClie.setString(3, cliente); // Identificador Del Cliente (nombre)
							updateSaldoClie.setInt(4, 1); // Activo
							updateSaldoClie.execute();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket3

					if(ticket4.length() > 0 && !yaPagado){ // El ticket4 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket4) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket4.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket4) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							CalculaDate cd = new CalculaDate();
							cd.parseaADate(formateaFecha(fecha));
							cd.setNuevaFecha(cambiaAInt(diasAPagarL));
							fechaPago = cd.obtenDatos();
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket4));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(fechaPago));
							updateTablaCredito.setString(4, rfc);
							updateTablaCredito.setString(5, cliente);
							updateTablaCredito.setDouble(6, cambiaADouble(pago4));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket4) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
							// Quito de Saldo al Cliente
							PreparedStatement updateSaldoClie;
							updateSaldoClie = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo - ? ) WHERE rfc  = ? AND nombre = ?  AND activo = ?");
							updateSaldoClie.setDouble(1, cambiaADouble(pago4)); // El  monto del Ticket a prestamo
							updateSaldoClie.setString(2, rfc); // Identificador Del Cliente (rfc)
							updateSaldoClie.setString(3, cliente); // Identificador Del Cliente (nombre)
							updateSaldoClie.setInt(4, 1); // Activo
							updateSaldoClie.execute();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket4

					if(ticket5.length() > 0 && !yaPagado){ // El ticket5 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket5) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket5.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket5) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							CalculaDate cd = new CalculaDate();
							cd.parseaADate(formateaFecha(fecha));
							cd.setNuevaFecha(cambiaAInt(diasAPagarL));
							fechaPago = cd.obtenDatos();
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket5));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(fechaPago));
							updateTablaCredito.setString(4, rfc);
							updateTablaCredito.setString(5, cliente);
							updateTablaCredito.setDouble(6, cambiaADouble(pago5));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket5) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
							// Quito de Saldo al Cliente
							PreparedStatement updateSaldoClie;
							updateSaldoClie = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo - ? ) WHERE rfc  = ? AND nombre = ?  AND activo = ?");
							updateSaldoClie.setDouble(1, cambiaADouble(pago5)); // El  monto del Ticket a prestamo
							updateSaldoClie.setString(2, rfc); // Identificador Del Cliente (rfc)
							updateSaldoClie.setString(3, cliente); // Identificador Del Cliente (nombre)
							updateSaldoClie.setInt(4, 1); // Activo
							updateSaldoClie.execute();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket5
				}// Else no falto producto
				con.realizaCommit();
			} // Cierro try
			catch (SQLException sqle) {
				resultado = 3;
				con.realizaRollback();
				String error = "SQLException: No se puedo realizar daTicketACredito.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch (Exception e) {
				resultado = 3;
				con.realizaRollback();
				String error = "Ocurrió una excepción mientras se ejecutaba daTicketACredito."+e;
				throw new Exception(error);
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception e){
					e.printStackTrace();
				}
			}
		}
		else{
			resultado = 3;
		}
		return resultado;
	}



// 0 --> OK,  1 --> Falta Producto,  2 --> Ya dado a credito,  3 --> ERROR
	public synchronized int daTicketACreditoVendedor(String fecha,String ticket1,String ticket2,String ticket3, String ticket4,String  ticket5, String pago1,String  pago2,String  pago3, String pago4, String pago5,String vendedor,  String vencimiento, String usuario) throws SQLException, Exception{
		this.fecha = fecha;
		this.usuario = usuario;
		int resultado = 0;
		boolean faltaProducto = false;
		boolean yaPagado = false;
		String serieTickets = "(";
		// Existe el ticket y es a pagar al contado.
		if(ticket1.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket1 +" ";
			}
		}
		if(ticket2.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket2 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket2 +" ";
			}
		}
		if(ticket3.length() > 0 ){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket3 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket3 +" ";
			}
		}
		if(ticket4.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket4 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket4 +" ";
			}
		}
		if(ticket5.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket5 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket5 +" ";
			}
		}
		serieTickets +=") ";
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				ResultSet rs = null;
				Statement stmt = null;
				String query = "SELECT SUM(Suma) AS Suma, ID_Pro FROM (SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 1 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 2 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto*productos.cantidadXCaja) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM  contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 3 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.pesoEnPz) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 4 AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta) as kiko GROUP BY ID_Pro";
				stmt =  con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					String existenciaQ = "SELECT invTienda, tipoPro FROM productos WHERE ID_Pro = "+rs.getInt("ID_Pro");
					Statement stmt2 = con.miConnection.createStatement();
					ResultSet rs2 = stmt2.executeQuery(existenciaQ);
					while (rs2.next() && !faltaProducto){
						if(rs2.getDouble("invTienda") < rs.getDouble("Suma")){
							faltaProducto = true;
						}
					} // Cierro while rs2
					rs2.close();
					stmt2.close();
				}// Cierro while rs
				rs.close();
				stmt.close();
				if(faltaProducto){
					resultado = 1;
				}
				else{
					if(ticket1.length() > 0 && !yaPagado){ // El ticket1 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket1) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket1.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket1) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket1));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(vencimiento));
							updateTablaCredito.setString(4, vendedor);
							updateTablaCredito.setString(5, "creditoInterno");
							updateTablaCredito.setDouble(6, cambiaADouble(pago1));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket1) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket1
					if(ticket2.length() > 0 && !yaPagado){ // El ticket2 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket2) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket2.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket2) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket2));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(vencimiento));
							updateTablaCredito.setString(4, vendedor);
							updateTablaCredito.setString(5, "creditoInterno");
							updateTablaCredito.setDouble(6, cambiaADouble(pago2));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket2) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket2
					if(ticket3.length() > 0 && !yaPagado){ // El ticket3 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket3) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket3.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket3) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket3));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(vencimiento));
							updateTablaCredito.setString(4, vendedor);
							updateTablaCredito.setString(5, "creditoInterno");
							updateTablaCredito.setDouble(6, cambiaADouble(pago3));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket3) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket3
					if(ticket4.length() > 0 && !yaPagado){ // El ticket4 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket4) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket4.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket4) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket4));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(vencimiento));
							updateTablaCredito.setString(4, vendedor);
							updateTablaCredito.setString(5, "creditoInterno");
							updateTablaCredito.setDouble(6, cambiaADouble(pago4));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket4) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket4
					if(ticket5.length() > 0 && !yaPagado){ // El ticket5 trae un numero y no ha encontrado algo ya pagado.
						stmt = con.creaStatement();
						rs = stmt.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(ticket5) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
						while(rs.next()){
							if(ticket5.equals(rs.getString("numticket"))) {
								resultado = 2;
								yaPagado = true;
							}
						}
						rs.close();
						stmt.close();
						if(!yaPagado){
							tiempo = new TimeStamp();
							String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(ticket5) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// CREO ENTRADA EN TABLA A CREDITO..
							PreparedStatement updateTablaCredito;
							updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateTablaCredito.setInt(1, cambiaAInt(ticket5));
							updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
							updateTablaCredito.setDate(3, cambiaADate(vencimiento));
							updateTablaCredito.setString(4, vendedor);
							updateTablaCredito.setString(5, "creditoInterno");
							updateTablaCredito.setDouble(6, cambiaADouble(pago5));
							updateTablaCredito.setInt(7, 0);
							updateTablaCredito.setInt(8,0 );
							updateTablaCredito.setString(9, "");
							updateTablaCredito.setString(10, usuario);
							updateTablaCredito.setNull(11, java.sql.Types.DATE);
							updateTablaCredito.setString(12, "");
							updateTablaCredito.setInt(13, 0);
							updateTablaCredito.setInt(14, 1);
							updateTablaCredito.execute();
							// FINALMENTE DESCUENTO DE MI INVENTARIO
							queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(ticket5) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
							stmt= con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while(rs.next()){
								int ID_Pro = rs.getInt("ID_Pro");
								int tipoVenta = rs.getInt("tipoVenta");
								double laCantidad = rs.getDouble("cantidadProducto");
								double losKgEnPz = rs.getDouble("pesoEnPz");
								if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta == 3){ // Caja
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, laCantidad); // Cantidad
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
								else if(tipoVenta ==4){ // Pieza
									PreparedStatement updateInventario;
									updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
									updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
									updateInventario.setInt(2, ID_Pro); // Identificador Producto
									updateInventario.setInt(3, 1); // Activo
									updateInventario.execute();
								}
							}
							rs.close();
							stmt.close();
						} // Verificacion no fue ya Pagado
					} // Cierro caso Ticket5
				}// Else no falto producto
				con.realizaCommit();
			} // Cierro try
			catch (SQLException sqle) {
				resultado = 3;
				con.realizaRollback();
				String error = "SQLException: No se puedo realizar daTicketACredito.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch (Exception e) {
				resultado = 3;
				con.realizaRollback();
				String error = "Ocurrió una excepción mientras se ejecutaba daTicketACredito."+e;
				throw new Exception(error);
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception e){
					e.printStackTrace();
				}
			}
		}
		else{
			resultado = 3;
		}
		return resultado;
	}


	public synchronized Vector <String> dameProductosFaltantes(String  ticket1, String ticket2,String  ticket3,String ticket4,String ticket5) throws SQLException, Exception{
		Vector <String> productoFaltante = new Vector <String>();
		String serieTickets = "(";
		// Existe el ticket y es a pagar al contado.
		if(ticket1.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket1 +" ";
			}
		}
		if(ticket2.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket2 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket2 +" ";
			}
		}
		if(ticket3.length() > 0 ){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket3 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket3 +" ";
			}
		}
		if(ticket4.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket4 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket4 +" ";
			}
		}
		if(ticket5.length() > 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket5 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket5 +" ";
			}
		}
		serieTickets +=") ";
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				ResultSet rs = null;
				String query = "SELECT SUM(Suma) AS Suma, ID_Pro FROM (SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 1 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 2 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto*productos.cantidadXCaja) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM  contenidoticket, productos WHERE "+serieTickets +"AND contenidoticket.TipoVenta = 3 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.pesoEnPz) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket WHERE "+serieTickets +" AND contenidoticket.TipoVenta = 4 AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta) as kiko GROUP BY ID_Pro";
				Statement stmt =  con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					boolean eliminacionXExistencia = false;
					String complemento = "";
					String existenciaQ = "SELECT invTienda, tipoPro FROM productos WHERE ID_Pro = "+rs.getInt("ID_Pro");
					Statement stmt2 = con.miConnection.createStatement();
					ResultSet rs2 = stmt2.executeQuery(existenciaQ);
					while (rs2.next()){
						if(rs2.getDouble("invTienda") < rs.getDouble("Suma")){
							eliminacionXExistencia = true;
							if(rs2.getInt("tipoPro") == 0){
								complemento = "<b>"+rs.getDouble("Suma")+"</b> Unidades. y solo hay <b> "+rs2.getDouble("invTienda")+"</b> Unidades. en invTienda";
							}
							else{
								complemento = "<b>"+rs.getDouble("Suma")+"</b> Kg. y solo hay <b> "+rs2.getDouble("invTienda")+"</b> Kg. en invTienda";
							}
						}
						if(eliminacionXExistencia) {
							Statement stmt3 = con.miConnection.createStatement();
							ResultSet rs3 = stmt3.executeQuery("SELECT descripcion FROM productos WHERE ID_Pro = "+rs.getInt("ID_Pro") +" AND activo = 1");
							while (rs3.next()){
								productoFaltante.addElement(rs3.getString("descripcion")+" ("+rs.getInt("ID_Pro")+	"),  solicitas "+complemento);
							}
							rs3.close();
							stmt3.close();
						}
					}
				}
				rs.close();
				stmt.close();
				con.realizaCommit();
			}
			catch (SQLException sqle){
				con.realizaRollback();
				productoFaltante = new Vector <String>();
				productoFaltante.addElement("ERROR");
				System.out.println("Error de SQL en ManagerPuntoVenta, dameProductoEliminado ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				con.realizaRollback();
				productoFaltante = new Vector <String>();
				productoFaltante.addElement("ERROR");
				System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameProductoEliminado ");
				e.printStackTrace();
			}
			finally{
				if(con != null){
					try{
						con.habilitaAutoCommit();
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameProductoEliminado ");
						q.printStackTrace();
					}
				}
			}
		}
		return productoFaltante;
	}



// Checo que no este ya registrado, cambio estatus en Ticket por Credito, Guardo en mi Tabla de // Credito, Descuento Cantidad de Productos, Aumento saldo al Cliente.

	public synchronized boolean yaMandoCredito( ) throws SQLException, Exception{
		boolean exito = true;
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				// CHECO QUE NO ESTE YA PAGADO...
				Statement st = con.creaStatement();
				ResultSet rs = st.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(numTicket) +"  AND fechaCredito='"+formateaFecha(fecha)+"' AND activo = 1");
				while(rs.next()){
					if(numTicket.equals(rs.getString("numticket"))) {
						return true;
					}
				}
				rs.close();
				st.close();
				//AHORA VOY A CAMBIAR EL ESTATUS DE MI TICKET ...
				tiempo = new TimeStamp();
				String queryString = "UPDATE contenidoticket SET estatusPago = 2   WHERE numTicket = "+cambiaAInt(numTicket) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
				Statement stmt = con.creaStatement();
				stmt.execute(queryString);
				stmt.close();
				// CREO ENTRADA EN TABLA A CREDITO..
				CalculaDate cd = new CalculaDate();
				cd.parseaADate(formateaFecha(fecha));
				cd.setNuevaFecha(diasAPagar);
				fechaPago = cd.obtenDatos();
				PreparedStatement updateTablaCredito;
				updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				updateTablaCredito.setInt(1, cambiaAInt(numTicket));
				updateTablaCredito.setDate(2, cambiaADate(formateaFecha(fecha)));
				updateTablaCredito.setDate(3, cambiaADate(fechaPago));
				updateTablaCredito.setString(4, rfc);
				updateTablaCredito.setString(5, cliente);
				updateTablaCredito.setDouble(6, cantidadAPagar);
				updateTablaCredito.setInt(7, 0);
				updateTablaCredito.setInt(8,0 );
				updateTablaCredito.setString(9, "");
				updateTablaCredito.setString(10, usuario);
				updateTablaCredito.setNull(11, java.sql.Types.DATE);
				updateTablaCredito.setString(12, "");
				updateTablaCredito.setInt(13, 0);
				updateTablaCredito.setInt(14, 1);
				updateTablaCredito.execute();
				//  DESCUENTO DE MI INVENTARIO
				queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+cambiaAInt(numTicket) +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
				stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){
					int ID_Pro = rs.getInt("ID_Pro");
					int tipoVenta = rs.getInt("tipoVenta");
					double laCantidad = rs.getDouble("cantidadProducto");
					double losKgEnPz = rs.getDouble("pesoEnPz");
					if(tipoVenta == 1 || tipoVenta == 2){ // Kg. o Unidad, descuento directo.
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ?) WHERE ID_Pro = ? AND activo = ?");
						updateInventario.setDouble(1, laCantidad); // Cantidad
						updateInventario.setInt(2, ID_Pro); // Identificador Producto
						updateInventario.setInt(3, 1); // Activo
						updateInventario.execute();
					}
					else if(tipoVenta == 3){ // Caja
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
						updateInventario.setDouble(1, laCantidad); // Cantidad
						updateInventario.setInt(2, ID_Pro); // Identificador Producto
						updateInventario.setInt(3, 1); // Activo
						updateInventario.execute();
					}
					else if(tipoVenta ==4){ // Pieza
						PreparedStatement updateInventario;
						updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
						updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
						updateInventario.setInt(2, ID_Pro); // Identificador Producto
						updateInventario.setInt(3, 1); // Activo
						updateInventario.execute();
					}
				}
				rs.close();
				stmt.close();
				// Quito de Saldo al Cliente
				PreparedStatement updateSaldoClie;
				updateSaldoClie = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo - ? ) WHERE rfc  = ? AND nombre = ?  AND activo = ?");
				updateSaldoClie.setDouble(1, cantidadAPagar); // El  monto del Ticket a prestamo
				updateSaldoClie.setString(2, rfc); // Identificador Del Cliente (rfc)
				updateSaldoClie.setString(3, cliente); // Identificador Del Cliente (nombre)
				updateSaldoClie.setInt(4, 1); // Activo
				updateSaldoClie.execute();
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				exito = false;
				con.realizaRollback();
				String error = "SQLException: No se puedo realizar yaMandoCredito.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch (Exception e) {
				exito = false;
				con.realizaRollback();
				String error = "Ocurrió una excepción mientras se ejecutaba yaMandoCredito."+e;
				throw new Exception(error);
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception e){
					e.printStackTrace();
				}
			}
		}
		else{
			exito = false;
		}
		return exito;
	}



	// Cambio el estado a aCredito del Ticket...
	public boolean datosTicketACredito() throws Exception {
		Date dFecha = cambiaADate(fecha);
		boolean fin = false;
		try  {
			String queryString = "UPDATE contenidoticket SET estatusPago = 2 WHERE numTicket = '"+numTicket +"' AND fecha = '" +dFecha +"'";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			stmt.execute(queryString);
			fin = true;
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo realizar datosTicketACredito.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrió una excepción mientras se ejecutaba datosTicketACredito."+e;
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


	public boolean CambiaActivoCredito() throws SQLException, Exception {
		boolean bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try  {
				String queryString = 	"UPDATE creditos SET activo = 0 WHERE numTicket = '"+completaString(numTicket) +"' AND fechaCredito = '" +cambiaADate(fecha) +"'";
				Statement stmt = con.creaStatement();
				stmt.execute(queryString);
				bandera = true;
			}
			catch (SQLException sqle) {
				String error = "SQLException: No se puedo realizar CambiaActivoCredito.";
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
					System.out.println(	"Error al cerrar conexion de mcredito metodo CambiaActivoCredito");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}


// ME REGRESA LA CANTIDAD A PAGAR DE UN TICKET!
	public ResultSet obtenCantidadACredito(){
		ResultSet rs = null;
		try  {
			String queryString = ("SELECT DISTINCT rfc, nombreCliente, cantidadAPagar from creditos WHERE numTicket = '"+numTicket +"' AND fechaCredito = '" +fecha +"' AND activo = 0" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta obtenVentasTicket.";
			sqle.printStackTrace();
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de obtenVentasTicket."+e;
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return rs;
	}





// Funciones Genericas de Transformacion:

	private double calculaPrecio(double precioVenta, double pesoOcant) throws Exception{
		double resultado ;
		return resultado = precioVenta * pesoOcant;
	}

	private String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}

	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
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

	public String parseaFecha(String fecha) throws Exception{
		String fechaIncrementada;
		Calendar tiempoPirata;
		tiempoPirata = Calendar.getInstance();
		tiempoPirata.clear();
		String anio = fecha.substring(0,4);
		String mes = fecha.substring(5,7);
		String dia = fecha.substring(8,fecha.length());
		tiempoPirata.set(Integer.parseInt(anio),(Integer.parseInt(mes)-1),Integer.parseInt(dia));
		tiempoPirata.add(Calendar.DATE, Integer.parseInt(incrementoDias));
		int diaSemana = tiempoPirata.get(Calendar.DAY_OF_WEEK);
		if(diaSemana == 1){
			tiempoPirata.add(Calendar.DATE, 1);
		}
		else if (diaSemana == 7){
			tiempoPirata.add(Calendar.DATE, 2);
		}
		String time;
		StringBuffer cadena = new StringBuffer();
		anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
		int mesI = tiempoPirata.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mesI+""));
		int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(diaI+""));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		return cadena.toString();
	}

// Mando una Fecha al próximo sabado.
	public String parseaFechaASabado(String fecha) throws Exception{
		Calendar tiempoPirata;
		tiempoPirata = Calendar.getInstance();
		tiempoPirata.clear();
		String anio = fecha.substring(6,10);
		String mes = fecha.substring(0,2);
		String dia = fecha.substring(3,5);
		tiempoPirata.set(Integer.parseInt(anio),(Integer.parseInt(mes)-1),Integer.parseInt(dia));
		int diaSemana = tiempoPirata.get(Calendar.DAY_OF_WEEK);
		if(diaSemana == 1){ // Es Domingo
			tiempoPirata.add(Calendar.DATE,6);
		}
		else if(diaSemana == 7){ // Sabado
			tiempoPirata.add(Calendar.DATE,7);
		}
		else if(diaSemana == 2){ // Lunes
			tiempoPirata.add(Calendar.DATE,5);
		}
		else if(diaSemana == 3){ // Martes
			tiempoPirata.add(Calendar.DATE,4);
		}
		else if(diaSemana == 4){ // Miercoles
			tiempoPirata.add(Calendar.DATE,3);
		}
		else if(diaSemana == 5){ // Jueves
			tiempoPirata.add(Calendar.DATE,2);
		}
		else if(diaSemana == 6){ // Viernes
			tiempoPirata.add(Calendar.DATE,1);
		}
		StringBuilder cadena = new StringBuilder();
		anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
		int mesI = tiempoPirata.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mesI+""));
		int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(diaI+""));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		return cadena.toString();
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
			else if(decimales.length() == 2){
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

	public String formateaFecha(String fecha){
		return fecha.substring(6,10)+"-"+fecha.substring(0,2)+"-"+fecha.substring(3,5);
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
