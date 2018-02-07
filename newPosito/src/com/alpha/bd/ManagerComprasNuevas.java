package com.alpha.bd;

import com.alpha.bd.DateStamp;
import com.alpha.bd.TimeStamp;
import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerComprasNuevas" es la encargada de administrar los datos correspondientes a las Compras.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Agosto 2005)
*/

public class ManagerComprasNuevas {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();

/**
* El método ManagerComprasNuevas es el constructor vacio de la clase.
*/

  public ManagerComprasNuevas()   { }

// Regresa la  Ganancia ($) correspondiente a cada vendedor solicitado.
   public ResultSet consultaVPV(String elVendedor, String inicio, String fin)   throws SQLException, Exception {
           ResultSet rs = null;
           con = new ConexionBD();
           try  {
             String queryString = ("SELECT vendedores.claveVenta, vendedores.NombreE, SUM(contenidoticket.precioAPagar)AS Total FROM vendedores, contenidoticket WHERE vendedores.claveVenta LIKE '"+elVendedor+"' AND vendedores.estatus = 1 AND contenidoticket.claveVendedor = vendedores.claveVenta AND contenidoticket.fechaRealPago BETWEEN '"+inicio+"' AND '"+fin+"' AND (contenidoticket.estatusPago = 1 OR contenidoticket.estatusPago = 2) AND contenidoticket.estatusTicket = 1 GROUP BY contenidoticket.claveVendedor ORDER BY vendedores.claveVenta");
             Statement stmt = con.miConnection.createStatement();
             rs = stmt.executeQuery(queryString);
           } catch (SQLException sqle) {
             error = "SQLException: Could not execute the query consultaVPV.";
             throw new SQLException(error);
           } catch (Exception e) {
             error = "An exception occured while retrieving consultaVPV.";
             throw new Exception(error);
           }
           return rs;
  }

	public void cierraConexion() throws SQLException{
             if(con != null){
 				try{
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerComprasNuevas metodo cierraConexion");
 			   		q.printStackTrace();
 			 	}
 		   }
	}

