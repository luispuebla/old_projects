// Copyright MageLang Institute; Version $Id: //depot/main/src/edu/modules/RMI-mml2/magercises/RMICallback/Solution/Applet1.java#2 $
import java.net.URL;
import java.rmi.*;
import java.rmi.server.*;

public class Cliente {
   // Change this to your computer's name
   private final static String HOST_NAME = "alpha-server";
	private final static int PORT = 10005;
	private static Cliente clie;

	public Cliente() {
		String dameSaludo = "";
		BarServicio bs ;
		try{
			bs = (BarServicio)Naming.lookup("rmi://"+HOST_NAME+":"+Integer.toString(PORT)+"/BarServicio");
         	System.out.println( "RemoteModelManager lookup successful" );
			dameSaludo = bs.DimeHola(" Enrique");
			System.out.println("Dame el resultado de mi peticion: \n" +dameSaludo);
		}
		catch ( RemoteException re ) {
			re.printStackTrace();
			System.out.println( "" + re );
		}
		catch ( Exception e ) {
			e.printStackTrace();
			System.out.println( "-->" + e );
		}
	}

	public static void main (String [] args) {
		Cliente clie = new Cliente();
	}
}
