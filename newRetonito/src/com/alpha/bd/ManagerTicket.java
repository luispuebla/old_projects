package com.alpha.bd;

import java.sql.SQLException;
import java.sql.Date;
import java.sql.Time;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Vector;
import com.alpha.bd.TimeStamp;
import java.math.BigDecimal;
import java.math.RoundingMode;
import com.alpha.bd.DateStamp;


public class ManagerTicket {

	private ConexionBD con = null;
	protected TimeStamp tiempo = null;
	protected DateStamp ds = null;

  	public ManagerTicket()   { }

// CLASES NUEVAS:

	public String dameFechaHoy() throws Exception{
		tiempo = new TimeStamp();
		return  tiempo.date2;
	}

	public String formateaFecha(String fecha){
		return fecha.substring(6,10)+"-"+fecha.substring(0,2)+"-"+fecha.substring(3,5);
	}


	public String dameUtilidad(String fecha) throws SQLException, Exception{
		String utilidad = "0.00";
		con = new ConexionBD();
		if(con != null){
			try{
				BigDecimal sumaUtilidad = new BigDecimal("0.00");
				String query = "SELECT SUM(contenidoticket.cantidadProducto)AS Total, contenidoticket.tipoPrecio, contenidoticket.tipoVenta, contenidoticket.precioVenta, productos.precioUniCompra, productos.preCaCompra, productos.precioUnidadKG, productos.kgXUnidad, productos.tipoPro FROM contenidoticket, productos WHERE contenidoticket.fechaRealPago LIKE '"+fecha+"' AND contenidoticket.estatusPago != 0 AND contenidoticket.estatusTicket = 1 AND productos.ID_Pro=contenidoticket.ID_Pro GROUP BY  contenidoticket.ID_Pro,contenidoticket.precioVenta ORDER BY contenidoticket.tipoVenta,contenidoticket.tipoPrecio";
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while(rs.next()){
					double diferencia = 0.00;
					if(rs.getInt("tipoVenta") == 1){ // HAblamos de Kilogramos.
						diferencia = (rs.getDouble("Total")*rs.getDouble("precioVenta")) - (rs.getDouble("Total")*rs.getDouble("precioUnidadKG"));
					}
					else if(rs.getInt("tipoVenta") == 2){ // HAblamos de Unidades
						diferencia = (rs.getDouble("Total")*rs.getDouble("precioVenta")) - (rs.getDouble("Total")*rs.getDouble("precioUniCompra"));
					}
					else if(rs.getInt("tipoVenta") == 3){ // HAblamos de Cajas.
						diferencia = (rs.getDouble("Total")*rs.getDouble("precioVenta")) - (rs.getDouble("Total")*rs.getDouble("preCaCompra"));
					}
					else if(rs.getInt("tipoVenta") == 4){ // HAblamos de Piezas
						diferencia = (rs.getDouble("Total")*rs.getDouble("precioVenta")) - (rs.getDouble("Total")*(rs.getDouble("precioUnidadKG")*rs.getDouble("kgXUnidad")));
					}
					sumaUtilidad = sumaUtilidad.add(new BigDecimal(diferencia+""));
				}
				sumaUtilidad = sumaUtilidad.setScale(2, RoundingMode.HALF_UP);
				utilidad = sumaUtilidad.toString();
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerFacturacion metodo dameUtilidad");
					q.printStackTrace();
				}
			}
		}
		return formatoDinero(utilidad);
	}

	public boolean existeElTicket(String numticket) throws SQLException, Exception   {
		Statement st = null;
		ResultSet rs= null;
		boolean bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT numTicket FROM contenidoticket WHERE numTicket = " +cambiaAInt(numticket) +" LIMIT 1 ";
				rs = st.executeQuery(query);
				while(rs.next()){
					if(numticket.equals(rs.getString("numTicket"))) {
						bandera = true;
					}
				}
				rs.close();
				st.close();
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de  existeElTicket en ManagerTicket");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}



	public ResultSet dameClientesConCreditosPendientes() throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT creditos.rfc, creditos.nombreCliente, SUM(creditos.cantidadAPagar)AS MontoACredito, ACuenta FROM creditos LEFT JOIN (SELECT SUM(abono_general.montoDisponible)AS ACuenta, abono_general.rfc, abono_general.nombreCliente FROM abono_general GROUP BY abono_general.rfc,abono_general.nombreCliente) AS tempTB ON (tempTB.rfc = creditos.rfc AND tempTB.nombreCliente = creditos.nombreCliente) WHERE creditos.activo = 1 AND creditos.estatusCredito != 2 AND  creditos.nombreCliente != 'creditoInterno' GROUP BY creditos.rfc,creditos.nombreCliente ORDER BY creditos.rfc,creditos.nombreCliente";
				rs = st.executeQuery(query);
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return rs;
	}


	public ResultSet dameDatosDeClienteParaAbono(String rfc, String nombreCliente) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT SUM(creditos.cantidadAPagar)AS MontoACredito, ACuenta FROM creditos LEFT JOIN (SELECT SUM(abono_general.montoDisponible)AS ACuenta, abono_general.rfc, abono_general.nombreCliente FROM abono_general GROUP BY abono_general.rfc,abono_general.nombreCliente) AS tempTB ON (tempTB.rfc = creditos.rfc AND tempTB.nombreCliente = creditos.nombreCliente) WHERE creditos.activo = 1 AND creditos.rfc = '"+rfc+"' AND creditos.nombreCliente = '"+nombreCliente+"' AND creditos.estatusCredito != 2 GROUP BY creditos.rfc,creditos.nombreCliente ORDER BY creditos.rfc,creditos.nombreCliente LIMIT 1";
				rs = st.executeQuery(query);
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return rs;
	}

	public ResultSet dameDatosDesglosadoXTicket(String rfc, String nombreCliente) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT creditos.numTicket, creditos.cantidadAPagar FROM creditos WHERE creditos.activo = 1 AND creditos.rfc = '"+rfc+"' AND creditos.nombreCliente = '"+nombreCliente+"' AND creditos.estatusCredito != 2  ORDER BY creditos.rfc,creditos.nombreCliente";
				rs = st.executeQuery(query);
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return rs;
	}


	public ResultSet dameClientesConAbonos() throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT DISTINCT rfc,nombreCliente FROM abonos WHERE estatus = 1 GROUP BY rfc,nombreCliente ORDER BY nombreCliente";
				rs = st.executeQuery(query);
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return rs;
	}

	public ResultSet dameDatoAbonos(String rfc, String nombreCliente, String fechaInicio, String fechaFin) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT rfc, nombreCliente,fecha, monto, formatoPago, referenciaCobro, cobro FROM abonos WHERE rfc LIKE '"+rfc+"' AND nombreCliente LIKE '"+nombreCliente+"' AND fecha BETWEEN '"+fechaInicio+"' AND '"+fechaFin+"'";
				rs = st.executeQuery(query);
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return rs;
	}


	public ResultSet dameDatosTicket(String numTicket) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT contenidoticket.*, productos.descripcion, vendedores.NombreE  FROM contenidoticket, productos, vendedores WHERE contenidoticket.numTicket = " +cambiaAInt(numTicket) +" AND productos.ID_Pro = contenidoticket.ID_Pro AND vendedores.claveVenta = contenidoticket.claveVendedor ";
				rs = st.executeQuery(query);
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return rs;
	}

