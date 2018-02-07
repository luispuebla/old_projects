<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<title>Men&uacute; de Facturaci&oacute;n</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	

<body>
<p align="center"><img src="imagenes/MenuFacturacion.jpg" width="700" height="400" border="0" usemap="#Map"></p>
<p align="right"> 
  <map name="Map">
    <area shape="rect" coords="140,136,348,167" href="Existe_Factura.jsp" target="_self">
    <area shape="rect" coords="609,319,686,392" href="Menu_Ventas.jsp" target="_self">
    <area shape="rect" coords="108,86,364,115" href="Existe_Cliente.jsp" target="_self">
    <area shape="rect" coords="169,185,482,220" href="Selecciona_LapsoTiempo_Facturas.jsp" target="_self">
    <area shape="rect" coords="198,236,425,267" href="Escoge_Cliente_Factura_Remision.jsp" target="_self">
    <area shape="rect" coords="228,285,487,316" href="Existe_Cliente_Fac_En.jsp" target="_self">
  </map>
</p>
</body>
</html>
