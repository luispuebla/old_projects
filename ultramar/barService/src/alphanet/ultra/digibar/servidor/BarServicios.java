package alphanet.ultra.digibar.servidor;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.Vector;

import javax.swing.DefaultListModel;
import javax.swing.table.AbstractTableModel;

public abstract interface BarServicios
  extends Remote
{
  public abstract String DimeHola(String paramString)
    throws RemoteException;
  
  public abstract Vector<String> EstatusMapa(int paramInt)
    throws RemoteException;
  
  public abstract String DameMesaMadre(String paramString)
    throws RemoteException;
  
  public abstract Vector<String> DameListadoMeseros()
    throws RemoteException;
  
  public abstract Vector<String> DameListadoEmpleados()
    throws RemoteException;
  
  public abstract Vector<String> mesasParaLigar(int paramInt)
    throws RemoteException;
  
  public abstract Vector<String> mesasDisponiblesTraspaso(int paramInt)
    throws RemoteException;
  
  public abstract String ProcesaAltaMesa(int paramInt1, int paramInt2, int paramInt3, DefaultListModel paramDefaultListModel)
    throws RemoteException;
  
  public abstract String ProcesaModificaMesa(int paramInt1, int paramInt2, int paramInt3, DefaultListModel paramDefaultListModel)
    throws RemoteException;
  
  public abstract Vector<String> listaComensales(int paramInt)
    throws RemoteException;
  
  public abstract Vector<String> listaXDivision(int paramInt)
    throws RemoteException;
  
  public abstract AbstractTableModel listaProducto(int paramInt1, int paramInt2)
    throws RemoteException;
  
  public abstract Vector<Object> nuevaListaProducto(Vector<Object> paramVector)
    throws RemoteException;
  
  public abstract Vector<Object> nuevaListaPInterno(Vector<Object> paramVector)
    throws RemoteException;
  
  public abstract AbstractTableModel ConsultaProductoComanda(int paramInt)
    throws RemoteException;
  
  public abstract AbstractTableModel DameDesgloseXComensal(int paramInt)
    throws RemoteException;
  
  public abstract int dameEntregaBebida(int paramInt1, int paramInt2)
    throws RemoteException;
  
  public abstract int traspasaMesa(int paramInt, String paramString)
    throws RemoteException;
  
  public abstract boolean dameDisponibilidadBotella(int paramInt1, int paramInt2, String paramString, int paramInt3)
    throws RemoteException;
  
  public abstract double damePrecioBotella(int paramInt1, int paramInt2, int paramInt3)
    throws RemoteException;
  
  public abstract double damePrecioCopa(int paramInt1, int paramInt2)
    throws RemoteException;
  
  public abstract double dameMontoTransaccion(int paramInt)
    throws RemoteException;
  
  public abstract boolean autentificaUsuario(int paramInt1, int paramInt2)
    throws RemoteException;
  
  public abstract Vector<String> DameListadoTodos()
    throws RemoteException;
  
  public abstract String DameMeseroAsignado(int paramInt)
    throws RemoteException;
  
  public abstract Vector<String> AlmacenaComanda(int paramInt1, Vector<Object> paramVector, int paramInt2)
    throws RemoteException;
  
  public abstract Vector<String> AlmacenaComandaInterna(Vector<Object> paramVector, int paramInt)
    throws RemoteException;
  
  public abstract Vector<String> mesasLigadasA(int paramInt)
    throws RemoteException;
  
  public abstract Vector<String> dameListadoPorCombinar()
    throws RemoteException;
  
  public abstract Vector<String> dameComponentesBotana()
    throws RemoteException;
  
  public abstract int DameCantidadOriginalComensales(int paramInt)
    throws RemoteException;
  
  public abstract void ImprimeTicketTotal(int paramInt)
    throws RemoteException;
  
  public abstract void ImprimeTicketXComen(int paramInt)
    throws RemoteException;
  
  public abstract int DameCantidadTotalComensales(int paramInt)
    throws RemoteException;
  
  public abstract String dameClaveBotana()
    throws RemoteException;
  
  public abstract void actualizaAsignacionProducComen(int paramInt1, int paramInt2, int paramInt3, String paramString, int paramInt4)
    throws RemoteException;
}
