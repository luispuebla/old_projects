/**
*  Es el encargado de escuchar constantemente la comunicación establecida con el Escanner, e informar sobre los datos
*  recibidos para su implementación.
*/
	public class scannerReader implements SerialPortEventListener {
		public void serialEvent( SerialPortEvent _ev ) {
			switch( _ev.getEventType() ) {
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
// Cuando haya datos disponibles se leen e interpretan...
			case SerialPortEvent.DATA_AVAILABLE:
				byte[] bufferLectura = new byte[20];
				try {
					while(entrada.available() > 0 ) {
						int nBytes = entrada.read( bufferLectura );
						if(conteoBuffer == 0){
							System.out.println("Entre con conteoBuffer 0");
							conteoBuffer = 1;
							sb = sb.append((new String(bufferLectura).trim()));
						}
						else if(conteoBuffer == 1){
							System.out.println("Entre con conteoBuffer 1");
							conteoBuffer = 2;
							sb = sb.append((new String(bufferLectura).trim()));
							entradaParcial = true;
						}
						else{
							System.out.println("Me vole con el conteoBuffer");
							sb = new StringBuilder("");
							conteoBuffer = 0;
						}
					}
				}
				catch( IOException e ) {
					e.printStackTrace();
				}
				break;
			}
		}
	}
