package alphanet.ultra.digibar.cliente;

import javax.swing.JInternalFrame;
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
import javax.swing.JOptionPane;
import  java.rmi.RemoteException;
import java.io.UnsupportedEncodingException;


public class TraspasaMesa extends JInternalFrame {

	private DefaultListModel listModel, listModel2;
	private	JDesktopPane desktop = null;
	protected String mesaAlta;
	protected int CantComensales = -1;
	protected Vector <String> vMesasL;
	protected JScrollPane jscroll, jscroll2 ;
	int mesaID = 0;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letra;
	protected JList jlMALigar, jlMALigar2;
	private JLabel  jlMesa, jlIda, jlVuelta;
	protected JLabel  jlCancela, jlAceptar;
	private ImageIcon  iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP, iiMesa, iiIda, iiIdaP, iivuelta, iivueltaP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private static final long serialVersionUID = 1L;
	protected boolean primeraVez = true;

    public TraspasaMesa() throws Exception {
        super("Traspaso de Mesa", false, true, false);
        // Tamaño de la Ventana
        setSize(821,654);
        // Localización de la Ventana
        setLocation(16,1);
        // Contenido de la Ventana
	}

	protected void setMesaModifica(String mesaAlta){
		this.mesaAlta =mesaAlta;
		mesaID = Integer.parseInt(mesaAlta);
	}

