package com.alpha.bd;

import java.sql.SQLException;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Vector;


public class ManagerProductos {

	private ConexionBD con = null;

	public ManagerProductos()   { }


		// Métodos Revisados


///////////////////////////////////
    ///////////////////////
        ////////////
          /////
		   //
	// Métodos Sin revisar



// Esta funcion se emplea para adquirir el nombre del articulo.
	public String nombreArticulo(String PLU) throws SQLException, Exception {
		ResultSet rs = null;
		String nombre = null;
		try {
			String queryString = ("SELECT textoArticulo FROM productos WHERE PLU = '" +PLU +"' AND ACTIVO = 1" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				nombre = rs.getString(1);
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
		return nombre;
	}

// Esta funcion se emplea para adquirir el tipo del articulo.
	public String clasePLU(String PLU) throws SQLException, Exception {
		ResultSet rs = null;
		String nombre = null;
		try {
			String queryString = ("SELECT clasePLU FROM productos WHERE PLU = '" +PLU +"' AND ACTIVO = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				nombre = rs.getString(1);
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta clasePLU.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraia la clase de PLU."+e;
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
		return nombre;
	}

// Se emplea para saber si un producto agrava IVA
	public boolean productoAgrava(String PLU) throws SQLException, Exception {
		boolean bandera= false;
		ResultSet rs = null;
		String obj = null;
		try  {
			String queryString = ("SELECT gravaIVA FROM productos WHERE PLU = '"+PLU +"' AND ACTIVO = 1" );
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
					obj = rs.getString(1);
			}
			if(obj.equals("1")){
				bandera = true;
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta datosTicketVenta.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraian los datos de datosTicketVenta."+e;
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
		return bandera;
	}


// Con esta funcion lleno mi tabla productos a partir de la tabla de la bascula PLST
	public boolean addDatosProducto(String plu, String subDepto, double precioBase1, double precioG1,
	double precioG2, double precioG3, String diasConserva, String basePrecio, String cantidadXPaquete, String clasePLU, String tipoPrecio, String textoArticulo, String pesoFijo){
		boolean salida = true;
		try{
			con = new ConexionBD();
			if (con.miConnection != null) {
				PreparedStatement updateTablaProductos;
				updateTablaProductos = con.miConnection.prepareStatement(	"INSERT INTO productos 	VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
				updateTablaProductos.setString(1, plu);
				updateTablaProductos.setString(2, subDepto);
				updateTablaProductos.setDouble(3, precioBase1);
				updateTablaProductos.setDouble(4, precioG1 );
				updateTablaProductos.setDouble(5, precioG2 );
				updateTablaProductos.setDouble(6, precioG3 );
				updateTablaProductos.setString(7, diasConserva );
				updateTablaProductos.setString(8, basePrecio);
				updateTablaProductos.setString(9, cantidadXPaquete);
				updateTablaProductos.setString(10, clasePLU);
				updateTablaProductos.setString(11, tipoPrecio);
				updateTablaProductos.setString(12, textoArticulo);
				updateTablaProductos.setString(13, pesoFijo);
				updateTablaProductos.setInt(14, 0 );
				if(clasePLU.equals("00")){
					updateTablaProductos.setString(15, "0");
					updateTablaProductos.setString(16, "NO");
				}
				else{
					updateTablaProductos.setString(15, "NO");
					updateTablaProductos.setString(16, "0");
				}
				updateTablaProductos.setInt(17, 1 );
				updateTablaProductos.execute();
				salida=false;
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL dentro de ManagerProductos metodo addDatosProducto");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Error! Excepcion dentro de ManagerProductos metodo addDatosProducto");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de InsercionesBD metodo addDatosProducto");
					q.printStackTrace();
				}
			}
		}
		return salida;
	}


// Esta funcion se emplea para la cantidad o peso a disminuir del producto
	public String descuentaCantidad(String PLU, String clasePLU) throws SQLException, Exception {
		ResultSet rs = null;
		String nombre = null;
		String complemento = new String("cantidad");
		if (clasePLU.equals("00")){
			complemento = "peso";
		}
		try {
			String queryString = ("SELECT " +complemento +" FROM productos WHERE PLU = '" +PLU +"' AND ACTIVO = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				nombre = rs.getString(1);
			}
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo ejecutar la consulta clasePLU.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrio una excepcion mientras se extraia la clase de PLU."+e;
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
		return nombre;
	}

// Decuento finalmente la cantidad de mis productos vendidos.
	public boolean descuentaProductosPieza(String PLU, int cantidad) throws Exception {
		boolean fin;
		String sCantidad = cantidad+"";
		try  {
			String queryString = "UPDATE productos SET cantidad = '" +sCantidad +"' WHERE PLU = '"+PLU +"' AND ACTIVO = 1";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			fin = stmt.execute(queryString);
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo realizar descuentaProductosPieza.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrió una excepción mientras se ejecutaba descuentaProductosPieza."+e;
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

	public boolean descuentaProductosPeso(String PLU, double cantidad) throws Exception {
		boolean fin;
		String sCantidad = cantidad+"";
		try  {
			String queryString = "UPDATE productos SET peso = '"+sCantidad +"'  WHERE PLU = '"+PLU +"' AND ACTIVO = 1";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			fin = stmt.execute(queryString);
		}
		catch (SQLException sqle) {
			String error = "SQLException: No se puedo realizar descuentaProductosPeso.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			String error = "Ocurrió una excepción mientras se ejecutaba descuentaProductosPeso."+e;
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


 		       //
             /////
          ////////////
     ///////////////////////
///////////////////////////////////
	// Genericos

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

	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
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
/*
	public static void main (String [] args) throws Exception{
		ExtraccionesBD eBD = new ExtraccionesBD();
		boolean agravo = false;
		double aPagarSubTotal = 0;
		Vector kiko = new Vector();
		kiko =eBD.datosTicketVenta("0000449", "02", "2004-12-18");

		if (kiko.size()==0){
			System.out.println("No hay ticket!!");
		}
		else{
			for (int i=0; i<kiko.size(); i=i+2){
				agravo = eBD.productoAgrava(kiko.elementAt(i).toString().trim());
				if(agravo){
					aPagarSubTotal = (Double.parseDouble(kiko.elementAt(i+1).toString().trim())* 1.15) +aPagarSubTotal;
				}
				else{
					aPagarSubTotal += (Double.parseDouble(kiko.elementAt(i+1).toString().trim()));
				}

			}
		}
		System.out.println("El double quedo con: " +aPagarSubTotal);
	} */

}