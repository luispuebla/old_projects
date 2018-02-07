package alphanet.rmi.digimaan.bd;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.NumberFormat;
import java.sql.Date;
import java.sql.Time;
import java.util.Vector;
import java.net.URLDecoder;
import javax.swing.DefaultListModel;
import java.sql.Savepoint;
import java.io.*;
import java.util.Calendar;

public class ManagerPuntoVenta {

	private ConexionBD con = null;
	private ConexionBD con2 = null;
	protected TimeStamp tiempo;
	protected static Properties config;
	private TimeStamp ts = null;


// NUEVAS

	public String damePropietario(int claveTicket)throws SQLException, Exception{
		String rfc = "";
		con = new ConexionBD();
		if(con != null){
			try{
				String query = "SELECT rfc, nombreCliente FROM creditos WHERE numTicket = "+claveTicket+" AND activo = 1";
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while(rs.next()){
					rfc = rs.getString("nombreCliente")+" > "+rs.getString("rfc");
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerVentas, damePropietario ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerVentas, damePropietario ");
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVentas, damePropietario ");
					q.printStackTrace();
				}
			}
		}
		return rfc;
	}


/**
* El Método dameListadoClientes es el Responsable de regresar el listado de Clientes Activos
* * @return Vector <String> con el listado correspondiente
*/
	public  Vector <String> dameListadoClientes() throws Exception{
		ResultSet rs = null;
		Vector <String> vClientes = new Vector <String>();
		vClientes.addElement("Público en General");
		try{
		String query = ("SELECT nombre, rfc FROM clientes WHERE activo = 1 AND tipocliente = 1 ORDER BY nombre"); // Pido clientes activos y con credito.
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				vClientes.addElement(rs.getString("nombre")+" > "+rs.getString("rfc"));
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, dameListadoClientes ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, dameListadoClientes ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVentas, dameListadoClientes ");
					q.printStackTrace();
				}
			}
		}
		return vClientes;
	}


/**
* El Método ticketCandidato verifica que el ticket del que se solicita la modificación sea un candidato viable, es decir que no este pagado o si es credito que no este liquidado.
*
* @return boolean true --> aceptado o false --> rechazado
*/
	public boolean ticketCandidato(int claveTicket){
		boolean resultado = false;
		ResultSet rs = null;
		try{
			String query = ("SELECT estatusPago FROM contenidoTicket WHERE numTicket = "+claveTicket +"  AND estatusTicket = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getInt("estatusPago") == 2){ // Ticket registrado a credito
					String query2 = "SELECT estatusCredito FROM creditos WHERE numTicket = "+claveTicket+" AND activo = 1";
					Statement stmt2 = con.creaStatement();
					ResultSet rs2 = stmt2.executeQuery(query2);
					while(rs2.next()){ // Ticket de credito NO liquidado
						if(rs2.getInt("estatusCredito") != 2){
							resultado = true;
						}
					}
					rs2.close();
					stmt2.close();
				}
				else if(rs.getInt("estatusPago") == 0){ // Ticket sin Pagar
					resultado = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, ticketCandidato ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, ticketCandidato ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, ticketCandidato ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}



/**
* El Método existeProducto verifica que el producto introducido exista en la base de datos y este dado de alta.
*
* @return boolean true --> si existe o false --> no existe
*/
	public boolean existeProducto(String laClave){
		boolean invTienda = false;
		ResultSet rs = null;
		try{
			String query = ("SELECT ID_Pro FROM productos WHERE ID_Pro = "+cambiaAInt(laClave) +"  AND Activo = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getString("ID_Pro").equals(laClave.trim())){
					invTienda = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, existeProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, existeProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, existeProducto ");
					q.printStackTrace();
				}
			}
		}
		return invTienda;
	}

/**
* El Método existeProducto verifica que el producto introducido exista en la base de datos y este dado de alta.
*
* @return boolean true --> si existe o false --> no existe
*/
	public boolean hayProducto(String laClave) throws SQLException{
		boolean invTienda = false;
		ResultSet rs = null;
		try{
			con = new ConexionBD();
			String query = ("SELECT invTienda FROM productos WHERE ID_Pro = "+cambiaAInt(laClave)+"  AND Activo = 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getDouble("invTienda") > 0.00){
					invTienda = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, hayProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, hayProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, hayProducto ");
					q.printStackTrace();
				}
			}
		}
		return invTienda;
	}


/**
* El Método existeEnAlmacen verifica que el producto introducido exista en la base de datos y este dado de alta.
*
* @return boolean true --> si existe o false --> no existe
*/
	public boolean existeEnAlmacen(String laClave) throws SQLException{
		boolean invTienda = false;
		ResultSet rs = null;
		try{
			con = new ConexionBD();
			String query = ("SELECT invAlmacen FROM productos WHERE ID_Pro = "+cambiaAInt(laClave)+"  AND Activo = 1");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getDouble("invAlmacen") > 0.00){
					invTienda = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, existeEnAlmacen ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, existeEnAlmacen ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, existeEnAlmacen ");
					q.printStackTrace();
				}
			}
		}
		return invTienda;
	}


	public String damePrecio(String precioBuscado, String claveProducto)  throws SQLException, Exception {
		con = new ConexionBD();
		String precio = "0.00";
		try{
			String target = "";
			ResultSet rs = null;
			String query = "SELECT "+precioBuscado+" AS precioTarget FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto) +" AND activo = 1 LIMIT 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				precio = rs.getString("precioTarget");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePrecio ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecio ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecio ");
					q.printStackTrace();
				}
			}
		}
		return formatoDinero(precio);
	}

	public String damePrecioMinimo(String tipoEntrada, String claveProducto)  throws SQLException, Exception {
		con = new ConexionBD();
		String precioMinimo = "0.00";
		try{
			String target = "";
			if(tipoEntrada.equals("Kilo")){
				target = " precioUnidadKG AS precioKilo ";
			}
			else if(tipoEntrada.equals("Pieza")){
				target = " precioUnidadKG  AS precioPieza";
			}
			else if(tipoEntrada.equals("Unidad")){
				target = " precioUniCompra AS precioUnidad";
			}
			else if(tipoEntrada.equals("Caja")){
				target = " preCaCompra  AS precioCaja";
			}
			ResultSet rs = null;
			String query = "SELECT "+target+" FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto) +" AND activo = 1 LIMIT 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				if(tipoEntrada.equals("Kilo")){
					precioMinimo = rs.getString("precioKilo");
				}
				else if(tipoEntrada.equals("Pieza")){
					precioMinimo = rs.getString("precioPieza");
				}
				else if(tipoEntrada.equals("Unidad")){
					precioMinimo = rs.getString("precioUnidad");
				}
				else if(tipoEntrada.equals("Caja")){
					precioMinimo = rs.getString("precioCaja");
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePrecioMinimo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecioMinimo ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecioMinimo ");
					q.printStackTrace();
				}
			}
		}
		return precioMinimo;
	}

