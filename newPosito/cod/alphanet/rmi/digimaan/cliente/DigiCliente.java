package alphanet.rmi.digimaan.cliente;

import java.net.MalformedURLException;
import java.rmi.*;
import java.rmi.server.*;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.servidor.DigiServicios;
import java.util.Vector;
import java.util.Properties;
import java.io.IOException;
import java.io.FileInputStream;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.KeyListener;
import java.awt.event.KeyEvent;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JInternalFrame;
import javax.swing.JOptionPane;
import javax.swing.JDesktopPane;
import javax.swing.JFrame;
import java.net.URL;
import java.io.InputStream;
import java.io.IOException;
import java.util.TooManyListenersException;
import javax.comm.CommPortIdentifier;
import javax.comm.SerialPort;
import javax.comm.SerialPortEventListener;
import javax.comm.NoSuchPortException;
import javax.comm.PortInUseException;
import javax.comm.SerialPortEvent;
import java.awt.MediaTracker;


public class DigiCliente extends JFrame implements Runnable  {


	// Variables Interfaz (Swing):
	protected JDesktopPane desktop;
	protected JTextField jftClave;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	private JLabel jlBorrar, jlCancela, jlRecicla, jlCerrar, jlTipoP, jlBusqueda, jlImprime, jlEnvia;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonRecN, iiBotonRecP, iiBotonCerN, iiBotonCerP, iiBotonTipN , iiBotonTipP, iiBotonBusN, iiBotonBusP, iiBotonEnvN,iiBotonEnvP,iiNoConnect, iiImprimeN, iiImprimeP;
	private Image imagen, icon;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private URL url;
	private JLabel  jlNoConnect;
	// Nuevas variables por escanner
	protected Thread tLectura, tInterno;
	protected boolean exitoComunicacion = true;
	boolean existencia = false;
    protected  CommPortIdentifier idPuerto;
    protected SerialPort puertoSerial;
    protected  InputStream entrada;
	protected boolean paroCom = false;
	protected boolean entradaParcial = false;
	protected	StringBuilder sb = new StringBuilder();
	protected int semaforoEscanner = 0; // 0 --> Procesando, 1 --> Comunicacion OK!,  2--> fallo Escanner;
	protected boolean conexionPerdida = false;
	// Variables de Aplicacion
	protected static DigiCliente digiCliente;
	private Sound son;
	protected int tipoPrecio = 0; // 0-> Normal, 1--> GP1, 2--> GP2, 3--> GP3, 4--> GP4,  5--> GP5, 6--> GP6,  7--> Escalon
	protected String claveDeProducto = "";
   	protected static Properties config;
	protected String puertoDeEscanner = "COM1";
	boolean cantidadPositiva = false;
	boolean hayEnAlmacen = false;
	protected boolean arranqueSinEscanner = false;
	// Variables RMI
	private String HOST_NAME = "";
	private int PORT = 0;
	public boolean cargaConfiguracion = true;
	protected DigiServicios bs ;
	private static final long serialVersionUID = 1L;


	public DigiCliente() throws RemoteException, MalformedURLException, NotBoundException, Exception {
		super("Sistema Administrativo DIGIMAAN -- DigiCliente");
	}

