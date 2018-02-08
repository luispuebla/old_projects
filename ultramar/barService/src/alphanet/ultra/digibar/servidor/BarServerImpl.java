package alphanet.ultra.digibar.servidor;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.sql.SQLException;
import java.util.Vector;

import javax.swing.DefaultListModel;
import javax.swing.table.AbstractTableModel;

import alphanet.ultra.digibar.bd.ManagerPuntoVenta;
import alphanet.ultra.digibar.bd.MyTableModel;

public class BarServerImpl
  extends UnicastRemoteObject
  implements BarServicios
{
  protected static ManagerPuntoVenta mpv = new ManagerPuntoVenta();
  private static final long serialVersionUID = 1L;
  
  public BarServerImpl()
    throws RemoteException
  {}
  
  public String DimeHola(String paramString)
    throws RemoteException
  {
    System.out.println("Cliente solicitando informacion");
    return "Hola " + paramString;
  }
  
  public Vector<String> EstatusMapa(int paramInt)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.estatusMapa(paramInt);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Excepcion SQL: ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public void ImprimeTicketTotal(int paramInt)
    throws RemoteException
  {
    try
    {
      mpv.ImprimeTicketTotal(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public void ImprimeTicketXComen(int paramInt)
    throws RemoteException
  {
    try
    {
      mpv.ImprimeTicketxComensal(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public String DameMesaMadre(String paramString)
    throws RemoteException
  {
    String str = "";
    try
    {
      str = mpv.mesaMadreLigada(paramString);
    }
    catch (SQLException localSQLException)
    {
      System.out.println("Excepcion SQL: ");
      localSQLException.printStackTrace();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public Vector<String> DameListadoMeseros()
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.listadoMeseras();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<String> DameListadoEmpleados()
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.listadoEmpleados();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<String> DameListadoTodos()
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.listadosTodosAutorizados();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<String> mesasLigadasA(int paramInt)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.dameMesasLigadasA(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public int DameCantidadOriginalComensales(int paramInt)
    throws RemoteException
  {
    int i = -1;
    try
    {
      i = mpv.dameComensalesPorMesa(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return i;
  }
  
  public Vector<String> mesasDisponiblesTraspaso(int paramInt)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.mesasDisponiblesTraspaso(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<String> mesasParaLigar(int paramInt)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.mesasDisponiblesLiga(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public String ProcesaModificaMesa(int paramInt1, int paramInt2, int paramInt3, javax.swing.DefaultListModel paramDefaultListModel)
    throws RemoteException
  {
    String str = "";
    try
    {
      str = mpv.modificaMesa(paramInt1, paramInt2, paramInt3, paramDefaultListModel);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public String ProcesaAltaMesa(int paramInt1, int paramInt2, int paramInt3, DefaultListModel paramDefaultListModel)
    throws RemoteException
  {
    String str = "";
    try
    {
      str = mpv.altaDeMesa(paramInt1, paramInt2, paramInt3, paramDefaultListModel);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public Vector<String> listaComensales(int paramInt)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.comensalesDesglosados(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<String> listaXDivision(int paramInt)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.divisionesDisponibles(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public AbstractTableModel listaProducto(int paramInt1, int paramInt2)
    throws RemoteException
  {
    MyTableModel localMyTableModel = null;
    try
    {
      localMyTableModel = mpv.dameModeloProductos(paramInt1, paramInt2);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localMyTableModel;
  }
  
  public int traspasaMesa(int paramInt, String paramString)
    throws RemoteException
  {
    int i = -1;
    try
    {
      i = mpv.traspasaMesaA(paramInt, paramString);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return i;
  }
  
  public Vector<String> dameListadoPorCombinar()
    throws RemoteException
  {
    Vector<String> localVector = null;
    try
    {
      localVector = mpv.dameListaParaCombinar();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<String> dameComponentesBotana()
    throws RemoteException
  {
    Vector<String> localVector = null;
    try
    {
      localVector = mpv.dameListaComponeBotana();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public String dameClaveBotana()
    throws RemoteException
  {
    String str = "";
    try
    {
      str = mpv.dameLaClaveDeBotana();
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public Vector<Object> nuevaListaPInterno(Vector<Object> paramVector)
    throws RemoteException
  {
    Vector<Object> localVector = null;
    try
    {
      localVector = mpv.dameModeloEspecialInterno(paramVector);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<Object> nuevaListaProducto(Vector<Object> paramVector)
    throws RemoteException
  {
    Vector<Object> localVector = null;
    try
    {
      localVector = mpv.dameModeloEspecialBebidas(paramVector);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public AbstractTableModel ConsultaProductoComanda(int paramInt)
    throws RemoteException
  {
    MyTableModel localMyTableModel = null;
    try
    {
      localMyTableModel = mpv.consultaComandaMTM(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localMyTableModel;
  }
  
  public AbstractTableModel DameDesgloseXComensal(int paramInt)
    throws RemoteException
  {
    MyTableModel localMyTableModel = null;
    try
    {
      localMyTableModel = mpv.comandaDesglosXComensal(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localMyTableModel;
  }
  
  public void actualizaAsignacionProducComen(int paramInt1, int paramInt2, int paramInt3, String paramString, int paramInt4)
    throws RemoteException
  {
    try
    {
      mpv.modificaComensalAsignado(paramInt1, paramInt2, paramInt3, paramString, paramInt4);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public int DameCantidadTotalComensales(int paramInt)
    throws RemoteException
  {
    int i = -1;
    try
    {
      i = mpv.dameComensalesPorMesa(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return i;
  }
  
  public int dameEntregaBebida(int paramInt1, int paramInt2)
    throws RemoteException
  {
    int i = -1;
    try
    {
      i = mpv.dameClasificacionBotella(paramInt1, paramInt2);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return i;
  }
  
  public boolean dameDisponibilidadBotella(int paramInt1, int paramInt2, String paramString, int paramInt3)
    throws RemoteException
  {
    boolean bool = false;
    try
    {
      bool = mpv.existeDisponibilidadBotella(paramInt1, paramInt2, paramString, paramInt3);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return bool;
  }
  
  public double damePrecioBotella(int paramInt1, int paramInt2, int paramInt3)
    throws RemoteException
  {
    double d = 0.0D;
    try
    {
      d = mpv.recuperaPrecioXBotella(paramInt1, paramInt2, paramInt3);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return d;
  }
  
  public double damePrecioCopa(int paramInt1, int paramInt2)
    throws RemoteException
  {
    double d = 0.0D;
    try
    {
      d = mpv.recuperaPrecioXCopa(paramInt1, paramInt2);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return d;
  }
  
  public double dameMontoTransaccion(int paramInt)
    throws RemoteException
  {
    double d = 0.0D;
    try
    {
      d = mpv.dameMontoTotal(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return d;
  }
  
  public boolean autentificaUsuario(int paramInt1, int paramInt2)
    throws RemoteException
  {
    boolean bool = false;
    try
    {
      bool = mpv.verificaIdentidad(paramInt1, paramInt2);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return bool;
  }
  
  public String DameMeseroAsignado(int paramInt)
    throws RemoteException
  {
    String str = "";
    try
    {
      str = mpv.dameMeseroAsignado(paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return str;
  }
  
  public Vector<String> AlmacenaComandaInterna(Vector<Object> paramVector, int paramInt)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.almacenaComandaInterna(paramVector, paramInt);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
  
  public Vector<String> AlmacenaComanda(int paramInt1, Vector<Object> paramVector, int paramInt2)
    throws RemoteException
  {
    Vector<String> localVector = new Vector<String>();
    try
    {
      localVector = mpv.almacenaComanda(paramInt1, paramVector, paramInt2);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    return localVector;
  }
}
