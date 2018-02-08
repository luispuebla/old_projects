package alphanet.ultra.digibar.servidor;

import java.lang.reflect.Method;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.UnexpectedException;
import java.rmi.server.RemoteRef;
import java.rmi.server.RemoteStub;
import java.util.Vector;

import javax.swing.DefaultListModel;
import javax.swing.table.AbstractTableModel;

public final class BarServerImpl_Stub
  extends RemoteStub
  implements BarServicios, Remote
{
  private static final long serialVersionUID = 2L;
  private static Method $method_AlmacenaComanda_0;
  private static Method $method_AlmacenaComandaInterna_1;
  private static Method $method_ConsultaProductoComanda_2;
  private static Method $method_DameCantidadOriginalComensales_3;
  private static Method $method_DameCantidadTotalComensales_4;
  private static Method $method_DameDesgloseXComensal_5;
  private static Method $method_DameListadoEmpleados_6;
  private static Method $method_DameListadoMeseros_7;
  private static Method $method_DameListadoTodos_8;
  private static Method $method_DameMesaMadre_9;
  private static Method $method_DameMeseroAsignado_10;
  private static Method $method_DimeHola_11;
  private static Method $method_EstatusMapa_12;
  private static Method $method_ImprimeTicketTotal_13;
  private static Method $method_ImprimeTicketXComen_14;
  private static Method $method_ProcesaAltaMesa_15;
  private static Method $method_ProcesaModificaMesa_16;
  private static Method $method_actualizaAsignacionProducComen_17;
  private static Method $method_autentificaUsuario_18;
  private static Method $method_dameClaveBotana_19;
  private static Method $method_dameComponentesBotana_20;
  private static Method $method_dameDisponibilidadBotella_21;
  private static Method $method_dameEntregaBebida_22;
  private static Method $method_dameListadoPorCombinar_23;
  private static Method $method_dameMontoTransaccion_24;
  private static Method $method_damePrecioBotella_25;
  private static Method $method_damePrecioCopa_26;
  private static Method $method_listaComensales_27;
  private static Method $method_listaProducto_28;
  private static Method $method_listaXDivision_29;
  private static Method $method_mesasDisponiblesTraspaso_30;
  private static Method $method_mesasLigadasA_31;
  private static Method $method_mesasParaLigar_32;
  private static Method $method_nuevaListaPInterno_33;
  private static Method $method_nuevaListaProducto_34;
  private static Method $method_traspasaMesa_35;
  
  static
  {
    try
    {
      $method_AlmacenaComanda_0 = BarServicios.class.getMethod("AlmacenaComanda", new Class[] { Integer.TYPE, Vector.class, Integer.TYPE });
      $method_AlmacenaComandaInterna_1 = BarServicios.class.getMethod("AlmacenaComandaInterna", new Class[] { Vector.class, Integer.TYPE });
      $method_ConsultaProductoComanda_2 = BarServicios.class.getMethod("ConsultaProductoComanda", new Class[] { Integer.TYPE });
      $method_DameCantidadOriginalComensales_3 = BarServicios.class.getMethod("DameCantidadOriginalComensales", new Class[] { Integer.TYPE });
      $method_DameCantidadTotalComensales_4 = BarServicios.class.getMethod("DameCantidadTotalComensales", new Class[] { Integer.TYPE });
      $method_DameDesgloseXComensal_5 = BarServicios.class.getMethod("DameDesgloseXComensal", new Class[] { Integer.TYPE });
      $method_DameListadoEmpleados_6 = BarServicios.class.getMethod("DameListadoEmpleados", new Class[0]);
      $method_DameListadoMeseros_7 = BarServicios.class.getMethod("DameListadoMeseros", new Class[0]);
      $method_DameListadoTodos_8 = BarServicios.class.getMethod("DameListadoTodos", new Class[0]);
      $method_DameMesaMadre_9 = BarServicios.class.getMethod("DameMesaMadre", new Class[] { String.class });
      $method_DameMeseroAsignado_10 = BarServicios.class.getMethod("DameMeseroAsignado", new Class[] { Integer.TYPE });
      $method_DimeHola_11 = BarServicios.class.getMethod("DimeHola", new Class[] { String.class });
      $method_EstatusMapa_12 = BarServicios.class.getMethod("EstatusMapa", new Class[] { Integer.TYPE });
      $method_ImprimeTicketTotal_13 = BarServicios.class.getMethod("ImprimeTicketTotal", new Class[] { Integer.TYPE });
      $method_ImprimeTicketXComen_14 = BarServicios.class.getMethod("ImprimeTicketXComen", new Class[] { Integer.TYPE });
      $method_ProcesaAltaMesa_15 = BarServicios.class.getMethod("ProcesaAltaMesa", new Class[] { Integer.TYPE, Integer.TYPE, Integer.TYPE, DefaultListModel.class });
      $method_ProcesaModificaMesa_16 = BarServicios.class.getMethod("ProcesaModificaMesa", new Class[] { Integer.TYPE, Integer.TYPE, Integer.TYPE, DefaultListModel.class });
      $method_actualizaAsignacionProducComen_17 = BarServicios.class.getMethod("actualizaAsignacionProducComen", new Class[] { Integer.TYPE, Integer.TYPE, Integer.TYPE, String.class, Integer.TYPE });
      $method_autentificaUsuario_18 = BarServicios.class.getMethod("autentificaUsuario", new Class[] { Integer.TYPE, Integer.TYPE });
      $method_dameClaveBotana_19 = BarServicios.class.getMethod("dameClaveBotana", new Class[0]);
      $method_dameComponentesBotana_20 = BarServicios.class.getMethod("dameComponentesBotana", new Class[0]);
      $method_dameDisponibilidadBotella_21 = BarServicios.class.getMethod("dameDisponibilidadBotella", new Class[] { Integer.TYPE, Integer.TYPE, String.class, Integer.TYPE });
      $method_dameEntregaBebida_22 = BarServicios.class.getMethod("dameEntregaBebida", new Class[] { Integer.TYPE, Integer.TYPE });
      $method_dameListadoPorCombinar_23 = BarServicios.class.getMethod("dameListadoPorCombinar", new Class[0]);
      $method_dameMontoTransaccion_24 = BarServicios.class.getMethod("dameMontoTransaccion", new Class[] { Integer.TYPE });
      $method_damePrecioBotella_25 = BarServicios.class.getMethod("damePrecioBotella", new Class[] { Integer.TYPE, Integer.TYPE, Integer.TYPE });
      $method_damePrecioCopa_26 = BarServicios.class.getMethod("damePrecioCopa", new Class[] { Integer.TYPE, Integer.TYPE });
      $method_listaComensales_27 = BarServicios.class.getMethod("listaComensales", new Class[] { Integer.TYPE });
      $method_listaProducto_28 = BarServicios.class.getMethod("listaProducto", new Class[] { Integer.TYPE, Integer.TYPE });
      $method_listaXDivision_29 = BarServicios.class.getMethod("listaXDivision", new Class[] { Integer.TYPE });
      $method_mesasDisponiblesTraspaso_30 = BarServicios.class.getMethod("mesasDisponiblesTraspaso", new Class[] { Integer.TYPE });
      $method_mesasLigadasA_31 = BarServicios.class.getMethod("mesasLigadasA", new Class[] { Integer.TYPE });
      $method_mesasParaLigar_32 = BarServicios.class.getMethod("mesasParaLigar", new Class[] { Integer.TYPE });
      $method_nuevaListaPInterno_33 = BarServicios.class.getMethod("nuevaListaPInterno", new Class[] { Vector.class });
      $method_nuevaListaProducto_34 = BarServicios.class.getMethod("nuevaListaProducto", new Class[] { Vector.class });
      $method_traspasaMesa_35 = BarServicios.class.getMethod("traspasaMesa", new Class[] { Integer.TYPE, String.class });
    }
    catch (NoSuchMethodException localNoSuchMethodException)
    {
      throw new NoSuchMethodError("stub class initialization failed");
    }
  }
  
  public BarServerImpl_Stub(RemoteRef paramRemoteRef)
  {
    super(paramRemoteRef);
  }
  
  public Vector AlmacenaComanda(int paramInt1, Vector paramVector, int paramInt2)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_AlmacenaComanda_0, new Object[] { new Integer(paramInt1), paramVector, new Integer(paramInt2) }, -1987209095912412159L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector AlmacenaComandaInterna(Vector paramVector, int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_AlmacenaComandaInterna_1, new Object[] { paramVector, new Integer(paramInt) }, 6299261043892085334L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public AbstractTableModel ConsultaProductoComanda(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_ConsultaProductoComanda_2, new Object[] { new Integer(paramInt) }, -5204595232077104645L);
      return (AbstractTableModel)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public int DameCantidadOriginalComensales(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameCantidadOriginalComensales_3, new Object[] { new Integer(paramInt) }, -7972821120046884393L);
      return ((Integer)localObject).intValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public int DameCantidadTotalComensales(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameCantidadTotalComensales_4, new Object[] { new Integer(paramInt) }, -6826730184416140166L);
      return ((Integer)localObject).intValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public AbstractTableModel DameDesgloseXComensal(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameDesgloseXComensal_5, new Object[] { new Integer(paramInt) }, -4651037715385379047L);
      return (AbstractTableModel)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector DameListadoEmpleados()
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameListadoEmpleados_6, null, 3450974134652155474L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector DameListadoMeseros()
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameListadoMeseros_7, null, -5989128458696900580L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector DameListadoTodos()
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameListadoTodos_8, null, -7477259340603005555L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public String DameMesaMadre(String paramString)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameMesaMadre_9, new Object[] { paramString }, -2762855023718831112L);
      return (String)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public String DameMeseroAsignado(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DameMeseroAsignado_10, new Object[] { new Integer(paramInt) }, 3985672492931068693L);
      return (String)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public String DimeHola(String paramString)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_DimeHola_11, new Object[] { paramString }, -3964305675540434601L);
      return (String)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector EstatusMapa(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_EstatusMapa_12, new Object[] { new Integer(paramInt) }, -7521878606386857588L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public void ImprimeTicketTotal(int paramInt)
    throws RemoteException
  {
    try
    {
      this.ref.invoke(this, $method_ImprimeTicketTotal_13, new Object[] { new Integer(paramInt) }, 5104167851397790641L);
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public void ImprimeTicketXComen(int paramInt)
    throws RemoteException
  {
    try
    {
      this.ref.invoke(this, $method_ImprimeTicketXComen_14, new Object[] { new Integer(paramInt) }, 3420996911501872629L);
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public String ProcesaAltaMesa(int paramInt1, int paramInt2, int paramInt3, DefaultListModel paramDefaultListModel)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_ProcesaAltaMesa_15, new Object[] { new Integer(paramInt1), new Integer(paramInt2), new Integer(paramInt3), paramDefaultListModel }, 7401113210138516009L);
      return (String)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public String ProcesaModificaMesa(int paramInt1, int paramInt2, int paramInt3, DefaultListModel paramDefaultListModel)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_ProcesaModificaMesa_16, new Object[] { new Integer(paramInt1), new Integer(paramInt2), new Integer(paramInt3), paramDefaultListModel }, -7973898876528522708L);
      return (String)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public void actualizaAsignacionProducComen(int paramInt1, int paramInt2, int paramInt3, String paramString, int paramInt4)
    throws RemoteException
  {
    try
    {
      this.ref.invoke(this, $method_actualizaAsignacionProducComen_17, new Object[] { new Integer(paramInt1), new Integer(paramInt2), new Integer(paramInt3), paramString, new Integer(paramInt4) }, -6369849846917189138L);
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public boolean autentificaUsuario(int paramInt1, int paramInt2)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_autentificaUsuario_18, new Object[] { new Integer(paramInt1), new Integer(paramInt2) }, 2840125031076742374L);
      return ((Boolean)localObject).booleanValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public String dameClaveBotana()
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_dameClaveBotana_19, null, 9106328529116626788L);
      return (String)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector dameComponentesBotana()
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_dameComponentesBotana_20, null, 4148297049350475788L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public boolean dameDisponibilidadBotella(int paramInt1, int paramInt2, String paramString, int paramInt3)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_dameDisponibilidadBotella_21, new Object[] { new Integer(paramInt1), new Integer(paramInt2), paramString, new Integer(paramInt3) }, 1903396545824503475L);
      return ((Boolean)localObject).booleanValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public int dameEntregaBebida(int paramInt1, int paramInt2)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_dameEntregaBebida_22, new Object[] { new Integer(paramInt1), new Integer(paramInt2) }, 1409899831685736974L);
      return ((Integer)localObject).intValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector dameListadoPorCombinar()
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_dameListadoPorCombinar_23, null, 4332416643385449924L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public double dameMontoTransaccion(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_dameMontoTransaccion_24, new Object[] { new Integer(paramInt) }, -2332698328776658693L);
      return ((Double)localObject).doubleValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public double damePrecioBotella(int paramInt1, int paramInt2, int paramInt3)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_damePrecioBotella_25, new Object[] { new Integer(paramInt1), new Integer(paramInt2), new Integer(paramInt3) }, 940181339801760405L);
      return ((Double)localObject).doubleValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public double damePrecioCopa(int paramInt1, int paramInt2)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_damePrecioCopa_26, new Object[] { new Integer(paramInt1), new Integer(paramInt2) }, -2175095394679830055L);
      return ((Double)localObject).doubleValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector listaComensales(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_listaComensales_27, new Object[] { new Integer(paramInt) }, 703423930067993834L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public AbstractTableModel listaProducto(int paramInt1, int paramInt2)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_listaProducto_28, new Object[] { new Integer(paramInt1), new Integer(paramInt2) }, -60313727242426673L);
      return (AbstractTableModel)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector listaXDivision(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_listaXDivision_29, new Object[] { new Integer(paramInt) }, 7037709108738987525L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector mesasDisponiblesTraspaso(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_mesasDisponiblesTraspaso_30, new Object[] { new Integer(paramInt) }, 8567043871832403605L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector mesasLigadasA(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_mesasLigadasA_31, new Object[] { new Integer(paramInt) }, -4591218679303995974L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector mesasParaLigar(int paramInt)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_mesasParaLigar_32, new Object[] { new Integer(paramInt) }, 1595380710659024084L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector nuevaListaPInterno(Vector paramVector)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_nuevaListaPInterno_33, new Object[] { paramVector }, -4218255372630366688L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public Vector nuevaListaProducto(Vector paramVector)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_nuevaListaProducto_34, new Object[] { paramVector }, -3131151932773853998L);
      return (Vector)localObject;
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
  
  public int traspasaMesa(int paramInt, String paramString)
    throws RemoteException
  {
    try
    {
      Object localObject = this.ref.invoke(this, $method_traspasaMesa_35, new Object[] { new Integer(paramInt), paramString }, -7639529005637779404L);
      return ((Integer)localObject).intValue();
    }
    catch (RuntimeException localRuntimeException)
    {
      throw localRuntimeException;
    }
    catch (RemoteException localRemoteException)
    {
      throw localRemoteException;
    }
    catch (Exception localException)
    {
      throw new UnexpectedException("undeclared checked exception", localException);
    }
  }
}
