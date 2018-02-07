<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="cob" class="com.ult.bd.ManagerCobros" scope="page" />

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
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	String fecha = request.getParameter("fecha");
	String fechaPrint = fecha;
%>

<h1>Los Cobros recibidos para la Fecha:<strong>
<%
	ResultSet datosCorteTC = cob.dameCorteCajaTC(fecha);
	ResultSet datosCorteTD = cob.dameCorteCajaTD(fecha);
	ResultSet datosCorteE = cob.dameCorteCajaE(fecha);
	boolean esReporteMensual = false;
	if(request.getParameter("dia").equalsIgnoreCase("%%")){
		esReporteMensual = true;
		fechaPrint = request.getParameter("mes")+"/"+request.getParameter("anio");
	}
	double totalFinal = 0.0;
	double ttc = 0.0;
	double ttd = 0.0;
	double te = 0.0;
%><%=fechaPrint%></strong> son:</font> </h1>
<% if(!esReporteMensual){ %>
<b>COBROS EN TARJETAS DE CR&Eacute;DITO</b> 
<table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
      
      <th width="142">Mesa</th>
    <th width="142">Cheque</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
	while (datosCorteTC.next()){
	ttc = ttc + datosCorteTC.getDouble("monto");
	
%>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=cob.dameMesa(datosCorteTC.getString("claveVenta"))%></font></div></td>
      <td><div align="center"><%=datosCorteTC.getString("claveVenta")%></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteTC.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteTC.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteTC.getString("consecutivo"))%>&nbsp;</div></td>
	 </tr>
	<%}%>
    <tr> 
 	<td></td>
     <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttc+""))%></div></td>
      <td>&nbsp;</td>
	 </tr>
</table>
<p></p>
<b>COBROS EN AMERICAN EXPRESS</b> 
<table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
      
      <th width="142">Mesa</th>
    <th width="142">Cheque</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
	while (datosCorteTD.next()){
	ttd = ttd + datosCorteTD.getDouble("monto");
	
%>
    <tr> 
       <td><div align="center"><font color="#FF0000"><%=cob.dameMesa(datosCorteTD.getString("claveVenta"))%></font></div></td>
     <td><div align="center"><%=datosCorteTD.getString("claveVenta")%></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteTD.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteTD.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteTD.getString("consecutivo"))%>&nbsp;</div></td>
	 </tr>
	<%}%>
    <tr> 
 	<td></td>
     <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttd+""))%></div></td>
      <td>&nbsp;</td>
	 </tr>
</table>
<p></p>
<b>COBROS EN EFECTIVO</b>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
      
      <th width="142">Mesa</th>
    <th width="142">Cheque</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
	while (datosCorteE.next()){
	te = te + datosCorteE.getDouble("monto");
	
%>
    <tr> 
       <td><div align="center"><font color="#FF0000"><%=cob.dameMesa(datosCorteE.getString("claveVenta"))%></font></div></td>
     <td><div align="center"><%=datosCorteE.getString("claveVenta")%></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteE.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteE.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteE.getString("consecutivo"))%>&nbsp;</div></td>
	 </tr>
	<%}%>
    <tr> 
 	<td></td>
     <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(te+""))%></div></td>
      <td>&nbsp;</td>
	 </tr>
</table>
<p></p>
<%}
else{
	while (datosCorteTC.next()){
		ttc = ttc + datosCorteTC.getDouble("monto");
	}
	while (datosCorteTD.next()){
		ttd = ttd + datosCorteTD.getDouble("monto");
	}
	while (datosCorteE.next()){
		te = te + datosCorteE.getDouble("monto");
	}	
}%>
<p></p>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <caption>
  CONCENTRADO 
  </caption>
    <tr bgcolor="#CCCCCC"> 
      
    <th width="215">Tarjetas Cr&eacute;dito</th>
      
    <th width="247">American Express</th>
      <th width="180">Efectivo</th>
    </tr>
    <tr> 
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttc +"")) %></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttd +"")) %></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(te+"")) %></div></td>
    </tr>
  </table>
    <br />
<%
totalFinal = ttc + ttd + te;
cob.cierraConexion();
%>
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


