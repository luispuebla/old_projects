import java.rmi.server.UnicastRemoteObject;
import  java.rmi.RemoteException;

public class BarServerImpl extends UnicastRemoteObject   implements BarServicio {

   /**
    * Constructor
   */
   public BarServerImpl()    throws RemoteException  {
      super();
   }

   public String DimeHola(String nombre)   throws RemoteException   {
	   System.out.println("Cliente solicitando informacíon");
		return "Hola "+nombre;
   }

}
