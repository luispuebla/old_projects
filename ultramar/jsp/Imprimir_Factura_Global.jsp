<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="numL" class="com.ult.bd.n2t" scope="page" />
<jsp:useBean id="cobro" class="com.ult.bd.ManagerCobros" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Impresi&oacute;n Factura</title>
<link href="ultramarinaFacturaCSS.css" rel="stylesheet" type="text/css">
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
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 24px;
	font-weight: bold;
}
-->
</style>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}

	String subTotal = request.getParameter("subTotal");
	String iva = request.getParameter("iva");
	String total = request.getParameter("total");
	String fecha = request.getParameter("fecha");
	fecha = fecha.substring(8,10)+"/"+fecha.substring(5,7)+"/"+fecha.substring(0,4);
%>
<body onLoad="imprimirPagina(); Cerrar()">
<div id="Layer1" style="position:absolute; left:580px; top:214px; width:210px; height:23px; z-index:1">
<table width="200" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td><div align="center"><%=fecha%></div></td>
	</tr>
</table>
</div>
<div id="Layer2" style="position:absolute; left:580px; top:746px; width:210px; height:23px; z-index:1">
<table width="200" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td><div align="center"><%=fecha%></div></td>
	</tr>
</table>
</div>
<table width="735" border="0" cellpadding="0" cellspacing="0" height="960">
  <tr valign="top">
  	<td>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	  <tr>
		<td colspan="6" height="140">&nbsp;</td>
	  </tr>
	  <tr valign="top">
	  	<td width="94">&nbsp;</td>
		<td colspan="3" height="38">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	  <tr valign="top">
	  	<td>&nbsp;</td>
		<td colspan="3" height="58"><div align="center" class="style1"> GLOBAL </div></td>
		<td colspan="2">&nbsp;</td>
	  </tr>
	  <tr valign="top">
	  	<td>&nbsp;</td>
		<td width="180" height="25"><div align="center">&nbsp;</div></td>
		<td width="54">&nbsp;</td>
		<td width="176"><div align="left">&nbsp;</div></td>				
		<td colspan="2">&nbsp;</td>
	  </tr>
	  <tr>
		<td colspan="6" height="64">&nbsp;</td>
	  </tr>
	  <tr valign="middle">
	  	<td rowspan="3">&nbsp;</td>
		<td rowspan="3" colspan="3"><div align="center">*****<%=numL.convertirLetras(Integer.parseInt(cobro.dameEnteros(total)))%> pesos <%=cobro.dameDecimales(total)%>/100 M.N.*****</div></td>
		<td width="109">&nbsp;</td>
		<td width="122"><div align="right"><%=cobro.formatoDinero(subTotal)%></div></td>		
	  </tr>	  
	  <tr valign="bottom">
		<td>&nbsp;</td>
		<td height="38"><div align="right"><%=cobro.formatoDinero(iva)%></div></td>		
	  </tr>	  
	  <tr valign="bottom">
		<td>&nbsp;</td>
		<td height="40"><div align="right"><%=cobro.formatoDinero(total)%></div></td>		
	  </tr>	  
	</table>
	</td>
  </tr>
  <tr valign="bottom">
  	<td>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	  <tr>
		<td colspan="6" height="120">&nbsp;</td>
	  </tr>
	  <tr valign="top">
	  	<td width="94">&nbsp;</td>
		<td colspan="3" height="38">&nbsp;</td>
		<td colspan="2">&nbsp;</td>
	  <tr valign="top">
	  	<td>&nbsp;</td>
		<td colspan="3" height="58"><div align="center" class="style1"> GLOBAL </div></td>
		<td colspan="2">&nbsp;</td>
	  </tr>
	  <tr valign="top">
	  	<td>&nbsp;</td>
		<td width="180" height="25"><div align="center">&nbsp;</div></td>
		<td width="54">&nbsp;</td>
		<td width="176"><div align="left">&nbsp;</div></td>				
		<td colspan="2">&nbsp;</td>
	  </tr>
	  <tr>
		<td colspan="6" height="64">&nbsp;</td>
	  </tr>
	  <tr>
	  	<td rowspan="3">&nbsp;</td>
		<td rowspan="3" colspan="3"><div align="center">*****<%=numL.convertirLetras(Integer.parseInt(cobro.dameEnteros(total)))%> pesos <%=cobro.dameDecimales(total)%>/100 M.N.*****</div></td>
		<td width="109">&nbsp;</td>
		<td width="122"><div align="right"><%=cobro.formatoDinero(subTotal)%></div></td>		
	  </tr>	  
	  <tr valign="bottom">
		<td>&nbsp;</td>
		<td height="38"><div align="right"><%=cobro.formatoDinero(iva)%></div></td>		
	  </tr>	  
	  <tr valign="bottom">
		<td>&nbsp;</td>
		<td height="40"><div align="right"><%=cobro.formatoDinero(total)%></div></td>		
	  </tr>	  
	</table>
	</td>
  </tr>
</table>
</body>
</html>
