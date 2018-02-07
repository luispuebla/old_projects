import java.rmi.*;

/**
 * Interface:    RemoteModelMgr
 *
 * Purpose:      Provides Remote Access to either a remote
 *               or a returned local copy of the "ComputationalModel"
 *
 * Notes:        RemoteModel is an RMI "Remote" interface.
 *               LocalModel is a local interface
 */
interface BarServicio extends Remote {
   String DimeHola(String nombre)   throws java.rmi.RemoteException;
}