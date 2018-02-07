/**
*  Implementa el Hilo que se encarga de monitorear la comunicación con el escanner.
*/
	public void vigia(){
		tLectura = new Thread (new Runnable(){
			public void run(){
				System.out.println("Entre a la ejecución del hilo");
				try{
// Verifico existencia del puerto....
					try  {
						idPuerto = CommPortIdentifier.getPortIdentifier("COM1");
					}
					catch (NoSuchPortException e){
						semaforoEscanner = 2;
						exitoComunicacion = false;
						e.printStackTrace();
					}
					if(exitoComunicacion){
// Abro el puerto y pido un Stream constante
						try {
							puertoSerial = (SerialPort) idPuerto.open("Escanner", 30000);
							entrada = puertoSerial.getInputStream();
							// Puedo solicitar los datos del puerto abierto.
							//informa();
						}
						catch (IOException ioe){
							semaforoEscanner = 2;
							exitoComunicacion = false;
							ioe.printStackTrace();
						}
						catch (PortInUseException e) {
							semaforoEscanner = 2;
							exitoComunicacion = false;
							e.printStackTrace();
						}
					}
// Si todo bien mantengo comunicacion con el escanner
					if(exitoComunicacion) {
						try {
							puertoSerial.notifyOnDataAvailable( true );
						}
						catch (Exception e) {
							semaforoEscanner = 2;
							e.printStackTrace();
						}
					}
// Checo de nuevo que todo vaya bien.., si es el caso pido me informen de lo obtenido.
					if(exitoComunicacion){
						semaforoEscanner = 1;
						try {
							System.out.println("Reiniciando???");
						   puertoSerial.addEventListener( new scannerReader() );
						}
						catch (TooManyListenersException e) {
							semaforoEscanner = 2;
							e.printStackTrace();
						}
						while (true){
							if (sb.length()== 0){
								System.out.print("\nNo hay archivos actualmente... así que voy a poner a dormir mi hilo por 1 segundo...");
								tLectura.sleep(1000);
							}
							if(sb.length() > 0 && entradaParcial){
								try{
									puertoSerial.removeEventListener();
								}
								catch (Exception on){
									on.printStackTrace();
								}
								System.out.print(sb.toString());
								try{
									mpv.setCodBarras(sb.toString());
									claveDeProducto =  mpv.dameClaveCorrespondiente();
								}
								catch (Exception q){
									q.printStackTrace();
								}
								try{
									tInterno = new Thread (new Runnable(){
										public void run() {
											try{
												sb = new StringBuilder("");
												mandaProducto(claveDeProducto);
												tInterno.join();
											}
											catch(Exception e){
												e.printStackTrace();
											}
										}
									});
									tInterno.start();
								}
								catch (Exception o){
									o.printStackTrace();
								}
								conteoBuffer = 0;
								sb = new StringBuilder("");
								entradaParcial = false;
							}
							while (paroCom){
								System.out.println("Durmiendo hilo por ejecucion 2 segundos");
								tLectura.sleep(2000);
								if (!existencia || !cantidadPositiva && paroCom){
									if(desktop.getComponentCount() ==18){
										System.out.println("ResetInterno...");
										//puertoSerial.addEventListener( new scannerReader() );
										entrada.reset();
										resetHilos();
									}
								}
							}
						}
					}
				}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		});
	}