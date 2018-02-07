package alphanet.ultra.digibar.cliente;

import java.text.NumberFormat;
import java.awt.Font;
import java.awt.Image;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.Frame;
import java.awt.Toolkit;
import java.awt.Component;
import java.util.Calendar;
import javax.swing.UIManager;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.FocusListener;
import java.awt.event.FocusEvent;
import java.awt.event.KeyListener;
import java.awt.event.KeyEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;
import javax.swing.JComboBox;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JFormattedTextField;
import javax.swing.text.MaskFormatter;
import javax.swing.ImageIcon;
import javax.swing.JDialog;
import java.net.URL;
import java.sql.ResultSet;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableColumn;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import java.awt.BorderLayout;
import javax.swing.WindowConstants;
import alphanet.ultra.digibar.bd.Sound;
import javax.swing.JDesktopPane;



public class AltaNota extends JDialog{

	private	JDesktopPane desktop = null;
	public JTextField jtNota;
	protected String laNota;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letra;
	private JLabel jB1, jB2, jB3, jB4, jB5, jB6, jB7, jB8, jB9, jB0 ,jBDiag;
	private JLabel jBq, jBw, jBe, jBr, jBt, jBy, jBu, jBi, jBo, jBp ,jBretro;
	private JLabel jBa, jBs, jBd, jBf, jBg, jBh, jBj, jBk, jBl, jBen;
	private JLabel jBz, jBx, jBc, jBv, jBb, jBn, jBm, jBcoma, jBpunto ;
	private JLabel jBespacio;
	protected JLabel jlBorrar, jlCancela, jlAceptar;
	private ImageIcon iiB1, iiB1P,  iiB2, iiB2P, iiB3, iiB3P, iiB4, iiB4P, iiB5, iiB5P, iiB6, iiB6P, iiB7, iiB7P,  iiB8, iiB8P,  iiB9, iiB9P,  iiB0, iiB0P, iiBDiag, iiBDiagP;
	private ImageIcon iiBq, iiBqP, iiBw, iiBwP, 	iiBe, iiBeP, iiBr, iiBrP, iiBt, iiBtP,  iiBy, iiByP, iiBu, iiBuP, iiBi, iiBiP, iiBo, iiBoP, iiBp, iiBpP, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP;
	private ImageIcon iiBa, iiBaP,  iiBs, iiBsP, iiBd, iiBdP, iiBf, iiBfP, iiBg, iiBgP, iiBh, iiBhP, iiBj, iiBjP,  iiBk, iiBkP,  iiBl, iiBlP,  iiBen, iiBenP;
	private ImageIcon iiBz, iiBzP,  iiBx, iiBxP, iiBc, iiBcP, iiBv, iiBvP,  iiBb, iiBbP, iiBn, iiBnP, iiBm, iiBmP,  iiBcoma, iiBcomaP, iiBpunto, iiBpuntoP ;
	private ImageIcon iiBespacio, iiBespacioP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	protected boolean existioCambio = false;
	private static final long serialVersionUID = 1L;