	public void despliegaInterfaz() throws Exception{
		CantComensales = cliente.bs.DameCantidadOriginalComensales(mesaID);
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,20);
		// ASIGNACION DE IMAGENES A ICONOS.
		if(mesaID != 0){
			if(mesaID == 1){
				url= getClass().getResource("/imas/ids/01ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 2){
				url= getClass().getResource("/imas/ids/02ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 3){
				url= getClass().getResource("/imas/ids/03ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 4){
				url= getClass().getResource("/imas/ids/04ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 5){
				url= getClass().getResource("/imas/ids/05ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 6){
				url= getClass().getResource("/imas/ids/06ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 7){
				url= getClass().getResource("/imas/ids/07ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 8){
				url= getClass().getResource("/imas/ids/08ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 9){
				url= getClass().getResource("/imas/ids/09ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 10){
				url= getClass().getResource("/imas/ids/10ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 11){
				url= getClass().getResource("/imas/ids/11ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 12){
				url= getClass().getResource("/imas/ids/12ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 13){
				url= getClass().getResource("/imas/ids/13ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 14){
				url= getClass().getResource("/imas/ids/14ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 15){
				url= getClass().getResource("/imas/ids/15ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 16){
				url= getClass().getResource("/imas/ids/16ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 17){
				url= getClass().getResource("/imas/ids/17ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 18){
				url= getClass().getResource("/imas/ids/18ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 19){
				url= getClass().getResource("/imas/ids/19ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 20){
				url= getClass().getResource("/imas/ids/20ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 21){
				url= getClass().getResource("/imas/ids/21ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 22){
				url= getClass().getResource("/imas/ids/22ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 23){
				url= getClass().getResource("/imas/ids/23ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 24){
				url= getClass().getResource("/imas/ids/24ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 25){
				url= getClass().getResource("/imas/ids/25ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 26){
				url= getClass().getResource("/imas/ids/26ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 27){
				url= getClass().getResource("/imas/ids/27ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 28){
				url= getClass().getResource("/imas/ids/28ID.jpg");
				iiMesa = new ImageIcon(url);
			}
			else if(mesaID == 29){
				url= getClass().getResource("/imas/ids/29ID.jpg");
				iiMesa = new ImageIcon(url);
			}
		}
		url= getClass().getResource("/imas/botones/flechaIda.jpg");
		iiIda = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechaIdaP.jpg");
		iiIdaP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechaRegreso.jpg");
		iivuelta = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/flechaRegresoP.jpg");
		iivueltaP = new ImageIcon(url);
		url= getClass().getResource("/imas/fondoTraspasoMesa.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Cancelar.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Aceptar.jpg");
		iiBotonAceptarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAceptarP = new ImageIcon(url);
		vMesasL= cliente.bs.mesasDisponiblesTraspaso(mesaID);
		listModel = new DefaultListModel();
		listModel2 = new DefaultListModel();
		for (int i = 0; i<vMesasL.size(); i++){
	        listModel.addElement(cliente.ma.decodifica(vMesasL.elementAt(i)));
		}
		jlMALigar2 = new JList(listModel2);
		jlMALigar2.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		jlMALigar2.setFont(letra);
		jlMALigar = new JList(listModel);
		jlMALigar.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		jlMALigar.setFont(letra);
		UIManager.put("ScrollBar.width", new Integer(50));
		jscroll = new JScrollPane();
 		jscroll.getViewport().setView(jlMALigar);
		jscroll.setBounds(103, 240, 188,180);
		jscroll2 = new JScrollPane();
 		jscroll2.getViewport().setView(jlMALigar2);
		jscroll2.setBounds(509, 240, 188,100);
		// Doy formato a mis campos de Texto:
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(811,636,0,0);
		if(mesaID !=0){
			jlMesa = new JLabel(iiMesa);
			jlMesa.setBounds(515,6,43,27);
		}
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlIda = new JLabel(iiIda);
		jlIda.setBounds(375,262,62,41);
		jlIda.addMouseListener(new mouseComportamientoLabels());
		jlVuelta = new JLabel(iivuelta);
		jlVuelta.setBounds(375,322,62,41);
		jlVuelta.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (645,563,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(31,563,152,55);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		if(mesaID >0){
			this.add(jlMesa);
		}
		this.add(jlCancela);
		this.add(jlAceptar);
		this.add(jscroll);
		this.add(jscroll2);
		this.add(jlIda);
		this.add(jlVuelta);
		// Si el tipo de precio es por Grupos despligo aviso.
		this.add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
    	setVisible(true);
	}

// Referencia directa a la Interfaz para cambiar valor de tipoPrecio.
	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void procesoAceptar() {
		try{
			if(listModel2.size() == 0){
				JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes especificar la mesa a la cual se realizará el traspaso.");
			}
			else{
				String laMesaATraspasar = (String) listModel2.firstElement();
				int resultado = cliente.bs.traspasaMesa(mesaID, laMesaATraspasar);
// -1 Error, 0-> Todo bien, 1 -> La mesa a Traspasar ya no esta disponible.
				if(resultado == 0){
					cliente.refrescaMapa();
					Cierra();
				}
				else if(resultado == -1){
					JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en Modifica Mesa.\nVuelva a intentarlo.");
					Cierra();
				}
				else if(resultado == 2){
					JOptionPane.showInternalMessageDialog(cliente.desktop, "La mesa Destino ya no esta disponible..., elija otra.");
					listModel2.clear();
					listModel.clear();
					vMesasL= cliente.bs.mesasDisponiblesTraspaso(mesaID);
					for (int i = 0; i<vMesasL.size(); i++){
				        listModel.addElement(cliente.ma.decodifica(vMesasL.elementAt(i)));
					}
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en Modifica Mesa.\nVuelva a intentarlo.");
			Cierra();
		}
	}


	public void procesoTraspasaA() throws Exception{
		if(! jlMALigar.isSelectionEmpty()){
			int indiceSelecc =	jlMALigar.getSelectedIndex();
			if (indiceSelecc != -1){
				if(listModel2.size() == 0){
					listModel2.addElement(jlMALigar.getSelectedValue());
					jlMALigar.clearSelection();
				}
				else{
					JOptionPane.showInternalMessageDialog(cliente.desktop, "Quita la otra mesa de la lista para poder asignar esta.");
				}
			}
		}
	}

	public void procesoNoTraspasa() throws Exception{
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
				if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAceptar){
					procesoAceptar();
				}
				else if(temporal == jlIda){
					procesoTraspasaA();
				}
				else if(temporal == jlVuelta){
					procesoNoTraspasa();
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
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}




}