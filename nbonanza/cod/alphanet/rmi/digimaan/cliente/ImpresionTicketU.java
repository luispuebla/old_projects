package alphanet.rmi.digimaan.cliente;

import javax.swing.JInternalFrame;
import javax.swing.ImageIcon;
import java.net.URL;
import javax.swing.JDesktopPane;
import javax.swing.JOptionPane;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Color;
import java.awt.MediaTracker;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.event.ListSelectionEvent;
import javax.swing.JLabel;
import javax.swing.event.ListSelectionListener;
import javax.swing.JTextField;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.rmi.RemoteException;
import java.util.Properties;
import java.io.IOException;
import java.io.FileInputStream;
import java.math.*;
import javax.swing.WindowConstants;

public class ImpresionTicketU extends JInternalFrame {
	protected DigiCliente digiCliente;
	protected int claveTicket = 0;
	private JLabel jlFondo;
	protected JTextField jtCambio;
	protected Font letra;
	private Color colorLetras;
	private ImageIcon iiFondo;
	private URL url;
	private JLabel  jlRegresar, jlImprimir;
	private ImageIcon iiBotonRegN, iiBotonRegP, iiBotonImpN,iiBotonImpP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	protected String elTotal = "";
	protected int claveU = 0;
	protected String elPago = "";
	protected String cambio = "0.00";
	protected String pago = "";
   	protected static Properties config;
	BigDecimal bgPago = null;
	BigDecimal bgTotal = null;
	BigDecimal bgCambio = null;

	protected void setElPago (String elPago){
		this.elPago = elPago;
	}

	public void setElTotal(String elTotal){
		this.elTotal = elTotal;
	}

	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}

    public ImpresionTicketU() throws Exception {
        super("Impresión de Ticket", false, true, false);
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
		jtCambio = new JTextField(30);
		jtCambio.setHorizontalAlignment(JTextField.CENTER);
		jtCambio.setFont(letra);
		// Checo si existen productos en la lista...
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoImpresionTDirecta.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/RegresarN.jpg");
		iiBotonRegN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/RegresarP.jpg");
		iiBotonRegP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ImprimeN.jpg");
		iiBotonImpN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ImprimeP.jpg");
		iiBotonImpP = new ImageIcon(url);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
		jtCambio.setBounds(320,175,200,40);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlRegresar= new JLabel(iiBotonRegN);
		jlRegresar.setBounds(330,390,175,70);
		jlRegresar.addMouseListener(new mouseComportamientoLabels());
		jlImprimir= new JLabel(iiBotonImpN);
		jlImprimir.setBounds (330,285,175,70);
		jlImprimir.addMouseListener(new mouseComportamientoLabels());
		// Acomodo mis campos dentro de la ventana.
		this.add(jlRegresar);
		this.add(jlImprimir);
		this.add(jtCambio);
		this.add(jlFondo);
		jtCambio.setText(ma.formatoDinero(dameCambio()));
		cambio = jtCambio.getText();
		jtCambio.setEditable(false);
    	setVisible(true);
	}

	public String dameCambio() throws Exception{
		bgPago = new BigDecimal(elPago);
		bgTotal = new BigDecimal(elTotal);
		bgCambio = new BigDecimal("0.00");
		bgCambio = bgTotal.subtract(bgPago);
		bgCambio = bgCambio.setScale(2, RoundingMode.HALF_UP);
		return bgCambio.toString();
	}

// Referencia a mi padre escritorio.
	public void setClaveTicket(int claveTicket){
		this.claveTicket = claveTicket;
	}

// Recibo quien procesa el ticket..
	public void setUsuario(int claveU){
		this.claveU = claveU;
	}

	public void Cierra() {
		this.setVisible(false);
		this.dispose();
		digiCliente.desktop.remove(this);
		if(!digiCliente.arranqueSinEscanner){
			digiCliente.resetHilos();
		}
		digiCliente.jftClave.requestFocus();
	}

	public void ProcesoImprime () throws Exception{
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
		digiCliente.bs.ImprimeTicketDirecto(claveTicket,identificador, claveU, bgTotal.toString(), bgCambio.toString());
	}


	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
		// Si presionaron mi boton mando tocar un sonido
		public void mousePressed(MouseEvent e){
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlImprimir){
					ProcesoImprime();
				}
				else if(temporal == jlRegresar){
					Cierra();
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
		public void mouseReleased(MouseEvent e){
		}
		// Si el mouse se encuentra dentro del área del boton cambio su apariencia.
		public void mouseEntered(MouseEvent e){
			setCursor(deMano);
			JLabel temporal = (JLabel)e.getSource();
			try{
				son.tocaSonido();
				if(temporal == jlImprimir){
					jlImprimir.setIcon(iiBotonImpP);
				}
				else if(temporal == jlRegresar){
					jlRegresar.setIcon(iiBotonRegP);
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
				if(temporal == jlRegresar){
					jlRegresar.setIcon(iiBotonRegN);
				}
				else if(temporal == jlImprimir){
					jlImprimir.setIcon(iiBotonImpN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}
}