/**
* El Método dameClaveCorrespondiente verifica que el producto introducido via escanner exista en la base de datos y este dado de alta.
*
* @return String con la clave registrada para el producto en la BD o en blanco si no se encontró.
*/
	public String dameClaveCorrespondiente(String codigoBarras)  throws SQLException, Exception {
		con = new ConexionBD();
		String claveDeProducto = "";
		try{
			ResultSet rs = null;
			String query = "SELECT ID_Pro FROM codigosb WHERE codBarra = '"+codigoBarras +"'";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				claveDeProducto = rs.getString("ID_Pro");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameClaveCorrespondiente ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameClaveCorrespondiente ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameClaveCorrespondiente ");
					q.printStackTrace();
				}
			}
		}
		return claveDeProducto;
	}

	// Me regresa el tipo de producto: // 1 Solo Kg,  2 Solo unidad,  3 Unidad y Caja, 4 KG y Pieza
	public int dameTipoProducto(String claveProducto) throws SQLException, Exception{
		con = new ConexionBD();
		int tipoProducto = 0;
		try{
			ResultSet rs = null;
			String query = "SELECT tipoPro, manejoPrecio FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				if(rs.getInt("tipoPro") == 1){
					if(rs.getInt("manejoPrecio") == 0){
						tipoProducto = 1;
					}
					else{
						tipoProducto = 4;
					}
				}
				else{
					if(rs.getInt("manejoPrecio") == 0){
						tipoProducto = 2;
					}
					else{
						tipoProducto = 3;
					}
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameTipoProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameTipoProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameTipoProducto ");
					q.printStackTrace();
				}
			}
		}
		return tipoProducto;
}

	 // Regresa el Manejo de precio de venta registrado para este producto:  1 Solo Base,  2 Grupo,  3 Escalon.
	public int dameManejoPrecio(String claveProducto) throws SQLException, Exception{
		con = new ConexionBD();
		int manejoPrecio = 0;
		try{
			ResultSet rs = null;
			String query = "SELECT tipoPrecio FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				if(rs.getInt("tipoPrecio") == 0){
					manejoPrecio = 1;
				}
				else if(rs.getInt("tipoPrecio") == 1){
					manejoPrecio = 2;
				}
				else{
					manejoPrecio = 3;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameManejoPrecio ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameManejoPrecio ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameManejoPrecio ");
					q.printStackTrace();
				}
			}
		}
		return manejoPrecio;
}


	public String dameNombreProducto(String claveProducto) throws SQLException, Exception{
		con = new ConexionBD();
		String nombreP = "";
		try{
			ResultSet rs = null;
			String query = "SELECT descripcion FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				nombreP = rs.getString("descripcion");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameNombreProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameNombreProducto ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameNombreProducto ");
					q.printStackTrace();
				}
			}
		}
		return nombreP;
	}


	public  String dameExistenciaXKilo(String claveProducto) throws SQLException, Exception{
		String existencia= "0.00";
		con = new ConexionBD();
		try{
			ResultSet rs = null;
			String query = "SELECT invTienda  FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				existencia = rs.getString("invTienda");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameExistenciaXKilo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameExistenciaXKilo ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameExistenciaXKilo ");
					q.printStackTrace();
				}
			}
		}
		return existencia;
	}



	public Vector <String> damePrecioYExsitenciaXKilo(String claveProducto, int formatoPrecio) throws SQLException, Exception{
		String solicitud = " precioMenu ";
		Vector <String> datosXKg = new Vector <String>();
		con = new ConexionBD();
		if (formatoPrecio == 1){
			solicitud = " precioMM ";
		}
		else if (formatoPrecio == 2){
			solicitud = " precioM ";
		}
		try{
			ResultSet rs = null;
			String query = "SELECT invTienda, "+solicitud +"AS Precio FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				datosXKg.addElement(rs.getString("invTienda"));
				datosXKg.addElement(rs.getString("Precio"));
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePrecioYExsitenciaXKilo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecioYExsitenciaXKilo ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecioYExsitenciaXKilo ");
					q.printStackTrace();
				}
			}
		}
		return datosXKg;
	}


	public  Vector <String> dameExistenciaXPz(String claveProducto) throws SQLException, Exception{
		Vector <String> datosXPz = new Vector <String>();
		con = new ConexionBD();
		try{
			ResultSet rs = null;
			String query = "SELECT (invTienda/kgXUnidad) AS invTienda, kgXUnidad FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				datosXPz.addElement(rs.getInt("invTienda")+"");
				datosXPz.addElement(rs.getString("kgXUnidad"));
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameExistenciaXPz ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameExistenciaXPz ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameExistenciaXPz ");
					q.printStackTrace();
				}
			}
		}
		return datosXPz;
	}


	public Vector <String> damePrecioYExsitenciaXPz(String claveProducto, int formatoPrecio) throws SQLException, Exception{
		String solicitud = " precioMenuC ";
		Vector <String> datosXPz = new Vector <String>();
		con = new ConexionBD();
		if (formatoPrecio == 1){
			solicitud = " precioMMC ";
		}
		else if (formatoPrecio == 2){
			solicitud = " precioMC ";
		}
		try{
			ResultSet rs = null;
			String query = "SELECT (invTienda/kgXUnidad) AS invTienda, kgXUnidad,  "+solicitud +"AS Precio FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				datosXPz.addElement(rs.getString("Precio"));
				datosXPz.addElement(rs.getInt("invTienda")+"");
				datosXPz.addElement(rs.getDouble("kgXUnidad")+"");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePrecioYExsitenciaXPz ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecioYExsitenciaXPz ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecioYExsitenciaXPz ");
					q.printStackTrace();
				}
			}
		}
		return datosXPz;
	}



	public String dameExistenciaXUni(String claveProducto) throws SQLException, Exception{
		String existencia = "0";
		con = new ConexionBD();
		try{
			ResultSet rs = null;
			String query = "SELECT invTienda  FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				existencia = rs.getInt("invTienda")+"";
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameExistenciaXUni ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameExistenciaXUni ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameExistenciaXUni ");
					q.printStackTrace();
				}
			}
		}
		return existencia;
	}


	public Vector <String> damePrecioYExsitenciaXUni(String claveProducto, int formatoPrecio) throws SQLException, Exception{
		String solicitud = " precioMenu ";
		Vector <String> datosXKg = new Vector <String>();
		con = new ConexionBD();
		if (formatoPrecio == 1){
			solicitud = " precioMM ";
		}
		else if (formatoPrecio == 2){
			solicitud = " precioM ";
		}
		try{
			ResultSet rs = null;
			String query = "SELECT invTienda, "+solicitud +"AS Precio FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				datosXKg.addElement(dameEnteros(rs.getString("invTienda")));
				datosXKg.addElement(rs.getString("Precio"));
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePrecioYExsitenciaXUni ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecioYExsitenciaXUni ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecioYExsitenciaXUni ");
					q.printStackTrace();
				}
			}
		}
		return datosXKg;
	}



	public  Vector <String> dameExistenciaXCaja(String claveProducto) throws SQLException, Exception{
		Vector <String> datosXCaja = new Vector <String>();
		con = new ConexionBD();
		try{
			ResultSet rs = null;
			String query = "SELECT (invTienda/cantidadXCaja) AS invTienda, cantidadXCaja FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				datosXCaja.addElement(rs.getInt("invTienda")+"");
				datosXCaja.addElement(rs.getInt("cantidadXCaja")+"");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameExistenciaXCaja ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameExistenciaXCaja ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameExistenciaXCaja ");
					q.printStackTrace();
				}
			}
		}
		return datosXCaja;
	}


	public Vector <String> damePrecioYExsitenciaXCj(String claveProducto, int formatoPrecio) throws SQLException, Exception{
		String solicitud = " precioMenuC ";
		Vector <String> datosXKg = new Vector <String>();
		con = new ConexionBD();
		if (formatoPrecio == 1){
			solicitud = " precioMMC ";
		}
		else if (formatoPrecio == 2){
			solicitud = " precioMC ";
		}
		try{
			ResultSet rs = null;
			String query = "SELECT (invTienda/cantidadXCaja) AS invTienda, "+solicitud +"AS Precio, cantidadXCaja FROM productos WHERE ID_Pro = "+cambiaAInt(claveProducto)+" AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				datosXKg.addElement(rs.getInt("invTienda")+"");
				datosXKg.addElement(rs.getString("Precio"));
				datosXKg.addElement(rs.getInt("cantidadXCaja")+"");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePrecioYExsitenciaXCj ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecioYExsitenciaXCj ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecioYExsitenciaXCj ");
					q.printStackTrace();
				}
			}
		}
		return datosXKg;
	}

/**
* El Método verificaAutorizacion nos informa si la contraseña para el cambio de tipo de producto es valida.
*
* @return boolean true --> si concuerda, false --> no concuerda
*/
	public boolean verificaAutorizacion(int claveAutoriza,  int tipoSolicitado) throws SQLException, Exception{
		boolean existe = false;
		ResultSet rs = null;
		try{
			String query = "SELECT clave FROM permisos WHERE Tipo  = "+tipoSolicitado;
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getInt("clave")==claveAutoriza){
					existe = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, verificaAutorizacion ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, verificaAutorizacion ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPrecioProveedor, verificaAutorizacion ");
					q.printStackTrace();
				}
			}
		}
		return existe;
	}

	public Vector <String> listadoEscalon(String claveProducto) throws SQLException, Exception{
		Vector <String> resultado = new Vector <String> ();
		ResultSet rs = null;
		String query = "";
		try{
			query = ("SELECT pescalonados.ca_peEscalon+1 AS Limite, pescalonados.campoPrecio AS Precio FROM pescalonados WHERE pescalonados.ID_Pro = '"+cambiaAInt(claveProducto) +"' AND activo = 1 ORDER BY pescalonados.ca_peEscalon");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				resultado.addElement(rs.getInt("Limite")+"   -->   $ " +formatoDinero(rs.getString("Precio")));
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, listadoEscalon ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, listadoEscalon ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, listadoEscalon ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}

/**
* El Método cambiaPrecioEscalon nos regresa el precio modificado deacuerdo a la cantidad comprada para cuando el producto es de Escalon
*
* @return double precio --> El precio modificado.
*/
	public double cambiaPrecioEscalon(String cantidadDeProducto, String claveProducto){
		double precio = 0.0;
		ResultSet rs = null;
		try{
			String query = " SELECT pescalonados.campoPrecio FROM  pescalonados  WHERE pescalonados.ca_peEscalon = (SELECT MAX(pescalonados.ca_peEscalon) AS escalon FROM pescalonados WHERE pescalonados.ID_Pro = '"+claveProducto +"' AND pescalonados.activo = 1 AND pescalonados.ca_peEscalon < " +cambiaADouble(cantidadDeProducto)  +" GROUP BY pescalonados.ID_Pro) AND pescalonados.ID_Pro = '"+claveProducto +"'";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
					precio = rs.getDouble("campoPrecio");
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, cambiaPrecioEscalon ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, cambiaPrecioEscalon ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPrecioProveedor, cambiaPrecioEscalon ");
					q.printStackTrace();
				}
			}
		}
		return precio;
	}

/**
* El Método existeUsuario nos informa si el producto cuenta con escalon de precios
*
* @return boolean true --> si posee, false --> no cuenta con un escalon.
*/
	public boolean existeUsuario(int claveVendedor) throws SQLException, Exception{
		boolean existe = false;
		ResultSet rs = null;
		try{
			String query = ("SELECT claveVenta FROM vendedores WHERE claveVenta = "+claveVendedor +" AND Estatus = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getInt("claveVenta") == claveVendedor){
					existe = true;
				}
			}
			rs.close();
			stmt.close();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, existeUsuario ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, existeUsuario ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPrecioProveedor, existeUsuario ");
					q.printStackTrace();
				}
			}
		}
		return existe;
	}


/**
* El método guardaProducto almacena el producto de acuerdo a un ticket.
*@return boolean Exito en la transaccion, donde true --> OK , false --> Error.
*/
	public synchronized boolean guardaProducto(String claveProducto, int tipoUnidad, int tipoPrecio, String precio, String cantidad, double  pPiezaKg, String importe, int claveU) throws SQLException, Exception {
		boolean exito = true;
		ResultSet contQ = null;
		con = new ConexionBD();
		con.cancelaAutoCommit();
		ts = new TimeStamp();
		int numTicket = 0;
		String nombreProducto = "";
		String fechaHoy = ts.date;
		String fechaPrevia = "";
		if (con.miConnection != null) {
			try {
				// Primero checo si existe un ticket en proceso...
				String query = ("SELECT numTicket, fechaRegistro FROM contenidoticket WHERE claveVendedor = "+claveU+" AND estatusTicket = 0");
				Statement stmt = con.miConnection.createStatement();
				contQ = stmt.executeQuery(query);
				while(contQ.next()){
					numTicket = contQ.getInt("numTicket");
					fechaPrevia = contQ.getString("fechaRegistro");
				}
				contQ.close();
				stmt.close();
				if(numTicket == 0){
					// NO EXISTE UN TICKET ABIERTO,
					query = "SELECT MAX(numTicket) AS Maximo FROM contenidoticket";
					stmt =  con.miConnection.createStatement();
					contQ = stmt.executeQuery(query);
					while(contQ.next()){
						numTicket = (contQ.getInt("Maximo"));
					}
					contQ.close();
					stmt.close();
					numTicket ++;
				}
				// Ya existe uno abierto,  solo reviso que no haya de fecha anterior.
				else{
					Calendar fechaActual = formatoCalendar(ts.date);
					Calendar fechaProdPrevio = formatoCalendar(fechaPrevia);
					if(fechaProdPrevio.before((Object) fechaActual)){
						String borraPrevio = "DELETE FROM contenidoticket WHERE numTicket = "+numTicket +" AND fechaRegistro = '"+fechaPrevia +"' AND estatusTicket = 0";
						stmt = con.miConnection.createStatement();
						stmt.execute(borraPrevio);
						stmt.close();
					}
				}
				// GUARDO EN BD
				PreparedStatement updateContenidoTicket;
				updateContenidoTicket = con.miConnection.prepareStatement("insert into contenidoticket values(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				updateContenidoTicket.setInt(1, numTicket); // Consecutivo de Ticket
				updateContenidoTicket.setString(2, ts.date); // fecha de Entrada
				updateContenidoTicket.setString(3, ts.time); // hora de Entrada
				updateContenidoTicket.setInt(4, cambiaAInt(claveProducto)); //ID_Pro
				updateContenidoTicket.setInt(5, claveU); // Vendedor
				updateContenidoTicket.setInt(6, tipoUnidad); // 1 Solo Kg,  2 Solo unidad,  3 Unidad y Caja, 4 Kg y Pieza
				updateContenidoTicket.setInt(7, tipoPrecio); // 0 --> Normal, 1--> GP1, 2--> GP2, 3--> GP3, 4--> GP4,  5--> GP5, 6--> GP6,  7--> Escalon
				updateContenidoTicket.setDouble(8, cambiaADouble(precio));
				updateContenidoTicket.setDouble(9, cambiaADouble(cantidad));
				updateContenidoTicket.setDouble(10, pPiezaKg);
				updateContenidoTicket.setInt(11,0);
				updateContenidoTicket.setDouble(12, cambiaADouble(importe)); // CANTIDAD A PAGAR
				updateContenidoTicket.setInt(13, 0); // CANTIDAD A PAGAR
				updateContenidoTicket.setNull(14,java.sql.Types.DATE);
				updateContenidoTicket.execute();
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				exito = false;
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo guardaProducto");
				sqle.printStackTrace();
			}
			catch (Exception q){
				con.realizaRollback();
				exito = false;
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo guardaProducto");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo guardaProducto");
					q.printStackTrace();
				}
			}
		}
		return exito;
	}


