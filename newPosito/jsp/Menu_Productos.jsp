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
    <area shape="rect" coords="127,116,453,148" href="Cambio_Productoh.jsp" target="_self">
    <area shape="rect" coords="154,164,386,196" href="Baja_Producto.jsp" target="_self">
    <area shape="rect" coords="186,215,466,248" href="ListadosProductos.jsp" target="_self">
    <area shape="rect" coords="100,65,331,98" href="Alta_Producto.jsp" target="_self">
    <area shape="rect" coords="617,319,689,388" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="214,268,507,296" href="Consulta_Productos.jsp" target="_self">
  </map>
</div>
</body>
</html>
