package com.ult.bd;

import java.sql.*;
import java.util.*;
import java.sql.Date;

/**
* La clase "ManagerAlimentos" es la encargada de administrar los datos correspondientes a las Divisiones como son Altas, Bajas, Cambios, Consultas, Actualizaciones, etc.
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 1.0 (Octubre 2006)
*/

public class ManagerAlimentos {

  String error;
  private ConexionBD con = null;
  private DateStamp dt= new DateStamp();
  private TimeStamp tiempo;


/**
* El método ManagerAlimentos es el constructor vacio de la clase.
*/

  public ManagerAlimentos()   { }



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
  	  		rs = st.executeQuery("select * from alimentos WHERE estatus = 1");
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
					System.out.println("Error al cerrar conexion de ManagerDivisiones metodo existe");
					q.printStackTrace();
				}

			}
  	  }
  	  return bandera;
  }



/**
* El método valida_add verifica que todas las variales que se le envian, no se encuentren NULL o con un tamaño menor a 0.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param 	colonia		String con la Colonia del Cliente.
*	@param 	delegacion	String con la Delegacion del Cliente.
*	@param 	cp			String con la Código Postal del Cliente.
*	@param 	ciudad		String con la Ciudad del Cliente.
*	@return int 	False se encuentra alguna variable NULL o con tamaño menor a 0, True se encuentran bien las variables.
*/
  public int valida_add(String nombre, String m1, String c1, String precio, String division) {
		int verifica = 2;
		boolean revisa = ((nombre != null) && (nombre.length() > 0) &&
				(m1 != null) && (m1.length() > 0) &&
				(c1 != null) && (c1.length() > 0) &&
				(precio != null) && (precio.length() > 0) &&
				(division != null) && (division.length() > 0));
		if(revisa){
			verifica = 1;
		}
		return verifica;

  }



