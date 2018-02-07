package alphanet.rmi.digimaan.cliente;

import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import java.net.URL;
import javax.swing.JDesktopPane;
import javax.swing.JOptionPane;
import java.sql.ResultSet;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Toolkit;
import javax.swing.UIManager;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Component;
import java.awt.Dimension;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableColumn;
import javax.swing.ListSelectionModel;
import javax.swing.JComboBox;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableCellRenderer;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import java.awt.BorderLayout;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.rmi.RemoteException;
import java.util.Vector;
import javax.swing.WindowConstants;
import javax.swing.plaf.basic.BasicArrowButton;
import javax.swing.plaf.basic.BasicComboBoxUI;
import javax.swing.plaf.ComboBoxUI;
import javax.swing.JButton;
import java.awt.Color;

public class ListaRecicla extends JInternalFrame {

	private String claveProducto = new String("");
	private JTable datosTabla;
	private JScrollPane scrollPane ;
	private TableColumn column;
	private JTableHeader jth;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected JComboBox jcClientes;
	protected DigiCliente digiCliente;
	private Font letra, letraClientes, letraTitulo, letraDatos,letraProducto, letraDatosTotal;
	private JLabel  jlModifica, jlAceptar, jlBorrar;
	private JTextField jtProductos, jtTotal;
	private ImageIcon iiBotonModN, iiBotonModP, iiBotonAD, iiBotonAcepN,iiBotonAcepP, iiBotonBorrarN, iiBotonBorrarP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	protected int  claveTicket = 0;
	protected int claveU = 0;
	protected String totalAPagar = "";
	// me indica que renglon se va a eliminar.
	protected int renglonGlobal = -1; //-1 --> sin seleccionar.
	protected Vector <String> productoFuera = null;
	protected Vector <String> vClientes = null;
	protected String rfcPropietario = "";
	protected double nuevaCantidad = 0.00;
	protected double pesoDePiezas = 0.00;
	protected int resultado = 0;

