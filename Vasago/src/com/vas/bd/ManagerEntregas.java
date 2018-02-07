package com.vas.bd;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Date;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Calendar;


public class ManagerEntregas {

	private TimeStamp tiempo;
	private ConexionBD con;
	private ConexionBD con2;
	private String error = new String("");


	public ResultSet todasLasVentasXClienteAgregada(String claveCliente)throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT claveVenta, fechaAlta, total, tipo, factura, remision FROM ventas WHERE claveCliente = '"+claveCliente +"' AND activo = 1 AND entrega !=2");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, todasLasVentasXClienteAgregada ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, todasLasVentasXClienteAgregada ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerEntregas, todasLasVentasXClienteAgregada ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}

	public ResultSet todasLasVentasXClienteBaja(String claveCliente)throws SQLException, Exception {
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT claveVenta, fechaAlta, total, tipo, factura, remision FROM ventas WHERE claveCliente = '"+claveCliente +"' AND activo = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, todasLasVentasXClienteBaja ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, todasLasVentasXClienteBaja ");
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
				System.out.println("Error al momento de cerrar conexion en ManagerEntregas, cierraConexion ");
				q.printStackTrace();
			}
		}
	}


	public ResultSet todasLasVentasXClienteBaja2(String clave)throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT DISTINCT claveVenta, tipo, factura, remision FROM ventas WHERE claveVenta = "+cla +" AND activo = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, todasLasVentasXClienteBaja2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, todasLasVentasXClienteBaja2 ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método datosVenta nos regresa los Datos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet datosVenta(String claveVenta) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(claveVenta);
			String query = ("SELECT * FROM ventas WHERE claveVenta = '"+cla+"'");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, datosVenta ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, datosVenta ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerEntregas, datosVenta ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}


