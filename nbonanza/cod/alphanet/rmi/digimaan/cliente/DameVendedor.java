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
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import alphanet.rmi.digimaan.bd.Sound;
import alphanet.rmi.digimaan.bd.ManagerAuxiliar;
import java.rmi.RemoteException;
import java.math.*;
import javax.swing.WindowConstants;


public class DameVendedor extends JInternalFrame {

	private String claveProducto = new String("");
	private int tipoPrecio = 0; //  0-> Normal, 1--> MedioMayoreo, 2--> Mayoreo, 3--> Asignado, 7--> Escalon
	protected int cambioUnico = -1;//-1 --> Inactivo,  // 0-> Normal, 1--> MedioMayoreo, 2--> Mayoreo, 3--> Asignado,  7--> Escalon
	private int clasePLU = 0; // 0--> Peso, 1--> Por pieza.
	private int claveU = 0;
	private String precio = "0.00";
	private int tipoUnidad = 0; // 1 --> Kg,  2--> Unidad,  3 --> Caja,  4 --> Pieza
	private String  cantidad = "0";
	private	JDesktopPane desktop = null;
	protected JTextField jtClaveU;
	private JTextField jtProducto, jtCantidad, jtVenta, jtPrecio, jtTipo, jtImporte;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0;
	private JLabel jlBorrar, jlCancela, jlAgregar;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAgreN,iiBotonAgreP;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	private ResultSet rsInfoProd = null;
	protected DigiCliente digiCliente;
	protected double pesoDePiezas = 0.00;
	protected int tipoProducto = 0; // 1 Solo Kg,  2 Solo unidad,  3 Unidad y Caja, 4 Kg y Pieza

	public void setTipoProducto (int tipoProducto){
		this.tipoProducto = tipoProducto;
	}

	public void setPesoXPzas(double pesoDePiezas){
		this.pesoDePiezas = pesoDePiezas;
	}

