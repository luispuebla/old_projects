package com.alpha.bd;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import com.alpha.bd.DateStamp;
import java.util.Calendar;

public class ManagerLogin {

// Setter´sql

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

	// Métodos Revisados

/**
* El Método Acceso es el Responsable de permitir la entrada a un Usuario a nuetros Sistema.
* * @return boolean Verdadero si se concedio el Acceso, o Falso si exisitó un intento Fallido.
*/
	public boolean Acceso() throws SQLException, Exception{
		boolean resultado = false;
		String nombreTemporal = new String();
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT USUARIO_ID FROM usuario WHERE USUARIO_ID = '"+usuario +"' AND PASSWORD = '" +contra +"'  AND estatus = 1 ");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					if(rs.getString("USUARIO_ID").equalsIgnoreCase(usuario)){
						resultado = true;
					}
				}
				rs.close();
				stmt.close();
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerAcceso, Acceso ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerAcceso, Acceso ");
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch(Exception ex){
					ex.printStackTrace();
				}
			}
		}
		else{
				System.out.println("Error en intentar iniciar la Conexion a la BD, ManagerAcceso, método Acceso ");
		}
		return resultado;
	}


	public ResultSet MandaTipoYArea() throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD();
		if(con != null){
			try{
				String query = ("SELECT Tipo, NombreE FROM usuario WHERE USUARIO_ID = '"+usuario +"' AND PASSWORD = '" +contra +"' AND estatus = 1");
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ManagerAcceso, MandaTipoYArea ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ManagerAcceso, MandaTipoYArea ");
				e.printStackTrace();
			}
		}
		else{
				System.out.println("Error en intentar iniciar la Conexion a la BD, ManagerAcceso, método MandaTipoYArea ");
		}
		return rs;
	}



	public void cierraConexion() throws Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception sql){
				System.out.println("Error al momento de cerrar conexion en ManagerAcceso ");
				sql.printStackTrace();
			}
		}
	}


	public boolean Valida_Pass_Nuevo(String usuario, String pass, String pass2, String pass3) {
		return ((usuario != null) && (usuario.length() > 0) && (pass != null) && (pass.length() > 0) &&(pass2 != null) && (pass2.length() > 0) &&(pass3 != null) && (pass3.length() > 0));
	}


	public int login_pass(String usuario, String pass, String pass2, String pass3) throws SQLException, Exception {
		if(!(pass2.equalsIgnoreCase(pass3))){
			return 2;
		}
		Statement st = null;
		ResultSet rs= null;
		int bandera = 0;
		con = new ConexionBD();
		if (con.miConnection !=null) {
			try {
				st = con.creaStatement();
				rs = st.executeQuery("SELECT USUARIO_ID, PASSWORD FROM usuario WHERE USUARIO_ID = '"+usuario +"' AND estatus = 1");
				while(rs.next()){
					if(usuario.equalsIgnoreCase(rs.getString("USUARIO_ID")) && pass.equalsIgnoreCase(rs.getString("PASSWORD"))) {
						String queryString = "UPDATE usuario SET PASSWORD ='"+pass2+"' WHERE USUARIO_ID ='"+usuario+"' AND estatus = 1";
						Statement stmt = con.creaStatement();
						stmt.execute(queryString);
						stmt.close();
						bandera = 1;
					}
					else{
						bandera = 3;
					}
				}// Cierro While
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
				catch(Exception o){
					o.printStackTrace();
				}
			}
		}
	return bandera;
	}



///////////////////////////////////
    ///////////////////////
        ////////////
          /////
		   //
	// Métodos Sin revisar

	public boolean estatusLiberado(){
		boolean resultado = true;
		int parcial1 =  0;
		ResultSet rs = null;
		ds = new DateStamp();
		String query = "";
		try{
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			// Llegue a la fecha limite o es mayor a la fecha limite de pago.
			if (formatoCalendar(ds.obtenDatos()).after((Object)formatoCalendar(("2005-12-03"))) || formatoCalendar(ds.obtenDatos()).equals((Object)formatoCalendar(("2005-12-03")))){
				query = ("SELECT clavePermiso FROM usuario WHERE USUARIO_ID = 'cobro'");
				rs = stmt.executeQuery(query);
				while (rs.next()){
					parcial1 = rs.getInt("clavePermiso");
				}
				if(parcial1 != 0){
					resultado = false;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en estatusLiberado, Acceso ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en estatusLiberado, Acceso ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en estatusLiberado, Acceso ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}


	public boolean liberaSistema(String liberacion){
		boolean resultado = false;
		int parcial1 =  0;
		int temporal = 0;
		try{
			parcial1 = cambiaAInt(liberacion);
		}
		catch(Exception q){
			q.printStackTrace();
		}
		ResultSet rs = null;
		String query = "";
		try{
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			// Llegue a la fecha limite o es mayor a la fecha limite de pago.
			query = ("SELECT clavePermiso FROM usuario WHERE USUARIO_ID = 'facturacion'");
			rs = stmt.executeQuery(query);
			while (rs.next()){
				temporal = rs.getInt("clavePermiso");
			}
			if(parcial1 == temporal){
				resultado = true;
				String queryString = "UPDATE usuario SET clavePermiso = 0 WHERE USUARIO_ID ='cobro'";
				stmt.execute(queryString);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en liberaSistema, Acceso ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en liberaSistema, Acceso ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en liberaSistema, Acceso ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
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

	public String remueveComas(String formato){
		StringBuilder sb = new StringBuilder (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}

}