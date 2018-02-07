import java.io.File;
import java.io.IOException;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.OutputStream;
import java.io.InputStream;

public class bajaOAltaBascula2 extends Thread {

	private String laRuta = new String();
	private OutputStream os;
	private Thread tservice, tservice2;
	private boolean fuera = true;
	private boolean listo = true;
	private boolean listo2 = true;
	private InputStream is;

	public void setLaRuta (String laRuta){
		this.laRuta= laRuta;
	}


	public bajaOAltaBascula2(){
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
				System.out.println("ENTRE AL TRY DE ARRANQUE DE SERVICIO!!!");
				runtime=Runtime.getRuntime();
				proc=runtime.exec("cmd /C start C:\\retonito\\SWCash\\SWCASH2.bat");
				System.out.println("ARRANCADO EL SERVICIO!!");
				is=proc.getInputStream();
				//while (fuera){
				//	tservice.sleep(5000);
				//}
				//paro();
				//while(is.read()!=-1){
				//	System.out.print("IS TRAE: "+is.read());
				//}
				while (proc.waitFor() != 0 || fuera){
					is=proc.getInputStream();
					System.out.print("IS TRAE: "+is.read());
					System.out.print("Esperando....");
				}
				//runtime.exit(0);
				System.out.println("CAPUT THREAD ARRANQUE!!");
				System.out.print("IS TRAE: "+is.read());
				listo = false;
				listo2 = false;
				//tservice2.join();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
	});
		tservice.start();
	}


	public static void main(String[] args) throws Exception{
		bajaOAltaBascula2 boa = new bajaOAltaBascula2();
		boa.setLaRuta("C:\\Tomcat\\webapps\\retonito\\WEB-INF\\SWCom\\");
		boa.arrancaServicio();
		for (int i =0; i<40000000; i++){
			System.out.print("");
		}
		//boa.iniciaServicioSWCash();
		//boa.ejecutaBaja("000123");
		boa.fuera=false;
		while(boa.listo2){System.out.print("");}
		//System.out.println("Ya lo elimine... calalo!!!");
		//boa.ejecutaAlta("00003900320001PRUEBA! VENECIA GALON PZA                             ");
		System.out.println("Terminamos...");
	}


	public void paro() throws Exception{
		System.out.println("Voy a parar el servicio de SWCash");
		for (int i =0; i<300000; i++){
			System.out.print("");
		}
		tservice2 = new Thread (new Runnable(){
			public void run(){
				boolean resultado = true;
				Process proc = null;
				Runtime runtime;
				try{
					System.out.println("ENTRE AL TRY DE DETENCION!!!");
					runtime=Runtime.getRuntime();
					proc=runtime.exec("cmd /C start C:\\retonito\\SWCash\\QUIT2.bat");
					System.out.println(" MANDE COMANDO DE DETENCION!!");
					while (proc.waitFor() != 0 ){
						System.out.print("Esperando....");
					}
				System.out.println("CAPUT THREAD DETENCION!!");
				join();
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
	});
		tservice2.start();
	}

}