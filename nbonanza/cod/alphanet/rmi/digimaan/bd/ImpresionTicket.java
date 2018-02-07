package alphanet.rmi.digimaan.bd;

import java.net.URL;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Color;
import java.awt.MediaTracker;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.geom.Rectangle2D.Double;
import java.awt.geom.Rectangle2D;
import java.awt.geom.Point2D;
import java.net.MalformedURLException;
import java.awt.print.PrinterJob;
import java.awt.print.Printable;
import java.awt.print.PageFormat;
import java.awt.print.PrinterException;
import java.awt.print.Paper;
import java.sql.*;
import java.awt.Graphics2D;
import java.awt.Graphics;
import javax.print.attribute.standard.MediaPrintableArea;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import java.io.*;
import java.util.Properties;
import java.awt.Component;
import java.awt.Frame;
import java.util.Vector;

public class ImpresionTicket  implements Printable {

	private ConexionBD con = null;
	private ConexionBD con2 = null;
	protected Frame frame = new Frame();
	protected static Properties config;
	private String PRINTER_NAME= "";
	protected String identificador = "";
	// ESTOS TRES LOS USO PARA IMPRIMIR Y CALCULAR EL TAMAÑO:
	private int tamanioCantidad = 16;
	private	int tamanioTexto = 16;
	private	int tamanioPrecio = 16;
	private ManagerPuntoVenta mpv = new ManagerPuntoVenta();
	private TimeStamp ts = new TimeStamp();
	protected int POINTS_PER_INCH = 72;
	protected double INCH = 72.0;
	protected int renglonFrases = 0;
	protected int claveTicket = 0;
	protected String elTotal = "";
	protected int claveU = 0;
	protected final HashPrintRequestAttributeSet attrib = new HashPrintRequestAttributeSet();
// VARIABLES
	private String tienda = "La Nueva Bonanza";
	private String fechaHoy= ts.date;
	private String titulo = "Cantidad                 $ Unitario        $ Total";
	private String ticket = "";
	private String laFrase = (mpv.dameFraseActual().trim());
	// Calculo 50 caracteres por renglon y el maximo son 200.
	// Asi que calculo el numero de renglones que corresponderan a la frase a imprimir.
	private String atendio = "";
	private int anchoTotal = tamanioCantidad + tamanioTexto + tamanioPrecio +6;
	private ResultSet rs = null;
	private String suma = "";
	protected int productosEnTicket = 0;
	protected int productosXHojas = 25;
	protected double cantidadHojas = 0.0;
	protected int espejoPagina = 0;
	protected Graphics2D g2d = null;
	//--- CREO MIS FUENTES
	protected Font normalFont = new Font ("serif", Font.BOLD, 8);
	protected Font petitFont = new Font ("Courier New", Font.BOLD, 6);
	protected Font boldFont = new Font ("serif", Font.BOLD, 11);
	protected Font nuevaProd = new Font("Agency FB", Font.BOLD, 10);
	protected Font nuevaTitulo = new Font("Agency FB", Font.BOLD, 13);
	//  PROPIEDADES DE ALTURA DE FUENTES:
	int nuevaTituloAscent= 0;
	int nuevaTituloDescent=0;
	int nuevaTituloLeading = 0;
	int nuevaProdAscent=0;
	int nuevaProdDescent=0;
	int nuevaProdLeading =0;
	int fontBoldAscent=0;
	int fontBoldDescent=0;
	int fontBoldLeading = 0;
	int fontNormalAscent=0;
	int fontNormalDescent= 0;
	int fontNormalLeading = 0;
	int fontPetitAscent=0;
	int fontPetitDescent=0;
	int fontPetitLeading = 0;

