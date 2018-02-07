/********************************************************************* 
 * Escritor.java 
 * 
 * Descripción: Este programa escribe una frase por el puerto 
 *              que le pasemos como parametro. 
 * 
 * Autor: Fco. Javier Rodriguez Navarro (c) Junio 2000 
 **********************************************************************/ 
import java.io.*; 
import java.util.*; 
import javax.comm.*; 

public class Escritor 
{ 
    static CommPortIdentifier idPort; 
    static SerialPort sPort; 
    static ParallelPort pPort; 
    static OutputStream salida; 
    static String datos = new String("HOLA! esto es una prueba"); 
    static evProp ev = new evProp(); 

    public static void main(String[] args) 
    { 

       // Lo primero que hacemos es abrir el puerto 
       try 
       { 
          idPort = CommPortIdentifier.getPortIdentifier(args[0]); 
          idPort.addPortOwnershipListener(ev); 
       } catch (NoSuchPortException e) 
         {System.err.println("ERROR al identificar puerto");} 

       // Abre el puerto necesario. 
       try 
       { 
          if (idPort.getPortType() == CommPortIdentifier.PORT_SERIAL) 
          { 
     sPort = (SerialPort) idPort.open("Escritor en serie", 30000); 
            try 
            { 
               salida = sPort.getOutputStream(); 
            } catch (IOException e) {} 
          } 
          else 
          { 
     pPort = (ParallelPort) idPort.open("Escritor en paralelo", 30000); 
            try 
            { 
               salida = pPort.getOutputStream(); 
            } catch (IOException e) { } 
          } 
 } catch (PortInUseException e) 
          { System.err.println("ERROR al abrir puerto");} 

        try 
        { 
           salida.write(datos.getBytes()); 
        } catch (IOException e) { System.err.println("Error escritura"); } 

    } 

} 

class evProp implements CommPortOwnershipListener 
{ 

   public void ownershipChange(int tipo) 
   { 
      System.out.print("Valor: " + tipo); 
      if (tipo == CommPortOwnershipListener.PORT_OWNED) 
         System.out.println(" Se abre el puerto"); 
      else if (tipo == CommPortOwnershipListener.PORT_UNOWNED) 
         System.out.println(" Se cierra el puerto"); 
      else if (tipo == CommPortOwnershipListener.PORT_OWNERSHIP_REQUESTED) 
         System.out.println(" Requerido puerto usado"); 
   } 
}

