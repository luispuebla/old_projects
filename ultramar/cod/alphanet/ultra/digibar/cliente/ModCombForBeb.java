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


public class ModCombForBeb extends JDialog {

	protected DefaultListModel listModel, listModel2;
	private	JDesktopPane desktop = null;
	protected String mesaAlta;
	protected Vector <String> vGuardoTemp = new Vector<String>();
	protected JScrollPane jscroll, jscroll2 ;
	public JTextField jtBebida, jtTipo;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letra;
	protected JList jlBebDisponible, jlBebSolicita;
	private JLabel   jlIda, jlVuelta, jlVueltaT;
	protected JLabel jlSencillo, jlDoble, jlTriple, jlPuesto, jlDivorciado, jlDerecho, jlRocas, jlChasser, jlNinguno, jlNormal, jlCampe, jlPintado, jlLimon, jlSangria;
	protected JLabel jlBorrar, jlCancela, jlAceptar;
	private ImageIcon  iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP, iiIda, iiIdaP, iivuelta, iivueltaP, iiTache, iiTacheP,  iiVueltaT, iiVueltaTP;
	private Sound son;
	private Image imagen;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private static final long serialVersionUID = 1L;
	protected int tBebida = 0;
	protected int tFormato =0;
	protected int tMezcla = 0;
	protected int tAdicional = -1;
	protected String tCombina = "";
	protected boolean esCombinable = false;
	protected boolean esRedimensionable = false;
	protected String nombreBebida = "";
	protected String tipoBebida = "";
	protected Vector <String> bebSolicitadas = new Vector <String>();
	protected boolean dioAceptar = false;

	protected void setNombreBebida(String nombreBebida){
		this.nombreBebida = nombreBebida;
	}

	protected void setTipoBebida(String tipoBebida){
		this.tipoBebida = tipoBebida;
	}

	protected void setEsCombinable(boolean esCombinable){
		this.esCombinable = esCombinable;
	}

	protected void setEsRedimensionable(boolean esRedimensionable){
		this.esRedimensionable = esRedimensionable;
	}

	protected void setTBebida(String SBebida){
		if(SBebida.equalsIgnoreCase("Sencillo")){
			tBebida = 1;
		}
		else if(SBebida.equalsIgnoreCase("Doble")){
			tBebida = 2;
		}
		else{
			tBebida = 3;
		}
	}

	protected void setTFormato(String SFormato){
		if(SFormato.equalsIgnoreCase("Puesto")){
			tFormato = 1;
		}
		else if(SFormato.equalsIgnoreCase("Divorciado")){
			tFormato = 2;
		}
		else if(SFormato.equalsIgnoreCase("Derecho")){
			tFormato = 3;
		}
		else if(SFormato.equalsIgnoreCase("Rocas")){
			tFormato = 4;
		}
		else if(SFormato.equalsIgnoreCase("Chasser")){
			tFormato = 5;
		}
	}

	protected void setTMezcla(String SMezcla){
		if(SMezcla.equalsIgnoreCase("Ninguno")){
			tMezcla = 1;
		}
		else if(SMezcla.equalsIgnoreCase("Normal")){
			tMezcla = 2;
		}
		else if(SMezcla.equalsIgnoreCase("Campechano")){
			tMezcla = 3;
		}
		else if(SMezcla.equalsIgnoreCase("Pintado")){
			tMezcla = 4;
		}
	}

	protected void setTAdicional(String SAdicional){
		if(SAdicional.equalsIgnoreCase("No")){
			tAdicional = 0;
		}
		else if(SAdicional.equalsIgnoreCase("C.Limon")){
			tAdicional = 1;
		}
		else if(SAdicional.equalsIgnoreCase("C.Sangrita")){
			tAdicional = 2;
		}
		else{
			tAdicional = 3;
		}
	}

	protected void setTCombina(String tCombina){
		this.tCombina = tCombina;
	}

