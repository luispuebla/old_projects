package alphanet.ultra.digibar.cliente;

import javax.swing.JFrame;
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
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableColumn;
import javax.swing.table.TableModel;
import javax.swing.table.AbstractTableModel;
import javax.swing.JTable;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;
import java.awt.Component;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.JScrollBar;

public class ComandaInterna extends JInternalFrame {

	private	JDesktopPane desktop = null;
	protected String mesaAlta;
	protected JComboBox  jcGenero, jcDivision;
	protected JScrollPane jscroll, jscroll2 ;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letraC, letraTH, letraT;
	private TableColumn column, column2;
	protected JLabel  jlModifica, jlAgrega, jlElimina, jlNota, jlCancela, jlAceptar;
	private ImageIcon iiModifica, iiModificaP, iiAgrega, iiAgregaP, iiElimina, iiEliminaP, iiNota, iiNotaP,  iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	protected JTable jtDisponible, jtSolicitado;
	protected int renglonGlobalDisponible = -1, renglonGlobalSolicitado = -1;
	private JTableHeader jth, jth2;
	protected TableModelVector tmv ;
	private static final long serialVersionUID = 1L;

    public ComandaInterna() throws Exception {
        super("Solicitud Personal Alimento-Bebida", false, true, false);
        // Tamaño de la Ventana
        setSize(821,654);
        // Localización de la Ventana
        setLocation(16,1);
        // Contenido de la Ventana
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letraC=new Font("Eras Demin ITC",Font.BOLD,20);
		letraTH=new Font("Arial Narrow",Font.BOLD,18);
		letraT=new Font("Arial Narrow",Font.PLAIN,17);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/botones/Modifica.jpg");
		iiModifica = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ModificaP.jpg");
		iiModificaP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Agrega.jpg");
		iiAgrega = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AgregaP.jpg");
		iiAgregaP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Elimina.jpg");
		iiElimina = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/EliminaP.jpg");
		iiEliminaP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Nota.jpg");
		iiNota = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/NotaP.jpg");
		iiNotaP = new ImageIcon(url);
		url= getClass().getResource("/imas/fondoAltaInterna.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Cancelar.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Aceptar.jpg");
		iiBotonAceptarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAceptarP = new ImageIcon(url);
		UIManager.put("ScrollBar.width", new Integer(50));
		// Doy formato a mis campos de Texto:
		// Acomodo mis campos dentro de la ventana.
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(811,636,0,0);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jcGenero = new JComboBox();
		jcGenero.setFont(letraC);
		jcGenero.addItem("Alimento");
		jcGenero.addItem("Bebida");
		jcGenero.setBounds(235,79,170,35);
		jcGenero.addActionListener(new refrescaDisponibles());
		Vector <String> divisionListado = cliente.bs.listaXDivision(1);
		jcDivision = new JComboBox();
		for (int i = 0; i<divisionListado.size() ; i++){
			jcDivision.addItem(cliente.ma.decodifica(divisionListado.elementAt(i)));
		}
		jcDivision.setFont(letraC);
		jcDivision.setBounds(520,79,265,35);
		jcDivision.addActionListener(new refrescaDisponibles());
		String temporalIDDivision = (String)jcDivision.getSelectedItem();
		temporalIDDivision = temporalIDDivision.substring(temporalIDDivision.lastIndexOf("-")+1, temporalIDDivision.length());
		AbstractTableModel am = cliente.bs.listaProducto(1, cliente.ma.cambiaAInt(temporalIDDivision.trim()));
		jtDisponible = new JTable((TableModel)am);
		jscroll = new JScrollPane(jtDisponible,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		jtDisponible.setFont(letraT);
		jtDisponible.setRowSelectionAllowed(true);
		jtDisponible.setColumnSelectionAllowed(false);
		jtDisponible.setShowGrid(true);
		jtDisponible.setRowHeight(35);
		jth = new JTableHeader();
		jth = jtDisponible.getTableHeader();
		jth.setFont(letraTH);
		jscroll.setBounds(48, 127, 725,155);
		column = null;
		TableCellRenderer rightRender = new RightRenderer();
		column = jtDisponible.getColumnModel().getColumn(4);
		column.setCellRenderer( rightRender );
		column.setPreferredWidth(75);
		column.setMinWidth(75);
		column.setMaxWidth(75);
		column.setResizable(false);
		TableCellRenderer centerRenderer = new CenterRenderer();
		column = jtDisponible.getColumnModel().getColumn(0);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(70);
		column.setMinWidth(70);
		column.setMaxWidth(70);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(1);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(65);
		column.setMinWidth(65);
		column.setMaxWidth(65);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(2);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(394);
		column.setMinWidth(394);
		column.setMaxWidth(394);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(3);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(70);
		column.setMinWidth(70);
		column.setMaxWidth(70);
		column.setResizable(false);
		ListSelectionModel filaSM = jtDisponible.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas());
		Vector <Object> titulos = new Vector <Object>();
		titulos.addElement("Cantidad");
		titulos.addElement("Clave G.");
		titulos.addElement("Producto");
		titulos.addElement("Tipo");
		titulos.addElement("Observacion");
		Vector <Object> datos = new Vector <Object>();
		tmv = new TableModelVector(titulos,datos);
		jtSolicitado = new JTable(tmv);
		jscroll2 = new JScrollPane(jtSolicitado,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		jtSolicitado.setFont(letraT);
		jtSolicitado.setRowSelectionAllowed(true);
		jtSolicitado.setColumnSelectionAllowed(false);
		jtSolicitado.setShowGrid(true);
		jtSolicitado.setRowHeight(35);
		jth2 = new JTableHeader();
		jth2 = jtSolicitado.getTableHeader();
		jth2.setFont(letraTH);
		jscroll2.setVerticalScrollBar(new ReverseScrollBar(JScrollBar.VERTICAL));
		jscroll2.setBounds(48, 335,725,200);
		column2 = null;
		centerRenderer = new CenterRenderer();
		column2 = jtSolicitado.getColumnModel().getColumn(0);
		column2.setCellRenderer( centerRenderer );
		column2.setPreferredWidth(68);
		column2.setMinWidth(68);
		column2.setMaxWidth(68);
		column2.setResizable(false);
		column2 = jtSolicitado.getColumnModel().getColumn(1);
		column2.setCellRenderer( centerRenderer );
		column2.setPreferredWidth(65);
		column2.setMinWidth(65);
		column2.setMaxWidth(65);
		column2.setResizable(false);
		column2 = jtSolicitado.getColumnModel().getColumn(3);
		column2.setCellRenderer( centerRenderer );
		column2.setPreferredWidth(7);
		column2.setMinWidth(65);
		column2.setMaxWidth(65);
		column2.setResizable(false);
		TableCellRenderer leftRender = new LeftRenderer();
		column2 = jtSolicitado.getColumnModel().getColumn(2);
		column2.setCellRenderer( leftRender );
		column2.setPreferredWidth(250);
		column2.setMinWidth(250);
		column2.setMaxWidth(250);
		column2.setResizable(false);
		column2 = jtSolicitado.getColumnModel().getColumn(4);
		column2.setCellRenderer( leftRender );
		column2.setPreferredWidth(225);
		column2.setMinWidth(225);
		column2.setMaxWidth(225);
		column2.setResizable(false);
		filaSM = jtSolicitado.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas2());
		jlModifica= new JLabel(iiModifica);
		jlModifica.setBounds (261,291,138,41);
		jlModifica.addMouseListener(new mouseComportamientoLabels());
		jlAgrega= new JLabel(iiAgrega);
		jlAgrega.setBounds (440,291,131,41);
		jlAgrega.addMouseListener(new mouseComportamientoLabels());
		jlElimina= new JLabel(iiElimina);
		jlElimina.setBounds (261,541,137,41);
		jlElimina.addMouseListener(new mouseComportamientoLabels());
		jlNota= new JLabel(iiNota);
		jlNota.setBounds (440,543,131,40);
		jlNota.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (645,563,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(31,563,152,55);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		this.add(jlCancela);
		this.add(jlAceptar);
		this.add(jscroll);
		this.add(jscroll2);
		this.add(jlModifica);
		this.add(jlAgrega);
		this.add(jlElimina);
		this.add(jlNota);
		this.add(jcGenero);
		this.add(jcDivision);
		// Si el tipo de precio es por Grupos despligo aviso.
		this.add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
    	setVisible(true);
	}

	public void reTablea (TableModel am) throws Exception{
		this.remove(jscroll);
		jtDisponible = new JTable((TableModel)am);
		jscroll = new JScrollPane(jtDisponible,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		jtDisponible.setFont(letraT);
		jtDisponible.setRowSelectionAllowed(true);
		jtDisponible.setColumnSelectionAllowed(false);
		jtDisponible.setShowGrid(true);
		jtDisponible.setRowHeight(35);
		jth = new JTableHeader();
		jth = jtDisponible.getTableHeader();
		jth.setFont(letraTH);
		UIManager.put("ScrollBar.width", new Integer(50));
		ListSelectionModel filaSM = jtDisponible.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas());
		column = null;
		TableCellRenderer rightRender = new RightRenderer();
		column = jtDisponible.getColumnModel().getColumn(4);
		column.setCellRenderer( rightRender );
		column.setPreferredWidth(75);
		column.setMinWidth(75);
		column.setMaxWidth(75);
		column.setResizable(false);
		TableCellRenderer centerRenderer = new CenterRenderer();
		column = jtDisponible.getColumnModel().getColumn(0);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(70);
		column.setMinWidth(70);
		column.setMaxWidth(70);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(1);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(65);
		column.setMinWidth(65);
		column.setMaxWidth(65);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(2);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(394);
		column.setMinWidth(394);
		column.setMaxWidth(394);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(3);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(70);
		column.setMinWidth(70);
		column.setMaxWidth(70);
		column.setResizable(false);
		jscroll.setBounds(48, 127, 725,155);
		//jscroll.revalidate();
		this.add(jscroll);
		this.add(jlFondo);
		this.updateUI();
		//this.validate();
		//repaint();
	}


	public class refrescaDisponibles implements ActionListener{
		public void actionPerformed(ActionEvent e){
			try{
				jtDisponible.clearSelection();
				renglonGlobalDisponible = -1;
				JComboBox cb = (JComboBox)e.getSource();
				int enviaArea = 0;
				int enviaDivision = 0;
				String area = (String)jcGenero.getSelectedItem();
				if (area.equalsIgnoreCase("Bebida")){
					enviaArea = 2;
				}
				else if (area.equalsIgnoreCase("Alimento")){
					enviaArea = 1;
				}
				if (cb == jcGenero){
					jcDivision.removeAllItems();
					Vector <String> divisionListado = cliente.bs.listaXDivision(enviaArea);
					for (int i = 0; i<divisionListado.size() ; i++){
						jcDivision.addItem(cliente.ma.decodifica(divisionListado.elementAt(i)));
					}
				}
				String laDivision = (String)jcDivision.getSelectedItem();
				laDivision=laDivision.substring(laDivision.lastIndexOf("-")+1, laDivision.length());
				enviaDivision = cliente.ma.cambiaAInt(laDivision.trim());
				renglonGlobalDisponible = -1;
				AbstractTableModel am = cliente.bs.listaProducto(enviaArea, enviaDivision);
				reTablea(am);
			}
			catch (NullPointerException npe){
				System.out.println("npe Inexistente...");
			}
			catch(RemoteException re){
				re.printStackTrace();
			}
			catch(UnsupportedEncodingException uee){
				uee.printStackTrace();
			}
			catch(Exception q){
				q.printStackTrace();
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
				JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes haber ingresado por lo menos un producto a la tabla de Solicitado.");
			}
			else{
				ConfirmaInterna ci = new ConfirmaInterna();
				ci.setPadre(cliente);
				ci.setProductosSolicitdos(tmv.datos);
				ci.despliegaInterfaz();
				ci.setVisible(true);
				cliente.desktop.add(ci);
				ci.setSelected(true);
				Cierra();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en ComandaInterna.\nVuelva a intentarlo.");
			Cierra();
		}
	}

	// Con este detecto que renglon seleccionaron para eliminar.
	protected class SeleccionFilas implements ListSelectionListener {
		public void valueChanged(ListSelectionEvent e) {
			if (e.getValueIsAdjusting()) return;
			ListSelectionModel lsm = (ListSelectionModel)e.getSource();
			if (lsm.isSelectionEmpty()) {
					renglonGlobalDisponible = -1;
			}
			else {
				int selectedRow = lsm.getMinSelectionIndex();
				renglonGlobalDisponible  = selectedRow;
			}
		}
	}


		// Con este detecto que renglon seleccionaron en mi tabla de ubicaciones.
	protected class SeleccionFilas2 implements ListSelectionListener {
		public void valueChanged(ListSelectionEvent e) {
			if (e.getValueIsAdjusting()) return;
			ListSelectionModel lsm = (ListSelectionModel)e.getSource();
			if (lsm.isSelectionEmpty()) {
				renglonGlobalSolicitado = -1;
			}
			else {
				int selectedRow = lsm.getMinSelectionIndex();
				renglonGlobalSolicitado = selectedRow;
			}
		}
	}


	public void procesoElimina() throws Exception{
		if(renglonGlobalSolicitado == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto Solicitado (Alimento o Bebida)");
		}
		else{
			tmv.removeRow(renglonGlobalSolicitado);
			jtSolicitado.clearSelection();
			renglonGlobalSolicitado = -1;
		}
	}

	public void procesaNota() throws Exception{
		if(renglonGlobalSolicitado == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto Solicitado (Alimento o Bebida)");
		}
		else{
			AltaNota an = new AltaNota((JFrame)cliente, "Alta de Nota", true);
			an.setLocationRelativeTo(null);
			an.setPadre(cliente);
			an.dibujaDialogo();
			if(an.existioCambio){
				String notaCorrespondiente = an.laNota;
				tmv.setValueAt(notaCorrespondiente, renglonGlobalSolicitado, 4);
				jtSolicitado.clearSelection();
				renglonGlobalSolicitado = -1;
			}
		}
	}


	public void procesoAgrega() throws Exception{
		if(renglonGlobalDisponible == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto (Alimento o Bebida)");
		}
		else{
			String elGenero = (String) jcGenero.getSelectedItem();
			if(elGenero.trim().equalsIgnoreCase("Alimento")){
				elGenero = "1*";
			}
			else{
				elGenero = "2*";
			}
			String laDivision = (String)jcDivision.getSelectedItem();
			laDivision = laDivision.substring(laDivision.lastIndexOf("-")+1,laDivision.length()).trim()+"*";
			String laClaveProducto = (String)jtDisponible.getValueAt(renglonGlobalDisponible, 1);
			laClaveProducto=elGenero+laDivision+laClaveProducto;
			String laCantidad = (String) jtDisponible.getValueAt(renglonGlobalDisponible, 0);
			String elProducto = (String)jtDisponible.getValueAt(renglonGlobalDisponible , 2);
			String elTipo =(String) jtDisponible.getValueAt(renglonGlobalDisponible, 3);
			tmv.addRow(laCantidad, laClaveProducto,elProducto,elTipo,"");
			jtDisponible.clearSelection();
			renglonGlobalDisponible = -1;
		}
	}



	public void procesoModifica() throws Exception{
		if(renglonGlobalDisponible == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto (Alimento o Bebida)");
		}
		else{
			int enviaArea = 0;
			int enviaDivision = 0;
			String area = (String)jcGenero.getSelectedItem();
			if (area.equalsIgnoreCase("Bebida")){
				enviaArea = 2;
			}
			else if (area.equalsIgnoreCase("Alimento")){
				enviaArea = 1;
			}
			String laDivision = (String)jcDivision.getSelectedItem();
			laDivision=laDivision.substring(laDivision.lastIndexOf("-")+1, laDivision.length());
			enviaDivision = cliente.ma.cambiaAInt(laDivision.trim());
			DialogoModificaSP dmsp = new DialogoModificaSP((JFrame)cliente, "Modificación Solicitud de Producto", true);
			dmsp.setLocationRelativeTo(null);
			dmsp.setPadre(cliente);
			dmsp.setProducto(enviaArea, enviaDivision, cliente.ma.cambiaAInt(jtDisponible.getValueAt(renglonGlobalDisponible, 1).toString()));
			int cantidadActual = 0;
			cantidadActual = cliente.ma.cambiaAInt(jtDisponible.getValueAt(renglonGlobalDisponible,0).toString());
			dmsp.setCantidadActual(cantidadActual);
			dmsp.dibujaDialogo();
			if(dmsp.existioCambio){
				String valorObtenido = (String)dmsp.jcTipo.getSelectedItem();
				int cantidadElementos = dmsp.cantidadElementos;
				if(valorObtenido.equalsIgnoreCase("No Aplica")){
					int cantidadModifica = cliente.ma.cambiaAInt(dmsp.jtCantidad.getText().trim());
					jtDisponible.setValueAt(cantidadModifica+"",  renglonGlobalDisponible, 0);
				}
				else if( valorObtenido.equalsIgnoreCase("Copa") && cantidadElementos == 1){
					int cantidadModifica = cliente.ma.cambiaAInt(dmsp.jtCantidad.getText().trim());
					jtDisponible.setValueAt(cantidadModifica+"",  renglonGlobalDisponible, 0);
				}
				else if(valorObtenido.equalsIgnoreCase("Copa") && cantidadElementos > 1){
					int cantidadModifica = cliente.ma.cambiaAInt(dmsp.jtCantidad.getText().trim());
					jtDisponible.setValueAt(cantidadModifica+"",  renglonGlobalDisponible, 0);
					jtDisponible.setValueAt("Copa", renglonGlobalDisponible, 3);
					jtDisponible.setValueAt(cliente.ma.formatoDinero(dmsp.precioCopa+""), renglonGlobalDisponible, 4);
				}
				else if(valorObtenido.equalsIgnoreCase("Botella")){
					int cantidadModifica = cliente.ma.cambiaAInt(dmsp.jtCantidad.getText().trim());
					jtDisponible.setValueAt(cantidadModifica+"",  renglonGlobalDisponible, 0);
					jtDisponible.setValueAt("Botella", renglonGlobalDisponible, 3);
					jtDisponible.setValueAt(cliente.ma.formatoDinero(dmsp.precioBotella+""), renglonGlobalDisponible, 4);
				}
				else if(valorObtenido.equalsIgnoreCase("Botella G.")){
					int cantidadModifica = cliente.ma.cambiaAInt(dmsp.jtCantidad.getText().trim());
					jtDisponible.setValueAt(cantidadModifica+"",  renglonGlobalDisponible, 0);
					jtDisponible.setValueAt("Botella G.", renglonGlobalDisponible, 3);
					jtDisponible.setValueAt(cliente.ma.formatoDinero(dmsp.precioBotella+""), renglonGlobalDisponible, 4);
				}
				else if(valorObtenido.equalsIgnoreCase("Botella P.")){
					int cantidadModifica = cliente.ma.cambiaAInt(dmsp.jtCantidad.getText().trim());
					jtDisponible.setValueAt(cantidadModifica+"",  renglonGlobalDisponible, 0);
					jtDisponible.setValueAt("Botella P.", renglonGlobalDisponible, 3);
					jtDisponible.setValueAt(cliente.ma.formatoDinero(dmsp.precioBotella+""), renglonGlobalDisponible, 4);
				}
			}
			// Si es botella tengo que cambiar el Tipo y el precio,
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
				else if(temporal == jlModifica){
					procesoModifica();
				}
				else if(temporal == jlAgrega){
					procesoAgrega();
				}
				else if(temporal == jlElimina){
					procesoElimina();

				}
				else if(temporal == jlNota){
					procesaNota();
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
				else if(temporal == jlModifica){
					jlModifica.setIcon(iiModificaP);
				}
				else if(temporal == jlAgrega){
					jlAgrega.setIcon(iiAgregaP);
				}
				else if(temporal == jlElimina){
					jlElimina.setIcon(iiEliminaP);
				}
				else if(temporal == jlNota){
					jlNota.setIcon(iiNotaP);
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
				else if(temporal == jlModifica){
					jlModifica.setIcon(iiModifica);
				}
				else if(temporal == jlAgrega){
					jlAgrega.setIcon(iiAgrega);
				}
				else if(temporal == jlElimina){
					jlElimina.setIcon(iiElimina);
				}
				else if(temporal == jlNota){
					jlNota.setIcon(iiNota);
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
			return this;
        }
	}

}