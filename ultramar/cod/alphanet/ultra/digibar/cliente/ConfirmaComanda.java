package alphanet.ultra.digibar.cliente;

import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JComboBox;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import java.net.URL;
import javax.swing.JDesktopPane;
import javax.swing.JScrollPane;
import javax.swing.JOptionPane;
import javax.swing.UIManager;
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
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableColumn;
import javax.swing.table.TableModel;
import javax.swing.table.AbstractTableModel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.Component;
import javax.swing.JFrame;
import javax.swing.table.DefaultTableModel;
import alphanet.ultra.digibar.bd.MultiLineCellRenderer;
import javax.swing.DefaultListModel;


public class ConfirmaComanda extends JInternalFrame {

	private	JDesktopPane desktop = null;
	protected String mesaAlta;
	protected Vector <String> vMeseras;
	protected Vector <Object> datos;
	protected String contra = "";
	int mesaID = 0;
	public JTextField jtContra;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letra, letra2, letraT, letraTH;
	protected JComboBox jcMeseras;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0, jlMesa;
	protected JLabel jlBorrar, jlCancela, jlAceptar, jlModifica, jlElimina, jlFormato;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP, iiMesa, iiModifica, iiModificaP, iiElimina, iiEliminaP, iiFormato, iiFormatoP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	protected JTable  jtSolicitado;
	protected int renglonGlobalSolicitado = -1;
	private JTableHeader jth;
	protected TableModelVector tmv ;
	private TableColumn column;
	protected JScrollPane jscroll ;
	protected TableModel am = null;
	private static final long serialVersionUID = 1L;

    public ConfirmaComanda() throws Exception {
        super("Confirmación Comanda", false, true, false);
        // Tamaño de la Ventana
        setSize(821,654);
        // Localización de la Ventana
        setLocation(16,1);
        // Contenido de la Ventana
	}

	protected void setProductosSolicitdos(Vector<Object> datos){
		this.datos = datos;
//		for(int i = 0; i<datos.size(); i++){
//			System.out.println("Datos i --> " +datos.elementAt(i));
//		}
	}

