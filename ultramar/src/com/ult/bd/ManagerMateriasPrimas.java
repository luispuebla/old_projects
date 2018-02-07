package com.ult.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerMateriasPrimas" es la encargada de administrar los datos correspondientes a los Clientes como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 1.0 (Octubre 2006)
*/

public class ManagerMateriasPrimas {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerMateriasPrimas es el constructor vacio de la clase.
*/

  public ManagerMateriasPrimas()   { }




/**
* El método existe verifica que el cliente solicitado existe dentro de nuestra Base de Datos.
*  	@param 	rfc  		String con el RFC del cliente solicitado.
*	@return bandera 	Int si es igual 0 el producto no exite y si es igual a 1 el producto se encuentra en la Base de Datos.
*/

public boolean existe(String nombre) throws SQLException, Exception
    {
  	  Statement st = null;
  	  ResultSet rs= null;
  	  boolean bandera = false;
		con = new ConexionBD();
  	  if (con.miConnection !=null) {
  	  	try {

  	  		st = con.creaStatement();
  	  		rs = st.executeQuery("select * from materiaprima WHERE estatus = 1");
  	  		while(rs.next()){

  	  			if(nombre.equalsIgnoreCase(rs.getString("nombre"))) {
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
					System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



/**
* El método valida_add1 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@param 	ciudad		String con la Ciudad del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add1(String nombre, String tipo, String costo, String invKg) {
		int verifica = 2;
		boolean revisa = ((nombre != null) && (nombre.length() > 0) &&
				(tipo != null) && (tipo.length() > 0) &&
				(costo != null) && (costo.length() > 0) &&
				(invKg != null) && (invKg.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método valida_add2 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@param 	ciudad		String con la Ciudad del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add2(String nombre, String tipo, String costo, String lxb, String invB, String invC) {
		int verifica = 2;
		boolean revisa = ((nombre != null) && (nombre.length() > 0) &&
				(tipo != null) && (tipo.length() > 0) &&
				(costo != null) && (costo.length() > 0) &&
				(lxb != null) && (lxb.length() > 0) &&
				(invB != null) && (invB.length() > 0) &&
				(invC != null) && (invC.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método valida_add3 verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@param 	ciudad		String con la Ciudad del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add3(String nombre, String tipo, String costoU, String kgxu, String invU) {
		int verifica = 2;
		boolean revisa = ((nombre != null) && (nombre.length() > 0) &&
				(tipo != null) && (tipo.length() > 0) &&
				(costoU != null) && (costoU.length() > 0) &&
				(kgxu != null) && (kgxu.length() > 0) &&
				(invU != null) && (invU.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método add_Materia_Prima1 se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public boolean add_Materia_Prima1(String nombre, String tipo, String costo, String invKg) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		int ti = cambiaAInt(tipo);
		double co = cambiaADouble(costo);
		double ik = cambiaADouble(invKg);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement updateMateriaPrima;
				updateMateriaPrima = con.miConnection.prepareStatement("insert into materiaprima values(?, ?, ?, ?, ?, ?, ?, ?, ?);");
				updateMateriaPrima.setNull(1, java.sql.Types.INTEGER);
				updateMateriaPrima.setString(2, nombre);
				updateMateriaPrima.setInt(3, ti);
				updateMateriaPrima.setDouble(4, 0.0);
				updateMateriaPrima.setDouble(5, co);
				updateMateriaPrima.setDouble(6, ik);
				updateMateriaPrima.setInt(7, 0);
				updateMateriaPrima.setDouble(8, 0.0);
				updateMateriaPrima.setInt(9, 1);

				updateMateriaPrima.execute();
				fin = true;
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
					System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo add_Materia_Prima1");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
	 return fin;
	}



/**
* El método add_Materia_Prima3 se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public boolean add_Materia_Prima3(String nombre, String tipo, String tipoA, String costoKg, String costoU, String invKg, String kgxu, String invU) throws SQLException, Exception {
		System.out.println(" nombre "+nombre+" tipo "+tipo+" tipoA "+tipoA+" costoKg "+costoKg+" costoU "+costoU+" invKg "+invKg+" kgxu "+kgxu+" invU "+invU);
		boolean fin = false;
		int ti = cambiaAInt(tipo);
		int tia = cambiaAInt(tipoA);
		//System.out.println("1");

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
			//System.out.println("2");
				if(tia == 1){
					double ik = cambiaADouble(invKg);
					double cokg = cambiaADouble(costoKg);

					//System.out.println("3");
					PreparedStatement updateMateriaPrima;
					updateMateriaPrima = con.miConnection.prepareStatement("insert into materiaprima values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
					updateMateriaPrima.setNull(1, java.sql.Types.INTEGER);
					updateMateriaPrima.setString(2, nombre);
					updateMateriaPrima.setInt(3, ti);
					updateMateriaPrima.setInt(4, tia);
					updateMateriaPrima.setDouble(5, 0.00);
					updateMateriaPrima.setDouble(6, 0.00);
					updateMateriaPrima.setDouble(7, 0.00);
					updateMateriaPrima.setDouble(8, ik);
					updateMateriaPrima.setInt(9, 0);
					updateMateriaPrima.setInt(10, 0);
					updateMateriaPrima.setInt(11, 0);
					updateMateriaPrima.setDouble(12, 0.00);
					updateMateriaPrima.setDouble(13, cokg);
					updateMateriaPrima.setDouble(14, 0.00);
					updateMateriaPrima.setDouble(15, 0.00);
					updateMateriaPrima.setDouble(16, 0.00);
					updateMateriaPrima.setInt(17, 1);

					updateMateriaPrima.execute();
					fin = true;
					//System.out.println("4");
				}

				if(tia == 2){
					double cou = cambiaADouble(costoU);
					double ik = cambiaADouble(invKg);
					int iu = cambiaAInt(invU);
					double kxu = cambiaADouble(kgxu);
					//System.out.println("5");
					PreparedStatement updateMateriaPrima;
					updateMateriaPrima = con.miConnection.prepareStatement("insert into materiaprima values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
					updateMateriaPrima.setNull(1, java.sql.Types.INTEGER);
					updateMateriaPrima.setString(2, nombre);
					updateMateriaPrima.setInt(3, ti);
					updateMateriaPrima.setInt(4, tia);
					updateMateriaPrima.setDouble(5, kxu);
					updateMateriaPrima.setDouble(6, 0.00);
					updateMateriaPrima.setDouble(7, 0.00);
					updateMateriaPrima.setDouble(8, ik);
					updateMateriaPrima.setInt(9, iu);
					updateMateriaPrima.setInt(10, 0);
					updateMateriaPrima.setInt(11, 0);
					updateMateriaPrima.setDouble(12, 0.00);
					updateMateriaPrima.setDouble(13, 0.00);
					updateMateriaPrima.setDouble(14, cou);
					updateMateriaPrima.setDouble(15, 0.00);
					updateMateriaPrima.setDouble(16, 0.00);
					updateMateriaPrima.setInt(17, 1);

					updateMateriaPrima.execute();
					fin = true;
					//System.out.println("6");
				}

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
					System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo add_Materia_Prima3");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
	 return fin;
	}




/**
* El método add_Materia_Prima2 se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public boolean add_Materia_Prima2(String nombre, String tipo, String costo, String lxb, String invB, String invC) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		int ti = cambiaAInt(tipo);
		double co = cambiaADouble(costo);
		double lb = cambiaADouble(lxb);
		int ib = cambiaAInt(invB);
		double ic = cambiaADouble(invC);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement updateMateriaPrima;
				updateMateriaPrima = con.miConnection.prepareStatement("insert into materiaprima values(?, ?, ?, ?, ?, ?, ?, ?, ?);");
				updateMateriaPrima.setNull(1, java.sql.Types.INTEGER);
				updateMateriaPrima.setString(2, nombre);
				updateMateriaPrima.setInt(3, ti);
				updateMateriaPrima.setDouble(4, lb);
				updateMateriaPrima.setDouble(5, co);
				updateMateriaPrima.setDouble(6, 0.0);
				updateMateriaPrima.setInt(7, ib);
				updateMateriaPrima.setDouble(8, ic);
				updateMateriaPrima.setInt(9, 1);

				updateMateriaPrima.execute();
				fin = true;
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
					System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo add_Materia_Prima2");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
	 return fin;
	}



/**
* El método add_Materia_Prima4 se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public boolean add_Materia_Prima4(String nombre, String tipo, String costoB, String costoB2, String lxb, String lxb2, String invB, String invB2, String invC) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		int ti = cambiaAInt(tipo);
		double co = cambiaADouble(costoB);
		double co2 = cambiaADouble(costoB2);
		double lb = cambiaADouble(lxb);
		double lb2 = cambiaADouble(lxb2);
		int ib = cambiaAInt(invB);
		int ib2 = cambiaAInt(invB2);
		double ic = cambiaADouble(invC);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement updateMateriaPrima;
				updateMateriaPrima = con.miConnection.prepareStatement("insert into materiaprima values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				updateMateriaPrima.setNull(1, java.sql.Types.INTEGER);
				updateMateriaPrima.setString(2, nombre);
				updateMateriaPrima.setInt(3, ti);
				updateMateriaPrima.setInt(4, 0);
				updateMateriaPrima.setDouble(5, 0.00);
				updateMateriaPrima.setDouble(6, lb);
				updateMateriaPrima.setDouble(7, lb2);
				updateMateriaPrima.setDouble(8, 0.00);
				updateMateriaPrima.setInt(9, 0);
				updateMateriaPrima.setInt(10, ib);
				updateMateriaPrima.setInt(11, ib2);
				updateMateriaPrima.setDouble(12, ic);
				updateMateriaPrima.setDouble(13, 0.00);
				updateMateriaPrima.setDouble(14, 0.00);
				updateMateriaPrima.setDouble(15, co);
				updateMateriaPrima.setDouble(16, co2);
				updateMateriaPrima.setInt(17, 1);

				updateMateriaPrima.execute();
				fin = true;
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
					System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo add_Materia_Prima4");
					q.printStackTrace();
				}
			}
		}
		else {
			error = "Exception: Conexión a la Base de Datos perdida.";
			throw new Exception(error);
		}
	 return fin;
	}



/**
* El método materiaPrimaXTipo se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Cliente.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Cliente.
*/
 public ResultSet materiaPrimaXTipo(String area0) throws SQLException, Exception
 {
	 	//System.out.println("Llego como area:"+area0);
        ResultSet rs = null;
        int area = cambiaAInt(area0);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM materiaprima WHERE tipo = "+area+" AND estatus = 1 ORDER BY nombre");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query materiaPrimaXTipo.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving materiaPrimaXTipo.";
          throw new Exception(error);
        }
        return rs;
  }



/**
* El método datos_Materia_Prima se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Cliente.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Cliente.
*/
 public ResultSet datos_Materia_Prima(String mp0) throws SQLException, Exception
 {
	 	//System.out.println("Llego como:" +division0);
        ResultSet rs = null;
        int mp = cambiaAInt(mp0);
        con = new ConexionBD();
        //System.out.println(mp);
        try  {
          String queryString = ("SELECT * FROM materiaprima WHERE clave = "+mp+" AND estatus = 1");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Materia_Prima.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Materia_Prima.";
          throw new Exception(error);
        }
        return rs;
  }



/**
* El método update_Materia_Prima1 se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Materia_Prima1(String map0, String nombre, String tipo0, String costo0, String invKg0) throws SQLException, Exception {

	  boolean fin = true;
	  ResultSet rs = null;
	  int map = cambiaAInt(map0);
	  int tipo = cambiaAInt(tipo0);
	  double costo = cambiaADouble(costo0);
	  double invKg = cambiaADouble(invKg0);
	  con = new ConexionBD();

            try  {
				String queryString = "UPDATE materiaprima SET nombre = '"+nombre+"', tipo = "+tipo+", costo = "+costo+", inventarioKG = "+invKg+" WHERE clave = "+map+" AND estatus = 1" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Materia_Prima1.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Materia_Prima1.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo update_Materia_Prima1");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El método update_Materia_Prima3 se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Materia_Prima3(String map0, String nombre, String tipo0, String tipoA0, String costoKg0, String costoU0, String invKg0, String kgxu0, String invU0) throws SQLException, Exception {

		//System.out.println("0");
		//System.out.println(map0+", "+nombre+", "+tipo0+", "+tipoA0+", "+costoKg0+", "+costoU0+", "+invKg0+", "+kgxu0+", "+invU0);
	  boolean fin = true;
	  ResultSet rs = null;
	  int map = cambiaAInt(map0);
	  int tipo = cambiaAInt(tipo0);
	  int tipoA = cambiaAInt(tipoA0);


		//System.out.println("1");
	  con = new ConexionBD();

            try  {
				//System.out.println("2");

				if(tipoA == 1){
					//System.out.println("3");
					double costokg = cambiaADouble(costoKg0);
					double invKg = cambiaADouble(invKg0);

					String queryString = "UPDATE materiaprima SET nombre = '"+nombre+"', tipo = "+tipo+", tipoA = 1, KgXUnidad = 0.00, litrosXBotella1 = 0.00, litrosXBotella2 = 0.00, inventarioKg = "+invKg+", inventarioUnidad = 0, inventarioBotella1 = 0, inventarioBotella2 = 0, inventarioCopeo = 0.00, costoKg = "+costokg+", costoUnidad = 0.00, costoBotella1 = 0.00, costoBotella2 = 0.00 WHERE clave = "+map+" AND estatus = 1" ;
					  Statement stmt = con.miConnection.createStatement();
					  stmt.execute(queryString);
				}

				if(tipoA == 2){
					double costou = cambiaADouble(costoU0);
					double kgxu = cambiaADouble(kgxu0);
	  				int invU = cambiaAInt(invU0);
					double invKg = cambiaADouble(invKg0);

					//System.out.println("4");
					String queryString2 = "UPDATE materiaprima SET nombre = '"+nombre+"', tipo = "+tipo+", tipoA = 2, KgXUnidad = "+kgxu+", litrosXBotella1 = 0.00, litrosXBotella2 = 0.00, inventarioKg = "+invKg+", inventarioUnidad = "+invU+", inventarioBotella1 = 0, inventarioBotella2 = 0, inventarioCopeo = 0.00, costoKg = 0.00, costoUnidad = "+costou+", costoBotella1 = 0.00, costoBotella2 = 0.00 WHERE clave = "+map+" AND estatus = 1" ;
					  Statement stmt2 = con.miConnection.createStatement();
					  stmt2.execute(queryString2);
				}
				//System.out.println("5");
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Materia_Prima3.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Materia_Prima3.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo update_Materia_Prima3");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El método update_Materia_Prima2 se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Materia_Prima2(String map0, String nombre, String tipo0, String costo0, String lxb0, String invB0, String invC0) throws SQLException, Exception {

	  boolean fin = true;
	  ResultSet rs = null;
	  int map = cambiaAInt(map0);
	  int tipo = cambiaAInt(tipo0);
	  double costo = cambiaADouble(costo0);
	  double lxb = cambiaADouble(lxb0);
	  int invB = cambiaAInt(invB0);
	  double invC = cambiaADouble(invC0);
	  con = new ConexionBD();

            try  {
				String queryString = "UPDATE materiaprima SET nombre = '"+nombre+"', tipo = "+tipo+", litrosXBotella = "+lxb+", costo = "+costo+", inventarioBotella = "+invB+", inventarioCopeo = "+invC+" WHERE clave = "+map+" AND estatus = 1" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Materia_Prima2.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Materia_Prima2.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo update_Materia_Prima2");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El método update_Materia_Prima4 se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Materia_Prima4(String map0, String nombre, String tipo0, String costoB0, String costoB20, String lxb0, String lxb20, String invB0, String invB20, String invC0) throws SQLException, Exception {

	  boolean fin = true;
	  ResultSet rs = null;
	  int map = cambiaAInt(map0);
	  int tipo = cambiaAInt(tipo0);
	  double costo = cambiaADouble(costoB0);
	  double costo2 = cambiaADouble(costoB20);
	  double lxb = cambiaADouble(lxb0);
	  double lxb2 = cambiaADouble(lxb20);
	  int invB = cambiaAInt(invB0);
	  int invB2 = cambiaAInt(invB20);
	  double invC = cambiaADouble(invC0);
	  con = new ConexionBD();

            try  {
				String queryString = "UPDATE materiaprima SET nombre = '"+nombre+"', tipo = "+tipo+", tipoA = 0, KgXUnidad = 0.00, litrosXBotella1 = "+lxb+", litrosXBotella2 = "+lxb2+", inventarioKg = 0.00, inventarioUnidad = 0, inventarioBotella1 = "+invB+", inventarioBotella2 = "+invB2+", inventarioCopeo = "+invC+", costoKg = 0.00, costoUnidad = 0.00, costoBotella1 = "+costo+", costoBotella2 = "+costo2+" WHERE clave = "+map+" AND estatus = 1" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Materia_Prima4.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Materia_Prima4.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo update_Materia_Prima4");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El método dameMateriasPrimas se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Clientes que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Clientes.
*/
  public ResultSet dameMateriasPrimas() throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM materiaprima WHERE estatus = '"+estatus+"' ORDER BY nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dameMateriasPrimas.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dameMateriasPrimas.";
            throw new Exception(error);
          }
          return rs;
  }



/**
* El método dameNombreMP se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public String dameNombreMP(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        int cla = cambiaAInt(clave);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT nombre FROM materiaprima WHERE clave = "+cla+"");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("nombre");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameNombreMP.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameNombreMP.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo dameNombreMP");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println(nombre);
        return nombre;
  }



/**
* El método dameTipoMP se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public String dameTipoMP(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        int cla = cambiaAInt(clave);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT tipo FROM materiaprima WHERE clave = "+cla+"");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("tipo");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameTipoMP.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameTipoMP.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerMateriasPrimas metodo dameTipoMP");
		   		q.printStackTrace();
		  	}
		}
		//System.out.println(nombre);
        return nombre;
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

}