/**
* El método existe verifica que el Ticket solicitado existe dentro de nuestra Base de Datos.
*  @param 	numticket	String con el número de Ticket solicitado.
*  @param 	fecha	String con la Fecha del Ticket.
*	@return bandera 	int  , 1 --> Existe, 0 --> No se encuentra
*/

	public int  existe(String numticket, String fecha) throws SQLException, Exception   {
		Statement st = null;
		ResultSet rs= null;
		int  bandera = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT numTicket FROM contenidoticket WHERE numTicket = " +cambiaAInt(numticket) +" AND fechaRegistro = '" +formateaFecha(fecha)+"' AND estatusTicket = 1 ";
				rs = st.executeQuery(query);
				while(rs.next()){
					if(numticket.equals(rs.getString("numTicket"))) {
						bandera = 1;//realiza comparación con la base de datos
					}
				}
				rs.close();
				st.close();
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
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


// Para obtener el total del ticket
	public double datosTicketVenta(String numTicket, String fecha) throws SQLException, Exception {
		double totalTicket = 0.00;
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = ("SELECT SUM(precioAPagar)AS precioAPagar  FROM contenidoticket WHERE numTicket = "+cambiaAInt(numTicket)+" AND fechaRegistro = '" +formateaFecha(fecha) +"' AND (estatusPago = 0 OR estatusPago = 2)" );
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){
					totalTicket = rs.getDouble("precioAPagar");
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				String error = "SQLException: No se puedo ejecutar la consulta datosTicketVenta.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch (Exception e) {
				String error = "Ocurrio una excepcion mientras se extraian los datos de datosTicketVenta.";
				e.printStackTrace();
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
		}
		return totalTicket;
	}

// DESCRIMINA TICKET
	public int dameTipoTicket(String numTicket, String fecha) throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		int  tipo = -1;
		con = new ConexionBD();
		if (con !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT estatusPago FROM contenidoticket WHERE numTicket = " +cambiaAInt(numTicket) +" AND FechaRegistro ='"+formateaFecha(fecha)+"'");
				while(rs.next()){
					tipo = rs.getInt("estatusPago");
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
					System.out.println("Error al cerrar conexion de mticket metodo dameTipoTicket");
					q.printStackTrace();
				}
			}
		}
		return tipo;
	}

// PARA VER SI YA ESTABA PAGADO EL CREDITO: (PAGO DE CREDITO)
// 0 --> aun no paga el crédito
// 1 --> ya estaba pagado el crédito

	public int yaEstabaPagadoCredito(String numticket, String fecha) throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 1;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT numticket FROM creditos WHERE numTicket = " +cambiaAInt(numticket) +" AND fechaCredito ='"+formateaFecha(fecha)+"' AND estatusCredito!=2 AND activo = 1");
				while(rs.next()){
					if(numticket.equals(rs.getString("numticket"))) {
						bandera = 0;//realiza comparación con la base de datos
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
					System.out.println("Error al cerrar conexion de Cobrador metodo yaEstabaPagadoCredito");
					q.printStackTrace();
				}
			}
		}
	return bandera;
	}

