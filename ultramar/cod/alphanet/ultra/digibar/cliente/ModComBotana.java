package alphanet.ultra.digibar.cliente;

import java.awt.Frame;
import javax.swing.JLabel;
import javax.swing.JComboBox;
import javax.swing.JList;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import java.net.URL;
import javax.swing.JDesktopPane;
import javax.swing.JScrollPane;
import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.ListSelectionModel;
import javax.swing.DefaultListModel;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import alphanet.ultra.digibar.bd.Sound;
import java.util.Vector;
import  java.rmi.RemoteException;
import java.io.UnsupportedEncodingException;
import javax.swing.WindowConstants;
import javax.swing.JDialog;
import javax.swing.Icon;


public class ModComBotana extends JDialog {

	protected DefaultListModel listModel, listModel2;
	private	JDesktopPane desktop = null;
	protected Vector <String> vGuardoTemp = new Vector<String>();
	protected JScrollPane jscroll, jscroll2 ;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letra;
	protected JList jlBotDisponible, jlBotSolicita;
	private JLabel   jlIda, jlVuelta, jlVueltaT;
	protected JLabel  jlCancela, jlAceptar;
	private ImageIcon  iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP, iiIda, iiIdaP, iivuelta, iivueltaP,   iiVueltaT, iiVueltaTP;
	private Sound son;
	private Image imagen;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private static final long serialVersionUID = 1L;
	protected boolean dioAceptar = false;
	protected String tComponente = "";

	protected void setTComponente(String tComponente){
		this.tComponente = tComponente;
	}

    public ModComBotana(Frame padre, String titulo, boolean modal) throws Exception {
		super(padre, titulo,modal);
		// con esto aseguro que no puedan cerrar mi ventana de manera tradicional.
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void  llenaSolicitado() throws Exception{
		while(tComponente.indexOf("\n") != -1){
			listModel2.addElement(tComponente.substring(0,tComponente.indexOf("\n")));
			tComponente = tComponente.substring(tComponente.indexOf("\n")+1, tComponente.length());
		}
		listModel2.addElement(tComponente);
	}

	public void despliegaInterfaz() throws Exception{
		setSize(776,635);
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,17);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/botones/flechitaRegresoT.jpg");
		iiVueltaT = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechitaRegresoTP.jpg");
		iiVueltaTP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechitaIda.jpg");
		iiIda = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechitaIdaP.jpg");
		iiIdaP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechitaRegreso.jpg");
		iivuelta = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechitaRegresoP.jpg");
		iivueltaP = new ImageIcon(url);
		url= getClass().getResource("/imas/fondoBotana.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Cancelar.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Aceptar.jpg");
		iiBotonAceptarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAceptarP = new ImageIcon(url);
		listModel = new DefaultListModel();
		Vector <String> listadoDeTiemposB = cliente.bs.dameComponentesBotana();
		for(int i=0; i<listadoDeTiemposB.size(); i++){
			listModel.addElement(listadoDeTiemposB.elementAt(i));
		}
		listModel2 = new DefaultListModel();
		jlBotSolicita = new JList(listModel2);
		jlBotSolicita.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		jlBotSolicita.setFont(letra);
		jlBotDisponible = new JList(listModel);
		jlBotDisponible.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		jlBotDisponible.setFont(letra);
		UIManager.put("ScrollBar.width", new Integer(50));
		jscroll = new JScrollPane();
 		jscroll.getViewport().setView(jlBotDisponible);
		jscroll.setBounds(36, 165, 260,200);
		jscroll2 = new JScrollPane();
 		jscroll2.getViewport().setView(jlBotSolicita);
		jscroll2.setBounds(452, 165, 260,200);
		// Doy formato a mis campos de Texto:
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,770,604);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlIda = new JLabel(iiIda);
		jlIda.setBounds(348,167,62,37);
		jlIda.addMouseListener(new mouseComportamientoLabels());
		jlVuelta = new JLabel(iivuelta);
		jlVuelta.setBounds(348,227,62,36);
		jlVuelta.addMouseListener(new mouseComportamientoLabels());
		jlVueltaT = new JLabel(iiVueltaT);
		jlVueltaT.setBounds(348,287,62,36);
		jlVueltaT.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (590,530,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(31,530,152,55);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		setResizable(false);
		// Lleno mi contenedor con los elementos para que los despliegue
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		getContentPane().add(jlCancela);
		getContentPane().add(jlAceptar);
		getContentPane().add(jscroll);
		getContentPane().add(jscroll2);
		getContentPane().add(jlIda);
		getContentPane().add(jlVuelta);
		getContentPane().add(jlVueltaT);
		// Si el tipo de precio es por Grupos despligo aviso.
		getContentPane().add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
		llenaSolicitado();
    	setVisible(true);
	}


	public void procesoAceptar() {

		try{
			if(listModel2.size() == 0){
				MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "Debes especificar por lo menos un elemento de la Botana");
				mn.dibujaDialogo();
			}
			else{
				dioAceptar = true;
				Cierra();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en ModComBotana.\nVuelva a intentarlo.");
			Cierra();
		}
	}


	public void procesoMandaBebida() throws Exception{
		if(! jlBotDisponible.isSelectionEmpty()){
			int indiceSelecc =	jlBotDisponible.getSelectedIndex();
			if (indiceSelecc != -1){
				if(listModel2.size() == 4){
					MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "No puedes solicitar más de 4 platos");
					mn.dibujaDialogo();
				}
				else{
					listModel2.addElement(jlBotDisponible.getSelectedValue());
				//	ordenaElementos();
				}
			}
		}
	}


// INCOMPLETA....
	public void ordenaElementos() throws Exception{
		Vector <String> contenido = new Vector<String>();
		for(int i = 0 ; i<listModel2.size(); i++){
			String actual = (String)listModel2.elementAt(i);
			contenido.addElement(actual.substring(actual.indexOf("*")+1,actual.length()).trim());
			contenido.addElement(actual.substring(0,actual.indexOf("*")).trim());
		}
	}

	public void procesoRetacheBebida() throws Exception{
		if(! jlBotSolicita.isSelectionEmpty()){
			int indiceSelecc =	jlBotSolicita.getSelectedIndex();
			if (indiceSelecc != -1){
				listModel2.remove(indiceSelecc);
			}
		}
	}

	public void procesoRetacheTotalBebida()throws Exception{
		if(!listModel2.isEmpty()){
			listModel2.clear();
		}
	}

	public void Cierra() {
		this.setVisible(false);
		this.dispose();
		cliente.desktop.remove(this);
	}




	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlAceptar){
					procesoAceptar();
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlIda){
					procesoMandaBebida();
				}
				else if(temporal == jlVuelta){
					procesoRetacheBebida();
				}
				else if(temporal == jlVueltaT){
					procesoRetacheTotalBebida();
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
				if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanP);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAceptarP);
				}
				else if(temporal == jlIda){
					jlIda.setIcon(iiIdaP);
				}
				else if(temporal == jlVuelta){
					jlVuelta.setIcon(iivueltaP);
				}
				else if(temporal == jlVueltaT){
					jlVueltaT.setIcon(iiVueltaTP);
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
				if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanN);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAceptarN);
				}
				else if(temporal == jlIda){
					jlIda.setIcon(iiIda);
				}
				else if(temporal == jlVuelta){
					jlVuelta.setIcon(iivuelta);
				}
				else if(temporal == jlVueltaT){
					jlVueltaT.setIcon(iiVueltaT);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}




}