	protected void setMesaTrabaja(String mesaAlta){
		this.mesaAlta =mesaAlta;
		mesaID = Integer.parseInt(mesaAlta);
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.PLAIN,18);
		letra2=new Font("Eras Demin ITC",Font.BOLD,30);
		letraTH=new Font("Arial Narrow",Font.PLAIN,14);
		letraT=new Font("Arial Narrow",Font.PLAIN,13);
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
		url= getClass().getResource("/imas/fondoConfirmaComanda.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Formato.jpg");
		iiFormato = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/FormatoP.jpg");
		iiFormatoP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Elimina.jpg");
		iiElimina = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EliminaP.jpg");
		iiEliminaP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Modifica.jpg");
		iiModifica = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ModificaP.jpg");
		iiModificaP = new ImageIcon(url);
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
		UIManager.put("ScrollBar.width", new Integer(50));
		Vector <Object> titulos = new Vector <Object>();
		titulos.addElement("Cantidad");
		titulos.addElement("ClaveG");
		titulos.addElement("Comen#");
		titulos.addElement("Producto");
		titulos.addElement("Tipo");
		titulos.addElement("Nota");
		titulos.addElement("Bebida");
		titulos.addElement("Formato");
		titulos.addElement("Mezcla");
		titulos.addElement("Adicional");
		titulos.addElement("Comb/Tiempos");
		Vector <Object> datos2 = cliente.bs.nuevaListaProducto(datos);
		tmv = new TableModelVector(titulos,datos2);
		jtSolicitado = new JTable(tmv);
		jscroll = new JScrollPane(jtSolicitado,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		//jtSolicitado.setFont(letraT);
		jtSolicitado.setRowSelectionAllowed(true);
		jtSolicitado.setColumnSelectionAllowed(false);
		jtSolicitado.setShowGrid(true);
		jtSolicitado.setRowHeight(40);
		TableColumnModel cmodel = jtSolicitado.getColumnModel();
		MultiLineCellRenderer cellAreaRenderer = new MultiLineCellRenderer();
		cmodel.getColumn(10).setCellRenderer(cellAreaRenderer);
		jth = new JTableHeader();
		jth = jtSolicitado.getTableHeader();
		jth.setFont(letraTH);
		jscroll.setBounds(55, 42, 725,243);
		column = null;
		CenterRenderer centerRenderer = new CenterRenderer();
		column = jtSolicitado.getColumnModel().getColumn(0);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(47);
		column.setMinWidth(47);
		column.setMaxWidth(47);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(1);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(0);
		column.setMinWidth(0);
		column.setMaxWidth(0);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(2);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(48);
		column.setMinWidth(48);
		column.setMaxWidth(48);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(4);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(50);
		column.setMinWidth(50);
		column.setMaxWidth(50);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(6);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(50);
		column.setMinWidth(50);
		column.setMaxWidth(50);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(7);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(55);
		column.setMinWidth(55);
		column.setMaxWidth(55);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(8);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(60);
		column.setMinWidth(60);
		column.setMaxWidth(60);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(9);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(60);
		column.setMinWidth(60);
		column.setMaxWidth(60);
		column.setResizable(false);
		LeftRenderer leftRender = new LeftRenderer();
		column = jtSolicitado.getColumnModel().getColumn(3);
		column.setCellRenderer( leftRender );
		column.setPreferredWidth(110);
		column.setMinWidth(110);
		column.setMaxWidth(110);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(5);
		column.setCellRenderer( leftRender );
		column.setPreferredWidth(90);
		column.setMinWidth(90);
		column.setMaxWidth(90);
		column.setResizable(false);
		column = jtSolicitado.getColumnModel().getColumn(10);
		//column.setCellRenderer( leftRender );
		column.setPreferredWidth(110);
		column.setMinWidth(110);
		column.setMaxWidth(110);
		column.setResizable(false);
		ListSelectionModel filaSM = jtSolicitado.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas());
		vMeseras = cliente.bs.DameListadoTodos();
		jcMeseras = new JComboBox();
		for(int i = 0; i<vMeseras.size() ; i++){
			String nombre = cliente.ma.decodifica(vMeseras.elementAt(i));
			jcMeseras.addItem(nombre);
		}
		jcMeseras.setFont(letra);
		jcMeseras.setBounds(122,362,300,40);
		String IDMeseroAsignado = cliente.bs.DameMeseroAsignado(mesaID);
		jcMeseras.setSelectedItem(IDMeseroAsignado);
		// Doy formato a mis campos de Texto:
		jtContra = new JTextField(30);
		jtContra.setHorizontalAlignment(JTextField.CENTER);
		jtContra.setFont(letra2);
		// Acomodo mis campos dentro de la ventana.
		jtContra.setBounds(122,421,300,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(811,636,0,0);
		if(mesaID !=0){
			jlMesa = new JLabel(iiMesa);
			jlMesa.setBounds(515,6,43,27);
		}
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlModifica = new JLabel(iiModifica);
		jlModifica.setBounds(117,292,138,41);
		jlModifica.addMouseListener(new mouseComportamientoLabels());
		jlElimina = new JLabel(iiElimina);
		jlElimina.setBounds(500,290,137,41);
		jlElimina.addMouseListener(new mouseComportamientoLabels());
		jlFormato = new JLabel(iiFormato);
		jlFormato.setBounds(311,292,137,41);
		jlFormato.addMouseListener(new mouseComportamientoLabels());
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(431,373,58,55);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(501,373,58,55);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(571,373,58,55);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(641,373,58,55);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(711,373,58,55);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(431,453,58,55);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(501,453,58,55);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(571,453,58,55);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(641,453,58,55);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(711,453,58,55);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(171,473,131,55);
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
		this.add(jscroll);
		this.add(jlModifica);
		this.add(jlElimina);
		this.add(jlFormato);
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
		this.add(jtContra);
		this.add(jcMeseras);
		// Si el tipo de precio es por Grupos despligo aviso.
		this.add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
    	setVisible(true);
    	jtContra.requestFocus();
	}

	public void procesoElimina() throws Exception{
		if(renglonGlobalSolicitado == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto  (Alimento o Bebida)");
		}
		else{
			tmv.removeRow(renglonGlobalSolicitado);
			jtSolicitado.clearSelection();
			renglonGlobalSolicitado = -1;
		}
	}

