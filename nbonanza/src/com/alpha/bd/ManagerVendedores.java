package com.alpha.bd;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Vector;



/**
* La clase "ManagerVendedores" es la encargada de administrar los datos correspondientes a los Vendedores como son Altas, Bajas, Consultas, etc.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Agosto 2005)
*/

public class ManagerVendedores {

	String error;
	private ConexionBD con = null;
	private ConexionBD con2 = null;
	private DateStamp dt= new DateStamp();
	protected TimeStamp tiempo = null;


/**
* El método ManagerUsuarios es el constructor vacio de la clase.
*/

	public ManagerVendedores()   { }
// Métodos Revisados




	public Vector<String> semanasDelAnio(String anio) throws Exception{
		Vector<String> semanas = new Vector<String>();
		Calendar tiempoInicio = Calendar.getInstance();
		Calendar tiempoApuntador = Calendar.getInstance();
		Calendar tiempoFinal = Calendar.getInstance();
		tiempoInicio.set(cambiaAInt(anio), 0, 1);
		tiempoApuntador.set(cambiaAInt(anio), 0, 1);
		tiempoFinal.set(cambiaAInt(anio), 11, 31);
		int diaSemana = tiempoInicio.get(Calendar.DAY_OF_WEEK);
		if(diaSemana == 1){
			tiempoInicio.add(Calendar.DATE, 6);
			tiempoApuntador.add(Calendar.DATE, 6);
		}
		else if (diaSemana == 2){
			tiempoInicio.add(Calendar.DATE, 5);
			tiempoApuntador.add(Calendar.DATE, 5);
		}
		else if (diaSemana == 3){
			tiempoInicio.add(Calendar.DATE, 4);
			tiempoApuntador.add(Calendar.DATE, 4);
		}
		else if (diaSemana == 4){
			tiempoInicio.add(Calendar.DATE, 3);
			tiempoApuntador.add(Calendar.DATE, 3);
		}
		else if (diaSemana == 5){
			tiempoInicio.add(Calendar.DATE, 2);
			tiempoApuntador.add(Calendar.DATE, 2);
		}
		else if (diaSemana == 6){
			tiempoInicio.add(Calendar.DATE, 1);
			tiempoApuntador.add(Calendar.DATE, 1);
		}
		diaSemana = tiempoInicio.get(Calendar.DAY_OF_WEEK);
		int semana = 1;
		while (tiempoInicio.before((Object)tiempoFinal) || tiempoInicio.equals((Object)tiempoFinal) ){
			tiempoApuntador.add(Calendar.DATE, 6);
			semanas.addElement("\'"+obtenDatos(tiempoInicio)+"\' AND \'" +obtenDatos(tiempoApuntador)+"\'");
			semanas.addElement(semana+"");
			semanas.addElement("De: " +obtenDatos(tiempoInicio) +" A: " +obtenDatos(tiempoApuntador)+" ");
			tiempoApuntador.add(Calendar.DATE, 1);
			tiempoInicio.add(Calendar.DATE, 7);
			semana++;
		}
		return semanas;
	}


	public String dameFechaHoyFBD() throws Exception{
		tiempo = new TimeStamp();
		return  tiempo.date;
	}

