// Copyright MageLang Institute; Version $Id: //depot/main/src/edu/modules/RMI-mml2/magercises/RMICallback/Solution/RMIServer.java#2 $
import java.net.*;
import java.io.*;
import java.util.Properties;

import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.LocateRegistry;

/**
 * RMIServer acts as a server for the remote "TimeServer" service.
 *
 * RMIServer starts execution at the standard entry point "public static void main";
 * It creates an instance of itself and continues processing in the constructor.
 *
 */


	public class BarServer implements Remote, DatoPrueba {

		protected static Properties config;
		private int  PORT = 0;
		private String HOST_NAME= "";
		protected static BarServer  barServer;
		protected boolean cargaConfiguracion = true;

   public static void main ( String[] args )   {
	// OBTENGO MIS DATOS DE ARCHIVO DE CONFIGURACION
		try{
			barServer = new BarServer();
			System.setSecurityManager( new RMISecurityManager() );
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			barServer.HOST_NAME=config.getProperty("server.host");
			barServer.PORT= Integer.parseInt(config.getProperty("server.port").trim());
		}
		catch(IOException ioe){
			barServer.cargaConfiguracion = false;
			System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
			ioe.printStackTrace();
		}
		catch (IllegalArgumentException iae){
			barServer.cargaConfiguracion = false;
			System.out.println("Error de lectura malformacion de archivo de configuracion");
			iae.printStackTrace();
		}
		if(barServer.cargaConfiguracion){
			try  {
				LocateRegistry.createRegistry( barServer.PORT );
				System.out.println( "Registro Creado" );
				UnicastRemoteObject.exportObject( ((DatoPrueba)barServer) );
				Naming.rebind( "//" + barServer.HOST_NAME + ":" + Integer.toString( barServer.PORT ) + "/" + "DatoPrueba", barServer );
				System.out.println( "Bindings Finalizado" );
				System.out.println( "Esperando Clientes...." );
		    }
			catch ( java.rmi.UnknownHostException uhe ) {
				System.out.println( "No concuerda el nombre del Host("+barServer.HOST_NAME+")" );
			}
			catch ( RemoteException re ) {
				System.out.println( "Error al iniciar el servicio" );
				System.out.println( "" + re );
			}
			catch ( MalformedURLException mURLe ) {
				System.out.println( "Error Interno" + mURLe );
			}
		}
	}  // main


   public void registerPrueba2( Prueba2 p2 )   {
      System.out.println( "Client solicitando coexion" );
      TimeTicker tt;
      // Insert two lines of code that complete the implementation of this method.
      // 1. Create a new TimeTicker object
      // 2. Start this new object running.
      tt = new TimeTicker( p2 );
      tt.start();
      System.out.println( "Timer Started" );
   }


}  // class RMIServer

class TimeTicker extends Thread
{
   private Prueba2 tm;

   TimeTicker( Prueba2  tm )
   {
      this.tm = tm;
   }

   public void run()
   {
      while ( true )
      {
         try
         {
            sleep( 2000 );
			tm.tellMePrueba2( );
         }
         catch ( Exception e )
         {
            stop();
         }
      }
   }
}