/**
* El método eliminaCuenta borra la transaccion en curso para un vendedor especifico
*@return int Exito en la transaccion, donde 0 --> falla SQL, 1 --> no hay ticket en proceso, 2 --> Exito.
*/
	public synchronized int eliminaCuenta(int claveVendedor) throws SQLException, Exception {
		int regresa = 2;
		ResultSet rs = null;
		con = new ConexionBD();
		con.cancelaAutoCommit();
		int ticket = 0;
		if (con.miConnection != null) {
			try {
				String query = ("SELECT numTicket FROM contenidoticket WHERE claveVendedor = '"+claveVendedor +"' AND estatusTicket = 0 AND estatusPago = 0 ");
					Statement stmt = con.miConnection.createStatement();
					rs = stmt.executeQuery(query);
					while(rs.next()){
						ticket = rs.getInt("numTicket");
					}
					rs.close();
					stmt.close();
					if(ticket == 0){
						regresa = 1;
					}
					else{
						String queryString = "UPDATE contenidoticket SET estatusTicket = 2 WHERE numTicket = " +ticket +" AND estatusPago = 0";
						stmt = con.miConnection.createStatement();
						stmt.execute(queryString);
						stmt.close();
					}
					con.realizaCommit();
				}
				catch (SQLException sqle) {
					con.realizaRollback();
					regresa = 0;
					System.out.println("Error SQL clase ManagerPuntoVenta, metodo eliminaCuenta");
					sqle.printStackTrace();
				}
				catch (Exception q){
					con.realizaRollback();
					regresa = 0;
					q.printStackTrace();
					System.out.println("Error clase ManagerPuntoVenta, metodo eliminaCuenta");
				}
				finally{
					try{
						con.habilitaAutoCommit();
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo eliminaCuenta");
						q.printStackTrace();
					}
				}
			}
		return regresa;
	}


/**
* El Método tablaListadoBusqueda  nos regresa el formato de la tabla para un JTable a ser desplegado.
*  @return MyTableModel con los campos sobre los productos que concuerdan con la búsqueda.
*/
	public MyTableModel tablaListadoBusqueda(String criterio) throws SQLException, Exception{
		MyTableModel mtm = null;
		// Genero mi Arreglo con los datos
		String [] titulos = new String[3];
		titulos[0] = "Clave";
		titulos[1] = "Artículo";
		titulos[2] = "Unidades / Kg.";
		try{
			ResultSet rs = null;
			String query = "";
			query = ("SELECT ID_Pro, descripcion, tipoPro, invTienda, tipoPrecio, cantidadXCaja, kgXUnidad, manejoPrecio FROM productos WHERE (descripcion LIKE '%"+FixCriterio(criterio.trim())+"%') AND activo = 1 ORDER BY descripcion");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnas = rsmd.getColumnCount();
			int renglones = getResultSetSize(rs);
			Object [][] datos = new Object [renglones][3];
			int renglon = 0;
			while(rs.next()){
				for (int i = 0 ; i<columnas; i++){
					int itipoPLU = rs.getInt("tipoPro");
					if(i == 0){
						datos [renglon][i] = rs.getInt("ID_Pro");
//						System.out.println("En i = 0 -->" +rs.getInt("ID_Pro"));
					}
					else if(i==1){
						datos [renglon][i] = rs.getString("descripcion");
//						System.out.println("En i = 1 -->" +rs.getString("descripcion"));
					}
					else if(i==2){
						if(itipoPLU == 1){
							datos [renglon] [i] = rs.getDouble("invTienda")+" Kg.";
//							System.out.println("En i = 2 -->" +rs.getString("invTienda"));
						}
						else{
							datos [renglon] [i] = rs.getInt("invTienda") +" Uni.";
//							System.out.println("En i = 2 -->" +rs.getString("invTienda"));
						}
					}
				}
				renglon++;
			}
			rs.close();
			stmt.close();
			mtm = new MyTableModel(titulos,datos);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, listadoProductosBusqueda ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, listadoProductosBusqueda ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, listadoProductosBusqueda ");
					q.printStackTrace();
				}
			}
		}
		return mtm;
	}


/**
* El método existeCuenta se encarga de modificar los precios registrados para una linea de acuerdo a un proveedor
*@return String ticket --> el ticket que vamos a procesar.
*/
	public synchronized int existeCuenta(int claveVendedor) throws SQLException, Exception {
		ResultSet rs = null;
		int ticket = 0;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				String query = ("SELECT numTicket FROM contenidoticket WHERE claveVendedor = "+claveVendedor +" AND estatusTicket = 0 AND estatusPago = 0 ");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					ticket = rs.getInt("numTicket");
				}
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo existeCuenta");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo existeCuenta");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo existeCuenta");
					q.printStackTrace();
				}
			}
		}
	return ticket;
	}

	public synchronized Vector <String> dameProductoEliminado(int claveTicket) throws SQLException, Exception{
		Vector <String> productoEliminado = new Vector <String>();
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				ResultSet rs = null;
				String query = "SELECT SUM(Suma) AS Suma, ID_Pro FROM (SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoticket.TipoVenta = 1 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 0 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoticket.TipoVenta = 2 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 0 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto*productos.cantidadXCaja) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM  contenidoticket, productos WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoticket.TipoVenta = 3 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 0 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.pesoEnPz) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket WHERE contenidoticket.numTicket = "+claveTicket + " AND contenidoticket.TipoVenta = 4 AND contenidoticket.estatusTicket = 0 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta) as kiko GROUP BY ID_Pro";
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
								complemento = rs.getDouble("Suma")+" Unidades. y solo hay "+rs2.getDouble("invTienda")+" Unidades. en Inventario de la Tienda";
							}
							else{
								complemento = rs.getDouble("Suma")+" Kg. y solo hay "+rs2.getDouble("invTienda")+" Kg. en Inventario de la Tienda";
							}
						}
						if(eliminacionXExistencia) {
							Statement stmt3 = con.miConnection.createStatement();
							ResultSet rs3 = stmt3.executeQuery("SELECT descripcion FROM productos WHERE ID_Pro = "+rs.getInt("ID_Pro") +" AND activo = 1");
							while (rs3.next()){
								productoEliminado.addElement("Se elimino automaticamente de tu cuenta las entradas de "+rs3.getString("descripcion")+" ("+rs.getInt("ID_Pro")+	") ya que \n solicitas "+complemento);
							}
							rs3.close();
							stmt3.close();
							String borraXExistencia = "DELETE FROM contenidoticket WHERE numTicket = "+claveTicket +" AND ID_Pro = "+rs.getInt("ID_Pro") +"  AND estatusTicket = 0";
							Statement stmt4 = con.miConnection.createStatement();
							stmt4.execute(borraXExistencia);
							stmt4.close();
						}
					}
				}
				rs.close();
				stmt.close();
				con.realizaCommit();
			}
			catch (SQLException sqle){
				con.realizaRollback();
				productoEliminado = new Vector <String>();
				productoEliminado.addElement("ERROR");
				System.out.println("Error de SQL en ManagerPuntoVenta, dameProductoEliminado ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				con.realizaRollback();
				productoEliminado = new Vector <String>();
				productoEliminado.addElement("ERROR");
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
		return productoEliminado;
	}

/**
* El Método existenProductosEnLista  nos avisa si existen productos para una lista solicitada.
*  @return ResultSet con los detalle por producto.
*/
	public boolean existenProductosEnLista(int claveTicket) throws SQLException, Exception{
		boolean invTienda = false;
		ResultSet rs = null;
		String query = "";
		try{
			query = ("SELECT COUNT(numTicket) AS productos FROM contenidoTicket WHERE numTicket = "+claveTicket +" AND estatusTicket = 0");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getInt("productos") > 0){
					invTienda = true;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, existenProductosEnLista ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, existenProductosEnLista ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, existenProductosEnLista ");
					q.printStackTrace();
				}
			}
		}
		return invTienda;
	}


/**
* El Método existenProductosEnLista  nos avisa si existen productos para una lista solicitada.
*  @return ResultSet con los detalle por producto.
*/
	public boolean existenProductosEnListaR(int claveTicket) throws SQLException, Exception{
		boolean invTienda = false;
		ResultSet rs = null;
		String query = "";
		try{
			query = ("SELECT COUNT(numTicket) AS productos FROM contenidoTicket WHERE numTicket = "+claveTicket +" AND estatusTicket = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getInt("productos") > 0){
					invTienda = true;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, existenProductosEnListaR ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, existenProductosEnListaR ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, existenProductosEnListaR ");
					q.printStackTrace();
				}
			}
		}
		return invTienda;
	}