    public DameVendedor() throws Exception {
        super("Captura Vendedor", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

// Utileria para quitar las comas.
	private String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,20);
		// ASIGNACION DE IMAGENES A ICONOS.
		url= getClass().getResource("/imas/fondoCapturaVendedor.jpg");
		iiFondo = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/UnoN.jpg");
		iiBoton1N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/UnoP.jpg");
		iiBoton1P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/DosN.jpg");
		iiBoton2N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/DosP.jpg");
		iiBoton2P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/TresN.jpg");
		iiBoton3N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/TresP.jpg");
		iiBoton3P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CuatroN.jpg");
		iiBoton4N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CuatroP.jpg");
		iiBoton4P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CincoN.jpg");
		iiBoton5N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CincoP.jpg");
		iiBoton5P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SeisN.jpg");
		iiBoton6N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SeisP.jpg");
		iiBoton6P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SieteN.jpg");
		iiBoton7N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/SieteP.jpg");
		iiBoton7P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/OchoN.jpg");
		iiBoton8N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/OchoP.jpg");
		iiBoton8P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/NueveN.jpg");
		iiBoton9N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/NueveP.jpg");
		iiBoton9P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CeroN.jpg");
		iiBoton0N = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CeroP.jpg");
		iiBoton0P = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCN.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCN.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarN.jpg");
		iiBotonAgreN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AceptarP.jpg");
		iiBotonAgreP = new ImageIcon(url);
	// Doy formato a mis campos de Texto:
		jtProducto = new JTextField(30);
		jtProducto.setHorizontalAlignment(JTextField.CENTER);
		jtProducto.setFont(letra);
		jtCantidad = new JTextField(30);
		jtCantidad.setHorizontalAlignment(JTextField.CENTER);
		jtCantidad.setFont(letra);
		jtVenta = new JTextField(30);
		jtVenta.setHorizontalAlignment(JTextField.CENTER);
		jtVenta.setFont(letra);
		jtClaveU = new JTextField(30);
		jtClaveU.setHorizontalAlignment(JTextField.CENTER);
		jtClaveU.setFont(letra);
		jtPrecio = new JTextField(30);
		jtPrecio.setHorizontalAlignment(JTextField.CENTER);
		jtPrecio.setFont(letra);
		jtImporte = new JTextField(30);
		jtImporte.setHorizontalAlignment(JTextField.CENTER);
		jtImporte.setFont(letra);
		jtTipo = new JTextField(30);
		jtTipo.setHorizontalAlignment(JTextField.CENTER);
		jtTipo.setFont(letra);
		// Acomodo mis campos dentro de la ventana.
		jtProducto.setBounds(145,45,550,30);
		jtCantidad.setBounds(145,95,160,30);
		jtVenta.setBounds(440,95,115,30);
		jtPrecio.setBounds(665,95,140,30);
		jtImporte.setBounds(130, 145, 200, 30);
		jtTipo.setBounds(540,145,200,30);
		jtClaveU.setBounds(245,185,185,40);
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(200,240,70,70);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(300,240,70,70);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(400,240,70,70);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(200,320,70,70);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(300,320,70,70);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(400,320,70,70);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(200,400,70,70);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(300,400,70,70);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(400,400,70,70);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(200,480,70,70);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(300,480,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAgregar= new JLabel(iiBotonAgreN);
		jlAgregar.setBounds (570,280,165,70);
		jlAgregar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(570,375,165,70);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
// LLENO LOS DATOS DEL PRODUCTO SOLICITADO:
		try{
			jtProducto.setText(digiCliente.bs.dameNombreProducto(claveProducto));
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
		if(tipoUnidad == 4){
			jtCantidad.setText(cantidad+" ("+pesoDePiezas+")");
		}
		else{
			jtCantidad.setText(cantidad);
		}
		if(tipoPrecio == 7){
			jtPrecio.setText(ma.formatoDinero(digiCliente.bs.cambiaPrecioEscalon(cantidad, claveProducto)+""));
			precio = jtPrecio.getText();
		}
		else{
			jtPrecio.setText(precio);
		}
		BigDecimal cantidadBD = new BigDecimal(remueveComas(cantidad));
		BigDecimal precioBD = new BigDecimal(remueveComas(precio));
		if(tipoUnidad == 4){ // Hablamos de una pieza
			cantidadBD = new BigDecimal(remueveComas(pesoDePiezas+""));
		}
		cantidadBD = cantidadBD.multiply(precioBD);
		cantidadBD = cantidadBD.setScale(2, RoundingMode.HALF_UP);
		jtImporte.setText(ma.formatoDinero(cantidadBD.toString()));
		if((tipoPrecio == 0 && cambioUnico == -1) || cambioUnico == 0){
			jtTipo.setText("Menudeo");
			tipoPrecio = 0;
		}
		else if((tipoPrecio==1 && cambioUnico == -1) || cambioUnico == 1){
			jtTipo.setText("Med.Mayoreo");
			tipoPrecio = 1;
		}
		else if((tipoPrecio==2 && cambioUnico ==-1) || cambioUnico == 2){
			jtTipo.setText("Mayoreo");
			tipoPrecio = 2;
		}
		else if((tipoPrecio==3  && cambioUnico == -1)|| cambioUnico == 3){
			jtTipo.setText("Asignación Directa");
			tipoPrecio = 3;
		}
		else if(tipoPrecio==7){
			jtTipo.setText("Normal/Escalonado");
			tipoPrecio = 7;
		}
		if(tipoUnidad == 1){
			jtVenta.setText("Kilogramo");
		}
		else if(tipoUnidad == 2){
			jtVenta.setText("Unidad");
		}
		else if(tipoUnidad == 3){
			jtVenta.setText("Caja");
		}
		else if(tipoUnidad == 4){
			jtVenta.setText("Pieza (Kg.)");
		}
		// Mando a la ventana todos los contenidos.
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
		this.add(jlAgregar);
		this.add(jtProducto);
		this.add(jtCantidad);
		this.add(jtVenta);
		this.add(jtClaveU);
		this.add(jtPrecio);
		this.add(jtImporte);
		this.add(jtTipo);
		this.add(jlFondo);
    	setVisible(true);
    	jtProducto.setEditable(false);
    	jtCantidad.setEditable(false);
    	jtPrecio.setEditable(false);
    	jtImporte.setEditable(false);
    	jtTipo.setEditable(false);
    	jtVenta.setEditable(false);
		digiCliente.desktop.setSelectedFrame(this);
		this.setSelected(true);
	}

// Inicio proceso para agregar producto seleccionado.
	private void procesoAgregaFinal() throws Exception{
		// Valido que me hayan escrito una clave de vendedor
		claveU = ma.cambiaAInt(jtClaveU.getText());
		if(claveU == 0){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Debes escribir tu clave.");
			jtClaveU.setText("");
		}
		else{
			boolean existe = false;
			try{
				existe = digiCliente.bs.existeUsuario(claveU);
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
			if (!existe){
				JOptionPane.showInternalMessageDialog(digiCliente.desktop, "La clave: "+claveU +" no existe o esta dada de Baja.");
				jtClaveU.setText("");
			}
			else{
				boolean almacenamiento = false;
				try{
					almacenamiento = digiCliente.bs.guardaProducto(claveProducto, tipoUnidad, tipoPrecio, jtPrecio.getText(), cantidad, pesoDePiezas,  jtImporte.getText(), claveU);
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
				if(almacenamiento){
				// DESCARGO ESTA VENTANA
					this.setVisible(false);
					this.dispose();
					digiCliente.desktop.remove(this);
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
				}
				else{
					JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Error con la Base de Datos, no se Guardo el Producto");
					// DESCARGO ESTA VENTANA
					this.setVisible(false);
					this.dispose();
					digiCliente.desktop.remove(this);
					if(!digiCliente.arranqueSinEscanner){
						digiCliente.resetHilos();
					}
					digiCliente.jftClave.requestFocus();
				}
			}
		}
	}

	public void Cierra() {
		this.setVisible(false);
		this.dispose();
		digiCliente.desktop.remove(this);
		if(!digiCliente.arranqueSinEscanner){
			digiCliente.resetHilos();
		}
		digiCliente.jftClave.requestFocus();
	}

// Recibo el precio correspondiente de Venta
	public void setPrecio(String prize) throws Exception{
		this.precio = (prize);
	}
// Me informo si la venta fue por unidades o caja.
	public void setTipoUnidad (int unidad){
		this.tipoUnidad = unidad; // 1 --> Kg,  2--> Unidad,  3 --> Caja,  4 --> Pieza
	}

// Me informo si existe un cambio temporal de precio único para esta transaccion
	public void setCambioUnico (int cambioUnico){
		this.cambioUnico = cambioUnico;// -1 --> No se uso, 0 --> Normal, 1-->GP1, 2-->GP2, 3-->GP3
	}
// Recibo la Cantidad de producto vendida
	public void setCantidadVendida(String cantidad){
		this.cantidad = cantidad;
	}

// Mando llamar este metodo para asignar la Clave del Producto que fue solicitado.
	public void setClaveProducto(String claveProducto){
		this.claveProducto = claveProducto;
	}

// Mando llamar este metodo para asignar el tipo de Precio con el que se esta generando la cuenta
	public void setTipoPrecio(int tipoPrecio){
		this.tipoPrecio = tipoPrecio;
	}


// Referencia a mi padre escritorio.
	public void setPadre(DigiCliente digiCliente){
		this.digiCliente = digiCliente;
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
				if(temporal == jlBoton1){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"1");
					}
				}
				else if(temporal == jlBoton2){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"2");
					}
				}
				else if(temporal == jlBoton3){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"3");
					}
				}
				else if(temporal == jlBoton4){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"4");
					}
				}
				else if(temporal == jlBoton5){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"5");
					}
				}
				else if(temporal == jlBoton6){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"6");
					}
				}
				else if(temporal == jlBoton7){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"7");
					}
				}
				else if(temporal == jlBoton8){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"8");
					}
				}
				else if(temporal == jlBoton9){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"9");
					}
				}
				else if(temporal == jlBoton0){
					String previo = jtClaveU.getText();
					if (previo.length() < 4){
						jtClaveU.setText(previo+"0");
					}
				}
				else if(temporal == jlBorrar){
					jtClaveU.setText("");
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAgregar){
					procesoAgregaFinal();
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
				else if(temporal == jlAgregar){
					jlAgregar.setIcon(iiBotonAgreP);
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
				else if(temporal == jlAgregar){
					jlAgregar.setIcon(iiBotonAgreN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}
}