	public boolean bajaPrestamo(String clavePrestamo, String usuario) throws SQLException, Exception   {
		Statement st = null;
		boolean exito = true;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				con.cancelaAutoCommit();
				Statement stmt = con.creaStatement();
				String query = "UPDATE prestamos SET estatus = 0 WHERE clavePrestamo = '"+cambiaAInt(clavePrestamo)+"' LIMIT 1";
				stmt.execute(query);
				stmt.close();
				stmt = con.creaStatement();
				query = "SELECT * FROM prestamos WHERE clavePrestamo = '"+clavePrestamo+"' AND estatus = 0";
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()){
					tiempo = new TimeStamp();
					String fechaHoy = tiempo.date;
					String horaHoy = tiempo.time;
					PreparedStatement updateTablaBajaPrestamo;
					updateTablaBajaPrestamo = con.miConnection.prepareStatement("INSERT INTO baja_prestamo VALUES(?,?,?,?,?);");
					updateTablaBajaPrestamo.setNull(1, java.sql.Types.INTEGER);
					updateTablaBajaPrestamo.setInt(2, rs.getInt("clavePrestamo"));
					updateTablaBajaPrestamo.setDate(3, cambiaADate(fechaHoy));
					updateTablaBajaPrestamo.setString(4, horaHoy);
					updateTablaBajaPrestamo.setString(5, usuario);
					updateTablaBajaPrestamo.execute();
					updateTablaBajaPrestamo.close();
				}
				rs.close();
				stmt.close();
				con.realizaCommit();
			}
			catch(SQLException sqle){
				exito = false;
				con.realizaRollback();
				System.out.println("Error SQL en ManagerVendedores, metodo bajaPrestamo:");
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				exito = false;
				con.realizaRollback();
				System.out.println("Error en ManagerVendedores, metodo bajaPrestamo:");
				ex.printStackTrace();
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerVendedores metodo bajaPrestamo");
					q.printStackTrace();
				}
			}
		}
		else{
			exito = false;
		}
		return exito;
	}



	public boolean guardaPrestamo(String claveE, String prestamo, String vencimiento, String usuario) throws SQLException, Exception   {
		Statement st = null;
		boolean exito = true;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				tiempo = new TimeStamp();
				String fechaHoy = tiempo.date;
				String horaHoy = tiempo.time;
				PreparedStatement updateTablaPrestamo;
				updateTablaPrestamo = con.miConnection.prepareStatement("INSERT INTO prestamos VALUES(?,?,?,?,?,?,?,?);");
				updateTablaPrestamo.setNull(1, java.sql.Types.INTEGER);
				updateTablaPrestamo.setInt(2, cambiaAInt(claveE));
				updateTablaPrestamo.setDate(3, cambiaADate(fechaHoy));
				updateTablaPrestamo.setString(4, horaHoy);
				updateTablaPrestamo.setDouble(5, cambiaADouble(prestamo));
				updateTablaPrestamo.setDate(6, cambiaADate(vencimiento));
				updateTablaPrestamo.setString(7, usuario);
				updateTablaPrestamo.setInt(8, 1);
				updateTablaPrestamo.execute();
				updateTablaPrestamo.close();
			}
			catch(SQLException sqle){
				exito = false;
				System.out.println("Error SQL en ManagerVendedores, metodo guardaPrestamo:");
				sqle.printStackTrace();
			}
			catch (Exception ex) {
				exito = false;
				System.out.println("Error en ManagerVendedores, metodo guardaPrestamo:");
				ex.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerVendedores metodo guardaPrestamo");
					q.printStackTrace();
				}
			}
		}
		return exito;
	}