/**
* El Método cuentaTodosProductosVenta nos regresa la Cantidad de Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public int cuentaTodosProductosVenta(String clave) throws SQLException, Exception {
		ResultSet rs = null;
		String aver = new String();
		int resul = 0;
		try{
			//System.out.println("La ClaveString: "+claveOrden);
			int cla = cambiaAInt(clave);
			//System.out.println("La Clave: "+cla);
			String query = ("SELECT COUNT(ClaveProducto) AS todos FROM productos_venta WHERE claveVenta = "+cla+"");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				resul = rs.getInt("todos");
			}
			//resul = cambiaAInt(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, cuentaTodosProductosVenta ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, cuentaTodosProductosVenta ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerEntregas, cuentaTodosProductosVenta ");
					q.printStackTrace();
				}
			}
		}
		//System.out.println("En el java salida: "+resul);
		return resul;
	}


	public ResultSet todosProductosVenta3(String clave){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT DISTINCT productos_venta.*, ventas.claveCliente FROM productos_venta, ventas WHERE ventas.claveVenta = "+cla+" AND productos_venta.claveVenta = ventas.claveVenta");
			//System.out.println("da lata: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, todosProductosVenta3 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, todosProductosVenta3 ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerEntregas, todosProductosVenta3 ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}


/**
* El Método datosRegalosVenta nos regresa los Datos de los Regalos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de los Regalos de la Orden de Compra.
*/
	public ResultSet datosRegalosVenta(String clave){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT * FROM regalos_venta WHERE claveVenta = '"+cla+"'");
			//System.out.println("query: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, datosRegalosVenta ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, datosRegalosVenta ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerEntregas, datosRegalosVenta ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}


/**
* El Método dameLlegaron nos regresa la Cantidad de Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con la cantidad de Productos de una Orden de Compra.
*/
	public double dameLlegaron(String producto, String clave){
		ResultSet rs = null;
		String aver = new String();
		double resul  = 0.00;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT llegan FROM productos_venta WHERE claveVenta = "+cla+" AND ClaveProducto = '"+producto+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				aver = rs.getString("llegan");
			}
			resul = cambiaADouble(aver);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, dameLlegaron ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, dameLlegaron ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerEntregas, dameLlegaron ");
					q.printStackTrace();
				}
			}
		}
		return resul;
	}


 /**
 * El método validaCantidadIngreso se encarga de verificar que la Cantidad a ingresar de producto entregado NO sea mayor a la estipulada originalmente.
 *	@return int -1 todo bien, X -> Renglon con el primer error.
 */

 public int validaCantidadIngreso(String clave, String[] ArrayCantidad) throws SQLException, Exception{
	int resultadoValidacion = -1;
	int cla = cambiaAInt(clave);
	String query = "SELECT Cantidad, Llegan FROM productos_venta WHERE claveVenta = "+cla+"";
	int todosLosProductos = cuentaTodosProductosVenta(clave);
	String[] ArrayCantidadExiste   = new String[todosLosProductos+1];
	ResultSet rs = null;
	try{
		con = new ConexionBD();
		Statement stmt = con.creaStatement();
		rs = stmt.executeQuery(query);
		for (int i =1; i<=todosLosProductos; i++){
			while(rs.next()){
				ArrayCantidadExiste[i] = (rs.getDouble("Cantidad")-rs.getDouble("Llegan"))+"";
				i++;
			}
		}
		//Checo que no se pase de lo pedido.
		for (int i =1; i<=todosLosProductos; i++){
			double faltante = cambiaADouble(ArrayCantidadExiste[i]);
			double llega = cambiaADouble(ArrayCantidad[i]);
			if(faltante - llega < 0){
				resultadoValidacion = i;
			}
		}
	}
	 catch(SQLException sqle){
		 resultadoValidacion =  0;
		 System.out.println("Excepcion SQL en bean ManagerEntregas, Metodo: validaCantidadIngreso.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 resultadoValidacion =  0;
		 System.out.println("Excepcion en bean ManagerEntregas, Metodo: validaCantidadIngreso.\n");
		 e.printStackTrace();
	 }
	 finally{
		 if(con != null){
			 try{
				 con.cierraConexion();
			 }
			 catch (Exception e2){
				 e2.printStackTrace();
			 }
		 }
	 }
	 return resultadoValidacion;
 }



  /**
  * El método validaCantidadIngresoObsequio se encarga de verificar que la Cantidad a ingresar de producto obsequiado entregado NO sea mayor a la estipulada originalmente.
  *	@return int -1 todo bien, X -> Renglon con el primer error.
  */

  public int validaCantidadIngresoObsequio(String clave, String can1, String can2, String can3) throws SQLException, Exception{
 	int resultadoValidacion = -1;
 	int cla = cambiaAInt(clave);
 	String query = "SELECT  (Cantidad-Llego) AS Faltante FROM regalos_venta WHERE claveVenta = "+cla +"";
 	ResultSet rs = null;
 	try{
 		con = new ConexionBD();
 		Statement stmt = con.creaStatement();
 		rs = stmt.executeQuery(query);
 		double can1B = 0.00;
 		double can2B = 0.00;
 		double can3B = 0.00;
 		int contadorInterno = 1;
		while(rs.next()){
			if(contadorInterno == 1){
				can1B = rs.getDouble("Faltante");
			}
			else if(contadorInterno == 2){
				can2B = rs.getDouble("Faltante");
			}
			else if(contadorInterno == 3){
				can3B = rs.getDouble("Faltante");
			}
			contadorInterno++;
 		}
 		//Checo que no se pase de lo pedido.
 		if(can1B - cambiaADouble(can1) < 0){
			resultadoValidacion = 1;
		}
 		if(can2B - cambiaADouble(can2) < 0){
			resultadoValidacion = 2;
		}
 		if(can3B - cambiaADouble(can3) < 0){
			resultadoValidacion = 3;
		}
 	}
 	 catch(SQLException sqle){
 		 System.out.println("Excepcion SQL en bean ManagerEntregas, Metodo: validaCantidadIngresoObsequio.\n");
 		 sqle.printStackTrace();
 	 }
 	 catch(Exception e){
 		 System.out.println("Excepcion en bean ManagerEntregas, Metodo: validaCantidadIngresoObsequio.\n");
 		 e.printStackTrace();
 	 }
 	 finally{
 		 if(con != null){
 			 try{
 				 con.cierraConexion();
 			 }
 			 catch (Exception e2){
 				 e2.printStackTrace();
 			 }
 		 }
 	 }
 	 return resultadoValidacion;
 }


/**
* El Método todosProductosVenta nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet todosProductosVenta(String clave){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT DISTINCT pro.*, ord.claveCliente FROM productos_venta pro, ventas ord WHERE ord.claveVenta = "+cla+" AND  pro.claveVenta = ord.claveVenta");
			//System.out.println("da lata: "+query);
			con2 = new ConexionBD();
			Statement stmt = con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerEntregas, todosProductosVenta ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerEntregas, todosProductosVenta ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerEntregas, todosProductosVenta ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}



 public boolean finalizaRecepcion (String usuario, String clave, int cantNumProductos, String[] ArrayCantidad, String[]  ArrayProducto, String can1, String prod1, String can2, String prod2, String can3, String prod3, String repartidor) throws SQLException, Exception{
	 boolean exito = true;
	 ResultSet productos = todosProductosVenta(clave);
	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		int claveDeOrden = cambiaAInt(clave);
		int cantNum = cantNumProductos;
		// Almaceno primero factura correspondiente:
		Statement stmt = con.creaStatement();
		Statement stmt2 = con.creaStatement();
		for (int i =1; i<=cantNum; i++){
			double canti = cambiaADouble(ArrayCantidad[i]);
			String queryString = "UPDATE productos_venta SET Llegan = (Llegan+"+canti+") WHERE claveVenta = "+claveDeOrden+" AND ClaveProducto = '"+ArrayProducto[i]+"'";
			stmt2.execute(queryString);
		}
		// Actualizo productos regalados
		if(!prod1.equalsIgnoreCase("")){
			double ocan = cambiaADouble(remueveComas(can1));
			if (ocan > 0){
				String updateObsequio = "UPDATE regalos_venta SET Llego = (Llego+"+ocan+") WHERE claveVenta = "+claveDeOrden+" AND ClaveProducto = '"+prod1+"'";
				Statement stmt3 = con.creaStatement();
				stmt.execute(updateObsequio);
			}
		}
		if(!prod2.equalsIgnoreCase("")){
			double ocan = cambiaADouble(remueveComas(can2));
			if (ocan > 0){
				String updateObsequio = "UPDATE regalos_venta SET Llego = (Llego+"+ocan+") WHERE claveVenta = "+claveDeOrden+" AND ClaveProducto = '"+prod2+"'";
				Statement stmt3 = con.creaStatement();
				stmt.execute(updateObsequio);
			}
		}
		if(!prod3.equalsIgnoreCase("")){
			double ocan = cambiaADouble(remueveComas(can3));
			if (ocan > 0){
				String updateObsequio = "UPDATE regalos_venta SET Llego = (Llego+"+ocan+") WHERE claveVenta = "+claveDeOrden+" AND ClaveProducto = '"+prod3+"'";
				Statement stmt3 = con.creaStatement();
				stmt.execute(updateObsequio);
			}
		}

		boolean finalizadosPC = true;
		boolean finalizadosPO = true;
		String queryFinProductosC = "SELECT Cantidad, Llegan FROM productos_venta WHERE claveVenta = "+claveDeOrden+"";
		Statement estadoPC = con.creaStatement();
		ResultSet rsPC = estadoPC.executeQuery(queryFinProductosC);
		while (rsPC.next()){
			if(rsPC.getInt("Cantidad") != rsPC.getInt("Llegan")){
				finalizadosPC = false;
			}
		}

		String queryFinProductosO = "SELECT Cantidad, Llego FROM regalos_venta WHERE claveVenta = "+claveDeOrden+"";
		Statement estadoPO = con.creaStatement();
		ResultSet rsPO = estadoPO.executeQuery(queryFinProductosO);
		while (rsPO.next()){
			if(rsPO.getInt("Cantidad") != rsPO.getInt("Llego")){
				finalizadosPO = false;
			}
		}
		if(finalizadosPC && finalizadosPO){
			String updateFinalizadaEntradas = "UPDATE ventas SET observaciones = CONCAT(observaciones,' Repartidor: ','"+repartidor+"'), Entrega = 2, repartidor = '"+repartidor+"' WHERE claveVenta = "+claveDeOrden+"";
			Statement temp2 = con.creaStatement();
			temp2.execute(updateFinalizadaEntradas);
		}
		else{
			String updateFinalizadaEntradas2 = "UPDATE ventas SET observaciones = CONCAT(observaciones,' Repartidor: ','"+repartidor+"'), Entrega = 1, repartidor = '"+repartidor+"' WHERE claveVenta = "+claveDeOrden+"";
			Statement temp22 = con.creaStatement();
			temp22.execute(updateFinalizadaEntradas2);
		}
		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerEntregas, Metodo: finalizaRecepcion.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion en bean ManagerEntregas, Metodo: finalizaRecepcion.\n");
		 e.printStackTrace();
	 }
	 finally{
		 if(con != null){
			 try{
				 con.habilitaAutoCommit();
				 con.cierraConexion();
			 }
			 catch (Exception e2){
				 e2.printStackTrace();
			 }
		 }
	 }
	 return exito;
 }


 /**
 * El método bajaVenta se encarga de actualizar campo Estatus a Baja en la Base de Datos de una Orden de Compra.
 *	@return boolean 	False se encontro algún problema en el momento de realizar el registro, True se realizo el registro sin problema alguno.
 */
   public boolean bajaVenta(String clave, String usuario) throws SQLException, Exception {
	 		con = new ConexionBD();
	 		con.cancelaAutoCommit();
			boolean resultado = false;
			int cla = cambiaAInt(clave);
			boolean exito = true;
			ResultSet rs = null;
			ResultSet rs2 = null;
			ResultSet rs0 = null;
			String rfc = "";
			double importe = 0.0;
          try  {
			   String datosPro = "SELECT claveCliente, total FROM ventas WHERE claveVenta = "+cla+"";
			   Statement dame = con.creaStatement();
			   rs0 = dame.executeQuery(datosPro);
			   while(rs0.next()){
				   rfc = rs0.getString("claveCliente");
				   importe = rs0.getDouble("total");
			   }
			   String cambiaSaldo = "UPDATE clientes SET saldoDisponible = saldoDisponible+"+importe+" WHERE rfc = '"+rfc+"' ";
			   Statement cambiar = con.miConnection.createStatement();
               cambiar.execute(cambiaSaldo);

 			   String queryString = "UPDATE ventas SET activo = 0 AND usuario = '"+usuario+"' WHERE claveVenta = '"+cla+"' ";
               Statement stmt = con.miConnection.createStatement();
               stmt.execute(queryString);

               String query = "SELECT ClaveProducto, Cantidad FROM productos_venta WHERE claveVenta = '"+cla+"' ";
			   Statement stmt2 = con.creaStatement();
				rs = stmt2.executeQuery(query);
				//System.out.println();
				while(rs.next()){
					String queryString2 = "UPDATE productos SET existencia =  existencia+"+rs.getDouble("cantidad")+" WHERE ClaveProducto = '"+rs.getString("ClaveProducto")+"' ";
					Statement stmt3 = con.miConnection.createStatement();
					stmt3.execute(queryString2);
					ResultSet rsRegPrecio = null;

				}
               String query2 = "SELECT ClaveProducto, cantidad FROM regalos_venta WHERE claveVenta = '"+cla+"' ";
               //System.out.println(query2);
			   Statement stmt4 = con.creaStatement();
				rs2 = stmt4.executeQuery(query2);
				while(rs2.next()){
						String queryString3 = "UPDATE producto_obsequio SET existencia =  existencia+"+rs2.getDouble("cantidad")+" WHERE claveproducto = '"+rs2.getString("ClaveProducto")+"' ";
						//System.out.println(queryString3);
						Statement stmt5 = con.miConnection.createStatement();
               			stmt5.execute(queryString3);
				}
             } catch (SQLException sqle) {
					con.realizaRollback();
					exito = false;
 					sqle.printStackTrace();
               		error = "SQLException: Could not execute the query bajaVenta.";
               throw new SQLException(error);
             } catch (Exception e) {
					con.realizaRollback();
					exito = false;
               		error = "Ocurrió una excepción mientras se actualizaba bajaVenta.";
               		throw new Exception(error);
             }
             finally{
 				try{
					con.habilitaAutoCommit();
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerEntregas metodo bajaVenta");
 			   		q.printStackTrace();
 			 	}
 		   }
		return exito;
     }


/**
* El método Facturas_Dia se encarga de enviar la información de las Facturas realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Facturas
*/

	public ResultSet Facturas_Dia(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT * FROM ventas WHERE fechaEntrega like '" +fecha+"%%%%%%%%%%%' AND activo = 1 AND entrega != 0 ORDER BY claveVenta");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Facturas_Dia.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Facturas_Dia.";
			throw new Exception(error);
		}
	return rs;
	}

   public double CostoXVenta(int venta) throws SQLException, Exception {
	 		double costoT = 0.0;
	 		double costoP = 0.0;
	 		ResultSet rs = null;
	 		ResultSet rs2 = null;
	 		con = new ConexionBD();
	 		con.cancelaAutoCommit();

          try  {

               String query = "SELECT ClaveProducto, Cantidad FROM productos_venta WHERE claveVenta = "+venta+" ";
			   Statement stmt2 = con.creaStatement();
				rs = stmt2.executeQuery(query);
				//System.out.println();
				while(rs.next()){
					String query2 = "SELECT costo FROM productos WHERE claveProducto = '"+rs.getString("claveProducto")+"' ";
					Statement stmt3 = con.creaStatement();
					rs2 = stmt3.executeQuery(query2);
					while(rs2.next()){
						costoP = rs2.getDouble("costo");
					}

					costoP = costoP * rs.getInt("cantidad");
					costoT = costoT + costoP;

				}

             } catch (SQLException sqle) {
					con.realizaRollback();
 					sqle.printStackTrace();
               		error = "SQLException: Could not execute the query CostoXVenta.";
               throw new SQLException(error);
             } catch (Exception e) {
					con.realizaRollback();
               		error = "Ocurrió una excepción mientras se actualizaba CostoXVenta.";
               		throw new Exception(error);
             }
             finally{
 				try{
					con.habilitaAutoCommit();
 			   		con.cierraConexion();
 			  	}
 			   	catch (Exception q){
 			   		System.out.println("Error al cerrar conexion de ManagerEntregas metodo CostoXVenta");
 			   		q.printStackTrace();
 			 	}
 		   }
		return costoT;
     }

