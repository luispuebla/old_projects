package alphanet.rmi.digimaan.cliente;

import java.awt.Font;
import java.awt.Image;
import java.awt.Color;
import java.awt.Frame;
import java.awt.Toolkit;
import java.awt.Component;
import javax.swing.UIManager;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JButton;
import javax.swing.JLabel;
import java.net.URL;
import javax.swing.WindowConstants;
import java.awt.Cursor;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import javax.swing.JTextField;
import javax.swing.JOptionPane;

public class ModificaCantidad extends JDialog{

	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra, letra2;
	protected JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0, jlBotonMedio;
	protected JLabel jlBorrar, jlAceptar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonMN, iiBotonMP, iiBotonBN, iiBotonBP, iiBotonAcepN, iiBotonAcepP;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private Image imagen;
	private Color colorletra;
	private static final long serialVersionUID = 1L;
	protected String nombreArticulo;
	protected String unidadP;
	protected String cantidad;
	protected double nuevaCantidad = 0.00;
	private JTextField jtCantidad, jtUnidad, jtArticulo;
	private Sound son;
	protected ManagerAuxiliar ma = new ManagerAuxiliar();
	protected boolean primerTacto = false;

	public ModificaCantidad (Frame padre, String titulo, boolean modal, String unidadP, String nombreArticulo, String cantidad) throws Exception {
		super(padre, titulo,modal);
		this.nombreArticulo = nombreArticulo;
		StringBuilder sbUnidadP = new StringBuilder(unidadP);
		if(sbUnidadP.indexOf("(") != -1){
			sbUnidadP.delete(sbUnidadP.indexOf("("), sbUnidadP.length());
		}
		this.unidadP = sbUnidadP.toString().trim();
		StringBuilder sbCantidad = new StringBuilder(cantidad);
		if(sbCantidad.indexOf("(") != -1){
			sbCantidad.delete(sbCantidad.indexOf("("), sbCantidad.length());
		}
		this.cantidad = sbCantidad.toString().trim();
		// con esto aseguro que no puedan cerrar mi ventana de manera tradicional.
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void dibujaDialogo() throws Exception {
		son = new Sound();
		// El tamaño del Diálogo
		setSize(712,550);
		letra=new Font("Eras Demin ITC",Font.BOLD,25);
		letra2=new Font("Eras Demin ITC",Font.PLAIN,19);
		colorletra=new Color(255,255,255);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoNuevaCantidad.jpg");
		iiFondo = new ImageIcon(url);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,705,519);
		jtCantidad = new JTextField(30);
		jtCantidad.setHorizontalAlignment(JTextField.CENTER);
		jtCantidad.setFont(letra);
		jtCantidad.setBounds(275,115,150,50);
		jtCantidad.setText(cantidad);
		jtCantidad.setEditable(false);
		jtUnidad = new JTextField(30);
		jtUnidad.setHorizontalAlignment(JTextField.CENTER);
		jtUnidad.setFont(letra2);
		jtUnidad.setBounds(450,7,80,37);
		jtUnidad.setText(unidadP);
		jtUnidad.setEditable(false);
		jtArticulo = new JTextField(30);
		jtArticulo.setHorizontalAlignment(JTextField.CENTER);
		jtArticulo.setFont(letra2);
		jtArticulo.setBounds(82,46,560,40);
		jtArticulo.setText(nombreArticulo);
		jtArticulo.setEditable(false);
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
		url= getClass().getResource("/imas/botones/MedioN.jpg");
		iiBotonMN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MedioP.jpg");
		iiBotonMP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCN.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarN.jpg");
		iiBotonAcepN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAcepP = new ImageIcon(url);
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(200,190,70,70);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(290,190,70,70);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(380,190,70,70);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(200,270,70,70);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(290,270,70,70);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(380,270,70,70);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(200,350,70,70);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(290,350,70,70);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(380,350,70,70);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(290,430,70,70);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBotonMedio = new JLabel(iiBotonMN);
		jlBotonMedio.setBounds(380,430,70,70);
		jlBotonMedio.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(510,100,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAcepN);
		jlAceptar.setBounds (510,230,165,70);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		// La textura de fondo (propiedad heredada de Kiwi)
		//setTexture(imagen);
		// Se prohibe modificar sus dimensiones al momento de ejecución
		setResizable(false);
		// Lleno mi contenedor con los elementos para que los despliegue
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		getContentPane().add(jlBoton1);
		getContentPane().add(jlBoton2);
		getContentPane().add(jlBoton3);
		getContentPane().add(jlBoton4);
		getContentPane().add(jlBoton5);
		getContentPane().add(jlBoton6);
		getContentPane().add(jlBoton7);
		getContentPane().add(jlBoton8);
		getContentPane().add(jlBoton9);
		getContentPane().add(jlBoton0);
		if(unidadP.equalsIgnoreCase("Caja") || unidadP.equalsIgnoreCase("Pieza")){
			getContentPane().add(jlBotonMedio);
		}
		getContentPane().add(jlBorrar);
		getContentPane().add(jlBorrar);
		getContentPane().add(jlAceptar);
		getContentPane().add(jtCantidad);
		getContentPane().add(jtUnidad);
		getContentPane().add(jtArticulo);
		getContentPane().add(jlFondo);
		// Muestro el contenido del contenedor
		setVisible(true);
	}

// Utileria para quitar los puntos.
	private String remuevePuntuacion(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(".") != -1){
			sb.deleteCharAt(sb.indexOf("."));
		}
		return formato = new String(sb.toString());
	}

