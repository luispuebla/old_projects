<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Consultas de Clientes</title>
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
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 	
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<body>
<div align="left">
  <p align="center"><img src="imagenes/MenuConsultasPagos.jpg" width="700" height="400" border="0" usemap="#Map">   
    <map name="Map">
      <area shape="rect" coords="618,322,688,384" href="Menu_Pagos.jsp" target="_self">
      <area shape="rect" coords="130,117,491,148" href="Escoge_Proveedor_Pagos.jsp" target="mainFrame">
      <area shape="rect" coords="150,167,499,196" href="Escoge_Proveedor_Pagos_Faltantes.jsp">
      <area shape="rect" coords="184,219,429,248" href="Tipo_Pago_Faltante.jsp">
    </map>
  </p></p>
</div>
</body>
</html>
