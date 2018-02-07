<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Productos</title>
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
<div align="center"><img src="imagenes/MenuProductos.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="rect" coords="138,135,464,168" href="Cambio_Productoh.jsp" target="_self">
    <area shape="rect" coords="167,185,399,217" href="Baja_Producto.jsp" target="_self">
    <area shape="rect" coords="190,235,470,268" href="ListadosProductos.jsp" target="_self">
    <area shape="rect" coords="106,85,337,118" href="Alta_Producto.jsp" target="_self">
    <area shape="rect" coords="612,324,684,393" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="228,288,521,316" href="Consulta_Productos.jsp" target="_self">
  </map>
</div>
</body>
</html>
