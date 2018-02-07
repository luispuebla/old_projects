package alphanet.ultra.digibar.servidor;

import java.rmi.*;
import java.util.Vector;
import javax.swing.JComboBox;
import javax.swing.DefaultListModel;
import javax.swing.table.AbstractTableModel;

/**
 * Interface:    BarServicios
 *
 * Purpose:    Se encarga de proveer y publicar las funciones remotas disponibles.
 *
 */
public interface BarServicios extends Remote {
	String DimeHola(String nombre)   throws RemoteException;
	Vector <String> EstatusMapa() throws RemoteException;
	String DameMesaMadre (String mesa) throws RemoteException;
	public Vector<String> DameListadoMeseros () throws RemoteException;
	public Vector<String> DameListadoEmpleados() throws RemoteException;
	public Vector<String> mesasParaLigar(int mesaMadre) throws RemoteException;
	public Vector<String> mesasDisponiblesTraspaso(int mesaATraspasar) throws RemoteException;
	public String ProcesaAltaMesa(int IDMesero, int comensales,int mesaID, javax.swing.DefaultListModel listaMLigadas) throws RemoteException;
	public String ProcesaModificaMesa(int IDMesero, int comensales, int mesaID, javax.swing.DefaultListModel listModel2) throws RemoteException;
	public Vector<String> listaComensales(int mesaMadre) throws RemoteException;
	public Vector<String> listaXDivision(int area) throws RemoteException;
	public AbstractTableModel listaProducto(int area, int division) throws RemoteException;
	public Vector<Object> nuevaListaProducto(Vector <Object> datos) throws RemoteException;
	public Vector<Object> nuevaListaPInterno(Vector <Object> datos) throws RemoteException;
	public AbstractTableModel ConsultaProductoComanda(int mesaID) throws RemoteException;
	public AbstractTableModel DameDesgloseXComensal(int mesaID) throws RemoteException;
	public int dameEntregaBebida (int claveProducto, int division) throws RemoteException;
	public int traspasaMesa(int IDMesa, String laMesaATraspasar) throws RemoteException;
	public boolean dameDisponibilidadBotella(int claveProducto,int division,String cantidad, int clasificacionBotella) throws RemoteException;
	public double damePrecioBotella(int claveProducto, int  division, int clasificacionBotella) throws RemoteException;
	public double damePrecioCopa(int claveProducto,int  division) throws RemoteException;
	public double dameMontoTransaccion(int mesaID) throws RemoteException;
	public boolean autentificaUsuario(int usuarioID, int contra) throws RemoteException;
	public Vector<String> DameListadoTodos() throws RemoteException;
	public String DameMeseroAsignado(int mesa) throws RemoteException;
	public Vector<String> AlmacenaComanda(int mesaID,Vector<Object>datos,int  userID) throws RemoteException;
	public Vector<String> AlmacenaComandaInterna(Vector<Object>datos, int userID) throws RemoteException;
	public Vector<String> mesasLigadasA(int mesaID) throws RemoteException;
	public Vector<String> dameListadoPorCombinar()  throws RemoteException;
	public Vector<String> dameComponentesBotana()  throws RemoteException;
	public int DameCantidadOriginalComensales(int mesaID) throws RemoteException;
	public void ImprimeTicketTotal(int mesaID) throws RemoteException;
	public void ImprimeTicketXComen(int mesaID) throws RemoteException;
	public int DameCantidadTotalComensales (int mesaID) throws RemoteException;
	public String dameClaveBotana() throws RemoteException;
 	public void actualizaAsignacionProducComen(int nuevoComensal, int mesaID, int claveProducto,String  tipo,int comensalPrevio) throws RemoteException;

}