	public void procesoDaFormato() throws Exception{
//		System.out.println("Renglon Global Solicitado = "+renglonGlobalSolicitado);
		if(renglonGlobalSolicitado == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto (Bebida o Alimento)");
		}
		else{
			int renglonTrabajando = renglonGlobalSolicitado;
//			System.out.println("Renglon Global Solicitado = "+renglonGlobalSolicitado +", renglonTrabajando = "+renglonTrabajando);
			String tipoDeProducto = ((String)tmv.getValueAt(renglonGlobalSolicitado, 1));
			tipoDeProducto =	tipoDeProducto.substring(0,1);
			int idTipoP = cliente.ma.cambiaAInt(tipoDeProducto);
			tipoDeProducto = ((String)tmv.getValueAt(renglonGlobalSolicitado, 1));
			String laClaveDeBotana = cliente.bs.dameClaveBotana();
			if(idTipoP == 1){
				if(tipoDeProducto.substring(tipoDeProducto.indexOf("*")+1, tipoDeProducto.lastIndexOf("*")).trim().equalsIgnoreCase(laClaveDeBotana+"")){
					ModComBotana mcb = new ModComBotana((JFrame)cliente, "Asignacion Componente de Botana", true);
					mcb.setLocationRelativeTo(null);
					mcb.setPadre(cliente);
					mcb.setTComponente((String)tmv.getValueAt(renglonGlobalSolicitado,10));
					mcb.despliegaInterfaz();
					if(mcb.dioAceptar){
						DefaultListModel tempDLM = mcb.listModel2;
						String componentes = "";
						for(int i = 0; i < tempDLM.size(); i++){
							componentes += tempDLM.elementAt(i);
							if(i+1 != tempDLM.size()){
								componentes += "\n";
							}
						}
						tmv.setValueAt(componentes,renglonTrabajando,10);
					}
				}
				else{
					JOptionPane.showInternalMessageDialog(cliente.desktop, "Este Alimento no recibe Formato");
				}
			}
			else{
				String tipoBebidaR = (String) tmv.getValueAt(renglonGlobalSolicitado, 6);
				String tipoCombina1 = (String)tmv.getValueAt(renglonGlobalSolicitado, 10);
				boolean esCombinable = false;
				boolean esRedimensionable = false;
				if(!tipoCombina1.trim().equalsIgnoreCase("NA")){
					esCombinable = true;
				}
				if(!tipoBebidaR.trim().equalsIgnoreCase("NA")){
					esRedimensionable = true;
				}
				if(!esCombinable && !esRedimensionable){
					JOptionPane.showInternalMessageDialog(cliente.desktop, "Esta Bebida no acepta ningun Formato");
				}
				else{
					ModCombForBeb mcfb = new ModCombForBeb((JFrame)cliente, "Modificación Combinación/Formato de Bebida", true);
					mcfb.setLocationRelativeTo(null);
					mcfb.setPadre(cliente);
					mcfb.setEsCombinable(esCombinable);
					mcfb.setEsRedimensionable(esRedimensionable);
					mcfb.setNombreBebida((String)tmv.getValueAt(renglonGlobalSolicitado,3));
					mcfb.setTipoBebida((String)tmv.getValueAt(renglonGlobalSolicitado,4));
					mcfb.setTCombina((String)tmv.getValueAt(renglonGlobalSolicitado,10));
					if(esCombinable){
						mcfb.setTFormato((String)tmv.getValueAt(renglonGlobalSolicitado,7));
						mcfb.setTMezcla((String)tmv.getValueAt(renglonGlobalSolicitado,8));
						mcfb.setTAdicional((String)tmv.getValueAt(renglonGlobalSolicitado,9));
					}
					if(esRedimensionable){
						mcfb.setTBebida(tipoBebidaR);
					}
					mcfb.despliegaInterfaz();
					if(mcfb.dioAceptar){
						int tBebida = mcfb.tBebida;
						int tFormato = mcfb.tFormato;
						int tMezcla = mcfb.tMezcla;
						int tAdicional = mcfb.tAdicional;
						Vector<String> vCombina = mcfb.bebSolicitadas;
						if(esRedimensionable){
							String tamanioBebida = "";
							if(tBebida == 1){
								tamanioBebida = "Sencillo";
							}
							else if(tBebida == 2){
								tamanioBebida = "Doble";
							}
							else if(tBebida == 3){
								tamanioBebida = "Triple";
							}
							tmv.setValueAt(tamanioBebida,renglonTrabajando, 6);
						}
						if(esCombinable){
							String formatoBebida = "";
							String mezclaBebida = "";
							String adicionalBebida = "";
							String compuesto = "";
							if(tFormato == 0){
								formatoBebida = "NA";
							}
							else if(tFormato == 1){
								formatoBebida = "Puesto";
							}
							else if(tFormato == 2){
								formatoBebida = "Divorciado";
							}
							else if(tFormato == 2){
								formatoBebida = "Divorciado";
							}
							else if(tFormato == 3){
								formatoBebida = "Derecho";
							}
							else if(tFormato == 4){
								formatoBebida = "Rocas";
							}
							else if(tFormato == 5){
								formatoBebida = "Chasser";
							}
							tmv.setValueAt(formatoBebida,renglonTrabajando, 7);
							if(tMezcla == 0){
								mezclaBebida = "NA";
							}
							else if(tMezcla == 1){
								mezclaBebida = "Ninguno";
							}
							if(tMezcla == 2){
								mezclaBebida = "Normal";
							}
							if(tMezcla == 3){
								mezclaBebida = "Campechano";
							}
							if(tMezcla == 4){
								mezclaBebida = "Pintado";
							}
							tmv.setValueAt(mezclaBebida,renglonTrabajando, 8);
							if(tAdicional == 0){
								adicionalBebida = "No";
							}
							if(tAdicional == 1){
								adicionalBebida = "C.Limon";
							}
							if(tAdicional == 2){
								adicionalBebida = "C.Sangrita";
							}
							if(tAdicional == 3){
								adicionalBebida = "Cs.Lim.San.";
							}
							tmv.setValueAt(adicionalBebida,renglonTrabajando, 9);

							for(int i = 0; i<vCombina.size(); i++){
								if(!vCombina.elementAt(0).equalsIgnoreCase("")){
									compuesto +=vCombina.elementAt(i)+"\n";
								}
							}
							tmv.setValueAt(compuesto,renglonTrabajando,10);
						}
					}
				}
			}
			jtSolicitado.clearSelection();
			renglonGlobalSolicitado = -1;
		}
	}

