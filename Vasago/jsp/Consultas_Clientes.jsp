<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Consultas de Clientes</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="left">
  <p align="center"><img src="imagenes/ConsultasClientes.jpg" width="700" height="400" border="0" usemap="#Map">   
    <map name="Map">
      <area shape="rect" coords="117,190,408,230" href="Existe_Cliente_Facturas.jsp" target="mainFrame">
      <area shape="rect" coords="623,327,684,394" href="Menu_Clientes.jsp" target="_self">
      <area shape="rect" coords="182,254,480,289" href="Existe_Agente_Clientes.jsp" target="mainFrame">
      <area shape="rect" coords="67,120,342,155" href="TodosCli.jsp" target="mainFrame">
    </map>
  </p></p>
</div>
</body>
</html>
