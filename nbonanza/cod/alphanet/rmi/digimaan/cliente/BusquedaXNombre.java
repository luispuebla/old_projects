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
import javax.swing.WindowConstants;


public class BusquedaXNombre extends JInternalFrame {

	private String claveProducto = new String("");
	private String nombreBusqueda = "";
	protected DigiCliente digiCliente;
	public JTextField  jtNombre;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra;
	private JLabel  jlBotonQ,  jlBotonW, jlBotonE, jlBotonR, jlBotonT, jlBotonY, jlBotonU, jlBotonI, jlBotonO, jlBotonP, jlBotonA, jlBotonS, jlBotonD, jlBotonF, jlBotonG, jlBotonH, jlBotonJ, jlBotonK, jlBotonL, jlBoton—, jlBotonZ, jlBotonX, jlBotonC, jlBotonV, jlBotonB, jlBotonN, jlBotonM, jlBotonEsp;
	private JLabel jlBorrar, jlCancela, jlAceptar;
	private ImageIcon iiBotonQN, iiBotonQP, iiBotonWN, iiBotonWP, iiBotonEN, iiBotonEP, iiBotonRN, iiBotonRP, iiBotonTN, iiBotonTP, iiBotonYN, iiBotonYP, iiBotonUN, iiBotonUP, iiBotonIN, iiBotonIP, iiBotonON, iiBotonOP, iiBotonPN, iiBotonPP, iiBotonAN, iiBotonAP, iiBotonSN, iiBotonSP, iiBotonDN, iiBotonDP, iiBotonFN, iiBotonFP, iiBotonGN, iiBotonGP, iiBotonHN, iiBotonHP, iiBotonJN, iiBotonJP, iiBotonKN, iiBotonKP, iiBotonLN, iiBotonLP, iiBoton—N, iiBoton—P, iiBotonZN, iiBotonZP, iiBotonXN, iiBotonXP, iiBotonCN, iiBotonCP, iiBotonVN, iiBotonVP, iiBotonBN, iiBotonBP, iiBotonNN, iiBotonNP, iiBotonMN, iiBotonMP, iiBotonEspN, iiBotonEspP, iiBotonBorrarN, iiBotonBorrarP, iiBotonCanN,  iiBotonCanP, iiAceptarN, iiAceptarP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	private ResultSet rsInfoProd = null;
	int tipoPrecio = -1;


	protected void setTipoPrecio (int tipoPrecio){
		this.tipoPrecio = tipoPrecio;
	}


