<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="" %>
<jsp:useBean id="cob" class="com.ult.bd.ManagerCobros" scope="page" />
<jsp:useBean id="time" class="com.ult.bd.TimeStamp" scope="page" />

<html>
<head>
<title>Corte Diario</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

function Cerrar() {
	parent.close(); 
}
 
//-->
</script>
</head>
  
<body onLoad="imprimirPagina(); Cerrar()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String tipoConsul = request.getParameter("tipoCon");
	String dia = "%%";
	String mes = request.getParameter("mes");
	String anio = request.getParameter("aaaa");
	boolean esReporteMensual = true;
	double totalFinal = 0.0;
	double totalTC = 0.0;
	double totalAE = 0.0;
	double totalCompro = 0.0;
	double totalEfec = 0.0;
	double totalFactur = 0.0;
	double totalTarget = 0.00;
	double totalPosible = 0.00;	
	BigDecimal bgTotal = new BigDecimal("0.00");	
	String fecha = "";
	ResultSet datosCorteTC = null;
	ResultSet datosCorteTD = null;
	ResultSet datosCorteE = null;
	ResultSet datosCorteES = null;
	ResultSet datosCorteEC = null;
	ResultSet datosCorteESinFacturar = null;	
	if(tipoConsul.equalsIgnoreCase("dia")){
		esReporteMensual = false;
		dia = request.getParameter("dia");
		fecha = anio+"-"+mes+"-"+dia;	
		datosCorteTC = cob.dameCorteCajaTC(fecha);		
		while (datosCorteTC.next()){
			totalTC = totalTC + datosCorteTC.getDouble("monto");
		}
		datosCorteTD = cob.dameCorteCajaTD(fecha);
		while (datosCorteTD.next()){
			totalAE = totalAE + datosCorteTD.getDouble("monto");
		}
		datosCorteE = cob.dameCorteCajaE(fecha);
		while (datosCorteE.next()){
			totalEfec = totalEfec + datosCorteE.getDouble("monto");
		} 
		cob.cierraConexionB();
		datosCorteES = cob.dameCorteCajaES(fecha);
		while (datosCorteES.next()){
			totalFactur = totalFactur + datosCorteES.getDouble("monto");
		} 
		datosCorteEC = cob.dameCorteCajaEC(fecha);
		while (datosCorteEC.next()){
			totalCompro = totalCompro + datosCorteEC.getDouble("monto");
		} 			
		datosCorteESinFacturar = cob.dameCorteCajaESinFacturar(fecha);
	}
	else{
		fecha = anio+"-"+mes+"-"+dia;		
		datosCorteTC = cob.dameCorteCajaTC(fecha);		
		while (datosCorteTC.next()){
			totalTC = totalTC + datosCorteTC.getDouble("monto");
		}
		datosCorteTD = cob.dameCorteCajaTD(fecha);
		while (datosCorteTD.next()){
			totalAE = totalAE + datosCorteTD.getDouble("monto");
		}
		datosCorteE = cob.dameCorteCajaE(fecha);
		while (datosCorteE.next()){
			totalEfec = totalEfec + datosCorteE.getDouble("monto");
		} 
		cob.cierraConexionB();		
		datosCorteES = cob.dameCorteCajaES(fecha);
		while (datosCorteES.next()){
			totalFactur = totalFactur + datosCorteES.getDouble("monto");
		} 
		datosCorteEC = cob.dameCorteCajaEC(fecha);
		while (datosCorteEC.next()){
			totalCompro = totalCompro + datosCorteEC.getDouble("monto");
		} 			
		datosCorteESinFacturar = cob.dameCorteCajaESinFacturar(fecha);
	}
	totalTarget = (totalEfec * 15)/100;
%>	
<h1>Los Cobros recibidos para la Fecha:<strong>
<%	
	if(!(dia.equalsIgnoreCase("%%"))){
		out.print(dia+"/");
	}
%><%=mes%>/<%=anio%></strong> son:</font> </h1>