/**
* El Método tablaListadoPrevio  nos regresa el formato de la tabla para un JTable a ser desplegado.
*  @return MyTableModel con los campos que detallan las especificaciones de los productos.
*/
	public synchronized MyTableModel tablaListadoPrevio(int claveTicket) throws SQLException, Exception {
		MyTableModel mtm = null;
		// Genero mi Arreglo con los datos
		String [] titulos = new String[7];
		titulos[0] = "Cantidad";
		titulos[1] = "Unidad";
		titulos[2] = "Artículo";
		titulos[3] = "Clave";
		titulos[4] = "T.Precio";
		titulos[5] = "Precio";
		titulos[6] = "Importe";
		try{
			con = new ConexionBD();
			String query = ("SELECT SUM(contenidoTicket.precioAPagar) AS precioAPagar, productos.descripcion, contenidoTicket.ID_Pro, contenidoTicket.tipoVenta, contenidoTicket.tipoPrecio, contenidoTicket.precioVenta, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz FROM contenidoTicket, productos WHERE contenidoTicket.numTicket = "+claveTicket+" AND contenidoTicket.estatusTicket = 0 AND productos.ID_Pro = contenidoticket.ID_Pro GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio ORDER BY horaRegistro");
			ResultSet rs = null;
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(query);
			rs = stmt.executeQuery(query);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnas = rsmd.getColumnCount();
			int renglones = getResultSetSize(rs);
			Object [][] datos = new Object [renglones][7];
			int renglon = 0;
			while(rs.next()){
				for (int i = 0 ; i<columnas; i++){
					if(i == 0){
						if(rs.getInt("tipoVenta") == 2){
							datos [renglon][i] = +rs.getInt("CantidadProducto");
						}
						else{
							if(rs.getInt("tipoVenta") == 1 || rs.getInt("tipoVenta") == 3){
								datos [renglon][i] = +rs.getDouble("CantidadProducto");
							}
							else if(rs.getInt("tipoVenta") == 4){
								datos [renglon][i] = +rs.getDouble("CantidadProducto")+" ("+rs.getDouble("pesoEnPz")+")";
							}

						}
					}
					else if(i==1){
						if(rs.getInt("tipoVenta") == 1){
							datos [renglon][i] = "Kilo";
						}
						else if(rs.getInt("tipoVenta") == 2){
							datos [renglon][i] = "Unidad";
						}
						else if(rs.getInt("tipoVenta")==3){
							datos [renglon][i] = "Caja";
						}
						else{
							datos [renglon][i] = "Pieza (Kg)";
						}
					}
					else if(i==2){
						datos [renglon] [i] = rs.getString("descripcion");
					}
					else if(i==3){
						datos [renglon] [i] = rs.getString("ID_Pro");
					}
					else if (i ==4){
						if(rs.getInt("tipoPrecio") == 0){
							datos [renglon][i] = "Menudeo";
						}
						if(rs.getInt("tipoPrecio") == 1){
							datos [renglon][i] = "M.Mayoreo";
						}
						if(rs.getInt("tipoPrecio") == 2){
							datos [renglon][i] = "Mayoreo";
						}
						if(rs.getInt("tipoPrecio") == 3){
							datos [renglon][i] = "Asignado";
						}
						if(rs.getInt("tipoPrecio") == 7){
							datos [renglon][i] = "Escalon";
						}
					}
					else if(i==5){
						datos[renglon][i] = formatoDinero(rs.getString("precioVenta"));
					}
					else if(i==6){
						datos[renglon][i] =formatoDinero(rs.getString("precioAPagar"));
					}
				}
				renglon++;
			}
			mtm = new MyTableModel(titulos,datos);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return mtm;
	}



/**
* El Método tablaListadoPrevio  nos regresa el formato de la tabla para un JTable a ser desplegado.
*  @return MyTableModel con los campos que detallan las especificaciones de los productos.
*/
	public synchronized MyTableModel tablaListadoPrevioR(int claveTicket) throws SQLException, Exception {
		MyTableModel mtm = null;
		// Genero mi Arreglo con los datos
		String [] titulos = new String[7];
		titulos[0] = "Cantidad";
		titulos[1] = "Unidad";
		titulos[2] = "Artículo";
		titulos[3] = "Clave";
		titulos[4] = "T.Precio";
		titulos[5] = "Precio";
		titulos[6] = "Importe";
		try{
			con = new ConexionBD();
			String query = ("SELECT SUM(contenidoTicket.precioAPagar) AS precioAPagar, productos.descripcion, contenidoTicket.ID_Pro, contenidoTicket.tipoVenta, contenidoTicket.tipoPrecio, contenidoTicket.precioVenta, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz FROM contenidoTicket, productos WHERE contenidoTicket.numTicket = "+claveTicket+" AND contenidoTicket.estatusTicket = 1 AND productos.ID_Pro = contenidoticket.ID_Pro GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio ORDER BY horaRegistro");
			ResultSet rs = null;
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(query);
			rs = stmt.executeQuery(query);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnas = rsmd.getColumnCount();
			int renglones = getResultSetSize(rs);
			Object [][] datos = new Object [renglones][7];
			int renglon = 0;
			while(rs.next()){
				for (int i = 0 ; i<columnas; i++){
					if(i == 0){
						if(rs.getInt("tipoVenta") == 2){
							datos [renglon][i] = +rs.getInt("CantidadProducto");
						}
						else{
							if(rs.getInt("tipoVenta") == 1 || rs.getInt("tipoVenta") == 3){
								datos [renglon][i] = +rs.getDouble("CantidadProducto");
							}
							else if(rs.getInt("tipoVenta") == 4){
								datos [renglon][i] = +rs.getDouble("CantidadProducto")+" ("+rs.getDouble("pesoEnPz")+")";
							}

						}
					}
					else if(i==1){
						if(rs.getInt("tipoVenta") == 1){
							datos [renglon][i] = "Kilo";
						}
						else if(rs.getInt("tipoVenta") == 2){
							datos [renglon][i] = "Unidad";
						}
						else if(rs.getInt("tipoVenta")==3){
							datos [renglon][i] = "Caja";
						}
						else{
							datos [renglon][i] = "Pieza (Kg)";
						}
					}
					else if(i==2){
						datos [renglon] [i] = rs.getString("descripcion");
					}
					else if(i==3){
						datos [renglon] [i] = rs.getString("ID_Pro");
					}
					else if (i ==4){
						if(rs.getInt("tipoPrecio") == 0){
							datos [renglon][i] = "Menudeo";
						}
						if(rs.getInt("tipoPrecio") == 1){
							datos [renglon][i] = "M.Mayoreo";
						}
						if(rs.getInt("tipoPrecio") == 2){
							datos [renglon][i] = "Mayoreo";
						}
						if(rs.getInt("tipoPrecio") == 3){
							datos [renglon][i] = "Asignado";
						}
						if(rs.getInt("tipoPrecio") == 7){
							datos [renglon][i] = "Escalon";
						}
					}
					else if(i==5){
						datos[renglon][i] = formatoDinero(rs.getString("precioVenta"));
					}
					else if(i==6){
						datos[renglon][i] =formatoDinero(rs.getString("precioAPagar"));
					}
				}
				renglon++;
			}
			mtm = new MyTableModel(titulos,datos);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return mtm;
	}

/**
* El método cantidadProductos nos informa cuantos productos conforman nuestra lista
*@return String cantidad --> la cantidad de productos.
*/
	public String cantidadProductos(int claveTicket) throws SQLException, Exception {
		ResultSet rs = null;
		String ticket = "0";
		int suma = 0;
		boolean entro = false;
			con = new ConexionBD();
			if (con.miConnection != null) {
				try {
					String query = ("SELECT COUNT(numTicket) AS productos FROM contenidoTicket WHERE numTicket = "+claveTicket +" AND estatusTicket = 0 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
//					System.out.println(query);
					Statement stmt = con.miConnection.createStatement();
					rs = stmt.executeQuery(query);
					while(rs.next()){
						suma ++;
					}
					ticket = suma+"";
				}
				catch (SQLException sqle) {
					System.out.println("Error SQL clase ManagerPuntoVenta, metodo cantidadProductos");
					sqle.printStackTrace();
				}
				catch (Exception q){
					q.printStackTrace();
					System.out.println("Error clase ManagerPuntoVenta, metodo cantidadProductos");
				}
				finally{
					try{
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo cantidadProductos");
						q.printStackTrace();
					}
				}
			}
		return ticket;
	}


/**
* El método cantidadProductosR nos informa cuantos productos conforman nuestra lista de Reciclado
*@return String cantidad --> la cantidad de productos.
*/
	public String cantidadProductosR(int claveTicket) throws SQLException, Exception {
		ResultSet rs = null;
		String ticket = "0";
		int suma = 0;
		boolean entro = false;
			con = new ConexionBD();
			if (con.miConnection != null) {
				try {
					String query = ("SELECT COUNT(numTicket) AS productos FROM contenidoTicket WHERE numTicket = "+claveTicket +" AND estatusTicket != 2 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
//					System.out.println(query);
					Statement stmt = con.miConnection.createStatement();
					rs = stmt.executeQuery(query);
					while(rs.next()){
						suma ++;
					}
					ticket = suma+"";
				}
				catch (SQLException sqle) {
					System.out.println("Error SQL clase ManagerPuntoVenta, metodo cantidadProductosR");
					sqle.printStackTrace();
				}
				catch (Exception q){
					q.printStackTrace();
					System.out.println("Error clase ManagerPuntoVenta, metodo cantidadProductosR");
				}
				finally{
					try{
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo cantidadProductosR");
						q.printStackTrace();
					}
				}
			}
		return ticket;
	}

/**
* El método sumaPagoProductos  nos informa el total a pagar por los productos que conforman nuestra lista
*@return String cantidad --> la cantidad a pagar.
*/
	public String sumaPagoProductos(int claveTicket) throws SQLException, Exception {
		ResultSet rs = null;
		String total = "0";
		boolean entro = false;
		con = new ConexionBD();
		if (con.miConnection != null) {
			con.cancelaAutoCommit();
			con.realizaCommit();
			con.habilitaAutoCommit();
			try {
				String query = ("SELECT SUM(precioAPagar) AS suma FROM contenidoticket WHERE numTicket = "+claveTicket +" AND estatusTicket = 0");
//				System.out.println(query);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					try{
						total = formatoDinero(acortaLongitud((rs.getDouble("suma")+"")));
					}
					catch (NullPointerException npe){
						total = "0.0";
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo sumaPagoProductos");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo sumaPagoProductos");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo sumaPagoProductos");
					q.printStackTrace();
				}
			}
		}
	return total;
	}

/**
* El método sumaPagoProductosR  nos informa el total a pagar por los productos que conforman nuestra lista reciclada
*@return String cantidad --> la cantidad a pagar.
*/
	public String sumaPagoProductosR(int claveTicket) throws SQLException, Exception {
		ResultSet rs = null;
		String total = "0";
		boolean entro = false;
		con = new ConexionBD();
		if (con.miConnection != null) {
			con.cancelaAutoCommit();
			con.realizaCommit();
			con.habilitaAutoCommit();
			try {
				String query = ("SELECT SUM(precioAPagar) AS suma FROM contenidoticket WHERE numTicket = "+claveTicket +" AND estatusTicket != 2");
//				System.out.println(query);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					try{
						total = formatoDinero(acortaLongitud((rs.getDouble("suma")+"")));
					}
					catch (NullPointerException npe){
						total = "0.0";
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo sumaPagoProductosR");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo sumaPagoProductosR");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo sumaPagoProductosR");
					q.printStackTrace();
				}
			}
		}
	return total;
	}