	// Informo si existe un producto solicitado.
	public boolean existeProducto	(String productoClave) throws Exception {
		boolean existe = false;
		ResultSet rs = null;
		try  {
			String queryString = "SELECT  ID_Pro  from productos WHERE ID_Pro = "+cambiaAInt(productoClave) +"  AND activo = 1";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while (rs.next()){
				if(rs.getString("ID_Pro").equals(productoClave)){
					existe = true;
				}
			}
		}
		catch (SQLException sqle) {
			System.out.println("SQLException: No se puedo realizar existeProducto, Manager Ticket");
			sqle.printStackTrace();
		}
		catch (Exception e) {
			System.out.println("Exception: No se puedo realizar existeProducto, Manager Ticket");
			e.printStackTrace();
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return existe;
	}

// Regresa la cantidad y Ganancia ($) correspondiente a un producto en un periodo de tiempo especifico.
   public ResultSet consultaVxPxF(String productoClave, String inicio, String fin)   throws SQLException, Exception {
           ResultSet rs = null;
           con = new ConexionBD();
           try  {
             String queryString = ("SELECT SUM(contenidoticket.cantidadProducto)AS Cantidad, contenidoticket.tipoVenta, (SUM(contenidoticket.precioAPagar)/SUM(contenidoticket.cantidadProducto))AS Promedio, SUM(contenidoticket.precioAPagar)AS Costo, productos.descripcion FROM  contenidoticket, productos WHERE contenidoticket.ID_Pro = "+cambiaAInt(productoClave)+" AND productos.ID_Pro = contenidoticket.ID_Pro AND contenidoticket.FechaRealPago BETWEEN '"+inicio+"' AND '"+fin+"' GROUP BY contenidoticket.ID_Pro,contenidoticket.tipoVenta");
             Statement stmt = con.miConnection.createStatement();
             rs = stmt.executeQuery(queryString);
           } catch (SQLException sqle) {
             error = "SQLException: Could not execute the query consultaVxPxF.";
             throw new SQLException(error);
           } catch (Exception e) {
             error = "An exception occured while retrieving consultaVxPxF.";
             throw new Exception(error);
           }
           return rs;
  }


  // Regresa la inversión en inventario para un producto solicitado
     public ResultSet consultaIIPV(String productoClave)   throws SQLException, Exception {
             ResultSet rs = null;
             con = new ConexionBD();
             try  {
               String queryString = ("SELECT descripcion, precioMenu, tipoPro, invTienda FROM productos WHERE ID_Pro LIKE '"+productoClave +"' AND activo = 1 ORDER BY descripcion");
               Statement stmt = con.miConnection.createStatement();
               rs = stmt.executeQuery(queryString);
             } catch (SQLException sqle) {
               error = "SQLException: Could not execute the query consultaIIPV.";
               throw new SQLException(error);
             } catch (Exception e) {
               error = "An exception occured while retrieving consultaIIPV.";
               throw new Exception(error);
             }
             return rs;
    }

  	public String totalizaInventario(String productoClave)   throws SQLException, Exception {
           ResultSet rs = null;
           String total = "0.00";
           con = new ConexionBD();
           try  {
             String queryString = ("SELECT  SUM(inversion) AS invertido FROM (SELECT (precioMenu*peso) AS inversion FROM productos WHERE PLU LIKE  '"+productoClave+"' AND clasePLU = 0 AND activo = 1  UNION SELECT (precioMenu*cantidad) AS inversion FROM productos WHERE PLU LIKE '"+productoClave+"' AND clasePLU = 1 AND activo = 1) as temp2");
             Statement stmt = con.miConnection.createStatement();
             rs = stmt.executeQuery(queryString);
             while(rs.next()){
				 total = rs.getString("invertido");
			 }
           } catch (SQLException sqle) {
             error = "SQLException: Could not execute the query consultaIIPV.";
             throw new SQLException(error);
           } catch (Exception e) {
             error = "An exception occured while retrieving consultaIIPV.";
             throw new Exception(error);
           }
           return total;
  	}




// CLASES PREVIAS


/**
* El método dameProductos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Usuarios que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Usuarios.
*/
  public ResultSet dameProductos() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM productos WHERE activo = 1 ORDER BY textoArticulo");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameProductos.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameProductos.";
            throw new Exception(error);
          }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerUsuarios metodo dameProductos");
			   		q.printStackTrace();
			 	}
		   }
          return rs;
  }


 /**
 * El método DatosProducto se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Usuarios que se encuentren activos, es decir que no hayan sido dados de baja.
 *	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Usuarios.
 */
   public ResultSet DatosProducto(String producto) throws SQLException, Exception {
           ResultSet rs = null;
           String estatus = "1";
           con = new ConexionBD();
           try  {
             String queryString = ("SELECT * FROM productos WHERE plu = '"+producto+"' AND activo = 1");
             Statement stmt = con.miConnection.createStatement();
             rs = stmt.executeQuery(queryString);
           } catch (SQLException sqle) {
             error = "SQLException: Could not execute the query DatosProducto.";
             throw new SQLException(error);
           } catch (Exception e) {
             error = "An exception occured while retrieving DatosProducto.";
             throw new Exception(error);
           }
             finally{
 				try{
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerUsuarios metodo DatosProducto");
 			   		q.printStackTrace();
 			 	}
 		   }
           return rs;
  }





	// Informo si existe un vendedor solicitado.
	public boolean existeVendedor (String vendedorClave) throws Exception {
		boolean existe = false;
		ResultSet rs = null;
		try  {
			String queryString = "SELECT  claveVenta from usuario WHERE claveVenta = '"+vendedorClave +"' AND estatus = 1";
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
			while (rs.next()){
				if(rs.getString("claveVenta").equals(vendedorClave)){
					existe = true;
				}
			}
		}
		catch (SQLException sqle) {
			System.out.println("SQLException: No se puedo realizar existeVendedor, Manager Ticket");
			sqle.printStackTrace();
		}
		catch (Exception e) {
			System.out.println("Exception: No se puedo realizar existeVendedor, Manager Ticket");
			e.printStackTrace();
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}
		return existe;
	}






