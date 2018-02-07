package alphanet.rmi.digimaan.servidor;

import java.rmi.*;
import java.util.Vector;
import javax.swing.JComboBox;
import javax.swing.DefaultListModel;
import javax.swing.table.AbstractTableModel;

/**
 * Interface:    DigiServicios
 *
 * Purpose:    Se encarga de proveer y publicar las funciones remotas disponibles.
 *
 */
public interface DigiServicios extends Remote {
// NUEVOS
	public boolean existeProducto(String claveProducto) throws RemoteException;
	public boolean hayProducto(String claveProducto) throws RemoteException;
	public boolean existeEnAlmacen(String claveProducto) throws RemoteException;
	public String dameClaveCorrespondiente(String codigoBarras) throws RemoteException;
	public int dameTipoProducto(String claveProducto) throws RemoteException;
	public int dameManejoPrecio(String claveProducto) throws RemoteException;
	public String dameNombreProducto(String claveProducto) throws RemoteException;
	public String damePrecioMinimo(String tipoEntrada, String claveProducto)throws RemoteException;
	public String damePrecio(String precioBuscado, String claveProducto)throws RemoteException;
	public Vector <String> damePrecioYExsitenciaXKilo(String claveProducto, int formatoPrecio) throws RemoteException;
	public String dameExistenciaXKilo(String claveProducto) throws RemoteException;
	public Vector <String> damePrecioYExsitenciaXUni(String claveProducto, int formatoPrecio) throws RemoteException;
	public String dameExistenciaXUni(String claveProducto) throws RemoteException;
	public Vector <String> damePrecioYExsitenciaXPz(String claveProducto, int formatoPrecio) throws RemoteException;
	public Vector <String> dameExistenciaXPz(String claveProducto) throws RemoteException;
	public Vector <String> damePrecioYExsitenciaXCj(String claveProducto, int formatoPrecio) throws RemoteException;
	public Vector <String> dameExistenciaXCaja(String claveProducto) throws RemoteException;
	public boolean verificaAutorizacion(int claveAutoriza, int tipoSolicitado)throws RemoteException;
	public Vector <String> listadoEscalon(String claveProducto) throws RemoteException;
	public double cambiaPrecioEscalon(String cantidadDeProducto, String claveProducto)throws RemoteException;
	public boolean existeUsuario(int claveVendedor) throws RemoteException;
	public boolean guardaProducto(String claveProducto, int tipoUnidad, int tipoPrecio, String precio, String cantidad, double pPiezaKg, String importe, int claveU) throws RemoteException;
	public int eliminaCuenta(int claveVendedor) throws RemoteException;
	public AbstractTableModel tablaListadoBusqueda(String criterio) throws RemoteException;
	public int existeCuenta(int claveVendedor) throws RemoteException;
	public Vector <String> dameProductoEliminado(int claveTicket) throws RemoteException;
	public boolean existenProductosEnLista(int claveTicket) throws RemoteException;
	public boolean existenProductosEnListaR(int claveTicket) throws RemoteException;
	public String damePropietario(int claveTicket)throws RemoteException;
	public AbstractTableModel tablaListadoPrevio(int claveTicket) throws RemoteException;
	public AbstractTableModel tablaListadoPrevioR(int claveTicket) throws RemoteException;
	public String cantidadProductos(int claveTicket) throws RemoteException;
	public String cantidadProductosR(int claveTicket) throws RemoteException;
	public String sumaPagoProductos(int claveTicket) throws RemoteException;
	public String sumaPagoProductosR(int claveTicket) throws RemoteException;
	public String sumaPagoProductosFin(int claveTicket) throws RemoteException;
	public boolean eliminaProducto(int claveTicket, int id1, String id2, String id3) throws RemoteException;
	public boolean cierraCuenta(int claveTicket, String rfc, String nombreCliente, int claveVendedor) throws RemoteException;
	public boolean modificaCuenta(int claveTicket, String rfc, String nombreCliente)throws RemoteException;
	public boolean reingresaInventario(int claveTicket)throws RemoteException;
	public boolean dameAutorizacionUser(int claveDelUsuario) throws RemoteException;
	public int modificaContenido(int ID_Pro, String cantidad, double nuevaCantidad, String unidadP, String tipoPre, int claveTicket, double pesoDePiezas) throws RemoteException;
	public void ImprimeTicketACobrar(int claveTicket, String identificador, int claveU) throws RemoteException;
	public void ImprimeTicketACobrarRem(int claveTicket, String identificador, int claveU) throws RemoteException;
	public String dameNombreVendedor(int claveUsuario) throws RemoteException;
	public boolean confirmaContra(String contraDelUsuario, int claveU) throws RemoteException;
	public boolean ticketCandidato(int claveTicket) throws RemoteException;
	public Vector<String> procesaPagoDescuento(int claveTicket, int claveU)  throws RemoteException;
	public Vector<String> dameListadoClientes( )  throws RemoteException;
	public void ImprimeTicketDirecto(int claveTicket, String identificador, int claveU, String elPago,String elCambio)  throws RemoteException;
	public int dameTicketRePrint(int claveU)  throws RemoteException;
}
