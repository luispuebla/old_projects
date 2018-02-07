package com.ult.bd;

import java.util.Calendar;
import java.util.TimeZone;

/**
* La clase "TimeStamp" es la clase encargada de obtener la fecha actual de acuerdo al Sistema
* @author <a href="mailto:enriquefj@prodigy.net.mx"> Ing. Enrique Fernández J.</a>
* @author <a href="mailto:sofiagd@prodigy.net.mx"> Ing. Sofía Gabián D.</a>
* @version 1.2
*/
public class DateStamp{

	private Calendar tiempoSistema;

/**
* El constructor de la clase obtiene una instancia del tiempo actual registrado en el Sistema y lo transforma de acuerdo al horario GMT, posteriormente manda llamar al método obtenDatos y formar el formato de String de tiempo requerido.
*/
	public DateStamp(){
		tiempoSistema = Calendar.getInstance();
		TimeZone gmt;
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

	public String dia(){
		int dia = tiempoSistema.get(Calendar.DAY_OF_MONTH);
		String diacomp = new String (checkSize(dia));
		return diacomp;
	}

	public String mes(){
		int mes = tiempoSistema.get(Calendar.MONTH)+1;
		String mescomp = new String (checkSize(mes));
		return mescomp;
	}

	public String anio(){
		String anio = new String (tiempoSistema.get(Calendar.YEAR) +"");
		return anio;
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
		DateStamp ts = new DateStamp();
//		System.out.println("Fecha: " +ts.obtenDatos());
	}

}
