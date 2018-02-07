<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>

<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" scope="page" />

<html>
<head>
<title>Asignaci&oacute;n de Ticket a Cr&eacute;dito</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String pago = request.getParameter("pagados");
	String tpago = credito.acortaLongitud(pago);
	String ticket1 = request.getParameter("ticket1");
	String ticket2 = request.getParameter("ticket2");
	String ticket3 = request.getParameter("ticket3");
	String ticket4 = request.getParameter("ticket4");
	String ticket5 = request.getParameter("ticket5");
	String pago1 = request.getParameter("pago1");
	String pago2 = request.getParameter("pago2");
	String pago3 = request.getParameter("pago3");
	String pago4 = request.getParameter("pago4");
	String pago5 = request.getParameter("pago5");
	String fecha = request.getParameter("fecha");
	String rfcCliente = request.getParameter("rfc");
	String nombreCliente = request.getParameter("nombreCliente");
	double SaldoDisponible = cliente.saldoDisponible(rfcCliente, nombreCliente);
	int diasAPagar = cliente.elTiempoDeCredito(rfcCliente, nombreCliente);
	int bloqueo = cliente.estatusBloqueo(rfcCliente, nombreCliente);
	boolean noHayCredito = (SaldoDisponible < credito.cambiaADouble(pago));
	if(bloqueo == 1){
%>
<p><div align="center"><b class="roj">El cliente esta bloqueado por tener saldos vencidos, verifique sus adeudos.</b></div>
<%
	}
	else{
%>	
<p><div align="center"><b class="aviso">Saldo Disponible de <%= nombreCliente %>: <%=credito.formatoDinero(credito.acortaLongitud(SaldoDisponible+""))%></b></div>
<div align="center">Tiempo de pago en <strong><%=diasAPagar%></strong> d&iacute;as</div>
<!--<div align="center"><font face="Eras Medium ITC" size="3">Solicitud por: <strong><%=credito.formatoDinero(credito.acortaLongitud(tpago)) %></strong></font></div> -->
</p>
<form name="form1" method="post" action="Conf_Pago_Credito.jsp">
	<input name="ticket1" type="hidden" value="<%=ticket1 %>">
	<input name="ticket2" type="hidden" value="<%=ticket2 %>">
	<input name="ticket3" type="hidden" value="<%=ticket3 %>">
	<input name="ticket4" type="hidden" value="<%=ticket4 %>">
	<input name="ticket5" type="hidden" value="<%=ticket5 %>">
	<input name="pago1" type="hidden" value="<%=pago1 %>">
	<input name="pago2" type="hidden" value="<%=pago2 %>">
	<input name="pago3" type="hidden" value="<%=pago3 %>">
	<input name="pago4" type="hidden" value="<%=pago4 %>">
	<input name="pago5" type="hidden" value="<%=pago5 %>">
	<input name="fecha" type="hidden" value="<%=fecha %>">
	<input name="rfc" type="hidden" value="<%=rfcCliente%>">
	<input name="nombre" type="hidden" value="<%=nombreCliente%>">
	<input name="diasAPagar" type="hidden" value="<%=diasAPagar%>">
<%		
		if (!noHayCredito){
%>
<table width="400" border="1" align="center">
  <tr> 
    <th> <div align="center">MONTO ACTUAL A <br/>SUMAR A CRÉDITO:</div></th>
  </tr>
  <tr>
    <td height="40"><div align="center"><input type="text" name="total" size="12" align="right" value="<%= credito.formatoDinero(credito.acortaLongitud(tpago))%>" readonly="true"> </div> </td>
  </tr>
  <tr>
  	<td><div align="center">Presiona Guardar para registrar la transacción</div></td>
</tr> 
</table>
<p align="center"><input type="submit" name="Submit" value="Guardar"></p>
</form>
<%
		} // Cierro el que si haya credito
		else{
%>
<table width="400" border="1" align="center">
  <tr>
  	<td><div align="center"><b class="roj">¡El Cliente ha sobrepasado su línea de Crédito!</b> </div></td>
  </tr> 
  <tr> 
    <th> <div align="center">TOTAL A PAGAR A CRÉDITO:</strong></div> </th>
  </tr>
  <tr>
    <td height="40"><div align="center"><input type="text" name="total" size="12" align="right" value="<%= credito.formatoDinero(credito.acortaLongitud(tpago))%>" readonly="true"></div></td>
  </tr>
  <tr>
  	<td align="center">Si aún así desea registrar la transacción presione el botón de Guardar</td>
  </tr> 
</table>
<p align="center"><input type="submit" name="Submit" value="Guardar"></p>
</form>
<%
		} //Cierro el que no haya credito
	}// CIERRO EL QUE NO ESTE VENCIDO
%>	
<p align="center"><a href="Menu_Credito.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>
