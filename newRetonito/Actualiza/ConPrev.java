
import java.sql.Connection;
import java.sql.Savepoint;
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
* La clase "ConPrev" es la responsable de hacer la conexi�n a la base de datos, en esta se especifican las firmas con las que se tendr� acceso a la BD.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fern�ndez J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sof�a Gabi�n Dom�nguez</a>
* @version 4.0 (Mayo 2005)
*/

public class ConPrev{

	public Connection miConnection;

/**
* El constructor de la clase ConPrev emplea un archivo a partir del cual se obtendra la direcci�n del archivo jdbc para tener acceso (driver), el nombre de usuario, y su contrase�a, para finalmente lograr la Conexion.
*/
	public ConPrev( ){
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			String dburl = "jdbc:mysql://localhost/nRetono";
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
* @return Statement a la conexi�n con la BD
*/
	public Statement creaStatement ( ) throws SQLException{
		return miConnection.createStatement();
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

/**
* Realiza Rollback con SavePoint
*/
	public void realizaRollback (Savepoint savepoint ) throws SQLException{
		miConnection.rollback( savepoint);
	}


	public Savepoint creaSavePoint(String nombreSavePoint) throws SQLException{
	 	return miConnection.setSavepoint(nombreSavePoint) ;
	 }

/**
* Cierra la conexi�n con la BD
*/
	public void cierraConexion() throws Exception{
		miConnection.close();
	}

/**
* Regresa los metaDatos obtenidos de la BD.
* @return DatabaseMetaData con la informaci�n en formato MetaData de la BD.
*/
	public DatabaseMetaData datosBD() throws SQLException{
		return miConnection.getMetaData();
	}

	public static void main (String[] args) throws Exception{
		ConPrev cbd = new ConPrev();
	}

}