    public BusquedaXNombre() throws Exception {
        super("SelecciÛn Criterio de B˙squeda", false, true, false);
        // TamaÒo de la Ventana
        setSize(840,640);
        // LocalizaciÛn de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,25);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoBusquedaXN.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/QN.jpg");
		iiBotonQN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/QP.jpg");
		iiBotonQP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/WN.jpg");
		iiBotonWN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/WP.jpg");
		iiBotonWP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EN.jpg");
		iiBotonEN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EP.jpg");
		iiBotonEP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/RN.jpg");
		iiBotonRN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/RP.jpg");
		iiBotonRP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/TN.jpg");
		iiBotonTN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/TP.jpg");
		iiBotonTP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/YN.jpg");
		iiBotonYN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/YP.jpg");
		iiBotonYP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/UN.jpg");
		iiBotonUN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/UP.jpg");
		iiBotonUP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/IN.jpg");
		iiBotonIN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/IP.jpg");
		iiBotonIP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ON.jpg");
		iiBotonON = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/OP.jpg");
		iiBotonOP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/PN.jpg");
		iiBotonPN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/PP.jpg");
		iiBotonPP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AN.jpg");
		iiBotonAN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AP.jpg");
		iiBotonAP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SN.jpg");
		iiBotonSN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SP.jpg");
		iiBotonSP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/DN.jpg");
		iiBotonDN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/DP.jpg");
		iiBotonDP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/FN.jpg");
		iiBotonFN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/FP.jpg");
		iiBotonFP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/GN.jpg");
		iiBotonGN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/GP.jpg");
		iiBotonGP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/HN.jpg");
		iiBotonHN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/HP.jpg");
		iiBotonHP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/JN.jpg");
		iiBotonJN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/JP.jpg");
		iiBotonJP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/KN.jpg");
		iiBotonKN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/KP.jpg");
		iiBotonKP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/LN.jpg");
		iiBotonLN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/LP.jpg");
		iiBotonLP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ENEN.jpg");
		iiBoton—N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ENEP.jpg");
		iiBoton—P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ZN.jpg");
		iiBotonZN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ZP.jpg");
		iiBotonZP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/XN.jpg");
		iiBotonXN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/XP.jpg");
		iiBotonXP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CN.jpg");
		iiBotonCN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CP.jpg");
		iiBotonCP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/VN.jpg");
		iiBotonVN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/VP.jpg");
		iiBotonVP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BN.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/NN.jpg");
		iiBotonNN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/NP.jpg");
		iiBotonNP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MN.jpg");
		iiBotonMN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MP.jpg");
		iiBotonMP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EspacioN.jpg");
		iiBotonEspN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EspacioP.jpg");
		iiBotonEspP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCN.jpg");
		iiBotonBorrarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCP.jpg");
		iiBotonBorrarP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCN.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarN.jpg");
		iiAceptarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiAceptarP = new ImageIcon(url);
		// Doy formato a mis campos de Texto:
		jtNombre = new JTextField(30);
		jtNombre.setHorizontalAlignment(JTextField.CENTER);
		jtNombre.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtNombre.setBounds(180,105,355,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlBotonQ= new JLabel(iiBotonQN);
		jlBotonQ.setBounds(20,180,59,59);
		jlBotonQ.addMouseListener(new mouseComportamientoLabels());
		jlBotonW = new JLabel(iiBotonWN);
		jlBotonW.setBounds(100,180,59,59);
		jlBotonW.addMouseListener(new mouseComportamientoLabels());
		jlBotonE = new JLabel(iiBotonEN);
		jlBotonE.setBounds(180,180,59,59);
		jlBotonE.addMouseListener(new mouseComportamientoLabels());
		jlBotonR = new JLabel(iiBotonRN);
		jlBotonR.setBounds(260,180,59,59);
		jlBotonR.addMouseListener(new mouseComportamientoLabels());
		jlBotonT = new JLabel(iiBotonTN);
		jlBotonT.setBounds(340,180,59,59);
		jlBotonT.addMouseListener(new mouseComportamientoLabels());
		jlBotonY = new JLabel(iiBotonYN);
		jlBotonY.setBounds(420,180,59,59);
		jlBotonY.addMouseListener(new mouseComportamientoLabels());
		jlBotonU = new JLabel(iiBotonUN);
		jlBotonU.setBounds(500,180,59,59);
		jlBotonU.addMouseListener(new mouseComportamientoLabels());
		jlBotonI = new JLabel(iiBotonIN);
		jlBotonI.setBounds(580,180,59,59);
		jlBotonI.addMouseListener(new mouseComportamientoLabels());
		jlBotonO = new JLabel(iiBotonON);
		jlBotonO.setBounds(660,180,59,59);
		jlBotonO.addMouseListener(new mouseComportamientoLabels());
		jlBotonP = new JLabel(iiBotonPN);
		jlBotonP.setBounds(740,180,59,59);
		jlBotonP.addMouseListener(new mouseComportamientoLabels());
		jlBotonA = new JLabel(iiBotonAN);
		jlBotonA.setBounds(30,260,59,59);
		jlBotonA.addMouseListener(new mouseComportamientoLabels());
		jlBotonS = new JLabel(iiBotonSN);
		jlBotonS.setBounds(110,260,59,59);
		jlBotonS.addMouseListener(new mouseComportamientoLabels());
		jlBotonD = new JLabel(iiBotonDN);
		jlBotonD.setBounds(190,260,59,59);
		jlBotonD.addMouseListener(new mouseComportamientoLabels());
		jlBotonF = new JLabel(iiBotonFN);
		jlBotonF.setBounds(270,260,59,59);
		jlBotonF.addMouseListener(new mouseComportamientoLabels());
		jlBotonG = new JLabel(iiBotonGN);
		jlBotonG.setBounds(350,260,59,59);
		jlBotonG.addMouseListener(new mouseComportamientoLabels());
		jlBotonH = new JLabel(iiBotonHN);
		jlBotonH.setBounds(430,260,59,59);
		jlBotonH.addMouseListener(new mouseComportamientoLabels());
		jlBotonJ = new JLabel(iiBotonJN);
		jlBotonJ.setBounds(510,260,59,59);
		jlBotonJ.addMouseListener(new mouseComportamientoLabels());
		jlBotonK = new JLabel(iiBotonKN);
		jlBotonK.setBounds(590,260,59,59);
		jlBotonK.addMouseListener(new mouseComportamientoLabels());
		jlBotonL = new JLabel(iiBotonLN);
		jlBotonL.setBounds(670,260,59,59);
		jlBotonL.addMouseListener(new mouseComportamientoLabels());
		jlBoton— = new JLabel(iiBoton—N);
		jlBoton—.setBounds(750,260,59,59);
		jlBoton—.addMouseListener(new mouseComportamientoLabels());
		jlBotonZ = new JLabel(iiBotonZN);
		jlBotonZ.setBounds(50,340,59,59);
		jlBotonZ.addMouseListener(new mouseComportamientoLabels());
		jlBotonX = new JLabel(iiBotonXN);
		jlBotonX.setBounds(130,340,59,59);
		jlBotonX.addMouseListener(new mouseComportamientoLabels());
		jlBotonC = new JLabel(iiBotonCN);
		jlBotonC.setBounds(210,340,59,59);
		jlBotonC.addMouseListener(new mouseComportamientoLabels());
		jlBotonV = new JLabel(iiBotonVN);
		jlBotonV.setBounds(290,340,59,59);
		jlBotonV.addMouseListener(new mouseComportamientoLabels());
		jlBotonB = new JLabel(iiBotonBN);
		jlBotonB.setBounds(370,340,59,59);
		jlBotonB.addMouseListener(new mouseComportamientoLabels());
		jlBotonN = new JLabel(iiBotonNN);
		jlBotonN.setBounds(450,340,59,59);
		jlBotonN.addMouseListener(new mouseComportamientoLabels());
		jlBotonM = new JLabel(iiBotonMN);
		jlBotonM.setBounds(530,340,59,59);
		jlBotonM.addMouseListener(new mouseComportamientoLabels());
		jlBotonEsp = new JLabel(iiBotonEspN);
		jlBotonEsp.setBounds(600,340,209,59);
		jlBotonEsp.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBorrarN);
		jlBorrar.setBounds(560,90,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiAceptarN);
		jlAceptar.setBounds (470,430,165,70);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(190,430,165,70);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		this.add(jlBotonQ);
		this.add(jlBotonW);
		this.add(jlBotonE);
		this.add(jlBotonR);
		this.add(jlBotonT);
		this.add(jlBotonY);
		this.add(jlBotonU);
		this.add(jlBotonI);
		this.add(jlBotonO);
		this.add(jlBotonP);
		this.add(jlBotonA);
		this.add(jlBotonS);
		this.add(jlBotonD);
		this.add(jlBotonF);
		this.add(jlBotonG);
		this.add(jlBotonH);
		this.add(jlBotonJ);
		this.add(jlBotonK);
		this.add(jlBotonL);
		this.add(jlBoton—);
		this.add(jlBotonZ);
		this.add(jlBotonX);
		this.add(jlBotonC);
		this.add(jlBotonV);
		this.add(jlBotonB);
		this.add(jlBotonN);
		this.add(jlBotonM);
		this.add(jlBotonEsp);
		this.add(jlBorrar);
		this.add(jlCancela);
		this.add(jlAceptar);
		this.add(jtNombre);
		this.add(jlFondo);
    	setVisible(true);
		digiCliente.desktop.setSelectedFrame(this);
		this.setSelected(true);
		jtNombre.requestFocus();
	}