/**
* El método add_Division se encarga de añadir los datos de un nuevo Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC a añadir del nuevo Cliente.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*/
	public boolean add_Alimento(String nombre, String descripcion, String m10, String c10, String m20, String c20, String m30, String c30, String m40, String c40, String m50, String c50, String m60, String c60, String m70, String c70, String m80, String c80, String m90, String c90, String m101, String c101, String precio, String division) throws SQLException, Exception {
		//System.out.println("agente funcion "+agente);
		boolean fin = false;
		int m1 = cambiaAInt(m10);
		int m2 = cambiaAInt(m20);
		int m3 = cambiaAInt(m30);
		int m4 = cambiaAInt(m40);
		int m5 = cambiaAInt(m50);
		int m6 = cambiaAInt(m60);
		int m7 = cambiaAInt(m70);
		int m8 = cambiaAInt(m80);
		int m9 = cambiaAInt(m90);
		int m11 = cambiaAInt(m101);
		int div = cambiaAInt(division);

		double c1 = cambiaADouble(c10);
		double c2 = cambiaADouble(c20);
		double c3 = cambiaADouble(c30);
		double c4 = cambiaADouble(c40);
		double c5 = cambiaADouble(c50);
		double c6 = cambiaADouble(c60);
		double c7 = cambiaADouble(c70);
		double c8 = cambiaADouble(c80);
		double c9 = cambiaADouble(c90);
		double c11 = cambiaADouble(c101);
		double pre = cambiaADouble(precio);

		con = new ConexionBD();
		if (con.miConnection != null) {
			try {
				PreparedStatement updateAlimento;
				updateAlimento = con.miConnection.prepareStatement("insert into alimentos values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
				updateAlimento.setNull(1, java.sql.Types.INTEGER);
				updateAlimento.setString(2, nombre);
				updateAlimento.setString(3, descripcion);
				updateAlimento.setInt(4, m1);
				updateAlimento.setInt(5, m2);
				updateAlimento.setInt(6, m3);
				updateAlimento.setInt(7, m4);
				updateAlimento.setInt(8, m5);
				updateAlimento.setInt(9, m6);
				updateAlimento.setInt(10, m7);
				updateAlimento.setInt(11, m8);
				updateAlimento.setInt(12, m9);
				updateAlimento.setInt(13, m11);
				updateAlimento.setDouble(14, c1);
				updateAlimento.setDouble(15, c2);
				updateAlimento.setDouble(16, c3);
				updateAlimento.setDouble(17, c4);
				updateAlimento.setDouble(18, c5);
				updateAlimento.setDouble(19, c6);
				updateAlimento.setDouble(20, c7);
				updateAlimento.setDouble(21, c8);
				updateAlimento.setDouble(22, c9);
				updateAlimento.setDouble(23, c11);
				updateAlimento.setDouble(24, pre);
				updateAlimento.setInt(25, div);
				updateAlimento.setInt(26, 1);

				updateAlimento.execute();
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
					System.out.println("Error al cerrar conexion de ManagerAlimentos metodo add_Alimento");
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
* El método alimentosXDivision se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Cliente.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Cliente.
*/
 public ResultSet alimentosXDivision(String division0) throws SQLException, Exception
 {
	 	//System.out.println("Llego como area:"+area0);
        ResultSet rs = null;
        int division = cambiaAInt(division0);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM alimentos WHERE division = "+division+" AND estatus = 1 ORDER BY nombre");
          //System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query alimentosXDivision.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving alimentosXDivision.";
          throw new Exception(error);
        }
        return rs;
  }



/**
* El método dameNombreAlimento se encarga de enviar el Nombre del Proveedor registrado dentro de la Base de Datos correspondientes a un Proveedor.
*  	@param 	clave  		String con la Clave de la Línea Solicitada.
*	@return nombre		String que contiene el Nombre correspondiente a una Línea.
*/
 public String dameNombreAlimento(String clave) throws SQLException, Exception
 {
        ResultSet rs = null;
        String nombre = new String();
        int cla = cambiaAInt(clave);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT nombre FROM alimentos WHERE clave = "+cla+"");
          System.out.println(queryString);
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);

          while(rs.next()){
		  		nombre = rs.getString("nombre");
		  }
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query dameNombreAlimento.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving dameNombreAlimento.";
          throw new Exception(error);
        }
        finally{
			try{
		   		con.cierraConexion();
		  	}
		   	catch (Exception q){
		   		System.out.println("Error al cerrar conexion de ManagerAlimentos metodo dameNombreAlimento");
		   		q.printStackTrace();
		  	}
		}
		System.out.println(nombre);
        return nombre;
  }



  /**
  * El método bajaAlimento se encarga de colocar un 0 en el campo "activo" del Cliente en la Base de Datos, para realizar una Baja lógica del Cliente correspondiente.
  *  	@param 	rfc		String con el RFC del Cliente solicitado.
  *	@return bandera		Entero que si es igual a 0 no se realizo la Baja Lógica, pero si es igual a 1 se realizó con exito la Baja.
  */
  public boolean bajaAlimento(String clave) throws SQLException, Exception {
              ResultSet rs = null;
              boolean bandera = false;
              int cla = cambiaAInt(clave);
              con = new ConexionBD();
              try  {

               String queryString = "UPDATE alimentos SET estatus ='0' WHERE clave = "+clave+"";
      		  Statement stmt = con.miConnection.createStatement();
      		  stmt.execute(queryString);
      		  bandera = true;

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
			   		System.out.println("Error al cerrar conexion de ManagerAlimentos metodo bajaAlimento");
			   		q.printStackTrace();
			  	}
			 }
              return bandera;
        }