/**
* El método Facturas_Semana se encarga de enviar la información de Facturas para una periodo de una semana de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos la información de las Facturas
*/

	public ResultSet Facturas_Semana(String semana, String fecha) throws SQLException, Exception {
		//System.out.println("Me llego : " +semana +", " +fecha);
		String diaInicial = "01";
		String diaFinal = "08";
		ResultSet rs = null;
		con = new ConexionBD();
		if (semana.equalsIgnoreCase("02")){
			diaInicial = "08";
			diaFinal = "16";

		}
		else if (semana.equalsIgnoreCase("03")){
			diaInicial = "16";
			diaFinal = "24";

		}
		else if (semana.equalsIgnoreCase("04")) {
			diaInicial = "24";
			diaFinal = "31";

		}
		try  {
			String queryString = ("SELECT * FROM ventas WHERE fechaEntrega >= '" +fecha+"-"+diaInicial+"%%%%%%%%%%%' AND fechaEntrega <'"+fecha+"-"+diaFinal+"%%%%%%%%%%%'  AND activo = 1 AND entrega != 0 ORDER BY claveVenta");
			//System.out.println(queryString);
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Facturas_Semana.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Facturas_Semana.";
			throw new Exception(error);
		}
	return rs;
	}


 public ResultSet Facturas_Mes(String fecha0) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT * FROM ventas WHERE fechaEntrega like '"+fecha0+"%%%%%%%%%' AND activo = 1 AND entrega != 0 ORDER BY claveVenta");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Facturas_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Facturas_Mes.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método Ordenes_Dia se encarga de enviar la información de las Ordenes de Compra realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Ordenes de Compra