/**
* El método eliminaProducto se encarga de borrar de mi lista un producto seleccionado.
*@return int Exito en la transaccion, donde 0 --> falla SQL, 1 --> no hay ticket en proceso, 2 --> Exito.
*/
	public boolean eliminaProducto(int claveTicket, int id1, String id2, String id3) throws SQLException, Exception {
		ResultSet rs = null;
		int ID2 = 0;
		int ID3 = 0;
		boolean exito = true;
		con = new ConexionBD();
		if(id2.equalsIgnoreCase("Kilo")){
			ID2 = 1;
		}
		else if(id2.equalsIgnoreCase("Unidad")){
			ID2 = 2;
		}
		else if(id2.equalsIgnoreCase("Caja")){
			ID2 = 3;
		}
		else if(id2.equalsIgnoreCase("Pieza (Kg)")){
			ID2 = 4;
		}
		if(id3.equalsIgnoreCase("Menudeo")){
			ID3 = 0;
		}
		else if(id3.equalsIgnoreCase("M.Mayoreo")){
			ID3 = 1;
		}
		else if(id3.equalsIgnoreCase("Mayoreo")){
			ID3 = 2;
		}
		else if(id3.equalsIgnoreCase("Asignado")){
			ID3 = 3;
		}
		else if(id3.equalsIgnoreCase("Escalon")){
			ID3 = 7;
		}
		if (con.miConnection != null) {
			try {
				String queryString = "DELETE FROM contenidoticket WHERE numTicket= "+claveTicket +" AND ID_Pro = "+id1 +" AND tipoVenta = "+ID2+" AND tipoPrecio = " +ID3;
				Statement stmt = con.miConnection.createStatement();
				stmt = con.miConnection.createStatement();
				stmt.execute(queryString);
				stmt.close();
			}
			catch (SQLException sqle) {
				exito = false;
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo eliminaProducto");
				sqle.printStackTrace();
			}
			catch (Exception q){
				exito = false;
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo eliminaProducto");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo eliminaProducto");
					q.printStackTrace();
				}
			}
		}
		return exito;
	}

// --> 0 Falla SQL, 1 Exito, 2 Pides mas de existencia
	public synchronized int modificaContenido(int ID_Pro, String cantidad, double nuevaCantidad, String unidadP, String tipoPre, int claveTicket, double pesoDePiezas) throws SQLException, Exception{
		int exito = 1;
		int tipoVenta = 0;
		int tipoPrecio = 0;
		con = new ConexionBD();
		if(unidadP.equalsIgnoreCase("Kilo")){
			tipoVenta = 1;
		}
		else if(unidadP.equalsIgnoreCase("Unidad")){
			tipoVenta = 2;
		}
		else if(unidadP.equalsIgnoreCase("Caja")){
			tipoVenta = 3;
		}
		else if(unidadP.equalsIgnoreCase("Pieza (Kg)")){
			tipoVenta = 4;
		}
		if(tipoPre.equalsIgnoreCase("Menudeo")){
			tipoPrecio = 0;
		}
		else if(tipoPre.equalsIgnoreCase("M.Mayoreo")){
			tipoPrecio = 1;
		}
		else if(tipoPre.equalsIgnoreCase("Mayoreo")){
			tipoPrecio = 2;
		}
		else if(tipoPre.equalsIgnoreCase("Asignado")){
			tipoPrecio = 3;
		}
		else if(tipoPre.equalsIgnoreCase("Escalon")){
			tipoPrecio = 7;
		}
		con = new ConexionBD();
		if(con != null){
			try{
				// Averiguo si esta dado a credito.
				boolean esACredito = false;
				String query = "SELECT numTicket FROM creditos WHERE numTicket = "+claveTicket+" AND activo = 1 LIMIT 1";
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next( )){
					if(rs.getInt("numTicket") == claveTicket){
						esACredito = true;
					}
				}
				rs.close();
				stmt.close();
				// Averiguo si cubro el cambio de producto de acuerdo a lo que me pidieron:
				boolean sobrepasaExistencia = false;
				query = "SELECT invTienda, cantidadXCaja FROM productos WHERE ID_Pro = "+ID_Pro+" AND activo = 1";
				stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				double canti = nuevaCantidad;
				while (rs.next()){
					if(unidadP.equalsIgnoreCase("Caja")){
						canti = canti*rs.getDouble("cantidadXCaja");
					}
					if(tipoVenta == 4){
						if(pesoDePiezas >rs.getDouble("invTienda")){
							sobrepasaExistencia = true;
						}
					}
					else {
						if(canti > rs.getDouble("invTienda")){
							sobrepasaExistencia = true;
						}
					}
				}
				rs.close();
				stmt.close();
				if(sobrepasaExistencia){
					exito = 2;
				}
				// Elimino entrada previa y creo nueva Entrada.
				else{
					String fechaRegistro = "";
					String horaRegistro = "";
					int claveVendedor = 0;
					double precioVenta = 0.00;
					int estatusPago = 0;
					query = "SELECT * FROM contenidoTicket WHERE numTicket = "+claveTicket +" AND ID_Pro = "+ID_Pro+" AND tipoVenta = "+tipoVenta+" AND tipoPrecio = "+tipoPrecio +" AND estatusTicket != 2";
					stmt = con.creaStatement();
					rs = stmt.executeQuery(query);
					while(rs.next()){
						fechaRegistro = rs.getString("fechaRegistro");
						horaRegistro = rs.getString("horaRegistro");
						claveVendedor = rs.getInt("claveVendedor");
						precioVenta = rs.getDouble("precioVenta");
						estatusPago = rs.getInt("estatusPago");
					}
					rs.close();
					stmt.close();
					query = "DELETE FROM contenidoTicket WHERE numTicket = "+claveTicket +" AND ID_Pro = "+ID_Pro+" AND tipoVenta = "+tipoVenta+" AND tipoPrecio = "+tipoPrecio;
					stmt = con.creaStatement();
					stmt.execute(query);
					PreparedStatement updateContenidoTicket;
					updateContenidoTicket = con.miConnection.prepareStatement("insert into contenidoticket values(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
					updateContenidoTicket.setInt(1, claveTicket); // Consecutivo de Ticket
					updateContenidoTicket.setString(2, fechaRegistro); // fecha de Entrada
					updateContenidoTicket.setString(3, horaRegistro); // hora de Entrada
					updateContenidoTicket.setInt(4, ID_Pro); //ID_Pro
					updateContenidoTicket.setInt(5, claveVendedor); // Vendedor
					updateContenidoTicket.setInt(6, tipoVenta); // 1 Solo Kg,  2 Solo unidad,  3 Unidad y Caja, 4 Kg y Pieza
					updateContenidoTicket.setInt(7, tipoPrecio); // 0 --> Normal, 1--> GP1, 2--> GP2, 3--> GP3, 4--> GP4,  5--> GP5, 6--> GP6,  7--> Escalon
					updateContenidoTicket.setDouble(8, precioVenta);
					updateContenidoTicket.setDouble(9, nuevaCantidad);
					updateContenidoTicket.setDouble(10, pesoDePiezas);
					if(esACredito){
						updateContenidoTicket.setInt(11,2);
					}
					else{
						updateContenidoTicket.setInt(11,0);
					}
					if(tipoVenta == 4){
						updateContenidoTicket.setDouble(12, precioVenta*pesoDePiezas); // CANTIDAD A PAGAR
					}
					else{
						updateContenidoTicket.setDouble(12, precioVenta*nuevaCantidad); // CANTIDAD A PAGAR
					}
					updateContenidoTicket.setInt(13, 1); // Estatus Ticket
					updateContenidoTicket.setNull(14,java.sql.Types.DATE);
					updateContenidoTicket.execute();
					updateContenidoTicket.close();
				}
			}
			catch (SQLException sqle) {
				exito = 0;
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo modificaContenido");
				sqle.printStackTrace();
			}
			catch (Exception q){
				exito = 0;
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo modificaContenido");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo modificaContenido");
					q.printStackTrace();
				}
			}
		}
		else{
			exito = 0;
		}
		return exito;
	}

