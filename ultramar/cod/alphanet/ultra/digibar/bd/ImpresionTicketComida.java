package alphanet.ultra.digibar.bd;

import java.net.URL;
import java.awt.Image;
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


public class ImpresionTicketComida implements Printable {

	protected static Properties config;
	private String PRINTER_NAME= "";

	private String claveProducto = new String("");
	// ESTOS TRES LOS USO PARA IMPRIMIR Y CALCULAR EL TAMAÑO:
	private ManagerPuntoVenta mpv = new ManagerPuntoVenta();
	protected int POINTS_PER_INCH = 72;
	protected final HashPrintRequestAttributeSet attrib = new HashPrintRequestAttributeSet();
	private ResultSet rs = null;
	//--- CREO MIS FUENTES
	protected Font nuevaProd = new Font("Agency FB", Font.BOLD, 13);
	//  PROPIEDADES DE ALTURA DE FUENTES:
	int nuevaProdAscent=0;
	int nuevaProdDescent=0;
	int nuevaProdLeading =0;
	int IDComanda = -1;
	boolean hayElementos = false;
	String IDMesa = "";
	String IDComandaS ="";
	String Solicito = "";
	String Hora = "";
	String Fecha = "";
	int ContadorProductos = 0;
	protected int productosEnTicket = 0;
	protected int productosXHojas = 8;
	protected double cantidadHojas = 0.0;
	protected int espejoPagina = 0;
	protected Graphics2D g2d = null;
	protected int IDConsecutivo;
	protected ConexionBD con = null;
	protected ConexionBD con2 = null;
	protected int claveBotana = 0;

    public ImpresionTicketComida(int IDComanda) throws Exception {
		this.IDComanda = IDComanda;
		claveBotana= mpv.cambiaAInt(mpv.dameLaClaveDeBotana());
		mandaImprimirAlimentos();
		if(hayElementos){
			cantidadHojas = ((double)ContadorProductos / productosXHojas);
			ProcesoImprime();
		}
		if(con2 != null){
			try{
				con2.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameNombreProducto ");
				q.printStackTrace();
			}
		}
		if(hayElementos){
			cambiaEstatusDeImpresion();
		}
	}