/**
* El método guardarEntrada se encarga de actualizar los inventarios en las Entradas.
*/
  public synchronized  boolean guardarEntrada(String producto, String cantidad, String unidad) throws SQLException, Exception {
	  		boolean sale = true;
			ResultSet rs = DatosProducto(producto);
			String nombreProducto = new String();
			String pesa = new String();
			String canticaja = new String();
			String tienePeso = new String();
			String tieneCantidad = new String();
			DateStamp ds = new DateStamp();
			while(rs.next()){
				pesa = rs.getString("clasePLU");
				canticaja = rs.getString("cantidadXCaja");
				tienePeso = rs.getString("peso");
				tieneCantidad = rs.getString("cantidad");
				nombreProducto = rs.getString("textoArticulo");
			}
			//System.out.println("Tipo que es: "+pesa);
			double llega = cambiaADouble(cantidad);
			con = new ConexionBD();
			con.cancelaAutoCommit();
            try  {
				if(pesa.equalsIgnoreCase("0")){
					if(unidad.equalsIgnoreCase("Caja")){
						llega = llega * cambiaADouble(canticaja);
					}
					llega = llega + cambiaADouble(tienePeso);
					String queryString = "UPDATE productos SET peso = '"+llega+"' WHERE plu = '"+producto+"' AND activo = 1" ;
					Statement stmt = con.miConnection.createStatement();
	              	stmt.execute(queryString);
			}
			else{
				if(unidad.equalsIgnoreCase("Caja")){
					llega = llega * cambiaADouble(canticaja);
				}
				llega = llega + cambiaADouble(tieneCantidad);
				String queryString = "UPDATE productos SET cantidad = '"+llega+"' WHERE plu = '"+producto+"' AND activo = 1" ;
				Statement stmt = con.miConnection.createStatement();
              	stmt.execute(queryString);
			}
			PreparedStatement almacenaEntrada;
			almacenaEntrada= con.miConnection.prepareStatement("insert entradas values(?,?,?,?,?,?);");
			almacenaEntrada.setString(1, producto); // PLU
			almacenaEntrada.setString(2, nombreProducto); // Nombre Producto
			almacenaEntrada.setDouble(3, cambiaADouble(cantidad)); //Codigo de Barras #1
			if(unidad.equalsIgnoreCase("Caja")){
				almacenaEntrada.setInt(4, 1); //Es por Caja
			}
			else{
				almacenaEntrada.setInt(4, 0); //Es por pieza
			}
			almacenaEntrada.setString(5, ds.obtenDatos()); //Codigo de Barras #1
			almacenaEntrada.setInt(6,1);// Activo
			almacenaEntrada.execute();

            } catch (SQLException sqle) {
				sale = false;
				con.realizaRollback();
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query guardarEntrada.";
              throw new SQLException(error);
            } catch (Exception e) {
				sale = false;
				con.realizaRollback();
              error = "Ocurrió una excepción mientras se actualizaba guardarEntrada.";
              throw new Exception(error);
            }
				try{
					con.realizaCommit ( );
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCompras Nuevas metodo guardarEntrada");
					q.printStackTrace();
				}
		return sale;
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


	public String formatoDinero(String formato){
		StringBuilder losEnteros = new StringBuilder(dameEnteros(formato));
		String losDecimales = dameDecimales(formato);
		if(losEnteros.length() == 10){
			losEnteros.insert(1,',');
			losEnteros.insert(5,',');
			losEnteros.insert(9,',');
		}
		else if(losEnteros.length() == 9 ){
			losEnteros.insert(3,',');
			losEnteros.insert(7,',');
		}
		else if(losEnteros.length() == 8 ){
			losEnteros.insert(2,',');
			losEnteros.insert(6,',');
		}
		else if(losEnteros.length() == 7){
			losEnteros.insert(1,',');
			losEnteros.insert(5,',');
		}
		else if(losEnteros.length() == 6 ){
			losEnteros.insert(3,',');
		}
		else if(losEnteros.length() == 5 ){
			losEnteros.insert(2,',');
		}
		else if(losEnteros.length() == 4 ){
			losEnteros.insert(1,',');
		}
		return losEnteros.toString()+"."+losDecimales;
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

}