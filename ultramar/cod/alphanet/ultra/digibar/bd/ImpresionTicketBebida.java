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


public class ImpresionTicketBebida implements Printable {

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
	String Tipo = "";
	int ContadorProductos = 0;
	protected int productosEnTicket = 0;
	protected int productosXHojas = 6;
	protected double cantidadHojas = 0.0;
	protected int espejoPagina = 0;
	protected Graphics2D g2d = null;
	protected int IDConsecutivo;
	protected ConexionBD con2 = null;
	protected ConexionBD con = null;


		public String dameNombreProducto(int claveProducto,int genero) throws SQLException, Exception{
			con = new ConexionBD();
			String nombre = "";
			try{
				ResultSet rs = null;
				String query = "";
				if(genero == 1) {
					query = "SELECT nombre FROM alimentos WHERE clave = "+claveProducto+" AND estatus = 1";
				}
				else{
					query ="SELECT nombre FROM bebidas WHERE clave = "+claveProducto+"  AND estatus = 1";
				}
				Statement stmt =  con.creaStatement();
				rs = stmt.executeQuery(query);
				while(rs.next()) {
					nombre = rs.getString("nombre");
				}
			}
			catch (SQLException sqle){
				System.out.println("Error de SQL en ImpresionTicketBebida, dameNombreProducto ");
				sqle.printStackTrace();
			}
			catch (Exception e){
				System.out.println("Ocurrio un Error en ImpresionTicketBebida, dameNombreProducto ");
				e.printStackTrace();
			}
			finally{
				if(con != null){
					try{
						con.cierraConexion();
					}
					catch (Exception q){
						System.out.println("Error al momento de cerrar conexion en ImpresionTicketBebida, dameNombreProducto ");
						q.printStackTrace();
					}
				}
			}
			return nombre;
		}