/**
* El método existe verifica que el usuario solicitado existe dentro de nuestra Base de Datos.
*  	@param 	nombre 		String con el nombre del usuario solicitado.
*	@return bandera 	Int si es igual 0 el usuario no exite y si es igual a 1 el usuario se encuentra en la Base de Datos.
*/

	public boolean existe(String nombre) throws SQLException, Exception   {
		Statement st = null;
		ResultSet rs= null;
		boolean existe = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT NombreE FROM vendedores WHERE NombreE = '"+nombre.trim() +"' AND estatus = 1 LIMIT 1");
				while(rs.next()){
					existe = true;
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
					System.out.println("Error al cerrar conexion de ManagerVendedores metodo existe");
					q.printStackTrace();
				}
			}
		}
		return existe;
	}


	/**
	* El método add_Venedor se encarga de añadir los datos de un nuevo Usuario dentro de la Base de Datos.
	*	@param 	nombre		String con el Nombre del Usuario
	*/
	public synchronized int  add_Vendedor(String nombre, String permiso, String clavePermiso, String salario, String direccion, String telCasa, String telCel, String observacion) throws SQLException, Exception {
		int exito = -1;
		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement addUsuario;
				addUsuario = con.miConnection.prepareStatement("insert into vendedores values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				addUsuario.setNull(1, java.sql.Types.INTEGER);
				addUsuario.setString(2, nombre);
				addUsuario.setInt(3, cambiaAInt(clavePermiso));
				addUsuario.setInt(4, cambiaAInt(permiso));
				addUsuario.setDouble(5, cambiaADouble(salario));
				addUsuario.setString(6, direccion);
				addUsuario.setString(7, telCasa);
				addUsuario.setString(8, telCel);
				addUsuario.setString(9, observacion);
				addUsuario.setInt(10, 1);
				addUsuario.execute();
				String query =  "SELECT MAX(claveVenta)AS Clave FROM vendedores WHERE estatus = 1";
				Statement stmt = con.creaStatement();
				ResultSet rs = stmt.executeQuery(query);
				while(rs.next()){
					exito = rs.getInt("Clave");
				}
				rs.close();
				stmt.close();
				String actualizaAdicionales = "UPDATE vendedores SET salario = "+cambiaADouble(salario)+" WHERE NombreE = '"+nombre +"' AND estatus = 1";
				stmt = con.creaStatement();
				stmt.execute(actualizaAdicionales);
				stmt.close();
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "Error en metodo add_Vendedor, clase ManagerVendedores.";
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
					System.out.println("Error al cerrar conexion de ManagerVendedores metodo add_Venedor");
					q.printStackTrace();
				}
			}
		}
		else {
			System.out.println("No pude conectarme a la Base de Datos");
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
		return exito;
	}


	/**
	* El método existe2 verifica que el usuario solicitado existe dentro de nuestra Base de Datos.
	*  	@param 	clave 		String con la clave del usuario solicitado.
	*	@return bandera 	boolean  si es igual 0 el usuario no exite y si es igual a 1 el usuario se encuentra en la Base de Datos.
	*/

	public boolean  existe2(String clave) throws SQLException, Exception 	{
		Statement st = null;
		ResultSet rs= null;
		boolean bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT  claveVenta  FROM vendedores  WHERE claveVenta = "+cambiaAInt(clave.trim())+" AND estatus = 1");
				while(rs.next()){
					if(rs.getInt("claveVenta")==cambiaAInt(clave)) {
						bandera = true;//realiza comparación con la base de datos
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
					System.out.println("Error al cerrar conexion de ManagerVendedores metodo existe2");
					q.printStackTrace();
				}
			}
		}
		return bandera;
	}

	public int semanaCorrespondienteADia(String diaHoy, String anioS) throws Exception{
		int semanita = 0;
		String inicia = "";
		StringBuilder cadena = new StringBuilder();
		Calendar tiempoPirata;
		tiempoPirata = Calendar.getInstance();
		tiempoPirata.clear();
		String anio = diaHoy.substring(0,4);
		String mes = diaHoy.substring(5,7);
		String dia = diaHoy.substring(8,10);
		tiempoPirata.set(Integer.parseInt(anio),(Integer.parseInt(mes)-1),Integer.parseInt(dia));
		int diaSemana = tiempoPirata.get(Calendar.DAY_OF_WEEK);
		// PRIMERO SACO EL INICIO...
		if(diaSemana == 7) {// ES SABADO
			anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
			int mesI = tiempoPirata.get(Calendar.MONTH)+1;
			String mescomp = new String (checkSize(mesI));
			int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
			String diacomp = new String (checkSize(diaI));
			cadena.append(anio+"-"+mescomp+"-"+diacomp);
			inicia = cadena.toString();
		}
		else{
			int i = diaSemana;
			while(i != 0  ){
				i --;
				tiempoPirata.add(Calendar.DATE,-1);
			}
			anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
			int mesI = tiempoPirata.get(Calendar.MONTH)+1;
			String mescomp = new String (checkSize(mesI));
			int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
			String diacomp = new String (checkSize(diaI));
			cadena.append(anio+"-"+mescomp+"-"+diacomp);
			inicia = cadena.toString();
		}
		Calendar tiempoInicio = Calendar.getInstance();
		Calendar tiempoApuntador = Calendar.getInstance();
		Calendar tiempoFinal = Calendar.getInstance();
		tiempoInicio.set(cambiaAInt(anioS), 0, 1);
		tiempoApuntador.set(cambiaAInt(anioS), 0, 1);
		tiempoFinal.set(cambiaAInt(anioS), 11, 31);
		diaSemana = tiempoInicio.get(Calendar.DAY_OF_WEEK);
		if(diaSemana == 1){
			tiempoInicio.add(Calendar.DATE, 6);
			tiempoApuntador.add(Calendar.DATE, 6);
		}
		else if (diaSemana == 2){
			tiempoInicio.add(Calendar.DATE, 5);
			tiempoApuntador.add(Calendar.DATE, 5);
		}
		else if (diaSemana == 3){
			tiempoInicio.add(Calendar.DATE, 4);
			tiempoApuntador.add(Calendar.DATE, 4);
		}
		else if (diaSemana == 4){
			tiempoInicio.add(Calendar.DATE, 3);
			tiempoApuntador.add(Calendar.DATE, 3);
		}
		else if (diaSemana == 5){
			tiempoInicio.add(Calendar.DATE, 2);
			tiempoApuntador.add(Calendar.DATE, 2);
		}
		else if (diaSemana == 6){
			tiempoInicio.add(Calendar.DATE, 1);
			tiempoApuntador.add(Calendar.DATE, 1);
		}
		diaSemana = tiempoInicio.get(Calendar.DAY_OF_WEEK);
		int semana = 1;
		while (tiempoInicio.before((Object)tiempoFinal) || tiempoInicio.equals((Object)tiempoFinal) ){
			tiempoApuntador.add(Calendar.DATE, 6);
			if(inicia.equalsIgnoreCase(obtenDatos(tiempoInicio))){
				semanita = semana;
			}
			tiempoApuntador.add(Calendar.DATE, 1);
			tiempoInicio.add(Calendar.DATE, 7);
			semana++;
		}
		return semanita;
	}

	public String dameSemanaCorrespondiente(String diaHoy) throws Exception{
		String inicia = "";
		String termina = "";
		StringBuilder cadena = new StringBuilder();
		Calendar tiempoPirata;
		tiempoPirata = Calendar.getInstance();
		tiempoPirata.clear();
		String anio = diaHoy.substring(0,4);
		String mes = diaHoy.substring(5,7);
		String dia = diaHoy.substring(8,10);
		tiempoPirata.set(Integer.parseInt(anio),(Integer.parseInt(mes)-1),Integer.parseInt(dia));
		int diaSemana = tiempoPirata.get(Calendar.DAY_OF_WEEK);
		// PRIMERO SACO EL INICIO...
		if(diaSemana == 7) {// ES SABADO
			anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
			int mesI = tiempoPirata.get(Calendar.MONTH)+1;
			String mescomp = new String (checkSize(mesI));
			int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
			String diacomp = new String (checkSize(diaI));
			cadena.append(anio+"-"+mescomp+"-"+diacomp);
			inicia = cadena.toString();
		}
		else{
			int i = diaSemana;
			while(i != 0  ){
				i --;
				tiempoPirata.add(Calendar.DATE,-1);
			}
			anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
			int mesI = tiempoPirata.get(Calendar.MONTH)+1;
			String mescomp = new String (checkSize(mesI));
			int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
			String diacomp = new String (checkSize(diaI));
			cadena.append(anio+"-"+mescomp+"-"+diacomp);
			inicia = cadena.toString();
		}
		// AHORA SACO EL FINAL...
		tiempoPirata.set(Integer.parseInt(anio),(Integer.parseInt(mes)-1),Integer.parseInt(dia));
		cadena = new StringBuilder("");
		if(diaSemana == 6) {// ES VIERNES
			anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
			int mesI = tiempoPirata.get(Calendar.MONTH)+1;
			String mescomp = new String (checkSize(mesI));
			int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
			String diacomp = new String (checkSize(diaI));
			cadena.append(anio+"-"+mescomp+"-"+diacomp);
			termina = cadena.toString();
		}
		else{
			int j = diaSemana;
			if(j == 7){
				while (j < (7*2)-1){ // (7*2)-1 es la fecha del proximo viernes
					j++;
					tiempoPirata.add(Calendar.DATE,1);
				}
			}
			else{
				while (j != 6){
					j++;
					tiempoPirata.add(Calendar.DATE,1);
				}
			}
			anio = new String (tiempoPirata.get(Calendar.YEAR) +"");
			int mesI = tiempoPirata.get(Calendar.MONTH)+1;
			String mescomp = new String (checkSize(mesI));
			int diaI = tiempoPirata.get(Calendar.DAY_OF_MONTH);
			String diacomp = new String (checkSize(diaI));
			cadena.append(anio+"-"+mescomp+"-"+diacomp);
			termina = cadena.toString();
		}
		return "\'"+inicia+"\' AND \'"+termina+"\'";
	}


	public ResultSet damePrestamosMPrevios(String claveU) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		String diaHoy = dameFechaHoyFBD();
		String lapso = dameSemanaCorrespondiente(diaHoy);
		if(con != null){
			try  {
				String queryString = ("SELECT clavePrestamo,fechaPrestamo, fechaFiniquito, cantidadAPagar FROM prestamos WHERE claveE = "+cambiaAInt(claveU) +"  AND estatus = 1 AND fechaPrestamo BETWEEN "+lapso +" ORDER BY fechaPrestamo");
//				System.out.println(queryString);
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query damePrestamosMPrevios.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				e.printStackTrace();
				error = "An exception occured while retrieving damePrestamosMPrevios.";
				throw new Exception(error);
			}
		}
		return rs;
	}


	public ResultSet dameTodosPrestamosCancelados(String semana) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = ("SELECT baja_prestamo.*, prestamos.fechaPrestamo, prestamos.cantidadAPagar, vendedores.NombreE FROM baja_prestamo, prestamos, vendedores WHERE baja_prestamo.fechaBaja BETWEEN " +semana +" AND prestamos.clavePrestamo = baja_prestamo.clavePrestamo AND prestamos.estatus = 0 AND vendedores.claveVenta = prestamos.claveE");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query dameTodosPrestamosCancelados.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				e.printStackTrace();
				error = "An exception occured while retrieving dameTodosPrestamosCancelados.";
				throw new Exception(error);
			}
		}
		return rs;
	}


	public ResultSet dameNominaCorrespondiente(String semana) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = ("SELECT vendedores.claveVenta, vendedores.NombreE, vendedores.salario, TB2.tipo, TB2.cantidadAPagar, TB2.fechaPrestamo FROM vendedores LEFT JOIN ( (SELECT ID, vendedor, tipo, nombreVendedor, cantidadAPagar, fechaPrestamo, autorizo FROM (SELECT creditos.numTicket AS ID, creditos.rfc AS vendedor, 'producto' AS tipo, vendedores.NombreE AS nombreVendedor, creditos.cantidadAPagar, creditos.fechaCredito AS fechaPrestamo, creditos.usuario AS autorizo FROM creditos, vendedores WHERE creditos.activo = 1 AND creditos.nombreCliente = 'creditoInterno' AND creditos.fechaCredito BETWEEN "+semana +" AND vendedores.claveVenta = creditos.rfc UNION ALL SELECT prestamos.clavePrestamo AS ID, prestamos.claveE AS vendedor, 'monetario' AS tipo, vendedores.NombreE AS nombreVendedor, prestamos.cantidadAPagar, prestamos.fechaPrestamo, prestamos.autorizo FROM prestamos, vendedores WHERE prestamos.estatus = 1 AND prestamos.fechaPrestamo BETWEEN "+semana +" AND vendedores.claveVenta = prestamos.claveE) AS TB1 ORDER BY vendedor,fechaPrestamo) AS TB2) ON vendedores.claveVenta = TB2.vendedor WHERE vendedores.estatus = 1 GROUP BY vendedores.NombreE,TB2.cantidadAPagar ORDER BY vendedores.NombreE,vendedores.salario DESC");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query dameNominaCorrespondiente.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				e.printStackTrace();
				error = "An exception occured while retrieving dameNominaCorrespondiente.";
				throw new Exception(error);
			}
		}
		return rs;
	}


	public ResultSet dameTodosPrestamos(String semana) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = ("SELECT  ID, vendedor, tipo, nombreVendedor, cantidadAPagar, fechaPrestamo, autorizo FROM (SELECT creditos.numTicket AS ID, creditos.rfc AS vendedor, 'producto' AS tipo, vendedores.NombreE AS nombreVendedor, creditos.cantidadAPagar, creditos.fechaCredito AS fechaPrestamo, creditos.usuario AS autorizo FROM creditos, vendedores WHERE creditos.activo = 1 AND creditos.nombreCliente = 'creditoInterno' AND creditos.fechaCredito BETWEEN "+semana+" AND vendedores.claveVenta = creditos.rfc UNION ALL SELECT prestamos.clavePrestamo AS ID, prestamos.claveE AS vendedor, 'monetario' AS tipo, vendedores.NombreE AS nombreVendedor, prestamos.cantidadAPagar, prestamos.fechaPrestamo, prestamos.autorizo FROM prestamos, vendedores WHERE prestamos.estatus = 1 AND prestamos.fechaPrestamo BETWEEN "+semana +" AND vendedores.claveVenta = prestamos.claveE) AS TB1 ORDER BY vendedor,fechaPrestamo ");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query dameTodosPrestamos.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				e.printStackTrace();
				error = "An exception occured while retrieving dameTodosPrestamos.";
				throw new Exception(error);
			}
		}
		return rs;
	}


	public ResultSet damePrestamosPPrevios(String claveU) throws SQLException, Exception {
		ResultSet rs = null;
		con2 = new ConexionBD();
		String diaHoy = dameFechaHoyFBD();
		String lapso = dameSemanaCorrespondiente(diaHoy);
		if(con2 != null){
			try  {
				String queryString = ("SELECT fechaCredito, fechaAPagar, cantidadAPagar FROM creditos  WHERE rfc = '"+cambiaAInt(claveU) +"'  AND nombreCliente = 'creditoInterno' AND activo = 1 AND fechaCredito BETWEEN "+lapso +" ORDER BY fechaCredito");
//				System.out.println(queryString);
				Statement stmt = con2.creaStatement();
				rs = stmt.executeQuery(queryString);
			}
			catch (SQLException sqle) {
				sqle.printStackTrace();
				error = "SQLException: Could not execute the query damePrestamosMPrevios.";
				throw new SQLException(error);
			}
			catch (Exception e) {
				e.printStackTrace();
				error = "An exception occured while retrieving damePrestamosMPrevios.";
				throw new Exception(error);
			}
		}
		return rs;
	}


	public ResultSet dameUsuario(String claveU) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM vendedores WHERE claveVenta= "+cambiaAInt(claveU) +"  AND estatus = 1 LIMIT 1 ");
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			error = "SQLException: Could not execute the query dameUsuarios.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			e.printStackTrace();
			error = "An exception occured while retrieving dameUsuarios.";
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
				System.out.println("Error al cerrar conexion de ManagerVendedores");
				q.printStackTrace();
			}
		}
	}

	public void cierraConexion2() throws SQLException, Exception{
		if(con2 != null){
			try{
				con2.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerVendedores");
				q.printStackTrace();
			}
		}
	}

  /**
  * El método existe verifica que el usuario solicitado existe dentro de nuestra Base de Datos.
  *  	@param 	nombre 		String con el nombre del usuario solicitado.
  *	@return bandera 	Int si es igual 0 el usuario no exite y si es igual a 1 el usuario se encuentra en la Base de Datos.
  */

	public boolean  existe(String nombre, String clave) throws SQLException, Exception {
		Statement st = null;
		ResultSet rs= null;
		boolean bandera = false;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT NombreE FROM vendedores WHERE NombreE = '"+nombre.trim() +"' AND claveVenta != "+cambiaAInt(clave)+" AND estatus = 1 LIMIT 1");
				while(rs.next()){
					bandera = true;
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
					System.out.println("Error al cerrar conexion de ManagerUsuarios metodo existe");
					q.printStackTrace();
				}
			}
		}
	return bandera;
	}

	public void liberaCreditoXProducto(String semana) throws SQLException,Exception{
		con = new ConexionBD();
		if(con != null){
			try  {
				String queryString = "UPDATE creditos SET estatusCredito = 2 WHERE fechaCredito BETWEEN "+semana +" AND nombreCliente = 'creditoInterno' AND activo = 1";
//				System.out.println(queryString);
				Statement stmt = con.creaStatement();
				stmt.execute(queryString);
				stmt.close();
			}
			catch (SQLException sqle) {
				System.out.println("Error SQL Clase ManagerVendedores, metodo liberaCreditoXProducto");
				sqle.printStackTrace();
			}
			catch (Exception e) {
				System.out.println("Excepcion Clase ManagerVendedores, metodo liberaCreditoXProducto" );
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error Clase ManagerVendedores, metodo liberaCreditoXProducto" );
				}
			}
		}
	}

	public boolean actualizaUser(String claveU, String nombre, String  permiso, String claveP, String salario, String direccion, String telCasa, String telCel, String observacion) throws Exception{
		boolean exito = true;
		con = new ConexionBD();
		try  {
			String queryString = "UPDATE vendedores SET NombreE = '"+nombre +"', permisoCobro = "+cambiaAInt(permiso) +", clavePermiso = "+cambiaAInt(claveP) +", salario = "+cambiaADouble(salario)+", direccion = '"+direccion+"', telCasa = '"+telCasa+"', telCel = '"+telCel+"', observacion = '"+observacion+"' WHERE claveVenta = "+cambiaAInt(claveU);
			Statement stmt = con.creaStatement();
			stmt.execute(queryString);
			stmt.close();
			String actualizaAdicionales = "UPDATE vendedores SET salario = "+cambiaADouble(salario)+" WHERE NombreE = '"+nombre +"' AND estatus = 1";
			stmt = con.creaStatement();
			stmt.execute(actualizaAdicionales);
			stmt.close();

		}
		catch (SQLException sqle) {
			exito = false;
			System.out.println("Error SQL Clase ManagerVendedores, metodo actualizaUser");
			sqle.printStackTrace();
		}
		catch (Exception e) {
			exito = false;
			System.out.println("Excepcion Clase ManagerVendedores, metodo actualizaUser" );
			e.printStackTrace();
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error Clase ManagerVendedores, metodo actualizaUser" );
			}
		}
		return exito;
	}


  /**
  * El método baja_Usuario se encarga de colocar un 0 en el campo "estatus" del Usuario en la Base de Datos, para realizar una Baja lógica del Vendedor correspondiente.
  *  	@param 	clave	String con la Clave de Venta del Usuario solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
	public boolean baja_Usuario(String clave) throws SQLException, Exception {
		ResultSet rs = null;
		boolean exito = true;
		con = new ConexionBD();
		try  {
			String queryString = "UPDATE vendedores SET estatus = 0 WHERE claveVenta = "+cambiaAInt(clave)+" AND estatus = 1 LIMIT 1";
			Statement stmt = con.creaStatement();
			stmt.execute(queryString);
			stmt.close();
		}
		catch (SQLException sqle) {
			exito = false;
			System.out.println("Error SQL Clase ManagerVendedores, metodo baja_Usuario");
			error = "Error SQL Clase ManagerVendedores, metodo baja_Usuario";
			throw new SQLException(error);
		}
		catch (Exception e) {
			exito = false;
			System.out.println("Excepcion Clase ManagerVendedores, metodo baja_Usuario");
			error = "Excepcion Clase ManagerVendedores, metodo baja_Usuario.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerVendedores metodo baja_Usuario");
				q.printStackTrace();
			}
		}
		return exito;
	}


	public String dameClavesSecundarias(String claveVendedor, String nombreVendedor) throws SQLException, Exception {
		ResultSet rs = null;
		String secundarias = "";
		con2 = new ConexionBD();
		try  {
			String queryString = ("SELECT claveVenta FROM vendedores WHERE NombreE = '"+nombreVendedor+"'  AND claveVenta != "+cambiaAInt(claveVendedor) +" AND  estatus = 1 ORDER BY claveVenta");
			Statement stmt = con2.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				if(secundarias.length() == 0){
					secundarias = rs.getString("claveVenta");
				}
				else{
					secundarias = secundarias +", "+rs.getString("claveVenta");
				}
			}
			rs.close();
			stmt.close();
			if(secundarias.length() == 0){
				secundarias = "NO";
			}
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameClavesSecundarias.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameClavesSecundarias.";
			throw new Exception(error);
		}
		finally{
			try{
				con2.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerVendedores metodo dameClavesSecundarias");
				q.printStackTrace();
			}
		}
		return secundarias;
	}



	public ResultSet dameOtrasClaves(String claveVendedor, String nombreVendedor) throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT claveVenta FROM vendedores WHERE NombreE = '"+nombreVendedor+"'  AND claveVenta != "+cambiaAInt(claveVendedor) +" AND  estatus = 1 ORDER BY claveVenta");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameOtrasClaves.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameOtrasClaves.";
			throw new Exception(error);
		}
		return rs;
	}

	/**
	* El método dameUsuarios se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Usuarios que se encuentren activos, es decir que no hayan sido dados de baja.
	*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Usuarios.
	*/
	public ResultSet dameUsuarios() throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT * FROM vendedores WHERE  estatus = 1 GROUP BY nombreE ORDER BY claveVenta");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameUsuarios.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameUsuarios.";
			throw new Exception(error);
		}
		return rs;
	}

	public ResultSet listadoVendedores() throws SQLException, Exception {
		ResultSet rs = null;
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT claveVenta, NombreE FROM vendedores WHERE  estatus = 1 GROUP BY NombreE ORDER BY NombreE");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query listadoVendedores.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving listadoVendedores.";
			throw new Exception(error);
		}
		return rs;
	}