/**
* El método datos_Alimento se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a un Cliente.
*  	@param 	rfc  		String con el RFC del Cliente solicitado.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a un Cliente.
*/
 public ResultSet datos_Alimento(String clave0) throws SQLException, Exception
 {
	 	//System.out.println("Llego como:" +division0);
        ResultSet rs = null;
        int clave = cambiaAInt(clave0);
        con = new ConexionBD();
        try  {
          String queryString = ("SELECT * FROM alimentos WHERE clave = "+clave+" AND estatus = 1");
          Statement stmt = con.miConnection.createStatement();
          rs = stmt.executeQuery(queryString);
        } catch (SQLException sqle) {
          error = "SQLException: Could not execute the query datos_Alimento.";
          throw new SQLException(error);
        } catch (Exception e) {
          error = "An exception occured while retrieving datos_Alimento.";
          throw new Exception(error);
        }
        return rs;
  }




/**
* El método update_Alimento se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Alimento(String clave, String nombre, String descripcion, String m10, String c10, String m20, String c20, String m30, String c30, String m40, String c40, String m50, String c50, String m60, String c60, String m70, String c70, String m80, String c80, String m90, String c90, String m101, String c101, String precio, String division) throws SQLException, Exception {

	  boolean fin = true;
	  ResultSet rs = null;
		int m1 = cambiaAInt(m10);
		int m2 = cambiaAInt(m20);
		int m3 = cambiaAInt(m30);
		int m4 = cambiaAInt(m40);
		int m5 = cambiaAInt(m50);
		int m6 = cambiaAInt(m60);
		int m7 = cambiaAInt(m70);
		int m8 = cambiaAInt(m80);
		int m9 = cambiaAInt(m90);
		int m11 = cambiaAInt(m101);
		int div = cambiaAInt(division);
		int cla = cambiaAInt(clave);

		double c1 = cambiaADouble(c10);
		double c2 = cambiaADouble(c20);
		double c3 = cambiaADouble(c30);
		double c4 = cambiaADouble(c40);
		double c5 = cambiaADouble(c50);
		double c6 = cambiaADouble(c60);
		double c7 = cambiaADouble(c70);
		double c8 = cambiaADouble(c80);
		double c9 = cambiaADouble(c90);
		double c11 = cambiaADouble(c101);
		double pre = cambiaADouble(precio);
	  con = new ConexionBD();

            try  {
				String queryString = "UPDATE alimentos SET nombre = '"+nombre+"', descripcion = '"+descripcion+"',materia0 = "+m1+",materia1 = "+m2+",materia2 = "+m3+",materia3 = "+m4+",materia4 = "+m5+",materia5 = "+m6+",materia6 = "+m7+",materia7 = "+m8+",materia8 = "+m9+",materia9 = "+m11+",cantidad0 = "+c1+",cantidad1 = "+c2+",cantidad2 = "+c3+",cantidad3 = "+c4+",cantidad4 = "+c5+",cantidad5 = "+c6+",cantidad6 = "+c7+",cantidad7 = "+c8+",cantidad8 = "+c9+",cantidad9 = "+c11+",precio = "+pre+",division = "+div+" WHERE clave = "+cla+" AND estatus = 1" ;
              Statement stmt = con.miConnection.createStatement();
              stmt.execute(queryString);
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Alimento.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Alimento.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerAlimentos metodo update_Alimento");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El método update_Alimento_Precios_Porcentaje se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Alimento_Precios_Porcentaje(String clave, String aumento, String decremento) throws SQLException, Exception {

	  boolean fin = true;
	  ResultSet rs = null;

		int cla = cambiaAInt(clave);

		double au = cambiaADouble(aumento);
		double de = cambiaADouble(decremento);
		double precio = 0.00;
		//System.out.println("au "+au);
		//System.out.println("de "+de);

	  	con = new ConexionBD();

            try  {

            	String query = ("SELECT precio FROM alimentos WHERE clave = "+cla+" AND estatus = 1");
            	Statement stmt = con.miConnection.createStatement();
            	rs = stmt.executeQuery(query);
            	while(rs.next()){
					precio = rs.getDouble("precio");
				}

				if(au <= 0.0){
					precio = precio - ((precio*de)/100);
				}

				if(de <= 0.0){
					//System.out.println("adentro if");
					precio = precio + ((precio*au)/100);
					//System.out.println(precio);
				}

				//System.out.println(precio);

				String queryString = "UPDATE alimentos SET precio = "+precio+" WHERE clave = "+cla+" AND estatus = 1" ;
              	Statement stmt2 = con.miConnection.createStatement();
              	stmt2.execute(queryString);
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Alimento_Precios_Porcentaje.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Alimento_Precios_Porcentaje.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerAlimentos metodo update_Alimento_Precios_Porcentaje");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El método update_Alimento_Precios2 se encarga de actualizar los datos de un Cliente dentro de la Base de Datos.
*  	@param 	rfc  		String con el RFC del Cliente a actualizar.
*	@param 	nombre		String con el Nombre del Cliente.
*	@param 	direccion	String con la Dirección del Cliente.
*	@param	colonia		String con la Colonia del Cliente
*	@param	delegacion	String con la Delegación del Cliente.
*	@param	cp			String con el Código Postal del Cliente.
*/
  public boolean update_Alimento_Precios2(String nombre, String precio) throws SQLException, Exception {

	  boolean fin = true;
	  ResultSet rs = null;

		double pre = cambiaADouble(precio);
		//System.out.println("au "+au);
		//System.out.println("de "+de);

	  	con = new ConexionBD();

            try  {

				String queryString = "UPDATE alimentos SET precio = "+pre+" WHERE nombre = '"+nombre+"' AND estatus = 1" ;
              	Statement stmt2 = con.miConnection.createStatement();
              	stmt2.execute(queryString);
            } catch (SQLException sqle) {
				sqle.printStackTrace();
		        fin = false;
              error = "SQLException: Could not execute the query update_Alimento_Precios2.";
              throw new SQLException(error);
            } catch (Exception e) {
              fin = false;
              error = "Ocurrió una excepción mientras se actualizaba update_Alimento_Precios2.";
              throw new Exception(error);
            }
            finally{
				try{
			   		con.cierraConexion();
			  	}
			   	catch (Exception q){
			   		System.out.println("Error al cerrar conexion de ManagerAlimentos metodo update_Alimento_Precios2");
			   		q.printStackTrace();
			 	}
		   }
		return fin;
    }



