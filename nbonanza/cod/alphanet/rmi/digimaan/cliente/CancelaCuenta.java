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


public class CancelaCuenta extends JInternalFrame {

	private String claveProducto = new String("");
	private int claveU = 0;
	public JTextField  jtClaveU;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	private JLabel jlBorrar, jlCancela, jlEliminar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonElimN, iiBotonElimP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	private ResultSet rsInfoProd = null;
	protected DigiCliente digiCliente;


    public CancelaCuenta() throws Exception {
        super("Eliminar Cuenta", false, true, false);
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
		url= getClass().getResource("/imas/fondoCancelaCuenta.jpg");
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
		url= getClass().getResource("/imas/botones/EliminarN.jpg");
		iiBotonElimN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EliminarP.jpg");
		iiBotonElimP = new ImageIcon(url);
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
		jlBoton1.setBounds(280,200,70,70);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(380,200,70,70);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(480,200,70,70);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(280,280,70,70);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(380,280,70,70);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(480,280,70,70);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(280,360,70,70);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(380,360,70,70);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(480,360,70,70);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(280,440,70,70);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(380,440,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlEliminar= new JLabel(iiBotonElimN);
		jlEliminar.setBounds (600,240,165,70);
		jlEliminar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(600,340,165,70);
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
		this.add(jlEliminar);
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

	public void procesoEliminaCuenta() throws Exception{
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
					resultado = digiCliente.bs.eliminaCuenta(claveU);
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
				// ERROR EN SQL:
				if(resultado == 0){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Error en la conexión con la Base de Datos.");
					jtClaveU.setText("");
				}
				// NO HAY CUENTA EN CURSO
				else if (resultado == 1){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Este usuario ("+claveU+") no tiene actualmente una cuenta en curso.");
					jtClaveU.setText("");
				}
				// ELIMINADO!
				else{
					// DESCARGO ESTA VENTANA
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
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlEliminar){
					procesoEliminaCuenta();
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
				else if(temporal == jlEliminar){
					jlEliminar.setIcon(iiBotonElimP);
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
				else if(temporal == jlEliminar){
					jlEliminar.setIcon(iiBotonElimN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}
}