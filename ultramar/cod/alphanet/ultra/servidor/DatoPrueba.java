// Copyright MageLang Institute; Version $Id: //depot/main/src/edu/modules/RMI-mml2/magercises/RMICallback/Solution/TimeServer.java#2 $
import java.rmi.*;


// Create the interface TimeServer.
// It contains one method registerTimeMonitor.
// This method accepts a parameter of type TimeMonitor
// and returns void.

public interface DatoPrueba extends java.rmi.Remote
{
   public void registerPrueba2(Prueba2 dp) throws RemoteException;

}