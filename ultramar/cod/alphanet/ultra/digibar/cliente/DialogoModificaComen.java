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

public class DialogoModificaComen extends JDialog{

	public JTextField jtCantidad;
	protected boolean existioCambio = false;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected Cliente cliente;
	protected int cantidadElementos = -1;
	private Font letra;
	protected boolean primerCambio = true;
	protected int maxComensales = -1;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	protected JLabel jlBorrar, jlCancela, jlAceptar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, 	iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAceptarN,iiBotonAceptarP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private Image imagen;
	private static final long serialVersionUID = 1L;

	public DialogoModificaComen (Frame padre, String titulo, boolean modal) throws Exception {
		super(padre, titulo,modal);
		// con esto aseguro que no puedan cerrar mi ventana de manera tradicional.
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

	public void setPadre (Cliente cliente){
		this.cliente = cliente;
	}

	public void setCantidadActual(int maxComensales){
		this.maxComensales =  maxComensales;
	}

	public void dibujaDialogo() throws Exception {
		// El tamaño del Diálogo
		setSize(614,506);
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,19);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fonditoModificaProducto2.jpg");
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
		// Doy formato a mis campos de Texto:
		jtCantidad = new JTextField(30);
		jtCantidad.setHorizontalAlignment(JTextField.CENTER);
		jtCantidad.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtCantidad.setBounds(158,112,200,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,608,477);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(149,179,58,55);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(225,179,58,55);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(300,179,58,55);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(375,179,58,55);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(449,179,58,55);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(149,269,58,55);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(225,269,58,55);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(300,269,58,55);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(375,269,58,55);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(449,269,58,55);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(375,105,131,55);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAceptar= new JLabel(iiBotonAceptarN);
		jlAceptar.setBounds (435,404,152,55);
		jlAceptar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(14,404,152,55);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		// La textura de fondo (propiedad heredada de Kiwi)
		//setTexture(imagen);
		// Se prohibe modificar sus dimensiones al momento de ejecución
		setResizable(false);
		// Lleno mi contenedor con los elementos para que los despliegue
		setLocationRelativeTo(null);
		getContentPane().setLayout(null);
		getContentPane().add(jlBoton1);
		getContentPane().add(jlBoton2);
		getContentPane().add(jlBoton3);
		getContentPane().add(jlBoton4);
		getContentPane().add(jlBoton5);
		getContentPane().add(jlBoton6);
		getContentPane().add(jlBoton7);
		getContentPane().add(jlBoton8);
		getContentPane().add(jlBoton9);
		getContentPane().add(jlBoton0);
		getContentPane().add(jlBorrar);
		getContentPane().add(jlCancela);
		getContentPane().add(jlAceptar);
		getContentPane().add(jtCantidad);
		getContentPane().add(jlFondo);
		jtCantidad.setText(maxComensales+"");
		jtCantidad.selectAll();
		// Muestro el contenido del contenedor
		setVisible(true);
	}

	public void procesoAceptar() {
		try{
// Verifico que la Cantidad sea mayor a cero.
			if(cliente.ma.cambiaAInt(jtCantidad.getText()) <= 0){
				MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "La Cantidad debe ser mayor a 0.");
				mn.dibujaDialogo();
				jtCantidad.requestFocus();
				jtCantidad.selectAll();
				primerCambio = true;
			}
			else if(cliente.ma.cambiaAInt(jtCantidad.getText()) > maxComensales){
				MensajeNotificacion mn = new MensajeNotificacion(cliente, "Aviso", true, "ERROR: Sobrepasas los comensales");
				mn.dibujaDialogo();
				jtCantidad.requestFocus();
				jtCantidad.selectAll();
				primerCambio = true;
			}
			else{
				existioCambio = true;
				cantidadElementos = cliente.ma.cambiaAInt(jtCantidad.getText());
				Cierra();
			}
		}
		catch(Exception e){
			e.printStackTrace();
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
				if(temporal == jlBoton1){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"1");
					}
				}
				else if(temporal == jlBoton2){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"2");
					}
				}
				else if(temporal == jlBoton3){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"3");
					}
				}
				else if(temporal == jlBoton4){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"4");
					}
				}
				else if(temporal == jlBoton5){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"5");
					}
				}
				else if(temporal == jlBoton6){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"6");
					}
				}
				else if(temporal == jlBoton7){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"7");
					}
				}
				else if(temporal == jlBoton8){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"8");
					}
				}
				else if(temporal == jlBoton9){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
						jtCantidad.setText(previo+"9");
					}
				}
				else if(temporal == jlBoton0){
					if(primerCambio){
						jtCantidad.setText("");
						primerCambio = false;
					}
					String previo = jtCantidad.getText();
					if (previo.length() < 3){
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