package com.vas.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerBancos" es la encargada de administrar los datos correspondientes a los Bancos como son Altas, Bajas, Cambios, Consultas, Actualizaciones, Ingresos, Gastos, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sof�a Gabi�n D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fern�ndez J.</a>
* @version 3.0 (Abril 2006)
*/

public class ManagerBancos {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El m�todo ManagerBancos es el constructor vacio de la clase.
*/

  public ManagerBancos()   { }


/**
* El m�todo existe verifica que el banco solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del proveedor solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean existe(String banco, String numero) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from bancos");
  	  		while(rs.next()){

  	  			if(banco.equalsIgnoreCase(rs.getString("banco")) && numero.equalsIgnoreCase(rs.getString("numero"))) {
  	  				bandera = true;//realiza comparaci�n con la base de datos
  	  				}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerBancos metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



/**
* El m�todo valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tama�o menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Tel�fono del Proveedor.
*/
  public int valida_add(String banco, String numero, String importe) {
		int verifica = 2;
		boolean revisa = ((banco != null) && (banco.length() > 0) &&
				(numero != null) && (numero.length() > 0) &&
				(importe != null) && (importe.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }


/**
* El m�todo valida_add2 verifica que todas las variales que se le envian, no se encuentren NULL o con un tama�o menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Tel�fono del Proveedor.
*/
  public int valida_add2(String banco, String importe) {
		int verifica = 2;
		boolean revisa = ((banco != null) && (banco.length() > 0) &&
				(importe != null) && (importe.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }


/**
* El m�todo valida_add3 verifica que todas las variales que se le envian, no se encuentren NULL o con un tama�o menor a 0.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	tel1		String con Tel�fono del Proveedor.
*/
  public int valida_add3(String importe) {
		int verifica = 2;
		boolean revisa = ((importe != null) && (importe.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El m�todo add_Banco se encarga de a�adir los datos de un nuevo Proveedor dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a a�adir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Direcci�n del Proveedor.
*/
	public boolean add_Banco(String banco, String numero, String importe) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		importe = remueveComas(importe);

		double impo = cambiaADouble(importe);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {

				PreparedStatement altaBanco;
				altaBanco = con.miConnection.prepareStatement("insert into bancos values(?,?,?,?,?);");
				altaBanco.setNull(1, java.sql.Types.INTEGER);
				altaBanco.setString(2, numero);
				altaBanco.setString(3, banco);
				altaBanco.setDouble(4, impo);
				altaBanco.setDouble(5, impo);

				altaBanco.execute();
				fin = true;
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Fall� UpDate, posible valor duplicado de Entrada en ManagerBancos";
				throw new SQLException(error);
			}
			catch (Exception q){
				q.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerBancos metodo add_Banco");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexi�n a la Base de Datos perdida. En ManagerBancos";
			throw new Exception(error);
		}
	 return fin;
	}


/**
* El m�todo add_Ingreso se encarga de a�adir los datos de un nuevo Ingreso correspondientes a un cuenta bancaria dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a a�adir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Direcci�n del Proveedor.
*/
	public boolean add_Ingreso(String banco, String numero, String concepto, String importe, String fecha) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		importe = remueveComas(importe);

		double impo = cambiaADouble(importe);

		int clave = dameClave(banco, numero);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {

				PreparedStatement altaIngreso;
				altaIngreso = con.miConnection.prepareStatement("insert into ingresos values(?,?,?,?,?,?);");
				altaIngreso.setNull(1, java.sql.Types.INTEGER);
				altaIngreso.setInt(2, clave);
				altaIngreso.setString(3, fecha);
				altaIngreso.setString(4, concepto);
				altaIngreso.setDouble(5, impo);
				altaIngreso.setInt(6, 1);

				altaIngreso.execute();
				fin = true;

				if(fin){

					double original = 0.0;
					ResultSet rs = null;

            		String queryString0 = ("SELECT importeActual FROM bancos WHERE clave = "+clave+"");
            		Statement stmt = con.miConnection.createStatement();
           			rs = stmt.executeQuery(queryString0);
            		while(rs.next()){
						original = rs.getDouble("importeActual");
					}

					original = original + impo;

					String queryString = "UPDATE bancos SET importeActual = "+original+" WHERE clave = "+clave+"" ;
             		Statement stmt1 = con.miConnection.createStatement();
              		stmt1.execute(queryString);
              		fin = true;

				}
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Fall� UpDate, posible valor duplicado de Entrada en ManagerBancos";
				throw new SQLException(error);
			}
			catch (Exception q){
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerBancos metodo add_Ingreso");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexi�n a la Base de Datos perdida. En ManagerBancos";
			throw new Exception(error);
		}
	 return fin;
	}

/**
* El m�todo add_Gasto se encarga de a�adir los datos de un nuevo Ingreso correspondientes a un cuenta bancaria dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a a�adir del nuevo Proveedor.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Direcci�n del Proveedor.
*/
	public boolean add_Gasto(String banco, String numero, String concepto, String importe, String fecha) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		importe = remueveComas(importe);

		double impo = cambiaADouble(importe);

		int clave = dameClave(banco, numero);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {

				PreparedStatement altaIngreso;
				altaIngreso = con.miConnection.prepareStatement("insert into gastos values(?,?,?,?,?,?);");
				altaIngreso.setNull(1, java.sql.Types.INTEGER);
				altaIngreso.setInt(2, clave);
				altaIngreso.setString(3, fecha);
				altaIngreso.setString(4, concepto);
				altaIngreso.setDouble(5, impo);
				altaIngreso.setInt(6, 1);

				altaIngreso.execute();
				fin = true;

				if(fin){

					double original = 0.0;
					ResultSet rs = null;

            		String queryString0 = ("SELECT importeActual FROM bancos WHERE clave = "+clave+"");
            		Statement stmt = con.miConnection.createStatement();
           			rs = stmt.executeQuery(queryString0);
            		while(rs.next()){
						original = rs.getDouble("importeActual");
					}

					original = original - impo;

					String queryString = "UPDATE bancos SET importeActual = "+original+" WHERE clave = "+clave+"" ;
             		Statement stmt1 = con.miConnection.createStatement();
              		stmt1.execute(queryString);
              		fin = true;

				}

			}
			catch (SQLException sqle) {
				con.realizaRollback();
				sqle.printStackTrace();
				error = "SQLException: Fall� UpDate, posible valor duplicado de Entrada en ManagerBancos";
				throw new SQLException(error);
			}
			catch (Exception q){
				con.realizaRollback();
				q.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerBancos metodo add_Gasto");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexi�n a la Base de Datos perdida. En ManagerBancos";
			throw new Exception(error);
		}
	 return fin;
	}


/**
* El m�todo dameClave se encarga de enviar la clave registrada dentro de la Base de Datos correspondientes a una Cuenta Bancaria.
*	@return rs 	ResultSet que contiene todos los datos correspondiente a todos los Bancos.
*/
  public int dameClave(String banco, String numero) throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          int clave = 0;
          try  {
            String queryString = ("SELECT DISTINCT clave FROM bancos WHERE numero = '"+numero+"' AND banco = '"+banco+"'");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
            while(rs.next()){
				clave = rs.getInt("clave");
			}
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameClave.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameClave.";
            throw new Exception(error);
          }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerBancos metodo dameBancos");
			   		q.printStackTrace();
			 	}
		   }
          return clave;
  }



/**
* El m�todo dameBancos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Bancos que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 	ResultSet que contiene todos los datos correspondiente a todos los Bancos.
*/
  public ResultSet dameBancos() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT DISTINCT banco FROM bancos ORDER BY banco");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameBancos.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameBancos.";
            throw new Exception(error);
          }
          return rs;
  }

  public void cierraConexion() throws SQLException, Exception{
	 	if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerBancos ");
				q.printStackTrace();
			}
	   }
  }


