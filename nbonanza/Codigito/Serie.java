/*************************************************************
 * Serie.java
 *
 * Descripción: Ejemplo de información de puerto con
 *              tratamiento de eventos.
 *
 * Autor: Fco. Javier Rodriguez Navarro (c) Julio 2000
 *************************************************************/
import java.io.*;
import java.util.*;
import javax.comm.*;

public class Serie
{
    static CommPortIdentifier idPort;
    static SerialPort sPort;
    static OutputStream salida;
    static String datos = new String("Una linea que deseamos escribir ");
    static evSerie ev = new evSerie();

    public static void main(String[] args)
    {
       try
       {
          idPort = CommPortIdentifier.getPortIdentifier("COM1");
       } catch (NoSuchPortException e)
         {System.err.println("ERROR al identificar puerto");}

       try
       {
          sPort = (SerialPort) idPort.open("Observador1(COM1)", 30000);
          informa();
          try
          {
            salida = sPort.getOutputStream();
          } catch (IOException e) { }
          try
          {
             sPort.addEventListener(ev);
             sPort.notifyOnDataAvailable(true);
             sPort.notifyOnOutputEmpty(true);
             sPort.notifyOnCTS(true);
             sPort.notifyOnDSR(true);
             sPort.notifyOnRingIndicator(true);
             sPort.notifyOnCarrierDetect(true);
             sPort.notifyOnParityError(true);
             sPort.notifyOnOverrunError(true);
             sPort.notifyOnBreakInterrupt(true);
          } catch (TooManyListenersException e) { }
 } catch (PortInUseException e)
          { System.err.println("ERROR al abrir puerto");}

        try
        {

           while (true) {salida.write(datos.getBytes());}

        } catch (IOException e) { System.err.println("Error escritura"); }
    }

   // Metodo informa: Nos dara información del estado del puerto
   private static void informa()
   {
      System.out.println("Información del puerto: " + sPort.getName());
      System.out.println("Buffer entrada: " + sPort.getInputBufferSize());
      System.out.println("Buffer salida: " + sPort.getOutputBufferSize());
      System.out.println("Baudios: " + sPort.getBaudRate());
      System.out.print("Bits de datos: ");
      switch (sPort.getDataBits())
      {
         case SerialPort.DATABITS_5:
            System.out.println("cinco ");
            break;
         case SerialPort.DATABITS_6:
            System.out.println("seis ");
            break;
         case SerialPort.DATABITS_7:
            System.out.println("siete ");
            break;
         case SerialPort.DATABITS_8:
            System.out.println("ocho ");
            break;
      }

      System.out.print("Bits de parada: ");
      switch (sPort.getStopBits())
      {
         case SerialPort.STOPBITS_1:
            System.out.println("uno ");
            break;
         case SerialPort.STOPBITS_2:
            System.out.println("dos ");
            break;
         case SerialPort.STOPBITS_1_5:
            System.out.println("uno y medio ");
            break;
      }

      System.out.print("Paridad: ");
      switch (sPort.getParity())
      {
         case SerialPort.PARITY_NONE:
            System.out.println("ninguna ");
            break;
         case SerialPort.PARITY_ODD:
            System.out.println("impar ");
            break;
         case SerialPort.PARITY_EVEN:
            System.out.println("par ");
            break;
         case SerialPort.PARITY_MARK:
            System.out.println("por marca ");
            break;
         case SerialPort.PARITY_SPACE:
            System.out.println("por espacio ");
            break;
      }
      System.out.print("Control de flujo: ");
      switch (sPort.getFlowControlMode())
      {
         case SerialPort.FLOWCONTROL_NONE:
            System.out.println("ninguno ");
            break;
         case SerialPort.FLOWCONTROL_RTSCTS_IN:
         case SerialPort.FLOWCONTROL_RTSCTS_OUT:
            System.out.println("hardware ");
            break;
         case SerialPort.FLOWCONTROL_XONXOFF_IN:
         case SerialPort.FLOWCONTROL_XONXOFF_OUT:
            System.out.println("software ");
      }
   }
}

class evSerie implements SerialPortEventListener
{

   public void serialEvent(SerialPortEvent evento)
   {
      switch (evento.getEventType())
      {
         case SerialPortEvent.DATA_AVAILABLE:
            System.out.println("Datos disponibles");
            break;
         case SerialPortEvent.OUTPUT_BUFFER_EMPTY:
            System.out.println("Buffer vacio");
            break;
         case SerialPortEvent.CTS:
            System.out.print("CTS pasa a ");
            if (evento.getNewValue()) System.out.println("cierto");
            else System.out.println("falso");
            break;
         case SerialPortEvent.DSR:
            System.out.print("DSR pasa a ");
            if (evento.getNewValue()) System.out.println("cierto");
            else System.out.println("falso");
            break;
         case SerialPortEvent.RI:
            System.out.print("RI pasa a ");
            if (evento.getNewValue()) System.out.println("cierto");
            else System.out.println("falso");
            break;
         case SerialPortEvent.CD:
            System.out.print("CD pasa a ");
            if (evento.getNewValue()) System.out.println("cierto");
            else System.out.println("falso");
            break;
      }
   }
}
