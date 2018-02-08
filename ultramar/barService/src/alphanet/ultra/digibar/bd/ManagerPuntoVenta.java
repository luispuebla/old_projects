package alphanet.ultra.digibar.bd;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Statement;
import java.sql.Time;
import java.util.Properties;
import java.util.Vector;

import javax.swing.DefaultListModel;

public class ManagerPuntoVenta
{
  protected Vector<String> datosMapa;
  protected TimeStamp tiempo;
  protected static Properties config;
  protected final int numeroDeCopasXBotanaGratis = 3;
  
  public Vector<String> dameListaComponeBotana()
    throws SQLException, Exception
  {
	  Vector <String> localVector = new Vector<String>();
    ConexionBD localConexionBD = new ConexionBD();
    int i = 0;
    try
    {
      String str1 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str1));
      i = cambiaAInt(config.getProperty("botanaCla").trim());
    }
    catch (IOException localIOException)
    {
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException.printStackTrace();
    }
    try
    {
      ResultSet localResultSet = null;
      String str2 = "SELECT alimentos.materia0, (a.nombre)AS nombre0, alimentos.materia1, (b.nombre)AS nombre1, alimentos.materia2, (c.nombre)AS nombre2, alimentos.materia3, (d.nombre)AS nombre3, alimentos.materia4, (e.nombre)AS nombre4, alimentos.materia5, (f.nombre)AS nombre5, alimentos.materia6, (g.nombre)AS nombre6, alimentos.materia7, (h.nombre)AS nombre7, alimentos.materia8, (i.nombre)AS nombre8, alimentos.materia9, (j.nombre)AS nombre9  FROM ((((((((((alimentos LEFT JOIN materiaprima a ON alimentos.materia0 = a.clave) LEFT JOIN materiaprima b ON alimentos.materia1 = b.clave)LEFT JOIN materiaprima c ON alimentos.materia2 = c.clave) LEFT JOIN materiaprima d ON  alimentos.materia3= d.clave) LEFT JOIN materiaprima e ON alimentos.materia4 = e.clave) LEFT JOIN materiaprima f ON alimentos.materia5 =  f.clave) LEFT JOIN materiaprima g ON alimentos.materia6 = g.clave) LEFT JOIN materiaprima h ON alimentos.materia7 = h.clave) LEFT JOIN materiaprima i ON alimentos.materia8 = i.clave) LEFT JOIN materiaprima j ON alimentos.materia9 = j.clave) WHERE alimentos.division = " + i + " AND alimentos.estatus = 1";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next())
      {
        if (localResultSet.getInt("materia0") != 0) {
          localVector.addElement(localResultSet.getString("nombre0") + " * " + localResultSet.getString("materia0"));
        }
        if (localResultSet.getInt("materia1") != 0) {
          localVector.addElement(localResultSet.getString("nombre1") + " * " + localResultSet.getString("materia1"));
        }
        if (localResultSet.getInt("materia2") != 0) {
          localVector.addElement(localResultSet.getString("nombre2") + " * " + localResultSet.getString("materia2"));
        }
        if (localResultSet.getInt("materia3") != 0) {
          localVector.addElement(localResultSet.getString("nombre3") + " * " + localResultSet.getString("materia3"));
        }
        if (localResultSet.getInt("materia4") != 0) {
          localVector.addElement(localResultSet.getString("nombre4") + " * " + localResultSet.getString("materia4"));
        }
        if (localResultSet.getInt("materia5") != 0) {
          localVector.addElement(localResultSet.getString("nombre5") + " * " + localResultSet.getString("materia5"));
        }
        if (localResultSet.getInt("materia6") != 0) {
          localVector.addElement(localResultSet.getString("nombre6") + " * " + localResultSet.getString("materia6"));
        }
        if (localResultSet.getInt("materia7") != 0) {
          localVector.addElement(localResultSet.getString("nombre7") + " * " + localResultSet.getString("materia7"));
        }
        if (localResultSet.getInt("materia8") != 0) {
          localVector.addElement(localResultSet.getString("nombre8") + " * " + localResultSet.getString("materia8"));
        }
        if (localResultSet.getInt("materia9") != 0) {
          localVector.addElement(localResultSet.getString("nombre9") + " * " + localResultSet.getString("materia9"));
        }
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameListaComponeBotana ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameListaComponeBotana ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameListaComponeBotana ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public Vector<String> dameListaParaCombinar()
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    Vector <String> localVector = new Vector<String>();
    try
    {
      ResultSet localResultSet = null;
      String str1 = "SELECT bebidas.nombre, bebidas.clave, materiaprima.litrosXBotella1, materiaprima.litrosXBotella2 FROM bebidas, materiaprima WHERE bebidas.combinable = 2 AND materiaprima.clave = bebidas.materia0  ORDER BY bebidas.nombre";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str1);
      while (localResultSet.next())
      {
        String str2 = localResultSet.getString("nombre");
        String str3 = localResultSet.getString("clave");
        double d1 = localResultSet.getDouble("litrosXBotella1");
        double d2 = localResultSet.getDouble("litrosXBotella2");
        if ((d1 == 0.0D) || (d2 == 0.0D))
        {
          localVector.addElement(str2 + " M. * " + str3);
        }
        else
        {
          localVector.addElement(str2 + " M. * " + str3);
          localVector.addElement(str2 + " C. * " + str3);
        }
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameListaParaCombinar ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameListaParaCombinar ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameListaParaCombinar ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public double dameMontoTotal(int paramInt)
    throws SQLException, Exception
  {
    double d1 = descuentaBotanas(paramInt);
    ResultSet localResultSet = null;
    double d2 = 0.0D;
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT SUM(comandapro.PT)AS PT FROM comandapro, comanda WHERE comanda.IDMM = " + paramInt + " AND comanda.Es = 1 " + " AND comandapro.IDC = comanda.IDC AND comandapro.Estatus = 1";
      
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        d2 = localResultSet.getDouble("PT");
      }
      return d2 - d1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameMontoTotal ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameMontoTotal ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameMontoTotal ");
          localException5.printStackTrace();
        }
      }
    }
	return d2;
  }
  
  public double descuentaBotanas(int paramInt)
    throws SQLException, Exception
  {
    double d1 = 0.0D;
    ConexionBD localConexionBD = new ConexionBD();
    int i = 0;
    int j = 0;
    int k = 0;
    int m = 0;
    int n = 0;
    int i1 = 0;
    String str1 = "";
    str1 = dameLaClaveDeBotana();
    try
    {
      ResultSet localResultSet1 = null;
      ResultSet localResultSet2 = null;
      
      String str2 = "SELECT comandapro.CanPro AS Cantidad, comandapro.Tipo, comandapro.TB FROM bebidas, comandapro, comanda  WHERE comanda.IDMM = " + paramInt + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 2 " + " AND comandapro.Estatus = 1 AND bebidas.clave =  comandapro.ClPro AND bebidas.alcoholica = 1 ";
      
      Statement localStatement1 = localConexionBD.creaStatement();
      localResultSet1 = localStatement1.executeQuery(str2);
      while (localResultSet1.next()) {
        if (localResultSet1.getInt("Tipo") == 1) {
          n += localResultSet1.getInt("Cantidad") * localResultSet1.getInt("TB");
        } else if (localResultSet1.getInt("Tipo") == 2) {
          k += localResultSet1.getInt("Cantidad");
        } else if (localResultSet1.getInt("Tipo") == 3) {
          k += localResultSet1.getInt("Cantidad");
        } else if (localResultSet1.getInt("Tipo") == 4) {
          m += localResultSet1.getInt("Cantidad");
        }
      }
      n /= 3;
      k *= 5;
      m *= 4;
      j = n + k + m;
      
      String str3 = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " + paramInt + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.Estatus = 1";
      Statement localStatement2 = localConexionBD.creaStatement();
      localResultSet2 = localStatement2.executeQuery(str3);
      while (localResultSet2.next()) {
        i = localResultSet2.getInt("Botanas");
      }
      String str4 = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " + paramInt + "  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.Estatus = 1 AND comandapro.PT = 0.00";
      Statement localStatement3 = localConexionBD.creaStatement();
      ResultSet localResultSet3 = null;
      localResultSet3 = localStatement3.executeQuery(str4);
      while (localResultSet3.next()) {
        i1 = localResultSet3.getInt("Botanas");
      }
      if (j > i) {
        j = i;
      }
      if (i1 > j) {
        System.out.println("Tengo mas condonadas");
      } else if (i1 == j) {
        j = 0;
      } else {
        j -= i1;
      }
      int i2 = 0;
      String str5 = "SELECT DISTINCT (comandapro.ClPro)AS Clave FROM comandapro, comanda WHERE comanda.IDMM = " + paramInt + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.Estatus = 1 ";
      ResultSet localResultSet4 = null;
      Statement localStatement4 = localConexionBD.creaStatement();
      localResultSet4 = localStatement4.executeQuery(str5);
      while (localResultSet4.next()) {
        i2 = localResultSet4.getInt("Clave");
      }
      double d2 = damePrecioUnitario(1, cambiaAInt(str1), i2, 0);
      d1 = d2 * j;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, descuentaBotanas ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, descuentaBotanas ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, descuentaBotanas ");
          localException5.printStackTrace();
        }
      }
    }
	return d1;
  }
  
  public Vector<String> estatusMapa(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    this.datosMapa = new Vector<String>();
    try
    {
      ResultSet localResultSet = null;
      String str1 = "SELECT IDMesa, Estatus FROM mesas WHERE piso = " + paramInt;
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str1);
      while (localResultSet.next())
      {
        String str2 = localResultSet.getString("IDMesa");
        String str3 = localResultSet.getString("Estatus");
        this.datosMapa.addElement(str2);
        this.datosMapa.addElement(str3);
      }
      return this.datosMapa;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, estatusMapa ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, estatusMapa ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, estatusMapa ");
          localException5.printStackTrace();
        }
      }
    }
	return datosMapa;
  }
  
  public String dameLaClaveDeBotana()
    throws Exception
  {
    String str1 = "";
    try
    {
      String str2 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str2));
      str1 = config.getProperty("botanaCla").trim();
    }
    catch (IOException localIOException)
    {
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException.printStackTrace();
    }
    return str1;
  }
  
  public String dameComponentesBotana()
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    String str1 = "";
    String str2 = "";
    String str3 = "";
    String str4 = "";
    try
    {
      String str5 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str5));
      str2 = config.getProperty("claBot1");
      str3 = config.getProperty("claBot2");
      str4 = config.getProperty("claBot3");
    }
    catch (IOException localIOException)
    {
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException.printStackTrace();
    }
    try
    {
      ResultSet localResultSet = null;
      String str6 = "SELECT materiaprima.nombre, materiaprima.clave FROM materiaprima WHERE materiaprima.clave = " + str2 + " OR materiaprima.clave = " + str3 + " OR materiaprima.clave = " + str4 + "  ORDER BY materiaprima.clave";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str6);
      while (localResultSet.next()) {
        if (localResultSet.getString("clave").equalsIgnoreCase(str2)) {
          str1 = localResultSet.getString("nombre") + " * " + localResultSet.getString("clave") + "\n";
        } else if (localResultSet.getString("clave").equalsIgnoreCase(str3)) {
          str1 = str1 + localResultSet.getString("nombre") + " * " + localResultSet.getString("clave") + "\n";
        } else if (localResultSet.getString("clave").equalsIgnoreCase(str4)) {
          str1 = str1 + localResultSet.getString("nombre") + " * " + localResultSet.getString("clave");
        }
      }
      return str1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameComponentesBotana ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameComponentesBotana ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameComponentesBotana ");
          localException5.printStackTrace();
        }
      }
    }
	return str1;
  }
  
  public String mesaMadreLigada(String paramString)
    throws SQLException, Exception
  {
    if (paramString.startsWith("B"))
    {
      paramString = paramString.substring(1, paramString.length());
      if (paramString.equals("1")) {
        paramString = "25";
      } else if (paramString.equals("2")) {
        paramString = "26";
      } else if (paramString.equals("3")) {
        paramString = "27";
      } else if (paramString.equals("4")) {
        paramString = "28";
      } else if (paramString.equals("5")) {
        paramString = "29";
      }
    }
    else if (paramString.startsWith("A"))
    {
      paramString = paramString.substring(1, paramString.length());
      if (paramString.equals("1")) {
        paramString = "53";
      } else if (paramString.equals("2")) {
        paramString = "54";
      } else if (paramString.equals("3")) {
        paramString = "55";
      } else if (paramString.equals("4")) {
        paramString = "56";
      } else if (paramString.equals("5")) {
        paramString = "57";
      } else if (paramString.equals("6")) {
        paramString = "58";
      }
    }
    else if (paramString.startsWith("S"))
    {
      paramString = paramString.substring(1, paramString.length());
      if (paramString.equals("1")) {
        paramString = "47";
      } else if (paramString.equals("2")) {
        paramString = "48";
      } else if (paramString.equals("3")) {
        paramString = "49";
      } else if (paramString.equals("4")) {
        paramString = "50";
      } else if (paramString.equals("5")) {
        paramString = "51";
      } else if (paramString.equals("6")) {
        paramString = "52";
      }
    }
    ConexionBD localConexionBD = new ConexionBD();
   String  str1 = "";
    try
    {
      ResultSet localResultSet = null;
      String str2 = "SELECT LigaA FROM mesas WHERE IDMesa = '" + paramString + "'";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next()) {
        str1 = localResultSet.getString("LigaA");
      }
      return str1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, mesaMadreLigada ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, mesaMadreLigada ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, mesaMadreLigada ");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public Vector<String> listadoMeseras()
  {
    ResultSet localResultSet = null;
    Vector <String> localVector = new Vector<String>();
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT CONCAT(Nombre COLLATE latin1_spanish_ci,' ',APaterno COLLATE latin1_spanish_ci,' ',AMaterno COLLATE latin1_spanish_ci, '  > ',IDEmpleado) AS Nombre FROM empleados WHERE (Tipo = 0 OR Tipo = 1)  AND Activo = 1 ORDER BY Nombre";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        localVector.addElement(localResultSet.getString("Nombre"));
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerVentas, listadoMeseras ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerVentas, listadoMeseras ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerVentas, listadoMeseras ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public Vector<String> listadoEmpleados()
    throws SQLException, Exception
  {
    ResultSet localResultSet = null;
    Vector <String> localVector = new Vector<String>();
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT CONCAT(Nombre COLLATE latin1_spanish_ci,' ',APaterno COLLATE latin1_spanish_ci,' ',AMaterno COLLATE latin1_spanish_ci, '  > ',IDEmpleado) AS Nombre FROM empleados WHERE  Activo = 1 ";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        localVector.addElement(localResultSet.getString("Nombre"));
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerVentas, listadoEmpleados ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerVentas, listadoEmpleados ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerVentas, listadoEmpleados ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public Vector<String> listadosTodosAutorizados()
    throws SQLException, Exception
  {
    ResultSet localResultSet = null;
    Vector <String> localVector = new Vector<String>();
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT CONCAT(Nombre COLLATE latin1_spanish_ci,' ',APaterno COLLATE latin1_spanish_ci,' ',AMaterno COLLATE latin1_spanish_ci, '  > ',IDEmpleado) AS Nombre FROM empleados WHERE (Tipo = 0 OR  Tipo = 1 OR Tipo = 2)  AND Activo = 1 ";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        localVector.addElement(localResultSet.getString("Nombre"));
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerVentas, listadosTodosAutorizados ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerVentas, listadosTodosAutorizados ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerVentas, listadosTodosAutorizados ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public String dameMeseroAsignado(int paramInt)
    throws SQLException, Exception
  {
    ResultSet localResultSet = null;
    String str1 = "";
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str2 = "SELECT CONCAT(empleados.Nombre COLLATE latin1_spanish_ci,' ',empleados.APaterno COLLATE latin1_spanish_ci,' ',empleados.AMaterno COLLATE latin1_spanish_ci, '  > ',empleados.IDEmpleado) AS Nombre FROM empleados, comanda WHERE empleados.IDEmpleado = comanda.IDM AND comanda.IDMM = " + paramInt + " AND comanda.es=1 ORDER BY Nombre";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next()) {
        str1 = localResultSet.getString("Nombre");
      }
      return str1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerVentas, dameMeseroAsignado ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerVentas, dameMeseroAsignado ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerVentas, dameMeseroAsignado ");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public void modificaComensalAsignado(int paramInt1, int paramInt2, int paramInt3, String paramString, int paramInt4)
    throws SQLException, Exception
  {
    int i = 0;
    int j = 0;
    if (paramString.equalsIgnoreCase("Copa")) {
      i = 1;
    } else if (paramString.equalsIgnoreCase("Botella")) {
      i = 2;
    }
    j = dameComandaCorrespondiente(paramInt2);
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      PreparedStatement localPreparedStatement = localConexionBD.miConnection.prepareStatement("UPDATE comandaPro SET IDCom = ? WHERE  IDC = ? AND ClPro = ? AND Tipo = ? AND IDCom = ? AND Estatus = 1 Limit 1");
      localPreparedStatement.setInt(1, paramInt1);
      localPreparedStatement.setInt(2, j);
      localPreparedStatement.setInt(3, paramInt3);
      localPreparedStatement.setInt(4, i);
      localPreparedStatement.setInt(5, paramInt4);
      localPreparedStatement.execute(); return;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, modificaComensalAsignado ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, modificaComensalAsignado ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, modificaComensalAsignado ");
          localException5.printStackTrace();
        }
      }
    }
  }
  
  public int dameComensalesPorMesa(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    int i = -1;
    try
    {
      ResultSet localResultSet = null;
      String str = "SELECT NC FROM comanda  WHERE IDMM = " + paramInt + " AND Es = 1";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        i = localResultSet.getInt("NC");
      }
      return i;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameComensalePorMesa ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameComensalePorMesa ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameComensalePorMesa ");
          localException5.printStackTrace();
        }
      }
    }
	return i;
  }
  
  public synchronized int dameTipoCombinacion(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    int i = -1;
    try
    {
      ResultSet localResultSet = null;
      String str = "SELECT combinable FROM bebidas WHERE clave = " + paramInt + " AND estatus = 1";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        i = localResultSet.getInt("combinable");
      }
      return i;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameTipoCombinacion ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameTipoCombinacion ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameTipoCombinacion ");
          localException5.printStackTrace();
        }
      }
    }
	return i;
  }
  
  public synchronized int damePropiedadDimension(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    int i = -1;
    try
    {
      ResultSet localResultSet = null;
      String str = "SELECT dimensionable FROM bebidas WHERE clave = " + paramInt + " AND estatus = 1";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        i = localResultSet.getInt("dimensionable");
      }
      return i;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, damePropiedadDimension ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePropiedadDimension ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePropiedadDimension ");
          localException5.printStackTrace();
        }
      }
    }
	return i;
  }
  
  public int dameComandaCorrespondiente(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    int i = -1;
    try
    {
      ResultSet localResultSet = null;
      String str = "SELECT IDC FROM comanda  WHERE IDMM = " + paramInt + " AND Es = 1";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        i = localResultSet.getInt("IDC");
      }
      return i;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameComandaCorrespondiente ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameComandaCorrespondiente ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameComandaCorrespondiente ");
          localException5.printStackTrace();
        }
      }
    }
	return i;
  }
  
  public Vector<String> dameMesasLigadasA(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    Vector <String> localVector = new Vector<String>();
    try
    {
      ResultSet localResultSet = null;
      String str1 = "SELECT IDMesa FROM mesas  WHERE LigaA = " + paramInt + " AND Estatus = 2";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str1);
      while (localResultSet.next())
      {
        String str2 = cambiaANombreBarra(localResultSet.getString("IDMesa"));
        localVector.addElement(str2);
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameMesasLigadasA ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameMesasLigadasA ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameMesasLigadasA ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public Vector<String> mesasDisponiblesTraspaso(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    Vector <String> localVector = new Vector<String>();
    try
    {
      ResultSet localResultSet = null;
      String str1 = "SELECT IDMesa FROM mesas  WHERE IDMesa != " + paramInt + " AND (Estatus = 0 OR Estatus = 1)";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str1);
      while (localResultSet.next())
      {
        String str2 = cambiaANombreBarra(localResultSet.getString("IDMesa"));
        localVector.addElement(str2);
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, mesasDisponiblesTraspaso ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, mesasDisponiblesTraspaso ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, mesasDisponiblesTraspaso ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public Vector<String> mesasDisponiblesLiga(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    Vector <String> localVector = new Vector<String>();
    try
    {
      ResultSet localResultSet = null;
      String str1 = "SELECT IDMesa FROM mesas  WHERE IDMesa != " + paramInt + " AND Estatus = 0 AND Piso = (SELECT Piso FROM mesas WHERE IDMesa = " + paramInt + ") ";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str1);
      while (localResultSet.next())
      {
        String str2 = localResultSet.getString("IDMesa");
        if (str2.equals("25")) {
          str2 = "B1";
        } else if (str2.equals("26")) {
          str2 = "B2";
        } else if (str2.equals("27")) {
          str2 = "B3";
        } else if (str2.equals("28")) {
          str2 = "B4";
        } else if (str2.equals("29")) {
          str2 = "B5";
        } else if (str2.equals("47")) {
          str2 = "S1";
        } else if (str2.equals("48")) {
          str2 = "S2";
        } else if (str2.equals("49")) {
          str2 = "S3";
        } else if (str2.equals("50")) {
          str2 = "S4";
        } else if (str2.equals("51")) {
          str2 = "S5";
        } else if (str2.equals("52")) {
          str2 = "S6";
        } else if (str2.equals("53")) {
          str2 = "A1";
        } else if (str2.equals("54")) {
          str2 = "A2";
        } else if (str2.equals("55")) {
          str2 = "A3";
        } else if (str2.equals("56")) {
          str2 = "A4";
        } else if (str2.equals("57")) {
          str2 = "A5";
        } else if (str2.equals("58")) {
          str2 = "A6";
        }
        localVector.addElement(str2);
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, mesasDisponiblesLiga ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, mesasDisponiblesLiga ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, mesasDisponiblesLiga ");
          localException5.printStackTrace();
        }
      }
    }
	return localVector;
  }
  
  public double damePrecioUnitario(int paramInt1, int paramInt2, int paramInt3, int paramInt4)
    throws SQLException, Exception
  {
    double d = 0.0D;
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      ResultSet localResultSet = null;
      String str = "";
      if (paramInt1 == 1) {
        str = "SELECT precio FROM alimentos WHERE clave = " + paramInt3 + " AND division = " + paramInt2 + " AND estatus = 1";
      } else if (paramInt4 == 1) {
        str = "SELECT (precioC)AS precio FROM bebidas WHERE clave = " + paramInt3 + " AND division = " + paramInt2 + " AND estatus = 1";
      } else if ((paramInt4 == 2) || (paramInt4 == 3) || (paramInt4 == 4)) {
        str = "SELECT (precioB1)AS precio1, (precioB2) AS precio2  FROM bebidas WHERE clave = " + paramInt3 + " AND division = " + paramInt2 + " AND estatus = 1";
      }
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        if ((paramInt4 == 1) || (paramInt4 == 0)) {
          d = localResultSet.getDouble("precio");
        } else if ((paramInt4 == 2) || (paramInt4 == 3))
        {
          if (localResultSet.getDouble("precio1") > localResultSet.getDouble("precio2")) {
            d = localResultSet.getDouble("precio1");
          } else {
            d = localResultSet.getDouble("precio2");
          }
        }
        else if (localResultSet.getDouble("precio1") == 0.0D) {
          d = localResultSet.getDouble("precio2");
        } else if (localResultSet.getDouble("precio2") == 0.0D) {
          d = localResultSet.getDouble("precio1");
        } else if (localResultSet.getDouble("precio1") < localResultSet.getDouble("precio2")) {
          d = localResultSet.getDouble("precio1");
        } else {
          d = localResultSet.getDouble("precio2");
        }
      }
      return d;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, damePrecioUnitario ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecioUnitario ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecioUnitario ");
          localException5.printStackTrace();
        }
      }
    }
	return d;
  }
  
  public String dameNombreProducto(int paramInt1, int paramInt2)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    String str1 = "";
    try
    {
      ResultSet localResultSet = null;
      String str2 = "";
      if (paramInt2 == 1) {
        str2 = "SELECT nombre FROM alimentos WHERE clave = " + paramInt1 + " AND estatus = 1";
      } else {
        str2 = "SELECT nombre FROM bebidas WHERE clave = " + paramInt1 + "  AND estatus = 1";
      }
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next()) {
        str1 = localResultSet.getString("nombre");
      }
      return str1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameNombreProducto ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameNombreProducto ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameNombreProducto ");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public ResultSet listadoAlimentos(int paramInt1, int paramInt2)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    ResultSet localResultSet = null;
    try
    {
      int i = paramInt2;
      String str = "SELECT (comandapro.IDC)AS IDComanda, (comanda.IDMM)AS Mesa, CONCAT(empleados.Nombre COLLATE latin1_spanish_ci, ' ', empleados.APaterno COLLATE latin1_spanish_ci)AS Nombre, SUM(comandapro.CanPro)AS Cantidad, (alimentos.nombre)AS Producto, (comandapro.Ob)AS Observacion, (comandapro.DiA)AS Fecha, (comandapro.HR)AS Hora FROM comandapro, comanda, empleados, alimentos WHERE comandapro.IDC = " + paramInt1 + " AND comandapro.IDSecuencia = " + i + " AND comandapro.Tipo = 0 AND comandapro.Estatus = 1 AND comanda.IDC = comandapro.IDC AND empleados.IDEmpleado = comandapro.IDM AND alimentos.clave = comandapro.ClPro GROUP BY CONCAT(comandapro.ClPro,comandapro.Ob)";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, listadoAlimentos ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, listadoAlimentos ");
      localException.printStackTrace();
    }
    return localResultSet;
  }
  
  public String dameNombreMateriaPrima(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    String str1 = "";
    try
    {
      ResultSet localResultSet = null;
      String str2 = "";
      str2 = "SELECT nombre FROM materiaprima WHERE clave = " + paramInt + " AND estatus = 1";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next()) {
        str1 = localResultSet.getString("nombre");
      }
      return str1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameNombreMateriaPrima ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameNombreMateriaPrima ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameNombreMateriaPrima ");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public synchronized int traspasaMesaA(int paramInt, String paramString)
    throws SQLException, Exception
  {
	int  i = 0;
    int j = cambiaAInt(cambiaAClaveBarra(paramString));
    int k = -1;
    ConexionBD localConexionBD = new ConexionBD();
    if (localConexionBD.miConnection != null) {
      try
      {
        localConexionBD.cancelaAutoCommit();
        ResultSet localResultSet1 = null;
        Statement localStatement1 = localConexionBD.creaStatement();
        String str1 = "SELECT Estatus FROM mesas WHERE IDMesa = " + j;
        localResultSet1 = localStatement1.executeQuery(str1);
        while (localResultSet1.next()) {
          k = localResultSet1.getInt("Estatus");
        }
        if (k == 2)
        {
           i = 1;
        }
        else
        {
          if (k == 0)
          {
            PreparedStatement localPreparedStatement1 = localConexionBD.miConnection.prepareStatement("UPDATE comanda SET IDMM = ? WHERE  IDMM = ? AND Es = 1");
            localPreparedStatement1.setInt(1, j);
            localPreparedStatement1.setInt(2, paramInt);
            localPreparedStatement1.execute();
            
            PreparedStatement localPreparedStatement3 = localConexionBD.miConnection.prepareStatement("UPDATE mesas SET Estatus = ? WHERE  IDMesa = ? ");
            localPreparedStatement3.setInt(1, 1);
            localPreparedStatement3.setInt(2, j);
            localPreparedStatement3.execute();
          }
          else
          {
            int m = 0;
            int n = 0;
            int i1 = 0;
            int i2 = 0;
            
            ResultSet localResultSet2 = null;
            Statement localStatement2 = localConexionBD.creaStatement();
            String str2 = "SELECT IDC, NC, PT FROM comanda WHERE IDMM = " + paramInt + " AND Es = 1";
            localResultSet2 = localStatement2.executeQuery(str2);
            ResultSet localResultSet3 = null;
            Statement localStatement3 = localConexionBD.creaStatement();
            String str3 = "SELECT IDC, NC FROM comanda WHERE IDMM = " + j + " AND Es = 1";
            localResultSet3 = localStatement3.executeQuery(str3);
            while (localResultSet3.next())
            {
              n = localResultSet3.getInt("IDC");
              i1 = localResultSet3.getInt("NC");
            }
            while (localResultSet2.next())
            {
              m = localResultSet2.getInt("IDC");
              i2 = localResultSet2.getInt("NC");
              PreparedStatement localPreparedStatement4;
              localPreparedStatement4 = localConexionBD.miConnection.prepareStatement("UPDATE comanda SET NC = (NC+?), PT = (PT + ?) WHERE IDC = ? AND Es = 1");
              localPreparedStatement4.setInt(1, localResultSet2.getInt("NC"));
              localPreparedStatement4.setDouble(2, localResultSet2.getDouble("PT"));
              localPreparedStatement4.setInt(3, n);
              localPreparedStatement4.execute();
            }
            PreparedStatement localPreparedStatement4 = localConexionBD.miConnection.prepareStatement("UPDATE comanda SET NC = ?, PT =  ?, Es = ? WHERE IDC = ? AND Es = 1");
            localPreparedStatement4.setInt(1, 0);
            localPreparedStatement4.setDouble(2, 0.0D);
            localPreparedStatement4.setInt(3, 0);
            localPreparedStatement4.setInt(4, m);
            localPreparedStatement4.execute();
            for (int i3 = 1; i3 <= i2; i3++)
            {
              PreparedStatement localPreparedStatement5 = localConexionBD.miConnection.prepareStatement("UPDATE comandapro SET IDC = ?, IDCom =  ? \tWHERE IDC = ? AND Estatus = 1");
              localPreparedStatement5.setInt(1, n);
              localPreparedStatement5.setInt(2, i3 + i1);
              localPreparedStatement5.setInt(3, m);
              localPreparedStatement5.execute();
            }
          }
          PreparedStatement localPreparedStatement2 = localConexionBD.miConnection.prepareStatement("UPDATE mesas SET Estatus = ?, LigaA = ? WHERE  IDMesa = ? OR LigaA = ?");
          localPreparedStatement2.setInt(1, 0);
          localPreparedStatement2.setNull(2, 4);
          localPreparedStatement2.setInt(3, paramInt);
          localPreparedStatement2.setInt(4, paramInt);
          localPreparedStatement2.execute();
        }
        localConexionBD.realizaCommit();
        
        return i;
      }
      catch (SQLException localSQLException)
      {
        i = -1;
        localConexionBD.realizaRollback();
        System.out.println("Error SQL clase ManagerPuntoVenta, método traspasaMesaA: " + localSQLException);
        localSQLException.printStackTrace();
      }
      catch (Exception localException3)
      {
        i = -1;
        localConexionBD.realizaRollback();
        System.out.println("Error clase ManagerPuntoVenta, método traspasaMesaA: " + localException3);
        localException3.printStackTrace();
      }
      finally
      {
        try
        {
          localConexionBD.habilitaAutoCommit();
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComanda");
          localException5.printStackTrace();
        }
      }
    }
	return i;
  }
  
  public synchronized Vector<String> almacenaComandaInterna(Vector<Object> paramVector, int paramInt)
    throws SQLException, Exception
  {
    Vector<String> localVector = new Vector<String>();
    int i = 0;
    try
    {
      String str1 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str1));
      i = cambiaAInt(config.getProperty("botanaCla").trim());
    }
    catch (IOException localIOException)
    {
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException.printStackTrace();
    }
    ConexionBD localConexionBD = new ConexionBD();
    localConexionBD.cancelaAutoCommit();
    int j = 0;
    String str2 = "";
    Savepoint localSavepoint = null;
    if (localConexionBD.miConnection != null) {
      try
      {
        ResultSet localResultSet1 = null;
        int n;
        int i3;
        Object localObject8;
        int i15;
        int i28;
        Object localObject13;
        Object localObject15;
        Object localObject14;
        for (int m = 0; m < paramVector.size(); m++)
        {
        	Vector<Object> localObject2 = (Vector)paramVector.elementAt(m);
          n = cambiaAInt((String)((Vector)localObject2).elementAt(0));
          String localObject4 = (String)((Vector)localObject2).elementAt(1);
          int i1 = cambiaAInt(((String)localObject4).substring(0, ((String)localObject4).indexOf('*')).trim());
          i3 = cambiaAInt(((String)localObject4).substring(((String)localObject4).indexOf('*') + 1, ((String)localObject4).lastIndexOf('*')).trim());
          int i5 = cambiaAInt(((String)localObject4).substring(((String)localObject4).lastIndexOf('*') + 1, ((String)localObject4).length()).trim());
          localObject8 = (String)((Vector)localObject2).elementAt(3);
          int i8 = 1;int i9 = 0;int i10 = 0;int i12 = 0;int i14 = 0;i15 = 0;int i16 = 0;int i17 = 0;int i18 = 0;int i19 = 0;int i20 = 0;int i21 = 0;int i22 = 0;int i24 = 0;int i26 = 0;int i27 = 0;
          i28 = -1;
          if (((String)localObject8).equalsIgnoreCase("na")) {
            i28 = 0;
          } else if (((String)localObject8).equalsIgnoreCase("Copa")) {
            i28 = 1;
          } else if (((String)localObject8).equalsIgnoreCase("Botella")) {
            i28 = 2;
          } else if (((String)localObject8).equalsIgnoreCase("Botella G.")) {
            i28 = 3;
          } else if (((String)localObject8).equalsIgnoreCase("Botella P.")) {
            i28 = 4;
          }
          String str8 = (String)((Vector)localObject2).elementAt(4);
          String str9;
          int i31;
          if ((i28 == 0) && (i3 == i))
          {
            str9 = (String)((Vector)localObject2).elementAt(9);
            localObject13 = new Vector();
            while (str9.indexOf("\n") != -1)
            {
              ((Vector)localObject13).addElement(str9.substring(0, str9.indexOf("\n")));
              str9 = str9.substring(str9.indexOf("\n") + 1, str9.length());
            }
            ((Vector)localObject13).addElement(str9);
            for (i31 = 0; i31 < ((Vector)localObject13).size(); i31++) {
              if (i31 == 0) {
                i18 = cambiaAInt(((String)((Vector)localObject13).elementAt(i31)).substring(((String)((Vector)localObject13).elementAt(i31)).indexOf("*") + 1, ((String)((Vector)localObject13).elementAt(i31)).length()).trim());
              } else if (i31 == 1) {
                i19 = cambiaAInt(((String)((Vector)localObject13).elementAt(i31)).substring(((String)((Vector)localObject13).elementAt(i31)).indexOf("*") + 1, ((String)((Vector)localObject13).elementAt(i31)).length()).trim());
              } else if (i31 == 2) {
                i20 = cambiaAInt(((String)((Vector)localObject13).elementAt(i31)).substring(((String)((Vector)localObject13).elementAt(i31)).indexOf("*") + 1, ((String)((Vector)localObject13).elementAt(i31)).length()).trim());
              } else if (i31 == 3) {
                i21 = cambiaAInt(((String)((Vector)localObject13).elementAt(i31)).substring(((String)((Vector)localObject13).elementAt(i31)).indexOf("*") + 1, ((String)((Vector)localObject13).elementAt(i31)).length()).trim());
              }
            }
          }
          else if (i28 != 0)
          {
            str9 = (String)((Vector)localObject2).elementAt(5);
            if (str9.equalsIgnoreCase("NA")) {
              i8 = 1;
            } else if (str9.equalsIgnoreCase("Sencillo")) {
              i8 = 1;
            } else if (str9.equalsIgnoreCase("Doble")) {
              i8 = 2;
            } else if (str9.equalsIgnoreCase("Triple")) {
              i8 = 3;
            }
            str9 = (String)((Vector)localObject2).elementAt(6);
            if (str9.equalsIgnoreCase("NA")) {
              i9 = 0;
            } else if (str9.equalsIgnoreCase("Puesto")) {
              i9 = 1;
            } else if (str9.equalsIgnoreCase("Divorciado")) {
              i9 = 2;
            } else if (str9.equalsIgnoreCase("Derecho")) {
              i9 = 3;
            } else if (str9.equalsIgnoreCase("Rocas")) {
              i9 = 4;
            } else if (str9.equalsIgnoreCase("Chasser")) {
              i9 = 5;
            }
            str9 = (String)((Vector)localObject2).elementAt(7);
            if (str9.equalsIgnoreCase("NA")) {
              i10 = 0;
            } else if (str9.equalsIgnoreCase("Ninguno")) {
              i10 = 1;
            } else if (str9.equalsIgnoreCase("Normal")) {
              i10 = 2;
            } else if (str9.equalsIgnoreCase("Campechano")) {
              i10 = 3;
            } else if (str9.equalsIgnoreCase("Pintado")) {
              i10 = 4;
            }
            str9 = (String)((Vector)localObject2).elementAt(8);
            if (str9.equalsIgnoreCase("No")) {
              i12 = 0;
            } else if (str9.equalsIgnoreCase("C.Limon")) {
              i12 = 1;
            } else if (str9.equalsIgnoreCase("C.Sangrita")) {
              i12 = 2;
            } else if (str9.equalsIgnoreCase("Cs.Lim.San.")) {
              i12 = 3;
            }
            localObject13 = (String)((Vector)localObject2).elementAt(9);
            if (!((String)localObject13).equalsIgnoreCase("NA"))
            {
              i31 = 0;
              localObject15 = new Vector();
              int i33;
              while (((String)localObject13).indexOf("\n") != -1)
              {
                i31 = 1;
                i33 = ((String)localObject13).indexOf("\n");
                ((Vector)localObject15).addElement(((String)localObject13).substring(0, i33));
                localObject13 = ((String)localObject13).substring(i33 + 1, ((String)localObject13).length());
              }
              if (i31 == 0) {
                ((Vector)localObject15).addElement(localObject13);
              }
              if (!((String)((Vector)localObject15).elementAt(0)).trim().equalsIgnoreCase("")) {
                for (i33 = 0; i33 < ((Vector)localObject15).size(); i33++)
                {
                  String str10;
                  if (i33 == 0)
                  {
                    i14 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(0, ((String)((Vector)localObject15).elementAt(i33)).indexOf("-")).trim());
                    i18 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") + 1, ((String)((Vector)localObject15).elementAt(i33)).length()).trim());
                    str10 = ((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 3, ((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i22 = 3;
                    } else {
                      i22 = 4;
                    }
                  }
                  else if (i33 == 1)
                  {
                    i15 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(0, ((String)((Vector)localObject15).elementAt(i33)).indexOf("-")).trim());
                    i19 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") + 1, ((String)((Vector)localObject15).elementAt(i33)).length()).trim());
                    str10 = ((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 3, ((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i24 = 3;
                    } else {
                      i24 = 4;
                    }
                  }
                  else if (i33 == 2)
                  {
                    i16 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(0, ((String)((Vector)localObject15).elementAt(i33)).indexOf("-")).trim());
                    i20 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") + 1, ((String)((Vector)localObject15).elementAt(i33)).length()).trim());
                    str10 = ((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 3, ((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i26 = 3;
                    } else {
                      i26 = 4;
                    }
                  }
                  else if (i33 == 3)
                  {
                    i17 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(0, ((String)((Vector)localObject15).elementAt(i33)).indexOf("-")).trim());
                    i21 = cambiaAInt(((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") + 1, ((String)((Vector)localObject15).elementAt(i33)).length()).trim());
                    str10 = ((String)((Vector)localObject15).elementAt(i33)).substring(((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 3, ((String)((Vector)localObject15).elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i27 = 3;
                    } else {
                      i27 = 4;
                    }
                  }
                }
              }
            }
          }
          double d4 = damePrecioUnitario(i1, i3, i5, i28);
          
          localObject14 = localConexionBD.miConnection.prepareStatement("insert into tempinterno values(?,?,?,?,?,?,?,?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
          ((PreparedStatement)localObject14).setInt(1, paramInt);
          ((PreparedStatement)localObject14).setInt(2, i3);
          ((PreparedStatement)localObject14).setInt(3, i1);
          ((PreparedStatement)localObject14).setInt(4, i5);
          ((PreparedStatement)localObject14).setInt(5, i28);
          ((PreparedStatement)localObject14).setInt(6, n);
          ((PreparedStatement)localObject14).setString(7, str8);
          ((PreparedStatement)localObject14).setDouble(8, d4 * i8);
          ((PreparedStatement)localObject14).setDouble(9, d4 * i8);
          ((PreparedStatement)localObject14).setInt(10, i8);
          ((PreparedStatement)localObject14).setInt(11, i9);
          ((PreparedStatement)localObject14).setInt(12, i10);
          ((PreparedStatement)localObject14).setInt(13, i12);
          ((PreparedStatement)localObject14).setInt(14, i14);
          ((PreparedStatement)localObject14).setInt(15, i15);
          ((PreparedStatement)localObject14).setInt(16, i16);
          ((PreparedStatement)localObject14).setInt(17, i17);
          ((PreparedStatement)localObject14).setInt(18, i18);
          ((PreparedStatement)localObject14).setInt(19, i19);
          ((PreparedStatement)localObject14).setInt(20, i20);
          ((PreparedStatement)localObject14).setInt(21, i21);
          ((PreparedStatement)localObject14).setInt(22, i22);
          ((PreparedStatement)localObject14).setInt(23, i24);
          ((PreparedStatement)localObject14).setInt(24, i26);
          ((PreparedStatement)localObject14).setInt(25, i27);
          ((PreparedStatement)localObject14).execute();
        }
        Object localObject1 = "SELECT SUM(CantidadC)AS Cantidad, ClaveB AS claveProducto, TipoB AS Tipo, productoPadre FROM (SELECT IDCP AS productoPadre, CA1*CP AS CantidadC, CB1 AS ClaveB, TB1 AS TipoB FROM tempInterno WHERE IDPersonal = " + paramInt + "  AND IDG = 2 UNION ALL SELECT IDCP AS  productoPadre, CA2*CP AS CantidadC, CB2 AS ClaveB, TB2 AS TipoB FROM tempInterno WHERE IDPersonal = " + paramInt + "  AND IDG = 2 UNION ALL SELECT  IDCP AS productoPadre, CA3*CP AS CantidadC, CB3 AS ClaveB, TB3 AS TipoB FROM tempInterno WHERE IDPersonal = " + paramInt + "  AND IDG = 2 UNION ALL  SELECT IDCP AS productoPadre, CA4*CP AS CantidadC, CB4 AS ClaveB, TB4 AS TipoB FROM tempInterno WHERE IDPersonal = " + paramInt + "  AND IDG = 2) AS Temp WHERE ClaveB != 0 GROUP BY(CONCAT(productoPadre,ClaveB,TipoB))";
        Object localObject2 = localConexionBD.creaStatement();
        localResultSet1 = ((Statement)localObject2).executeQuery((String)localObject1);
        localSavepoint = localConexionBD.creaSavePoint("puntoUpdateInventarioCombinadas");
        Object localObject7;
        Object localObject9;
        Object localObject10;
        Object localObject11;
        Object localObject12;
        String str6;
        while ((localResultSet1.next()) && (j == 0))
        {
          n = localResultSet1.getInt("Cantidad");
          String localObject4 = "";
          String str3 = "";
          i3 = 0;
          localObject7 = null;
          localObject8 = null;
          ResultSet localResultSet2 = null;
          localObject9 = "";
          Statement localStatement1 = localConexionBD.creaStatement();
          Statement localStatement2 = localConexionBD.creaStatement();
          localObject10 = localConexionBD.creaStatement();
          if ((localResultSet1.getInt("tipo") == 3) || (localResultSet1.getInt("tipo") == 4))
          {
            i15 = localResultSet1.getInt("tipo");
            
            localObject4 = "SELECT materia0 FROM bebidas WHERE clave = " + localResultSet1.getInt("claveProducto") + " AND estatus = 1";
            localObject7 = localStatement1.executeQuery((String)localObject4);
            while (((ResultSet)localObject7).next())
            {
              localObject11 = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" + ((ResultSet)localObject7).getInt("materia0") + " AND Estatus = 1";
              localResultSet2 = ((Statement)localObject10).executeQuery((String)localObject11);
              while (localResultSet2.next()) {
                if ((localResultSet1.getInt("tipo") == 2) || (localResultSet1.getInt("tipo") == 3))
                {
                  if (localResultSet2.getDouble("litrosXBotella1") >= localResultSet2.getDouble("litrosXBotella2")) {
                    localObject9 = "inventarioBotella1";
                  } else {
                    localObject9 = "inventarioBotella2";
                  }
                }
                else if ((localResultSet2.getDouble("litrosXBotella1") > localResultSet2.getDouble("litrosXBotella2")) && (localResultSet2.getDouble("litrosXBotella2") != 0.0D)) {
                  localObject9 = "inventarioBotella2";
                } else {
                  localObject9 = "inventarioBotella1";
                }
              }
              localObject12 = localConexionBD.miConnection.prepareStatement("UPDATE materiaprima SET " + (String)localObject9 + " = (" + (String)localObject9 + " - ?) WHERE  clave = ? AND Estatus = 1");
              ((PreparedStatement)localObject12).setInt(1, n);
              ((PreparedStatement)localObject12).setInt(2, ((ResultSet)localObject7).getInt("materia0"));
              ((PreparedStatement)localObject12).execute();
              
              str3 = "SELECT " + (String)localObject9 + " FROM materiaprima WHERE clave = " + ((ResultSet)localObject7).getInt("materia0") + " AND tipo = 2 AND Estatus = 1";
              localObject8 = localStatement2.executeQuery(str3);
              while (((ResultSet)localObject8).next()) {
                i3 = ((ResultSet)localObject8).getInt((String)localObject9);
              }
              if (i3 < 0)
              {
                j = 1;
                str6 = "Mediana";
                if (i15 == 4) {
                  str6 = "Chica";
                }
                str2 = "Me faltan:  " + i3 * -1 + " botella(s) " + str6 + "  de " + dameNombreProducto(localResultSet1.getInt("claveProducto"), 2) + " para realizar la mezcla de " + dameNombreProducto(localResultSet1.getInt("productoPadre"), 2) + " en Inventario. \n Modifica la mezcla";
                localVector.addElement(str2);
              }
            }
          }
        }
        Object localObject3 = "SELECT SUM(CP) AS Cantidad, IDCP AS ClaveProducto, IDT AS tipo FROM tempInterno WHERE IDPersonal = " + paramInt + " GROUP BY CONCAT(IDCP,IDD,IDT) ORDER BY  IDT DESC";
        Object localObject4 = localConexionBD.creaStatement();
        localResultSet1 = ((Statement)localObject4).executeQuery((String)localObject3);
        while ((localResultSet1.next()) && (j == 0))
        {
          int i2 = localResultSet1.getInt("Cantidad");
          String localObject6 = "";
          localObject7 = "";
          int i7 = 0;
          double d1 = 0.0D;
          int i11 = 0;
          double d2 = 0.0D;
          ResultSet localResultSet3 = null;
          localObject11 = null;
          localObject12 = null;
          str6 = "";
          Statement localStatement3 = localConexionBD.creaStatement();
          Statement localStatement4 = localConexionBD.creaStatement();
          Statement localStatement5 = localConexionBD.creaStatement();
          if ((localResultSet1.getInt("tipo") == 2) || (localResultSet1.getInt("tipo") == 3) || (localResultSet1.getInt("tipo") == 4))
          {
            localObject6 = "SELECT materia0 FROM bebidas WHERE clave = " + localResultSet1.getInt("claveProducto") + " AND estatus = 1";
            localResultSet3 = localStatement3.executeQuery((String)localObject6);
          }
          while (localResultSet3.next())
          {
            String str7 = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" + localResultSet3.getInt("materia0") + " AND Estatus = 1";
            localObject12 = localStatement5.executeQuery(str7);
            while (((ResultSet)localObject12).next()) {
              if ((localResultSet1.getInt("tipo") == 2) || (localResultSet1.getInt("tipo") == 3))
              {
                if (((ResultSet)localObject12).getDouble("litrosXBotella1") >= ((ResultSet)localObject12).getDouble("litrosXBotella2")) {
                  str6 = "inventarioBotella1";
                } else {
                  str6 = "inventarioBotella2";
                }
              }
              else if ((((ResultSet)localObject12).getDouble("litrosXBotella1") > ((ResultSet)localObject12).getDouble("litrosXBotella2")) && (((ResultSet)localObject12).getDouble("litrosXBotella2") != 0.0D)) {
                str6 = "inventarioBotella2";
              } else {
                str6 = "inventarioBotella1";
              }
            }
            PreparedStatement localPreparedStatement1 = localConexionBD.miConnection.prepareStatement("UPDATE materiaprima SET " + str6 + " = (" + str6 + " - ?) WHERE  clave = ? AND Estatus = 1");
            localPreparedStatement1.setInt(1, i2);
            localPreparedStatement1.setInt(2, localResultSet3.getInt("materia0"));
            localPreparedStatement1.execute();
            
            localObject7 = "SELECT " + str6 + " FROM materiaprima WHERE clave = " + localResultSet3.getInt("materia0") + " AND tipo = 2 AND Estatus = 1";
            localObject11 = localStatement4.executeQuery((String)localObject7);
            while (((ResultSet)localObject11).next()) {
              i7 = ((ResultSet)localObject11).getInt(str6);
            }
            if (i7 < 0)
            {
              j = 1;
              str2 = "Me quedo corto por:  " + i7 * -1 + " botella(s) de " + dameNombreProducto(localResultSet1.getInt("ClaveProducto"), 2) + " en Inventario. \n Modifica tu comanda";
              localVector.addElement(str2);
            }
          }
        }
        if (j != 0)
        {
          System.out.println("Existio un problema asi que hize RollBack");
          localConexionBD.realizaRollback(localSavepoint);
        }
        else
        {
          localResultSet1 = null;
          String localObject5 = "SELECT * FROM tempInterno WHERE IDPersonal = " + paramInt + "  ORDER BY  IDT DESC";
          
          Statement localObject6 = localConexionBD.creaStatement();
          localResultSet1 = ((Statement)localObject6).executeQuery((String)localObject5);
          while (localResultSet1.next())
          {
            int i6 = localResultSet1.getInt("CP");
            this.tiempo = new TimeStamp();
            String str4 = this.tiempo.date;
            String str5 = this.tiempo.time;
            localObject9 = cambiaADate(str4);
            Time localTime = cambiaATiempo(str5);
            for (int i13 = 1; i13 <= i6; i13++)
            {
              localObject10 = localConexionBD.miConnection.prepareStatement("insert into internopro values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
              ((PreparedStatement)localObject10).setInt(1, paramInt);
              ((PreparedStatement)localObject10).setTime(2, localTime);
              ((PreparedStatement)localObject10).setDate(3, (Date)localObject9);
              ((PreparedStatement)localObject10).setInt(4, localResultSet1.getInt("IDG"));
              ((PreparedStatement)localObject10).setInt(5, localResultSet1.getInt("IDD"));
              ((PreparedStatement)localObject10).setInt(6, 1);
              ((PreparedStatement)localObject10).setInt(7, localResultSet1.getInt("IDCP"));
              ((PreparedStatement)localObject10).setDouble(8, localResultSet1.getInt("IDT"));
              ((PreparedStatement)localObject10).setString(9, localResultSet1.getString("Ob"));
              ((PreparedStatement)localObject10).setDouble(10, localResultSet1.getDouble("PU"));
              ((PreparedStatement)localObject10).setDouble(11, localResultSet1.getDouble("PT"));
              ((PreparedStatement)localObject10).setInt(12, 1);
              ((PreparedStatement)localObject10).setInt(13, 0);
              ((PreparedStatement)localObject10).setInt(14, localResultSet1.getInt("TB"));
              ((PreparedStatement)localObject10).setInt(15, localResultSet1.getInt("FB"));
              ((PreparedStatement)localObject10).setInt(16, localResultSet1.getInt("MB"));
              ((PreparedStatement)localObject10).setInt(17, localResultSet1.getInt("AB"));
              ((PreparedStatement)localObject10).setInt(18, localResultSet1.getInt("CA1"));
              ((PreparedStatement)localObject10).setInt(19, localResultSet1.getInt("CA2"));
              ((PreparedStatement)localObject10).setInt(20, localResultSet1.getInt("CA3"));
              ((PreparedStatement)localObject10).setInt(21, localResultSet1.getInt("CA4"));
              ((PreparedStatement)localObject10).setInt(22, localResultSet1.getInt("CB1"));
              ((PreparedStatement)localObject10).setInt(23, localResultSet1.getInt("CB2"));
              ((PreparedStatement)localObject10).setInt(24, localResultSet1.getInt("CB3"));
              ((PreparedStatement)localObject10).setInt(25, localResultSet1.getInt("CB4"));
              ((PreparedStatement)localObject10).setInt(26, localResultSet1.getInt("TB1"));
              ((PreparedStatement)localObject10).setInt(27, localResultSet1.getInt("TB2"));
              ((PreparedStatement)localObject10).setInt(28, localResultSet1.getInt("TB3"));
              ((PreparedStatement)localObject10).setInt(29, localResultSet1.getInt("TB4"));
              ((PreparedStatement)localObject10).execute();
            }
          }
          localVector.addElement("OK");
        }
        Object localObject5 = "DELETE FROM tempinterno WHERE IDPersonal = " + paramInt;
        Object localObject6 = localConexionBD.miConnection.createStatement();
        ((Statement)localObject6).execute((String)localObject5);
        localVector.addElement("OK");
        localConexionBD.realizaCommit();
        try
        {
          localConexionBD.realizaCommit();
          localConexionBD.habilitaAutoCommit();
          localConexionBD.cierraConexion();
        }
        catch (Exception localException1)
        {
          System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComandaInterna");
          localException1.printStackTrace();
        }
        new ImpresionTicketComidaI(paramInt);
      }
      catch (SQLException localSQLException)
      {
        if (localVector.size() == 0) {
          localVector.addElement("Error");
        } else {
          localVector.setElementAt("Error", 0);
        }
        localConexionBD.realizaRollback();
        localSQLException.printStackTrace();
        try
        {
          File localObject1 = new File("LogExSQLi.txt");
          ((File)localObject1).createNewFile();
          StringBuffer localObject2 = new StringBuffer();
          FileWriter localObject3 = new FileWriter((File)localObject1);
          BufferedWriter localObject4 = new BufferedWriter((Writer)localObject3);
          ((StringBuffer)localObject2).append(localSQLException.toString());
          StackTraceElement[] localObject5 = localSQLException.getStackTrace();
          for (int i4 = 0; i4 < localObject5.length; i4++) {
            ((StringBuffer)localObject2).append(localObject5[i4].toString());
          }
          ((StringBuffer)localObject2).append(localSQLException.getStackTrace());
          ((BufferedWriter)localObject4).write(((StringBuffer)localObject2).toString(), 0, ((StringBuffer)localObject2).toString().length());
          ((FileWriter)localObject3).flush();
          ((BufferedWriter)localObject4).close();
        }
        catch (Exception localException5) {}
        System.out.println("Error SQL clase ManagerPuntoVenta, método almacenaComandaInterna" + localSQLException);
      }
      catch (Exception localException3)
      {
        if (localVector.size() == 0) {
          localVector.addElement("Error");
        } else {
          localVector.setElementAt("Error", 0);
        }
        localConexionBD.realizaRollback();
        localException3.printStackTrace();
        try
        {
          File localFile = new File("LogExi.txt");
          localFile.createNewFile();
          StringBuffer localObject2 = new StringBuffer();
          FileWriter localObject3 = new FileWriter(localFile);
          BufferedWriter localObject4 = new BufferedWriter((Writer)localObject3);
          ((StringBuffer)localObject2).append(localException3.toString());
          StackTraceElement[] localObject5 = localException3.getStackTrace();
          for (int i4 = 0; i4 < localObject5.length; i4++) {
            ((StringBuffer)localObject2).append(localObject5[i4].toString());
          }
          ((StringBuffer)localObject2).append(localException3.getStackTrace());
          ((BufferedWriter)localObject4).write(((StringBuffer)localObject2).toString(), 0, ((StringBuffer)localObject2).toString().length());
          ((FileWriter)localObject3).flush();
          ((BufferedWriter)localObject4).close();
        }
        catch (Exception localException6) {}
        System.out.println("Error clase ManagerPuntoVenta, método almacenaComandaInterna");
      }
      finally
      {
        try
        {
          localConexionBD.realizaCommit();
          localConexionBD.habilitaAutoCommit();
          localConexionBD.cierraConexion();
        }
        catch (Exception localException7)
        {
          System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComandaInterna");
          localException7.printStackTrace();
        }
      }
    }
    new ImpresionTicketBebidaI(paramInt);
    System.out.println("Regreso en Vector Incidencias:");
    for (int k = 0; k < localVector.size(); k++) {
      System.out.println("Elemento: " + k + ", contiene -- " + (String)localVector.elementAt(k));
    }
    return localVector;
  }
  
  public synchronized Vector<String> almacenaComanda(int paramInt1, Vector<Object> paramVector, int paramInt2)
    throws SQLException, Exception
  {
    Vector<String> localVector1 = new Vector<String>();
    int i = 0;
    try
    {
      String str1 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str1));
      i = cambiaAInt(config.getProperty("botanaCla").trim());
    }
    catch (IOException localIOException)
    {
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException.printStackTrace();
    }
    ConexionBD localConexionBD = new ConexionBD();
    localConexionBD.cancelaAutoCommit();
    int j = 0;
    String str2 = "";
    Savepoint localSavepoint = null;
    int k = -1;
    if (localConexionBD.miConnection != null) {
      try
      {
        ResultSet localResultSet1 = null;
        
        Object localObject1 = "SELECT IDC FROM comanda WHERE IDMM = " + paramInt1 + " AND Es = 1";
        Object localObject2 = localConexionBD.creaStatement();
        localResultSet1 = ((Statement)localObject2).executeQuery((String)localObject1);
        while (localResultSet1.next()) {
          k = localResultSet1.getInt("IDC");
        }
        int i1;
        int i5;
        Object localObject9;
        int i14;
        int i28;
        int i29;
        Object localObject16;
        int i33;
        Object localObject17;
        for (int n = 0; n < paramVector.size(); n++)
        {
          Vector<Object> localObject4 = (Vector)paramVector.elementAt(n);
          i1 = cambiaAInt((String)((Vector)localObject4).elementAt(0));
          String localObject6 = (String)((Vector)localObject4).elementAt(1);
          int i3 = cambiaAInt(((String)localObject6).substring(0, ((String)localObject6).indexOf('*')).trim());
          i5 = cambiaAInt(((String)localObject6).substring(((String)localObject6).indexOf('*') + 1, ((String)localObject6).lastIndexOf('*')).trim());
          int i6 = cambiaAInt(((String)localObject6).substring(((String)localObject6).lastIndexOf('*') + 1, ((String)localObject6).length()).trim());
          int i7 = cambiaAInt((String)((Vector)localObject4).elementAt(2));
          localObject9 = (String)((Vector)localObject4).elementAt(4);
          int i9 = 1;int i10 = 0;int i12 = 0;int i13 = 0;i14 = 0;int i15 = 0;int i16 = 0;int i18 = 0;int i19 = 0;int i20 = 0;int i21 = 0;int i22 = 0;int i24 = 0;int i26 = 0;int i27 = 0;i28 = 0;
          i29 = -1;
          if (((String)localObject9).equalsIgnoreCase("na")) {
            i29 = 0;
          } else if (((String)localObject9).equalsIgnoreCase("Copa")) {
            i29 = 1;
          } else if (((String)localObject9).equalsIgnoreCase("Botella")) {
            i29 = 2;
          } else if (((String)localObject9).equalsIgnoreCase("Botella G.")) {
            i29 = 3;
          } else if (((String)localObject9).equalsIgnoreCase("Botella P.")) {
            i29 = 4;
          }
          String str8 = (String)((Vector)localObject4).elementAt(5);
          String str9;
          int i32;
          if ((i29 == 0) && (i5 == i))
          {
            str9 = (String)((Vector)localObject4).elementAt(10);
            localObject16 = new Vector();
            while (str9.indexOf("\n") != -1)
            {
              ((Vector)localObject16).addElement(str9.substring(0, str9.indexOf("\n")));
              str9 = str9.substring(str9.indexOf("\n") + 1, str9.length());
            }
            ((Vector)localObject16).addElement(str9);
            for (i32 = 0; i32 < ((Vector)localObject16).size(); i32++) {
              if (i32 == 0) {
                i19 = cambiaAInt(((String)((Vector)localObject16).elementAt(i32)).substring(((String)((Vector)localObject16).elementAt(i32)).indexOf("*") + 1, ((String)((Vector)localObject16).elementAt(i32)).length()).trim());
              } else if (i32 == 1) {
                i20 = cambiaAInt(((String)((Vector)localObject16).elementAt(i32)).substring(((String)((Vector)localObject16).elementAt(i32)).indexOf("*") + 1, ((String)((Vector)localObject16).elementAt(i32)).length()).trim());
              } else if (i32 == 2) {
                i21 = cambiaAInt(((String)((Vector)localObject16).elementAt(i32)).substring(((String)((Vector)localObject16).elementAt(i32)).indexOf("*") + 1, ((String)((Vector)localObject16).elementAt(i32)).length()).trim());
              } else if (i32 == 3) {
                i22 = cambiaAInt(((String)((Vector)localObject16).elementAt(i32)).substring(((String)((Vector)localObject16).elementAt(i32)).indexOf("*") + 1, ((String)((Vector)localObject16).elementAt(i32)).length()).trim());
              }
            }
          }
          else if (i29 != 0)
          {
            str9 = (String)((Vector)localObject4).elementAt(6);
            if (str9.equalsIgnoreCase("NA")) {
              i9 = 1;
            } else if (str9.equalsIgnoreCase("Sencillo")) {
              i9 = 1;
            } else if (str9.equalsIgnoreCase("Doble")) {
              i9 = 2;
            } else if (str9.equalsIgnoreCase("Triple")) {
              i9 = 3;
            }
            str9 = (String)((Vector)localObject4).elementAt(7);
            if (str9.equalsIgnoreCase("NA")) {
              i10 = 0;
            } else if (str9.equalsIgnoreCase("Puesto")) {
              i10 = 1;
            } else if (str9.equalsIgnoreCase("Divorciado")) {
              i10 = 2;
            } else if (str9.equalsIgnoreCase("Derecho")) {
              i10 = 3;
            } else if (str9.equalsIgnoreCase("Rocas")) {
              i10 = 4;
            } else if (str9.equalsIgnoreCase("Chasser")) {
              i10 = 5;
            }
            str9 = (String)((Vector)localObject4).elementAt(8);
            if (str9.equalsIgnoreCase("NA")) {
              i12 = 0;
            } else if (str9.equalsIgnoreCase("Ninguno")) {
              i12 = 1;
            } else if (str9.equalsIgnoreCase("Normal")) {
              i12 = 2;
            } else if (str9.equalsIgnoreCase("Campechano")) {
              i12 = 3;
            } else if (str9.equalsIgnoreCase("Pintado")) {
              i12 = 4;
            }
            str9 = (String)((Vector)localObject4).elementAt(9);
            if (str9.equalsIgnoreCase("No")) {
              i13 = 0;
            } else if (str9.equalsIgnoreCase("C.Limon")) {
              i13 = 1;
            } else if (str9.equalsIgnoreCase("C.Sangrita")) {
              i13 = 2;
            } else if (str9.equalsIgnoreCase("Cs.Lim.San.")) {
              i13 = 3;
            }
            localObject16 = (String)((Vector)localObject4).elementAt(10);
            if (!((String)localObject16).equalsIgnoreCase("NA"))
            {
              i32 = 0;
              Vector localVector2 = new Vector();
              while (((String)localObject16).indexOf("\n") != -1)
              {
                i32 = 1;
                i33 = ((String)localObject16).indexOf("\n");
                localVector2.addElement(((String)localObject16).substring(0, i33));
                localObject16 = ((String)localObject16).substring(i33 + 1, ((String)localObject16).length());
              }
              if (i32 == 0) {
                localVector2.addElement(localObject16);
              }
              if (!((String)localVector2.elementAt(0)).trim().equalsIgnoreCase("")) {
                for (i33 = 0; i33 < localVector2.size(); i33++)
                {
                  String str10;
                  if (i33 == 0)
                  {
                    i14 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(0, ((String)localVector2.elementAt(i33)).indexOf("-")).trim());
                    i19 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") + 1, ((String)localVector2.elementAt(i33)).length()).trim());
                    str10 = ((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") - 3, ((String)localVector2.elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i24 = 3;
                    } else {
                      i24 = 4;
                    }
                  }
                  else if (i33 == 1)
                  {
                    i15 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(0, ((String)localVector2.elementAt(i33)).indexOf("-")).trim());
                    i20 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") + 1, ((String)localVector2.elementAt(i33)).length()).trim());
                    str10 = ((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") - 3, ((String)localVector2.elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i26 = 3;
                    } else {
                      i26 = 4;
                    }
                  }
                  else if (i33 == 2)
                  {
                    i16 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(0, ((String)localVector2.elementAt(i33)).indexOf("-")).trim());
                    i21 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") + 1, ((String)localVector2.elementAt(i33)).length()).trim());
                    str10 = ((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") - 3, ((String)localVector2.elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i27 = 3;
                    } else {
                      i27 = 4;
                    }
                  }
                  else if (i33 == 3)
                  {
                    i18 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(0, ((String)localVector2.elementAt(i33)).indexOf("-")).trim());
                    i22 = cambiaAInt(((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") + 1, ((String)localVector2.elementAt(i33)).length()).trim());
                    str10 = ((String)localVector2.elementAt(i33)).substring(((String)localVector2.elementAt(i33)).lastIndexOf("*") - 3, ((String)localVector2.elementAt(i33)).lastIndexOf("*") - 2).trim();
                    if (str10.equalsIgnoreCase("M")) {
                      i28 = 3;
                    } else {
                      i28 = 4;
                    }
                  }
                }
              }
            }
          }
          double d5 = damePrecioUnitario(i3, i5, i6, i29);
          
          localObject17 = localConexionBD.miConnection.prepareStatement("insert into tempcom values(?,?,?,?,?,?,?,?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
          ((PreparedStatement)localObject17).setInt(1, k);
          ((PreparedStatement)localObject17).setInt(2, paramInt2);
          ((PreparedStatement)localObject17).setInt(3, i5);
          ((PreparedStatement)localObject17).setInt(4, i3);
          ((PreparedStatement)localObject17).setInt(5, i6);
          ((PreparedStatement)localObject17).setInt(6, i29);
          ((PreparedStatement)localObject17).setInt(7, i1);
          ((PreparedStatement)localObject17).setInt(8, i7);
          ((PreparedStatement)localObject17).setString(9, str8);
          ((PreparedStatement)localObject17).setDouble(10, d5 * i9);
          ((PreparedStatement)localObject17).setDouble(11, d5 * i9);
          ((PreparedStatement)localObject17).setInt(12, i9);
          ((PreparedStatement)localObject17).setInt(13, i10);
          ((PreparedStatement)localObject17).setInt(14, i12);
          ((PreparedStatement)localObject17).setInt(15, i13);
          ((PreparedStatement)localObject17).setInt(16, i14);
          ((PreparedStatement)localObject17).setInt(17, i15);
          ((PreparedStatement)localObject17).setInt(18, i16);
          ((PreparedStatement)localObject17).setInt(19, i18);
          ((PreparedStatement)localObject17).setInt(20, i19);
          ((PreparedStatement)localObject17).setInt(21, i20);
          ((PreparedStatement)localObject17).setInt(22, i21);
          ((PreparedStatement)localObject17).setInt(23, i22);
          ((PreparedStatement)localObject17).setInt(24, i24);
          ((PreparedStatement)localObject17).setInt(25, i26);
          ((PreparedStatement)localObject17).setInt(26, i27);
          ((PreparedStatement)localObject17).setInt(27, i28);
          ((PreparedStatement)localObject17).execute();
        }
        Object localObject3 = "SELECT SUM(CantidadC)AS Cantidad, ClaveB AS claveProducto, TipoB AS Tipo, productoPadre FROM (SELECT IDCP AS productoPadre, CA1*CP AS CantidadC, CB1 AS ClaveB, TB1 AS TipoB FROM tempcom WHERE IDC = " + k + "  AND IDG = 2 UNION ALL SELECT IDCP AS  productoPadre, CA2*CP AS CantidadC, CB2 AS ClaveB, TB2 AS TipoB FROM tempcom WHERE IDC = " + k + "  AND IDG = 2 UNION ALL SELECT  IDCP AS productoPadre, CA3*CP AS CantidadC, CB3 AS ClaveB, TB3 AS TipoB FROM tempcom WHERE IDC = " + k + "  AND IDG = 2 UNION ALL  SELECT IDCP AS productoPadre, CA4*CP AS CantidadC, CB4 AS ClaveB, TB4 AS TipoB FROM tempcom WHERE IDC = " + k + "  AND IDG = 2) AS Temp WHERE ClaveB != 0 GROUP BY(CONCAT(productoPadre,ClaveB,TipoB))";
        Object localObject4 = localConexionBD.creaStatement();
        localResultSet1 = ((Statement)localObject4).executeQuery((String)localObject3);
        localSavepoint = localConexionBD.creaSavePoint("puntoUpdateInventarioCombinadas");
        Object localObject8;
        Object localObject10;
        Object localObject11;
        Object localObject13;
        Object localObject14;
        Object localObject15;
        while ((localResultSet1.next()) && (j == 0))
        {
          i1 = localResultSet1.getInt("Cantidad");
          String localObject6 = "";
          String str3 = "";
          i5 = 0;
          localObject8 = null;
          ResultSet localResultSet2 = null;
          localObject9 = null;
          localObject10 = "";
          Statement localStatement1 = localConexionBD.creaStatement();
          Statement localStatement2 = localConexionBD.creaStatement();
          localObject11 = localConexionBD.creaStatement();
          if ((localResultSet1.getInt("tipo") == 3) || (localResultSet1.getInt("tipo") == 4))
          {
            i14 = localResultSet1.getInt("tipo");
            
            localObject6 = "SELECT materia0 FROM bebidas WHERE clave = " + localResultSet1.getInt("claveProducto") + " AND estatus = 1";
            localObject8 = localStatement1.executeQuery((String)localObject6);
            while (((ResultSet)localObject8).next())
            {
              localObject13 = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" + ((ResultSet)localObject8).getInt("materia0") + " AND Estatus = 1";
              localObject9 = ((Statement)localObject11).executeQuery((String)localObject13);
              while (((ResultSet)localObject9).next()) {
                if ((localResultSet1.getInt("tipo") == 2) || (localResultSet1.getInt("tipo") == 3))
                {
                  if (((ResultSet)localObject9).getDouble("litrosXBotella1") >= ((ResultSet)localObject9).getDouble("litrosXBotella2")) {
                    localObject10 = "inventarioBotella1";
                  } else {
                    localObject10 = "inventarioBotella2";
                  }
                }
                else if ((((ResultSet)localObject9).getDouble("litrosXBotella1") > ((ResultSet)localObject9).getDouble("litrosXBotella2")) && (((ResultSet)localObject9).getDouble("litrosXBotella2") != 0.0D)) {
                  localObject10 = "inventarioBotella2";
                } else {
                  localObject10 = "inventarioBotella1";
                }
              }
              localObject14 = localConexionBD.miConnection.prepareStatement("UPDATE materiaprima SET " + (String)localObject10 + " = (" + (String)localObject10 + " - ?) WHERE  clave = ? AND Estatus = 1");
              ((PreparedStatement)localObject14).setInt(1, i1);
              ((PreparedStatement)localObject14).setInt(2, ((ResultSet)localObject8).getInt("materia0"));
              ((PreparedStatement)localObject14).execute();
              
              str3 = "SELECT " + (String)localObject10 + " FROM materiaprima WHERE clave = " + ((ResultSet)localObject8).getInt("materia0") + " AND tipo = 2 AND Estatus = 1";
              localResultSet2 = localStatement2.executeQuery(str3);
              while (localResultSet2.next()) {
                i5 = localResultSet2.getInt((String)localObject10);
              }
              if (i5 < 0)
              {
                j = 1;
                localObject15 = "Mediana";
                if (i14 == 4) {
                  localObject15 = "Chica";
                }
                str2 = "Me faltan:  " + i5 * -1 + " botella(s) " + (String)localObject15 + "  de " + dameNombreProducto(localResultSet1.getInt("claveProducto"), 2) + " para realizar la mezcla de " + dameNombreProducto(localResultSet1.getInt("productoPadre"), 2) + " en Inventario. \n Modifica la mezcla";
                localVector1.addElement(str2);
              }
            }
          }
        }
        Object localObject5 = "SELECT SUM(CP) AS Cantidad, IDCP AS ClaveProducto, IDT AS tipo FROM tempcom WHERE IDC = " + k + " GROUP BY CONCAT(IDCP,IDD,IDT) ORDER BY  IDT DESC";
        Object localObject6 = localConexionBD.creaStatement();
        localResultSet1 = ((Statement)localObject6).executeQuery((String)localObject5);
        int i8;
        int i11;
        Object localObject12;
        while ((localResultSet1.next()) && (j == 0))
        {
          int i4 = localResultSet1.getInt("Cantidad");
          String localObject7 = "";
          localObject8 = "";
          i8 = 0;
          double d1 = 0.0D;
          i11 = 0;
          double d3 = 0.0D;
          localObject12 = null;
          localObject13 = null;
          localObject14 = null;
          localObject15 = "";
          Statement localStatement3 = localConexionBD.creaStatement();
          Statement localStatement4 = localConexionBD.creaStatement();
          Statement localStatement5 = localConexionBD.creaStatement();
          if ((localResultSet1.getInt("tipo") == 2) || (localResultSet1.getInt("tipo") == 3) || (localResultSet1.getInt("tipo") == 4))
          {
            localObject7 = "SELECT materia0 FROM bebidas WHERE clave = " + localResultSet1.getInt("claveProducto") + " AND estatus = 1";
            localObject12 = localStatement3.executeQuery((String)localObject7);
          }
          while (((ResultSet)localObject12).next())
          {
            String str7 = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" + ((ResultSet)localObject12).getInt("materia0") + " AND Estatus = 1";
            localObject14 = localStatement5.executeQuery(str7);
            while (((ResultSet)localObject14).next()) {
              if ((localResultSet1.getInt("tipo") == 2) || (localResultSet1.getInt("tipo") == 3))
              {
                if (((ResultSet)localObject14).getDouble("litrosXBotella1") >= ((ResultSet)localObject14).getDouble("litrosXBotella2")) {
                  localObject15 = "inventarioBotella1";
                } else {
                  localObject15 = "inventarioBotella2";
                }
              }
              else if ((((ResultSet)localObject14).getDouble("litrosXBotella1") > ((ResultSet)localObject14).getDouble("litrosXBotella2")) && (((ResultSet)localObject14).getDouble("litrosXBotella2") != 0.0D)) {
                localObject15 = "inventarioBotella2";
              } else {
                localObject15 = "inventarioBotella1";
              }
            }
            PreparedStatement localPreparedStatement1 = localConexionBD.miConnection.prepareStatement("UPDATE materiaprima SET " + (String)localObject15 + " = (" + (String)localObject15 + " - ?) WHERE  clave = ? AND Estatus = 1");
            localPreparedStatement1.setInt(1, i4);
            localPreparedStatement1.setInt(2, ((ResultSet)localObject12).getInt("materia0"));
            localPreparedStatement1.execute();
            
            localObject8 = "SELECT " + (String)localObject15 + " FROM materiaprima WHERE clave = " + ((ResultSet)localObject12).getInt("materia0") + " AND tipo = 2 AND Estatus = 1";
            localObject13 = localStatement4.executeQuery((String)localObject8);
            while (((ResultSet)localObject13).next()) {
              i8 = ((ResultSet)localObject13).getInt((String)localObject15);
            }
            if (i8 < 0)
            {
              j = 1;
              str2 = "Me quedo corto por:  " + i8 * -1 + " botella(s) de " + dameNombreProducto(localResultSet1.getInt("ClaveProducto"), 2) + " en Inventario. \n Modifica tu comanda";
              localVector1.addElement(str2);
            }
          }
        }
        if (j != 0)
        {
          System.out.println("Existio un problema asi que hize RollBack");
          localConexionBD.realizaRollback(localSavepoint);
        }
        else
        {
          localResultSet1 = null;
          String str4 = "SELECT * FROM tempcom WHERE IDC = " + k + "  ORDER BY  IDT DESC";
          
          Statement localObject7 = localConexionBD.creaStatement();
          localResultSet1 = ((Statement)localObject7).executeQuery(str4);
          localObject8 = null;
          i8 = 0;
          String str5 = "SELECT DISTINCT MAX(IDSecuencia)AS Maximo FROM comandapro WHERE IDC = " + k;
          localObject10 = localConexionBD.creaStatement();
          localObject8 = ((Statement)localObject10).executeQuery(str5);
          while (((ResultSet)localObject8).next()) {
            i8 = ((ResultSet)localObject8).getInt("Maximo");
          }
          i8++;
          while (localResultSet1.next())
          {
            i11 = localResultSet1.getInt("CP");
            this.tiempo = new TimeStamp();
            String str6 = this.tiempo.date;
            localObject11 = this.tiempo.time;
            localObject12 = cambiaADate(str6);
            localObject13 = cambiaATiempo((String)localObject11);
            for (int i17 = 1; i17 <= i11; i17++)
            {
              localObject15 = localConexionBD.miConnection.prepareStatement("insert into comandapro values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
              ((PreparedStatement)localObject15).setInt(1, k);
              ((PreparedStatement)localObject15).setInt(2, localResultSet1.getInt("IDM"));
              ((PreparedStatement)localObject15).setInt(3, localResultSet1.getInt("IDCom"));
              ((PreparedStatement)localObject15).setTime(4, (Time)localObject13);
              ((PreparedStatement)localObject15).setDate(5, (Date)localObject12);
              ((PreparedStatement)localObject15).setInt(6, localResultSet1.getInt("IDG"));
              ((PreparedStatement)localObject15).setInt(7, localResultSet1.getInt("IDD"));
              ((PreparedStatement)localObject15).setInt(8, 1);
              ((PreparedStatement)localObject15).setInt(9, localResultSet1.getInt("IDCP"));
              ((PreparedStatement)localObject15).setDouble(10, localResultSet1.getInt("IDT"));
              ((PreparedStatement)localObject15).setString(11, localResultSet1.getString("Ob"));
              ((PreparedStatement)localObject15).setDouble(12, localResultSet1.getDouble("PU"));
              ((PreparedStatement)localObject15).setDouble(13, localResultSet1.getDouble("PT"));
              ((PreparedStatement)localObject15).setInt(14, 1);
              ((PreparedStatement)localObject15).setInt(15, i8);
              ((PreparedStatement)localObject15).setInt(16, 0);
              ((PreparedStatement)localObject15).setInt(17, localResultSet1.getInt("TB"));
              ((PreparedStatement)localObject15).setInt(18, localResultSet1.getInt("FB"));
              ((PreparedStatement)localObject15).setInt(19, localResultSet1.getInt("MB"));
              ((PreparedStatement)localObject15).setInt(20, localResultSet1.getInt("AB"));
              ((PreparedStatement)localObject15).setInt(21, localResultSet1.getInt("CA1"));
              ((PreparedStatement)localObject15).setInt(22, localResultSet1.getInt("CA2"));
              ((PreparedStatement)localObject15).setInt(23, localResultSet1.getInt("CA3"));
              ((PreparedStatement)localObject15).setInt(24, localResultSet1.getInt("CA4"));
              ((PreparedStatement)localObject15).setInt(25, localResultSet1.getInt("CB1"));
              ((PreparedStatement)localObject15).setInt(26, localResultSet1.getInt("CB2"));
              ((PreparedStatement)localObject15).setInt(27, localResultSet1.getInt("CB3"));
              ((PreparedStatement)localObject15).setInt(28, localResultSet1.getInt("CB4"));
              ((PreparedStatement)localObject15).setInt(29, localResultSet1.getInt("TB1"));
              ((PreparedStatement)localObject15).setInt(30, localResultSet1.getInt("TB2"));
              ((PreparedStatement)localObject15).setInt(31, localResultSet1.getInt("TB3"));
              ((PreparedStatement)localObject15).setInt(32, localResultSet1.getInt("TB4"));
              ((PreparedStatement)localObject15).execute();
            }
          }
          localResultSet1 = null;
          double d2 = 0.0D;
          localObject11 = "SELECT SUM(PT)AS sumatoria FROM comandapro WHERE IDC = " + k;
          localObject12 = localConexionBD.creaStatement();
          localResultSet1 = ((Statement)localObject12).executeQuery((String)localObject11);
          while (localResultSet1.next()) {
            d2 = localResultSet1.getDouble("sumatoria");
          }
          localObject13 = localConexionBD.miConnection.prepareStatement("UPDATE comanda SET PT = ?  WHERE  IDC = ? AND Es = 1 ");
          ((PreparedStatement)localObject13).setDouble(1, d2);
          ((PreparedStatement)localObject13).setInt(2, k);
          ((PreparedStatement)localObject13).execute();
          localVector1.addElement("OK");
        }
        String str4 = "DELETE FROM tempcom WHERE IDC = " + k;
        Object localObject7 = localConexionBD.miConnection.createStatement();
        ((Statement)localObject7).execute(str4);
        localVector1.addElement("OK");
        localConexionBD.realizaCommit();
        try
        {
          localConexionBD.realizaCommit();
          localConexionBD.habilitaAutoCommit();
          localConexionBD.cierraConexion();
        }
        catch (Exception localException1)
        {
          System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComanda");
          localException1.printStackTrace();
        }
        int i2;
        File localFile;
        new ImpresionTicketComida(k);
      }
      catch (SQLException localSQLException)
      {
        if (localVector1.size() == 0) {
          localVector1.addElement("Error");
        } else {
          localVector1.setElementAt("Error", 0);
        }
        localConexionBD.realizaRollback();
        localSQLException.printStackTrace();
        try
        {
          File localObject1 = new File("LogExSQL.txt");
          ((File)localObject1).createNewFile();
          StringBuffer localObject2 = new StringBuffer();
          FileWriter localObject3 = new FileWriter((File)localObject1);
          BufferedWriter localObject4 = new BufferedWriter((Writer)localObject3);
          ((StringBuffer)localObject2).append(localSQLException.toString());
          StackTraceElement[] localObject5 = localSQLException.getStackTrace();
          for (int i2 = 0; i2 < localObject5.length; i2++) {
            ((StringBuffer)localObject2).append(localObject5[i2].toString());
          }
          ((StringBuffer)localObject2).append(localSQLException.getStackTrace());
          ((BufferedWriter)localObject4).write(((StringBuffer)localObject2).toString(), 0, ((StringBuffer)localObject2).toString().length());
          ((FileWriter)localObject3).flush();
          ((BufferedWriter)localObject4).close();
        }
        catch (Exception localException5) {}
        System.out.println("Error SQL clase ManagerPuntoVenta, método almacenaComanda" + localSQLException);
      }
      catch (Exception localException3)
      {
        if (localVector1.size() == 0) {
          localVector1.addElement("Error");
        } else {
          localVector1.setElementAt("Error", 0);
        }
        localConexionBD.realizaRollback();
        localException3.printStackTrace();
        try
        {
          File localFile = new File("LogEx.txt");
          localFile.createNewFile();
          StringBuffer localObject2 = new StringBuffer();
          FileWriter localObject3 = new FileWriter(localFile);
          BufferedWriter localObject4 = new BufferedWriter((Writer)localObject3);
          ((StringBuffer)localObject2).append(localException3.toString());
          StackTraceElement[] localObject5 = localException3.getStackTrace();
          for (int i2 = 0; i2 < localObject5.length; i2++) {
            ((StringBuffer)localObject2).append(localObject5[i2].toString());
          }
          ((StringBuffer)localObject2).append(localException3.getStackTrace());
          ((BufferedWriter)localObject4).write(((StringBuffer)localObject2).toString(), 0, ((StringBuffer)localObject2).toString().length());
          ((FileWriter)localObject3).flush();
          ((BufferedWriter)localObject4).close();
        }
        catch (Exception localException6) {}
        System.out.println("Error clase ManagerPuntoVenta, método almacenaComanda");
      }
      finally
      {
        try
        {
          localConexionBD.realizaCommit();
          localConexionBD.habilitaAutoCommit();
          localConexionBD.cierraConexion();
        }
        catch (Exception localException7)
        {
          System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComanda");
          localException7.printStackTrace();
        }
      }
    }
    new ImpresionTicketBebida(k);
    System.out.println("Regreso en Vector Incidencias:");
    for (int m = 0; m < localVector1.size(); m++) {
      System.out.println("Elemento: " + m + ", contiene -- " + (String)localVector1.elementAt(m));
    }
    return localVector1;
  }
  
  public void ImprimeTicketTotal(int paramInt)
    throws Exception
  {
    try
    {
      new ImpresionTicketComandaT(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public void ImprimeTicketxComensal(int paramInt)
    throws Exception
  {
    try
    {
      new ImpresionTicketXComensal(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public synchronized String modificaMesa(int paramInt1, int paramInt2, int paramInt3, DefaultListModel paramDefaultListModel)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    localConexionBD.cancelaAutoCommit();
    String str1 = "OK";
    Vector localVector1 = new Vector();
    Vector localVector2 = new Vector();
    int i = paramDefaultListModel.getSize();
    for (int j = 0; j < i; j++) {
      localVector2.addElement(cambiaAClaveBarra((String)paramDefaultListModel.elementAt(j)));
    }
    int j = 0;
    if (localConexionBD.miConnection != null) {
      try
      {
        ResultSet localResultSet = null;
        String str2 = "SELECT IDMesa FROM mesas WHERE LigaA = " + paramInt3;
        Statement localStatement1 = localConexionBD.creaStatement();
        localResultSet = localStatement1.executeQuery(str2);
        while (localResultSet.next()) {
          localVector1.addElement(localResultSet.getString("IDMesa"));
        }
        localResultSet = null;
        int k = paramDefaultListModel.getSize();
        Object localObject1;
        Object localObject2;
        if (k > 0)
        {
          localObject1 = cambiaAClaveBarra((String)paramDefaultListModel.getElementAt(0));
          for (int m = 1; m < k; m++) {
            localObject1 = (String)localObject1 + " OR IDMESA = " + cambiaAClaveBarra((String)paramDefaultListModel.getElementAt(m));
          }
          localResultSet = null;
          localObject2 = "SELECT IDMesa, Estatus FROM mesas WHERE IDMesa = " + (String)localObject1;
          Statement localStatement2 = localConexionBD.creaStatement();
          localResultSet = localStatement2.executeQuery((String)localObject2);
          while (localResultSet.next())
          {
            int i1 = 1;
            if (localResultSet.getInt("Estatus") > 0)
            {
              for (int i2 = 0; i2 < localVector1.size(); i2++) {
                if (localResultSet.getString("IDMesa").equalsIgnoreCase((String)localVector1.elementAt(i2))) {
                  i1 = 0;
                }
              }
              if (i1 != 0)
              {
                j = 1;
                str1 = "ML";
              }
            }
          }
        }
        if (j == 0)
        {
          localObject1 = localConexionBD.miConnection.prepareStatement("UPDATE comanda SET IDM = ?,  NC = ?  WHERE IDMM = ?  AND Es = 1");
          ((PreparedStatement)localObject1).setInt(1, paramInt1);
          ((PreparedStatement)localObject1).setInt(2, paramInt2);
          ((PreparedStatement)localObject1).setInt(3, paramInt3);
          ((PreparedStatement)localObject1).execute();
          
          localObject2 = localConexionBD.miConnection.prepareStatement("UPDATE mesas SET LigaA = ?, Estatus = ?  WHERE LigaA = ?");
          ((PreparedStatement)localObject2).setNull(1, 4);
          ((PreparedStatement)localObject2).setInt(2, 0);
          ((PreparedStatement)localObject2).setInt(3, paramInt3);
          ((PreparedStatement)localObject2).execute();
          if (localVector2.size() > 0) {
            for (int n = 0; n < localVector2.size(); n++)
            {
              String str3 = (String)localVector2.elementAt(n);
              
              PreparedStatement localPreparedStatement = localConexionBD.miConnection.prepareStatement("UPDATE mesas SET Estatus = ?, LigaA = ?  WHERE IDMesa = ?");
              localPreparedStatement.setInt(1, 2);
              localPreparedStatement.setInt(2, paramInt3);
              localPreparedStatement.setString(3, str3);
              localPreparedStatement.execute();
            }
          }
        }
        localConexionBD.realizaCommit();
        
        return str1;
      }
      catch (SQLException localSQLException)
      {
        localConexionBD.realizaRollback();
        str1 = "ERROR";
        localSQLException.printStackTrace();
        System.out.println("Error SQL clase ManagerPuntoVenta, método modificaMesa" + localSQLException);
      }
      catch (Exception localException3)
      {
        localConexionBD.realizaRollback();
        str1 = "ERROR";
        localException3.printStackTrace();
        System.out.println("Error clase ManagerPuntoVenta, método modificaMesa");
      }
      finally
      {
        try
        {
          localConexionBD.habilitaAutoCommit();
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo modificaMesa");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public synchronized String altaDeMesa(int paramInt1, int paramInt2, int paramInt3, DefaultListModel paramDefaultListModel)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    localConexionBD.cancelaAutoCommit();
    String str1 = "OK";
    int i = 0;
    int j = 0;
    if (localConexionBD.miConnection != null) {
      try
      {
        ResultSet localResultSet = null;
        this.tiempo = new TimeStamp();
        String str2 = this.tiempo.date;
        String str3 = this.tiempo.time;
        Date localDate = cambiaADate(str2);
        Time localTime = cambiaATiempo(str3);
        
        String str4 = "SELECT Estatus FROM mesas WHERE IDMesa = " + paramInt3;
        Statement localStatement = localConexionBD.creaStatement();
        localResultSet = localStatement.executeQuery(str4);
        while (localResultSet.next()) {
          if (localResultSet.getInt("Estatus") > 0)
          {
            i = 1;
            str1 = "MO";
          }
        }
        Object localObject1;
        String str6;
        if ((i == 0) && (paramDefaultListModel.getSize() > 0))
        {
          localResultSet = null;
          int k = paramDefaultListModel.getSize();
          String str5 = (String)paramDefaultListModel.getElementAt(0);
          if (str5.equals("B1")) {
            str5 = "25";
          } else if (str5.equals("B2")) {
            str5 = "26";
          } else if (str5.equals("B3")) {
            str5 = "27";
          } else if (str5.equals("B4")) {
            str5 = "28";
          } else if (str5.equals("B5")) {
            str5 = "29";
          } else if (str5.equals("S1")) {
            str5 = "47";
          } else if (str5.equals("S2")) {
            str5 = "48";
          } else if (str5.equals("S3")) {
            str5 = "49";
          } else if (str5.equals("S4")) {
            str5 = "50";
          } else if (str5.equals("S5")) {
            str5 = "51";
          } else if (str5.equals("S6")) {
            str5 = "52";
          } else if (str5.equals("A1")) {
            str5 = "53";
          } else if (str5.equals("A2")) {
            str5 = "54";
          } else if (str5.equals("A3")) {
            str5 = "55";
          } else if (str5.equals("A4")) {
            str5 = "56";
          } else if (str5.equals("A5")) {
            str5 = "57";
          } else if (str5.equals("A6")) {
            str5 = "58";
          }
          for (int n = 1; n < k; n++)
          {
            localObject1 = (String)paramDefaultListModel.getElementAt(n);
            if (((String)localObject1).equals("B1")) {
              localObject1 = "25";
            } else if (((String)localObject1).equals("B2")) {
              localObject1 = "26";
            } else if (((String)localObject1).equals("B3")) {
              localObject1 = "27";
            } else if (((String)localObject1).equals("B4")) {
              localObject1 = "28";
            } else if (((String)localObject1).equals("B5")) {
              localObject1 = "29";
            } else if (((String)localObject1).equals("S1")) {
              localObject1 = "47";
            } else if (((String)localObject1).equals("S2")) {
              localObject1 = "48";
            } else if (((String)localObject1).equals("S3")) {
              localObject1 = "49";
            } else if (((String)localObject1).equals("S4")) {
              localObject1 = "50";
            } else if (((String)localObject1).equals("S5")) {
              localObject1 = "51";
            } else if (((String)localObject1).equals("S6")) {
              localObject1 = "52";
            } else if (((String)localObject1).equals("A1")) {
              localObject1 = "53";
            } else if (((String)localObject1).equals("A2")) {
              localObject1 = "54";
            } else if (((String)localObject1).equals("A3")) {
              localObject1 = "55";
            } else if (((String)localObject1).equals("A4")) {
              localObject1 = "56";
            } else if (((String)localObject1).equals("A5")) {
              localObject1 = "57";
            } else if (((String)localObject1).equals("A6")) {
              localObject1 = "58";
            }
            str5 = str5 + " OR IDMESA = " + (String)localObject1;
          }
          str6 = "SELECT Estatus FROM mesas WHERE IDMesa = " + str5;
          localObject1 = localConexionBD.creaStatement();
          localResultSet = ((Statement)localObject1).executeQuery(str6);
          while (localResultSet.next()) {
            if (localResultSet.getInt("Estatus") > 0)
            {
              j = 1;
              str1 = "ML";
            }
          }
          localResultSet.close();
        }
        if ((j == 0) && (i == 0))
        {
          PreparedStatement localPreparedStatement1 = localConexionBD.miConnection.prepareStatement("insert into comanda values(?,?,?,?,?,?,?,?);");
          localPreparedStatement1.setNull(1, 4);
          localPreparedStatement1.setInt(2, paramInt3);
          localPreparedStatement1.setInt(3, paramInt1);
          localPreparedStatement1.setDate(4, localDate);
          localPreparedStatement1.setTime(5, localTime);
          localPreparedStatement1.setInt(6, paramInt2);
          localPreparedStatement1.setDouble(7, 0.0D);
          localPreparedStatement1.setInt(8, 1);
          localPreparedStatement1.execute();
          localPreparedStatement1.close();
          
          int m = 0;
          str6 = "SELECT MAX(IDC)AS IDC FROM comanda WHERE Es = 1";
          localObject1 = localConexionBD.creaStatement();
          localResultSet = ((Statement)localObject1).executeQuery(str6);
          while (localResultSet.next()) {
            m = localResultSet.getInt("IDC");
          }
          localResultSet.close();
          ((Statement)localObject1).close();
          
          PreparedStatement localPreparedStatement2 = localConexionBD.miConnection.prepareStatement("insert into hidecomanda values(?,?,?,?,?);");
          localPreparedStatement2.setNull(1, 4);
          localPreparedStatement2.setInt(2, paramInt3);
          localPreparedStatement2.setInt(3, m);
          localPreparedStatement2.setDate(4, localDate);
          localPreparedStatement2.setTime(5, localTime);
          localPreparedStatement2.execute();
          localPreparedStatement2.close();
          
          PreparedStatement localPreparedStatement3 = localConexionBD.miConnection.prepareStatement("UPDATE mesas SET Estatus = ?  WHERE IDMesa = ?");
          localPreparedStatement3.setInt(1, 1);
          localPreparedStatement3.setInt(2, paramInt3);
          localPreparedStatement3.execute();
          if (paramDefaultListModel.getSize() > 0)
          {
            int i1 = paramDefaultListModel.getSize();
            for (int i2 = 0; i2 < i1; i2++)
            {
              String str7 = (String)paramDefaultListModel.getElementAt(i2);
              if (str7.equals("B1")) {
                str7 = "25";
              } else if (str7.equals("B2")) {
                str7 = "26";
              } else if (str7.equals("B3")) {
                str7 = "27";
              } else if (str7.equals("B4")) {
                str7 = "28";
              } else if (str7.equals("B5")) {
                str7 = "29";
              } else if (str7.equals("S1")) {
                str7 = "47";
              } else if (str7.equals("S2")) {
                str7 = "48";
              } else if (str7.equals("S3")) {
                str7 = "49";
              } else if (str7.equals("S4")) {
                str7 = "50";
              } else if (str7.equals("S5")) {
                str7 = "51";
              } else if (str7.equals("S6")) {
                str7 = "52";
              } else if (str7.equals("A1")) {
                str7 = "53";
              } else if (str7.equals("A2")) {
                str7 = "54";
              } else if (str7.equals("A3")) {
                str7 = "55";
              } else if (str7.equals("A4")) {
                str7 = "56";
              } else if (str7.equals("A5")) {
                str7 = "57";
              } else if (str7.equals("A6")) {
                str7 = "58";
              }
              PreparedStatement localPreparedStatement4 = localConexionBD.miConnection.prepareStatement("UPDATE mesas SET Estatus = ?, LigaA = ?  WHERE IDMesa = ?");
              localPreparedStatement4.setInt(1, 2);
              localPreparedStatement4.setInt(2, paramInt3);
              localPreparedStatement4.setString(3, str7);
              localPreparedStatement4.execute();
            }
          }
        }
        localConexionBD.realizaCommit();
        
        return str1;
      }
      catch (SQLException localSQLException)
      {
        localConexionBD.realizaRollback();
        str1 = "ERROR";
        localSQLException.printStackTrace();
        System.out.println("Error SQL clase ManagerPuntoVenta, método altaDeMesa" + localSQLException);
      }
      catch (Exception localException3)
      {
        localConexionBD.realizaRollback();
        str1 = "ERROR";
        localException3.printStackTrace();
        System.out.println("Error clase ManagerPuntoVenta, método altaDeMesa");
      }
      finally
      {
        try
        {
          localConexionBD.habilitaAutoCommit();
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo altaDeMesa");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public String cambiaAClaveBarra(String paramString)
    throws Exception
  {
    if (paramString.equals("B1")) {
      paramString = "25";
    } else if (paramString.equals("B2")) {
      paramString = "26";
    } else if (paramString.equals("B3")) {
      paramString = "27";
    } else if (paramString.equals("B4")) {
      paramString = "28";
    } else if (paramString.equals("B5")) {
      paramString = "29";
    } else if (paramString.equals("S1")) {
      paramString = "47";
    } else if (paramString.equals("S2")) {
      paramString = "48";
    } else if (paramString.equals("S3")) {
      paramString = "49";
    } else if (paramString.equals("S4")) {
      paramString = "50";
    } else if (paramString.equals("S5")) {
      paramString = "51";
    } else if (paramString.equals("S6")) {
      paramString = "52";
    } else if (paramString.equals("A1")) {
      paramString = "53";
    } else if (paramString.equals("A2")) {
      paramString = "54";
    } else if (paramString.equals("A3")) {
      paramString = "55";
    } else if (paramString.equals("A4")) {
      paramString = "56";
    } else if (paramString.equals("A5")) {
      paramString = "57";
    } else if (paramString.equals("A6")) {
      paramString = "58";
    }
    return paramString;
  }
  
  public String cambiaANombreBarra(String paramString)
    throws Exception
  {
    if (paramString.equals("25")) {
      paramString = "B1";
    } else if (paramString.equals("26")) {
      paramString = "B2";
    } else if (paramString.equals("27")) {
      paramString = "B3";
    } else if (paramString.equals("28")) {
      paramString = "B4";
    } else if (paramString.equals("29")) {
      paramString = "B5";
    } else if (paramString.equals("47")) {
      paramString = "S1";
    } else if (paramString.equals("48")) {
      paramString = "S2";
    } else if (paramString.equals("49")) {
      paramString = "S3";
    } else if (paramString.equals("50")) {
      paramString = "S4";
    } else if (paramString.equals("51")) {
      paramString = "S5";
    } else if (paramString.equals("52")) {
      paramString = "S6";
    } else if (paramString.equals("53")) {
      paramString = "A1";
    } else if (paramString.equals("54")) {
      paramString = "A2";
    } else if (paramString.equals("55")) {
      paramString = "A3";
    } else if (paramString.equals("56")) {
      paramString = "A4";
    } else if (paramString.equals("57")) {
      paramString = "A5";
    } else if (paramString.equals("58")) {
      paramString = "A6";
    }
    return paramString;
  }
  
  public Vector<String> comensalesDesglosados(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    int i = 0;
    Vector <String>localVector = new Vector <String>();
    
    try
    {
      ResultSet localResultSet = null;
      String str1 = "SELECT NC FROM comanda WHERE IDMM =  " + paramInt + "  AND Es = 1";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str1);
      while (localResultSet.next()) {
        i = localResultSet.getInt("NC");
      }
      for (int j = 1; j <= i; j++)
      {
        String str2 = j + "";
        localVector.addElement(str2);
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, comensalesDesglosados ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, comensalesDesglosados ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, comensalesDesglosados ");
          localException5.printStackTrace();
        }
      }
    }
    return localVector;
  }
  
  public Vector<String> divisionesDisponibles(int paramInt)
    throws SQLException, Exception
  {
    ConexionBD localConexionBD = new ConexionBD();
    String str1 = "";
    Vector <String> localVector = new Vector <String>();
    try
    {
      ResultSet localResultSet = null;
      String str2 = "SELECT CONCAT(nombre COLLATE latin1_spanish_ci,' - ',clave)AS divi FROM division  WHERE area =  " + paramInt + " AND estatus = 1 ORDER BY nombre";
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next())
      {
        str1 = localResultSet.getString("divi");
        localVector.addElement(str1);
      }
      return localVector;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, divisionesDisponibles ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, divisionesDisponibles ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, divisionesDisponibles ");
          localException5.printStackTrace();
        }
      }
    }
    return localVector;
  }
  
  public MyTableModel comandaDesglosXComensal(int paramInt)
    throws Exception
  {
	  MyTableModel localMyTableModel = null;
    
    String[] arrayOfString = new String[5];
    arrayOfString[0] = "Cantidad";
    arrayOfString[1] = "Tipo";
    arrayOfString[2] = "Clave";
    arrayOfString[3] = "Producto";
    arrayOfString[4] = "Comensal";
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      ResultSet localResultSet = dameXComeComanda(paramInt, localConexionBD);
      ResultSetMetaData localResultSetMetaData = localResultSet.getMetaData();
      int i = localResultSetMetaData.getColumnCount() - 1;
      int j = getResultSetSize(localResultSet);
      Object[][] arrayOfObject = new Object[j][i];
      int k = 0;
      while (localResultSet.next())
      {
        for (int m = 0; m < i; m++) {
          if (m == 0)
          {
            arrayOfObject[k][m] = localResultSet.getString("cantidad");
          }
          else if (m == 1)
          {
            int n = localResultSet.getInt("Tipo");
            int i1 = localResultSet.getInt("Tamanio");
            String str = "N/A";
            if ((n == 1) && (i1 == 1)) {
              str = "Copa";
            } else if ((n == 1) && (i1 == 2)) {
              str = "Copa D.";
            } else if ((n == 1) && (i1 == 3)) {
              str = "Copa T.";
            } else if (n == 2) {
              str = "Botella";
            } else if (n == 3) {
              str = "Botella G.";
            } else if (n == 4) {
              str = "Botella P.";
            }
            arrayOfObject[k][m] = str;
          }
          else if (m == 2)
          {
            arrayOfObject[k][m] = localResultSet.getString("ClaveP");
          }
          else if (m == 3)
          {
            arrayOfObject[k][m] = localResultSet.getString("Producto");
          }
          else if (m == 4)
          {
            arrayOfObject[k][m] = localResultSet.getString("IDCom");
          }
        }
        k++;
      }
      localMyTableModel = new MyTableModel(arrayOfString, arrayOfObject);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, divisionesDisponibles ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, divisionesDisponibles ");
          localException5.printStackTrace();
        }
      }
    }
    return localMyTableModel;
  }
  
  public ResultSet dameXComeComanda(int paramInt, ConexionBD paramConexionBD)
  {
    ResultSet localResultSet = null;
    String str = "";
    try
    {
      str = "SELECT Cantidad, Tipo, ClaveP, Producto, IDCom, Tamanio  FROM (SELECT (comandapro.CanPro)AS Cantidad, (comandapro.TB)AS Tamanio,  (comandaPro.ClPro)AS ClaveP,  (alimentos.nombre)AS Producto, comandapro.Tipo, comandapro.IDCom FROM comandapro, comanda, alimentos  WHERE comanda.IDMM = " + paramInt + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Tipo = 0 " + " AND comandapro.Estatus = 1 AND alimentos.clave = comandapro.ClPro UNION ALL SELECT (comandapro.CanPro)AS Cantidad," + " (comandapro.TB)AS Tamanio, (comandaPro.ClPro)AS ClaveP, (bebidas.nombre)AS   Producto, comandapro.Tipo, " + " comandapro.IDCom FROM comandapro, comanda, bebidas WHERE comanda.IDMM = " + paramInt + " AND comanda.Es = 1 AND " + " comandapro.IDC = comanda.IDC AND (comandapro.Tipo = 1 OR comandapro.Tipo = 2 OR comandapro.Tipo = 3 OR " + " comandapro.Tipo = 4) AND comandapro.Estatus = 1  AND bebidas.clave = comandapro.ClPro)AS tbTemp " + " ORDER BY CONCAT(IDCom,'',ClaveP,Tipo,Producto)";
      
      Statement localStatement = paramConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameXComeComanda ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameXComeComanda ");
      localException.printStackTrace();
    }
    return localResultSet;
  }
  
  public MyTableModel consultaComandaMTM(int paramInt)
    throws SQLException, Exception
  {
	  MyTableModel localMyTableModel = null;
    
    String[] arrayOfString = new String[5];
    arrayOfString[0] = "Cantidad";
    arrayOfString[1] = "Tipo";
    arrayOfString[2] = "Producto";
    arrayOfString[3] = "Solicito";
    arrayOfString[4] = "Comensal";
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      ResultSet localResultSet = dameTodaComanda(paramInt, localConexionBD);
      ResultSetMetaData localResultSetMetaData = localResultSet.getMetaData();
      int i = localResultSetMetaData.getColumnCount() - 3;
      int j = getResultSetSize(localResultSet);
      Object[][] arrayOfObject = new Object[j][i];
      int k = 0;
      while (localResultSet.next())
      {
        for (int m = 0; m < i; m++) {
          if (m == 0)
          {
            arrayOfObject[k][m] = localResultSet.getString("cantidad");
          }
          else if (m == 1)
          {
            int n = localResultSet.getInt("Tipo");
            int i1 = localResultSet.getInt("TB");
            String str = "N/A";
            if ((n == 1) && (i1 == 1)) {
              str = "Copa";
            } else if ((n == 1) && (i1 == 2)) {
              str = "Copa D.";
            } else if ((n == 1) && (i1 == 3)) {
              str = "Copa T.";
            } else if (n == 2) {
              str = "Botella";
            } else if (n == 3) {
              str = "Botella G.";
            } else if (n == 2) {
              str = "Botella P.";
            }
            arrayOfObject[k][m] = str;
          }
          else if (m == 2)
          {
            arrayOfObject[k][m] = localResultSet.getString("nombre");
          }
          else if (m == 3)
          {
            arrayOfObject[k][m] = localResultSet.getString("Nombre2");
          }
          else if (m == 4)
          {
            arrayOfObject[k][m] = localResultSet.getString("IDCom");
          }
        }
        k++;
      }
      localMyTableModel = new MyTableModel(arrayOfString, arrayOfObject);
    }
    catch (Exception localException2)
    {
      localException2.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException4)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, consultaComandaMTM ");
          localException4.printStackTrace();
        }
      }
    }
    return localMyTableModel;
  }
  
  public ResultSet dameTodaComanda(int paramInt, ConexionBD paramConexionBD)
  {
    ResultSet localResultSet = null;
    String str = "";
    try
    {
      str = "SELECT ALL SUM(Cantidad)AS Cantidad, nombre, ClPro, Tipo, Nombre2, IDcom, HR, TB FROM (SELECT (comandapro.CanPro)AS Cantidad, alimentos.nombre, comandapro.Tipo, comandapro.ClPro, comandapro.TB,  CONCAT(empleados.Nombre,'  ',empleados.APaterno)AS Nombre2, comandapro.IDCom, comandapro.HR FROM  comandapro, alimentos, empleados, comanda WHERE comanda.IDMM = " + paramInt + "  AND comanda.Es = 1 AND" + " comandapro.IDC = comanda.IDC AND comandapro.Estatus != 0 AND comandapro.tipo = 0 AND alimentos.clave = comandapro.ClPro " + " AND empleados.IDEmpleado = comandapro.IDM UNION ALL SELECT (comandapro.CanPro)AS Cantidad,  bebidas.nombre, " + " comandapro.Tipo, comandapro.ClPro, comandapro.TB,  CONCAT(empleados.Nombre,' ',empleados.APaterno)AS Nombre2, " + " comandapro.IDCom, comandapro.HR  FROM comandapro, bebidas, empleados, comanda  WHERE comanda.IDMM = " + paramInt + "  " + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Estatus != 0  " + " AND (comandapro.tipo = 1 OR comandapro.tipo = 2 OR comandapro.tipo = 3 OR comandapro.tipo = 4)  " + " AND bebidas.clave = comandapro.ClPro AND empleados.IDEmpleado = comandapro.IDM)AS kiko2  " + " GROUP BY CONCAT(Tipo,TB,nombre,IDCom,Nombre2,ClPro)  ORDER BY CONCAT(IDCom,ClPro,HR)";
      
      Statement localStatement = paramConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameTodaComanda ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameTodaComanda ");
      localException.printStackTrace();
    }
    return localResultSet;
  }
  
  public Vector<Object> dameModeloEspecialBebidas(Vector<Object> paramVector)
    throws Exception
  {
    Vector localVector1 = new Vector();
    Vector localVector2 = null;
    int i = 0;
    int j = 0;
    try
    {
      String str1 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str1));
      j = cambiaAInt(config.getProperty("botanaCla").trim());
    }
    catch (IOException localIOException1)
    {
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException1.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException1)
    {
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException1.printStackTrace();
    }
    Vector localVector3;
    for (int k = 0; k < paramVector.size(); k++)
    {
      localVector3 = (Vector)paramVector.elementAt(k);
      if (((String)localVector3.elementAt(1)).startsWith("1")) {
        i++;
      } else {
        i += cambiaAInt((String)localVector3.elementAt(0));
      }
    }
    for (int k = 0; k < paramVector.size(); k++)
    {
      localVector3 = (Vector)paramVector.elementAt(k);
      
      localVector2 = new Vector();
      String str2;
      int m;
      int n;
      if (((String)localVector3.elementAt(1)).startsWith("1"))
      {
        str2 = (String)localVector3.elementAt(1);
        if (str2.substring(str2.indexOf("*") + 1, str2.lastIndexOf("*")).trim().equalsIgnoreCase(j + ""))
        {
          m = cambiaAInt((String)localVector3.elementAt(0));
          for (n = 0; n < m; n++)
          {
            localVector2.addElement("1");
            localVector2.addElement(localVector3.elementAt(1));
            localVector2.addElement(localVector3.elementAt(2));
            localVector2.addElement(localVector3.elementAt(3));
            localVector2.addElement(localVector3.elementAt(4));
            localVector2.addElement(localVector3.elementAt(5));
            localVector2.addElement("NA");
            localVector2.addElement("NA");
            localVector2.addElement("NA");
            localVector2.addElement("NA");
            localVector2.addElement(dameComponentesBotana());
            localVector1.addElement(localVector2);
            localVector2 = new Vector();
          }
        }
        else
        {
          localVector2.addElement(localVector3.elementAt(0));
          localVector2.addElement(localVector3.elementAt(1));
          localVector2.addElement(localVector3.elementAt(2));
          localVector2.addElement(localVector3.elementAt(3));
          localVector2.addElement(localVector3.elementAt(4));
          localVector2.addElement(localVector3.elementAt(5));
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector1.addElement(localVector2);
        }
      }
      else
      {
        str2 = ((String)localVector3.elementAt(1)).trim();
        m = cambiaAInt(str2.substring(str2.lastIndexOf("*") + 1, str2.length()));
        n = dameTipoCombinacion(m);
        int i1 = damePropiedadDimension(m);
        int i2;
        int i3;
        String str3;
        if (((String)localVector3.elementAt(4)).startsWith("Copa"))
        {
          i2 = cambiaAInt((String)localVector3.elementAt(0));
          for (i3 = 0; i3 < i2; i3++) {
            if ((n == 1) && (i1 == 1))
            {
              str3 = "";
              try
              {
                String str4 = "Server.conf";
                config = new Properties();
                config.load(new FileInputStream(str4));
                str3 = config.getProperty("refOficial");
                str3 = "1 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
              }
              catch (IOException localIOException2)
              {
                System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
                localIOException2.printStackTrace();
              }
              catch (IllegalArgumentException localIllegalArgumentException2)
              {
                System.out.println("Error de lectura malformacion de archivo de configuracion");
                localIllegalArgumentException2.printStackTrace();
              }
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement(localVector3.elementAt(5));
              localVector2.addElement("Sencillo");
              localVector2.addElement("Puesto");
              localVector2.addElement("Normal");
              localVector2.addElement("No");
              localVector2.addElement(str3);
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if ((n == 1) && (i1 == 0))
            {
              str3 = "";
              try
              {
                String str5 = "Server.conf";
                config = new Properties();
                config.load(new FileInputStream(str5));
                str3 = config.getProperty("refOficial");
                str3 = "1 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
              }
              catch (IOException localIOException3)
              {
                System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
                localIOException3.printStackTrace();
              }
              catch (IllegalArgumentException localIllegalArgumentException3)
              {
                System.out.println("Error de lectura malformacion de archivo de configuracion");
                localIllegalArgumentException3.printStackTrace();
              }
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement(localVector3.elementAt(5));
              localVector2.addElement("NA");
              localVector2.addElement("Puesto");
              localVector2.addElement("Normal");
              localVector2.addElement("No");
              localVector2.addElement(str3);
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if ((n == 0) && (i1 == 1))
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement(localVector3.elementAt(5));
              localVector2.addElement("Sencillo");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("No");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement(localVector3.elementAt(5));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
          }
        }
        else
        {
          i2 = cambiaAInt((String)localVector3.elementAt(0));
          for (i3 = 0; i3 < i2; i3++) {
            if (n == 1)
            {
              str3 = "";
              try
              {
                String str6 = "Server.conf";
                config = new Properties();
                config.load(new FileInputStream(str6));
                str3 = config.getProperty("refOficial");
                if ((((String)localVector3.elementAt(4)).equalsIgnoreCase("Botella")) || (((String)localVector3.elementAt(4)).equalsIgnoreCase("Botella G."))) {
                  str3 = "4 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
                } else {
                  str3 = "3 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
                }
              }
              catch (IOException localIOException4)
              {
                System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
                localIOException4.printStackTrace();
              }
              catch (IllegalArgumentException localIllegalArgumentException4)
              {
                System.out.println("Error de lectura malformacion de archivo de configuracion");
                localIllegalArgumentException4.printStackTrace();
              }
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement(localVector3.elementAt(5));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("No");
              localVector2.addElement(str3);
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if (n == 0)
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement(localVector3.elementAt(5));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("No");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if (n == 2)
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement(localVector3.elementAt(5));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
          }
        }
      }
    }
    return localVector1;
  }
  
  public Vector<Object> dameModeloEspecialInterno(Vector<Object> paramVector)
    throws Exception
  {
    Vector localVector1 = new Vector();
    Vector localVector2 = null;
    int i = 0;
    int j = 0;
    try
    {
      String str1 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str1));
      j = cambiaAInt(config.getProperty("botanaCla").trim());
    }
    catch (IOException localIOException1)
    {
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException1.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException1)
    {
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException1.printStackTrace();
    }
    Vector localVector3;
    for (int k = 0; k < paramVector.size(); k++)
    {
      localVector3 = (Vector)paramVector.elementAt(k);
      if (((String)localVector3.elementAt(1)).startsWith("1")) {
        i++;
      } else {
        i += cambiaAInt((String)localVector3.elementAt(0));
      }
    }
    for (int k = 0; k < paramVector.size(); k++)
    {
      localVector3 = (Vector)paramVector.elementAt(k);
      
      localVector2 = new Vector();
      String str2;
      int m;
      int n;
      if (((String)localVector3.elementAt(1)).startsWith("1"))
      {
        str2 = (String)localVector3.elementAt(1);
        if (str2.substring(str2.indexOf("*") + 1, str2.lastIndexOf("*")).trim().equalsIgnoreCase(j + ""))
        {
          m = cambiaAInt((String)localVector3.elementAt(0));
          for (n = 0; n < m; n++)
          {
            localVector2.addElement("1");
            localVector2.addElement(localVector3.elementAt(1));
            localVector2.addElement(localVector3.elementAt(2));
            localVector2.addElement(localVector3.elementAt(3));
            localVector2.addElement(localVector3.elementAt(4));
            localVector2.addElement("NA");
            localVector2.addElement("NA");
            localVector2.addElement("NA");
            localVector2.addElement("NA");
            localVector2.addElement(dameComponentesBotana());
            localVector1.addElement(localVector2);
            localVector2 = new Vector();
          }
        }
        else
        {
          localVector2.addElement(localVector3.elementAt(0));
          localVector2.addElement(localVector3.elementAt(1));
          localVector2.addElement(localVector3.elementAt(2));
          localVector2.addElement(localVector3.elementAt(3));
          localVector2.addElement(localVector3.elementAt(4));
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector2.addElement("NA");
          localVector1.addElement(localVector2);
        }
      }
      else
      {
        str2 = ((String)localVector3.elementAt(1)).trim();
        m = cambiaAInt(str2.substring(str2.lastIndexOf("*") + 1, str2.length()));
        n = dameTipoCombinacion(m);
        int i1 = damePropiedadDimension(m);
        int i2;
        int i3;
        String str3;
        if (((String)localVector3.elementAt(3)).startsWith("Copa"))
        {
          i2 = cambiaAInt((String)localVector3.elementAt(0));
          for (i3 = 0; i3 < i2; i3++) {
            if ((n == 1) && (i1 == 1))
            {
              str3 = "";
              try
              {
                String str4 = "Server.conf";
                config = new Properties();
                config.load(new FileInputStream(str4));
                str3 = config.getProperty("refOficial");
                str3 = "1 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
              }
              catch (IOException localIOException2)
              {
                System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
                localIOException2.printStackTrace();
              }
              catch (IllegalArgumentException localIllegalArgumentException2)
              {
                System.out.println("Error de lectura malformacion de archivo de configuracion");
                localIllegalArgumentException2.printStackTrace();
              }
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement("Sencillo");
              localVector2.addElement("Puesto");
              localVector2.addElement("Normal");
              localVector2.addElement("No");
              localVector2.addElement(str3);
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if ((n == 1) && (i1 == 0))
            {
              str3 = "";
              try
              {
                String str5 = "Server.conf";
                config = new Properties();
                config.load(new FileInputStream(str5));
                str3 = config.getProperty("refOficial");
                str3 = "1 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
              }
              catch (IOException localIOException3)
              {
                System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
                localIOException3.printStackTrace();
              }
              catch (IllegalArgumentException localIllegalArgumentException3)
              {
                System.out.println("Error de lectura malformacion de archivo de configuracion");
                localIllegalArgumentException3.printStackTrace();
              }
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement("NA");
              localVector2.addElement("Puesto");
              localVector2.addElement("Normal");
              localVector2.addElement("No");
              localVector2.addElement(str3);
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if ((n == 0) && (i1 == 1))
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement("Sencillo");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("No");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
          }
        }
        else
        {
          i2 = cambiaAInt((String)localVector3.elementAt(0));
          for (i3 = 0; i3 < i2; i3++) {
            if (n == 1)
            {
              str3 = "";
              try
              {
                String str6 = "Server.conf";
                config = new Properties();
                config.load(new FileInputStream(str6));
                str3 = config.getProperty("refOficial");
                if ((((String)localVector3.elementAt(3)).equalsIgnoreCase("Botella")) || (((String)localVector3.elementAt(3)).equalsIgnoreCase("Botella G."))) {
                  str3 = "4 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
                } else {
                  str3 = "3 - " + dameNombreProducto(cambiaAInt(str3.trim()), 2) + " M. *" + str3;
                }
              }
              catch (IOException localIOException4)
              {
                System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
                localIOException4.printStackTrace();
              }
              catch (IllegalArgumentException localIllegalArgumentException4)
              {
                System.out.println("Error de lectura malformacion de archivo de configuracion");
                localIllegalArgumentException4.printStackTrace();
              }
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("No");
              localVector2.addElement(str3);
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if (n == 0)
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("No");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
            else if (n == 2)
            {
              localVector2.addElement("1");
              localVector2.addElement(localVector3.elementAt(1));
              localVector2.addElement(localVector3.elementAt(2));
              localVector2.addElement(localVector3.elementAt(3));
              localVector2.addElement(localVector3.elementAt(4));
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector2.addElement("NA");
              localVector1.addElement(localVector2);
              localVector2 = new Vector();
            }
          }
        }
      }
    }
    return localVector1;
  }
  
  public MyTableModel dameModeloProductos(int paramInt1, int paramInt2)
    throws SQLException, Exception
  {
	  MyTableModel localMyTableModel = null;
    
    String[] arrayOfString = new String[5];
    arrayOfString[0] = "Cantidad";
    arrayOfString[1] = "Clave";
    arrayOfString[2] = "Producto";
    arrayOfString[3] = "Tipo";
    arrayOfString[4] = "Precio U.";
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      ResultSet localResultSet = listadoProductosBusqueda(paramInt1, paramInt2, localConexionBD);
      ResultSetMetaData localResultSetMetaData = localResultSet.getMetaData();
      int i = localResultSetMetaData.getColumnCount();
      int j = getResultSetSize(localResultSet);
      Object[][] arrayOfObject = new Object[j][i];
      int k = 0;
      while (localResultSet.next())
      {
        int m = -1;
        if (paramInt1 == 2) {
          m = dameClasificacionBotella(localResultSet.getInt("clave"), paramInt2);
        }
        for (int n = 0; n < i; n++) {
          if (n == 0) {
            arrayOfObject[k][n] = localResultSet.getString("cantidad");
          } else if (n == 1) {
            arrayOfObject[k][n] = localResultSet.getString("clave");
          } else if (n == 2) {
            arrayOfObject[k][n] = localResultSet.getString("nombre");
          } else if (n == 3)
          {
            if (paramInt1 == 2)
            {
              if ((m == 0) || (m == 1) || (m == 2)) {
                arrayOfObject[k][n] = "Copa";
              } else if (m == 3) {
                arrayOfObject[k][n] = "Botella";
              } else if (m == 4) {
                arrayOfObject[k][n] = "Botella G.";
              }
            }
            else {
              arrayOfObject[k][n] = localResultSet.getString("tipo");
            }
          }
          else if (n == 4) {
            if (paramInt1 == 2)
            {
              if ((m == 0) || (m == 1) || (m == 2)) {
                arrayOfObject[k][n] = formatoDinero(acortaLongitud(localResultSet.getString("precioC")));
              } else if ((m == 3) || (m == 4)) {
                arrayOfObject[k][n] = formatoDinero(acortaLongitud(localResultSet.getString("precioB1")));
              }
            }
            else {
              arrayOfObject[k][n] = formatoDinero(acortaLongitud(localResultSet.getString("precio")));
            }
          }
        }
        k++;
      }
      localMyTableModel = new MyTableModel(arrayOfString, arrayOfObject);
    }
    catch (Exception localException2)
    {
      localException2.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException4)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, listadoProductosBusqueda ");
          localException4.printStackTrace();
        }
      }
    }
    return localMyTableModel;
  }
  
  public ResultSet listadoProductosBusqueda(int paramInt1, int paramInt2, ConexionBD paramConexionBD)
  {
    ResultSet localResultSet = null;
    String str = "";
    try
    {
      if (paramInt1 == 1) {
        str = "SELECT CONCAT('1') AS cantidad, clave, nombre,CONCAT('na')AS tipo, precio FROM alimentos WHERE division = " + paramInt2 + " AND estatus = 1 ORDER BY nombre";
      } else {
        str = "SELECT CONCAT('1') AS cantidad, clave, nombre, precioC, precioB1, precioB2 FROM bebidas WHERE division = " + paramInt2 + " AND estatus = 1 ORDER BY nombre";
      }
      Statement localStatement = paramConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, listadoProductosBusqueda ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, listadoProductosBusqueda ");
      localException.printStackTrace();
    }
    return localResultSet;
  }
  
  public int dameClasificacionBotella(int paramInt1, int paramInt2)
    throws SQLException, Exception
  {
    ResultSet localResultSet = null;
    String str = "";
    int i = -1;
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      str = "SELECT  precioC, precioB1, precioB2 FROM bebidas WHERE division = " + paramInt2 + " AND estatus = 1 AND clave = " + paramInt1 + " ORDER BY nombre";
      
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        if ((localResultSet.getDouble("precioC") > 0.0D) && (localResultSet.getDouble("precioB1") > 0.0D) && (localResultSet.getDouble("precioB2") <= 0.0D)) {
          i = 0;
        } else if ((localResultSet.getDouble("precioC") > 0.0D) && (localResultSet.getDouble("precioB1") <= 0.0D) && (localResultSet.getDouble("precioB2") > 0.0D)) {
          i = 0;
        } else if ((localResultSet.getDouble("precioC") > 0.0D) && (localResultSet.getDouble("precioB1") > 0.0D) && (localResultSet.getDouble("precioB2") > 0.0D)) {
          i = 1;
        } else if ((localResultSet.getDouble("precioC") > 0.0D) && (localResultSet.getDouble("precioB1") <= 0.0D) && (localResultSet.getDouble("precioB2") <= 0.0D)) {
          i = 2;
        } else if (((localResultSet.getDouble("precioB1") > 0.0D) && (localResultSet.getDouble("precioB2") <= 0.0D)) || ((localResultSet.getDouble("precioB1") <= 0.0D) && (localResultSet.getDouble("precioB2") > 0.0D))) {
          i = 3;
        } else if ((localResultSet.getDouble("precioB1") > 0.0D) && (localResultSet.getDouble("precioB2") > 0.0D)) {
          i = 4;
        }
      }
      return i;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, dameClasificacionBotella ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameClasificacionBotella ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameClasificacionBotella ");
          localException5.printStackTrace();
        }
      }
    }
    return i;
  }
  
  public boolean existeDisponibilidadBotella(int paramInt1, int paramInt2, String paramString, int paramInt3)
    throws SQLException, Exception
  {
    ResultSet localResultSet = null;
    boolean bool = false;
    int i = -1;
    i = cambiaAInt(paramString);
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT materiaprima.inventarioBotella1, materiaprima.inventarioBotella2, materiaprima.litrosXBotella1, materiaprima.litrosXBotella2 FROM materiaprima, bebidas  WHERE bebidas.division = " + paramInt2 + " AND bebidas.clave = " + paramInt1 + " AND materiaprima.clave = materia0 ";
      
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next())
      {
        double d1 = localResultSet.getDouble("litrosXBotella1");
        double d2 = localResultSet.getDouble("litrosXBotella2");
        if ((paramInt3 == 0) || (paramInt3 == 1))
        {
          if (d1 > d2)
          {
            if (localResultSet.getInt("inventarioBotella1") >= i) {
              bool = true;
            }
          }
          else if (localResultSet.getInt("inventarioBotella2") >= i) {
            bool = true;
          }
        }
        else if (paramInt3 == 2) {
          if (d1 > d2)
          {
            if (localResultSet.getInt("inventarioBotella2") >= i) {
              bool = true;
            }
          }
          else if (localResultSet.getInt("inventarioBotella1") >= i) {
            bool = true;
          }
        }
      }
      return bool;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, existeDisponibilidadBotella ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, existeDisponibilidadBotella ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, existeDisponibilidadBotella ");
          localException5.printStackTrace();
        }
      }
    }
    return bool;
  }
  
  public double recuperaPrecioXBotella(int paramInt1, int paramInt2, int paramInt3)
    throws SQLException, Exception
  {
    ResultSet localResultSet = null;
    double d1 = 0.0D;
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT precioB1, precioB2  FROM bebidas WHERE clave = " + paramInt1 + " AND division = " + paramInt2;
      
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next())
      {
        double d2 = localResultSet.getDouble("precioB1");
        double d3 = localResultSet.getDouble("precioB2");
        if ((paramInt3 == 0) || (paramInt3 == 1))
        {
          if (d2 > d3) {
            d1 = d2;
          } else {
            d1 = d3;
          }
        }
        else if (d2 > d3) {
          d1 = d3;
        } else {
          d1 = d2;
        }
      }
      return d1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, recuperaPrecioXBotella ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, recuperaPrecioXBotella ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, recuperaPrecioXBotella ");
          localException5.printStackTrace();
        }
      }
    }
    return d1;
  }
  
  public double recuperaPrecioXCopa(int paramInt1, int paramInt2)
    throws SQLException, Exception
  {
    ResultSet localResultSet = null;
    double d = 0.0D;
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT precioC FROM bebidas WHERE clave = " + paramInt1 + " AND division = " + paramInt2;
      
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        d = localResultSet.getDouble("precioC");
      }
      return d;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, recuperaPrecioXCopa ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, recuperaPrecioXCopa ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, recuperaPrecioXCopa ");
          localException5.printStackTrace();
        }
      }
    }
    return d;
  }
  
  public boolean verificaIdentidad(int paramInt1, int paramInt2)
    throws SQLException, Exception
  {
    boolean bool = false;
    ResultSet localResultSet = null;
    ConexionBD localConexionBD = new ConexionBD();
    try
    {
      String str = "SELECT IDEmpleado FROM empleados WHERE IDEmpleado = " + paramInt1 + " AND Contra = " + paramInt2 + " and Activo = 1";
      
      Statement localStatement = localConexionBD.creaStatement();
      localResultSet = localStatement.executeQuery(str);
      while (localResultSet.next()) {
        if (paramInt1 == localResultSet.getInt("IDEmpleado")) {
          bool = true;
        }
      }
      return bool;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ManagerPuntoVenta, verificaIdentidad ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ManagerPuntoVenta, verificaIdentidad ");
      localException3.printStackTrace();
    }
    finally
    {
      if (localConexionBD != null) {
        try
        {
          localConexionBD.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, verificaIdentidad ");
          localException5.printStackTrace();
        }
      }
    }
    return bool;
  }
  
  protected int getResultSetSize(ResultSet paramResultSet)
  {
    ResultSet localResultSet = paramResultSet;
    int i = -1;
    try
    {
      localResultSet.last();
      i = localResultSet.getRow();
      localResultSet.beforeFirst();
    }
    catch (SQLException localSQLException)
    {
      localSQLException.printStackTrace();
    }
    return i;
  }
  
  public String completaString(String paramString)
    throws Exception
  {
    String str = paramString;
    try
    {
      int i = paramString.length();
      i = 6 - i;
      for (int j = 0; j < i; j++) {
        str = "0" + str;
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public String completaStringTicket(String paramString)
    throws Exception
  {
    String str = paramString;
    try
    {
      int i = paramString.length();
      i = 7 - i;
      for (int j = 0; j < i; j++) {
        str = "0" + str;
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public String completaStringTipoPLU(String paramString)
    throws Exception
  {
    String str = paramString;
    try
    {
      int i = paramString.length();
      i = 2 - i;
      for (int j = 0; j < i; j++) {
        str = "0" + str;
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public int cambiaAInt(String paramString)
    throws Exception
  {
    int i;
    try
    {
      i = Integer.parseInt(paramString);
    }
    catch (NumberFormatException localNumberFormatException)
    {
      i = 0;
    }
    return i;
  }
  
  public String remueveComas(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    while (localStringBuffer.indexOf(",") != -1) {
      localStringBuffer.deleteCharAt(localStringBuffer.indexOf(","));
    }
    return paramString = new String(localStringBuffer.toString());
  }
  
  public String formatoCortoDinero(String paramString)
    throws Exception
  {
    StringBuilder localStringBuilder1 = new StringBuilder(paramString);
    if (localStringBuilder1.indexOf(".") != -1) {
      localStringBuilder1 = localStringBuilder1.delete(localStringBuilder1.indexOf("."), localStringBuilder1.length());
    }
    int i = 0;
    StringBuilder localStringBuilder2 = new StringBuilder(paramString);
    int j = 0;
    int k;
    if (localStringBuilder2.indexOf(".") != -1)
    {
      j = 1;
      localStringBuilder2 = localStringBuilder2.delete(0, localStringBuilder2.indexOf(".") + 1);
      if (localStringBuilder2.length() == 1)
      {
        localStringBuilder2.append("0");
      }
      else if (localStringBuilder2.length() > 2)
      {
        k = cambiaAInt(localStringBuilder2.substring(0, 1));
        int m = cambiaAInt(localStringBuilder2.substring(1, 2));
        int n = cambiaAInt(localStringBuilder2.substring(2, 3));
        if (n >= 5)
        {
          m++;
          if (m == 10)
          {
            m = 0;
            k++;
            if (k == 10)
            {
              k = 0;
              i = 1;
            }
          }
          localStringBuilder2 = new StringBuilder(k + "" + m + "");
        }
        else
        {
          localStringBuilder2 = new StringBuilder(k + "" + m + "");
        }
      }
    }
    if (j == 0) {
      localStringBuilder2 = new StringBuilder("00");
    }
    if (i != 0)
    {
      k = cambiaAInt(localStringBuilder1.toString());
      k++;
      localStringBuilder1 = new StringBuilder(k + "");
    }
    return localStringBuilder1.toString() + "." + localStringBuilder2.toString();
  }
  
  public double cambiaADouble(String paramString)
    throws Exception
  {
    if (paramString == null) {
      paramString = "";
    }
    double d;
    try
    {
      Double localDouble = Double.valueOf(paramString);
      d = localDouble.doubleValue();
    }
    catch (NumberFormatException localNumberFormatException)
    {
      d = 0.0D;
    }
    return d;
  }
  
  public String acortaLongitud(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    if (localStringBuffer.indexOf(".") != -1)
    {
      String str1 = localStringBuffer.substring(localStringBuffer.indexOf("."));
      
      String str2 = localStringBuffer.substring(0, localStringBuffer.indexOf("."));
      localStringBuffer.delete(0, localStringBuffer.length());
      if (str1.length() > 3) {
        str1 = str1.substring(0, 3);
      }
      if (str1.length() <= 2) {
        str1 = str1 + "0";
      }
      localStringBuffer.append(str2);
      localStringBuffer.append(str1);
    }
    return localStringBuffer.toString();
  }
  
  public String formatoDinero(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(dameEnteros(paramString));
    String str = dameDecimales(paramString);
    if (localStringBuffer.length() == 8)
    {
      localStringBuffer.insert(2, ',');
      localStringBuffer.insert(6, ',');
    }
    else if (localStringBuffer.length() == 7)
    {
      localStringBuffer.insert(1, ',');
      localStringBuffer.insert(5, ',');
    }
    else if (localStringBuffer.length() == 4)
    {
      localStringBuffer.insert(1, ',');
    }
    else if (localStringBuffer.length() == 5)
    {
      localStringBuffer.insert(2, ',');
    }
    else if (localStringBuffer.length() == 6)
    {
      localStringBuffer.insert(3, ',');
    }
    return localStringBuffer.toString() + "." + str;
  }
  
  public String dameDecimales(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    int i = 0;
    if (localStringBuffer.indexOf(".") != -1)
    {
      localStringBuffer = localStringBuffer.delete(0, localStringBuffer.indexOf(".") + 1);
      i = 1;
    }
    if (i == 0) {
      localStringBuffer = new StringBuffer("00");
    }
    return localStringBuffer.toString();
  }
  
  public String dameEnteros(String paramString)
  {
    StringBuffer localStringBuffer = new StringBuffer(paramString);
    if (localStringBuffer.indexOf(".") != -1) {
      localStringBuffer = localStringBuffer.delete(localStringBuffer.indexOf("."), localStringBuffer.length());
    }
    return localStringBuffer.toString();
  }
  
  protected String formatoEspaciado(String paramString)
    throws Exception
  {
    int i = paramString.length();
    while (i < 10)
    {
      paramString = "  " + paramString;
      i++;
    }
    StringBuilder localStringBuilder = new StringBuilder(paramString);
    int j = 0;
    while (localStringBuilder.indexOf("1") != -1)
    {
      localStringBuilder.replace(localStringBuilder.indexOf("1"), localStringBuilder.indexOf("1") + 1, "*");
      j++;
    }
    while (localStringBuilder.indexOf("*") != -1) {
      localStringBuilder.replace(localStringBuilder.indexOf("*"), localStringBuilder.indexOf("*") + 1, "1");
    }
    while (j > 0)
    {
      paramString = " " + paramString;
      j--;
    }
    return paramString;
  }
  
  protected String formatoEspaciado2(String paramString)
    throws Exception
  {
    int i = paramString.length();
    while (i < 10)
    {
      paramString = "  " + paramString;
      i++;
    }
    return paramString;
  }
  
  public Date cambiaADate(String paramString)
  {
    Date localDate;
    try
    {
      localDate = Date.valueOf(new String(paramString));
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      localDate = Date.valueOf(new String("9999-10-10"));
    }
    return localDate;
  }
  
  public Time cambiaATiempo(String paramString)
  {
    Time localTime;
    try
    {
      localTime = Time.valueOf(new String(paramString));
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      localTime = Time.valueOf(new String("12:00:00"));
    }
    return localTime;
  }
}
