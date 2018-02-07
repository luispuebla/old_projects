package com.vas.bd;

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
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;
  private CalculaDate cd;



/**
* El método ManagerCobros es el constructor vacio de la clase.
*/

  public ManagerCobros()   { }


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
* El Método dameTotal nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet dameTotal(String clave)throws SQLException, Exception{
		ResultSet rs = null;
		int cla = cambiaAInt(clave);
		try{
			String query = ("SELECT total FROM ventas WHERE ClaveVenta = '"+cla+"' AND activo = 1 AND pago != 2");
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
          String queryString = ("SELECT fechaCobro, monto FROM cobros WHERE claveVenta = "+cla+" AND activo = 1");
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
* El método add_Cobro se encarga de añadir los datos de un nuevo Ingreso correspondientes a un cuenta bancaria dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*/
	public boolean add_Cobro(String ClaveVenta, String cliente, String fecha, String importe, String formaPago, String observaciones, String banco, String total) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = true;
		importe = remueveComas(importe);

		double impo = cambiaADouble(importe);

		int clave = cambiaAInt(ClaveVenta);
		int ba = cambiaAInt(banco);
		int fp = cambiaAInt(formaPago);

		int actual = totalIgual(ClaveVenta,total,importe);
		//System.out.println("pago: "+actual);

		con = new ConexionBD();
		con.cancelaAutoCommit();
			try {

				String cambiaSaldo = "UPDATE clientes SET saldoDisponible = saldoDisponible+"+impo+" WHERE rfc = '"+cliente+"' ";
				Statement cambiar = con.miConnection.createStatement();
				cambiar.execute(cambiaSaldo);


				PreparedStatement altaCobro;
				altaCobro = con.miConnection.prepareStatement("insert into cobros values(?,?,?,?,?,?,?,?,?);");
				altaCobro.setNull(1, java.sql.Types.INTEGER);
				altaCobro.setInt(2, clave);
				altaCobro.setString(3, cliente);
				altaCobro.setString(4, fecha);
				altaCobro.setDouble(5, impo);
				altaCobro.setInt(6, fp);
				altaCobro.setString(7, observaciones);
				altaCobro.setInt(8, ba);
				altaCobro.setInt(9, 1);

				altaCobro.execute();

				double original = 0.0;
				ResultSet rs = null;

            	String queryString0 = ("SELECT importeActual FROM bancos WHERE clave = "+ba+"");
            	Statement stmt = con.miConnection.createStatement();
           		rs = stmt.executeQuery(queryString0);
            	while(rs.next()){
					original = rs.getDouble("importeActual");
				}
				//System.out.println("tengo: "+original);
				original = original + impo;
				//System.out.println("aumento: "+original);

				String queryString = "UPDATE bancos SET importeActual = "+original+" WHERE clave = "+ba+"";
				//System.out.println("queryString: "+queryString);
             	Statement stmt1 = con.miConnection.createStatement();
              	stmt1.execute(queryString);

				PreparedStatement altaIngreso;
				altaIngreso = con.miConnection.prepareStatement("insert into ingresos values(?,?,?,?,?,?);");
				altaIngreso.setNull(1, java.sql.Types.INTEGER);
				altaIngreso.setInt(2, ba);
				altaIngreso.setString(3, fecha);
				altaIngreso.setString(4, "Cobro de la Venta #"+ClaveVenta);
				altaIngreso.setDouble(5, impo);
				altaIngreso.setInt(6, 1);

				altaIngreso.execute();

				String queryString2 = "UPDATE ventas SET pago = "+actual+" WHERE claveVenta = "+clave+"";
              	Statement stmt2 = con.miConnection.createStatement();
              	stmt2.execute(queryString2);

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

	public void cierraConexion() throws Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ManagerCobros ");
				q.printStackTrace();
			}
		}
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
* El método bajaCobro se encarga de actualizar los datos de una Cuenta dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Proveedor a actualizar.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*	@param	colonia		String con la Colonia del Proveedor
*	@param	delegacion	String con la Delegación del Proveedor.
*	@param	cp			String con el Código Postal del Proveedor.
*/
  public boolean bajaCobro(String clave) throws SQLException, Exception {
	boolean fin = true;
	int cla = cambiaAInt(clave);
	int aver = dameClaveIngreso(clave);
	int orden = 0;
	con = new ConexionBD();
	con.cancelaAutoCommit();
	try  {

		ResultSet rs0 = null;
		double pagoAnterior = 0.0;
		String cliente = new String();

		String datosCli = "SELECT claveCliente, monto FROM cobros WHERE consecutivo = "+cla+"";
		Statement dame = con.creaStatement();
		rs0 = dame.executeQuery(datosCli);
		while(rs0.next()){
			cliente = rs0.getString("claveCliente");
			pagoAnterior = rs0.getDouble("monto");
		}

		String cambiaSaldo = "UPDATE clientes SET saldoDisponible = saldoDisponible-"+pagoAnterior+" WHERE rfc = '"+cliente+"' ";
		Statement cambiar = con.miConnection.createStatement();
		cambiar.execute(cambiaSaldo);

		String queryString = "UPDATE cobros SET activo = 0 WHERE consecutivo = "+cla+"";
		Statement stmt = con.miConnection.createStatement();
		stmt.execute(queryString);

		ResultSet rs10 = null;
		String queryString10 = ("SELECT claveVenta FROM cobros WHERE consecutivo = "+cla+"");
		Statement stmt10 = con.miConnection.createStatement();
		rs10 = stmt10.executeQuery(queryString10);
		while(rs10.next()){
			orden = rs10.getInt("claveVenta");
		}

		String queryString8 = "UPDATE ventas SET pago = 1 WHERE claveVenta = "+orden+"";
		Statement stmt8 = con.miConnection.createStatement();
		stmt8.execute(queryString8);

		double original = 0.0;
		double impo = 0.0;
		int clave1 = 0;
		ResultSet rs = null;
		ResultSet rs1 = null;
		//System.out.println("1");
		String queryString1 = ("SELECT monto, bancoCuenta FROM cobros WHERE consecutivo = "+cla+"");
		Statement stmt1 = con.miConnection.createStatement();
		rs = stmt1.executeQuery(queryString1);
		while(rs.next()){
			impo = rs.getDouble("monto");
			clave1 = rs.getInt("bancoCuenta");
		}

		String queryString2 = ("SELECT importeActual FROM bancos WHERE clave = "+clave1+"");
		Statement stmt2 = con.miConnection.createStatement();
		rs1 = stmt2.executeQuery(queryString2);
		while(rs1.next()){
			original = rs1.getDouble("importeActual");
		}

		original = original - impo;

		String queryString3 = "UPDATE bancos SET importeActual = "+original+" WHERE clave = "+clave1+"";
		Statement stmt3 = con.miConnection.createStatement();
		stmt3.execute(queryString3);


		//System.out.println("4");
		//System.out.println("clave gasto "+aver);

		String queryString4 = "UPDATE ingresos SET activo = 0 WHERE clave = "+aver+"";
		//System.out.println("queryString5 "+queryString5);
		Statement stmt4 = con.miConnection.createStatement();
		stmt4.execute(queryString4);

		con.realizaCommit();

		}catch (SQLException sqle) {
				fin = false;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerCobros";
				throw new SQLException(error);
		}catch (Exception q){
				fin = false;
				con.realizaRollback();
				q.printStackTrace();
		}finally{
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


/**
* El Método datosVenta nos regresa los Datos de la Orden de Compra seleccionada.
*
*  @return rs ResultSet con los Datos de la Orden de Compra.
*/
	public ResultSet datosVenta(String clave) throws SQLException, Exception {
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			String query = ("SELECT * FROM ventas WHERE ClaveVenta = '"+cla+"'");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerCobros, datosVenta ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerCobros, datosVenta ");
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