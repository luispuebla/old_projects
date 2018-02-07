// Copyright MageLang Institute; Version $Id: //depot/main/src/edu/modules/RMI-mml2/magercises/RMICallback/Solution/Applet1.java#2 $
import java.net.URL;
import java.rmi.*;
import java.rmi.server.*;

public class Cliente implements  Prueba2 {
   // Change this to your computer's name
   private final static String HOST_NAME = "alpha-server";
   private DatoPrueba dp;


	public Cliente() {
	}

	public static void main (String [] args) {
		Cliente clie = new Cliente();
		try{
			System.out.println( "Inicio solicitud de Conexion..." );
			UnicastRemoteObject.exportObject( clie );
			String hostName = HOST_NAME;
			String  serverName = "rmi://" + hostName + ":10005/DatoPrueba" ;
			System.out.println( "Conexion realizada con: " + serverName );

			try  {
				clie.dp = (DatoPrueba)Naming.lookup(serverName );
			}
			catch ( Exception e ) {
				e.printStackTrace();
				System.out.println( "-->" + e );
			}
			clie.dp.registerPrueba2( clie );
			System.out.println( "Ya estamos registrados..." );
		}
		catch ( RemoteException re ) {
			re.printStackTrace();
			System.out.println( "" + re );
		}
		catch (Exception q){
			q.printStackTrace();
		}
	}


   public String tellMePrueba2(  )
   {
      System.out.println("Prueba 2");
      return("Prueba2");
   }

}
