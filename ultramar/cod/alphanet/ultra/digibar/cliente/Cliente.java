package alphanet.ultra.digibar.cliente;

import java.net.MalformedURLException;
import java.rmi.*;
import java.rmi.server.*;
import alphanet.ultra.digibar.bd.ManagerAuxiliar;
import alphanet.ultra.digibar.bd.Sound;
import alphanet.ultra.digibar.servidor.BarServicios;
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

public class Cliente extends JFrame implements Runnable  {

	protected JDesktopPane desktop;
	private Font letra;
	private boolean recupereMesas = false;
	private JLabel jlM01, jlM02, jlM03, jlM04, jlM05, jlM06, jlM07, jlM08, jlM09, jlM10, jlM11, jlM12, jlM13, jlM14, jlM15, jlM16, jlM17, jlM18, jlM19, jlM20, jlM21, jlM22, jlM23, jlM24, jlB01, jlB02, jlB03, jlB04, jlB05, jlBotonPersonal, jlNoConnect;
	private ImageIcon iiM01V, iiM02V, iiM03V, iiM04V, iiM05V, iiM06V, iiM07V, iiM08V, iiM09V, iiM10V, iiM11V, iiM12V, iiM13V, iiM14V, iiM15V, iiM16V, iiM17V, iiM18V, iiM19V, iiM20V, iiM21V, iiM22V, iiM23V, iiM24V, iiB25V, iiB26V, iiB27V, iiB28V, iiB29V, 	iiM01O, iiM02O, iiM03O, iiM04O, iiM05O, iiM06O, iiM07O, iiM08O, iiM09O, iiM10O, iiM11O, iiM12O, iiM13O, iiM14O, iiM15O, iiM16O, iiM17O, iiM18O, iiM19O, iiM20O, iiM21O, iiM22O, iiM23O, iiM24O,iiB25O, iiB26O, iiB27O, iiB28O, iiB29O, 	iiM01L, iiM02L, iiM03L, iiM04L, iiM05L, iiM06L, iiM07L, iiM08L, iiM09L, iiM10L, iiM11L, iiM12L, iiM13L, iiM14L, iiM15L, iiM16L, iiM17L, iiM18L,   iiM19L, iiM20L, iiM21L, iiM22L, iiM23L, iiM24L, iiB25L, iiB26L, iiB27L, iiB28L, iiB29L, iiNoConnect, iiBPerN, iiBPerP;
	private Sound son;
   	protected static Properties config;
	private String HOST_NAME = "";
	private int PORT = 0;
	protected boolean cargaConfiguracion = true;
	protected static Cliente clie;
	protected BarServicios bs ;
	protected String dameSaludo;
	private Image imagen;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private URL url;
	protected ManagerAuxiliar ma = new ManagerAuxiliar();
	private static final long serialVersionUID = 1L;
	protected Thread tLectura;
	protected boolean conexionPerdida = false;


	public void run() {
		try {
			tLectura.start();
		}
		catch( Exception e ) {
			e.printStackTrace();
		}
	}


