package alphanet.ultra.digibar.bd;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.NumberFormat;
import java.sql.Date;
import java.sql.Time;
import java.util.Vector;
import java.net.URLDecoder;
import sun.text.Normalizer;
import javax.swing.DefaultListModel;
import java.sql.Savepoint;
import java.io.*;

public class ManagerPuntoVenta {

	protected Vector <String> datosMapa;
	private ConexionBD con = null;
	private ConexionBD con2 = null;
	private ConexionBD con3 = null;
	private ConexionBD con4 = null;
	private ConexionBD con5 = null;
	protected TimeStamp tiempo;
	protected static Properties config;
	protected final int numeroDeCopasXBotanaGratis = 3;


	public Vector<String> dameListaComponeBotana() throws SQLException, Exception {
		Vector <String>datosCombina = new Vector <String>();
		con = new ConexionBD();
		int claveBotana = 0;
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			claveBotana=cambiaAInt(config.getProperty("botanaCla").trim());
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		try{
			ResultSet rs = null;
			String query = "SELECT alimentos.materia0, (a.nombre)AS nombre0, alimentos.materia1, (b.nombre)AS nombre1, alimentos.materia2, (c.nombre)AS nombre2, alimentos.materia3, (d.nombre)AS nombre3, alimentos.materia4, (e.nombre)AS nombre4, alimentos.materia5, (f.nombre)AS nombre5, alimentos.materia6, (g.nombre)AS nombre6, alimentos.materia7, (h.nombre)AS nombre7, alimentos.materia8, (i.nombre)AS nombre8, alimentos.materia9, (j.nombre)AS nombre9  FROM ((((((((((alimentos LEFT JOIN materiaprima a ON alimentos.materia0 = a.clave) LEFT JOIN materiaprima b ON alimentos.materia1 = b.clave)LEFT JOIN materiaprima c ON alimentos.materia2 = c.clave) LEFT JOIN materiaprima d ON  alimentos.materia3= d.clave) LEFT JOIN materiaprima e ON alimentos.materia4 = e.clave) LEFT JOIN materiaprima f ON alimentos.materia5 =  f.clave) LEFT JOIN materiaprima g ON alimentos.materia6 = g.clave) LEFT JOIN materiaprima h ON alimentos.materia7 = h.clave) LEFT JOIN materiaprima i ON alimentos.materia8 = i.clave) LEFT JOIN materiaprima j ON alimentos.materia9 = j.clave) WHERE alimentos.division = "+claveBotana+" AND alimentos.estatus = 1";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				if(rs.getInt("materia0")!= 0){
					datosCombina.addElement(rs.getString("nombre0")+" * " +rs.getString("materia0"));
				}
				if(rs.getInt("materia1")!= 0){
					datosCombina.addElement(rs.getString("nombre1")+" * " +rs.getString("materia1"));
				}
				if(rs.getInt("materia2")!= 0){
					datosCombina.addElement(rs.getString("nombre2")+" * " +rs.getString("materia2"));
				}
				if(rs.getInt("materia3")!= 0){
					datosCombina.addElement(rs.getString("nombre3")+" * " +rs.getString("materia3"));
				}
				if(rs.getInt("materia4")!= 0){
					datosCombina.addElement(rs.getString("nombre4")+" * " +rs.getString("materia4"));
				}
				if(rs.getInt("materia5")!= 0){
					datosCombina.addElement(rs.getString("nombre5")+" * " +rs.getString("materia5"));
				}
				if(rs.getInt("materia6")!= 0){
					datosCombina.addElement(rs.getString("nombre6")+" * " +rs.getString("materia6"));
				}
				if(rs.getInt("materia7")!= 0){
					datosCombina.addElement(rs.getString("nombre7")+" * " +rs.getString("materia7"));
				}
				if(rs.getInt("materia8")!= 0){
					datosCombina.addElement(rs.getString("nombre8")+" * " +rs.getString("materia8"));
				}
				if(rs.getInt("materia9")!= 0){
					datosCombina.addElement(rs.getString("nombre9")+" * " +rs.getString("materia9"));
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameListaComponeBotana ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameListaComponeBotana ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameListaComponeBotana ");
					q.printStackTrace();
				}
			}
		}
		return datosCombina;
	}




	public Vector<String> dameListaParaCombinar() throws SQLException, Exception {
		con = new ConexionBD();
		Vector <String>datosCombina = new Vector <String>();
		try{
			ResultSet rs = null;
			String query = "SELECT bebidas.nombre, bebidas.clave, materiaprima.litrosXBotella1, materiaprima.litrosXBotella2 FROM bebidas, materiaprima WHERE bebidas.combinable = 2 AND materiaprima.clave = bebidas.materia0  ORDER BY bebidas.nombre";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				String elNombre = rs.getString("nombre");
				String laClave = rs.getString("clave");
				double litrosB1 = rs.getDouble("litrosXBotella1");
				double litrosB2 = rs.getDouble("litrosXBotella2");
				if(litrosB1 == 0 || litrosB2 == 0){
					datosCombina. addElement(elNombre+" M. * "+laClave);
				}
				else {
					datosCombina.addElement(elNombre+" M. * "+laClave);
					datosCombina.addElement(elNombre+" C. * "+laClave);
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameListaParaCombinar ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameListaParaCombinar ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
				con.cierraConexion();				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameListaParaCombinar ");
					q.printStackTrace();
				}
			}
		}
		return datosCombina;
	}


	public double dameMontoTotal(int mesaID) throws SQLException, Exception {
		double montoARestar = descuentaBotanas(mesaID);
		ResultSet rs = null;
		double elMonto = 0.00;
		try{
			String query = ("SELECT SUM(comandapro.PT)AS PT FROM comandapro, comanda WHERE comanda.IDMM = "+mesaID +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Estatus = 1");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				elMonto = rs.getDouble("PT");
			}
			elMonto -= montoARestar;
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameMontoTotal ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameMontoTotal ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameMontoTotal ");
					q.printStackTrace();
				}
			}
		}
		return elMonto;
	}


// Con este metodo valido mis reglas (Ejem botanas X Bebidas).
	public double descuentaBotanas(int IDMesa) throws SQLException, Exception{
		double cantidadARestar = 0.00;
		con4 = new ConexionBD();
		int cantidadBotanas = 0;
		int cantidadBotanasGratis = 0;
		int cantidadBotellaG = 0;
		int cantidadBotellaM = 0;
		int cantidadCopas = 0;
		int botanasACondonar = 0;
		int botanasYaCondonadas = 0;
		String laClaveDeBotana = "";
		laClaveDeBotana = dameLaClaveDeBotana();
		try{
			ResultSet rsCantidadAlcohol = null;
			ResultSet rsCantidadBotanas = null;
// Solicito la cantidad de alcohol consumida para esta cuenta...
			String queryChupes = "SELECT comandapro.CanPro AS Cantidad, comandapro.Tipo, comandapro.TB FROM bebidas, comandapro, comanda WHERE comanda.IDMM = "+IDMesa +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 2 AND comandapro.Estatus = 1 AND bebidas.clave =  comandapro.ClPro AND bebidas.alcoholica = 1 ";
			Statement stmt =  con4.creaStatement();
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
			cantidadBotanasGratis = cantidadCopas+cantidadBotellaG+cantidadBotellaM;
// Averiguo cuantas botanas me solicitaron
			String queryBotanasPedidas = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = "+IDMesa +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.Estatus = 1";
			Statement stmt2 =  con4.creaStatement();
			rsCantidadBotanas = stmt2.executeQuery(queryBotanasPedidas);
			while(rsCantidadBotanas.next()){
				cantidadBotanas = rsCantidadBotanas.getInt("Botanas");
			}
// Ahora averiguo cuantas ya han sido condonadas...
			String queryPerdonadas = "SELECT DISTINCT SUM(comandapro.CanPro)AS Botanas FROM comandapro, comanda WHERE comanda.IDMM = " +IDMesa +"  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.Estatus = 1 AND comandapro.PT = 0.00";
			Statement stmt3 =  con4.creaStatement();
			ResultSet rsBotanasYaCondonadas = null;
			rsBotanasYaCondonadas = stmt3.executeQuery(queryPerdonadas);
			while(rsBotanasYaCondonadas.next()){
				botanasYaCondonadas = rsBotanasYaCondonadas.getInt("Botanas");
			}
//			System.out.println("botanasYaCondonadas: "+botanasYaCondonadas);
//			System.out.println("botanas Pedidas: "+cantidadBotanas);
//			System.out.println("botanasBotanasGratis: "+cantidadBotanasGratis);
			if(cantidadBotanasGratis > cantidadBotanas ){
				cantidadBotanasGratis = cantidadBotanas;
			}
			if(botanasYaCondonadas > cantidadBotanasGratis){
				System.out.println("Tengo mas condonadas");
			}
			else if(botanasYaCondonadas == cantidadBotanasGratis){
				cantidadBotanasGratis = 0;
			}
			else {
				cantidadBotanasGratis -=botanasYaCondonadas;
			}
//			System.out.println("botanasYaCondonadas: "+botanasYaCondonadas);
//			System.out.println("botanas Pedidas: "+cantidadBotanas);
//			System.out.println("botanasBotanasGratis: "+cantidadBotanasGratis);
			int claveDeProducto = 0;
			String queryDimeCP = "SELECT DISTINCT (comandapro.ClPro)AS Clave FROM comandapro, comanda WHERE comanda.IDMM = "+ IDMesa +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Ge = 1 AND comandapro.Di = "+laClaveDeBotana +" AND comandapro.Estatus = 1 ";
			ResultSet rsPetit = null;
			Statement stmt4 =  con4.creaStatement();
			rsPetit = stmt4.executeQuery(queryDimeCP);
			while(rsPetit.next()){
				claveDeProducto = rsPetit.getInt("Clave");
			}
			double precioCondonado = damePrecioUnitario(1, cambiaAInt(laClaveDeBotana),claveDeProducto , 0);
			cantidadARestar = precioCondonado*cantidadBotanasGratis;
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, descuentaBotanas ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, descuentaBotanas ");
			e.printStackTrace();
		}
		finally{
			if(con4 != null){
				try{
					con4.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, descuentaBotanas ");
					q.printStackTrace();
				}
			}
		}
		return cantidadARestar;
	}




/**
* El Método estatusMapa nos informa sobre el estado que guardan todas las mesas....
*
* @return Vector <String> con el estado de las mesas
*/
	public Vector<String> estatusMapa() throws SQLException, Exception {
		con = new ConexionBD();
		datosMapa = new Vector <String>();
		try{
			ResultSet rs = null;
			String query = "SELECT IDMesa, Estatus FROM mesas ";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				String mesa = codifica(rs.getString("IDMesa"));
				String estatus = codifica(rs.getString("Estatus"));
				datosMapa.addElement(mesa);
				datosMapa.addElement(estatus);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, estatusMapa ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, estatusMapa ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
				con.cierraConexion();				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, estatusMapa ");
					q.printStackTrace();
				}
			}
		}
		return datosMapa;
	}


	public String dameLaClaveDeBotana()throws Exception{
		String claveBotana = "";
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			claveBotana=config.getProperty("botanaCla").trim();
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		return claveBotana;
	}

/**
* El Método dameComponentesBotana nos indica que mesa esta registrada como la maestra de todas.
*
* @return String con el ID de la mesa maestra
*/
	public String dameComponentesBotana() throws SQLException, Exception {
		con = new ConexionBD();
		String componentes = "";
		String clave1 = "";
		String clave2 = "";
		String clave3 = "";
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			clave1=config.getProperty("claBot1");
			clave2=config.getProperty("claBot2");
			clave3=config.getProperty("claBot3");
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		try{
			ResultSet rs = null;
			String query = "SELECT materiaprima.nombre, materiaprima.clave FROM materiaprima WHERE materiaprima.clave = "+clave1 +" OR materiaprima.clave = "+clave2+" OR materiaprima.clave = "+clave3+"  ORDER BY materiaprima.clave";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				if(rs.getString("clave").equalsIgnoreCase(clave1)){
					componentes = rs.getString("nombre")+ " * " +rs.getString("clave")+"\n";
				}
				else if(rs.getString("clave").equalsIgnoreCase(clave2)){
					componentes += rs.getString("nombre")+ " * " +rs.getString("clave")+"\n";
				}
				else if(rs.getString("clave").equalsIgnoreCase(clave3)){
					componentes += rs.getString("nombre")+ " * " +rs.getString("clave");
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameComponentesBotana ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameComponentesBotana ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameComponentesBotana ");
					q.printStackTrace();
				}
			}
		}
		return componentes;
	}




/**
* El Método mesaMadreLigada nos indica que mesa esta registrada como la maestra de todas.
*
* @return String con el ID de la mesa maestra
*/
	public String mesaMadreLigada(String mesa) throws SQLException, Exception {
		if(mesa.startsWith("B")){
			mesa=mesa.substring(1,mesa.length());
			if(mesa.equals("1")){
				mesa = "25";
			}
			else if(mesa.equals("2")){
				mesa = "26";
			}
			else if(mesa.equals("3")){
				mesa = "27";
			}
			else if(mesa.equals("4")){
				mesa = "28";
			}
			else if(mesa.equals("5")){
				mesa = "29";
			}
		}
		con = new ConexionBD();
		String mesaMadre = "";
		try{
			ResultSet rs = null;
			String query = "SELECT LigaA FROM mesas WHERE IDMesa = '"+mesa +"'";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				mesaMadre = rs.getString("LigaA");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, mesaMadreLigada ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, mesaMadreLigada ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, mesaMadreLigada ");
					q.printStackTrace();
				}
			}
		}
		return mesaMadre;
	}


/**
* El Método listadoMeseras es el Responsable de regresar el listado de Meseros Activos
* * @return Object[] con el listado correspondiente
*/
	public  Vector <String> listadoMeseras(){
		ResultSet rs = null;
		Vector <String> vMeseros = new Vector <String>();
		try{
		String query = ("SELECT CONCAT(Nombre COLLATE latin1_spanish_ci,' ',APaterno COLLATE latin1_spanish_ci,' ',AMaterno COLLATE latin1_spanish_ci, '  > ',IDEmpleado) AS Nombre FROM empleados WHERE (Tipo = 0 OR Tipo = 1)  AND Activo = 1 ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				vMeseros.addElement(codifica(rs.getString("Nombre")));
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, listadoMeseras ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, listadoMeseras ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVentas, listadoMeseras ");
					q.printStackTrace();
				}
			}
		}
		return vMeseros;
	}


/**
* El Método listadoEmpleados es el Responsable de regresar el listado de Todos los Empleados Activos.
* * @return Object[] con el listado correspondiente
*/
	public  Vector <String> listadoEmpleados() throws SQLException, Exception{
		ResultSet rs = null;
		Vector <String> vTodosA = new Vector <String>();
		try{
		String query = ("SELECT CONCAT(Nombre COLLATE latin1_spanish_ci,' ',APaterno COLLATE latin1_spanish_ci,' ',AMaterno COLLATE latin1_spanish_ci, '  > ',IDEmpleado) AS Nombre FROM empleados WHERE  Activo = 1 ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				vTodosA.addElement(codifica(rs.getString("Nombre")));
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, listadoEmpleados ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, listadoEmpleados ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVentas, listadoEmpleados ");
					q.printStackTrace();
				}
			}
		}
		return vTodosA;
	}



/**
* El Método listadosTodosAutorizados es el Responsable de regresar el listado de Meseros Activos
* * @return Object[] con el listado correspondiente
*/
	public  Vector <String> listadosTodosAutorizados() throws SQLException, Exception{
		ResultSet rs = null;
		Vector <String> vTodosA = new Vector <String>();
		try{
		String query = ("SELECT CONCAT(Nombre COLLATE latin1_spanish_ci,' ',APaterno COLLATE latin1_spanish_ci,' ',AMaterno COLLATE latin1_spanish_ci, '  > ',IDEmpleado) AS Nombre FROM empleados WHERE (Tipo = 0 OR  Tipo = 1 OR Tipo = 2)  AND Activo = 1 ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				vTodosA.addElement(codifica(rs.getString("Nombre")));
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, listadosTodosAutorizados ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, listadosTodosAutorizados ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVentas, listadosTodosAutorizados ");
					q.printStackTrace();
				}
			}
		}
		return vTodosA;
	}

	public String dameMeseroAsignado(int mesa) throws SQLException, Exception{
		ResultSet rs = null;
		String  idMesero = "";
		try{
		String query = ("SELECT CONCAT(empleados.Nombre COLLATE latin1_spanish_ci,' ',empleados.APaterno COLLATE latin1_spanish_ci,' ',empleados.AMaterno COLLATE latin1_spanish_ci, '  > ',empleados.IDEmpleado) AS Nombre FROM empleados, comanda WHERE empleados.IDEmpleado = comanda.IDM AND comanda.IDMM = "+mesa+" AND comanda.es=1 ");
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				idMesero = rs.getString("Nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerVentas, dameMeseroAsignado ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerVentas, dameMeseroAsignado ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerVentas, dameMeseroAsignado ");
					q.printStackTrace();
				}
			}
		}
		return idMesero;
	}


	public void modificaComensalAsignado(int nuevoComensal, int mesaID, int claveProducto,String  tipo,int comensalPrevio) throws SQLException, Exception{
		int tipoI = 0;
		int comandaActual = 0;
		if(tipo.equalsIgnoreCase("Copa")){
			tipoI = 1;
		}
		else if(tipo.equalsIgnoreCase("Botella")){
			tipoI = 2;
		}
		comandaActual = dameComandaCorrespondiente(mesaID);
		con3 = new ConexionBD();
		try{
			PreparedStatement updateAsignacionPC;
			updateAsignacionPC = con3.miConnection.prepareStatement (				"UPDATE comandaPro SET IDCom = ? WHERE  IDC = ? AND ClPro = ? AND Tipo = ? AND IDCom = ? AND Estatus = 1 Limit 1");
			updateAsignacionPC.setInt(1, nuevoComensal);
			updateAsignacionPC.setInt(2, comandaActual);
			updateAsignacionPC.setInt(3, claveProducto);
			updateAsignacionPC.setInt(4, tipoI);
			updateAsignacionPC.setInt(5, comensalPrevio);
			updateAsignacionPC.execute();
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, modificaComensalAsignado ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, modificaComensalAsignado ");
			e.printStackTrace();
		}
		finally{
			if(con3 != null){
				try{
					con3.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, modificaComensalAsignado ");
					q.printStackTrace();
				}
			}
		}
	}



	public int dameComensalesPorMesa(int mesaID) throws SQLException, Exception{
		con = new ConexionBD();
		int cantidadComensales = -1;
		try{
			ResultSet rs = null;
			String query = "SELECT NC FROM comanda  WHERE IDMM = "+mesaID +" AND Es = 1";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				cantidadComensales = rs.getInt("NC");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameComensalePorMesa ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameComensalePorMesa ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameComensalePorMesa ");
					q.printStackTrace();
				}
			}
		}
		return cantidadComensales;
	}



	public synchronized int dameTipoCombinacion(int claveDeProducto) throws SQLException, Exception{
		con = new ConexionBD();
		int tipoCombinacion = -1;
		try{
			ResultSet rs = null;
			String query = "SELECT combinable FROM bebidas WHERE clave = "+claveDeProducto +" AND estatus = 1";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				tipoCombinacion = rs.getInt("combinable");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameTipoCombinacion ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameTipoCombinacion ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameTipoCombinacion ");
					q.printStackTrace();
				}
			}
		}
		return tipoCombinacion;
	}


	public synchronized int damePropiedadDimension(int claveDeProducto) throws SQLException, Exception{
		con = new ConexionBD();
		int propiedadDimension = -1;
		try{
			ResultSet rs = null;
			String query = "SELECT dimensionable FROM bebidas WHERE clave = "+claveDeProducto +" AND estatus = 1";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				propiedadDimension = rs.getInt("dimensionable");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePropiedadDimension ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePropiedadDimension ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePropiedadDimension ");
					q.printStackTrace();
				}
			}
		}
		return propiedadDimension;
	}



	public int dameComandaCorrespondiente(int mesaID) throws SQLException, Exception{
		con = new ConexionBD();
		int comandaC = -1;
		try{
			ResultSet rs = null;
			String query = "SELECT IDC FROM comanda  WHERE IDMM = "+mesaID +" AND Es = 1";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				comandaC = rs.getInt("IDC");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameComandaCorrespondiente ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameComandaCorrespondiente ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameComandaCorrespondiente ");
					q.printStackTrace();
				}
			}
		}
		return comandaC;
	}



	public Vector<String> dameMesasLigadasA(int mesaID) throws SQLException, Exception{
		con = new ConexionBD();
		Vector <String> mesasLigadas = new Vector <String>();
		try{
			ResultSet rs = null;
			String query = "SELECT IDMesa FROM mesas  WHERE LigaA = "+mesaID +" AND Estatus = 2";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				String mesa = codifica(cambiaANombreBarra(rs.getString("IDMesa")));
				mesasLigadas.addElement(mesa);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameMesasLigadasA ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameMesasLigadasA ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameMesasLigadasA ");
					q.printStackTrace();
				}
			}
		}
		return mesasLigadas;
	}

/**
* El Método mesasDisponiblesTraspaso nos informa sobre las mesas que se encuentran disponibles para ser ligadas.
*
* @return Vector <String> con el listado de las mesas disponibles.
*/
	public Vector<String> mesasDisponiblesTraspaso(int mesaATraspasar) throws SQLException, Exception {
		con = new ConexionBD();
		Vector <String> datosMDisponibles = new Vector <String>();
		try{
			ResultSet rs = null;
			String query = "SELECT IDMesa FROM mesas  WHERE IDMesa != "+mesaATraspasar +" AND (Estatus = 0 OR Estatus = 1)";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				String mesa = codifica(cambiaANombreBarra(rs.getString("IDMesa")));
				datosMDisponibles.addElement(mesa);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, mesasDisponiblesTraspaso ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, mesasDisponiblesTraspaso ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, mesasDisponiblesTraspaso ");
					q.printStackTrace();
				}
			}
		}
		return datosMDisponibles;
	}




