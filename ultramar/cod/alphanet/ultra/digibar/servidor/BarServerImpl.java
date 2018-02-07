package alphanet.ultra.digibar.servidor;

import java.rmi.server.UnicastRemoteObject;
import  java.rmi.RemoteException;
import alphanet.ultra.digibar.bd.ManagerPuntoVenta;
import java.util.Vector;
import java.sql.SQLException;
import javax.swing.DefaultListModel;
import javax.swing.table.AbstractTableModel;

public class BarServerImpl extends UnicastRemoteObject   implements BarServicios {

	protected static ManagerPuntoVenta mpv = new ManagerPuntoVenta();
	private static final long serialVersionUID = 1L;
   /**
    * Constructor
   */
   public BarServerImpl()    throws RemoteException  {
      super();
   }

   public String DimeHola(String nombre)   throws RemoteException   {
	   System.out.println("Cliente solicitando informacíon");
		return "Hola "+nombre;
   }


/**
* La funcion EstatusMapa se encarga de retornar un Vector que contiene las mesas así como su Estatus (Vacio, Ocupado, Ligado).
*
* @return Vector <String> con el listado de mesas y su estatus.
*/
   public Vector <String> EstatusMapa() throws RemoteException{
	   Vector <String> mesas = new Vector<String>();
	   try{
	   		mesas = mpv.estatusMapa();
		}
		catch (SQLException sqle){
			System.out.println("Excepcion SQL: ");
			sqle.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	   return mesas;
   }


	public void ImprimeTicketTotal(int mesaID) throws RemoteException{
		try{
			mpv.ImprimeTicketTotal(mesaID);
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}

	public void ImprimeTicketXComen(int mesaID) throws RemoteException{
		try{
			mpv.ImprimeTicketxComensal(mesaID);
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}

/**
* La funcion DameMesaMadre se encarga de informar a quien se ligo la mesa seleccionada.
*
* @return String con el Identificador de la Mesa Madre.
*/
   public String DameMesaMadre(String mesa) throws RemoteException{
	   String mesaM = "";
	   try{
		   mesaM = mpv.mesaMadreLigada(mesa);
	   }
		catch (SQLException sqle){
			System.out.println("Excepcion SQL: ");
			sqle.printStackTrace();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return mesaM;
   }

/**
* La funcion DameListadoMeseros se encarga de regresar el listado de meseras(os) activos
*
* @return String con el Identificador de la Mesa Madre.
*/
   public Vector<String> DameListadoMeseros() throws RemoteException{
	   Vector <String> meseros = new Vector <String>();
	   try{
		   meseros = mpv.listadoMeseras();
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return meseros;
   }

	public Vector<String> DameListadoEmpleados() throws RemoteException{
	   Vector <String> empleados = new Vector <String>();
	   try{
		   empleados = mpv.listadoEmpleados();
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return empleados;
   }



/**
* La funcion DameListadoTodos se encarga de regresar el listado de todo el personal en activo que puede levantar comanda.
*
* @return Vector <String> con el listado correspondiente.
*/
	public Vector <String> DameListadoTodos() throws RemoteException{
		Vector<String> todos = new Vector <String>();
		try{
			todos = mpv.listadosTodosAutorizados();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return todos;
	}


	public Vector<String> mesasLigadasA(int mesaID) throws RemoteException{
		Vector <String> mesasLigadas = new Vector<String>();
		try{
			mesasLigadas = mpv.dameMesasLigadasA(mesaID);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return mesasLigadas;
	}

	public int DameCantidadOriginalComensales(int mesaID) throws RemoteException{
		int cantComensales = -1;
		try{
			cantComensales = mpv.dameComensalesPorMesa(mesaID);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return cantComensales;
	}

	public Vector<String> mesasDisponiblesTraspaso(int mesaATraspasar) throws RemoteException{
	   Vector <String> mesasDisponiblesT = new Vector <String>();
	   try{
		   mesasDisponiblesT = mpv.mesasDisponiblesTraspaso(mesaATraspasar);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return mesasDisponiblesT;
	}

/**
* La funcion mesasParaLigar se encarga de regresar el listado de mesas libres para ser Ligadas.
*
* @return String con el Identificador de la Mesa Madre.
*/
   public Vector<String> mesasParaLigar(int mesaMadre) throws RemoteException{
	   Vector <String> mesasLibres = new Vector <String>();
	   try{
		   mesasLibres = mpv.mesasDisponiblesLiga(mesaMadre);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return mesasLibres;
   }

	public String ProcesaModificaMesa(int IDMesero, int comensales, int  mesaID, javax.swing.DefaultListModel listaMLigadas) throws RemoteException{
		String resultado = "";
		try{
		   resultado = mpv.modificaMesa(IDMesero, comensales, mesaID,  listaMLigadas);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return resultado;
	}


/**
* La funcion ProcesaAltaMesa se encarga de realizar el proceso de Alta de Mesa.
*
* @return String con el Identificador de la Mesa Madre.
*/
	public String ProcesaAltaMesa(int IDMesero, int comensales,int mesaID, javax.swing.DefaultListModel listaMLigadas) throws RemoteException{
	   String resultado = "";
	   try{
		   resultado = mpv.altaDeMesa(IDMesero, comensales, mesaID,  listaMLigadas);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return resultado;
   }


/**
* El método listaComensales se encarga de regresar el listado de comensales para una mesa.
*
* @return Vector <String> con el listado correspondiente de comensales.
*/
   public Vector<String> listaComensales(int mesaMadre) throws RemoteException{
	   Vector <String> listadoComensales = new Vector <String>();
	   try{
		   listadoComensales = mpv.comensalesDesglosados(mesaMadre);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return listadoComensales;
   }

/**
* El método listaComensales se encarga de regresar el listado de comensales para una mesa.
*
* @return Vector <String> con el listado correspondiente de comensales.
*/
   public Vector<String> listaXDivision(int area) throws RemoteException{
	   Vector <String> listadoXDivision = new Vector <String>();
	   try{
		   listadoXDivision = mpv.divisionesDisponibles(area);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return listadoXDivision;
   }



/**
* El método listaProducto se encarga de regresar el listado de productos ya sean bebidas o alimentos y que pertenezcan a una division en especifico..
*
* @return AbstractTableModel con el listado correspondiente de productos.
*/
	public AbstractTableModel listaProducto(int area, int division) throws RemoteException{
		AbstractTableModel am = null;
		try{
			am = mpv.dameModeloProductos(area, division);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}


	public int traspasaMesa(int IDMesa, String laMesaATraspasar) throws RemoteException{
	int resultado = -1;
		try{
			resultado = mpv.traspasaMesaA(IDMesa, laMesaATraspasar);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return resultado;
	}


	public Vector<String> dameListadoPorCombinar()  throws RemoteException{
	Vector <String> am = null;
		try{
			am = mpv.dameListaParaCombinar();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}



	public Vector<String> dameComponentesBotana()  throws RemoteException{
	Vector <String> am = null;
		try{
			am = mpv.dameListaComponeBotana();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}


	public String dameClaveBotana() throws RemoteException{
		String claveBotana = "";
		try{
			claveBotana = mpv.dameLaClaveDeBotana();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return claveBotana;

	}





public Vector<Object> nuevaListaPInterno(Vector <Object> datos) throws RemoteException{
	Vector <Object> am = null;
		try{
			am = mpv.dameModeloEspecialInterno(datos);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}


public Vector<Object> nuevaListaProducto(Vector <Object> datos) throws RemoteException{
	Vector <Object> am = null;
		try{
			am = mpv.dameModeloEspecialBebidas(datos);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}

/**
* El método ConsultaProductoComanda se encarga de generar la tabla de consulta de productos por mesa
*
* @return AbstractTableModel con el listado correspondiente de productos.
*/
	public AbstractTableModel ConsultaProductoComanda(int mesaID) throws RemoteException{
		AbstractTableModel am = null;
		try{
			am = mpv.consultaComandaMTM(mesaID);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}

	public AbstractTableModel DameDesgloseXComensal(int mesaID) throws RemoteException{
		AbstractTableModel am = null;
		try{
			am = mpv.comandaDesglosXComensal(mesaID);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return am;
	}



 	public void actualizaAsignacionProducComen(int nuevoComensal, int mesaID, int claveProducto,String  tipo,int comensalPrevio) throws RemoteException{
	   try{
		  mpv.modificaComensalAsignado(nuevoComensal, mesaID, claveProducto, tipo, comensalPrevio);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
	}


	public int DameCantidadTotalComensales (int mesaID) throws RemoteException{
	  int maxComensales = -1;
	   try{
		   maxComensales = mpv.dameComensalesPorMesa(mesaID);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return maxComensales;
	}

/**
* El método listaComensales se encarga de regresar el listado de comensales para una mesa.
*
* @return Vector <String> con el listado correspondiente de comensales.
*/
   public int dameEntregaBebida (int claveProducto, int division) throws RemoteException{
	  int tipoEnvase = -1;
	   try{
		   tipoEnvase = mpv.dameClasificacionBotella(claveProducto, division);
	   }
		catch(Exception e){
			e.printStackTrace();
		}
		return tipoEnvase;
   }

/**
* El método dameDisponibilidadBotella se encarga de informar si existe en inventario la cantidad de botella solicitada.
*
* @return boolean True si hay en Existencia, False si no se acompleta.
*/
	public boolean dameDisponibilidadBotella(int claveProducto,int division,String cantidad,  int clasificacionBotella) throws RemoteException{
		boolean existencia = false;
		try{
			existencia = mpv.existeDisponibilidadBotella(claveProducto, division, cantidad, clasificacionBotella);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return existencia;
	}

/**
* El método damePrecioBotella se encarga de informarnos sobre el precio que corresponde a una botella.
*
* @return double el precio de la botella
*/
	public double damePrecioBotella(int claveProducto,int  division, int clasificacionBotella) throws RemoteException {
		double precioBotella = 0.00;
		try{
			precioBotella = mpv.recuperaPrecioXBotella(claveProducto, division, clasificacionBotella);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return precioBotella;
	}


/**
* El método damePrecioCopa se encarga de informarnos sobre el precio que corresponde a una copa.
*
* @return double el precio de la copa
*/
	public double damePrecioCopa(int claveProducto,int  division) throws RemoteException {
		double precioCopa = 0.00;
		try{
			precioCopa = mpv.recuperaPrecioXCopa(claveProducto, division);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return precioCopa;
	}


	public double dameMontoTransaccion(int mesaID) throws RemoteException{
		double montoTotal = 0.00;
		try{
			montoTotal = mpv.dameMontoTotal(mesaID);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return montoTotal;
	}


/**
* El método autentificaUsuario se encarga de informarnos sobre el precio que corresponde a una copa.
*
* @return boolean con el resultado de verificar la contraseña del usuario que da de alta la comanda.
*/
	public boolean autentificaUsuario(int usuarioID, int contra) throws RemoteException {
		boolean resultado = false;
		try{
			resultado = mpv.verificaIdentidad(usuarioID, contra);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return resultado;
	}

/**
* El método DameMeseroAsignado se encarga de informarnos sobre al mesero a quien fue asignada la mesa originalmente
*
* @return int El Identificador del mesero asignado.
*/
	public String  DameMeseroAsignado(int mesa) throws RemoteException{
		String IDMesero = "";
		try{
			IDMesero = mpv.dameMeseroAsignado(mesa);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return IDMesero;
	}


	public Vector<String> AlmacenaComandaInterna(Vector<Object>datos, int userID) throws RemoteException{
		Vector<String> incidencias = new Vector<String>();
		try{
			incidencias = mpv.almacenaComandaInterna(datos, userID);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return incidencias;
	}

/**
* El método AlmacenaComanda se encarga de guardar a la cuenta de una mesa su estado y regresarnos el estado del almacenamiento.
*
* @return Vector<String> con el resultado.
*/
	public Vector<String> AlmacenaComanda(int mesaID,Vector<Object>datos,int  userID) throws RemoteException{
		Vector<String> incidencias = new Vector<String>();
		try{
			incidencias = mpv.almacenaComanda(mesaID, datos, userID);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return incidencias;
	}


}