///////////////////////////////////
    ///////////////////////
        ////////////
          /////
		   //
	// Métodos Sin revisar








	public String dameNombreUsuario(String claveU) throws SQLException, Exception {
		ResultSet rs = null;
		String elNombre = "";
		con = new ConexionBD();
		try  {
			String queryString = ("SELECT NombreE  FROM vendedores WHERE claveVenta= "+cambiaAInt(claveU) +"  AND estatus = 1 LIMIT 1");
			Statement stmt = con.miConnection.createStatement();
			rs = stmt.executeQuery(queryString);
			while(rs.next()){
				elNombre = rs.getString("NombreE");
			}
		}
		catch (SQLException sqle) {
			error = "SQLException: Could not execute the query dameNombreUsuario.";
			throw new SQLException(error);
		}
		catch (Exception e) {
			error = "An exception occured while retrieving dameNombreUsuario.";
			throw new Exception(error);
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerVendedores metodo dameNombreUsuario");
				q.printStackTrace();
			}
		}
		return elNombre;
	}






// CLASES VIEJAS
  public boolean Valida_Pass_Nuevo(String usuario, String pass, String pass2, String pass3) {
  		return ((usuario != null) && (usuario.length() > 0) &&
  				(pass != null) && (pass.length() > 0) &&
  				(pass2 != null) && (pass2.length() > 0) &&
  				(pass3 != null) && (pass3.length() > 0));

  }