*/

	public ResultSet Ordenes_Dia(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT * FROM ventas WHERE fechaEntrega like '" +fecha+"%%%%%%%%%%%' AND activo = 1 AND Entrega = 0 ORDER BY ClaveVenta");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Ordenes_Dia.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Ordenes_Dia.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerCompra metodo Ordenes_Dia");
			q.printStackTrace();
			}
		}
	return rs;
	}


/**
* El método totalCantidadXFecha se encarga de enviar la información de las Ordenes de Compra realizadas para un periodo de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos los datos de las Ordenes de Compra
*/

	public ResultSet totalCantidadXFecha(String fecha) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(fecha.length() < 8){
			fecha = fecha+"-%%";
		}
		try  {
			String queryString = ("SELECT productos_venta.claveProducto,  CONCAT(linea.nombre, ' ',marca.nombre, ' ', productos.descripcion) AS producto, SUM(productos_venta.Cantidad)AS total, productos.tipo, productos.costo FROM ventas, productos, linea, marca, productos_venta WHERE ventas.activo = 1 AND ventas.fechaAlta LIKE '"+fecha +"' AND productos_venta.claveVenta = ventas.claveVenta AND productos.claveProducto =  productos_venta.ClaveProducto AND linea.clave = productos.linea AND marca.clave = productos.marca GROUP BY productos_venta.ClaveProducto");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query totalCantidadXFecha.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving totalCantidadXFecha.";
			throw new Exception(error);
		}
	return rs;
	}


