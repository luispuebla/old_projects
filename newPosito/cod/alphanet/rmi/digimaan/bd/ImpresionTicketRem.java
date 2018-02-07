package alphanet.rmi.digimaan.bd;

import java.net.URL;
import java.awt.Image;
import java.awt.Cursor;
import java.awt.Color;
import java.awt.MediaTracker;
import java.awt.Font;
import java.awt.font.*;

import java.awt.FontMetrics;
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
import java.text.*;

public class ImpresionTicketRem  implements Printable {

	private ConexionBD con = null;
	private ConexionBD con2 = null;
	protected Frame frame = new Frame();
	protected static Properties config;
	private String PRINTER_NAME= "";
	protected String identificador = "";
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
	private String tiendaN = "    Comercializadora  ";
	private String tienda = "   \" EL  POSITO \" ";
	private String direccion1 = "Pasillo 3 Letra I-J L-85,";
	private String direccion2 = " Central de Abasto ";
	private String direccion3 = "México, D.F. 09440 Tel, 5694-7059";
	private String fechaHoy= ts.date;
	private String titulo = "Cantidad                        P. Unitario       Importe";
	private String ticketPre = "Número Ticket:";
	private String ticket = "";
	private String elRFC = "";
	private String elNombre = "";
	private String laCalle = "";
	private String laDel = "";
	private String elCP = "";
	private String laCol = "";
	private String laCiudad = "";
	private String laRemision = "";
	private String laDireccion = "";
	private String laFrase = (mpv.dameFraseActual().trim());
	// Calculo 50 caracteres por renglon y el maximo son 200.
	// Asi que calculo el numero de renglones que corresponderan a la frase a imprimir.
	private String atendio = "";
	private String tiempoImpresion = "";
	private ResultSet rs = null;
	private String suma = "";
	protected int productosEnTicket = 0;
	protected int productosXHojas = 20;
	protected double cantidadHojas = 0.0;
	protected int espejoPagina = 0;
	protected Graphics2D g2d = null;
	//--- CREO MIS FUENTES
	protected Font normalFont = new Font ("serif", Font.BOLD, 8);
	protected Font petitFont = new Font ("Bodoni MT Condensed", Font.PLAIN, 11);
	protected Font boldFont = new Font ("serif", Font.BOLD, 10);
	protected Font nuevaProd = new Font("Agency FB", Font.BOLD, 10);
	protected Font nuevaTitulo = new Font("Agency FB", Font.BOLD, 16);
	protected Font preTitulo = new Font("Arial", Font.PLAIN, 9);
	//  PROPIEDADES DE ALTURA DE FUENTES:
	int nuevaTituloAscent= 0;
	int nuevaTituloDescent=0;
	int nuevaTituloLeading = 0;
	int preTituloAscent= 0;
	int preTituloDescent=0;
	int preTituloLeading = 0;
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

    public ImpresionTicketRem(int claveTicket, String identificador, int usuario) throws Exception {
		this.identificador = identificador;
		this.claveTicket = claveTicket;
		llenaDatosRemision( );
		rs = listadoProductosImpresion2();
		ticket = "Número de Ticket: #" +claveTicket;
		suma = mpv.sumaPagoProductosFin(claveTicket);
		atendio = "Atendio: "+mpv.dameNombreTendero(claveTicket);
		tiempoImpresion = "Hora: "+ts.time;
		productosEnTicket = mpv.getResultSetSize(rs);
		rs.beforeFirst();
		cantidadHojas = ((double)productosEnTicket / productosXHojas);
		for(int i = 1; i <= 2; i ++){
			ProcesoImprime();
		}
		cierraConexion();
	}


