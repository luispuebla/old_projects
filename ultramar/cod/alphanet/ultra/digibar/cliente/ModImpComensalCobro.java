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


public class ModImpComensalCobro extends JInternalFrame {

	private	JDesktopPane desktop = null;
	protected String mesaAlta;
	protected JScrollPane jscroll ;
	int mesaID = 0;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letraC, letraTH, letraT;
	private TableColumn column;
	protected JLabel jlMesa, jlModifica,  jlCancela, jlAceptar;
	private ImageIcon iiMesa, iiModifica, iiModificaP,   iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	protected JTable jtDisponible, jtSolicitado;
	protected int renglonGlobalDisponible = -1;
	private JTableHeader jth;
	protected TableModelVector tmv ;
	private static final long serialVersionUID = 1L;

    public ModImpComensalCobro() throws Exception {
        super("Valida/Imprime Producto - Comensal", false, true, false);
        // Tamaño de la Ventana
        setSize(780,625);
        // Localización de la Ventana
        setLocation(30,8);
        // Contenido de la Ventana
	}

	protected void setMesaTrabaja(String mesaAlta){
		this.mesaAlta =mesaAlta;
		mesaID = Integer.parseInt(mesaAlta);
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letraC=new Font("Eras Demin ITC",Font.BOLD,20);
		letraTH=new Font("Arial Narrow",Font.BOLD,18);
		letraT=new Font("Arial Narrow",Font.PLAIN,18);
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
		url= getClass().getResource("/imas/botones/Modifica.jpg");
		iiModifica = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/ModificaP.jpg");
		iiModificaP = new ImageIcon(url);
		url= getClass().getResource("/imas/fondoImprimeXComen.jpg");
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
		jlFondo.setBounds(0,0,770,604);
		if(mesaID !=0){
			jlMesa = new JLabel(iiMesa);
			jlMesa.setBounds(497,37,43,27);
		}
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		AbstractTableModel am = cliente.bs.DameDesgloseXComensal(mesaID);
		jtDisponible = new JTable((TableModel)am);
		jscroll = new JScrollPane(jtDisponible,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		jtDisponible.setFont(letraT);
		jtDisponible.setRowSelectionAllowed(true);
		jtDisponible.setColumnSelectionAllowed(false);
		jtDisponible.setShowGrid(true);
		jtDisponible.setRowHeight(30);
		jth = new JTableHeader();
		jth = jtDisponible.getTableHeader();
		jth.setFont(letraTH);
		jscroll.setBounds(20, 110, 725,380);
		column = null;
		TableCellRenderer rightRender = new RightRenderer();
		TableCellRenderer centerRenderer = new CenterRenderer();
		column = jtDisponible.getColumnModel().getColumn(0);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(80);
		column.setMinWidth(80);
		column.setMaxWidth(80);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(4);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(78);
		column.setMinWidth(78);
		column.setMaxWidth(78);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(1);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(65);
		column.setMinWidth(65);
		column.setMaxWidth(65);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(2);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(60);
		column.setMinWidth(60);
		column.setMaxWidth(60);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(3);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(390);
		column.setMinWidth(390);
		column.setMaxWidth(390);
		column.setResizable(false);
		ListSelectionModel filaSM = jtDisponible.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas());
		jlModifica= new JLabel(iiModifica);
		jlModifica.setBounds (315,503,138,41);
		jlModifica.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (591,525,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(31,525,152,55);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		if(mesaID >0){
			this.add(jlMesa);
		}
		this.add(jlCancela);
		this.add(jlAceptar);
		this.add(jscroll);
		this.add(jlModifica);
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
			cliente.bs.ImprimeTicketXComen(mesaID);
			Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en Modifica Imprime Comensal.\nVuelva a intentarlo.");
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



	public void procesoModifica() throws Exception{
		if(renglonGlobalDisponible == -1){
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Debes seleccionar un producto (Alimento o Bebida)");
		}
		else{
//			System.out.println("Entre");
			int enviaMaxComensal = 0;
			enviaMaxComensal = cliente.bs.DameCantidadTotalComensales(mesaID);
			DialogoModificaComen dmc = new DialogoModificaComen((JFrame)cliente, "Modificación Comensal", true);
			dmc.setPadre(cliente);
			dmc.setCantidadActual(enviaMaxComensal);
			dmc.dibujaDialogo();
			int nuevoComanesal = -1;
			if(dmc.existioCambio){
				int nuevoComensal = dmc.cantidadElementos;
				int claveDeProducto = cliente.ma.cambiaAInt(((String)jtDisponible.getValueAt(renglonGlobalDisponible,2)).trim());
				String tipo = (String)jtDisponible.getValueAt(renglonGlobalDisponible, 1);
				int comensalPrevio = cliente.ma.cambiaAInt(((String)jtDisponible.getValueAt(renglonGlobalDisponible, 4)).trim());
				cliente.bs.actualizaAsignacionProducComen(nuevoComensal, mesaID, claveDeProducto, tipo, comensalPrevio);
				renglonGlobalDisponible = -1;
				AbstractTableModel am = cliente.bs.DameDesgloseXComensal(mesaID);
				reTablea(am);
			}
			// Si es botella tengo que cambiar el Tipo y el precio,
		}
	}


	public void reTablea (TableModel am) throws Exception{
		this.remove(jscroll);
		jtDisponible = new JTable((TableModel)am);
		jscroll = new JScrollPane(jtDisponible,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		jtDisponible.setFont(letraT);
		jtDisponible.setRowSelectionAllowed(true);
		jtDisponible.setColumnSelectionAllowed(false);
		jtDisponible.setShowGrid(true);
		jtDisponible.setRowHeight(30);
		jth = new JTableHeader();
		jth = jtDisponible.getTableHeader();
		jth.setFont(letraTH);
		UIManager.put("ScrollBar.width", new Integer(50));
		ListSelectionModel filaSM = jtDisponible.getSelectionModel();
		filaSM.addListSelectionListener(new SeleccionFilas());
		column = null;
		TableCellRenderer rightRender = new RightRenderer();
		TableCellRenderer centerRenderer = new CenterRenderer();
		column = jtDisponible.getColumnModel().getColumn(0);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(80);
		column.setMinWidth(80);
		column.setMaxWidth(80);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(4);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(78);
		column.setMinWidth(78);
		column.setMaxWidth(78);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(1);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(65);
		column.setMinWidth(65);
		column.setMaxWidth(65);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(2);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(60);
		column.setMinWidth(60);
		column.setMaxWidth(60);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(3);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(390);
		column.setMinWidth(390);
		column.setMaxWidth(390);
		column.setResizable(false);
		jscroll.setBounds(20, 110, 725,380);
		//jscroll.revalidate();
		this.add(jscroll);
		this.add(jlFondo);
		this.updateUI();
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