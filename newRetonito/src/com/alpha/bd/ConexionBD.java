package com.alpha.bd;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.io.IOException;

/**
* La clase "ConexionBD" es la responsable de hacer la conexión a la base de datos, en esta se especifican las firmas con las que se tendrá acceso a la BD.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 1.2
*/

public class ConexionBD{

	public Connection miConnection;

/**
* El constructor de la clase ConexionBD emplea un archivo a partir del cual se obtendra la dirección del archivo jdbc para tener acceso (driver), el nombre de usuario, y su contraseña, para finalmente lograr la Conexion.
*/
	public ConexionBD( ){
		try{
			//Properties p = new Properties();
			//p.load( new FileInputStream("db.conf") );
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String dburl = "jdbc:mysql://localhost/newRetonito";
			String dbuser = "root";
			String dbpasswd = "dbmanager";
			miConnection = DriverManager.getConnection( dburl, dbuser, dbpasswd );
		}
		catch (ClassNotFoundException cnfe){
			System.out.println("No encontro la clase, ");
			 cnfe.printStackTrace();
		}
		catch (InstantiationException ie){
			System.out.println("No pudo instanciar, " );
			ie.printStackTrace();
		}
		catch (SQLException sql){
			System.out.println("ErrorSQL, " );
			sql.printStackTrace();
		}
		catch (IllegalAccessException iae){
			System.out.println("Acceso Ilegal, " );
			iae.printStackTrace();
		}
	}


/**
* Crea un Statement de la BD
* @return Statement a la conexión con la BD
*/
	public Statement creaStatement ( ) throws SQLException{
		return miConnection.createStatement();
	}


	public Statement creaStatement(int resultSetType, int resultSetConcurrency)	throws SQLException{
		return miConnection.createStatement(resultSetType, resultSetConcurrency);
	}


/**
* Cierra la conexión con la BD
*/
	public void cierraConexion() throws Exception{
		miConnection.close();
	}

/**
* Regresa los metaDatos obtenidos de la BD.
* @return DatabaseMetaData con la información en formato MetaData de la BD.
*/
	public DatabaseMetaData datosBD() throws SQLException{
		return miConnection.getMetaData();
	}

	/**
	* Realiza el Commit
	*/
		public void realizaCommit ( ) throws SQLException{
			miConnection.commit();
		}

	/**
	* Realiza Rollback
	*/
		public void realizaRollback ( ) throws SQLException{
			miConnection.rollback();
		}

	/**
	* Cancela Auto-Commit
	*/
		public void cancelaAutoCommit ( ) throws SQLException{
			miConnection.setAutoCommit(false);
		}


	/**
	* Habilita Auto-Commit
	*/
		public void habilitaAutoCommit ( ) throws SQLException{
			miConnection.setAutoCommit(true);
		}


	public static void main (String[] args) throws Exception{
		ConexionBD cbd = new ConexionBD();
	}
}