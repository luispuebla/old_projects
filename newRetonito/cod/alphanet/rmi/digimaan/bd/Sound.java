package alphanet.rmi.digimaan.bd;

import java.io.File;
import java.applet.AudioClip;
import java.applet.Applet;
import java.net.URL;
/**
* La clase "Sound" se encargará de ejecutar el o los sonidos necesarios por el Sistema al momento que sea(n) requerido(s).
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 1.0
*/
public class Sound {
	/**
	* El Campo AudioClip es el encargado de almacenar temporalmente el sonido en formato .wav que deberá escucharse al momento en que se mande llamar al método ciclaSonido, tocaSonido o detenerse con el método detenerSonido.
	*/
	public AudioClip _clip;
	public URL url = getClass().getResource("/sounds/click.wav");


	/**
	* El constructor de esta clase recibe como parámero un String que contiene el nombre del archivo que hace referencia al sonido a ser emitido por el Sistema.
	*@param nombre String con el nombre del Archivo del Sonido.
	*/
	public Sound (String nombre) throws Exception{
		File file = new File(nombre);
		_clip = Applet.newAudioClip((file.toURI( )).toURL( ));
	}

	public Sound () throws Exception{
		_clip = Applet.newAudioClip(url);
	}


	/**
	* El método ciclaSonido manda ejecutar el sonido de manera ciclica, es decir entra en un loop de ejecución infinita hasta que se le indique que se detenga.
	*/
	public void ciclaSonido( ) throws Exception {
		_clip.loop( );
	}

	/**
	* El método detenerSonido se encarga de enviar la señal de paro de ejecución a un sonido que se encuentre ciclando.
	*/
	public void detenerSonido( ) throws Exception {
		_clip.stop( );
	}

	/**
	* El método tocaSonido manda ejecutar el sonido una sola ocasión, por lo que no necesita del metodo detenerSonido, al menos que se deseé interrumpir explicitamente su reproducción.
	*/
	public void tocaSonido() throws Exception{
		_clip.play();
	}
}