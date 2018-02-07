package com.ult.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.math.BigDecimal;

/**
* La clase "ManagerCobros" es la encargada de administrar los datos correspondientes a los ManagerPagos como son Altas, Bajas, Consultas, Actualizaciones, Ingresos, Gastos, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Abril 2006)
*/

public class ManagerCobros {

  String error;
  private ConexionBD con = null;
  private ConexionBD conA = null;
  private ConexionBD conB = null;
  private ConexionBD conC = null;
  private ConexionBD conD = null;
  private ConexionBD conE= null;

  private ConexionBD con2 = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;
  private CalculaDate cd;



/**
* El método ManagerCobros es el constructor vacio de la clase.
*/

  public ManagerCobros()   { }



public boolean existe(String factura) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from facturaventa WHERE activo = 1");
  	  		while(rs.next()){

  	  			if(factura.equalsIgnoreCase(rs.getString("factura"))) {
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
					System.out.println("Error al cerrar conexion de ManagerClientes metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



/**
* El Método dameTotal nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet dameTotal(String clave)throws SQLException, Exception{
		ResultSet rs = null;
		int cla = cambiaAInt(clave);
		try{
			String query = ("SELECT PT FROM comanda WHERE IDC = "+cla+" AND Es = 1");
			//System.out.printn
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, dameTotal ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, dameTotal ");
			e.printStackTrace();
		}
		return rs;
	}


	public ResultSet dameTotal2(String clave)throws SQLException, Exception{
		ResultSet rs = null;
		int cla = cambiaAInt(clave);
		try{
			String query = ("SELECT PT FROM comanda WHERE IDC = "+cla+" AND Es = 2");
			//System.out.printn
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, dameTotal ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, dameTotal ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El método dameCobros se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameCobros(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT consecutivo, fechaCobro, monto, formaPago FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCobros.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCobros.";
          throw new Exception(error);
        }
      return rs;
  }



 public ResultSet dameCobros2(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT consecutivo, fechaCobro, monto, formaPago FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCobros.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCobros.";
          throw new Exception(error);
        }
      return rs;
  }


/**
* El método dameCobrosNoFacturados se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameCobrosNoFacturados(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT DISTINCT consecutivo, fechaCobro, monto, formaPago FROM cobros WHERE claveVenta = "+cla+" AND activo = 1 AND facturado = 0");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCobrosNoFacturados.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCobrosNoFacturados.";
          throw new Exception(error);
        }
      return rs;
  }



/**
* El método damePropinas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet damePropinas(String fecha) throws SQLException, Exception  {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT claveVenta, propina FROM cobros WHERE fechaCobro BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' AND activo = 1 AND propina > 0.00");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query damePropinas.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving damePropinas.";
          throw new Exception(error);
        }
      return rs;
  }



/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Teléfono del Proveedor.
*/
  public int valida_add(String fecha, String importe, String formaPago) {
		int verifica = 2;
		boolean revisa = ((fecha != null) && (fecha.length() > 0) &&
				(importe != null) && (importe.length() > 0) &&
				(formaPago != null) && (formaPago.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método valida_add3 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Teléfono del Proveedor.
*/
  public int valida_add3(String mesa) {
		int verifica = 2;
		boolean revisa = ((mesa != null) && (mesa.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método valida_add2 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Teléfono del Proveedor.
*/
  public int valida_add2(String rfc, String factura) {
		int verifica = 2;
		boolean revisa = ((rfc != null) && (rfc.length() > 0) &&
				(factura != null) && (factura.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método valida_Total verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean valida_Total(String clave, String total, String monto) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
  	  int cla = cambiaAInt(clave);
	  double anteriores = 0.0;
	  double to = cambiaADouble(total);
	  double mo = cambiaADouble(monto);

		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select sum(monto) AS suma FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
  	  		while(rs.next()){
				anteriores = rs.getDouble("suma");
  	  		}

  	  		anteriores = anteriores + mo;

  	  		if(anteriores > to){
				bandera = false;
			}
			else{
				bandera = true;
			}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo valida_Total");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }

/**
* El método valida_Total verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

	public boolean valida_Total_Facturado(String comanda, String cobro) throws SQLException, Exception    {
		Statement st = null;
		ResultSet rs= null;
		boolean bandera = false;
		Statement st2 = null;
		ResultSet rs2= null;
		Statement st3 = null;
		ResultSet rs3= null;
		int cla = cambiaAInt(comanda);
		double anteriores = 0.0;
		double to = 0.00;
		double actual = 0.00;
		int cob = cambiaAInt(cobro);
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("select sum(monto) AS suma FROM facturaventa WHERE comanda = "+cla+" AND activo = 1");
				while(rs.next()){
					anteriores = rs.getDouble("suma");
				}
				st2 = con.creaStatement();
				rs2 = st2.executeQuery("select PT FROM comanda WHERE IDC = "+cla+" AND ES = 0");
				while(rs2.next()){
					to = rs2.getDouble("PT");
				}
				st3 = con.creaStatement();
				rs3 = st3.executeQuery("select monto FROM cobros WHERE consecutivo = "+cob+" AND activo = 1");
				while(rs3.next()){
					actual = rs3.getDouble("monto");
				}
				anteriores = anteriores + actual;
				if(anteriores > to){
					bandera = false;
				}
				else{
					bandera = true;
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
					System.out.println("Error al cerrar conexion de ManagerCobros metodo valida_Total_Facturado");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}



/**
* El método add_Cobro se encarga de añadir los datos de un nuevo Ingreso correspondientes a un cuenta bancaria dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public boolean add_Cobro(String ClaveVenta, String fecha, String importe, String formaPago, String observaciones, String total, String mes, String propina, String usuario) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;
		ResultSet rs =null;
		ResultSet rs2 =null;
		importe = remueveComas(importe);

		double impo = cambiaADouble(importe);
		tiempo = new TimeStamp();
		int clave = cambiaAInt(ClaveVenta);
		int fp = cambiaAInt(formaPago);
		int mesa = cambiaAInt(mes);
		double prop = cambiaADouble(propina);
		//System.out.println(mesa);

		int actual = totalIgual(ClaveVenta,total,importe);
		//System.out.println("pago: "+actual);

		con = new ConexionBD();
		con.cancelaAutoCommit();
			try {


				PreparedStatement altaCobro;
				altaCobro = con.miConnection.prepareStatement("insert into cobros values(?,?,?,?,?,?,?,?,?,?);");
				altaCobro.setNull(1, java.sql.Types.INTEGER);
				altaCobro.setInt(2, clave);
				altaCobro.setString(3, tiempo.datetime);
				altaCobro.setDouble(4, impo);
				altaCobro.setInt(5, fp);
				altaCobro.setString(6, observaciones);
				altaCobro.setInt(7, 1);
				altaCobro.setDouble(8, prop);
				altaCobro.setString(9,usuario);
				altaCobro.setDouble(10, 0);

				altaCobro.execute();

				if(actual == 2){
					String queryString2 = "UPDATE comanda SET Es = 0 WHERE IDC = "+clave+"";
              		Statement stmt2 = con.miConnection.createStatement();
              		stmt2.execute(queryString2);

					String queryString3 = "UPDATE comandapro SET Estatus = 2 WHERE IDC = "+clave+" AND Estatus = 1";
					Statement stmt3 = con.miConnection.createStatement();
					stmt3.execute(queryString3);

					String queryString4 = "UPDATE mesas SET Estatus = 0 WHERE IDMesa = "+mesa+"";
					//System.out.println(queryString4);
              		Statement stmt4 = con.miConnection.createStatement();
              		stmt4.execute(queryString4);

          			String queryString5 = ("SELECT * FROM mesas WHERE LigaA = "+mesa+" AND Estatus = 2");
          			//System.out.println(queryString5);
          			Statement stmt5 = con.miConnection.createStatement();
          			rs2 = stmt5.executeQuery(queryString5);
          			while(rs2.next()){

						String queryString6 = "UPDATE mesas SET Estatus = 0, LigaA = null WHERE IDMesa = "+rs2.getInt("IDMesa")+"";
						//System.out.println(queryString6);
						Statement stmt6 = con.miConnection.createStatement();
						stmt6.execute(queryString6);
					}

				}

			}
			catch (SQLException sqle) {
				fin = false;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerCobros";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo add_Cobro");
					q.printStackTrace();
				}
			}

	 return fin;
	}



/**
* El método add_Cobro_Pendiente se encarga de añadir los datos de un nuevo Ingreso correspondientes a un cuenta bancaria dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public boolean add_Cobro_Pendiente(String mes, int clave) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;
		ResultSet rs =null;
		ResultSet rs2 =null;

		int mesa = cambiaAInt(mes);

		con = new ConexionBD();
		con.cancelaAutoCommit();
			try {

				String queryString2 = "UPDATE comanda SET Es = 2 WHERE IDC = "+clave+"";
				Statement stmt2 = con.miConnection.createStatement();
				stmt2.execute(queryString2);

				String queryString3 = "UPDATE comandapro SET Estatus = 2 WHERE IDC = "+clave+" AND Estatus = 1";
				Statement stmt3 = con.miConnection.createStatement();
				stmt3.execute(queryString3);

				String queryString4 = "UPDATE mesas SET Estatus = 0 WHERE IDMesa = "+mesa+"";
				//System.out.println(queryString4);
				Statement stmt4 = con.miConnection.createStatement();
				stmt4.execute(queryString4);

				String queryString5 = ("SELECT * FROM mesas WHERE LigaA = "+mesa+" AND Estatus = 2");
				//System.out.println(queryString5);
				Statement stmt5 = con.miConnection.createStatement();
				rs2 = stmt5.executeQuery(queryString5);
				while(rs2.next()){

					String queryString6 = "UPDATE mesas SET Estatus = 0, LigaA = null WHERE IDMesa = "+rs2.getInt("IDMesa")+"";
					//System.out.println(queryString6);
					Statement stmt6 = con.miConnection.createStatement();
					stmt6.execute(queryString6);
				}


			}
			catch (SQLException sqle) {
				fin = false;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerCobros";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo add_Cobro_Pendiente");
					q.printStackTrace();
				}
			}

	 return fin;
	}



	public boolean bajaCobro(String ClaveCobro) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;
		ResultSet rs =null;
		ResultSet rs2 =null;

		int clave = cambiaAInt(ClaveCobro);
		int comanda = 0;
		int mesa = 0;
		//System.out.println(mesa);


		con = new ConexionBD();
		con.cancelaAutoCommit();
			try {

				String queryString5 = ("SELECT claveVenta FROM cobros WHERE consecutivo = "+clave+" AND activo = 1");
				//System.out.println(queryString5);
				Statement stmt5 = con.miConnection.createStatement();
				rs2 = stmt5.executeQuery(queryString5);
				while(rs2.next()){

					comanda = rs2.getInt("claveVenta");
				}

				String queryString = ("SELECT IDMM FROM comanda WHERE IDC = "+comanda+"");
				//System.out.println(queryString5);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){

					mesa = rs.getInt("IDMM");
				}

				String queryString2 = "UPDATE cobros SET activo = 0 WHERE consecutivo = "+clave+"";
				Statement stmt2 = con.miConnection.createStatement();
				stmt2.execute(queryString2);

				String queryString3 = "UPDATE comanda SET Es = 1 WHERE IDC = "+comanda+"";
				Statement stmt3 = con.miConnection.createStatement();
				stmt3.execute(queryString3);

				String queryString4 = "UPDATE comandapro SET Estatus = 1 WHERE IDC = "+comanda+" AND Estatus != 0";
				Statement stmt4 = con.miConnection.createStatement();
				stmt4.execute(queryString4);

				String queryString6 = "UPDATE mesas SET Estatus = 1, LigaA = null WHERE IDMesa = "+mesa+"";
				//System.out.println(queryString6);
				Statement stmt6 = con.miConnection.createStatement();
				stmt6.execute(queryString6);

			}
			catch (SQLException sqle) {
				fin = false;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerCobros";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo bajaCobro");
					q.printStackTrace();
				}
			}

	 return fin;
	}


	public boolean bajaCobro2(String ClaveCobro) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;
		ResultSet rs =null;
		ResultSet rs2 =null;

		int clave = cambiaAInt(ClaveCobro);
		int comanda = 0;
		int mesa = 0;
		//System.out.println(mesa);


		con = new ConexionBD();
		con.cancelaAutoCommit();
			try {

				String queryString5 = ("SELECT claveVenta FROM cobros WHERE consecutivo = "+clave+" AND activo = 1");
				//System.out.println(queryString5);
				Statement stmt5 = con.miConnection.createStatement();
				rs2 = stmt5.executeQuery(queryString5);
				while(rs2.next()){

					comanda = rs2.getInt("claveVenta");
				}

				String queryString = ("SELECT IDMM FROM comanda WHERE IDC = "+comanda+"");
				//System.out.println(queryString5);
				Statement stmt = con.miConnection.createStatement();
				rs = stmt.executeQuery(queryString);
				while(rs.next()){

					mesa = rs.getInt("IDMM");
				}

				String queryString2 = "UPDATE cobros SET activo = 0 WHERE consecutivo = "+clave+"";
				Statement stmt2 = con.miConnection.createStatement();
				stmt2.execute(queryString2);

				String queryString3 = "UPDATE comanda SET Es = 2 WHERE IDC = "+comanda+"";
				Statement stmt3 = con.miConnection.createStatement();
				stmt3.execute(queryString3);


			}
			catch (SQLException sqle) {
				fin = false;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerCobros";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = false;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo bajaCobro");
					q.printStackTrace();
				}
			}

	 return fin;
	}

	public String dameFechaHoyFactura() throws Exception{
		String laFecha = "";
		tiempo = new TimeStamp();
		String dia = tiempo.date;
		String hora = tiempo.time;
		int laHora = cambiaAInt(hora.substring(0,2));
		if(laHora == 0 || laHora == 1  || laHora == 2  || laHora == 3 || laHora == 4 || laHora == 5 || laHora == 6 || laHora == 7 || laHora == 8 || laHora == 9 || laHora == 10 || laHora == 11){
			laFecha = restaDia(dia);
		}
		else{
			laFecha = dia;
		}
		laFecha = laFecha.substring(8,10)+"/"+laFecha.substring(5,7)+"/"+laFecha.substring(0,4);
		return laFecha;
	}

	public static void main (String[ ] args) throws Exception{
		ManagerCobros mc = new ManagerCobros();
		mc.dameFechaHoyFactura();
	}



	public synchronized boolean  almacenaFacturaGlobal(String fecha,String  total,String  factura) throws SQLException, Exception {
		boolean exito = true;
		con = new ConexionBD();
		if(con != null){
			try {
					PreparedStatement altaFacturaG;
					altaFacturaG = con.miConnection.prepareStatement("insert into facturaventa values(?,?,?,?,?,?,?,?,?);");
					altaFacturaG.setNull(1, java.sql.Types.INTEGER);
					altaFacturaG.setInt(2, 0);
					altaFacturaG.setString(3, fecha);
					altaFacturaG.setInt(4, 0);
					altaFacturaG.setString(5, factura);
					altaFacturaG.setString(6, fecha);
					altaFacturaG.setDouble(7,cambiaADouble( total));
					altaFacturaG.setString(8, "Global");
					altaFacturaG.setInt(9, 1);
					altaFacturaG.execute();
			}
			catch (SQLException sqle) {
				 exito = false;
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerCobros almacenaFacturaGlobal";
				throw new SQLException(error);
			}
			catch (Exception q){
				exito = false;
				q.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo add_Factura");
					q.printStackTrace();
				}
			}
		}
		else{
			exito = false;
		}
		return exito;
	}


// 1 OK , 2 ERROR, 3 NO HAY CONEXION.
/**
* El método add_Factura se encarga de añadir los datos de un nuevo Ingreso correspondientes a un cuenta bancaria dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public synchronized int  add_Factura(String rfc, String factura, String[ ] cobro, String comanda) throws SQLException, Exception {
		int resultado = 1;
		Statement st = null;
		ResultSet rs= null;
		String fecha = "";
		tiempo = new TimeStamp();
		String hoy = tiempo.datetime;
		con = new ConexionBD();
		double monto = 0.00;
		if(con != null){
			try {
				con.cancelaAutoCommit();
				st = con.creaStatement();
				rs = st.executeQuery("SELECT  FA,TA FROM comanda WHERE IDC = "+comanda+" AND ES = 0");
				while(rs.next()){
					fecha = rs.getString("FA")+" "+rs.getString("TA");
				}
				rs.close();
				st.close();
				for(int i = 0; i<cobro.length; i++){
					st = con.creaStatement();
					rs = st.executeQuery("SELECT monto FROM cobros WHERE consecutivo = "+cobro[i]+" AND activo = 1");
					while(rs.next()){
						monto = rs.getDouble("monto");
					}
					rs.close();
					st.close();
					String queryString2 = "UPDATE cobros SET facturado = 1 WHERE consecutivo = "+cobro[i];
					st = con.creaStatement();
					st.execute(queryString2);
					PreparedStatement altaFactura;
					altaFactura = con.miConnection.prepareStatement("insert into facturaventa values(?,?,?,?,?,?,?,?,?);");
					altaFactura.setNull(1, java.sql.Types.INTEGER);
					altaFactura.setInt(2, cambiaAInt(comanda));
					altaFactura.setString(3, fecha);
					altaFactura.setInt(4, cambiaAInt(cobro[i]));
					altaFactura.setString(5, factura);
					altaFactura.setString(6, hoy);
					altaFactura.setDouble(7, monto);
					altaFactura.setString(8, rfc);
					altaFactura.setInt(9, 1);
					altaFactura.execute();
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				resultado = 2;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerCobros";
				throw new SQLException(error);
			}
			catch (Exception q){
				resultado = 2;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo add_Factura");
					q.printStackTrace();
				}
			}
		}
		else{
			resultado = 3;
		}
		return resultado;
	}



/**
* El método totalIgual verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public int totalIgual(String clave, String total, String monto) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
  	  int cla = cambiaAInt(clave);
	  double anteriores = 0.0;
	  double to = cambiaADouble(total);
	  double mo = cambiaADouble(monto);

		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select sum(monto) AS suma FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
  	  		while(rs.next()){
				anteriores = roundDBL(rs.getDouble("suma"));
  	  		}
			anteriores = anteriores + roundDBL(mo);
			if(roundDBL(anteriores) >= to){
				bandera = 2;
			}
			else{
				bandera = 1;
			}
			//System.out.println("bandera: "+bandera);

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo totalIgual");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }




/**
* El método dameCorteCajaTC se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
	public ResultSet dameCorteCajaTC(String fecha) throws SQLException, Exception {
		String complemento = "(";
		boolean primera = true;
		if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
			int anioActual = cambiaAInt(fecha.substring(0,4));
			int mesActual = cambiaAInt(fecha.substring(5,7));
			int limite = 31;
			if (mesActual == 4 ||  mesActual == 6 || mesActual == 9 || mesActual == 11){
				limite = 30;
			}
			else if(mesActual == 2){
				if(anioActual%(4) == 0){
					limite = 29;
				}
				else{
					limite = 28;
				}
			}
			mesActual += 1;
			if(mesActual == 13){
				mesActual = 1;
				anioActual +=1;
			}
			for(int i = 1;  i<=limite; i++){
				if(primera){
					complemento +=" cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
					primera = false;
				}
				else{
					complemento += " OR   cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
				}
			}
			complemento += ")";
		}
		else{
			complemento += " cobros.fechaCobro BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' )";
		}
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT DISTINCT cobros.consecutivo, cobros.claveVenta, cobros.monto, cobros.usuario, cobros.facturado, comanda.IDMM FROM cobros, comanda WHERE "+complemento +"  AND cobros.formaPago = 4 AND cobros.activo = 1 AND comanda.IDC = cobros.claveVenta");
			//System.out.println(queryString);
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameCorteCajaTC.";
			sqle.printStackTrace();
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteCajaTC.";
			throw new Exception(error);
		}
		return rs;
	}



/**
* El método dameCorteCajaTC se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
	public ResultSet dameCorteCajaTD(String fecha) throws SQLException, Exception {
		String complemento = "(";
		boolean primera = true;
	 	if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
			int anioActual = cambiaAInt(fecha.substring(0,4));
			int mesActual = cambiaAInt(fecha.substring(5,7));
			int limite = 31;
			if (mesActual == 4 ||  mesActual == 6 || mesActual == 9 || mesActual == 11){
				limite = 30;
			}
			else if(mesActual == 2){
				if(anioActual%(4) == 0){
					limite = 29;
				}
				else{
					limite = 28;
				}
			}
			mesActual += 1;
			if(mesActual == 13){
				mesActual = 1;
				anioActual +=1;
			}
			for(int i = 1;  i<=limite; i++){
				if(primera){
					complemento +=" cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
					primera = false;
				}
				else{
					complemento += " OR   cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
				}
			}
			complemento += ")";
		}
		else{
			complemento += " cobros.fechaCobro BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' )";
		}
		ResultSet rs = null;
		conA = new ConexionBD();
		try  {
			String queryString = ("SELECT DISTINCT cobros.consecutivo, cobros.claveVenta, cobros.monto, cobros.usuario,  cobros.facturado, comanda.IDMM FROM cobros, comanda WHERE "+complemento +" AND cobros.formaPago = 5 AND cobros.activo = 1 AND comanda.IDC = cobros.claveVenta");
			//System.out.println(queryString);
			Statement stmt = conA.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameCorteCajaTD.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameCorteCajaTD.";
			throw new Exception(error);
		}
		return rs;
	}

	public void cierraConexionA() throws SQLException, Exception{
		try{
			if(conA != null){
				conA.cierraConexion();
			}
		}
		catch(SQLException sqle){
			sqle.printStackTrace();
		}
	}


/**
* El método dameCorteCajaTC se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameCorteCajaE(String fecha) throws SQLException, Exception  {
	 String complemento = "(";
	boolean primera = true;
 	if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
		int anioActual = cambiaAInt(fecha.substring(0,4));
		int mesActual = cambiaAInt(fecha.substring(5,7));
		int limite = 31;
		if (mesActual == 4 ||  mesActual == 6 || mesActual == 9 || mesActual == 11){
			limite = 30;
		}
		else if(mesActual == 2){
			if(anioActual%(4) == 0){
				limite = 29;
			}
			else{
				limite = 28;
			}
		}
		mesActual += 1;
			if(mesActual == 13){
				mesActual = 1;
				anioActual +=1;
			}
			for(int i = 1;  i<=limite; i++){
				if(primera){
					complemento +=" cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
					primera = false;
				}
				else{
					complemento += " OR   cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
				}
			}
			complemento += ")";
		}
		else{
			complemento += " cobros.fechaCobro BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' )";
		}
        ResultSet rs = null;
        conB = new ConexionBD();
        try  {
          String queryString = ("SELECT DISTINCT cobros.consecutivo, cobros.claveVenta, cobros.monto, cobros.usuario,  cobros.facturado, comanda.IDMM FROM cobros, comanda WHERE "+complemento +" AND cobros.formaPago = 1 AND cobros.activo = 1  AND comanda.IDC = cobros.claveVenta");
         //System.out.println(queryString);
          Statement stmt = conB.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query dameCorteCajaTC.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCorteCajaTC.";
          throw new Exception(error);
        }
      return rs;
  }

	public void cierraConexionB() throws SQLException, Exception{
		try{
			if(conB != null){
				conB.cierraConexion();
			}
		}
		catch(SQLException sqle){
			sqle.printStackTrace();
		}
	}

	 public ResultSet dameCorteCajaES(String fecha) throws SQLException, Exception {
		String complemento = "(";
		boolean primera = true;
		if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
			int anioActual = cambiaAInt(fecha.substring(0,4));
			int mesActual = cambiaAInt(fecha.substring(5,7));
			int limite = 31;
			if (mesActual == 4 ||  mesActual == 6 || mesActual == 9 || mesActual == 11){
				limite = 30;
			}
			else if(mesActual == 2){
				if(anioActual%(4) == 0){
					limite = 29;
				}
				else{
					limite = 28;
				}
			}
			mesActual += 1;
			if(mesActual == 13){
				mesActual = 1;
				anioActual +=1;
			}
			for(int i = 1;  i<=limite; i++){
				if(primera){
					complemento +=" fac.fechaFactura  BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
					primera = false;
				}
				else{
					complemento += " OR   fac.fechaFactura  BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
				}
			}
			complemento += ")";
		}
		else{
			complemento += " fac.fechaFactura BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' )";
		}

        ResultSet rs = null;
        conC = new ConexionBD();
        try  {
          String queryString = ("SELECT fac.cobro, fac.comanda, fac.monto, co.usuario, com.IDMM FROM facturaventa fac, cobros co, comanda com WHERE "+complemento +" AND fac.activo = 1 AND fac.cobro = co.consecutivo AND co.formaPago = 1  AND com.IDC = co.claveVenta");
         //System.out.println("-->\n"+queryString);
          Statement stmt = conC.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query dameCorteCajaES.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCorteCajaES.";
          throw new Exception(error);
        }
      return rs;
  }

	public void cierraConexionC() throws SQLException, Exception{
		try{
			if(conC != null){
				conC.cierraConexion();
			}
		}
		catch(SQLException sqle){
			sqle.printStackTrace();
		}
	}

	 public ResultSet dameCorteCajaEC(String fecha) throws SQLException, Exception {
		String complemento = "(";
		boolean primera = true;
	 	if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
			int anioActual = cambiaAInt(fecha.substring(0,4));
			int mesActual = cambiaAInt(fecha.substring(5,7));
			int limite = 31;
			if (mesActual == 4 ||  mesActual == 6 || mesActual == 9 || mesActual == 11){
				limite = 30;
			}
			else if(mesActual == 2){
				if(anioActual%(4) == 0){
					limite = 29;
				}
				else{
					limite = 28;
				}
			}
			mesActual += 1;
				if(mesActual == 13){
					mesActual = 1;
					anioActual +=1;
				}
			for(int i = 1;  i<=limite; i++){
				if(primera){
					complemento +=" cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
					primera = false;
				}
				else{
					complemento += " OR   cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
				}
			}
			complemento += ")";
		}
		else{
			complemento += " cobros.fechaCobro  BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58'  )";
		}
        ResultSet rs = null;
        conD = new ConexionBD();
        try  {
          String queryString = ("SELECT DISTINCT cobros.consecutivo, cobros.claveVenta, cobros.monto, cobros.usuario,  cobros.facturado, comanda.IDMM FROM cobros, comanda WHERE "+complemento +" AND cobros.activo = 1 AND cobros.facturado = 0 AND cobros.formaPago = 1 AND comanda.IDC = cobros.claveVenta  AND cobros.claveVenta = ANY (SELECT DISTINCT cobros.claveVenta FROM cobros WHERE "+complemento +" AND cobros.activo = 1 AND cobros.facturado = 0 AND (cobros.formaPago = 4 OR cobros.formaPago = 5))");
        	//System.out.println("EC -->\n"+queryString);
          Statement stmt = conD.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCorteCajaEC.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCorteCajaEC.";
          throw new Exception(error);
        }
      return rs;
  }

	public void cierraConexionD() throws SQLException, Exception{
		try{
			if(conD != null){
				conD.cierraConexion();
			}
		}
		catch(SQLException sqle){
			sqle.printStackTrace();
		}
	}


 public ResultSet dameCorteCajaTCSinFacturar(String fecha) throws SQLException, Exception {
	String complemento = "";
 	if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
		int anioActual = cambiaAInt(fecha.substring(0,4));
		int mesActual = cambiaAInt(fecha.substring(5,7));
		mesActual += 1;
			if(mesActual == 13){
				mesActual = 1;
				anioActual +=1;
			}
			complemento = " fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-01 11:59:59' AND '"+anioActual+"-"+mesActual+"-01 11:59:58' ";
		}
		else{
			complemento = " fechaCobro BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' ";
		}

        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT monto FROM cobros WHERE "+complemento +" AND (formaPago = 4 OR formaPago = 5)  AND activo = 1 AND facturado = 0");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCorteCajaTCSinFacturar.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCorteCajaTCSinFacturar.";
          throw new Exception(error);
        }
      return rs;
  }


 public ResultSet dameCorteCajaASinFacturar(String fecha) throws SQLException, Exception {
	String complemento = "";
 	if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
		int anioActual = cambiaAInt(fecha.substring(0,4));
		int mesActual = cambiaAInt(fecha.substring(5,7));
		mesActual += 1;
			if(mesActual == 13){
				mesActual = 1;
				anioActual +=1;
			}
			complemento = " fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-01 11:59:59' AND '"+anioActual+"-"+mesActual+"-01 11:59:58' ";
		}
		else{
			complemento = " fechaCobro BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' ";
		}

        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT monto FROM cobros WHERE "+complemento +" AND formaPago = 5 AND activo = 1 AND facturado = 0");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query dameCorteCajaASinFacturar.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCorteCajaASinFacturar.";
          throw new Exception(error);
        }
      return rs;
  }


 public ResultSet dameCorteCajaESinFacturar(String fecha) throws SQLException, Exception {
		String complemento = "(";
		boolean primera = true;
		boolean entroComparacion = false;
	 	if((fecha.substring(fecha.length()-1,fecha.length())).equalsIgnoreCase("%")){
			int anioActual = cambiaAInt(fecha.substring(0,4));
			int mesActual = cambiaAInt(fecha.substring(5,7));
			int limite = 31;
			if (mesActual == 4 ||  mesActual == 6 || mesActual == 9 || mesActual == 11){
				limite = 30;
			}
			else if(mesActual == 2){
				if(anioActual%(4) == 0){
					limite = 29;
				}
				else{
					limite = 28;
				}
			}
			mesActual += 1;
			if(mesActual == 13){
				mesActual = 1;
				anioActual +=1;
			}
			for(int i = 1;  i<=limite; i++){
				if(primera){
					complemento +=" cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
					primera = false;
				}
				else{
					complemento += " OR   cobros.fechaCobro BETWEEN '"+fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i)+" 11:59:59' AND '"+aumentaDia(fecha.substring(0,4)+"-"+fecha.substring(5,7)+"-"+checkSize(i))+" 11:59:58'  ";
				}
			}
			complemento += ")";
		}
		else{
			complemento += " fechaCobro BETWEEN '"+fecha+" 11:59:59' AND '"+aumentaDia(fecha)+" 11:59:58' )";
		}
        ResultSet rs = null;
        conE = new ConexionBD();
        try  {
			String queryEntrada = "SELECT DISTINCT cobros.claveVenta FROM cobros WHERE "+complemento +" AND cobros.activo = 1 AND cobros.facturado = 0 AND (cobros.formaPago = 4 OR cobros.formaPago = 5) LIMIT 1";
			Statement stmt1 = conE.creaStatement();
			ResultSet rs2 = stmt1.executeQuery(queryEntrada);
			while (rs2.next()){
				entroComparacion = true;
			}
			String queryString = "";
			if(entroComparacion){
				queryString = ("SELECT consecutivo, claveVenta, SUM(monto) AS Monto, usuario FROM cobros WHERE   "+complemento +" AND formaPago = 1 AND activo = 1 AND facturado = 0 AND monto >  0.00 AND cobros.claveVenta NOT IN (SELECT DISTINCT cobros.claveVenta FROM cobros WHERE "+complemento +" AND cobros.activo = 1 AND cobros.facturado = 0 AND (cobros.formaPago = 4 OR cobros.formaPago = 5)) GROUP BY claveVenta ORDER BY monto ASC");
			}
			else{
				queryString = ("SELECT consecutivo, claveVenta, SUM(monto) AS Monto, usuario FROM cobros WHERE   "+complemento +" AND formaPago = 1 AND activo = 1 AND facturado = 0 AND monto >  0.00 GROUP BY claveVenta ORDER BY monto ASC");
			}
			//System.out.println("Sin F-->\n"+queryString);
			Statement stmt = conE.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query dameCorteCajaESinFacturar.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCorteCajaESinFacturar.";
          throw new Exception(error);
        }
      return rs;
  }

	public void cierraConexionE() throws SQLException, Exception{
		try{
			if(conE != null){
				conE.cierraConexion();
			}
		}
		catch(SQLException sqle){
			sqle.printStackTrace();
		}
	}

public boolean tieneComanda(String comanda) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select claveVenta from cobros WHERE activo = 1");
  	  		while(rs.next()){

  	  			if(comanda.equalsIgnoreCase(rs.getString("claveVenta"))) {
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



 public double dameMonto(String[ ] clave) throws SQLException, Exception {
        ResultSet rs = null;
        double monto = 0.00;
        String complemento = "(";
        boolean primerPaso = true;
        for (int i = 0; i < clave.length; i++){
			if(primerPaso){
				primerPaso = false;
				complemento += " consecutivo = "+clave[i];
			}
			else{
				complemento += " OR consecutivo = "+clave[i];
			}
		}
		complemento += " ) ";
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT SUM(monto)AS monto FROM cobros WHERE "+complemento);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
          while(rs.next()){
		  		monto = rs.getDouble("monto");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameMonto.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameMonto.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerCobros metodo dameMonto");
		   		q.printStackTrace();
		  	}
		}
        return monto;
  }


 public String dameMesa(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String mesa = "";
        int co = cambiaAInt(clave);
        con2 = new ConexionBD();
        try  {
          String queryString = ("SELECT IDMM FROM comanda WHERE IDC = "+co+"");
          Statement stmt = con2.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		mesa = rs.getString("IDMM");
		  }
		  rs.close();
		  stmt.close();
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameMesa.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameMesa.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con2.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerCobros metodo dameMesa");
		   		q.printStackTrace();
		  	}
		}
        return mesa;
  }


 public String dameFactura(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String fac = "";
        int cob = cambiaAInt(clave);
        con2 = new ConexionBD();
        try  {
          String queryString = ("SELECT factura FROM facturaventa WHERE cobro = "+cob+" AND activo = 1");
          Statement stmt = con2.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
          while(rs.next()){
		  		fac = rs.getString("factura");
		  }
		  rs.close();
		  stmt.close();
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameMonto.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameMonto.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con2.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerCobros metodo dameFactura");
		   		q.printStackTrace();
		  	}
		}
        return fac;
  }


	public boolean yaExisteFacturaGlobal(String fecha) throws SQLException, Exception{
		ResultSet rs = null;
		boolean bandera = false;
		con = new ConexionBD();
		if(con != null){
			try{
				String queryBusqueda = "SELECT consecutivo FROM facturaVenta WHERE rfc = 'Global' AND activo = 1 AND fechaFactura LIKE '"+fecha +" "+"00:00:00'";
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryBusqueda);
				while(rs.next()) {
					bandera = true;
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				bandera = true;
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query yaExisteFacturaGlobal.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				bandera = true;
				e.printStackTrace();
				error = "An exception occured while retrieving yaExisteFacturaGlobal.";
				throw new Exception(error);
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobrosmetodo yaExisteFacturaGlobal");
					q.printStackTrace();
				}
			}
		}
		else{
			bandera = true;
		}
		return bandera;
	}



	public boolean yaUsadaFactura(String factura) throws SQLException, Exception{
		ResultSet rs = null;
		boolean bandera = false;
		con = new ConexionBD();
		if(con != null){
			try{
				String queryBusqueda = "SELECT factura FROM facturaVenta WHERE activo = 1 AND factura = '"+factura +"'";
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryBusqueda);
				while(rs.next()) {
					bandera = true;
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle) {
				bandera = true;
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query yaUsadaFactura.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				bandera = true;
				e.printStackTrace();
				error = "An exception occured while retrieving yaUsadaFactura.";
				throw new Exception(error);
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobrosmetodo yaUsadaFactura");
					q.printStackTrace();
				}
			}
		}
		else{
			bandera = true;
		}
		return bandera;
	}


	public boolean baja_Factura(String factura) throws SQLException, Exception {
		ResultSet rs = null;
		boolean bandera = true;
		int cobro = 0;
		con = new ConexionBD();
		try  {
			con.cancelaAutoCommit();
			String queryString = "UPDATE facturaventa SET activo = 0 WHERE factura ='"+factura+"'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
			stmt.close();
			String queryString3 = ("SELECT cobro FROM facturaventa WHERE factura = '"+factura+"'");
			Statement stmt3 = con.miConnection.createStatement();
			rs = stmt3.executeQuery(queryString3);
			while(rs.next()){
				cobro = rs.getInt("cobro");
				String queryString2 = "UPDATE cobros SET facturado = 0 WHERE consecutivo = "+cobro+"";
				Statement stmt2 = con.miConnection.createStatement();
				stmt2.execute(queryString2);
				stmt2.close();
			}
			rs.close();
			stmt3.close();
			con.realizaCommit();
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query.";
			con.realizaRollback();
			throw new SQLException(error);
		}
		catch (Exception e) {
			e.printStackTrace();
			error = "An exception occured while retrieving.";
			con.realizaRollback();
			throw new Exception(error);
		}
		finally{
			try{
				con.habilitaAutoCommit();
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerCobrosmetodo baja_Factura");
				q.printStackTrace();
			}
		}
		return bandera;
	}



















/**
* El Método cobranzaXDia nos regresa la cobranza correspondiente a un día solicitado.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet cobranzaXDia(String fecha){
		ResultSet rs = null;
		try{
			String query = ("SELECT DISTINCT ventas.claveVenta, clientes.nombre, cobros.monto FROM cobros,  ventas, clientes WHERE cobros.activo = 1 AND cobros.fechaCobro = '"+fecha +"' AND  ventas.claveVenta = cobros.claveVenta AND clientes.rfc = ventas.claveCliente ORDER BY clientes.nombre");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, cobranzaXDia ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, cobranzaXDia ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método ventasXclienteSinCobrar nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet ventasXclienteSinCobrar(String cliente){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveVenta, fechaAlta, total FROM ventas WHERE claveCliente = '"+cliente +"' AND activo = 1 AND entrega != 0 AND pago != 2");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, ventasXclienteSinCobrar ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, ventasXclienteSinCobrar ");
			e.printStackTrace();
		}
		return rs;
	}




/**
* El método dameSumaCobrados verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public double dameSumaCobrados(String clave) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int cla = cambiaAInt(clave);
	  double to = 0.0;

		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select sum(monto) AS suma FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
  	  		while(rs.next()){
				to = rs.getDouble("suma");
  	  		}
  	  		//System.out.println("suma: "+anteriores);

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo dameSumaCobrados");
					q.printStackTrace();
				}

			}
  	  }
  	  return to;
  }


/**
* El Método todasLasVentasXClienteListado nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet todasLasVentasXClienteListado(String claveCliente){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveVenta, fechaAlta, total, tipo, factura, remision, pago FROM ventas WHERE claveCliente = '"+claveCliente +"' AND activo = 1 AND entrega != '0'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, todasLasVentasXClienteListado ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, todasLasVentasXClienteListado ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El método dameCobrosVenta se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameCobrosVenta(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT consecutivo, fechaCobro, monto FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCobrosVenta.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCobrosVenta.";
          throw new Exception(error);
        }
      return rs;
  }



/**
* El método dameClaveIngreso verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public int dameClaveIngreso(String clave) throws SQLException, Exception
    {

	con = new ConexionBD();
	  	  Statement st = null;
	  	  Statement st2 = null;
	  	  ResultSet rs= null;
		  ResultSet rs2= null;
	  	  int bandera = 0;
	  	  int cla = cambiaAInt(clave);
	  	  String con1 = "Cobro de la Venta #";
	  	  String fe = new String("");
	  	  double monto = 0.0;
	  	  int ban = 0;

  	  	try {

  	  		st = con.miConnection.createStatement();
  	  		rs = st.executeQuery("select consecutivo, claveVenta,fechaCobro,monto,bancoCuenta FROM cobros WHERE consecutivo = "+cla+"");
  	  		while(rs.next()){
				con1 = con1+rs.getString("claveVenta");
				fe = rs.getString("fechaCobro");
				monto = rs.getDouble("monto");
				ban = rs.getInt("bancoCuenta");
  	  		}

  	  		st2 = con.miConnection.createStatement();
  	  		rs2 = st2.executeQuery("select clave FROM ingresos WHERE bancoCuenta = "+ban+" AND fecha = '"+fe+"' AND concepto = '"+con1+"' AND importe = "+monto+"");
  	  		while(rs2.next()){
				bandera = rs2.getInt("clave");
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerCobros metodo dameClaveIngreso");
					q.printStackTrace();
				}

			}
  	  return bandera;
  }


/**
* El Método ventasXclienteCobradas nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet ventasXclienteCobradas(String cliente){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveVenta, fechaAlta, total FROM ventas WHERE claveCliente = '"+cliente +"' AND activo = 1 AND entrega != 0 AND pago != 0");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, ventasXclienteCobradas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, ventasXclienteCobradas ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El método dameCobrosVenta2 se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameCobrosVenta2(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT * FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameCobrosVenta2.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameCobrosVenta2.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El Método ventasXclientePorCobrar nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet ventasXclientePorCobrar(String cliente){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveVenta, fechaAlta, total FROM ventas WHERE claveCliente = '"+cliente +"' AND activo = 1 AND entrega != 0 AND pago != 2");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, ventasXclientePorCobrar ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, ventasXclientePorCobrar ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método ventasXclientePorCobrarListado nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet ventasXclientePorCobrarListado(String cliente){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveVenta, tipo, fechaEntrega, factura, remision, total FROM ventas WHERE claveCliente = '"+cliente +"' AND activo = 1 AND entrega != 0 AND pago != 2 ORDER BY claveVenta");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, ventasXclientePorCobrarListado ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, ventasXclientePorCobrarListado ");
			e.printStackTrace();
		}
		return rs;
	}



/****************************************************************************************************/


/**
* El Método fechaMasDias nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public boolean fechaMasDias(String entrega, int diasMas)throws Exception{
		boolean rs = true;
		try{

			cd = new CalculaDate();
			cd.parseaADate(entrega);
			cd.setNuevaFecha(diasMas);
			String fechaPago = cd.obtenDatos();

			tiempo = new TimeStamp();
			String hoy = tiempo.date;
			//System.out.println("Hoy :"+hoy);
			//System.out.println("diasMas: "+diasMas);
			//System.out.println("fechaPago :"+fechaPago);

			if(hoy.equalsIgnoreCase(fechaPago)){
				rs = true;
			}
			else{
				rs = false;
			}
			//System.out.println("regresa :"+rs);

		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, fechaMasDias ");
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
		System.out.println("Error al momento de cerrar conexion en ManagerPersonal, datosUsuario ");
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

		public String checkSize (int revisa){
			StringBuffer verificador = new StringBuffer(revisa+"");
			if (verificador.length() ==1){
				verificador.insert(0,"0");
			}
			return verificador.toString();
		}

		public String checkSize (String revisa){
			StringBuffer verificador = new StringBuffer(revisa);
			if (verificador.length() ==1){
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


// Le aumenta a una fecha un día.
	public String restaDia(String fecha) throws Exception{
		Calendar tiempoPirata;
		tiempoPirata = Calendar.getInstance();
		tiempoPirata.clear();
		String anio = fecha.substring(0,4);
		String mes = fecha.substring(5,7);
		String dia = fecha.substring(8,fecha.length());
		tiempoPirata.set(Integer.parseInt(anio),(Integer.parseInt(mes)-1),Integer.parseInt(dia));
		tiempoPirata.add(Calendar.DATE, -1);
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

	public double roundDBL(double targetDBL){
		int decimalPlace = 2;
		BigDecimal bd = new BigDecimal(targetDBL);
		bd = bd.setScale(decimalPlace,BigDecimal.ROUND_CEILING  );
		return (bd.doubleValue());
	}

	public double roundDBL2(double targetDBL){
		int decimalPlace = 2;
		BigDecimal bd = new BigDecimal(targetDBL);
		bd = bd.setScale(decimalPlace,BigDecimal.ROUND_HALF_UP  );
		return (bd.doubleValue());
	}

}