/**
* El método cierraCuenta se encarga de cambiar el estado del ticket a cerrado y guardar si el ticket esta ligado a un cliente en especifico
*@return int Exito en la transaccion, donde true --> todo bien, false --> error en el proceso.
*/
	public synchronized boolean cierraCuenta(int claveTicket, String rfc, String nombreCliente, int claveVendedor) throws SQLException, Exception {
		ResultSet rs = null;
		boolean exito = true;
		con = new ConexionBD();
		ts = new TimeStamp();
		if (con != null) {
			try {
				con.cancelaAutoCommit();
				if(rfc.trim().length() == 0){ // Ticket de Venta normal
					String queryString = "UPDATE contenidoticket SET estatusTicket = 1  WHERE numTicket = " +claveTicket  +" AND estatusTicket = 0";
					Statement stmt = con.creaStatement();
					stmt.execute(queryString);
					stmt.close();
				}
				else { // Ticket de Remision
					String queryString = "UPDATE contenidoticket SET estatusTicket = 1, estatusPago = 2  WHERE numTicket = " +claveTicket  +" AND estatusPago = 0 AND estatusTicket = 0";
					Statement stmt = con.creaStatement();
					stmt.execute(queryString);
					stmt.close();
					// Guardo entrada de Ticket ligado desde punto de venta....
					ts = new TimeStamp();
					PreparedStatement updatTicketLigado;
					updatTicketLigado = con.miConnection.prepareStatement("INSERT INTO ticket_ligado VALUES(?,?,?,?,?,?,?);");
					updatTicketLigado.setNull(1, java.sql.Types.INTEGER); //ID automatico
					updatTicketLigado.setInt(2, claveTicket); // ID_Ticket
					updatTicketLigado.setDate(3, cambiaADate(ts.date)); // fecha del Ticket
					updatTicketLigado.setString(4, rfc); // RFC cliente
					updatTicketLigado.setString(5, nombreCliente); // Nombre del Cliente
					updatTicketLigado.setInt(6, claveVendedor); // el Vendedor
					updatTicketLigado.setInt(7, 0); // Estatus
					updatTicketLigado.execute();
					updatTicketLigado.close();
					// Obtengo tiempo de credito del cliente
					String diasAPagarL = "0";
					String fechaPago = "";
					queryString = "SELECT tiempoCredito FROM clientes WHERE rfc = '"+rfc +"' AND nombre = '"+nombreCliente +"' AND activo = 1 AND tipoCliente = 1 LIMIT 1";
					stmt = con.creaStatement();
					rs = stmt.executeQuery(queryString);
					while(rs.next()){
						diasAPagarL = rs.getString("tiempoCredito");
					}
					rs.close();
					stmt.close();
					// Obtengo monto total de ticket.
					String pago = "0.00";
					queryString = "SELECT SUM(precioAPagar)AS precioAPagar FROM contenidoticket WHERE numTicket = "+claveTicket+" AND estatusTicket = 1";
					stmt = con.creaStatement();
					rs = stmt.executeQuery(queryString);
					while(rs.next()){
						pago = rs.getString("precioAPagar");
					}
					rs.close();
					stmt.close();
					// Guardo entrada en tabla de Credito.
					CalculaDate cd = new CalculaDate();
					cd.parseaADate(ts.date);
					cd.setNuevaFecha(cambiaAInt(diasAPagarL));
					fechaPago = cd.obtenDatos();
					PreparedStatement updateTablaCredito;
					updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
					updateTablaCredito.setInt(1, claveTicket);
					updateTablaCredito.setDate(2, cambiaADate(ts.date));
					updateTablaCredito.setDate(3, cambiaADate(fechaPago));
					updateTablaCredito.setString(4, rfc);
					updateTablaCredito.setString(5, nombreCliente);
					updateTablaCredito.setDouble(6, cambiaADouble(pago));
					updateTablaCredito.setInt(7, 0);
					updateTablaCredito.setInt(8,0 );
					updateTablaCredito.setString(9, "");
					updateTablaCredito.setString(10, claveVendedor+"");
					updateTablaCredito.setNull(11, java.sql.Types.DATE);
					updateTablaCredito.setString(12, "");
					updateTablaCredito.setInt(13, 0);
					updateTablaCredito.setInt(14, 1);
					updateTablaCredito.execute();
					//Asigno saldo de credito a cliente
					PreparedStatement updateCreditoCliente;
					updateCreditoCliente = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo-?) WHERE rfc = ? AND nombre = ? AND activo  =  ?");
					updateCreditoCliente.setDouble(1, cambiaADouble(pago)); // Monto dada originalmente a credito
					updateCreditoCliente.setString(2, rfc);
					updateCreditoCliente.setString(3, nombreCliente);
					updateCreditoCliente.setInt(4, 1);
					updateCreditoCliente.execute();
					updateCreditoCliente.close();
					// Descuento de inventario
// FINALMENTE DESCUENTO DE MI INVENTARIO
					queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
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
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				exito = false;
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo cierraCuenta");
				sqle.printStackTrace();
			}
			catch (Exception q){
				exito = false;
				con.realizaRollback();
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo cierraCuenta");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo cierraCuenta");
					q.printStackTrace();
				}
			}
		}
		else{
			exito = false;
		}
		return exito;
	}

	public synchronized boolean reingresaInventario(int claveTicket)throws SQLException, Exception{
		boolean exito = true;
		con = new ConexionBD();
		if(con != null){
			try{
				con.cancelaAutoCommit();
				// Averiguo si es a credito, si es asi entonces si descuento...
				boolean esACredito = false;
				String query = "SELECT numTicket FROM creditos WHERE numTicket = "+claveTicket +" AND activo = 1 LIMIT 1";
				Statement st = con.creaStatement();
				ResultSet rs2 = st.executeQuery(query);
				while(rs2.next()){
					if(rs2.getInt("numTicket") == claveTicket){
						esACredito = true;
					}
				}
				rs2.close();
				st.close();
				if(esACredito){
					String queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
					Statement stmt= con.creaStatement();
					ResultSet rs = stmt.executeQuery(queryString);
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
					rs.close();
					stmt.close();
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				exito = false;
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo reingresaInventario");
				sqle.printStackTrace();
			}
			catch (Exception q){
				con.realizaRollback();
				exito = false;
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo reingresaInventario");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo reingresaInventario");
					q.printStackTrace();
				}
			}
		}
		else{
			exito = false;
		}
		return exito;
	}



/**
* El método cierraCuenta se encarga de cambiar el estado del ticket a cerrado y guardar si el ticket esta ligado a un cliente en especifico
*@return int Exito en la transaccion, donde true --> todo bien, false --> error en el proceso.
*/
	public synchronized boolean modificaCuenta(int claveTicket, String rfc, String nombreCliente) throws SQLException, Exception {
		ResultSet rs = null;
		boolean exito = true;
		con = new ConexionBD();
		ts = new TimeStamp();
		int ID_LigaPrevio = 0;
		String rfcPrevio = "";
		String nombrePrevio = "";
		String pago = "0.00";
		boolean previoCredito = false;
		if (con != null) {
			try {
				con.cancelaAutoCommit();
				// Primero averiguo como estaba previamente este ticket para realizar los ajustes oportunos.....
				// Obtengo el nombre del vendedor original así como averiguar si existe una credito previo....
				int claveVendedor = 0;
				String query = "SELECT claveVendedor, ID_Liga, rfc, nombre FROM ticket_ligado WHERE numTicket = "+claveTicket;
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					previoCredito = true;
					claveVendedor = rs.getInt("claveVendedor");
					ID_LigaPrevio = rs.getInt("ID_Liga");
					rfcPrevio = rs.getString("rfc");
					nombrePrevio = rs.getString("nombre");
				}
				rs.close();
				stmt.close();
				// Si no obtuve clave de vendedor la obtendo de la tabla contenidoTicket
				if(claveVendedor == 0){
					query = "SELECT claveVendedor FROM contenidoTicket WHERE numTicket = "+claveTicket +" AND estatusTicket != 2 LIMIT 1";
					stmt = con.creaStatement();
					rs= stmt.executeQuery(query);
					while(rs.next()){
						claveVendedor = rs.getInt("claveVendedor");
					}
					rs.close();
					stmt.close();
				}
				// Obtengo monto total de ticket.
				query = "SELECT SUM(precioAPagar)AS precioAPagar FROM contenidoticket WHERE numTicket = "+claveTicket+" AND estatusTicket = 1";
				stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					if(rs.getString("precioAPagar") != null){
						pago = rs.getString("precioAPagar");
					}
				}
				rs.close();
				stmt.close();
				// Estaba dado a credito previamente...
				if(previoCredito){
					// Elimino TicketLigado Previo
					query = "DELETE FROM  ticket_ligado  WHERE numTicket = "+claveTicket;
					stmt = con.creaStatement();
					stmt.execute(query);
					// Elimino entrada a Credito
					query = "DELETE FROM creditos WHERE  numTicket = "+claveTicket +" AND activo = 1";
					stmt = con.creaStatement();
					stmt.execute(query);
					if(cambiaADouble(pago) > 0.00){
						// Descuento credito a Cliente....
						PreparedStatement updateCreditoCliente;
						updateCreditoCliente = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo+?) WHERE rfc = ? AND nombre = ? AND activo  =  ?");
						updateCreditoCliente.setDouble(1, cambiaADouble(pago)); // Monto dada originalmente a credito
						updateCreditoCliente.setString(2, rfcPrevio);
						updateCreditoCliente.setString(3, nombrePrevio);
						updateCreditoCliente.setInt(4, 1);
						updateCreditoCliente.execute();
						updateCreditoCliente.close();
					}
					PreparedStatement updateTablaContenidoTicket;
					updateTablaContenidoTicket = con.miConnection.prepareStatement("UPDATE contenidoticket SET estatusPago = ?  WHERE numTicket = ?  AND estatusTicket = ?");
					updateTablaContenidoTicket.setInt(1, 0);
					updateTablaContenidoTicket.setInt(2, claveTicket);
					updateTablaContenidoTicket.setInt(3, 1);
					updateTablaContenidoTicket.execute();
					updateTablaContenidoTicket.close();
				}
				// El ticket de es por remision....
				if(rfc.trim().length() > 0){ // Ticket de Venta por Remision
					//Asigno saldo de credito a cliente
					PreparedStatement updateCreditoCliente;
					updateCreditoCliente = con.miConnection.prepareStatement("UPDATE clientes SET saldo = (saldo-?) WHERE rfc = ? AND nombre = ? AND activo  =  ?");
					updateCreditoCliente.setDouble(1, cambiaADouble(pago)); // Monto dada originalmente a credito
					updateCreditoCliente.setString(2, rfc);
					updateCreditoCliente.setString(3, nombreCliente);
					updateCreditoCliente.setInt(4, 1);
					updateCreditoCliente.execute();
					updateCreditoCliente.close();
					// Guardo entrada de Ticket ligado desde punto de venta....
					ts = new TimeStamp();
					PreparedStatement updatTicketLigado;
					updatTicketLigado = con.miConnection.prepareStatement("INSERT INTO ticket_ligado VALUES(?,?,?,?,?,?,?);");
					if(ID_LigaPrevio == 0){
						updatTicketLigado.setNull(1,java.sql.Types.INTEGER);
					}
					else{
						updatTicketLigado.setInt(1, ID_LigaPrevio); //ID automatico
					}
					updatTicketLigado.setInt(2, claveTicket); // ID_Ticket
					updatTicketLigado.setDate(3, cambiaADate(ts.date)); // fecha del Ticket
					updatTicketLigado.setString(4, rfc); // RFC cliente
					updatTicketLigado.setString(5, nombreCliente); // Nombre del Cliente
					updatTicketLigado.setInt(6, claveVendedor); // el Vendedor
					updatTicketLigado.setInt(7, 0); // Estatus
					updatTicketLigado.execute();
					updatTicketLigado.close();
					// Obtengo tiempo de credito del cliente
					String diasAPagarL = "0";
					String fechaPago = "";
					query = "SELECT tiempoCredito FROM clientes WHERE rfc = '"+rfc +"' AND nombre = '"+nombreCliente +"' AND activo = 1 AND tipoCliente = 1 LIMIT 1";
					stmt = con.creaStatement();
					rs = stmt.executeQuery(query);
					while(rs.next()){
						diasAPagarL = rs.getString("tiempoCredito");
					}
					rs.close();
					stmt.close();
					// Guardo entrada en tabla de Credito siempre y cuando haya productos..
					CalculaDate cd = new CalculaDate();
					cd.parseaADate(ts.date);
					cd.setNuevaFecha(cambiaAInt(diasAPagarL));
					fechaPago = cd.obtenDatos();
					PreparedStatement updateTablaCredito;
					updateTablaCredito = con.miConnection.prepareStatement("INSERT INTO creditos VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
					updateTablaCredito.setInt(1, claveTicket);
					updateTablaCredito.setDate(2, cambiaADate(ts.date));
					updateTablaCredito.setDate(3, cambiaADate(fechaPago));
					updateTablaCredito.setString(4, rfc);
					updateTablaCredito.setString(5, nombreCliente);
					updateTablaCredito.setDouble(6, cambiaADouble(pago));
					updateTablaCredito.setInt(7, 0);
					updateTablaCredito.setInt(8,0 );
					updateTablaCredito.setString(9, "");
					updateTablaCredito.setString(10, claveVendedor+"");
					updateTablaCredito.setNull(11, java.sql.Types.DATE);
					updateTablaCredito.setString(12, "");
					updateTablaCredito.setInt(13, 0);
					updateTablaCredito.setInt(14, 1);
					updateTablaCredito.execute();
					updateTablaCredito.close();
					// Actualizo la Tabla ContenidoTicket
					PreparedStatement updateTablaContenidoTicket;
					updateTablaContenidoTicket = con.miConnection.prepareStatement("UPDATE contenidoticket SET estatusPago = ?  WHERE numTicket = ?  AND estatusTicket = ?");
					updateTablaContenidoTicket.setInt(1, 2);
					updateTablaContenidoTicket.setInt(2, claveTicket);
					updateTablaContenidoTicket.setInt(3, 1);
					updateTablaContenidoTicket.execute();
					updateTablaContenidoTicket.close();
					// Descuento de inventario
// FINALMENTE DESCUENTO DE MI INVENTARIO
					query= ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
					stmt= con.creaStatement();
					rs = stmt.executeQuery(query);
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
							updateInventario.close();
						}
						else if(tipoVenta == 3){ // Caja
							PreparedStatement updateInventario;
							updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - (?*cantidadXCaja)) WHERE ID_Pro = ? AND activo = ?");
							updateInventario.setDouble(1, laCantidad); // Cantidad
							updateInventario.setInt(2, ID_Pro); // Identificador Producto
							updateInventario.setInt(3, 1); // Activo
							updateInventario.execute();
							updateInventario.close();
						}
						else if(tipoVenta ==4){ // Pieza
							PreparedStatement updateInventario;
							updateInventario = con.miConnection.prepareStatement("UPDATE productos SET invTienda = (invTienda - ? ) WHERE ID_Pro = ? AND activo = ?");
							updateInventario.setDouble(1, losKgEnPz); // Los Kg en la Pz
							updateInventario.setInt(2, ID_Pro); // Identificador Producto
							updateInventario.setInt(3, 1); // Activo
							updateInventario.execute();
							updateInventario.close();
						}
					}
					rs.close();
					stmt.close();
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				exito = false;
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo modificaCuenta");
				sqle.printStackTrace();
			}
			catch (Exception q){
				exito = false;
				con.realizaRollback();
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo modificaCuenta");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo modificaCuenta");
					q.printStackTrace();
				}
			}
		}
		else{
			exito = false;
		}
		return exito;
	}