	public void llenaDatosRemision() throws SQLException, Exception{
		ResultSet rs = null;
		con = new ConexionBD( );
		if(con != null){
			try{
				String query = "SELECT clientes.rfc, clientes.nombre, clientes.direccion, clientes.delegacion, clientes.colonia, clientes.cp, clientes.ciudad, ticket_ligado.ID_Liga FROM ticket_ligado, clientes WHERE ticket_ligado.numTicket = "+claveTicket +" AND (clientes.rfc = ticket_ligado.rfc AND clientes.nombre = ticket_ligado.nombre AND clientes.activo = 1) LIMIT 1";
				Statement stmt = con.creaStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()){
					elRFC = rs.getString("rfc");
					elNombre = rs.getString("nombre");
					laCalle = rs.getString("direccion");
					laDel = rs.getString("delegacion");
					elCP = rs.getString("cp");
					laCol = rs.getString("colonia");
					laCiudad = rs.getString("ciudad");
					laRemision = rs.getString("ID_Liga");
				}
				rs.close();
				stmt.close();
				if(laCalle.trim().length() > 0){
					laDireccion = laCalle;
				}
				if(laCol.trim().length() > 0){
					laDireccion +=", Col. "+laCol;
				}
				if(laDel.trim().length() > 0){
					laDireccion +=", Del. "+laDel;
				}
				if(elCP.trim().length() > 0){
					laDireccion +=", C.P. "+elCP;
				}
				if(laCiudad.trim().length() > 0){
					laDireccion +=", "+laCiudad;
				}
			}
			catch(SQLException sqle){
				sqle.printStackTrace();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				try{
					con.cierraConexion();
				}
				catch(Exception q){
					q.printStackTrace();
				}
			}
		}
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
		g2d.setFont(preTitulo);
		preTituloAscent=g2d.getFontMetrics().getAscent();
		preTituloDescent=g2d.getFontMetrics().getDescent();
		preTituloLeading = g2d.getFontMetrics().getLeading();
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
		double width = pageFormat.getImageableWidth () -2;
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
		g2d.drawImage (image,0,15, (int) (0.878 * POINTS_PER_INCH),  61, frame);
		//--- Creo el String inicial con la Fecha y Numero de Ticket.
		// Inicializo mi punto para realizar los trazos, mando imprimir "La tienda"
		Point2D.Double pen = new Point2D.Double (1.125 * POINTS_PER_INCH , 5);
		g2d.setFont (preTitulo);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		pen.y += preTituloAscent+preTituloAscent+preTituloAscent;
		g2d.drawString (tiendaN, (int)pen.getX(),(int) pen.getY());
		pen.y += preTituloDescent-1;
		g2d.setFont (nuevaTitulo);
		pen.y += nuevaTituloAscent;
		g2d.drawString (tienda, (int)pen.getX(),(int) pen.getY());
		// ESTO SE REPITE PARA CADA RENGLON!:
		//--- Muevo la pluma a la siguiente coordinada, mando imprimir EL TICKET!
		pen.y += nuevaTituloDescent-2; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
		pen.x = (1.125 * POINTS_PER_INCH);
		g2d.setFont (preTitulo);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		pen.y += preTituloAscent;
		g2d.drawString (direccion1, (int)pen.getX(),(int) pen.getY());
		pen.y += preTituloDescent;
		pen.x = (1.125 * POINTS_PER_INCH);
		pen.y += preTituloAscent-2;
		g2d.drawString (direccion2, (int)pen.getX(),(int) pen.getY());
		pen.y += preTituloDescent-2;
		pen.x = (.900 * POINTS_PER_INCH);
		pen.y += preTituloAscent;
		g2d.drawString (direccion3, (int)pen.getX(),(int) pen.getY());
		pen.y += preTituloDescent;
		pen.x = (0);
		g2d.setFont (normalFont);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		pen.y += fontNormalAscent-1;
		pen.x = 72;
		g2d.drawString (ticket, (int)pen.getX(),(int) pen.getY());
		pen.y += fontNormalDescent+fontNormalLeading;
		g2d.drawRect (0,(int) pen.getY(),200,18);
		// Cambio mi letra.
		g2d.setFont (nuevaTitulo);
		pen.x = 2;
		pen.y += nuevaTituloAscent;
		g2d.drawString ("REMISIÓN: # "+laRemision, (int)pen.getX(),(int) pen.getY());
		g2d.setFont (nuevaProd);
		pen.x = (144);
		pen.y += -3;
		g2d.drawString (fechaHoy, (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent+nuevaProdLeading+4;
		pen.x = 0;
		g2d.setFont (normalFont);
		pen.y += fontNormalAscent;
		g2d.drawString ("Nombre:", (int)pen.getX(),(int) pen.getY());
		g2d.setFont (nuevaProd);
		pen.x = 5;
		pen.y += nuevaProdAscent;
		g2d.drawString (elNombre, (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent;
		pen.x = 0;
		g2d.setFont (normalFont);
		pen.y += fontNormalAscent;
		g2d.drawString ("Dirección:", (int)pen.getX(),(int) pen.getY());
		g2d.setFont (nuevaProd);
		pen.x = 5;
		AttributedString paragraphText = new AttributedString (laDireccion);
		// Escribo el tipo de letra y el atributo del que es tipo
		paragraphText.addAttribute (TextAttribute.FONT, nuevaProd);
		// Se crea la clase LineBreakMeasurer
		LineBreakMeasurer lineBreaker = new LineBreakMeasurer (paragraphText.getIterator(), new FontRenderContext (null, true, true));
		//--- Se crea el objeto TextLayout
		TextLayout layout;
		//--- LineBreakMeasurer se encarga automaticamente de segmentar el texto en lineas que quepan en mi ticket
		while ((layout = lineBreaker.nextLayout ((float) width)) != null) {
			pen.y += layout.getAscent ();
			// Dibujo la linea de Texto
			layout.draw (g2d, (float) pen.x, (float) pen.y);
			// Sumatoria de propiedades del tamaño de la fuente.
			pen.y += layout.getDescent () + layout.getLeading ();
		}
		pen.x = 0;
		g2d.setFont (normalFont);
		pen.y += fontNormalAscent;
		g2d.drawString ("RFC Cliente:", (int)pen.getX(),(int) pen.getY());
		g2d.setFont (nuevaProd);
		pen.x = 5;
		pen.y += nuevaProdAscent;
		g2d.drawString (elRFC, (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent;
		g2d.drawLine (0,(int) pen.getY(), 200,(int) pen.getY());
		// ESTO SE REPITE PARA CADA RENGLON!:
		//--- Muevo la pluma a la siguiente coordinada, mando imprimir TITULOS TICKET
		g2d.setFont (boldFont);
		pen.y +=  fontBoldAscent+2;
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
			pen.x = (95);
			g2d.drawString ("Total........ $ ", (int)pen.getX(),(int) pen.getY());
			pen.x = (154);
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
			pen.y += fontNormalDescent; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones=
			pen.y += fontNormalAscent;
			g2d.drawString (tiempoImpresion, (int)pen.getX(),(int) pen.getY());
			pen.y += fontNormalDescent + fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
			pen.x = (0);
			// Bajo mi coordinada de acuerdo a la altura de la letra.
			pen.y += fontNormalAscent;
			g2d.drawString ("   *********************************************", (int)pen.getX(),(int) pen.getY());
			pen.y += fontNormalLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
			n2t n2= new n2t();
			String leyendaPagare = new String("");
			leyendaPagare = "Por el presente pagaré reconozco y me obligo en esta ciudad o ";
			leyendaPagare += "en cualquier otra que se me requiera el pago a EL POSITO";
			leyendaPagare += " a su orden el día _________________ la cantidad ";
			leyendaPagare += "de: $"+mpv.formatoDinero(mpv.remueveComas(mpv.acortaLongitud(suma))) +" ("+n2.convertirLetras(Integer.parseInt(mpv.dameEnteros(mpv.remueveComas(mpv.acortaLongitud(suma)))))+" pesos  "+n2.dameDecimales(mpv.acortaLongitud(mpv.remueveComas(mpv.acortaLongitud(suma))))+"/100 m.n.)";
			leyendaPagare += " valor recibido en mercancía. Este  pagaré mercantil esta regido por la Ley General de Titulos y Operaciones ";
			leyendaPagare += "de Crédito en su artículo 173 parte final y demás correlativos por no ser pagaré domiciliado.";
			paragraphText = new AttributedString (leyendaPagare);
			// Escribo el tipo de letra y el atributo del que es tipo
			paragraphText.addAttribute (TextAttribute.FONT, petitFont);
			// Se crea la clase LineBreakMeasurer
			lineBreaker = new LineBreakMeasurer (paragraphText.getIterator(), new FontRenderContext (null, true, true));
			//--- Se crea el objeto TextLayout
			//--- LineBreakMeasurer se encarga automaticamente de segmentar el texto en lineas que quepan en mi ticket
			while ((layout = lineBreaker.nextLayout ((float) width)) != null) {
				pen.y += layout.getAscent ();
				// Dibujo la linea de Texto
				layout.draw (g2d, (float) pen.x, (float) pen.y);
				// Sumatoria de propiedades del tamaño de la fuente.
				pen.y += layout.getDescent () + layout.getLeading ()-3;
			}
			pen.y += 2;
			g2d.setFont (normalFont);
			pen.y += fontNormalAscent;
			g2d.drawString ("   **********************************************", (int)pen.getX(),(int) pen.getY());
		}
		else{
			g2d.drawString ("CONTINUA PAGARÉ ............", (int)pen.getX(),(int) pen.getY());
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