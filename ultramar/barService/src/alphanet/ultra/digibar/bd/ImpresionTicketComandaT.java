package alphanet.ultra.digibar.bd;

import java.awt.Color;
import java.awt.Font;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Toolkit;
import java.awt.font.FontRenderContext;
import java.awt.font.LineBreakMeasurer;
import java.awt.font.TextAttribute;
import java.awt.font.TextLayout;
import java.awt.geom.Point2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.AttributedString;
import java.util.Properties;
import java.util.Vector;

import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.standard.MediaPrintableArea;

public class ImpresionTicketComandaT
  implements Printable
{
  protected Frame frame = new Frame();
  protected static Properties config;
  private String PRINTER_NAME = "";
  private ManagerPuntoVenta mpv = new ManagerPuntoVenta();
  protected int POINTS_PER_INCH = 72;
  protected final HashPrintRequestAttributeSet attrib = new HashPrintRequestAttributeSet();
  private ResultSet rs = null;
  protected Font nueva = new Font("Agency FB", 1, 15);
  protected Font nuevaProd = new Font("Agency FB", 1, 12);
  protected Font nuevaProd2 = new Font("Agency FB", 1, 13);
  protected Font prod = new Font("Agency FB", 0, 11);
  int nuevaProdAscent = 0;
  int nuevaProdDescent = 0;
  int nuevaProdLeading = 0;
  int nuevaProdAscent2 = 0;
  int nuevaProdDescent2 = 0;
  int nuevaProdLeading2 = 0;
  int prodAscent = 0;
  int prodDescent = 0;
  int prodLeading = 0;
  int IDComanda = -1;
  boolean hayElementos = false;
  int IDMesa = 0;
  String Empleado = "";
  TimeStamp tiempo;
  String Hora = "";
  String Fecha = "";
  String Tipo = "";
  String Cantidad = "";
  String PagoTotal = "";
  String PagoSubtotal = "";
  String PagoIVA = "";
  double Descuento = 0.0D;
  String NumComensales = "";
  int ContadorProductos = 0;
  protected int productosEnTicket = 0;
  protected int productosXHojas = 25;
  protected double cantidadHojas = 0.0D;
  protected int espejoPagina = 0;
  protected Graphics2D g2d = null;
  protected int IDConsecutivo;
  protected ConexionBD con2 = null;
  protected ConexionBD con1 = null;
  protected final int numeroDeCopasXBotanaGratis = 3;
  protected final String DATARFC = "MA.  EDUWIGES  GUTI��RREZ  Y  GUTI��RREZ,    ";
  protected final String RFC = "RFC: GUGE481208-QH4,";
  protected final String DATACURP = "CURP:  GUGE481208MDFTTD07,";
  protected final String DATADIR = "Tonalá #178 PB, Col. Roma, Del. Cuauhtémoc, C.P. 06700, México, D.F.";
  
  public ImpresionTicketComandaT(int paramInt)
    throws Exception
  {
    this.IDMesa = paramInt;
    mandaImprimirTicketCT();
    if (this.hayElementos)
    {
      this.tiempo = new TimeStamp();
      this.Hora = this.tiempo.time;
      this.Fecha = this.tiempo.date;
      this.cantidadHojas = (this.ContadorProductos / this.productosXHojas);
      ProcesoImprime();
      CierraConexion2();
    }
  }
  
  public void mandaImprimirTicketCT()
    throws Exception
  {
    validaReglas();
    ajustaDescuentos();
    this.rs = dameDatosComanda();
    while (this.rs.next())
    {
      this.IDComanda = this.rs.getInt("IDC");
      this.Empleado = this.rs.getString("Nombre");
      double d1 = 0.0D;
      double d2 = 0.0D;
      double d3 = 0.0D;
      d1 = this.rs.getDouble("PT") * 100.0D / 116.0D;
      d1 = this.mpv.cambiaADouble(this.mpv.formatoCortoDinero(d1 + ""));
      d2 = d1 * 0.15D;
      d2 = this.mpv.cambiaADouble(this.mpv.formatoCortoDinero(d2 + ""));
      d3 = d2 + d1 - this.Descuento;
      d3 = this.mpv.cambiaADouble(this.mpv.formatoCortoDinero(d3 + ""));
      this.PagoSubtotal = this.mpv.formatoDinero(this.mpv.acortaLongitud(d1 + ""));
      this.PagoIVA = this.mpv.formatoDinero(this.mpv.acortaLongitud(d2 + ""));
      this.PagoTotal = this.mpv.formatoDinero(this.mpv.acortaLongitud(this.rs.getDouble("PT") + ""));
      this.NumComensales = this.rs.getString("NC");
    }
    CierraConexion1();
    this.rs = listadoComanda();
    this.ContadorProductos = this.mpv.getResultSetSize(this.rs);
    if (this.ContadorProductos > 0) {
      this.hayElementos = true;
    }
    this.rs.beforeFirst();
  }
  
  public void ajustaDescuentos()
    throws SQLException, Exception
  {
    this.con1 = new ConexionBD();
    this.con1.cancelaAutoCommit();
    int i = 0;
    int j = 0;
    double d1 = 0.0D;
    try
    {
      ResultSet localResultSet1 = null;
      String str1 = "SELECT SUM(comandapro.PT)AS total, comandapro.IDC FROM comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + " AND comandapro.IDC = comanda.IDC AND Estatus = 1 GROUP BY (comandapro.IDC)";
      Statement localStatement1 = this.con1.creaStatement();
      localResultSet1 = localStatement1.executeQuery(str1);
      while (localResultSet1.next())
      {
        j = localResultSet1.getInt("IDC");
        d1 = localResultSet1.getDouble("total");
      }
      PreparedStatement localPreparedStatement1 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = ? WHERE IDC = ?");
      localPreparedStatement1.setDouble(1, d1);
      localPreparedStatement1.setInt(2, j);
      localPreparedStatement1.execute();
      ResultSet localResultSet2 = null;
      String str2 = "SELECT DISTINCT descuentos.comanda, descuentos.numComensal, descuentos.porcentaje FROM descuentos, comanda, comandapro WHERE comanda.IDMM = " + this.IDMesa + " AND comanda.Es = 1 AND descuentos.comanda = comanda.IDC ORDER BY(descuentos.numComensal)";
      Statement localStatement2 = this.con1.creaStatement();
      localResultSet2 = localStatement2.executeQuery(str2);
      while (localResultSet2.next())
      {
        j = localResultSet2.getInt("comanda");
        i = 1;
      }
      if (i == 0)
      {
        this.Descuento = 0.0D;
      }
      else
      {
        localResultSet2.beforeFirst();
        int k = 0;
        ResultSet localResultSet3 = null;
        while (localResultSet2.next())
        {
          k = localResultSet2.getInt("porcentaje");
          String str3 = "SELECT SUM(PT)AS total FROM comandapro WHERE IDC = " + j + " AND IDCom = " + localResultSet2.getInt("numComensal") + " AND Estatus = 1";
          Statement localStatement3 = this.con1.creaStatement();
          localResultSet3 = localStatement3.executeQuery(str3);
          double d2 = 0.0D;
          while (localResultSet3.next()) {
            d2 = localResultSet3.getDouble("total");
          }
          d2 = d2 * k / 100.0D;
          this.Descuento += d2;
          
          PreparedStatement localPreparedStatement2 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = (PT - ?) WHERE IDC = ?");
          localPreparedStatement2.setDouble(1, d2);
          localPreparedStatement2.setInt(2, j);
          localPreparedStatement2.execute();
        }
      }
      this.con1.realizaCommit(); return;
    }
    catch (SQLException localSQLException)
    {
      this.con1.realizaRollback();
      System.out.println("Error de SQL en ImpresionTicketXComensal, ajustaDescuentos ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      this.con1.realizaRollback();
      System.out.println("Ocurrio un Error en ImpresionTicketXComensal, ajustaDescuentos ");
      localException3.printStackTrace();
    }
    finally
    {
      if (this.con1 != null) {
        try
        {
          this.con1.realizaCommit();
          this.con1.habilitaAutoCommit();
          this.con1.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ImpresionTicketXComensal, ajustaDescuentos ");
          localException5.printStackTrace();
        }
      }
    }
  }
  
  public void validaReglas()
    throws SQLException, Exception
  {
    this.con1 = new ConexionBD();
    this.con1.cancelaAutoCommit();
    int i = 0;
    int j = 0;
    int k = 0;
    int m = 0;
    int n = 0;
    int i1 = 0;
    int i2 = 0;
    String str1 = "";
    str1 = this.mpv.dameLaClaveDeBotana();
    try
    {
      ResultSet localResultSet1 = null;
      ResultSet localResultSet2 = null;
      
      String str2 = "SELECT comandapro.CanPro AS Cantidad, comandapro.Tipo, comandapro.TB FROM bebidas, comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 2 AND comandapro.Estatus = 1 AND bebidas.clave =  comandapro.ClPro AND bebidas.alcoholica = 1 ";
      Statement localStatement1 = this.con1.creaStatement();
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
      
      String str3 = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.Estatus = 1";
      Statement localStatement2 = this.con1.creaStatement();
      localResultSet2 = localStatement2.executeQuery(str3);
      while (localResultSet2.next()) {
        i = localResultSet2.getInt("Botanas");
      }
      i1 = j;
      
      ResultSet localResultSet3 = null;
      
      String str4 = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + "  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.Estatus = 1 AND comandapro.PT = 0.00";
      Statement localStatement3 = this.con1.creaStatement();
      localResultSet3 = localStatement3.executeQuery(str4);
      while (localResultSet3.next()) {
        i2 = localResultSet3.getInt("Botanas");
      }
      if (i1 < i2) {
        i1 = i2;
      }
      if (i2 != i1)
      {
        int i3 = 0;
        String str5 = "SELECT DISTINCT (comandapro.ClPro)AS Clave FROM comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.Estatus = 1 ";
        ResultSet localResultSet4 = null;
        Statement localStatement4 = this.con1.creaStatement();
        localResultSet4 = localStatement4.executeQuery(str5);
        while (localResultSet4.next()) {
          i3 = localResultSet4.getInt("Clave");
        }
        double d = this.mpv.damePrecioUnitario(1, this.mpv.cambiaAInt(str1), i3, 0);
        int i4 = this.mpv.dameComandaCorrespondiente(this.IDMesa);
        if (i2 < i1)
        {
          int i5;
          Object localObject1;
          if (i1 >= i)
          {
            i5 = i1 - i2;
            if (i5 > i) {
              i5 = i;
            }
            for (int i6 = 1; i6 <= i5; i6++)
            {
              PreparedStatement localPreparedStatement1 = this.con1.miConnection.prepareStatement("UPDATE comandaPro SET PU = ?, PT = ? WHERE  IDC = ? AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
              localPreparedStatement1.setDouble(1, 0.0D);
              localPreparedStatement1.setDouble(2, 0.0D);
              localPreparedStatement1.setInt(3, i4);
              localPreparedStatement1.setInt(4, this.mpv.cambiaAInt(str1));
              localPreparedStatement1.execute();
            }
            localObject1 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
            ((PreparedStatement)localObject1).setDouble(1, d * i5);
            ((PreparedStatement)localObject1).setInt(2, i4);
            ((PreparedStatement)localObject1).execute();
          }
          else
          {
            i5 = this.mpv.dameComensalesPorMesa(this.IDMesa);
            localObject1 = new Vector();
            for (int i7 = 1; i7 <= i5; i7++)
            {
              n = 0;
              k = 0;
              m = 0;
              j = 0;
              int i8 = 0;
              
              String str6 = "SELECT comandapro.CanPro AS Cantidad, comandapro.Tipo, comandapro.TB FROM bebidas, comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + " AND comandapro.IDCom = " + i7 + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 2 AND comandapro.Estatus = 1 AND bebidas.clave =  comandapro.ClPro AND bebidas.alcoholica = 1 ";
              localStatement1 = this.con1.creaStatement();
              localResultSet1 = localStatement1.executeQuery(str6);
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
              if (n < 3)
              {
                i8 = n;
              }
              else
              {
                i8 = n - 3;
                while (i8 >= 3) {
                  i8 -= 3;
                }
              }
              n /= 3;
              k *= 5;
              m *= 4;
              j = n + k + m;
              ((Vector)localObject1).addElement(j + "*" + i8);
            }
            int i7 = 0;
            int i8 = 0;
            String str7;
            int i10;
            int i11;
            String str8;
            ResultSet localResultSet5;
            Statement localStatement5;
            int i12;
            for (int i9 = 1; i9 <= ((Vector)localObject1).size(); i9++)
            {
              str7 = (String)((Vector)localObject1).elementAt(i9 - 1);
              i10 = this.mpv.cambiaAInt(str7.substring(0, str7.indexOf("*")));
              i11 = this.mpv.cambiaAInt(str7.substring(str7.indexOf("*") + 1, str7.length()));
              str8 = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + "  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.IDCom = " + i9 + " AND comandapro.Estatus = 1 ";
              localResultSet5 = null;
              localStatement5 = this.con1.creaStatement();
              localResultSet5 = localStatement5.executeQuery(str8);
              while (localResultSet5.next())
              {
                i12 = localResultSet5.getInt("Botanas");
                if (i12 == i10)
                {
                  i7 += i11;
                }
                else if (i12 < i10)
                {
                  i7 += i11;
                  i8 += i10 - i12;
                }
                else if (i12 > i10)
                {
                  i7 += i11;
                }
              }
            }
            for (int i9 = 1; i9 <= ((Vector)localObject1).size(); i9++)
            {
              str7 = (String)((Vector)localObject1).elementAt(i9 - 1);
              i10 = this.mpv.cambiaAInt(str7.substring(0, str7.indexOf("*")));
              i11 = this.mpv.cambiaAInt(str7.substring(str7.indexOf("*") + 1, str7.length()));
              str8 = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " + this.IDMesa + "  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = " + str1 + " AND comandapro.IDCom = " + i9 + " AND comandapro.Estatus = 1 ";
              localResultSet5 = null;
              localStatement5 = this.con1.creaStatement();
              localResultSet5 = localStatement5.executeQuery(str8);
              while (localResultSet5.next())
              {
                i12 = localResultSet5.getInt("Botanas");
                int i13;
                PreparedStatement localPreparedStatement4;
                if (i12 == i10)
                {
                  for (i13 = 0; i13 < i12; i13++)
                  {
                    PreparedStatement localPreparedStatement2 = this.con1.miConnection.prepareStatement("UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ? AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
                    localPreparedStatement2.setDouble(1, 0.0D);
                    localPreparedStatement2.setDouble(2, 0.0D);
                    localPreparedStatement2.setInt(3, i9);
                    localPreparedStatement2.setInt(4, i4);
                    localPreparedStatement2.setInt(5, i9);
                    localPreparedStatement2.setInt(6, this.mpv.cambiaAInt(str1));
                    localPreparedStatement2.execute();
                    
                    localPreparedStatement4 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
                    localPreparedStatement4.setDouble(1, d);
                    localPreparedStatement4.setInt(2, i4);
                    localPreparedStatement4.execute();
                  }
                }
                else if (i12 > i10)
                {
                  int i14;
                  PreparedStatement localPreparedStatement5;
                  if (i10 >= 1)
                  {
                    i13 = i10;
                    for (i14 = 0; i14 < i13; i14++)
                    {
                      i12--;
                      i10--;
                      
                      localPreparedStatement4 = this.con1.miConnection.prepareStatement("UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
                      localPreparedStatement4.setDouble(1, 0.0D);
                      localPreparedStatement4.setDouble(2, 0.0D);
                      localPreparedStatement4.setInt(3, i9);
                      localPreparedStatement4.setInt(4, i4);
                      localPreparedStatement4.setInt(5, i9);
                      localPreparedStatement4.setInt(6, this.mpv.cambiaAInt(str1));
                      localPreparedStatement4.execute();
                      
                      localPreparedStatement5 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
                      localPreparedStatement5.setDouble(1, d);
                      localPreparedStatement5.setInt(2, i4);
                      localPreparedStatement5.execute();
                    }
                  }
                  if (i11 / 3 >= 1)
                  {
                    i13 = i11 / 3;
                    for (i14 = 0; i14 < i13; i14++)
                    {
                      i12--;
                      i11 -= 3;
                      
                      localPreparedStatement4 = this.con1.miConnection.prepareStatement("UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
                      localPreparedStatement4.setDouble(1, 0.0D);
                      localPreparedStatement4.setDouble(2, 0.0D);
                      localPreparedStatement4.setInt(3, i9);
                      localPreparedStatement4.setInt(4, i4);
                      localPreparedStatement4.setInt(5, i9);
                      localPreparedStatement4.setInt(6, this.mpv.cambiaAInt(str1));
                      localPreparedStatement4.execute();
                      
                      localPreparedStatement5 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
                      localPreparedStatement5.setDouble(1, d);
                      localPreparedStatement5.setInt(2, i4);
                      localPreparedStatement5.execute();
                    }
                  }
                  if ((i8 + i10 >= 1) && (i12 > 0))
                  {
                    i13 = i8 + i10;
                    for (i14 = 0; i14 < i13; i14++)
                    {
                      i8--;
                      i12--;
                      
                      localPreparedStatement4 = this.con1.miConnection.prepareStatement("UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
                      localPreparedStatement4.setDouble(1, 0.0D);
                      localPreparedStatement4.setDouble(2, 0.0D);
                      localPreparedStatement4.setInt(3, i9);
                      localPreparedStatement4.setInt(4, i4);
                      localPreparedStatement4.setInt(5, i9);
                      localPreparedStatement4.setInt(6, this.mpv.cambiaAInt(str1));
                      localPreparedStatement4.execute();
                      
                      localPreparedStatement5 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
                      localPreparedStatement5.setDouble(1, d);
                      localPreparedStatement5.setInt(2, i4);
                      localPreparedStatement5.execute();
                    }
                  }
                  if ((i7 / 3 >= 1) && (i12 > 0))
                  {
                    i13 = (i11 + i7) / 3 - i12;
                    for (i14 = 0; i14 < i13; i14++)
                    {
                      i7 -= 3;
                      i12--;
                      
                      localPreparedStatement4 = this.con1.miConnection.prepareStatement("UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
                      localPreparedStatement4.setDouble(1, 0.0D);
                      localPreparedStatement4.setDouble(2, 0.0D);
                      localPreparedStatement4.setInt(3, i9);
                      localPreparedStatement4.setInt(4, i4);
                      localPreparedStatement4.setInt(5, i9);
                      localPreparedStatement4.setInt(6, this.mpv.cambiaAInt(str1));
                      localPreparedStatement4.execute();
                      
                      localPreparedStatement5 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
                      localPreparedStatement5.setDouble(1, d);
                      localPreparedStatement5.setInt(2, i4);
                      localPreparedStatement5.execute();
                    }
                  }
                }
                else if (i12 < i10)
                {
                  for (i13 = 0; i13 < i12; i13++)
                  {
                    PreparedStatement localPreparedStatement3 = this.con1.miConnection.prepareStatement("UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
                    localPreparedStatement3.setDouble(1, 0.0D);
                    localPreparedStatement3.setDouble(2, 0.0D);
                    localPreparedStatement3.setInt(3, i9);
                    localPreparedStatement3.setInt(4, i4);
                    localPreparedStatement3.setInt(5, i9);
                    localPreparedStatement3.setInt(6, this.mpv.cambiaAInt(str1));
                    localPreparedStatement3.execute();
                    
                    localPreparedStatement4 = this.con1.miConnection.prepareStatement("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
                    localPreparedStatement4.setDouble(1, d);
                    localPreparedStatement4.setInt(2, i4);
                    localPreparedStatement4.execute();
                  }
                }
              }
            }
          }
        }
      }
      this.con1.realizaCommit(); return;
    }
    catch (SQLException localSQLException)
    {
      this.con1.realizaRollback();
      System.out.println("Error de SQL en ImpresionTicketXComensal, validaReglas ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException3)
    {
      this.con1.realizaRollback();
      System.out.println("Ocurrio un Error en ImpresionTicketXComensal, validaReglas ");
      localException3.printStackTrace();
    }
    finally
    {
      if (this.con1 != null) {
        try
        {
          this.con1.realizaCommit();
          this.con1.habilitaAutoCommit();
          this.con1.cierraConexion();
        }
        catch (Exception localException5)
        {
          System.out.println("Error al momento de cerrar conexion en ImpresionTicketXComensal, validaReglas ");
          localException5.printStackTrace();
        }
      }
    }
  }
  
  public ResultSet dameDatosComanda()
    throws SQLException, Exception
  {
    this.con1 = new ConexionBD();
    try
    {
      String str = "SELECT comanda.IDC, comanda.NC, CONCAT(empleados.Nombre COLLATE latin1_spanish_ci,' ',empleados.APaterno COLLATE latin1_spanish_ci) AS Nombre, comanda.PT  FROM comanda, empleados WHERE comanda.IDMM = " + this.IDMesa + " AND comanda.Es = 1 AND empleados.IDEmpleado = comanda.IDM ";
      Statement localStatement = this.con1.creaStatement();
      this.rs = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketComandaT, dameDatosComanda ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketComandaT, dameDatosComanda ");
      localException.printStackTrace();
    }
    return this.rs;
  }
  
  public void CierraConexion1()
    throws SQLException, Exception
  {
    if (this.con1 != null) {
      try
      {
        this.con1.cierraConexion();
      }
      catch (Exception localException)
      {
        System.out.println("Error al momento de cerrar conexion en ImpresionTicketComandaT, dameDatosComanda ");
        localException.printStackTrace();
      }
    }
  }
  
  public void CierraConexion2()
    throws SQLException, Exception
  {
    if (this.con2 != null) {
      try
      {
        this.con1.cierraConexion();
      }
      catch (Exception localException)
      {
        System.out.println("Error al momento de cerrar conexion en ImpresionTicketComandaT, dameDatosComanda ");
        localException.printStackTrace();
      }
    }
  }
  
  public ResultSet listadoComanda()
    throws SQLException, Exception
  {
    this.con2 = new ConexionBD();
    ResultSet localResultSet = null;
    try
    {
      String str = "SELECT Cantidad, PrecioUnitario, PrecioTotal, Producto, Tipo, Tamanio FROM (SELECT SUM(comandapro.CanPro)AS Cantidad, (comandapro.PU)AS PrecioUnitario, SUM(comandapro.PT)AS PrecioTotal, (comandapro.TB) AS Tamanio, (alimentos.nombre)AS Producto, comandapro.Tipo FROM comandapro, comanda, alimentos WHERE comanda.IDMM = " + this.IDMesa + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Tipo = 0 AND comandapro.Estatus = 1 AND alimentos.clave = comandapro.ClPro GROUP BY CONCAT(comandapro.ClPro,comandapro.TB,comandapro.PU) UNION SELECT SUM(comandapro.CanPro)AS  Cantidad, (comandapro.PU)AS PrecioUnitario, SUM(comandapro.PT)AS PrecioTotal, (comandapro.TB)AS Tamanio, (bebidas.nombre)AS Producto, comandapro.Tipo FROM comandapro, comanda, bebidas WHERE comanda.IDMM = " + this.IDMesa + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND (comandapro.Tipo = 1 OR comandapro.Tipo = 2 OR comandapro.Tipo = 3 OR comandapro.Tipo = 4) AND comandapro.Estatus = 1 AND bebidas.clave = comandapro.ClPro GROUP BY  CONCAT(comandapro.ClPro,comandapro.TB,comandapro.PU))AS TempT ORDER BY CONCAT(Producto,Tamanio)";
      Statement localStatement = this.con2.creaStatement();
      localResultSet = localStatement.executeQuery(str);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Error de SQL en ImpresionTicketComandaT, listadoComanda ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      System.out.println("Ocurrio un Error en ImpresionTicketComandaT, listadoComanda ");
      localException.printStackTrace();
    }
    return localResultSet;
  }
  
  public int print(Graphics paramGraphics, PageFormat paramPageFormat, int paramInt)
    throws PrinterException
  {
    if (paramInt >= (int)Math.ceil(this.cantidadHojas)) {
      return 1;
    }
    double d = paramPageFormat.getImageableWidth();
    
    this.g2d = ((Graphics2D)paramGraphics);
    
    this.g2d.translate(paramPageFormat.getImageableX(), paramPageFormat.getImageableY());
    
    MediaTracker localMediaTracker = new MediaTracker(this.frame);
    URL localURL = null;
    try
    {
      localURL = getClass().getResource("/imas/petitLogo.jpg");
    }
    catch (Exception localException1)
    {
      localException1.printStackTrace();
    }
    Image localImage = Toolkit.getDefaultToolkit().getImage(localURL);
    localMediaTracker.addImage(localImage, 0);
    try
    {
      localMediaTracker.waitForID(0);
    }
    catch (InterruptedException localInterruptedException) {}
    this.g2d.drawImage(localImage, 25, 0, (int)(0.944D * this.POINTS_PER_INCH), (int)(0.736D * this.POINTS_PER_INCH), this.frame);
    
    this.g2d.setFont(this.nuevaProd);
    this.nuevaProdAscent = this.g2d.getFontMetrics().getAscent();
    this.nuevaProdDescent = this.g2d.getFontMetrics().getDescent();
    this.nuevaProdLeading = this.g2d.getFontMetrics().getLeading();
    this.g2d.setFont(this.nuevaProd2);
    this.nuevaProdAscent2 = this.g2d.getFontMetrics().getAscent();
    this.nuevaProdDescent2 = this.g2d.getFontMetrics().getDescent();
    this.nuevaProdLeading2 = this.g2d.getFontMetrics().getLeading();
    this.g2d.setFont(this.prod);
    this.prodAscent = this.g2d.getFontMetrics().getAscent();
    this.prodDescent = this.g2d.getFontMetrics().getDescent();
    this.prodLeading = this.g2d.getFontMetrics().getLeading();
    this.g2d.setFont(this.nueva);
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
        while (i < 25)
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
    this.g2d.translate(paramPageFormat.getImageableX(), paramPageFormat.getImageableY());
    localDouble.y += 0.4D * this.POINTS_PER_INCH;
    localDouble.x += 98.0D;
    this.g2d.drawString("LA ULTRAMARINA", (int)localDouble.getX(), (int)localDouble.getY());
    this.g2d.setFont(this.nuevaProd2);
    localDouble.y += this.nuevaProdAscent + this.nuevaProdDescent + this.nuevaProdLeading;
    localDouble.x = 110.0D;
    this.g2d.drawString("Cuenta: Total", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += 17.0D;
    localDouble.x = 0.0D;
    this.g2d.setFont(this.nuevaProd);
    this.g2d.drawString("**************************************", (int)localDouble.getX(), (int)localDouble.getY());
    
    localDouble.y += this.nuevaProdAscent;
    localDouble.x = 5.0D;
    this.g2d.setFont(this.nuevaProd2);
    
    this.g2d.drawString("           Cantina   \" La Ultramarina \"", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.x = 5.0D;
    AttributedString localAttributedString = new AttributedString(DATARFC+RFC);
    
    localAttributedString.addAttribute(TextAttribute.FONT, this.nuevaProd2);
    
    LineBreakMeasurer localLineBreakMeasurer = new LineBreakMeasurer(localAttributedString.getIterator(), new FontRenderContext(null, true, true));
    TextLayout localTextLayout;
    while ((localTextLayout = localLineBreakMeasurer.nextLayout((float)d)) != null)
    {
      localDouble.y += localTextLayout.getAscent();
      if (localTextLayout.isLeftToRight()) {
        localDouble.x = ((d - localTextLayout.getVisibleAdvance()) / 2.0D);
      } else {
        localDouble.x = ((d + localTextLayout.getAdvance()) / 2.0D - localTextLayout.getAdvance());
      }
      localTextLayout.draw(this.g2d, (float)localDouble.x, (float)localDouble.y);
      
      localDouble.y += localTextLayout.getDescent() + localTextLayout.getLeading() - 3.0F;
    }
    localAttributedString = new AttributedString(DATACURP);
    
    localAttributedString.addAttribute(TextAttribute.FONT, this.nuevaProd2);
    
    localLineBreakMeasurer = new LineBreakMeasurer(localAttributedString.getIterator(), new FontRenderContext(null, true, true));
    while ((localTextLayout = localLineBreakMeasurer.nextLayout((float)d)) != null)
    {
      localDouble.y += localTextLayout.getAscent();
      if (localTextLayout.isLeftToRight()) {
        localDouble.x = ((d - localTextLayout.getVisibleAdvance()) / 2.0D);
      } else {
        localDouble.x = ((d + localTextLayout.getAdvance()) / 2.0D - localTextLayout.getAdvance());
      }
      localTextLayout.draw(this.g2d, (float)localDouble.x, (float)localDouble.y);
      
      localDouble.y += localTextLayout.getDescent() + localTextLayout.getLeading() - 3.0F;
    }
    localAttributedString = new AttributedString(DATADIR);
    
    localAttributedString.addAttribute(TextAttribute.FONT, this.nuevaProd2);
    
    localLineBreakMeasurer = new LineBreakMeasurer(localAttributedString.getIterator(), new FontRenderContext(null, true, true));
    while ((localTextLayout = localLineBreakMeasurer.nextLayout((float)d)) != null)
    {
      localDouble.y += localTextLayout.getAscent();
      if (localTextLayout.isLeftToRight()) {
        localDouble.x = ((d - localTextLayout.getVisibleAdvance()) / 2.0D);
      } else {
        localDouble.x = ((d + localTextLayout.getAdvance()) / 2.0D - localTextLayout.getAdvance());
      }
      localTextLayout.draw(this.g2d, (float)localDouble.x, (float)localDouble.y);
      
      localDouble.y += localTextLayout.getDescent() + localTextLayout.getLeading() - 3.0F;
    }
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 0.0D;
    this.g2d.setFont(this.nuevaProd);
    this.g2d.drawString("*************** NO FISCAL ***************", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdAscent;
    localDouble.x = 5.0D;
    this.g2d.setFont(this.nuevaProd2);
    this.g2d.drawString("Fecha: " + this.Fecha, (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.x = 105.0D;
    this.g2d.drawString("Hora: " + this.Hora, (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 5.0D;
    try
    {
      this.g2d.drawString("Mesa: " + this.mpv.cambiaANombreBarra(new StringBuilder().append(this.IDMesa).append("").toString()) + ",", (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.x = 55.0D;
    }
    catch (Exception localException2)
    {
      localException2.printStackTrace();
    }
    this.g2d.drawString("Comen.:#" + this.NumComensales, (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.x = 118.0D;
    
    localDouble.y += this.nuevaProdDescent;
    localDouble.x = 0.0D;
    this.g2d.setFont(this.nuevaProd);
    this.g2d.drawString(" ________________________________________", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 0.0D;
    this.g2d.drawString("Cant.             Producto             $ Unitario       $ Total", (int)localDouble.getX(), (int)localDouble.getY());
    localDouble.y += this.nuevaProdDescent + this.nuevaProdLeading + this.nuevaProdAscent;
    localDouble.x = 0.0D;
    this.g2d.setFont(this.prod);
    
    int k = 0;
    int m = 0;
    try
    {
      while ((this.rs.next()) && (m < 25))
      {
        int n = 0;
        String str1 = this.mpv.formatoCortoDinero(this.rs.getString("precioUnitario"));
        String str2 = this.mpv.formatoCortoDinero(this.rs.getString("precioTotal"));
        String str3 = this.rs.getString("Producto").toLowerCase();
        if (str3.length() > 25) {
          str3 = str3.substring(0, 25);
        }
        if ((this.rs.getString("tipo").equalsIgnoreCase("1")) && (this.rs.getInt("Tamanio") == 1)) {
          this.Tipo = "C.";
        } else if ((this.rs.getString("tipo").equalsIgnoreCase("1")) && (this.rs.getInt("Tamanio") == 2)) {
          this.Tipo = "Cd.";
        } else if ((this.rs.getString("tipo").equalsIgnoreCase("1")) && (this.rs.getInt("Tamanio") == 3)) {
          this.Tipo = "Ct.";
        } else if (this.rs.getString("tipo").equalsIgnoreCase("2")) {
          this.Tipo = "B.";
        } else if (this.rs.getString("tipo").equalsIgnoreCase("3")) {
          this.Tipo = "BG.";
        } else if (this.rs.getString("tipo").equalsIgnoreCase("4")) {
          this.Tipo = "BP.";
        } else {
          this.Tipo = "";
        }
        this.Cantidad = this.mpv.dameEnteros(this.rs.getString("Cantidad"));
        if (this.Cantidad.equals("1")) {
          n = 1;
        }
        this.Cantidad = (this.Cantidad + " " + this.Tipo);
        m++;
        if (k != 0)
        {
          localDouble.y += this.prodDescent + this.prodLeading;
          localDouble.x = 0.0D;
          localDouble.y += this.prodAscent;
        }
        else
        {
          k = 1;
        }
        if (n != 0) {
          localDouble.x += 2.0D;
        }
        this.g2d.drawString(this.Cantidad, (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.x += 23.0D;
        if (n != 0) {
          localDouble.x += -2.0D;
        }
        this.g2d.drawString(str3, (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.x = 116.0D;
        if (this.mpv.formatoDinero(this.mpv.acortaLongitud(str1)).length() <= 6) {
          localDouble.x += -2.0D;
        }
        this.g2d.drawString(this.mpv.formatoEspaciado(this.mpv.formatoDinero(this.mpv.acortaLongitud(str1))), (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.x = 152.0D;
        if (this.mpv.formatoDinero(this.mpv.acortaLongitud(str2)).length() <= 6) {
          localDouble.x += -2.0D;
        }
        this.g2d.drawString(this.mpv.formatoEspaciado(this.mpv.formatoDinero(this.mpv.acortaLongitud(str2))), (int)localDouble.getX(), (int)localDouble.getY());
      }
      this.rs.previous();
    }
    catch (SQLException localSQLException3)
    {
      localSQLException3.printStackTrace();
    }
    catch (Exception localException3)
    {
      localException3.printStackTrace();
    }
    this.g2d.setFont(this.nuevaProd);
    if (paramInt + 1 == (int)Math.ceil(this.cantidadHojas))
    {
      localDouble.y += this.nuevaProdDescent;
      localDouble.x = 0.0D;
      this.g2d.drawString(" ________________________________________", (int)localDouble.getX(), (int)localDouble.getY());
      if (this.Descuento > 0.0D)
      {
        localDouble.y += this.nuevaProdDescent + this.nuevaProdAscent;
        localDouble.x = 110.0D;
        this.g2d.drawString("DESCUENTO. $ ", (int)localDouble.getX(), (int)localDouble.getY());
        localDouble.x = 155.0D;
        if (this.Descuento + "".length() <= 6.0D) {
          localDouble.x += -2.0D;
        }
        try
        {
          this.g2d.drawString(this.mpv.formatoEspaciado(this.mpv.formatoDinero(this.mpv.acortaLongitud(this.Descuento + ""))), (int)localDouble.getX(), (int)localDouble.getY());
        }
        catch (Exception localException4)
        {
          localException4.printStackTrace();
        }
      }
      localDouble.y += this.nuevaProdDescent + this.nuevaProdAscent;
      localDouble.x = 110.0D;
      this.g2d.drawString("TOTAL.......... $ ", (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.x = 155.0D;
      if (this.PagoTotal.length() <= 6) {
        localDouble.x += -2.0D;
      }
      try
      {
        this.g2d.drawString(this.mpv.formatoEspaciado(this.PagoTotal), (int)localDouble.getX(), (int)localDouble.getY());
      }
      catch (Exception localException5)
      {
        localException5.printStackTrace();
      }
      localDouble.y += this.nuevaProdDescent + this.nuevaProdAscent;
      localDouble.x = 0.0D;
      this.g2d.drawString("**************************************", (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.y += this.nuevaProdAscent;
      localDouble.x = 5.0D;
      this.g2d.drawString("***** Los Precios Incluyen I.V.A. *****", (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.y += this.nuevaProdAscent;
      localDouble.x = 35.0D;
      this.g2d.drawString("Gracias Por Su Visita, Vuelva Pronto", (int)localDouble.getX(), (int)localDouble.getY());
      localDouble.y += this.nuevaProdLeading + this.nuevaProdAscent;
      localDouble.x = 53.0D;
      this.g2d.drawString("Le atendio: " + this.Empleado, (int)localDouble.getX(), (int)localDouble.getY());
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
      this.PRINTER_NAME = config.getProperty("imp_Caja").trim();
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