/**
* El método yaEstabaPagado sirve para verificar que no se cobre dos veces por error del Usuario
*  	@param 	numticket0	String con el número de Ticket solicitado.
*  	@param 	fecha	Date con la fecha correspondiente al ticket.
*	@return bandera 	Int si es igual 0 el Ticket no exite y si es igual a 1 el Ticket se encuentra en la Base de Datos.
*/

	public int yaEstabaPagado(String numticket, String fecha) throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT numticket FROM salidas WHERE numTicket = " +cambiaAInt(numticket) +"  AND fechaVenta ='"+formateaFecha(fecha)+"' AND activo = 1");
				while(rs.next()){
					if(numticket.equals(rs.getString("numticket"))) {
						bandera = 1;//realiza comparación con la base de datos
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
					System.out.println("Error al cerrar conexion de mticket metodo yaEstabaPagado");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}


	public synchronized Vector <String> dameProductosFaltantes(String  ticket1, String ticket2,String  ticket3,String ticket4,String ticket5, String tipot1,String tipot2,String tipot3,String tipot4,String tipot5) throws SQLException, Exception{
		Vector <String> productoFaltante = new Vector <String>();
		String serieTickets = "(";
		// Existe el ticket y es a pagar al contado.
		if(ticket1.length() > 0 && cambiaAInt(tipot1) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket1 +" ";
			}
		}
		if(ticket2.length() > 0 && cambiaAInt(tipot2) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket2 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket2 +" ";
			}
		}
		if(ticket3.length() > 0 && cambiaAInt(tipot3) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket3 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket3 +" ";
			}
		}
		if(ticket4.length() > 0 && cambiaAInt(tipot4) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket4 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket4 +" ";
			}
		}
		if(ticket5.length() > 0 && cambiaAInt(tipot5) == 0){
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




	// Cierro tickets...
	// 0 --> OK,  1 --> Falta Producto,  2 --> Ya dado a credito,  3 --> ERROR
	public synchronized int finalizaTicketVenta(String fecha, String  ticket1, String ticket2,String  ticket3,String ticket4,String ticket5,String pago1,String pago2,String pago3,String pago4,String pago5,String tipot1,String tipot2,String tipot3,String tipot4,String tipot5,String formaPago,String referenciaC,String usuario) throws SQLException, Exception{
		int resultado = 0;
		boolean faltaProducto = false;
		boolean yaPagado = false;
		String serieTickets = "(";
		// Existe el ticket y es a pagar al contado.
		if(ticket1.length() > 0 && cambiaAInt(tipot1) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket1 +" ";
			}
		}
		if(ticket2.length() > 0 && cambiaAInt(tipot2) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket2 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket2 +" ";
			}
		}
		if(ticket3.length() > 0 && cambiaAInt(tipot3) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket3 +" ";
			}
			else{
				serieTickets += " OR contenidoTicket.numTicket = " + ticket3 +" ";
			}
		}
		if(ticket4.length() > 0 && cambiaAInt(tipot4) == 0){
			if (serieTickets.trim().length() == 1){
				serieTickets += " contenidoTicket.numTicket = " + ticket4 +" ";
			}
			else{
				serieTickets += " OR  contenidoTicket.numTicket = " + ticket4 +" ";
			}
		}
		if(ticket5.length() > 0 && cambiaAInt(tipot5) == 0){
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
				if(serieTickets.length() > 4){
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
				}
				if(faltaProducto){
					resultado = 1;
				}
				else{
					if(ticket1.length() > 0 && !yaPagado){ // El icket1 trae un numero y no ha encontrado algo ya pagado.
						if (cambiaAInt(tipot1) == 0){ // Es pago Directo
							stmt = con.creaStatement();
							rs = stmt.executeQuery("SELECT numticket FROM salidas WHERE numTicket = " +cambiaAInt(ticket1) +"  AND fechaVenta='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
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
								String fechaHoy = tiempo.date;
								String horaHoy = tiempo.time;
								String queryString = "UPDATE contenidoticket SET estatusPago = 1, fechaRealPago = '"+fechaHoy +"'  WHERE numTicket = "+cambiaAInt(ticket1) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
								stmt= con.creaStatement();
								stmt.execute(queryString);
								stmt.close();
								// GUARDO EL REGISTRO EN MI TABLA DE SALIDAS YA QUE ES AL CONTADO...
								PreparedStatement updateTablaSalida;
								updateTablaSalida = con.miConnection.prepareStatement("INSERT INTO salidas VALUES(?,?,?,?,?,?,?,?,?);");
								updateTablaSalida.setInt(1, cambiaAInt(ticket1));
								updateTablaSalida.setDate(2, cambiaADate(fechaHoy));
								updateTablaSalida.setString(3, horaHoy);
								updateTablaSalida.setDouble(4, cambiaADouble(pago1));
								updateTablaSalida.setInt(5, 0);
								updateTablaSalida.setInt(6, cambiaAInt(formaPago));
								updateTablaSalida.setString(7, referenciaC);
								updateTablaSalida.setString(8, usuario);
								updateTablaSalida.setInt(9, 1);
								updateTablaSalida.execute();
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
						}// Cierre ticket pago Directo
						else{ // Fue pago de un credito
							String rfc = "";
							String nombre = "";
							double cantidad = 0;
							tiempo = new TimeStamp();
							String fechaHoy = tiempo.date;
							String horaHoy = tiempo.time;
							String queryString = 	"UPDATE contenidoTicket SET fechaRealPago = '"+tiempo.date +"'  WHERE numTicket = "+cambiaAInt(ticket1) +" AND fechaRegistro = '"+formateaFecha(fecha) +"'";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// ACTUALIZO AHORA MI TABLA DE CREDITOS
							queryString = "UPDATE creditos SET fechaRealPago ='"+tiempo.date +"', usuarioPago = '"+usuario+"', estatusCredito = 2,  tipoCobro = "+cambiaAInt(formaPago) +", referenciaCobro = '"+referenciaC +"' WHERE numTicket = "+cambiaAInt(ticket1) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// FINALMENTE REGRESO CREDITO AL CLIENTE
							queryString = (
							"SELECT rfc, nombreCliente, cantidadAPagar from creditos WHERE numTicket = "+cambiaAInt(ticket1) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1" );
							stmt = con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while (rs.next()){
								rfc = rs.getString("rfc");
								nombre = rs.getString("nombreCliente");
								cantidad = rs.getDouble("cantidadAPagar");
							}
							rs.close();
							stmt.close();
							queryString = "UPDATE clientes SET saldo = saldo+"+cantidad+" WHERE rfc = '"+rfc +"' AND nombre = '" +nombre +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
						}
					}// Cierre ticket1
					if(ticket2.length() > 0 && !yaPagado){ // El icket1 trae un numero y no ha encontrado algo ya pagado.
						if (cambiaAInt(tipot2) == 0){ // Es pago Directo
							stmt = con.creaStatement();
							rs = stmt.executeQuery("SELECT numticket FROM salidas WHERE numTicket = " +cambiaAInt(ticket2) +"  AND fechaVenta='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
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
								String fechaHoy = tiempo.date;
								String horaHoy = tiempo.time;
								String queryString = "UPDATE contenidoticket SET estatusPago = 1, fechaRealPago = '"+fechaHoy +"'  WHERE numTicket = "+cambiaAInt(ticket2) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
								stmt= con.creaStatement();
								stmt.execute(queryString);
								stmt.close();
								// GUARDO EL REGISTRO EN MI TABLA DE SALIDAS YA QUE ES AL CONTADO...
								PreparedStatement updateTablaSalida;
								updateTablaSalida = con.miConnection.prepareStatement("INSERT INTO salidas VALUES(?,?,?,?,?,?,?,?,?);");
								updateTablaSalida.setInt(1, cambiaAInt(ticket2));
								updateTablaSalida.setDate(2, cambiaADate(fechaHoy));
								updateTablaSalida.setString(3, horaHoy);
								updateTablaSalida.setDouble(4, cambiaADouble(pago2));
								updateTablaSalida.setInt(5, 0);
								updateTablaSalida.setInt(6, cambiaAInt(formaPago));
								updateTablaSalida.setString(7, referenciaC);
								updateTablaSalida.setString(8, usuario);
								updateTablaSalida.setInt(9, 1);
								updateTablaSalida.execute();
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
						}// Cierre ticket pago Directo
						else{ // Fue pago de un credito
							String rfc = "";
							String nombre = "";
							double cantidad = 0;
							tiempo = new TimeStamp();
							String fechaHoy = tiempo.date;
							String horaHoy = tiempo.time;
							String queryString = 	"UPDATE contenidoTicket SET fechaRealPago = '"+tiempo.date +"'  WHERE numTicket = "+cambiaAInt(ticket2) +" AND fechaRegistro = '"+formateaFecha(fecha) +"'";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// ACTUALIZO AHORA MI TABLA DE CREDITOS
							queryString = "UPDATE creditos SET fechaRealPago ='"+tiempo.date +"', usuarioPago = '"+usuario+"', estatusCredito = 2,  tipoCobro = "+cambiaAInt(formaPago) +", referenciaCobro = '"+referenciaC +"' WHERE numTicket = "+cambiaAInt(ticket2) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// FINALMENTE REGRESO CREDITO AL CLIENTE
							queryString = (
							"SELECT rfc, nombreCliente, cantidadAPagar from creditos WHERE numTicket = "+cambiaAInt(ticket2) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1" );
							stmt = con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while (rs.next()){
								rfc = rs.getString("rfc");
								nombre = rs.getString("nombreCliente");
								cantidad = rs.getDouble("cantidadAPagar");
							}
							rs.close();
							stmt.close();
							queryString = "UPDATE clientes SET saldo = saldo+"+cantidad+" WHERE rfc = '"+rfc +"' AND nombre = '" +nombre +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
						}
					}// Cierre ticket2
					if(ticket3.length() > 0 && !yaPagado){ // El icket1 trae un numero y no ha encontrado algo ya pagado.
						if (cambiaAInt(tipot3) == 0){ // Es pago Directo
							stmt = con.creaStatement();
							rs = stmt.executeQuery("SELECT numticket FROM salidas WHERE numTicket = " +cambiaAInt(ticket3) +"  AND fechaVenta='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
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
								String fechaHoy = tiempo.date;
								String horaHoy = tiempo.time;
								String queryString = "UPDATE contenidoticket SET estatusPago = 1, fechaRealPago = '"+fechaHoy +"'  WHERE numTicket = "+cambiaAInt(ticket3) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
								stmt= con.creaStatement();
								stmt.execute(queryString);
								stmt.close();
								// GUARDO EL REGISTRO EN MI TABLA DE SALIDAS YA QUE ES AL CONTADO...
								PreparedStatement updateTablaSalida;
								updateTablaSalida = con.miConnection.prepareStatement("INSERT INTO salidas VALUES(?,?,?,?,?,?,?,?,?);");
								updateTablaSalida.setInt(1, cambiaAInt(ticket3));
								updateTablaSalida.setDate(2, cambiaADate(fechaHoy));
								updateTablaSalida.setString(3, horaHoy);
								updateTablaSalida.setDouble(4, cambiaADouble(pago3));
								updateTablaSalida.setInt(5, 0);
								updateTablaSalida.setInt(6, cambiaAInt(formaPago));
								updateTablaSalida.setString(7, referenciaC);
								updateTablaSalida.setString(8, usuario);
								updateTablaSalida.setInt(9, 1);
								updateTablaSalida.execute();
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
						}// Cierre ticket pago Directo
						else{ // Fue pago de un credito
							String rfc = "";
							String nombre = "";
							double cantidad = 0;
							tiempo = new TimeStamp();
							String fechaHoy = tiempo.date;
							String horaHoy = tiempo.time;
							String queryString = 	"UPDATE contenidoTicket SET fechaRealPago = '"+tiempo.date +"'  WHERE numTicket = "+cambiaAInt(ticket3) +" AND fechaRegistro = '"+formateaFecha(fecha) +"'";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// ACTUALIZO AHORA MI TABLA DE CREDITOS
							queryString = "UPDATE creditos SET fechaRealPago ='"+tiempo.date +"', usuarioPago = '"+usuario+"', estatusCredito = 2,  tipoCobro = "+cambiaAInt(formaPago) +", referenciaCobro = '"+referenciaC +"' WHERE numTicket = "+cambiaAInt(ticket3) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// FINALMENTE REGRESO CREDITO AL CLIENTE
							queryString = (
							"SELECT rfc, nombreCliente, cantidadAPagar from creditos WHERE numTicket = "+cambiaAInt(ticket3) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1" );
							stmt = con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while (rs.next()){
								rfc = rs.getString("rfc");
								nombre = rs.getString("nombreCliente");
								cantidad = rs.getDouble("cantidadAPagar");
							}
							rs.close();
							stmt.close();
							queryString = "UPDATE clientes SET saldo = saldo+"+cantidad+" WHERE rfc = '"+rfc +"' AND nombre = '" +nombre +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
						}
					}// Cierre ticket3
					if(ticket4.length() > 0 && !yaPagado){ // El icket1 trae un numero y no ha encontrado algo ya pagado.
						if (cambiaAInt(tipot4) == 0){ // Es pago Directo
							stmt = con.creaStatement();
							rs = stmt.executeQuery("SELECT numticket FROM salidas WHERE numTicket = " +cambiaAInt(ticket4) +"  AND fechaVenta='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
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
								String fechaHoy = tiempo.date;
								String horaHoy = tiempo.time;
								String queryString = "UPDATE contenidoticket SET estatusPago = 1, fechaRealPago = '"+fechaHoy +"'  WHERE numTicket = "+cambiaAInt(ticket4) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
								stmt= con.creaStatement();
								stmt.execute(queryString);
								stmt.close();
								// GUARDO EL REGISTRO EN MI TABLA DE SALIDAS YA QUE ES AL CONTADO...
								PreparedStatement updateTablaSalida;
								updateTablaSalida = con.miConnection.prepareStatement("INSERT INTO salidas VALUES(?,?,?,?,?,?,?,?,?);");
								updateTablaSalida.setInt(1, cambiaAInt(ticket4));
								updateTablaSalida.setDate(2, cambiaADate(fechaHoy));
								updateTablaSalida.setString(3, horaHoy);
								updateTablaSalida.setDouble(4, cambiaADouble(pago4));
								updateTablaSalida.setInt(5, 0);
								updateTablaSalida.setInt(6, cambiaAInt(formaPago));
								updateTablaSalida.setString(7, referenciaC);
								updateTablaSalida.setString(8, usuario);
								updateTablaSalida.setInt(9, 1);
								updateTablaSalida.execute();
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
						}// Cierre ticket pago Directo
						else{ // Fue pago de un credito
							String rfc = "";
							String nombre = "";
							double cantidad = 0;
							tiempo = new TimeStamp();
							String fechaHoy = tiempo.date;
							String horaHoy = tiempo.time;
							String queryString = 	"UPDATE contenidoTicket SET fechaRealPago = '"+tiempo.date +"'  WHERE numTicket = "+cambiaAInt(ticket4) +" AND fechaRegistro = '"+formateaFecha(fecha) +"'";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// ACTUALIZO AHORA MI TABLA DE CREDITOS
							queryString = "UPDATE creditos SET fechaRealPago ='"+tiempo.date +"', usuarioPago = '"+usuario+"', estatusCredito = 2,  tipoCobro = "+cambiaAInt(formaPago) +", referenciaCobro = '"+referenciaC +"' WHERE numTicket = "+cambiaAInt(ticket4) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// FINALMENTE REGRESO CREDITO AL CLIENTE
							queryString = (
							"SELECT rfc, nombreCliente, cantidadAPagar from creditos WHERE numTicket = "+cambiaAInt(ticket4) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1" );
							stmt = con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while (rs.next()){
								rfc = rs.getString("rfc");
								nombre = rs.getString("nombreCliente");
								cantidad = rs.getDouble("cantidadAPagar");
							}
							rs.close();
							stmt.close();
							queryString = "UPDATE clientes SET saldo = saldo+"+cantidad+" WHERE rfc = '"+rfc +"' AND nombre = '" +nombre +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
						}
					}// Cierre ticket4
					if(ticket5.length() > 0 && !yaPagado){ // El icket1 trae un numero y no ha encontrado algo ya pagado.
						if (cambiaAInt(tipot5) == 0){ // Es pago Directo
							stmt = con.creaStatement();
							rs = stmt.executeQuery("SELECT numticket FROM salidas WHERE numTicket = " +cambiaAInt(ticket5) +"  AND fechaVenta='"+formateaFecha(fecha)+"' AND activo = 1 LIMIT 1");
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
								String fechaHoy = tiempo.date;
								String horaHoy = tiempo.time;
								String queryString = "UPDATE contenidoticket SET estatusPago = 1, fechaRealPago = '"+fechaHoy +"'  WHERE numTicket = "+cambiaAInt(ticket5) +"  AND fechaRegistro= '" +formateaFecha(fecha) +"' AND estatusTicket = 1";
								stmt= con.creaStatement();
								stmt.execute(queryString);
								stmt.close();
								// GUARDO EL REGISTRO EN MI TABLA DE SALIDAS YA QUE ES AL CONTADO...
								PreparedStatement updateTablaSalida;
								updateTablaSalida = con.miConnection.prepareStatement("INSERT INTO salidas VALUES(?,?,?,?,?,?,?,?,?);");
								updateTablaSalida.setInt(1, cambiaAInt(ticket5));
								updateTablaSalida.setDate(2, cambiaADate(fechaHoy));
								updateTablaSalida.setString(3, horaHoy);
								updateTablaSalida.setDouble(4, cambiaADouble(pago5));
								updateTablaSalida.setInt(5, 0);
								updateTablaSalida.setInt(6, cambiaAInt(formaPago));
								updateTablaSalida.setString(7, referenciaC);
								updateTablaSalida.setString(8, usuario);
								updateTablaSalida.setInt(9, 1);
								updateTablaSalida.execute();
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
						}// Cierre ticket pago Directo
						else{ // Fue pago de un credito
							String rfc = "";
							String nombre = "";
							double cantidad = 0;
							tiempo = new TimeStamp();
							String fechaHoy = tiempo.date;
							String horaHoy = tiempo.time;
							String queryString = 	"UPDATE contenidoTicket SET fechaRealPago = '"+tiempo.date +"'  WHERE numTicket = "+cambiaAInt(ticket5) +" AND fechaRegistro = '"+formateaFecha(fecha) +"'";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// ACTUALIZO AHORA MI TABLA DE CREDITOS
							queryString = "UPDATE creditos SET fechaRealPago ='"+tiempo.date +"', usuarioPago = '"+usuario+"', estatusCredito = 2,  tipoCobro = "+cambiaAInt(formaPago) +", referenciaCobro = '"+referenciaC +"' WHERE numTicket = "+cambiaAInt(ticket5) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
							stmt.close();
							// FINALMENTE REGRESO CREDITO AL CLIENTE
							queryString = (
							"SELECT rfc, nombreCliente, cantidadAPagar from creditos WHERE numTicket = "+cambiaAInt(ticket5) +" AND fechaCredito = '" +formateaFecha(fecha) +"' AND activo = 1" );
							stmt = con.creaStatement();
							rs = stmt.executeQuery(queryString);
							while (rs.next()){
								rfc = rs.getString("rfc");
								nombre = rs.getString("nombreCliente");
								cantidad = rs.getDouble("cantidadAPagar");
							}
							rs.close();
							stmt.close();
							queryString = "UPDATE clientes SET saldo = saldo+"+cantidad+" WHERE rfc = '"+rfc +"' AND nombre = '" +nombre +"' AND activo = 1";
							stmt = con.creaStatement();
							stmt.execute(queryString);
						}
					}// Cierre ticket5
				}// Else no falto producto
				con.realizaCommit();
			} // Cierro try
			catch (SQLException sqle) {
				resultado = 3;
				con.realizaRollback();
				String error = "SQLException: No se puedo realizar finalizaTicketVenta.";
				sqle.printStackTrace();
				throw new SQLException(error);
			}
			catch (Exception e) {
				resultado = 3;
				con.realizaRollback();
				String error = "Ocurrió una excepción mientras se ejecutaba finalizaTicketVenta."+e;
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


// PARA VER SI YA ESTABA DADO A CREDITO: (DADO UN CREDITO)
// 0 no estaba aun registrado, 1 ya estaba registrado

	public int yaEstabaACredito(String numticket, String fecha) throws SQLException, Exception {
		  Statement st = null;
		  ResultSet rs= null;
		  int bandera = 0;
			con = new ConexionBD();
		  if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT numticket FROM creditos WHERE numTicket = '" +cambiaAInt(numticket) +"' AND fechaCredito ='"+formateaFecha(fecha)+"' AND activo = 1");
				while(rs.next()){
					if(numticket.equals(rs.getString("numticket"))) {
						bandera = 1;//realiza comparación con la base de datos
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
					System.out.println("Error al cerrar conexion de ManagerTicket metodo existe");
					q.printStackTrace();
				}
			}
		 }
		return bandera;
	}

// EXISTE PARA CANCELAR:
// -1 --> No existe...
// 0 --> No esta pagado.
// 1 --> Fue pagado al Contado.
// 2 --> Fue pagado a Crédito.
	public int existeCancela(String numticket) throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		int bandera = -1;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				String query = "SELECT estatusPago FROM contenidoticket WHERE numTicket = " +cambiaAInt(numticket) +" AND estatusTicket = 1";
				rs = st.executeQuery(query);
				while(rs.next()){
					bandera = rs.getInt("estatusPago");
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
					System.out.println("Error al cerrar conexion de ManagerTicket metodo existeCancela");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}

public String dameUsuarioQueCobro(String numTicket){
	String elUsuario = "";
	Statement st = null;
	ResultSet rs = null;
	try{
		con = new ConexionBD();
		st = con.creaStatement();
		String queryString = ("(SELECT salidas.usuario FROM salidas WHERE salidas.numTicket = " +cambiaAInt(numTicket) +" AND salidas.activo = 1) UNION (SELECT DISTINCT (creditos.usuarioPago) AS usuario FROM creditos WHERE creditos.numTicket = " +cambiaAInt(numTicket) +" AND creditos.activo = 1 )");
		rs = st.executeQuery(queryString);
		while (rs.next()){
			elUsuario = rs.getString("usuario");
		}
	}
	catch (SQLException sqle) {
		System.out.println("Error SQL dentro de ManagerTicket metodo dameUsuarioQueCobro");
		sqle.printStackTrace();
	}
	catch (Exception e){
		System.out.println("Error! Excepcion dentro de ManagerTicket metodo dameUsuarioQueCobro");
		e.printStackTrace();
	}
	finally{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerTicket metodo dameUsuarioQueCobro");
				q.printStackTrace();
			}
		}
	}
	return elUsuario;
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
				// Ahora como es de contado elimino de forma logica la entrada en mi tabla de salidas, pero antes averiguo si ya esta facturado el Ticket para también cancelar la Factura, tambien averiguo el total de la venta para almacenarlo en mi tabla de cancelacion
				boolean existeFactura = false;
				queryString = "SELECT factura, sumaVenta FROM salidas WHERE numTicket = "+cambiaAInt(numTicket) +" AND activo = 1 ";
				stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){
					if(rs.getInt("factura") == 1){
						existeFactura = true;
					}
					totalTicket = rs.getDouble("sumaVenta");
				}
				rs.close();
				stmt.close();
				queryString="UPDATE salidas SET activo = 0 WHERE numTicket = "+cambiaAInt(numTicket) +" AND activo = 1";
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
					queryString = "UPDATE creditos SET factura = 0 WHERE numTicket = "+cambiaAInt(sb.toString())+"";
					stmt = con.creaStatement();
					stmt.execute(queryString);
					stmt.close();
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
				updateCancelaTicket.setInt(4, 1);
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

/**
* El Método dameCancelaciones  nos regresa las cancelaciones realizadas en un periodo de tiempo especifico o bien todas las existentes.
*  @return ResultSet con los campos que detallan las cancelaciones de tickets.
*/
	public ResultSet dameCancelaciones(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		String query = "";
		try{
			if(fecha.equalsIgnoreCase("NO")){
				query = ("SELECT * FROM cancelacion ORDER BY claveCancela DESC");
			}
			else {
				query = ("SELECT * FROM cancelacion WHERE fechaBaja LIKE '"+fecha +"' ORDER BY claveCancela DESC");
			}
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerTicket, dameCancelaciones ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerTicket, dameCancelaciones ");
			e.printStackTrace();
		}
		return rs;
	}


	public void cierraConexion() throws SQLException, Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerTicket metodo cierraConexion");
				q.printStackTrace();
			}
		}
	}


	public boolean CambiaAviso(String aviso) throws SQLException, Exception {
		boolean bandera = true;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try  {
				String queryString ="UPDATE avisos SET frase = '"+aviso+"' WHERE automatico = 1 ";
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
				bandera = false;
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println(	"Error al cerrar conexion de mticket ManagerTicket CambiaAviso");
					q.printStackTrace();
				}
			}
		}
		//System.out.println("Bandera: "+bandera);
		return bandera;
	}


// CLASES PREVIAS:





// Encargado de insertar los datos arrojados por mi ticket.
	public boolean addDatosTicket(String numTicket, String fecha, String numArticulo, String descripcionArticulo, String tipoPLU, String numOperador, String numBascula, double precioVenta, String numCliente, double pesoOcant, String numDepto, String modOpera, String cantDescu, String precioEsp, String IDsobreEsc, String IDCancela){
		boolean salida = true;
		try{
			con = new ConexionBD();
			if (con.miConnection != null) {
				PreparedStatement updateContenidoTicket;
				updateContenidoTicket = con.miConnection.prepareStatement(	"INSERT INTO contenidoticket 	VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				updateContenidoTicket.setString(1, numTicket);
				updateContenidoTicket.setDate(2, cambiaADate(fecha));
				updateContenidoTicket.setString(3, numArticulo);
				updateContenidoTicket.setString(4, descripcionArticulo );
				updateContenidoTicket.setString(5, tipoPLU);
				updateContenidoTicket.setString(6, numOperador );
				updateContenidoTicket.setString(7, numBascula);
				updateContenidoTicket.setDouble(8, precioVenta);
				updateContenidoTicket.setString(9, numCliente);
				updateContenidoTicket.setDouble(10, pesoOcant);
				updateContenidoTicket.setString(11, numDepto );
				updateContenidoTicket.setInt(12, cambiaAInt(modOpera));
				updateContenidoTicket.setString(13, cantDescu);
				updateContenidoTicket.setString(14, precioEsp);
				updateContenidoTicket.setInt(15, cambiaAInt(IDsobreEsc));
				updateContenidoTicket.setInt(16, cambiaAInt(IDCancela));
				updateContenidoTicket.setInt(17, 0);
				updateContenidoTicket.setDouble(18, calculaPrecio(precioVenta,pesoOcant));
				updateContenidoTicket.execute();
				salida=false;
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL dentro de ManagerTicket metodo addDatosTicket");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Error! Excepcion dentro de ManagerTicket metodo addDatosTicket");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerTicket metodo addDatosTicket");
					q.printStackTrace();
				}
			}
		}
		return salida;
	}




