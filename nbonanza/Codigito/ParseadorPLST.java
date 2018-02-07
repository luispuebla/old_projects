import java.util.Properties;
import java.io.FileInputStream;
import java.io.File;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;
/**
* La clase "ParseadorSWCash" es la encargada de extraer los datos del archivo generado por la báscula cuando crea un iiPreB1 y a partir de este extraer todos los artículos que fueron generados.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004)
*/
public class ParseadorPLST{

	private Properties p = new Properties();
	private String PLU = new String("");
	private String subDepto = new String("");
	private String precioBase1 = new String("");
	private String precioBase2 = new String("");
	private String diasConserva = new String("");
	private String basePrecio = new String("");
	private String cantidadXPaquete = new String("");
	private String claseiPreB1 = new String("");
	private String pesoFijo = new String("");
	private String textoArticulo = new String("");
	private DateStamp ds;
	private String descripcion = new String("");


/**
* El constructor de la clase es vacio.
*/
	public ParseadorPLST(){

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
* El método lectura  analiza el String extraido del iiPreB1 y asigna a la varible correspondiente cada uno de sus valores.
*  @param archivo  El String del nombre del archivo que contiene los datos del iiPreB1 generado por la báscula.
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
		ParseadorPLST g = new ParseadorPLST();
//		g.EjecutaBAT();
		g.lectura("Plst2.txt");
	}

/**
* El método parseaComponente  analiza el String extraido del iiPreB1 y asigna a la varible correspondiente cada uno de sus valores.
*  @param lineaiiPreB1  El String con los valores a ser parseados y asignados a cada varible
*/
	public void parseaComponente(String lineaParser){
		// Apuntadores que recorro a través del String recibido para ir asignando valores a las variables.
		int apuntadorI = 0;
		int apuntadorF = 0;
		// Cargo el formato que contiene mi iiPreB1
		try{
			p.load(new FileInputStream("paramPLST.conf"));
			int iPLU = Integer.parseInt(p.getProperty("PLU").trim());
			int isubDept = Integer.parseInt(p.getProperty("subDepto").trim());
			int iPreB1 = Integer.parseInt(p.getProperty("precioBase1").trim());
			int iPreB2 = Integer.parseInt(p.getProperty("precioBase2").trim());
			int idiasCon = Integer.parseInt(p.getProperty("diasConserva").trim());
			int ibaseP = Integer.parseInt(p.getProperty("basePrecio").trim());
			int icantPaq = Integer.parseInt(p.getProperty("cantidadXPaquete").trim());
			int iclaPLU = Integer.parseInt(p.getProperty("clasePLU").trim());
			int ipesoFix = Integer.parseInt(p.getProperty("pesoFijo").trim());
			int itextoArt = Integer.parseInt(p.getProperty("textoArticulo").trim());
			int longitudOficial = iPLU+isubDept+iPreB1+iPreB2+idiasCon+ibaseP+icantPaq+iclaPLU+ipesoFix+itextoArt;

			System.out.println("Serie: " +iPLU+"-"+isubDept+"-"+iPreB1+"-"+iPreB2+"-"+idiasCon+"-"+ibaseP+"-"+icantPaq+"-"+iclaPLU+"-"+ipesoFix+"-"+itextoArt);
			System.out.println("Valor longitud Deseada:" +longitudOficial +"\nValor longitud Encontrada:" +lineaParser.length());
			if(lineaParser.length()>longitudOficial){
				System.out.println("Verificar datos!, sobrepasan requerimiento esperado");
			}
			else {
				apuntadorF = iPLU;
				PLU = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += iPLU;
				apuntadorF += isubDept;
				subDepto = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += isubDept;
				apuntadorF += iPreB1;
				precioBase1 = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += iPreB1;
				apuntadorF += iPreB2;
				precioBase2 = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += iPreB2;
				apuntadorF += idiasCon;
				diasConserva = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += idiasCon;
				apuntadorF += ibaseP;
				basePrecio = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += ibaseP;
				apuntadorF += icantPaq;
				cantidadXPaquete = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += icantPaq;
				apuntadorF += iclaPLU;
				claseiPreB1 = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += iclaPLU;
				apuntadorF += ipesoFix;
				pesoFijo = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += ipesoFix;
				textoArticulo = lineaParser.substring(apuntadorI);
				String enteros = precioBase1.substring(0,4);
				String decimales = precioBase1.substring(4);
				double dPrecioBase1 = Double.parseDouble(enteros+"."+decimales);
				enteros = precioBase2.substring(0,4);
				decimales = precioBase2.substring(4);
				double dPrecioBase2 = Double.parseDouble(enteros+"."+decimales);
				System.out.println("Los valores numericos son: \n" +"Numero de PLU: " +PLU +"\n" +"SubDepartamento: " +subDepto +"\n" +"Precio Base 1: " +dPrecioBase1 +"\n" +"Precio Base 2: " +dPrecioBase2 	+"\n" +"dias Conserva: " +diasConserva +"\n" +"base Precio: " +basePrecio +"\n" +"cantidad por paquete: " +cantidadXPaquete +"\n" +"Clase PLU " +claseiPreB1 	+"\n" +"Peso Fijo: " +pesoFijo +"\n" +"Texto Articulo: " +textoArticulo );
			}
		}
		catch (NumberFormatException nfe){
			System.out.println("Mal formato numerico en paramiiPreB1.conf");
			nfe.printStackTrace();
		}
		catch (Exception q){
			System.out.println("Error generado en lectura de parametros de iiPreB1");
			q.printStackTrace();
		}

	}

}