	public void cambiaEstatusDeImpresion () throws SQLException, Exception{
		con2 = new ConexionBD();
		try{
			PreparedStatement updateEstadoImpresion;
			updateEstadoImpresion = con2.miConnection.prepareStatement ("UPDATE comandapro SET IDImpresion = ?  WHERE IDC = ? AND Tipo = 0");
			updateEstadoImpresion.setInt(1, 1);
			updateEstadoImpresion.setInt(2, IDComanda);
			updateEstadoImpresion.execute();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicketComida, cambiaEstatusDeImpresion ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicketComida, cambiaEstatusDeImpresion ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ImpresionTicketComida, cambiaEstatusDeImpresion ");
					q.printStackTrace();
				}
			}
		}
	}

	public String dameElNombreMP (int claveMP) throws SQLException, Exception{
		con = new ConexionBD();
		ResultSet rs = null;
		String elNombreMP = "";
		try{
			int IDSecuencia = IDConsecutivo;
			String query = "SELECT nombre FROM materiaprima WHERE clave = "+claveMP +" AND Estatus = 1";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				elNombreMP = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicketComida, dameElNombreMP ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicketComida, dameElNombreMP ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ImpresionTicketComida, dameElNombreMP ");
					q.printStackTrace();
				}
			}
		}
		return elNombreMP;
	}

	public ResultSet listadoAlimentos(int IDComanda) throws SQLException, Exception{
		con2 = new ConexionBD();
		ResultSet rs = null;
		try{
			int IDSecuencia = IDConsecutivo;
			String query = "SELECT (comandapro.IDC)AS IDComanda, (comanda.IDMM)AS Mesa, CONCAT(empleados.Nombre COLLATE latin1_spanish_ci, ' ',  empleados.APaterno COLLATE latin1_spanish_ci)AS Nombre, SUM(comandapro.CanPro)AS Cantidad, (alimentos.nombre)AS Producto, (comandapro.Ob)AS Observacion,(comandapro.Di)AS Division, (comandapro.CB1) AS ClaveB1, (comandapro.CB2) AS ClaveB2, (comandapro.CB3) AS ClaveB3, (comandapro.CB4) AS ClaveB4, (comandapro.DiA)AS Fecha, (comandapro.HR)AS Hora FROM comandapro, comanda, empleados, alimentos WHERE comandapro.IDC = "+IDComanda +" AND comandapro.IDImpresion = 0 AND comandapro.Tipo = 0 AND comandapro.Estatus = 1 AND comanda.IDC = comandapro.IDC AND empleados.IDEmpleado = comandapro.IDM AND alimentos.clave = comandapro.ClPro GROUP BY CONCAT(comandapro.ClPro,comandapro.Ob,comandapro.CB1,comandapro.CB2,comandapro.CB3,comandapro.CB4)";
			Statement stmt =  con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicketComida, listadoAlimentos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicketComida, listadoAlimentos ");
			e.printStackTrace();
		}
		return rs;
	}

	public void mandaImprimirAlimentos() throws Exception{
		rs = listadoAlimentos(IDComanda);
		while(rs.next()){
			ContadorProductos ++;
			hayElementos = true;
			IDMesa = rs.getString("Mesa");
			IDComandaS = rs.getString("IDComanda");
			Solicito = rs.getString("Nombre");
			Hora = rs.getString("Hora");
			Fecha = rs.getString("Fecha");
		}
		rs.beforeFirst();
	}


	public int print (Graphics g, PageFormat pageFormat, int page) throws PrinterException  {
		// CHECO QUE NO PASE DE LAS HOJAS ACORDADAS A IMPRIMIR....
		if(page>= (int)Math.ceil(cantidadHojas)) {
			return NO_SUCH_PAGE;
		}
		//--- creacion de un objeto Graphics2 para desplegar mis elementos.
		g2d = (Graphics2D) g;
		// EXTRAIGO PROPIEDADES DE ALTURA DE MIS FUENTES:
		g2d.setFont(nuevaProd);
		nuevaProdAscent=g2d.getFontMetrics().getAscent();
		nuevaProdDescent=g2d.getFontMetrics().getDescent();
		nuevaProdLeading = g2d.getFontMetrics().getLeading();
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
				while (posicional < productosXHojas){
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
		//--- creacion de un objeto Graphics2 para desplegar mis elementos.
		g2d = (Graphics2D) g;
		g2d.setColor (Color.black);
		// Inicializo mi punto para realizar los trazos, mando imprimir "El retoño"
		Point2D.Double pen = new Point2D.Double (0, 0);
		g2d.setFont (nuevaProd);
		g2d.translate (pageFormat.getImageableX (), pageFormat.getImageableY ());
		g2d.drawString (" ________________________________________", (int)pen.getX(),(int) pen.getY());
		//--- Muevo la pluma a la siguiente coordinada
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 5;
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		try{
			g2d.drawString ("Mesa: "+mpv.cambiaANombreBarra(IDMesa), (int)pen.getX(),(int) pen.getY());
			pen.x +=(85);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		g2d.drawString ("Comanda #: "+IDComandaS, (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 5;
		g2d.drawString ("Solicitó: "+Solicito, (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent;
		pen.x = 0;
		g2d.drawString (" ________________________________________", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 5;
		// IMPRIMO LOS PRODUCTOS SOLICITADOS.
		boolean pasoPrimerProducto = false;
		int contadorInterno = 0;
		try{
			while(rs.next() && contadorInterno < productosXHojas){
				contadorInterno ++;
				if(pasoPrimerProducto){
					pen.y += nuevaProdDescent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.x = 5;
					pen.y += nuevaProdAscent;
				}
				else{
					pasoPrimerProducto = true;
				}
				boolean hayObservacion = false;
				boolean esBotana = false;
				String observacion = rs.getString("Observacion");
				if(observacion.trim().length() > 0){
					hayObservacion = true;
				}
				if(claveBotana==rs.getInt("Division")){
					esBotana = true;
				}
				String cantidad = rs.getString("Cantidad");
				g2d.drawString ("Cantidad:  "+cantidad, (int)pen.getX(),(int) pen.getY());
				pen.y += nuevaProdDescent +  nuevaProdLeading;
				pen.x = 5;
				pen.y += nuevaProdAscent;
				g2d.drawString (rs.getString("Producto"), (int)pen.getX(),(int) pen.getY());
				pen.y += nuevaProdDescent;
				pen.x = 0;
				if(esBotana){
					pen.x = 35;
					pen.y += nuevaProdAscent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					g2d.drawString ("CONFORMADA POR: ", (int)pen.getX(),(int) pen.getY());
					if(rs.getInt("ClaveB1") != 0){
						pen.x = 15;
						pen.y += nuevaProdAscent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
						g2d.drawString ("> "+dameElNombreMP(rs.getInt("ClaveB1")), (int)pen.getX(),(int) pen.getY());
					}
					if(rs.getInt("ClaveB2") != 0){
						pen.x = 15;
						pen.y += nuevaProdAscent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
						g2d.drawString ("> "+dameElNombreMP(rs.getInt("ClaveB2")), (int)pen.getX(),(int) pen.getY());
					}
					if(rs.getInt("ClaveB3") != 0){
						pen.x = 15;
						pen.y += nuevaProdAscent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
						g2d.drawString ("> "+dameElNombreMP(rs.getInt("ClaveB3")), (int)pen.getX(),(int) pen.getY());
					}
					if(rs.getInt("ClaveB4") != 0){
						pen.x = 15;
						pen.y += nuevaProdAscent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
						g2d.drawString ("> "+dameElNombreMP(rs.getInt("ClaveB4")), (int)pen.getX(),(int) pen.getY());
					}
				}
				if(hayObservacion){
					pen.x = 5;
					pen.y += nuevaProdAscent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					g2d.drawString ("Nota: "+observacion, (int)pen.getX(),(int) pen.getY());
					pen.x = 0;
					pen.y += nuevaProdDescent;
				}
				pen.x = 0;
				g2d.drawString (" _____________________________________________", (int)pen.getX(),(int) pen.getY());
			}
			rs.previous();
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
		catch (Exception e2){
			e2.printStackTrace();
		}
		if((page+1) == (int)Math.ceil(cantidadHojas)){
			pen.y += nuevaProdDescent +  nuevaProdLeading;
			pen.x = 10;
			pen.y += nuevaProdAscent;
			g2d.drawString ("Fecha: "+Fecha, (int)pen.getX(),(int) pen.getY());
			pen.x +=(95);
			g2d.drawString ("Hora: "+Hora, (int)pen.getX(),(int) pen.getY());
			pen.y += nuevaProdDescent+nuevaProdAscent;
			pen.x = 0;
			g2d.drawString ("***************************************", (int)pen.getX(),(int) pen.getY());
		}
		else{
			pen.y += nuevaProdDescent +  nuevaProdLeading;
			pen.x = 0;
			pen.y += nuevaProdAscent;
			g2d.drawString ("CONTINUA ............", (int)pen.getX(),(int) pen.getY());
			pen.y += nuevaProdDescent +  nuevaProdLeading;
			pen.x = 0;
			pen.y += nuevaProdAscent;
		}
		return Printable.PAGE_EXISTS;
	}



	public void ProcesoImprime () throws Exception{
		PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null);
		int idService = -1;
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			PRINTER_NAME=config.getProperty("imp_Alimentos").trim();
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		for(int i = 0; i<services.length;i++){
			if(services[i].getName().equalsIgnoreCase(PRINTER_NAME)){
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
}