	public void procesoModifica() throws Exception{
		if(renglonGlobalSolicitado == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto (Alimento o Bebida)");
		}
		else{
			String cantidad = 	(String)tmv.getValueAt(renglonGlobalSolicitado, 0);
			DialogoModificaSP2 dmsp = new DialogoModificaSP2((JFrame)cliente, "Modificación Cantidad de Producto", true);
			dmsp.setLocationRelativeTo(null);
			dmsp.setPadre(cliente);
			int cantidadActual = 0;
			cantidadActual = cliente.ma.cambiaAInt(cantidad);
			dmsp.setCantidadActual(cantidadActual);
			dmsp.dibujaDialogo();
			if(dmsp.existioCambio){
				tmv.setValueAt(dmsp.jtCantidad.getText().trim(), renglonGlobalSolicitado, 0  );
			}
		}
	}


// Referencia directa a la Interfaz para cambiar valor de tipoPrecio.
	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void procesoAceptar() {
		try{
			if(jtSolicitado.getRowCount() == 0){
				JOptionPane.showInternalMessageDialog(cliente.desktop, "No existen productos, presiona el boton Cancelar.");
			}
			else if(jtContra.getText().trim().length() == 0){
				JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes escribir la contraseña del Usuario solicitado.");
			}
			else{
				String usuarioID = (String) jcMeseras.getSelectedItem();
				usuarioID = usuarioID.substring(usuarioID.lastIndexOf(">")+1, usuarioID.length()).trim();
				int userID = cliente.ma.cambiaAInt(usuarioID);
				boolean autentificacion = cliente.bs.autentificaUsuario(userID, cliente.ma.cambiaAInt(contra));
				if (!autentificacion){
					JOptionPane.showInternalMessageDialog(cliente.desktop, "No concuerda tu contraseña con el Usuario especificado.");
					jtContra.setText("");
					contra="";
					jtContra.requestFocus();
				}
				else{
					Vector <String> resultadoAlmacena = cliente.bs.AlmacenaComanda(mesaID, tmv.datos, userID);
					if(resultadoAlmacena != null){
						String resultado= resultadoAlmacena.elementAt(0);
						if(resultado.equalsIgnoreCase("OK")){
							Cierra();
						}
						else if(resultado.equalsIgnoreCase("Promocion")){
							String avisote = "";
							for (int i = 1; i<resultadoAlmacena.size(); i++){
								avisote = "> "+resultadoAlmacena.elementAt(i)+"\n";
							}
							JOptionPane.showInternalMessageDialog(cliente.desktop, avisote);
							Cierra();
						}
						else if(resultado.equalsIgnoreCase("Error")){
							JOptionPane.showInternalMessageDialog(cliente.desktop, "Error al intentar almacenar en BD vuelva a intentarlo.");
							Cierra();
						}
						else{
//							System.out.println("Entre al else de faltantes");
							String avisote = "";
							for (int i = 0; i<resultadoAlmacena.size(); i++){
								if(!resultadoAlmacena.elementAt(i).trim().equalsIgnoreCase("OK")){
									avisote = "> "+resultadoAlmacena.elementAt(i)+"\n";
									JOptionPane.showInternalMessageDialog(cliente.desktop, avisote);
								}
							}
						}
					}
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en ConfirmaComanda.\nVuelva a intentarlo.");
			Cierra();
		}
	}

	// Con este detecto que renglon seleccionaron para eliminar.
	protected class SeleccionFilas implements ListSelectionListener {
		public void valueChanged(ListSelectionEvent e) {
			if (e.getValueIsAdjusting()) return;
			ListSelectionModel lsm = (ListSelectionModel)e.getSource();
			if (lsm.isSelectionEmpty()) {
					renglonGlobalSolicitado = -1;
			}
			else {
				int selectedRow = lsm.getMinSelectionIndex();
				renglonGlobalSolicitado  = selectedRow;
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
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"1";
					}
				}
				else if(temporal == jlBoton2){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"2";
					}
				}
				else if(temporal == jlBoton3){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"3";
					}
				}
				else if(temporal == jlBoton4){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"4";
					}
				}
				else if(temporal == jlBoton5){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"5";
					}
				}
				else if(temporal == jlBoton6){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"6";
					}
				}
				else if(temporal == jlBoton7){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"7";
					}
				}
				else if(temporal == jlBoton8){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"8";
					}
				}
				else if(temporal == jlBoton9){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"9";
					}
				}
				else if(temporal == jlBoton0){
					String previo = jtContra.getText();
					if (previo.length() < 4){
						jtContra.setText(previo+"*");
						contra = contra+"0";
					}
				}
				else if(temporal == jlBorrar){
					jtContra.setText("");
					contra = "";
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAceptar){
					procesoAceptar();
				}
				else if(temporal == jlElimina){
					procesoElimina();
				}
				else if(temporal == jlModifica){
					procesoModifica();
				}
				else if(temporal == jlFormato){
					procesoDaFormato();
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
				else if(temporal == jlModifica){
					jlModifica.setIcon(iiModificaP);
				}
				else if(temporal == jlElimina){
					jlElimina.setIcon(iiEliminaP);
				}
				else if(temporal == jlFormato){
					jlFormato.setIcon(iiFormatoP);
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
				else if(temporal == jlModifica){
					jlModifica.setIcon(iiModifica);
				}
				else if(temporal == jlElimina){
					jlElimina.setIcon(iiElimina);
				}
				else if(temporal == jlFormato){
					jlFormato.setIcon(iiFormato);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}

    public class CenterRenderer extends DefaultTableCellRenderer {
		private static final long serialVersionUID = 1L;
        public CenterRenderer() {
            setHorizontalAlignment( CENTER );
        }
        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			setFont(letraT);
			return this;
        }
    }

    public class RightRenderer extends DefaultTableCellRenderer {
		private static final long serialVersionUID = 1L;
        public RightRenderer() {
			setHorizontalAlignment( RIGHT );
      	  }
        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			setFont(letraT);
			return this;
        }
	}

    public class LeftRenderer extends DefaultTableCellRenderer {
		private static final long serialVersionUID = 1L;
        public LeftRenderer() {
			setHorizontalAlignment( LEFT );
      	  }
        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			setFont(letraT);
			return this;
        }
	}

}