<% if(!esReporteMensual){ %>
<b>COBROS EN TARJETAS DE CR&Eacute;DITO</b>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
      <th width="142">Mesa</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
		datosCorteTC.beforeFirst();
		while (datosCorteTC.next()){ %>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=datosCorteTC.getString("IDMM")%></font></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteTC.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteTC.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteTC.getString("consecutivo"))%>&nbsp;</div></td>
    </tr>
			
<%		} 
		datosCorteTC.close();
		cob.cierraConexion();
%>
    <tr> 
      <th><div align="right">TOTAL:</div></th>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(totalTC+""))%></div></td>
      <td colspan="2">&nbsp;</td>
    </tr>
</table>
<b>COBROS EN AMERICAN EXPRESS</b>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
      <th width="142">Mesa</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
	datosCorteTD.beforeFirst();
	while (datosCorteTD.next()){
	
%>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=datosCorteTD.getString("IDMM")%></font></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteTD.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteTD.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteTD.getString("consecutivo"))%>&nbsp;</div></td>
    </tr>
	<%}
		datosCorteTD.close();
		cob.cierraConexionA();
	%>
    <tr> 
      <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(totalAE+""))%></div></td>
      <td colspan="2">&nbsp;</td>
    </tr>
</table>
<p></p>
<b>COBROS EN EFECTIVO</b>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
     <th width="142">Mesa</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
<% } %>	
    <%
	 if(tipoConsul.equals("dia")){
		datosCorteESinFacturar.beforeFirst();
		datosCorteES.beforeFirst();
		datosCorteEC.beforeFirst();
		while (datosCorteES.next()){ %>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=datosCorteES.getString("IDMM")%></font></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteES.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteES.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteES.getString("cobro"))%>&nbsp;</div></td>
    </tr>		
	<%	}
		datosCorteES.close();
		if(tipoConsul.equalsIgnoreCase("mes")){
			cob.cierraConexionC();
		}
		while (datosCorteEC.next()){ %>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=datosCorteEC.getString("IDMM")%></font></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteEC.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteEC.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteEC.getString("consecutivo"))%>&nbsp;</div></td>
    </tr>		
	<%	}
		datosCorteEC.close();
		cob.cierraConexionD();
		if(totalFactur+totalCompro < totalTarget){
			while (datosCorteESinFacturar.next() && totalFactur+totalCompro+totalPosible < totalTarget){ 
			//System.out.println("Tengo Previo: " +(totalFactur+totalCompro+totalPosible) +", Para: "+totalTarget);		
			totalPosible += datosCorteESinFacturar.getDouble("monto");		
//			System.out.println("Tengo Posterior: " +(totalFactur+totalCompro+totalPosible) +", Para: "+totalTarget);
		%>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=cob.dameMesa(datosCorteESinFacturar.getString("claveVenta"))%></font></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteESinFacturar.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteESinFacturar.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteESinFacturar.getString("consecutivo"))%>&nbsp;</div></td>
    </tr>		
<%			}
			datosCorteESinFacturar.close();
			cob.cierraConexionE();
		}
%>
    <tr> 
      <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud((totalFactur+totalCompro+totalPosible)+""))%></div></td>
      <td colspan="2">&nbsp;</td>
    </tr>