/**
* El método dameAutorizacionUser nos devuelve un booleano indicandonos si el usuario puede cobrar directamente la cuenta.
*@return boolean nombre --> el nombre del tendero
*/
	public boolean dameAutorizacionUser(int claveDelUsuario) throws SQLException, Exception {
		ResultSet rs = null;
		boolean permiso = false;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				String query = ("SELECT permisoCobro FROM vendedores WHERE claveVenta = "+claveDelUsuario +" AND estatus = 1 ");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					if(rs.getInt("permisoCobro") == 1){
						permiso = true;
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo dameAutorizacionUser");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo dameAutorizacionUser");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo dameAutorizacionUser");
					q.printStackTrace();
				}
			}
		}
		return permiso;
	}

/**
* El método dameNombreTendero nos devuelve el nombre del empleado que nos realizó la cuenta
*@return String nombre --> el nombre del tendero
*/
	public String dameNombreTendero(int claveTicket) throws SQLException, Exception {
		ResultSet rs = null;
		String nombre = "";
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				String query = ("SELECT vendedores.nombreE FROM vendedores, contenidoTicket  WHERE contenidoTicket.numTicket = "+claveTicket +" AND  vendedores.claveVenta = contenidoTicket.claveVendedor  AND vendedores.estatus = 1 ");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					nombre = rs.getString("nombreE");
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo dameNombreTendero");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo dameNombreTendero");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo dameNombreTendero");
					q.printStackTrace();
				}
			}
		}
		return nombre;
	}

/**
* El método dameFraseActual nos devuelve la frase que será impresa en el ticket de venta.
*@return String nombre --> el nombre del tendero
*/
	public String dameFraseActual() throws SQLException, Exception {
		ResultSet rs = null;
		String frase = "";
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				String query = ("SELECT frase FROM avisos WHERE activo = 1");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					frase = rs.getString("frase");
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo dameFraseActual");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo dameFraseActual");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo dameFraseActual");
					q.printStackTrace();
				}
			}
		}
		return frase;
	}

	public void ImprimeTicketACobrar(int claveTicket, String identificador, int claveU) throws Exception{
		boolean esRemision = false;
		con = new ConexionBD();
		if (con != null) {
			try{
				String queryEsRemision = "SELECT numTicket FROM ticket_ligado WHERE numTicket = "+claveTicket+" AND estatus != 3 LIMIT 1";
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(queryEsRemision);
				while (rs.next()){
					if(rs.getInt("numTicket") == claveTicket){
						esRemision = true;
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle){
				sqle.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch(Exception q){
					q.printStackTrace();
				}
			}
		}
		try{
			if(!esRemision){
				ImpresionTicket it = new ImpresionTicket(claveTicket, identificador, claveU);
			}
			else{
				ImpresionTicketRem it = new ImpresionTicketRem(claveTicket, identificador, claveU);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void ImprimeTicketACobrarRem(int claveTicket, String identificador, int claveU) throws Exception{
		try{
			ImpresionTicketRem it = new ImpresionTicketRem(claveTicket, identificador, claveU);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}


/**
* El método sumaPagoProductosFin  nos informa el total a pagar por los productos que conforman nuestra lista ya cerrada
*@return String cantidad --> la cantidad a pagar.
*/
	public String sumaPagoProductosFin(int claveTicket) throws SQLException, Exception {
		ResultSet rs = null;
		String total = "0";
		boolean entro = false;
		con2 = new ConexionBD();
		if (con2.miConnection != null) {
			try {
				String query = ("SELECT SUM(precioAPagar) AS suma FROM contenidoticket WHERE numTicket = "+claveTicket +" AND estatusTicket = 1");
//				System.out.println(query);
				Statement stmt = con2.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					try{
						total = formatoDinero(acortaLongitud((rs.getDouble("suma")+"")));
					}
					catch (NullPointerException npe){
						total = "0.0";
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo sumaPagoProductosFin");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo sumaPagoProductosFin");
			}
			finally{
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo sumaPagoProductosFin");
					q.printStackTrace();
				}
			}
		}
	return total;
	}


/**
* El método dameNombreTendero nos devuelve el nombre del empleado que nos realizó la cuenta
*@return String nombre --> el nombre del tendero
*/
	public String dameNombreVendedor(int claveUsuario) throws SQLException, Exception {
		ResultSet rs = null;
		String nombre = "";
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				String query = ("SELECT nombreE FROM vendedores WHERE claveVenta = "+claveUsuario +" AND estatus = 1 ");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					nombre = rs.getString("nombreE");
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo dameNombreTendero");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo dameNombreTendero");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo dameNombreTendero");
					q.printStackTrace();
				}
			}
		}
		return nombre;
	}

/**
* El método confirmaContra nos devuelve un booleano indicandonos si concuerda la contraseña para el usuario especificado
*@return boolean nombre --> el nombre del tendero
*/
	public boolean confirmaContra(String contraDelUsuario, int claveU) throws SQLException, Exception {
		ResultSet rs = null;
		int userPass = cambiaAInt(contraDelUsuario);
		boolean permiso = false;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				String query = ("SELECT clavePermiso FROM vendedores WHERE claveVenta = "+claveU +" AND estatus = 1 ");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					if(rs.getInt("clavePermiso") == userPass){
						permiso = true;
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo confirmaContra");
				sqle.printStackTrace();
			}
			catch (Exception q){
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo confirmaContra");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo confirmaContra");
					q.printStackTrace();
				}
			}
		}
		return permiso;
	}


