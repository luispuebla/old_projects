package alphanet.ultra.digibar.servidor;

import java.awt.Font;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RMISecurityManager;
import java.rmi.RemoteException;
import java.rmi.UnknownHostException;
import java.rmi.registry.LocateRegistry;
import java.util.Properties;

import javax.swing.ImageIcon;
import javax.swing.JDesktopPane;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class BarServer
  extends JFrame
{
  private static final long serialVersionUID = 1L;
  protected static Properties config;
  private int PORT = 0;
  private String HOST_NAME = "";
  protected static BarServer barServer;
  protected boolean cargaConfiguracion = true;
  protected JDesktopPane desktop;
  private Font letra;
  private URL url;
  public JTextField jtCantidad;
  public String mensaje = "Error al Levanta el Servicio";
  
  public void despliegaInterfaz()
    throws Exception
  {
    System.out.println("Entre a despliegaInterfaz");
    setBounds(0, 0, 860, 690);
    setResizable(false);
    this.letra = new Font("Eras Demin ITC", 1, 20);
    this.url = getClass().getResource("/imas/fondoServidor.jpg");
    
    ImageIcon localImageIcon = new ImageIcon(this.url);
    this.desktop = new JDesktopPane();
    this.jtCantidad = new JTextField(this.mensaje);
    this.jtCantidad.setHorizontalAlignment(0);
    this.jtCantidad.setFont(this.letra);
    
    this.jtCantidad.setBounds(220, 300, 400, 40);
    setContentPane(this.desktop);
    setLocationRelativeTo(null);
    this.desktop.setDragMode(1);
    loadBackgroundImage(localImageIcon);
    if (this.cargaConfiguracion) {
      this.desktop.add(this.jtCantidad, 1);
    }
  }
  
  protected void loadBackgroundImage(ImageIcon paramImageIcon)
  {
    JLabel localJLabel = new JLabel(paramImageIcon);
    localJLabel.setBounds(0, 0, paramImageIcon.getIconWidth(), paramImageIcon.getIconHeight());
    
    this.desktop.add(localJLabel, new Integer(Integer.MIN_VALUE));
  }
  
  public BarServer()
    throws RemoteException, MalformedURLException, NotBoundException
  {
    super("Sistema Administrativo DIGIBAR -- Servidor");
    try
    {
      String str1 = "Server.conf";
      config = new Properties();
      config.load(new FileInputStream(str1));
      this.HOST_NAME = config.getProperty("server.host");
      this.PORT = Integer.parseInt(config.getProperty("server.port").trim());
    }
    catch (IOException localIOException)
    {
      this.cargaConfiguracion = false;
      System.out.println("Error de lectura al tratar de abrir archivo de configuracion");
      localIOException.printStackTrace();
    }
    catch (IllegalArgumentException localIllegalArgumentException)
    {
      this.cargaConfiguracion = false;
      System.out.println("Error de lectura malformacion de archivo de configuracion");
      localIllegalArgumentException.printStackTrace();
    }
    if (this.cargaConfiguracion)
    {
      LocateRegistry.createRegistry(this.PORT);
      System.out.println("Registro Creado");
      BarServerImpl localBarServerImpl = new BarServerImpl();
      String str2 = "//" + this.HOST_NAME + ":" + Integer.toString(this.PORT) + "/" + "BarServicios";
      Naming.rebind(str2, localBarServerImpl);
      this.mensaje = "Exito al inicializar Servicio";
    }
  }
  
  public static void main(String[] paramArrayOfString)
  {
    try
    {
      System.setSecurityManager(new RMISecurityManager());
      barServer = new BarServer();
      try
      {
        barServer.despliegaInterfaz();
        barServer.setDefaultCloseOperation(3);
        
        barServer.setVisible(true);
      }
      catch (Exception localException1)
      {
        localException1.printStackTrace();
      }
      if (!barServer.cargaConfiguracion) {
        return;
      }
    }
    catch (UnknownHostException localUnknownHostException)
    {
      System.out.println("No concuerda el nombre del Host(" + barServer.HOST_NAME + ")");
      localUnknownHostException.printStackTrace();
    }
    catch (RemoteException localRemoteException)
    {
      System.out.println("Error al iniciar el servicio");
      localRemoteException.printStackTrace();
    }
    catch (MalformedURLException localMalformedURLException)
    {
      System.out.println("Error Interno" + localMalformedURLException);
      localMalformedURLException.printStackTrace();
    }
    catch (NotBoundException localNotBoundException)
    {
      System.out.println("Not Bound" + localNotBoundException);
      localNotBoundException.printStackTrace();
    }
    catch (Exception localException6)
    {
      System.out.println("Excepcion" + localException6);
      localException6.printStackTrace();
    }
    finally
    {
      try
      {
        barServer.despliegaInterfaz();
        barServer.setDefaultCloseOperation(3);
        
        barServer.setVisible(true);
      }
      catch (Exception localException8)
      {
        localException8.printStackTrace();
      }
    }
    System.out.println("Esperando conexion de Cliente.....");
  }
}
