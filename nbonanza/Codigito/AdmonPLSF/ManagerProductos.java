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


	public boolean addDatosProdEscalonado(String plu, String subDepto, String idOferta, String numOrden, String ca_peEscalon, double dCampoPrecio, String campoBit, String formaEscalon, String tipoEscalon){
		boolean salida = true;
		try{
			con = new ConexionBD();
			if (con.miConnection != null) {
				PreparedStatement updateTablaPreciosEscalonados;
				updateTablaPreciosEscalonados = con.miConnection.prepareStatement(	"INSERT INTO pescalonados VALUES(?,?,?,?,?,?,?,?,?,?);");
				updateTablaPreciosEscalonados.setString(1, plu);
				updateTablaPreciosEscalonados.setString(2, subDepto);
				updateTablaPreciosEscalonados.setString(3, idOferta);
				updateTablaPreciosEscalonados.setString(4, numOrden );
				updateTablaPreciosEscalonados.setString(5, ca_peEscalon );
				updateTablaPreciosEscalonados.setDouble(6, dCampoPrecio );
				updateTablaPreciosEscalonados.setString(7, campoBit );
				updateTablaPreciosEscalonados.setString(8, formaEscalon);
				updateTablaPreciosEscalonados.setString(9, tipoEscalon);
				updateTablaPreciosEscalonados.setInt(10, 1);
				updateTablaPreciosEscalonados.execute();
				salida=false;
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL dentro de InsercionesBD metodo addDatosProdEscalonado");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Error! Excepcion dentro de InsercionesBD metodo addDatosProdEscalonado");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de InsercionesBD metodo addDatosProdEscalonado");
					q.printStackTrace();
				}
			}
		}
		return salida;
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