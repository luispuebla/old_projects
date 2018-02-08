package alphanet.ultra.digibar.bd;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Statement;
import java.util.Properties;

public class ConexionBD
{
  public Connection miConnection;
  
  public ConexionBD()
  {
    try
    {
      Properties localProperties = new Properties();
      localProperties.load(new FileInputStream("db.conf"));
      Class.forName(localProperties.getProperty("db.driver")).newInstance();
      String str1 = localProperties.getProperty("db.url");
      String str2 = localProperties.getProperty("db.user");
      String str3 = localProperties.getProperty("db.passwd");
      this.miConnection = DriverManager.getConnection(str1, str2, str3);
    }
    catch (FileNotFoundException localFileNotFoundException)
    {
      System.out.println("No encontro el archivo, ");
      localFileNotFoundException.printStackTrace();
    }
    catch (IOException localIOException)
    {
      System.out.println("Excepcion IO, ");
      localIOException.printStackTrace();
    }
    catch (ClassNotFoundException localClassNotFoundException)
    {
      System.out.println("No encontro la clase, ");
      localClassNotFoundException.printStackTrace();
    }
    catch (InstantiationException localInstantiationException)
    {
      System.out.println("No pudo instanciar, ");
      localInstantiationException.printStackTrace();
    }
    catch (SQLException localSQLException)
    {
      System.out.println("ErrorSQL, ");
      localSQLException.printStackTrace();
    }
    catch (IllegalAccessException localIllegalAccessException)
    {
      System.out.println("Acceso Ilegal, ");
      localIllegalAccessException.printStackTrace();
    }
  }
  
  public Statement creaStatement()
    throws SQLException
  {
    return this.miConnection.createStatement();
  }
  
  public void realizaCommit()
    throws SQLException
  {
    this.miConnection.commit();
  }
  
  public void realizaRollback()
    throws SQLException
  {
    this.miConnection.rollback();
  }
  
  public void cancelaAutoCommit()
    throws SQLException
  {
    this.miConnection.setAutoCommit(false);
  }
  
  public void habilitaAutoCommit()
    throws SQLException
  {
    this.miConnection.setAutoCommit(true);
  }
  
  public void realizaRollback(Savepoint paramSavepoint)
    throws SQLException
  {
    this.miConnection.rollback(paramSavepoint);
  }
  
  public Savepoint creaSavePoint(String paramString)
    throws SQLException
  {
    return this.miConnection.setSavepoint(paramString);
  }
  
  public void cierraConexion()
    throws Exception
  {
    this.miConnection.close();
  }
  
  public DatabaseMetaData datosBD()
    throws SQLException
  {
    return this.miConnection.getMetaData();
  }
}
