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


public class MenuMesaO extends JInternalFrame {

	private	JDesktopPane desktop = null;
	protected String mesaTrabaja;
	int mesaID = 0;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letra;
	private JLabel  jlEditaM, jlTraspasaM, jlEntraC, jlConsulC, jlFinalC, jlRegresa, jlMesa;
	private ImageIcon  iiEditaM, iiEditaMP, iiTraspasaM, iiTraspasaMP,  iiEntradaC, iiEntradaCP, iiConsulC,  iiConsulCP,  iiFinalC, iiFinalCP, iiRegresa, iiRegresaP, iiMesa;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private static final long serialVersionUID = 1L;


    public MenuMesaO() throws Exception {
        super("Menú Mesa Ocupada", false, true, false);
        // Tamaño de la Ventana
        setSize(821,654);
        // Localización de la Ventana
        setLocation(16,1);
        // Contenido de la Ventana
	}

	protected void setMesaTrabaja(String mesaTrabaja){
		this.mesaTrabaja =mesaTrabaja;
		mesaID = Integer.parseInt(mesaTrabaja);
	}

	public void despliegaInterfaz() throws Exception{
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
		url= getClass().getResource("/imas/botones/comandaFinaliza.jpg");
		iiFinalC = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/comandaFinalizaP.jpg");
		iiFinalCP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Regresar.jpg");
		iiRegresa = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/RegresarP.jpg");
		iiRegresaP = new ImageIcon(url);
		url= getClass().getResource("/imas/fondoMenuOcupada.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/mesaEdita.jpg");
		iiEditaM = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/mesaEditaP.jpg");
		iiEditaMP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/traspasaMesa.jpg");
		iiTraspasaM = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/traspasaMesaP.jpg");
		iiTraspasaMP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/comandaAgrega.jpg");
		iiEntradaC = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/comandaAgregaP.jpg");
		iiEntradaCP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/comandaConsulta.jpg");
		iiConsulC = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/comandaConsultaP.jpg");
		iiConsulCP = new ImageIcon(url);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(811,636,0,0);
		if(mesaID !=0){
			jlMesa = new JLabel(iiMesa);
			jlMesa.setBounds(515,6,43,27);
		}
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlEditaM = new JLabel(iiEditaM);
		jlEditaM.setBounds(98,130,79,81);
		jlEditaM.addMouseListener(new mouseComportamientoLabels());
		jlTraspasaM  = new JLabel(iiTraspasaM);
		jlTraspasaM.setBounds(477,130,79,81);
		jlTraspasaM.addMouseListener(new mouseComportamientoLabels());
		jlEntraC = new JLabel(iiEntradaC);
		jlEntraC.setBounds(285,282,79,81);
		jlEntraC.addMouseListener(new mouseComportamientoLabels());
		jlConsulC = new JLabel(iiConsulC);
		jlConsulC.setBounds(98,413,79,81);
		jlConsulC.addMouseListener(new mouseComportamientoLabels());
		jlFinalC = new JLabel(iiFinalC);
		jlFinalC.setBounds(477,415,79,81);
		jlFinalC.addMouseListener(new mouseComportamientoLabels());
		jlRegresa = new JLabel(iiRegresa);
		jlRegresa.setBounds(624,563,152,55);
		jlRegresa.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		if(mesaID >0){
			this.add(jlMesa);
		}
		this.add(jlTraspasaM);
		this.add(jlEditaM);
		this.add(jlEntraC);
		this.add(jlConsulC);
		this.add(jlFinalC);
		this.add(jlRegresa);
		// Si el tipo de precio es por Grupos despligo aviso.
		this.add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
    	setVisible(true);
	}

// Referencia directa a la Interfaz para cambiar valor de tipoPrecio.
	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void procesoConsultaComanda(){
		try{
//			System.out.println("Distec click a Consulta Comanda: " +mesaID);
			ConsultaComanda cc = new ConsultaComanda();
			cc.setPadre(cliente);
			cc.setMesaConsulta(mesaTrabaja);
			cc.despliegaInterfaz();
			cc.setVisible(true);
			cliente.desktop.add(cc);
			cc.setSelected(true);
			Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}


	public void procesoEditaMesa(){
		try{
			EditaMesa em = new EditaMesa();
			em.setPadre(cliente);
			em.setMesaModifica(mesaTrabaja);
			em.despliegaInterfaz();
			em.jtCantidad.requestFocus();
			em.setVisible(true);
			cliente.desktop.add(em);
			em.setSelected(true);
			Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void procesoFinalizaComanda(){
		try{
			SeleccionTipoCierre stc = new SeleccionTipoCierre();
			stc.setPadre(cliente);
			stc.setMesaTrabaja(mesaTrabaja);
			stc.despliegaInterfaz();
			stc.setVisible(true);
			cliente.desktop.add(stc);
			stc.setSelected(true);
			Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void procesoAgregaAComanda(){
		try{
			AgregaComanda ag = new AgregaComanda();
			ag.setPadre(cliente);
			ag.setMesaTrabaja(mesaTrabaja);
			ag.despliegaInterfaz();
			ag.setVisible(true);
			cliente.desktop.add(ag);
			ag.setSelected(true);
			Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void procesoTraspasaMesa(){
		try{
			TraspasaMesa tm = new TraspasaMesa();
			tm.setPadre(cliente);
			tm.setMesaModifica(mesaTrabaja);
			tm.despliegaInterfaz();
			tm.setVisible(true);
			cliente.desktop.add(tm);
			tm.setSelected(true);
			Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
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
				if(temporal == jlEditaM){
					procesoEditaMesa();
				}
				else if(temporal == jlEntraC){
					procesoAgregaAComanda();
				}
				else if(temporal == jlTraspasaM){
					procesoTraspasaMesa();
				}
				else if(temporal == jlConsulC){
					procesoConsultaComanda();
				}
				else if(temporal == jlFinalC){
					procesoFinalizaComanda();
				}
				else if(temporal == jlRegresa){
					Cierra();
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
				if(temporal == jlEditaM){
					jlEditaM.setIcon(iiEditaMP);
				}
				else if(temporal == jlTraspasaM){
					jlTraspasaM.setIcon(iiTraspasaMP);
				}
				else if(temporal == jlEntraC){
					jlEntraC.setIcon(iiEntradaCP);
				}
				else if(temporal == jlConsulC){
					jlConsulC.setIcon(iiConsulCP);
				}
				else if(temporal == jlFinalC){
					jlFinalC.setIcon(iiFinalCP);
				}
				else if(temporal == jlRegresa){
					jlRegresa.setIcon(iiRegresaP);
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
				if(temporal == jlEditaM){
					jlEditaM.setIcon(iiEditaM);
				}
				else if(temporal == jlTraspasaM){
					jlTraspasaM.setIcon(iiTraspasaM);
				}
				else if(temporal == jlEntraC){
					jlEntraC.setIcon(iiEntradaC);
				}
				else if(temporal == jlConsulC){
					jlConsulC.setIcon(iiConsulC);
				}
				else if(temporal == jlFinalC){
					jlFinalC.setIcon(iiFinalC);
				}
				else if(temporal == jlRegresa){
					jlRegresa.setIcon(iiRegresa);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}




}