/**
* El m�todo dameCuentas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todas las Cuentas que se encuentren activas.
*	@return rs 	ResultSet que contiene todos los datos correspondiente a todas las Cuentas.
*/
  public ResultSet dameCuentas(String banco) throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT DISTINCT numero FROM bancos WHERE banco = '"+banco+"' ORDER BY banco");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameCuentas.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameCuentas.";
            throw new Exception(error);
          }
          return rs;
  }



/**
* El m�todo datos_Cuenta se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet datos_Cuenta(String banco, String cuenta) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM bancos WHERE numero = '"+cuenta+"' AND banco = '"+banco+"'");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Cuenta.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Cuenta.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El m�todo bancoCuenta se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet bancoCuenta(String banco) throws SQLException, Exception
 {
        ResultSet rs = null;
        int ba = cambiaAInt(banco);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT numero,banco FROM bancos WHERE clave = "+ba+"");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query bancoCuenta.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving bancoCuenta.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El m�todo dameIngresos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameIngresos(int clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM ingresos WHERE bancoCuenta = "+clave+" AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameIngresos.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameIngresos.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El m�todo dameGastos se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameGastos(int clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM gastos WHERE bancoCuenta = "+clave+" AND activo = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameGastos.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameGastos.";
          throw new Exception(error);
        }
        return rs;
  }

/**
* El m�todo dameBalance se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a los Ingresos y Gastos de una Cuenta.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameBalance(int clave, String mes, String ano) throws SQLException, Exception
 {
        ResultSet rs = null;
        mes = checkSize(mes);
        String tiempo = ano+"-"+mes+"-%%";
        con = new ConexionBD();
        try  {
          String queryString = ("(SELECT ingresos.clave, ingresos.fecha, ingresos.concepto, ingresos.importe, '1' AS tipo FROM ingresos WHERE ingresos.fecha like '"+tiempo+"' AND ingresos.bancoCuenta = "+clave+" AND ingresos.activo = 1) UNION (SELECT gastos.clave, gastos.fecha, gastos.concepto, gastos.importe, '2' AS tipo FROM gastos WHERE gastos.fecha like '"+tiempo+"' AND gastos.bancoCuenta = "+clave+" AND gastos.activo = 1) ORDER BY fecha");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameBalance.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameBalance.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El m�todo dameTodo se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Bancos y todas la Cuentas.
*  	@param 	rfc  		String con el RFC del Proveedor solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Proveedor.
*/
 public ResultSet dameTodo() throws SQLException, Exception
 {
        ResultSet rs = null;
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM bancos ORDER BY banco");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameTodo.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameTodo.";
          throw new Exception(error);
        }
        return rs;
  }


