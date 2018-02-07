package com.vas.bd;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;

public class ManagerPersonal {

// Setter´s

	private String usuario = new String("");
	private String contra = new String("");
	private String contra2 = new String("");
	private String tipo = new String("");
	private String nombre = new String("");
	private String aPaterno = new String("");
	private String aMaterno = new String("");
	private String puesto = new String("");
	private String area = new String("");
	private String tel = new String("");
	private String cel = new String("");
	private ConexionBD con = null;

	public void setArea(String area){
		this.area = area;
	}

	public void setTel(String tel){
		this.tel = tel;
	}

	public void setCel(String cel){
			this.cel = cel;
	}

	public void setUsuario(String usuario){
		this.usuario = usuario;
	}

	public void setContra(String contra){
		this.contra = contra;
	}

	public void setContra2(String contra2){
		this.contra2 = contra2;
	}

	public void setTipo(String tipo){
		this.tipo = tipo;
	}

	public void setNombre(String nombre){
		this.nombre = nombre;
	}

	public void setAPaterno(String aPaterno){
		this.aPaterno = aPaterno;
	}

	public void setAMaterno(String aMaterno){
		this.aMaterno = aMaterno;
	}

	public void setPuesto(String puesto){
		this.puesto = puesto;
	}



/**
* El método update_Usuarios se encarga de actualizar los datos del Personal dentro de la Base de Datos.
*	@return boolean		Verdadero si la actualización fue exitosa, Falso si algo fallo.
*/
	public boolean update_Usuarios() throws SQLException, Exception {
		con = new ConexionBD();
		boolean exito = false;
		try  {
			String queryString = "UPDATE usuarios SET contrasena = '" +contra +"', Tipo = '" +tipo +"', Nombre = '" +nombre +"', APaterno = '"+aPaterno +"', AMaterno = '"+aMaterno +"', Puesto ='"+puesto +"', Area ='"+area +"' WHERE ClaveU = '" +usuario +"' AND estatus = '1'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
			exito = true;
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			System.out.println("Error de SQL en ManagerPersonal, update_Usuarios ");

		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error en ManagerPersonal, update_Usuarios ");
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerPersonal metodo update_Usuarios");
				q.printStackTrace();
			}
		}
		return exito;
	}


/**
* El Método yaExiste nos informa si ya esta registrado en el Sistema el usuario
* * @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public boolean yaExiste(){
		boolean resultado = false;
		boolean ingreso = false;
		String nombreTemporal = new String();
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveU FROM usuarios WHERE ClaveU = '"+usuario +"' AND Estatus = 1 ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				ingreso = true;
				nombreTemporal = rs.getString("ClaveU");
			}
			if(nombreTemporal.equalsIgnoreCase(usuario) && ingreso){
				resultado = true;
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPersonal, YaExiste ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPersonal, YaExiste ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPersonal, YaExiste ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}

/**
* El Método datosUsuarioV  nos informa si ya esta registrado en el Sistema el usuario
* * @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public ResultSet datosUsuario(){
		String nombreTemporal = new String();
		ResultSet rs = null;
		try{
			String query = ("SELECT * FROM usuarios WHERE ClaveU = '"+usuario +"'  AND Estatus = 1 ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPersonal, datosUsuario ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPersonal, datosUsuario ");
			e.printStackTrace();
		}
		return rs;
	}


	public void cierraConexion(){
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ManagerPersonal");
				q.printStackTrace();
			}
		}
	}


/**
* El Método todosLosUsuarios nos informa si ya esta registrado en el Sistema el usuario
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public ResultSet todosLosUsuarios(){
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveU, CONCAT(APaterno,' ',AMaterno, ' ',Nombre) NombreCompleto, Area, Puesto  FROM usuarios WHERE  Estatus ='1' ORDER BY APaterno;");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPersonal, todosLosUsuarios ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPersonal, todosLosUsuarios ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameAgentes Nos regresa Todos los Agentes Activos en el Sistema.
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public ResultSet dameAgentes(){
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveU, CONCAT(Nombre,' ',APaterno, ' ',AMaterno) NombreCompleto  FROM usuarios WHERE  Puesto ='Agente' AND Estatus ='1' ORDER BY Nombre;");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPersonal, dameAgentes ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPersonal, dameAgentes ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameRepartidores Nos regresa Todos los Agentes Activos en el Sistema.
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public ResultSet dameRepartidores(){
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveU, CONCAT(Nombre,' ',APaterno, ' ',AMaterno) NombreCompleto  FROM usuarios WHERE  Puesto ='Repartidor' AND Estatus ='1' ORDER BY Nombre;");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPersonal, dameRepartidores ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPersonal, dameRepartidores ");
			e.printStackTrace();
		}
		return rs;
	}



/**
* El Método dameNombreAgente Nos regresa Todos los Agentes Activos en el Sistema.
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public ResultSet dameNombreAgente(String clave){
		ResultSet rs = null;
		try{
			//System.out.println("Clave funcion "+clave);
			String query = ("SELECT ClaveU, CONCAT(Nombre,' ',APaterno, ' ',AMaterno) NombreCompleto  FROM usuarios WHERE  ClaveU = '"+clave+"';");
			//System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPersonal, dameNombreAgente ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPersonal, dameNombreAgente ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método llenadoCompleto Verifica que todos los campos del fromulario esten llenos.
* * @return boolean Verdadero si todo esta lleno, o Falso si falto un campo por llenar.
*/
	public boolean llenadoCompleto(){
		//System.out.println(usuario +" " +contra +" " +contra2 +" " +tipo +" " +nombre +" " +aPaterno +" " +aMaterno +" " +area +" " +puesto);
		return ((usuario != null) && (usuario.trim().length() >0) &&
				(contra != null) && (contra.trim().length() > 0) &&
				(contra2 != null) && (contra2.trim().length() > 0) &&
				(tipo != null) && (tipo.trim().length()>0) &&
				(nombre != null) && (nombre.trim().length()>0) &&
				(aPaterno != null) && (aPaterno.trim().length()>0) &&
				(aMaterno != null) && (aMaterno.trim().length()>0) &&
				(area != null) && (area.trim().length()>0) &&
				(puesto != null));
	}

