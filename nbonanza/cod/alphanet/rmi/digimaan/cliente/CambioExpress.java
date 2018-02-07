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


public class CambioExpress extends JInternalFrame {

	protected String claveProducto = new String("");
	protected DigiCliente digiCliente;
	protected int tipoPrecio = 0;
	protected int tipoUnidad = 0;
	protected int banderaCambio = -1;
	protected String autorizacion = "";
	protected String cantidadIntroducida = "";
	private int claveU = 0;
	private	JDesktopPane desktop = null;
	public JTextField  jtPrecioMenu1, jtPrecioMenu2, jtPrecioMM1, jtPrecioMM2, jtPrecioM1, jtPrecioM2;
	public JTextField  jtAutoriza;
	private JLabel jlFondo, jlTacheMenu, jlTacheMM, jlTacheMayo, jlTachePers;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra, letra2;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	private JLabel jlBorrar, jlCancela, jlAceptar;
	private JLabel jlPMenudeo, jlMMayoreo, jlMayoreo, jlPersonal;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAcepN, iiBotonAcepP, iiTache, iiBotonMMN, iiBotonMMP, iiBotonMN, iiBotonMP, iiBotonPerN, iiBotonPerP,  iiBotonPMenuN, iiBotonPMenuP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	private ResultSet rsInfoProd = null;
	protected int formato = 0; // Se si anteriormente estaba por Caja/Pieza o Unidad/Kg.
	protected int tipoProducto = 0; // 1 Solo Kg,  2 Solo unidad,  3 Unidad y Caja, 4 Kg y Pieza

