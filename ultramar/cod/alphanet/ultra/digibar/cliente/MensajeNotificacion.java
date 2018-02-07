package alphanet.ultra.digibar.cliente;

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

public class MensajeNotificacion extends JDialog{

	private JLabel jlFondo;
	private JButton jlBoton;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra;
	protected JLabel jlAceptar, jlAviso, jlAviso2, jlAviso3;
	private ImageIcon iiBotonAceptarN,iiBotonAceptarP;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private Image imagen;
	protected String aviso, aviso2, aviso3;
	private Color colorletra;
	private static final long serialVersionUID = 1L;
	protected int numAvisos = 1;


	public MensajeNotificacion (Frame padre, String titulo, boolean modal, String aviso) throws Exception {
		super(padre, titulo,modal);
		this.aviso = aviso;
		// con esto aseguro que no puedan cerrar mi ventana de manera tradicional.
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
		arreglaAviso();
	}

	public void arreglaAviso()throws Exception{
		if(aviso.length() > 35){
			int primerEspacio = aviso.indexOf(" ",33);
			aviso2 = aviso.substring(primerEspacio, aviso.length()).trim();
			aviso = aviso.substring(0,primerEspacio).trim();
			numAvisos = 2;
			if(aviso2.length() > 35){
				int segundoEspacio = aviso2.indexOf(" ", 33);
				aviso3 = aviso2.substring(segundoEspacio, aviso2.length()).trim();
				aviso2 = aviso2.substring(0,segundoEspacio).trim();
				numAvisos = 3;
			}
		}
	}

	public void dibujaDialogo() throws Exception {
		// El tamaño del Diálogo
		setSize(405,282);
		letra=new Font("Eras Demin ITC",Font.BOLD,17);
		colorletra=new Color(255,255,255);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fonditoMN.jpg");
		iiFondo = new ImageIcon(url);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,400,250);
		jlAviso = new JLabel();
		jlAviso2 = new JLabel();
		jlAviso3 = new JLabel();
		jlAviso.setText(aviso);
		jlAviso.setFont(letra);
		jlAviso.setForeground(colorletra);
		jlAviso.setBounds(30,75,300,30);
		if(numAvisos > 1){
			jlAviso2.setText(aviso2);
			jlAviso2.setFont(letra);
			jlAviso2.setForeground(colorletra);
			jlAviso2.setBounds(30,105,300,30);
		}
		if(numAvisos > 2){
			jlAviso3.setText(aviso3);
			jlAviso3.setFont(letra);
			jlAviso3.setForeground(colorletra);
			jlAviso3.setBounds(30,140,300,30);
		}
		jlBoton = new JButton("Aceptar");
		jlBoton.setBounds(144,190,120,35);
		jlBoton.addActionListener(new mandaCerrar());
		// La textura de fondo (propiedad heredada de Kiwi)
		//setTexture(imagen);
		// Se prohibe modificar sus dimensiones al momento de ejecución
		setResizable(false);
		// Lleno mi contenedor con los elementos para que los despliegue
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		getContentPane().add(jlAviso);
		if(numAvisos > 1){
			getContentPane().add(jlAviso2);
		}
		if(numAvisos > 2){
			getContentPane().add(jlAviso3);
		}
		getContentPane().add(jlBoton);
		getContentPane().add(jlFondo);
		// Muestro el contenido del contenedor
		setVisible(true);
	}

	public void Cierra() {
		this.setVisible(false);
		this.dispose();
	}

	protected class mandaCerrar implements ActionListener {
		public void actionPerformed (ActionEvent e){
			Cierra();
		}
	}

}