    public AltaNota(Frame padre, String titulo, boolean modal) throws Exception {
		super(padre, titulo,modal);
		// con esto aseguro que no puedan cerrar mi ventana de manera tradicional.
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void dibujaDialogo() throws Exception{
		son = new Sound();
		setSize(777,634);
		letra=new Font("Eras Demin ITC",Font.BOLD,20);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoAltaNota.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B1.jpg");
		iiB1 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B2.jpg");
		iiB2 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B3.jpg");
		iiB3 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B4.jpg");
		iiB4 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B5.jpg");
		iiB5 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B6.jpg");
		iiB6 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B7.jpg");
		iiB7 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B8.jpg");
		iiB8 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B9.jpg");
		iiB9 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B0.jpg");
		iiB0 = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BDiag.jpg");
		iiBDiag = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B1P.jpg");
		iiB1P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B2P.jpg");
		iiB2P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B3P.jpg");
		iiB3P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B4P.jpg");
		iiB4P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B5P.jpg");
		iiB5P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B6P.jpg");
		iiB6P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B7P.jpg");
		iiB7P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B8P.jpg");
		iiB8P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B9P.jpg");
		iiB9P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/B0P.jpg");
		iiB0P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BDiagP.jpg");
		iiBDiagP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bq.jpg");
		iiBq = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BqP.jpg");
		iiBqP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bw.jpg");
		iiBw = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BwP.jpg");
		iiBwP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Be.jpg");
		iiBe = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BeP.jpg");
		iiBeP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Br.jpg");
		iiBr = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BrP.jpg");
		iiBrP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bt.jpg");
		iiBt = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BtP.jpg");
		iiBtP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/By.jpg");
		iiBy = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ByP.jpg");
		iiByP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bu.jpg");
		iiBu = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BuP.jpg");
		iiBuP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bi.jpg");
		iiBi = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BiP.jpg");
		iiBiP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bo.jpg");
		iiBo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BoP.jpg");
		iiBoP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bp.jpg");
		iiBp = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BpP.jpg");
		iiBpP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bretro.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BretroP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Cancelar.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Aceptar.jpg");
		iiBotonAceptarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAceptarP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Ba.jpg");
		iiBa = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BaP.jpg");
		iiBaP  = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bs.jpg");
		iiBs = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BsP.jpg");
		iiBsP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bd.jpg");
		iiBd = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BdP.jpg");
		iiBdP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bf.jpg");
		iiBf = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BfP.jpg");
		iiBfP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bg.jpg");
		iiBg = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BgP.jpg");
		iiBgP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bh.jpg");
		iiBh = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BhP.jpg");
		iiBhP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bj.jpg");
		iiBj = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BjP.jpg");
		iiBjP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bk.jpg");
		iiBk = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BkP.jpg");
		iiBkP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bl.jpg");
		iiBl = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BlP.jpg");
		iiBlP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bne.jpg");
		iiBen = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BneP.jpg");
		iiBenP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bz.jpg");
		iiBz = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BzP.jpg");
		iiBzP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bx.jpg");
		iiBx = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BxP.jpg");
		iiBxP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bc.jpg");
		iiBc = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BcP.jpg");
		iiBcP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bv.jpg");
		iiBv  = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BvP.jpg");
		iiBvP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bb.jpg");
		iiBb = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BbP.jpg");
		iiBbP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bn.jpg");
		iiBn = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BnP.jpg");
		iiBnP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bm.jpg");
		iiBm = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BmP.jpg");
		iiBmP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bcoma.jpg");
		iiBcoma = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BcomaP.jpg");
		iiBcomaP  = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bpunto.jpg");
		iiBpunto = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BpuntoP.jpg");
		iiBpuntoP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Bespacio.jpg");
		iiBespacio = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BespacioP.jpg");
		iiBespacioP = new ImageIcon(url);
		// Doy formato a mis campos de Texto:
		jtNota = new JTextField(30);
		jtNota.setHorizontalAlignment(JTextField.CENTER);
		jtNota.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtNota.setBounds(34,110,675,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,770,604);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jB1 = new JLabel(iiB1);
		jB1.setBounds(18,168,50,41);
		jB1.addMouseListener(new mouseComportamientoLabels());
		jB2 = new JLabel(iiB2);
		jB2.setBounds(83,168,50,41);
		jB2.addMouseListener(new mouseComportamientoLabels());
		jB3 = new JLabel(iiB3);
		jB3.setBounds(148,168,50,41);
		jB3.addMouseListener(new mouseComportamientoLabels());
		jB4 = new JLabel(iiB4);
		jB4.setBounds(213,168,50,41);
		jB4.addMouseListener(new mouseComportamientoLabels());
		jB5 = new JLabel(iiB5);
		jB5.setBounds(278,168,50,41);
		jB5.addMouseListener(new mouseComportamientoLabels());
		jB6 = new JLabel(iiB6);
		jB6.setBounds(343,168,50,41);
		jB6.addMouseListener(new mouseComportamientoLabels());
		jB7 = new JLabel(iiB7);
		jB7.setBounds(408,168,50,41);
		jB7.addMouseListener(new mouseComportamientoLabels());
		jB8 = new JLabel(iiB8);
		jB8.setBounds(473,168,50,41);
		jB8.addMouseListener(new mouseComportamientoLabels());
		jB9 = new JLabel(iiB9);
		jB9.setBounds(538,168,50,41);
		jB9.addMouseListener(new mouseComportamientoLabels());
		jB0 = new JLabel(iiB0);
		jB0.setBounds(603,168,50,41);
		jB0.addMouseListener(new mouseComportamientoLabels());
		jBDiag = new JLabel(iiBDiag);
		jBDiag.setBounds(668,168,50,41);
		jBDiag.addMouseListener(new mouseComportamientoLabels());
		jBq = new JLabel(iiBq);
		jBq.setBounds(28,239,50,41);
		jBq.addMouseListener(new mouseComportamientoLabels());
		jBw = new JLabel(iiBw);
		jBw.setBounds(94,239,50,41);
		jBw.addMouseListener(new mouseComportamientoLabels());
		jBe = new JLabel(iiBe);
		jBe.setBounds(159,239,50,41);
		jBe.addMouseListener(new mouseComportamientoLabels());
		jBr = new JLabel(iiBr);
		jBr.setBounds(224,239,50,41);
		jBr.addMouseListener(new mouseComportamientoLabels());
		jBt = new JLabel(iiBt);
		jBt.setBounds(289,239,50,41);
		jBt.addMouseListener(new mouseComportamientoLabels());
		jBy = new JLabel(iiBy);
		jBy.setBounds(354,239,50,41);
		jBy.addMouseListener(new mouseComportamientoLabels());
		jBu = new JLabel(iiBu);
		jBu.setBounds(419,239,50,41);
		jBu.addMouseListener(new mouseComportamientoLabels());
		jBi = new JLabel(iiBi);
		jBi.setBounds(484,239,50,41);
		jBi.addMouseListener(new mouseComportamientoLabels());
		jBo = new JLabel(iiBo);
		jBo.setBounds(549,239,50,41);
		jBo.addMouseListener(new mouseComportamientoLabels());
		jBp = new JLabel(iiBp);
		jBp.setBounds(614,239,50,41);
		jBp.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(679,239,60,41);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jBa = new JLabel(iiBa);
		jBa.setBounds(43,308,50,41);
		jBa.addMouseListener(new mouseComportamientoLabels());
		jBs = new JLabel(iiBs);
		jBs.setBounds(109,308,50,41);
		jBs.addMouseListener(new mouseComportamientoLabels());
		jBd = new JLabel(iiBd);
		jBd.setBounds(174,308,50,41);
		jBd.addMouseListener(new mouseComportamientoLabels());
		jBf = new JLabel(iiBf);
		jBf.setBounds(239,308,50,41);
		jBf.addMouseListener(new mouseComportamientoLabels());
		jBg = new JLabel(iiBg);
		jBg.setBounds(304,308,50,41);
		jBg.addMouseListener(new mouseComportamientoLabels());
		jBh = new JLabel(iiBh);
		jBh.setBounds(369,308,50,41);
		jBh.addMouseListener(new mouseComportamientoLabels());
		jBj = new JLabel(iiBj);
		jBj.setBounds(434,308,50,41);
		jBj.addMouseListener(new mouseComportamientoLabels());
		jBk = new JLabel(iiBk);
		jBk.setBounds(499,308,50,41);
		jBk.addMouseListener(new mouseComportamientoLabels());
		jBl = new JLabel(iiBl);
		jBl.setBounds(564,308,50,41);
		jBl.addMouseListener(new mouseComportamientoLabels());
		jBen = new JLabel(iiBen);
		jBen.setBounds(634,308,50,41);
		jBen.addMouseListener(new mouseComportamientoLabels());
		jBz= new JLabel(iiBz);
		jBz.setBounds(58,378,50,41);
		jBz.addMouseListener(new mouseComportamientoLabels());
		jBx= new JLabel(iiBx);
		jBx.setBounds(124,378,50,41);
		jBx.addMouseListener(new mouseComportamientoLabels());
		jBc= new JLabel(iiBc);
		jBc.setBounds(189,378,50,41);
		jBc.addMouseListener(new mouseComportamientoLabels());
		jBv= new JLabel(iiBv);
		jBv.setBounds(254,378,50,41);
		jBv.addMouseListener(new mouseComportamientoLabels());
		jBb= new JLabel(iiBb);
		jBb.setBounds(319,378,50,41);
		jBb.addMouseListener(new mouseComportamientoLabels());
		jBn= new JLabel(iiBn);
		jBn.setBounds(384,378,50,41);
		jBn.addMouseListener(new mouseComportamientoLabels());
		jBm= new JLabel(iiBm);
		jBm	.setBounds(449,378,50,41);
		jBm.addMouseListener(new mouseComportamientoLabels());
		jBcoma= new JLabel(iiBcoma);
		jBcoma.setBounds(514,378,50,41);
		jBcoma.addMouseListener(new mouseComportamientoLabels());
		jBpunto= new JLabel(iiBpunto);
		jBpunto.setBounds(584,378,50,41);
		jBpunto.addMouseListener(new mouseComportamientoLabels());
		jBespacio= new JLabel(iiBespacio);
		jBespacio.setBounds(111,449,517,41);
		jBespacio.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (590,530,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(30,530,152,55);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		setResizable(false);
		// Lleno mi contenedor con los elementos para que los despliegue
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		getContentPane().add(jB1);
		getContentPane().add(jB2);
		getContentPane().add(jB3);
		getContentPane().add(jB4);
		getContentPane().add(jB5);
		getContentPane().add(jB6);
		getContentPane().add(jB7);
		getContentPane().add(jB8);
		getContentPane().add(jB9);
		getContentPane().add(jB0);
		getContentPane().add(jBDiag);
		getContentPane().add(jBq);
		getContentPane().add(jBw);
		getContentPane().add(jBe);
		getContentPane().add(jBr);
		getContentPane().add(jBt);
		getContentPane().add(jBy);
		getContentPane().add(jBu);
		getContentPane().add(jBi);
		getContentPane().add(jBo);
		getContentPane().add(jBp);
		getContentPane().add(jlBorrar);
		getContentPane().add(jBa);
		getContentPane().add(jBs);
		getContentPane().add(jBd);
		getContentPane().add(jBf);
		getContentPane().add(jBg);
		getContentPane().add(jBh);
		getContentPane().add(jBj);
		getContentPane().add(jBk);
		getContentPane().add(jBl);
		getContentPane().add(jBen);
		getContentPane().add(jBz);
		getContentPane().add(jBx);
		getContentPane().add(jBc);
		getContentPane().add(jBv);
		getContentPane().add(jBb);
		getContentPane().add(jBn);
		getContentPane().add(jBm);
		getContentPane().add(jBcoma);
		getContentPane().add(jBpunto);
		getContentPane().add(jBespacio);
		getContentPane().add(jlCancela);
		getContentPane().add(jlAceptar);
		getContentPane().add(jtNota);
		getContentPane().add(jlFondo);
		// Muestro el contenido del contenedor
		setVisible(true);
    	jtNota.requestFocus();
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
			if(jtNota.getText().trim().length() == 0){
				MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "Debes escribir una observación o usar Cancelar.");
				mn.dibujaDialogo();
			}
			else{
				laNota = jtNota.getText().trim();
				existioCambio = true;
				Cierra();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			Cierra();
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
				if(temporal == jB1){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"1");
					}
				}
				else if(temporal == jB2){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"2");
					}
				}
				else if(temporal == jB3){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"3");
					}
				}
				else if(temporal == jB4){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"4");
					}
				}
				else if(temporal == jB5){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"5");
					}
				}
				else if(temporal == jB6){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"6");
					}
				}
				else if(temporal == jB7){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"7");
					}
				}
				else if(temporal == jB8){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"8");
					}
				}
				else if(temporal == jB9){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"9");
					}
				}
				else if(temporal == jB0){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"0");
					}
				}
				else if(temporal == jBDiag){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"/");
					}
				}
				else if(temporal == jBq){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"q");
					}
				}
				else if(temporal == jBw){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"w");
					}
				}
				else if(temporal == jBe){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"e");
					}
				}
				else if(temporal == jBr){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"r");
					}
				}
				else if(temporal == jBt){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"t");
					}
				}
				else if(temporal == jBy){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"y");
					}
				}
				else if(temporal == jBu){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"u");
					}
				}
				else if(temporal == jBi){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"i");
					}
				}
				else if(temporal == jBo){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"o");
					}
				}
				else if(temporal == jBp){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"p");
					}
				}
				else if(temporal == jBa){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"a");
					}
				}
				else if(temporal == jBs){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"s");
					}
				}
				else if(temporal == jBd){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"d");
					}
				}
				else if(temporal == jBf){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"f");
					}
				}
				else if(temporal == jBg){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"g");
					}
				}
				else if(temporal == jBh){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"h");
					}
				}
				else if(temporal == jBj){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"j");
					}
				}
				else if(temporal == jBk){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"k");
					}
				}
				else if(temporal == jBl){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"l");
					}
				}
				else if(temporal == jBen){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"ñ");
					}
				}
				else if(temporal == jBz){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"z");
					}
				}
				else if(temporal == jBx){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"x");
					}
				}
				else if(temporal == jBc){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"c");
					}
				}
				else if(temporal == jBv){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"v");
					}
				}
				else if(temporal == jBb){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"b");
					}
				}
				else if(temporal == jBn){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"n");
					}
				}
				else if(temporal == jBm){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+"m");
					}
				}
				else if(temporal == jBcoma){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+",");
					}
				}
				else if(temporal == jBpunto){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+".");
					}
				}
				else if(temporal == jBespacio){
					String previo = jtNota.getText();
					if (previo.length() < 36){
						jtNota.setText(previo+" ");
					}
				}
				else if(temporal == jlBorrar){
					String anterior = jtNota.getText();
					if(anterior.length() > 0){
						jtNota.setText(anterior.substring(0, anterior.length()-1));
					}
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAceptar){
					procesoAceptar();
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
				if(temporal == jB1){
					jB1.setIcon(iiB1P);
				}
				else if(temporal == jB2){
					jB2.setIcon(iiB2P);
				}
				else if(temporal == jB3){
					jB3.setIcon(iiB3P);
				}
				else if(temporal == jB4){
					jB4.setIcon(iiB4P);
				}
				else if(temporal == jB5){
					jB5.setIcon(iiB5P);
				}
				else if(temporal == jB6){
					jB6.setIcon(iiB6P);
				}
				else if(temporal == jB7){
					jB7.setIcon(iiB7P);
				}
				else if(temporal == jB8){
					jB8.setIcon(iiB8P);
				}
				else if(temporal == jB9){
					jB9.setIcon(iiB9P);
				}
				else if(temporal == jB0){
					jB0.setIcon(iiB0P);
				}
				else if(temporal == jBDiag){
					jBDiag.setIcon(iiBDiagP);
				}
				else if(temporal == jBq){
					jBq.setIcon(iiBqP);
				}
				else if(temporal == jBw){
					jBw.setIcon(iiBwP);
				}
				else if(temporal == jBe){
					jBe.setIcon(iiBeP);
				}
				else if(temporal == jBr){
					jBr.setIcon(iiBrP);
				}
				else if(temporal == jBt){
					jBt.setIcon(iiBtP);
				}
				else if(temporal == jBy){
					jBy.setIcon(iiByP);
				}
				else if(temporal == jBu){
					jBu.setIcon(iiBuP);
				}
				else if(temporal == jBi){
					jBi.setIcon(iiBiP);
				}
				else if(temporal == jBo){
					jBo.setIcon(iiBoP);
				}
				else if(temporal == jBp){
					jBp.setIcon(iiBpP);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBP);
				}
				else if(temporal == jBa){
					jBa.setIcon(iiBaP);
				}
				else if(temporal == jBs){
					jBs.setIcon(iiBsP);
				}
				else if(temporal == jBd){
					jBd.setIcon(iiBdP);
				}
				else if(temporal == jBf){
					jBf.setIcon(iiBfP);
				}
				else if(temporal == jBg){
					jBg.setIcon(iiBgP);
				}
				else if(temporal == jBh){
					jBh.setIcon(iiBhP);
				}
				else if(temporal == jBj){
					jBj.setIcon(iiBjP);
				}
				else if(temporal == jBk){
					jBk.setIcon(iiBkP);
				}
				else if(temporal == jBl){
					jBl.setIcon(iiBlP);
				}
				else if(temporal == jBen){
					jBen.setIcon(iiBenP);
				}
				else if(temporal == jBz){
					jBz.setIcon(iiBzP);
				}
				else if(temporal == jBx){
					jBx.setIcon(iiBxP);
				}
				else if(temporal == jBc){
					jBc.setIcon(iiBcP);
				}
				else if(temporal == jBv){
					jBv.setIcon(iiBvP);
				}
				else if(temporal == jBb){
					jBb.setIcon(iiBbP);
				}
				else if(temporal == jBn){
					jBn.setIcon(iiBnP);
				}
				else if(temporal == jBm){
					jBm.setIcon(iiBmP);
				}
				else if(temporal == jBcoma){
					jBcoma.setIcon(iiBcomaP);
				}
				else if(temporal == jBpunto){
					jBpunto.setIcon(iiBpuntoP);
				}
				else if(temporal == jBespacio){
					jBespacio.setIcon(iiBespacioP);
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
				if(temporal == jB1){
					jB1.setIcon(iiB1);
				}
				else if(temporal == jB2){
					jB2.setIcon(iiB2);
				}
				else if(temporal == jB3){
					jB3.setIcon(iiB3);
				}
				else if(temporal == jB4){
					jB4.setIcon(iiB4);
				}
				else if(temporal == jB5){
					jB5.setIcon(iiB5);
				}
				else if(temporal == jB6){
					jB6.setIcon(iiB6);
				}
				else if(temporal == jB7){
					jB7.setIcon(iiB7);
				}
				else if(temporal == jB8){
					jB8.setIcon(iiB8);
				}
				else if(temporal == jB9){
					jB9.setIcon(iiB9);
				}
				else if(temporal == jB0){
					jB0.setIcon(iiB0);
				}
				else if(temporal == jBDiag){
					jBDiag.setIcon(iiBDiag);
				}
				else if(temporal == jBq){
					jBq.setIcon(iiBq);
				}
				else if(temporal == jBw){
					jBw.setIcon(iiBw);
				}
				else if(temporal == jBe){
					jBe.setIcon(iiBe);
				}
				else if(temporal == jBr){
					jBr.setIcon(iiBr);
				}
				else if(temporal == jBt){
					jBt.setIcon(iiBt);
				}
				else if(temporal == jBy){
					jBy.setIcon(iiBy);
				}
				else if(temporal == jBu){
					jBu.setIcon(iiBu);
				}
				else if(temporal == jBi){
					jBi.setIcon(iiBi);
				}
				else if(temporal == jBo){
					jBo.setIcon(iiBo);
				}
				else if(temporal == jBp){
					jBp.setIcon(iiBp);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBN);
				}
				else if(temporal == jBa){
					jBa.setIcon(iiBa);
				}
				else if(temporal == jBs){
					jBs.setIcon(iiBs);
				}
				else if(temporal == jBd){
					jBd.setIcon(iiBd);
				}
				else if(temporal == jBf){
					jBf.setIcon(iiBf);
				}
				else if(temporal == jBg){
					jBg.setIcon(iiBg);
				}
				else if(temporal == jBh){
					jBh.setIcon(iiBh);
				}
				else if(temporal == jBj){
					jBj.setIcon(iiBj);
				}
				else if(temporal == jBk){
					jBk.setIcon(iiBk);
				}
				else if(temporal == jBl){
					jBl.setIcon(iiBl);
				}
				else if(temporal == jBen){
					jBen.setIcon(iiBen);
				}
				else if(temporal == jBz){
					jBz.setIcon(iiBz);
				}
				else if(temporal == jBx){
					jBx.setIcon(iiBx);
				}
				else if(temporal == jBc){
					jBc.setIcon(iiBc);
				}
				else if(temporal == jBv){
					jBv.setIcon(iiBv);
				}
				else if(temporal == jBb){
					jBb.setIcon(iiBb);
				}
				else if(temporal == jBn){
					jBn.setIcon(iiBn);
				}
				else if(temporal == jBm){
					jBm.setIcon(iiBm);
				}
				else if(temporal == jBcoma){
					jBcoma.setIcon(iiBcoma);
				}
				else if(temporal == jBpunto){
					jBpunto.setIcon(iiBpunto);
				}
				else if(temporal == jBespacio){
					jBespacio.setIcon(iiBespacio);
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