    public ModCombForBeb(Frame padre, String titulo, boolean modal) throws Exception {
		super(padre, titulo,modal);
		// con esto aseguro que no puedan cerrar mi ventana de manera tradicional.
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void despliegaInterfaz() throws Exception{
		setSize(776,635);
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,17);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/botones/tache.jpg");
		iiTache = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/tacheP.jpg");
		iiTacheP = new ImageIcon(url);
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
		url= getClass().getResource("/imas/fondoCombinacion.jpg");
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
		if(!tCombina.equalsIgnoreCase("NA")){
			Vector <String> listadoPorCombinar = cliente.bs.dameListadoPorCombinar();
			for(int i=0; i<listadoPorCombinar.size(); i++){
				listModel.addElement(listadoPorCombinar.elementAt(i));
			}
		}
		listModel2 = new DefaultListModel();
		jlBebSolicita = new JList(listModel2);
		jlBebSolicita.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		jlBebSolicita.setFont(letra);
		jlBebDisponible = new JList(listModel);
		jlBebDisponible.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		jlBebDisponible.setFont(letra);
		UIManager.put("ScrollBar.width", new Integer(50));
		jscroll = new JScrollPane();
 		jscroll.getViewport().setView(jlBebDisponible);
		jscroll.setBounds(90, 335, 270,180);
		jscroll2 = new JScrollPane();
 		jscroll2.getViewport().setView(jlBebSolicita);
		jscroll2.setBounds(470, 335, 270,180);
		// Doy formato a mis campos de Texto:
		jtBebida = new JTextField(30);
		jtBebida.setHorizontalAlignment(JTextField.CENTER);
		jtBebida.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtBebida.setBounds(115,38,350,38);
		jtTipo = new JTextField(30);
		jtTipo.setHorizontalAlignment(JTextField.CENTER);
		jtTipo.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtTipo.setBounds(530,38,185,38);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,770,604);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlIda = new JLabel(iiIda);
		jlIda.setBounds(384,347,62,37);
		jlIda.addMouseListener(new mouseComportamientoLabels());
		jlVuelta = new JLabel(iivuelta);
		jlVuelta.setBounds(384,407,62,36);
		jlVuelta.addMouseListener(new mouseComportamientoLabels());
		jlVueltaT = new JLabel(iiVueltaT);
		jlVueltaT.setBounds(384,467,62,36);
		jlVueltaT.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (590,530,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(31,530,152,55);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		jlSencillo= new JLabel(iiTacheP);
		jlSencillo.setBounds(246,84,35,35);
		jlSencillo.addMouseListener(new mouseComportamientoLabels());
		jlDoble= new JLabel(iiTacheP);
		jlDoble.setBounds(413,84,35,35);
		jlDoble.addMouseListener(new mouseComportamientoLabels());
		jlTriple= new JLabel(iiTacheP);
		jlTriple.setBounds(595,84,35,35);
		jlTriple.addMouseListener(new mouseComportamientoLabels());
		jlPuesto= new JLabel(iiTacheP);
		jlPuesto.setBounds(209,132,35,35);
		jlPuesto.addMouseListener(new mouseComportamientoLabels());
		jlDivorciado= new JLabel(iiTacheP);
		jlDivorciado.setBounds(360,132,35,35);
		jlDivorciado.addMouseListener(new mouseComportamientoLabels());
		jlDerecho= new JLabel(iiTacheP);
		jlDerecho.setBounds(495,132,35,35);
		jlDerecho.addMouseListener(new mouseComportamientoLabels());
		jlRocas= new JLabel(iiTacheP);
		jlRocas.setBounds(601,132,35,35);
		jlRocas.addMouseListener(new mouseComportamientoLabels());
		jlChasser= new JLabel(iiTacheP);
		jlChasser.setBounds(726,132,35,35);
		jlChasser.addMouseListener(new mouseComportamientoLabels());
		jlNinguno= new JLabel(iiTacheP);
		jlNinguno.setBounds(220,182,35,35);
		jlNinguno.addMouseListener(new mouseComportamientoLabels());
		jlNormal= new JLabel(iiTacheP);
		jlNormal.setBounds(353,182,35,35);
		jlNormal.addMouseListener(new mouseComportamientoLabels());
		jlCampe= new JLabel(iiTacheP);
		jlCampe.setBounds(543,182,35,35);
		jlCampe.addMouseListener(new mouseComportamientoLabels());
		jlPintado= new JLabel(iiTacheP);
		jlPintado.setBounds(680,182,35,35);
		jlPintado.addMouseListener(new mouseComportamientoLabels());
		jlLimon= new JLabel(iiTacheP);
		jlLimon.setBounds(288,230,35,35);
		jlLimon.addMouseListener(new mouseComportamientoLabels());
		jlSangria= new JLabel(iiTacheP);
		jlSangria.setBounds(477,230,35,35);
		jlSangria.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		setResizable(false);
		// Lleno mi contenedor con los elementos para que los despliegue
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		getContentPane().add(jlCancela);
		getContentPane().add(jlAceptar);
		getContentPane().add(jtBebida);
		getContentPane().add(jtTipo);
		getContentPane().add(jscroll);
		getContentPane().add(jscroll2);
		getContentPane().add(jlIda);
		getContentPane().add(jlVuelta);
		getContentPane().add(jlVueltaT);
		getContentPane().add(jlSencillo);
		getContentPane().add(jlDoble);
		getContentPane().add(jlTriple);
		getContentPane().add(jlPuesto);
		getContentPane().add(jlDivorciado);
		getContentPane().add(jlDerecho);
		getContentPane().add(jlRocas);
		getContentPane().add(jlChasser);
		getContentPane().add(jlNinguno);
		getContentPane().add(jlNormal);
		getContentPane().add(jlCampe);
		getContentPane().add(jlPintado);
		getContentPane().add(jlLimon);
		getContentPane().add(jlSangria);
		// Si el tipo de precio es por Grupos despligo aviso.
		getContentPane().add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
    	jtBebida.setEditable(false);
    	jtTipo.setEditable(false);
    	formateaPantalla();
    	setVisible(true);
	}

