package alphanet.ultra.digibar.bd;

import java.applet.Applet;
import java.applet.AudioClip;
import java.io.File;
import java.net.URI;
import java.net.URL;

public class Sound
{
  public AudioClip _clip;
  public URL url = getClass().getResource("/sounds/click.wav");
  public URI uri = new URI(this.url.toString());
  
  public Sound(String paramString)
    throws Exception
  {
    File localFile = new File(paramString);
    this._clip = Applet.newAudioClip(localFile.toURI().toURL());
  }
  
  public Sound()
    throws Exception
  {
    this._clip = Applet.newAudioClip(this.url);
  }
  
  public void ciclaSonido()
    throws Exception
  {
    this._clip.loop();
  }
  
  public void detenerSonido()
    throws Exception
  {
    this._clip.stop();
  }
  
  public void tocaSonido()
    throws Exception
  {
    this._clip.play();
  }
}