/**
* El método Ordenes_Semana se encarga de enviar la información de Ordenes de Compra para una periodo de una semana de tiempo determinado
*  	@param 	fecha 		String la Fecha que se solicito.
*	@return rs 			ResultSet que contiene todos la información de las Ordenes de Compra
*/

	public ResultSet Ordenes_Semana(String semana, String fecha) throws SQLException, Exception {
		//System.out.println("Me llego : " +semana +", " +fecha);
		String diaInicial = "01";
		String diaFinal = "08";
		ResultSet rs = null;
		con = new ConexionBD();
		if (semana.equalsIgnoreCase("02")){
			diaInicial = "08";
			diaFinal = "16";

		}
		else if (semana.equalsIgnoreCase("03")){
			diaInicial = "16";
			diaFinal = "24";

		}
		else if (semana.equalsIgnoreCase("04")) {
			diaInicial = "24";
			diaFinal = "31";

		}
		try  {
			String queryString = ("SELECT * FROM ventas WHERE fechaEntrega >= '" +fecha+"-"+diaInicial+"%%%%%%%%%%%' AND fechaEntrega <'"+fecha+"-"+diaFinal+"%%%%%%%%%%%' AND activo = 1 AND Entrega = 0 ORDER BY ClaveVenta");
			//System.out.println(queryString);
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query Ordenes_Semana.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving Ordenes_Semana.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerCompra metodo Ordenes_Semana");
			q.printStackTrace();
			}
		}
	return rs;
	}

 public ResultSet Ordenes_Mes(String fecha0) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
        Calendar tiempoSistema = Calendar.getInstance();
        String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
  		String fecha1 = anio+fecha0;
  		//System.out.println(fecha1);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT * FROM ventas WHERE fechaEntrega like '"+fecha0+"%%%%%%%%%' AND activo = 1 AND Entrega = 0 ORDER BY ClaveVenta");
          System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Ordenes_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Ordenes_Mes.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerCompra metodo Ordenes_Mes");
		   		q.printStackTrace();
		  	}
		}
        return rs;
  }


