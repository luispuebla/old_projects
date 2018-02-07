
//import com.ret.bd.ManagerProductos;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.DataOutputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;
/**
* La clase "ParseadorPLST" es la encargada de extraer los datos del archivo generado por la báscula cuando crea un ticket y a partir de este extraer todos los artículos que fueron generados.
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.0 (Diciembre 2004)
*/
public class MandaRecuperaPLSF{

//	private ManagerProductos iBD;


/**
* Método Setter del Bean para almacenar la Ruta de la aplicación para poder tener acceso al archivo de configuraciones (.conf) para obtener los datos sobre especificaciones adicionales del sistema.
* @param laRuta String con el path de la aplicación en curso.
*/

/**
* El constructor de la clase es vacio.
*/
	public MandaRecuperaPLSF(){
	}


/**
* Este método estático es el principal que se manda llamar para la ejecución del Sistema.
*
*/
	public static void main (String[] args) throws Exception{
		MandaRecuperaPLSF g = new MandaRecuperaPLSF();
		int ciclador = 1;
		String accion;
		String archivo=new String();
		System.out.print("Dame el numero de accion a ejecutar:\n1.TraerPLSF\n2.EnviarPLSF\n3.Ingresa Datos a BD\n4.Salir \n> ");
		accion= g.consolaString();
		while (ciclador ==1){
			if (accion.equalsIgnoreCase("1")){
				g.cicloTraer();
			}
			else if (accion.equalsIgnoreCase("2")){
				g.cicloMandar();
			}
			else if (accion.equalsIgnoreCase("3")){
				g.cicloIngresa();
			}
			else if (accion.equalsIgnoreCase("4")){
				ciclador = 0;
			}
			else{
				System.out.println("\nERROR!!, Accion desconocida.");
			}
			if (ciclador == 1){
				System.out.print("Dame el numero de accion a ejecutar:\n1.TraerPLST\n2.EnviarPLST\n3.Ingresa Datos a BD\n4.Salir \n> ");
				accion = g.consolaString();
			}
		}
		System.exit(0);
	}


	public void cicloIngresa() throws Exception{
		String nombreArchivo = new String();
		System.out.println("Dame el nombre del archivo que contien la informacion.");
		nombreArchivo = consolaString();
		while (nombreArchivo.equals("")){
			nombreArchivo = consolaString();
		}
		System.out.println("Tu archivo: " +nombreArchivo +" sera ingresado a la BD");
		System.out.println("Para iniciar presiona Enter");
		consolaString();
		ParseadorPLSF pplsf = new ParseadorPLSF();
		pplsf.lectura(nombreArchivo);



	}

	public void cicloTraer() throws Exception{
		String nombreArchivo = new String();
		System.out.println("Dame el nombre del archivo para guardar con formato: *.txt");
		nombreArchivo = consolaString();
		while (nombreArchivo.equals("")){
			nombreArchivo = consolaString();
		}
		System.out.println("Tu archivo sera creado bajo el nombre: " +nombreArchivo);
		System.out.println("Para iniciar presiona Enter y espera que termine el proceso..");
		consolaString();
		File batchTraer = new File("Traer.bat");
		FileWriter escritor = new FileWriter( batchTraer );
		BufferedWriter escritorBuff = new BufferedWriter( escritor );
		StringBuffer lineaArchivo = new StringBuffer();
		lineaArchivo.append("Swc_bat.exe traer.anw");
		lineaArchivo.append("\r\n");
		lineaArchivo.append("Swascii /iplsf /o"+nombreArchivo +" plsft.if");
		lineaArchivo.append("\r\n");
		lineaArchivo.append("exit");
		lineaArchivo.append("\r\n");
		escritorBuff.write( lineaArchivo.toString(), 0, lineaArchivo.toString().length() );
		escritor.flush();
		escritorBuff.close();
		Runtime runtime=Runtime.getRuntime();
		Process proc=runtime.exec("cmd.exe /c start Traer.bat");
		DataOutputStream dos = new DataOutputStream(proc.getOutputStream());
		dos.flush();
		BufferedReader brs = new BufferedReader(new InputStreamReader(proc.getInputStream()));
		String s = null;
		while((s=brs.readLine()) != null)
		{
			System.out.println(s);
		}
		proc.destroy();
		System.out.println("Proceso finalizado...");
	}

	public void cicloMandar() throws Exception{
		String nombreArchivo = new String();
		System.out.println("Dame el nombre del archivo que contiene los datos: ");
		nombreArchivo = consolaString();
		while (nombreArchivo.equals("")){
			nombreArchivo = consolaString();
		}
		System.out.println("Tu archivo sera ingresado a la bascula..");
		System.out.println("Para iniciar presiona Enter y espera que termine el proceso..");
		consolaString();
		File batchMandar = new File("Mandar.bat");
		FileWriter escritor = new FileWriter( batchMandar );
		BufferedWriter escritorBuff = new BufferedWriter( escritor );
		StringBuffer lineaArchivo = new StringBuffer();
		lineaArchivo.append("swascii /i"+nombreArchivo +" /oPLSF plsfm.if");
		lineaArchivo.append("\r\n");
		lineaArchivo.append("Swc_bat enviar.anw");
		lineaArchivo.append("\r\n");
		lineaArchivo.append("exit");
		lineaArchivo.append("\r\n");
		escritorBuff.write( lineaArchivo.toString(), 0, lineaArchivo.toString().length() );
		escritor.flush();
		escritorBuff.close();
		Runtime runtime=Runtime.getRuntime();
		Process proc=runtime.exec("cmd.exe /C start Mandar.bat");
		DataOutputStream dos = new DataOutputStream(proc.getOutputStream());
		dos.flush();
		BufferedReader brs = new BufferedReader(new InputStreamReader(proc.getInputStream()));
		String s = null;
		while((s=brs.readLine()) != null)
		{
			System.out.println(s);
		}
		proc.destroy();
		System.out.println("Proceso finalizado...");
	}

	private boolean creaArchivo(String datos){
		boolean resultado = false;
		try {
			FileWriter escritor = new FileWriter(datos);
			BufferedWriter escritorBuff = new BufferedWriter( escritor );
			escritorBuff.write( datos, 0, datos.length() );
			escritor.flush();
			escritorBuff.close();
			resultado = true;
		}
		catch (IOException ioe){
			System.out.println("No pude crear el archivo con los datos");
			ioe.printStackTrace();
		}
		return resultado;
	}


	public String consolaString()  throws Exception{
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in) );
		String linea = null;
		try{
			while( true ) {
				System.out.flush();
				linea = in.readLine();
				if(linea!=null) break;
				}
			}
		catch( IOException e )	{
			e.printStackTrace();
		}
		return linea.trim();
	}

}