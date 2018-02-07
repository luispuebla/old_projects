<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Precios Bebidas</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="left">
  <p align="center"><img src="imagenes/PreciosBebidas.jpg" width="700" height="400" border="0" usemap="#Map"> 
    <map name="Map">
      <area shape="rect" coords="54,183,480,222" target="mainFrame">
      <area shape="rect" coords="623,327,684,394" href="Menu_Bebidas.jsp" target="_self">
      <area shape="rect" coords="37,132,571,170" href="Existe_Bebida_Cambio_Precio_Porcentaje_Division.jsp" target="mainFrame">
    </map>
  </p></p>
</div>
</body>
</html>