/**
* El Método mesasDisponiblesLiga nos informa sobre las mesas que se encuentran disponibles para ser ligadas.
*
* @return Vector <String> con el listado de las mesas disponibles.
*/
	public Vector<String> mesasDisponiblesLiga(int mesaMadre) throws SQLException, Exception {
		con = new ConexionBD();
		Vector <String> datosMLibres = new Vector <String>();
		try{
			ResultSet rs = null;
			String query = "SELECT IDMesa FROM mesas  WHERE IDMesa != "+mesaMadre +" AND Estatus = 0";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				String mesa = codifica(rs.getString("IDMesa"));
				if(mesa.equals("25")){
					mesa="B1";
				}
				else if(mesa.equals("26")){
					mesa="B2";
				}
				else if(mesa.equals("27")){
					mesa="B3";
				}
				else if(mesa.equals("28")){
					mesa="B4";
				}
				else if(mesa.equals("29")){
					mesa="B5";
				}
				datosMLibres.addElement(mesa);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, mesasDisponiblesLiga ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, mesasDisponiblesLiga ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, mesasDisponiblesLiga ");
					q.printStackTrace();
				}
			}
		}
		return datosMLibres;
	}


	public  double damePrecioUnitario(int genero, int division, int claveProducto, int tipo) throws SQLException, Exception {
		double precioU = 0.00;
		con2 = new ConexionBD();
		try{
			ResultSet rs = null;
			String query = "";
			if(genero == 1) {
				query = "SELECT precio FROM alimentos WHERE clave = "+claveProducto+" AND division = "+division +" AND estatus = 1";
			}
			else{
				if( tipo == 1)  { // POR COPA
					query = "SELECT (precioC)AS precio FROM bebidas WHERE clave = "+claveProducto+" AND division = "+division +" AND estatus = 1";
				}
				else if (tipo == 2 || tipo == 3 || tipo == 4) { // POR BOTELLA
					query ="SELECT (precioB1)AS precio1, (precioB2) AS precio2  FROM bebidas WHERE clave = "+claveProducto+" AND division = "+division +	" AND estatus = 1";
				}
			}
			Statement stmt =  con2.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				if(tipo == 1 || tipo == 0){
					precioU = rs.getDouble("precio");
				}
				else if(tipo == 2 || tipo == 3){
					if(rs.getDouble("precio1") > rs.getDouble("precio2")){
						precioU = rs.getDouble("precio1");
					}
					else{
						precioU = rs.getDouble("precio2");
					}
				}
				else{
					if(rs.getDouble("precio1") == 0.00){
						precioU = rs.getDouble("precio2");
					}
					else if(rs.getDouble("precio2") == 0.00){
						precioU = rs.getDouble("precio1");
					}
					else if(rs.getDouble("precio1") < rs.getDouble("precio2")){
						precioU = rs.getDouble("precio1");
					}
					else{
						precioU = rs.getDouble("precio2");
					}
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, damePrecioUnitario ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, damePrecioUnitario ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, damePrecioUnitario ");
					q.printStackTrace();
				}
			}
		}
		return precioU;
	}


	public String dameNombreProducto(int claveProducto,int genero) throws SQLException, Exception{
		con2 = new ConexionBD();
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
			Statement stmt =  con2.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				nombre = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameNombreProducto ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameNombreProducto ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameNombreProducto ");
					q.printStackTrace();
				}
			}
		}
		return nombre;
	}


	public ResultSet listadoAlimentos(int IDComanda, int IDConsecutivo) throws SQLException, Exception{
		con2 = new ConexionBD();
		ResultSet rs = null;
		try{
			int IDSecuencia = IDConsecutivo;
			String query = "SELECT (comandapro.IDC)AS IDComanda, (comanda.IDMM)AS Mesa, CONCAT(empleados.Nombre COLLATE latin1_spanish_ci, ' ', empleados.APaterno COLLATE latin1_spanish_ci)AS Nombre, SUM(comandapro.CanPro)AS Cantidad, (alimentos.nombre)AS Producto, (comandapro.Ob)AS Observacion, (comandapro.DiA)AS Fecha, (comandapro.HR)AS Hora FROM comandapro, comanda, empleados, alimentos WHERE comandapro.IDC = "+IDComanda +" AND comandapro.IDSecuencia = "+IDSecuencia +" AND comandapro.Tipo = 0 AND comandapro.Estatus = 1 AND comanda.IDC = comandapro.IDC AND empleados.IDEmpleado = comandapro.IDM AND alimentos.clave = comandapro.ClPro GROUP BY CONCAT(comandapro.ClPro,comandapro.Ob)";
			Statement stmt =  con2.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, listadoAlimentos ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, listadoAlimentos ");
			e.printStackTrace();
		}
		return rs;
	}



	public String dameNombreMateriaPrima(int claveMateria) throws SQLException, Exception{
		con2 = new ConexionBD();
		String nombre = "";
		try{
			ResultSet rs = null;
			String query = "";
			query = "SELECT nombre FROM materiaprima WHERE clave = "+claveMateria+" AND estatus = 1";
			Statement stmt =  con2.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				nombre = rs.getString("nombre");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameNombreMateriaPrima ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameNombreMateriaPrima ");
			e.printStackTrace();
		}
		finally{
			if(con2 != null){
				try{
					con2.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameNombreMateriaPrima ");
					q.printStackTrace();
				}
			}
		}
		return nombre;
	}


