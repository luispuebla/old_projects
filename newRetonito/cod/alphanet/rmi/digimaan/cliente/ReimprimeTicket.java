package alphanet.rmi.digimaan.cliente;

import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import java.net.URL;
import javax.swing.JDesktopPane;
import javax.swing.JOptionPane;
import java.sql.ResultSet;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.rmi.RemoteException;
import java.util.Properties;
import java.io.IOException;
import java.io.FileInputStream;
import javax.swing.WindowConstants;


public class ReimprimeTicket extends JInternalFrame {

	private String claveProducto = new String("");
	private int claveU = 0;
	public JTextField  jtClaveU;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	private JLabel jlBorrar, jlRegresar, jlImprime;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonRegN, iiBotonRegP, iiBotonPrintN, iiBotonPrintP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	private ResultSet rsInfoProd = null;
	protected DigiCliente digiCliente;
   	protected static Properties config;

    public ReimprimeTicket() throws Exception {
        super("Reimpresión de Ticket", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,25);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoRTicket.jpg");
		iiFondo = new ImageIcon(url);
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
		url= getClass().getResource("/imas/botones/BorrarCN.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/RegresarN.jpg");
		iiBotonRegN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/RegresarP.jpg");
		iiBotonRegP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ImprimeN.jpg");
		iiBotonPrintN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ImprimeP.jpg");
		iiBotonPrintP = new ImageIcon(url);
		// Doy formato a mis campos de Texto:
		jtClaveU = new JTextField(30);
		jtClaveU.setHorizontalAlignment(JTextField.CENTER);
		jtClaveU.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtClaveU.setBounds(325,140,185,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(380,450,70,70);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(200,240,70,70);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(300,240,70,70);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(400,240,70,70);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(200,320,70,70);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(300,320,70,70);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(400,320,70,70);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(200,400,70,70);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(300,400,70,70);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(400,400,70,70);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(200,480,70,70);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(300,480,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlImprime= new JLabel(iiBotonPrintN);
		jlImprime.setBounds (540,270,175,70);
		jlImprime.addMouseListener(new mouseComportamientoLabels());
		jlRegresar= new JLabel(iiBotonRegN);
		jlRegresar.setBounds(540,380,175,70);
		jlRegresar.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		this.add(jlBoton1);
		this.add(jlBoton2);
		this.add(jlBoton3);
		this.add(jlBoton4);
		this.add(jlBoton5);
		this.add(jlBoton6);
		this.add(jlBoton7);
		this.add(jlBoton8);
		this.add(jlBoton9);
		this.add(jlBoton0);
		this.add(jlBorrar);
		this.add(jlRegresar);
		this.add(jlImprime);
		this.add(jtClaveU);
		this.add(jlFondo);
    	setVisible(true);
		digiCliente.desktop.setSelectedFrame(this);
		this.setSelected(true);
		jtClaveU.requestFocus();
	}

	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}

	public void procesoReimprimeTicket() throws Exception{
		claveU = ma.cambiaAInt(jtClaveU.getText());
		if(claveU == 0){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Debes escribir tu clave.");
			jtClaveU.setText("");
		}
		else{
			boolean existe =  false;
			try{
				existe = digiCliente.bs.existeUsuario(claveU);
			}
			catch(RemoteException re){
				this.setVisible(false);
				this.dispose();
				digiCliente.desktop.remove(this);
				if(!digiCliente.arranqueSinEscanner){
					digiCliente.resetHilos();
				}
				digiCliente.jftClave.requestFocus();
				digiCliente.notificaPerdidaConexion();
			}
			if (!existe){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "La clave: "+claveU +" no existe");
				jtClaveU.setText("");
			}
			else{
				int resultado = 0;
				try{
					resultado = digiCliente.bs.dameTicketRePrint(claveU);
				}
				catch(RemoteException re){
					this.setVisible(false);
					this.dispose();
					digiCliente.desktop.remove(this);
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
					digiCliente.notificaPerdidaConexion();
				}
				// x>0 --> El numero del ticket, 0 --> No hay, -1 --> Excepcion, -2 --> Ya Pagado,  -3 --> Otro en proceso.
				// ERROR EN SQL:
				if(resultado == -1){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Error en la conexión con la Base de Datos.");
					jtClaveU.setText("");
				}
				// NO HAY CUENTA EN CURSO
				else if (resultado == 0){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Este usuario ("+claveU+") no tiene registrado ningun ticket previo.");
					jtClaveU.setText("");
				}
				else if (resultado == -2){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Tú último ticket ya fue pagado, no se puede reimprimir");
					jtClaveU.setText("");
					this.setVisible(false);
					digiCliente.desktop.remove(this);
					this.dispose();
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
				}
				else if (resultado == -3){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Tienes un nuevo ticket en proceso, no se puede reimprimir el anterior.");
					jtClaveU.setText("");
					this.setVisible(false);
					digiCliente.desktop.remove(this);
					this.dispose();
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
				}
				// lo voy a reimprimir
				else{
					// DESCARGO ESTA VENTANA
					String identificador = "";
					try{
						String conf = "Client.conf";
						config = new Properties();
						config.load( new FileInputStream(conf) );
						identificador=config.getProperty("identificador");
					}
					catch(IOException ioe){
						System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
						ioe.printStackTrace();
					}
					digiCliente.bs.ImprimeTicketACobrar(resultado,identificador, claveU);
				}
			}
		}
	}

	public void Cierra() {
		this.setVisible(false);
		digiCliente.desktop.remove(this);
		this.dispose();
		if(!digiCliente.arranqueSinEscanner){
			digiCliente.resetHilos();
		}
		digiCliente.jftClave.requestFocus();
	}


	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlBoton1){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"1");
					}
				}
				else if(temporal == jlBoton2){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"2");
					}
				}
				else if(temporal == jlBoton3){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"3");
					}
				}
				else if(temporal == jlBoton4){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"4");
					}
				}
				else if(temporal == jlBoton5){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"5");
					}
				}
				else if(temporal == jlBoton6){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"6");
					}
				}
				else if(temporal == jlBoton7){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"7");
					}
				}
				else if(temporal == jlBoton8){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"8");
					}
				}
				else if(temporal == jlBoton9){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"9");
					}
				}
				else if(temporal == jlBoton0){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"0");
					}
				}
				else if(temporal == jlBorrar){
					jtClaveU.setText("");
				}
				else if(temporal == jlRegresar){
					Cierra();
				}
				else if(temporal == jlImprime){
					procesoReimprimeTicket();
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
				else if(temporal == jlRegresar){
					jlRegresar.setIcon(iiBotonRegP);
				}
				else if(temporal == jlImprime){
					jlImprime.setIcon(iiBotonPrintP);
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
				else if(temporal == jlRegresar){
					jlRegresar.setIcon(iiBotonRegN);
				}
				else if(temporal == jlImprime){
					jlImprime.setIcon(iiBotonPrintN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}
}