	public void levantaServicioRMI() throws RemoteException, MalformedURLException, NotBoundException, Exception {
		try{
			String conf = "Client.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			HOST_NAME=config.getProperty("server.host");
			PORT= Integer.parseInt(config.getProperty("server.port").trim());
			puertoDeEscanner =config.getProperty("client.port");
		}
		catch(IOException ioe){
			cargaConfiguracion = false;
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			cargaConfiguracion = false;
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		// Si obtuve mis datos cargo la configuracion y arranco hilo de lectura
		if(cargaConfiguracion){
			try{
				bs = (DigiServicios)Naming.lookup("rmi://"+HOST_NAME+":"+Integer.toString(PORT)+"/DigiServicios");
			}
			catch (ConnectException ce) {
				System.out.println("No hubo conexion con el Servidor...");
				cargaConfiguracion = false;
			}
		}
	}

	public void despliegaInterfaz() throws Exception{
		url= getClass().getResource("/imas/MiniIco.jpg");
		Image icon = Toolkit.getDefaultToolkit().getImage(url);
	    this.setIconImage(icon);
		son = new Sound();
		setBounds(0,0, 860, 690);
		setResizable(false);
		letra=new Font("Eras Demin ITC",Font.BOLD,32);
		url= getClass().getResource("/imas/botones/UnoN.jpg");
		iiBoton1N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/UnoP.jpg");
		iiBoton1P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/DosN.jpg");
		iiBoton2N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/DosP.jpg");
		iiBoton2P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/TresN.jpg");
		iiBoton3N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/TresP.jpg");
		iiBoton3P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CuatroN.jpg");
		iiBoton4N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CuatroP.jpg");
		iiBoton4P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CincoN.jpg");
		iiBoton5N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CincoP.jpg");
		iiBoton5P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SeisN.jpg");
		iiBoton6N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SeisP.jpg");
		iiBoton6P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SieteN.jpg");
		iiBoton7N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SieteP.jpg");
		iiBoton7P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/OchoN.jpg");
		iiBoton8N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/OchoP.jpg");
		iiBoton8P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/NueveN.jpg");
		iiBoton9N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/NueveP.jpg");
		iiBoton9P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CeroN.jpg");
		iiBoton0N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CeroP.jpg");
		iiBoton0P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarN.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarN.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ReciclaN.jpg");
		iiBotonRecN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ReciclaP.jpg");
		iiBotonRecP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CerrarN.jpg");
		iiBotonCerN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CerrarP.jpg");
		iiBotonCerP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/PreciosN.jpg");
		iiBotonTipN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/PreciosP.jpg");
		iiBotonTipP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BuscarN.jpg");
		iiBotonBusN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BuscarP.jpg");
		iiBotonBusP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ReImprimeN.jpg");
		iiImprimeN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ReImprimeP.jpg");
		iiImprimeP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EnviarN.jpg");
		iiBotonEnvN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EnviarP.jpg");
		iiBotonEnvP = new ImageIcon(url);
		url= getClass().getResource("/imas/avisoNoConexion.jpg");
		iiNoConnect = new ImageIcon(url);
		url= getClass().getResource("/imas/fondoCliente.jpg");
		MediaTracker mt = new MediaTracker (this);
		imagen = Toolkit.getDefaultToolkit().getImage(url);
		mt.addImage (imagen, 0);
		try {
			mt.waitForID (0);
		}
		catch (InterruptedException e) {
		}
		// Este lo meto para que me despliegue el fondo.., realmente no es necesario.
		ImageIcon pruebaFondoIcon = new ImageIcon(url);
		jftClave = new JTextField(30); //(creaFormato("########"));
		jftClave.setHorizontalAlignment(JTextField.RIGHT);
		jftClave.setFont(letra);
		jftClave.setBounds(390,110,250,60);
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(450,210,70,70);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(560,210,70,70);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(670,210,70,70);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(450,310,70,70);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(560,310,70,70);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(670,310,70,70);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(450,410,70,70);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(560,410,70,70);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(670,410,70,70);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(450,510,70,70);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(670,109,70,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlRecicla= new JLabel(iiBotonRecN);
		jlRecicla.setBounds(237,109,116,74);
		jlRecicla.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(120,109,116,74);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		jlCerrar= new JLabel(iiBotonCerN);
		jlCerrar.setBounds(120,210,233,74);
		jlCerrar.addMouseListener(new mouseComportamientoLabels());
		jlTipoP= new JLabel(iiBotonTipN);
		jlTipoP.setBounds(120,310,233,74);
		jlTipoP.addMouseListener(new mouseComportamientoLabels());
		jlBusqueda= new JLabel(iiBotonBusN);
		jlBusqueda.setBounds(120,510,233,74);
		jlBusqueda.addMouseListener(new mouseComportamientoLabels());
		jlImprime= new JLabel(iiImprimeN);
		jlImprime.setBounds(120,410,233,74);
		jlImprime.addMouseListener(new mouseComportamientoLabels());
		jlEnvia= new JLabel(iiBotonEnvN);
		jlEnvia.setBounds(560,510,175,70);
		jlEnvia.addMouseListener(new mouseComportamientoLabels());
		jlNoConnect = new JLabel (iiNoConnect);
		jlNoConnect.setBounds(93,120,674,433);
		desktop = new JDesktopPane(); //a specialized layered pane
		setContentPane(desktop);
		setLocationRelativeTo(null);
		desktop.setDragMode(JDesktopPane.OUTLINE_DRAG_MODE);
		loadBackgroundImage(pruebaFondoIcon);
		desktop.add(jlBoton1,1);
		desktop.add(jlBoton2,1);
		desktop.add(jlBoton3,1);
		desktop.add(jlBoton4,1);
		desktop.add(jlBoton5,1);
		desktop.add(jlBoton6,1);
		desktop.add(jlBoton7,1);
		desktop.add(jlBoton8,1);
		desktop.add(jlBoton9,1);
		desktop.add(jlBoton0,1);
		desktop.add(jlBorrar,1);
		desktop.add(jlRecicla,1);
		desktop.add(jlCancela,1);
		desktop.add(jlCerrar,1);
		desktop.add(jlTipoP,1);
		desktop.add(jlBusqueda,1);
		desktop.add(jlImprime,1);
		desktop.add(jlEnvia,1);
		desktop.add(jftClave,1);
		jftClave.requestFocus();
		jftClave.setEditable(false);
	}

	public void notificaPerdidaConexion() throws Exception{
		if(!conexionPerdida){
			conexionPerdida = true;
			jlCancela.setVisible(false);
			jlRecicla.setVisible(false);
			jlCerrar.setVisible(false);
			jlTipoP.setVisible(false);
			jlBusqueda.setVisible(false);
			jlImprime.setVisible(false);
			jlEnvia.setVisible(false);
			jlBoton1.setVisible(false);
			jlBoton2.setVisible(false);
			jlBoton3.setVisible(false);
			jlBoton4.setVisible(false);
			jlBoton5.setVisible(false);
			jlBoton6.setVisible(false);
			jlBoton7.setVisible(false);
			jlBoton8.setVisible(false);
			jlBoton9.setVisible(false);
			jlBoton0.setVisible(false);
			jlBorrar.setVisible(false);
			jlCancela.removeMouseListener(new mouseComportamientoLabels());
			jlRecicla.removeMouseListener(new mouseComportamientoLabels());
			jlCerrar.removeMouseListener(new mouseComportamientoLabels());
			jlTipoP.removeMouseListener(new mouseComportamientoLabels());
			jlBusqueda.removeMouseListener(new mouseComportamientoLabels());
			jlImprime.removeMouseListener(new mouseComportamientoLabels());
			jlEnvia.removeMouseListener(new mouseComportamientoLabels());
			jlBoton1.removeMouseListener(new mouseComportamientoLabels());
			jlBoton2.removeMouseListener(new mouseComportamientoLabels());
			jlBoton3.removeMouseListener(new mouseComportamientoLabels());
			jlBoton4.removeMouseListener(new mouseComportamientoLabels());
			jlBoton5.removeMouseListener(new mouseComportamientoLabels());
			jlBoton6.removeMouseListener(new mouseComportamientoLabels());
			jlBoton7.removeMouseListener(new mouseComportamientoLabels());
			jlBoton8.removeMouseListener(new mouseComportamientoLabels());
			jlBoton9.removeMouseListener(new mouseComportamientoLabels());
			jlBoton0.removeMouseListener(new mouseComportamientoLabels());
			jlBorrar.removeMouseListener(new mouseComportamientoLabels());
			desktop.add(jlNoConnect,0);
		}
	}


	protected void avisoNoEscanner() throws Exception{
		JOptionPane.showInternalMessageDialog(desktop, "¡No se logro la comunicacón con el escanner, \n verifique los cables y que este prendido el dispositivo!");
		jftClave.setText("");
	}


// Here we load a background image for our desktop.
  protected void loadBackgroundImage( ImageIcon icon) {
    JLabel l = new JLabel(icon);
    l.setBounds(0, 0, icon.getIconWidth(), icon.getIconHeight());
    // Place the image in the lowest possible layer so nothing
    // can ever be painted under it.
    desktop.add(l, new Integer(Integer.MIN_VALUE));
  }



	public static void main (String [] args) throws Exception{
		DigiCliente digiCliente = new DigiCliente();
		try{
			digiCliente.despliegaInterfaz();
			digiCliente.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	        //Display the window.
	        digiCliente.setVisible(true);
	        digiCliente.levantaServicioRMI();
	        if(digiCliente.cargaConfiguracion){ // Si hay comunicacion RMI levanto servicio de Escanner
				digiCliente.vigia();
				digiCliente.run();
			}
		}
		catch (UnknownHostException uhe ) {
			digiCliente.cargaConfiguracion = false;
			System.out.println( "No concuerda el nombre del Host("+digiCliente.HOST_NAME+")" );
			uhe.printStackTrace();
		}
		catch (MalformedURLException mURLe ) {
			digiCliente.cargaConfiguracion = false;
			System.out.println( "Error Interno" + mURLe );
			mURLe.printStackTrace();
		}
		catch ( RemoteException re ) {
			digiCliente.cargaConfiguracion = false;
			System.out.println( "Error al iniciar el servicio" );
			re.printStackTrace();
		}
		catch (NotBoundException nbe )   {
			digiCliente.cargaConfiguracion = false;
			System.out.println( "Not Bound" +nbe );
			nbe.printStackTrace();
		}
		catch(Exception e){
			digiCliente.cargaConfiguracion = false;
			System.out.println( "Exepcion Generica" +e );
			e.printStackTrace();
		}
		finally{
			try{
				if(!digiCliente.cargaConfiguracion){
					digiCliente.notificaPerdidaConexion();
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}

/**
* Arranque de hilo con el que implemento Runnable.
*/
	public void run() {
		try {
			tLectura.start();
		}
		catch( Exception e ) {
			e.printStackTrace();
		}
	}


    protected void mandaProducto(String producto) throws Exception{
		// Paro lectura del Buffer... no quiero mas datos provenientes del escanner
		if(!arranqueSinEscanner && entrada != null){
			entrada.close();
		}
		try{
			// Checo que la clave dada exista
			existencia = bs.existeProducto(producto.trim());
			// Si existe ahora verifico que haya en existencia
			if(existencia){
				cantidadPositiva = bs.hayProducto(producto.trim());
			}
			if (!existencia){
				JOptionPane.showInternalMessageDialog(desktop, "¡No esta registrado un producto con esa clave!");
				jftClave.setText("");
			}
			else if(!cantidadPositiva){
				try{
					hayEnAlmacen = bs.existeEnAlmacen(producto.trim());
				}
				catch(RemoteException re){
					notificaPerdidaConexion();
				}
				String nombreProducto = "";
				try{
					nombreProducto = bs.dameNombreProducto(producto.trim());
				}
				catch(RemoteException re){
					notificaPerdidaConexion();
				}
				if(!hayEnAlmacen){
					JOptionPane.showInternalMessageDialog(desktop, "¡No tengo el producto: \n"+nombreProducto +"\n en existencia!");
				}
				else{
					JOptionPane.showInternalMessageDialog(desktop, "¡Solo  tengo el producto: \n"+nombreProducto +"\n en Almacén, Solicite un traspaso de producto!");
				}
				jftClave.setText("");
			}
			else{
				DatosProducto dp = new DatosProducto();
				// Mando Referencia a mi Cliente
				dp.setPadre(this);
				dp.setClaveProducto(producto);
				dp.setTipoPrecio(tipoPrecio);
				dp.despliegaInterfaz();
				jftClave.setText("");
				dp.setVisible(true);
				desktop.add(dp);
				dp.setSelected(true);
				dp.jtCantidad.requestFocus();
			}
		}
		catch (ConnectException ce) {
			notificaPerdidaConexion();
			System.out.println("Se perdio la conexion con el Servidor...");
		}
    }

	protected void procesoTipoPrecio() throws Exception{
		// Paro lectura del Buffer...
		if(!arranqueSinEscanner && entrada != null){
			entrada.close();
		}
		try{
			puertoSerial.removeEventListener();
			puertoSerial.close();
		}
		catch (Exception on){
			on.printStackTrace();
		}
		TipoPrecio tp = new TipoPrecio();
		tp.setPadre(this);
		tp.despliegaInterfaz();
		tp.setVisible(true);
		desktop.add(tp);
		tp.setSelected(true);
		tp.jtAutoriza.requestFocus();
	}

	protected void reImprimeTicket() throws Exception{
		// Paro lectura del Buffer...
		if(!arranqueSinEscanner && entrada != null){
			entrada.close();
		}
		try{
			puertoSerial.removeEventListener();
			puertoSerial.close();
		}
		catch (Exception on){
			on.printStackTrace();
		}
		ReimprimeTicket rt = new ReimprimeTicket();
		rt.setPadre(this);
		rt.despliegaInterfaz();
		rt.setVisible(true);
		desktop.add(rt);
		rt.setSelected(true);
		rt.jtClaveU.requestFocus();
	}

	protected void procesoCerrar() throws Exception{
		// Paro lectura del Buffer...
		if(!arranqueSinEscanner && entrada != null){
			entrada.close();
		}
		try{
			puertoSerial.removeEventListener();
			puertoSerial.close();
		}
		catch (Exception on){
			on.printStackTrace();
		}
		CierraCuentaDV ccdv = new CierraCuentaDV();
		jftClave.setText("");
		ccdv.setPadre(this);
		ccdv.despliegaInterfaz();
		ccdv.setVisible(true);
		desktop.add(ccdv);
		ccdv.setSelected(true);
		ccdv.jtClaveU.requestFocus();
	}


	protected void busquedaXNombre() throws Exception{
		// Paro lectura del Buffer...
		if(!arranqueSinEscanner && entrada != null){
			entrada.close();
		}
		try{
			puertoSerial.removeEventListener();
			puertoSerial.close();
		}
		catch (Exception on){
			on.printStackTrace();
		}
		BusquedaXNombre bxn = new BusquedaXNombre();
		bxn.setTipoPrecio(tipoPrecio);
		bxn.setPadre(this);
		bxn.despliegaInterfaz();
		bxn.setVisible(true);
		desktop.add(bxn);
		bxn.setSelected(true);
		bxn.jtNombre.requestFocus();
	}

	protected void procesoCancelar() throws Exception{
		// Paro lectura del Buffer...
		// Paro lectura del Buffer...
		if(!arranqueSinEscanner && entrada != null){
			entrada.close();
		}
		try{
			puertoSerial.removeEventListener();
			puertoSerial.close();
		}
		catch (Exception on){
			on.printStackTrace();
		}
		CancelaCuenta cc = new CancelaCuenta();
		cc.setPadre(this);
		cc.despliegaInterfaz();
		cc.setVisible(true);
		desktop.add(cc);
		cc.setSelected(true);
		cc.jtClaveU.requestFocus();
	}

	protected void procesoRecicla() throws Exception{
		// Paro lectura del Buffer...
		// Paro lectura del Buffer...
		if(!arranqueSinEscanner && entrada != null){
			entrada.close();
		}
		try{
			puertoSerial.removeEventListener();
			puertoSerial.close();
		}
		catch (Exception on){
			on.printStackTrace();
		}
		ReciclaTicket rc = new ReciclaTicket();
		rc.setPadre(this);
		rc.despliegaInterfaz();
		rc.setVisible(true);
		desktop.add(rc);
		rc.setSelected(true);
		rc.jtNumTicket.requestFocus();
	}

/**
*  Implementa el Hilo que se encarga de monitorear la comunicación con el escanner.
*/
	public void vigia(){
		tLectura = new Thread (new Runnable(){
			public void run(){
				//System.out.println("Entre a la ejecución del hilo");
				try{
					// Verifico existencia del puerto....
					try  {
						idPuerto = CommPortIdentifier.getPortIdentifier(puertoDeEscanner);
					}
					catch (NoSuchPortException e){
						System.out.println("Avento error NoSuchPortException!");
						semaforoEscanner = 2;
						exitoComunicacion = false;
						e.printStackTrace();
						arranqueSinEscanner = true;
						avisoNoEscanner();
						tLectura.interrupt();
					}
					if (tLectura.interrupted()) {
							return;
				    }
					if(exitoComunicacion){
// Abro el puerto y pido un Stream constante
						try {
							puertoSerial = (SerialPort) idPuerto.open("Escanner", 10000);
							entrada = puertoSerial.getInputStream();
							// Puedo solicitar los datos del puerto abierto.
							//informa();
						}
						catch (IOException ioe){
							semaforoEscanner = 2;
							exitoComunicacion = false;
							ioe.printStackTrace();
							arranqueSinEscanner = true;
							avisoNoEscanner();
							tLectura.interrupt();
						}
						catch (PortInUseException e) {
							semaforoEscanner = 2;
							exitoComunicacion = false;
							e.printStackTrace();
							arranqueSinEscanner = true;
							avisoNoEscanner();
							tLectura.interrupt();
						}
						if (tLectura.interrupted()) {
							return;
					    }
					}
// Si todo bien mantengo comunicacion con el escanner
					if(exitoComunicacion) {
						try {
							puertoSerial.notifyOnDataAvailable( true );
						}
						catch (Exception e) {
							semaforoEscanner = 2;
							e.printStackTrace();
						}
					}
// Checo de nuevo que todo vaya bien.., si es el caso pido me informen de lo obtenido.
					if(exitoComunicacion){
						semaforoEscanner = 1;
						try {
							//System.out.println("Inicio Demonio escucha...");
						   puertoSerial.addEventListener( new scannerReader() );
						}
						catch (TooManyListenersException e) {
							semaforoEscanner = 2;
							e.printStackTrace();
						}
						while (semaforoEscanner != 2){
							if (sb.length()== 0){
								//System.out.print("\nNo hay archivos actualmente... así que voy a poner a dormir mi hilo por 1 segundo...");
								tLectura.sleep(1000);
							}
							if(sb.length() > 0 && entradaParcial){
								try{
									puertoSerial.removeEventListener();
									puertoSerial.close();
									paroCom = true;
								}
								catch (Exception on){
									on.printStackTrace();
								}
								try{
									//System.out.println("Voy a buscar el código de barras :" +sb.toString());
									claveDeProducto =  bs.dameClaveCorrespondiente(sb.toString());
								}
								catch (Exception q){
									q.printStackTrace();
								}
								try{
									tInterno = new Thread (new Runnable(){
										public void run() {
											try{
												sb = new StringBuilder("");
												mandaProducto(claveDeProducto);
												tInterno.join();
											}
											catch(Exception e){
												e.printStackTrace();
											}
										}
									});
									tInterno.start();
								}
								catch (Exception o){
									o.printStackTrace();
								}
								sb = new StringBuilder("");
								entradaParcial = false;
							}
							while (paroCom){ // Este while se ejecuta mientra checo que onda con el producto que se escaneo
								tLectura.sleep(1500);
								if ((!existencia || !cantidadPositiva) && paroCom){ // Si no existe el producto o no hay en Existencia y se paro el servicio del escanner
									//System.out.println("Componentes: " +desktop.getComponentCount());
									if(desktop.getComponentCount() ==19){ //  Espero a que el cliente cierre la venta de aviso de que no hay producto o no existe....
										//System.out.println("ResetInterno...");
										resetHilos();
									}
								}
							}
						}
					}
				}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		});
	}

	protected void resetHilos(){
		//System.out.println("Reseteando Hilos");
		entrada = null;
		try{
			//if(tInterno != null){
			//	tInterno = null;
			//}
			if(!idPuerto.isCurrentlyOwned()){
				puertoSerial = (SerialPort) idPuerto.open("Escanner", 1500);
				puertoSerial.notifyOnDataAvailable( true );
				entrada = puertoSerial.getInputStream();
				puertoSerial.addEventListener( new scannerReader() );
			}
			else{
				entrada = puertoSerial.getInputStream();
			}
			paroCom = false;
			sb = new StringBuilder("");
			existencia = false;
			cantidadPositiva = false;
		}
		catch (PortInUseException e) {
			e.printStackTrace();
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}


/**
*  Es el encargado de escuchar constantemente la comunicación establecida con el Escanner, e informar sobre los datos
*  recibidos para su implementación.
*/
	public class scannerReader implements SerialPortEventListener {
		public void serialEvent( SerialPortEvent _ev ) {
			switch( _ev.getEventType() ) {
			case SerialPortEvent.BI:
			case SerialPortEvent.OE:
			case SerialPortEvent.FE:
			case SerialPortEvent.PE:
			case SerialPortEvent.CD:
			case SerialPortEvent.CTS:
			case SerialPortEvent.DSR:
			case SerialPortEvent.RI:
			case SerialPortEvent.OUTPUT_BUFFER_EMPTY:
				break;
// Cuando haya datos disponibles se leen e interpretan...
			case SerialPortEvent.DATA_AVAILABLE:
				byte[] bufferLectura = new byte[20];
				try {
					while(entrada.available() > 0 ) {
						int nBytes = entrada.read( bufferLectura );
						sb = sb.append((new String(bufferLectura).trim()));
//						System.out.println("Desde ScannerReader(1): "+sb.toString());
					}
					if(sb.length() > 0){
						entradaParcial = true;
					}
				}
				catch( IOException e ) {
					e.printStackTrace();
				}
				break;
			}
		}
	}

	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlBoton1){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"1");
					}
				}
				else if(temporal == jlBoton2){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"2");
					}
				}
				else if(temporal == jlBoton3){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"3");
					}
				}
				else if(temporal == jlBoton4){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"4");
					}
				}
				else if(temporal == jlBoton5){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"5");
					}
				}
				else if(temporal == jlBoton6){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"6");
					}
				}
				else if(temporal == jlBoton7){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"7");
					}
				}
				else if(temporal == jlBoton8){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"8");
					}
				}
				else if(temporal == jlBoton9){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"9");
					}
				}
				else if(temporal == jlBoton0){
					String previo = jftClave.getText();
					if (previo.length() < 7){
						jftClave.setText(previo+"0");
					}
				}
				else if(temporal == jlBorrar){
					String previo = jftClave.getText();
					try{
						jftClave.setText(previo.substring(0, previo.length()-1));
					}
					catch (StringIndexOutOfBoundsException sioobe){
					}
				}
				else if(temporal == jlCancela){
					procesoCancelar();
				}
				else if(temporal == jlRecicla){
					procesoRecicla();
				}
				else if(temporal == jlCerrar){
					procesoCerrar();
				}
				else if(temporal == jlTipoP){
					procesoTipoPrecio();
				}
				else if(temporal == jlBusqueda){
					busquedaXNombre();
				}
				else if(temporal == jlImprime){
					reImprimeTicket();
				}
				else if(temporal == jlEnvia){
					String previo = jftClave.getText();
					mandaProducto(previo);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
		// Si presionaron mi boton mando tocar un sonido
		public void mousePressed(MouseEvent e){
			try{
			}
			catch (Exception a){
				a.printStackTrace();
			}
		}
		public void mouseReleased(MouseEvent e){
		}
		// Si el mouse se encuentra dentro del área del boton cambio su apariencia.
		public void mouseEntered(MouseEvent e){
			setCursor(deMano);
			try{
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlBoton1){
					jlBoton1.setIcon(iiBoton1P);
				}
				else if(temporal == jlBoton2){
					jlBoton2.setIcon(iiBoton2P);
				}
				else if(temporal == jlBoton3){
					jlBoton3.setIcon(iiBoton3P);
				}
				else if(temporal == jlBoton4){
					jlBoton4.setIcon(iiBoton4P);
				}
				else if(temporal == jlBoton5){
					jlBoton5.setIcon(iiBoton5P);
				}
				else if(temporal == jlBoton6){
					jlBoton6.setIcon(iiBoton6P);
				}
				else if(temporal == jlBoton7){
					jlBoton7.setIcon(iiBoton7P);
				}
				else if(temporal == jlBoton8){
					jlBoton8.setIcon(iiBoton8P);
				}
				else if(temporal == jlBoton9){
					jlBoton9.setIcon(iiBoton9P);
				}
				else if(temporal == jlBoton0){
					jlBoton0.setIcon(iiBoton0P);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBP);
				}
				else if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanP);
				}
				else if(temporal == jlRecicla){
					jlRecicla.setIcon(iiBotonRecP);
				}
				else if(temporal == jlCerrar){
					jlCerrar.setIcon(iiBotonCerP);
				}
				else if(temporal == jlTipoP){
					jlTipoP.setIcon(iiBotonTipP);
				}
				else if(temporal == jlBusqueda){
					jlBusqueda.setIcon(iiBotonBusP);
				}
				else if(temporal == jlImprime){
					jlImprime.setIcon(iiImprimeP);
				}
				else if(temporal == jlEnvia){
					jlEnvia.setIcon(iiBotonEnvP);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
		// Si el mouse sale del área de mi boton le devuelvo su primera apariencia.
		public void mouseExited(MouseEvent e){
			setCursor(normal);
			try{
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlBoton1){
					jlBoton1.setIcon(iiBoton1N);
				}
				else if(temporal == jlBoton2){
					jlBoton2.setIcon(iiBoton2N);
				}
				else if(temporal == jlBoton3){
					jlBoton3.setIcon(iiBoton3N);
				}
				else if(temporal == jlBoton4){
					jlBoton4.setIcon(iiBoton4N);
				}
				else if(temporal == jlBoton5){
					jlBoton5.setIcon(iiBoton5N);
				}
				else if(temporal == jlBoton6){
					jlBoton6.setIcon(iiBoton6N);
				}
				else if(temporal == jlBoton7){
					jlBoton7.setIcon(iiBoton7N);
				}
				else if(temporal == jlBoton8){
					jlBoton8.setIcon(iiBoton8N);
				}
				else if(temporal == jlBoton9){
					jlBoton9.setIcon(iiBoton9N);
				}
				else if(temporal == jlBoton0){
					jlBoton0.setIcon(iiBoton0N);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBN);
				}
				else if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanN);
				}
				else if(temporal == jlRecicla){
					jlRecicla.setIcon(iiBotonRecN);
				}

				else if(temporal == jlCerrar){
					jlCerrar.setIcon(iiBotonCerN);
				}
				else if(temporal == jlTipoP){
					jlTipoP.setIcon(iiBotonTipN);
				}
				else if(temporal == jlBusqueda){
					jlBusqueda.setIcon(iiBotonBusN);
				}
				else if(temporal == jlImprime){
					jlImprime.setIcon(iiImprimeN);
				}
				else if(temporal == jlEnvia){
					jlEnvia.setIcon(iiBotonEnvN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}

}