    public ImpresionTicketBebida(int IDComanda) throws Exception {
		this.IDComanda = IDComanda;
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
				System.out.println("Error al momento de cerrar conexion en ImpresionTicketBebida, ImpresionTicketBebida ");
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
			updateEstadoImpresion = con2.miConnection.prepareStatement ("UPDATE comandapro SET IDImpresion = ?  WHERE IDC = ? AND Tipo != 0");
			updateEstadoImpresion.setInt(1, 1);
			updateEstadoImpresion.setInt(2, IDComanda);
			updateEstadoImpresion.execute();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicketBebida, cambiaEstatusDeImpresion ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicketBebida, cambiaEstatusDeImpresion ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ImpresionTicketBebida, cambiaEstatusDeImpresion ");
					q.printStackTrace();
				}
			}
		}

	}


	public ResultSet listadosBebidas(int IDComanda) throws SQLException, Exception{
		con2 = new ConexionBD();
		ResultSet rs = null;
		try{
			int IDSecuencia = IDConsecutivo;
			String query = "SELECT (comandapro.IDC)AS IDComanda, (comanda.IDMM)AS Mesa,  bebidas.combinable, bebidas.dimensionable, CONCAT(empleados.Nombre COLLATE latin1_spanish_ci, ' ', empleados.APaterno COLLATE latin1_spanish_ci)AS Nombre, SUM(comandapro.CanPro)AS Cantidad, comandapro.Tipo, (bebidas.nombre)AS Producto, (comandapro.Ob)AS Observacion, (comandapro.DiA)AS Fecha, (comandapro.HR)AS Hora, (comandapro.TB) AS Tamanio, (comandapro.FB) AS Formato, (comandapro.MB) AS Mezcla, (comandapro.AB) AS Adicional, (comandapro.CA1) AS Cantidad1, (comandapro.CA2) AS Cantidad2, (comandapro.CA3) AS Cantidad3, (comandapro.CA4) AS Cantidad4, (comandapro.CB1) AS ClaveB1, (comandapro.CB2) AS ClaveB2, (comandapro.CB3) AS ClaveB3, (comandapro.CB4) AS ClaveB4, (comandapro.TB1) AS TipoBA1, (comandapro.TB2) AS TipoBA2, (comandapro.TB3) AS TipoBA3, (comandapro.TB4) AS TipoBA4 FROM comandapro, comanda, empleados, bebidas  WHERE comandapro.IDC = "+IDComanda +"  AND comandapro.IDImpresion = 0 AND (comandapro.Tipo = 1 OR comandapro.Tipo = 2 OR comandapro.Tipo = 3 OR comandapro.Tipo = 4) AND comandapro.Estatus = 1 AND comanda.IDC = comandapro.IDC AND empleados.IDEmpleado = comandapro.IDM AND bebidas.clave = comandapro.ClPro GROUP BY(CONCAT(comandapro.ClPro,comandapro.Tipo,comandapro.Ob,comandapro.TB,comandapro.FB,comandapro.MB,comandapro.AB, comandapro.CB1,comandapro.CB2,comandapro.CB3,comandapro.CB4,comandapro.TB1,comandapro.TB2,comandapro.TB3,comandapro.TB4))";
//			System.out.println(query);
			Statement stmt =  con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicketBebida, listadosBebidas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicketBebida, listadosBebidas ");
			e.printStackTrace();
		}
		return rs;
	}

	public void mandaImprimirAlimentos() throws Exception{
		rs = listadosBebidas(IDComanda);
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
				String tamanioB = "Sencillo";
				String formatoB = "Puesto";
				String mezclaB = "Normal";
				String adicionalB= "No";
				int redimensionable = 0;
				int combinable = 0;
				redimensionable=(rs.getInt("dimensionable"));
				combinable=(rs.getInt("combinable"));
				int tempAsigna1 = rs.getInt("Adicional");
				if (tempAsigna1 == 0){
					adicionalB = "No"; }
				else if(tempAsigna1==1){
					adicionalB = "C. Limón";}
				else if(tempAsigna1==2){
					adicionalB = "C. Sangrita";}
				else if(tempAsigna1==3){
					adicionalB = "C. Limón y C. Sangrita";}
				if(redimensionable == 1){
					int tempAsigna = rs.getInt("Tamanio");
					if (tempAsigna == 1){
						tamanioB = "Sencillo"; }
					else if(tempAsigna==2){
						tamanioB = "Doble";}
					else if(tempAsigna==3){
						tamanioB = "Triple";}
				}
				if(combinable==1){
					int tempAsigna = rs.getInt("Formato");
					if (tempAsigna == 1){
						formatoB = "Puesto"; }
					else if(tempAsigna==2){
						formatoB = "Divorciado";}
					else if(tempAsigna==3){
						formatoB = "Derecho";}
					else if(tempAsigna==4){
						formatoB = "Rocas";}
					else if(tempAsigna==5){
						formatoB = "Chasser";}
					tempAsigna = rs.getInt("Mezcla");
					if (tempAsigna == 1){
						mezclaB = "Ninguno"; }
					else if(tempAsigna==2){
						mezclaB = "Normal";}
					else if(tempAsigna==3){
						mezclaB = "Campechano";}
					else if(tempAsigna==4){
						mezclaB = "Pintado";}
				}
				if(rs.getString("tipo").equalsIgnoreCase("1")){
					Tipo = "Copa";
				}
				else if (rs.getString("tipo").equalsIgnoreCase("2")){
					Tipo = "Botella";
				}
				else if (rs.getString("tipo").equalsIgnoreCase("3")){
					Tipo = "Botella Grande";
				}
				else if (rs.getString("tipo").equalsIgnoreCase("4")){
					Tipo = "Botella Chica";
				}
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
				String observacion = rs.getString("Observacion");
				if(observacion.trim().length() > 0){
					hayObservacion = true;
				}
				String cantidad = rs.getString("Cantidad");
				g2d.drawString ("Cantidad:  "+cantidad, (int)pen.getX(),(int) pen.getY());
				pen.x +=(85);
				g2d.drawString ("Tipo:  "+Tipo, (int)pen.getX(),(int) pen.getY());
				pen.y += nuevaProdDescent +  nuevaProdLeading;
				pen.x = 5;
				pen.y += nuevaProdAscent;
				g2d.drawString ("BEBIDA: "+rs.getString("Producto"), (int)pen.getX(),(int) pen.getY());
				pen.y += nuevaProdDescent +  nuevaProdLeading;
				pen.x = 5;
				pen.y += nuevaProdAscent;
// Caso copa combinable
				if(redimensionable == 1 && Tipo.equalsIgnoreCase("Copa")){
					g2d.drawString ("Tamaño:  "+tamanioB, (int)pen.getX(),(int) pen.getY());
					pen.y += nuevaProdDescent +  nuevaProdLeading;
					pen.x = 5;
					pen.y += nuevaProdAscent;
				}
				if(combinable == 1 && Tipo.equalsIgnoreCase("Copa")){
					g2d.drawString ("Formato:  "+formatoB, (int)pen.getX(),(int) pen.getY());
					pen.x +=(90);
					g2d.drawString (", >Mezcla:  "+mezclaB, (int)pen.getX(),(int) pen.getY());
					pen.y += nuevaProdDescent +  nuevaProdLeading;
					pen.x = 5;
					pen.y += nuevaProdAscent;
				}
				if(!(adicionalB.equalsIgnoreCase("No"))){
					g2d.drawString ("Adicional:  "+adicionalB, (int)pen.getX(),(int) pen.getY());
					pen.y += nuevaProdDescent +  nuevaProdLeading;
					pen.x = 5;
					pen.y += nuevaProdAscent;
				}
				if(combinable == 1){
					pen.y += nuevaProdDescent;
					pen.x = 5;
					if(rs.getInt("ClaveB1") != 0){
						String tamanitoBC = "Mediano";
						if(rs.getInt("TipoBA1") == 4){
							tamanitoBC = "Chico";
						}
						g2d.drawString (" > "+rs.getInt("cantidad1")+" "+dameNombreProducto(rs.getInt("ClaveB1"),2)+" "+tamanitoBC, (int)pen.getX(),(int) pen.getY());
						pen.y += nuevaProdDescent +  nuevaProdLeading;
						pen.x = 5;
						pen.y += nuevaProdAscent;
					}
					if(rs.getInt("ClaveB2") != 0){
						String tamanitoBC = "Mediano";
						if(rs.getInt("TipoBA2") == 4){
							tamanitoBC = "Chico";
						}
						g2d.drawString (" > "+rs.getInt("cantidad2")+" "+dameNombreProducto(rs.getInt("ClaveB2"),2)+" "+tamanitoBC, (int)pen.getX(),(int) pen.getY());						pen.y += nuevaProdDescent +  nuevaProdLeading;
						pen.x = 5;
						pen.y += nuevaProdAscent;
					}
					if(rs.getInt("ClaveB3") != 0){
						String tamanitoBC = "Mediano";
						if(rs.getInt("TipoBA3") == 4){
							tamanitoBC = "Chico";
						}
						g2d.drawString (" > "+rs.getInt("cantidad3")+" "+dameNombreProducto(rs.getInt("ClaveB3"),2)+" "+tamanitoBC, (int)pen.getX(),(int) pen.getY());												pen.y += nuevaProdDescent +  nuevaProdLeading;
						pen.x = 5;
						pen.y += nuevaProdAscent;
					}
					if(rs.getInt("ClaveB4") != 0){
						String tamanitoBC = "Mediano";
						if(rs.getInt("TipoBA4") == 4){
							tamanitoBC = "Chico";
						}
						g2d.drawString (" > "+rs.getInt("cantidad4")+" "+dameNombreProducto(rs.getInt("ClaveB4"),2)+" "+tamanitoBC, (int)pen.getX(),(int) pen.getY());																		pen.y += nuevaProdDescent +  nuevaProdLeading;
						pen.x = 5;
						pen.y += nuevaProdAscent;
					}
				}
				if(hayObservacion){
					pen.x = 5;
					pen.y += nuevaProdAscent +  nuevaProdLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					g2d.drawString ("Nota: " +observacion, (int)pen.getX(),(int) pen.getY());
					pen.x = 0;
					pen.y += nuevaProdDescent;
				}
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
			g2d.drawString ("*************************************", (int)pen.getX(),(int) pen.getY());
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
			PRINTER_NAME=config.getProperty("imp_Bebidas").trim();
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