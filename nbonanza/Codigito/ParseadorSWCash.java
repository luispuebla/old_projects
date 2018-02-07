import java.util.Properties;
import java.io.FileInputStream;
import java.io.File;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;
/**
* La clase "ParseadorSWCash" es la encargada de extraer los datos del archivo generado por la báscula cuando crea un ticket y a partir de este extraer todos los artículos que fueron generados.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004)
*/
public class ParseadorSWCash{

	private Properties p = new Properties();
	private String numTicket = new String("");
	private String tipoRegis = new String("");
	private String numArticu = new String("");
	private String numDepart = new String("");
	private String modOperac = new String("");
	private String numClient = new String("");
	private String numOperad = new String("");
	private String numBascul = new String("");
	private String peso_cant = new String("");
	private String precioVen = new String("");
	private String cantDescu = new String("");
	private String valorArSP = new String("");
	private String identiPre = new String("");
	private String identCanc = new String("");
	private String textoAdic = new String("");
	private DateStamp ds;
	private String descripcion = new String("");


/**
* El constructor de la clase es vacio.
*/
	public ParseadorSWCash(){

	}


	private void EjecutaBAT() {
		try {
			System.out.println("Entre al EjecutaBAT");
			Runtime.getRuntime().exec("cmd /K start D:\\prueba\\kiko.bat");
			System.out.println("Sali del EjecutaBAT");
		}
		catch (Exception eOut) {
			eOut.printStackTrace();
		}
	}



/**
* El método lectura  analiza el String extraido del Ticket y asigna a la varible correspondiente cada uno de sus valores.
*  @param archivo  El String del nombre del archivo que contiene los datos del ticket generado por la báscula.
*/
	public void lectura(String archivo) throws IOException{
		FileReader lector = new FileReader(archivo);
		BufferedReader lectorBuff = new BufferedReader(lector);
		while( true ) {
			String linea = null;
			int i=0;
			linea = lectorBuff.readLine();
			if( linea == null ) break;
			linea.trim();
			parseaComponente(linea);

			if( linea.length() < 1 ) continue;
		}
		lectorBuff.close();
	}


/**
* Este método estático es el principal que se manda llamar para la ejecución del Sistema.
*
*/
	public static void main (String[] args) throws Exception{
		ParseadorSWCash g = new ParseadorSWCash();
		g.EjecutaBAT();
		g.lectura("b00001.320");
	}

/**
* El método parseaComponente  analiza el String extraido del Ticket y asigna a la varible correspondiente cada uno de sus valores.
*  @param lineaTicket  El String con los valores a ser parseados y asignados a cada varible
*/
	public void parseaComponente(String lineaTicket){
		// Apuntadores que recorro a través del String recibido para ir asignando valores a las variables.
		int apuntadorI = 0;
		int apuntadorF = 0;
		// Cargo el formato que contiene mi ticket
		try{
			p.load(new FileInputStream("paramTicket.conf"));
			int ticket = Integer.parseInt(p.getProperty("numTicket").trim());
			int registro = Integer.parseInt(p.getProperty("tipoRegis").trim());
			int plu = Integer.parseInt(p.getProperty("numArticu").trim());
			int depto = Integer.parseInt(p.getProperty("numDepart").trim());
			int opera = Integer.parseInt(p.getProperty("modOperac").trim());
			int cliente = Integer.parseInt(p.getProperty("numClient").trim());
			int operador = Integer.parseInt(p.getProperty("numOperad").trim());
			int bascula = Integer.parseInt(p.getProperty("numBascul").trim());
			int pesoOcant = Integer.parseInt(p.getProperty("peso/cant").trim());
			int precio = Integer.parseInt(p.getProperty("precioVen").trim());
			int descuento = Integer.parseInt(p.getProperty("cantDescu").trim());
			int SP = Integer.parseInt(p.getProperty("valorArSP").trim());
			int idSpre = Integer.parseInt(p.getProperty("identiPre").trim());
			int idCancela = Integer.parseInt(p.getProperty("identCanc").trim());
			int adicional = Integer.parseInt(p.getProperty("textoAdic").trim());
			int longitudOficial = ticket+registro+plu+depto+opera+cliente+operador+bascula+pesoOcant+precio+descuento+SP+idSpre+idCancela+adicional;
			System.out.println("Valor longitud Deseada:" +longitudOficial +"\nValor longitud Encontrada:" +lineaTicket.length());
			if(lineaTicket.length()!=longitudOficial){
				System.out.println("No concuerdan las longitudes del ticket y paramTicket");
			}
			else {
				apuntadorF = ticket;
				numTicket = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += ticket;
				apuntadorF += registro;
				tipoRegis = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += registro;
				apuntadorF += plu;
				numArticu = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += plu;
				apuntadorF += depto;
				numDepart = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += depto;
				apuntadorF += opera;
				modOperac = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += opera;
				apuntadorF += cliente;
				numClient = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += cliente;
				apuntadorF += operador;
				numOperad = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += operador;
				apuntadorF += bascula;
				numBascul = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += bascula;
				apuntadorF += pesoOcant;
				peso_cant = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += pesoOcant;
				apuntadorF += precio;
				precioVen = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += precio;
				apuntadorF += descuento;
				cantDescu = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += descuento;
				apuntadorF += SP;
				valorArSP = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += SP;
				apuntadorF += idSpre;
				identiPre = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += idSpre;
				apuntadorF += idCancela;
				identCanc = lineaTicket.substring(apuntadorI, apuntadorF);
				apuntadorI += idCancela;
				apuntadorF += adicional;
				textoAdic = lineaTicket.substring(apuntadorI, apuntadorF);
				System.out.println("Los valores numericos son: \n" +"Numero de Ticket: " +numTicket +"\n" +"Tipo de Resgistro: " +tipoRegis +"\n" +"Numero de Articulo: " +numArticu +"\n" +"Numero Departamento: " +numDepart +"\n" +"Modo de Operacion: " +modOperac +"\n" +"Numero de Cliente: " +numClient +"\n" +"Numero de Operador: " +numOperad +"\n" +"Numero de Bascula: " +numBascul +"\n" +"Peso y/o Cantidad en Relacion con el articulo: " +peso_cant +"\n" +"Precio de Venta: " +precioVen +"\n" +"Cantidad de Descuento: " +cantDescu +"\n"		+"Valor SP de Articulo: " +valorArSP +"\n" +"ID Sobreescritura de Precio: " +identiPre +"\n" +"ID de Cancelacion: " +identCanc +"\n" +"Texto Adicional: " +textoAdic +"\n");
			}
		}
		catch (NumberFormatException nfe){
			System.out.println("Mal formato numerico en paramTicket.conf");
			nfe.printStackTrace();
		}
		catch (Exception q){
			System.out.println("Error generado en lectura de parametros de Ticket");
			q.printStackTrace();
		}

	}

}