<%	
	}
	else{
		int anioActual = cob.cambiaAInt(fecha.substring(0,4));
		int mesActual = cob.cambiaAInt(fecha.substring(5,7));
		int limite = 31;
		if (mesActual == 4 ||  mesActual == 6 || mesActual == 9 || mesActual == 11){
			limite = 30;
		}
		else if(mesActual == 2){
			if(anioActual%(4) == 0){
				limite = 29;
			}
			else{
				limite = 28;
			}
		}
		BigDecimal bgFactur = new BigDecimal("0.00");
		BigDecimal bgCompra = new BigDecimal("0.00");			
		BigDecimal bgPosible = new BigDecimal("0.00");		
		for(int i = 1; i<= limite; i++){		
			totalPosible = 0.00;
			String nuevaFecha = anioActual+"-"+cob.checkSize(mesActual)+"-"+time.checkSize(i);
			double tempEfec = 0.00;
			double tempTFactur = 0.00;
			double tempCompra = 0.00;
			datosCorteES = cob.dameCorteCajaES(nuevaFecha);
			while(datosCorteES.next()){
				tempTFactur = tempTFactur + datosCorteES.getDouble("monto");
				bgFactur = bgFactur.add(new BigDecimal(datosCorteES.getString("monto")));
			}			
			datosCorteEC = cob.dameCorteCajaEC(nuevaFecha);
			while(datosCorteEC.next()){
				tempCompra = tempCompra + datosCorteEC.getDouble("monto");	
				bgCompra = bgCompra.add(new BigDecimal(datosCorteEC.getString("monto")));
			}			
			datosCorteESinFacturar = cob.dameCorteCajaESinFacturar(nuevaFecha);
			datosCorteE = cob.dameCorteCajaE(nuevaFecha);
			while(datosCorteE.next()){
				tempEfec = tempEfec + datosCorteE.getDouble("monto");				
			}
			cob.cierraConexionB();
			totalTarget = (tempEfec * 15)/100;
			datosCorteESinFacturar.beforeFirst();
			datosCorteES.beforeFirst();
			datosCorteEC.beforeFirst();
			datosCorteES.close();
			cob.cierraConexionC();
			datosCorteEC.close();
			cob.cierraConexionD();
			if(tempTFactur+tempCompra < totalTarget){
				while (datosCorteESinFacturar.next() && tempTFactur+tempCompra+totalPosible < totalTarget){ 
				//System.out.println("Tengo Previo: " +(totalFactur+totalCompro+totalPosible) +", Para: "+totalTarget);		
				totalPosible += datosCorteESinFacturar.getDouble("monto");
				bgPosible = bgPosible.add(new BigDecimal(datosCorteESinFacturar.getString("monto")));	
//				System.out.println("Tengo Posterior: " +(totalFactur+totalCompro+totalPosible) +", Para: "+totalTarget);
				}
				datosCorteESinFacturar.close();
				cob.cierraConexionE();
			}
		}
		bgTotal = bgTotal.add(bgPosible);
		bgTotal = bgTotal.add(bgFactur);
		bgTotal = bgTotal.add(bgCompra);
		bgTotal = bgTotal.setScale(2, RoundingMode.HALF_UP);								
	}
%>	 	

</table>
<p></p>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <caption>
    Concentrado 
    </caption>
    <tr bgcolor="#CCCCCC"> 
      <th width="215">Tarjetas Cr&eacute;dito</th>
      <th width="247">American Express</th>
      <th width="180">Efectivo</th>
    </tr>
    <tr> 
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(totalTC +"")) %></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(totalAE +"")) %></div></td>
		<%if(tipoConsul.equals("dia")){%>
	      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud((totalFactur+totalCompro+totalPosible)+"")) %></div></td>
<%		}
		else{ %>
		  <td><div align="center">$ <%=cob.formatoDinero(bgTotal.toString()) %></div></td>
<%		}		%>
    </tr>
  </table>
    <br />
<%
if(tipoConsul.equals("dia")){
	totalFinal = totalTC + totalAE + totalFactur+totalCompro+totalPosible;
} else{
	totalFinal = totalTC + totalAE + cob.cambiaADouble(bgTotal.toString());
}
cob.cierraConexion();
%>
<p></p>
    <table cellpadding="0" cellspacing="0" border="1" align="center" width="650">
      <caption>&nbsp;
      </caption>
      <tr bgcolor="#999999"> 
        <th width="418">GRAN TOTAL...............</th>
        
      <th width="226">$ <%=cob.formatoDinero(cob.acortaLongitud(totalFinal +"")) %></th>
      </tr>
    </table>
    <br/>
</body>
</html>


