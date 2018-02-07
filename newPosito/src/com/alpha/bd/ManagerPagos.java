package com.alpha.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;
import java.math.BigDecimal;
import java.math.RoundingMode;


/**
* La clase "ManagerPagos" es la encargada de administrar los datos correspondientes a los ManagerPagos como son Altas, Bajas, Consultas, Actualizaciones, Ingresos, Gastos, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 3.0 (Abril 2006)
*/

public class ManagerPagos {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;
  private CalculaDate cd;



/**
* El método ManagerPagos es el constructor vacio de la clase.
*/

  public ManagerPagos()   { }




/**
* El Método comprasXproveedorSinPagar nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet comprasXproveedorSinPagar(String proveedor){
		ResultSet rs = null;
		try{
			String query = ("SELECT orden_compra.claveOrden, orden_compra.fechaRegistro, facturas.docAval, facturas.tipoDoc, orden_compra.total FROM orden_compra, facturas WHERE orden_compra.claveProveedor = '"+proveedor +"' AND orden_compra.activo = 1 AND orden_compra.entrega != 0 AND orden_compra.pago != 2 AND facturas.claveOrden = orden_compra.claveOrden ORDER BY orden_compra.claveOrden");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPagos, comprasXproveedorSinPagar ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPagos, comprasXproveedorSinPagar ");
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
				System.out.println("Error al momento de cerrar conexion en ManagerPagos ");
				q.printStackTrace();
			}
		}
	}
/**
* El Método comprasXproveedorPagadas nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet comprasXproveedorPagadas(String proveedor){
		ResultSet rs = null;
		try{
			String query = ("SELECT orden_compra.claveOrden, orden_compra.fechaRegistro, facturas.docAval, facturas.tipoDoc, orden_compra.total FROM orden_compra, facturas WHERE orden_compra.claveProveedor =  '"+proveedor +"'  AND orden_compra.activo = 1 AND orden_compra.entrega != 0 AND orden_compra.pago != 0 AND facturas.claveOrden = orden_compra.claveOrden ORDER BY  orden_compra.claveOrden DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPagos, comprasXproveedorPagadas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPagos, comprasXproveedorPagadas ");
			e.printStackTrace();
		}
		return rs;
	}

/**
* El Método comprasXproveedorPagadas2 nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet comprasXproveedorPagadas2(String proveedor){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fecha, total FROM orden_compra WHERE claveProveedor = '"+proveedor +"' AND activo = 1 AND entrega != 0 AND pago != 0 ORDER BY claveOrden DESC");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPagos, comprasXproveedorPagadas2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPagos, comprasXproveedorPagadas2 ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método comprasXproveedorPorPagar nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet comprasXproveedorPorPagar(String proveedor){
		ResultSet rs = null;
		try{
			String query = ("SELECT claveOrden, fechaRegistro, total FROM orden_compra WHERE claveProveedor = '"+proveedor +"' AND activo = 1 AND entrega != 0 AND pago != 2");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPagos, comprasXproveedorPorPagar ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPagos, comprasXproveedorPorPagar ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método comprasXproveedorPorPagarHoy nos regresa todas las Claves de Ordenes de Compras de un Proveedor en especifico.
*
*  @return rs ResultSet con las Claves de las Ordenes de Compra.
*/
	public ResultSet comprasXproveedorPorPagarHoy(String tipoConsulta, String fecha) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = "";
				if(tipoConsulta.equals("1")){
					query = ("SELECT orden_compra.claveOrden, proveedores.nombre,  orden_compra.fechaRegistro, orden_compra.fechaEntrega, orden_compra.fechaPago,       orden_compra.total, pagado FROM (orden_compra, proveedores) LEFT JOIN (SELECT SUM(pagos.monto)as pagado, pagos.claveOrden FROM pagos WHERE  pagos.activo = 1 GROUP BY pagos.claveOrden) AS kiko ON kiko.claveOrden = orden_compra.claveOrden WHERE orden_compra.activo = 1 AND orden_compra.Entrega != 0 AND orden_compra.pago != 2 AND proveedores.rfc = orden_compra.claveProveedor ORDER BY proveedores.nombre,orden_compra.fechaPago");
					Statement stmt = con.creaStatement();
					rs = stmt.executeQuery(query);
				}
				else{
					fecha = fecha.substring(6,10)+"-" +fecha.substring(0,2)+"-" +fecha.substring(3,5);
					query = ("SELECT orden_compra.claveOrden, proveedores.nombre, orden_compra.fechaRegistro, orden_compra.fechaEntrega, orden_compra.fechaPago, orden_compra.total, pagado FROM (orden_compra, proveedores)  LEFT JOIN (SELECT SUM(pagos.monto)as pagado, pagos.claveOrden FROM pagos WHERE  pagos.activo = 1 GROUP BY pagos.claveOrden) AS kiko ON kiko.claveOrden = orden_compra.claveOrden WHERE orden_compra.fechaPago = '"+fecha +"' AND orden_compra.activo = 1 AND orden_compra.Entrega != 0 AND orden_compra.pago != 2 AND proveedores.rfc = orden_compra.claveProveedor ORDER BY proveedores.nombre,orden_compra.fechaPago");
					Statement stmt = con.creaStatement();
					rs = stmt.executeQuery(query);
				}
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerPagos, comprasXproveedorPorPagarHoy ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerPagos, comprasXproveedorPorPagarHoy ");
				e.printStackTrace();
			}
		}
		return rs;
	}



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
			System.out.println("Ocurrio un Error en ManagerPagos, fechaMasDias ");
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
			String query = ("SELECT total FROM orden_compra WHERE ClaveOrden = '"+cla+"' AND activo = 1 AND pago != 2");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPagos, dameTotal ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPagos, dameTotal ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El método damePagos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet damePagos(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT fechaPago, monto FROM pagos WHERE claveOrden = "+cla+" AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query damePagos.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving damePagos.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método damePagosCompra se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet damePagosCompra(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT consecutivo, fechaPago, monto FROM pagos WHERE claveOrden = "+cla+" AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query damePagosCompra.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving damePagosCompra.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El método damePagosCompra2 se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet damePagosCompra2(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM pagos WHERE claveOrden = "+clave+" AND activo = 1 ORDER BY consecutivo DESC");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
			sqle.printStackTrace();
          error = "SQLException: Could not execute the query damePagosCompra2.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving damePagosCompra2.";
          throw new Exception(error);
        }
        return rs;
  }

/**
* El método damePagosCompra3 se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet damePagosCompra3(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        int cla = cambiaAInt(clave);
        try  {
          String queryString = ("SELECT * FROM pagos WHERE claveOrden = "+cla+" AND formaPago = 2 AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query damePagosCompra3.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving damePagosCompra3.";
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
  	  		rs = st.executeQuery("select sum(monto) AS suma FROM pagos WHERE claveOrden = "+cla+" AND activo = 1");
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
					System.out.println("Error al cerrar conexion de ManagerPagos metodo valida_Total");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }


/**
* El método totalIgual verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

	public int totalIgual(String clave, String total, String monto) throws SQLException, Exception  {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 0;
		int cla = cambiaAInt(clave);
		double anteriores = 0.00;
		double to = cambiaADouble(total);
		double mo = cambiaADouble(monto);
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("select sum(monto) AS suma FROM pagos WHERE claveOrden = "+cla+" AND activo = 1");
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
			}
			catch (Exception ex) {
				ex.printStackTrace();}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPagos metodo totalIgual");
					q.printStackTrace();
				}
			}
		}
	return bandera;
	}


/**
* El método totalIgual verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public double totalPagado(String clave) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
  	  int cla = cambiaAInt(clave);
  	  double total = 0.0;

		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select sum(monto) AS suma FROM pagos WHERE claveOrden = "+cla+" AND activo = 1");
  	  		while(rs.next()){
				total = rs.getDouble("suma");
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPagos metodo totalIgual");
					q.printStackTrace();
				}

			}
  	  }
  	  return total;
  }


/**
* El método add_Pago se encarga de añadir los datos de un nuevo Ingreso correspondientes a un cuenta bancaria dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
* 0 --> OK, 1 --> monto mayor a Faltante, 2 --> Error SQL
*/
	public synchronized int   add_Pago(String ClaveOrden, String proveedor, String fecha, String importe, String formaPago, String cheque,  String total, String usuario) throws SQLException, Exception {
		int fin = 0;
		boolean yaCubierto = false;
		double montoTotal = 0.00;
		double montoYaPagado = 0.00;
		BigDecimal montoACubrir = new BigDecimal("0.00");
		BigDecimal montoPrevio = new BigDecimal("0.00");
		BigDecimal montoActual = new BigDecimal(remueveComas(importe));
		con = new ConexionBD();
		if(con != null){
			try {
				con.cancelaAutoCommit();
				Statement stmt = con.creaStatement();
				ResultSet rs = null;
				// verifico que no me hayan querido meter gol ingresando dos veces el pago
				String dameTotalTransaccion = "SELECT total FROM orden_compra WHERE claveOrden = "+ClaveOrden+" AND activo = 1";
				rs = stmt.executeQuery(dameTotalTransaccion);
				while (rs.next()){
					montoACubrir = new BigDecimal(rs.getString("total"));
				}
				rs.close();
				stmt.close();
				stmt = con.creaStatement();
				String dameMontoYaPagados = "SELECT SUM(monto)AS monto  FROM pagos WHERE claveOrden = "+ClaveOrden +" AND activo = 1";
				rs = stmt.executeQuery(dameMontoYaPagados);
				while (rs.next() ){
					if(rs.getString("monto") != null){
						montoPrevio = new BigDecimal(rs.getString("monto"));
					}
				}
				rs.close();
				stmt.close();
				montoActual = montoActual.add(montoPrevio);
				montoActual = montoActual.setScale(2, RoundingMode.HALF_UP);
				montoACubrir = montoACubrir.setScale(2, RoundingMode.HALF_UP);
				if(montoActual.compareTo(montoACubrir) == 1){
					fin = 1;
				}
				else{
					if(montoActual.compareTo(montoACubrir) == 0){
						yaCubierto = true;
					}
					if(montoActual.compareTo(montoACubrir) == 0 || montoActual.compareTo(montoACubrir) == -1){
						PreparedStatement modificaSaldo;
						modificaSaldo = con.miConnection.prepareStatement("UPDATE proveedores SET saldoDisponible = (saldoDisponible + ?) WHERE rfc = ? AND activo = 1");
						modificaSaldo.setDouble(1, cambiaADouble(importe));
						modificaSaldo.setString(2, proveedor);
						modificaSaldo.execute();
						PreparedStatement altaPago;
						altaPago = con.miConnection.prepareStatement("insert into pagos values(?,?,?,?,?,?,?,?,?,?);");
						altaPago.setNull(1, java.sql.Types.INTEGER);
						altaPago.setInt(2, cambiaAInt(ClaveOrden));
						altaPago.setString(3, proveedor);
						altaPago.setString(4, fecha);
						altaPago.setDouble(5, cambiaADouble(importe));
						altaPago.setInt(6, cambiaAInt(formaPago));
						altaPago.setString(7, cheque);
						altaPago.setInt(8, 0);
						altaPago.setInt(9, 1);
						altaPago.setString(10, usuario);
						altaPago.execute();
						if(yaCubierto){
							String queryString2 = "UPDATE orden_compra SET pago = 2 WHERE claveOrden = "+ClaveOrden;
    			          	Statement stmt2 = con.miConnection.createStatement();
    			          	stmt2.execute(queryString2);
    			          	stmt2.close();
						}
						else{
							String queryString2 = "UPDATE orden_compra SET pago = 1 WHERE claveOrden = "+ClaveOrden;
    			          	Statement stmt2 = con.miConnection.createStatement();
    			          	stmt2.execute(queryString2);
    			          	stmt2.close();
						}
					}
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				System.out.println("SQLException: metodo add_Pago, bean ManagerPagos");
				fin = 3;
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: metodo add_Pago, bean ManagerPagos";
				throw new SQLException(error);
			}
			catch (Exception q){
				fin = 3;
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPagos metodo add_Pago");
					q.printStackTrace();
				}
			}
		}
		else{
			fin = 3;
		}
	 	return fin;
	}


/**
* El método bajaPago se encarga de actualizar los datos de una Cuenta dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Proveedor a actualizar.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Dirección del Proveedor.
*	@param	colonia		String con la Colonia del Proveedor
*	@param	delegacion	String con la Delegación del Proveedor.
*	@param	cp			String con el Código Postal del Proveedor.
*/
	public boolean bajaPago(String clave) throws SQLException, Exception {
		boolean fin = true;
		con = new ConexionBD();
		if(con != null){
			try  {
				con.cancelaAutoCommit();
				ResultSet rs0 = null;
				double pagoAnterior = 0.0;
				String proveedor = "";
				int claveOrden = 0;
				String datosPro = "SELECT claveProveedor, claveOrden, monto FROM pagos WHERE consecutivo = "+clave;
				Statement dame = con.creaStatement();
				rs0 = dame.executeQuery(datosPro);
				while(rs0.next()){
					proveedor = rs0.getString("claveProveedor");
					pagoAnterior = rs0.getDouble("monto");
					claveOrden = rs0.getInt("claveOrden");
				}
				rs0.close();
				dame.close();
				// Descuento otra vez saldoDisponible
				String cambiaSaldo = "UPDATE proveedores SET saldoDisponible = saldoDisponible-"+pagoAnterior+" WHERE rfc = '"+proveedor+"'";
				Statement cambiar = con.miConnection.createStatement();
				cambiar.execute(cambiaSaldo);
				cambiar.close();
				// Cambio el Estatus de Activo a Baja.
				String queryString = "UPDATE pagos SET activo = 0 WHERE consecutivo = "+clave;
				Statement stmt = con.miConnection.createStatement();
				stmt.execute(queryString);
				stmt.close();
				//Verifico si tengo mas pagos para dejar el estado en parcialmente pagado o cambio a  sin pagos.
				ResultSet rs10 = null;
				String queryString10 = "SELECT SUM(monto)AS monto FROM pagos WHERE claveOrden = "+claveOrden +" AND activo = 1";
//				System.out.println(queryString10);
				Statement stmt10 = con.miConnection.createStatement();
				rs10 = stmt10.executeQuery(queryString10);
				boolean conMasPagos = false;
				while(rs10.next()){
					if(rs10.getDouble("monto") > 0){
						conMasPagos = true;
					}
				}
				rs10.close();
				stmt10.close();
				if(!conMasPagos){
					String queryString8 = "UPDATE orden_compra SET pago = 0 WHERE claveOrden = "+claveOrden;
					Statement stmt8 = con.miConnection.createStatement();
					stmt8.execute(queryString8);
					stmt8.close();
				}
				else{
					String queryString8 = "UPDATE orden_compra SET pago = 1 WHERE claveOrden = "+claveOrden;
					Statement stmt8 = con.miConnection.createStatement();
					stmt8.execute(queryString8);
					stmt8.close();
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
					fin = false;
					con.realizaRollback();
					sqle.printStackTrace();
					error = "SQLException: Falló UpDate, posible valor duplicado de Entrada en ManagerPagos";
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
					System.out.println("Error al cerrar conexion de ManagerPagos metodo baja_Pago");
					q.printStackTrace();
				}
			}
		}
		else{
			fin = false;
		}
	return fin;
    }

/**
* El método totalIgual verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public int dameClaveGasto(String clave) throws SQLException, Exception
    {

	con = new ConexionBD();
	  	  Statement st = null;
	  	  Statement st2 = null;
	  	  ResultSet rs= null;
		  ResultSet rs2= null;
	  	  int bandera = 0;
	  	  int cla = cambiaAInt(clave);
	  	  String con1 = "Pago a la Compra #";
	  	  String fe = new String("");
	  	  double monto = 0.0;
	  	  int ban = 0;

  	  	try {

  	  		st = con.miConnection.createStatement();
  	  		rs = st.executeQuery("select claveOrden,fechaPago,monto,bancoCuenta FROM pagos WHERE consecutivo = "+cla+"");
  	  		while(rs.next()){
				con1 = con1+rs.getString("claveOrden");
				fe = rs.getString("fechaPago");
				monto = rs.getDouble("monto");
				ban = rs.getInt("bancoCuenta");
  	  		}

  	  		st2 = con.miConnection.createStatement();
  	  		rs2 = st2.executeQuery("select clave FROM gastos WHERE bancoCuenta = "+ban+" AND fecha = '"+fe+"' AND concepto = '"+con1+"' AND importe = "+monto+"");
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
					System.out.println("Error al cerrar conexion de ManagerPagos metodo dameClaveGasto");
					q.printStackTrace();
				}

			}
  	  return bandera;
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
		variable = remueveComas(variable);
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

	public double roundDBL(double targetDBL){
		int decimalPlace = 2;
		BigDecimal bd = new BigDecimal(targetDBL);
		bd = bd.setScale(2, RoundingMode.HALF_UP);
		return (bd.doubleValue());
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