    public CambioExpress() throws Exception {
        super("Cambio de Precio Único", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void setCantidad(String jtCantidad){
		cantidadIntroducida = jtCantidad;
	}

	public void setFormato (int formato){
		this.formato = formato; // 1 Caja/ Pieza    2--> Unidad/Kg.
	}

	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,25);
		letra2=new Font("Arial",Font.PLAIN,14);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoCambioEx.jpg");
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
		url= getClass().getResource("/imas/botones/tacheTP.jpg");
		iiTache = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MMayoreo.jpg");
		iiBotonMMN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MMayoreoP.jpg");
		iiBotonMMP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Mayoreo.jpg");
		iiBotonMN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MayoreoP.jpg");
		iiBotonMP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Personal.jpg");
		iiBotonPerN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/PersonalP.jpg");
		iiBotonPerP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Menudeo.jpg");
		iiBotonPMenuN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MenudeoP.jpg");
		iiBotonPMenuP = new ImageIcon(url);
		jtAutoriza = new JTextField(30);
		jtAutoriza.setHorizontalAlignment(JTextField.CENTER);
		jtAutoriza.setFont(letra);
		jtPrecioMenu1= new JTextField(20);
		jtPrecioMenu1.setHorizontalAlignment(JTextField.LEFT);
		jtPrecioMenu1.setFont(letra2);
		jtPrecioMenu2= new JTextField(20);
		jtPrecioMenu2.setHorizontalAlignment(JTextField.LEFT);
		jtPrecioMenu2.setFont(letra2);
		jtPrecioMM1= new JTextField(20);
		jtPrecioMM1.setHorizontalAlignment(JTextField.LEFT);
		jtPrecioMM1.setFont(letra2);
		jtPrecioMM2= new JTextField(20);
		jtPrecioMM2.setHorizontalAlignment(JTextField.LEFT);
		jtPrecioMM2.setFont(letra2);
		jtPrecioM1= new JTextField(20);
		jtPrecioM1.setHorizontalAlignment(JTextField.LEFT);
		jtPrecioM1.setFont(letra2);
		jtPrecioM2= new JTextField(20);
		jtPrecioM2.setHorizontalAlignment(JTextField.LEFT);
		jtPrecioM2.setFont(letra2);
////////// BORRAME SOLO PRUEBA!!! ::::
//		jtPrecioMenu1.setText("U > $ 50.00");
//		jtPrecioMenu2.setText("C > $ 150.00");
//		jtPrecioMM1.setText("U > $ 49.00");
//		jtPrecioMM2.setText("C > $ 148.00");
//		jtPrecioM1.setText("U > $ 47.00");
//		jtPrecioM2.setText("C > $ 146.00");
////// BORRA HASTA ACA...
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlTacheMenu = new JLabel(iiTache);
		jlTacheMenu.addMouseListener(new mouseComportamientoLabels());
		jlTacheMM = new JLabel(iiTache);
		jlTacheMM.addMouseListener(new mouseComportamientoLabels());
		jlTacheMayo = new JLabel(iiTache);
		jlTacheMayo.addMouseListener(new mouseComportamientoLabels());
		jlTachePers = new JLabel(iiTache);
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
		jlPMenudeo= new JLabel(iiBotonPMenuN);
		jlPMenudeo.addMouseListener(new mouseComportamientoLabels());
		jlMMayoreo= new JLabel(iiBotonMMN);
		jlMMayoreo.addMouseListener(new mouseComportamientoLabels());
		jlMayoreo= new JLabel(iiBotonMN);
		jlMayoreo.addMouseListener(new mouseComportamientoLabels());
		jlPersonal= new JLabel(iiBotonPerN);
		jlPersonal.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAcepN);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Acomodo mis campos dentro de la ventana.
		jlTacheMenu.setBounds(300,115,33,34);
		jtPrecioMenu1.setBounds(348,105,102,25);
		jtPrecioMenu2.setBounds(348,135,102,25);
		jlTacheMM.setBounds(660,115,33,34);
		jtPrecioMM1.setBounds(708,105,102,25);
		jtPrecioMM2.setBounds(708,135,102,25);
		jlTacheMayo.setBounds(300,215,33,34);
		jtPrecioM1.setBounds(348,205,102,25);
		jtPrecioM2.setBounds(348,235,102,25);
		jlTachePers.setBounds(660,215,33,34);
		jlPMenudeo.setBounds(100,100,175,70);
		jlMMayoreo.setBounds(460,100,175,70);
		jlMayoreo.setBounds(100,200,175,70);
		jlPersonal.setBounds(460,200,175,70);
		jtAutoriza.setBounds(280,318,185,40);
		jlBorrar.setBounds(548,306,170,70);
		jlBoton1.setBounds(105,388,70,70);
		jlBoton2.setBounds(210,388,70,70);
		jlBoton3.setBounds(315,388,70,70);
		jlBoton4.setBounds(420,388,70,70);
		jlBoton5.setBounds(525,388,70,70);
		jlAceptar.setBounds (630,388,165,70);
		jlBoton6.setBounds(105,478,70,70);
		jlBoton7.setBounds(210,478,70,70);
		jlBoton8.setBounds(315,478,70,70);
		jlBoton9.setBounds(420,478,70,70);
		jlBoton0.setBounds(525,478,70,70);
		jlCancela.setBounds(630,478,165,70);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
		// Mando a la ventana todos los contenidos.
		this.add(jlPMenudeo);
		this.add(jlMMayoreo);
		this.add(jlMayoreo);
		this.add(jlPersonal);
		this.add(jtPrecioMenu1);
		this.add(jtPrecioMenu2);
		this.add(jtPrecioMM1);
		this.add(jtPrecioMM2);
		this.add(jtPrecioM1);
		this.add(jtPrecioM2);
		this.add(jlTacheMenu);
		this.add(jlTacheMM);
		this.add(jlTacheMayo);
		this.add(jlTachePers);
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
		jtPrecioMenu1.setVisible(false);
		jtPrecioMenu2.setVisible(false);
		jtPrecioMM1.setVisible(false);
		jtPrecioMM2.setVisible(false);
		jtPrecioM1.setVisible(false);
		jtPrecioM2.setVisible(false);
		jlTacheMM.setEnabled(false);
		jlTacheMayo.setEnabled(false);
		jlTachePers.setEnabled(false);
	}


	public void procesoCambiaTipoCuenta() throws Exception{
		int claveAutoriza = ma.cambiaAInt(autorizacion);
		int tipoSolicitado = -1;
		if(claveAutoriza == 0){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "No se puede hacer el cambio sin una clave valida.");
			jtAutoriza.setText("");
			autorizacion = "";
		}
		else{
			boolean valida = false;
			if(jlTacheMenu.isEnabled()){
				tipoSolicitado = 1;
			}
			else if(jlTacheMM.isEnabled()){
				tipoSolicitado = 1;
			}
			else if(jlTacheMayo.isEnabled()){
				tipoSolicitado = 1;
			}
			else if(jlTachePers.isEnabled()){
				tipoSolicitado = 2;
			}
			try{
				valida = digiCliente.bs.verificaAutorizacion(claveAutoriza, tipoSolicitado);
			}
			catch(RemoteException re){
				digiCliente.notificaPerdidaConexion();
				this.setVisible(false);
				this.dispose();
				digiCliente.desktop.remove(this);
				if(!digiCliente.arranqueSinEscanner){
					digiCliente.resetHilos();
				}
				digiCliente.jftClave.requestFocus();
			}
			if(!valida){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "No es válida la clave de Autorización.");
				jtAutoriza.setText("");
				autorizacion = "";
			}
			else{
				if(jlTacheMenu.isEnabled()){
					banderaCambio = 0;
				}
				else if(jlTacheMM.isEnabled()){
					banderaCambio = 1;
				}
				else if(jlTacheMayo.isEnabled()){
					banderaCambio = 2;
				}
				else if(jlTachePers.isEnabled()){
					banderaCambio = 3;
				}
				DatosProducto dp = new DatosProducto();
				// Mando Referencia a mi Interfaz
				dp.setPadre(digiCliente);
				dp.setCambioUnico(banderaCambio);
				dp.setClaveProducto(claveProducto);
				dp.setTipoPrecio(tipoPrecio);
				dp.despliegaInterfaz();
				dp.setVisible(true);
				digiCliente.desktop.add(dp);
				dp.setSelected(true);
				dp.jtCantidad.requestFocus();
				dp.datosPrevios(cantidadIntroducida, formato);
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
			}
		}
	}

	public void Cierra() throws Exception{
		DatosProducto dp = new DatosProducto();
		// Mando Referencia a mi Interfaz
		dp.setPadre(digiCliente);
		dp.setClaveProducto(claveProducto);
		dp.setTipoPrecio(tipoPrecio);
		dp.despliegaInterfaz();
		dp.setVisible(true);
		digiCliente.desktop.add(dp);
		dp.setSelected(true);
		dp.jtCantidad.requestFocus();
		dp.datosPrevios(cantidadIntroducida, formato);
		this.setVisible(false);
		digiCliente.desktop.remove(this);
		this.dispose();
	}


