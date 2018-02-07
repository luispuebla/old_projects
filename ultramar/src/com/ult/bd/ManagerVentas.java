package com.ult.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.ult.bd.ManagerCobros;

/**
* La clase "ManagerVentas" es la encargada de administrar los datos correspondientes a los Productos como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Mayo 2006)
*/

public class ManagerVentas {

  String error;
  private ConexionBD con = null;
  private ConexionBD con1 = null;
  private ConexionBD con2 = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerVentas es el constructor vacio de la clase.
*/

  public ManagerVentas()   { }


	public double dameDescuento(int IDC) throws SQLException, Exception{
		double Descuento = 0.00;
		con1 = new ConexionBD();
		con1.cancelaAutoCommit();
		boolean existeDescuento = false;
		int laComanda = 0;
		double totalGlobal = 0.00;
		try{
			ResultSet rs = null;
			String dameProductosTotal = "SELECT SUM(comandapro.PT)AS total, comandapro.IDC FROM comandapro, comanda WHERE comanda.IDC = "+IDC +" AND comandapro.IDC = comanda.IDC AND Estatus = 1 GROUP BY (comandapro.IDC)";
			Statement stmt3 = con1.creaStatement();
			rs = stmt3.executeQuery(dameProductosTotal);
			while(rs.next()){
				laComanda = rs.getInt("IDC");
				totalGlobal = rs.getDouble("total");
			}
			PreparedStatement updateSumaTotal;
			updateSumaTotal = con1.miConnection.prepareStatement("UPDATE comanda SET PT = ? WHERE IDC = ?");
			updateSumaTotal.setDouble(1, totalGlobal);
			updateSumaTotal.setInt(2, laComanda);
			updateSumaTotal.execute();
			ResultSet rsDescuentos = null;
			String queryHayDescuentos = "SELECT DISTINCT descuentos.comanda, descuentos.numComensal, descuentos.porcentaje FROM descuentos, comanda, comandapro WHERE comanda.IDC = "+IDC +" AND comanda.Es = 1 AND descuentos.comanda = comanda.IDC ORDER BY(descuentos.numComensal)";
			Statement stmt = con1.creaStatement();
			rsDescuentos = stmt.executeQuery(queryHayDescuentos);
			while(rsDescuentos.next()){
				laComanda = rsDescuentos.getInt("comanda");
				existeDescuento = true;
			}
			if(!existeDescuento){
				Descuento = 0.00;
			}
			else{
				rsDescuentos.beforeFirst();
				int descPorc = 0;
				ResultSet rsInterno = null;
				while(rsDescuentos.next()){
					descPorc = rsDescuentos.getInt("porcentaje");
					String dameProductosXComensal = "SELECT SUM(PT)AS total FROM comandapro WHERE IDC = "+laComanda +" AND IDCom = "+rsDescuentos.getInt("numComensal") +" AND Estatus = 1";
					Statement stmt2 = con1.creaStatement();
					rsInterno = stmt2.executeQuery(dameProductosXComensal);
					double totalComensal = 0.00;
					while(rsInterno.next()){
						totalComensal = rsInterno.getDouble("total");
					}
// QUITO EL IVA
//					totalComensal = ((totalComensal*100)/115);
// HAGO DESCUENTO
					totalComensal = ((totalComensal*descPorc)/100);
					Descuento += totalComensal;
// ACTUALIZO COMANDA TOTAL
					PreparedStatement updateSumaFinal;
					updateSumaFinal = con1.miConnection.prepareStatement("UPDATE comanda SET PT = (PT - ?) WHERE IDC = ?");
					updateSumaFinal.setDouble(1, totalComensal);
					updateSumaFinal.setInt(2, laComanda);
					updateSumaFinal.execute();
				}
			}
			con1.realizaCommit();
		}
		catch (SQLException sqle){
			con1.realizaRollback();
			System.out.println("Error de SQL en ImpresionTicketXComensal, ajustaDescuentos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			con1.realizaRollback();
			System.out.println("Ocurrio un Error en ImpresionTicketXComensal, ajustaDescuentos ");
			e.printStackTrace();
		}
		finally{
			if(con1 != null){
				try{
					con1.realizaCommit();
					con1.habilitaAutoCommit();
					con1.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ImpresionTicketXComensal, ajustaDescuentos ");
					q.printStackTrace();
				}
			}
		}
		return Descuento;
	}


public ResultSet dameComandasAImprimir(String fecha, String totalTarget, String totalFactur, String  totalCompro ) throws SQLException, Exception{
	ManagerCobros cob = new ManagerCobros();
	double tt = cambiaADouble(totalTarget);
	double tf = cambiaADouble(totalFactur);
	double tc = cambiaADouble(totalCompro);
	double tp = 0.00;
	ResultSet datosCorteESinFacturar = cob.dameCorteCajaESinFacturar(fecha);
	ResultSet datosCorteEC =	cob.dameCorteCajaEC(fecha);
	String complemento = " ";
	boolean primeraVez = true;
	ResultSet rs = null;
	ResultSet rsB = null;
	con = new ConexionBD();
	if(con != null){
		try{
			String query1 = "SELECT DISTINCT IDC FROM (SELECT DISTINCT cobros.claveVenta AS IDC FROM cobros WHERE cobros.fechaCobro BETWEEN '"+ fecha +" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58'  AND cobros.activo = 1 AND (cobros.formaPago = 4 OR cobros.formaPago = 5) UNION ALL SELECT DISTINCT cobros.claveVenta AS IDC FROM cobros WHERE cobros.fechaCobro BETWEEN '"+fecha +" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58'  AND cobros.activo = 1 AND cobros.facturado = 1)AS TempT2 ";
			//System.out.println("query1:\n" +query1);
			Statement stmt1 = con.creaStatement();
			rsB = stmt1.executeQuery(query1);
			while(rsB.next()){
				if(primeraVez){
					primeraVez = false;
					complemento += " (comanda.IDC = "+rsB.getString("IDC");
				}
				else{
					complemento += " OR comanda.IDC = "+rsB.getString("IDC");
				}
			}
			while(datosCorteEC.next()){
				if(primeraVez){
					primeraVez = false;
					complemento += " (comanda.IDC = "+datosCorteEC.getString("claveVenta");
				}
				else{
					complemento += " OR comanda.IDC = "+datosCorteEC.getString("claveVenta");
				}
			}
			if(tf+tc < tt){
				while (datosCorteESinFacturar.next() && tf+tc+tp< tt){
					tp += datosCorteESinFacturar.getDouble("monto");
					if(primeraVez){
						primeraVez = false;
						complemento += " (comanda.IDC = "+datosCorteESinFacturar.getString("claveVenta");
					}
					else{
						complemento += " OR comanda.IDC = "+datosCorteESinFacturar.getString("claveVenta");
					}
				}
			}
			cob.cierraConexion();
			if(complemento.trim().equals("")){
				complemento = " comanda.IDC = 0  ";
			}
			else{
				complemento += ") ";
			}
			String query ="SELECT DISTINCT comanda.IDC, comanda.FA,  comanda.TA,  comanda.IDMM,  comanda.NC,  comanda.PT FROM comanda  WHERE "+complemento +" AND comanda.Es = 0";
			//System.out.println("Query: \n"+query);
			Statement stmt = con.creaStatement();
			rs=stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	return rs;
}


public ResultSet dameTicketsInternos(int IDC) throws SQLException, Exception{
	ResultSet rs = null;
	con2 = new ConexionBD();
	if(con2 != null){
		try{
			String query ="SELECT Cantidad, PrecioUnitario, PrecioTotal, Producto, Tipo, Tamanio FROM (SELECT SUM(comandapro.CanPro)AS Cantidad, (comandapro.PU)AS PrecioUnitario, SUM(comandapro.PT)AS PrecioTotal, (comandapro.TB)AS Tamanio, (alimentos.nombre)AS Producto,  comandapro.Tipo FROM comandapro, comanda, alimentos WHERE comanda.IDC = "+IDC +" AND comanda.Es = 0 AND comandapro.IDC = comanda.IDC AND comandapro.Tipo = 0 AND comandapro.Estatus = 2 AND alimentos.clave = comandapro.ClPro GROUP BY CONCAT(comandapro.ClPro,comandapro.TB,comandapro.PU) UNION SELECT SUM(comandapro.CanPro)AS  Cantidad, (comandapro.PU)AS PrecioUnitario, SUM(comandapro.PT)AS PrecioTotal, (comandapro.TB)AS Tamanio, (bebidas.nombre)AS Producto, comandapro.Tipo FROM comandapro, comanda, bebidas WHERE comanda.IDC = "+IDC +" AND comanda.Es = 0 AND comandapro.IDC = comanda.IDC AND (comandapro.Tipo = 1 OR comandapro.Tipo = 2 OR comandapro.Tipo = 3 OR comandapro.Tipo = 4) AND comandapro.Estatus = 2 AND bebidas.clave = comandapro.ClPro GROUP BY  CONCAT(comandapro.ClPro,comandapro.TB,comandapro.PU))AS TempT ORDER BY CONCAT(Producto,Tamanio) ";
			Statement stmt = con2.creaStatement();
			rs=stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	return rs;
}


/**
* El método dameComanda se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public int dameComanda(String mesa) throws SQLException, Exception
 {
        ResultSet rs = null;
        int comanda = 0;
        int cla = cambiaAInt(mesa);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT IDC FROM comanda WHERE IDMM = "+cla+" AND Es = 1");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		comanda = rs.getInt("IDC");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameComanda.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameComanda.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerVentas metodo dameComanda");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println(nombre);
        return comanda;
  }



/**
* El método dameMeseroComanda se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public int dameMeseroComanda(String comanda) throws SQLException, Exception
 {
        ResultSet rs = null;
        int mesero = 0;
        int cla = cambiaAInt(comanda);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT IDM FROM comanda WHERE IDC = "+cla+" AND Es = 1");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		mesero = rs.getInt("IDM");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameMeseroComanda.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameMeseroComanda.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerVentas metodo dameMeseroComanda");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println(nombre);
        return mesero;
  }




/**
* El método todosLosProductosComanda se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los productos que dentro de su cavle tengar el orden de linea+sublinea+marca solicitado.
*  	@param 	linea	String con la línea solicitada.
*  	@param 	subinea	String con la sublínea solicitada.
*  	@param 	marca	String con la marca solicitada.
*	@return rs 		ResultSet que contiene todos los datos correspondiente a la solicitud.
*/
 public ResultSet todosLosProductosComanda(int clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT Ge, CanPro, ClPro, TB, FB, MB, Tipo FROM comandapro WHERE IDC = "+clave+" AND PT != 0.00 AND estatus = 1 ORDER BY(CONCAT(Ge,ClPro,TB,HR))");
         System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query todosLosProductosComanda.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving todosLosProductosComanda.";
          throw new Exception(error);
        }
        return rs;
  }



 public ResultSet todosLosProductosComanda2(int clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT Ge, CanPro, ClPro, TB, FB, MB, Tipo FROM comandapro WHERE IDC = "+clave+" AND PT != 0.00 AND (estatus = 2 OR  estatus = 1) ORDER BY(CONCAT(Ge,ClPro,TB,HR))");
         //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query todosLosProductosComanda.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving todosLosProductosComanda.";
          throw new Exception(error);
        }
        return rs;
  }



 public int update_Cortesias (String[] clave, String comanda) throws SQLException, Exception{
	 int exito = 0;
	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		 for(int i = 0; i<clave.length; i++){
			 String tipo = clave[i].substring(0,1);
			 String producto = clave[i].substring(1,clave[i].indexOf("*"));
			 String tamanio = clave[i].substring(clave[i].indexOf("*")+1,clave[i].length());
			 int com = cambiaAInt(comanda);
			 int ti = cambiaAInt(tipo);
			 int prod = cambiaAInt(producto);
			 int tama = cambiaAInt(tamanio);
			 double sumaTotal = 0.00;
			String updatecortesia = "UPDATE comandapro SET PU = 0.00, PT = 0.00  WHERE IDC = "+com+" AND ClPro = "+prod+" AND Tipo = "+ti+" AND TB = "+tama +" AND PT != 0.00 AND Estatus != 0 LIMIT 1";
			//System.out.println(updatecortesia);
			Statement stmt = con.creaStatement();
			stmt.execute(updatecortesia);
			ResultSet rs = null;
			String queryActualizaPrecio = "SELECT SUM(PT) AS total FROM comandapro WHERE IDC = "+com+" AND PT != 0.00 AND Estatus = 1";
			Statement st1 = con.creaStatement();
			rs=st1.executeQuery(queryActualizaPrecio);
			while(rs.next()){
				sumaTotal = rs.getDouble("total");
			}
			System.out.println(queryActualizaPrecio+": " +sumaTotal);
			String updateTotal = "UPDATE comanda SET PT = "+sumaTotal +" WHERE IDC = "+com +" AND Es = 1";
			//System.out.println(updatecortesia);
			Statement stmt2 = con.creaStatement();
			stmt2.execute(updateTotal);
		}
		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = 1;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerVentas, Metodo: update_Cortesias.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = 1;
		 con.realizaRollback();
		 System.out.println("Excepcion en bean ManagerVentas, Metodo: update_Cortesias.\n");
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


 public int update_Pago_Total_Comanda (String comanda) throws SQLException, Exception{
	 int exito = 0;

	 int com = cambiaAInt(comanda);
	 ResultSet rs = null;
	 double totalTodos = 0.0;

	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		//System.out.println(ar);

          String queryString = ("SELECT SUM(PT) AS total FROM comandapro WHERE IDC = "+com+" AND PT != 0.00 AND Estatus = 1");
          System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		totalTodos = rs.getDouble("total");
		  }

			String updateTotal = "UPDATE comanda SET PT = PT - "+totalTodos+" WHERE IDC = "+com+" AND Es = 1";
			//System.out.println("updateTotal "+updateTotal);
			Statement stmt2 = con.creaStatement();
			stmt2.execute(updateTotal);

		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = 1;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerVentas, Metodo: update_Pago_Total_Comanda.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = 1;
		 con.realizaRollback();
		 System.out.println("Excepcion en bean ManagerVentas, Metodo: update_Pago_Total_Comanda.\n");
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
* El método tieneComanda verifica que el cliente solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del cliente solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean tieneComanda(String mesa) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select IDMM from comanda WHERE es = 1");
  	  		while(rs.next()){

  	  			if(mesa.equalsIgnoreCase(rs.getString("IDMM"))) {
  	  				bandera = true;//realiza comparación con la base de datos
  	  				}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerVentas metodo tieneComanda");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



public boolean tieneComandaPendiente(String comanda) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select IDC from comanda WHERE es = 2");
  	  		while(rs.next()){

  	  			if(comanda.equalsIgnoreCase(rs.getString("IDC"))) {
  	  				bandera = true;//realiza comparación con la base de datos
  	  				}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerVentas metodo tieneComandaPendiente");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



 public int update_Bajas_Productos (String[] clave, String comanda) throws SQLException, Exception{
	 int exito = 0;
	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		 for (int i = 0; i<clave.length; i++){
			 int com = cambiaAInt(comanda);
			 int tipo = cambiaAInt(clave[i].substring(0,1));
			 int producto = cambiaAInt(clave[i].substring(1,clave[i].indexOf("*")));
			 int tamanio = cambiaAInt(clave[i].substring(clave[i].indexOf("*")+1, clave[i].indexOf("%")));
			 int formato =cambiaAInt(clave[i].substring(clave[i].indexOf("%")+1, clave[i].indexOf("$")));
			 int mezcla = cambiaAInt(clave[i].substring(clave[i].indexOf("$")+1, clave[i].length()));
			 ResultSet rsDatos = null;
			Statement st1 = con.creaStatement();
// OBTENGO DATOS PREVIOS
			String queryDameDatosPB = "SELECT * FROM comandapro WHERE IDC = "+com+" AND ClPro = "+producto+" AND Tipo = "+tipo +" AND TB = "+tamanio +" AND FB = "+formato +" AND MB = "+mezcla +" AND Estatus != 0 LIMIT 1";
			rsDatos = st1.executeQuery(queryDameDatosPB);
// ACTUALIZO ESTATUS A CERO ASI COMO SUS PRECIOS
			String updateBajaProducto = "UPDATE comandapro SET PU= 0.00, PT = 0.00,  Estatus = 0 WHERE IDC = "+com+" AND ClPro = "+producto+" AND Tipo = "+tipo +" AND TB = "+tamanio +" AND FB = "+formato +" AND MB = "+mezcla +" AND Estatus != 0 LIMIT 1";
			Statement stmt = con.creaStatement();
			stmt.execute(updateBajaProducto);
// RENUEVO EL MONTO TOTAL DE MI CUENTA.
			ResultSet rs = null;
			double sumaTotal = 0.00;
			String queryActualizaPrecio = "SELECT SUM(PT) AS total FROM comandapro WHERE IDC = "+com+" AND PT != 0.00 AND Estatus = 1";
			Statement st2 = con.creaStatement();
			rs=st2.executeQuery(queryActualizaPrecio);
			while(rs.next()){
				sumaTotal = rs.getDouble("total");
			}
			String updateTotal = "UPDATE comanda SET PT = "+sumaTotal +" WHERE IDC = "+com +" AND Es = 1";
			//System.out.println(queryActualizaPrecio+": " +sumaTotal);
			Statement stmt2 = con.creaStatement();
			stmt2.execute(updateTotal);
// REGRESO A INVENTARIOS
			while(rsDatos.next()){
				// Hablamos de un alimento
				if(rsDatos.getInt("Ge") == 1){
					//System.out.println("Hablamos de un alimento");
					for (int contadorMP = 0; contadorMP < 10; contadorMP ++){
						ResultSet interino = null;
						String queryDameMP = "SELECT materia"+contadorMP+", cantidad"+contadorMP +" FROM ALIMENTOS WHERE clave = "+rsDatos.getInt("ClPro") +" AND estatus = 1";
						//System.out.println(queryDameMP);
						Statement stInterno = con.creaStatement();
						interino = stInterno.executeQuery(queryDameMP);
						while (interino.next()){
							if(interino.getInt("materia"+contadorMP) >0){
								//System.out.println("Si tiene materia que lo componga.." +interino.getInt("materia"+contadorMP));
								String queryDetalleMP = "SELECT * FROM materiaprima WHERE clave = "+interino.getInt("materia"+contadorMP) +" AND Estatus = 1";
								Statement stmt3 = con.creaStatement();
								ResultSet infoMP = null;
								infoMP = stmt3.executeQuery(queryDetalleMP);
								while (infoMP.next()){
									// Es un alimento
									if(infoMP.getInt("tipo") == 1){
										//System.out.println("La materia es alimento");
										String updateMP= "UPDATE materiaprima SET inventarioKG = inventarioKG + "+interino.getDouble("cantidad"+contadorMP) +" WHERE clave  = "+interino.getInt("materia"+contadorMP) +" AND Estatus = 1";
										Statement stmt6 = con.creaStatement();
										stmt6.execute(updateMP);
									}
									// Es una bebida
									else{
										//System.out.println("La materia es bebida");
										String updateMP= "UPDATE materiaprima SET inventarioCopeo = inventarioCopeo + "+interino.getDouble("cantidad"+contadorMP) +" WHERE clave  = "+interino.getInt("materia"+contadorMP) +" AND Estatus = 1";
										Statement stmt6 = con.creaStatement();
										stmt6.execute(updateMP);
									}
								}// cierro While infoMP
							}// Cierro if (si tiene materia)
						}// Cierro While interino
					}// Cierro ciclo for
				}
				// Hablamos de una bebida
				else{
					// Es una copa
					if(rsDatos.getInt("Tipo") == 1){
						//System.out.println("Hablamos de una copa.");
						for (int contadorMP = 0; contadorMP < 10; contadorMP ++){
							ResultSet interino = null;
							String queryDameMP = "SELECT materia"+contadorMP+", cantidad"+contadorMP +" FROM BEBIDAS WHERE clave = "+rsDatos.getInt("ClPro") +" AND estatus = 1";
							Statement stInterno = con.creaStatement();
							interino = stInterno.executeQuery(queryDameMP);
							while (interino.next()){
								if(interino.getInt("materia"+contadorMP) >0){
									String queryDetalleMP = "SELECT * FROM materiaprima WHERE clave = "+interino.getInt("materia"+contadorMP) +" AND Estatus = 1";
									Statement stmt3 = con.creaStatement();
									ResultSet infoMP = null;
									infoMP = stmt3.executeQuery(queryDetalleMP);
									while (infoMP.next()){
										// Es un alimento
										if(infoMP.getInt("tipo") == 1){
											String updateMP= "UPDATE materiaprima SET inventarioKG = inventarioKG + "+interino.getDouble("cantidad"+contadorMP) +" WHERE clave  = "+interino.getInt("materia"+contadorMP) +" AND Estatus = 1";
											Statement stmt6 = con.creaStatement();
											stmt6.execute(updateMP);
										}
										// Es una bebida
										else{
											String updateMP= "UPDATE materiaprima SET inventarioCopeo = inventarioCopeo + "+interino.getDouble("cantidad"+contadorMP) +" WHERE clave  = "+interino.getInt("materia"+contadorMP) +" AND Estatus = 1";
											Statement stmt6 = con.creaStatement();
											stmt6.execute(updateMP);
										}
									}// cierro While infoMP
								}// Cierro if (si tiene materia)
							}// Cierro While interino
						}// Cierro ciclo for
					}
					// Es una sola botella o botella grande
					else if(rsDatos.getInt("Tipo") == 2 || rsDatos.getInt("Tipo") == 3){
						//System.out.println("Hablamos de una botella grande o unica");
						ResultSet interino = null;
						String queryDameMP = "SELECT materia0 FROM BEBIDAS WHERE clave = "+rsDatos.getInt("ClPro") +" AND estatus = 1";
						Statement stInterno = con.creaStatement();
						interino = stInterno.executeQuery(queryDameMP);
						int claveMPBotella = 0;
						while (interino.next()){
							claveMPBotella = interino.getInt("materia0");
						}
						String queryDetalleMP = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+claveMPBotella +" AND Estatus = 1";
						Statement stmt3 = con.creaStatement();
						ResultSet infoMP = null;
						infoMP = stmt3.executeQuery(queryDetalleMP);
						while(infoMP.next()){
							if(infoMP.getDouble("litrosXBotella1") == 0){
								String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + 1 WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
								Statement stmt6 = con.creaStatement();
								stmt6.execute(updateMP);
							}
							else if(infoMP.getDouble("litrosXBotella2") == 0){
								String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + 1 WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
								Statement stmt6 = con.creaStatement();
								stmt6.execute(updateMP);
							}
							else if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
								String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + 1 WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
								Statement stmt6 = con.creaStatement();
								stmt6.execute(updateMP);
							}
							else{
								String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + 1 WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
								Statement stmt6 = con.creaStatement();
								stmt6.execute(updateMP);
							}
						}
					}
					// Es botella pequeña
					else if(rsDatos.getInt("Tipo") == 4){
						//System.out.println("Hablamos de una botella pequeña.");
						ResultSet interino = null;
						String queryDameMP = "SELECT materia0 FROM BEBIDAS WHERE clave = "+rsDatos.getInt("ClPro") +" AND estatus = 1";
						Statement stInterno = con.creaStatement();
						interino = stInterno.executeQuery(queryDameMP);
						int claveMPBotella = 0;
						while (interino.next()){
							claveMPBotella = interino.getInt("materia0");
						}
						String queryDetalleMP = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+claveMPBotella +" AND Estatus = 1";
						Statement stmt3 = con.creaStatement();
						ResultSet infoMP = null;
						infoMP = stmt3.executeQuery(queryDetalleMP);
						while(infoMP.next()){
							if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
								String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + 1 WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
								Statement stmt6 = con.creaStatement();
								stmt6.execute(updateMP);
							}
							else{
								String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + 1 WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
								Statement stmt6 = con.creaStatement();
								stmt6.execute(updateMP);
							}
						}
					}
					// LO QUE COMBINA
					if(rsDatos.getInt("CB1") > 0 ){
						ResultSet interino = null;
						String queryDameMP = "SELECT materia0 FROM BEBIDAS WHERE clave = "+rsDatos.getInt("CB1") +" AND estatus = 1";
						Statement stInterno = con.creaStatement();
						interino = stInterno.executeQuery(queryDameMP);
						int claveMPBotella = 0;
						while (interino.next()){
							claveMPBotella = interino.getInt("materia0");
						}
						String queryDetalleMP = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+claveMPBotella +" AND Estatus = 1";
						Statement stmt3 = con.creaStatement();
						ResultSet infoMP = null;
						infoMP = stmt3.executeQuery(queryDetalleMP);
						while(infoMP.next()){
							// Botella Grande
							if(rsDatos.getInt("TB1") == 3){
								if(infoMP.getDouble("litrosXBotella1") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA1")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella2") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA1")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA1")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA1")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
							else{
								if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA1")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA1")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
						}
					}
					if(rsDatos.getInt("CB2") > 0 ){
						ResultSet interino = null;
						String queryDameMP = "SELECT materia0 FROM BEBIDAS WHERE clave = "+rsDatos.getInt("CB2") +" AND estatus = 1";
						Statement stInterno = con.creaStatement();
						interino = stInterno.executeQuery(queryDameMP);
						int claveMPBotella = 0;
						while (interino.next()){
							claveMPBotella = interino.getInt("materia0");
						}
						String queryDetalleMP = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+claveMPBotella +" AND Estatus = 1";
						Statement stmt3 = con.creaStatement();
						ResultSet infoMP = null;
						infoMP = stmt3.executeQuery(queryDetalleMP);
						while(infoMP.next()){
							// Botella Grande
							if(rsDatos.getInt("TB2") == 3){
								if(infoMP.getDouble("litrosXBotella1") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA2")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella2") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA2")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA2")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA2")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
							else{
								if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA2")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA2")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
						}
					}
					if(rsDatos.getInt("CB3") > 0 ){
						ResultSet interino = null;
						String queryDameMP = "SELECT materia0 FROM BEBIDAS WHERE clave = "+rsDatos.getInt("CB3") +" AND estatus = 1";
						Statement stInterno = con.creaStatement();
						interino = stInterno.executeQuery(queryDameMP);
						int claveMPBotella = 0;
						while (interino.next()){
							claveMPBotella = interino.getInt("materia0");
						}
						String queryDetalleMP = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+claveMPBotella +" AND Estatus = 1";
						Statement stmt3 = con.creaStatement();
						ResultSet infoMP = null;
						infoMP = stmt3.executeQuery(queryDetalleMP);
						while(infoMP.next()){
							// Botella Grande
							if(rsDatos.getInt("TB3") == 3){
								if(infoMP.getDouble("litrosXBotella1") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA3")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella2") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA3")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA3")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA3")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
							else{
								if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA3")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA3")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
						}
					}
					if(rsDatos.getInt("CB4") > 0 ){
						ResultSet interino = null;
						String queryDameMP = "SELECT materia0 FROM BEBIDAS WHERE clave = "+rsDatos.getInt("CB4") +" AND estatus = 1";
						Statement stInterno = con.creaStatement();
						interino = stInterno.executeQuery(queryDameMP);
						int claveMPBotella = 0;
						while (interino.next()){
							claveMPBotella = interino.getInt("materia0");
						}
						String queryDetalleMP = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+claveMPBotella +" AND Estatus = 1";
						Statement stmt3 = con.creaStatement();
						ResultSet infoMP = null;
						infoMP = stmt3.executeQuery(queryDetalleMP);
						while(infoMP.next()){
							// Botella Grande
							if(rsDatos.getInt("TB4") == 3){
								if(infoMP.getDouble("litrosXBotella1") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA4")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella2") == 0){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA4")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA4")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA4")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
							else{
								if(infoMP.getDouble("litrosXBotella1") > infoMP.getDouble("litrosXBotella2")){
									String updateMP= "UPDATE materiaprima SET inventarioBotella2 = inventarioBotella2 + "+rsDatos.getInt("CA4")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
								else{
									String updateMP= "UPDATE materiaprima SET inventarioBotella1 = inventarioBotella1 + "+rsDatos.getInt("CA4")+" WHERE clave  = "+claveMPBotella +" AND Estatus = 1";
									Statement stmt6 = con.creaStatement();
									stmt6.execute(updateMP);
								}
							}
						}
					}
				}
			}
		 }
		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = 1;
		 con.realizaRollback();
		 //System.out.println("Excepcion SQL en bean ManagerVentas, Metodo: update_Bajas_Productos.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = 1;
		 con.realizaRollback();
		 //System.out.println("Excepcion en bean ManagerVentas, Metodo: update_Bajas_Productos.\n");
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



 public int update_Pago_Total_Comanda_Baja (String comanda) throws SQLException, Exception{
	 int exito = 0;

	 int com = cambiaAInt(comanda);
	 ResultSet rs = null;
	 double totalTodos = 0.0;

	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		//System.out.println(ar);

          String queryString = ("SELECT SUM(PT) AS total FROM comandapro WHERE IDC = "+com+" AND PT != 0.00 AND Estatus = 1");
          System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		totalTodos = rs.getDouble("total");
		  }

			String updateTotal = "UPDATE comanda SET PT = "+totalTodos+" WHERE IDC = "+com+" AND Es = 1";
			//System.out.println("updateTotal "+updateTotal);
			Statement stmt2 = con.creaStatement();
			stmt2.execute(updateTotal);

		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = 1;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerVentas, Metodo: update_Pago_Total_Comanda.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = 1;
		 con.realizaRollback();
		 System.out.println("Excepcion en bean ManagerVentas, Metodo: update_Pago_Total_Comanda.\n");
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
* El Método dameComandasXTiempo nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComandasXTiempo(String fechai, String fechaf){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT IDC, PT FROM comanda WHERE CONCAT(FA,' ',TA) BETWEEN '"+fechai+" 11:59:59'  AND '"+aumentaDia(fechaf)+" 11:59:58'  AND Es = 0");
//			System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, dameComandasXTiempo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, dameComandasXTiempo ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameComandasXTiempoXMesera nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComandasXTiempoXMesera(String fechai, String fechaf, String mesera){
		ResultSet rs = null;
		try{
			int mes = cambiaAInt(mesera);
			String query = ("SELECT DISTINCT IDC, PT FROM comanda WHERE IDM = "+mes+" AND CONCAT(FA,' ',TA) BETWEEN '"+fechai+" 11:59:59' AND '"+aumentaDia(fechaf)+" 11:59:58'  AND Es = 0");
//			System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, dameComandasXTiempoXMesera ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, dameComandasXTiempoXMesera ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameComandasXTiempoSinCobrar nos regresa un listado con todas las compras efectuadas en un lapso de tiempo a un proveedor
*
* @return ResultSet correspondiente a las compras que entran dentro del criterio de fechas y proveedor
*/
	public ResultSet dameComandasXTiempoSinCobrar(String fechai, String fechaf){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT IDC, FA, PT FROM comanda WHERE CONCAT(FA,' ',TA) BETWEEN '"+fechai+" 11:59:59'  AND '"+aumentaDia(fechaf)+" 11:59:58'  AND (Es = 2 OR Es = 1)");
//			System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, dameComandasXTiempoSinCobrar ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, dameComandasXTiempoSinCobrar ");
			e.printStackTrace();
		}
		return rs;
	}




 public void cierraConexion() throws SQLException, Exception
 {
	 if(con != null){
		try{
			con.cierraConexion();
		}
		catch (Exception q){
		System.out.println("Error al momento de cerrar conexion en ManagerVentas, datosUsuario ");
		q.printStackTrace();
		}
	}

}

 public void cierraConexion2() throws SQLException, Exception
 {
	 if(con2 != null){
		try{
			con2.cierraConexion();
		}
		catch (Exception q){
		System.out.println("Error al momento de cerrar conexion2 en ManagerVentas, datosUsuario ");
		q.printStackTrace();
		}
	}

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


		private String checkSize2 (String revisa){
			StringBuffer verificador = new StringBuffer(revisa);
			if (verificador.length() ==1){
				verificador.insert(0,"0");
				verificador.insert(1,"0");
			}
			if (verificador.length() ==2){
				verificador.insert(0,"0");
			}
			return verificador.toString();
	}
// Le aumenta a una fecha un día.
	public String aumentaDia(String fecha) throws Exception{
		Calendar tiempoPirata;
		tiempoPirata = Calendar.getInstance();
		tiempoPirata.clear();
		String anio = fecha.substring(0,4);
		String mes = fecha.substring(5,7);
		String dia = fecha.substring(8,fecha.length());
		tiempoPirata.set(Integer.parseInt(anio),(Integer.parseInt(mes)-1),Integer.parseInt(dia));
		tiempoPirata.add(Calendar.DATE, 1);
		int diaSemana = tiempoPirata.get(Calendar.DAY_OF_WEEK);
		StringBuilder cadena = new StringBuilder();
		anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
		int mesI = tiempoPirata.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mesI+""));
		int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(diaI+""));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		return cadena.toString();
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

// Funcion generica que regresa un objeto Calendar a partir de un String tipo Fecha.(aaaa-mm-dd)
	public Calendar formatoCalendar(String formato) throws Exception{
		//System.out.println("Entro: "+formato);
		int anio =  Integer.parseInt(formato.substring(0,formato.indexOf("-")));
		int mes = Integer.parseInt(formato.substring((formato.indexOf("-")+1), formato.lastIndexOf("-")));
		int dia = Integer.parseInt(formato.substring((formato.lastIndexOf("-")+1), formato.length()));
		//System.out.println("año: "+anio);
		//System.out.println("mes: "+mes);
		//System.out.println("dia: "+dia);
		Calendar temporal = Calendar.getInstance();
		temporal.clear();
		temporal.set(anio, mes-1, dia);
		//System.out.println("Temporal: "+temporal);
		return temporal;
	}

}