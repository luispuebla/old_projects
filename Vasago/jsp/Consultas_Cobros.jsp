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
  <p align="center"><img src="imagenes/ConsultasCobros.jpg" width="700" height="400" border="0" usemap="#Map">   
    <map name="Map">
      <area shape="rect" coords="623,327,684,394" href="Menu_Cobros.jsp" target="_self">
      <area shape="rect" coords="45,104,329,137" href="Escoge_Cliente_Cobros.jsp" target="mainFrame">
      <area shape="rect" coords="88,163,492,195" href="Escoge_Cliente_Cobros_Faltantes.jsp">
      <area shape="rect" coords="123,224,558,259" href="Existe_Agente_Clientes_Cobros.jsp">
      <area shape="rect" coords="168,285,416,319" href="Selecciona_Dia_Cobranza.jsp" target="_self">
    </map>
  </p></p>
</div>
</body>
</html>
