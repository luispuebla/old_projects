package com.alpha.bd;

import java.sql.SQLException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Vector;


public class ManagerEntradas {

	private ConexionBD con = null;

  	public ManagerEntradas()   { }

// Encargado de insertar los datos arrojados por mi ticket cuando se trata de una entrada.
	public boolean addDatosEntrada(String numTicket, String numBascula, String fecha){
		boolean salida = true;
		try{
			con = new ConexionBD();
			if (con.miConnection != null) {
				PreparedStatement updateContenidoEntrada;
				updateContenidoEntrada = con.miConnection.prepareStatement(	"INSERT INTO entradas VALUES (?,?,?);");
				updateContenidoEntrada.setString(1, numTicket);
				updateContenidoEntrada.setString(2, numBascula);
				updateContenidoEntrada.setDate(3, cambiaADate(fecha));
				updateContenidoEntrada.execute();
				salida=false;
			}
		}
		catch (SQLException sqle) {
			System.out.println("Error SQL dentro de ManagerEntradas metodo addDatosTicket");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Error! Excepcion dentro de ManagerEntradas metodo addDatosEntrada");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerEntradas metodo addDatosEntrada");
					q.printStackTrace();
				}
			}
		}
		return salida;
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

}