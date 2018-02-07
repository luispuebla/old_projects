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
import java.awt.Component;
import java.awt.Frame;
import java.util.Vector;

public class ImpresionTicketComandaT implements Printable {

	protected Frame frame = new Frame();
	protected static Properties config;
	private String PRINTER_NAME= "";
//	protected final Component component = Component.getComponentAt(0,0) ;
	private String claveProducto = new String("");
	// ESTOS TRES LOS USO PARA IMPRIMIR Y CALCULAR EL TAMAÑO:
	private ManagerPuntoVenta mpv = new ManagerPuntoVenta();
	protected int POINTS_PER_INCH = 72;
	protected final HashPrintRequestAttributeSet attrib = new HashPrintRequestAttributeSet();
	private ResultSet rs = null;
	//--- CREO MIS FUENTES
	protected Font nueva = new Font("Agency FB", Font.BOLD, 15);
	protected Font nuevaProd = new Font("Agency FB", Font.BOLD, 12);
	protected Font nuevaProd2 = new Font("Agency FB", Font.BOLD, 13);
	protected Font prod = new Font("Agency FB", Font.PLAIN, 11);
	//  PROPIEDADES DE ALTURA DE FUENTES:
	int nuevaProdAscent=0;
	int nuevaProdDescent=0;
	int nuevaProdLeading =0;
	int nuevaProdAscent2=0;
	int nuevaProdDescent2=0;
	int nuevaProdLeading2 =0;
	int prodAscent=0;
	int prodDescent=0;
	int prodLeading =0;
	int IDComanda = -1;
	boolean hayElementos = false;
	int  IDMesa = 0;
	String Empleado = "";
	TimeStamp tiempo;
	String Hora = "";
	String Fecha = "";
	String Tipo = "";
	String Cantidad = "";
	String PagoTotal = "";
	String PagoSubtotal = "";
	String PagoIVA = "";
	double Descuento = 0.00;
	String NumComensales = "";
	int ContadorProductos = 0;
	protected int productosEnTicket = 0;
	protected int productosXHojas = 25;
	protected double cantidadHojas = 0.0;
	protected int espejoPagina = 0;
	protected Graphics2D g2d = null;
	protected int IDConsecutivo;
	protected ConexionBD con2 = null;
	protected ConexionBD con1 = null;
	protected final int numeroDeCopasXBotanaGratis = 3;

    public ImpresionTicketComandaT (int IDMesa) throws Exception {
		this.IDMesa = IDMesa;
		mandaImprimirTicketCT();
		if(hayElementos){
			tiempo = new TimeStamp();
			Hora = tiempo.time;
			Fecha = tiempo.date;
			cantidadHojas = ((double)ContadorProductos / productosXHojas);
			ProcesoImprime();
			CierraConexion2();
		}
	}

	public void mandaImprimirTicketCT() throws Exception{
		validaReglas();
		ajustaDescuentos();
		rs = dameDatosComanda();
		while(rs.next() ){
			IDComanda = rs.getInt("IDC");
			Empleado = rs.getString("Nombre");
			double subtotal = 0.00;
			double iva = 0.00;
			double total = 0.00;
			subtotal = ((rs.getDouble("PT")*100)/115);
			subtotal = mpv.cambiaADouble(mpv.formatoCortoDinero(subtotal+""));
			iva = subtotal * 0.15;
			iva = mpv.cambiaADouble(mpv.formatoCortoDinero(iva+""));
			total = iva + subtotal - Descuento;
			total = mpv.cambiaADouble(mpv.formatoCortoDinero(total+""));
			PagoSubtotal = mpv.formatoDinero(mpv.acortaLongitud(subtotal+""));
			PagoIVA = mpv.formatoDinero(mpv.acortaLongitud(iva+""));
			PagoTotal = mpv.formatoDinero(mpv.acortaLongitud((rs.getDouble("PT")+"")));
			NumComensales = rs.getString("NC");
		}
		CierraConexion1();
		rs = listadoComanda();
		ContadorProductos = mpv.getResultSetSize(rs);
		if(ContadorProductos > 0){
			hayElementos = true;
		}
		rs.beforeFirst();
	}



