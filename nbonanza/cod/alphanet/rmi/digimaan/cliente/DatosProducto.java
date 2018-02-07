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
import java.util.Vector;
import javax.swing.WindowConstants;

public class DatosProducto extends JInternalFrame {

	private String claveProducto = new String("");
	private int tipoPrecio = 0; //  0-> Normal, 1--> MedioMayoreo, 2--> Mayoreo, 3--> Asignado, 7--> Escalon
	private int cambioUnico = -1; //-1 --> Inactivo,  // 0-> Normal, 1--> MedioMayoreo, 2--> Mayoreo, 3--> Asignado,  7--> Escalon
	private int clasePLU = 0; // 0--> Peso, 1--> Por pieza.
	public double temporalD = 0.00; // La cantidad comprada del producto.
	private boolean existeCaja = true; // Uso como bandera para saber si el producto se puede vender por caja.
	public JTextField jtCantidad;
	private JTextField jtProducto, jtExistenciaPz, jtExistenciaCaja, jtPrecioU, jtPrecioC, jtUXCaja;
	private JLabel jlFondo;
	private ImageIcon iiFondo;
	private URL url;
	protected DigiCliente digiCliente;
	private Font letra;
	private JLabel jlBoton1, jlBoton2, jlBoton3, jlBoton4, jlBoton5, jlBoton6, jlBoton7, jlBoton8, jlBoton9, jlBoton0, jlBotonMedio;
	protected JLabel jlBorrar, jlCancela, jlAgregar, jlCambioE, jlTacheU, jlTacheC, jlAvisoGP, jlUXCaja,  jlEscalonado;
	private ImageIcon iiBoton1N, iiBoton1P, iiBoton2N, iiBoton2P, iiBoton3N, iiBoton3P, iiBoton4N, iiBoton4P, iiBoton5N, iiBoton5P,  iiBoton6N, iiBoton6P, iiBoton7N, iiBoton7P, iiBoton8N, iiBoton8P, iiBoton9N, iiBoton9P, iiBoton0N, iiBoton0P, iiBotonBN, iiBotonBP, iiBotonCanN, iiBotonCanP, iiBotonAgreN,iiBotonAgreP, iiTacheC, iiTacheU, iiAvisoGP, iiEscalonadoN, iiEscalonadoP, iiBotonMN, iiBotonMP,  iiBotonCambioEN, iiBotonCambioEP, iiUniPorCaja;
	private Sound son;
	private Cursor deMano = new Cursor (Cursor.HAND_CURSOR);
	private Cursor normal = new Cursor (Cursor.DEFAULT_CURSOR);
	private ManagerAuxiliar ma = new ManagerAuxiliar();
	private ResultSet rsInfoProd = null;
	protected double lasPiezasExistentes = 0.0;
	protected int lasCajasExistentes = 0;
	protected String precioUKg = "S/A";
	protected String precioCPZ = "S/A";

// NUEVOS
	protected int tipoProducto = 0; // 1 Solo Kg,  2 Solo unidad,  3 Unidad y Caja, 4 Kg y Pieza
	protected int manejoPrecio = 0; // 1 Solo Base,  2 Grupo,  3 Escalon.
// NUEVOS
	protected JLabel jlPrecioUni, jlPrecioKilo, jlPrecioPieza, jlPrecioCa, jlEspecifica, jlPorCaja, jlPorUni, jlPiezasXCaja, jlPiezas, jlKilos, jlCajas, jlTrabajandoEn, jlKgEnPz, jlPorPz, jlUnidades, jlPorKg;
	protected ImageIcon iiPrecioUni, iiPrecioKilo, iiPrecioCa, iiEspecifica, iiPorCaja, iiPorUni, iiPiezasXCaja, iiPiezas, iiKilos, iiCajas, iiTrabajandoEn, iiPorPieza, iiUnidad, iiKilosXPz, iiPorKilo, iiPieza;
	protected JTextField jtPrecioKg, jtPrecioPz, jtExistenciaKg, jtPzXKg, jtExistenciaUni;
    public DatosProducto() throws Exception {
        super("Datos Producto", false, true, false);
        // Tamaño de la Ventana
        setSize(840,640);
        // Localización de la Ventana
        setLocation(11,11);
        // Contenido de la Ventana
		this.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}

// Referencia directa a la Interfaz para cambiar valor de tipoPrecio.
	public void setPadre (DigiCliente digiCliente){
		this.digiCliente = digiCliente;
	}

// Mando llamar este metodo para asignar la Clave del Producto que fue solicitado.
	public void setClaveProducto(String claveProducto) throws Exception {
		try{
			this.claveProducto = claveProducto;
			tipoProducto = digiCliente.bs.dameTipoProducto(claveProducto);
			manejoPrecio = digiCliente.bs.dameManejoPrecio(claveProducto);
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
	}

// Mando llamar este metodo para asignar el tipo de Precio con el que se esta generando la cuenta
	public void setTipoPrecio(int tipoPrecio){
		this.tipoPrecio = tipoPrecio;
	}

	public void setCambioUnico (int cambioUnico){
		this.cambioUnico = cambioUnico;
	}

	public void despliegaInterfaz() throws Exception{
		son = new Sound();
		letra=new Font("Eras Demin ITC",Font.BOLD,20);
		// ASIGNACION DE IMAGENES A ICONOS.
		// Imagenes de Cajon:
		url= getClass().getResource("/imas/fondoProducto.jpg");
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
		url= getClass().getResource("/imas/botones/MedioN.jpg");
		iiBotonMN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/MedioP.jpg");
		iiBotonMP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCN.jpg");
		iiBotonBN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/BorrarCP.jpg");
		iiBotonBP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCN.jpg");
		iiBotonCanN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/CancelarCP.jpg");
		iiBotonCanP = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AgregarN.jpg");
		iiBotonAgreN = new ImageIcon(url);
		url= getClass().getResource("/imas/botones/AgregarP.jpg");
		iiBotonAgreP = new ImageIcon(url);
		// Dependiendo del producto
		if(tipoProducto == 1 || tipoProducto == 4){	// Solo KG
			url= getClass().getResource("/imas/etiqueta/Kilogramo.png");
			iiPrecioKilo = new ImageIcon(url);
			url= getClass().getResource("/imas/etiqueta/Kilos.png");
			iiKilos = new ImageIcon(url);
			if(tipoProducto ==4){ // Por KG y Piezas
				url= getClass().getResource("/imas/botones/tacheUni.jpg");
				iiTacheC = new ImageIcon(url);
				url= getClass().getResource("/imas/botones/tacheUni.jpg");
				iiTacheU = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/PorPieza.png");
				iiPorPieza = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/Piezas.png");
				iiPiezas = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/Pieza.png");
				iiPieza = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/KilosXPieza.png");
				iiKilosXPz = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/PorKilo.png");
				iiPorKilo = new ImageIcon(url);
			}
		}
		else{ // PIEZA ó PIEZA Y CAJA
			url= getClass().getResource("/imas/etiqueta/Unidad.png");
			iiPrecioUni = new ImageIcon(url);
			url= getClass().getResource("/imas/etiqueta/Unidades.png");
			iiUnidad = new ImageIcon(url);
			if(tipoProducto == 3){ // HABLAMOS DE PZ Y CAJA
				url= getClass().getResource("/imas/botones/tacheUni.jpg");
				iiTacheC = new ImageIcon(url);
				url= getClass().getResource("/imas/botones/tacheUni.jpg");
				iiTacheU = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/PiezasXCaja.png");
				iiUniPorCaja = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/Caja.png");
				iiPrecioCa = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/Especifica.png");
				iiEspecifica =  new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/PorCaja.png");
				iiPorCaja =  new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/PorUnidad.png");
				iiPorUni = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/PiezasXCaja.png");
				iiPiezasXCaja = new ImageIcon(url);
				url= getClass().getResource("/imas/etiqueta/Cajas.png");
				iiCajas =  new ImageIcon(url);
			}
		}
		if(manejoPrecio == 2){ // Hablamos de venta por Grupo
			url= getClass().getResource("/imas/botones/CambioEN.jpg");
			iiBotonCambioEN=  new ImageIcon(url);
			url= getClass().getResource("/imas/botones/CambioEP.jpg");
			iiBotonCambioEP= new ImageIcon(url);
		}
		else if (manejoPrecio == 3){ // Hablamos de venta por escalon
			url= getClass().getResource("/imas/botones/EscalonN.jpg");
			iiEscalonadoN = new ImageIcon(url);
			url= getClass().getResource("/imas/botones/EscalonP.jpg");
			iiEscalonadoP = new ImageIcon(url);
		}
		if(tipoPrecio != 0 || cambioUnico != -1){
			url= getClass().getResource("/imas/etiqueta/TrabajandoEn.png");
			iiTrabajandoEn = new ImageIcon(url);
		}
		if((tipoPrecio == 1 || cambioUnico == 1) && cambioUnico != 0){
			url= getClass().getResource("/imas/etiqueta/GPMM.png");
			iiAvisoGP = new ImageIcon(url);
		}
		else if ((tipoPrecio == 2 || cambioUnico == 2) && cambioUnico !=0){
			url= getClass().getResource("/imas/etiqueta/GPM.png");
			iiAvisoGP = new ImageIcon(url);
		}
		else if ((tipoPrecio == 3 || cambioUnico == 3) && cambioUnico !=0){
			url= getClass().getResource("/imas/etiqueta/GPA.png");
			iiAvisoGP = new ImageIcon(url);
		}
		// Doy formato a mis campos de Texto:
		jtProducto = new JTextField(30);
		jtProducto.setHorizontalAlignment(JTextField.CENTER);
		jtProducto.setFont(letra);
		jtProducto.setBounds(220,14,550,30);
		jtCantidad = new JTextField(30);
		jtCantidad.setHorizontalAlignment(JTextField.CENTER);
		jtCantidad.setFont(letra);
		jtCantidad.setBounds(265,180,300,40);
		// Acomodo mis campos dentro de la ventana.
		//  Configuro Fondo de la pantalla y ubico en la ventana
		jlFondo = new JLabel(iiFondo);
		jlFondo.setBounds(0,0,829,609);
		// Configuro todos los botones, ubico dentro de la ventana y ligo acciones al ser tocados.
		jlBoton1 = new JLabel(iiBoton1N);
		jlBoton1.setBounds(286,224,70,70);
		jlBoton1.addMouseListener(new mouseComportamientoLabels());
		jlBoton2 = new JLabel(iiBoton2N);
		jlBoton2.setBounds(377,224,70,70);
		jlBoton2.addMouseListener(new mouseComportamientoLabels());
		jlBoton3 = new JLabel(iiBoton3N);
		jlBoton3.setBounds(467,224,70,70);
		jlBoton3.addMouseListener(new mouseComportamientoLabels());
		jlBoton4 = new JLabel(iiBoton4N);
		jlBoton4.setBounds(286,300,70,70);
		jlBoton4.addMouseListener(new mouseComportamientoLabels());
		jlBoton5 = new JLabel(iiBoton5N);
		jlBoton5.setBounds(377,300,70,70);
		jlBoton5.addMouseListener(new mouseComportamientoLabels());
		jlBoton6 = new JLabel(iiBoton6N);
		jlBoton6.setBounds(467,300,70,70);
		jlBoton6.addMouseListener(new mouseComportamientoLabels());
		jlBoton7 = new JLabel(iiBoton7N);
		jlBoton7.setBounds(286,375,70,70);
		jlBoton7.addMouseListener(new mouseComportamientoLabels());
		jlBoton8 = new JLabel(iiBoton8N);
		jlBoton8.setBounds(377,375,70,70);
		jlBoton8.addMouseListener(new mouseComportamientoLabels());
		jlBoton9 = new JLabel(iiBoton9N);
		jlBoton9.setBounds(467,375,70,70);
		jlBoton9.addMouseListener(new mouseComportamientoLabels());
		jlBoton0 = new JLabel(iiBoton0N);
		jlBoton0.setBounds(286,450,70,70);
		jlBoton0.addMouseListener(new mouseComportamientoLabels());
		jlBotonMedio = new JLabel(iiBotonMN);
		jlBotonMedio.setBounds(377,525,70,70);
		jlBotonMedio.addMouseListener(new mouseComportamientoLabels());
		jlBorrar= new JLabel(iiBotonBN);
		jlBorrar.setBounds(377,450,170,70);
		jlBorrar.addMouseListener(new mouseComportamientoLabels());
		jlAgregar= new JLabel(iiBotonAgreN);
		jlAgregar.setBounds (642,200,165,70);
		jlAgregar.addMouseListener(new mouseComportamientoLabels());
		jlCancela= new JLabel(iiBotonCanN);
		jlCancela.setBounds(642,280,165,70);
		jlCancela.addMouseListener(new mouseComportamientoLabels());
		if(tipoProducto == 1 || tipoProducto == 4){	// Solo KG
			jlPrecioKilo = new JLabel(iiPrecioKilo);
			jlPrecioKilo.setBounds(140,55,149,37);
			jlKilos= new JLabel(iiKilos);
			jlKilos.setBounds(590,400,78,29);
			jtPrecioKg = new JTextField(20);
			jtPrecioKg.setHorizontalAlignment(JTextField.RIGHT);
			jtPrecioKg.setFont(letra);
			jtPrecioKg.setBounds(295,55,90,30);
			jtExistenciaKg = new JTextField(20);
			jtExistenciaKg.setHorizontalAlignment(JTextField.CENTER);
			jtExistenciaKg.setFont(letra);
			jtExistenciaKg.setBounds(680,400,110,30);
			if(tipoProducto ==4){ // Por Kg y Pieza.
				jlPiezas= new JLabel(iiPiezas);
				jlPiezas.setBounds(590,460,78,29);
				jtExistenciaPz = new JTextField(20);
				jtExistenciaPz.setHorizontalAlignment(JTextField.CENTER);
				jtExistenciaPz.setFont(letra);
				jtExistenciaPz.setBounds(680,460,110,30);
				jlPrecioPieza = new JLabel(iiPieza);
				jlPrecioPieza.setBounds(410,55,90,30);
				jtPrecioPz = new JTextField(20);
				jtPrecioPz.setHorizontalAlignment(JTextField.RIGHT);
				jtPrecioPz.setFont(letra);
				jtPrecioPz.setBounds(495,55,90,30);
				jlPorKg = new JLabel(iiPorKilo);
				jlPorKg.setBounds(377,100,102,37);
				jlPorPz = new JLabel(iiPorPieza);
				jlPorPz.setBounds(188,100,135,37);
				jlKgEnPz = new JLabel(iiKilosXPz);
				jlKgEnPz.setBounds(55,140,161,30);
				jtPzXKg = new JTextField(30);
				jtPzXKg.setHorizontalAlignment(JTextField.CENTER);
				jtPzXKg.setFont(letra);
				jtPzXKg.setBounds(265,140,110,30);
				jlTacheC= new JLabel(iiTacheC);
				jlTacheC.setBounds(315,92,39,40);
				jlTacheC.addMouseListener(new mouseComportamientoLabels());
				jlTacheU= new JLabel(iiTacheU);
				jlTacheU.setBounds(485,92,39,40);
				jlTacheU.addMouseListener(new mouseComportamientoLabels());
			}
		}
		else { // PIEZA ó PIEZA Y CAJA
			jlPrecioUni = new JLabel(iiPrecioUni);
			jlPrecioUni.setBounds(150,55,114,37);
			jlUnidades= new JLabel(iiUnidad);
			jlUnidades.setBounds(575,410,107,28);
			jtExistenciaUni = new JTextField(20);
			jtExistenciaUni.setHorizontalAlignment(JTextField.CENTER);
			jtExistenciaUni.setFont(letra);
			jtExistenciaUni.setBounds(680,410,110,30);
			jtPrecioU = new JTextField(30);
			jtPrecioU.setHorizontalAlignment(JTextField.RIGHT);
			jtPrecioU.setFont(letra);
			jtPrecioU.setBounds(265,55,110,30);
			if(tipoProducto == 3){ // HABLAMOS DE PZ Y CAJA
				jtExistenciaCaja  = new JTextField(20);
				jtExistenciaCaja.setHorizontalAlignment(JTextField.CENTER);
				jtExistenciaCaja.setFont(letra);
				jtExistenciaCaja.setBounds(680,460,110,30);
				jlPrecioCa = new JLabel(iiPrecioCa);
				jlPrecioCa.setBounds(395,55,79,37);
				jtPrecioC = new JTextField(30);
				jtPrecioC.setHorizontalAlignment(JTextField.RIGHT);
				jtPrecioC.setFont(letra);
				jtPrecioC.setBounds(475,55,110,30);
				jlEspecifica = new JLabel(iiEspecifica);
				jlEspecifica.setBounds(20,100,143,37);
				jlPorCaja = new JLabel(iiPorCaja);
				jlPorCaja.setBounds(188,100,102,37);
				jlPorUni = new JLabel(iiPorUni);
				jlPorUni.setBounds(377,100,135,37);
				jlPiezasXCaja = new JLabel(iiUniPorCaja);
				jlPiezasXCaja.setBounds(55,140,207,36);
				jtUXCaja = new JTextField(30);
				jtUXCaja.setHorizontalAlignment(JTextField.CENTER);
				jtUXCaja.setFont(letra);
				jtUXCaja.setBounds(265,140,110,30);
				jlCajas  = new JLabel(iiCajas);
				jlCajas.setBounds(590,460,78,29);
				jlTacheC= new JLabel(iiTacheC);
				jlTacheC.setBounds(300,92,39,40);
				jlTacheC.addMouseListener(new mouseComportamientoLabels());
				jlTacheU= new JLabel(iiTacheU);
				jlTacheU.setBounds(515,92,39,40);
				jlTacheU.addMouseListener(new mouseComportamientoLabels());
			}
		}
		if(manejoPrecio == 2){ // Hablamos de venta por Grupo
			jlCambioE= new JLabel(iiBotonCambioEN);
			jlCambioE.setBounds (642,90,165,70);
			jlCambioE.addMouseListener(new mouseComportamientoLabels());
		}
		else if (manejoPrecio == 3){ // Hablamos de venta por escalon
			jlEscalonado = new JLabel(iiEscalonadoN);
			jlEscalonado.setBounds(642,90,165,70);
			jlEscalonado.addMouseListener(new mouseComportamientoLabels());
		}
		if((tipoPrecio != 0 || cambioUnico != -1) && cambioUnico != 0){
			jlTrabajandoEn = new JLabel(iiTrabajandoEn);
			jlTrabajandoEn.setBounds(55,280,141,60);
		}
		if((tipoPrecio == 1 || cambioUnico == 1) && cambioUnico != 0){
			jlAvisoGP = new JLabel(iiAvisoGP);
			jlAvisoGP.setBounds(55,360,141,60);
		}
		else if ((tipoPrecio == 2 || cambioUnico == 2) && cambioUnico !=0){
			jlAvisoGP = new JLabel(iiAvisoGP);
			jlAvisoGP.setBounds(55,360,141,60);
		}
		else if ((tipoPrecio == 3 || cambioUnico == 3) && cambioUnico !=0){
			jlAvisoGP = new JLabel(iiAvisoGP);
			jlAvisoGP.setBounds(55,360,141,60);
		}
// LLENO LOS DATOS DEL PRODUCTO SOLICITADO:
		jtProducto.setText(digiCliente.bs.dameNombreProducto(claveProducto));
		jtProducto.setEditable(false);
		if(tipoProducto == 1 || tipoProducto == 4){	// Solo KG
			Vector <String> datosXKG = new Vector <String> ();
			if(cambioUnico == -1){
				datosXKG = digiCliente.bs.damePrecioYExsitenciaXKilo(claveProducto, tipoPrecio);
				jtExistenciaKg.setText(datosXKG.elementAt(0));
				jtPrecioKg.setText(ma.formatoDinero(datosXKG.elementAt(1)));
			}
			else if(cambioUnico == 0 || cambioUnico == 1 || cambioUnico == 2){
				datosXKG = digiCliente.bs.damePrecioYExsitenciaXKilo(claveProducto, cambioUnico);
				jtExistenciaKg.setText(datosXKG.elementAt(0));
				jtPrecioKg.setText(ma.formatoDinero(datosXKG.elementAt(1)));
			}
			else{
				jtExistenciaKg.setText(digiCliente.bs.dameExistenciaXKilo(claveProducto));
				DamePrecioAsignado dpa = new DamePrecioAsignado(digiCliente, "Especifica el precio por Kilo", true, "Kilo", claveProducto, digiCliente);
				dpa.dibujaDialogo();
				precioUKg = dpa.precioRegistrado;
				jtPrecioKg.setText(ma.formatoDinero(precioUKg));
			}
			jtExistenciaKg.setEditable(false);
			jtPrecioKg.setEditable(false);
			if(tipoProducto ==4){ // Por Kg y Pieza.
				Vector <String> datoXPz  = new Vector <String>();
				if(cambioUnico == -1){
					datoXPz = digiCliente.bs.damePrecioYExsitenciaXPz(claveProducto, tipoPrecio);
					jtPrecioPz.setText(ma.formatoDinero(datoXPz.elementAt(0)));
					jtExistenciaPz.setText(datoXPz.elementAt(1));
					jtPzXKg.setText(datoXPz.elementAt(2));
				}
				else if(cambioUnico == 0 || cambioUnico == 1 || cambioUnico == 2){
					datoXPz = digiCliente.bs.damePrecioYExsitenciaXPz(claveProducto, cambioUnico);
					jtPrecioPz.setText(ma.formatoDinero(datoXPz.elementAt(0)));
					jtExistenciaPz.setText(datoXPz.elementAt(1));
					jtPzXKg.setText(datoXPz.elementAt(2));
				}
				else{
					datoXPz = digiCliente.bs.dameExistenciaXPz(claveProducto);
					jtExistenciaPz.setText(datoXPz.elementAt(0));
					jtPzXKg.setText(datoXPz.elementAt(1));
					DamePrecioAsignado dpa = new DamePrecioAsignado(digiCliente, "Especifica el precio del Kilo por  Pieza", true, "Pieza",claveProducto, digiCliente);
					dpa.dibujaDialogo();
					precioCPZ = dpa.precioRegistrado;
					jtPrecioPz.setText(ma.formatoDinero(precioCPZ));
				}
				jlTacheC.setEnabled(false);
				jtPrecioPz.setEditable(false);
				jtExistenciaPz.setEditable(false);
				jtPzXKg.setEditable(false);
			}
		}
		else{
			Vector <String> datoXPz = new Vector <String>();
			if(cambioUnico == -1){
				datoXPz = digiCliente.bs.damePrecioYExsitenciaXUni(claveProducto, tipoPrecio);
				jtExistenciaUni.setText(datoXPz.elementAt(0));
				jtPrecioU.setText(ma.formatoDinero(datoXPz.elementAt(1)));
			}
			else if(cambioUnico == 0 || cambioUnico == 1 || cambioUnico == 2){
				datoXPz = digiCliente.bs.damePrecioYExsitenciaXUni(claveProducto, cambioUnico);
				jtExistenciaUni.setText(datoXPz.elementAt(0));
				jtPrecioU.setText(ma.formatoDinero(datoXPz.elementAt(1)));
			}
			else{
				jtExistenciaUni.setText(digiCliente.bs.dameExistenciaXUni(claveProducto));
				DamePrecioAsignado dpa = new DamePrecioAsignado(digiCliente, "Especifica el precio por Unidad", true, "Unidad",claveProducto, digiCliente);
				dpa.dibujaDialogo();
				precioUKg = dpa.precioRegistrado;
				jtPrecioU.setText(ma.formatoDinero(precioUKg));
			}
			jtExistenciaUni.setEditable(false);
			jtPrecioU.setEditable(false);
			if(tipoProducto == 3){ // HABLAMOS DE Unidad Y CAJA
				Vector <String> datoXCaja = new Vector <String>();
				if(cambioUnico == -1){
					datoXCaja = digiCliente.bs.damePrecioYExsitenciaXCj(claveProducto, tipoPrecio);
					jtExistenciaCaja.setText(datoXCaja.elementAt(0));
					jtPrecioC.setText(ma.formatoDinero(datoXCaja.elementAt(1)));
					jtUXCaja.setText(datoXCaja.elementAt(2));
				}
				else if(cambioUnico == 0 || cambioUnico == 1 || cambioUnico == 2){
					datoXCaja = digiCliente.bs.damePrecioYExsitenciaXCj(claveProducto, cambioUnico);
					jtExistenciaCaja.setText(datoXCaja.elementAt(0));
					jtPrecioC.setText(ma.formatoDinero(datoXCaja.elementAt(1)));
					jtUXCaja.setText(datoXCaja.elementAt(2));
				}
				else{
					datoXCaja = digiCliente.bs.dameExistenciaXCaja(claveProducto);
					jtExistenciaCaja.setText(datoXCaja.elementAt(0));
					jtUXCaja.setText(datoXCaja.elementAt(1));
					DamePrecioAsignado dpa = new DamePrecioAsignado(digiCliente, "Especifica el precio por  Caja", true, "Caja",claveProducto, digiCliente);
					dpa.dibujaDialogo();
					precioCPZ = dpa.precioRegistrado;
					jtPrecioC.setText(ma.formatoDinero(precioCPZ));
				}
				jlTacheC.setEnabled(false);
				jtExistenciaCaja.setEditable(false);
				jtPrecioC.setEditable(false);
			}
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
		this.add(jlBotonMedio);
		if(tipoProducto == 1 || tipoProducto == 4){	// Solo KG
			this.add(jlPrecioKilo);
			this.add(jlKilos);
			this.add(jtPrecioKg);
			this.add(jtExistenciaKg);
			if(tipoProducto ==4){ // Por KG y Piezas
				this.add(jlPiezas);
				this.add(jtExistenciaPz);
				this.add(jlPrecioPieza);
				this.add(jtPrecioPz);
				this.add(jlPorKg);
				this.add(jlPorPz);
				this.add(jlKgEnPz);
				this.add(jtPzXKg);
				this.add(jlTacheC);
				this.add(jlTacheU);
			}
		}
		else{
			this.add(jlPrecioUni);
			this.add(jlUnidades);
			this.add(jtExistenciaUni);
			this.add(jtPrecioU);
			if(tipoProducto == 3){ // HABLAMOS DE PZ Y CAJA
				this.add(jtExistenciaCaja);
				this.add(jtPrecioC);
				this.add(jlPrecioCa);
				this.add(jlEspecifica);
				this.add(jlPorCaja);
				this.add(jlPorUni);
				this.add(jlPiezasXCaja);
				this.add(jtUXCaja);
				this.add(jlCajas);
				this.add(jlTacheC);
				this.add(jlTacheU);
			}
		}
		if(manejoPrecio == 2){ // Hablamos de venta por Grupo
			this.add(jlCambioE);
		}
		else if (manejoPrecio == 3){ // Hablamos de venta por escalon
			this.add(jlEscalonado);
		}
		if((tipoPrecio != 0 || cambioUnico != -1) && cambioUnico != 0){
			this.add(jlTrabajandoEn);
		}
		if((tipoPrecio == 1 || cambioUnico == 1) && cambioUnico != 0){
			this.add(jlAvisoGP);
		}
		else if ((tipoPrecio == 2 || cambioUnico == 2) && cambioUnico !=0){
			this.add(jlAvisoGP);
		}
		else if ((tipoPrecio == 3 || cambioUnico == 3) && cambioUnico !=0){
			this.add(jlAvisoGP);
		}
		this.add(jlFondo);
    	jtProducto.setEditable(false);
    	jtCantidad.setEditable(false);
    	jlBotonMedio.setVisible(false);
    	setVisible(true);
	}

// Formato a desplegar cuando se trata de un producto que se vende de acuerdo a su peso.
	private String formatoKG (String previo, String nuevo){
		previo = remuevePuntuacion(previo);
		previo = previo +nuevo;
		if(previo.length() == 1){
			previo = ".00"+previo;
		}
		else if(previo.length() == 2){
			previo = ".0"+previo;
		}
		else{
			StringBuilder sb = new StringBuilder(previo);
			sb.insert((previo.length()-3),'.');
			previo = sb.toString();
		}
		if(previo.startsWith("0")){
			previo=previo.substring(1, previo.length());
		}
		return previo;
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

	protected void datosPrevios(String cantidadIntroducida, int formato) throws Exception{
		jtCantidad.setText(cantidadIntroducida);
		if(formato > 0 && (tipoProducto ==3 || tipoProducto ==4)){	// es tipo 3 ó 4
			if(formato == 1){
				jlTacheC.setEnabled(true);
				jlTacheU.setEnabled(false);
				jlBotonMedio.setVisible(true);
			}
			else{
				jlTacheC.setEnabled(false);
				jlTacheU.setEnabled(true);
			}
		}
	}


	protected void procesoCambioExpress() throws Exception{
		this.setVisible(false);
		digiCliente.desktop.remove(this);
		this.dispose();
		CambioExpress ce = new CambioExpress();
		ce.setPadre(digiCliente);
		ce.setClaveProducto(claveProducto);
		ce.setCantidad(jtCantidad.getText());
		if(tipoProducto == 3 || tipoProducto == 4){
			if(jlTacheC.isEnabled()){
				ce.setFormato(1);
			}
			else{
				ce.setFormato(2);
			}
		}
		ce.setTipoPrecio(tipoPrecio);
		ce.setTipoProducto(tipoProducto);
		ce.despliegaInterfaz();
		ce.setVisible(true);
		digiCliente.desktop.add(ce);
		ce.moveToFront();
		digiCliente.desktop.setSelectedFrame(ce);
		ce.setSelected(true);
		ce.jtAutoriza.requestFocus();
	}

	protected boolean checaCantidadExistente() throws Exception{
		boolean resultado = true;
		double cantidadSolicitada = ma.cambiaADouble(jtCantidad.getText());
		if(tipoProducto == 1){ // Hablamos de Kilos....
			if(cantidadSolicitada > ma.cambiaADouble(jtExistenciaKg.getText())){
				resultado = false;
			}
		}
		else if(tipoProducto == 2){
			if(cantidadSolicitada > ma.cambiaADouble(jtExistenciaUni.getText())){
				resultado = false;
			}
		}
		else if(tipoProducto == 3){
			if(jlTacheU.isEnabled()){
				if(cantidadSolicitada > ma.cambiaADouble(jtExistenciaUni.getText())){
					resultado = false;
				}
			}
			else{
				if(cantidadSolicitada > ma.cambiaADouble(jtExistenciaCaja.getText())){
					resultado = false;
				}
			}
		}
		else if(tipoProducto == 4){
			if(jlTacheU.isEnabled()){
				if(cantidadSolicitada > ma.cambiaADouble(jtExistenciaKg.getText())){
					resultado = false;
				}
			}
			else{
				if(cantidadSolicitada > ma.cambiaADouble(jtExistenciaPz.getText())){
					resultado = false;
				}
			}
		}
		return resultado;
	}


// Inicio proceso para agregar producto seleccionado.
	private void procesoAgrega() throws Exception{
		// Valido que me hayan escrito una cantidad > 0
		temporalD = ma.cambiaADouble(jtCantidad.getText());
		if (temporalD<=0.0){
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "Debes dar una cantidad mayor a 0");
			jtCantidad.setText("");
		}
		else if(checaCantidadExistente()){
			// Inicializo otro ventana
			DameVendedor dv = new DameVendedor();
			dv.setPadre(digiCliente);
			// Envio la cantidad pedida.
			dv.setCantidadVendida(jtCantidad.getText());
			// La Clave del Producto.
			dv.setClaveProducto(claveProducto);
			dv.setTipoProducto(tipoProducto);
			// El tipo por Unidad o Caja
			// El tipo de precio correspondiente.
			if(jlEscalonado != null){
				tipoPrecio = 7;
			}
			dv.setTipoPrecio(tipoPrecio); // 0-> Normal, 1--> MedioMayoreo, 2--> Mayoreo, 3--> Asignado, 7--> Escalon
			// El precio asignado a una sola transaccion
			dv.setCambioUnico(cambioUnico);//-1 --> Inactivo,  // 0-> Normal, 1--> MedioMayoreo, 2--> Mayoreo, 3--> Asignado,  7--> Escalon
			// El precio que corresponde
			if (tipoProducto == 1){
				dv.setPrecio(jtPrecioKg.getText());
				dv.setTipoUnidad(1); // Es por Kg.
			}
			else if (tipoProducto==2){
				dv.setPrecio(jtPrecioU.getText());
				dv.setTipoUnidad(2); // Es por Unidad
			}
			else if(tipoProducto == 3){
				if(jlTacheU.isEnabled()){
					dv.setPrecio(jtPrecioU.getText());
					dv.setTipoUnidad(2); // Es por Unidad
				}
				else{
					dv.setPrecio(jtPrecioC.getText());
					dv.setTipoUnidad(3); // Es por Caja
				}
			}
			else{
				if(jlTacheU.isEnabled()){
					dv.setPrecio(jtPrecioKg.getText());
					dv.setTipoUnidad(1); // Es por Kg.
				}
				else{
// Mando pedir la cantidad de peso de las piezas
					DamePesoXPieza dppp = new DamePesoXPieza(digiCliente, "Especifica el peso de las piezas", true, temporalD+"");
					dppp.dibujaDialogo();
					double pesoDePiezas = dppp.pesoRegistrado;
					dv.setPesoXPzas(pesoDePiezas);
					dv.setPrecio(jtPrecioPz.getText());
					dv.setTipoUnidad(4); // Es por Pieza
				}
			}
			// Referencia al Escritorio
			// DESCARGO ESTA VENTANA
			this.setVisible(false);
			digiCliente.desktop.remove(this);
			this.dispose();
			// PINTO LA OTRA VENTANA
			dv.despliegaInterfaz();
			dv.setVisible(true);
			digiCliente.desktop.add(dv);
			dv.moveToFront();
			digiCliente.desktop.setSelectedFrame(dv);
			dv.setSelected(true);
			dv.jtClaveU.requestFocus();
		}
		// Sobre pasa peticion existencia...
		else{
			JOptionPane.showInternalMessageDialog(digiCliente.desktop, "¡La cantidad solicitada sobre pasa la existencia en inventario del producto!");
			jtCantidad.setText("");
			jtCantidad.requestFocus();
		}
	}

	public void procesoEscala() throws Exception{
		Vector <String> escala = new Vector<String>();
		try{
			escala = digiCliente.bs.listadoEscalon(claveProducto);
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
		String despliegue = "";
		for(int i = 0; i < escala.size(); i++){
			despliegue = despliegue +escala.elementAt(i)+"\n";
		}
		JOptionPane.showInternalMessageDialog(digiCliente.desktop, despliegue,"Escala",JOptionPane.INFORMATION_MESSAGE );
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
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"1"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"1"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"1");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"1"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"1");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"1"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton2){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"2"));
							}
							else if(jlTacheC.isEnabled() ==  false) {
								jtCantidad.setText(formatoKG(previo,"2"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"2");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"2"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"2");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"2"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton3){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"3"));
							}
							else if(jlTacheC.isEnabled() == false ) {
								jtCantidad.setText(formatoKG(previo,"3"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5")== -1){
									jtCantidad.setText(previo+"3");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"3"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"3");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"3"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton4){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"4"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"4"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"4");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"4"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"4");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"4"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton5){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"5"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"5"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"5");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"5"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"5");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"5"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton6){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"6"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"6"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"6");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"6"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"6");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"6"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton7){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"7"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"7"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"7");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"7"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"7");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"7"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton8){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"8"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"8"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"8");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"8"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"8");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"8"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton9){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"9"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"9"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"9");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"9"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"9");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"9"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBoton0){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC == null){
								jtCantidad.setText(formatoKG(previo,"0"));
							}
							else if(jlTacheC.isEnabled() == false) {
								jtCantidad.setText(formatoKG(previo,"0"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+"0");
								}
								else{
									jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"0"+".5" );
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+"0");
							}
							else{
								jtCantidad.setText(previo.substring(0, sb.indexOf(".5"))+"0"+".5" );
							}
						}
					}
				}
				else if(temporal == jlBotonMedio){
					String previo = jtCantidad.getText();
					if (previo.length() < 7){
						if(tipoProducto == 1 || tipoProducto == 4){
							if(jlTacheC.isEnabled()==false) {
								jtCantidad.setText(formatoKG(previo,"0"));
							}
							else{
								StringBuilder sb = new StringBuilder(previo);
								if (sb.indexOf(".5") == -1){
									jtCantidad.setText(previo+".5");
								}
							}
						}
						else{
							StringBuilder sb = new StringBuilder(previo);
							if (sb.indexOf(".5") == -1){
								jtCantidad.setText(previo+".5");
							}
						}
					}
				}
				else if(temporal == jlBorrar){
					jtCantidad.setText("");
				}
				else if(temporal == jlCancela){
					Cierra();
				}
				else if(temporal == jlAgregar){
					procesoAgrega();
				}
				else if(temporal == jlTacheC){
					jlTacheC.setEnabled(true);
					jlBotonMedio.setVisible(true);
					jlTacheU.setEnabled(false);
					jtCantidad.setText("");
					// Checo si se debe modificar el tipo de Unidad o KG
				}
				else if(temporal == jlTacheU){
					jlTacheC.setEnabled(false);
					jlTacheU.setEnabled(true);
					jlBotonMedio.setVisible(false);
					jtCantidad.setText("");
				}
				else if(temporal == jlEscalonado){
					procesoEscala();
				}
				else if(temporal == jlCambioE){
					procesoCambioExpress();
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
				else if(temporal == jlBotonMedio){
					jlBotonMedio.setIcon(iiBotonMP);
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
				else if(temporal == jlTacheC){
				}
				else if(temporal == jlTacheU){
				}
				else if(temporal == jlEscalonado){
					jlEscalonado.setIcon(iiEscalonadoP);
				}
				else if(temporal == jlCambioE){
					jlCambioE.setIcon(iiBotonCambioEP);
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
				else if(temporal == jlBotonMedio){
					jlBotonMedio.setIcon(iiBotonMN);
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
				else if(temporal == jlTacheC){
				}
				else if(temporal == jlTacheU){
				}
				else if(temporal == jlEscalonado){
					jlEscalonado.setIcon(iiEscalonadoN);
				}
				else if(temporal == jlCambioE){
					jlCambioE.setIcon(iiBotonCambioEN);
				}
			}
			catch(Exception q){
				q.printStackTrace();
			}
		}
	}

}