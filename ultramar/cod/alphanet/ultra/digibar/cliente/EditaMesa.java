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


public class EditaMesa extends JInternalFrame {

	private DefaultListModel listModel, listModel2;
	private	JDesktopPane desktop = null;
	protected String mesaAlta;
	protected int CantComensales = -1;
	protected Vector <String> vMeseras, vMesasL, vMesasYaL;
	protected JScrollPane jscroll, jscroll2 ;
	int mesaID = 0;
	public JTextField jtCantidad;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letra;
	protected JComboBox jcMeseras;
	protected JList jlMALigar, jlMALigar2;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0, jlMesa, jlIda, jlVuelta;
	protected JLabel jlBorrar, jlCancela, jlAceptar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP, iiMesa, iiIda, iiIdaP, iivuelta, iivueltaP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private static final long serialVersionUID = 1L;
	protected boolean primeraVez = true;

    public EditaMesa() throws Exception {
        super("Modificación de Mesa", false, true, false);
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
		url= getClass().getResource("/imas/fondoModificaMesa.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/01.jpg");
		iiBoton1N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/01P.jpg");
		iiBoton1P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/02.jpg");
		iiBoton2N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/02P.jpg");
		iiBoton2P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/03.jpg");
		iiBoton3N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/03P.jpg");
		iiBoton3P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/04.jpg");
		iiBoton4N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/04P.jpg");
		iiBoton4P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/05.jpg");
		iiBoton5N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/05P.jpg");
		iiBoton5P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/06.jpg");
		iiBoton6N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/06P.jpg");
		iiBoton6P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/07.jpg");
		iiBoton7N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/07P.jpg");
		iiBoton7P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/08.jpg");
		iiBoton8N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/08P.jpg");
		iiBoton8P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/09.jpg");
		iiBoton9N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/09P.jpg");
		iiBoton9P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/00.jpg");
		iiBoton0N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/00P.jpg");
		iiBoton0P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Borrar.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Cancelar.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Aceptar.jpg");
		iiBotonAceptarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAceptarP = new ImageIcon(url);
		vMesasL= cliente.bs.mesasParaLigar(mesaID);
		listModel = new DefaultListModel();
		listModel2 = new DefaultListModel();
		for (int i = 0; i<vMesasL.size(); i++){
	        listModel.addElement(cliente.ma.decodifica(vMesasL.elementAt(i)));
		}
		vMesasYaL = cliente.bs.mesasLigadasA(mesaID);
		for (int i = 0; i<vMesasYaL.size(); i++){
	        listModel2.addElement(cliente.ma.decodifica(vMesasYaL.elementAt(i)));
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
		jscroll.setBounds(80, 365, 100,180);
		jscroll2 = new JScrollPane();
 		jscroll2.getViewport().setView(jlMALigar2);
		jscroll2.setBounds(278, 365, 100,180);
		vMeseras = cliente.bs.DameListadoMeseros();
		jcMeseras = new JComboBox();
		for(int i = 0; i<vMeseras.size() ; i++){
			String nombre = cliente.ma.decodifica(vMeseras.elementAt(i));
			jcMeseras.addItem(nombre);
		}
		String IDMeseroAsignado = cliente.bs.DameMeseroAsignado(mesaID);
		jcMeseras.setSelectedItem(IDMeseroAsignado);
		jcMeseras.setFont(letra);
		jcMeseras.setBounds(215,65,350,45);
		// Doy formato a mis campos de Texto:
		jtCantidad = new JTextField(30);
		jtCantidad.setHorizontalAlignment(JTextField.CENTER);
		jtCantidad.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtCantidad.setBounds(30,220,300,40);
		jtCantidad.setText(CantComensales+"");
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(811,636,0,0);
		if(mesaID !=0){
			jlMesa = new JLabel(iiMesa);
			jlMesa.setBounds(515,6,43,27);
		}
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlIda = new JLabel(iiIda);
		jlIda.setBounds(200,395,58,55);
		jlIda.addMouseListener(new mouseComportamientoLabels());
		jlVuelta = new JLabel(iivuelta);
		jlVuelta.setBounds(200,460,58,55);
		jlVuelta.addMouseListener(new mouseComportamientoLabels());
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(435,168,58,55);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(511,168,58,55);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(586,168,58,55);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(661,168,58,55);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(736,168,58,55);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(435,242,58,55);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(511,242,58,55);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(586,242,58,55);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(661,242,58,55);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(736,242,58,55);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(553,317,131,55);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
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
		this.add(jtCantidad);
		this.add(jcMeseras);
		this.add(jscroll);
		this.add(jscroll2);
		this.add(jlIda);
		this.add(jlVuelta);
		// Si el tipo de precio es por Grupos despligo aviso.
		this.add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
    	setVisible(true);
    	jtCantidad.requestFocus();
	}

// Referencia directa a la Interfaz para cambiar valor de tipoPrecio.
	public void setPadre (Cliente cliente){
		this.cliente = cliente;
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

	public void procesoAceptar() {
		try{
//			System.out.println("Diste click en Aceptar");
			// Verifico que el numero de comensales sea superior a 0.
			int comensales = cliente.ma.cambiaAInt(jtCantidad.getText());
			if (!(comensales >= CantComensales)){
				JOptionPane.showInternalMessageDialog(cliente.desktop, "No puedes decrementar el numero de Comensales, solo aumentarlos.");
				jtCantidad.setText(CantComensales+"");
			}
			else{
				// Obtengo el ID del Mesero asignado.
				String IDM = (String)	jcMeseras.getSelectedItem();
				IDM = IDM.substring(IDM.lastIndexOf(">")+1, IDM.length()).trim();
				int IDMesero = cliente.ma.cambiaAInt(IDM);

				// Ahora mando toda la informacion al Servidor para que me diga el Resultado.
				String resultado = cliente.bs.ProcesaModificaMesa(IDMesero, comensales, mesaID, listModel2);
				if(resultado.equalsIgnoreCase("OK")){
					cliente.refrescaMapa();
					Cierra();
				}
				else if(resultado.equalsIgnoreCase("ML")){
					JOptionPane.showInternalMessageDialog(cliente.desktop, 	"Al menos una de las Mesas Ligadas que solicitó ya no esta disponible, vuelva a introducir las mesas Ligadas.");
					listModel.removeAllElements();
					listModel2.removeAllElements();
					vMesasL= cliente.bs.mesasParaLigar(mesaID);
					for (int i = 0; i<vMesasL.size(); i++){
				        listModel.addElement(cliente.ma.decodifica(vMesasL.elementAt(i)));
					}
					cliente.refrescaMapa();
				}
				else{
					JOptionPane.showInternalMessageDialog(cliente.desktop, "Error en la Base de Datos intentando dar de Alta la Mesa.\nVuelva a intentarlo.");
					Cierra();
				}
			}
		}
		catch(RemoteException re){
			re.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion Remota en Modifica Mesa.\nVuelva a intentarlo.");
			Cierra();
		}
		catch(UnsupportedEncodingException uee){
			uee.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion De Codificacion en Modifica Mesa.\nVuelva a intentarlo.");
			Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en Modifica Mesa.\nVuelva a intentarlo.");
			Cierra();
		}
	}


	public void procesoLigaMesa() throws Exception{
		if(! jlMALigar.isSelectionEmpty()){
			int indiceSelecc =	jlMALigar.getSelectedIndex();
			if (indiceSelecc != -1){
				listModel2.addElement(jlMALigar.getSelectedValue());
				listModel.remove(indiceSelecc);
			}
		}
	}

	public void procesoDesligaMesa() throws Exception{
		if(! jlMALigar2.isSelectionEmpty()){
			int indiceSelecc =	jlMALigar2.getSelectedIndex();
			if (indiceSelecc != -1){
				listModel.addElement(jlMALigar2.getSelectedValue());
				listModel2.remove(indiceSelecc);
			}
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
				if(temporal == jlBoton1){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"1");
					}
				}
				else if(temporal == jlBoton2){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"2");
					}
				}
				else if(temporal == jlBoton3){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"3");
					}
				}
				else if(temporal == jlBoton4){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"4");
					}
				}
				else if(temporal == jlBoton5){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"5");
					}
				}
				else if(temporal == jlBoton6){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"6");
					}
				}
				else if(temporal == jlBoton7){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"7");
					}
				}
				else if(temporal == jlBoton8){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"8");
					}
				}
				else if(temporal == jlBoton9){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"9");
					}
				}
				else if(temporal == jlBoton0){
					if(primeraVez){
						primeraVez = false;
						jtCantidad.setText("");
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 4){
						jtCantidad.setText(previo+"0");
					}
				}
				else if(temporal == jlBorrar){
					jtCantidad.setText("");
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAceptar){
					procesoAceptar();
				}
				else if(temporal == jlIda){
					procesoLigaMesa();
				}
				else if(temporal == jlVuelta){
					procesoDesligaMesa();
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
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBP);
				}
				else if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanP);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAceptarP);
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
					jlAceptar.setIcon(iiBotonAceptarN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}




}