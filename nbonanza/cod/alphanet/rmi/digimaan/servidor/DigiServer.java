package alphanet.rmi.digimaan.servidor;


// Elaborado con RMI.
import java.net.MalformedURLException;
import java.io.*;
import java.util.Properties;
import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.LocateRegistry;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JComboBox;
import javax.swing.JList;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import java.net.URL;
import javax.swing.JDesktopPane;
import javax.swing.JScrollPane;
import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.ListSelectionModel;
import javax.swing.DefaultListModel;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import alphanet.rmi.digimaan.bd.Sound;
import java.util.Vector;
import  java.rmi.RemoteException;
import java.io.UnsupportedEncodingException;
import javax.swing.JInternalFrame;
import javax.swing.JOptionPane;
import javax.swing.JDesktopPane;
import javax.swing.JFrame;
import java.net.URL;
import java.io.InputStream;
import java.io.IOException;
import java.awt.MediaTracker;


/**
 * DigiServer es la Interfaz del Servidor que se encarga de dar Servicio a las peticiones de un cliente.
 *
 */


public class DigiServer extends JFrame {

	protected static Properties config;
	private int  PORT = 0;
	private String HOST_NAME= "";
	protected static DigiServer  digiServer;
	protected boolean cargaConfiguracion = true;
	protected JDesktopPane desktop;
	private Font letra;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private URL url;
	private Image imagen, ico;
	public JTextField jtCantidad;
	public String mensaje = "No fue posible iniciar el Servidor.";
	protected String codigoError = "";
	private static final long serialVersionUID=1L;

	public void despliegaInterfaz() throws Exception{
		url= getClass().getResource("/imas/MiniIco.jpg");
		Image icon = Toolkit.getDefaultToolkit().getImage(url);
	    this.setIconImage(icon);
		setBounds(0,0, 860, 690);
		setResizable(false);
		letra = new Font("Eras Demin ITC",Font.BOLD,18);
		url= getClass().getResource("/imas/fondoServidor.jpg");
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
		desktop = new JDesktopPane(); //a specialized layered pane
		jtCantidad = new JTextField();
		jtCantidad.setHorizontalAlignment(JTextField.CENTER);
		jtCantidad.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtCantidad.setBounds(220,300,400,40);
		setContentPane(desktop);
		setLocationRelativeTo(null);
		desktop.setDragMode(JDesktopPane.OUTLINE_DRAG_MODE);
		loadBackgroundImage(pruebaFondoIcon);
		desktop.add(jtCantidad,1);
		jtCantidad.setEditable(false);
	}

  protected void loadBackgroundImage( ImageIcon icon) {
    JLabel l = new JLabel(icon);
    l.setBounds(0, 0, icon.getIconWidth(), icon.getIconHeight());
    // Place the image in the lowest possible layer so nothing
    // can ever be painted under it.
    desktop.add(l, new Integer(Integer.MIN_VALUE));
  }


// Constructor
	public DigiServer() throws RemoteException, MalformedURLException, NotBoundException{
		super("Sistema Administrativo DIGIMAAN -- Servidor");
	// OBTENGO MIS DATOS DE ARCHIVO DE CONFIGURACION

	}

	public void levantaServicio() throws RemoteException, MalformedURLException, NotBoundException{
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			HOST_NAME=config.getProperty("server.host");
			PORT= Integer.parseInt(config.getProperty("server.port").trim());
		}
		catch(IOException ioe){
			cargaConfiguracion = false;
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
			codigoError = " Codigo 1";
		}
		catch (IllegalArgumentException iae){
			cargaConfiguracion = false;
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
			codigoError = " Codigo 2";
		}
		// Si obtuve mis datos cargo la configuracion
		if(cargaConfiguracion){
			LocateRegistry.createRegistry(PORT);
			DigiServerImpl bsi = new DigiServerImpl();
			String urlString = "//"+HOST_NAME+":"+Integer.toString(PORT)+"/"+"DigiServicios";
			Naming.rebind(urlString, bsi);
			mensaje = "Inicio correcto del Servidor...";
		}
	}


   public static void main ( String[] args ) throws Exception  {
		digiServer = new DigiServer();
	// OBTENGO MIS DATOS DE ARCHIVO DE CONFIGURACION
		try{
			System.setSecurityManager( new RMISecurityManager() );
			digiServer.despliegaInterfaz();
			digiServer.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	        //Display the window.
	        digiServer.setVisible(true);
	       	digiServer.levantaServicio();
		}

		catch (UnknownHostException uhe ) {
			digiServer.codigoError = " Codigo 3";
			System.out.println( "No concuerda el nombre del Host("+digiServer.HOST_NAME+")" );
			uhe.printStackTrace();
		}
		catch ( RemoteException re ) {
			digiServer.codigoError = " Codigo 4";
			System.out.println( "Error al iniciar el servicio remoto" );
			re.printStackTrace();
		}
		catch (MalformedURLException mURLe ) {
			digiServer.codigoError = " Codigo 5";
			System.out.println( "Error Interno" + mURLe );
			mURLe.printStackTrace();
		}
		catch (NotBoundException nbe )   {
			digiServer.codigoError = " Codigo 6";
			System.out.println( "Not Bound" +nbe );
			nbe.printStackTrace();
		}
		catch (Exception e )   {
			digiServer.codigoError = " Codigo 7";
			System.out.println( "Excepcion" +e );
			e.printStackTrace();
		}
		finally{
			digiServer.jtCantidad.setText(digiServer.mensaje+digiServer.codigoError);
		}
		if(digiServer.cargaConfiguracion){
			System.out.println("Esperando conexion de Cliente.....");
		}
	}  // main

}  // class DigiServer