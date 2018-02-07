import java.io.*;
import java.util.*;
import javax.comm.*;
import java.sql.*;

public class KikoTestBKUP implements Runnable, SerialPortEventListener {
    protected  CommPortIdentifier idPuerto;
    protected SerialPort puertoSerial;
    protected  InputStream entrada;
	protected Thread tLectura;
	protected boolean paroCom = false;
	protected	boolean paroInterno = false;
	protected	int conteoBuffer = 0;
	protected boolean entradaParcial = false;
	protected	StringBuilder sb = new StringBuilder();
	protected ConexionBD con ;


	public KikoTestBKUP ()   {
		// Verifico que este el puerto
		try  {
			idPuerto = CommPortIdentifier.getPortIdentifier("COM1");
		}
		catch (NoSuchPortException e){
				e.printStackTrace();
				System.err.println("ERROR al identificar puerto");
		}
		// Abro el puerto
		try {
			puertoSerial = (SerialPort) idPuerto.open("Escanner", 30000);
			// Solicito informacion sobre el puerto
			informa();
			// Abro canal de entrada constante con el puerto
			entrada = puertoSerial.getInputStream();
			// Creo un receptor de eventos captados por mi escanner.
				try {
				   puertoSerial.addEventListener( this );
				}
				catch (TooManyListenersException e) {
					e.printStackTrace();
				}
			}
			catch (IOException ioe){
				ioe.printStackTrace();
			}
			catch (PortInUseException e) {
				e.printStackTrace();
				System.err.println("ERROR al abrir puerto");
			}
			// Cuando lleguen datos informame
			puertoSerial.notifyOnDataAvailable( true );
             puertoSerial.notifyOnDataAvailable(true);
             puertoSerial.notifyOnOutputEmpty(true);
             puertoSerial.notifyOnCTS(true);
             puertoSerial.notifyOnDSR(true);
             puertoSerial.notifyOnRingIndicator(true);
             puertoSerial.notifyOnCarrierDetect(true);
             puertoSerial.notifyOnParityError(true);
             puertoSerial.notifyOnOverrunError(true);
             puertoSerial.notifyOnBreakInterrupt(true);
			// Arrancamos el thread
			vigia();
			System.out.println("Ya arranque el thread");
	    }


/**
* El método vigia poseé las instrucciones de arranque para el thread que se encuentra monitoreando la llegada de datos provenientes del Escanner
*/
	public void vigia(){
		System.out.println("Entre al metodo vigia");
		tLectura = new Thread (new Runnable(){
			public void run(){
				System.out.println("Entre al run interno");
				try{
					while (true){
						System.out.println("Corriendo...");
						if(paroCom){
							System.out.println("hola");
							System.out.println("Durmiendo el Thread");
							tLectura.sleep(3000);
						}
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		});
	}


/**
* El Método almacenaCompra se encarga de realizar la insercion final dentro de la tabla compra.
*
* @return boolean true --> todo bien o false --> Error.
*/

	public String dameClaveCorrespondiente(String codBarras) throws SQLException, Exception {
		con = new ConexionBD();
		String claveDeProducto = "";
		try{
			ResultSet rs = null;
			String query = "SELECT PLU FROM productos WHERE codBarras = '"+codBarras +"' AND activo = 1";
			Statement stmt =  con.miConnection.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()){
				claveDeProducto = rs.getString("PLU");
			}
		}
		catch (SQLException sqle){
			System.out.println("Error de SQL en KikoTest, dameClaveCorrespondiente ");
			sqle.printStackTrace();
		}
		catch (Exception e){
			System.out.println("Ocurrio un Error en KikoTest, dameClaveCorrespondiente ");
			e.printStackTrace();
		}
		finally{
			if(con != null){
				try{
				con.cierraConexion();				}
				catch (Exception q){
					System.out.println("Error al momento de cerrar conexion en KikoTest, dameClaveCorrespondiente ");
					q.printStackTrace();
				}
			}
		}
		return claveDeProducto;
	}


	public void run(){
		try{
			tLectura.start();
		}
		catch(Exception q){
			q.printStackTrace();
		}
	}




	public void serialEvent( SerialPortEvent _ev ) {
		switch( _ev.getEventType() ) {
		case SerialPortEvent.BI:
			System.out.println ("Break Interrupt");
			break;
		case SerialPortEvent.OE:
			System.out.println ("Over Run");
			break;
		case SerialPortEvent.FE:
			System.out.println ("Framing Error");
			break;
		case SerialPortEvent.PE:
			System.out.println ("Parity Error");
			break;
		case SerialPortEvent.CD:
			System.out.println ("Carrier Detect");
			break;
		case SerialPortEvent.CTS:
			System.out.println ("Clear to send");
			break;
		case SerialPortEvent.DSR:
			System.out.println ("Data Set Ready");
			break;
		case SerialPortEvent.RI:
			System.out.println ("Ring indicator");
			break;
		case SerialPortEvent.OUTPUT_BUFFER_EMPTY:
			System.out.println ("Bufer vacio");
			break;
// Cuando haya datos disponibles se leen y luego se
		case SerialPortEvent.DATA_AVAILABLE:
			byte[] bufferLectura = new byte[20];
			try {
				while(entrada.available() > 0 ) {
					int nBytes = entrada.read( bufferLectura );
					if(conteoBuffer == 0){
						conteoBuffer = 1;
					}
					else{
						entradaParcial = true;
					}
				}
				sb = sb.append((new String(bufferLectura).trim()));
				if(entradaParcial){
					String claveDeProducto = "";
					System.out.print(sb.toString());
					entradaParcial = false;
					conteoBuffer = 0;
					try{
						claveDeProducto = dameClaveCorrespondiente(sb.toString());
					}
					catch (Exception q){
						q.printStackTrace();
					}
					if(claveDeProducto.equalsIgnoreCase("")){
						System.out.print("\nNo correspondio a ningún producto");
					}
					else{
						System.out.println("El PLU correspondiente es:" +claveDeProducto);
						paroCom = true;
						for (int i=0; i<= 10000; i++){
							System.out.print("*");
						}
						paroCom = false;
					}
					sb = new StringBuilder("");

				}
			}
			catch( IOException e ) {
				e.printStackTrace();
			}
			break;

		}
	}


   // Metodo informa: Nos dara información del estado del puerto
	private  void informa()  {
		System.out.println("Información del puerto: " + puertoSerial.getName());
		System.out.println("Buffer entrada: " + puertoSerial.getInputBufferSize());
		System.out.println("Buffer salida: " + puertoSerial.getOutputBufferSize());
		System.out.println("Baudios: " + puertoSerial.getBaudRate());
		System.out.print("Bits de datos: ");
		switch (puertoSerial.getDataBits()) {
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
		switch (puertoSerial.getStopBits()) {
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
		switch (puertoSerial.getParity()) {
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
		switch (puertoSerial.getFlowControlMode()) {
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




	public static void main( String[] args ) {
		KikoTest kt = new KikoTest();
	}
}