	protected void formateaPantalla() throws Exception{
		// Nombre y Tipo de Bebida.
		jtBebida.setText(nombreBebida);
		jtTipo.setText(tipoBebida);
		// Tamaño de Bebida
		if(! (tCombina.equalsIgnoreCase("NA") || tCombina.trim().equalsIgnoreCase(""))){
			boolean variosCombinados = false;
			Vector <String> vDesglosa = new Vector<String>();
			while(tCombina.indexOf("\n") != -1){
				variosCombinados = true;
				int cambiar = tCombina.indexOf("\n");
				vDesglosa.addElement(tCombina.substring(0,cambiar));
				tCombina=tCombina.substring(cambiar+1,tCombina.length());
			}
			if(!variosCombinados){
				vDesglosa.addElement(tCombina);
			}
			for(int i = 0; i<vDesglosa.size();i++){
				int cantidadBeb = cliente.ma.cambiaAInt(vDesglosa.elementAt(i).substring(0,vDesglosa.elementAt(i).indexOf("-")).trim());
				for(int j= 0 ; j<cantidadBeb; j++){
					listModel2.addElement((Object)vDesglosa.elementAt(i).substring(vDesglosa.elementAt(i).indexOf("-")+1, vDesglosa.elementAt(i).length()).trim());
				}
			}
		}
		else if(tCombina.trim().equalsIgnoreCase("NA")){
			jlBebDisponible.setEnabled(false);
			jlBebSolicita.setEnabled(false);
		}
		if(tBebida == 0){
			jlSencillo.setVisible(false);
			jlDoble.setVisible(false);
			jlTriple.setVisible(false);
		}
		else if(tBebida == 1){
			jlSencillo.setIcon(iiTache);
		}
		else if(tBebida == 2){
			jlDoble.setIcon(iiTache);
		}
		else if(tBebida == 3){
			jlTriple.setIcon(iiTache);
		}
		// Formato de Bebida
		if(tFormato == 0){
			jlPuesto.setVisible(false);
			jlDivorciado.setVisible(false);
			jlDerecho.setVisible(false);
			jlRocas.setVisible(false);
			jlChasser.setVisible(false);
		}
		else if(tFormato == 1){
			jlPuesto.setIcon(iiTache);
		}
		else if(tFormato == 2){
			jlDivorciado.setIcon(iiTache);
		}
		else if(tFormato == 3){
			jlDerecho.setIcon(iiTache);
		}
		else if(tFormato == 4){
			jlRocas.setIcon(iiTache);
		}
		else if(tFormato == 5){
			jlChasser.setIcon(iiTache);
		}
		// Mezcla de Bebida.
		if(tMezcla == 0){
			jlNinguno.setVisible(false);
			jlNormal.setVisible(false);
			jlCampe.setVisible(false);
			jlPintado.setVisible(false);
		}
		else if(tMezcla == 1){
			jlNinguno.setIcon(iiTache);
		}
		else if(tMezcla == 2){
			jlNormal.setIcon(iiTache);
		}
		else if(tMezcla == 3){
			jlCampe.setIcon(iiTache);
		}
		else if(tMezcla == 4){
			jlPintado.setIcon(iiTache);
		}
		// Adicionales de Bebida.
		if(tAdicional == -1){
			jlLimon.setVisible(false);
			jlSangria.setVisible(false);
		}
		else if(tAdicional == 0){
		}
		else if(tAdicional == 1){
			jlLimon.setIcon(iiTache);
		}
		else if(tAdicional == 2){
			jlSangria.setIcon(iiTache);
		}
		else if(tAdicional == 3){
			jlLimon.setIcon(iiTache);
			jlSangria.setIcon(iiTache);
		}
	}