// Encargado de insertar los datos posteriores a una cancelacion de Ticket.
	public void almacenaEliminacion(String numTicket, String fecha, String tipo, String usuario){
		Statement st = null;
		ResultSet rs= null;
		TimeStamp ts = null;
		DateStamp ds = null;
		if(usuario.equalsIgnoreCase("")){
			usuario = "super >Sin cobro<";
		}
		double montoTotal = 0.0;
		try{
			con = new ConexionBD();
			st = con.creaStatement();
			ts = new TimeStamp();
			ds = new DateStamp();
			String queryParcial = "SELECT SUM(precioAPagar) AS montoTotal from contenidoticket WHERE numTicket = '"+completaString(numTicket) +"' AND fecha = '"+fecha +"'";
			rs = st.executeQuery(queryParcial);
			while (rs.next()){
				montoTotal = rs.getDouble("montoTotal");
			}
			if (con.miConnection != null) {
				PreparedStatement updateCancelaTicket;
				updateCancelaTicket = con.miConnection.prepareStatement(	"INSERT INTO cancelacion VALUES(?,?,?,?,?,?,?,?);");
				updateCancelaTicket.setNull(1, java.sql.Types.INTEGER);
				updateCancelaTicket.setString(2, completaString(numTicket));
				updateCancelaTicket.setDate(3, cambiaADate(fecha));
				updateCancelaTicket.setInt(4, cambiaAInt(tipo));
				updateCancelaTicket.setString(5, usuario);
				updateCancelaTicket.setDouble(6, montoTotal );
				updateCancelaTicket.setDate(7, cambiaADate(ds.obtenDatos()));
				updateCancelaTicket.setTime(8, cambiaATime(ts.time+":00"));
				updateCancelaTicket.execute();
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL dentro de ManagerTicket metodo almacenaEliminacion");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Error! Excepcion dentro de ManagerTicket metodo almacenaEliminacion");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerTicket metodo almacenaEliminacion");
					q.printStackTrace();
				}
			}
		}
	}




