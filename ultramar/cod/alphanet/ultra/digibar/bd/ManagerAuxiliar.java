package alphanet.ultra.digibar.bd;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.NumberFormat;
import java.sql.Date;
import java.util.Vector;
import java.net.URLDecoder;
import javax.swing.JComboBox;


public class ManagerAuxiliar {

	protected Vector <String> datosMapa;

// GENERICAS:


	public Vector<String> comprimeVector(Vector <String> vOriginal) throws Exception{
		Vector <String> comprimido = new Vector <String>();
		int cantidadElemento = 0;
		if(vOriginal.size() == 1){
			comprimido.addElement("1 - " +vOriginal.elementAt(0).trim());
		}
		else{
			for(int j = 0; j < vOriginal.size(); j++){
				String elementoAnalizado = vOriginal.elementAt(j);
				for(int k = 0; k < vOriginal.size(); k++){
					if(elementoAnalizado.equalsIgnoreCase(vOriginal.elementAt(k))){
						cantidadElemento ++;
					}
				}
				comprimido.addElement(cantidadElemento+" - "+elementoAnalizado);
				Vector <String> tempFix = new Vector <String>();
				boolean primerPaso = true;
				for (int m = 0; m < vOriginal.size(); m++){
					if(vOriginal.elementAt(m).equalsIgnoreCase(elementoAnalizado)){
						if(primerPaso){
							primerPaso = false;
							tempFix.addElement(vOriginal.elementAt(m));
						}
					}
					else{
						tempFix.addElement(vOriginal.elementAt(m));
					}
				}
				vOriginal = tempFix;
				cantidadElemento = 0;
			}
		}
		return comprimido;
	}

	public static void main (String args[]) throws Exception{
		Vector <String> temporal = new Vector <String>();
		temporal.addElement("hola");
		temporal.addElement("hola");
		temporal.addElement("hola");
		temporal.addElement("hola");
		temporal.addElement("adios");
		temporal.addElement("hola");
		temporal.addElement("adios");
		temporal.addElement("hola");
		temporal.addElement("hola");
		temporal.addElement("que hubo");
		temporal.addElement("cuando");
		ManagerAuxiliar ma = new ManagerAuxiliar();
		Vector <String> comprimido = ma.comprimeVector(temporal);
		for (int i = 0; i< comprimido.size(); i++){
			System.out.println(comprimido.elementAt(i));
		}
	}


	public String completaString(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 6 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}

	public String completaStringTicket(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 7 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}

	public String completaStringTipoPLU(String aCompletar) throws Exception{
		int valor;
		String finalplu = aCompletar;
		try{
			valor = aCompletar.length();
			valor = 2 - valor;
			for(int i=0; i<valor; i++)
			{
				finalplu = "0"+finalplu;
			}
		}
		catch(Exception e){
			e.printStackTrace();		}

		return finalplu;
	}



	public int cambiaAInt(String variable) throws Exception{
		int valor;
		try{
			valor = (Integer.parseInt(variable));
		}
		catch(NumberFormatException nfe){
			valor = 0;
		}
			return valor;
	}


	public String remueveComas(String formato){
		StringBuffer sb = new StringBuffer (formato);
		while (sb.indexOf(",") != -1){
			sb.deleteCharAt(sb.indexOf(","));
		}
		return formato = new String(sb.toString());
	}


	public double cambiaADouble(String variable) throws Exception{
		double valor;
		if(variable == null){
			variable = "";
		}
		try{
			Double val = (Double.valueOf(variable));
			valor = val.doubleValue();
		}
		catch(NumberFormatException nfe){
			valor =0;
		}
			return valor;
	}


	public String acortaLongitud(String muchosDecimales){
		StringBuffer sb = new StringBuffer (muchosDecimales);
		if(sb.indexOf(".") != -1){
			String decimales=sb.substring(sb.indexOf("."));
			String decima;
			decima = sb.substring(0, sb.indexOf("."));
			sb.delete(0,sb.length());
			if (decimales.length()>3){
				decimales = decimales.substring(0,3);
			}
			if(decimales.length()<=2){
				decimales = decimales+"0";
			}
			sb.append(decima);
			sb.append(decimales);
		}
		return sb.toString();
	}

	public String formatoDinero(String formato){
		StringBuffer losEnteros = new StringBuffer(dameEnteros(formato));
		String losDecimales = dameDecimales(formato);
		if(losEnteros.length() == 8){
			losEnteros.insert(2,',');
			losEnteros.insert(6,',');
		}
		else if(losEnteros.length() == 7){
			losEnteros.insert(1,',');
			losEnteros.insert(5,',');
		}
		else if(losEnteros.length() == 4 ){
			losEnteros.insert(1,',');
		}
		else if(losEnteros.length() == 5 ){
			losEnteros.insert(2,',');
		}
		else if(losEnteros.length() == 6 ){
			losEnteros.insert(3,',');
		}
		return losEnteros.toString()+"."+losDecimales;
	}

	public String dameDecimales(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		boolean existieron = false;
		if(sb.indexOf(".") != -1){
			sb=sb.delete(0, sb.indexOf(".")+1);
			existieron = true;
		}
		if (!existieron){
			sb = new StringBuffer ("00");
		}
		return sb.toString();
	}

	public String dameEnteros(String enteros){
		StringBuffer sb = new StringBuffer (enteros);
		if(sb.indexOf(".") != -1){
			sb=sb.delete(sb.indexOf("."),sb.length() );
		}
		return sb.toString();
	}

	private String checkSize (String revisa){
		StringBuffer verificador = new StringBuffer(revisa);
		if (verificador.length() ==1){
			verificador.insert(0,"0");
		}
		return verificador.toString();
	}

	protected String formatoEspaciado(String cantidad) throws Exception{
		int tamanioCantidad = cantidad.length();
		while (tamanioCantidad < 10 ){
			cantidad = "  "+cantidad;
			tamanioCantidad++;
		}
		StringBuilder sb = new StringBuilder(cantidad);
		int contadorUnos = 0;
		while (sb.indexOf("1") != -1){
			sb.replace(sb.indexOf("1"), (sb.indexOf("1")+1),"*");
			contadorUnos ++;
		}
		while (sb.indexOf("*") != -1){
			sb.replace(sb.indexOf("*"), (sb.indexOf("*")+1),"1");
		}
		while (contadorUnos > 0){
			cantidad = " "+cantidad;
			contadorUnos --;
		}
		return cantidad;
	}

	protected String formatoEspaciado2(String cantidad) throws Exception{
		int tamanioCantidad = cantidad.length();
		while (tamanioCantidad < 10 ){
			cantidad = "  "+cantidad;
			tamanioCantidad++;
		}
		return cantidad;
	}

	public static String codifica (String src) throws UnsupportedEncodingException{
      String cody=java.net.URLEncoder.encode(src, "UTF-8");
      return cody;
	}



	public static String decodifica (String src) throws UnsupportedEncodingException{
		String decody;
		URLDecoder decoder = new URLDecoder();
		decody=decoder.decode(src, "UTF-8");
		return decody;
	}


	public Date cambiaADate(String fecha) {
		java.sql.Date elDia;
		try {
			elDia = java.sql.Date.valueOf(new String(fecha));
		}
		catch(IllegalArgumentException iae){
			elDia = java.sql.Date.valueOf(new String("9999-10-10"));
		}
		return elDia;
	}
}