	public void procesoAceptar() {
		try{
			dioAceptar = true;
//			System.out.println("Clave Bebida: " +tBebida+"\nClave Formato: "+tFormato+"\nClave Mezcla: "+tMezcla +"\nClaveAdicional: "+tAdicional +"\nCombinacion: "+tCombina);
			if(esCombinable){
				if((tMezcla == 3 || tMezcla == 4) && listModel2.getSize() != 2){
					MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "Para las mezclas de Campechano y  de Pintado es necesario pedir 2 be- bidas para mezclar. Seleccionalas.");
					mn.dibujaDialogo();
				}
				else{
					if(!(listModel2.isEmpty())){
						if(tMezcla!=0 && tMezcla != 1){
							for (int i = 0; i<listModel2.getSize(); i++){
								bebSolicitadas.addElement((String)listModel2.elementAt(i));
							}
							bebSolicitadas = cliente.ma.comprimeVector(bebSolicitadas);
						}
					}
					else{
						listModel2.clear();
						tMezcla = 1;
						jlNinguno.setIcon(iiTache);
						jlNormal.setIcon(iiTacheP);
						jlCampe.setIcon(iiTacheP);
						jlPintado.setIcon(iiTacheP);
						if(tFormato != 4 && tFormato != 5){
							tFormato = 3;
							jlPuesto.setIcon(iiTacheP);
							jlDivorciado.setIcon(iiTacheP);
							jlDerecho.setIcon(iiTache);
						}
					}
					Cierra();
				}
			}
			else{
				Cierra();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en ModComForBeb Mesa.\nVuelva a intentarlo.");
			Cierra();
		}
	}