	public Cliente() throws RemoteException, MalformedURLException, NotBoundException, Exception {
		super("Sistema Administrativo DIGIBAR -- Cliente");
	// OBTENGO MIS DATOS DE ARCHIVO DE CONFIGURACION
		try{
			String conf = "Client.conf";
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
		// Si obtuve mis datos cargo la configuracion y arranco hilo de lectura
		if(cargaConfiguracion){
			try{
				bs = (BarServicios)Naming.lookup("rmi://"+HOST_NAME+":"+Integer.toString(PORT)+"/BarServicios");
				vigia();
				run();
				despliegaInterfaz();
			}
			catch (ConnectException ce) {
				System.out.println("No hubo conexion con el Servidor...");
				cargaConfiguracion = false;
				bs = null;
				despliegaInterfaz();
			}
		}
	}

/**
*  Implementa el Hilo que se encarga de monitorear la comunicación con el escanner.
*/
	public void vigia(){
		tLectura = new Thread (new Runnable(){
			public void run(){
				//System.out.println("Entre a la ejecución del hilo");
				try{
					while (true && !conexionPerdida){
						tLectura.sleep(8000);
						refrescaMapa();
					}
				}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		});
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		setBounds(0,0, 860, 690);
		setResizable(false);
		letra = new Font("Agency FB", Font.BOLD, 20);
		url= getClass().getResource("/imas/mesas/M01L.jpg");
		iiM01L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M01O.jpg");
		iiM01O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M01V.jpg");
		iiM01V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M02L.jpg");
		iiM02L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M02O.jpg");
		iiM02O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M02V.jpg");
		iiM02V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M03L.jpg");
		iiM03L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M03O.jpg");
		iiM03O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M03V.jpg");
		iiM03V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M04L.jpg");
		iiM04L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M04O.jpg");
		iiM04O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M04V.jpg");
		iiM04V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M05L.jpg");
		iiM05L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M05O.jpg");
		iiM05O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M05V.jpg");
		iiM05V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M06L.jpg");
		iiM06L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M06O.jpg");
		iiM06O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M06V.jpg");
		iiM06V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M07L.jpg");
		iiM07L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M07O.jpg");
		iiM07O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M07V.jpg");
		iiM07V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M08L.jpg");
		iiM08L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M08O.jpg");
		iiM08O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M08V.jpg");
		iiM08V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M09L.jpg");
		iiM09L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M09O.jpg");
		iiM09O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M09V.jpg");
		iiM09V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M10L.jpg");
		iiM10L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M10O.jpg");
		iiM10O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M10V.jpg");
		iiM10V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M11L.jpg");
		iiM11L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M11O.jpg");
		iiM11O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M11V.jpg");
		iiM11V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M12L.jpg");
		iiM12L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M12O.jpg");
		iiM12O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M12V.jpg");
		iiM12V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M13L.jpg");
		iiM13L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M13O.jpg");
		iiM13O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M13V.jpg");
		iiM13V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M14L.jpg");
		iiM14L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M14O.jpg");
		iiM14O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M14V.jpg");
		iiM14V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M15L.jpg");
		iiM15L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M15O.jpg");
		iiM15O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M15V.jpg");
		iiM15V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M16L.jpg");
		iiM16L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M16O.jpg");
		iiM16O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M16V.jpg");
		iiM16V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M17L.jpg");
		iiM17L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M17O.jpg");
		iiM17O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M17V.jpg");
		iiM17V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M18L.jpg");
		iiM18L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M18O.jpg");
		iiM18O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M18V.jpg");
		iiM18V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M19L.jpg");
		iiM19L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M19O.jpg");
		iiM19O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M19V.jpg");
		iiM19V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M20L.jpg");
		iiM20L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M20O.jpg");
		iiM20O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M20V.jpg");
		iiM20V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M21L.jpg");
		iiM21L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M21O.jpg");
		iiM21O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M21V.jpg");
		iiM21V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M22L.jpg");
		iiM22L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M22O.jpg");
		iiM22O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M22V.jpg");
		iiM22V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M23L.jpg");
		iiM23L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M23O.jpg");
		iiM23O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M23V.jpg");
		iiM23V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M24L.jpg");
		iiM24L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M24O.jpg");
		iiM24O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/M24V.jpg");
		iiM24V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB1L.jpg");
		iiB25L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB1O.jpg");
		iiB25O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB1V.jpg");
		iiB25V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB2L.jpg");
		iiB26L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB2O.jpg");
		iiB26O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB2V.jpg");
		iiB26V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB3L.jpg");
		iiB27L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB3O.jpg");
		iiB27O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB3V.jpg");
		iiB27V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB4L.jpg");
		iiB28L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB4O.jpg");
		iiB28O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB4V.jpg");
		iiB28V = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB5L.jpg");
		iiB29L = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB5O.jpg");
		iiB29O = new ImageIcon(url);
		url= getClass().getResource("/imas/mesas/MB5V.jpg");
		iiB29V = new ImageIcon(url);
		url= getClass().getResource("/imas/avisoNoConexion.jpg");
		iiNoConnect = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MPerN.jpg");
		iiBPerN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MPerP.jpg");
		iiBPerP = new ImageIcon(url);
		url= getClass().getResource("/imas/fondoMapa.jpg");
		imagen = Toolkit.getDefaultToolkit().getImage(url);

		jlBotonPersonal = new JLabel(iiBPerN);
		jlBotonPersonal.setBounds(60,446,110,72);
		jlBotonPersonal.addMouseListener(new mouseComportamientoLabels());


		// Este lo meto para que me despliegue el fondo.., realmente no es necesario.
		ImageIcon pruebaFondoIcon = new ImageIcon(url);
// Si hubo comunicacion... cargo mesas...
		if(cargaConfiguracion) {
			Vector <String> estatusMesas = bs.EstatusMapa();
			int tamanio = 0;
			if (estatusMesas!=null){
				recupereMesas = true;
				tamanio = estatusMesas.size();
				for(int i = 0; i<tamanio; i++){
					String laMesa =estatusMesas.elementAt(i);
					i++;
					String elEstatus =estatusMesas.elementAt(i);
					if(laMesa.equals("1")){
						if(elEstatus.equals("0")){
							jlM01= new JLabel(iiM01V);
						}
						else if(elEstatus.equals("1")){
							jlM01= new JLabel(iiM01O);
						}
						else if(elEstatus.equals("2")){
							jlM01= new JLabel(iiM01L);
						}
						jlM01.setBounds(318,472,49,87);
						jlM01.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("2")){
						if(elEstatus.equals("0")){
							jlM02= new JLabel(iiM02V);
						}
						else if(elEstatus.equals("1")){
							jlM02= new JLabel(iiM02O);
						}
						else if(elEstatus.equals("2")){
							jlM02= new JLabel(iiM02L);
						}
						jlM02.setBounds(382,490,65,65);
						jlM02.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("3")){
						if(elEstatus.equals("0")){
							jlM03= new JLabel(iiM03V);
						}
						else if(elEstatus.equals("1")){
							jlM03= new JLabel(iiM03O);
						}
						else if(elEstatus.equals("2")){
							jlM03= new JLabel(iiM03L);
						}
						jlM03.setBounds(460,493,65,65);
						jlM03.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("4")){
						if(elEstatus.equals("0")){
							jlM04= new JLabel(iiM04V);
						}
						else if(elEstatus.equals("1")){
							jlM04= new JLabel(iiM04O);
						}
						else if(elEstatus.equals("2")){
							jlM04= new JLabel(iiM04L);
						}
						jlM04.setBounds(534,493,65,65);
						jlM04.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("5")){
						if(elEstatus.equals("0")){
							jlM05= new JLabel(iiM05V);
						}
						else if(elEstatus.equals("1")){
							jlM05= new JLabel(iiM05O);
						}
						else if(elEstatus.equals("2")){
								jlM05= new JLabel(iiM05L);
						}
						jlM05.setBounds(607,493,65,65);
						jlM05.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("6")){
						if(elEstatus.equals("0")){
							jlM06= new JLabel(iiM06V);
						}
						else if(elEstatus.equals("1")){
							jlM06= new JLabel(iiM06O);
						}
						else if(elEstatus.equals("2")){
							jlM06= new JLabel(iiM06L);
						}
						jlM06.setBounds(616,426,65,65);
						jlM06.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("7")){
						if(elEstatus.equals("0")){
							jlM07= new JLabel(iiM07V);
						}
						else if(elEstatus.equals("1")){
							jlM07= new JLabel(iiM07O);
						}
						else if(elEstatus.equals("2")){
							jlM07= new JLabel(iiM07L);
						}
						jlM07.setBounds(562,354,65,65);
						jlM07.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("8")){
						if(elEstatus.equals("0")){
							jlM08= new JLabel(iiM08V);
						}
						else if(elEstatus.equals("1")){
							jlM08= new JLabel(iiM08O);
						}
						else if(elEstatus.equals("2")){
							jlM08= new JLabel(iiM08L);
						}
						jlM08.setBounds(477,354,65,65);
						jlM08.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("9")){
						if(elEstatus.equals("0")){
							jlM09= new JLabel(iiM09V);
						}
						else if(elEstatus.equals("1")){
							jlM09= new JLabel(iiM09O);
						}
						else if(elEstatus.equals("2")){
							jlM09= new JLabel(iiM09L);
						}
						jlM09.setBounds(390,354,65,65);
						jlM09.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("10")){
						if(elEstatus.equals("0")){
							jlM10= new JLabel(iiM10V);
						}
						else if(elEstatus.equals("1")){
							jlM10= new JLabel(iiM10O);
						}
						else if(elEstatus.equals("2")){
							jlM10= new JLabel(iiM10L);
						}
						jlM10.setBounds(271,362,87,49);
						jlM10.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("11")){
						if(elEstatus.equals("0")){
							jlM11= new JLabel(iiM11V);
						}
						else if(elEstatus.equals("1")){
							jlM11= new JLabel(iiM11O);
						}
						else if(elEstatus.equals("2")){
							jlM11= new JLabel(iiM11L);
						}
						jlM11.setBounds(203,236,65,65);
						jlM11.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("12")){
						if(elEstatus.equals("0")){
							jlM12= new JLabel(iiM12V);
						}
						else if(elEstatus.equals("1")){
							jlM12= new JLabel(iiM12O);
						}
						else if(elEstatus.equals("2")){
							jlM12= new JLabel(iiM12L);
						}
						jlM12.setBounds(294,236,65,65);
						jlM12.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("13")){
						if(elEstatus.equals("0")){
							jlM13= new JLabel(iiM13V);
						}
						else if(elEstatus.equals("1")){
							jlM13= new JLabel(iiM13O);
						}
						else if(elEstatus.equals("2")){
							jlM13= new JLabel(iiM13L);
						}
						jlM13.setBounds(384,236,65,65);
						jlM13.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("14")){
						if(elEstatus.equals("0")){
							jlM14= new JLabel(iiM14V);
						}
						else if(elEstatus.equals("1")){
							jlM14= new JLabel(iiM14O);
						}
						else if(elEstatus.equals("2")){
							jlM14= new JLabel(iiM14L);
						}
						jlM14.setBounds(474,236,65,65);
						jlM14.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("15")){
						if(elEstatus.equals("0")){
							jlM15= new JLabel(iiM15V);
						}
						else if(elEstatus.equals("1")){
							jlM15= new JLabel(iiM15O);
						}
						else if(elEstatus.equals("2")){
							jlM15= new JLabel(iiM15L);
						}
						jlM15.setBounds(583,213,51,51);
						jlM15.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("16")){
						if(elEstatus.equals("0")){
							jlM16= new JLabel(iiM16V);
						}
						else if(elEstatus.equals("1")){
							jlM16= new JLabel(iiM16O);
						}
						else if(elEstatus.equals("2")){
							jlM16= new JLabel(iiM16L);
						}
						jlM16.setBounds(552,130,65,65);
						jlM16.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("17")){
						if(elEstatus.equals("0")){
							jlM17= new JLabel(iiM17V);
						}
						else if(elEstatus.equals("1")){
							jlM17= new JLabel(iiM17O);
						}
						else if(elEstatus.equals("2")){
							jlM17= new JLabel(iiM17L);
						}
						jlM17.setBounds(477,130,65,65);
						jlM17.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("18")){
						if(elEstatus.equals("0")){
							jlM18= new JLabel(iiM18V);
						}
						else if(elEstatus.equals("1")){
							jlM18= new JLabel(iiM18O);
						}
						else if(elEstatus.equals("2")){
							jlM18= new JLabel(iiM18L);
						}
						jlM18.setBounds(399,130,65,65);
						jlM18.addMouseListener(new mouseComportamientoLabels());
					}

					else if(laMesa.equals("19")){
						if(elEstatus.equals("0")){
							jlM19= new JLabel(iiM19V);
						}
						else if(elEstatus.equals("1")){
							jlM19= new JLabel(iiM19O);
						}
						else if(elEstatus.equals("2")){
							jlM19= new JLabel(iiM19L);
						}
						jlM19.setBounds(727,168,51,51);
						jlM19.addMouseListener(new mouseComportamientoLabels());
					}

					else if(laMesa.equals("20")){
						if(elEstatus.equals("0")){
							jlM20= new JLabel(iiM20V);
						}
						else if(elEstatus.equals("1")){
							jlM20= new JLabel(iiM20O);
						}
						else if(elEstatus.equals("2")){
							jlM20= new JLabel(iiM20L);
						}
						jlM20.setBounds(687,226,51,51);
						jlM20.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("21")){
						if(elEstatus.equals("0")){
							jlM21= new JLabel(iiM21V);
						}
						else if(elEstatus.equals("1")){
							jlM21= new JLabel(iiM21O);
						}
						else if(elEstatus.equals("2")){
							jlM21= new JLabel(iiM21L);
						}
						jlM21.setBounds(766,226,51,51);
						jlM21.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("22")){
						if(elEstatus.equals("0")){
							jlM22= new JLabel(iiM22V);
						}
						else if(elEstatus.equals("1")){
							jlM22= new JLabel(iiM22O);
						}
						else if(elEstatus.equals("2")){
							jlM22= new JLabel(iiM22L);
						}
						jlM22.setBounds(687,286,51,51);
						jlM22.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("23")){
						if(elEstatus.equals("0")){
							jlM23= new JLabel(iiM23V);
						}
						else if(elEstatus.equals("1")){
							jlM23= new JLabel(iiM23O);
						}
						else if(elEstatus.equals("2")){
							jlM23= new JLabel(iiM23L);
						}
						jlM23.setBounds(766,286,51,51);
						jlM23.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("24")){
						if(elEstatus.equals("0")){
							jlM24= new JLabel(iiM24V);
						}
						else if(elEstatus.equals("1")){
							jlM24= new JLabel(iiM24O);
						}
						else if(elEstatus.equals("2")){
							jlM24= new JLabel(iiM24L);
						}
						jlM24.setBounds(727,346,51,51);
						jlM24.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("25")){
						if(elEstatus.equals("0")){
							jlB01= new JLabel(iiB25V);
						}
						else if(elEstatus.equals("1")){
							jlB01= new JLabel(iiB25O);
						}
						else if(elEstatus.equals("2")){
							jlB01= new JLabel(iiB25L);
						}
						jlB01.setBounds(165,344,35,33);
						jlB01.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("26")){
						if(elEstatus.equals("0")){
							jlB02= new JLabel(iiB26V);
						}
						else if(elEstatus.equals("1")){
							jlB02= new JLabel(iiB26O);
						}
						else if(elEstatus.equals("2")){
							jlB02= new JLabel(iiB26L);
						}
						jlB02.setBounds(165,274,35,33);
						jlB02.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("27")){
						if(elEstatus.equals("0")){
							jlB03= new JLabel(iiB27V);
						}
						else if(elEstatus.equals("1")){
							jlB03= new JLabel(iiB27O);
						}
						else if(elEstatus.equals("2")){
							jlB03= new JLabel(iiB27L);
						}
						jlB03.setBounds(175,205,35,33);
						jlB03.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("28")){
						if(elEstatus.equals("0")){
							jlB04= new JLabel(iiB28V);
						}
						else if(elEstatus.equals("1")){
							jlB04= new JLabel(iiB28O);
						}
						else if(elEstatus.equals("2")){
							jlB04= new JLabel(iiB28L);
						}
						jlB04.setBounds(254,192,35,33);
						jlB04.addMouseListener(new mouseComportamientoLabels());
					}
					else if(laMesa.equals("29")){
						if(elEstatus.equals("0")){
							jlB05= new JLabel(iiB29V);
						}
						else if(elEstatus.equals("1")){
							jlB05= new JLabel(iiB29O);
						}
						else if(elEstatus.equals("2")){
							jlB05= new JLabel(iiB29L);
						}
						jlB05.setBounds(334,192,35,33);
						jlB05.addMouseListener(new mouseComportamientoLabels());
					}
				}
			}
			jlNoConnect = new JLabel (iiNoConnect);
			jlNoConnect.setBounds(93,120,674,433);
		}
		// Cargo el anuncio de que no hay comunicacion con el Servidor...
		else{
			jlNoConnect = new JLabel (iiNoConnect);
			jlNoConnect.setBounds(93,120,674,433);
		}
		desktop = new JDesktopPane(); //a specialized layered pane
		setContentPane(desktop);
		setLocationRelativeTo(null);
		desktop.setDragMode(JDesktopPane.OUTLINE_DRAG_MODE);
		loadBackgroundImage(pruebaFondoIcon);
		if(cargaConfiguracion){
			if(recupereMesas){
				desktop.add(jlM01,1);
				desktop.add(jlM02,1);
				desktop.add(jlM03,1);
				desktop.add(jlM04,1);
				desktop.add(jlM05,1);
				desktop.add(jlM06,1);
				desktop.add(jlM07,1);
				desktop.add(jlM08,1);
				desktop.add(jlM09,1);
				desktop.add(jlM10,1);
				desktop.add(jlM11,1);
				desktop.add(jlM12,1);
				desktop.add(jlM13,1);
				desktop.add(jlM14,1);
				desktop.add(jlM15,1);
				desktop.add(jlM16,1);
				desktop.add(jlM17,1);
				desktop.add(jlM18,1);
				desktop.add(jlM19,1);
				desktop.add(jlM20,1);
				desktop.add(jlM21,1);
				desktop.add(jlM22,1);
				desktop.add(jlM23,1);
				desktop.add(jlM24,1);
				desktop.add(jlB01,1);
				desktop.add(jlB02,1);
				desktop.add(jlB03,1);
				desktop.add(jlB04,1);
				desktop.add(jlB05,1);
				desktop.add(jlBotonPersonal,1);
			}
		}
		else{
			desktop.add(jlNoConnect,1);
		}
	}


	protected synchronized  void refrescaMapa() throws Exception{
		try{
			Vector <String> estatusMesas = bs.EstatusMapa();
			int tamanio = 0;
			if(estatusMesas != null){
				tamanio = estatusMesas.size();
				for(int i = 0; i<tamanio; i++){
					String laMesa =estatusMesas.elementAt(i);
					i++;
					String elEstatus =estatusMesas.elementAt(i);
					if(laMesa.equals("1")){
						if(elEstatus.equals("0")){
							jlM01.setIcon(iiM01V);
						}
						else if(elEstatus.equals("1")){
							jlM01.setIcon(iiM01O);
						}
						else if(elEstatus.equals("2")){
							jlM01.setIcon(iiM01L);
						}
					}
					else if(laMesa.equals("2")){
						if(elEstatus.equals("0")){
							jlM02.setIcon(iiM02V);
						}
						else if(elEstatus.equals("1")){
							jlM02.setIcon(iiM02O);
						}
						else if(elEstatus.equals("2")){
							jlM02.setIcon(iiM02L);
						}
					}
					else if(laMesa.equals("3")){
						if(elEstatus.equals("0")){
							jlM03.setIcon(iiM03V);
						}
						else if(elEstatus.equals("1")){
							jlM03.setIcon(iiM03O);
						}
						else if(elEstatus.equals("2")){
							jlM03.setIcon(iiM03L);
						}
					}
					else if(laMesa.equals("4")){
						if(elEstatus.equals("0")){
							jlM04.setIcon(iiM04V);
						}
						else if(elEstatus.equals("1")){
							jlM04.setIcon(iiM04O);
						}
						else if(elEstatus.equals("2")){
							jlM04.setIcon(iiM04L);
						}
					}
					else if(laMesa.equals("5")){
						if(elEstatus.equals("0")){
							jlM05.setIcon(iiM05V);
						}
						else if(elEstatus.equals("1")){
							jlM05.setIcon(iiM05O);
						}
						else if(elEstatus.equals("2")){
							jlM05.setIcon(iiM05L);
						}
					}
					else if(laMesa.equals("6")){
						if(elEstatus.equals("0")){
							jlM06.setIcon(iiM06V);
						}
						else if(elEstatus.equals("1")){
							jlM06.setIcon(iiM06O);
						}
						else if(elEstatus.equals("2")){
							jlM06.setIcon(iiM06L);
						}
					}
					else if(laMesa.equals("7")){
						if(elEstatus.equals("0")){
							jlM07.setIcon(iiM07V);
						}
						else if(elEstatus.equals("1")){
							jlM07.setIcon(iiM07O);
						}
						else if(elEstatus.equals("2")){
							jlM07.setIcon(iiM07L);
						}
					}
					else if(laMesa.equals("8")){
						if(elEstatus.equals("0")){
							jlM08.setIcon(iiM08V);
						}
						else if(elEstatus.equals("1")){
							jlM08.setIcon(iiM08O);
						}
						else if(elEstatus.equals("2")){
							jlM08.setIcon(iiM08L);
						}
					}
					else if(laMesa.equals("9")){
						if(elEstatus.equals("0")){
							jlM09.setIcon(iiM09V);
						}
						else if(elEstatus.equals("1")){
							jlM09.setIcon(iiM09O);
						}
						else if(elEstatus.equals("2")){
							jlM09.setIcon(iiM09L);
						}
					}
					else if(laMesa.equals("10")){
						if(elEstatus.equals("0")){
							jlM10.setIcon(iiM10V);
						}
						else if(elEstatus.equals("1")){
							jlM10.setIcon(iiM10O);
						}
						else if(elEstatus.equals("2")){
							jlM10.setIcon(iiM10L);
						}
					}
					else if(laMesa.equals("11")){
						if(elEstatus.equals("0")){
							jlM11.setIcon(iiM11V);
						}
						else if(elEstatus.equals("1")){
							jlM11.setIcon(iiM11O);
						}
						else if(elEstatus.equals("2")){
							jlM11.setIcon(iiM11L);
						}
					}
					else if(laMesa.equals("12")){
						if(elEstatus.equals("0")){
							jlM12.setIcon(iiM12V);
						}
						else if(elEstatus.equals("1")){
							jlM12.setIcon(iiM12O);
						}
						else if(elEstatus.equals("2")){
							jlM12.setIcon(iiM12L);
						}
					}
					else if(laMesa.equals("13")){
						if(elEstatus.equals("0")){
							jlM13.setIcon(iiM13V);
						}
						else if(elEstatus.equals("1")){
							jlM13.setIcon(iiM13O);
						}
						else if(elEstatus.equals("2")){
							jlM13.setIcon(iiM13L);
						}
					}
					else if(laMesa.equals("14")){
						if(elEstatus.equals("0")){
							jlM14.setIcon(iiM14V);
						}
						else if(elEstatus.equals("1")){
							jlM14.setIcon(iiM14O);
						}
						else if(elEstatus.equals("2")){
							jlM14.setIcon(iiM14L);
						}
					}
					else if(laMesa.equals("15")){
						if(elEstatus.equals("0")){
							jlM15.setIcon(iiM15V);
						}
						else if(elEstatus.equals("1")){
							jlM15.setIcon(iiM15O);
						}
						else if(elEstatus.equals("2")){
							jlM15.setIcon(iiM15L);
						}
					}
					else if(laMesa.equals("16")){
						if(elEstatus.equals("0")){
							jlM16.setIcon(iiM16V);
						}
						else if(elEstatus.equals("1")){
							jlM16.setIcon(iiM16O);
						}
						else if(elEstatus.equals("2")){
							jlM16.setIcon(iiM16L);
						}
					}
					else if(laMesa.equals("17")){
						if(elEstatus.equals("0")){
							jlM17.setIcon(iiM17V);
						}
						else if(elEstatus.equals("1")){
							jlM17.setIcon(iiM17O);
						}
						else if(elEstatus.equals("2")){
							jlM17.setIcon(iiM17L);
						}
					}
					else if(laMesa.equals("18")){
						if(elEstatus.equals("0")){
							jlM18.setIcon(iiM18V);
						}
						else if(elEstatus.equals("1")){
							jlM18.setIcon(iiM18O);
						}
						else if(elEstatus.equals("2")){
							jlM18.setIcon(iiM18L);
						}
					}

					else if(laMesa.equals("19")){
						if(elEstatus.equals("0")){
							jlM19.setIcon(iiM19V);
						}
						else if(elEstatus.equals("1")){
							jlM19.setIcon(iiM19O);
						}
						else if(elEstatus.equals("2")){
							jlM19.setIcon(iiM19L);
						}
					}

					else if(laMesa.equals("20")){
						if(elEstatus.equals("0")){
							jlM20.setIcon(iiM20V);
						}
						else if(elEstatus.equals("1")){
							jlM20.setIcon(iiM20O);
						}
						else if(elEstatus.equals("2")){
							jlM20.setIcon(iiM20L);
						}
					}

					else if(laMesa.equals("21")){
						if(elEstatus.equals("0")){
							jlM21.setIcon(iiM21V);
						}
						else if(elEstatus.equals("1")){
							jlM21.setIcon(iiM21O);
						}
						else if(elEstatus.equals("2")){
							jlM21.setIcon(iiM21L);
						}
					}

					else if(laMesa.equals("22")){
						if(elEstatus.equals("0")){
							jlM22.setIcon(iiM22V);
						}
						else if(elEstatus.equals("1")){
							jlM22.setIcon(iiM22O);
						}
						else if(elEstatus.equals("2")){
							jlM22.setIcon(iiM22L);
						}
					}

					else if(laMesa.equals("23")){
						if(elEstatus.equals("0")){
							jlM23.setIcon(iiM23V);
						}
						else if(elEstatus.equals("1")){
							jlM23.setIcon(iiM23O);
						}
						else if(elEstatus.equals("2")){
							jlM23.setIcon(iiM23L);
						}
					}

					else if(laMesa.equals("24")){
						if(elEstatus.equals("0")){
							jlM24.setIcon(iiM24V);
						}
						else if(elEstatus.equals("1")){
							jlM24.setIcon(iiM24O);
						}
						else if(elEstatus.equals("2")){
							jlM24.setIcon(iiM24L);
						}
					}

					else if(laMesa.equals("25")){
						if(elEstatus.equals("0")){
							jlB01.setIcon(iiB25V);
						}
						else if(elEstatus.equals("1")){
							jlB01.setIcon(iiB25O);
						}
						else if(elEstatus.equals("2")){
							jlB01.setIcon(iiB25L);
						}
					}
					else if(laMesa.equals("26")){
						if(elEstatus.equals("0")){
							jlB02.setIcon(iiB26V);
						}
						else if(elEstatus.equals("1")){
							jlB02.setIcon(iiB26O);
						}
						else if(elEstatus.equals("2")){
							jlB02.setIcon(iiB26L);
						}
					}
					else if(laMesa.equals("27")){
						if(elEstatus.equals("0")){
							jlB03.setIcon(iiB27V);
						}
						else if(elEstatus.equals("1")){
							jlB03.setIcon(iiB27O);
						}
						else if(elEstatus.equals("2")){
							jlB03.setIcon(iiB27L);
						}
					}
					else if(laMesa.equals("28")){
						if(elEstatus.equals("0")){
							jlB04.setIcon(iiB28V);
						}
						else if(elEstatus.equals("1")){
							jlB04.setIcon(iiB28O);
						}
						else if(elEstatus.equals("2")){
							jlB04.setIcon(iiB28L);
						}
					}

					else if(laMesa.equals("29")){
						if(elEstatus.equals("0")){
							jlB05.setIcon(iiB29V);
						}
						else if(elEstatus.equals("1")){
							jlB05.setIcon(iiB29O);
						}
						else if(elEstatus.equals("2")){
							jlB05.setIcon(iiB29L);
						}
					}
				}
			}
		}
		catch (ConnectException ce) {
			notificaPerdidaConexion();
			System.out.println("Se perdio la conexion con el Servidor...");
		}
		catch(ConnectIOException cioe){
			notificaPerdidaConexion();
			System.out.println("Se perdio la conexion con el Servidor...");
		}
	}


	public void notificaPerdidaConexion() throws Exception{
		if(!conexionPerdida){
			conexionPerdida = true;
			desktop.add(jlNoConnect,0);
		}
	}

// Here we load a background image for our desktop.
  protected void loadBackgroundImage( ImageIcon icon) {
    JLabel l = new JLabel(icon);
    l.setBounds(0, 0, icon.getIconWidth(), icon.getIconHeight());
    // Place the image in the lowest possible layer so nothing
    // can ever be painted under it.
    desktop.add(l, new Integer(Integer.MIN_VALUE));
  }

	protected void procesaMesaOcupada(String mesa) throws Exception{
		if(mesa.startsWith("B")){
			mesa=mesa.substring(1,mesa.length());
			if(mesa.equals("1")){
				mesa = "25";
			}
			else if(mesa.equals("2")){
				mesa = "26";
			}
			else if(mesa.equals("3")){
				mesa = "27";
			}
			else if(mesa.equals("4")){
				mesa = "28";
			}
			else if(mesa.equals("5")){
				mesa = "29";
			}
		}
		try{
			MenuMesaO  mmo = new MenuMesaO();
			mmo.setPadre(this);
			mmo.setMesaTrabaja(mesa);
			mmo.despliegaInterfaz();
			mmo.setVisible(true);
			desktop.add(mmo);
			mmo.setSelected(true);
		}
		catch (ConnectException ce) {
			notificaPerdidaConexion();
			System.out.println("Se perdio la conexion con el Servidor...");
		}
		catch(ConnectIOException cioe){
			notificaPerdidaConexion();
			System.out.println("Se perdio la conexion con el Servidor...");
		}
	}

	protected void procesaAltaMesa(String mesa) throws Exception{
		if(mesa.startsWith("B")){
			mesa=mesa.substring(1,mesa.length());
			if(mesa.equals("1")){
				mesa = "25";
			}
			else if(mesa.equals("2")){
				mesa = "26";
			}
			else if(mesa.equals("3")){
				mesa = "27";
			}
			else if(mesa.equals("4")){
				mesa = "28";
			}
			else if(mesa.equals("5")){
				mesa = "29";
			}
		}
		try{
			AltaMesa  am = new AltaMesa();
			am.setPadre(this);
			am.setMesaAlta(mesa);
			am.despliegaInterfaz();
			am.setVisible(true);
			desktop.add(am);
			am.setSelected(true);
			am.jtCantidad.requestFocus();
		}
		catch (ConnectException ce) {
			notificaPerdidaConexion();
			System.out.println("Se perdio la conexion con el Servidor...");
		}
		catch(ConnectIOException cioe){
			notificaPerdidaConexion();
			System.out.println("Se perdio la conexion con el Servidor...");
		}
	}

    protected void procesaAccion(JLabel jlMesa) throws Exception{
		refrescaMapa();
		ImageIcon temporal = ((ImageIcon) jlMesa.getIcon());
		String estatus = temporal.getDescription().substring(temporal.getDescription().length()-5,temporal.getDescription().length()-4);
		String mesa = temporal.getDescription().substring(temporal.getDescription().length()-7,temporal.getDescription().length()-5);
		if (estatus.equalsIgnoreCase("V")){
			procesaAltaMesa(mesa);
		}
		else if(estatus.equalsIgnoreCase("O")){
			procesaMesaOcupada(mesa);
		}
		else{
			procesaMesaOcupada(bs.DameMesaMadre(mesa));
		}
    }

	public void procesoConsumoInterno(){
		try{
			ComandaInterna ci = new ComandaInterna();
			ci.setPadre(this);
			ci.despliegaInterfaz();
			ci.setVisible(true);
			desktop.add(ci);
			ci.setSelected(true);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
				JLabel temporal = (JLabel)e.getSource();
				son.tocaSonido();
				if(temporal == jlBotonPersonal){
					procesoConsumoInterno();
				}
				else{
					procesaAccion(temporal);
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
				if(temporal == jlBotonPersonal){
					jlBotonPersonal.setIcon(iiBPerP);
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
				if(temporal == jlBotonPersonal){
					jlBotonPersonal.setIcon(iiBPerN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}


	public class formatoTeclado implements KeyListener {
		//JLabel source;
		public void keyPressed (KeyEvent e){
		}
		public void keyReleased (KeyEvent e){
		}
		public void keyTyped (KeyEvent e){
		}
	}



	public static void main (String [] args) {
		try{
			Cliente clie = new Cliente();
			clie.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	        //Display the window.
	        clie.setVisible(true);
		}
		catch (UnknownHostException uhe ) {
			System.out.println( "No concuerda el nombre del Host("+clie.HOST_NAME+")" );
			uhe.printStackTrace();
		}
		catch (MalformedURLException mURLe ) {
			System.out.println( "Error Interno" + mURLe );
			mURLe.printStackTrace();
		}
		catch ( RemoteException re ) {
			System.out.println( "Error al iniciar el servicio" );
			re.printStackTrace();
		}
		catch (NotBoundException nbe )   {
			System.out.println( "Not Bound" +nbe );
			nbe.printStackTrace();
		}
		catch(Exception e){
			System.out.println( "Exepcion Generica" +e );
			e.printStackTrace();
		}
	}

}