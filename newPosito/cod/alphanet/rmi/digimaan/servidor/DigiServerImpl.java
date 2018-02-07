package alphanet.rmi.digimaan.servidor;

import java.rmi.server.UnicastRemoteObject;
import  java.rmi.RemoteException;
import alphanet.rmi.digimaan.bd.ManagerPuntoVenta;
import java.util.Vector;
import java.sql.SQLException;
import javax.swing.DefaultListModel;
import javax.swing.table.AbstractTableModel;

public class DigiServerImpl extends UnicastRemoteObject   implements DigiServicios {

	protected static ManagerPuntoVenta mpv = new ManagerPuntoVenta();
	private static final long serialVersionUID = 1L;
   /**
    * Constructor
   */
   public DigiServerImpl()    throws RemoteException  {
      super();
   }


//NUEVOS

	// Me dice si la clave que introdujeron si corresponde a un producto registrado
	public boolean existeProducto(String claveProducto) throws RemoteException{
		boolean existe = false;
		try{
			existe = mpv.existeProducto(claveProducto);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return existe;
	}

	// Checo si el ticket que desean modificar es candidato.
	public boolean ticketCandidato(int claveTicket) throws RemoteException{
		boolean aceptado = false;
		try{
			aceptado = mpv.ticketCandidato(claveTicket);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return aceptado;
	}

	// Verifica que haya en existencia del producto solicitado.
	public boolean hayProducto(String claveProducto) throws RemoteException{
		boolean hay = false;
		try{
			hay = mpv.hayProducto(claveProducto);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return hay;
	}

	public boolean existeEnAlmacen(String claveProducto) throws RemoteException{
		boolean hay = false;
		try{
			hay = mpv.existeEnAlmacen(claveProducto);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return hay;
	}


	// Me regresa la clave de producto ligada a un codigo de barras.
	public String dameClaveCorrespondiente(String codigoBarras) throws RemoteException{
		String laClave = "";
		try{
			laClave = mpv.dameClaveCorrespondiente(codigoBarras);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return laClave;
	}


	public String damePrecioMinimo(String tipoEntrada, String claveProducto)throws RemoteException{
		String precioMinimo = "0.00";
		try{
			precioMinimo = mpv.damePrecioMinimo(tipoEntrada, claveProducto);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return precioMinimo;
	}

	public String damePrecio(String precioBuscado, String claveProducto)throws RemoteException{
		String precio = "0.00";
		try{
			precio = mpv.damePrecio(precioBuscado, claveProducto);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return precio;
	}






	// Me regresa el tipo de producto: // 1 Solo Kg,  2 Solo pieza,  3 Pieza y Caja.
	public int dameTipoProducto(String claveProducto)throws RemoteException{
		int tipo=0;
		try{
			tipo = mpv.dameTipoProducto(claveProducto);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return tipo;
	}

	 // Regresa el Manejo de precio de venta registrado para este producto:  1 Solo Base,  2 Grupo,  3 Escalon.
	public int dameManejoPrecio(String claveProducto) throws RemoteException{
		int manejo=0;
		try{
			manejo = mpv.dameManejoPrecio(claveProducto);
		}
		catch (Exception ex){
			ex.printStackTrace();
		}
		return manejo;
	}


	public String dameNombreProducto(String claveProducto) throws RemoteException{
		String nombreP = "";
		try{
			nombreP = mpv.dameNombreProducto(claveProducto);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return nombreP;
	}

	public Vector<String> dameListadoClientes( )  throws RemoteException{
		Vector <String> losClientes = new Vector <String>();
		try{
			losClientes = mpv.dameListadoClientes( );
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return losClientes;
	}

	public  Vector <String> damePrecioYExsitenciaXKilo(String claveProducto, int formatoPrecio) throws RemoteException{
		Vector <String> datosXKg = new Vector <String>();
		try{
			datosXKg = mpv.damePrecioYExsitenciaXKilo(claveProducto, formatoPrecio);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return datosXKg;
	}

	public String dameExistenciaXKilo(String claveProducto) throws RemoteException{
		String existenciaKilo = new String("0.00");
		try{
			existenciaKilo = mpv.dameExistenciaXKilo(claveProducto);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return existenciaKilo;
	}

	public Vector <String> damePrecioYExsitenciaXUni(String claveProducto, int formatoPrecio) throws RemoteException{
		Vector <String> datosXUni = new Vector <String>();
		try{
			datosXUni = mpv.damePrecioYExsitenciaXUni(claveProducto, formatoPrecio);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return datosXUni;
	}

	public String dameExistenciaXUni(String claveProducto) throws RemoteException{
		String existenciaUni = new String("0");
		try{
			existenciaUni = mpv.dameExistenciaXUni(claveProducto);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return existenciaUni;
	}

	public Vector <String> damePrecioYExsitenciaXCj(String claveProducto, int formatoPrecio) throws RemoteException{
		Vector <String> datosXCj = new Vector <String>();
		try{
			datosXCj = mpv.damePrecioYExsitenciaXCj(claveProducto, formatoPrecio);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return datosXCj;
	}

	public Vector <String>  dameExistenciaXCaja(String claveProducto) throws RemoteException{
		Vector <String> existenciaCaja = new Vector <String>();
		try{
			existenciaCaja = mpv.dameExistenciaXCaja(claveProducto);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return existenciaCaja;
	}


	public Vector <String> damePrecioYExsitenciaXPz(String claveProducto, int formatoPrecio) throws RemoteException{
		Vector <String> datosXPz = new Vector <String>();
		try{
			datosXPz = mpv.damePrecioYExsitenciaXPz(claveProducto, formatoPrecio);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return datosXPz;
	}

	public Vector <String> dameExistenciaXPz(String claveProducto) throws RemoteException{
		Vector <String> datosXPz = new Vector <String>();
		try{
			datosXPz = mpv.dameExistenciaXPz(claveProducto);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return datosXPz;
	}


	public boolean verificaAutorizacion(int claveAutoriza,  int tipoSolicitado)throws RemoteException{
		boolean acceso = false;
		try{
			acceso = mpv.verificaAutorizacion(claveAutoriza, tipoSolicitado);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return acceso;
	}

	public Vector <String> listadoEscalon(String claveProducto) throws RemoteException{
		Vector <String> listado = new Vector <String>();
		try{
			listado = mpv.listadoEscalon(claveProducto);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return listado;
	}

	public double cambiaPrecioEscalon(String cantidadDeProducto, String claveProducto)throws RemoteException{
		Double nuevoPrecio = 0.00;
		try{
			nuevoPrecio = mpv.cambiaPrecioEscalon(cantidadDeProducto, claveProducto);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return nuevoPrecio;
	}

	public boolean existeUsuario(int claveVendedor) throws RemoteException{
		boolean existencia = false;
		try{
			existencia = mpv.existeUsuario(claveVendedor);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return existencia;
	}


	public boolean guardaProducto(String claveProducto, int tipoUnidad, int tipoPrecio, String precio, String cantidad, double pPiezaKg, String importe, int claveU) throws RemoteException{
		boolean exito = false;
		try{
			exito = mpv.guardaProducto(claveProducto, tipoUnidad, tipoPrecio, precio, cantidad, pPiezaKg, importe, claveU);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return exito;
	}

	public int eliminaCuenta(int claveVendedor) throws RemoteException{
		int regreso = 0;
		try{
			regreso = mpv.eliminaCuenta(claveVendedor);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return regreso;
	}


	public AbstractTableModel tablaListadoBusqueda(String criterio) throws RemoteException{
		AbstractTableModel am = null;
		try{
			am = mpv.tablaListadoBusqueda(criterio);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}

	public int existeCuenta(int claveVendedor) throws RemoteException{
		int regreso = 0;
		try{
			regreso = mpv.existeCuenta(claveVendedor);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return regreso;
	}

	public Vector <String> dameProductoEliminado(int claveTicket) throws RemoteException{
		Vector <String> listado = new Vector <String>();
		try{
			listado = mpv.dameProductoEliminado(claveTicket);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return listado;
	}


	public boolean existenProductosEnLista(int claveTicket) throws RemoteException{
		boolean existencia = false;
		try{
			existencia = mpv.existenProductosEnLista(claveTicket);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return existencia;
	}

	public boolean existenProductosEnListaR(int claveTicket) throws RemoteException{
		boolean existencia = false;
		try{
			existencia = mpv.existenProductosEnListaR(claveTicket);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return existencia;
	}

	public AbstractTableModel tablaListadoPrevio(int claveTicket) throws RemoteException{
		AbstractTableModel am = null;
		try{
			am = mpv.tablaListadoPrevio(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}


	public AbstractTableModel tablaListadoPrevioR(int claveTicket) throws RemoteException{
		AbstractTableModel am = null;
		try{
			am = mpv.tablaListadoPrevioR(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}

	public String damePropietario(int claveTicket)throws RemoteException{
		String rfc = "";
		try{
			rfc = mpv.damePropietario(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return rfc;
	}

	public String cantidadProductos(int claveTicket) throws RemoteException{
		String cantidad = "0";
		try{
			cantidad = mpv.cantidadProductos(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return cantidad;
	}

	public String cantidadProductosR(int claveTicket) throws RemoteException{
		String cantidad = "0";
		try{
			cantidad = mpv.cantidadProductosR(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return cantidad;
	}

	public String sumaPagoProductos(int claveTicket) throws RemoteException{
		String total = "0.00";
		try{
			total = mpv.sumaPagoProductos(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return total;
	}

	public String sumaPagoProductosR(int claveTicket) throws RemoteException{
		String total = "0.00";
		try{
			total = mpv.sumaPagoProductosR(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return total;
	}

	public boolean eliminaProducto(int claveTicket, int id1, String id2, String id3) throws RemoteException{
		boolean exito = false;
		try{
			exito = mpv.eliminaProducto(claveTicket,id1, id2, id3);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return exito;
	}

	public boolean cierraCuenta(int claveTicket, String rfc, String nombreCliente, int claveVendedor) throws RemoteException{
		boolean cierre = false;
		try{
			cierre = mpv.cierraCuenta(claveTicket, rfc, nombreCliente, claveVendedor);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return cierre;
	}

	public boolean dameAutorizacionUser(int claveDelUsuario) throws RemoteException{
		boolean autorizado = false;
		try{
			autorizado = mpv.dameAutorizacionUser(claveDelUsuario);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return autorizado;
	}

	public void ImprimeTicketACobrar(int claveTicket, String identificador, int claveU) throws RemoteException{
		try{
			mpv.ImprimeTicketACobrar(claveTicket, identificador, claveU);
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}


	public void ImprimeTicketACobrarRem(int claveTicket, String identificador, int claveU) throws RemoteException{
		try{
			mpv.ImprimeTicketACobrarRem(claveTicket, identificador, claveU);
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}

	public String dameNombreVendedor(int claveUsuario) throws RemoteException{
		String nombre = "";
		try{
			nombre = mpv.dameNombreVendedor(claveUsuario);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return nombre;
	}

	public boolean confirmaContra(String contraDelUsuario, int claveU) throws RemoteException{
		boolean concuerda = false;
		try{
			concuerda = mpv.confirmaContra(contraDelUsuario, claveU);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return concuerda;
	}


	public String sumaPagoProductosFin(int claveTicket) throws RemoteException{
		String monto = "0.00";
		try{
			monto = mpv.sumaPagoProductosFin(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return monto;
	}

	public Vector<String> procesaPagoDescuento(int claveTicket, int claveU)  throws RemoteException{
		Vector <String> exito = new Vector <String>();
		try{
			exito = mpv.procesaPagoDescuento(claveTicket, claveU);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return exito;
	}

	public void ImprimeTicketDirecto(int claveTicket, String identificador, int claveU, String elPago,String elCambio)  throws RemoteException{
		try{
			mpv.ImprimeTicketDirecto(claveTicket, identificador, claveU, elPago, elCambio);
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}

	public int dameTicketRePrint(int claveU)  throws RemoteException{
		int resultado = 0;
		try{
			resultado = mpv.dameTicketRePrint(claveU);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return resultado;
	}

	public int modificaContenido(int ID_Pro, String cantidad, double nuevaCantidad, String unidadP, String tipoPre, int claveTicket, double pesoDePiezas) throws RemoteException{
		int resultado = 0;
		try{
			resultado = mpv.modificaContenido(ID_Pro, cantidad, nuevaCantidad, unidadP, tipoPre, claveTicket, pesoDePiezas);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return resultado;
	}

	public boolean modificaCuenta(int claveTicket, String rfc, String nombreCliente)throws RemoteException{
		boolean finalizado = false;
		try{
			finalizado = mpv.modificaCuenta(claveTicket, rfc, nombreCliente);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return finalizado;
	}

	public boolean reingresaInventario(int claveTicket)throws RemoteException{
		boolean exito = false;
		try{
			exito = mpv.reingresaInventario(claveTicket);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return exito;
	}

}