/**
* El método existe verifica que el Ticket solicitado existe dentro de nuestra Base de Datos.
*  	@param 	numticket0	String con el número de Ticket solicitado.
*	@return bandera 	Int si es igual 0 el Ticket no exite y si es igual a 1 el Ticket se encuentra en la Base de Datos.
*/

public int existe(String numticket0) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  String numticket = completaString(numticket0);
  	  int bandera = 0;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		String query ="SELECT numticket from contenidoticket WHERE numTicket = '" +numticket +"' AND (estatusPago = 0 OR estatusPago =2) ";
  	  		rs = st.executeQuery(query);
  	  		while(rs.next()){
  	  			if(numticket.equalsIgnoreCase(rs.getString("numticket"))) {
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
					System.out.println("Error al cerrar conexion de Cobrador metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



/**
* El método anulaProdEnTicket se encarga de completar la anulacion de un producto.
*  	@param 	numticket0	String con el número de Ticket a anularse.
*	@return bandera 	Int si es igual 0 el Ticket no exite y si es igual a 1 el Ticket se encuentra en la Base de Datos.
*/

	public void anulaProdEnTicket (String numticket0, String fecha, String numArticulo, double pesoOcant) throws SQLException, Exception {
		Statement st = null;
		boolean rs= true;
		String numticket = completaString(numticket0);
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.execute("DELETE FROM `contenidoticket` WHERE numticket = '"+numticket+"' AND fecha = '" +cambiaADate(fecha) +"' AND numArticulo = '" +numArticulo +"' AND pesoOcant = "+pesoOcant);
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
	}



//


	public synchronized Vector <String> almacenaAbono(String rfc, String nombreCliente, String pagoAbono, String formatoPago, String referenciaC, String usuario) throws SQLException, Exception {
		Vector <String> datos = new Vector <String>();
		datos.add("Exito");
		ResultSet rs = null;
		con = new ConexionBD();
		double montoPrevio = 0.00;
		double montoAbonado = cambiaADouble(pagoAbono);
		boolean existenPrevios = false;
		if(con != null){
			try  {
				con.cancelaAutoCommit();
// Guardo mi abono actual que desencadena el proceso...
				tiempo = new TimeStamp();
				String fechaHoy = tiempo.date;
				PreparedStatement updateAlmacenaAbono;
				updateAlmacenaAbono = con.miConnection.prepareStatement("INSERT INTO abonos VALUES(?,?,?,?,?,?,?,?,?);");
				updateAlmacenaAbono.setNull(1, java.sql.Types.INTEGER);
				updateAlmacenaAbono.setString(2, rfc);
				updateAlmacenaAbono.setString(3, nombreCliente);
				updateAlmacenaAbono.setDate(4, cambiaADate(fechaHoy));
				updateAlmacenaAbono.setDouble(5, cambiaADouble(pagoAbono));
				updateAlmacenaAbono.setInt(6, cambiaAInt(formatoPago));
				updateAlmacenaAbono.setString(7, referenciaC);
				updateAlmacenaAbono.setString(8, usuario);
				updateAlmacenaAbono.setInt(9,1);
				updateAlmacenaAbono.execute();
				updateAlmacenaAbono.close();
// Averiguo si ya existe registro previo en abono general, si no lo creo, de otra forma solo actualizo.
				boolean hayPrevio = false;
				String queryExisteGeneral = "SELECT rfc, nombreCliente FROM abono_general WHERE rfc = '"+rfc+"' AND nombreCliente = '"+nombreCliente+"'";
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryExisteGeneral);
				while(rs.next()){
					hayPrevio = true;
				}
				rs.close();
				stmt.close();
				if(hayPrevio){
					PreparedStatement updateAbonoGeneral;
					updateAbonoGeneral = con.miConnection.prepareStatement("UPDATE abono_general SET montoDisponible = (montoDisponible+?) WHERE rfc = ? AND nombreCliente = ?");
					updateAbonoGeneral.setDouble(1, cambiaADouble(pagoAbono));
					updateAbonoGeneral.setString(2, rfc);
					updateAbonoGeneral.setString(3, nombreCliente);
					updateAbonoGeneral.execute();
					updateAbonoGeneral.close();
				}
				else{
					PreparedStatement almacenaGeneral;
					almacenaGeneral = con.miConnection.prepareStatement("INSERT INTO abono_general  VALUES(?,?,?);");
					almacenaGeneral.setString(1, rfc);
					almacenaGeneral.setString(2, nombreCliente);
					almacenaGeneral.setDouble(3, cambiaADouble(pagoAbono));
					almacenaGeneral.execute();
					almacenaGeneral.close();
				}
// Devuelvo el credito al Cliente:
				PreparedStatement updateCreditoCliente;
				updateCreditoCliente = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo+?) WHERE rfc = ? AND nombre = ? AND activo = 1");
				updateCreditoCliente.setDouble(1, cambiaADouble(pagoAbono));
				updateCreditoCliente.setString(2, rfc);
				updateCreditoCliente.setString(3, nombreCliente);
				updateCreditoCliente.execute();
				updateCreditoCliente.close();
// Pido Abonos previos, para ver si puedo ya pagar algo previo.
				String aPrevios= "SELECT montoDisponible AS Actual FROM abono_general WHERE rfc = '"+rfc+"' AND nombreCliente = '"+nombreCliente+"'";
				stmt = con.creaStatement();
				rs = stmt.executeQuery(aPrevios);
				while(rs.next()){
					montoPrevio = montoPrevio+rs.getDouble("Actual");
				}
				rs.close();
				stmt.close();
// VERIFICO SI  EXISTE UN CREDITO QUE YA PUEDA PAGAR...
				String queryACredito = "SELECT numTicket, cantidadAPagar FROM creditos WHERE rfc = '"+rfc +"' AND nombreCliente = '"+nombreCliente +"' AND estatusCredito != 2 AND activo = 1 ORDER BY numTicket";
				stmt = con.creaStatement();
				rs = stmt.executeQuery(queryACredito);
				while(rs.next()){
					if(montoPrevio >= rs.getDouble("cantidadAPagar")){
						montoPrevio = montoPrevio-rs.getDouble("cantidadAPagar");
						Statement stmt2 = con.creaStatement();
						String finiquitaCredito = "UPDATE creditos SET estatusCredito = 2,  fechaRealPago = '"+fechaHoy+"', tipoCobro = 6,  usuarioPago = '"+usuario +"' WHERE numTicket = "+rs.getInt("numTicket")+" AND activo = 1 AND estatusCredito != 2 AND rfc ='"+rfc+"' AND nombreCliente = '"+nombreCliente+"'";
						stmt2.execute(finiquitaCredito);
						stmt2.close();
						stmt2 = con.creaStatement();
						String finiquitaTicket = "UPDATE contenidoTicket SET  fechaRealPago = '"+fechaHoy+"'  WHERE numTicket = "+rs.getInt("numTicket");
						stmt2.execute(finiquitaTicket);
						stmt2.close();
// GUARDO CONSTANCIA DE FINIQUITO DE TICKET VIA ABONO.
						PreparedStatement almacenaCreditoFin;
						almacenaCreditoFin = con.miConnection.prepareStatement("INSERT INTO pagoXAbono VALUES(?,?,?,?,?);");
						almacenaCreditoFin.setInt(1, rs.getInt("numTicket"));
						almacenaCreditoFin.setDouble(2, rs.getDouble("cantidadAPagar"));
						almacenaCreditoFin.setDate(3, cambiaADate(fechaHoy));
						almacenaCreditoFin.setString(4, usuario);
						almacenaCreditoFin.setInt(5,1);
						almacenaCreditoFin.execute();
						almacenaCreditoFin.close();
						datos.add(rs.getString("numTicket"));
						datos.add(rs.getString("cantidadAPagar"));
// Actualizo abono_general descontando el monto disponible...
						PreparedStatement updateAbonoGeneral;
						updateAbonoGeneral = con.miConnection.prepareStatement("UPDATE abono_general SET montoDisponible = (montoDisponible-?) WHERE rfc = ? AND nombreCliente = ?");
						updateAbonoGeneral.setDouble(1, rs.getDouble("cantidadAPagar"));
						updateAbonoGeneral.setString(2, rfc);
						updateAbonoGeneral.setString(3, nombreCliente);
						updateAbonoGeneral.execute();
						updateAbonoGeneral.close();
					}// Cierro If de me alcanzo a pagar algun credito
				} // Cierro while
// Vuelvo a pedir existencia de Abonos Pevios, así como sus montos:
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				datos = new Vector<String>();
				datos.add("Error");
				datos.add("Falla de SQL en clase: ManagerTicket, metodo: almacenaAbono");
				sqle.printStackTrace();
			}
			catch (Exception e) {
				con.realizaRollback();
				datos = new Vector<String>();
				datos.add("Error");
				datos.add("Excepcion en Clase ManagerTicket, metodo almacenaAbono");
				e.printStackTrace();
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
			datos = new Vector<String>();
			datos.add("Error");
			datos.add("No pude conectarme a la Base de Datos, vuelve a Intentarlo.");
		}
		return datos;
	}


	public Vector<String> damePosibleAbono (String numTicket) throws SQLException, Exception{
		Vector<String> data = new Vector<String>();
		Statement st = null;
		ResultSet rs= null;
		int bandera = 1;
		con = new ConexionBD();
		if (con !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT creditos.rfc, creditos.nombreCliente, creditos.cantidadAPagar, ACuenta FROM creditos LEFT JOIN (SELECT abono_general.montoDisponible AS ACuenta, abono_general.rfc,  abono_general.nombreCliente FROM abono_general GROUP BY abono_general.rfc,abono_general.nombreCliente) AS tempTB ON (tempTB.rfc = creditos.rfc AND tempTB.nombreCliente = creditos.nombreCliente) WHERE creditos.activo = 1 AND creditos.numTicket = "+cambiaAInt(numTicket)+" AND creditos.estatusCredito != 2 LIMIT 1");
				while(rs.next()){
					data. add(rs.getString("rfc"));
					data. add(rs.getString("nombreCliente"));
					if(rs.getString("ACuenta") != null){
						data. add(rs.getString("ACuenta"));
					}
					else{
						data. add("0.00");
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
					System.out.println("Error al cerrar conexion de Cobrador metodo yaEstabaPagadoCredito");
					q.printStackTrace();
				}
			}
		}
		return data;
	}


// NUEVO DESCUENTO
/**
* El método descuentaInventario se encarga de modificar los precios registrados para un producto.
*@return int Exito en la transaccion, donde 0 --> falla SQL, 1 --> ya esta Registrado, 2 --> Exito.
*/
	public synchronized boolean  descuentaInventario(String numTicket, String fecha) throws SQLException, Exception {
		boolean resultado = true;
		ResultSet rs = null;
		ResultSet rs2 = null;
		int cantidadPorCaja = 0;
		con = new ConexionBD();
		con.cancelaAutoCommit();
		if (con.miConnection != null) {
			try {
				String queryString = ("SELECT numArticulo, tipoPLU, pesoProducto, tipoUnidad FROM contenidoticket WHERE numTicket = '"+completaString(numTicket)+"' AND FechaTicket = '" +fecha +"' AND estatusPago != 0" );
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){
					String plu = rs.getString("numArticulo");
					String tipoPLU = rs.getString("tipoPLU");
					int tipoUnidad = rs.getInt("tipoUnidad");
					double laCantidad = rs.getDouble("pesoProducto");
					if(tipoUnidad == 1){ // ES UNA CAJA!, debo entonces de sacar la cantidad de piezas por caja.
						queryString = ("SELECT cantidadXCaja FROM productos WHERE PLU = '"+plu +"' AND activo = 1");
						stmt = con.creaStatement();
						rs2 = stmt.executeQuery(queryString);
						while(rs2.next()){
							cantidadPorCaja = cambiaAInt(rs2.getString("cantidadXCaja"));
						}
						laCantidad = laCantidad * cantidadPorCaja;
					}
					if(tipoPLU.equalsIgnoreCase("00")){
						double pesoP = 0.0;
						queryString=("SELECT peso FROM productos WHERE PLU = '"+plu +"' AND activo = 1");
						stmt = con.creaStatement();
						rs2 = stmt.executeQuery(queryString);
						while(rs2.next()){
							pesoP = cambiaADouble(rs2.getString("peso"));
						}
						pesoP = pesoP - laCantidad;
						String spesoP = pesoP+"";
						queryString = "UPDATE productos SET peso = '"+spesoP+"' WHERE PLU = '"+plu +"' AND activo = 1";
						stmt = con.miConnection.createStatement();
						stmt.execute(queryString);
					}
					else{
						double cantidadP = 0.0;
						queryString = ("SELECT cantidad FROM productos WHERE PLU = '"+plu +"' AND activo = 1");
						stmt = con.creaStatement();
						rs2 = stmt.executeQuery(queryString);
						while(rs2.next()){
							cantidadP = cambiaADouble(rs2.getString("cantidad"));
						}
						cantidadP = cantidadP - laCantidad;
						String scantidadP = cantidadP+"";
						queryString = "UPDATE productos SET cantidad = '"+scantidadP+"' WHERE PLU = '"+plu +"' AND activo = 1";
						stmt = con.miConnection.createStatement();
						stmt.execute(queryString);
					}
				}// CIERRO WHILE
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				resultado = false;
				System.out.println("Error SQL clase ManagerTicket, método descuentaInventario");
				sqle.printStackTrace();
			}
			catch (Exception q){
				con.realizaRollback();
				resultado = false;
				q.printStackTrace();
				System.out.println("Error clase ManagerTicket, método descuentaInventario");
			}
			finally{
				try{
					con.realizaCommit ( );
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerTicket metodo descuentaInventario");
					q.printStackTrace();
				}
			}
		}
		return resultado;
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


	public Time cambiaATime(String time) {
		java.sql.Time elTiempo;
		try {
			elTiempo = java.sql.Time.valueOf(new String(time));
		}
		catch(IllegalArgumentException iae){
			elTiempo = java.sql.Time.valueOf(new String("12:00:00"));
		}
		return elTiempo;
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

	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
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

	public static void main (String args[]) throws Exception{
		ManagerTicket mt = new ManagerTicket();
	}

}