	public void procesoMandaBebida() throws Exception{
		if(! jlBebDisponible.isSelectionEmpty()){
			int indiceSelecc =	jlBebDisponible.getSelectedIndex();
			if (indiceSelecc != -1){
				if(tFormato == 4 || tFormato == 5){
					MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "En Los Formatos Chasser y Rocas no se permite Combinar con otra bebida");
					mn.dibujaDialogo();
				}
				else{
					int maxDisp = 0;
					if(tipoBebida.equalsIgnoreCase("copa")){
						maxDisp = 2;
					}
					else if(tipoBebida.equalsIgnoreCase("Botella P.")){
						maxDisp = 3;
					}
					else if(tipoBebida.equalsIgnoreCase("Botella G.") || tipoBebida.equalsIgnoreCase("Botella")){
						maxDisp = 4;
					}
					if(listModel2.getSize() == maxDisp){
						MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "Sobre pasas la cantidad autorizada para una "+tipoBebida+	", quita una bebida para añadir otra.");
						mn.dibujaDialogo();
					}
					else{
						if(tMezcla == 1){
							tMezcla =2;
						}
						listModel2.addElement(jlBebDisponible.getSelectedValue());
					}
				}
			}
		}
	}

	public void procesoRetacheBebida() throws Exception{
		if(! jlBebSolicita.isSelectionEmpty()){
			int indiceSelecc =	jlBebSolicita.getSelectedIndex();
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

	public void procesoMezcla(JLabel temporal){
		if(temporal == jlNinguno){
			Icon iconTemp = jlNinguno.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(!listModel2.isEmpty()  && vGuardoTemp.size() == 0){
					for(int i = 0; i<listModel2.getSize(); i++){
						vGuardoTemp.addElement((String) listModel2.elementAt(i));
					}
					listModel2.clear();
				}
				if(jlPuesto.getIcon() == (Icon)iiTache || jlDivorciado.getIcon() == (Icon)iiTache){
					jlPuesto.setIcon(iiTacheP);
					jlDivorciado.setIcon(iiTacheP);
					jlDerecho.setIcon(iiTache);
					tFormato = 3;
				}
				jlNinguno.setIcon(iiTache);
				jlNormal.setIcon(iiTacheP);
				jlCampe.setIcon(iiTacheP);
				jlPintado.setIcon(iiTacheP);
				tMezcla= 1;
			}
		}
		else if(temporal == jlNormal){
			Icon iconTemp = jlNormal.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(vGuardoTemp.size() != 0){
					// Solo una bebida.., solo paso el primer combinable.
					for(int i = 0; i < 1; i++){
						listModel2.addElement(vGuardoTemp.elementAt(i));
					}
					vGuardoTemp = new Vector<String>();
				}
				if(jlRocas.getIcon() == (Icon)iiTache || jlChasser.getIcon() == (Icon)iiTache){
					jlRocas.setIcon(iiTacheP);
					jlChasser.setIcon(iiTacheP);
					jlDerecho.setIcon(iiTache);
					tFormato = 3;
				}
				jlNinguno.setIcon(iiTacheP);
				jlNormal.setIcon(iiTache);
				jlCampe.setIcon(iiTacheP);
				jlPintado.setIcon(iiTacheP);
				tMezcla= 2;
			}
		}
		else if(temporal == jlCampe){
			Icon iconTemp = jlCampe.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(vGuardoTemp.size() != 0 && jlRocas.getIcon() != (Icon) iiTache && jlChasser.getIcon() != (Icon) iiTache ){
					for(int i = 0; i < vGuardoTemp.size(); i++){
						listModel2.addElement(vGuardoTemp.elementAt(i));
					}
					vGuardoTemp = new Vector<String>();
				}
				if(jlRocas.getIcon() == (Icon)iiTache || jlChasser.getIcon() == (Icon)iiTache){
					jlRocas.setIcon(iiTacheP);
					jlChasser.setIcon(iiTacheP);
					jlPuesto.setIcon(iiTache);
					tFormato = 1;
				}
				jlNinguno.setIcon(iiTacheP);
				jlNormal.setIcon(iiTacheP);
				jlCampe.setIcon(iiTache);
				jlPintado.setIcon(iiTacheP);
				tMezcla=3;
			}
		}
		else if(temporal == jlPintado){
			Icon iconTemp = jlPintado.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(vGuardoTemp.size() != 0 && jlRocas.getIcon() != (Icon) iiTache && jlChasser.getIcon() != (Icon) iiTache ){
					for(int i = 0; i < vGuardoTemp.size(); i++){
						listModel2.addElement(vGuardoTemp.elementAt(i));
					}
					vGuardoTemp = new Vector<String>();
				}
				if(jlRocas.getIcon() == (Icon)iiTache || jlChasser.getIcon() == (Icon)iiTache){
					jlRocas.setIcon(iiTacheP);
					jlChasser.setIcon(iiTacheP);
					jlPuesto.setIcon(iiTache);
					tFormato = 1;
				}
				jlNinguno.setIcon(iiTacheP);
				jlNormal.setIcon(iiTacheP);
				jlCampe.setIcon(iiTacheP);
				jlPintado.setIcon(iiTache);
				tMezcla=4;
			}
		}
	}

	public void procesoFormato(JLabel temporal){
		if(temporal == jlPuesto){
			Icon iconTemp = jlPuesto.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(vGuardoTemp.size() != 0){
					for(int i = 0; i < vGuardoTemp.size(); i++){
						listModel2.addElement(vGuardoTemp.elementAt(i));
					}
					vGuardoTemp = new Vector<String>();
				}
				Icon iconTemp2 = jlNinguno.getIcon();
				if(iconTemp2 == (Icon)iiTache){
					jlNinguno.setIcon(iiTacheP);
					jlNormal.setIcon(iiTache);
					tMezcla = 2;
				}
				jlPuesto.setIcon(iiTache);
				jlDivorciado.setIcon(iiTacheP);
				jlDerecho.setIcon(iiTacheP);
				jlRocas.setIcon(iiTacheP);
				jlChasser.setIcon(iiTacheP);
				tFormato=1;
			}
		}
		else if(temporal == jlDivorciado){
			Icon iconTemp = jlDivorciado.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(vGuardoTemp.size() != 0){
					for(int i = 0; i < vGuardoTemp.size(); i++){
						listModel2.addElement(vGuardoTemp.elementAt(i));
					}
					vGuardoTemp = new Vector<String>();
				}
				Icon iconTemp2 = jlNinguno.getIcon();
				if(iconTemp2 == (Icon)iiTache){
					jlNinguno.setIcon(iiTacheP);
					jlNormal.setIcon(iiTache);
					tMezcla = 2;
				}
				jlPuesto.setIcon(iiTacheP);
				jlDivorciado.setIcon(iiTache);
				jlDerecho.setIcon(iiTacheP);
				jlRocas.setIcon(iiTacheP);
				jlChasser.setIcon(iiTacheP);
				tFormato=2;
			}
		}
		else if(temporal == jlDerecho){
			Icon iconTemp = jlDerecho.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(vGuardoTemp.size() != 0){
					for(int i = 0; i < vGuardoTemp.size(); i++){
						listModel2.addElement(vGuardoTemp.elementAt(i));
					}
					vGuardoTemp = new Vector<String>();
				}
				Icon iconTemp2 = jlNinguno.getIcon();
				if(iconTemp2 == (Icon)iiTache){
					jlNinguno.setIcon(iiTacheP);
					jlNormal.setIcon(iiTache);
					tMezcla = 2;
				}
				jlPuesto.setIcon(iiTacheP);
				jlDivorciado.setIcon(iiTacheP);
				jlDerecho.setIcon(iiTache);
				jlRocas.setIcon(iiTacheP);
				jlChasser.setIcon(iiTacheP);
				tFormato=3;
			}
		}
		else if(temporal == jlRocas){
			Icon iconTemp = jlRocas.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(!listModel2.isEmpty()  && vGuardoTemp.size() == 0){
					for(int i = 0; i<listModel2.getSize(); i++){
						vGuardoTemp.addElement((String) listModel2.elementAt(i));
					}
					listModel2.clear();
				}
				Icon iconTemp2 = jlNinguno.getIcon();
				if(iconTemp2 == (Icon)iiTacheP){
					jlNinguno.setIcon(iiTache);
					jlNormal.setIcon(iiTacheP);
					jlCampe.setIcon(iiTacheP);
					jlPintado.setIcon(iiTacheP);
					tMezcla = 1;
				}
				jlPuesto.setIcon(iiTacheP);
				jlDivorciado.setIcon(iiTacheP);
				jlDerecho.setIcon(iiTacheP);
				jlRocas.setIcon(iiTache);
				jlChasser.setIcon(iiTacheP);
				tFormato=4;
			}
		}
		else if(temporal == jlChasser){
			Icon iconTemp = jlChasser.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				if(!listModel2.isEmpty()  && vGuardoTemp.size() == 0){
					for(int i = 0; i<listModel2.getSize(); i++){
						vGuardoTemp.addElement((String) listModel2.elementAt(i));
					}
					listModel2.clear();
				}
				Icon iconTemp2 = jlNinguno.getIcon();
				if(iconTemp2 == (Icon)iiTacheP){
					jlNinguno.setIcon(iiTache);
					jlNormal.setIcon(iiTacheP);
					jlCampe.setIcon(iiTacheP);
					jlPintado.setIcon(iiTacheP);
					tMezcla = 1;
				}
				jlPuesto.setIcon(iiTacheP);
				jlDivorciado.setIcon(iiTacheP);
				jlDerecho.setIcon(iiTacheP);
				jlRocas.setIcon(iiTacheP);
				jlChasser.setIcon(iiTache);
				tFormato=5;
			}
		}
	}


	public void procesoAdicional(JLabel temporal){
		if(temporal == jlLimon){
			Icon iconTemp = jlLimon.getIcon();
			if (iconTemp == (Icon) iiTache){
				jlLimon.setIcon(iiTacheP);
				if(tAdicional == 1){
					tAdicional = 0;
				}
				else if(tAdicional == 2){
					tAdicional = 3;
				}
				else if(tAdicional == 3){
					tAdicional = 2;
				}
			}
			else{
				jlLimon.setIcon(iiTache);
				if(tAdicional == 0){
					tAdicional = 1;
				}
				else if(tAdicional == 2){
					tAdicional =3;
				}
			}
		}
		else if(temporal == jlSangria){
			Icon iconTemp = jlSangria.getIcon();
			if (iconTemp == (Icon) iiTache){
				jlSangria.setIcon(iiTacheP);
				if(tAdicional == 2){
					tAdicional = 0;
				}
				else if(tAdicional == 1){
					tAdicional = 3;
				}
				else if(tAdicional == 3){
					tAdicional = 1;
				}
			}
			else{
				jlSangria.setIcon(iiTache);
				if(tAdicional == 0){
					tAdicional = 2;
				}
				else if(tAdicional == 1){
					tAdicional = 3;
				}
			}
		}
	}