/**
* El Método todosProductosVenta2 nos regresa todos los Productos correspondientes a una Orden de Compra de un Proveedor en especifico.
*
*  @return rs ResultSet con los Productos de una Orden de Compra.
*/
	public ResultSet todosProductosVenta2(String clave) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT pro.* FROM productos_venta pro WHERE pro.claveVenta = "+cla+"");
			//System.out.println("da lata: "+query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCompra, todosProductosVenta2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCompra, todosProductosVenta2 ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerCompra, todosProductosVenta2 ");
					q.printStackTrace();
				}
			}
		}
		return rs;
	}


 public ResultSet Producto_Mes(String fecha0, String producto) throws SQLException, Exception {
        ResultSet rs = null;
        con = new ConexionBD();
  		//System.out.println(fecha0);
  		//System.out.println(producto);
  		//Date fecha = cambiaADate(fecha1);
        try  {
          String queryString = ("SELECT ord.claveVenta, ord.claveCliente, ord.fechaEntrega, ord.tipo, ord.factura, ord.remision, pr.Cantidad FROM ventas ord, productos_venta pr WHERE ord.FechaEntrega like '"+fecha0+"%%' AND ord.activo = 1 AND ord.entrega != 0 AND ord.ClaveVenta = pr.ClaveVenta AND pr.ClaveProducto = '"+producto+"' ORDER BY ord.fechaEntrega");
        //  System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query Facturas_Mes.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving Facturas_Mes.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El Método dameVentasXClienteXTiempo nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameVentasXClienteXTiempo(String claveCliente, String fechaInicial, String fechaFinal){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT ventas.claveVenta, ventas.fechaEntrega, ventas.tipo, ventas.factura, ventas.remision, ventas.total, ventas.Entrega, ventas.pago, CONCAT(usuarios.Nombre,' ',usuarios.APaterno) AS Nombre FROM ventas, usuarios WHERE ventas.claveCliente = '"+claveCliente +"' AND ventas.activo = 1 AND (ventas.fechaEntrega BETWEEN '"+fechaInicial+"' AND  '"+fechaFinal+"') AND usuarios.ClaveU = ventas.usuario ORDER BY ventas.fechaEntrega DESC");
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

	public ResultSet dameFacturasXTiempo( String fechaInicial, String fechaFinal){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT ventas.claveVenta, ventas.fechaAlta, ventas.total,  ventas.factura, ventas.entrega, ventas.pago FROM  ventas WHERE  ventas.activo = 1 AND (ventas.fechaAlta BETWEEN '"+fechaInicial+"' AND  '"+fechaFinal+"')  AND ventas.tipo = 1 ORDER BY ventas.fechaAlta DESC");
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


// Funciones Genericas de Transformacion:

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


	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}

	public double cambiaADouble(String variable) throws Exception{
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

	public String formatoDinero(String formato){
		//System.out.println("formato es: "+formato);
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
		//System.out.println("Sale: "+losEnteros.toString()+"."+losDecimales);
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

	private String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}
}