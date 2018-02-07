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

	public String rfcCliente(String nombre) throws SQLException, Exception {
		String calladito = remueveCaracteres(nombre);
		String queryString;
		if (calladito.equals(nombre)){
			System.out.println("Fue igual");
			queryString = ("SELECT rfc FROM clientes WHERE nombre = '" +nombre +"' AND ACTIVO = 1" );
		}
		else{
			System.out.println("NO Fue igual");
			queryString = ("SELECT rfc FROM clientes WHERE nombre like '" +calladito +"' AND ACTIVO = 1" );
		}
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
		return rfc;
	}



	public String remueveCaracteres(String formato){
		System.out.println("Entro: " +formato);
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
		System.out.println("Salio: " +sb);
		return formato = new String(sb.toString());
	}



// Con esta funcion lleno mi tabla productos a partir de la tabla de la bascula PLST
	public boolean addDatosProducto(String plu, String subDepto, double precioBase1, double precioG1,
	double precioG2, double precioG3, String diasConserva, String basePrecio, String cantidadXPaquete, String clasePLU, String sobreEscritura, String tipoPrecio, String textoArticulo, String pesoFijo){
		boolean salida = true;
		try{
			con = new ConexionBD();
			if (con.miConnection != null) {
				PreparedStatement updateTablaProductos;
				updateTablaProductos = con.miConnection.prepareStatement(	"INSERT INTO productos 	VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
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
				updateTablaProductos.setString(11, sobreEscritura);
				updateTablaProductos.setString(12, tipoPrecio);
				updateTablaProductos.setString(13, textoArticulo);
				updateTablaProductos.setString(14, pesoFijo);
				updateTablaProductos.setInt(15, 0 );
				if(clasePLU.equals("00")){
					updateTablaProductos.setString(16, "0");
					updateTablaProductos.setString(17, "NO");
				}
				else{
					updateTablaProductos.setString(16, "NO");
					updateTablaProductos.setString(17, "0");
				}
				updateTablaProductos.setInt(18, 1 );
				updateTablaProductos.execute();
				salida=false;
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL dentro de InsercionesBD metodo addDatosProducto");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Error! Excepcion dentro de InsercionesBD metodo addDatosProducto");
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

// GENERICAS

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