// Proceso para aceptar la redimension.
	public void procesoRedimensiona (JLabel temporal){
		if(temporal == jlSencillo){
			Icon iconTemp = jlSencillo.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				jlDoble.setIcon(iiTacheP);
				jlTriple.setIcon(iiTacheP);
				jlSencillo.setIcon(iiTache);
				tBebida=1;
			}
		}
		else if(temporal == jlDoble){
			Icon iconTemp = jlDoble.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				jlSencillo.setIcon(iiTacheP);
				jlTriple.setIcon(iiTacheP);
				jlDoble.setIcon(iiTache);
				tBebida=2;
			}
		}
		else if(temporal == jlTriple){
			Icon iconTemp = jlTriple.getIcon();
			if (!(iconTemp == (Icon) iiTache)){
				jlDoble.setIcon(iiTacheP);
				jlSencillo.setIcon(iiTacheP);
				jlTriple.setIcon(iiTache);
				tBebida=3;
			}
		}
	}

	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlSencillo ||  temporal == jlDoble || temporal == jlTriple){
					procesoRedimensiona(temporal);
				}
				else if(temporal == jlPuesto ||  temporal == jlDivorciado || temporal == jlDerecho || temporal == jlRocas || temporal == jlChasser){
					procesoFormato(temporal);
				}
				else if(temporal == jlNinguno ||  temporal == jlNormal || temporal == jlCampe || temporal == jlPintado){
					procesoMezcla(temporal);
				}
				else if(temporal == jlLimon ||  temporal == jlSangria){
					procesoAdicional(temporal);
				}
				else if(temporal == jlAceptar){
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