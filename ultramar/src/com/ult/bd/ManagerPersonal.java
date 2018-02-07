package com.ult.bd;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;

public class ManagerPersonal {

// Setter�s

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
* El M�todo yaExiste nos informa si ya esta registrado en el Sistema el usuario
* * @return boolean Verdadero si se concedio el Acceso, o Falso si exisit� un intento Fallido.
*/
	public boolean yaExiste(){
		boolean resultado = false;
		boolean ingreso = false;
		String nombreTemporal = new String();
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveU FROM usuarios WHERE ClaveU = '"+usuario +"'");
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
* El M�todo datosUsuarioV  nos informa si ya esta registrado en el Sistema el usuario
* * @return boolean Verdadero si se concedio el Acceso, o Falso si exisit� un intento Fallido.
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


/**
* El M�todo todosLosUsuarios nos informa si ya esta registrado en el Sistema el usuario
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisit� un intento Fallido.
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
* El M�todo dameAgentes Nos regresa Todos los Agentes Activos en el Sistema.
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisit� un intento Fallido.
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
* El M�todo dameRepartidores Nos regresa Todos los Agentes Activos en el Sistema.
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisit� un intento Fallido.
*/
	public ResultSet dameMeseros(){
		ResultSet rs = null;
		try{
			String query = ("SELECT IDEmpleado, CONCAT(Nombre,' ',APaterno, ' ',AMaterno) NombreCompleto  FROM empleados WHERE  Tipo =0 AND activo ='1' ORDER BY Nombre;");
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
* El M�todo dameNombreAgente Nos regresa Todos los Agentes Activos en el Sistema.
* @return boolean Verdadero si se concedio el Acceso, o Falso si exisit� un intento Fallido.
*/
	public ResultSet dameNombreMesera(String clave){
		ResultSet rs = null;
		try{
			int cla = cambiaAInt(clave);
			//System.out.println("Clave funcion "+clave);
			String query = ("SELECT IDEmpleado, CONCAT(Nombre,' ',APaterno, ' ',AMaterno) NombreCompleto  FROM empleados WHERE  IDEmpleado = "+cla+";");
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
* El M�todo llenadoCompleto Verifica que todos los campos del fromulario esten llenos.
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
* El M�todo llenadoCompleto Verifica que todos los campos del fromulario esten llenos.
* * @return boolean Verdadero si todo esta lleno, o Falso si falto un campo por llenar.
*/
	public boolean contrasEquals(){
		boolean contraEqual = contra.equals(contra2);
		return contraEqual;
	}

/**
* El m�todo add_Personal se encarga de a�adir los datos de un nuevo Personal dentro de la Base de Datos.
*
*/
	public boolean add_Personal() throws SQLException, Exception {
		con = new ConexionBD();
		con.cancelaAutoCommit();
		boolean exito = true;
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

				if(puesto.equalsIgnoreCase("Hostes") || puesto.equalsIgnoreCase("Mesera")){

					int tip = 0;
					if(puesto.equalsIgnoreCase("Hostes")){
						tip = 1;
					}
					if(puesto.equalsIgnoreCase("Mesera")){
						tip = 0;
					}

					int cont = cambiaAInt(contra);

					PreparedStatement updatePersonal2;
					updatePersonal2 = con.miConnection.prepareStatement("insert into empleados values(?, ?, ?, ?, ?, ?, ?, ?);");
					updatePersonal2.setNull(1, java.sql.Types.INTEGER);
					updatePersonal2.setString(2, usuario);
					updatePersonal2.setInt(3, cont);
					updatePersonal2.setString(4, nombre);
					updatePersonal2.setString(5, aPaterno);
					updatePersonal2.setString(6, aMaterno);
					updatePersonal2.setInt(7, tip);
					updatePersonal2.setInt(8, 1);
					updatePersonal2.execute();
				}

				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				exito = false;
				sqle.printStackTrace();
				System.out.println("Error SQL clase ManagerPersonal, m�todo add_Personal");
			}
			catch (Exception q){
				con.realizaRollback();
				exito = false;
				q.printStackTrace();
				System.out.println("Error clase ManagerPersonal, m�todo add_Personal");
			}
			finally{
				try{
				con.habilitaAutoCommit();
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
* El m�todo baja_Personal se encarga de colocar un 0 en el campo "activo" del Personal en la Base de Datos, para realizar una Baja l�gica del Personal correspondiente.
*  	@param 	rfc		String con el RFC del Personal solicitado.
*/
	public boolean baja_Personal() throws SQLException, Exception {
		ResultSet rs = null;
		boolean exito = true;
		con = new ConexionBD();
		con.cancelaAutoCommit();
		try  {
			String queryString = "UPDATE usuarios SET estatus ='0' WHERE ClaveU ='"+usuario+"' AND Area != 'admin'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);

			String queryString2 = "UPDATE empleados SET activo = 0 WHERE ClaveU ='"+usuario+"'";
			Statement stmt2 = con.miConnection.createStatement();
			stmt2.execute(queryString2);

			con.realizaCommit();
		}
		catch (SQLException sqle) {
			con.realizaRollback();
			sqle.printStackTrace();
			System.out.println("Error SQL clase ManagerPersonal, m�todo baja_Personal");
		}
		catch (Exception e) {
			con.realizaRollback();
			e.printStackTrace();
			System.out.println("Error clase ManagerPersonal, m�todo baja_Personal");
		}
		finally{
			try{
				con.habilitaAutoCommit();
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


/**
* El m�todo update_Usuarios se encarga de actualizar los datos del Personal dentro de la Base de Datos.
*	@return boolean		Verdadero si la actualizaci�n fue exitosa, Falso si algo fallo.
*/
	public boolean update_Usuarios() throws SQLException, Exception {
		con = new ConexionBD();
		con.cancelaAutoCommit();
		boolean exito = true;
		try  {
			String queryString = "UPDATE usuarios SET contrasena = '" +contra +"', Tipo = '" +tipo +"', Nombre = '" +nombre +"', APaterno = '"+aPaterno +"', AMaterno = '"+aMaterno +"', Puesto ='"+puesto +"', Area ='"+area +"' WHERE ClaveU = '" +usuario +"' AND estatus = '1'";
			Statement stmt = con.miConnection.createStatement();
			stmt.execute(queryString);

			int cont = cambiaAInt(contra);
			if(puesto.equalsIgnoreCase("Hostes") || puesto.equalsIgnoreCase("Mesera")){

				int tip = 0;
				if(puesto.equalsIgnoreCase("Hostes")){
					tip = 1;
				}
				if(puesto.equalsIgnoreCase("Mesera")){
					tip = 0;
				}

  	  			Statement st = con.creaStatement();
  	  			boolean bandera = false;
  	  			ResultSet rs = st.executeQuery("select * from empleados WHERE activo = 1");
  	  			while(rs.next()){

  	  				if(usuario.equalsIgnoreCase(rs.getString("ClaveU"))) {
  	  					bandera = true;//realiza comparaci�n con la base de datos
  	  				}
  	  			}

				if(bandera){

					String queryString2 = "UPDATE empleados SET contra = " +cont +", Nombre = '" +nombre +"', APaterno = '"+aPaterno +"', AMaterno = '"+aMaterno +"', Tipo = " +tip +" WHERE ClaveU = '" +usuario +"' AND activo = 1";
					Statement stmt2 = con.miConnection.createStatement();
					stmt2.execute(queryString2);
				}
				else{

					PreparedStatement updatePersonal2;
					updatePersonal2 = con.miConnection.prepareStatement("insert into empleados values(?, ?, ?, ?, ?, ?, ?, ?);");
					updatePersonal2.setNull(1, java.sql.Types.INTEGER);
					updatePersonal2.setString(2, usuario);
					updatePersonal2.setInt(3, cont);
					updatePersonal2.setString(4, nombre);
					updatePersonal2.setString(5, aPaterno);
					updatePersonal2.setString(6, aMaterno);
					updatePersonal2.setInt(7, tip);
					updatePersonal2.setInt(8, 1);
					updatePersonal2.execute();
				}
			}

			if(!puesto.equalsIgnoreCase("Hostes") || !puesto.equalsIgnoreCase("Mesera")){

  	  			Statement st = con.creaStatement();
  	  			boolean bandera = false;
  	  			ResultSet rs = st.executeQuery("select * from empleados WHERE activo = 1");
  	  			while(rs.next()){

  	  				if(usuario.equalsIgnoreCase(rs.getString("ClaveU"))) {
  	  					bandera = true;//realiza comparaci�n con la base de datos
  	  				}
  	  			}

				if(bandera){

					String queryString2 = "UPDATE empleados SET activo = 0 WHERE ClaveU ='"+usuario+"'";
					Statement stmt2 = con.miConnection.createStatement();
					stmt2.execute(queryString2);
				}
			}

			con.realizaCommit();
		}
		catch (SQLException sqle) {
			con.realizaRollback();
			sqle.printStackTrace();
			System.out.println("Error de SQL en ManagerPersonal, update_Usuarios ");

		}
		catch (Exception e) {
			con.realizaRollback();
			e.printStackTrace();
			System.out.println("Error en ManagerPersonal, update_Usuarios ");
		}
		finally{
			try{
				con.habilitaAutoCommit();
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al cerrar conexion de ManagerPersonal metodo update_Usuarios");
				q.printStackTrace();
			}
		}
		return exito;
	}



 public void cierraConexion() throws SQLException, Exception
 {
	 if(con != null){
		try{
			con.cierraConexion();
		}
		catch (Exception q){
		System.out.println("Error al momento de cerrar conexion en ManagerPersonal ");
		q.printStackTrace();
		}
	}

}



// Funciones Genericas de Transformacion:

/**
* El m�todo cambiaADate se encarga de transformar a un Date una variables en formato String.
*  	@param 	fecha	String a tranformar a Date.
*	@return Date	double con el valor de la variable.
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