public int login_pass(String usuario, String pass, String pass2, String pass3)
                         throws SQLException, Exception
  {
	  Statement st = null;
	  ResultSet rs= null;
	  int bandera = 0;
	  con = new ConexionBD();

	  if (con.miConnection !=null)
	  {
	  	try {

	  		st = con.creaStatement();
	  		rs = st.executeQuery("select * from usuario");
	  		while(rs.next()){

	  			if(usuario.equals(rs.getString("usuario_id")))
	  			{
//	  			System.out.println("entre 1");
					if (pass.equals(rs.getString("clavePermiso")))
					{
//					System.out.println("entre 2");
						if( pass2.equals(pass3) )
						{
//						System.out.println("entre 3");
							try{

						String queryString = "UPDATE usuario SET clavePermiso ='"+pass2+"' WHERE usuario_id ='"+usuario+"'";
						Statement stmt = con.creaStatement();
						stmt.execute(queryString);
						bandera = 1;
						}

						catch(SQLException sqle)
						{
							sqle.printStackTrace();
							error = "SQL Exception: no pudo ejecutarse el query";
							throw new SQLException(error);
						}
						catch(Exception e)
						{
							error = "Una excepcion ocurrio mientras se obtenia"+e;
							throw new Exception(error);
						}

					    }
					    else
					      bandera = 2;
					}
	  				else
	  					bandera = 3;
				}
	  		}

	  		}	catch (Exception ex) {
	  				ex.printStackTrace();}
	  }
	  return bandera;

  }