// Referencia a mi padre escritorio.
	public void setInterfaz(JDesktopPane desktop){
		this.desktop = desktop;
	}

// Referencia al tipo de unidad
	public void setTipoUnidad(int tipoUnidad){
		this.tipoUnidad = tipoUnidad;
	}

// Referencia al tipo de unidad
	public void setTipoProducto(int tipoProducto){
		this.tipoProducto = tipoProducto;
	}


// Referencia de Producto pedido.
	public void setClaveProducto (String claveProducto){
		this.claveProducto = claveProducto;
	}

// Referencia de Tipo de Precio.
	public void setTipoPrecio (int tipoPrecio){
		this.tipoPrecio = tipoPrecio;
	}


// Referencia a la cantidad escrita previamente...
	public void setCantidadIntroducida(String cantidadIntroducida){
		this.cantidadIntroducida = cantidadIntroducida;
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
				else if(temporal == jlPMenudeo){
					jlTacheMM.setEnabled(false);
					jlTacheMayo.setEnabled(false);
					jlTachePers.setEnabled(false);
					jlTacheMenu.setEnabled(true);
				}
				else if(temporal == jlMMayoreo){
					jlTacheMM.setEnabled(true);
					jlTacheMayo.setEnabled(false);
					jlTachePers.setEnabled(false);
					jlTacheMenu.setEnabled(false);
				}
				else if(temporal == jlMayoreo){
					jlTacheMM.setEnabled(false);
					jlTacheMayo.setEnabled(true);
					jlTachePers.setEnabled(false);
					jlTacheMenu.setEnabled(false);
				}
				else if(temporal == jlPersonal){
					jlTacheMM.setEnabled(false);
					jlTacheMayo.setEnabled(false);
					jlTachePers.setEnabled(true);
					jlTacheMenu.setEnabled(false);
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
				if(temporal == jlTacheMenu){
					if(tipoProducto == 1){
						jtPrecioMenu1.setText("Kg> $ "+digiCliente.bs.damePrecio("precioMenu", claveProducto));
						jtPrecioMenu1.setVisible(true);
					}
					else if (tipoProducto == 2){
						jtPrecioMenu1.setText("U > $ "+digiCliente.bs.damePrecio("precioMenu", claveProducto));
						jtPrecioMenu1.setVisible(true);
					}
					else if (tipoProducto == 3){
						jtPrecioMenu1.setText("U > $ "+digiCliente.bs.damePrecio("precioMenu", claveProducto));
						jtPrecioMenu1.setVisible(true);
						jtPrecioMenu2.setText("C > $ "+digiCliente.bs.damePrecio("precioMenuC", claveProducto));
						jtPrecioMenu2.setVisible(true);
					}
					else if (tipoProducto == 4){
						jtPrecioMenu1.setText("Kg> $ "+digiCliente.bs.damePrecio("precioMenu", claveProducto));
						jtPrecioMenu1.setVisible(true);
						jtPrecioMenu2.setText("Pz> $ "+digiCliente.bs.damePrecio("precioMenuC", claveProducto));
						jtPrecioMenu2.setVisible(true);
					}
				}
				else  if(temporal == jlTacheMM){
					if(tipoProducto == 1){
						jtPrecioMM1.setText("Kg> $ "+digiCliente.bs.damePrecio("precioMM", claveProducto));
						jtPrecioMM1.setVisible(true);
					}
					else if (tipoProducto == 2){
						jtPrecioMM1.setText("U > $ "+digiCliente.bs.damePrecio("precioMM", claveProducto));
						jtPrecioMM1.setVisible(true);
					}
					else if (tipoProducto == 3){
						jtPrecioMM1.setText("U > $ "+digiCliente.bs.damePrecio("precioMM", claveProducto));
						jtPrecioMM1.setVisible(true);
						jtPrecioMM2.setText("C > $ "+digiCliente.bs.damePrecio("precioMMC", claveProducto));
						jtPrecioMM2.setVisible(true);
					}
					else if (tipoProducto == 4){
						jtPrecioMM1.setText("Kg> $ "+digiCliente.bs.damePrecio("precioMM", claveProducto));
						jtPrecioMM1.setVisible(true);
						jtPrecioMM2.setText("Pz> $ "+digiCliente.bs.damePrecio("precioMMC", claveProducto));
						jtPrecioMM2.setVisible(true);
					}
				}
				else if(temporal == jlTacheMayo){
					if(tipoProducto == 1){
						jtPrecioM1.setText("Kg> $ "+digiCliente.bs.damePrecio("precioM", claveProducto));
						jtPrecioM1.setVisible(true);
					}
					else if (tipoProducto == 2){
						jtPrecioM1.setText("U > $ "+digiCliente.bs.damePrecio("precioM", claveProducto));
						jtPrecioM1.setVisible(true);
					}
					else if (tipoProducto == 3){
						jtPrecioM1.setText("U > $ "+digiCliente.bs.damePrecio("precioM", claveProducto));
						jtPrecioM1.setVisible(true);
						jtPrecioM2.setText("C > $ "+digiCliente.bs.damePrecio("precioMC", claveProducto));
						jtPrecioM2.setVisible(true);
					}
					else if (tipoProducto == 4){
						jtPrecioM1.setText("Kg> $ "+digiCliente.bs.damePrecio("precioM", claveProducto));
						jtPrecioM1.setVisible(true);
						jtPrecioM2.setText("Pz> $ "+digiCliente.bs.damePrecio("precioMC", claveProducto));
						jtPrecioM2.setVisible(true);
					}
				}
				else if(temporal == jlBoton1){
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
				else if(temporal == jlPMenudeo){
					jlPMenudeo.setIcon(iiBotonPMenuP);
				}
				else if(temporal == jlMMayoreo){
					jlMMayoreo.setIcon(iiBotonMMP);
				}
				else if(temporal == jlMayoreo){
					jlMayoreo.setIcon(iiBotonMP);
				}
				else if(temporal == jlPersonal){
					jlPersonal.setIcon(iiBotonPerP);
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
				if(temporal == jlTacheMenu){
					jtPrecioMenu1.setVisible(false);
					jtPrecioMenu2.setVisible(false);
				}
				else if(temporal == jlTacheMM){
					jtPrecioMM1.setVisible(false);
					jtPrecioMM2.setVisible(false);
				}
				else if(temporal == jlTacheMayo){
					jtPrecioM1.setVisible(false);
					jtPrecioM2.setVisible(false);
				}
				else if(temporal == jlBoton1){
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
				else if(temporal == jlPMenudeo){
					jlPMenudeo.setIcon(iiBotonPMenuN);
				}
				else if(temporal == jlMMayoreo){
					jlMMayoreo.setIcon(iiBotonMMN);
				}
				else if(temporal == jlMayoreo){
					jlMayoreo.setIcon(iiBotonMN);
				}
				else if(temporal == jlPersonal){
					jlPersonal.setIcon(iiBotonPerN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}

}