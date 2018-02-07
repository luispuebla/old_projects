package alphanet.ultra.digibar.servidor;


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
import alphanet.ultra.digibar.bd.Sound;
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


/**
 * BarServer es la Interfaz del Servidor que se encarga de dar Servicio a las peticiones de un cliente.
 *
 */


public class BarServer extends JFrame {

	protected static Properties config;
	private int  PORT = 0;
	private String HOST_NAME= "";
	protected static BarServer  barServer;
	protected boolean cargaConfiguracion = true;
	protected JDesktopPane desktop;
	private Font letra;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private URL url;
	private Image imagen;
	public JTextField jtCantidad;
	public String mensaje = "Error al Levanta el Servicio";


	public void despliegaInterfaz() throws Exception{
		System.out.println("Entre a despliegaInterfaz");
		setBounds(0,0, 860, 690);
		setResizable(false);
		letra = new Font("Eras Demin ITC",Font.BOLD,20);
		url= getClass().getResource("/imas/fondoServidor.jpg");
		imagen = Toolkit.getDefaultToolkit().getImage(url);
		// Este lo meto para que me despliegue el fondo.., realmente no es necesario.
		ImageIcon pruebaFondoIcon = new ImageIcon(url);
		desktop = new JDesktopPane(); //a specialized layered pane
		jtCantidad = new JTextField(mensaje);
		jtCantidad.setHorizontalAlignment(JTextField.CENTER);
		jtCantidad.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtCantidad.setBounds(220,300,400,40);
		setContentPane(desktop);
		setLocationRelativeTo(null);
		desktop.setDragMode(JDesktopPane.OUTLINE_DRAG_MODE);
		loadBackgroundImage(pruebaFondoIcon);
		if(cargaConfiguracion){
			desktop.add(jtCantidad,1);
		}
	}

  protected void loadBackgroundImage( ImageIcon icon) {
    JLabel l = new JLabel(icon);
    l.setBounds(0, 0, icon.getIconWidth(), icon.getIconHeight());
    // Place the image in the lowest possible layer so nothing
    // can ever be painted under it.
    desktop.add(l, new Integer(Integer.MIN_VALUE));
  }


// Constructor
	public BarServer() throws RemoteException, MalformedURLException, NotBoundException{
		super("Sistema Administrativo DIGIBAR -- Servidor");
	// OBTENGO MIS DATOS DE ARCHIVO DE CONFIGURACION
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
		}
		catch (IllegalArgumentException iae){
			cargaConfiguracion = false;
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		// Si obtuve mis datos cargo la configuracion
		if(cargaConfiguracion){
			LocateRegistry.createRegistry(PORT);
			System.out.println( "Registro Creado" );
			BarServerImpl bsi = new BarServerImpl();
			String urlString = "//"+HOST_NAME+":"+Integer.toString(PORT)+"/"+"BarServicios";
			Naming.rebind(urlString, bsi);
			mensaje = "Exito al inicializar Servicio";
		}

	}



   public static void main ( String[] args )   {
	// OBTENGO MIS DATOS DE ARCHIVO DE CONFIGURACION
		try{
			System.setSecurityManager( new RMISecurityManager() );
			barServer = new BarServer();
		}

		catch (UnknownHostException uhe ) {
			System.out.println( "No concuerda el nombre del Host("+barServer.HOST_NAME+")" );
			uhe.printStackTrace();
		}
		catch ( RemoteException re ) {
			System.out.println( "Error al iniciar el servicio" );
			re.printStackTrace();
		}
		catch (MalformedURLException mURLe ) {
			System.out.println( "Error Interno" + mURLe );
			mURLe.printStackTrace();
		}
		catch (NotBoundException nbe )   {
			System.out.println( "Not Bound" +nbe );
			nbe.printStackTrace();
		}
		catch (Exception e )   {
			System.out.println( "Excepcion" +e );
			e.printStackTrace();
		}
		finally{
			try{
				barServer.despliegaInterfaz();
				barServer.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		        //Display the window.
		        barServer.setVisible(true);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		if(barServer.cargaConfiguracion){
			System.out.println("Esperando conexion de Cliente.....");
		}
	}  // main

}  // class BarServer