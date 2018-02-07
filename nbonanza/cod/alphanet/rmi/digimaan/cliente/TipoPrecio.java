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
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.rmi.RemoteException;
import javax.swing.WindowConstants;


public class TipoPrecio extends JInternalFrame {

	private String claveProducto = new String("");
	protected String autorizacion = "";
	private int claveU = 0;
	protected DigiCliente digiCliente;
	public JTextField  jtAutoriza;
	private JLabel jlFondo, jlTacheMen, jlTacheMM, jlTacheM;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	private JLabel jlBorrar, jlCancela, jlAceptar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAcepN, iiBotonAcepP, iiTache;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();


    public TipoPrecio() throws Exception {
        super("Cambio de Precio", false, true, false);
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
		url= getClass().getResource("/imas/fondoTipoPrecio.jpg");
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
		url= getClass().getResource("/imas/botones/tacheUni.png");
		iiTache = new ImageIcon(url);
		// Doy formato a mis campos de Texto:
		jtAutoriza = new JTextField(30);
		jtAutoriza.setHorizontalAlignment(JTextField.CENTER);
		jtAutoriza.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtAutoriza.setBounds(275,305,185,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlTacheMen = new JLabel(iiTache);
		jlTacheMen.setBounds(449,93,39,40);
		jlTacheMen.addMouseListener(new mouseComportamientoLabels());
		jlTacheMM = new JLabel(iiTache);
		jlTacheMM.setBounds(273,198,39,40);
		jlTacheMM.addMouseListener(new mouseComportamientoLabels());
		jlTacheM = new JLabel(iiTache);
		jlTacheM.setBounds(591,198,39,40);
		jlTacheM.addMouseListener(new mouseComportamientoLabels());
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(105,388,70,70);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(210,388,70,70);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(315,388,70,70);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(420,388,70,70);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(525,388,70,70);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(105,478,70,70);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(210,478,70,70);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(315,478,70,70);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(420,478,70,70);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(525,478,70,70);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(548,306,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAcepN);
		jlAceptar.setBounds (630,388,165,70);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(630,478,165,70);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		this.add(jlTacheMen);
		this.add(jlTacheMM);
		this.add(jlTacheM);
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
		this.add(jlCancela);
		this.add(jlAceptar);
		this.add(jtAutoriza);
		this.add(jlFondo);
    	setVisible(true);
		digiCliente.desktop.setSelectedFrame(this);
		this.setSelected(true);
		jlTacheMM.setEnabled(false);
		jlTacheM.setEnabled(false);
		jtAutoriza.requestFocus();
	}


	public void procesoCambiaTipoCuenta() throws Exception{
		if(jlTacheMen.isEnabled()){
			digiCliente.tipoPrecio=0;
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
		}
		else{
			int claveAutoriza = ma.cambiaAInt(autorizacion);
			if(claveAutoriza == 0){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "No se puede hacer el cambio sin una clave valida.");
				jtAutoriza.setText("");
				autorizacion = "";
			}
			else{
				boolean valida = false;
				try{
					valida = digiCliente.bs.verificaAutorizacion(claveAutoriza, 1);
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
				if(!valida){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "No es válida la clave de Autorización.");
					jtAutoriza.setText("");
					autorizacion = "";
				}
				else{
					if(jlTacheMM.isEnabled()){
						digiCliente.tipoPrecio=1;
					}
					else if(jlTacheM.isEnabled()){
						digiCliente.tipoPrecio=2;
					}
					this.setVisible(false);
					this.dispose();
					digiCliente.desktop.remove(this);
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
				}
			}
		}
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


// Referencia directa a la DigiCliente para cambiar valor de tipoPrecio.
	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
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
				if(temporal == jlBoton1){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"1";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton2){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"2";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton3){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"3";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton4){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"4";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton5){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"5";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton6){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"6";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton7){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"7";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton8){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"8";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton9){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"9";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBoton0){
					String previo = jtAutoriza.getText();
					autorizacion = autorizacion +"0";
					if (previo.length() < 4){
						jtAutoriza.setText(previo+"*");
					}
				}
				else if(temporal == jlBorrar){
					jtAutoriza.setText("");
					autorizacion = "";
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAceptar){
					procesoCambiaTipoCuenta();
				}
				else if(temporal == jlTacheMen){
					jlTacheMM.setEnabled(false);
					jlTacheM.setEnabled(false);
					jlTacheMen.setEnabled(true);
				}
				else if(temporal == jlTacheMM){
					jlTacheMM.setEnabled(true);
					jlTacheM.setEnabled(false);
					jlTacheMen.setEnabled(false);
				}
				else if(temporal == jlTacheM){
					jlTacheMM.setEnabled(false);
					jlTacheM.setEnabled(true);
					jlTacheMen.setEnabled(false);
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
				son.tocaSonido();
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
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAcepP);
				}
				else if(temporal == jlTacheMen){
				}
				else if(temporal == jlTacheMM){
				}
				else if(temporal == jlTacheM){
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
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAcepN);
				}
				else if(temporal == jlTacheMen){
				}
				else if(temporal == jlTacheMM){
				}
				else if(temporal == jlTacheM){
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}


}