    public ImpresionTicket(int claveTicket, String identificador, int usuario) throws Exception {
		this.identificador = identificador;
		this.claveTicket = claveTicket;
		rs = listadoProductosImpresion2();
		ticket = "Número de Ticket: " +claveTicket;
		suma = mpv.sumaPagoProductosFin(claveTicket);
		atendio = "Atendio: "+mpv.dameNombreTendero(claveTicket) +",  Hora: "+ts.time;
		productosEnTicket = mpv.getResultSetSize(rs);
		rs.beforeFirst();
		cantidadHojas = ((double)productosEnTicket / productosXHojas);
		ProcesoImprime();
		cierraConexion();
	}

/**
* El Método listadoProductosImpresion2  nos regresa los productos que conforman un numero de ticket
*  @return ResultSet con los detalle por producto.
*/
	public ResultSet listadoProductosImpresion2() throws SQLException, Exception{
		ResultSet rs = null;
		String query = "";
		try{
			query = ("SELECT  productos.descripcion, SUM(contenidoTicket.cantidadProducto) AS cantidadProducto, contenidoTicket.tipoVenta, contenidoTicket.precioVenta, SUM(contenidoTicket.precioAPagar) AS precioAPagar, SUM(contenidoticket.pesoEnPz) AS pesoEnPz FROM contenidoTicket, productos WHERE contenidoticket.numTicket = "+claveTicket +" AND productos.ID_Pro = contenidoTicket.ID_Pro AND contenidoTicket.estatusTicket = 1 GROUP BY contenidoTicket.ID_Pro,contenidoTicket.tipoVenta,contenidoTicket.tipoPrecio ORDER BY productos.descripcion");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicket, listadoProductosImpresion2 ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicket, listadoProductosImpresion2 ");
			e.printStackTrace();
		}
		return rs;
	}

	public void cierraConexion() throws Exception{
		if(con != null){
			try{
				con.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ImpresionTicket, cierraConexion ");
				q.printStackTrace();
			}
		}
	}


