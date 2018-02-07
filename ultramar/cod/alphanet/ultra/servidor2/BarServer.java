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


public class BarServer {

	protected static Properties config;
	private int  PORT = 0;
	private String HOST_NAME= "";
	protected static BarServer  barServer;
	protected boolean cargaConfiguracion = true;


	public BarServer() throws RemoteException, MalformedURLException, NotBoundException{
		try{
			String conf = "Server.conf";
			config = new Properties();
			config.load( new FileInputStream(conf) );
			HOST_NAME=config.getProperty("server.host");
			PORT= Integer.parseInt(config.getProperty("server.port").trim());
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
		LocateRegistry.createRegistry(PORT);
		System.out.println( "Registro Creado" );
		BarServerImpl bsi = new BarServerImpl();
		String urlString = "//"+HOST_NAME+":"+Integer.toString(PORT)+"/"+"BarServicio";
		Naming.rebind(urlString, bsi);
		System.out.println("Esperando peticiones de cliente...");
	}

   public static void main ( String[] args )   {
		try{
			System.setSecurityManager( new RMISecurityManager() );
			barServer = new BarServer();
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
		catch ( NotBoundException nbe )   {
			System.out.println( "Not Bound" +nbe );
		}
	}  // main
}  // class RMIServer

