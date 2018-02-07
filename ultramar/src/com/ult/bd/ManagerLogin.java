package com.ult.bd;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.Calendar;

public class ManagerLogin {

// Setter´s

	private String usuario = new String("");
	private String contra = new String("");
	private ConexionBD con = null;
	public String error = new String("");
	private String liberacion = new String ("");
	protected DateStamp ds;


	public void setUsuario(String usuario){
		this.usuario = usuario;
	}

	public void setContra(String contra){
		this.contra = contra;
	}


/**
* El Método Acceso es el Responsable de permitir la entrada a un Usuario a nuetro Sistema.
* * @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public boolean Acceso(){
		boolean resultado = false;
		boolean ingreso = false;
		String nombreTemporal = new String();
		ResultSet rs = null;
		try{
			String query = ("SELECT ClaveU FROM usuarios WHERE ClaveU = '"+usuario +"' AND Contrasena = '" +contra +"'  AND estatus = 1 ");
			//System.out.println(query);
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
			System.out.println("Error de SQL en ManagerLogin, Acceso ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerLogin, Acceso ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerLogin, Acceso ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}



	public ResultSet MandaTipoYArea(){
		ResultSet rs = null;
		try{
			String query = ("SELECT Tipo FROM usuarios WHERE ClaveU = '"+usuario +"' AND Contrasena = '" +contra +"' AND estatus = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerLogin, MandaTipo ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerLogin, MandaTipo ");
			e.printStackTrace();
		}
		return rs;
	}


	public boolean Valida_Pass_Nuevo(String usuario, String pass, String pass2, String pass3) {
		return ((usuario != null) && (usuario.length() > 0) && (pass != null) && (pass.length() > 0) &&(pass2 != null) && (pass2.length() > 0) &&(pass3 != null) && (pass3.length() > 0));

	}


	public int login_pass(String usuario, String pass, String pass2, String pass3) throws SQLException, Exception {

		Statement st = null;
		ResultSet rs= null;
		int bandera = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT ClaveU, Contrasena FROM usuarios WHERE estatus = 1");
				while(rs.next()){
					if(usuario.equalsIgnoreCase(rs.getString("ClaveU"))) {
						if (pass.equalsIgnoreCase(rs.getString("Contrasena"))) {
							if( pass2.equalsIgnoreCase(pass3) ) {
								try{
									String queryString = "UPDATE usuarios SET Contrasena ='"+pass2+"' WHERE ClaveU ='"+usuario+"' AND estatus = 1";
									Statement stmt = con.creaStatement();
									stmt.execute(queryString);
									bandera = 1;
								}
								catch(SQLException sqle) {
									sqle.printStackTrace();
								}
								catch(Exception e) {
								}
							}
						else{
							bandera = 2;
						}
					}
					else {
						bandera = 3;
					}
				}
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();}
		}
	return bandera;
	}


	protected Calendar formatoCalendar(String formato) throws Exception{
		int anio =  Integer.parseInt(formato.substring(0,formato.indexOf("-")));
		int mes = Integer.parseInt(formato.substring((formato.indexOf("-")+1), formato.lastIndexOf("-")));
		int dia = Integer.parseInt(formato.substring((formato.lastIndexOf("-")+1), formato.length()));
		Calendar temporal = Calendar.getInstance();
		temporal.clear();
		temporal.set(anio, mes-1, dia);
		return temporal;
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

}