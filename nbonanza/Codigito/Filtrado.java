

import java.io.File;
import java.io.FilenameFilter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;


public class Filtrado extends Thread{

	// Donde estaran guardados los archivos
	private File directorio;
	private String[] lista = null;
	private Properties p = new Properties();
	private Thread tescucha, tinterno;
	private boolean fuera = true;


	public String[] recorrido() throws Exception{
		lista = directorio.list( new FilenameFilter(){
				public boolean accept( File d, String n ) {
					return n.matches("[b]{1}?" +"[0-9]{5}?"+"."+"[0-9]{3}?");
				}
			});
/*		System.out.println("Entre a listado...");
		for (int i = 0; i<lista.length; i++){
			System.out.println("i --> " +lista[i]);
		}
		System.out.println("Esto es Lista: " +lista.length); */
		return lista;
	}



	public Filtrado (){
		try{
			p.load(new FileInputStream("paramsSW.conf"));
			directorio = new File(p.getProperty("dirSWCash").trim());
			System.out.println ("Directorio trae: " +directorio);
			orale();
		}
		catch (FileNotFoundException fnfe){
			fnfe.printStackTrace();
		}
		catch (IOException ioe){
			ioe.printStackTrace();
		}
	}

	public void detente() throws Exception{
		String[] ticketPendientes = null;
		ticketPendientes = recorrido();
		while(ticketPendientes.length != 0){
			ticketPendientes = recorrido();
			System.out.println("Existen tickets aun...");
		}
		fuera = false;
	}


	public static void main(String [] args)  throws Exception{
		Filtrado f = new Filtrado();
		f.start();
		f.detente();
	}


	public void orale(){
	tescucha = new Thread (new Runnable(){
		public void run(){
			try{
				boolean generoInterno = false;
				// Ciclo infinito mi hilo que busca la aparicion de un ticket proveniente de una báscula
				while (fuera){
					String[] listado = null;
					listado = recorrido();
					// Si no hay nuevos archivos voy a dormir mi thread por unos 20 segundos.
					if (listado.length==0){
						System.out.println("No hay archivos actualmente... así que voy a poner a dormir mi hilo");
						sleep(20000);
					}
					else{
						generoInterno = true;
					// Si encontre archivos, voy a sacarlos uno por uno para extraer la info y eliminarlo
						//Levanto el hilo encargado de guardarlo.
						for(int i = 0; i<listado.length; i++){
							System.out.println("Entre");
							final File temporal = new File(directorio+"\\"+listado[i]);
							tinterno = new Thread (new Runnable(){
								public void run() {
									try{
										System.out.println("Genere el thread interno y voy a borrar el archivo:" +temporal);
										temporal.delete();
										join();
									}
									catch (Exception e){
										e.printStackTrace();
									}
								}
							});
							// Arranco el Hilo Interno
							tinterno.start();
						}
					}
					if(generoInterno){
						while (tinterno.isAlive()){
							tescucha.sleep(5000);
						}
					}
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
	});
	}


	public void run()
		{
			tescucha.start();
	}



}