    public ListaRecicla() throws Exception {
        super("Listado de Productos", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		// Checo si existen productos en la lista...
		try{
			productoFuera = digiCliente.bs.dameProductoEliminado(claveTicket);
		}
		catch (RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}
		boolean existencia = false;
		try{
			existencia = digiCliente.bs.existenProductosEnListaR(claveTicket);
		}
		catch (RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}
		try{
			datosTabla = new JTable(digiCliente.bs.tablaListadoPrevioR(claveTicket));
		}
		catch (RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}
		try{
			vClientes = digiCliente.bs.dameListadoClientes();
			rfcPropietario = digiCliente.bs.damePropietario(claveTicket);
		}
		catch (RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}

		jcClientes = new JComboBox();
		for(int i = 0; i<vClientes.size() ; i++){

			String nombre = vClientes.elementAt(i);
			jcClientes.addItem(nombre);
		}
		if(!rfcPropietario.equals("")){
			jcClientes.setSelectedItem((Object)rfcPropietario);
		}
		UIManager.put("ScrollBar.width", new Integer(50));
		scrollPane = new JScrollPane(datosTabla,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		letra=new Font("Eras Demin ITC",Font.BOLD,22);
		letraClientes=new Font("Agency FB",Font.PLAIN,25);
		letraTitulo=new Font("Eras Agency FB BOLD",Font.BOLD,15);
		letraDatos=new Font("Eras Agency FB",Font.PLAIN,14);
		letraDatosTotal=new Font("Eras Agency FB",Font.BOLD,15);
		letraProducto=new Font("Arial Narrow",Font.PLAIN,17);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoListadoRecicla.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ModificarN.jpg");
		iiBotonModN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ModificarP.jpg");
		iiBotonModP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/downArrow.jpg");
		iiBotonAD = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarN.jpg");
		iiBotonAcepN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAcepP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCN.jpg");
		iiBotonBorrarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCP.jpg");
		iiBotonBorrarP = new ImageIcon(url);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		scrollPane.setBounds(12, 75,810, 385);
		jlFondo.setBounds(380,450,70,70);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlModifica= new JLabel(iiBotonModN);
		jlModifica.setBounds(120,510,175,70);
		jlModifica.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBorrarN);
		jlBorrar.setBounds(330,510,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAcepN);
		jlAceptar.setBounds (540,510,165,70);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		ListSelectionModel filaSM = datosTabla.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas());
		datosTabla.setFont(letraDatos);
		datosTabla.setRowSelectionAllowed(true);
		datosTabla.setColumnSelectionAllowed(false);
		datosTabla.setShowGrid(true);
		datosTabla.setRowHeight(50);
		jtProductos = new JTextField(30);
		jtProductos.setHorizontalAlignment(JTextField.CENTER);
		jtProductos.setFont(letra);
		try{
			jtProductos.setText(digiCliente.bs.cantidadProductosR(claveTicket));
		}
		catch (RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}
		jtTotal = new JTextField(30);
		jtTotal.setHorizontalAlignment(JTextField.RIGHT);
		jtTotal.setFont(letra);
		try{
			totalAPagar = digiCliente.bs.sumaPagoProductosR(claveTicket);
		}
		catch (RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}
		jtTotal.setText(totalAPagar);
		jcClientes.setFont(letraClientes);
		ComboBoxUI comUI = new myBasicComboBoxUI();
		jcClientes.setUI(comUI);
		jcClientes.setBounds(220,8,600,35);
		// Acomodo mis campos dentro de la ventana.
		jtProductos.setBounds(265,463,115,30);
		jtTotal.setBounds(618,463,130,30);
		jth = new JTableHeader();
		jth = datosTabla.getTableHeader();
		jth.setFont(letraTitulo);
		column = null;
		TableCellRenderer fontRenderer = new FontRenderer();
		column = datosTabla.getColumnModel().getColumn(2);
		column.setCellRenderer( fontRenderer );
		column.setPreferredWidth(268);
		column.setMinWidth(268);
		column.setMaxWidth(268);
		column.setResizable(true);
		TableCellRenderer centerRenderer = new CenterRenderer();
		column = datosTabla.getColumnModel().getColumn(0);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(90);
		column.setMinWidth(90);
		column.setMaxWidth(90);
		column.setResizable(false);
		column = datosTabla.getColumnModel().getColumn(1);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(73);
		column.setMinWidth(73);
		column.setMaxWidth(73);
		column.setResizable(false);
		column = datosTabla.getColumnModel().getColumn(3);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(70);
		column.setMinWidth(70);
		column.setMaxWidth(70);
		column.setResizable(false);
		column = datosTabla.getColumnModel().getColumn(4);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(75);
		column.setMinWidth(75);
		column.setMaxWidth(75);
		column.setResizable(false);
		TableCellRenderer rightRenderer = new RightRenderer();
		column = datosTabla.getColumnModel().getColumn(5);
		column.setCellRenderer( rightRenderer );
		column.setPreferredWidth(80);
		column.setMinWidth(80);
		column.setMaxWidth(80);
		column.setResizable(false);
		TableCellRenderer rightRendererF = new RightRendererF();
		column = datosTabla.getColumnModel().getColumn(6);
		column.setCellRenderer( rightRendererF );
		column.setPreferredWidth(100);
		column.setMinWidth(100);
		column.setMaxWidth(100);
		column.setResizable(false);
		this.add(scrollPane, BorderLayout.CENTER);
		this.add(jcClientes);
		this.add(jlAceptar);
		if(existencia){
			jcClientes.setEditable(false);
			this.add(jlModifica);
			this.add(jlBorrar);
		}
		this.add(jtProductos);
		this.add(jtTotal);
		this.add(jlFondo);
    	setVisible(true);
    	jtProductos.setEditable(false);
    	jtTotal.setEditable(false);
		if(productoFuera != null || !productoFuera.elementAt(0).equalsIgnoreCase("ERROR")){
			for(int i=0; i<productoFuera.size(); i++){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, productoFuera.elementAt(i));
			}
		}
	}

	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}


