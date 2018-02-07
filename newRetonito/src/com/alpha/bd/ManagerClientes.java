package com.alpha.bd;

import com.alpha.bd.DateStamp;
import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerClientes" es la encargada de administrar los datos correspondientes a los Clientes como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004)
*/

public class ManagerClientes {

  String error;
  public  static ConexionBD con = null;
  private DateStamp dt= new DateStamp();


/**
* El método ManagerClientes es el constructor vacio de la clase.
*/

  public ManagerClientes()   { }


/**
* El método existe verifica que el cliente solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del cliente solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public int existe(String rfc) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {
  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from clientes WHERE activo = 1");
  	  		while(rs.next()){
  	  			if(rfc.equalsIgnoreCase(rs.getString("rfc"))) {
  	  				bandera = 1;//realiza comparación con la base de datos
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

	public boolean existeClienteE(String rfc, String nombre) throws SQLException, Exception{
		Statement st = null;
		ResultSet rs= null;
		boolean existe = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT rfc  FROM clientes WHERE rfc = '"+rfc.trim() +"' AND nombre = '"+nombre.trim()+"' AND activo = 1 LIMIT 1");
				while(rs.next()){
					if(rfc.trim().equalsIgnoreCase(rs.getString("rfc"))) {
						existe = true;//realiza comparación con la base de datos
					}
				}
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
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
		return existe;
	}

/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@return boolean 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public boolean valida_add(String rfc, String nombre, String direccion, String colonia, String delegacion, String cp) {
		return ((rfc != null) && (rfc.length() > 0) &&
				(nombre != null) && (nombre.length() > 0) &&
				(direccion != null) && (direccion.length() > 0) &&
				(colonia != null) && (colonia.length() > 0) &&
				(delegacion != null) && (delegacion.length() > 0) &&
				(cp != null) && (cp.length() > 0));

  }

// NUEVAS FUNCIONES PARA CLIENTES CON CRÉDITO 2o MODULO!!

/**
* El método valida_add1 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0 para los datos simples...
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@return boolean 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add1(String rfc, String nombre, String direccion, String colonia, String delegacion, String ciudad,  String cp) {
	  int verifica = 2;
		boolean revisa = ((rfc != null) && (rfc.length() > 0) &&
				(nombre != null) && (nombre.length() > 0) &&
				(ciudad != null) && (ciudad.length() > 0) &&
				(direccion != null) && (direccion.length() > 0) &&
				(colonia != null) && (colonia.length() > 0) &&
				(delegacion != null) && (delegacion.length() > 0) &&
				(cp != null) && (cp.length() > 0));
		if(revisa) {
			verifica = 1;
		}
		return verifica;

  }


/**
* El método valida_add2 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0 para los datos de credito
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@return boolean 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add2(String rfc, String nombre, String direccion, String colonia, String delegacion, String ciudad, String cp, String credito) {
	  	int verifica = 2;
		boolean revisa = ((rfc != null) && (rfc.length() > 0) &&
				(nombre != null) && (nombre.length() > 0) &&
				(direccion != null) && (direccion.length() > 0) &&
				(colonia != null) && (colonia.length() > 0) &&
				(delegacion != null) && (delegacion.length() > 0) &&
				(ciudad != null) && (ciudad.length() > 0) &&
				(cp != null) && (cp.length() > 0) &&
				(credito != null) && (credito.length() > 0));
		if(revisa){
			verifica = 1;
		}
		if (!checaFormatoDouble(credito)){
			verifica = 3;
		}
		return verifica;
  }


// EMPLEADO PARA VERIFICAR LA ESCRITURA TIPO DOUBLE EN UN CAMPO.
	public boolean checaFormatoDouble (String credito){
		credito = remueveComas(credito);
		boolean resultado = false;
		try{
			double valor;
			Double val = (Double.valueOf(credito));
			valor = val.doubleValue();
			resultado = true;
		}
		catch(NumberFormatException nfe){
		}
		return resultado;

	}


// ME REGRESA EL SALDO CON QUE DISPONE EL CLIENTE
	public double saldoDisponible(String rfc, String nombre){
		Statement st = null;
		ResultSet rs= null;
		double saldo = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.miConnection.createStatement();
				rs = st.executeQuery("SELECT  saldo FROM clientes WHERE rfc = '" +rfc +"' AND nombre = '" +nombre +"' AND activo = 1");
				while(rs.next()){
					saldo = rs.getDouble("saldo");
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
					System.out.println("Error al cerrar conexion de ManagerClientes metodo saldoDisponible");
					q.printStackTrace();
				}
			}
		}
		return saldo;
	}


// ME REGRESA EN DIAS EL TIEMPO QUE TIENE DE CREDITO EL  CLIENTE
	public int elTiempoDeCredito(String rfc, String nombre){
		Statement st = null;
		ResultSet rs= null;
		int dias = -1;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.miConnection.createStatement();
				rs = st.executeQuery("SELECT tiempoCredito FROM clientes WHERE rfc = '" +rfc +"' AND nombre = '" +nombre +"' AND activo = 1");
				while(rs.next()){
					dias = rs.getInt("tiempoCredito");
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
					System.out.println("Error al cerrar conexion de ManagerClientes metodo elTiempoDeCredito");
					q.printStackTrace();
				}
			}
		}
		return dias;
	}


// ME REGRESA EN DIAS EL TIEMPO QUE TIENE DE CREDITO EL  CLIENTE
	public int estatusBloqueo(String rfc, String nombre){
		Statement st = null;
		ResultSet rs= null;
		int bloqueo = 1;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.miConnection.createStatement();
				rs = st.executeQuery("SELECT bloqueoXPagoV FROM clientes WHERE rfc = '" +rfc +"' AND nombre = '" +nombre +"' AND activo = 1");
				while(rs.next()){
					bloqueo = rs.getInt("bloqueoXPagoV");
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
					System.out.println("Error al cerrar conexion de ManagerClientes metodo estatusBloqueo");
					q.printStackTrace();
				}
			}
		}
		return bloqueo;
	}

// Por medio de este método Incremento el Saldo de mi Cliente
	public boolean aumentaElSaldo(String rfc, String nombre, double cantidadASumar) throws SQLException, Exception {
		ResultSet rs = null;
		Statement st = null;
		double inicial = 0;
		boolean bandera = false;
		con = new ConexionBD();
		try  {
			st = con.miConnection.createStatement();
			rs = st.executeQuery("SELECT saldo FROM clientes WHERE rfc = '" +rfc +"' AND nombre = '" +nombre +"' AND activo = 1");
			while(rs.next()){
				inicial = rs.getDouble("saldo");
			}
			inicial = inicial + cantidadASumar;
			String queryString = "UPDATE clientes SET saldo = "+inicial +" WHERE rfc ='"+rfc+	"' AND nombre ='"+nombre+"'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
			bandera = true;
		}
		catch (SQLException sqle) {
			System.out.println(	"Error SQL en aumentaElSaldo");
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println(	"Error al cerrar conexion de ManagerClientes metodo aumentaElSaldo");
				q.printStackTrace();
			}
		}
		return bandera;
	}


// Por medio de este método averiguo si existe una CURP para un cliente.
	public boolean tieneCurp(String rfc, String nombre) throws SQLException, Exception {
		ResultSet rs = null;
		Statement st = null;
		boolean bandera = true;
		con = new ConexionBD();
		try  {
			st = con.miConnection.createStatement();
			rs = st.executeQuery("SELECT curp FROM clientes WHERE rfc = '" +rfc +"' AND nombre = '" +nombre +"' AND activo = 1");
			while(rs.next()){
				if(rs.getString("curp").trim().equals("")){
					bandera = false;
				}
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL en tieneCurp");
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			bandera = false;
			error = "An exception occured while retrieving.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println(	"Error al cerrar conexion de ManagerClientes metodo tieneCurp");
				q.printStackTrace();
			}
		}
		return bandera;
	}



// Por medio de este método almaceno unicamente el CURP de mi cliente.
	public boolean almacenaCURP(String rfc, String nombre, String curp) throws SQLException, Exception {
		Statement st = null;
		boolean bandera = true;
		con = new ConexionBD();
		try  {
			String queryString = "UPDATE clientes SET curp = '"+curp +"' WHERE rfc ='"+rfc+	"' AND nombre ='"+nombre+"'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
		}
		catch (SQLException sqle) {
			bandera = false;
			System.out.println(	"Error SQL en almacenaCURP");
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			bandera = false;
			error = "An exception occured while retrieving.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println(	"Error al cerrar conexion de ManagerClientes metodo almacenaCURP");
				q.printStackTrace();
			}
		}
		return bandera;
	}


// Por medio de este método Decremento el Saldo de mi Cliente
	public boolean decrementaElSaldo(String rfc, String nombre, double cantidadARestar) throws SQLException, Exception {
		ResultSet rs = null;
		Statement st = null;
		double inicial = 0;
		boolean bandera = true;
		con = new ConexionBD();
		try  {
			st = con.miConnection.createStatement();
			rs = st.executeQuery("SELECT saldo FROM clientes WHERE rfc = '" +rfc +"' AND nombre = '" +nombre +"' AND activo = 1");
			while(rs.next()){
				inicial = rs.getDouble("saldo");
			}
			inicial = inicial - cantidadARestar;
			String queryString = "UPDATE clientes SET saldo = "+inicial +" WHERE rfc ='"+rfc+	"' AND nombre ='"+nombre+"'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
		}
		catch (SQLException sqle) {
			bandera = false;
			System.out.println(	"Error SQL en decrementaElSaldo");
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			bandera = false;
			error = "An exception occured while retrieving.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println(	"Error al cerrar conexion de ManagerClientes metodo decrementaElSaldo");
				q.printStackTrace();
			}
		}
		return bandera;
	}


// Existe el cliente con Estatus de Crédito
// 0 --> NO EXISTE
// 1 --> EXISTE
	public int existeClienteCredito(String rfc) throws SQLException, Exception{
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
	  con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {
  	  		st = con.miConnection.createStatement();
  	  		rs = st.executeQuery("select rfc from clientes WHERE rfc = '"+rfc+"' AND activo ='1'");
  	  		while(rs.next()){
  	  			if(rfc.equalsIgnoreCase(rs.getString("rfc"))){
  	  				bandera = 1;//realiza comparación con la base de datos
  	  			}
  	  		}

  	  	}	catch (Exception ex) {
  	  				ex.printStackTrace();}
  	  		 finally{
	  		 	try{
	  		 		con.cierraConexion();
	  			}
	  		 	catch (Exception q){
	  		 		System.out.println("Error al cerrar conexion de ManagerClientes metodo existeClienteCredito");
	  		 		q.printStackTrace();
	  			}
			 }
  	  }
  	  return bandera;
  }


// Existe el cliente con Estatus de Crédito
// 0 --> EXISTE PERO NO ES DE TIPO CON CREDITO
// 1 --> EXISTE Y NO ESTA BLOQUEADO...
// 2 --> EXISTE PERO ESTA BLOQUEADO.
	public int existeClienteDeCreditoSinBloqueo(String rfc, String nombre) throws SQLException, Exception{
  	  Statement st = null;
  	  ResultSet rs= null;
  	  int bandera = 0;
	  con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {
  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("SELECT rfc FROM clientes WHERE rfc = '"+rfc+"' AND nombre = '"+nombre +"' AND activo = 1  AND tipoCliente = 1");
  	  		while(rs.next()){
  	  			if(rfc.equalsIgnoreCase(rs.getString("rfc"))){
  	  				bandera = 1;//realiza comparación con la base de datos
  	  			}
  	  		}
  	  		rs.close();
  	  		st.close();
  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("SELECT bloqueoXPagoV  FROM  clientes WHERE rfc = '"+rfc+"' AND nombre = '"+nombre +"' AND activo =1");
  	  		while(rs.next()){
  	  			if(rs.getInt("bloqueoXPagoV") == 1){
  	  				bandera = 2;//realiza comparación con la base de datos
  	  			}
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
	  			System.out.println("Error al cerrar conexion de ManagerClientes metodo existeClienteDeCreditoSinBloqueo");
	  			q.printStackTrace();
	  		}
		}
  	  }
  	  return bandera;
  }



// FINALIZAN NUEVAS FUNCIONES...



/**
* El método add_Cliente se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public void add_Cliente(String rfc, String curp, String nombre, String direccion, String colonia, String delegacion, String cp, String tipoCliente, String credito, String tiempoCredito, String contacto, String telefono1, String telefono2, String ciudad) throws SQLException, Exception {
		credito = remueveComas(credito);
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement updateCliente;
				updateCliente = con.miConnection.prepareStatement("insert into clientes values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				updateCliente.setString(1, rfc);
				updateCliente.setString(2, curp);
				updateCliente.setString(3, nombre);
				updateCliente.setString(4, direccion);
				updateCliente.setString(5, colonia);
				updateCliente.setString(6, delegacion);
				updateCliente.setString(7, cp);
				updateCliente.setString(8, ciudad);
				updateCliente.setString(9, contacto);
				updateCliente.setString(10, telefono1);
				updateCliente.setString(11, telefono2);
				updateCliente.setDate(12, cambiaADate(dt.obtenDatos()));
				updateCliente.setInt(13, cambiaAInt(tipoCliente));
				if(tipoCliente.equalsIgnoreCase("0")){
					updateCliente.setDouble(14, 0);
					updateCliente.setInt(15, 0);
				}
				else{
					updateCliente.setDouble(14, cambiaADouble(credito));
					updateCliente.setInt(15, cambiaAInt(tiempoCredito));
				}
				updateCliente.setDouble(16, cambiaADouble(credito));
				updateCliente.setDouble(17, 0.00);
				updateCliente.setInt(18, 1);
				updateCliente.execute();
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Falló UpDate, posible valor duplicado de Entrada";
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
					System.out.println("Error al cerrar conexion de ManagerClientes metodo add_Cliente");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
	}


/**
* El método existe2 verifica que el Cliente solicitado existe dentro de nuestra Base de Datos y se encuentre habilitado, es decir que no haya sido dado de baja.
*  	@param rfc  		String con el rfc del Cliente solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

	public int existe2(String rfc) throws SQLException, Exception    {
		Statement st = null;
		ResultSet rs= null;
		int bandera = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.miConnection.createStatement();
				rs = st.executeQuery("SELECT * FROM clientes WHERE rfc = '"+rfc+"' AND activo = 1");
				while(rs.next()){
					if(rs.getInt("activo") == 1){
						bandera = 1; //realiza comparación con la base de datos
					}
				}
				rs.close();
				st.close();
			}
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerClientes metodo existe2");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}


  /**
  * El método baja_Cliente se encarga de colocar un 0 en el campo "activo" del Cliente en la Base de Datos, para realizar una Baja lógica del Cliente correspondiente.
  *  	@param 	rfc		String con el RFC del Cliente solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
  public int baja_Cliente(String rfc, String nombre) throws SQLException, Exception {
              ResultSet rs = null;
              int bandera = 0;
              con = new ConexionBD();
              try  {

               String queryString = "UPDATE clientes SET activo ='0' WHERE rfc ='"+rfc+"' AND nombre ='"+nombre+"'";
      		  Statement stmt = con.miConnection.createStatement();
      		  stmt.execute(queryString);
      		  bandera = 1;

              } catch (SQLException sqle) {
                error = "SQLException: Could not execute the query.";
                throw new SQLException(error);
              } catch (Exception e) {
                error = "An exception occured while retrieving.";
                throw new Exception(error);
              }
              finally{
			   	try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerClientes metodo baja_Cliente");
			   		q.printStackTrace();
			  	}
			 }
              return bandera;
        }

/**
* El método datos_Cliente se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Cliente.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Cliente.
*/
	public ResultSet datos_Cliente(String rfc) throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM clientes WHERE rfc = '"+rfc+"' AND activo = 1");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query datos_Cliente.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving datos_Cliente.";
			throw new Exception(error);
		}
		return rs;
	}


	public ResultSet datos_Cliente_N(String rfc, String nombre) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM clientes WHERE rfc = '"+rfc.trim()+"' AND nombre = '"+nombre.trim()+"' AND activo = 1 LIMIT 1");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query datos_Cliente_N.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving datos_Cliente_N.";
			throw new Exception(error);
		}
		return rs;
	}

