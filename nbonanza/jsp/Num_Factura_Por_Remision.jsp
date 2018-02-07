<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" session = "true" errorPage=""%>
<jsp:useBean id="facturador" class="com.alpha.bd.ManagerFacturacion" scope="page"/>

<html>
<head>
<title>Número de Factura</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
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

function funcionFoco(){
	document.form1.numFactura.focus();
}
//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco()">
<%
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 		
	String rfc = request.getParameter("rfc");
	String nombre = request.getParameter("nombre");
	String [] ArrayNumTicket = (String[])request.getParameterValues("numTicket");
	String cantidadP = request.getParameter("cantidadP");
	int numFacturas = 0;
	int ciclo = 0;
	String laFechaHoy = facturador.dameFechaHoy();
	if(request.getParameter("laFechaHoy") != null){
		laFechaHoy =request.getParameter("laFechaHoy");
	}
	// Si cambian capacidad de productos en la factura, modificar estos parámetros:
	double maximoProd = 14;
	if (facturador.cambiaADouble(cantidadP) <= maximoProd){
		numFacturas = 1;
	}
	else{
	//CAMBIE MAXIMO PARA QUITAR VIENE DE Y CONTINUA EN
		double numFacturasD = Math.ceil((facturador.cambiaADouble(cantidadP))/maximoProd);
		Double nfd = new Double(numFacturasD);
		numFacturas = nfd.intValue();
	}
%>	
<h1>Son <%=cantidadP %> productos, por lo que se necesita(n): <%=numFacturas%> factura(s).</h1>
<form name="form1" method="post" action="Conf_Num_Factura_Por_Remision.jsp">
	<input	 type="hidden" value="<%=maximoProd+""%>" name="prodXFac">
<table width="350" border="1" align="center">
<caption>Escribe los números correspondientes a cada Factura:</caption>
<%	
	for (int i=1; i<=numFacturas; i++){
%>	
  <tr>
	<th align="right" bgcolor="#CCCCCC"> Factura #<%=i%>: </th> 
	<td align="center">  <div align="center">
	  <input type="text" name="numFactura" size="14" maxlength="10"> 
	  </div></td>
  </tr>	
<%
	ciclo = i;
	}
%>
</table>
	<input type="hidden" name="nombre" value="<%=nombre%>">
	<input type="hidden" name="rfc" value="<%=rfc%>">
<%	for(int i=0; i < ArrayNumTicket.length; i++){ %>
	    <input type="hidden" name="numTicket" value="<%=ArrayNumTicket[i]%>">
<%	} %>	
	<input type="hidden" name="cantidadP" value="<%=cantidadP%>">

<p> <table width="350" border="1" align="center">
    <tr> 
      <th> Especif&iacute;ca la fecha de la(s) Factura(s):</th>
    </tr>
    <tr> 
 	  <td> <div align="center"> <input type=text name="fecha" size=15 readonly="true" value="<%=laFechaHoy%>">  <a href="javascript:show_calendar('form1.fecha');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"> <img src="imagenes/show-calendar.gif" width=24 height=22 border=0 align="absmiddle"></a> </div></td>	
    </tr>
  </table></p>
<p align="center">
		<input type="reset" name="Borrar" value="Borrar">
		<input type="submit" name="Submit" value="Continuar">		
</p>	
</form>
<p align="center"><a href="Escoge_Cliente_Remision.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
