package alphanet.ultra.digibar.bd;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Point2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.standard.MediaPrintableArea;

public class ImpresionTicketBebidaI
  implements Printable
{
  protected static Properties config;
  private String PRINTER_NAME = "";
  protected int POINTS_PER_INCH = 72;
  protected final HashPrintRequestAttributeSet attrib = new HashPrintRequestAttributeSet();
  private ResultSet rs = null;
  protected Font nuevaProd = new Font("Agency FB", 1, 13);
  int nuevaProdAscent = 0;
  int nuevaProdDescent = 0;
  int nuevaProdLeading = 0;
  boolean hayElementos = false;
  String Solicito = "";
  String Hora = "";
  String Fecha = "";
  String Tipo = "";
  int ContadorProductos = 0;
  protected int productosEnTicket = 0;
  protected int productosXHojas = 6;
  protected double cantidadHojas = 0.0D;
  protected int espejoPagina = 0;
  protected Graphics2D g2d = null;
  protected int IDConsecutivo;
  protected ConexionBD con2 = null;
  protected ConexionBD con = null;
  protected int claveEmpleado = -1;
  
  public String dameNombreProducto(int paramInt1, int paramInt2)
    throws SQLException, Exception
  {
    this.con = new ConexionBD();
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
      Statement localStatement = this.con.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next()) {
        str1 = localResultSet.getString("nombre");
      }
      return str1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketBebidaI, dameNombreProducto ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketBebidaI, dameNombreProducto ");
      localException3.printStackTrace();
    }
    finally
    {
      if (this.con != null) {
        try
        {
          this.con.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ImpresionTicketBebidaI, dameNombreProducto ");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public ImpresionTicketBebidaI(int paramInt)
    throws Exception
  {
    this.claveEmpleado = paramInt;
    mandaImprimirAlimentos();
    if (this.hayElementos)
    {
      this.cantidadHojas = (this.ContadorProductos / this.productosXHojas);
      ProcesoImprime();
    }
    if (this.con2 != null) {
      try
      {
        this.con2.cierraConexion();
      }
      catch (Exception localException)
      {
        System.out.println("Error al momento de cerrar conexion en ImpresionTicketBebidaI, ImpresionTicketBebida ");
        localException.printStackTrace();
      }
    }
    if (this.hayElementos) {
      cambiaEstatusDeImpresion();
    }
  }
  
  public void cambiaEstatusDeImpresion()
    throws SQLException, Exception
  {
    this.con2 = new ConexionBD();
    try
    {
      PreparedStatement localPreparedStatement = this.con2.miConnection.prepareStatement("UPDATE internopro SET IDImpresion = ?  WHERE IDPersonal = ? AND Tipo != 0");
      localPreparedStatement.setInt(1, 1);
      localPreparedStatement.setInt(2, this.claveEmpleado);
      localPreparedStatement.execute(); return;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketBebidaI, cambiaEstatusDeImpresion ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketBebidaI, cambiaEstatusDeImpresion ");
      localException3.printStackTrace();
    }
    finally
    {
      if (this.con2 != null) {
        try
        {
          this.con2.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ImpresionTicketBebidaI, cambiaEstatusDeImpresion ");
          localException5.printStackTrace();
        }
      }
    }
  }
  
  public ResultSet listadosBebidas(int paramInt)
    throws SQLException, Exception
  {
    this.con2 = new ConexionBD();
    ResultSet localResultSet = null;
    try
    {
      String str = "SELECT   bebidas.combinable, bebidas.dimensionable,  CONCAT(empleados.Nombre COLLATE latin1_spanish_ci, ' ', empleados.APaterno COLLATE latin1_spanish_ci)AS Nombre,  SUM(internopro.CanPro)AS Cantidad, internopro.Tipo, (bebidas.nombre)AS Producto, (internopro.Ob)AS Observacion,  (internopro.DiA)AS Fecha, (internopro.HR)AS Hora, (internopro.TB) AS Tamanio, (internopro.FB) AS Formato,  (internopro.MB) AS Mezcla, (internopro.AB) AS Adicional, (internopro.CA1) AS Cantidad1, (internopro.CA2) AS Cantidad2,  (internopro.CA3) AS Cantidad3, (internopro.CA4) AS Cantidad4, (internopro.CB1) AS ClaveB1, (internopro.CB2) AS ClaveB2, (internopro.CB3) AS ClaveB3, (internopro.CB4) AS ClaveB4, (internopro.TB1) AS TipoBA1, (internopro.TB2) AS TipoBA2,  (internopro.TB3) AS TipoBA3, (internopro.TB4) AS TipoBA4 FROM internopro, empleados, bebidas   WHERE internopro.IDPersonal = " + paramInt + "  AND internopro.IDImpresion = 0 AND " + " (internopro.Tipo = 1 OR internopro.Tipo = 2 OR internopro.Tipo = 3 OR internopro.Tipo = 4) AND internopro.Estatus = 1 " + " AND empleados.IDEmpleado = internopro.IDPersonal AND bebidas.clave = internopro.ClPro " + " GROUP BY(CONCAT(internopro.ClPro,internopro.Tipo,internopro.Ob,internopro.TB,internopro.FB,internopro.MB,internopro.AB," + " internopro.CB1,internopro.CB2,internopro.CB3,internopro.CB4,internopro.TB1,internopro.TB2,internopro.TB3,internopro.TB4))";
      
      Statement localStatement = this.con2.creaStatement();
      localResultSet = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketBebidaI, listadosBebidas ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketBebidaI, listadosBebidas ");
      localException.printStackTrace();
    }
    return localResultSet;
  }
  
  public void mandaImprimirAlimentos()
    throws Exception
  {
    this.rs = listadosBebidas(this.claveEmpleado);
    while (this.rs.next())
    {
      this.ContadorProductos += 1;
      this.hayElementos = true;
      this.Solicito = this.rs.getString("Nombre");
      this.Hora = this.rs.getString("Hora");
      this.Fecha = this.rs.getString("Fecha");
    }
    this.rs.beforeFirst();
  }
  
  public int print(Graphics paramGraphics, PageFormat paramPageFormat, int paramInt)
    throws PrinterException
  {
    if (paramInt >= (int)Math.ceil(this.cantidadHojas)) {
      return 1;
    }
    this.g2d = ((Graphics2D)paramGraphics);
    
    this.g2d.setFont(this.nuevaProd);
    this.nuevaProdAscent = this.g2d.getFontMetrics().getAscent();
    this.nuevaProdDescent = this.g2d.getFontMetrics().getDescent();
    this.nuevaProdLeading = this.g2d.getFontMetrics().getLeading();
    if (this.espejoPagina == paramInt)
    {
      int i = 0;
      try
      {
        this.rs.beforeFirst();
      }
      catch (SQLException localSQLException1)
      {
        localSQLException1.printStackTrace();
      }
      for (int j = 0; j < this.espejoPagina; j++)
      {
        while (i < this.productosXHojas)
        {
          try
          {
            this.rs.next();
          }
          catch (SQLException localSQLException2)
          {
            localSQLException2.printStackTrace();
          }
          i++;
        }
        i = 0;
      }
    }
    else
    {
      this.espejoPagina = paramInt;
    }
    this.g2d = ((Graphics2D)paramGraphics);
    this.g2d.setColor(Color.black);
    
    Point2D.Double localDouble = new Point2D.Double(0.0D, 0.0D);
    this.g2d.setFont(this.nuevaProd);
    this.g2d.translate(paramPageFormat.getImageableX(), paramPageFormat.getImageableY());
    this.g2d.drawString(" ________________________________________", (int)localDouble.getX(), (int)localDouble.getY());
    
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 5.0D;
    
    this.g2d.drawString("SOLICITUD INTERNA DE EMPLEADO: ", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 5.0D;
    this.g2d.drawString("Solicitó: " + this.Solicito, (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent;
    localDouble.x = 0.0D;
    this.g2d.drawString(" ________________________________________", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 5.0D;
    
    int j = 0;
    int k = 0;
    try
    {
      while ((this.rs.next()) && (k < this.productosXHojas))
      {
        String str1 = "Sencillo";
        String str2 = "Puesto";
        String str3 = "Normal";
        String str4 = "No";
        int m = 0;
        int n = 0;
        m = this.rs.getInt("dimensionable");
        n = this.rs.getInt("combinable");
        int i1 = this.rs.getInt("Adicional");
        if (i1 == 0) {
          str4 = "No";
        } else if (i1 == 1) {
          str4 = "C. Limón";
        } else if (i1 == 2) {
          str4 = "C. Sangrita";
        } else if (i1 == 3) {
          str4 = "C. Limón y C. Sangrita";
        }
        if (m == 1)
        {
          int i2 = this.rs.getInt("Tamanio");
          if (i2 == 1) {
            str1 = "Sencillo";
          } else if (i2 == 2) {
            str1 = "Doble";
          } else if (i2 == 3) {
            str1 = "Triple";
          }
        }
        if (n == 1)
        {
         int i2 = this.rs.getInt("Formato");
          if (i2 == 1) {
            str2 = "Puesto";
          } else if (i2 == 2) {
            str2 = "Divorciado";
          } else if (i2 == 3) {
            str2 = "Derecho";
          } else if (i2 == 4) {
            str2 = "Rocas";
          } else if (i2 == 5) {
            str2 = "Chasser";
          }
          i2 = this.rs.getInt("Mezcla");
          if (i2 == 1) {
            str3 = "Ninguno";
          } else if (i2 == 2) {
            str3 = "Normal";
          } else if (i2 == 3) {
            str3 = "Campechano";
          } else if (i2 == 4) {
            str3 = "Pintado";
          }
        }
        if (this.rs.getString("tipo").equalsIgnoreCase("1")) {
          this.Tipo = "Copa";
        } else if (this.rs.getString("tipo").equalsIgnoreCase("2")) {
          this.Tipo = "Botella";
        } else if (this.rs.getString("tipo").equalsIgnoreCase("3")) {
          this.Tipo = "Botella Grande";
        } else if (this.rs.getString("tipo").equalsIgnoreCase("4")) {
          this.Tipo = "Botella Chica";
        }
        k++;
        if (j != 0)
        {
          localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
          localDouble.x = 5.0D;
          localDouble.y += this.nuevaProdAscent;
        }
        else
        {
          j = 1;
        }
        int i2 = 0;
        String str5 = this.rs.getString("Observacion");
        if (str5.trim().length() > 0) {
          i2 = 1;
        }
        String str6 = this.rs.getString("Cantidad");
        this.g2d.drawString("Cantidad:  " + str6, (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.x += 85.0D;
        this.g2d.drawString("Tipo:  " + this.Tipo, (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
        localDouble.x = 5.0D;
        localDouble.y += this.nuevaProdAscent;
        this.g2d.drawString("BEBIDA: " + this.rs.getString("Producto"), (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
        localDouble.x = 5.0D;
        localDouble.y += this.nuevaProdAscent;
        if ((m == 1) && (this.Tipo.equalsIgnoreCase("Copa")))
        {
          this.g2d.drawString("Tamaño:  " + str1, (int)localDouble.getX(), (int)localDouble.getY());
          localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
          localDouble.x = 5.0D;
          localDouble.y += this.nuevaProdAscent;
        }
        if ((n == 1) && (this.Tipo.equalsIgnoreCase("Copa")))
        {
          this.g2d.drawString("Formato:  " + str2, (int)localDouble.getX(), (int)localDouble.getY());
          localDouble.x += 90.0D;
          this.g2d.drawString(", >Mezcla:  " + str3, (int)localDouble.getX(), (int)localDouble.getY());
          localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
          localDouble.x = 5.0D;
          localDouble.y += this.nuevaProdAscent;
        }
        if (!str4.equalsIgnoreCase("No"))
        {
          this.g2d.drawString("Adicional:  " + str4, (int)localDouble.getX(), (int)localDouble.getY());
          localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
          localDouble.x = 5.0D;
          localDouble.y += this.nuevaProdAscent;
        }
        if (n == 1)
        {
          localDouble.y += this.nuevaProdDescent;
          localDouble.x = 5.0D;
          String str7;
          if (this.rs.getInt("ClaveB1") != 0)
          {
            str7 = "Mediano";
            if (this.rs.getInt("TipoBA1") == 4) {
              str7 = "Chico";
            }
            this.g2d.drawString(" > " + this.rs.getInt("cantidad1") + " " + dameNombreProducto(this.rs.getInt("ClaveB1"), 2) + " " + str7, (int)localDouble.getX(), (int)localDouble.getY());
            localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
            localDouble.x = 5.0D;
            localDouble.y += this.nuevaProdAscent;
          }
          if (this.rs.getInt("ClaveB2") != 0)
          {
            str7 = "Mediano";
            if (this.rs.getInt("TipoBA2") == 4) {
              str7 = "Chico";
            }
            this.g2d.drawString(" > " + this.rs.getInt("cantidad2") + " " + dameNombreProducto(this.rs.getInt("ClaveB2"), 2) + " " + str7, (int)localDouble.getX(), (int)localDouble.getY());localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
            localDouble.x = 5.0D;
            localDouble.y += this.nuevaProdAscent;
          }
          if (this.rs.getInt("ClaveB3") != 0)
          {
            str7 = "Mediano";
            if (this.rs.getInt("TipoBA3") == 4) {
              str7 = "Chico";
            }
            this.g2d.drawString(" > " + this.rs.getInt("cantidad3") + " " + dameNombreProducto(this.rs.getInt("ClaveB3"), 2) + " " + str7, (int)localDouble.getX(), (int)localDouble.getY());localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
            localDouble.x = 5.0D;
            localDouble.y += this.nuevaProdAscent;
          }
          if (this.rs.getInt("ClaveB4") != 0)
          {
            str7 = "Mediano";
            if (this.rs.getInt("TipoBA4") == 4) {
              str7 = "Chico";
            }
            this.g2d.drawString(" > " + this.rs.getInt("cantidad4") + " " + dameNombreProducto(this.rs.getInt("ClaveB4"), 2) + " " + str7, (int)localDouble.getX(), (int)localDouble.getY());localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
            localDouble.x = 5.0D;
            localDouble.y += this.nuevaProdAscent;
          }
        }
        if (i2 != 0)
        {
          localDouble.x = 5.0D;
          localDouble.y += this.nuevaProdAscent + this.nuevaProdLeading;
          this.g2d.drawString("Nota: " + str5, (int)localDouble.getX(), (int)localDouble.getY());
          localDouble.x = 0.0D;
          localDouble.y += this.nuevaProdDescent;
        }
        this.g2d.drawString(" _____________________________________________", (int)localDouble.getX(), (int)localDouble.getY());
      }
      this.rs.previous();
    }
    catch (SQLException localSQLException3)
    {
      localSQLException3.printStackTrace();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    if (paramInt + 1 == (int)Math.ceil(this.cantidadHojas))
    {
      localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
      localDouble.x = 10.0D;
      localDouble.y += this.nuevaProdAscent;
      this.g2d.drawString("Fecha: " + this.Fecha, (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.x += 95.0D;
      this.g2d.drawString("Hora: " + this.Hora, (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.y += this.nuevaProdDescent + this.nuevaProdAscent;
      localDouble.x = 0.0D;
      this.g2d.drawString("*************************************", (int)localDouble.getX(), (int)localDouble.getY());
    }
    else
    {
      localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
      localDouble.x = 0.0D;
      localDouble.y += this.nuevaProdAscent;
      this.g2d.drawString("CONTINUA ............", (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
      localDouble.x = 0.0D;
      localDouble.y += this.nuevaProdAscent;
    }
    return 0;
  }
  
  public void ProcesoImprime()
    throws Exception
  {
    PrintService[] arrayOfPrintService = PrintServiceLookup.lookupPrintServices(null, null);
    int i = -1;
    try
    {
      String str = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str));
      this.PRINTER_NAME = config.getProperty("imp_Bebidas").trim();
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
    for (int j = 0; j < arrayOfPrintService.length; j++) {
      if (arrayOfPrintService[j].getName().equalsIgnoreCase(this.PRINTER_NAME)) {
        i = j;
      }
    }
    try
    {
      PrinterJob localPrinterJob = PrinterJob.getPrinterJob();
      localPrinterJob.setPrintable(this);
      localPrinterJob.setPrintService(arrayOfPrintService[i]);
      this.attrib.add(new MediaPrintableArea(0.15F, 0.15F, 8.5F, 11.0F, 25400));
      localPrinterJob.print(this.attrib);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
}
