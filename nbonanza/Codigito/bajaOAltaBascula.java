import java.io.File;
import java.io.IOException;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.OutputStream;

public class bajaOAltaBascula extends Thread {

	private String laRuta = new String();
	private OutputStream os;
	private Thread tservice;
	private boolean fuera = true;
	private boolean listo = true;


	public void setLaRuta (String laRuta){
		this.laRuta= laRuta;
	}


	public bajaOAltaBascula(){
	}


	public boolean ejecutaBaja(String cadena) throws Exception{
		boolean resultado = true;
		if (creaArchivo(cadena)){
			if (paraServicioSWCash()){
				for(int i = 0; i<200000; i++){System.out.print("\r");}
				try{
					Runtime runtime=Runtime.getRuntime();
					Process proc=runtime.exec("cmd /C start " +laRuta /*+"\\WEB-INF\\SWCash\\SWCash.bat"*/+"envElim.bat");
				}
				catch (IOException ioe){
					resultado = false;
					System.out.println("No pude ejecutar el proceso de baja SWCom");
					ioe.printStackTrace();
				}
				for(int i = 0; i<100000; i++){System.out.print("\r");}
				iniciaServicioSWCash();
				for(int i = 0; i<100000; i++){System.out.print("\r");}
			}
		}
		else{
			resultado = false;
		}
		return resultado;
	}


	public boolean ejecutaAlta(String cadena) throws Exception{
		boolean resultado = true;
		if (creaArchivo(cadena)){
			if (paraServicioSWCash()){
				for(int i = 0; i<200000; i++){System.out.print("\r");}
				try{
					Runtime runtime=Runtime.getRuntime();
					Process proc=runtime.exec("cmd /C start " +laRuta +"envAlta.bat");
				}
				catch (IOException ioe){
					resultado = false;
					System.out.println("No pude ejecutar el proceso de baja SWCom");
					ioe.printStackTrace();
				}
				for(int i = 0; i<100000; i++){System.out.print("\r");}
				iniciaServicioSWCash();
				for(int i = 0; i<100000; i++){System.out.print("\r");}
			}
		}
		else{
			resultado = false;
		}
		return resultado;
	}


	public boolean paraServicioSWCash() throws Exception{
		boolean resultado = true;
		int paroOK = 0;
		try{
			Runtime runtime=Runtime.getRuntime();
			Process proc=runtime.exec("cmd /C start C:\\retonito\\SWCash\\QUIT2.bat");
			while (proc.waitFor() != 0 ){
				System.out.print("Esperando....");
			}
			for(int i = 0; i<100000; i++){System.out.print("\r");}
		}
		catch (IOException ioe){
			resultado = false;
			System.out.println("No pude ejecutar el proceso de paraServicioSWCash");
			ioe.printStackTrace();
		}
		return resultado;
	}


	public void arrancaServicio(){
		System.out.println("VOY A COMENZAR EL SERVICIO!!");
		for(int i = 0; i<100000; i++){System.out.print("\r");}
		tservice = new Thread (new Runnable(){
		public void run(){
			boolean resultado = true;
			Process proc = null;
			Runtime runtime;
			try{
				System.out.println("ENTRE AL TRY!!!");
				runtime=Runtime.getRuntime();
				proc=runtime.exec("cmd /C start C:\\retonito\\SWCash\\SWCASH2.bat");
				System.out.println("ARRANCADO EL SERVICIO!!");
				while (fuera){
					tservice.sleep(5000);
				}
				proc.destroy();
				while (proc.waitFor() != 0 ){
					System.out.print("Esperando....");
				}
				System.out.println("CAPUT THREAD!!");
				listo = false;
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
	});
		tservice.start();
	}


	public boolean iniciaServicioSWCash(){
		boolean resultado = true;
		try{
			Runtime runtime=Runtime.getRuntime();
			Process proc=runtime.exec("cmd /C start C:\\retonito\\SWCash\\SWCASH2.bat");
		}
		catch (IOException ioe){
			resultado = false;
			System.out.println("No pude ejecutar el proceso de iniciaServicioSWCash");
			ioe.printStackTrace();
		}
		return resultado;
	}


	public static void main(String[] args) throws Exception{
		bajaOAltaBascula boa = new bajaOAltaBascula();
		boa.setLaRuta("C:\\Tomcat\\webapps\\retonito\\WEB-INF\\SWCom\\");
		boa.arrancaServicio();
		for (int i =0; i<50000000; i++){
			System.out.print("");
		}
		//boa.iniciaServicioSWCash();
		//boa.ejecutaBaja("000123");
		boa.paro();
		while(boa.listo){}
		//System.out.println("Ya lo elimine... calalo!!!");
		//boa.ejecutaAlta("00003900320001PRUEBA! VENECIA GALON PZA                             ");
		System.out.println("Terminamos...");
	}


	public void paro() throws Exception{
		System.out.print("Voy a parar el servicio de SWCash");
		for (int i =0; i<300000; i++){
			System.out.print("");
		}
		fuera = false;
		System.out.print("Despierta Thread!!!!");
		for (int i =0; i<300000; i++){
			System.out.print("");
		}
			Runtime runtime=Runtime.getRuntime();
			Process proc=runtime.exec("cmd /C start C:\\retonito\\SWCash\\QUIT2.bat");
	}


	private boolean creaArchivo(String datos){
		boolean resultado = false;
		try {
			FileWriter escritor = new FileWriter( laRuta +"plst.txt" );
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


}