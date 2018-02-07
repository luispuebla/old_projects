//  java_902.java

//  Copyright (c) 1999, Agustin Froufe

//  Todos los derechos reservados.

//

//  No se asume ninguna  responsabilidad por el  uso o  alteracion  de este

//  software.  Este software se proporciona COMO ES, sin garantia de ningun

//  tipo de su funcionamiento y en ningun caso sera el autor responsable de

//  daños o perjuicios que se deriven del mal uso del software,  aun cuando

//  este haya sido notificado de la posibilidad de dicho daño.

//

//   Compilador: javac 1.2

//        Autor: Agustin Froufe

//     Creacion: 17-Feb-1999  06:09:33

//

//--------------------------------------------------------------------------

//  Esta informacion no es necesariamente definitiva y esta sujeta a cambios

//  que pueden ser incorporados en cualquier momento, sin avisar.

//--------------------------------------------------------------------------


/**

* Este es un ejemplo de uso del API de Comunicaciones Java que permite la

* lectura de información a través de uno de los puertos serie de la

* máquina en que se ejecuta.

* El ejemplo se ha probado en Windows y Solaris, utilizando la línea

* de código que identifica el puerto a utilizar correspondiente

*/

import java.io.*;

import java.util.*;

import javax.comm.*;


public class java_902 implements Runnable,SerialPortEventListener {

  static CommPortIdentifier idPuerto;

  static Enumeration listaPuertos;

  InputStream entrada;

  SerialPort puertoSerie;

  Thread tLectura;


  // En este ejemplo implementa un thread que es el que se encarga de

  // que la aplicación se quede esperando en el puerto que se haya

  // abierto a que se reciban datos.

  // Primero abre el puerto y luego le fija los parámetros

  public java_902() {

    // Si el puerto no está en uso, se intenta abrir

    try {

      puertoSerie = (SerialPort)idPuerto.open( "AplLectura",2000 );

    } catch( PortInUseException e ) {}

    // Se obtiene un canal de entrada

    try {

      entrada = puertoSerie.getInputStream();

    } catch( IOException e ) {}



    // Añadimos un receptor de eventos para estar informados de lo

    // que suceda en el puerto

    try {

      puertoSerie.addEventListener( this );

        } catch( TooManyListenersException e ) {}



    // Hacemos que se nos notifique cuando haya datos disponibles

    // para lectura en el buffer de la puerta

    puertoSerie.notifyOnDataAvailable( true );



    // Se fijan los parámetros de comunicación del puerto

    try {

      puertoSerie.setSerialPortParams( 9600,

        SerialPort.DATABITS_8,

        SerialPort.STOPBITS_1,

        SerialPort.PARITY_NONE );

    } catch( UnsupportedCommOperationException e ) {}



    // Se crea y lanza el thread que se va a encargar de quedarse

    // esperando en la puerta a que haya datos disponibles

    tLectura = new Thread( this );

    tLectura.start();

    }



  public void run() {

    try {

      // En los threads, hay que procurar siempre que haya algún

      // método de escape, para que no se queden continuamente

      // bloqueados, en este caso, la comprobación de si hay datos

      // o no disponibles en el buffer de la puerta, se hace

      // intermitentemente

      Thread.sleep( 20000 );

    } catch( InterruptedException e ) {}

    }




  public void serialEvent( SerialPortEvent _ev ) {
	  		System.out.println("arranque demonio del puerto");


    switch( _ev.getEventType() ) {

      // La mayoría de los eventos no se trata, éstos son los

      // que se producen por cambios en las líneas de control del

      // puerto que se está monitorizando

      case SerialPortEvent.BI:

      case SerialPortEvent.OE:

      case SerialPortEvent.FE:

      case SerialPortEvent.PE:

      case SerialPortEvent.CD:

      case SerialPortEvent.CTS:

      case SerialPortEvent.DSR:

      case SerialPortEvent.RI:

      case SerialPortEvent.OUTPUT_BUFFER_EMPTY:

        break;

      // Cuando haya datos disponibles se leen y luego se

      // imprime lo recibido en la consola

      case SerialPortEvent.DATA_AVAILABLE:

        byte[] bufferLectura = new byte[20];

        try {

          while( entrada.available() > 0 ) {

            int nBytes = entrada.read( bufferLectura );

            }

          System.out.print( new String(bufferLectura) );

        } catch( IOException e ) {}

        break;

      }

    }





  public static void main( String[] args ) {

    // Lista de los puertos disponibles en la máquina. Se carga en el

    // mimo momento en que se inicia la JVM de Java

    listaPuertos = CommPortIdentifier.getPortIdentifiers();


    while( listaPuertos.hasMoreElements() ) {

      idPuerto = (CommPortIdentifier)listaPuertos.nextElement();

      if( idPuerto.getPortType() == CommPortIdentifier.PORT_SERIAL ) {

//        if( idPuerto.getName().equals("/dev/term/a") ) {  // UNIX

        if( idPuerto.getName().equals("COM1") ) {           // WINDOWS

          // Lector del puerto, se quedará esperando a que llegue algo

          // al puerto

          java_902 lector = new java_902();

          }

        }

      }

    }

  }


//------------------------------------------ Final del fichero java_902.java