// Recibo el ticket que proceso
	public void setClaveTicket(int claveTicket){
		this.claveTicket = claveTicket;
	}



    /*
    **  Center the text
    */
    class CenterRenderer extends DefaultTableCellRenderer {
        public CenterRenderer() {
            setHorizontalAlignment( CENTER );
        }

        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			super.setSize(3,15);
			return this;
        }
    }

    // Cambiar tamaño de la Fuente
    class FontRenderer extends DefaultTableCellRenderer {
        public FontRenderer() {
			setHorizontalAlignment( CENTER );
        }

        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			super.setFont(letraProducto);
			return this;
        }
    }


    /*
    **  Move to Left  the text
    */
    class RightRenderer extends DefaultTableCellRenderer {
        public RightRenderer() {
            setHorizontalAlignment( RIGHT );
        }

        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			return this;
        }
    }


	class myBasicComboBoxUI extends BasicComboBoxUI {

		myBasicComboBoxUI( ) {
		}

		protected JButton createArrowButton() {
			JButton jbTest = new JButton(iiBotonAD);
			return jbTest;
		}

	}

    /*
    **  Move to Left  the text
    */
    class RightRendererF extends DefaultTableCellRenderer {

        public RightRendererF() {
            setHorizontalAlignment( RIGHT );
        }

        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			super.setFont(letraDatosTotal);
			return this;
        }
    }

	protected void ProcesoModifica() throws Exception{
		if(renglonGlobal == -1){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Seleccione un producto para modificar la Cantidad Vendida");
		}
		else {
			int ID_Pro = Integer.parseInt(ma.dameEnteros(ma.remueveComas(datosTabla.getValueAt(renglonGlobal, 3) +"")));
			String cantidad = datosTabla.getValueAt(renglonGlobal, 0) +"";
			String unidadP = datosTabla.getValueAt(renglonGlobal, 1) +"";
			String tipoPrecio = datosTabla.getValueAt(renglonGlobal, 4) +"";
			String nombreArticulo = datosTabla.getValueAt(renglonGlobal, 2) +"";
// Mando pedir la cantidad de peso de las piezas
			ModificaCantidad mc = new ModificaCantidad(digiCliente, "Nueva Cantidad", true, unidadP, nombreArticulo, cantidad );
			mc.dibujaDialogo();
			nuevaCantidad = mc.nuevaCantidad;
			if(ma.cambiaADouble(cantidad) != nuevaCantidad){ // Si cambio la cantidad solicitada...
				if(unidadP.equalsIgnoreCase("Pieza (Kg)")){
					DamePesoXPieza dppp = new DamePesoXPieza(digiCliente, "Especifica el peso de las piezas", true, nuevaCantidad+"");
					dppp.dibujaDialogo();
					pesoDePiezas = dppp.pesoRegistrado;
				}
				try{
					resultado = digiCliente.bs.modificaContenido(ID_Pro, cantidad,nuevaCantidad,unidadP,tipoPrecio, claveTicket, pesoDePiezas);
				}
				catch (RemoteException re){
					this.setVisible(false);
					this.dispose();
					digiCliente.desktop.remove(this);
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
					digiCliente.notificaPerdidaConexion();
				}
				// --> 0 Falla SQL, 1 Exito, 2 Pides mas de existencia
				if(resultado == 0){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Error al modificar el producto, vuelva a intentarlo");
				}
				else if(resultado == 2){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "No se puede modificar la cantidad de:\n"+nombreArticulo+",\npues pides mas de lo que existe en Inventario.");
				}
				else{
					ListaRecicla lp = new ListaRecicla();
					lp.setPadre(digiCliente);
					lp.setClaveTicket(claveTicket);
					lp.despliegaInterfaz();
					lp.setVisible(true);
					digiCliente.desktop.add(lp);
					lp.moveToFront();
					this.setVisible(false);
					digiCliente.desktop.remove(this);
					this.dispose();
					digiCliente.desktop.setSelectedFrame(lp);
					lp.setSelected(true);
				}
			}
		}
	}


	protected void ProcesoAceptar() throws Exception{
		// Voy a cerrar la cuenta y guardar la fecha con que se paga.
		String IDCliente = (String)jcClientes.getSelectedItem();
		String rfc = "";
		String nombreCliente = "";
		if(IDCliente.lastIndexOf(" > ") != -1){
			nombreCliente = IDCliente.substring(0, IDCliente.lastIndexOf(">")-1).trim();
			rfc = IDCliente.substring(IDCliente.lastIndexOf(">")+1, IDCliente.length()).trim();
		}
		boolean procesaCierre = false;
		try{
			procesaCierre = digiCliente.bs.modificaCuenta(claveTicket, rfc, nombreCliente);
		}
		catch (RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}
		if(procesaCierre){
			if (rfc.length() == 0){
				ImpresionTicket2 it = new ImpresionTicket2();
				it.setPadre(digiCliente);
				it.setClaveTicket(claveTicket);
				it.setUsuario(claveU);
				it.despliegaInterfaz();
				it.setVisible(true);
				digiCliente.desktop.add(it);
				it.moveToFront();
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
				digiCliente.desktop.setSelectedFrame(it);
				it.setSelected(true);
			}
			else {
				ImpresionTicketRem it = new ImpresionTicketRem();
				it.setPadre(digiCliente);
				it.setClaveTicket(claveTicket);
				it.setUsuario(claveU);
				it.setRFC(rfc);
				it.setNombreCliente(nombreCliente);
				it.despliegaInterfaz();
				it.setVisible(true);
				digiCliente.desktop.add(it);
				it.moveToFront();
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
				digiCliente.desktop.setSelectedFrame(it);
				it.setSelected(true);
			}
		}
		else{
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "No se puede modificar la cuenta, cheque la conexion al Servidor");
		}
	}

	protected void ProcesoBorrar() throws Exception{
		if(renglonGlobal == -1){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Seleccione un producto para borrarlo de la lista.");
		}
		else {
			int id1 = Integer.parseInt(ma.dameEnteros(ma.remueveComas(datosTabla.getValueAt(renglonGlobal, 3) +"")));
			String id2 = datosTabla.getValueAt(renglonGlobal, 1) +"";
			String id3 = datosTabla.getValueAt(renglonGlobal, 4) +"";
			// Voy a mandar eliminar el producto seleccionado:
			boolean eliminacion = false;
			try{
				eliminacion = digiCliente.bs.eliminaProducto(claveTicket,id1, id2, id3);
			}
			catch (RemoteException re){
				this.setVisible(false);
				this.dispose();
				digiCliente.desktop.remove(this);
				if(!digiCliente.arranqueSinEscanner){
					digiCliente.resetHilos();
				}
				digiCliente.jftClave.requestFocus();
				digiCliente.notificaPerdidaConexion();
			}
			if(eliminacion){
				ListaRecicla lp = new ListaRecicla();
				lp.setPadre(digiCliente);
				lp.setClaveTicket(claveTicket);
				lp.despliegaInterfaz();
				lp.setVisible(true);
				digiCliente.desktop.add(lp);
				lp.moveToFront();
				this.setVisible(false);
				digiCliente.desktop.remove(this);
				this.dispose();
				digiCliente.desktop.setSelectedFrame(lp);
				lp.setSelected(true);
			}
			else{
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Error al eliminar el producto, vuelva a intentarlo");
			}
		}
	}


	// Con este detecto que renglon seleccionaron para eliminar.
	protected class SeleccionFilas implements ListSelectionListener {
		public void valueChanged(ListSelectionEvent e) {
			if (e.getValueIsAdjusting()) return;
			ListSelectionModel lsm = (ListSelectionModel)e.getSource();
			if (lsm.isSelectionEmpty()) {
					renglonGlobal = -1;
			}
			else {
				int selectedRow = lsm.getMinSelectionIndex();
				renglonGlobal = selectedRow;
			}
		}
	}

	protected class mouseComportamientoLabels implements MouseListener {
		public void mouseClicked (MouseEvent e){
			try{
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
		// Si presionaron mi boton mando tocar un sonido
		public void mousePressed(MouseEvent e){
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlModifica){
					ProcesoModifica();
				}
				else if(temporal == jlAceptar){
					ProcesoAceptar();
				}
				else if(temporal == jlBorrar){
					ProcesoBorrar();
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
		public void mouseReleased(MouseEvent e){
		}
		// Si el mouse se encuentra dentro del área del boton cambio su apariencia.
		public void mouseEntered(MouseEvent e){
			setCursor(deMano);
			try{
				son.tocaSonido();
				JLabel temporal = (JLabel)e.getSource();
				if(temporal == jlModifica){
					jlModifica.setIcon(iiBotonModP);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAcepP);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBorrarP);
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
				if(temporal == jlModifica){
					jlModifica.setIcon(iiBotonModN);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAcepN);
				}
				else if(temporal == jlBorrar){
					jlBorrar.setIcon(iiBotonBorrarN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}
}