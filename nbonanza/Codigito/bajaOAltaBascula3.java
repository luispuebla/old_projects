import java.io.File;
import java.io.IOException;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.DataOutputStream;
import java.io.DataInputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;



public class bajaOAltaBascula3 {

	private String laRuta = new String();
	private OutputStream os;
	private Thread tservice, tservice2;
	private boolean bandera = true;
	private boolean finalizado = false;
	private InputStream is;


	public void setLaRuta (String laRuta){
		this.laRuta= laRuta;
	}


	public bajaOAltaBascula3(){
	}


	public void arrancaServicio(){
		System.out.println("VOY A COMENZAR EL SERVICIO!!");
		tservice = new Thread (new Runnable(){
		public void run(){
			Process proc = null;
			Runtime runtime;
			try{
				System.out.println("ENTRE AL TRY DE ARRANQUE DE SERVICIO!!!");
				runtime=Runtime.getRuntime();
				proc=runtime.exec("cmd.exe /C start C:\\retonito\\SWCash\\SWCASH2.bat");
				System.out.println("ARRANCADO EL SERVICIO!!");
				DataOutputStream dos = new DataOutputStream(proc.getOutputStream());
				dos.flush();
				BufferedReader brs = new BufferedReader(new InputStreamReader(proc.getInputStream()));
				String s = null;
				while((s=brs.readLine()) != null || bandera) {
					System.out.println(s);
				}
				proc.destroy();
				System.out.println("CAPUT THREAD ARRANQUE!!");
				finalizado = true;
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
	});
		tservice.start();
	}


	public static void main(String[] args) throws Exception{
		bajaOAltaBascula3 boa = new bajaOAltaBascula3();
		boa.setLaRuta("C:\\Tomcat\\webapps\\retonito\\WEB-INF\\SWCom\\");
		boa.arrancaServicio();
		for (int i =0; i<30000000; i++){
			System.out.print("");
		}
		System.out.println("Voy a terminar");
		boa.paro();
		System.out.println("Terminamos...");
	}


	public void paro() throws Exception{
		System.out.println("Voy a parar el servicio de SWCash");
		for (int i =0; i<300000; i++){
			System.out.print("");
		}
		bandera = false;
		Runtime runtime=Runtime.getRuntime();
		Process proc=runtime.exec("cmd.exe /C start C:\\retonito\\SWCash\\QUIT2.bat");
		DataOutputStream dos = new DataOutputStream(proc.getOutputStream());
		dos.flush();
		BufferedReader brs = new BufferedReader(new InputStreamReader(proc.getInputStream()));
		String s = null;
		while((s=brs.readLine()) != null) {
			System.out.println(s);
		}
		proc.destroy();
		while (!finalizado){
			System.out.println("Espero que pare Thread de SWCash...");
		}
	}

}