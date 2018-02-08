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

public class ImpresionTicketComida
  implements Printable
{
  protected static Properties config;
  private String PRINTER_NAME = "";
  private ManagerPuntoVenta mpv = new ManagerPuntoVenta();
  protected int POINTS_PER_INCH = 72;
  protected final HashPrintRequestAttributeSet attrib = new HashPrintRequestAttributeSet();
  private ResultSet rs = null;
  protected Font nuevaProd = new Font("Agency FB", 1, 13);
  int nuevaProdAscent = 0;
  int nuevaProdDescent = 0;
  int nuevaProdLeading = 0;
  int IDComanda = -1;
  boolean hayElementos = false;
  String IDMesa = "";
  String IDComandaS = "";
  String Solicito = "";
  String Hora = "";
  String Fecha = "";
  int ContadorProductos = 0;
  protected int productosEnTicket = 0;
  protected int productosXHojas = 8;
  protected double cantidadHojas = 0.0D;
  protected int espejoPagina = 0;
  protected Graphics2D g2d = null;
  protected int IDConsecutivo;
  protected ConexionBD con = null;
  protected ConexionBD con2 = null;
  protected int claveBotana = 0;
  
  public ImpresionTicketComida(int paramInt)
    throws Exception
  {
    this.IDComanda = paramInt;
    this.claveBotana = this.mpv.cambiaAInt(this.mpv.dameLaClaveDeBotana());
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
        System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameNombreProducto ");
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
      PreparedStatement localPreparedStatement = this.con2.miConnection.prepareStatement("UPDATE comandapro SET IDImpresion = ?  WHERE IDC = ? AND Tipo = 0");
      localPreparedStatement.setInt(1, 1);
      localPreparedStatement.setInt(2, this.IDComanda);
      localPreparedStatement.execute(); return;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketComida, cambiaEstatusDeImpresion ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketComida, cambiaEstatusDeImpresion ");
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
          System.out.println("Error al momento de cerrar conexion en ImpresionTicketComida, cambiaEstatusDeImpresion ");
          localException5.printStackTrace();
        }
      }
    }
  }
  
  public String dameElNombreMP(int paramInt)
    throws SQLException, Exception
  {
    this.con = new ConexionBD();
    ResultSet localResultSet = null;
    String str1 = "";
    try
    {
      String str2 = "SELECT nombre FROM materiaprima WHERE clave = " + paramInt + " AND Estatus = 1";
      Statement localStatement = this.con.creaStatement();
      localResultSet = localStatement.executeQuery(str2);
      while (localResultSet.next()) {
        str1 = localResultSet.getString("nombre");
      }
      return str1;
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketComida, dameElNombreMP ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketComida, dameElNombreMP ");
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
          System.out.println("Error al momento de cerrar conexion en ImpresionTicketComida, dameElNombreMP ");
          localException5.printStackTrace();
        }
      }
    }
    return str1;
  }
  
  public ResultSet listadoAlimentos(int paramInt)
    throws SQLException, Exception
  {
    this.con2 = new ConexionBD();
    ResultSet localResultSet = null;
    try
    {
      String str = "SELECT (comandapro.IDC)AS IDComanda, (comanda.IDMM)AS Mesa, CONCAT(empleados.Nombre COLLATE latin1_spanish_ci, ' ',  empleados.APaterno COLLATE latin1_spanish_ci)AS Nombre, SUM(comandapro.CanPro)AS Cantidad, (alimentos.nombre)AS Producto, (comandapro.Ob)AS Observacion,(comandapro.Di)AS Division, (comandapro.CB1) AS ClaveB1, (comandapro.CB2) AS ClaveB2, (comandapro.CB3) AS ClaveB3, (comandapro.CB4) AS ClaveB4, (comandapro.DiA)AS Fecha, (comandapro.HR)AS Hora FROM comandapro, comanda, empleados, alimentos WHERE comandapro.IDC = " + paramInt + " AND comandapro.IDImpresion = 0 AND comandapro.Tipo = 0 AND comandapro.Estatus = 1 AND comanda.IDC = comandapro.IDC AND empleados.IDEmpleado = comandapro.IDM AND alimentos.clave = comandapro.ClPro GROUP BY CONCAT(comandapro.ClPro,comandapro.Ob,comandapro.CB1,comandapro.CB2,comandapro.CB3,comandapro.CB4)";
      Statement localStatement = this.con2.creaStatement();
      localResultSet = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketComida, listadoAlimentos ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketComida, listadoAlimentos ");
      localException.printStackTrace();
    }
    return localResultSet;
  }
  
  public void mandaImprimirAlimentos()
    throws Exception
  {
    this.rs = listadoAlimentos(this.IDComanda);
    while (this.rs.next())
    {
      this.ContadorProductos += 1;
      this.hayElementos = true;
      this.IDMesa = this.rs.getString("Mesa");
      this.IDComandaS = this.rs.getString("IDComanda");
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
    try
    {
      this.g2d.drawString("Mesa: " + this.mpv.cambiaANombreBarra(this.IDMesa), (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.x += 85.0D;
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    this.g2d.drawString("Comanda #: " + this.IDComandaS, (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 5.0D;
    this.g2d.drawString("Solicitó: " + this.Solicito, (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent;
    localDouble.x = 0.0D;
    this.g2d.drawString(" ________________________________________", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 5.0D;
    
    int k = 0;
    int m = 0;
    try
    {
      while ((this.rs.next()) && (m < this.productosXHojas))
      {
        m++;
        if (k != 0)
        {
          localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
          localDouble.x = 5.0D;
          localDouble.y += this.nuevaProdAscent;
        }
        else
        {
          k = 1;
        }
        int n = 0;
        int i1 = 0;
        String str1 = this.rs.getString("Observacion");
        if (str1.trim().length() > 0) {
          n = 1;
        }
        if (this.claveBotana == this.rs.getInt("Division")) {
          i1 = 1;
        }
        String str2 = this.rs.getString("Cantidad");
        this.g2d.drawString("Cantidad:  " + str2, (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading;
        localDouble.x = 5.0D;
        localDouble.y += this.nuevaProdAscent;
        this.g2d.drawString(this.rs.getString("Producto"), (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.y += this.nuevaProdDescent;
        localDouble.x = 0.0D;
        if (i1 != 0)
        {
          localDouble.x = 35.0D;
          localDouble.y += this.nuevaProdAscent + this.nuevaProdLeading;
          this.g2d.drawString("CONFORMADA POR: ", (int)localDouble.getX(), (int)localDouble.getY());
          if (this.rs.getInt("ClaveB1") != 0)
          {
            localDouble.x = 15.0D;
            localDouble.y += this.nuevaProdAscent + this.nuevaProdLeading;
            this.g2d.drawString("> " + dameElNombreMP(this.rs.getInt("ClaveB1")), (int)localDouble.getX(), (int)localDouble.getY());
          }
          if (this.rs.getInt("ClaveB2") != 0)
          {
            localDouble.x = 15.0D;
            localDouble.y += this.nuevaProdAscent + this.nuevaProdLeading;
            this.g2d.drawString("> " + dameElNombreMP(this.rs.getInt("ClaveB2")), (int)localDouble.getX(), (int)localDouble.getY());
          }
          if (this.rs.getInt("ClaveB3") != 0)
          {
            localDouble.x = 15.0D;
            localDouble.y += this.nuevaProdAscent + this.nuevaProdLeading;
            this.g2d.drawString("> " + dameElNombreMP(this.rs.getInt("ClaveB3")), (int)localDouble.getX(), (int)localDouble.getY());
          }
          if (this.rs.getInt("ClaveB4") != 0)
          {
            localDouble.x = 15.0D;
            localDouble.y += this.nuevaProdAscent + this.nuevaProdLeading;
            this.g2d.drawString("> " + dameElNombreMP(this.rs.getInt("ClaveB4")), (int)localDouble.getX(), (int)localDouble.getY());
          }
        }
        if (n != 0)
        {
          localDouble.x = 5.0D;
          localDouble.y += this.nuevaProdAscent + this.nuevaProdLeading;
          this.g2d.drawString("Nota: " + str1, (int)localDouble.getX(), (int)localDouble.getY());
          localDouble.x = 0.0D;
          localDouble.y += this.nuevaProdDescent;
        }
        localDouble.x = 0.0D;
        this.g2d.drawString(" _____________________________________________", (int)localDouble.getX(), (int)localDouble.getY());
      }
      this.rs.previous();
    }
    catch (SQLException localSQLException3)
    {
      localSQLException3.printStackTrace();
    }
    catch (Exception localException2)
    {
      localException2.printStackTrace();
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
      this.g2d.drawString("***************************************", (int)localDouble.getX(), (int)localDouble.getY());
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
      this.PRINTER_NAME = config.getProperty("imp_Alimentos").trim();
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
