<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" session = "true"%>

<html>
<head>
<title>Menu Inventarios</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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
<div align="center"><img src="imagenes/MenuVentas.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="152,161,319,204" href="Menu_FacturasV.jsp" target="_self">
    <area shape="rect" coords="132,115,344,156" href="Menu_Cobros.jsp" target="_self">
    <area shape="rect" coords="217,261,514,298" href="Menu_Ventas_ConsulYEstad.jsp" target="_self">
    <area shape="rect" coords="185,217,543,253" href="Menu_Contras_Texto.jsp" target="_self">
    <area shape="rect" coords="615,322,689,383" href="Menu_Admon.jsp" target="_self">
  </map>
</div>
</body>
</html>