/**
* El método procesaPagoDescuento se encarga de modificar los precios registrados para una linea de acuerdo a un proveedor
*@return int Exito en la transaccion, donde true --> todo bien, false --> error en el proceso.
*/
	public synchronized Vector<String> procesaPagoDescuento(int claveTicket, int claveU) throws SQLException, Exception {
		ResultSet rs = null;
		ResultSet rs2 = null;
		int cantidadPorCaja = 0;
		double kilosEnPz = 0.00;
		con = new ConexionBD();
		ts = new TimeStamp();
		Vector <String> resultado = new Vector<String>();
		if (con.miConnection != null) {
			try {
				con.cancelaAutoCommit();
	// ANTES QUE NADA VERIFICO QUE AUN TENGA EN EXISTENCIA LOS PRODUCTOS QUE ESTOY VENDIENDO
				rs = null;
				String query = "SELECT SUM(Suma) AS Suma, ID_Pro FROM (SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoticket.TipoVenta = 1 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket, productos WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoticket.TipoVenta = 2 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.cantidadProducto*productos.cantidadXCaja) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM  contenidoticket, productos WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoticket.TipoVenta = 3 AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta UNION ALL SELECT SUM(contenidoticket.pesoEnPz) AS Suma, contenidoticket.ID_Pro, contenidoticket.tipoVenta FROM contenidoticket WHERE contenidoticket.numTicket = "+claveTicket + " AND contenidoticket.TipoVenta = 4 AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.ID_Pro, contenidoticket.tipoVenta) as kiko GROUP BY ID_Pro";
				Statement stmt =  con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					boolean faltaProducto = false;
					String complemento = "";
					String existenciaQ = "SELECT invTienda, tipoPro FROM productos WHERE ID_Pro = "+rs.getInt("ID_Pro");
					Statement stmt2 = con.miConnection.createStatement();
					rs2 = stmt2.executeQuery(existenciaQ);
					while (rs2.next()){
						if(rs2.getDouble("invTienda") < rs.getDouble("Suma")){
							faltaProducto = true;
							if(rs2.getInt("tipoPro") == 0){
								complemento = rs.getDouble("Suma")+" Unidades. y solo hay "+rs2.getDouble("invTienda")+" Unidades. en invTienda, aumenta tu inventario o reinicia el cierre de este Ticket";
							}
							else{
								complemento = rs.getDouble("Suma")+" Kg. y solo hay "+rs2.getDouble("invTienda")+" Kg. en invTienda, aumenta tu inventario o  reinicia el cierre de este Ticket";
							}
						}
						if(faltaProducto) {
							Statement stmt3 = con.miConnection.createStatement();
							ResultSet rs3 = stmt3.executeQuery("SELECT descripcion FROM productos WHERE ID_Pro = "+rs.getInt("ID_Pro") +" AND activo = 1");
							while (rs3.next()){
								resultado.addElement("No puedo finalizar tu venta ya que del producto:  "+rs3.getString("descripcion")+" ("+rs.getInt("ID_Pro")+	")  \n solicitas "+complemento);
							}
							rs3.close();
							stmt3.close();
						}
					}
				}
				if(resultado.size() > 0){
					String queryString = "UPDATE contenidoticket SET estatusTicket = 0  WHERE numTicket = "+(claveTicket) +" AND estatusTicket = 1";
					stmt.execute(queryString);
					stmt.close();
				}
				else {
					resultado.addElement("Exito");
					stmt = con.creaStatement();
					// SI NO FALTA PRODUCTO ENTONCES  PRIMERO CAMBIO MI ESTATUS DEL TICKET A YA PAGADO ASI COMO LA FECHA DE PAGO A HOY!.
					String queryString = "UPDATE contenidoticket SET estatusPago = 1, fechaRealPago = '"+ts.date +"' WHERE numTicket = "+(claveTicket) +" AND fechaRegistro = '" +ts.date +"' AND estatusTicket = 1";
					stmt.execute(queryString);
					stmt.close();
					// SEGUNDO GUARDO ENTRADA EN TABLA SALIDAS
					PreparedStatement updateTablaSalida;
					updateTablaSalida = con.miConnection.prepareStatement("INSERT INTO salidas VALUES(?,?,?,?,?,?,?,?,?);");
					updateTablaSalida.setInt(1, claveTicket); // ID
					updateTablaSalida.setDate(2, cambiaADate(ts.date)); // fecha del Ticket
					updateTablaSalida.setString(3, ts.time); // hora de Ticket
					updateTablaSalida.setDouble(4, cambiaADouble(sumaPagoProductosFin(claveTicket))); // Total del Ticket
					updateTablaSalida.setInt(5, 0); // Sin facturar
					updateTablaSalida.setInt(6, 1); // Es efectivo
					updateTablaSalida.setString(7, ""); // Referencia
					updateTablaSalida.setString(8, claveU+""); // Clave de Vendedor
					updateTablaSalida.setInt(9, 1); // Activo
					updateTablaSalida.execute();
					// TERCERO DESCUENTO DE MIS INVENTARIOS.
					queryString = ("SELECT contenidoTicket.ID_Pro, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, SUM(contenidoticket.pesoEnPz) AS pesoEnPz,  contenidoTicket.tipoVenta  FROM contenidoTicket  WHERE contenidoticket.numTicket = "+claveTicket +" AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio");
					stmt = con.miConnection.createStatement();
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
					}// CIERRO WHILE
				}
				con.realizaCommit();
			}// CIERRO TRY
			catch (SQLException sqle) {
				resultado = new Vector<String>();
				resultado.addElement("Error");
				con.realizaRollback();
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo procesaPagoDescuento");
				sqle.printStackTrace();
			}
			catch (Exception q){
				resultado = new Vector<String>();
				resultado.addElement("Error");
				con.realizaRollback();
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo procesaPagoDescuento");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo procesaPagoDescuento");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}


	public void ImprimeTicketDirecto(int claveTicket, String identificador, int claveU, String elPago, String elCambio) throws Exception{
		try{
			ImpresionTicketD it = new ImpresionTicketD(claveTicket, identificador, claveU, elPago, elCambio);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

// x>0 --> El numero del ticket, 0 --> No hay, -1 --> Excepcion, -2 --> Ya Pagado,  -3 --> Otro en proceso.
	public int dameTicketRePrint(int claveU) throws SQLException, Exception{
		ResultSet rs = null;
		int codigoTIK = 0;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				String query = ("SELECT MAX(numTicket) AS ticket, estatusPago, estatusTicket FROM contenidoTicket WHERE claveVendedor = "+claveU+" GROUP BY numTicket");
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()){
					if(rs.getInt("estatusPago") == 1){
						codigoTIK = -2;
					}
					else if(rs.getInt("estatusTicket") == 0){
						codigoTIK = -3;
					}
					else{
						codigoTIK = rs.getInt("ticket");
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				codigoTIK = -1;
				System.out.println("Error SQL clase ManagerPuntoVenta, metodo dameTicketRePrint");
				sqle.printStackTrace();
			}
			catch (Exception q){
				codigoTIK = -1;
				q.printStackTrace();
				System.out.println("Error clase ManagerPuntoVenta, metodo dameTicketRePrint");
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo dameTicketRePrint");
					q.printStackTrace();
				}
			}
		}
		return codigoTIK;
	}

// GENERICAS:

// Metodo protegido me regresa la cantidad de renglones dentro de un resultSet
	protected int getResultSetSize(ResultSet resultSet) {
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


	public String completaString(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 6 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}

	public String completaStringTicket(String aCompletar) throws Exception{
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

	public String completaStringTipoPLU(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 2 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
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


	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}



	public String formatoCortoDinero(String enteros) throws Exception{
		StringBuilder sb1 = new StringBuilder (enteros);
		if(sb1.indexOf(".") != -1){
			sb1=sb1.delete(sb1.indexOf("."),sb1.length() );
		}
		boolean aumentaEnteros = false;
		StringBuilder sb = new StringBuilder (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			existieron = true;
			sb=sb.delete(0, sb.indexOf(".")+1);
			if(sb.length() == 1){
				sb.append("0");
			}
			else if(sb.length()>2){
				int primero = cambiaAInt(sb.substring(0,1));
				int anterior = cambiaAInt(sb.substring(1,2));
				int posterior = cambiaAInt(sb.substring(2,3));
				if(posterior >= 5){
					anterior +=1;
					if(anterior == 10){
						anterior = 0;
						primero +=1;
						if(primero == 10){
							primero = 0;
							aumentaEnteros = true;
						}
					}
					sb = new StringBuilder(primero+""+anterior+"");
				}
				else{
					sb = new StringBuilder(primero+""+anterior+"");
				}
			}
		}
		if (!existieron){
			sb = new StringBuilder ("00");
		}
		if(aumentaEnteros){
			int enteros2 = cambiaAInt(sb1.toString());
			enteros2 +=1;
			sb1 = new StringBuilder(enteros2+"");
		}
		return sb1.toString()+"."+sb.toString();
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

	private String checkSize (String revisa){
		StringBuilder verificador = new StringBuilder(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}

	protected String formatoEspaciado(String cantidad) throws Exception{
		int tamanioCantidad = cantidad.length();
		while (tamanioCantidad < 10 ){
			cantidad = "  "+cantidad;
			tamanioCantidad++;
		}
		StringBuilder sb = new StringBuilder(cantidad);
		int contadorUnos = 0;
		while (sb.indexOf("1") != -1){
			sb.replace(sb.indexOf("1"), (sb.indexOf("1")+1),"*");
			contadorUnos ++;
		}
		while (sb.indexOf("*") != -1){
			sb.replace(sb.indexOf("*"), (sb.indexOf("*")+1),"1");
		}
		while (contadorUnos > 0){
			cantidad = " "+cantidad;
			contadorUnos --;
		}
		return cantidad;
	}

	protected String formatoEspaciado2(String cantidad) throws Exception{
		int tamanioCantidad = cantidad.length();
		while (tamanioCantidad < 10 ){
			cantidad = "  "+cantidad;
			tamanioCantidad++;
		}
		return cantidad;
	}

	public static String codifica (String src) throws UnsupportedEncodingException{
      String cody=java.net.URLEncoder.encode(src, "UTF-8");
      return cody;
	}



	public static String decodifica (String src) throws UnsupportedEncodingException{
		String decody;
		URLDecoder decoder = new URLDecoder();
		decody=decoder.decode(src, "UTF-8");
		return decody;
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

// Funcion generica que regresa un objeto Calendar a partir de un String tipo Fecha.(aaaa-mm-dd)
	public Calendar formatoCalendar(String formato) throws Exception{
		int anio =  Integer.parseInt(formato.substring(0,formato.indexOf("-")));
		int mes = Integer.parseInt(formato.substring((formato.indexOf("-")+1), formato.lastIndexOf("-")));
		int dia = Integer.parseInt(formato.substring((formato.lastIndexOf("-")+1), formato.length()));
		Calendar temporal = Calendar.getInstance();
		temporal.clear();
		temporal.set(anio, mes-1, dia);
		return temporal;
	}

	protected String FixCriterio (String criterio){
		StringBuilder sb = new StringBuilder (criterio);
		while (sb.indexOf(" ") != -1){
			int tempis = sb.indexOf(" ");
			sb.deleteCharAt(tempis);
			sb.insert(tempis,"%'*AND*descripcion*LIKE*'%");
		}
		return sb.toString().replace('*', ' ');
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


	public Time cambiaATiempo(String tiempo) {
		java.sql.Time elTiempo;
		try {
			elTiempo = java.sql.Time.valueOf(new String(tiempo));
		}
		catch(IllegalArgumentException iae){
			elTiempo = java.sql.Time.valueOf(new String("12:00:00"));
		}
		return elTiempo;
	}

}