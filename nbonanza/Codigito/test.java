/*********************************************************************
 * P1.java
 *
 * Descripción: Este programa nos permite analizar la disponibilidad de
 *              todos los puertos soportados en nuestra maquina. Tambien
 *              nos informara del tipo del puerto así como el propietario
 *              de este en caso de que se encuentre ocupado.
 *
 * Autor: Fco. Javier Rodriguez Navarro (c) Junio 2000
 **********************************************************************/
import java.io.*;
import java.util.*;
import javax.comm.*;
public class test {
    static Enumeration listaPort;
    static CommPortIdentifier idPort;

    public static void main(String[] args)
    {
        listaPort = CommPortIdentifier.getPortIdentifiers();
        ListaPuertos();
    }

    private static void ListaPuertos()
    {

        System.out.println("Los puertos disponibles son:");
        while (listaPort.hasMoreElements())
        {
            idPort = (CommPortIdentifier) listaPort.nextElement();
            System.out.print("PUERTO: " + idPort.getName() + " ");

            if (idPort.getPortType() == CommPortIdentifier.PORT_SERIAL)
            {
               System.out.println("RS-232 (" + idPort.getPortType() + ")");
            } else if (idPort.getPortType() == CommPortIdentifier.PORT_PARALLEL)
              {
                 System.out.println("IEEE 1284 (" + idPort.getPortType() + ")");
              } else System.out.println("Tipo de puerto desconocido");

            // Describimos si esta disponible.
            if (idPort.isCurrentlyOwned())
               System.out.println("OCUPADO por: " +
                                   idPort.getCurrentOwner());
            else
               System.out.println("DISPONIBLE");

            System.out.println("---------------------------------------------");
        }

     }
}