	public void ProcesoImprime () throws Exception{
		PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null);
		int idService = -1;
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			PRINTER_NAME=config.getProperty(identificador.trim());
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
//System.out.println("Y es: " +PRINTER_NAME);
		for(int i = 0; i<services.length;i++){
//System.out.println("Encontro: " +services[i].getName());
			if(services[i].getName().equalsIgnoreCase(PRINTER_NAME)){
//System.out.println("Lo encontre!");
				idService = i;
			}
		}
	try{
			PrinterJob pj = PrinterJob.getPrinterJob();
			pj.setPrintable(this);
			pj.setPrintService(services[idService]);
			attrib.add(new MediaPrintableArea(0.15f, 0.15f, 8.50f,11.00f , MediaPrintableArea.INCH));
			pj.print(attrib);
		}
		catch (Exception PrintException){
			PrintException.printStackTrace();
		}
	}

	public int print (Graphics g, PageFormat pageFormat, int page) throws PrinterException  {
		// CHECO QUE NO PASE DE LAS HOJAS ACORDADAS A IMPRIMIR....
		if(page>= (int)Math.ceil(cantidadHojas)) {
			return NO_SUCH_PAGE;
		}
		//--- creacion de un objeto Graphics2 para desplegar mis elementos.
		g2d = (Graphics2D) g;
		// EXTRAIGO PROPIEDADES DE ALTURA DE MIS FUENTES:
		g2d.setFont(nuevaTitulo);
		nuevaTituloAscent=g2d.getFontMetrics().getAscent();
		nuevaTituloDescent=g2d.getFontMetrics().getDescent();
		nuevaTituloLeading = g2d.getFontMetrics().getLeading();
		g2d.setFont(nuevaProd);
		nuevaProdAscent=g2d.getFontMetrics().getAscent();
		nuevaProdDescent=g2d.getFontMetrics().getDescent();
		nuevaProdLeading = g2d.getFontMetrics().getLeading();
		g2d.setFont(boldFont);
		fontBoldAscent=g2d.getFontMetrics().getAscent();
		fontBoldDescent=g2d.getFontMetrics().getDescent();
		fontBoldLeading = g2d.getFontMetrics().getLeading();
		g2d.setFont(normalFont);
		fontNormalAscent=g2d.getFontMetrics().getAscent();
		fontNormalDescent=g2d.getFontMetrics().getDescent();
		fontNormalLeading = g2d.getFontMetrics().getLeading();
		g2d.setFont(petitFont);
		fontPetitAscent=g2d.getFontMetrics().getAscent();
		fontPetitDescent=g2d.getFontMetrics().getDescent();
		fontPetitLeading = g2d.getFontMetrics().getLeading();
		// Muevo ResultSet de acuerdo a donde debe ir:
		if(espejoPagina == page){
			int posicional = 0;
			try{
				rs.beforeFirst();
			}
			catch (SQLException sql2){
				sql2.printStackTrace();
			}
			for (int i = 0; i< espejoPagina; i++){
				while (posicional < 25){
					try{
						rs.next();
					}
					catch (SQLException sql3){
						sql3.printStackTrace();
					}
					posicional++;
				}
				posicional = 0;
			}
		}
		else{
			espejoPagina = page;
		}
		if(laFrase.length() > 0){
			renglonFrases = 1;
		}
		//--- creacion de un objeto Graphics2 para desplegar mis elementos.
		g2d = (Graphics2D) g;
		g2d.setColor (Color.black);
		//--- Traslado el origen a mi punto (0,0)
		g2d.translate (pageFormat.getImageableX (), pageFormat.getImageableY ());
		// Dibujo el Logo del Retoñito:
		//--- Cargo la imagen en un mediatracker
		MediaTracker mt = new MediaTracker (frame);
		URL url = null;
		//--- Cargo en el  URL la direccion de mi imagen
		try {
			url= getClass().getResource("/imas/petitLogo.jpg");
		}
		catch (Exception me) {
			me.printStackTrace ();
		}
		//--- Espero a que haya cargado por completo la imagen
		Image image = Toolkit.getDefaultToolkit().getImage (url);
		mt.addImage (image, 0);
		try {
			mt.waitForID (0);
		}
		catch (InterruptedException e) {
		}
		//--- Dibujo la imagen en la parte superior izquierda
		g2d.drawImage (image,0,0, (int) (0.875 * POINTS_PER_INCH),  (int) (0.833 * POINTS_PER_INCH), frame);
		//--- Creo el String inicial con la Fecha y Numero de Ticket.
		// Inicializo mi punto para realizar los trazos, mando imprimir "La tienda"
		Point2D.Double pen = new Point2D.Double (0.819 * POINTS_PER_INCH +25, 15.35);
		g2d.setFont (nuevaTitulo);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		pen.y += nuevaTituloAscent;
		g2d.drawString (tienda, (int)pen.getX(),(int) pen.getY());
		// ESTO SE REPITE PARA CADA RENGLON!:
		//--- Muevo la pluma a la siguiente coordinada, mando imprimir EL TICKET!
		pen.y += nuevaTituloDescent +  nuevaTituloLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = (0.819 * POINTS_PER_INCH+30);
		// Cambio mi letra.
		g2d.setFont (normalFont);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		pen.y += fontNormalAscent;
		g2d.drawString (ticket, (int)pen.getX(),(int) pen.getY());
		// ESTO SE REPITE PARA CADA RENGLON!:
		//--- Muevo la pluma a la siguiente coordinada, mando imprimir LA FECHA!
		pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = (0.819 * POINTS_PER_INCH+44);
		// Cambio mi letra.
		g2d.setFont (normalFont);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		pen.y += fontNormalAscent;
		g2d.drawString (fechaHoy, (int)pen.getX(),(int) pen.getY());
		// ESTO SE REPITE PARA CADA RENGLON!:
		//--- Muevo la pluma a la siguiente coordinada, mando imprimir TITULOS TICKET
		g2d.setFont (boldFont);
		pen.y = ((int)(0.825 * POINTS_PER_INCH)) + fontBoldAscent;
		pen.x = 0;
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		g2d.drawString (titulo, (int)pen.getX(),(int) pen.getY());
		// ESTO SE REPITE PARA CADA RENGLON!:
		//--- Muevo la pluma a la siguiente coordinada, mando imprimir PRODUCTOS DEL TICKET!!!
		pen.y += fontBoldDescent; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		// Cambio mi letra.
		g2d.setFont (nuevaProd);
		boolean pasoPrimerProducto = false;
		//				pen.y += nuevaProdDescent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = 0;
		//				pen.y += nuevaProdAscent;
		g2d.drawString (" ____________________________________________________", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = 0;
		pen.y += nuevaProdAscent;
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		// ITERO TODOS LOS PRODUCTOS:
		int contadorInterno = 0;
		try{
			while(rs.next() && contadorInterno < 25){
				contadorInterno ++;
				if(pasoPrimerProducto){
					pen.y += nuevaProdDescent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.x = 0;
					pen.y += nuevaProdAscent;
				}
				else{
					pasoPrimerProducto = true;
				}
				String cantidad = rs.getString("cantidadProducto");
				int itipoUnidad = rs.getInt("tipoVenta");
				String precioVenta = rs.getString("precioVenta");
				String articulo = rs.getString("descripcion");
				String pagoA = rs.getString("precioAPagar");
				String pesoEnPz = rs.getString("pesoEnPz");
				g2d.drawString (articulo, (int)pen.getX(),(int) pen.getY());
				pen.y += nuevaProdDescent +  nuevaProdLeading;
				pen.x = 0;
				pen.y += nuevaProdAscent;
				if(itipoUnidad == 1){
					cantidad = cantidad+" Kg. ";
				}
				else if(itipoUnidad == 2){
					cantidad = mpv.dameEnteros(cantidad)+" Unidades";
				}
				else if (itipoUnidad == 3){
					cantidad = mpv.formatoMaxUnDecimal(cantidad)+" Cajas";
				}
				else{
					cantidad = mpv.formatoMaxUnDecimal(cantidad)+" Piezas -- ("+pesoEnPz+" Kg.)";
				}
				g2d.drawString (cantidad, (int)pen.getX(),(int) pen.getY());
				pen.x = (1.500 *  POINTS_PER_INCH);
				if(mpv.formatoDinero(mpv.acortaLongitud(precioVenta)).length() <= 6){
					pen.x += -2;
				}
				g2d.drawString (mpv.formatoEspaciado(mpv.formatoDinero(mpv.acortaLongitud(precioVenta))), (int)pen.getX(),(int) pen.getY());
				pen.x = (2.250 *  POINTS_PER_INCH);
				if(mpv.formatoDinero(mpv.acortaLongitud(pagoA)).length() <= 6){
					pen.x += -2;
				}
				g2d.drawString (mpv.formatoEspaciado(mpv.formatoDinero(mpv.acortaLongitud(pagoA))), (int)pen.getX(),(int) pen.getY());
			}
			rs.previous();
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
		catch (Exception e2){
			e2.printStackTrace();
		}
		//				pen.y += nuevaProdDescent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = 0;
		//				pen.y += nuevaProdAscent;
		g2d.drawString (" ____________________________________________________", (int)pen.getX(),(int) pen.getY());
		//				pen.y += nuevaProdDescent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = 0;
		//				pen.y += nuevaProdAscent;
		// ESTO SE REPITE PARA CADA RENGLON!:
		//--- Muevo la pluma a la siguiente coordinada, mando imprimir EL TOTAL!
		pen.y += fontBoldDescent +  fontBoldLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = (0);
		// Cambio mi letra.
		g2d.setFont (boldFont);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		pen.y += fontBoldAscent;
		if((page+1) == (int)Math.ceil(cantidadHojas)){
				pen.x = (POINTS_PER_INCH * 1.300);
				g2d.drawString ("Total........ $ ", (int)pen.getX(),(int) pen.getY());
				pen.x = (POINTS_PER_INCH * 2.100);
				if(mpv.formatoDinero(mpv.remueveComas(mpv.acortaLongitud(suma))).length() <= 6){
					pen.x += -3;
				}
				try{
					g2d.drawString (mpv.formatoEspaciado2(mpv.formatoDinero(mpv.remueveComas(mpv.acortaLongitud(suma)))), (int)pen.getX(),(int) 	pen.getY	());
				}
				catch(Exception e){
					e.printStackTrace();
				}
//			g2d.drawString (suma, (int)pen.getX(),(int) pen.getY());
			// ESTO SE REPITE PARA CADA RENGLON!:
			//--- Muevo la pluma a la siguiente coordinada, mando imprimir EL TENDERO!
			pen.y += fontBoldDescent +  fontBoldLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
			pen.x = (0);
			// Cambio mi letra.
			g2d.setFont (normalFont);
			// Bajo mi coordinada de acuerdo a la altura de la letra.
			pen.y += fontNormalAscent;
			g2d.drawString (atendio, (int)pen.getX(),(int) pen.getY());
			if(renglonFrases > 0)	{
				//--- Muevo la pluma a la siguiente coordinada, mando imprimir LA FRASE!
				pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
				pen.x = (0);
				// Bajo mi coordinada de acuerdo a la altura de la letra.
				pen.y += fontNormalAscent;
				g2d.drawString ("   **************************************************", (int)pen.getX(),(int) pen.getY());
				pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
				pen.y += fontNormalAscent;
				// VOY A DESPLEGAR MI DIRECCION TENIENDO COMO MAXIMO 70 LETRAS POR RENGLON:

				if(laFrase.length() <= 50){
					g2d.drawString (laFrase, (int)pen.getX(),(int) pen.getY());
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.x = 0;
					pen.y += fontNormalAscent;
				}
				else if (laFrase.length() > 50 && laFrase.length() <= 100) {
					String renglon1D = laFrase.substring(0,50);
					String renglon2D = "";
					int finaliza_en = renglon1D.trim().lastIndexOf(" ");
					if(finaliza_en != -1 && finaliza_en >= 40){
						renglon1D = laFrase.substring(0, finaliza_en);
						renglon2D = laFrase.substring(finaliza_en, laFrase.length());
					}
					else{
						renglon2D = laFrase.substring(51, laFrase.length());
					}
					g2d.drawString (renglon1D, (int)pen.getX(),(int) pen.getY());
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					pen.x = 0;
					g2d.drawString (renglon2D, (int)pen.getX(),(int) pen.getY());
					pen.x = 0;
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
				}
				else if (laFrase.length() > 100 && laFrase.length() <= 150) {
					String renglon1D = laFrase.substring(0,50);
					String renglon2D = "";
					String renglon3D = "";
					int finaliza_en1 = renglon1D.trim().lastIndexOf(" ");
					if(finaliza_en1 != -1 && finaliza_en1 >= 40){
						renglon1D = laFrase.substring(0, finaliza_en1);
						renglon2D = laFrase.substring(finaliza_en1, 100);
					}
					else{
						renglon2D = laFrase.substring(51, 100);
					}
					int finaliza_en2 = renglon2D.trim().lastIndexOf(" ");
					if(finaliza_en2 != -1 && finaliza_en2 >= 40){
						renglon2D = laFrase.substring(finaliza_en1, 51+finaliza_en2);
						renglon3D = laFrase.substring(51+finaliza_en2, laFrase.length());
					}
					else{
						renglon3D = laFrase.substring(101, laFrase.length());
					}
					g2d.drawString (renglon1D, (int)pen.getX(),(int) pen.getY());
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					pen.x = 0;
					g2d.drawString (renglon2D, (int)pen.getX(),(int) pen.getY());
					pen.x = 0;
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					g2d.drawString (renglon3D, (int)pen.getX(),(int) pen.getY());
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					pen.x = 0;
				}
				else if (laFrase.length() > 150 && laFrase.length() <= 200) {
					String renglon1D = laFrase.substring(0,50);
					String renglon2D = "";
					String renglon3D = "";
					String renglon4D = "";
					int finaliza_en1 = renglon1D.trim().lastIndexOf(" ");
					if(finaliza_en1 != -1 && finaliza_en1 >= 40){
						renglon1D = laFrase.substring(0, finaliza_en1);
						renglon2D = laFrase.substring(finaliza_en1, 100);
					}
					else{
						renglon2D = laFrase.substring(51, 100);
					}
					int finaliza_en2 = renglon2D.trim().lastIndexOf(" ");
					if(finaliza_en2 != -1 && finaliza_en2 >= 40){
						renglon2D = laFrase.substring(finaliza_en1, 51+finaliza_en2);
						renglon3D = laFrase.substring(51+finaliza_en2, 150);
					}
					else{
						renglon3D = laFrase.substring(101, 150);
					}
					int finaliza_en3 = renglon3D.trim().lastIndexOf(" ");
					if(finaliza_en3 != -1 && finaliza_en3 >= 40){
						renglon3D = laFrase.substring(51+finaliza_en2, 101+finaliza_en3);
						renglon4D = laFrase.substring(101+finaliza_en3, laFrase.length());
					}
					else{
						renglon4D = laFrase.substring(151, laFrase.length());
					}
					g2d.drawString (renglon1D, (int)pen.getX(),(int) pen.getY());
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					pen.x = 0;
					g2d.drawString (renglon2D, (int)pen.getX(),(int) pen.getY());
					pen.x = 0;
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					g2d.drawString (renglon3D, (int)pen.getX(),(int) pen.getY());
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					pen.x = 0;
					g2d.drawString (renglon4D, (int)pen.getX(),(int) pen.getY());
					pen.y += fontNormalDescent +  fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.y += fontNormalAscent;
					pen.x = 0;
				}
				g2d.drawString ("   **************************************************", (int)pen.getX(),(int) pen.getY());
			}
		}
		else{
			g2d.drawString ("CONTINUA ............", (int)pen.getX(),(int) pen.getY());
			pen.y += fontBoldDescent +  fontBoldLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
			pen.x = (0);
			// Cambio mi letra.
			g2d.setFont (boldFont);
			// Bajo mi coordinada de acuerdo a la altura de la letra.
			pen.y += fontBoldAscent;
		}
		return Printable.PAGE_EXISTS;
	}
}