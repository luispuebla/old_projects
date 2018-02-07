<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage=""%>
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" scope="page"/>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

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
	String totalPago = request.getParameter("pagados");
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
	String vendedor = request.getParameter("vendedor");
	String vencimiento = credito.parseaFechaASabado(ticket.dameFechaHoy());
%>
<h1>Confirmaci&oacute;n de Asignaci&oacute;n de Cr&eacute;dito.</h1>
<table align="center" border="1" width="600">
<caption>Datos Vendedor / Cr&eacute;dito</caption>
  <tr>
	<th>Vendedor:</th>
	<td><%=empleado.dameNombreUsuario(vendedor)%></td>
  </tr>
  <tr>
  	<th>Monto a Cr&eacute;dito:</th>
	<td><%=credito.formatoDinero(totalPago)%></td>
  </tr>
  <tr>
  	<th>Fecha Finiquito:</th>
	<td>Pr&oacute;ximo s&aacute;bado: <%=vencimiento%></td>
  </tr>
</table>
<form name="form1" method="post" action="Conf_Pago_Credito_Vendedor.jsp">
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
	<input name="vendedor" type="hidden" value="<%=vendedor%>">
	<input name="vencimiento" type="hidden" value="<%=vencimiento%>">
	<input name="totalPago" type="hidden" value="<%=totalPago%>">
<p align="center"><input type="submit" name="Submit" value="Confirmaci&oacute;n"></p>
</form>
<p align="center"><a href="Menu_Credito.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>