/**
* El Método llenadoCompleto Verifica que todos los campos del fromulario esten llenos.
* * @return boolean Verdadero si todo esta lleno, o Falso si falto un campo por llenar.
*/
	public boolean contrasEquals(){
		boolean contraEqual = contra.equals(contra2);
		return contraEqual;
	}

/**
* El método add_Personal se encarga de añadir los datos de un nuevo Personal dentro de la Base de Datos.
*
*/
	public boolean add_Personal() throws SQLException, Exception {
		con = new ConexionBD();
		boolean exito = false;
		if (con.miConnection != null) {
			try {
				PreparedStatement updatePersonal;
				updatePersonal = con.miConnection.prepareStatement("insert into usuarios values(?, ?, ?, ?, ?, ?, ?, ?, ?);");
				updatePersonal.setString(1, usuario);
				updatePersonal.setString(2, contra);
				updatePersonal.setString(3, tipo);
				updatePersonal.setString(4, nombre);
				updatePersonal.setString(5, aPaterno);
				updatePersonal.setString(6, aMaterno);
				updatePersonal.setString(7, puesto);
				updatePersonal.setString(8, area);
				updatePersonal.setString(9, "1");
				updatePersonal.execute();
				exito = true;
			}
			catch (SQLException sqle) {
				exito = false;
				sqle.printStackTrace();
				System.out.println("Error SQL clase ManagerPersonal, método add_Personal");
			}
			catch (Exception q){
				exito = false;
				q.printStackTrace();
				System.out.println("Error clase ManagerPersonal, método add_Personal");
			}
			finally{
				try{
				con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPersonal metodo add_Personal");
					q.printStackTrace();
				}
			}
		}
		return exito;
	}

/**
* El método baja_Personal se encarga de colocar un 0 en el campo "activo" del Personal en la Base de Datos, para realizar una Baja lógica del Personal correspondiente.
*  	@param 	rfc		String con el RFC del Personal solicitado.
*/
	public boolean baja_Personal() throws SQLException, Exception {
		ResultSet rs = null;
		boolean exito = false;
		con = new ConexionBD();
		try  {
			String queryString = "UPDATE usuarios SET estatus ='0' WHERE ClaveU ='"+usuario+"' AND Area != 'admin'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);
			exito = true;
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
			System.out.println("Error SQL clase ManagerPersonal, método baja_Personal");
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error clase ManagerPersonal, método baja_Personal");
		}
		finally{
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println(
					"Error al cerrar conexion de ManagerPersonal metodo baja_Personal");
				q.printStackTrace();
			}
		}
		return exito;
	}


}