/**
* El método update_Cliente se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public void update_Cliente(String rfc, String curp, String nombre, String direccion, String colonia, String delegacion, String cp, String tipoCliente, String credito, String tiempoCredito, String contacto, String telefono1, String telefono2, String ciudad, String saldo) throws SQLException, Exception {
	 	credito = remueveComas(credito);
		saldo = remueveComas(saldo);
		double cre = cambiaADouble(credito);
		double credPrev = 0.00;
		double saldoDisp = 0.00;
		con = new ConexionBD();
		ResultSet rs = null;
		try  {
			String queryCrePrev = "SELECT credito, saldo FROM clientes WHERE rfc = '"+rfc+"' AND nombre = '"+nombre +"' AND activo = 1";
			Statement st = con.miConnection.createStatement();
			rs = st.executeQuery(queryCrePrev);
			while (rs.next()){
				credPrev = rs.getDouble("credito");
				saldoDisp = rs.getDouble("saldo");
			}
			double nuevoSD = 0.00;
			if(cre == 0.00){
				if(saldoDisp < 0.00){
					nuevoSD = saldoDisp;
				}
			}
			else if(credPrev == saldoDisp){
				nuevoSD = cre;
			}
			else if(cre > 0.00){
				nuevoSD = cre - (credPrev - saldoDisp);
			}

			PreparedStatement modCliente;
			modCliente = con.miConnection.prepareStatement("UPDATE clientes SET curp = ?, direccion = ?, colonia = ?, delegacion = ?, cp = ?, ciudad = ?,  tipoCliente = ?, credito = ?, tiempoCredito = ?,  tel1 = ?, tel2 = ?, saldo = ?, contacto = ?  WHERE rfc = ? AND nombre = ? AND activo = 1");
			modCliente.setString(1, curp);
			modCliente.setString(2, direccion);
			modCliente.setString(3, colonia);
			modCliente.setString(4, delegacion);
			modCliente.setString(5, cp);
			modCliente.setString(6, ciudad);
			modCliente.setInt(7,cambiaAInt(tipoCliente));
			modCliente.setDouble(8, cambiaADouble(credito));
			modCliente.setInt(9, cambiaAInt(tiempoCredito));
			modCliente.setString(10, telefono1);
			modCliente.setString(11, telefono2);
			modCliente.setDouble(12, nuevoSD);
			modCliente.setString(13, contacto);
			modCliente.setString(14, rfc);
			modCliente.setString(15, nombre);
			modCliente.execute();
            } catch (SQLException sqle) {
				sqle.printStackTrace();
              error = "SQLException: Could not execute the query update_Cliente.";
              throw new SQLException(error);
            } catch (Exception e) {
              error = "Ocurrió una excepción mientras se actualizaba update_Cliente.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerClientes metodo update_Cliente");
			   		q.printStackTrace();
			 	}
		   }

    }


/**
* El método dameClientes se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Clientes que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Clientes.
*/
  public ResultSet dameClientes() throws SQLException, Exception {
          ResultSet rs = null;
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM clientes WHERE activo = 1 ORDER BY nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameClientes.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameClientes.";
            throw new Exception(error);
          }
          return rs;
  }