	public void ajustaDescuentos() throws SQLException, Exception{
		con1 = new ConexionBD();
		con1.cancelaAutoCommit();
		boolean existeDescuento = false;
		int laComanda = 0;
		double totalGlobal = 0.00;
		try{
			ResultSet rs = null;
			String dameProductosTotal = "SELECT SUM(comandapro.PT)AS total, comandapro.IDC FROM comandapro, comanda WHERE comanda.IDMM = "+IDMesa +" AND comandapro.IDC = comanda.IDC AND Estatus = 1 GROUP BY (comandapro.IDC)";
			Statement stmt3 = con1.creaStatement();
			rs = stmt3.executeQuery(dameProductosTotal);
			while(rs.next()){
				laComanda = rs.getInt("IDC");
				totalGlobal = rs.getDouble("total");
			}
			PreparedStatement updateSumaTotal;
			updateSumaTotal = con1.miConnection.prepareStatement("UPDATE comanda SET PT = ? WHERE IDC = ?");
			updateSumaTotal.setDouble(1, totalGlobal);
			updateSumaTotal.setInt(2, laComanda);
			updateSumaTotal.execute();
			ResultSet rsDescuentos = null;
			String queryHayDescuentos = "SELECT DISTINCT descuentos.comanda, descuentos.numComensal, descuentos.porcentaje FROM descuentos, comanda, comandapro WHERE comanda.IDMM = "+IDMesa +" AND comanda.Es = 1 AND descuentos.comanda = comanda.IDC ORDER BY(descuentos.numComensal)";
			Statement stmt = con1.creaStatement();
			rsDescuentos = stmt.executeQuery(queryHayDescuentos);
			while(rsDescuentos.next()){
				laComanda = rsDescuentos.getInt("comanda");
				existeDescuento = true;
			}
			if(!existeDescuento){
				Descuento = 0.00;
			}
			else{
				rsDescuentos.beforeFirst();
				int descPorc = 0;
				ResultSet rsInterno = null;
				while(rsDescuentos.next()){
					descPorc = rsDescuentos.getInt("porcentaje");
					String dameProductosXComensal = "SELECT SUM(PT)AS total FROM comandapro WHERE IDC = "+laComanda +" AND IDCom = "+rsDescuentos.getInt("numComensal") +" AND Estatus = 1";
					Statement stmt2 = con1.creaStatement();
					rsInterno = stmt2.executeQuery(dameProductosXComensal);
					double totalComensal = 0.00;
					while(rsInterno.next()){
						totalComensal = rsInterno.getDouble("total");
					}
// QUITO EL IVA
//					totalComensal = ((totalComensal*100)/115);
// HAGO DESCUENTO
					totalComensal = ((totalComensal*descPorc)/100);
					Descuento += totalComensal;
// ACTUALIZO COMANDA TOTAL
					PreparedStatement updateSumaFinal;
					updateSumaFinal = con1.miConnection.prepareStatement("UPDATE comanda SET PT = (PT - ?) WHERE IDC = ?");
					updateSumaFinal.setDouble(1, totalComensal);
					updateSumaFinal.setInt(2, laComanda);
					updateSumaFinal.execute();
				}
			}
			con1.realizaCommit();
		}
		catch (SQLException sqle){
			con1.realizaRollback();
			System.out.println("Error de SQL en ImpresionTicketXComensal, ajustaDescuentos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			con1.realizaRollback();
			System.out.println("Ocurrio un Error en ImpresionTicketXComensal, ajustaDescuentos ");
			e.printStackTrace();
		}
		finally{
			if(con1 != null){
				try{
					con1.realizaCommit();
					con1.habilitaAutoCommit();
					con1.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ImpresionTicketXComensal, ajustaDescuentos ");
					q.printStackTrace();
				}
			}
		}
	}



// Con este metodo valido mis reglas (Ejem botanas X Bebidas).
	public void validaReglas() throws SQLException, Exception{
		con1 = new ConexionBD();
		con1.cancelaAutoCommit();
		int cantidadBotanas = 0;
		int cantidadBotanasGratis = 0;
		int cantidadBotellaG = 0;
		int cantidadBotellaM = 0;
		int cantidadCopas = 0;
		int botanasACondonar = 0;
		int botanasYaCondonadas = 0;
		String laClaveDeBotana = "";
		laClaveDeBotana = mpv.dameLaClaveDeBotana();
		try{
			ResultSet rsCantidadAlcohol = null;
			ResultSet rsCantidadBotanas = null;
// Solicito la cantidad de alcohol consumida para esta cuenta...
			String queryChupes = "SELECT comandapro.CanPro AS Cantidad, comandapro.Tipo, comandapro.TB FROM bebidas, comandapro, comanda WHERE comanda.IDMM = "+IDMesa +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 2 AND comandapro.Estatus = 1 AND bebidas.clave =  comandapro.ClPro AND bebidas.alcoholica = 1 ";
			Statement stmt =  con1.creaStatement();
			rsCantidadAlcohol = stmt.executeQuery(queryChupes);
			while(rsCantidadAlcohol.next()){
				if(rsCantidadAlcohol.getInt("Tipo") == 1){
					cantidadCopas += (rsCantidadAlcohol.getInt("Cantidad") * rsCantidadAlcohol.getInt("TB"));
				}
				else if(rsCantidadAlcohol.getInt("Tipo") == 2){
					cantidadBotellaG += rsCantidadAlcohol.getInt("Cantidad");
				}
				else if(rsCantidadAlcohol.getInt("Tipo") == 3){
					cantidadBotellaG += rsCantidadAlcohol.getInt("Cantidad");
				}
				else if(rsCantidadAlcohol.getInt("Tipo") == 4){
					cantidadBotellaM += rsCantidadAlcohol.getInt("Cantidad");
				}
			}
			cantidadCopas = cantidadCopas/numeroDeCopasXBotanaGratis;
			cantidadBotellaG = cantidadBotellaG *5;
			cantidadBotellaM = cantidadBotellaM *4;
//			System.out.println("CantidadCopas: "+cantidadCopas +",CantidadBotellasG:"+cantidadBotellaG +", CantidadBotellaM:"+cantidadBotellaM);
			cantidadBotanasGratis = cantidadCopas+cantidadBotellaG+cantidadBotellaM;
// Averiguo cuantas botanas me solicitaron
			String queryBotanasPedidas = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = "+IDMesa +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.Estatus = 1";
			Statement stmt2 =  con1.creaStatement();
			rsCantidadBotanas = stmt2.executeQuery(queryBotanasPedidas);
			while(rsCantidadBotanas.next()){
				cantidadBotanas = rsCantidadBotanas.getInt("Botanas");
			}
//			System.out.println("Cantidad Botanas Gratis: " +cantidadBotanasGratis);
//			System.out.println("Cantidad de Botanas Pedidas: " +cantidadBotanas);
			botanasACondonar = cantidadBotanasGratis;
//			System.out.println("Botanas a Perdonar:" +botanasACondonar);
			ResultSet rsBotanasYaCondonadas = null;
// Ahora averiguo cuantas ya han sido condonadas...
			String queryPerdonadas = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " +IDMesa +"  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.Estatus = 1 AND comandapro.PT = 0.00";
			Statement stmt3 =  con1.creaStatement();
			rsBotanasYaCondonadas = stmt3.executeQuery(queryPerdonadas);
			while(rsBotanasYaCondonadas.next()){
				botanasYaCondonadas = rsBotanasYaCondonadas.getInt("Botanas");
			}
//			System.out.println("Botanas ya Perdonadas Anteriormente:" +botanasYaCondonadas);

// Voy a perdonar botanas....
// Primero averiguo, si tengo más botanas perdonadas de las que tienen derecho puede ser que sea debido a que condono directamente en Sistema.
			if(botanasACondonar < botanasYaCondonadas){
				botanasACondonar = botanasYaCondonadas;
			}
// Ahora voy a revisar si me alcanza para cubrir todas las botanas..., si si guardo directamente, de no ser así discrimino por Comensal.
			if(botanasYaCondonadas != botanasACondonar){
				int claveDeProducto = 0;
				String queryDimeCP = "SELECT DISTINCT (comandapro.ClPro)AS Clave FROM comandapro, comanda WHERE comanda.IDMM = "+ IDMesa +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.Estatus = 1 ";
				ResultSet rsPetit = null;
				Statement stmt4 =  con1.creaStatement();
				rsPetit = stmt4.executeQuery(queryDimeCP);
				while(rsPetit.next()){
					claveDeProducto = rsPetit.getInt("Clave");
				}
				double precioCondonado = mpv.damePrecioUnitario(1, mpv.cambiaAInt(laClaveDeBotana),claveDeProducto , 0);
				int comandaID = mpv.dameComandaCorrespondiente(IDMesa);
// Me alcanza para condonar todas las botanas....
				if(botanasYaCondonadas < botanasACondonar){
					// No hay problemas es igual o me sobra para perdonar botanas
					if(botanasACondonar >= cantidadBotanas){
						int vecesACondonar = botanasACondonar - botanasYaCondonadas;
						if(vecesACondonar > cantidadBotanas){
							vecesACondonar = cantidadBotanas;
						}
						precioCondonado = precioCondonado;
						for(int i=1; i<=vecesACondonar; i++){
							PreparedStatement updateCondonaBotana;
							updateCondonaBotana = con1.miConnection.prepareStatement ("UPDATE comandaPro SET PU = ?, PT = ? WHERE  IDC = ? AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
							updateCondonaBotana.setDouble(1, 0.00);
							updateCondonaBotana.setDouble(2, 0.00);
							updateCondonaBotana.setInt(3, comandaID);
							updateCondonaBotana.setInt(4, mpv.cambiaAInt(laClaveDeBotana));
							updateCondonaBotana.execute();
						}
// ACTUALIZO EL PRECIO FINAL...
						PreparedStatement updatePrecioFinal;
						updatePrecioFinal = con1.miConnection.prepareStatement ("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
						updatePrecioFinal.setDouble(1, (precioCondonado*vecesACondonar));
						updatePrecioFinal.setInt(2, comandaID);
						updatePrecioFinal.execute();
					}
// Tengo broncas debo descontar por cada uno de mis comensales de la manera más justa posible...
					else{
						int cantidadDeComensales = mpv.dameComensalesPorMesa(IDMesa);
						Vector <String> comensalesTragos = new Vector <String>();
						for(int q=1; q<=cantidadDeComensales; q++){
							cantidadCopas = 0;
							cantidadBotellaG = 0;
							cantidadBotellaM = 0;
							cantidadBotanasGratis = 0;
							int cantidadCopitas = 0;
// Averiguo el alcohol consumido por cada comensal
							String queryChupes2 = "SELECT comandapro.CanPro AS Cantidad, comandapro.Tipo, comandapro.TB FROM bebidas, comandapro, comanda WHERE comanda.IDMM = "+IDMesa +" AND comandapro.IDCom = "+q +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 2 AND comandapro.Estatus = 1 AND bebidas.clave =  comandapro.ClPro AND bebidas.alcoholica = 1 ";
							stmt =  con1.creaStatement();
							rsCantidadAlcohol = stmt.executeQuery(queryChupes2);
							while(rsCantidadAlcohol.next()){
								if(rsCantidadAlcohol.getInt("Tipo") == 1){
									cantidadCopas += (rsCantidadAlcohol.getInt("Cantidad")*rsCantidadAlcohol.getInt("TB"));
								}
								else if(rsCantidadAlcohol.getInt("Tipo") == 2){
									cantidadBotellaG += rsCantidadAlcohol.getInt("Cantidad");
								}
								else if(rsCantidadAlcohol.getInt("Tipo") == 3){
									cantidadBotellaG += rsCantidadAlcohol.getInt("Cantidad");
								}
								else if(rsCantidadAlcohol.getInt("Tipo") == 4){
									cantidadBotellaM += rsCantidadAlcohol.getInt("Cantidad");
								}
							}
							if(cantidadCopas < numeroDeCopasXBotanaGratis){
								cantidadCopitas = cantidadCopas;
							}
							else{
								cantidadCopitas = cantidadCopas - numeroDeCopasXBotanaGratis;
								while(cantidadCopitas >= numeroDeCopasXBotanaGratis){
									cantidadCopitas -=numeroDeCopasXBotanaGratis;
								}
							}
							cantidadCopas = cantidadCopas/numeroDeCopasXBotanaGratis;
							cantidadBotellaG = cantidadBotellaG *5;
							cantidadBotellaM = cantidadBotellaM *4;
							cantidadBotanasGratis = cantidadCopas+cantidadBotellaG+cantidadBotellaM;
							comensalesTragos.addElement(cantidadBotanasGratis+"*"+cantidadCopitas);
						}
						int prestamosCopitas = 0;
						int prestamosBotanas = 0;
						for(int j=1; j<=comensalesTragos.size(); j++){
							String composicion = comensalesTragos.elementAt(j-1);
							int botaGratis = mpv.cambiaAInt(composicion.substring(0, composicion.indexOf("*")));
							int copitasPresta = mpv.cambiaAInt(composicion.substring(composicion.indexOf("*")+1, composicion.length()));
							String queryXComensal = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = "+IDMesa +"  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.IDCom = "+j +" AND comandapro.Estatus = 1 ";
							ResultSet rsInterino = null;
							Statement stInternio =  con1.creaStatement();
							rsInterino = stInternio.executeQuery(queryXComensal);
							while(rsInterino.next()){
								int BotanasPedidas = rsInterino.getInt("Botanas");
								if(BotanasPedidas == botaGratis){
									prestamosCopitas +=copitasPresta;
								}
								else if(BotanasPedidas < botaGratis){
									prestamosCopitas += copitasPresta;
									prestamosBotanas += (botaGratis-BotanasPedidas);
								}
								else if(BotanasPedidas > botaGratis){
									prestamosCopitas += copitasPresta;
								}
							}
						}
						for(int j=1; j<=comensalesTragos.size(); j++){
							String composicion = comensalesTragos.elementAt(j-1);
							int botaGratis = mpv.cambiaAInt(composicion.substring(0, composicion.indexOf("*")));
							int copitasPresta = mpv.cambiaAInt(composicion.substring(composicion.indexOf("*")+1, composicion.length()));
							String queryXComensal = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = "+IDMesa +"  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.IDCom = "+j +" AND comandapro.Estatus = 1 ";
							ResultSet rsInterino = null;
							Statement stInternio =  con1.creaStatement();
							rsInterino = stInternio.executeQuery(queryXComensal);
							while(rsInterino.next()){
								int BotanasPedidas = rsInterino.getInt("Botanas");
//								System.out.println("Comensal: "+j +", BotanaPedida: "+BotanasPedidas+", botanaGratisConDerecho: "+botaGratis);
//								System.out.println("Prestamos Botanas = "+prestamosBotanas +", Prestamos Copitas = " +prestamosCopitas);
// TIENE EXACTAMENTE LO SUFICIENTE...
								if(BotanasPedidas == botaGratis){
//									System.out.println("Cuadra bien Caso#1");
									for (int i=0; i<BotanasPedidas; i++){
										PreparedStatement updateCondonaBotana;
										updateCondonaBotana = con1.miConnection.prepareStatement (								"UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ? AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
										updateCondonaBotana.setDouble(1, 0.00);
										updateCondonaBotana.setDouble(2, 0.00);
										updateCondonaBotana.setInt(3, j);
										updateCondonaBotana.setInt(4, comandaID);
										updateCondonaBotana.setInt(5, j);
										updateCondonaBotana.setInt(6, mpv.cambiaAInt(laClaveDeBotana));
										updateCondonaBotana.execute();
// ACTUALIZO EL PRECIO FINAL...
										PreparedStatement updatePrecioFinal;
										updatePrecioFinal = con1.miConnection.prepareStatement ("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
										updatePrecioFinal.setDouble(1, (precioCondonado));
										updatePrecioFinal.setInt(2, comandaID);
										updatePrecioFinal.execute();
									}
// ACTUALIZO PARA ESTE CLIENTE.
								}
// NO LE ALCANZA VEO SI PIDIENDO PRESTADO...
								else if(BotanasPedidas > botaGratis){
//									System.out.println("Me esta pidiendo más botanas de las que tiene derecho Caso #2");
									if(botaGratis >= 1){
//										System.out.println("Entre al caso en si sumo lo que tengo derecho directo por botana me alcanza para quitarle algo Caso 2A");
										int espejobotaGratis = botaGratis;
										for(int i=0; i< espejobotaGratis; i++){
											BotanasPedidas -=1;
											botaGratis -= 1;
											PreparedStatement updateCondonaBotana;
											updateCondonaBotana = con1.miConnection.prepareStatement (								"UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
											updateCondonaBotana.setDouble(1, 0.00);
											updateCondonaBotana.setDouble(2, 0.00);
											updateCondonaBotana.setInt(3, j);
											updateCondonaBotana.setInt(4, comandaID);
											updateCondonaBotana.setInt(5, j);
											updateCondonaBotana.setInt(6, mpv.cambiaAInt(laClaveDeBotana));
											updateCondonaBotana.execute();
// ACTUALIZO EL PRECIO FINAL...
											PreparedStatement updatePrecioFinal;
											updatePrecioFinal = con1.miConnection.prepareStatement ("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
											updatePrecioFinal.setDouble(1, (precioCondonado));
											updatePrecioFinal.setInt(2, comandaID);
											updatePrecioFinal.execute();
										}
									}
									if(copitasPresta/numeroDeCopasXBotanaGratis >= 1){
//										System.out.println("Entre al caso en si sumo lo que tengo derecho en copitas por botana me alcanza para quitarle algo Caso 2B");
										int espejoCP = copitasPresta/numeroDeCopasXBotanaGratis;
										for(int i=0; i< espejoCP; i++){
											BotanasPedidas -=1;
											copitasPresta -= numeroDeCopasXBotanaGratis;
											PreparedStatement updateCondonaBotana;
											updateCondonaBotana = con1.miConnection.prepareStatement (								"UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
											updateCondonaBotana.setDouble(1, 0.00);
											updateCondonaBotana.setDouble(2, 0.00);
											updateCondonaBotana.setInt(3, j);
											updateCondonaBotana.setInt(4, comandaID);
											updateCondonaBotana.setInt(5, j);
											updateCondonaBotana.setInt(6, mpv.cambiaAInt(laClaveDeBotana));
											updateCondonaBotana.execute();
// ACTUALIZO EL PRECIO FINAL...
											PreparedStatement updatePrecioFinal;
											updatePrecioFinal = con1.miConnection.prepareStatement ("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
											updatePrecioFinal.setDouble(1, (precioCondonado));
											updatePrecioFinal.setInt(2, comandaID);
											updatePrecioFinal.execute();
										}
									}
									if(prestamosBotanas+botaGratis >= 1 && BotanasPedidas > 0){
//										System.out.println("Entre al caso en si sumo lo que tengo en prestamos de botana mas lo que tiene derecho me alcanza al menos para uno. Caso 2C");
										int monto = (prestamosBotanas+botaGratis);
										for(int i=0; i< monto; i++){
											prestamosBotanas -= 1;
											BotanasPedidas -=1;
											PreparedStatement updateCondonaBotana;
											updateCondonaBotana = con1.miConnection.prepareStatement (								"UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
											updateCondonaBotana.setDouble(1, 0.00);
											updateCondonaBotana.setDouble(2, 0.00);
											updateCondonaBotana.setInt(3, j);
											updateCondonaBotana.setInt(4, comandaID);
											updateCondonaBotana.setInt(5, j);
											updateCondonaBotana.setInt(6, mpv.cambiaAInt(laClaveDeBotana));
											updateCondonaBotana.execute();
// ACTUALIZO EL PRECIO FINAL...
											PreparedStatement updatePrecioFinal;
											updatePrecioFinal = con1.miConnection.prepareStatement ("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
											updatePrecioFinal.setDouble(1, (precioCondonado));
											updatePrecioFinal.setInt(2, comandaID);
											updatePrecioFinal.execute();
										}
									}
									if((prestamosCopitas)/numeroDeCopasXBotanaGratis >= 1 && BotanasPedidas > 0){
//										System.out.println("Entre al caso en que si pido prestado de Copitas me alcanza al menos para un. Caso 2D");
										int monto =((copitasPresta+prestamosCopitas)/numeroDeCopasXBotanaGratis)-BotanasPedidas;
										for(int i=0; i< monto; i++){
											prestamosCopitas -= numeroDeCopasXBotanaGratis;
											BotanasPedidas -=1;
											PreparedStatement updateCondonaBotana;
											updateCondonaBotana = con1.miConnection.prepareStatement (								"UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
											updateCondonaBotana.setDouble(1, 0.00);
											updateCondonaBotana.setDouble(2, 0.00);
											updateCondonaBotana.setInt(3, j);
											updateCondonaBotana.setInt(4, comandaID);
											updateCondonaBotana.setInt(5, j);
											updateCondonaBotana.setInt(6, mpv.cambiaAInt(laClaveDeBotana));
											updateCondonaBotana.execute();
// ACTUALIZO EL PRECIO FINAL...
											PreparedStatement updatePrecioFinal;
											updatePrecioFinal = con1.miConnection.prepareStatement ("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
											updatePrecioFinal.setDouble(1, (precioCondonado));
											updatePrecioFinal.setInt(2, comandaID);
											updatePrecioFinal.execute();
										}
									}
								}
// LE SOBRA.
								else if(BotanasPedidas < botaGratis){
//									System.out.println("Le Sobra Caso #3");
									for (int i=0; i<BotanasPedidas; i++){
										PreparedStatement updateCondonaBotana;
										updateCondonaBotana = con1.miConnection.prepareStatement (								"UPDATE comandaPro SET PU = ?, PT = ?,  IDCom = ? WHERE  IDC = ? AND IDCom = ?  AND Di = ?  AND PU != 0.00 AND PT != 0.00 AND Estatus = 1 Limit 1");
										updateCondonaBotana.setDouble(1, 0.00);
										updateCondonaBotana.setDouble(2, 0.00);
										updateCondonaBotana.setInt(3, j);
										updateCondonaBotana.setInt(4, comandaID);
										updateCondonaBotana.setInt(5, j);
										updateCondonaBotana.setInt(6, mpv.cambiaAInt(laClaveDeBotana));
										updateCondonaBotana.execute();
// ACTUALIZO EL PRECIO FINAL...
										PreparedStatement updatePrecioFinal;
										updatePrecioFinal = con1.miConnection.prepareStatement ("UPDATE comanda SET PT = PT - ? WHERE IDC = ?  AND Es = 1 ");
										updatePrecioFinal.setDouble(1, (precioCondonado));
										updatePrecioFinal.setInt(2, comandaID);
										updatePrecioFinal.execute();
									}
//ACTUALIZO PARA ESTE CLIENTE
								}
							}
						}
					}
				}
			}
			con1.realizaCommit();
		}
		catch (SQLException sqle){
			con1.realizaRollback();
			System.out.println("Error de SQL en ImpresionTicketXComensal, validaReglas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			con1.realizaRollback();
			System.out.println("Ocurrio un Error en ImpresionTicketXComensal, validaReglas ");
			e.printStackTrace();
		}
		finally{
			if(con1 != null){
				try{
					con1.realizaCommit();
					con1.habilitaAutoCommit();
					con1.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ImpresionTicketXComensal, validaReglas ");
					q.printStackTrace();
				}
			}
		}
	}

	public ResultSet dameDatosComanda () throws SQLException, Exception{
		con1 = new ConexionBD();
		try{
			String query = "SELECT comanda.IDC, comanda.NC, CONCAT(empleados.Nombre COLLATE latin1_spanish_ci,' ',empleados.APaterno COLLATE latin1_spanish_ci) AS Nombre, comanda.PT  FROM comanda, empleados WHERE comanda.IDMM = "+IDMesa +" AND comanda.Es = 1 AND empleados.IDEmpleado = comanda.IDM ";
			Statement stmt =  con1.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicketComandaT, dameDatosComanda ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicketComandaT, dameDatosComanda ");
			e.printStackTrace();
		}
		return rs;
	}


	public void CierraConexion1() throws SQLException, Exception{
		if(con1 != null){
			try{
				con1.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ImpresionTicketComandaT, dameDatosComanda ");
				q.printStackTrace();
			}
		}
	}

	public void CierraConexion2() throws SQLException, Exception{
		if(con2 != null){
			try{
				con1.cierraConexion();
			}
			catch (Exception q){
				System.out.println("Error al momento de cerrar conexion en ImpresionTicketComandaT, dameDatosComanda ");
				q.printStackTrace();
			}
		}
	}



	public ResultSet listadoComanda() throws SQLException, Exception{
		con2 = new ConexionBD();
		ResultSet rs = null;
		try{
			String query = "SELECT Cantidad, PrecioUnitario, PrecioTotal, Producto, Tipo, Tamanio FROM (SELECT SUM(comandapro.CanPro)AS Cantidad, (comandapro.PU)AS PrecioUnitario, SUM(comandapro.PT)AS PrecioTotal, (comandapro.TB) AS Tamanio, (alimentos.nombre)AS Producto, comandapro.Tipo FROM comandapro, comanda, alimentos WHERE comanda.IDMM = "+IDMesa +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Tipo = 0 AND comandapro.Estatus = 1 AND alimentos.clave = comandapro.ClPro GROUP BY CONCAT(comandapro.ClPro,comandapro.TB,comandapro.PU) UNION SELECT SUM(comandapro.CanPro)AS  Cantidad, (comandapro.PU)AS PrecioUnitario, SUM(comandapro.PT)AS PrecioTotal, (comandapro.TB)AS Tamanio, (bebidas.nombre)AS Producto, comandapro.Tipo FROM comandapro, comanda, bebidas WHERE comanda.IDMM = "+IDMesa + " AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND (comandapro.Tipo = 1 OR comandapro.Tipo = 2 OR comandapro.Tipo = 3 OR comandapro.Tipo = 4) AND comandapro.Estatus = 1 AND bebidas.clave = comandapro.ClPro GROUP BY  CONCAT(comandapro.ClPro,comandapro.TB,comandapro.PU))AS TempT ORDER BY CONCAT(Producto,Tamanio)";
			Statement stmt =  con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ImpresionTicketComandaT, listadoComanda ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ImpresionTicketComandaT, listadoComanda ");
			e.printStackTrace();
		}
		return rs;
	}


	public int print (Graphics g, PageFormat pageFormat, int page) throws PrinterException  {
		// CHECO QUE NO PASE DE LAS HOJAS ACORDADAS A IMPRIMIR....
		if(page>= (int)Math.ceil(cantidadHojas)) {
			return NO_SUCH_PAGE;
		}
		//--- creacion de un objeto Graphics2 para desplegar mis elementos.
		g2d = (Graphics2D) g;
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
		g2d.drawImage (image,25,0, (int) (0.944 * POINTS_PER_INCH),  (int) (0.736 * POINTS_PER_INCH), frame);
		// EXTRAIGO PROPIEDADES DE ALTURA DE MIS FUENTES:
		g2d.setFont(nuevaProd);
		nuevaProdAscent=g2d.getFontMetrics().getAscent();
		nuevaProdDescent=g2d.getFontMetrics().getDescent();
		nuevaProdLeading = g2d.getFontMetrics().getLeading();
		g2d.setFont(nuevaProd2);
		nuevaProdAscent2=g2d.getFontMetrics().getAscent();
		nuevaProdDescent2=g2d.getFontMetrics().getDescent();
		nuevaProdLeading2 = g2d.getFontMetrics().getLeading();
		g2d.setFont(prod);
		prodAscent=g2d.getFontMetrics().getAscent();
		prodDescent=g2d.getFontMetrics().getDescent();
		prodLeading =g2d.getFontMetrics().getLeading();
		g2d.setFont(nueva);
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
		//--- creacion de un objeto Graphics2 para desplegar mis elementos.
		g2d = (Graphics2D) g;
		g2d.setColor (Color.black);
		// Inicializo mi punto para realizar los trazos, mando imprimir "El retoño"
		Point2D.Double pen = new Point2D.Double (0, 0);
		g2d.translate (pageFormat.getImageableX (), pageFormat.getImageableY ());
		pen.y += (0.400 *  POINTS_PER_INCH);
		pen.x += 98;
		g2d.drawString ("LA ULTRAMARINA", (int)pen.getX(),(int) pen.getY());
		g2d.setFont (nuevaProd2);
		pen.y +=  nuevaProdAscent + nuevaProdDescent + nuevaProdLeading;
		pen.x = 110;
		g2d.drawString ("Cuenta: Total", (int)pen.getX(),(int) pen.getY());
		pen.y +=(12);
		pen.x = 0;
		g2d.setFont (nuevaProd);
		g2d.drawString ("**************************************", (int)pen.getX(),(int) pen.getY());
		//--- Muevo la pluma a la siguiente coordinada
		pen.y += nuevaProdAscent;
		pen.x = 5;
		g2d.setFont (nuevaProd2);
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		g2d.drawString ("Cantina   \" La Ultramarina \",   Tonalá #178", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 5;
		g2d.drawString ("esq. Yucatán,  Col. Roma,  Tel.  5574 3953", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 0;
		g2d.setFont (nuevaProd);
		g2d.drawString ("*************** NO FISCAL ***************", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdAscent;
		pen.x = 5;
		g2d.setFont (nuevaProd2);
		g2d.drawString ("Fecha: "+Fecha, (int)pen.getX(),(int) pen.getY());
		pen.x = 105;
		g2d.drawString ("Hora: "+Hora, (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 5;
		// Bajo mi coordinada de acuerdo a la altura de la letra.
		try{
			g2d.drawString ("Mesa: "+mpv.cambiaANombreBarra(IDMesa+"")+",", (int)pen.getX(),(int) pen.getY());
			pen.x = 55;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		g2d.drawString ("Comen.:#"+NumComensales, (int)pen.getX(),(int) pen.getY());
		pen.x =(118);
		g2d.drawString ("Comanda #: "+IDComanda+"", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent;
		pen.x = 0;
		g2d.setFont (nuevaProd);
		g2d.drawString (" ________________________________________", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 0;
		g2d.drawString ("Cant.             Producto             $ Unitario       $ Total", (int)pen.getX(),(int) pen.getY());
		pen.y += nuevaProdDescent +  nuevaProdLeading +nuevaProdAscent;
		pen.x = 0;
		g2d.setFont(prod);
		// IMPRIMO LOS PRODUCTOS SOLICITADOS.
		boolean pasoPrimerProducto = false;
		int contadorInterno = 0;
		try{
			while(rs.next() && contadorInterno < 25){
				boolean aumentoX1 = false;
				String precioUnitario = mpv.formatoCortoDinero(rs.getString("precioUnitario"));
				String precioTotal = mpv.formatoCortoDinero(rs.getString("precioTotal"));
				String elProducto =  rs.getString("Producto").toLowerCase();
				if(elProducto.length() > 25){
					elProducto= elProducto.substring(0,25);
				}
				if(rs.getString("tipo").equalsIgnoreCase("1") && rs.getInt("Tamanio")==1){
					Tipo = "C.";
				}
				else if(rs.getString("tipo").equalsIgnoreCase("1") && rs.getInt("Tamanio")==2){
					Tipo = "Cd.";
				}
				else if(rs.getString("tipo").equalsIgnoreCase("1") && rs.getInt("Tamanio")==3){
					Tipo = "Ct.";
				}
				else if(rs.getString("tipo").equalsIgnoreCase("2")){
					Tipo = "B.";
				}
				else if(rs.getString("tipo").equalsIgnoreCase("3")){
					Tipo = "BG.";
				}
				else if(rs.getString("tipo").equalsIgnoreCase("4")){
					Tipo = "BP.";
				}
				else{
					Tipo = "";
				}
				Cantidad = mpv.dameEnteros(rs.getString("Cantidad"));
				if(Cantidad.equals("1")){
					aumentoX1 = true;
				}
				Cantidad += " "+Tipo;
				contadorInterno ++;
				if(pasoPrimerProducto){
					pen.y += prodDescent +  prodLeading; // Sumo a mi punto y lo que sale de la letra y el espacio entre renglones
					pen.x = 0;
					pen.y += prodAscent;
				}
				else{
					pasoPrimerProducto = true;
				}
				boolean hayObservacion = false;
				if(aumentoX1){
					pen.x += 2;
				}
				g2d.drawString (Cantidad, (int)pen.getX(),(int) pen.getY());
				pen.x +=(23);
				if(aumentoX1){
					pen.x += -2;
				}
				g2d.drawString (elProducto, (int)pen.getX(),(int) pen.getY());
				pen.x = (116);
				if(mpv.formatoDinero(mpv.acortaLongitud(precioUnitario)).length() <= 6){
					pen.x += -2;
				}
				g2d.drawString (mpv.formatoEspaciado(mpv.formatoDinero(mpv.acortaLongitud(precioUnitario))), (int)pen.getX(),(int) pen.getY());
				pen.x = (152);
				if(mpv.formatoDinero(mpv.acortaLongitud(precioTotal)).length() <= 6){
					pen.x += -2;
				}
				g2d.drawString (mpv.formatoEspaciado(mpv.formatoDinero(mpv.acortaLongitud(precioTotal))), (int)pen.getX(),(int) pen.getY());
			}
			rs.previous();
		}
		catch (SQLException sqle){
			sqle.printStackTrace();
		}
		catch (Exception e2){
			e2.printStackTrace();
		}
		g2d.setFont (nuevaProd);
		if((page+1) == (int)Math.ceil(cantidadHojas)){
			pen.y += nuevaProdDescent;
			pen.x = 0;
			g2d.drawString (" ________________________________________", (int)pen.getX(),(int) pen.getY());
			if(Descuento > 0){
				pen.y += nuevaProdDescent+nuevaProdAscent;
				pen.x = 110;
				g2d.drawString ("DESCUENTO. $ ", (int)pen.getX(),(int) pen.getY());
				pen.x = 155;
				if(Descuento+"".length() <= 6){
					pen.x += -2;
				}
				try{
					g2d.drawString (mpv.formatoEspaciado(mpv.formatoDinero(mpv.acortaLongitud(Descuento+""))), (int)pen.getX(),(int) pen.getY());
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
			pen.y += nuevaProdDescent+nuevaProdAscent;
			pen.x = 110;
			g2d.drawString ("TOTAL.......... $ ", (int)pen.getX(),(int) pen.getY());
			pen.x = 155;
			if(PagoTotal.length() <= 6){
				pen.x += -2;
			}
			try{
				g2d.drawString (mpv.formatoEspaciado(PagoTotal), (int)pen.getX(),(int) pen.getY());
			}
			catch(Exception e){
				e.printStackTrace();
			}
			pen.y += nuevaProdDescent+nuevaProdAscent;
			pen.x = 0;
			g2d.drawString ("**************************************", (int)pen.getX(),(int) pen.getY());
			pen.y += nuevaProdAscent;
			pen.x = 5;
			g2d.drawString ("***** Los Precios Incluyen I.V.A. ****", (int)pen.getX(),(int) pen.getY());
			pen.y += nuevaProdAscent;
			pen.x = 35;
			g2d.drawString ("Gracias Por Su Visita, Vuelva Pronto", (int)pen.getX(),(int) pen.getY());
			pen.y += nuevaProdLeading+nuevaProdAscent;
			pen.x = 53;
			g2d.drawString ("Le atendió: " +Empleado, (int)pen.getX(),(int) pen.getY());
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
			PRINTER_NAME=config.getProperty("imp_Caja").trim();
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