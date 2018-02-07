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
import javax.swing.WindowConstants;



public class ListaProductosCoincidentes extends JInternalFrame {

	private String claveProducto = new String("");
	private	JDesktopPane desktop = null;
	private JTable datosTabla;
	private JScrollPane scrollPane ;
	private TableColumn column;
	private JTableHeader jth;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra, letraTitulo, letraDatos,letraProducto, letraDatosTotal;
	private JLabel  jlCancela, jlAceptar, jlBorrar;
	private JTextField jtProductos, jtTotal;
	private ImageIcon iiBotonCanN, iiBotonCanP, iiBotonAcepN,iiBotonAcepP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	protected String claveTicket = "";
	protected int claveU = 0;
	// me indica que renglon se va a eliminar.
	protected int renglonGlobal = -1; //-1 --> sin seleccionar.
	protected String busqueda = "";
	protected int tipoPrecio = -1;
	protected DigiCliente digiCliente;

	protected void setTipoPrecio(int tipoPrecio){
		this.tipoPrecio = tipoPrecio;
	}

	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}


    public ListaProductosCoincidentes() throws Exception {
        super("Listado de Productos Resultantes", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void despliegaInterfaz(String busqueda) throws Exception{
		this.busqueda = busqueda;
		son = new Sound();
		// Checo si existen productos en la lista...
		try{
			datosTabla = new JTable(digiCliente.bs.tablaListadoBusqueda(busqueda));
		}
		catch(RemoteException re){
			this.setVisible(false);
			this.dispose();
			digiCliente.desktop.remove(this);
			if(!digiCliente.arranqueSinEscanner){
				digiCliente.resetHilos();
			}
			digiCliente.jftClave.requestFocus();
			digiCliente.notificaPerdidaConexion();
		}
		UIManager.put("ScrollBar.width", new Integer(50));
		scrollPane = new JScrollPane(datosTabla,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		letraTitulo=new Font("Eras Agency FB BOLD",Font.BOLD,17);
		letraDatos=new Font("Arial",Font.BOLD,16);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoListadoXBusqueda.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCN.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarN.jpg");
		iiBotonAcepN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAcepP = new ImageIcon(url);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		scrollPane.setBounds(15, 45,800, 410);
		jlFondo.setBounds(0,0,829,609);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(240,515,165,70);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAcepN);
		jlAceptar.setBounds (436,515,165,70);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		ListSelectionModel filaSM = datosTabla.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas());
		datosTabla.setFont(letraDatos);
		datosTabla.setRowSelectionAllowed(true);
		datosTabla.setColumnSelectionAllowed(false);
		datosTabla.setShowGrid(true);
		datosTabla.setRowHeight(40);
		// Acomodo mis campos dentro de la ventana.
		jth = new JTableHeader();
		jth = datosTabla.getTableHeader();
		jth.setFont(letraTitulo);
		column = null;
		TableCellRenderer centerRenderer = new CenterRenderer();
		column = datosTabla.getColumnModel().getColumn(2);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(180);
		column.setMinWidth(180);
		column.setMaxWidth(180);
		column.setResizable(false);
		column = datosTabla.getColumnModel().getColumn(0);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(100);
		column.setMinWidth(100);
		column.setMaxWidth(100);
		column.setResizable(false);
		TableCellRenderer leftRenderer = new LeftRendererF();
		column = datosTabla.getColumnModel().getColumn(1);
		column.setCellRenderer( leftRenderer );
		column.setPreferredWidth(470);
		column.setMinWidth(470);
		column.setMaxWidth(470);
		column.setResizable(false);
		this.add(scrollPane, BorderLayout.CENTER);
		this.add(jlCancela);
		this.add(jlAceptar);
		this.add(jlFondo);
    	setVisible(true);
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
			super.setFont(letraDatosTotal);
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
			super.setFont(letraDatosTotal);
			return this;
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

    class LeftRendererF extends DefaultTableCellRenderer {
        public LeftRendererF() {
            setHorizontalAlignment( LEFT );
        }

        public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)  {
			super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
			super.setFont(letraDatosTotal);
			return this;
        }
    }


	protected void Cierra() throws Exception{
		this.setVisible(false);
		digiCliente.desktop.remove(this);
		this.dispose();
		digiCliente.desktop.remove(this);
		if(!digiCliente.arranqueSinEscanner){
			digiCliente.resetHilos();
		}
		digiCliente.jftClave.requestFocus();
	}


	protected void ProcesoAceptar() throws Exception{
		// Voy a cerrar la cuenta y guardar la fecha con que se paga.
		boolean existioP = true;
		try{
			String prueba = datosTabla.getValueAt(0,0)+"";
		}
		catch (ArrayIndexOutOfBoundsException aioobe){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "No existió ningun producto de acuerdo a su búsqueda");
			existioP = false;
			Cierra();
		}
		if (existioP){
			if (renglonGlobal == -1){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Se debe Seleccionar un producto resultante de la búsqueda");
			}
			else{
				boolean cantidadPositiva = false;
				String claveProducto = datosTabla.getValueAt(renglonGlobal, 0) +"";
				try{
					cantidadPositiva = digiCliente.bs.hayProducto(claveProducto);
				}
				catch(RemoteException re){
					this.setVisible(false);
					this.dispose();
					digiCliente.desktop.remove(this);
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
					digiCliente.notificaPerdidaConexion();
				}
				if(!cantidadPositiva){
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "¡No tengo el producto seleccionado en existencia!");
				}
				else{
					DatosProducto dp = new DatosProducto();
					// Mando Referencia a mi DigiCliente
					dp.setPadre(digiCliente);
					dp.setClaveProducto(claveProducto);
					dp.setTipoPrecio(tipoPrecio);
					dp.despliegaInterfaz();
					dp.setVisible(true);
					digiCliente.desktop.add(dp);
					dp.setSelected(true);
					dp.jtCantidad.requestFocus();
					this.setVisible(false);
					digiCliente.desktop.remove(this);
					this.dispose();
				}
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
				if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAceptar){
					ProcesoAceptar();
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
				if(temporal == jlCancela){
					jlCancela.setIcon(iiBotonCanP);
				}
				else if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAcepP);
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
					jlAceptar.setIcon(iiBotonAcepN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}
}