/**
* El método datos_Cliente_Facturas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos las Facturas de un Clientes.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todas las Facturas de un Cliente.
*/
  public ResultSet datos_Cliente_Facturas(String rfcclie, String nombre) throws SQLException, Exception {
	ResultSet rs = null;
	con = new ConexionBD();
	try  {
		String queryString = ("SELECT numFactura, tickets, fechaCrea, fechaFac, total FROM facventas WHERE estatus = 1 AND rfc = '"+rfcclie.trim()+"' AND nombre = '"+nombre.trim()+"' ORDER BY fechaFac DESC");
		Statement stmt = con.miConnection.createStatement();
		rs = stmt.executeQuery(queryString);
	}
	catch (SQLException sqle) {
		sqle.printStackTrace();
		error = "SQLException: Could not execute the query datos_Cliente_Facturas.";
		throw new SQLException(error);
	}
	catch (Exception e) {
		error = "An exception occured while retrieving datos_Cliente_Facturas.";
		throw new Exception(error);
	}
	return rs;
}

	public void cierraConexion(){
		try{
	   		con.cierraConexion();
	  	}
	   	catch (Exception q){
	   		System.out.println("Error al cerrar conexion de ManagerClientes metodo cierraConexion");
	   		q.printStackTrace();
	 	}
	}

/**
* El método cambiaAInt se encarga de transformar a un Entero una variables en formato String.
*  	@param 	variable	String a tranformar a Entero.
*	@return valor 		Entero con el valor de la variable.
*/
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

	public String remueveEspacios(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf("%20") != -1){
			int indexActual = sb.indexOf("%20");
			for(int i=0; i<3; i++){
				sb.deleteCharAt(indexActual);
			}
			sb.insert(indexActual," ");
		}
		return formato = new String(sb.toString());
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
		StringBuffer losEnteros = new StringBuffer(dameEnteros(formato));
		String losDecimales = dameDecimales(formato);
		if(losEnteros.length() == 7){
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

}