/**
* El método dameClave se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Vendedor.
*  	@param 	nombre 		String con el Nombre del Vendedor solicitado.
*	@return nom			String que contiene todos el Nombre del Vendedor.
*/
 public String dameClave(String nombre) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nom = new String();
        //System.out.println("Llego: +"nombre);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM usuario WHERE NombreE = '"+nombre+"' AND estatus = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){

			  nom = rs.getString("claveVenta");
		  }
        }
        catch (SQLException sqle) {
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
		   		System.out.println("Error al cerrar conexion de ManagerUsuarios metodo dameClave");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println("Clave: "+nom);
        return nom;
  }




 		       //
             /////
          ////////////
     ///////////////////////
///////////////////////////////////
	// Genericos


/**
* El método cambiaAInt se encarga de transformar a un Entero una variables en formato String.
*  	@param 	variable	String a tranformar a Entero.
*	@return valor 		Entero con el valor de la variable.
*/
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
* El método cambiaADouble se encarga de transformar a un Double una variables en formato String.
*  	@param 	variable	String a tranformar a double.
*	@return valor 		double con el valor de la variable.
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


	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}

	public String formatoDinero(String formato){
		StringBuilder losEnteros = new StringBuilder(dameEnteros(formato));
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

	public String dameDecimales(String enteros){
		StringBuilder sb = new StringBuilder (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			sb=sb.delete(0, sb.indexOf(".")+1);
			existieron = true;
		}
		if (!existieron){
			sb = new StringBuilder ("00");
		}
		return sb.toString();
	}

	public String dameEnteros(String enteros){
		StringBuilder sb = new StringBuilder (enteros);
		if(sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length() );
		}
		return sb.toString();
	}

	private String checkSize (int revisa){
		StringBuilder verificador = new StringBuilder(revisa+"");
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
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

	public String obtenDatos(Calendar temporal){
		String time;
		StringBuilder cadena = new StringBuilder();
		String anio = new String (temporal.get(Calendar.YEAR) +"");
		int mes = temporal.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mes));
		int dia = temporal.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(dia));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		return (time = new String(cadena));
	}


	public static void main(String args[]) throws Exception{
		ManagerVendedores mv = new ManagerVendedores();
		String fecha = "2007-11-19";
		String anio =  "2008";
		System.out.println("Con Año:" +fecha +", y Año: "+anio);
		mv.semanaCorrespondienteADia(fecha, anio);
	}



}