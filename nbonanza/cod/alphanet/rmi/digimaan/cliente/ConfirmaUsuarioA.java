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
import java.awt.event.FocusListener;
import java.awt.event.FocusEvent;
import java.text.NumberFormat;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.rmi.RemoteException;
import javax.swing.WindowConstants;

public class ConfirmaUsuarioA extends JInternalFrame {

	private	JDesktopPane desktop = null;
	public JTextField jtUsuario;
	private JTextField jftContra;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected DigiCliente digiCliente;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	protected JLabel jlBorrar, jlCancela, jlAgregar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAgreN,iiBotonAgreP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
    protected int claveTicket = 0;
    protected String elTotal = "";
    protected int claveU = 0;
    protected String contraU = "";


    public ConfirmaUsuarioA() throws Exception {
        super("Confirmación Usuario Autorizado", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void setClaveTicket(int claveTicket){
		this.claveTicket = claveTicket;
	}

// Recibo quien procesa el ticket..
	public void setUsuario(int claveU){
		this.claveU = claveU;
	}


	public class validaFoco implements FocusListener{
		public void focusGained (FocusEvent e){
			JTextField temporal = (JTextField) e.getSource();
			 if(temporal == jtUsuario){
				 jftContra.requestFocus();
			 }
			 else{
				 jftContra.setText("");
			 }
		}
		public void focusLost (FocusEvent e){

		}
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,20);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoUsuarioAutorizado.jpg");
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
		url= getClass().getResource("/imas/botones/CNormalN.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CNormalP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarN.jpg");
		iiBotonAgreN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAgreP = new ImageIcon(url);
		// Doy formato a mis campos de Texto:
		jftContra = new JTextField(30);
		jftContra.setFont(letra);
		jftContra.setHorizontalAlignment(JTextField.CENTER);
		jtUsuario = new JTextField(30);
		jtUsuario.setHorizontalAlignment(JTextField.CENTER);
		jtUsuario.setFont(letra);
		jftContra.addFocusListener(new validaFoco());
		jtUsuario.addFocusListener(new validaFoco());
		// Acomodo mis campos dentro de la ventana.
		jtUsuario.setBounds(190,60,450,40);
		jftContra.setBounds(270,125,250,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
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
		jlAgregar= new JLabel(iiBotonAgreN);
		jlAgregar.setBounds (570,280,165,70);
		jlAgregar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(570,380,165,70);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
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
		this.add(jlCancela);
		this.add(jlAgregar);
		this.add(jtUsuario);
		this.add(jftContra);
		this.add(jlFondo);
		try{
			jtUsuario.setText(digiCliente.bs.dameNombreVendedor(claveU));
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
    	jtUsuario.setEditable(false);
    	jftContra.setEditable(false);
    	jftContra.requestFocus();
    	setVisible(true);
	}

// Referencia directa a la DigiCliente para cambiar valor de tipoPrecio.
	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}


// Utileria para quitar los puntos.
	private String remuevePuntuacion(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(".") != -1){
			sb.deleteCharAt(sb.indexOf("."));
		}
		return formato = new String(sb.toString());
	}

// Utileria para quitar las comas.
	private String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}


// Inicio proceso para agregar producto seleccionado.
	private void procesoAgrega() throws Exception{
		// Valido que me hayan escrito una contraseña
		if(jftContra.getText().trim().length() == 0){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Debes escribir la contraseña o bien presionar  \"C. Normal\" para imprimir un ticket a pagar en Caja");
			jftContra.requestFocus();
		}
		// Ahora checo que la contraseña corresponda con la de mi Usuario.
		else{
			boolean concuerdaContra = false;
			try{
				concuerdaContra = digiCliente.bs.confirmaContra(contraU, claveU);
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
			if(!concuerdaContra){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "La contraseña no concuerda con la registrada, intentelo de nuevo.");
				jftContra.setText("");
				contraU = "";
				jftContra.requestFocus();
			}
			else{
				CapturaPago cp = new CapturaPago();
				cp.setPadre(digiCliente);
				cp.setClaveTicket(claveTicket);
				cp.setUsuario(claveU);
				cp.despliegaInterfaz();
				cp.setVisible(true);
				digiCliente.desktop.add(cp);
				cp.moveToFront();
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
				digiCliente.desktop.setSelectedFrame(cp);
				cp.setSelected(true);
			}
		// Todo bien mando a mi pantalla de cobro.
		}
	}

	public void Cierra() throws Exception{
		ImpresionTicket2 it = new ImpresionTicket2();
		it.setPadre(digiCliente);
		it.setClaveTicket(claveTicket);
		it.setUsuario(claveU);
		it.despliegaInterfaz();
		it.setVisible(true);
		digiCliente.desktop.add(it);
		it.moveToFront();
		this.setVisible(false);
		digiCliente.desktop.remove(this);
		this.dispose();
		digiCliente.desktop.setSelectedFrame(it);
		it.setSelected(true);
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
				String previo = jftContra.getText().trim();
				if(temporal == jlBoton1){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						 contraU = contraU +"1";
					}
				}
				else if(temporal == jlBoton2){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"2";
					}
				}
				else if(temporal == jlBoton3){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"3";
					}
				}
				else if(temporal == jlBoton4){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"4";
					}
				}
				else if(temporal == jlBoton5){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"5";
					}
				}
				else if(temporal == jlBoton6){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"6";
					}
				}
				else if(temporal == jlBoton7){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"7";
					}
				}
				else if(temporal == jlBoton8){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"8";
					}
				}
				else if(temporal == jlBoton9){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"9";
					}
				}
				else if(temporal == jlBoton0){
					if (previo.length() < 4){
						jftContra.setText(jftContra.getText()+("*"));
						contraU = contraU +"0";
					}
				}
				else if(temporal == jlBorrar){
					jftContra.setText("");
					contraU = "";
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAgregar){
					procesoAgrega();
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
				else if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanP);
				}
				else if(temporal == jlAgregar){
					jlAgregar.setIcon(iiBotonAgreP);
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
				else if(temporal == jlAgregar){
					jlAgregar.setIcon(iiBotonAgreN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}




}