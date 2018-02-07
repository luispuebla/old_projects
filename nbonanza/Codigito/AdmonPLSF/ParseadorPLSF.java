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
public class ParseadorPLSF{

	private Properties p = new Properties();
	private String PLU = new String("");
	private String subDepto = new String("");
	private String idOferta = new String("");
	private String numOrden = new String("");
	private String ca_peEscalon =  new String("");
	private String campoPrecio = new String(" ");
	private String campoBit = new String("");
	private String formaEscalon = new String("");
	private String tipoEscalon = new String("");
	private double dCampoPrecio;
	private ManagerProductos iBD;

/**
* El constructor de la clase es vacio.
*/
	public ParseadorPLSF(){

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
		ParseadorPLSF g = new ParseadorPLSF();
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
			p.load(new FileInputStream("paramPLSF.conf"));
			int iPLU = Integer.parseInt(p.getProperty("PLU").trim());
			int isubDept = Integer.parseInt(p.getProperty("subDepto").trim());
			int iidOf = Integer.parseInt(p.getProperty("idOferta").trim());
			int inumOr = Integer.parseInt(p.getProperty("numOrden").trim());
			int ica_peEs = Integer.parseInt(p.getProperty("ca_peEscalon").trim());
			int icampoPr = Integer.parseInt(p.getProperty("campoPrecio").trim());
			int icampoBi = Integer.parseInt(p.getProperty("campoBit").trim());
			int iformaEs= Integer.parseInt(p.getProperty("formaEscalon").trim());
			int itipoEs = Integer.parseInt(p.getProperty("tipoEscalon").trim());
			int longitudOficial = iPLU+isubDept+iidOf+inumOr+ica_peEs+icampoPr+icampoBi+iformaEs+itipoEs;
//			System.out.println("Serie: " +iPLU+"-"+isubDept+"-"+iPreB1+"-"+iPreB2+"-"+idiasCon+"-"+ibaseP+"-"+icantPaq+"-"+iclaPLU+"-"+ipesoFix+"-"+itextoArt);
//			System.out.println("Valor longitud Deseada:" +longitudOficial +"\nValor longitud Encontrada:" +lineaParser.length());
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
				apuntadorF += iidOf;
				idOferta = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += iidOf;
				apuntadorF += inumOr;
				numOrden = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += inumOr;
				apuntadorF += ica_peEs;
				ca_peEscalon = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += ica_peEs;
				apuntadorF += icampoPr;
				campoPrecio = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += icampoPr;
				apuntadorF += icampoBi;
				campoBit = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += icampoBi;
				apuntadorF += iformaEs;
				formaEscalon = lineaParser.substring(apuntadorI, apuntadorF);
				apuntadorI += iformaEs;
				apuntadorF += itipoEs;
				tipoEscalon = lineaParser.substring(apuntadorI, apuntadorF);
				String enteros = campoPrecio.substring(0,4);
				String decimales = campoPrecio.substring(4);
				dCampoPrecio = Double.parseDouble(enteros+"."+decimales);
				System.out.println("Los valores numericos son: \n" +"Numero de PLU: " +PLU +"\n" +"SubDepartamento: " +subDepto +"\n" +"ID de Ofera: " +idOferta +"\n" +"Numero de Orden: " +numOrden 	+"\n" +"Cantidad/Peso Escalonado: " +ca_peEscalon 	+"\n" +"Campo Precio: " +dCampoPrecio 	+"\n" +"Status Campo de Bit: " +campoBit +"\n" 				+"Formato de Escalonado: " +formaEscalon +"\n" +"Tipo de Escalonado: " +tipoEscalon +"\n");
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
		try{
			System.out.println("AQUI ALMACENARIA");
			almacenaBD();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	public void almacenaBD() throws Exception{
		iBD = new ManagerProductos();
		iBD.addDatosProdEscalonado(PLU, subDepto, idOferta, numOrden, ca_peEscalon, dCampoPrecio, campoBit, formaEscalon, tipoEscalon);
	}

}