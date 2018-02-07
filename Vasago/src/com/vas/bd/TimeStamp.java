package com.vas.bd;

import java.util.Calendar;
import java.util.TimeZone;

/**
* La clase "TimeStamp" es la clase encargada de obtener el tiempo y fecha actual de acuerdo al horario GMT
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía ´Gabián D.</a>
* @version 3.0 Mayo 2006
*/
public class TimeStamp{

	// Ajuste al TimeStamp...
	private Calendar tiempoSistema;
	/**
	* El String que representa la fecha y tiempo actual de acuerdo al horario GMT
	*/
	public String time;
	public String date;
	public String datetime;
	/**
	* El int que representa el día del mes en que nos encontramos de acuerdo al horario GMT
	*/
	public int  toDay;

/**
* El constructor de la clase obtiene una instancia del tiempo actual registrado en el Sistema y lo transforma de acuerdo al horario GMT, posteriormente manda llamar al método obtenDatos y formar el formato de String de tiempo requerido.
*/
	public TimeStamp(){
		tiempoSistema = Calendar.getInstance();
		obtenDatos();
	}

/**
* El método obtenDatos se encarga de almacenar en un String el formato de fecha y tiempo de acuerdo con el horario GMT de la siguiente manera: yyyymmddhhmmss, en los casos donde es posible que se regrese un solo dígito (por ejemplo día: 2) se manda checar y en caso de que esto ocurra se agrega un 0 para poder cumplir con el formato.
*/
	private void obtenDatos(){
		StringBuffer cadena = new StringBuffer();
		StringBuffer cadena2 = new StringBuffer();
		StringBuffer cadena3 = new StringBuffer();
		String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
		int mes = tiempoSistema.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mes));
		int dia = tiempoSistema.get(Calendar.DAY_OF_MONTH);
		toDay = dia;
		String diacomp = new String (checkSize(dia));
		int hora = tiempoSistema.get(Calendar.HOUR_OF_DAY);
		String horacomp = new String (checkSize(hora));
		int minutos = tiempoSistema.get(Calendar.MINUTE);
		String minutoscomp = new String (checkSize(minutos));
		int segundos = tiempoSistema.get(Calendar.SECOND);
		String segundoscomp = new String (checkSize(segundos));
		cadena.append(anio+"-"+mescomp+"-"+diacomp);
		cadena2.append(horacomp+":"+minutoscomp+":"+segundoscomp);
		cadena3.append(cadena+" "+cadena2);
		time = new String(cadena2);
		date = new String(cadena);
		datetime = new String(cadena3);
		//System.out.println("TimeStamp: " +time);
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

}
