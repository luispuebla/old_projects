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


public class ConsultaComanda extends JInternalFrame {

	private	JDesktopPane desktop = null;
	protected String mesaAlta;
	protected JScrollPane jscroll ;
	int mesaID = 0;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	private Font letraC, letraTH, letraT, letra;
	private TableColumn column;
	protected JLabel jlMesa,  jlAceptar;
	private ImageIcon iiMesa,  iiBotonAceptarN,iiBotonAceptarP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	protected JTable jtDisponible, jtSolicitado;
	protected int renglonGlobalDisponible = -1, renglonGlobalSolicitado = -1;
	private JTableHeader jth;
	protected JTextField jtMontoTotal;
	protected TableModelVector tmv ;
	private static final long serialVersionUID = 1L;

    public ConsultaComanda() throws Exception {
        super("Consulta Comanda", false, true, false);
        // Tamaño de la Ventana
        setSize(821,654);
        // Localización de la Ventana
        setLocation(16,1);
        // Contenido de la Ventana
	}

	protected void setMesaConsulta(String mesaAlta){
		this.mesaAlta =mesaAlta;
		mesaID = Integer.parseInt(mesaAlta);
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letraC=new Font("Eras Demin ITC",Font.BOLD,20);
		letra=new Font("Eras Demin ITC",Font.BOLD,22);
		letraTH=new Font("Arial Narrow",Font.BOLD,15);
		letraT=new Font("Arial Narrow",Font.PLAIN,14);
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
		url= getClass().getResource("/imas/fondoConsultaComanda.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/Aceptar.jpg");
		iiBotonAceptarN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAceptarP = new ImageIcon(url);
		UIManager.put("ScrollBar.width", new Integer(50));
		// Doy formato a mis campos de Texto:
		// Acomodo mis campos dentro de la ventana.
		jtMontoTotal = new JTextField(30);
		jtMontoTotal.setHorizontalAlignment(JTextField.CENTER);
		jtMontoTotal.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtMontoTotal.setBounds(190,543,150,40);
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,811,636);
		if(mesaID !=0){
			jlMesa = new JLabel(iiMesa);
			jlMesa.setBounds(515,6,43,27);
		}
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		AbstractTableModel am = cliente.bs.ConsultaProductoComanda(mesaID);
		jtDisponible = new JTable((TableModel)am);
		jscroll = new JScrollPane(jtDisponible,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		jtDisponible.setFont(letraT);
		jtDisponible.setRowSelectionAllowed(true);
		jtDisponible.setColumnSelectionAllowed(false);
		jtDisponible.setShowGrid(true);
		jtDisponible.setRowHeight(28);
		jth = new JTableHeader();
		jth = jtDisponible.getTableHeader();
		jth.setFont(letraTH);
		jscroll.setBounds(35, 48, 750,485);
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
		column.setPreferredWidth(55);
		column.setMinWidth(55);
		column.setMaxWidth(55);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(2);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(378);
		column.setMinWidth(378);
		column.setMaxWidth(378);
		column.setResizable(false);
		column = jtDisponible.getColumnModel().getColumn(3);
		column.setCellRenderer( centerRenderer );
		column.setPreferredWidth(120);
		column.setMinWidth(120);
		column.setMaxWidth(120);
		column.setResizable(false);
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (645,563,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		// Mando a la ventana todos los contenidos.
		if(mesaID >0){
			this.add(jlMesa);
		}
		this.add(jlAceptar);
		this.add(jtMontoTotal);
		this.add(jscroll);
		// Si el tipo de precio es por Grupos despligo aviso.
		this.add(jlFondo);
		// Condiciono si se despliga kilos o unidades de acuerdo al tipo de producto
		cargaMontoTotal();
		jtMontoTotal.setEditable(false);
    	setVisible(true);
	}


	public void cargaMontoTotal() throws Exception{
		double montoConsumido = 0.00;
		montoConsumido = cliente.bs.dameMontoTransaccion(mesaID);
		jtMontoTotal.setText("$ " +cliente.ma.formatoDinero(cliente.ma.acortaLongitud(montoConsumido+"")));
	}

// Referencia directa a la Interfaz para cambiar valor de tipoPrecio.
	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void procesoAceptar() {
		try{
				Cierra();
		}
		catch(Exception e){
			e.printStackTrace();
			JOptionPane.showInternalMessageDialog(cliente.desktop, "Excepcion  en Consulta Comanda.\nVuelva a intentarlo.");
			Cierra();
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
				if(temporal == jlAceptar){
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
				if(temporal == jlAceptar){
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
				if(temporal == jlAceptar){
					jlAceptar.setIcon(iiBotonAceptarN);
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