// Formato a desplegar cuando se trata de un producto que se vende de acuerdo a su peso.
	private String formatoKG (String previo, String nuevo){
		previo = remuevePuntuacion(previo);
		previo = previo +nuevo;
		if(previo.length() == 1){
			previo = ".00"+previo;
		}
		else if(previo.length() == 2){
			previo = ".0"+previo;
		}
		else{
			StringBuilder sb = new StringBuilder(previo);
			sb.insert((previo.length()-3),'.');
			previo = sb.toString();
		}
		if(previo.startsWith("0")){
			previo=previo.substring(1, previo.length());
		}
		return previo;
	}

// Inicio proceso para agregar producto seleccionado.
	private void procesoAcepta() throws Exception{
		// Valido que me hayan escrito una cantidad > 0
		nuevaCantidad = ma.cambiaADouble(jtCantidad.getText());
		if (nuevaCantidad<=0.0){
			JOptionPane.showMessageDialog(this, "La cantidad debe ser mayor a 0.");
			jtCantidad.setText("");
		}
		else {
			this.setVisible(false);
			this.dispose();
		}
	}


	public void Cierra() {
		this.setVisible(false);
		this.dispose();
	}

	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if (!primerTacto){
					if(temporal == jlBoton1 || temporal == jlBoton2 || temporal == jlBoton3 || temporal == jlBoton4 || temporal == jlBoton5 || temporal == jlBoton6 || temporal == jlBoton7 || temporal == jlBoton8 || temporal == jlBoton9 || temporal == jlBoton0 || temporal == jlBotonMedio){
					jtCantidad.setText("");
					}
					primerTacto = true;
				}



				if(temporal == jlBoton1){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"1"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"1");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"1");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"1"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton2){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"2"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"2");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"2");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"2"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton3){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"3"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"3");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"3");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"3"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton4){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"4"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"4");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"4");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"4"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton5){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"5"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"5");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"5");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"5"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton6){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"6"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"6");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"6");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"6"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton7){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"7"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"7");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"7");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"7"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton8){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"8"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"8");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"8");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"8"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton9){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"9"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"9");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"9");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"9"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton0){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(unidadP.equalsIgnoreCase("Kilo")){
							jtCantidad.setText(formatoKG(previo,"0"));
						}
						else if(unidadP.equalsIgnoreCase("Unidad")) {
							jtCantidad.setText(previo+"0");
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"0");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"0"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBotonMedio){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						StringBuilder sb = new StringBuilder(previo);
						if (sb.indexOf(".5") == -1){
							jtCantidad.setText(previo+".5");
						}
					}
				}
				else if(temporal == jlBorrar){
					jtCantidad.setText("");
				}
				else if(temporal == jlBorrar){
					Cierra();
				}
				else if(temporal == jlAceptar){
					procesoAcepta();
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
				else if(temporal == jlBotonMedio){
					jlBotonMedio.setIcon(iiBotonMP);
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
				else if(temporal == jlBotonMedio){
					jlBotonMedio.setIcon(iiBotonMN);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBN);
				}
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