package alphanet.rmi.digimaan.cliente;

import javax.swing.JInternalFrame;
import javax.swing.JFrame;
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
import javax.swing.JFormattedTextField;
import java.text.NumberFormat;
import java.awt.event.FocusListener;
import java.awt.event.FocusEvent;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.rmi.RemoteException;
import javax.swing.WindowConstants;
import java.util.Vector;

public class CapturaPago extends JInternalFrame {

	protected DigiCliente digiCliente;
	protected String autorizacion = "";
	protected int claveTicket = 0;
	protected String elPago = "0.00";
	private int claveU = 0;
	public JTextField  jtMontoP;
	protected JFormattedTextField jftCantidad;
	private JLabel jlFondo, jlTacheN, jlTacheGP1, jlTacheGP2, jlTacheGP3, jlTacheGP4, jlTacheGP5, jlTacheGP6;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	private JLabel jlBorrar, jlCancela, jlAceptar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAcepN, iiBotonAcepP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	protected double cantidadInicial = 0.00;
    private NumberFormat formatoCantidad;


    public CapturaPago() throws Exception {
        super("Captura De Pago", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}

	public void setClaveTicket(int claveTicket){
		this.claveTicket = claveTicket;
	}

// Recibo quien procesa el ticket..
	public void setUsuario(int claveU){
		this.claveU = claveU;
	}

	public void despliegaInterfaz() throws Exception{
		setUpFormatos();
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,25);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoCapturaMontoPago.jpg");
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
		url= getClass().getResource("/imas/botones/CancelarCN.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarN.jpg");
		iiBotonAcepN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAcepP = new ImageIcon(url);
		jtMontoP = new JTextField(30);
		jtMontoP.setHorizontalAlignment(JTextField.CENTER);
		jtMontoP.setFont(letra);
		jftCantidad = new JFormattedTextField(formatoCantidad);
        jftCantidad.setValue(new Double (cantidadInicial));
        jftCantidad.setColumns(12);
		jftCantidad.setFont(letra);
		jftCantidad.setHorizontalAlignment(JFormattedTextField.RIGHT);
		jtMontoP.addFocusListener(new validaFoco());
		jftCantidad.addFocusListener(new validaFoco());
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAcepN);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
//		jlCancela= new JLabel(iiBotonCanN);
//		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Acomodo mis campos dentro de la ventana.
		jtMontoP.setBounds(290,65,200,40);
		jftCantidad.setBounds(310,165,200,40);
		jlAceptar.setBounds (610,320,165,70);
		jlBorrar.setBounds(590,140,170,70);
		jlBoton1.setBounds(240,230,70,70);
		jlBoton2.setBounds(350,230,70,70);
		jlBoton3.setBounds(460,230,70,70);
		jlBoton4.setBounds(240,320,70,70);
		jlBoton5.setBounds(350,320,70,70);
		jlBoton6.setBounds(460,320,70,70);
		jlBoton7.setBounds(240,410,70,70);
		jlBoton8.setBounds(350,410,70,70);
		jlBoton9.setBounds(460,410,70,70);
		jlBoton0.setBounds(350,500,70,70);
//		jlCancela.setBounds(617,477,170,70);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
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
//		this.add(jlCancela);
		this.add(jlAceptar);
		this.add(jtMontoP);
		this.add(jftCantidad);
		this.add(jlFondo);
		try{
			jtMontoP.setText(digiCliente.bs.sumaPagoProductosFin(claveTicket));
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
		jtMontoP.setEditable(false);
		jftCantidad.setEditable(false);
		jftCantidad.requestFocus();
		setVisible(true);
	}


	public class validaFoco implements FocusListener{
		public void focusGained (FocusEvent e){
			if(e.getSource().getClass() == (Object)jtMontoP.getClass()){
				jftCantidad.requestFocus();
			}
			else{
				jftCantidad.setText("0.00");
			}
		}
		public void focusLost (FocusEvent e){
		}
	}


	public void procesoCapturaPago() throws Exception{
		if(ma.cambiaADouble(elPago) < ma.cambiaADouble(jtMontoP.getText())){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "La Cantidad es menor que el Monto, favor de Corregir");
			jftCantidad.requestFocus();
		}
		else{
			Vector <String> exito = new Vector <String>();
			try{
				exito = digiCliente.bs.procesaPagoDescuento(claveTicket, claveU);
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
			if(exito.elementAt(0).equalsIgnoreCase("Exito")){
				ImpresionTicketU itu = new ImpresionTicketU();
				itu.setPadre(digiCliente);
				itu.setClaveTicket(claveTicket);
				itu.setElTotal(ma.remueveComas(jftCantidad.getText()));
				itu.setElPago(ma.remueveComas(jtMontoP.getText()));
				itu.setUsuario(claveU);
				itu.despliegaInterfaz();
				itu.setVisible(true);
				digiCliente.desktop.add(itu);
				itu.moveToFront();
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
				digiCliente.desktop.setSelectedFrame(itu);
				itu.setSelected(true);
			}
			else if(exito.elementAt(0).equalsIgnoreCase("Error")){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Error de conexion con el Servidor, no se guardo la venta");
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
				if(!digiCliente.arranqueSinEscanner){
					digiCliente.resetHilos();
				}
				digiCliente.jftClave.requestFocus();
			}
			else {
				for(int i=0; i<exito.size(); i++){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, exito.elementAt(i));
				}
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
				if(!digiCliente.arranqueSinEscanner){
					digiCliente.resetHilos();
				}
				digiCliente.jftClave.requestFocus();
			}
		}
	}


    private void setUpFormatos() {
       formatoCantidad = NumberFormat.getNumberInstance();
       formatoCantidad.setMinimumFractionDigits(2);
    }

// Utileria para quitar los puntos.
	private String remuevePuntuacion(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(".") != -1){
			sb.deleteCharAt(sb.indexOf("."));
		}
		return formato = new String(sb.toString());
	}

	private String formatoInicial (String previo, String nuevo){
		if(previo.startsWith("0")){
			previo = previo.substring(1, previo.length());
		}
		previo = remuevePuntuacion(previo);
		previo = previo +nuevo;
		if(previo.length() == 1){
			previo = ".0"+previo;
		}
		else{
			StringBuilder sb = new StringBuilder(previo);
			sb.insert((previo.length()-2),'.');
			previo = sb.toString();
		}
		if(previo.startsWith("0")){
			previo=previo.substring(1, previo.length());
		}
		return previo;
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
				String previo = jftCantidad.getText();
				if(temporal == jlBoton1){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"1")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton2){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"2")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton3){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"3")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton4){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"4")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton5){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"5")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton6){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"6")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton7){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"7")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton8){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"8")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton9){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"9")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBoton0){
					if (previo.length() < 10){
						jftCantidad.setText(ma.formatoDinero(formatoInicial(ma.remueveComas(previo),"0")));
						elPago = ma.remueveComas(jftCantidad.getText());
					}
				}
				else if(temporal == jlBorrar){
					jftCantidad.setText("0.00");
					elPago = "0.00";
				}
//				else if(temporal == jlCancela){
//					Cierra();
//				}
				else if(temporal == jlAceptar){
					procesoCapturaPago();
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
			try{
				JLabel temporal = (JLabel)e.getSource();
				son.tocaSonido();
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
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAcepP);
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
//				else if(temporal == jlCancela){
//					jlCancela.setIcon(iiBotonCanN);
//				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAcepN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}

}