// -1 Error, 0-> Todo bien, 1 -> La mesa a Traspasar ya no esta disponible.
	@SuppressWarnings("unchecked")
	public synchronized int traspasaMesaA(int mesaID, String mesaATraspasar) throws SQLException, Exception{
		int resultado = 0;
		int mesaTargetID = cambiaAInt(cambiaAClaveBarra(mesaATraspasar));
		int estatusMesa = -1;
		ConexionBD conBD = new ConexionBD();
		if (conBD.miConnection != null) {
			try{
				conBD.cancelaAutoCommit();
				ResultSet rs = null;
				Statement stmt = conBD.creaStatement();
				String queryDatosMesaT = "SELECT Estatus FROM mesas WHERE IDMesa = "+mesaTargetID;
				rs= stmt.executeQuery(queryDatosMesaT);
				while (rs.next()){
					estatusMesa = rs.getInt("Estatus");
				}
// Mesa con estado ligado!, termino transaccion
				if(estatusMesa == 2){
					resultado = 1;
				}
				else{
// Mesa sin inicializar... perfecto!
					if (estatusMesa ==0){
// Actualiza tabla comanda
						PreparedStatement updateComanda;
						updateComanda = conBD.miConnection.prepareStatement ("UPDATE comanda SET IDMM = ? WHERE  IDMM = ? AND Es = 1");
						updateComanda.setInt(1, mesaTargetID);
						updateComanda.setInt(2, mesaID);
						updateComanda.execute();
// Actualiza estado de Mesa.
						PreparedStatement updateMesaNueva;
						updateMesaNueva = conBD.miConnection.prepareStatement ("UPDATE mesas SET Estatus = ? WHERE  IDMesa = ? ");
						updateMesaNueva.setInt(1, 1);
						updateMesaNueva.setInt(2, mesaTargetID);
						updateMesaNueva.execute();
					}
// La joda....  ya hay otras cuentas en curso.
					else{
						int IDCOrigen = 0;
						int IDCDestino = 0;
						int numComenDestino = 0;
						int numComenOrigen = 0;
// Obtengo Datos del Mesa Origen y Mesa Destino.
						ResultSet rsMOrigen = null;
						Statement st1 = conBD.creaStatement();
						String queryMOrigen = "SELECT IDC, NC, PT FROM comanda WHERE IDMM = "+mesaID +" AND Es = 1";
						rsMOrigen = st1.executeQuery(queryMOrigen);
						ResultSet rsMDestino = null;
						Statement st2 = conBD.creaStatement();
						String queryMDestino = "SELECT IDC, NC FROM comanda WHERE IDMM = "+mesaTargetID +" AND Es = 1";
						rsMDestino = st2.executeQuery(queryMDestino);
						while(rsMDestino.next()){
							IDCDestino = rsMDestino.getInt("IDC");
							numComenDestino = rsMDestino.getInt("NC");
						}
// Actualizo Mesa Destino
						while(rsMOrigen.next()){
							IDCOrigen = rsMOrigen.getInt("IDC");
							numComenOrigen  = rsMOrigen.getInt("NC");
							PreparedStatement actualizaComanda;
							actualizaComanda = conBD.miConnection.prepareStatement ("UPDATE comanda SET NC = (NC+?), PT = (PT + ?) WHERE IDC = ? AND Es = 1");
							actualizaComanda.setInt(1, rsMOrigen.getInt("NC"));
							actualizaComanda.setDouble(2, rsMOrigen.getDouble("PT"));
							actualizaComanda.setInt(3,IDCDestino);
							actualizaComanda.execute();
						}
// Actualizo Mesa Origen
						PreparedStatement actualizaComandaO;
						actualizaComandaO = conBD.miConnection.prepareStatement ("UPDATE comanda SET NC = ?, PT =  ?, Es = ? WHERE IDC = ? AND Es = 1");
						actualizaComandaO.setInt(1, 0);
						actualizaComandaO.setDouble(2, 0.00);
						actualizaComandaO.setInt(3,0);
						actualizaComandaO.setInt(4,IDCOrigen);
						actualizaComandaO.execute();
// Actualizo producto de comanda Origen.
						for(int i =1; i<=numComenOrigen; i++){
							PreparedStatement actualizaProductosO;
							actualizaProductosO = conBD.miConnection.prepareStatement ("UPDATE comandapro SET IDC = ?, IDCom =  ? 	WHERE IDC = ? AND Estatus = 1");
							actualizaProductosO.setInt(1, IDCDestino);
							actualizaProductosO.setInt(2, (i+numComenDestino));
							actualizaProductosO.setInt(3, IDCOrigen);
							actualizaProductosO.execute();
						}
					}
// Para ambos casos libero mesa original y mesas ligadas si es que existen.
						PreparedStatement liberaMesaML;
						liberaMesaML = conBD.miConnection.prepareStatement ("UPDATE mesas SET Estatus = ?, LigaA = ? WHERE  IDMesa = ? OR LigaA = ?");
						liberaMesaML.setInt(1, 0);
						liberaMesaML.setNull(2, java.sql.Types.INTEGER);
						liberaMesaML.setInt(3, mesaID);
						liberaMesaML.setInt(4, mesaID);
						liberaMesaML.execute();
				}
				conBD.realizaCommit();
			}
			catch (SQLException sqle) {
				resultado = -1;
				conBD.realizaRollback();
				System.out.println(	"Error SQL clase ManagerPuntoVenta, método traspasaMesaA: "+sqle);
				sqle.printStackTrace();
			}
			catch (Exception q){
				resultado = -1;
				conBD.realizaRollback();
				System.out.println(	"Error clase ManagerPuntoVenta, método traspasaMesaA: " +q);
				q.printStackTrace();
			}
			finally{
				try{
					conBD.habilitaAutoCommit();
					conBD.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComanda");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}


// COMANDA INTERNA ALMACENAMIENTO (PERSONAL)
	@SuppressWarnings("unchecked")
	public synchronized Vector<String> almacenaComandaInterna(Vector<Object>datos, int userID) throws SQLException, Exception{
		Vector<String>Incidencias = new Vector<String>();
		int claveBotana = 0;
// OBTENGO CLAVE DE BOTANAS.
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			claveBotana=cambiaAInt(config.getProperty("botanaCla").trim());
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		con5 = new ConexionBD();
		con5.cancelaAutoCommit();
		boolean noAlcanza = false;
		boolean noAlcanzaPrimeraSeccion = false;
		String noAlcanzaS = "";
		Savepoint puntoUpdateInventarioCombinadas = null;
		if (con5.miConnection != null) {
			try {
				ResultSet rs= null;
// AHORA GUARDO LA INFORMACIÓN EN MI TABLA TEMPORAL PARA SU VALIDACION.
// ITERO DE MI VECTOR.
				for(int i=0; i<datos.size(); i++){
					Vector<Object> temporal = (Vector)datos.elementAt(i);
					int cantidad = cambiaAInt((String)temporal.elementAt(0));
					String compuesta = ((String)temporal.elementAt(1));
					int genero = cambiaAInt(compuesta.substring(0,compuesta.indexOf('*')).trim());
					int division= cambiaAInt(compuesta.substring(compuesta.indexOf('*')+1,compuesta.lastIndexOf('*')).trim());
					int claveProducto =cambiaAInt(compuesta.substring(compuesta.lastIndexOf('*')+1, compuesta.length()).trim());
					String tipo = ((String)temporal.elementAt(3));
					int tamanioBebida = 1, formatoBebida = 0, mezclaBebida = 0, adicionalBebida = 0, cant1 = 0, cant2 = 0, cant3 = 0,  cant4 = 0, clavePC1 = 0, 					clavePC2 = 0, clavePC3 = 0, clavePC4 = 0, tipoBebC1 = 0, tipoBebC2 = 0, tipoBebC3 = 0, tipoBebC4 = 0;
					int tipoI = -1;
					if(tipo.equalsIgnoreCase("na")){
						tipoI = 0;		// Caso no Aplica
					}
					else if(tipo.equalsIgnoreCase("Copa")){
						tipoI = 1;  // Caso por copa
					}
					else if(tipo.equalsIgnoreCase("Botella")){
						tipoI = 2;  // Caso Botella
					}
					else if(tipo.equalsIgnoreCase("Botella G.")){
						tipoI = 3;  // Caso Botella
					}
					else if(tipo.equalsIgnoreCase("Botella P.")){
						tipoI = 4;  // Caso Botella
					}
					String observacion = ((String) temporal.elementAt(4));
// ES ALIMENTO Y BOTANA.
					if(tipoI == 0 && division == claveBotana){
						String componentes = ((String)temporal.elementAt(9));
						Vector<String> componeBotana = new Vector<String>();
						while(componentes.indexOf("\n") != -1){
							componeBotana.addElement(componentes.substring(0,componentes.indexOf("\n")));
							componentes = componentes.substring(componentes.indexOf("\n")+1, componentes.length());
						}
						componeBotana.addElement(componentes);
						for(int n=0; n<componeBotana.size(); n++){
							if(n == 0){
								clavePC1 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
							else if(n==1){
								clavePC2 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
							else if(n==2){
								clavePC3 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
							else if(n==3){
								clavePC4 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
						}
					}
// ES BEBIDA
					else if(tipoI !=0){
						String extractorVarios = ((String)temporal.elementAt(5));
						if(extractorVarios.equalsIgnoreCase("NA")){
							tamanioBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Sencillo")){
							tamanioBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Doble")){
							tamanioBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Triple")){
							tamanioBebida = 3;
						}
						extractorVarios = ((String)temporal.elementAt(6));
						if(extractorVarios.equalsIgnoreCase("NA")){
							formatoBebida = 0;
						}
						else if(extractorVarios.equalsIgnoreCase("Puesto")){
							formatoBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Divorciado")){
							formatoBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Derecho")){
							formatoBebida = 3;
						}
						else if(extractorVarios.equalsIgnoreCase("Rocas")){
							formatoBebida = 4;
						}
						else if(extractorVarios.equalsIgnoreCase("Chasser")){
							formatoBebida = 5;
						}
						extractorVarios = ((String)temporal.elementAt(7));
						if(extractorVarios.equalsIgnoreCase("NA")){
							mezclaBebida = 0;
						}
						else if(extractorVarios.equalsIgnoreCase("Ninguno")){
							mezclaBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Normal")){
							mezclaBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Campechano")){
							mezclaBebida = 3;
						}
						else if(extractorVarios.equalsIgnoreCase("Pintado")){
							mezclaBebida = 4;
						}
						extractorVarios = ((String)temporal.elementAt(8));
						if(extractorVarios.equalsIgnoreCase("No")){
							adicionalBebida = 0;
						}
						else if(extractorVarios.equalsIgnoreCase("C.Limon")){
							adicionalBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("C.Sangrita")){
							adicionalBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Cs.Lim.San.")){
							adicionalBebida = 3;
						}
						String componentes = ((String)temporal.elementAt(9));
						if(!componentes.equalsIgnoreCase("NA")){
							boolean variosCombinados = false;
							Vector <String> vDesglosa = new Vector<String>();
							while(componentes.indexOf("\n") != -1){
								variosCombinados = true;
								int cambiar = componentes.indexOf("\n");
								vDesglosa.addElement(componentes.substring(0,cambiar));
								componentes=componentes.substring(cambiar+1,componentes.length());
							}
							if(!variosCombinados){
								vDesglosa.addElement(componentes);
							}
							if(!vDesglosa.elementAt(0).trim().equalsIgnoreCase("")){
								for(int k = 0; k<vDesglosa.size();k++){
									if(k== 0){
										cant1 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC1 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC1 = 3;
										}
										else{
											tipoBebC1 = 4;
										}
									}
									else if(k== 1){
										cant2 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC2 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC2 = 3;
										}
										else{
											tipoBebC2 = 4;
										}
									}
									else if(k== 2){
										cant3 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC3 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC3 = 3;
										}
										else{
											tipoBebC3 = 4;
										}
									}
									else if(k== 3){
										cant4 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC4 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC4 = 3;
										}
										else{
											tipoBebC4 = 4;
										}
									}
								}
							}
						}
					}
					double precioUnitario = damePrecioUnitario(genero, division, claveProducto, tipoI);
					PreparedStatement updateAltaTemporalInterno;
					updateAltaTemporalInterno = con5.miConnection.prepareStatement("insert into tempinterno values(?,?,?,?,?,?,?,?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
					updateAltaTemporalInterno.setInt(1, userID);
					updateAltaTemporalInterno.setInt(2, division);
					updateAltaTemporalInterno.setInt(3, genero);
					updateAltaTemporalInterno.setInt(4, claveProducto);
					updateAltaTemporalInterno.setInt(5, tipoI);
					updateAltaTemporalInterno.setInt(6, cantidad);
					updateAltaTemporalInterno.setString(7, observacion);
					updateAltaTemporalInterno.setDouble(8, precioUnitario*tamanioBebida);
					updateAltaTemporalInterno.setDouble(9, (precioUnitario*tamanioBebida));
					updateAltaTemporalInterno.setInt(10, tamanioBebida);
					updateAltaTemporalInterno.setInt(11, formatoBebida);
					updateAltaTemporalInterno.setInt(12, mezclaBebida);
					updateAltaTemporalInterno.setInt(13, adicionalBebida);
					updateAltaTemporalInterno.setInt(14, cant1);
					updateAltaTemporalInterno.setInt(15, cant2);
					updateAltaTemporalInterno.setInt(16, cant3);
					updateAltaTemporalInterno.setInt(17, cant4);
					updateAltaTemporalInterno.setInt(18, clavePC1);
					updateAltaTemporalInterno.setInt(19, clavePC2);
					updateAltaTemporalInterno.setInt(20, clavePC3);
					updateAltaTemporalInterno.setInt(21, clavePC4);
					updateAltaTemporalInterno.setInt(22, tipoBebC1);
					updateAltaTemporalInterno.setInt(23, tipoBebC2);
					updateAltaTemporalInterno.setInt(24, tipoBebC3);
					updateAltaTemporalInterno.setInt(25, tipoBebC4);
					updateAltaTemporalInterno.execute();
				}
// Saco primero mi total de BEBIDAS COMBINADAS para saber si tengo en existencia las botellas de refresco/combinacion solicitadas.
				String querySumaCombinadas = "SELECT SUM(CantidadC)AS Cantidad, ClaveB AS claveProducto, TipoB AS Tipo, productoPadre FROM (SELECT IDCP AS productoPadre, CA1*CP AS CantidadC, CB1 AS ClaveB, TB1 AS TipoB FROM tempInterno WHERE IDPersonal = "+userID +"  AND IDG = 2 UNION ALL SELECT IDCP AS  productoPadre, CA2*CP AS CantidadC, CB2 AS ClaveB, TB2 AS TipoB FROM tempInterno WHERE IDPersonal = "+userID +"  AND IDG = 2 UNION ALL SELECT  IDCP AS productoPadre, CA3*CP AS CantidadC, CB3 AS ClaveB, TB3 AS TipoB FROM tempInterno WHERE IDPersonal = "+userID +"  AND IDG = 2 UNION ALL  SELECT IDCP AS productoPadre, CA4*CP AS CantidadC, CB4 AS ClaveB, TB4 AS TipoB FROM tempInterno WHERE IDPersonal = "+userID +"  AND IDG = 2) AS Temp WHERE ClaveB != 0 GROUP BY(CONCAT(productoPadre,ClaveB,TipoB))";
				Statement stCombinadas = con5.creaStatement();
				rs = stCombinadas.executeQuery(querySumaCombinadas);
				puntoUpdateInventarioCombinadas = con5.creaSavePoint("puntoUpdateInventarioCombinadas");
				while (rs.next() && !noAlcanza){
					int cantidadPedida = rs.getInt("Cantidad");
					String queryConformacionMP = "";
					String queryConsultaRestante = "";
					int resta = 0;
					double litrosXBotella = 0.00;
					ResultSet rs2 = null;
					ResultSet rs3 = null;
					ResultSet rsMini = null;
					String botellaTrabajada = "";
					Statement stUpdate = con5.creaStatement();
					Statement stUpdate2 = con5.creaStatement();
					Statement stAveriguaTipoB = con5.creaStatement();
// Se pidio una botella
					if(rs.getInt("tipo") == 3 || rs.getInt("tipo") == 4){
						int elTipoTemporal = rs.getInt("tipo");
// Obtengo componentes del Producto
						queryConformacionMP = "SELECT materia0 FROM bebidas WHERE clave = "+rs.getInt("claveProducto")+" AND estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						while(rs2.next()){
// Si fue una sola botella o botella grande
							String queryDiscriminadorBotella = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" +rs2.getInt("materia0") +" AND Estatus = 1";
							rsMini = stAveriguaTipoB.executeQuery(queryDiscriminadorBotella);
							while (rsMini.next()){
//								System.out.println("Litros1: "+rsMini.getDouble("litrosXBotella1") +", Litros2: "+ rsMini.getDouble("litrosXBotella2"));
								if(rs.getInt("tipo") == 2 || rs.getInt("tipo") == 3){ // Hablamos de botella única o Grande
									if(rsMini.getDouble("litrosXBotella1") >= rsMini.getDouble("litrosXBotella2") ){
										botellaTrabajada = "inventarioBotella1";
									}
									else{
										botellaTrabajada = "inventarioBotella2";
									}
								}
								else{ // Hablamos de botella pequeña
									if(rsMini.getDouble("litrosXBotella1") > rsMini.getDouble("litrosXBotella2") && rsMini.getDouble("litrosXBotella2") != 0.00 ){
										botellaTrabajada = "inventarioBotella2";
									}
									else{
										botellaTrabajada = "inventarioBotella1";
									}
								}
							}
							PreparedStatement updateBotellasInventario;
							updateBotellasInventario = con5.miConnection.prepareStatement ("UPDATE materiaprima SET "+botellaTrabajada +" = ("+botellaTrabajada +" - ?) WHERE  clave = ? AND Estatus = 1");
							updateBotellasInventario.setInt(1, cantidadPedida);
							updateBotellasInventario.setInt(2, rs2.getInt("materia0"));
							updateBotellasInventario.execute();
//							System.out.println(updateBotellasInventario.toString());
// Obtengo inventario despues de actualizacion
							queryConsultaRestante = "SELECT "+botellaTrabajada +" FROM materiaprima WHERE clave = "+ rs2.getInt("materia0")+	" AND tipo = 2 AND Estatus = 1";
							rs3 = stUpdate2.executeQuery(queryConsultaRestante);
							while (rs3.next()){
// Verifico si sobrepasa el inventario
								resta = rs3.getInt(botellaTrabajada);
							}
							if(resta < 0){
								noAlcanza = true;
								noAlcanzaPrimeraSeccion = true;
								String formatoBM = "Mediana";
								if(elTipoTemporal == 4){
									formatoBM = "Chica";
								}
								noAlcanzaS = "Me faltan:  "+resta*(-1)+ " botella(s) "+formatoBM+"  de "+dameNombreProducto(rs.getInt("claveProducto"),  2) +" para realizar la mezcla de "+dameNombreProducto(rs.getInt("productoPadre"),  2)+" en Inventario. \n Modifica la mezcla";
								Incidencias.addElement(noAlcanzaS);
							}
						}//Cierro While de RS2
					}
				}
// Saco totales por pedido para checar existencia/descarga en Inventario.
				String querySumarizado = "SELECT SUM(CP) AS Cantidad, IDCP AS ClaveProducto, IDT AS tipo FROM tempInterno WHERE IDPersonal = "+userID +" GROUP BY CONCAT(IDCP,IDD,IDT) ORDER BY  IDT DESC";
				Statement st2 = con5.creaStatement();
				rs = st2.executeQuery(querySumarizado);
				while (rs.next() && !noAlcanza){
// Pregunto cuanto pidio.
					int cantidadPedida = rs.getInt("Cantidad");
					String queryConformacionMP = "";
					String queryConsultaRestante = "";
					int resta = 0;
					double restaCopeo = 0.00;
					int botellaActual=0;
					double litrosXBotella = 0.00;
					ResultSet rs2 = null;
					ResultSet rs3 = null;
					ResultSet rsMini = null;
					String botellaTrabajada = "";
					Statement stUpdate = con5.creaStatement();
					Statement stUpdate2 = con5.creaStatement();
					Statement stAveriguaTipoB = con5.creaStatement();
// Se pidio una botella
					if(rs.getInt("tipo") == 2 || rs.getInt("tipo") == 3 || rs.getInt("tipo") == 4){
// Obtengo componentes del Producto
						queryConformacionMP = "SELECT materia0 FROM bebidas WHERE clave = "+rs.getInt("claveProducto")+" AND estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						while(rs2.next()){
// Si fue una sola botella o botella grande
							String queryDiscriminadorBotella = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" +rs2.getInt("materia0") +" AND Estatus = 1";
							rsMini = stAveriguaTipoB.executeQuery(queryDiscriminadorBotella);
							while (rsMini.next()){
//								System.out.println("Litros1: "+rsMini.getDouble("litrosXBotella1") +", Litros2: "+ rsMini.getDouble("litrosXBotella2"));
								if(rs.getInt("tipo") == 2 || rs.getInt("tipo") == 3){ // Hablamos de botella única o Grande
									if(rsMini.getDouble("litrosXBotella1") >= rsMini.getDouble("litrosXBotella2") ){
										botellaTrabajada = "inventarioBotella1";
									}
									else{
										botellaTrabajada = "inventarioBotella2";
									}
								}
								else{ // Hablamos de botella pequeña
									if(rsMini.getDouble("litrosXBotella1") > rsMini.getDouble("litrosXBotella2") && rsMini.getDouble("litrosXBotella2") != 0.00 ){
										botellaTrabajada = "inventarioBotella2";
									}
									else{
										botellaTrabajada = "inventarioBotella1";
									}
								}
							}
							PreparedStatement updateBotellasInventario;
							updateBotellasInventario = con5.miConnection.prepareStatement ("UPDATE materiaprima SET "+botellaTrabajada +" = ("+botellaTrabajada +" - ?) WHERE  clave = ? AND Estatus = 1");
							updateBotellasInventario.setInt(1, cantidadPedida);
							updateBotellasInventario.setInt(2, rs2.getInt("materia0"));
							updateBotellasInventario.execute();
//							System.out.println(updateBotellasInventario.toString());
// Obtengo inventario despues de actualizacion
							queryConsultaRestante = "SELECT "+botellaTrabajada +" FROM materiaprima WHERE clave = "+ rs2.getInt("materia0")+	" AND tipo = 2 AND Estatus = 1";
							rs3 = stUpdate2.executeQuery(queryConsultaRestante);
							while (rs3.next()){
// Verifico si sobrepasa el inventario
								resta = rs3.getInt(botellaTrabajada);
							}
							if(resta < 0){
								noAlcanza = true;
								noAlcanzaS = "Me quedo corto por:  "+resta*(-1)+ " botella(s) de "+dameNombreProducto(rs.getInt("ClaveProducto"),  2)+" en Inventario. \n Modifica tu comanda";
								Incidencias.addElement(noAlcanzaS);
							}
						}//Cierro While de RS2
					}	// Cierro opcion se trata de una botella
// Se pidio una copa
					else if(rs.getInt("tipo") == 1){
//						System.out.println("Entre a Se pidio una copa...");
// Obtengo componentes del Producto Tipo Copa:
						queryConformacionMP = "SELECT bebidas.materia0, bebidas.cantidad0, (a.tipo)AS tipo0, (a.tipoA)AS tipoA0, bebidas.materia1, bebidas.cantidad1, (b.tipo)AS tipo1, (b.tipoA)AS tipoA1, bebidas.materia2, bebidas.cantidad2, (c.tipo)AS tipo2, (c.tipoA)AS tipoA2, bebidas.materia3, bebidas.cantidad3, (d.tipo)AS tipo3, (d.tipoA)AS tipoA3, bebidas.materia4, bebidas.cantidad4, (e.tipo)AS tipo4, (e.tipoA)AS tipoA4, bebidas.materia5, bebidas.cantidad5, (f.tipo)AS tipo5, (f.tipoA)AS tipoA5, bebidas.materia6, bebidas.cantidad6, (g.tipo)AS tipo6, (g.tipoA)AS tipoA6, bebidas.materia7, bebidas.cantidad7, (h.tipo)AS tipo7, (h.tipoA)AS tipoA7, bebidas.materia8, bebidas.cantidad8, (i.tipo)AS tipo8, (i.tipoA)AS tipoA8, bebidas.materia9, bebidas.cantidad9, (j.tipo)AS tipo9, (j.tipoA)AS tipoA9 FROM ((((((((((bebidas LEFT JOIN  materiaprima a ON bebidas.materia0 = a.clave)LEFT JOIN materiaprima b ON bebidas.materia1 = b.clave)LEFT JOIN materiaprima c ON  bebidas.materia2 = c.clave) LEFT JOIN materiaprima d ON bebidas.materia3 = d.clave) LEFT JOIN materiaprima e ON bebidas.materia4 = e.clave) LEFT JOIN materiaprima f ON bebidas.materia5 = f.clave) LEFT JOIN materiaprima g ON bebidas.materia6 = g.clave) LEFT JOIN materiaprima h ON bebidas.materia7 = h.clave) LEFT JOIN materiaprima i ON bebidas.materia8 = i.clave) LEFT JOIN materiaprima j ON bebidas.materia9 = j.clave) WHERE bebidas.clave = "+rs.getInt("claveProducto")+"  AND bebidas.estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						int caso = 0;
						while(rs2.next()){
							int claveMP = 0;
							double cantidad=0.00;
							boolean entro = false;
							int tipoP = 0;
							int tipoM = 0;
							while (caso <10){
								if(caso == 0){
									claveMP = rs2.getInt("materia0");
									cantidad = rs2.getDouble("cantidad0");
									if(rs2.getString("tipo0") != null)
										tipoP = rs2.getInt("tipo0");
										tipoM = rs2.getInt("tipoA0");
								}
								else if(caso == 1){
									claveMP = rs2.getInt("materia1");
									cantidad = rs2.getDouble("cantidad1");
									if(rs2.getString("tipo1") != null)
										tipoP = rs2.getInt("tipo1");
										tipoM = rs2.getInt("tipoA1");
								}
								else if(caso == 2){
									claveMP = rs2.getInt("materia2");
									cantidad = rs2.getDouble("cantidad2");
									if(rs2.getString("tipo2") != null)
										tipoP = rs2.getInt("tipo2");
										tipoM = rs2.getInt("tipoA2");
								}
								else if(caso == 3){
									claveMP = rs2.getInt("materia3");
									cantidad = rs2.getDouble("cantidad3");
									if(rs2.getString("tipo3") != null)
										tipoP = rs2.getInt("tipo3");
										tipoM = rs2.getInt("tipoA3");
								}
								else if(caso == 4){
									claveMP = rs2.getInt("materia4");
									cantidad = rs2.getDouble("cantidad4");
									if(rs2.getString("tipo4") != null)
										tipoP = rs2.getInt("tipo4");
										tipoM = rs2.getInt("tipoA4");
								}
								else if(caso == 5){
									claveMP = rs2.getInt("materia5");
									cantidad = rs2.getDouble("cantidad5");
									if(rs2.getString("tipo5") != null)
										tipoP = rs2.getInt("tipo5");
										tipoM = rs2.getInt("tipoA5");
								}
								else if(caso == 6){
									claveMP = rs2.getInt("materia6");
									cantidad = rs2.getDouble("cantidad6");
									if(rs2.getString("tipo6") != null)
										tipoP = rs2.getInt("tipo6");
										tipoM = rs2.getInt("tipoA6");
								}
								else if(caso == 7){
									claveMP = rs2.getInt("materia7");
									cantidad = rs2.getDouble("cantidad7");
									if(rs2.getString("tipo7") != null)
										tipoP = rs2.getInt("tipo7");
										tipoM = rs2.getInt("tipoA7");
								}
								else if(caso == 8){
									claveMP = rs2.getInt("materia8");
									cantidad = rs2.getDouble("cantidad8");
									if(rs2.getString("tipo8") != null)
										tipoP = rs2.getInt("tipo8");
										tipoM = rs2.getInt("tipoA8");
								}
								else if(caso == 9){
									claveMP = rs2.getInt("materia9");
									cantidad = rs2.getDouble("cantidad9");
									if(rs2.getString("tipo9") != null)
										tipoP = rs2.getInt("tipo9");
										tipoM = rs2.getInt("tipoA9");
								}
								caso++;
								if(claveMP > 0){
									entro = true;
								}
								if (entro){
									entro = false;
// Actualizo inventario de componentes del Producto
									PreparedStatement updateMPCopas;
									if(tipoP == 1 && tipoM ==1) { // es alimento y ya esta dado por KG.
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento por Kilogramo, componente de materia prima de copa

									else if(tipoP == 1 && tipoM ==2) { // es alimento y esta dado en Unidades.., así que se debe refrescar
// Averiguo cuanto hay actualmente en Kg. del producto y cuanto trae cada unidad
										ResultSet rsInterino = null;
										Statement stInterino = con5.creaStatement();
										double kgActual = 0.00;
										double kgEnUnidad = 0.00;
										int unidadesExistentes = 0;
										String queryInterino = "SELECT KGXUnidad, inventarioKG, inventarioUnidad FROM materiaprima WHERE clave = "+claveMP +	" AND Estatus = 1";
										rsInterino = stInterino.executeQuery(queryInterino);
										while (rsInterino.next()){
											kgActual = rsInterino.getDouble("inventarioKG");
											kgEnUnidad = rsInterino.getDouble("KGXUnidad");
											unidadesExistentes = rsInterino.getInt("inventarioUnidad");
										}
										double gramosSolicitados = (cantidad * cantidadPedida);
										// Traspaso Unidades ya que no me alcanza con5 lo que hay actualmente en inventario por Kilogramos.
										if(gramosSolicitados > kgActual){
											gramosSolicitados -=kgActual;
											int seNecesitan = cambiaAInt(dameEnteros(Math.ceil(gramosSolicitados/kgActual)+""));
											// Si necesito más de lo que existe simplemente trasapaso lo máximo.
											if(seNecesitan > unidadesExistentes){
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = ? WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, unidadesExistentes * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, 0);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
											// Si me alcanza bien, solo traspaso lo necesario.
											else{
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = (inventarioUnidad - ?) WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, seNecesitan * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, seNecesitan);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
										}
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO, PERO SI DESCARGO DE UNIDADES.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento por Unidad, componente de materia prima de copa
									else{ // Es componente bebida...
//										System.out.println("Entre a esta copa tiene componente BEBIDA");
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
// Obtengo inventario despues de actualizacion
										queryConsultaRestante = "SELECT inventarioCopeo, inventarioBotella1, inventarioBotella2,  litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+ 	claveMP + " AND tipo = 2 AND Estatus = 1";
										rs3 = stUpdate2.executeQuery(queryConsultaRestante);
										boolean esUnaSolaBotella = false;
//										System.out.println("Voy a checar que bebidas lo componen....");
										while (rs3.next()){
											if(rs3.getDouble("litrosXBotella1")== 0.00 || rs3.getDouble("litrosXBotella2")==0.00 ){
//												System.out.println("Entre a es una sola botella.");
												esUnaSolaBotella = true;
											}
											// La Botella mas grande es la primera
											if(rs3.getDouble("litrosXBotella1") > rs3.getDouble("litrosXBotella2")){
//												System.out.println("Determine que la botella mas grande es la primera");
												restaCopeo = rs3.getDouble("inventarioCopeo");
												botellaActual = rs3.getInt("inventarioBotella1");
												litrosXBotella = rs3.getDouble("litrosXBotella1");
												botellaTrabajada = "inventarioBotella1";
											}
											else{
//												System.out.println("La botella mas grande es la segunda!");
// Verifico si sobrepasa el inventario
												restaCopeo = rs3.getDouble("inventarioCopeo");
												botellaActual = rs3.getInt("inventarioBotella2");
												litrosXBotella = rs3.getDouble("litrosXBotella2");
												botellaTrabajada = "inventarioBotella2";
											}
										}
										if(restaCopeo < 0){
//											System.out.println("Entre al no me alcanza con5 lo abierto... restaCopeo:" +restaCopeo);
											double botellasFaltantes = Math.ceil((restaCopeo*(-1))/litrosXBotella);
//											System.out.println("Botellas Faltantes: "+botellasFaltantes);
											int botellasATraspasar = cambiaAInt(dameEnteros(Math.ceil((restaCopeo*(-1))/litrosXBotella)+""));
//											System.out.println("Botellas a Traspasar: "+botellasATraspasar);
// No me alcanza con5 las botellas de inventario, así que checo si solo tengo un tamaño de botella..., si asi es ahí muere, sino saco botella pequeña y verifico si con5 eso ya me alcanza.
											if(esUnaSolaBotella && botellasFaltantes > botellaActual){
//												System.out.println("Solo hay de una botella y no alcanza.. así que PELAS!!");
												noAlcanza = true;
												noAlcanzaS = "Me quedo corto por:  "+(botellasFaltantes-botellaActual) + " botella(s) de:  "+dameNombreMateriaPrima(claveMP) +", para poder elaborar el producto por copa de: "+	dameNombreProducto(rs.getInt("ClaveProducto"), 2)+"\n Modifica tu orden de Compra";
												Incidencias.addElement(noAlcanzaS);
											}
											else if(!esUnaSolaBotella && botellasFaltantes > botellaActual){
//												System.out.println("Todavia hay oportunidad... , hay de otro tipo de botella y voy a investigar...");
// Obtengo datos de botella pequeña y checo si con5 eso me alcanza.
												int botellitasExistentes = 0;
												double litrosXBotellitas = 0.00;
												String botellitaChica = "";
												String queryConsultaBotellaPetit = "SELECT inventarioCopeo, inventarioBotella1, inventarioBotella2,  litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+ 	claveMP + " AND tipo = 2 AND Estatus = 1";
												rs3 = stUpdate2.executeQuery(queryConsultaBotellaPetit);
												while (rs3.next()){
													if(rs3.getDouble("litrosXBotella1") > rs3.getDouble("litrosXBotella2")){
														botellitaChica = "inventarioBotella2";
														botellitasExistentes = rs3.getInt("inventarioBotella2");
														litrosXBotellitas = rs3.getDouble("litrosXBotella2");
													}
													else{
														botellitaChica = "inventarioBotella1";
														botellitasExistentes = rs3.getInt("inventarioBotella1");
														litrosXBotellitas = rs3.getDouble("litrosXBotella1");
													}
												} // Cierro While de ResultSet rs3
//												System.out.println("Botellitas Exsitentes: " +botellitasExistentes);
//												System.out.println("Litros en Botellita: " +litrosXBotellitas);
												double litrosDisponibles = botellaActual*litrosXBotella;
//												System.out.println("Litros Disponibles1: " +litrosDisponibles +", --" +botellaActual +", " +litrosXBotella);
												litrosDisponibles += restaCopeo;
												double botellitasFaltantes =  Math.ceil((litrosDisponibles*(-1))/litrosXBotellitas);
												int botellitasATraspasar = cambiaAInt(dameEnteros(Math.ceil((litrosDisponibles*(-1))/litrosXBotellitas)+""));
//												System.out.println("Litros Disponibles2: " +litrosDisponibles);
//												System.out.println("Botellitas Faltantes: "+botellitasFaltantes);
//												System.out.println("Botellitas a Traspasar: " +botellitasATraspasar);
// Primer caso no me alcanza ni con5 botella pequeñas así que mato el proceso.
												if(botellitasFaltantes > botellitasExistentes){
//													System.out.println("No me alcanzo ni con5 las peques.. así que pelas!" +botellitasFaltantes +", >  "+botellitasExistentes);
													noAlcanza = true;
													noAlcanzaS = "Me quedo corto por:  "+(botellasFaltantes-botellaActual) + " botella(s) de:  "+dameNombreMateriaPrima(claveMP) +", para poder elaborar el producto por copa de: "+	dameNombreProducto(rs.getInt("ClaveProducto"), 2)+"\n Modifica tu orden de Compra";
													Incidencias.addElement(noAlcanzaS);
												}
// Si alcanza así que paso todas las botellas grandes y las pequeñas necesarias, ademas almaceno a traspasos.
												else{
//													System.out.println("Si me alcanza con5 las peques... voy a descontar");
													double nuevoInventario = (botellitasFaltantes*litrosXBotellitas) + (botellaActual*litrosXBotella);
//													System.out.println("Nuevo Inventario: " +nuevoInventario);
													PreparedStatement updateCopas;
													updateCopas = con5.miConnection.prepareStatement ("UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo+?) , "+botellaTrabajada +" = ("+botellaTrabajada+" - ?), "+botellitaChica +"= ("+botellitaChica+"- ?) WHERE  clave = ? AND Estatus = 1 ");
													updateCopas.setDouble(1, nuevoInventario);
													updateCopas.setInt(2, botellaActual);
													updateCopas.setInt(3, botellitasATraspasar);
													updateCopas.setInt(4, claveMP);
													updateCopas.execute();
//													System.out.println(updateCopas.toString());
// CREO UN REGISTRO DE QUE CREE UN INTERCAMBIO.
													TimeStamp tiempo2 = new TimeStamp();
													String fechaHoy = tiempo2.date;
													Date altaHoy = cambiaADate(fechaHoy);
													PreparedStatement updateTraspasoBotella;
													if(botellaActual > 0){
														updateTraspasoBotella = con5.miConnection.prepareStatement("insert into traspasoAutomatico values(?,?,?);");
														updateTraspasoBotella.setInt(1, botellaActual);
														updateTraspasoBotella.setInt(2, claveMP);
														updateTraspasoBotella.setDate(3, altaHoy);
														updateTraspasoBotella.execute();
													}
													updateTraspasoBotella = null;
													updateTraspasoBotella = con5.miConnection.prepareStatement("insert into traspasoAutomatico values(?,?,?);");
													updateTraspasoBotella.setInt(1, botellitasATraspasar);
													updateTraspasoBotella.setInt(2, claveMP);
													updateTraspasoBotella.setDate(3, altaHoy);
													updateTraspasoBotella.execute();
												}
											}// Cierro caso donde tambien verifico si me alcanza tomando botellas pequeñas.
											else{
//												System.out.println("Todo bien!, si me alcanza con5 las botellas grandes.., asi que descuento y aviso");
// COMO SI ME ALCANZA SACO BOTELLAS NECESARIAS DE INVENTARIO POR COPEO Y ACTUALIZO DONDE CORRESPONDA
												double nuevoInventario =botellasFaltantes*litrosXBotella;
												PreparedStatement updateCopas;
												updateCopas = con5.miConnection.prepareStatement ("UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo+?) , "+botellaTrabajada +" = ("+botellaTrabajada+" - ?) WHERE  clave = ? AND Estatus = 1 ");
												updateCopas.setDouble(1, nuevoInventario);
												updateCopas.setInt(2, botellasATraspasar);
												updateCopas.setInt(3, claveMP);
												updateCopas.execute();
// CREO UN REGISTRO DE QUE CREE UN INTERCAMBIO.
												TimeStamp tiempo2 = new TimeStamp();
												String fechaHoy = tiempo2.date;
												Date altaHoy = cambiaADate(fechaHoy);
												PreparedStatement updateTraspasoBotella;
												updateTraspasoBotella = con5.miConnection.prepareStatement("insert into traspasoAutomatico values(?,?,?);");
												updateTraspasoBotella.setInt(1, botellasATraspasar);
//												System.out.println("BotellasATraspasar: " +botellasATraspasar);
												updateTraspasoBotella.setInt(2, claveMP);
												updateTraspasoBotella.setDate(3, altaHoy);
												updateTraspasoBotella.execute();
											}
										}
									}
								}//Cierro Entra
							} // Cierro Caso
						}// Cierro ResultSet2
					}// Cierro caso Copa
// Se pidio un alimento
					else if(rs.getInt("tipo") == 0){
// Obtengo componentes del Producto
						queryConformacionMP = "SELECT alimentos.materia0, alimentos.cantidad0, (a.tipo)AS tipo0, (a.tipoA)AS tipoA0, alimentos.materia1, alimentos.cantidad1, (b.tipo)AS tipo1, (b.tipoA)AS tipoA1, alimentos.materia2, alimentos.cantidad2, (c.tipo)AS tipo2, (c.tipoA)AS tipoA2, alimentos.materia3, alimentos.cantidad3, (d.tipo)AS tipo3, (d.tipoA)AS tipoA3, alimentos.materia4, alimentos.cantidad4, (e.tipo)AS tipo4, (e.tipoA)AS tipoA4, alimentos.materia5, alimentos.cantidad5, (f.tipo)AS tipo5, (f.tipoA)AS tipoA5, alimentos.materia6, alimentos.cantidad6, (g.tipo)AS tipo6, (g.tipoA)AS tipoA6, alimentos.materia7, alimentos.cantidad7, (h.tipo)AS tipo7, (h.tipoA)AS tipoA7, alimentos.materia8, alimentos.cantidad8, (i.tipo)AS tipo8, (i.tipoA)AS tipoA8, alimentos.materia9, alimentos.cantidad9, (j.tipo)AS tipo9, (j.tipoA)AS tipoA9  FROM ((((((((((alimentos LEFT JOIN materiaprima a ON alimentos.materia0 = a.clave) LEFT JOIN materiaprima b ON alimentos.materia1 = b.clave)LEFT JOIN materiaprima c ON alimentos.materia2 = c.clave) LEFT JOIN materiaprima d ON alimentos.materia3= d.clave) LEFT JOIN materiaprima e ON alimentos.materia4 = e.clave) LEFT JOIN materiaprima f ON alimentos.materia5 = f.clave) LEFT JOIN materiaprima g ON alimentos.materia6 = g.clave) LEFT JOIN materiaprima h ON alimentos.materia7 = h.clave) LEFT JOIN materiaprima i ON alimentos.materia8 = i.clave) LEFT JOIN materiaprima j ON alimentos.materia9 = j.clave) WHERE alimentos.clave = "+rs.getInt("claveProducto")+"  AND alimentos.estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						int caso = 0;
						while(rs2.next()){
							int claveMP = 0;
							double cantidad=0.00;
							boolean entro = false;
							int tipoP = 0;
							int tipoM = 0;
							while (caso <10){
								if(caso == 0){
									claveMP = rs2.getInt("materia0");
									cantidad = rs2.getDouble("cantidad0");
									if(rs2.getString("tipo0") != null)
										tipoP = rs2.getInt("tipo0");
										tipoM = rs2.getInt("tipoA0");
								}
								else if(caso == 1){
									claveMP = rs2.getInt("materia1");
									cantidad = rs2.getDouble("cantidad1");
									if(rs2.getString("tipo1") != null)
										tipoP = rs2.getInt("tipo1");
										tipoM = rs2.getInt("tipoA1");
								}
								else if(caso == 2){
									claveMP = rs2.getInt("materia2");
									cantidad = rs2.getDouble("cantidad2");
									if(rs2.getString("tipo2") != null)
										tipoP = rs2.getInt("tipo2");
										tipoM = rs2.getInt("tipoA2");
								}
								else if(caso == 3){
									claveMP = rs2.getInt("materia3");
									cantidad = rs2.getDouble("cantidad3");
									if(rs2.getString("tipo3") != null)
										tipoP = rs2.getInt("tipo3");
										tipoM = rs2.getInt("tipoA3");
								}
								else if(caso == 4){
									claveMP = rs2.getInt("materia4");
									cantidad = rs2.getDouble("cantidad4");
									if(rs2.getString("tipo4") != null)
										tipoP = rs2.getInt("tipo4");
										tipoM = rs2.getInt("tipoA5");
								}
								else if(caso == 5){
									claveMP = rs2.getInt("materia5");
									cantidad = rs2.getDouble("cantidad5");
									if(rs2.getString("tipo5") != null)
										tipoP = rs2.getInt("tipo5");
										tipoM = rs2.getInt("tipoA6");
								}
								else if(caso == 6){
									claveMP = rs2.getInt("materia6");
									cantidad = rs2.getDouble("cantidad6");
									if(rs2.getString("tipo6") != null)
										tipoP = rs2.getInt("tipo6");
										tipoM = rs2.getInt("tipoA6");
								}
								else if(caso == 7){
									claveMP = rs2.getInt("materia7");
									cantidad = rs2.getDouble("cantidad7");
									if(rs2.getString("tipo7") != null)
										tipoP = rs2.getInt("tipo7");
										tipoM = rs2.getInt("tipoA7");
								}
								else if(caso == 8){
									claveMP = rs2.getInt("materia8");
									cantidad = rs2.getDouble("cantidad8");
									if(rs2.getString("tipo8") != null)
										tipoP = rs2.getInt("tipo8");
										tipoM = rs2.getInt("tipoA8");
								}
								else if(caso == 9){
									claveMP = rs2.getInt("materia9");
									cantidad = rs2.getDouble("cantidad9");
									if(rs2.getString("tipo9") != null)
										tipoP = rs2.getInt("tipo9");
										tipoM = rs2.getInt("tipoA9");
								}
								caso++;
								if(claveMP > 0){
									entro = true;
								}
								if (entro){
									entro = false;
// Actualizo inventario de componentes del Producto
									PreparedStatement updateMPCopas;
									if(tipoP == 1 && tipoM == 1) { // es alimento y esta ya dado solo por Kg.
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento componente de materia prima de copa
									else if(tipoP == 1 && tipoM ==2) { // es alimento y esta dado en Unidades.., así que se debe refrescar
// Averiguo cuanto hay actualmente en Kg. del producto y cuanto trae cada unidad
										ResultSet rsInterino = null;
										Statement stInterino = con5.creaStatement();
										double kgActual = 0.00;
										double kgEnUnidad = 0.00;
										int unidadesExistentes = 0;
										String queryInterino = "SELECT KGXUnidad, inventarioKG, inventarioUnidad FROM materiaprima WHERE clave = "+claveMP +	" AND Estatus = 1";
										rsInterino = stInterino.executeQuery(queryInterino);
										while (rsInterino.next()){
											kgActual = rsInterino.getDouble("inventarioKG");
											kgEnUnidad = rsInterino.getDouble("KGXUnidad");
											unidadesExistentes = rsInterino.getInt("inventarioUnidad");
										}
										double gramosSolicitados = (cantidad * cantidadPedida);
										// Traspaso Unidades ya que no me alcanza con5 lo que hay actualmente en inventario por Kilogramos.
										if(gramosSolicitados > kgActual){
											gramosSolicitados -=kgActual;
											int seNecesitan = cambiaAInt(dameEnteros(Math.ceil(gramosSolicitados/kgActual)+""));
											// Si necesito más de lo que existe simplemente trasapaso lo máximo.
											if(seNecesitan > unidadesExistentes){
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = ? WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, unidadesExistentes * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, 0);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
											// Si me alcanza bien, solo traspaso lo necesario.
											else{
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = (inventarioUnidad - ?) WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, seNecesitan * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, seNecesitan);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
										}
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO, PERO SI DESCARGO DE UNIDADES.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento por Unidad, componente de materia prima de alimento
									else{ // Es componente bebida...
										updateMPCopas = con5.miConnection.prepareStatement (				"UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}
								}
							}//Cierro Entra
						} // Cierro Caso
					}
				}
// Si HUBO PROBLEMAS POR INVENTARIOS REALIZO UN ROLLBACK
				if(noAlcanza){
					System.out.println("Existio un problema asi que hize RollBack");
					con5.realizaRollback(puntoUpdateInventarioCombinadas);
				}

// SI TODO BIEN GUARDO EN MI TABLA FORMAL, VERIFICO ACTUALIZO PRECIO TOTAL DE COMANDA Y MANDO IMPRIMIR
				else{
					rs = null;
					String queryCompleto = "SELECT * FROM tempInterno WHERE IDPersonal = "+userID +"  ORDER BY  IDT DESC";
//					System.out.println(queryCompleto);
					Statement stCompleto = con5.creaStatement();
					rs = stCompleto.executeQuery(queryCompleto);
					while(rs.next()){
						int cantidadSolicitada = rs.getInt("CP");
						tiempo = new TimeStamp();
						String fecha = tiempo.date;
						String hora = tiempo.time;
						Date altaD = cambiaADate(fecha);
						Time altaT = cambiaATiempo(hora);
						for(int j = 1; j<=cantidadSolicitada; j++){
							PreparedStatement updateAltaInternoProducto;
							updateAltaInternoProducto = con5.miConnection.prepareStatement("insert into internopro values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateAltaInternoProducto.setInt(1, userID);
							updateAltaInternoProducto.setTime(2, altaT);
							updateAltaInternoProducto.setDate(3, altaD);
							updateAltaInternoProducto.setInt(4, rs.getInt("IDG"));
							updateAltaInternoProducto.setInt(5, rs.getInt("IDD"));
							updateAltaInternoProducto.setInt(6, 1);
							updateAltaInternoProducto.setInt(7, rs.getInt("IDCP"));
							updateAltaInternoProducto.setDouble(8,rs.getInt("IDT"));
							updateAltaInternoProducto.setString(9,rs.getString("Ob"));
							updateAltaInternoProducto.setDouble(10,rs.getDouble("PU"));
							updateAltaInternoProducto.setDouble(11,rs.getDouble("PT"));
							updateAltaInternoProducto.setInt(12, 1);
							updateAltaInternoProducto.setInt(13, 0);
							updateAltaInternoProducto.setInt(14, rs.getInt("TB"));
							updateAltaInternoProducto.setInt(15, rs.getInt("FB"));
							updateAltaInternoProducto.setInt(16, rs.getInt("MB"));
							updateAltaInternoProducto.setInt(17, rs.getInt("AB"));
							updateAltaInternoProducto.setInt(18, rs.getInt("CA1"));
							updateAltaInternoProducto.setInt(19, rs.getInt("CA2"));
							updateAltaInternoProducto.setInt(20, rs.getInt("CA3"));
							updateAltaInternoProducto.setInt(21, rs.getInt("CA4"));
							updateAltaInternoProducto.setInt(22, rs.getInt("CB1"));
							updateAltaInternoProducto.setInt(23, rs.getInt("CB2"));
							updateAltaInternoProducto.setInt(24, rs.getInt("CB3"));
							updateAltaInternoProducto.setInt(25, rs.getInt("CB4"));
							updateAltaInternoProducto.setInt(26, rs.getInt("TB1"));
							updateAltaInternoProducto.setInt(27, rs.getInt("TB2"));
							updateAltaInternoProducto.setInt(28, rs.getInt("TB3"));
							updateAltaInternoProducto.setInt(29, rs.getInt("TB4"));
							updateAltaInternoProducto.execute();
						}
					}
					Incidencias.addElement("OK");
				}
// FINALMENTE ELIMINO MI TABLA TEMPORAL.
				String queryBorra = "DELETE FROM tempinterno WHERE IDPersonal = "+userID;
				Statement stmtB = con5.miConnection.createStatement();
				stmtB.execute(queryBorra);
				Incidencias.addElement("OK");
				con5.realizaCommit();
			}// Cierro try
			catch (SQLException sqle) {
				if(Incidencias.size() == 0){
					Incidencias.addElement("Error");
				}
				else{
					Incidencias.setElementAt("Error",0);
				}
				con5.realizaRollback();
				sqle.printStackTrace();
// Archivo Log..
				try{
					File fLog = new File("LogExSQLi.txt");
					fLog.createNewFile();
					StringBuffer lineaArchivo = new StringBuffer();
					FileWriter escritor = new FileWriter( fLog );
					BufferedWriter escritorBuff = new BufferedWriter( escritor );
					lineaArchivo.append(sqle.toString());
					StackTraceElement[] kioto = sqle.getStackTrace();
					for(int i=0; i<kioto.length; i++){
						lineaArchivo.append(kioto[i].toString());
					}
					lineaArchivo.append(sqle.getStackTrace());
					escritorBuff.write( lineaArchivo.toString(), 0, lineaArchivo.toString().length() );
					escritor.flush();
					escritorBuff.close();
				}
				catch (Exception e){
				}
				System.out.println(	"Error SQL clase ManagerPuntoVenta, método almacenaComandaInterna"+sqle);
			}
			catch (Exception q){
				if(Incidencias.size()== 0){
					Incidencias.addElement("Error");
				}
				else{
					Incidencias.setElementAt("Error",0);
				}
				con5.realizaRollback();
				q.printStackTrace();
// Archivo Log..
				try{
					File fLog = new File("LogExi.txt");
					fLog.createNewFile();
					StringBuffer lineaArchivo = new StringBuffer();
					FileWriter escritor = new FileWriter( fLog );
					BufferedWriter escritorBuff = new BufferedWriter( escritor );
					lineaArchivo.append(q.toString());
					StackTraceElement[] kioto = q.getStackTrace();
					for(int i=0; i<kioto.length; i++){
						lineaArchivo.append(kioto[i].toString());
					}
					lineaArchivo.append(q.getStackTrace());
					escritorBuff.write( lineaArchivo.toString(), 0, lineaArchivo.toString().length() );
					escritor.flush();
					escritorBuff.close();
				}
				catch (Exception e){
				}
				System.out.println("Error clase ManagerPuntoVenta, método almacenaComandaInterna");
			}
			finally{
				try{
					con5.realizaCommit();
					con5.habilitaAutoCommit();
					con5.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComandaInterna");
					q.printStackTrace();
				}
			}
		}
		// MANDO IMPRIMIR
		ImpresionTicketComidaI itc = new ImpresionTicketComidaI(userID);
		ImpresionTicketBebidaI itb = new ImpresionTicketBebidaI(userID);
		System.out.println("Regreso en Vector Incidencias:");
		for(int i=0; i<Incidencias.size(); i++){
			System.out.println("Elemento: "+i +", contiene -- "+Incidencias.elementAt(i));
		}
		return Incidencias;
	}
// FINALIZA COMANDA INTERNA ALMACENAMIENTO (PERSONAL)



// COMANDA ALMACENAMIENTO (CLIENTES-MESAS)
	@SuppressWarnings("unchecked")
	public synchronized Vector<String> almacenaComanda(int mesaID, Vector<Object>datos, int userID) throws SQLException, Exception{
		Vector<String>Incidencias = new Vector<String>();
		int claveBotana = 0;
// OBTENGO CLAVE DE BOTANAS.
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			claveBotana=cambiaAInt(config.getProperty("botanaCla").trim());
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		con5 = new ConexionBD();
		con5.cancelaAutoCommit();
		boolean noAlcanza = false;
		String noAlcanzaS = "";
		Savepoint puntoUpdateInventarioCombinadas = null;
		int IDComanda = -1;
		if (con5.miConnection != null) {
			try {
				ResultSet rs= null;
// PRIMERO OBTENGO EL IDENTIFICADOR DE LA COMANDA.
				String queryDameNumComanda = "SELECT IDC FROM comanda WHERE IDMM = "+mesaID +" AND Es = 1";
				Statement st1 = con5.creaStatement();
				rs = st1.executeQuery(queryDameNumComanda);
				while (rs.next()){
					IDComanda = rs.getInt("IDC");
				}
// AHORA GUARDO LA INFORMACIÓN EN MI TABLA TEMPORAL PARA SU VALIDACION.
// ITERO DE MI VECTOR.
				for(int i=0; i<datos.size(); i++){
					Vector<Object> temporal = (Vector)datos.elementAt(i);
					int cantidad = cambiaAInt((String)temporal.elementAt(0));
					String compuesta = ((String)temporal.elementAt(1));
					int genero = cambiaAInt(compuesta.substring(0,compuesta.indexOf('*')).trim());
					int division= cambiaAInt(compuesta.substring(compuesta.indexOf('*')+1,compuesta.lastIndexOf('*')).trim());
					int claveProducto =cambiaAInt(compuesta.substring(compuesta.lastIndexOf('*')+1, compuesta.length()).trim());
					int comensal = cambiaAInt((String) temporal.elementAt(2));
					String tipo = ((String)temporal.elementAt(4));
					int tamanioBebida = 1, formatoBebida = 0, mezclaBebida = 0, adicionalBebida = 0, cant1 = 0, cant2 = 0, cant3 = 0,  cant4 = 0, clavePC1 = 0, 					clavePC2 = 0, clavePC3 = 0, clavePC4 = 0, tipoBebC1 = 0, tipoBebC2 = 0, tipoBebC3 = 0, tipoBebC4 = 0;
					int tipoI = -1;
					if(tipo.equalsIgnoreCase("na")){
						tipoI = 0;		// Caso no Aplica
					}
					else if(tipo.equalsIgnoreCase("Copa")){
						tipoI = 1;  // Caso por copa
					}
					else if(tipo.equalsIgnoreCase("Botella")){
						tipoI = 2;  // Caso Botella
					}
					else if(tipo.equalsIgnoreCase("Botella G.")){
						tipoI = 3;  // Caso Botella
					}
					else if(tipo.equalsIgnoreCase("Botella P.")){
						tipoI = 4;  // Caso Botella
					}
					String observacion = ((String) temporal.elementAt(5));
// ES ALIMENTO Y BOTANA.
					if(tipoI == 0 && division == claveBotana){
						String componentes = ((String)temporal.elementAt(10));
						Vector<String> componeBotana = new Vector<String>();
						while(componentes.indexOf("\n") != -1){
							componeBotana.addElement(componentes.substring(0,componentes.indexOf("\n")));
							componentes = componentes.substring(componentes.indexOf("\n")+1, componentes.length());
						}
						componeBotana.addElement(componentes);
						for(int n=0; n<componeBotana.size(); n++){
							if(n == 0){
								clavePC1 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
							else if(n==1){
								clavePC2 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
							else if(n==2){
								clavePC3 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
							else if(n==3){
								clavePC4 = cambiaAInt(componeBotana.elementAt(n).substring(componeBotana.elementAt(n).indexOf("*")+1, componeBotana.elementAt(n).length()).trim());
							}
						}
					}
// ES BEBIDA
					else if(tipoI !=0){
						String extractorVarios = ((String)temporal.elementAt(6));
						if(extractorVarios.equalsIgnoreCase("NA")){
							tamanioBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Sencillo")){
							tamanioBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Doble")){
							tamanioBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Triple")){
							tamanioBebida = 3;
						}
						extractorVarios = ((String)temporal.elementAt(7));
						if(extractorVarios.equalsIgnoreCase("NA")){
							formatoBebida = 0;
						}
						else if(extractorVarios.equalsIgnoreCase("Puesto")){
							formatoBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Divorciado")){
							formatoBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Derecho")){
							formatoBebida = 3;
						}
						else if(extractorVarios.equalsIgnoreCase("Rocas")){
							formatoBebida = 4;
						}
						else if(extractorVarios.equalsIgnoreCase("Chasser")){
							formatoBebida = 5;
						}
						extractorVarios = ((String)temporal.elementAt(8));
						if(extractorVarios.equalsIgnoreCase("NA")){
							mezclaBebida = 0;
						}
						else if(extractorVarios.equalsIgnoreCase("Ninguno")){
							mezclaBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("Normal")){
							mezclaBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Campechano")){
							mezclaBebida = 3;
						}
						else if(extractorVarios.equalsIgnoreCase("Pintado")){
							mezclaBebida = 4;
						}
						extractorVarios = ((String)temporal.elementAt(9));
						if(extractorVarios.equalsIgnoreCase("No")){
							adicionalBebida = 0;
						}
						else if(extractorVarios.equalsIgnoreCase("C.Limon")){
							adicionalBebida = 1;
						}
						else if(extractorVarios.equalsIgnoreCase("C.Sangrita")){
							adicionalBebida = 2;
						}
						else if(extractorVarios.equalsIgnoreCase("Cs.Lim.San.")){
							adicionalBebida = 3;
						}
						String componentes = ((String)temporal.elementAt(10));
						if(!componentes.equalsIgnoreCase("NA")){
							boolean variosCombinados = false;
							Vector <String> vDesglosa = new Vector<String>();
							while(componentes.indexOf("\n") != -1){
								variosCombinados = true;
								int cambiar = componentes.indexOf("\n");
								vDesglosa.addElement(componentes.substring(0,cambiar));
								componentes=componentes.substring(cambiar+1,componentes.length());
							}
							if(!variosCombinados){
								vDesglosa.addElement(componentes);
							}
							if(!vDesglosa.elementAt(0).trim().equalsIgnoreCase("")){
								for(int k = 0; k<vDesglosa.size();k++){
									if(k== 0){
										cant1 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC1 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC1 = 3;
										}
										else{
											tipoBebC1 = 4;
										}
									}
									else if(k== 1){
										cant2 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC2 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC2 = 3;
										}
										else{
											tipoBebC2 = 4;
										}
									}
									else if(k== 2){
										cant3 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC3 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC3 = 3;
										}
										else{
											tipoBebC3 = 4;
										}
									}
									else if(k== 3){
										cant4 = cambiaAInt(vDesglosa.elementAt(k).substring(0,vDesglosa.elementAt(k).indexOf("-")).trim());
										clavePC4 = cambiaAInt(vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")+1,vDesglosa.elementAt(k).	length()).trim());
										String tipoPetit = vDesglosa.elementAt(k).substring(vDesglosa.elementAt(k).lastIndexOf("*")-3,vDesglosa.elementAt(k).lastIndexOf(	"*")-2).trim();
										if(tipoPetit.equalsIgnoreCase("M")){
											tipoBebC4 = 3;
										}
										else{
											tipoBebC4 = 4;
										}
									}
								}
							}
						}
					}
					double precioUnitario = damePrecioUnitario(genero, division, claveProducto, tipoI);
					PreparedStatement updateAltaTemporalComanda;
					updateAltaTemporalComanda = con5.miConnection.prepareStatement("insert into tempcom values(?,?,?,?,?,?,?,?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
					updateAltaTemporalComanda.setInt(1, IDComanda);
					updateAltaTemporalComanda.setInt(2, userID);
					updateAltaTemporalComanda.setInt(3, division);
					updateAltaTemporalComanda.setInt(4, genero);
					updateAltaTemporalComanda.setInt(5, claveProducto);
					updateAltaTemporalComanda.setInt(6, tipoI);
					updateAltaTemporalComanda.setInt(7, cantidad);
					updateAltaTemporalComanda.setInt(8, comensal);
					updateAltaTemporalComanda.setString(9, observacion);
					updateAltaTemporalComanda.setDouble(10, precioUnitario*tamanioBebida);
					updateAltaTemporalComanda.setDouble(11, (precioUnitario*tamanioBebida));
					updateAltaTemporalComanda.setInt(12, tamanioBebida);
					updateAltaTemporalComanda.setInt(13, formatoBebida);
					updateAltaTemporalComanda.setInt(14, mezclaBebida);
					updateAltaTemporalComanda.setInt(15, adicionalBebida);
					updateAltaTemporalComanda.setInt(16, cant1);
					updateAltaTemporalComanda.setInt(17, cant2);
					updateAltaTemporalComanda.setInt(18, cant3);
					updateAltaTemporalComanda.setInt(19, cant4);
					updateAltaTemporalComanda.setInt(20, clavePC1);
					updateAltaTemporalComanda.setInt(21, clavePC2);
					updateAltaTemporalComanda.setInt(22, clavePC3);
					updateAltaTemporalComanda.setInt(23, clavePC4);
					updateAltaTemporalComanda.setInt(24, tipoBebC1);
					updateAltaTemporalComanda.setInt(25, tipoBebC2);
					updateAltaTemporalComanda.setInt(26, tipoBebC3);
					updateAltaTemporalComanda.setInt(27, tipoBebC4);
					updateAltaTemporalComanda.execute();
				}
// Saco primero mi total de BEBIDAS COMBINADAS para saber si tengo en existencia las botellas de refresco solicitadas.
				String querySumaCombinadas = "SELECT SUM(CantidadC)AS Cantidad, ClaveB AS claveProducto, TipoB AS Tipo, productoPadre FROM (SELECT IDCP AS productoPadre, CA1*CP AS CantidadC, CB1 AS ClaveB, TB1 AS TipoB FROM tempcom WHERE IDC = "+IDComanda +"  AND IDG = 2 UNION ALL SELECT IDCP AS  productoPadre, CA2*CP AS CantidadC, CB2 AS ClaveB, TB2 AS TipoB FROM tempcom WHERE IDC = "+IDComanda +"  AND IDG = 2 UNION ALL SELECT  IDCP AS productoPadre, CA3*CP AS CantidadC, CB3 AS ClaveB, TB3 AS TipoB FROM tempcom WHERE IDC = "+IDComanda +"  AND IDG = 2 UNION ALL  SELECT IDCP AS productoPadre, CA4*CP AS CantidadC, CB4 AS ClaveB, TB4 AS TipoB FROM tempcom WHERE IDC = "+IDComanda +"  AND IDG = 2) AS Temp WHERE ClaveB != 0 GROUP BY(CONCAT(productoPadre,ClaveB,TipoB))";
				Statement stCombinadas = con5.creaStatement();
				rs = stCombinadas.executeQuery(querySumaCombinadas);
				puntoUpdateInventarioCombinadas = con5.creaSavePoint("puntoUpdateInventarioCombinadas");
				while (rs.next() && !noAlcanza){
					int cantidadPedida = rs.getInt("Cantidad");
					String queryConformacionMP = "";
					String queryConsultaRestante = "";
					int resta = 0;
					double litrosXBotella = 0.00;
					ResultSet rs2 = null;
					ResultSet rs3 = null;
					ResultSet rsMini = null;
					String botellaTrabajada = "";
					Statement stUpdate = con5.creaStatement();
					Statement stUpdate2 = con5.creaStatement();
					Statement stAveriguaTipoB = con5.creaStatement();
// Se pidio una botella
					if(rs.getInt("tipo") == 3 || rs.getInt("tipo") == 4){
						int elTipoTemporal = rs.getInt("tipo");
// Obtengo componentes del Producto
						queryConformacionMP = "SELECT materia0 FROM bebidas WHERE clave = "+rs.getInt("claveProducto")+" AND estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						while(rs2.next()){
// Si fue una sola botella o botella grande
							String queryDiscriminadorBotella = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" +rs2.getInt("materia0") +" AND Estatus = 1";
							rsMini = stAveriguaTipoB.executeQuery(queryDiscriminadorBotella);
							while (rsMini.next()){
//								System.out.println("Litros1: "+rsMini.getDouble("litrosXBotella1") +", Litros2: "+ rsMini.getDouble("litrosXBotella2"));
								if(rs.getInt("tipo") == 2 || rs.getInt("tipo") == 3){ // Hablamos de botella única o Grande
									if(rsMini.getDouble("litrosXBotella1") >= rsMini.getDouble("litrosXBotella2") ){
										botellaTrabajada = "inventarioBotella1";
									}
									else{
										botellaTrabajada = "inventarioBotella2";
									}
								}
								else{ // Hablamos de botella pequeña
									if(rsMini.getDouble("litrosXBotella1") > rsMini.getDouble("litrosXBotella2") && rsMini.getDouble("litrosXBotella2") != 0.00 ){
										botellaTrabajada = "inventarioBotella2";
									}
									else{
										botellaTrabajada = "inventarioBotella1";
									}
								}
							}
							PreparedStatement updateBotellasInventario;
							updateBotellasInventario = con5.miConnection.prepareStatement ("UPDATE materiaprima SET "+botellaTrabajada +" = ("+botellaTrabajada +" - ?) WHERE  clave = ? AND Estatus = 1");
							updateBotellasInventario.setInt(1, cantidadPedida);
							updateBotellasInventario.setInt(2, rs2.getInt("materia0"));
							updateBotellasInventario.execute();
//							System.out.println(updateBotellasInventario.toString());
// Obtengo inventario despues de actualizacion
							queryConsultaRestante = "SELECT "+botellaTrabajada +" FROM materiaprima WHERE clave = "+ rs2.getInt("materia0")+	" AND tipo = 2 AND Estatus = 1";
							rs3 = stUpdate2.executeQuery(queryConsultaRestante);
							while (rs3.next()){
// Verifico si sobrepasa el inventario
								resta = rs3.getInt(botellaTrabajada);
							}
							if(resta < 0){
								noAlcanza = true;
								String formatoBM = "Mediana";
								if(elTipoTemporal == 4){
									formatoBM = "Chica";
								}
								noAlcanzaS = "Me faltan:  "+resta*(-1)+ " botella(s) "+formatoBM+"  de "+dameNombreProducto(rs.getInt("claveProducto"),  2) +" para realizar la mezcla de "+dameNombreProducto(rs.getInt("productoPadre"),  2)+" en Inventario. \n Modifica la mezcla";
								Incidencias.addElement(noAlcanzaS);
							}
						}//Cierro While de RS2
					}
				}
// Saco totales por pedido para checar existencia/descarga en Inventario.
				String querySumarizado = "SELECT SUM(CP) AS Cantidad, IDCP AS ClaveProducto, IDT AS tipo FROM tempcom WHERE IDC = "+IDComanda +" GROUP BY CONCAT(IDCP,IDD,IDT) ORDER BY  IDT DESC";
				Statement st2 = con5.creaStatement();
				rs = st2.executeQuery(querySumarizado);
				while (rs.next() && !noAlcanza){
// Pregunto cuanto pidio.
					int cantidadPedida = rs.getInt("Cantidad");
					String queryConformacionMP = "";
					String queryConsultaRestante = "";
					int resta = 0;
					double restaCopeo = 0.00;
					int botellaActual=0;
					double litrosXBotella = 0.00;
					ResultSet rs2 = null;
					ResultSet rs3 = null;
					ResultSet rsMini = null;
					String botellaTrabajada = "";
					Statement stUpdate = con5.creaStatement();
					Statement stUpdate2 = con5.creaStatement();
					Statement stAveriguaTipoB = con5.creaStatement();
// Se pidio una botella
					if(rs.getInt("tipo") == 2 || rs.getInt("tipo") == 3 || rs.getInt("tipo") == 4){
// Obtengo componentes del Producto
						queryConformacionMP = "SELECT materia0 FROM bebidas WHERE clave = "+rs.getInt("claveProducto")+" AND estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						while(rs2.next()){
// Si fue una sola botella o botella grande
							String queryDiscriminadorBotella = "SELECT litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE  clave =" +rs2.getInt("materia0") +" AND Estatus = 1";
							rsMini = stAveriguaTipoB.executeQuery(queryDiscriminadorBotella);
							while (rsMini.next()){
//								System.out.println("Litros1: "+rsMini.getDouble("litrosXBotella1") +", Litros2: "+ rsMini.getDouble("litrosXBotella2"));
								if(rs.getInt("tipo") == 2 || rs.getInt("tipo") == 3){ // Hablamos de botella única o Grande
									if(rsMini.getDouble("litrosXBotella1") >= rsMini.getDouble("litrosXBotella2") ){
										botellaTrabajada = "inventarioBotella1";
									}
									else{
										botellaTrabajada = "inventarioBotella2";
									}
								}
								else{ // Hablamos de botella pequeña
									if(rsMini.getDouble("litrosXBotella1") > rsMini.getDouble("litrosXBotella2") && rsMini.getDouble("litrosXBotella2") != 0.00 ){
										botellaTrabajada = "inventarioBotella2";
									}
									else{
										botellaTrabajada = "inventarioBotella1";
									}
								}
							}
							PreparedStatement updateBotellasInventario;
							updateBotellasInventario = con5.miConnection.prepareStatement ("UPDATE materiaprima SET "+botellaTrabajada +" = ("+botellaTrabajada +" - ?) WHERE  clave = ? AND Estatus = 1");
							updateBotellasInventario.setInt(1, cantidadPedida);
							updateBotellasInventario.setInt(2, rs2.getInt("materia0"));
							updateBotellasInventario.execute();
//							System.out.println(updateBotellasInventario.toString());
// Obtengo inventario despues de actualizacion
							queryConsultaRestante = "SELECT "+botellaTrabajada +" FROM materiaprima WHERE clave = "+ rs2.getInt("materia0")+	" AND tipo = 2 AND Estatus = 1";
							rs3 = stUpdate2.executeQuery(queryConsultaRestante);
							while (rs3.next()){
// Verifico si sobrepasa el inventario
								resta = rs3.getInt(botellaTrabajada);
							}
							if(resta < 0){
								noAlcanza = true;
								noAlcanzaS = "Me quedo corto por:  "+resta*(-1)+ " botella(s) de "+dameNombreProducto(rs.getInt("ClaveProducto"),  2)+" en Inventario. \n Modifica tu comanda";
								Incidencias.addElement(noAlcanzaS);
							}
						}//Cierro While de RS2
					}	// Cierro opcion se trata de una botella
// Se pidio una copa
					else if(rs.getInt("tipo") == 1){
//						System.out.println("Entre a Se pidio una copa...");
// Obtengo componentes del Producto Tipo Copa:
						queryConformacionMP = "SELECT bebidas.materia0, bebidas.cantidad0, (a.tipo)AS tipo0, (a.tipoA)AS tipoA0, bebidas.materia1, bebidas.cantidad1, (b.tipo)AS tipo1, (b.tipoA)AS tipoA1, bebidas.materia2, bebidas.cantidad2, (c.tipo)AS tipo2, (c.tipoA)AS tipoA2, bebidas.materia3, bebidas.cantidad3, (d.tipo)AS tipo3, (d.tipoA)AS tipoA3, bebidas.materia4, bebidas.cantidad4, (e.tipo)AS tipo4, (e.tipoA)AS tipoA4, bebidas.materia5, bebidas.cantidad5, (f.tipo)AS tipo5, (f.tipoA)AS tipoA5, bebidas.materia6, bebidas.cantidad6, (g.tipo)AS tipo6, (g.tipoA)AS tipoA6, bebidas.materia7, bebidas.cantidad7, (h.tipo)AS tipo7, (h.tipoA)AS tipoA7, bebidas.materia8, bebidas.cantidad8, (i.tipo)AS tipo8, (i.tipoA)AS tipoA8, bebidas.materia9, bebidas.cantidad9, (j.tipo)AS tipo9, (j.tipoA)AS tipoA9 FROM ((((((((((bebidas LEFT JOIN  materiaprima a ON bebidas.materia0 = a.clave)LEFT JOIN materiaprima b ON bebidas.materia1 = b.clave)LEFT JOIN materiaprima c ON  bebidas.materia2 = c.clave) LEFT JOIN materiaprima d ON bebidas.materia3 = d.clave) LEFT JOIN materiaprima e ON bebidas.materia4 = e.clave) LEFT JOIN materiaprima f ON bebidas.materia5 = f.clave) LEFT JOIN materiaprima g ON bebidas.materia6 = g.clave) LEFT JOIN materiaprima h ON bebidas.materia7 = h.clave) LEFT JOIN materiaprima i ON bebidas.materia8 = i.clave) LEFT JOIN materiaprima j ON bebidas.materia9 = j.clave) WHERE bebidas.clave = "+rs.getInt("claveProducto")+"  AND bebidas.estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						int caso = 0;
						while(rs2.next()){
							int claveMP = 0;
							double cantidad=0.00;
							boolean entro = false;
							int tipoP = 0;
							int tipoM = 0;
							while (caso <10){
								if(caso == 0){
									claveMP = rs2.getInt("materia0");
									cantidad = rs2.getDouble("cantidad0");
									if(rs2.getString("tipo0") != null)
										tipoP = rs2.getInt("tipo0");
										tipoM = rs2.getInt("tipoA0");
								}
								else if(caso == 1){
									claveMP = rs2.getInt("materia1");
									cantidad = rs2.getDouble("cantidad1");
									if(rs2.getString("tipo1") != null)
										tipoP = rs2.getInt("tipo1");
										tipoM = rs2.getInt("tipoA1");
								}
								else if(caso == 2){
									claveMP = rs2.getInt("materia2");
									cantidad = rs2.getDouble("cantidad2");
									if(rs2.getString("tipo2") != null)
										tipoP = rs2.getInt("tipo2");
										tipoM = rs2.getInt("tipoA2");
								}
								else if(caso == 3){
									claveMP = rs2.getInt("materia3");
									cantidad = rs2.getDouble("cantidad3");
									if(rs2.getString("tipo3") != null)
										tipoP = rs2.getInt("tipo3");
										tipoM = rs2.getInt("tipoA3");
								}
								else if(caso == 4){
									claveMP = rs2.getInt("materia4");
									cantidad = rs2.getDouble("cantidad4");
									if(rs2.getString("tipo4") != null)
										tipoP = rs2.getInt("tipo4");
										tipoM = rs2.getInt("tipoA4");
								}
								else if(caso == 5){
									claveMP = rs2.getInt("materia5");
									cantidad = rs2.getDouble("cantidad5");
									if(rs2.getString("tipo5") != null)
										tipoP = rs2.getInt("tipo5");
										tipoM = rs2.getInt("tipoA5");
								}
								else if(caso == 6){
									claveMP = rs2.getInt("materia6");
									cantidad = rs2.getDouble("cantidad6");
									if(rs2.getString("tipo6") != null)
										tipoP = rs2.getInt("tipo6");
										tipoM = rs2.getInt("tipoA6");
								}
								else if(caso == 7){
									claveMP = rs2.getInt("materia7");
									cantidad = rs2.getDouble("cantidad7");
									if(rs2.getString("tipo7") != null)
										tipoP = rs2.getInt("tipo7");
										tipoM = rs2.getInt("tipoA7");
								}
								else if(caso == 8){
									claveMP = rs2.getInt("materia8");
									cantidad = rs2.getDouble("cantidad8");
									if(rs2.getString("tipo8") != null)
										tipoP = rs2.getInt("tipo8");
										tipoM = rs2.getInt("tipoA8");
								}
								else if(caso == 9){
									claveMP = rs2.getInt("materia9");
									cantidad = rs2.getDouble("cantidad9");
									if(rs2.getString("tipo9") != null)
										tipoP = rs2.getInt("tipo9");
										tipoM = rs2.getInt("tipoA9");
								}
								caso++;
								if(claveMP > 0){
									entro = true;
								}
								if (entro){
									entro = false;
// Actualizo inventario de componentes del Producto
									PreparedStatement updateMPCopas;
									if(tipoP == 1 && tipoM ==1) { // es alimento y ya esta dado por KG.
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento por Kilogramo, componente de materia prima de copa

									else if(tipoP == 1 && tipoM ==2) { // es alimento y esta dado en Unidades.., así que se debe refrescar
// Averiguo cuanto hay actualmente en Kg. del producto y cuanto trae cada unidad
										ResultSet rsInterino = null;
										Statement stInterino = con5.creaStatement();
										double kgActual = 0.00;
										double kgEnUnidad = 0.00;
										int unidadesExistentes = 0;
										String queryInterino = "SELECT KGXUnidad, inventarioKG, inventarioUnidad FROM materiaprima WHERE clave = "+claveMP +	" AND Estatus = 1";
										rsInterino = stInterino.executeQuery(queryInterino);
										while (rsInterino.next()){
											kgActual = rsInterino.getDouble("inventarioKG");
											kgEnUnidad = rsInterino.getDouble("KGXUnidad");
											unidadesExistentes = rsInterino.getInt("inventarioUnidad");
										}
										double gramosSolicitados = (cantidad * cantidadPedida);
										// Traspaso Unidades ya que no me alcanza con5 lo que hay actualmente en inventario por Kilogramos.
										if(gramosSolicitados > kgActual){
											gramosSolicitados -=kgActual;
											int seNecesitan = cambiaAInt(dameEnteros(Math.ceil(gramosSolicitados/kgActual)+""));
											// Si necesito más de lo que existe simplemente trasapaso lo máximo.
											if(seNecesitan > unidadesExistentes){
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = ? WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, unidadesExistentes * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, 0);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
											// Si me alcanza bien, solo traspaso lo necesario.
											else{
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = (inventarioUnidad - ?) WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, seNecesitan * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, seNecesitan);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
										}
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO, PERO SI DESCARGO DE UNIDADES.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento por Unidad, componente de materia prima de copa
									else{ // Es componente bebida...
//										System.out.println("Entre a esta copa tiene componente BEBIDA");
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
// Obtengo inventario despues de actualizacion
										queryConsultaRestante = "SELECT inventarioCopeo, inventarioBotella1, inventarioBotella2,  litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+ 	claveMP + " AND tipo = 2 AND Estatus = 1";
										rs3 = stUpdate2.executeQuery(queryConsultaRestante);
										boolean esUnaSolaBotella = false;
//										System.out.println("Voy a checar que bebidas lo componen....");
										while (rs3.next()){
											if(rs3.getDouble("litrosXBotella1")== 0.00 || rs3.getDouble("litrosXBotella2")==0.00 ){
//												System.out.println("Entre a es una sola botella.");
												esUnaSolaBotella = true;
											}
											// La Botella mas grande es la primera
											if(rs3.getDouble("litrosXBotella1") > rs3.getDouble("litrosXBotella2")){
//												System.out.println("Determine que la botella mas grande es la primera");
												restaCopeo = rs3.getDouble("inventarioCopeo");
												botellaActual = rs3.getInt("inventarioBotella1");
												litrosXBotella = rs3.getDouble("litrosXBotella1");
												botellaTrabajada = "inventarioBotella1";
											}
											else{
//												System.out.println("La botella mas grande es la segunda!");
// Verifico si sobrepasa el inventario
												restaCopeo = rs3.getDouble("inventarioCopeo");
												botellaActual = rs3.getInt("inventarioBotella2");
												litrosXBotella = rs3.getDouble("litrosXBotella2");
												botellaTrabajada = "inventarioBotella2";
											}
										}
										if(restaCopeo < 0){
//											System.out.println("Entre al no me alcanza con5 lo abierto... restaCopeo:" +restaCopeo);
											double botellasFaltantes = Math.ceil((restaCopeo*(-1))/litrosXBotella);
//											System.out.println("Botellas Faltantes: "+botellasFaltantes);
											int botellasATraspasar = cambiaAInt(dameEnteros(Math.ceil((restaCopeo*(-1))/litrosXBotella)+""));
//											System.out.println("Botellas a Traspasar: "+botellasATraspasar);
// No me alcanza con5 las botellas de inventario, así que checo si solo tengo un tamaño de botella..., si asi es ahí muere, sino saco botella pequeña y verifico si con5 eso ya me alcanza.
											if(esUnaSolaBotella && botellasFaltantes > botellaActual){
//												System.out.println("Solo hay de una botella y no alcanza.. así que PELAS!!");
												noAlcanza = true;
												noAlcanzaS = "Me quedo corto por:  "+(botellasFaltantes-botellaActual) + " botella(s) de:  "+dameNombreMateriaPrima(claveMP) +", para poder elaborar el producto por copa de: "+	dameNombreProducto(rs.getInt("ClaveProducto"), 2)+"\n Modifica tu orden de Compra";
												Incidencias.addElement(noAlcanzaS);
											}
											else if(!esUnaSolaBotella && botellasFaltantes > botellaActual){
//												System.out.println("Todavia hay oportunidad... , hay de otro tipo de botella y voy a investigar...");
// Obtengo datos de botella pequeña y checo si con5 eso me alcanza.
												int botellitasExistentes = 0;
												double litrosXBotellitas = 0.00;
												String botellitaChica = "";
												String queryConsultaBotellaPetit = "SELECT inventarioCopeo, inventarioBotella1, inventarioBotella2,  litrosXBotella1, litrosXBotella2 FROM materiaprima WHERE clave = "+ 	claveMP + " AND tipo = 2 AND Estatus = 1";
												rs3 = stUpdate2.executeQuery(queryConsultaBotellaPetit);
												while (rs3.next()){
													if(rs3.getDouble("litrosXBotella1") > rs3.getDouble("litrosXBotella2")){
														botellitaChica = "inventarioBotella2";
														botellitasExistentes = rs3.getInt("inventarioBotella2");
														litrosXBotellitas = rs3.getDouble("litrosXBotella2");
													}
													else{
														botellitaChica = "inventarioBotella1";
														botellitasExistentes = rs3.getInt("inventarioBotella1");
														litrosXBotellitas = rs3.getDouble("litrosXBotella1");
													}
												} // Cierro While de ResultSet rs3
//												System.out.println("Botellitas Exsitentes: " +botellitasExistentes);
//												System.out.println("Litros en Botellita: " +litrosXBotellitas);
												double litrosDisponibles = botellaActual*litrosXBotella;
//												System.out.println("Litros Disponibles1: " +litrosDisponibles +", --" +botellaActual +", " +litrosXBotella);
												litrosDisponibles += restaCopeo;
												double botellitasFaltantes =  Math.ceil((litrosDisponibles*(-1))/litrosXBotellitas);
												int botellitasATraspasar = cambiaAInt(dameEnteros(Math.ceil((litrosDisponibles*(-1))/litrosXBotellitas)+""));
//												System.out.println("Litros Disponibles2: " +litrosDisponibles);
//												System.out.println("Botellitas Faltantes: "+botellitasFaltantes);
//												System.out.println("Botellitas a Traspasar: " +botellitasATraspasar);
// Primer caso no me alcanza ni con5 botella pequeñas así que mato el proceso.
												if(botellitasFaltantes > botellitasExistentes){
//													System.out.println("No me alcanzo ni con5 las peques.. así que pelas!" +botellitasFaltantes +", >  "+botellitasExistentes);
													noAlcanza = true;
													noAlcanzaS = "Me quedo corto por:  "+(botellasFaltantes-botellaActual) + " botella(s) de:  "+dameNombreMateriaPrima(claveMP) +", para poder elaborar el producto por copa de: "+	dameNombreProducto(rs.getInt("ClaveProducto"), 2)+"\n Modifica tu orden de Compra";
													Incidencias.addElement(noAlcanzaS);
												}
// Si alcanza así que paso todas las botellas grandes y las pequeñas necesarias, ademas almaceno a traspasos.
												else{
//													System.out.println("Si me alcanza con5 las peques... voy a descontar");
													double nuevoInventario = (botellitasFaltantes*litrosXBotellitas) + (botellaActual*litrosXBotella);
//													System.out.println("Nuevo Inventario: " +nuevoInventario);
													PreparedStatement updateCopas;
													updateCopas = con5.miConnection.prepareStatement ("UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo+?) , "+botellaTrabajada +" = ("+botellaTrabajada+" - ?), "+botellitaChica +"= ("+botellitaChica+"- ?) WHERE  clave = ? AND Estatus = 1 ");
													updateCopas.setDouble(1, nuevoInventario);
													updateCopas.setInt(2, botellaActual);
													updateCopas.setInt(3, botellitasATraspasar);
													updateCopas.setInt(4, claveMP);
													updateCopas.execute();
//													System.out.println(updateCopas.toString());
// CREO UN REGISTRO DE QUE CREE UN INTERCAMBIO.
													TimeStamp tiempo2 = new TimeStamp();
													String fechaHoy = tiempo2.date;
													Date altaHoy = cambiaADate(fechaHoy);
													PreparedStatement updateTraspasoBotella;
													if(botellaActual > 0){
														updateTraspasoBotella = con5.miConnection.prepareStatement("insert into traspasoAutomatico values(?,?,?);");
														updateTraspasoBotella.setInt(1, botellaActual);
														updateTraspasoBotella.setInt(2, claveMP);
														updateTraspasoBotella.setDate(3, altaHoy);
														updateTraspasoBotella.execute();
													}
													updateTraspasoBotella = null;
													updateTraspasoBotella = con5.miConnection.prepareStatement("insert into traspasoAutomatico values(?,?,?);");
													updateTraspasoBotella.setInt(1, botellitasATraspasar);
													updateTraspasoBotella.setInt(2, claveMP);
													updateTraspasoBotella.setDate(3, altaHoy);
													updateTraspasoBotella.execute();
												}
											}// Cierro caso donde tambien verifico si me alcanza tomando botellas pequeñas.
											else{
//												System.out.println("Todo bien!, si me alcanza con5 las botellas grandes.., asi que descuento y aviso");
// COMO SI ME ALCANZA SACO BOTELLAS NECESARIAS DE INVENTARIO POR COPEO Y ACTUALIZO DONDE CORRESPONDA
												double nuevoInventario =botellasFaltantes*litrosXBotella;
												PreparedStatement updateCopas;
												updateCopas = con5.miConnection.prepareStatement ("UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo+?) , "+botellaTrabajada +" = ("+botellaTrabajada+" - ?) WHERE  clave = ? AND Estatus = 1 ");
												updateCopas.setDouble(1, nuevoInventario);
												updateCopas.setInt(2, botellasATraspasar);
												updateCopas.setInt(3, claveMP);
												updateCopas.execute();
// CREO UN REGISTRO DE QUE CREE UN INTERCAMBIO.
												TimeStamp tiempo2 = new TimeStamp();
												String fechaHoy = tiempo2.date;
												Date altaHoy = cambiaADate(fechaHoy);
												PreparedStatement updateTraspasoBotella;
												updateTraspasoBotella = con5.miConnection.prepareStatement("insert into traspasoAutomatico values(?,?,?);");
												updateTraspasoBotella.setInt(1, botellasATraspasar);
//												System.out.println("BotellasATraspasar: " +botellasATraspasar);
												updateTraspasoBotella.setInt(2, claveMP);
												updateTraspasoBotella.setDate(3, altaHoy);
												updateTraspasoBotella.execute();
											}
										}
									}
								}//Cierro Entra
							} // Cierro Caso
						}// Cierro ResultSet2
					}// Cierro caso Copa
// Se pidio un alimento
					else if(rs.getInt("tipo") == 0){
// Obtengo componentes del Producto
						queryConformacionMP = "SELECT alimentos.materia0, alimentos.cantidad0, (a.tipo)AS tipo0, (a.tipoA)AS tipoA0, alimentos.materia1, alimentos.cantidad1, (b.tipo)AS tipo1, (b.tipoA)AS tipoA1, alimentos.materia2, alimentos.cantidad2, (c.tipo)AS tipo2, (c.tipoA)AS tipoA2, alimentos.materia3, alimentos.cantidad3, (d.tipo)AS tipo3, (d.tipoA)AS tipoA3, alimentos.materia4, alimentos.cantidad4, (e.tipo)AS tipo4, (e.tipoA)AS tipoA4, alimentos.materia5, alimentos.cantidad5, (f.tipo)AS tipo5, (f.tipoA)AS tipoA5, alimentos.materia6, alimentos.cantidad6, (g.tipo)AS tipo6, (g.tipoA)AS tipoA6, alimentos.materia7, alimentos.cantidad7, (h.tipo)AS tipo7, (h.tipoA)AS tipoA7, alimentos.materia8, alimentos.cantidad8, (i.tipo)AS tipo8, (i.tipoA)AS tipoA8, alimentos.materia9, alimentos.cantidad9, (j.tipo)AS tipo9, (j.tipoA)AS tipoA9  FROM ((((((((((alimentos LEFT JOIN materiaprima a ON alimentos.materia0 = a.clave) LEFT JOIN materiaprima b ON alimentos.materia1 = b.clave)LEFT JOIN materiaprima c ON alimentos.materia2 = c.clave) LEFT JOIN materiaprima d ON alimentos.materia3= d.clave) LEFT JOIN materiaprima e ON alimentos.materia4 = e.clave) LEFT JOIN materiaprima f ON alimentos.materia5 = f.clave) LEFT JOIN materiaprima g ON alimentos.materia6 = g.clave) LEFT JOIN materiaprima h ON alimentos.materia7 = h.clave) LEFT JOIN materiaprima i ON alimentos.materia8 = i.clave) LEFT JOIN materiaprima j ON alimentos.materia9 = j.clave) WHERE alimentos.clave = "+rs.getInt("claveProducto")+"  AND alimentos.estatus = 1";
						rs2 = stUpdate.executeQuery(queryConformacionMP);
						int caso = 0;
						while(rs2.next()){
							int claveMP = 0;
							double cantidad=0.00;
							boolean entro = false;
							int tipoP = 0;
							int tipoM = 0;
							while (caso <10){
								if(caso == 0){
									claveMP = rs2.getInt("materia0");
									cantidad = rs2.getDouble("cantidad0");
									if(rs2.getString("tipo0") != null)
										tipoP = rs2.getInt("tipo0");
										tipoM = rs2.getInt("tipoA0");
								}
								else if(caso == 1){
									claveMP = rs2.getInt("materia1");
									cantidad = rs2.getDouble("cantidad1");
									if(rs2.getString("tipo1") != null)
										tipoP = rs2.getInt("tipo1");
										tipoM = rs2.getInt("tipoA1");
								}
								else if(caso == 2){
									claveMP = rs2.getInt("materia2");
									cantidad = rs2.getDouble("cantidad2");
									if(rs2.getString("tipo2") != null)
										tipoP = rs2.getInt("tipo2");
										tipoM = rs2.getInt("tipoA2");
								}
								else if(caso == 3){
									claveMP = rs2.getInt("materia3");
									cantidad = rs2.getDouble("cantidad3");
									if(rs2.getString("tipo3") != null)
										tipoP = rs2.getInt("tipo3");
										tipoM = rs2.getInt("tipoA3");
								}
								else if(caso == 4){
									claveMP = rs2.getInt("materia4");
									cantidad = rs2.getDouble("cantidad4");
									if(rs2.getString("tipo4") != null)
										tipoP = rs2.getInt("tipo4");
										tipoM = rs2.getInt("tipoA5");
								}
								else if(caso == 5){
									claveMP = rs2.getInt("materia5");
									cantidad = rs2.getDouble("cantidad5");
									if(rs2.getString("tipo5") != null)
										tipoP = rs2.getInt("tipo5");
										tipoM = rs2.getInt("tipoA6");
								}
								else if(caso == 6){
									claveMP = rs2.getInt("materia6");
									cantidad = rs2.getDouble("cantidad6");
									if(rs2.getString("tipo6") != null)
										tipoP = rs2.getInt("tipo6");
										tipoM = rs2.getInt("tipoA6");
								}
								else if(caso == 7){
									claveMP = rs2.getInt("materia7");
									cantidad = rs2.getDouble("cantidad7");
									if(rs2.getString("tipo7") != null)
										tipoP = rs2.getInt("tipo7");
										tipoM = rs2.getInt("tipoA7");
								}
								else if(caso == 8){
									claveMP = rs2.getInt("materia8");
									cantidad = rs2.getDouble("cantidad8");
									if(rs2.getString("tipo8") != null)
										tipoP = rs2.getInt("tipo8");
										tipoM = rs2.getInt("tipoA8");
								}
								else if(caso == 9){
									claveMP = rs2.getInt("materia9");
									cantidad = rs2.getDouble("cantidad9");
									if(rs2.getString("tipo9") != null)
										tipoP = rs2.getInt("tipo9");
										tipoM = rs2.getInt("tipoA9");
								}
								caso++;
								if(claveMP > 0){
									entro = true;
								}
								if (entro){
									entro = false;
// Actualizo inventario de componentes del Producto
									PreparedStatement updateMPCopas;
									if(tipoP == 1 && tipoM == 1) { // es alimento y esta ya dado solo por Kg.
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento componente de materia prima de copa
									else if(tipoP == 1 && tipoM ==2) { // es alimento y esta dado en Unidades.., así que se debe refrescar
// Averiguo cuanto hay actualmente en Kg. del producto y cuanto trae cada unidad
										ResultSet rsInterino = null;
										Statement stInterino = con5.creaStatement();
										double kgActual = 0.00;
										double kgEnUnidad = 0.00;
										int unidadesExistentes = 0;
										String queryInterino = "SELECT KGXUnidad, inventarioKG, inventarioUnidad FROM materiaprima WHERE clave = "+claveMP +	" AND Estatus = 1";
										rsInterino = stInterino.executeQuery(queryInterino);
										while (rsInterino.next()){
											kgActual = rsInterino.getDouble("inventarioKG");
											kgEnUnidad = rsInterino.getDouble("KGXUnidad");
											unidadesExistentes = rsInterino.getInt("inventarioUnidad");
										}
										double gramosSolicitados = (cantidad * cantidadPedida);
										// Traspaso Unidades ya que no me alcanza con5 lo que hay actualmente en inventario por Kilogramos.
										if(gramosSolicitados > kgActual){
											gramosSolicitados -=kgActual;
											int seNecesitan = cambiaAInt(dameEnteros(Math.ceil(gramosSolicitados/kgActual)+""));
											// Si necesito más de lo que existe simplemente trasapaso lo máximo.
											if(seNecesitan > unidadesExistentes){
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = ? WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, unidadesExistentes * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, 0);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
											// Si me alcanza bien, solo traspaso lo necesario.
											else{
												PreparedStatement updateTraspasoUnidades;
												updateTraspasoUnidades = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG + ?), inventarioUnidad = (inventarioUnidad - ?) WHERE  clave = ? AND Estatus = 1");
												updateTraspasoUnidades.setDouble(1, seNecesitan * kgEnUnidad);
												updateTraspasoUnidades.setInt(2, seNecesitan);
												updateTraspasoUnidades.setInt(3, claveMP);
												updateTraspasoUnidades.execute();
											}
										}
// SOLO DESCUENTO DE INVENTARIO NO VERIFICO SI TENGO EN EXISTENCIA O NO, PERO SI DESCARGO DE UNIDADES.
										updateMPCopas = con5.miConnection.prepareStatement (			"UPDATE materiaprima SET inventarioKG = (inventarioKG - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad  * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}// Cierro Caso Alimento por Unidad, componente de materia prima de alimento
									else{ // Es componente bebida...
										updateMPCopas = con5.miConnection.prepareStatement (				"UPDATE materiaprima SET inventarioCopeo = (inventarioCopeo - ?) WHERE  clave = ? AND Estatus = 1");
										updateMPCopas.setDouble(1, cantidad * cantidadPedida);
										updateMPCopas.setInt(2, claveMP);
										updateMPCopas.execute();
									}
								}
							}//Cierro Entra
						} // Cierro Caso
					}
				}
// Si HUBO PROBLEMAS POR INVENTARIOS REALIZO UN ROLLBACK
				if(noAlcanza){
					System.out.println("Existio un problema asi que hize RollBack");
					con5.realizaRollback(puntoUpdateInventarioCombinadas);
				}

// SI TODO BIEN GUARDO EN MI TABLA FORMAL, VERIFICO ACTUALIZO PRECIO TOTAL DE COMANDA Y MANDO IMPRIMIR
				else{
					rs = null;
					String queryCompleto = "SELECT * FROM tempcom WHERE IDC = "+IDComanda +"  ORDER BY  IDT DESC";
//					System.out.println(queryCompleto);
					Statement stCompleto = con5.creaStatement();
					rs = stCompleto.executeQuery(queryCompleto);
					ResultSet rs2 = null;
					int IDSecuencia = 0;
					String queryIDSec = "SELECT DISTINCT MAX(IDSecuencia)AS Maximo FROM comandapro WHERE IDC = "+IDComanda;
					Statement stIDSec = con5.creaStatement();
					rs2 = stIDSec.executeQuery(queryIDSec);
					while (rs2.next()){
						IDSecuencia = rs2.getInt("Maximo");
					}
					IDSecuencia++;
					while(rs.next()){
						int cantidadSolicitada = rs.getInt("CP");
						tiempo = new TimeStamp();
						String fecha = tiempo.date;
						String hora = tiempo.time;
						Date altaD = cambiaADate(fecha);
						Time altaT = cambiaATiempo(hora);
						for(int j = 1; j<=cantidadSolicitada; j++){
							PreparedStatement updateAltaComandaProducto;
							updateAltaComandaProducto = con5.miConnection.prepareStatement("insert into comandapro values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
							updateAltaComandaProducto.setInt(1, IDComanda);
							updateAltaComandaProducto.setInt(2, rs.getInt("IDM"));
							updateAltaComandaProducto.setInt(3, rs.getInt("IDCom"));
							updateAltaComandaProducto.setTime(4, altaT);
							updateAltaComandaProducto.setDate(5, altaD);
							updateAltaComandaProducto.setInt(6, rs.getInt("IDG"));
							updateAltaComandaProducto.setInt(7, rs.getInt("IDD"));
							updateAltaComandaProducto.setInt(8, 1);
							updateAltaComandaProducto.setInt(9, rs.getInt("IDCP"));
							updateAltaComandaProducto.setDouble(10,rs.getInt("IDT"));
							updateAltaComandaProducto.setString(11,rs.getString("Ob"));
							updateAltaComandaProducto.setDouble(12,rs.getDouble("PU"));
							updateAltaComandaProducto.setDouble(13,rs.getDouble("PT"));
							updateAltaComandaProducto.setInt(14, 1);
							updateAltaComandaProducto.setInt(15, IDSecuencia);
							updateAltaComandaProducto.setInt(16, 0);
							updateAltaComandaProducto.setInt(17, rs.getInt("TB"));
							updateAltaComandaProducto.setInt(18, rs.getInt("FB"));
							updateAltaComandaProducto.setInt(19, rs.getInt("MB"));
							updateAltaComandaProducto.setInt(20, rs.getInt("AB"));
							updateAltaComandaProducto.setInt(21, rs.getInt("CA1"));
							updateAltaComandaProducto.setInt(22, rs.getInt("CA2"));
							updateAltaComandaProducto.setInt(23, rs.getInt("CA3"));
							updateAltaComandaProducto.setInt(24, rs.getInt("CA4"));
							updateAltaComandaProducto.setInt(25, rs.getInt("CB1"));
							updateAltaComandaProducto.setInt(26, rs.getInt("CB2"));
							updateAltaComandaProducto.setInt(27, rs.getInt("CB3"));
							updateAltaComandaProducto.setInt(28, rs.getInt("CB4"));
							updateAltaComandaProducto.setInt(29, rs.getInt("TB1"));
							updateAltaComandaProducto.setInt(30, rs.getInt("TB2"));
							updateAltaComandaProducto.setInt(31, rs.getInt("TB3"));
							updateAltaComandaProducto.setInt(32, rs.getInt("TB4"));
							updateAltaComandaProducto.execute();
						}
					}
					rs = null;
					double sumaTotal = 0.00;
					String querySumaTotal = "SELECT SUM(PT)AS sumatoria FROM comandapro WHERE IDC = "+IDComanda;
					Statement stSuma = con5.creaStatement();
					rs = stSuma.executeQuery(querySumaTotal);
					while(rs.next()){
						sumaTotal = rs.getDouble("sumatoria");
					}
					PreparedStatement updateCuenta;
					updateCuenta = con5.miConnection.prepareStatement ("UPDATE comanda SET PT = ?  WHERE  IDC = ? AND Es = 1 ");
					updateCuenta.setDouble(1, sumaTotal);
					updateCuenta.setInt(2, IDComanda);
					updateCuenta.execute();
					Incidencias.addElement("OK");
				}
// FINALMENTE ELIMINO MI TABLA TEMPORAL.
				String queryBorra = "DELETE FROM tempcom WHERE IDC = "+IDComanda;
				Statement stmtB = con5.miConnection.createStatement();
				stmtB.execute(queryBorra);
				Incidencias.addElement("OK");
				con5.realizaCommit();
			}// Cierro try
			catch (SQLException sqle) {
				if(Incidencias.size() == 0){
					Incidencias.addElement("Error");
				}
				else{
					Incidencias.setElementAt("Error",0);
				}
				con5.realizaRollback();
				sqle.printStackTrace();
// Archivo Log..
				try{
					File fLog = new File("LogExSQL.txt");
					fLog.createNewFile();
					StringBuffer lineaArchivo = new StringBuffer();
					FileWriter escritor = new FileWriter( fLog );
					BufferedWriter escritorBuff = new BufferedWriter( escritor );
					lineaArchivo.append(sqle.toString());
					StackTraceElement[] kioto = sqle.getStackTrace();
					for(int i=0; i<kioto.length; i++){
						lineaArchivo.append(kioto[i].toString());
					}
					lineaArchivo.append(sqle.getStackTrace());
					escritorBuff.write( lineaArchivo.toString(), 0, lineaArchivo.toString().length() );
					escritor.flush();
					escritorBuff.close();
				}
				catch (Exception e){
				}
				System.out.println(	"Error SQL clase ManagerPuntoVenta, método almacenaComanda"+sqle);
			}
			catch (Exception q){
				if(Incidencias.size()== 0){
					Incidencias.addElement("Error");
				}
				else{
					Incidencias.setElementAt("Error",0);
				}
				con5.realizaRollback();
				q.printStackTrace();
// Archivo Log..
				try{
					File fLog = new File("LogEx.txt");
					fLog.createNewFile();
					StringBuffer lineaArchivo = new StringBuffer();
					FileWriter escritor = new FileWriter( fLog );
					BufferedWriter escritorBuff = new BufferedWriter( escritor );
					lineaArchivo.append(q.toString());
					StackTraceElement[] kioto = q.getStackTrace();
					for(int i=0; i<kioto.length; i++){
						lineaArchivo.append(kioto[i].toString());
					}
					lineaArchivo.append(q.getStackTrace());
					escritorBuff.write( lineaArchivo.toString(), 0, lineaArchivo.toString().length() );
					escritor.flush();
					escritorBuff.close();
				}
				catch (Exception e){
				}
				System.out.println(	"Error clase ManagerPuntoVenta, método almacenaComanda");
			}
			finally{
				try{
					con5.realizaCommit();
					con5.habilitaAutoCommit();
					con5.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo almacenaComanda");
					q.printStackTrace();
				}
			}
		}
		// MANDO IMPRIMIR
		ImpresionTicketComida itc = new ImpresionTicketComida(IDComanda);
		ImpresionTicketBebida itb = new ImpresionTicketBebida(IDComanda);
		System.out.println("Regreso en Vector Incidencias:");
		for(int i=0; i<Incidencias.size(); i++){
			System.out.println("Elemento: "+i +", contiene -- "+Incidencias.elementAt(i));
		}
		return Incidencias;
	}

	public void ImprimeTicketTotal (int mesaID) throws Exception{
		try{
			ImpresionTicketComandaT itct = new ImpresionTicketComandaT(mesaID);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void ImprimeTicketxComensal(int mesaID) throws Exception{
		try{
			ImpresionTicketXComensal itxc = new ImpresionTicketXComensal(mesaID);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}


	public synchronized String modificaMesa(int IDMesero, int comensales, int mesaID, javax.swing.DefaultListModel  listaMLigadas) throws SQLException, Exception{
		con = new ConexionBD();
		con.cancelaAutoCommit();
		String resultado = "OK";
		Vector <String> yaLigadas = new Vector<String>();
		Vector <String> listaOriginal = new Vector<String>();
		int tamanioLista = listaMLigadas.getSize();
		for(int i = 0; i < tamanioLista ; i++){
			listaOriginal.addElement(cambiaAClaveBarra((String)listaMLigadas.elementAt(i)));
		}
		boolean ligadaOcupada = false;
		if (con.miConnection != null) {
			try {
				String queryParcial = "";
				ResultSet rs= null;
				String MyaLigadas = "SELECT IDMesa FROM mesas WHERE LigaA = "+mesaID;
				Statement st1 = con.creaStatement();
				rs = st1.executeQuery(MyaLigadas);
				while (rs.next()){
					yaLigadas.addElement(rs.getString("IDMesa"));
				}
// VERIFICO QUE MIS MESAS LIGADAS NO ESTEN YA OCUPADAS.. POR SI ME QUIEREN METER GOL.
				rs = null;
				int tamanioListaML = listaMLigadas.getSize();
				boolean primeraVez = true;
				if (tamanioListaML > 0){
					String complemento = cambiaAClaveBarra((String)listaMLigadas.getElementAt(0));
					for(int i = 1; i < tamanioListaML ; i++){
						complemento +=" OR IDMESA = "+cambiaAClaveBarra((String)listaMLigadas.getElementAt(i));
					}
					rs = null;
					String verificaMLigadas = "SELECT IDMesa, Estatus FROM mesas WHERE IDMesa = "+complemento;
					Statement st2 = con.creaStatement();
					rs = st2.executeQuery(verificaMLigadas);
					while (rs.next()){
						boolean yaFueLigada = true;
						if(rs.getInt("Estatus") > 0){
							for(int i=0; i<yaLigadas.size(); i++){
								if(rs.getString("IDMesa").equalsIgnoreCase((String) yaLigadas.elementAt(i))){
									yaFueLigada = false;
								}
							}
							if(yaFueLigada){
								ligadaOcupada = true;
								resultado = "ML";
							}
						}
					}
				}
// TODO BIEN ACTUALIZO...
				if(!ligadaOcupada){
					PreparedStatement updateComandaMesa;
					updateComandaMesa = con.miConnection.prepareStatement ("UPDATE comanda SET IDM = ?,  NC = ?  WHERE IDMM = ?  AND Es = 1");
					updateComandaMesa.setInt(1, IDMesero);
					updateComandaMesa.setInt(2, comensales);
					updateComandaMesa.setInt(3, mesaID);
					updateComandaMesa.execute();
// AHORA CAMBIO ESTATUS DE MESAS LIGADAS
					PreparedStatement updateQuitaLigadas;
					updateQuitaLigadas = con.miConnection.prepareStatement ("UPDATE mesas SET LigaA = ?, Estatus = ?  WHERE LigaA = ?");
					updateQuitaLigadas.setNull(1, java.sql.Types.INTEGER);
					updateQuitaLigadas.setInt(2, 0);
					updateQuitaLigadas.setInt(3, mesaID);
					updateQuitaLigadas.execute();
					if(listaOriginal.size() > 0){
						for (int i = 0; i<listaOriginal.size()  ; i++){
							String mesaLigadaID = (String)listaOriginal.elementAt(i);
							PreparedStatement updateEstadoMesaLigada;
							updateEstadoMesaLigada = con.miConnection.prepareStatement ("UPDATE mesas SET Estatus = ?, LigaA = ?  WHERE IDMesa = ?");
							updateEstadoMesaLigada.setInt(1, 2);
							updateEstadoMesaLigada.setInt(2, mesaID);
							updateEstadoMesaLigada.setString(3, mesaLigadaID);
							updateEstadoMesaLigada.execute();
						}
					}
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				resultado = "ERROR";
				sqle.printStackTrace();
				System.out.println(	"Error SQL clase ManagerPuntoVenta, método modificaMesa"+sqle);
			}
			catch (Exception q){
				con.realizaRollback();
				resultado = "ERROR";
				q.printStackTrace();
				System.out.println(	"Error clase ManagerPuntoVenta, método modificaMesa");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo modificaMesa");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}


/**
* El Método altaDeMesa nos informa sobre las mesas que se encuentran disponibles para ser ligadas.
*
* @return String con el listado de las mesas disponibles.
*/
	public synchronized String altaDeMesa(int IDMesero, int comensales, int mesaID, javax.swing.DefaultListModel  listaMLigadas) throws SQLException, Exception{
		//System.out.println("Empiezo");
		con = new ConexionBD();
		con.cancelaAutoCommit();
		String resultado = "OK";
		boolean madreOcupada = false;
		boolean ligadaOcupada = false;
		if (con.miConnection != null) {
			try {
				ResultSet rs= null;
				tiempo = new TimeStamp();
				String fecha = tiempo.date;
				String hora = tiempo.time;
				Date altaD = cambiaADate(fecha);
				Time altaT = cambiaATiempo(hora);
// VERIFICO QUE MI MESA MADRE NO ESTE YA OCUPADA.. POR SI ME QUIEREN METER GOL.
				String verificaMMadre = "SELECT Estatus FROM mesas WHERE IDMesa = "+mesaID;
				Statement st1 = con.creaStatement();
				rs = st1.executeQuery(verificaMMadre);
				while (rs.next()){
					if(rs.getInt("Estatus") > 0){
						madreOcupada = true;
						resultado = "MO";
					}
				}
// VERIFICO QUE MIS MESAS LIGADAS NO ESTEN YA OCUPADAS.. POR SI ME QUIEREN METER GOL.
				if(!madreOcupada && listaMLigadas.getSize() > 0){
					rs = null;
					int tamanioListaML = listaMLigadas.getSize();
					String complemento = (String)listaMLigadas.getElementAt(0);
					if(complemento.equals("B1")){
						complemento = "25";
					}
					else if(complemento.equals("B2")){
						complemento = "26";
					}
					else if(complemento.equals("B3")){
						complemento = "27";
					}
					else if(complemento.equals("B4")){
						complemento = "28";
					}
					else if(complemento.equals("B5")){
						complemento = "29";
					}
					for(int i = 1; i < tamanioListaML ; i++){
						String IDCheck = (String)listaMLigadas.getElementAt(i);
						if(IDCheck.equals("B1")){
							IDCheck = "25";
						}
						else if(IDCheck.equals("B2")){
							IDCheck = "26";
						}
						else if(IDCheck.equals("B3")){
							IDCheck = "27";
						}
						else if(IDCheck.equals("B4")){
							IDCheck = "28";
						}
						else if(IDCheck.equals("B5")){
							IDCheck = "29";
						}
						complemento +=" OR IDMESA = "+IDCheck;
					}
					String verificaMLigadas = "SELECT Estatus FROM mesas WHERE IDMesa = "+complemento;
					Statement st2 = con.creaStatement();
					rs = st2.executeQuery(verificaMLigadas);
					while (rs.next()){
						if(rs.getInt("Estatus") > 0){
							ligadaOcupada = true;
							resultado = "ML";
						}
					}
				}
// TODO BIEN ALMACENO ENTONCES MI NUEVA COMANDA......
				if(!ligadaOcupada && !madreOcupada){
					PreparedStatement updateAltaMesa;
					updateAltaMesa = con.miConnection.prepareStatement("insert into comanda values(?,?,?,?,?,?,?,?);");
					updateAltaMesa.setNull(1, java.sql.Types.INTEGER);
					updateAltaMesa.setInt(2, mesaID);
					updateAltaMesa.setInt(3, IDMesero);
					updateAltaMesa.setDate(4, altaD);
					updateAltaMesa.setTime(5, altaT);
					updateAltaMesa.setInt(6, comensales);
					updateAltaMesa.setDouble(7,0.00);
					updateAltaMesa.setInt(8, 1);
					updateAltaMesa.execute();
// AHORA CAMBIO ESTATUS DE MESA MADRE Y POSTERIORMENTE DE MESAS LIGADAS
					PreparedStatement updateEstadoMesaMadre;
					updateEstadoMesaMadre = con.miConnection.prepareStatement ("UPDATE mesas SET Estatus = ?  WHERE IDMesa = ?");
					updateEstadoMesaMadre.setInt(1, 1);
					updateEstadoMesaMadre.setInt(2, mesaID);
					updateEstadoMesaMadre.execute();
					if(listaMLigadas.getSize() > 0){
						int recorreLista = listaMLigadas.getSize();
						for (int i = 0; i<recorreLista ; i++){
							String mesaLigadaID = (String)listaMLigadas.getElementAt(i);
							if(mesaLigadaID.equals("B1")){
								mesaLigadaID = "25";
							}
							else if(mesaLigadaID.equals("B2")){
								mesaLigadaID = "26";
							}
							else if(mesaLigadaID.equals("B3")){
								mesaLigadaID = "27";
							}
							else if(mesaLigadaID.equals("B4")){
								mesaLigadaID = "28";
							}
							else if(mesaLigadaID.equals("B5")){
								mesaLigadaID = "29";
							}
							PreparedStatement updateEstadoMesaLigada;
							updateEstadoMesaLigada = con.miConnection.prepareStatement ("UPDATE mesas SET Estatus = ?, LigaA = ?  WHERE IDMesa = ?");
							updateEstadoMesaLigada.setInt(1, 2);
							updateEstadoMesaLigada.setInt(2, mesaID);
							updateEstadoMesaLigada.setString(3, mesaLigadaID);
							updateEstadoMesaLigada.execute();
						}
					}
				}
				con.realizaCommit();
			}
			catch (SQLException sqle) {
				con.realizaRollback();
				resultado = "ERROR";
				sqle.printStackTrace();
				System.out.println(	"Error SQL clase ManagerPuntoVenta, método altaDeMesa"+sqle);
			}
			catch (Exception q){
				con.realizaRollback();
				resultado = "ERROR";
				q.printStackTrace();
				System.out.println(	"Error clase ManagerPuntoVenta, método altaDeMesa");
			}
			finally{
				try{
					con.habilitaAutoCommit();
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al cerrar conexion de ManagerPuntoVenta metodo altaDeMesa");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}

	public String cambiaAClaveBarra(String nombreBarra) throws Exception{
		if(nombreBarra.equals("B1")){
			nombreBarra = "25";
		}
		else if(nombreBarra.equals("B2")){
			nombreBarra = "26";
		}
		else if(nombreBarra.equals("B3")){
			nombreBarra = "27";
		}
		else if(nombreBarra.equals("B4")){
			nombreBarra = "28";
		}
		else if(nombreBarra.equals("B5")){
			nombreBarra = "29";
		}
		return nombreBarra;
	}

	public String cambiaANombreBarra(String claveBarra) throws Exception{
		if(claveBarra.equals("25")){
			claveBarra = "B1";
		}
		else if(claveBarra.equals("26")){
			claveBarra = "B2";
		}
		else if(claveBarra.equals("27")){
			claveBarra = "B3";
		}
		else if(claveBarra.equals("28")){
			claveBarra = "B4";
		}
		else if(claveBarra.equals("29")){
			claveBarra = "B5";
		}
		return claveBarra;
	}


/**
* El Método comensalesDesglosados nos regresa un Vector que contiene desglosados la cantidad de comensales especificados para una mesa.
*
* @return Vector <String> con el desglose de comensales.
*/
	public Vector<String> comensalesDesglosados(int mesaM) throws SQLException, Exception {
		con = new ConexionBD();
		int contador = 0;
		Vector <String>datosComen = new Vector <String>();
		try{
			ResultSet rs = null;
			String query = "SELECT NC FROM comanda WHERE IDMM =  "+mesaM +"  AND Es = 1";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				contador = rs.getInt("NC");
			}
			for (int j=1; j<=contador; j++){
				String comensal = j+"";
				datosComen.addElement(comensal);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, comensalesDesglosados ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, comensalesDesglosados ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
				con.cierraConexion();				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, comensalesDesglosados ");
					q.printStackTrace();
				}
			}
		}
		return datosComen;
	}


/**
* El Método divisionesDisponibles nos regresa un Vector que contiene las divisiones disponibles en activo, organizadas alfabeticamente
*
* @return Vector <String> con el desglose de comensales.
*/
	public Vector<String> divisionesDisponibles(int area) throws SQLException, Exception {
		con = new ConexionBD();
		String laDivision = "";
		Vector <String> datosDivisiones = new Vector <String>();
		try{
			ResultSet rs = null;
			String query = "SELECT CONCAT(nombre COLLATE latin1_spanish_ci,' - ',clave)AS divi FROM division  WHERE area =  "+area +" AND estatus = 1 ORDER BY nombre";
			Statement stmt =  con.creaStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				laDivision = codifica(rs.getString("divi"));
				datosDivisiones.addElement(laDivision);
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, divisionesDisponibles ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, divisionesDisponibles ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
				con.cierraConexion();				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, divisionesDisponibles ");
					q.printStackTrace();
				}
			}
		}
		return datosDivisiones;
	}


	public MyTableModel comandaDesglosXComensal(int mesaID) throws SQLException, Exception{
		MyTableModel tmp = null;
		// Genero mi Arreglo con los datos
		String [] titulos = new String[5];
		titulos[0] = "Cantidad";
		titulos[1] = "Tipo";
		titulos[2] = "Clave";
		titulos[3] = "Producto";
		titulos[4] = "Comensal";
		try{
			ResultSet rs = dameXComeComanda(mesaID);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnas = rsmd.getColumnCount()-1;
			int renglones = getResultSetSize(rs);
			Object [][] datos = new Object [renglones][columnas];
			int renglon = 0;
			while(rs.next()){
				for (int i = 0 ; i<columnas; i++){
					if(i == 0){
						datos [renglon][i] = rs.getString("cantidad");
					}
					else if(i==1){
						int tipoP = rs.getInt("Tipo");
						int tamanioB = rs.getInt("Tamanio");
						String valorP = "N/A";
						if(tipoP == 1 && tamanioB == 1){
							valorP = "Copa";
						}
						else if(tipoP == 1 && tamanioB == 2){
							valorP = "Copa D.";
						}
						else if(tipoP == 1 && tamanioB == 3){
							valorP = "Copa T.";
						}
						else if(tipoP == 2 ){
							valorP = "Botella";
						}
						else if(tipoP == 3){
							valorP = "Botella G.";
						}
						else if(tipoP == 4){
							valorP = "Botella P.";
						}
						datos [renglon] [i] =valorP;
					}
					else if(i==2){
						datos [renglon][i] = rs.getString("ClaveP");
					}
					else if(i==3){
						datos [renglon][i] = rs.getString("Producto");
					}
					else if (i == 4){
						datos [renglon][i] = rs.getString("IDCom");
					}
				}
				renglon++;
			}
			tmp = new MyTableModel(titulos,datos);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, comandaDesglosXComensal ");
					q.printStackTrace();
				}
			}
		}
		return	tmp;
	}


	public ResultSet dameXComeComanda(int mesaID){
		ResultSet rs = null;
		String query = "";
		try{
			query = ("SELECT Cantidad, Tipo, ClaveP, Producto, IDCom, Tamanio FROM (SELECT (comandapro.CanPro)AS Cantidad, (comandapro.TB)AS Tamanio,  (comandaPro.ClPro)AS ClaveP, (alimentos.nombre)AS Producto, comandapro.Tipo, comandapro.IDCom FROM comandapro, comanda, alimentos WHERE comanda.IDMM = "+mesaID +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Tipo = 0 AND comandapro.Estatus = 1 AND alimentos.clave = comandapro.ClPro UNION ALL SELECT (comandapro.CanPro)AS Cantidad, (comandapro.TB)AS Tamanio, (comandaPro.ClPro)AS ClaveP, (bebidas.nombre)AS   Producto, comandapro.Tipo, comandapro.IDCom FROM comandapro, comanda, bebidas WHERE comanda.IDMM = "+mesaID +" AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND (comandapro.Tipo = 1 OR comandapro.Tipo = 2 OR comandapro.Tipo = 3 OR comandapro.Tipo = 4) AND comandapro.Estatus = 1  AND bebidas.clave = comandapro.ClPro)AS tbTemp ORDER BY CONCAT(IDCom,'',ClaveP,Tipo,Producto)");
//			System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameXComeComanda ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameXComeComanda ");
			e.printStackTrace();
		}
		return rs;
	}


	public MyTableModel consultaComandaMTM(int mesaID) throws SQLException, Exception {
		MyTableModel tmp = null;
		// Genero mi Arreglo con los datos
		String [] titulos = new String[5];
		titulos[0] = "Cantidad";
		titulos[1] = "Tipo";
		titulos[2] = "Producto";
		titulos[3] = "Solicito";
		titulos[4] = "Comensal";
		try{
			ResultSet rs = dameTodaComanda(mesaID);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnas = rsmd.getColumnCount()-3;
			int renglones = getResultSetSize(rs);
			Object [][] datos = new Object [renglones][columnas];
			int renglon = 0;
			while(rs.next()){
				for (int i = 0 ; i<columnas; i++){
					if(i == 0){
						datos [renglon][i] = rs.getString("cantidad");
					}
					else if(i==1){
						int tipoP = rs.getInt("Tipo");
						int tamnioC = rs.getInt("TB");
						String valorP = "N/A";
						if(tipoP == 1 && tamnioC == 1){
							valorP = "Copa";
						}
						else if(tipoP == 1 && tamnioC == 2){
							valorP = "Copa D.";
						}
						else if(tipoP == 1 && tamnioC == 3){
							valorP = "Copa T.";
						}
						else if(tipoP == 2){
							valorP = "Botella";
						}
						else if(tipoP == 3){
							valorP = "Botella G.";
						}
						else if(tipoP == 2){
							valorP = "Botella P.";
						}
						datos [renglon] [i] =valorP;
					}
					else if(i==2){
						datos [renglon][i] = rs.getString("nombre");
					}
					else if (i == 3){
						datos [renglon][i] = rs.getString("Nombre2");
					}
					else if (i == 4){
						datos [renglon][i] = rs.getString("IDCom");
					}
				}
				renglon++;
			}
			tmp = new MyTableModel(titulos,datos);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, consultaComandaMTM ");
					q.printStackTrace();
				}
			}
		}
		return	tmp;
	}

/**
* El Método listadoProductos  nos regresa los productos que conforman un numero de ticket
*  @return ResultSet con los detalle por producto.
*/
	public ResultSet dameTodaComanda(int mesaID){
		ResultSet rs = null;
		String query = "";
		try{
			query = ("SELECT ALL SUM(Cantidad)AS Cantidad, nombre, ClPro, Tipo, Nombre2, IDcom, HR, TB FROM (SELECT (comandapro.CanPro)AS Cantidad, alimentos.nombre, comandapro.Tipo, comandapro.ClPro, comandapro.TB, CONCAT(empleados.Nombre,'  ',empleados.APaterno)AS Nombre2, comandapro.IDCom, comandapro.HR FROM comandapro, alimentos, empleados, comanda WHERE comanda.IDMM = "+mesaID +"  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Estatus != 0 AND comandapro.tipo = 0 AND alimentos.clave = comandapro.ClPro AND empleados.IDEmpleado = comandapro.IDM UNION ALL SELECT (comandapro.CanPro)AS Cantidad,  bebidas.nombre, comandapro.Tipo, comandapro.ClPro, comandapro.TB,  CONCAT(empleados.Nombre,' ',empleados.APaterno)AS Nombre2,  comandapro.IDCom, comandapro.HR  FROM comandapro, bebidas, empleados, comanda  WHERE comanda.IDMM = "+mesaID +"  AND comanda.Es = 1 AND comandapro.IDC = comanda.IDC AND comandapro.Estatus != 0  AND (comandapro.tipo = 1 OR comandapro.tipo = 2 OR comandapro.tipo = 3 OR comandapro.tipo = 4)  AND bebidas.clave = comandapro.ClPro AND empleados.IDEmpleado = comandapro.IDM)AS kiko2  GROUP BY CONCAT(Tipo,TB,nombre,IDCom,Nombre2,ClPro)  ORDER BY CONCAT(IDCom,ClPro,HR)");
			//System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameTodaComanda ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameTodaComanda ");
			e.printStackTrace();
		}
		return rs;
	}

	@SuppressWarnings("unchecked")
	public Vector<Object> dameModeloEspecialBebidas(Vector <Object> info) throws Exception{
		Vector<Object> tmp = new Vector<Object>();
		Vector <String> interno =null;
		int tamanioVector = info.size();
		int cantidadProductos = 0;
		int claveBotana = 0;
// Obtengo la clave de la Botana que si trae propiedades.
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			claveBotana=cambiaAInt(config.getProperty("botanaCla").trim());
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
// Averiguo cuantos productos son en total.
		for(int i = 0; i<info.size(); i++){
			Vector <String> temporal = (Vector)info.elementAt(i);
			if(((String)temporal.elementAt(1)).startsWith("1")){
				cantidadProductos += 1;
			}
			else{
				cantidadProductos += cambiaAInt((String)temporal.elementAt(0));
			}
//			System.out.println("Cantidad Productos: " +cantidadProductos);
		}
		for(int i = 0; i<info.size(); i++){
			Vector <String> temporal = ((Vector <String>)info.elementAt(i));
//			System.out.println("Tamanio temporal: " +temporal.size()+", Primer Elemento: " +temporal.elementAt(0));
			interno = new Vector <String>();
			// Hablamos de un alimento
			if(((String)temporal.elementAt(1)).startsWith("1")){
				String tipoDeAlimento = (String)temporal.elementAt(1);
				if(tipoDeAlimento.substring(tipoDeAlimento.indexOf("*")+1, tipoDeAlimento.lastIndexOf("*")).trim().equalsIgnoreCase(claveBotana+"")){
					int cantidadPedida = cambiaAInt((String)temporal.elementAt(0));
					for(int p = 0; p<cantidadPedida; p++){
						interno.addElement("1");
						interno.addElement(temporal.elementAt(1));
						interno.addElement(temporal.elementAt(2));
						interno.addElement(temporal.elementAt(3));
						interno.addElement(temporal.elementAt(4));
						interno.addElement(temporal.elementAt(5));
						interno.addElement("NA");
						interno.addElement("NA");
						interno.addElement("NA");
						interno.addElement("NA");
						interno.addElement(dameComponentesBotana());
						tmp.addElement(interno);
						interno = new Vector<String>();
					}
				}
				else{
					interno.addElement(temporal.elementAt(0));
					interno.addElement(temporal.elementAt(1));
					interno.addElement(temporal.elementAt(2));
					interno.addElement(temporal.elementAt(3));
					interno.addElement(temporal.elementAt(4));
					interno.addElement(temporal.elementAt(5));
					interno.addElement("NA");
					interno.addElement("NA");
					interno.addElement("NA");
					interno.addElement("NA");
					interno.addElement("NA");
					tmp.addElement(interno);
				}
			}
			else{
				String elProducto = ((String)temporal.elementAt(1)).trim();
				int claveDeProducto = cambiaAInt(elProducto.substring((elProducto.lastIndexOf("*"))+1, elProducto.length()));
				int esCombinable = dameTipoCombinacion(claveDeProducto);
				int esDimensionable = damePropiedadDimension(claveDeProducto);
				if(((String)temporal.elementAt(4)).startsWith("Copa")){
					int cantidadPedida = cambiaAInt((String)temporal.elementAt(0));
					for (int k=0; k < cantidadPedida; k++){
						if(esCombinable == 1 && esDimensionable == 1){
							String combinaInicial = "";
							try{
								String conf = "Server.conf";
								config = new Properties();
								config.load( new FileInputStream(conf) );
								combinaInicial=config.getProperty("refOficial");
								combinaInicial ="1 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
							}
							catch(IOException ioe){
								System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
								ioe.printStackTrace();
							}
							catch (IllegalArgumentException iae){
								System.out.println("Error de lectura malformacion de archivo de configuracion");
								iae.printStackTrace();
							}
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement(temporal.elementAt(5));
							interno.addElement("Sencillo");
							interno.addElement("Puesto");
							interno.addElement("Normal");
							interno.addElement("No");
							interno.addElement(combinaInicial);
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 1 && esDimensionable == 0){
							String combinaInicial = "";
							try{
								String conf = "Server.conf";
								config = new Properties();
								config.load( new FileInputStream(conf) );
								combinaInicial=config.getProperty("refOficial");
								combinaInicial ="1 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
							}
							catch(IOException ioe){
								System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
								ioe.printStackTrace();
							}
							catch (IllegalArgumentException iae){
								System.out.println("Error de lectura malformacion de archivo de configuracion");
								iae.printStackTrace();
							}
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement(temporal.elementAt(5));
							interno.addElement("NA");
							interno.addElement("Puesto");
							interno.addElement("Normal");
							interno.addElement("No");
							interno.addElement(combinaInicial);
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 0 && esDimensionable == 1){
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement(temporal.elementAt(5));
							interno.addElement("Sencillo");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("No");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else{
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement(temporal.elementAt(5));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
					}
				}
				else{
					int cantidadPedida = cambiaAInt((String)temporal.elementAt(0));
					for (int k=0; k < cantidadPedida; k++){
						if(esCombinable == 1){
							String combinaInicial = "";
							try{
								String conf = "Server.conf";
								config = new Properties();
								config.load( new FileInputStream(conf) );
								combinaInicial=config.getProperty("refOficial");
								if(((String)temporal.elementAt(4)).equalsIgnoreCase("Botella") || ((String)temporal.elementAt(4)).equalsIgnoreCase("Botella G.")){
									combinaInicial ="4 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
								}
								else{
									combinaInicial ="3 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
								}
							}
							catch(IOException ioe){
								System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
								ioe.printStackTrace();
							}
							catch (IllegalArgumentException iae){
								System.out.println("Error de lectura malformacion de archivo de configuracion");
								iae.printStackTrace();
							}
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement(temporal.elementAt(5));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("No");
							interno.addElement(combinaInicial);
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 0){
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement(temporal.elementAt(5));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("No");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 2){
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement(temporal.elementAt(5));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
					}
				}
			}
		}
		return	tmp;
	}


	@SuppressWarnings("unchecked")
	public Vector<Object> dameModeloEspecialInterno(Vector <Object> info) throws Exception{
		Vector<Object> tmp = new Vector<Object>();
		Vector <String> interno =null;
		int tamanioVector = info.size();
		int cantidadProductos = 0;
		int claveBotana = 0;
// Obtengo la clave de la Botana que si trae propiedades.
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			claveBotana=cambiaAInt(config.getProperty("botanaCla").trim());
		}
		catch(IOException ioe){
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
// Averiguo cuantos productos son en total.
		for(int i = 0; i<info.size(); i++){
			Vector <String> temporal = (Vector)info.elementAt(i);
			if(((String)temporal.elementAt(1)).startsWith("1")){
				cantidadProductos += 1;
			}
			else{
				cantidadProductos += cambiaAInt((String)temporal.elementAt(0));
			}
//			System.out.println("Cantidad Productos: " +cantidadProductos);
		}
		for(int i = 0; i<info.size(); i++){
			Vector <String> temporal = ((Vector <String>)info.elementAt(i));
//			System.out.println("Tamanio temporal: " +temporal.size()+", Primer Elemento: " +temporal.elementAt(0));
			interno = new Vector <String>();
			// Hablamos de un alimento
			if(((String)temporal.elementAt(1)).startsWith("1")){
				String tipoDeAlimento = (String)temporal.elementAt(1);
				if(tipoDeAlimento.substring(tipoDeAlimento.indexOf("*")+1, tipoDeAlimento.lastIndexOf("*")).trim().equalsIgnoreCase(claveBotana+"")){
					int cantidadPedida = cambiaAInt((String)temporal.elementAt(0));
					for(int p = 0; p<cantidadPedida; p++){
						interno.addElement("1");
						interno.addElement(temporal.elementAt(1));
						interno.addElement(temporal.elementAt(2));
						interno.addElement(temporal.elementAt(3));
						interno.addElement(temporal.elementAt(4));
						interno.addElement("NA");
						interno.addElement("NA");
						interno.addElement("NA");
						interno.addElement("NA");
						interno.addElement(dameComponentesBotana());
						tmp.addElement(interno);
						interno = new Vector<String>();
					}
				}
				else{
					interno.addElement(temporal.elementAt(0));
					interno.addElement(temporal.elementAt(1));
					interno.addElement(temporal.elementAt(2));
					interno.addElement(temporal.elementAt(3));
					interno.addElement(temporal.elementAt(4));
					interno.addElement("NA");
					interno.addElement("NA");
					interno.addElement("NA");
					interno.addElement("NA");
					interno.addElement("NA");
					tmp.addElement(interno);
				}
			}
			else{
				String elProducto = ((String)temporal.elementAt(1)).trim();
				int claveDeProducto = cambiaAInt(elProducto.substring((elProducto.lastIndexOf("*"))+1, elProducto.length()));
				int esCombinable = dameTipoCombinacion(claveDeProducto);
				int esDimensionable = damePropiedadDimension(claveDeProducto);
				if(((String)temporal.elementAt(3)).startsWith("Copa")){
					int cantidadPedida = cambiaAInt((String)temporal.elementAt(0));
					for (int k=0; k < cantidadPedida; k++){
						if(esCombinable == 1 && esDimensionable == 1){
							String combinaInicial = "";
							try{
								String conf = "Server.conf";
								config = new Properties();
								config.load( new FileInputStream(conf) );
								combinaInicial=config.getProperty("refOficial");
								combinaInicial ="1 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
							}
							catch(IOException ioe){
								System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
								ioe.printStackTrace();
							}
							catch (IllegalArgumentException iae){
								System.out.println("Error de lectura malformacion de archivo de configuracion");
								iae.printStackTrace();
							}
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement("Sencillo");
							interno.addElement("Puesto");
							interno.addElement("Normal");
							interno.addElement("No");
							interno.addElement(combinaInicial);
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 1 && esDimensionable == 0){
							String combinaInicial = "";
							try{
								String conf = "Server.conf";
								config = new Properties();
								config.load( new FileInputStream(conf) );
								combinaInicial=config.getProperty("refOficial");
								combinaInicial ="1 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
							}
							catch(IOException ioe){
								System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
								ioe.printStackTrace();
							}
							catch (IllegalArgumentException iae){
								System.out.println("Error de lectura malformacion de archivo de configuracion");
								iae.printStackTrace();
							}
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement("NA");
							interno.addElement("Puesto");
							interno.addElement("Normal");
							interno.addElement("No");
							interno.addElement(combinaInicial);
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 0 && esDimensionable == 1){
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement("Sencillo");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("No");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else{
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
					}
				}
				else{
					int cantidadPedida = cambiaAInt((String)temporal.elementAt(0));
					for (int k=0; k < cantidadPedida; k++){
						if(esCombinable == 1){
							String combinaInicial = "";
							try{
								String conf = "Server.conf";
								config = new Properties();
								config.load( new FileInputStream(conf) );
								combinaInicial=config.getProperty("refOficial");
								if(((String)temporal.elementAt(3)).equalsIgnoreCase("Botella") || ((String)temporal.elementAt(3)).equalsIgnoreCase("Botella G.")){
									combinaInicial ="4 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
								}
								else{
									combinaInicial ="3 - "+dameNombreProducto(cambiaAInt(combinaInicial.trim()), 2) +" M. *"+combinaInicial;
								}
							}
							catch(IOException ioe){
								System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
								ioe.printStackTrace();
							}
							catch (IllegalArgumentException iae){
								System.out.println("Error de lectura malformacion de archivo de configuracion");
								iae.printStackTrace();
							}
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("No");
							interno.addElement(combinaInicial);
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 0){
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("No");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
						else if(esCombinable == 2){
							interno.addElement("1");
							interno.addElement(temporal.elementAt(1));
							interno.addElement(temporal.elementAt(2));
							interno.addElement(temporal.elementAt(3));
							interno.addElement(temporal.elementAt(4));
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							interno.addElement("NA");
							tmp.addElement(interno);
							interno = new Vector<String>();
						}
					}
				}
			}
		}
		return	tmp;
	}

	public MyTableModel dameModeloProductos(int area, int division) throws SQLException, Exception {
		//System.out.println("Entre a dameModeloProductos con:" +area +", " +division);
		MyTableModel tmp = null;
		// Genero mi Arreglo con los datos
		String [] titulos = new String[5];
		titulos[0] = "Cantidad";
		titulos[1] = "Clave";
		titulos[2] = "Producto";
		titulos[3] = "Tipo";
		titulos[4] = "Precio U.";
		try{
			ResultSet rs = listadoProductosBusqueda(area, division);
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnas = rsmd.getColumnCount();
			int renglones = getResultSetSize(rs);
			Object [][] datos = new Object [renglones][columnas];
			int renglon = 0;
			while(rs.next()){
				int tipoBebida = -1;
				if(area == 2){
					// tipoBebida-->  0 -> CopeoCon1Botella,  1 --> CopeoCon2 Botellas,  2-> SoloCopeo,   3->Solo1 Botella,  4 --> Las 2 Botellas.
					tipoBebida = dameClasificacionBotella(rs.getInt("clave"), division);
					//System.out.println("Recibo tipo de bebida:" +tipoBebida);
				}
				for (int i = 0 ; i<columnas; i++){
					if(i == 0){
						datos [renglon][i] = rs.getString("cantidad");
					}
					else if(i==1){
						datos [renglon][i] = rs.getString("clave");
						//System.out.println("En i = 1 -->" +rs.getString("textoArticulo"));
					}
					else if(i==2){
							datos [renglon] [i] = rs.getString("nombre");
					}
					else if (i == 3){
						if (area == 2){
							if(tipoBebida == 0 || tipoBebida == 1 ||  tipoBebida == 2){
								datos [renglon][i] = "Copa";
							}
							else if(tipoBebida == 3){
								datos [renglon][i] = "Botella";
							}
							else if(tipoBebida == 4 ){
								datos [renglon][i] = "Botella G.";
							}
						}
						else{
							datos [renglon][i] = rs.getString("tipo");
						}
					}
					else if (i == 4){
						if (area == 2){
							if(tipoBebida == 0  || tipoBebida == 1 || tipoBebida == 2){
								datos [renglon][i] = formatoDinero(acortaLongitud(rs.getString("precioC")));
							}
							else if(tipoBebida == 3 || tipoBebida == 4){
								datos [renglon][i] = formatoDinero(acortaLongitud(rs.getString("precioB1")));
							}
						}
						else{
							datos [renglon] [i] = formatoDinero(acortaLongitud(rs.getString("precio")));
						}
					}
				}
				renglon++;
			}
			tmp = new MyTableModel(titulos,datos);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, listadoProductosBusqueda ");
					q.printStackTrace();
				}
			}
		}
		return	tmp;
	}

/**
* El Método listadoProductos  nos regresa los productos que conforman un numero de ticket
*  @return ResultSet con los detalle por producto.
*/
	public ResultSet listadoProductosBusqueda(int area, int division){
		ResultSet rs = null;
		String query = "";
		try{
		// VErifico el area para saber si hablamos de un Alimento o una Bebida)
			if (area == 1){
				query = ("SELECT CONCAT('1') AS cantidad, clave, nombre,CONCAT('na')AS tipo, precio FROM alimentos WHERE division = "+division + " AND estatus = 1 ORDER BY nombre");
			}
// SI ES BEBIDA PARA EL CASO DE BOTELLA DEBO VERIFICAR QUE SI HAYA EN EXISTENCIA
			else{
				query = ("SELECT CONCAT('1') AS cantidad, clave, nombre, precioC, precioB1, precioB2 FROM bebidas WHERE division = "+division + " AND estatus = 1 ORDER BY nombre");
// Query previo donde verificaba que existiera botella.
				//query = ("SELECT CONCAT('1') AS Cantidad, clave, nombre, precioC, precioB FROM (SELECT clave, nombre, precioC, precioB FROM bebidas WHERE bebidas.precioB = 0.00 AND bebidas.division = "+division + "  AND bebidas.estatus = 1 UNION ALL  SELECT bebidas.clave,  bebidas.nombre, bebidas.precioC, bebidas.precioB FROM bebidas, materiaprima WHERE bebidas.precioB > 0.00 AND bebidas.division = "+division + "  AND bebidas.estatus = 1 AND materiaprima.clave = bebidas.materia0 AND materiaprima.inventarioBotella > 0 )AS TEMPORAL ORDER BY nombre");
			}
//			System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, listadoProductosBusqueda ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, listadoProductosBusqueda ");
			e.printStackTrace();
		}
		return rs;
	}


/**
* El Método dameClasificacionBotella  nos regresa los productos que conforman un numero de ticket
*  @return int Con el resultado de mi query, donde:
* tipoBebida-->  0 -> CopeoCon1Botella,  1 --> CopeoCon2 Botellas,  2-> SoloCopeo,   3->Solo1 Botella,  4 --> Las 2 Botellas.
*/
	public int  dameClasificacionBotella(int claveProducto, int division)throws SQLException, Exception {
		ResultSet rs = null;
		String query = "";
		int resultado = -1;
		try{
			query = ("SELECT  precioC, precioB1, precioB2 FROM bebidas WHERE division = "+division + " AND estatus = 1 AND clave = "+claveProducto +" ORDER BY nombre");
			//System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(rs.getDouble("precioC")>0.00 && rs.getDouble("precioB1") > 0.00 &&  rs.getDouble("precioB2") <= 0.00) {
					resultado = 0;
				}
				else if(rs.getDouble("precioC")>0.00 && rs.getDouble("precioB1") <= 0.00 &&  rs.getDouble("precioB2") > 0.00) {
					resultado = 0;
				}
				else if(rs.getDouble("precioC")>0.00 && rs.getDouble("precioB1") > 0.00  && rs.getDouble("precioB2") > 0.00){
					resultado = 1;
				}
				else if(rs.getDouble("precioC") > 0.00 && rs.getDouble("precioB1") <=  0.00  && rs.getDouble("precioB2") <= 0.00){
					resultado = 2;
				}
				else if((rs.getDouble("precioB1") > 0.00 && rs.getDouble("precioB2") <= 0.00) || (rs.getDouble("precioB1") <= 0.00 && rs.getDouble("precioB2") > 0.00)){
					resultado = 3;
				}
				else if(rs.getDouble("precioB1") > 0.00 && rs.getDouble("precioB2") > 0.00){
					resultado = 4;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, dameClasificacionBotella ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, dameClasificacionBotella ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, dameClasificacionBotella ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}



	public boolean existeDisponibilidadBotella(int claveProducto,int division,  String cantidad, int clasificacionBotella) throws SQLException, Exception {
		ResultSet rs = null;
		boolean resultado = false;
		int laCantidadDeseada = -1;
		laCantidadDeseada = cambiaAInt(cantidad);
		try{
			String query = ("SELECT materiaprima.inventarioBotella1, materiaprima.inventarioBotella2, materiaprima.litrosXBotella1, materiaprima.litrosXBotella2 FROM materiaprima, bebidas  WHERE bebidas.division = "+division +" AND bebidas.clave = "+claveProducto +" AND materiaprima.clave = materia0 ");
//			System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				// 0 --> Solo Botella   1--> Botella Grande,    2--> Botella Pequeña
				double botella1 = rs.getDouble("litrosXBotella1");
				double botella2 = rs.getDouble("litrosXBotella2");
				if(clasificacionBotella == 0 || clasificacionBotella == 1){
					if(botella1 > botella2){
						if(rs.getInt("inventarioBotella1") >= laCantidadDeseada){
							resultado = true;
						}
					}
					else{
						if(rs.getInt("inventarioBotella2") >= laCantidadDeseada){
							resultado = true;
						}
					}
				}
				else if(clasificacionBotella == 2){
					if(botella1 > botella2){
						if(rs.getInt("inventarioBotella2") >= laCantidadDeseada){
							resultado = true;
						}
					}
					else{
						if(rs.getInt("inventarioBotella1") >= laCantidadDeseada){
							resultado = true;
						}
					}
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, existeDisponibilidadBotella ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, existeDisponibilidadBotella ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, existeDisponibilidadBotella ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}


	public double recuperaPrecioXBotella(int claveProducto,int  division, int clasificacionBotella) throws SQLException, Exception {
		ResultSet rs = null;
		double elPrecio = 0.00;
		try{
			String query = ("SELECT precioB1, precioB2  FROM bebidas WHERE clave = "+claveProducto +" AND division = "+division);
			//System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				double precio1 = rs.getDouble("precioB1");
				double precio2 = rs.getDouble("precioB2");
				if(clasificacionBotella == 0 || clasificacionBotella ==1){
					if(precio1 > precio2){
						elPrecio = precio1;
					}
					else{
						elPrecio = precio2;
					}
				}
				else{
					if(precio1 > precio2){
						elPrecio = precio2;
					}
					else{
						elPrecio = precio1;
					}
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, recuperaPrecioXBotella ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, recuperaPrecioXBotella ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, recuperaPrecioXBotella ");
					q.printStackTrace();
				}
			}
		}
		return elPrecio;
	}


	public double recuperaPrecioXCopa(int claveProducto,int  division) throws SQLException, Exception {
		ResultSet rs = null;
		double elPrecio = 0.00;
		try{
			String query = ("SELECT precioC FROM bebidas WHERE clave = "+claveProducto +" AND division = "+division);
			//System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				elPrecio = rs.getDouble("precioC");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, recuperaPrecioXCopa ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, recuperaPrecioXCopa ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, recuperaPrecioXCopa ");
					q.printStackTrace();
				}
			}
		}
		return elPrecio;
	}

	public boolean verificaIdentidad(int usuarioID, int contra) throws SQLException, Exception{
		boolean resultado = false;
		ResultSet rs = null;
		try{
			String query = ("SELECT IDEmpleado FROM empleados WHERE IDEmpleado = "+usuarioID +" AND Contra = "+contra +" and Activo = 1");
//			System.out.println(query);
			con = new ConexionBD();
			Statement stmt = con.creaStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()){
				if(usuarioID == rs.getInt("IDEmpleado")){
					resultado = true;
				}
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en ManagerPuntoVenta, verificaIdentidad ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en ManagerPuntoVenta, verificaIdentidad ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
					con.cierraConexion();
				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en ManagerPuntoVenta, verificaIdentidad ");
					q.printStackTrace();
				}
			}
		}
		return resultado;
	}

// Setter´s OK
// GENERICAS:

// Metodo protegido me regresa la cantidad de renglones dentro de un resultSet
	protected int getResultSetSize(ResultSet resultSet) {
		ResultSet temporal = resultSet;
	    int size = -1;
	    try {
	        temporal.last();
	        size = temporal.getRow();
	        temporal.beforeFirst();
	    }
	    catch(SQLException e) {
	       e.printStackTrace();
	    }
		return size;
	}


	public String completaString(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 6 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}

	public String completaStringTicket(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 7 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}

	public String completaStringTipoPLU(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 2 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}



	public int cambiaAInt(String variable) throws Exception{
		int valor;
		try{
			valor = (Integer.parseInt(variable));
		}
		catch(NumberFormatException nfe){
			valor = 0;
		}
			return valor;
	}


	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}



	public String formatoCortoDinero(String enteros) throws Exception{
		StringBuilder sb1 = new StringBuilder (enteros);
		if(sb1.indexOf(".") != -1){
			sb1=sb1.delete(sb1.indexOf("."),sb1.length() );
		}
		boolean aumentaEnteros = false;
		StringBuilder sb = new StringBuilder (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			existieron = true;
			sb=sb.delete(0, sb.indexOf(".")+1);
			if(sb.length() == 1){
				sb.append("0");
			}
			else if(sb.length()>2){
				int primero = cambiaAInt(sb.substring(0,1));
				int anterior = cambiaAInt(sb.substring(1,2));
				int posterior = cambiaAInt(sb.substring(2,3));
				if(posterior >= 5){
					anterior +=1;
					if(anterior == 10){
						anterior = 0;
						primero +=1;
						if(primero == 10){
							primero = 0;
							aumentaEnteros = true;
						}
					}
					sb = new StringBuilder(primero+""+anterior+"");
				}
				else{
					sb = new StringBuilder(primero+""+anterior+"");
				}
			}
		}
		if (!existieron){
			sb = new StringBuilder ("00");
		}
		if(aumentaEnteros){
			int enteros2 = cambiaAInt(sb1.toString());
			enteros2 +=1;
			sb1 = new StringBuilder(enteros2+"");
		}
		return sb1.toString()+"."+sb.toString();
	}


	public double cambiaADouble(String variable) throws Exception{
		double valor;
		if(variable == null){
			variable = "";
		}
		try{
			Double val = (Double.valueOf(variable));
			valor = val.doubleValue();
		}
		catch(NumberFormatException nfe){
			valor =0;
		}
			return valor;
	}


	public String acortaLongitud(String muchosDecimales){
		StringBuffer sb = new StringBuffer (muchosDecimales);
		if(sb.indexOf(".") != -1){
			String decimales=sb.substring(sb.indexOf("."));
			String decima;
			decima = sb.substring(0, sb.indexOf("."));
			sb.delete(0,sb.length());
			if (decimales.length()>3){
				decimales = decimales.substring(0,3);
			}
			if(decimales.length()<=2){
				decimales = decimales+"0";
			}
			sb.append(decima);
			sb.append(decimales);
		}
		return sb.toString();
	}

	public String formatoDinero(String formato){
		StringBuffer losEnteros = new StringBuffer(dameEnteros(formato));
		String losDecimales = dameDecimales(formato);
		if(losEnteros.length() == 8){
			losEnteros.insert(2,',');
			losEnteros.insert(6,',');
		}
		else if(losEnteros.length() == 7){
			losEnteros.insert(1,',');
			losEnteros.insert(5,',');
		}
		else if(losEnteros.length() == 4 ){
			losEnteros.insert(1,',');
		}
		else if(losEnteros.length() == 5 ){
			losEnteros.insert(2,',');
		}
		else if(losEnteros.length() == 6 ){
			losEnteros.insert(3,',');
		}
		return losEnteros.toString()+"."+losDecimales;
	}

	public String dameDecimales(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			sb=sb.delete(0, sb.indexOf(".")+1);
			existieron = true;
		}
		if (!existieron){
			sb = new StringBuffer ("00");
		}
		return sb.toString();
	}

	public String dameEnteros(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		if(sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length() );
		}
		return sb.toString();
	}

	private String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}

	protected String formatoEspaciado(String cantidad) throws Exception{
		int tamanioCantidad = cantidad.length();
		while (tamanioCantidad < 10 ){
			cantidad = "  "+cantidad;
			tamanioCantidad++;
		}
		StringBuilder sb = new StringBuilder(cantidad);
		int contadorUnos = 0;
		while (sb.indexOf("1") != -1){
			sb.replace(sb.indexOf("1"), (sb.indexOf("1")+1),"*");
			contadorUnos ++;
		}
		while (sb.indexOf("*") != -1){
			sb.replace(sb.indexOf("*"), (sb.indexOf("*")+1),"1");
		}
		while (contadorUnos > 0){
			cantidad = " "+cantidad;
			contadorUnos --;
		}
		return cantidad;
	}

	protected String formatoEspaciado2(String cantidad) throws Exception{
		int tamanioCantidad = cantidad.length();
		while (tamanioCantidad < 10 ){
			cantidad = "  "+cantidad;
			tamanioCantidad++;
		}
		return cantidad;
	}

	public static String codifica (String src) throws UnsupportedEncodingException{
      String cody=java.net.URLEncoder.encode(src, "UTF-8");
      return cody;
	}



	public static String decodifica (String src) throws UnsupportedEncodingException{
		String decody;
		URLDecoder decoder = new URLDecoder();
		decody=decoder.decode(src, "UTF-8");
		return decody;
	}

	public static String formatStringA(String s) {
        String temp = Normalizer.normalize(s, Normalizer.DECOMP, 0);
        return temp.replaceAll("[^\\p{ASCII}]","");
    }


	public Date cambiaADate(String fecha) {
		java.sql.Date elDia;
		try {
			elDia = java.sql.Date.valueOf(new String(fecha));
		}
		catch(IllegalArgumentException iae){
			elDia = java.sql.Date.valueOf(new String("9999-10-10"));
		}
		return elDia;
	}


	public Time cambiaATiempo(String tiempo) {
		java.sql.Time elTiempo;
		try {
			elTiempo = java.sql.Time.valueOf(new String(tiempo));
		}
		catch(IllegalArgumentException iae){
			elTiempo = java.sql.Time.valueOf(new String("12:00:00"));
		}
		return elTiempo;
	}

}