/**
* El método dame_Alimentos_Division se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Clientes que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Clientes.
*/
  public ResultSet dame_Alimentos_Division(String division) throws SQLException, Exception {
          ResultSet rs = null;
          String estatus = "1";
          int div = cambiaAInt(division);
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT * FROM alimentos WHERE division = "+div+" AND estatus = '"+estatus+"' ORDER BY nombre");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dame_Alimentos_Division.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dame_Alimentos_Division.";
            throw new Exception(error);
          }
          return rs;
  }

/**
* El método dame_Alimentos_Division se encarga de enviar todos los datos registrados dentro de la Base de Datos correspondientes a todos los Clientes que se encuentren activos, es decir que no hayan sido dados de baja.
*	@return rs 			ResultSet que contiene todos los datos correspondiente a todos los Clientes.
*/
  public ResultSet dame_Alimentos_Division2() throws SQLException, Exception {
          ResultSet rs = null;
          con = new ConexionBD();
          try  {
            String queryString = ("SELECT division.nombre AS nombreD, alimentos.nombre AS nombreA, alimentos.precio, alimentos.descripcion FROM alimentos, division WHERE division.estatus = 1 AND division.area = 1 AND alimentos.division = division.clave AND alimentos.estatus = 1 ORDER BY  CONCAT(division.nombre,alimentos.nombre)");
            Statement stmt = con.miConnection.createStatement();
            rs = stmt.executeQuery(queryString);
          } catch (SQLException sqle) {
            error = "SQLException: Could not execute the query dame_Alimentos_Division2.";
            throw new SQLException(error);
          } catch (Exception e) {
            error = "An exception occured while retrieving dame_Alimentos_Division2.";
            throw new Exception(error);
          }
          return rs;
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