	public void procesaBusquedaXN() throws Exception{
		nombreBusqueda = jtNombre.getText();
		if(nombreBusqueda.trim().equalsIgnoreCase("")){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Se debe escribir un criterio de B˙squeda");
			jtNombre.setText("");
			jtNombre.requestFocus();
		}
		else{
			ListaProductosCoincidentes lpc = new ListaProductosCoincidentes();
			lpc.setPadre(digiCliente);
			lpc.setTipoPrecio(tipoPrecio);
			lpc.despliegaInterfaz(nombreBusqueda);
			lpc.setVisible(true);
			digiCliente.desktop.add(lpc);
			lpc.moveToFront();
			digiCliente.desktop.setSelectedFrame(lpc);
			lpc.setSelected(true);
			this.setVisible(false);
			digiCliente.desktop.remove(this);
			this.dispose();
//			System.out.println("Voy a buscar de acuerdo al criterio: "+nombreBusqueda);
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
				if(temporal == jlBotonQ){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"Q");
					}
				}
				else if(temporal == jlBotonW){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"W");
					}
				}
				else if(temporal == jlBotonE){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"E");
					}
				}
				else if(temporal == jlBotonR){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"R");
					}
				}
				else if(temporal == jlBotonT){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"T");
					}
				}
				else if(temporal == jlBotonY){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"Y");
					}
				}
				else if(temporal == jlBotonU){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"U");
					}
				}
				else if(temporal == jlBotonI){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"I");
					}
				}
				else if(temporal == jlBotonO){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"O");
					}
				}
				else if(temporal == jlBotonP){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"P");
					}
				}
				else if(temporal == jlBotonA){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"A");
					}
				}
				else if(temporal == jlBotonS){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"S");
					}
				}
				else if(temporal == jlBotonD){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"D");
					}
				}
				else if(temporal == jlBotonF){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"F");
					}
				}
				else if(temporal == jlBotonG){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"G");
					}
				}
				else if(temporal == jlBotonH){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"H");
					}
				}
				else if(temporal == jlBotonJ){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"J");
					}
				}
				else if(temporal == jlBotonK){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"K");
					}
				}
				else if(temporal == jlBotonL){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"L");
					}
				}
				else if(temporal == jlBoton—){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"—");
					}
				}
				else if(temporal == jlBotonZ){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"Z");
					}
				}
				else if(temporal == jlBotonX){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"X");
					}
				}
				else if(temporal == jlBotonC){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"C");
					}
				}
				else if(temporal == jlBotonV){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"V");
					}
				}
				else if(temporal == jlBotonB){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"B");
					}
				}
				else if(temporal == jlBotonN){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"N");
					}
				}
				else if(temporal == jlBotonM){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+"M");
					}
				}
				else if(temporal == jlBotonEsp){
					String previo = jtNombre.getText();
					if (previo.length() < 20){
						jtNombre.setText(previo+" ");
					}
				}
				else if(temporal == jlBorrar){
					String previo = jtNombre.getText();
					try{
						jtNombre.setText(previo.substring(0, previo.length()-1));
					}
					catch (StringIndexOutOfBoundsException sioobe){
					}
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAceptar){
					procesaBusquedaXN();
				}
			}
			catch (Exception a){
				a.printStackTrace();
			}
		}
		public void mouseReleased(MouseEvent e){
		}
		// Si el mouse se encuentra dentro del ·rea del boton cambio su apariencia.
		public void mouseEntered(MouseEvent e){
			setCursor(deMano);
			try{
				JLabel temporal = (JLabel)e.getSource();
				son.tocaSonido();
				if(temporal == jlBotonQ){
					jlBotonQ.setIcon(iiBotonQP);
				}
				else if(temporal == jlBotonW){
					jlBotonW.setIcon(iiBotonWP);
				}
				else if(temporal == jlBotonE){
					jlBotonE.setIcon(iiBotonEP);
				}
				else if(temporal == jlBotonR){
					jlBotonR.setIcon(iiBotonRP);
				}
				else if(temporal == jlBotonT){
					jlBotonT.setIcon(iiBotonTP);
				}
				else if(temporal == jlBotonY){
					jlBotonY.setIcon(iiBotonYP);
				}
				else if(temporal == jlBotonU){
					jlBotonU.setIcon(iiBotonUP);
				}
				else if(temporal == jlBotonI){
					jlBotonI.setIcon(iiBotonIP);
				}
				else if(temporal == jlBotonO){
					jlBotonO.setIcon(iiBotonOP);
				}
				else if(temporal == jlBotonP){
					jlBotonP.setIcon(iiBotonPP);
				}
				else if(temporal == jlBotonA){
					jlBotonA.setIcon(iiBotonAP);
				}
				else if(temporal == jlBotonS){
					jlBotonS.setIcon(iiBotonSP);
				}
				else if(temporal == jlBotonD){
					jlBotonD.setIcon(iiBotonDP);
				}
				else if(temporal == jlBotonF){
					jlBotonF.setIcon(iiBotonFP);
				}
				else if(temporal == jlBotonG){
					jlBotonG.setIcon(iiBotonGP);
				}
				else if(temporal == jlBotonH){
					jlBotonH.setIcon(iiBotonHP);
				}
				else if(temporal == jlBotonJ){
					jlBotonJ.setIcon(iiBotonJP);
				}
				else if(temporal == jlBotonK){
					jlBotonK.setIcon(iiBotonKP);
				}
				else if(temporal == jlBotonL){
					jlBotonL.setIcon(iiBotonLP);
				}
				else if(temporal == jlBoton—){
					jlBoton—.setIcon(iiBoton—P);
				}
				else if(temporal == jlBotonZ){
					jlBotonZ.setIcon(iiBotonZP);
				}
				else if(temporal == jlBotonX){
					jlBotonX.setIcon(iiBotonXP);
				}
				else if(temporal == jlBotonC){
					jlBotonC.setIcon(iiBotonCP);
				}
				else if(temporal == jlBotonV){
					jlBotonV.setIcon(iiBotonVP);
				}
				else if(temporal == jlBotonB){
					jlBotonB.setIcon(iiBotonBP);
				}
				else if(temporal == jlBotonN){
					jlBotonN.setIcon(iiBotonNP);
				}
				else if(temporal == jlBotonM){
					jlBotonM.setIcon(iiBotonMP);
				}
				else if(temporal == jlBotonEsp){
					jlBotonEsp.setIcon(iiBotonEspP);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBorrarP);
				}
				else if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanP);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiAceptarP);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
		// Si el mouse sale del ·rea de mi boton le devuelvo su primera apariencia.
		public void mouseExited(MouseEvent e){
			setCursor(normal);
			try{
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlBotonQ){
					jlBotonQ.setIcon(iiBotonQN);
				}
				else if(temporal == jlBotonW){
					jlBotonW.setIcon(iiBotonWN);
				}
				else if(temporal == jlBotonE){
					jlBotonE.setIcon(iiBotonEN);
				}
				else if(temporal == jlBotonR){
					jlBotonR.setIcon(iiBotonRN);
				}
				else if(temporal == jlBotonT){
					jlBotonT.setIcon(iiBotonTN);
				}
				else if(temporal == jlBotonY){
					jlBotonY.setIcon(iiBotonYN);
				}
				else if(temporal == jlBotonU){
					jlBotonU.setIcon(iiBotonUN);
				}
				else if(temporal == jlBotonI){
					jlBotonI.setIcon(iiBotonIN);
				}
				else if(temporal == jlBotonO){
					jlBotonO.setIcon(iiBotonON);
				}
				else if(temporal == jlBotonP){
					jlBotonP.setIcon(iiBotonPN);
				}
				else if(temporal == jlBotonA){
					jlBotonA.setIcon(iiBotonAN);
				}
				else if(temporal == jlBotonS){
					jlBotonS.setIcon(iiBotonSN);
				}
				else if(temporal == jlBotonD){
					jlBotonD.setIcon(iiBotonDN);
				}
				else if(temporal == jlBotonF){
					jlBotonF.setIcon(iiBotonFN);
				}
				else if(temporal == jlBotonG){
					jlBotonG.setIcon(iiBotonGN);
				}
				else if(temporal == jlBotonH){
					jlBotonH.setIcon(iiBotonHN);
				}
				else if(temporal == jlBotonJ){
					jlBotonJ.setIcon(iiBotonJN);
				}
				else if(temporal == jlBotonK){
					jlBotonK.setIcon(iiBotonKN);
				}
				else if(temporal == jlBotonL){
					jlBotonL.setIcon(iiBotonLN);
				}
				else if(temporal == jlBoton—){
					jlBoton—.setIcon(iiBoton—N);
				}
				else if(temporal == jlBotonZ){
					jlBotonZ.setIcon(iiBotonZN);
				}
				else if(temporal == jlBotonX){
					jlBotonX.setIcon(iiBotonXN);
				}
				else if(temporal == jlBotonC){
					jlBotonC.setIcon(iiBotonCN);
				}
				else if(temporal == jlBotonV){
					jlBotonV.setIcon(iiBotonVN);
				}
				else if(temporal == jlBotonB){
					jlBotonB.setIcon(iiBotonBN);
				}
				else if(temporal == jlBotonN){
					jlBotonN.setIcon(iiBotonNN);
				}
				else if(temporal == jlBotonM){
					jlBotonM.setIcon(iiBotonMN);
				}
				else if(temporal == jlBotonEsp){
					jlBotonEsp.setIcon(iiBotonEspN);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBorrarN);
				}
				else if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanN);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiAceptarN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}




}