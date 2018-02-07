package alphanet.rmi.digimaan.bd;

import java.util.Calendar;
import java.util.TimeZone;

/**
* La clase "CalculaDate" es la clase encargada de obtener la fecha actual de acuerdo al Sistema
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @version 2.0
*/
public class CalculaDate{

	private Calendar tiempoSistema;
	private int anioInicial;
	private int mesInicial;
	private int diaInicial;


/**
* El constructor de la clase obtiene una instancia del tiempo actual registrado en el Sistema y lo transforma de acuerdo al horario GMT, posteriormente manda llamar al método obtenDatos y formar el formato de String de tiempo requerido.
*/
	public CalculaDate(){
	}

	public void parseaADate(String fechaInicial){
		tiempoSistema = Calendar.getInstance();
		String anio = fechaInicial.substring(0,fechaInicial.indexOf("-"));
		String mes = fechaInicial.substring((fechaInicial.indexOf("-")+1), fechaInicial.lastIndexOf("-"));
		String dia = fechaInicial.substring((fechaInicial.lastIndexOf("-")+1), fechaInicial.length());
		try {
			anioInicial = Integer.parseInt(anio);
			mesInicial = Integer.parseInt(mes);
			diaInicial = Integer.parseInt(dia);
		}
		catch (NumberFormatException nfe){
			nfe.printStackTrace();
		}
		tiempoSistema.set(anioInicial, mesInicial-1, diaInicial);
		//System.out.println("Entrega: "+obtenDatos());
	}


/**
* El método obtenDatos se encarga de almacenar en un String el formato de fecha y tiempo de acuerdo con el horario GMT de la siguiente manera: yyyymmddhhmmss, en los casos donde es posible que se regrese un solo dígito (por ejemplo día: 2) se manda checar y en caso de que esto ocurra se agrega un 0 para poder cumplir con el formato.
*/
	public String obtenDatos(){
		String time;
		StringBuffer cadena = new StringBuffer();
		String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
		int mes = tiempoSistema.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mes));
		int dia = tiempoSistema.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(dia));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		return (time = new String(cadena));
	}



// LE MANDO LOS DIAS QUE POSEE PARA PAGAR AL PROVEEDOR.
	public void setNuevaFecha(int sumaDias){
		tiempoSistema.add(Calendar.DATE, sumaDias);
		int diaSemana = tiempoSistema.get(Calendar.DAY_OF_WEEK);
		if(diaSemana == 1){
			tiempoSistema.add(Calendar.DATE, 1);
		}
		//System.out.println("Sumo: "+sumaDias);
		//System.out.println("Añadido: "+obtenDatos());
	}

/**
* Revisa que el tamaño del dato sea mayor a un solo dígito para cumplir con el formato, en caso de no ser así se le agrega un 0 al inicio, los casos en que se verifica son: mes, día,  hora, minuto, segundo.
* @return String que representa el valor recibido probablemente en caso de que haya sido necesario ya modificado.
*/
	private String checkSize (int revisa){
		StringBuffer verificador = new StringBuffer(revisa+"");
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}

	public static void main (String[] args){
		CalculaDate cd = new CalculaDate();
		cd.parseaADate("2004-8-1");
//		System.out.println("Fecha: " +ts.obtenDatos());
	}

}