/**
* El m�todo update_Cuenta se encarga de actualizar los datos de una Cuenta dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Proveedor a actualizar.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Direcci�n del Proveedor.
*	@param	colonia		String con la Colonia del Proveedor
*	@param	delegacion	String con la Delegaci�n del Proveedor.
*	@param	cp			String con el C�digo Postal del Proveedor.
*/
  public boolean update_Cuenta(String clave, String banco, String importeA) throws SQLException, Exception {

	  boolean fin = false;

		importeA = remueveComas(importeA);

		double impo = cambiaADouble(importeA);
		int cla = cambiaAInt(clave);

	  con = new ConexionBD();
            try  {
				String queryString = "UPDATE bancos SET banco = '"+banco+"', importeActual = "+impo+" WHERE clave = "+cla+"" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              fin = true;
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query update_Cuenta.";
              throw new SQLException(error);
            } catch (Exception e) {
              error = "Ocurri� una excepci�n mientras se actualizaba update_Cuenta.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerBancos metodo update_Cuenta");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }


/**
* El m�todo bajaIngreso se encarga de actualizar los datos de una Cuenta dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Proveedor a actualizar.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Direcci�n del Proveedor.
*	@param	colonia		String con la Colonia del Proveedor
*	@param	delegacion	String con la Delegaci�n del Proveedor.
*	@param	cp			String con el C�digo Postal del Proveedor.
*/
  public boolean bajaIngreso(String clave) throws SQLException, Exception {

	  boolean fin = false;

		int cla = cambiaAInt(clave);

	  con = new ConexionBD();
            try  {
				String queryString = "UPDATE ingresos SET activo = 0 WHERE clave = "+cla+"" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              fin = true;

			if(fin){

				double original = 0.0;
				double impo = 0.0;
				int clave1 = 0;
				ResultSet rs = null;
				ResultSet rs1 = null;

				String queryString1 = ("SELECT bancoCuenta, importe FROM ingresos WHERE clave = "+clave+"");
				Statement stmt2 = con.miConnection.createStatement();
				rs = stmt2.executeQuery(queryString1);
				while(rs.next()){
					impo = rs.getDouble("importe");
					clave1 = rs.getInt("bancoCuenta");
				}

            	String queryString0 = ("SELECT importeActual FROM bancos WHERE clave = "+clave1+"");
            	Statement stmt1 = con.miConnection.createStatement();
           		rs1 = stmt1.executeQuery(queryString0);
            	while(rs1.next()){
					original = rs1.getDouble("importeActual");
				}

				original = original - impo;

				String queryString2 = "UPDATE bancos SET importeActual = "+original+" WHERE clave = "+clave1+"" ;
             	Statement stmt3 = con.miConnection.createStatement();
              	stmt3.execute(queryString2);
              	fin = true;

			}

            } catch (SQLException sqle) {
				con.realizaRollback();
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query bajaIngreso.";
              throw new SQLException(error);
            } catch (Exception e) {
				con.realizaRollback();
              	error = "Ocurri� una excepci�n mientras se actualizaba bajaIngreso.";
              	throw new Exception(error);
            }
            finally{
				try{
					con.habilitaAutoCommit();
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerBancos metodo bajaIngreso");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El m�todo bajaGasto se encarga de actualizar los datos de una Cuenta dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Proveedor a actualizar.
*	@param 	nombre		String con el Nombre del Proveedor.
*	@param 	direccion	String con la Direcci�n del Proveedor.
*	@param	colonia		String con la Colonia del Proveedor
*	@param	delegacion	String con la Delegaci�n del Proveedor.
*	@param	cp			String con el C�digo Postal del Proveedor.
*/
  public boolean bajaGasto(String clave) throws SQLException, Exception {

	  boolean fin = false;

		int cla = cambiaAInt(clave);

	  con = new ConexionBD();
            try  {
				String queryString = "UPDATE gastos SET activo = 0 WHERE clave = "+cla+"" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
              fin = true;

			if(fin){

				double original = 0.0;
				double impo = 0.0;
				int clave1 = 0;
				ResultSet rs = null;
				ResultSet rs1 = null;

				String queryString1 = ("SELECT bancoCuenta, importe FROM gastos WHERE clave = "+clave+"");
				Statement stmt2 = con.miConnection.createStatement();
				rs = stmt2.executeQuery(queryString1);
				while(rs.next()){
					impo = rs.getDouble("importe");
					clave1 = rs.getInt("bancoCuenta");
				}

            	String queryString0 = ("SELECT importeActual FROM bancos WHERE clave = "+clave1+"");
            	Statement stmt1 = con.miConnection.createStatement();
           		rs1 = stmt1.executeQuery(queryString0);
            	while(rs1.next()){
					original = rs1.getDouble("importeActual");
				}

				original = original + impo;

				String queryString2 = "UPDATE bancos SET importeActual = "+original+" WHERE clave = "+clave1+"" ;
             	Statement stmt3 = con.miConnection.createStatement();
              	stmt3.execute(queryString2);
              	fin = true;

			}

            } catch (SQLException sqle) {
					con.realizaRollback();
					sqle.printStackTrace();
              		error = "SQLException: Could not execute the query bajaGasto.";
              		throw new SQLException(error);
            } catch (Exception e) {
					con.realizaRollback();
              		error = "Ocurri� una excepci�n mientras se actualizaba bajaGasto.";
              		throw new Exception(error);
            }
            finally{
				try{
					con.habilitaAutoCommit();
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerBancos metodo bajaGasto");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



 public boolean Traspaso (String bancoS, String bancoM, String importe) throws SQLException, Exception{
	 boolean exito = true;
	 con = new ConexionBD();
	 con.cancelaAutoCommit();
	 try{
		int bs = cambiaAInt(bancoS);
		int bm = cambiaAInt(bancoM);
		double im = cambiaADouble(importe);
		tiempo = new TimeStamp();
		String fecha = tiempo.date;

		PreparedStatement altaGasto;
		altaGasto = con.miConnection.prepareStatement("insert into gastos values(?,?,?,?,?,?);");
		altaGasto.setNull(1, java.sql.Types.INTEGER);
		altaGasto.setInt(2, bs);
		altaGasto.setString(3, fecha);
		altaGasto.setString(4, "Traspaso");
		altaGasto.setDouble(5, im);
		altaGasto.setInt(6, 1);

		altaGasto.execute();

		double original = 0.0;
		ResultSet rs = null;

		String queryString0 = ("SELECT importeActual FROM bancos WHERE clave = "+bs+"");
		Statement stmt = con.miConnection.createStatement();
		rs = stmt.executeQuery(queryString0);
		while(rs.next()){
			original = rs.getDouble("importeActual");
		}

		original = original - im;

		String queryString = "UPDATE bancos SET importeActual = "+original+" WHERE clave = "+bs+"" ;
		Statement stmt1 = con.miConnection.createStatement();
		stmt1.execute(queryString);


		PreparedStatement altaIngreso;
		altaIngreso = con.miConnection.prepareStatement("insert into ingresos values(?,?,?,?,?,?);");
		altaIngreso.setNull(1, java.sql.Types.INTEGER);
		altaIngreso.setInt(2, bm);
		altaIngreso.setString(3, fecha);
		altaIngreso.setString(4, "Traspaso");
		altaIngreso.setDouble(5, im);
		altaIngreso.setInt(6, 1);

		altaIngreso.execute();


		double originalm = 0.0;
		ResultSet rsm = null;

		String queryString0m = ("SELECT importeActual FROM bancos WHERE clave = "+bm+"");
		Statement stmtm = con.miConnection.createStatement();
		rsm = stmtm.executeQuery(queryString0m);
		while(rsm.next()){
			originalm = rsm.getDouble("importeActual");
		}

		originalm = originalm + im;

		String queryStringm = "UPDATE bancos SET importeActual = "+originalm+" WHERE clave = "+bm+"" ;
		Statement stmt1m = con.miConnection.createStatement();
		stmt1m.execute(queryStringm);


		 con.realizaCommit();
	 }
	 catch(SQLException sqle){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion SQL en bean ManagerInventarios, Metodo: Traspaso.\n");
		 sqle.printStackTrace();
	 }
	 catch(Exception e){
		 exito = false;
		 con.realizaRollback();
		 System.out.println("Excepcion en bean ManagerInventarios, Metodo: Traspaso.\n");
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
* El m�todo cambiaAInt se encarga de transformar a un Entero una variables en formato String.
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
* El m�todo cambiaADouble se encarga de transformar a un Double una variables en formato String.
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
* El m�todo cambiaADate se encarga de transformar a un Date una variables en formato String.
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
		while (sb.indexOf("�") != -1){
			sb=sb.replace(sb.indexOf("�"),sb.indexOf("�")+1,"%");
		}
		while (sb.indexOf("�") != -1){
			sb=sb.replace(sb.indexOf("�"),sb.indexOf("�")+1,"%");
		}
		while (sb.indexOf("�") != -1){
			sb=sb.replace(sb.indexOf("�"),sb.indexOf("�")+1,"%");
		}
		while (sb.indexOf("�") != -1){
			sb=sb.replace(sb.indexOf("�"),sb.indexOf("�")+1,"%");
		}
		while (sb.indexOf("�") != -1){
			sb=sb.replace(sb.indexOf("�"),sb.indexOf("�")+1,"%");
		}
		while (sb.indexOf("�") != -1){
			sb=sb.replace(sb.indexOf("�"),sb.indexOf("�")+1,"%");
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
		//System.out.println("a�o: "+anio);
		//System.out.println("mes: "+mes);
		//System.out.println("dia: "+dia);
		Calendar temporal = Calendar.getInstance();
		temporal.clear();
		temporal.set(anio, mes-1, dia);
		//System.out.println("Temporal: "+temporal);
		return temporal;
	}

}