<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Consultas &Oacute;rdenes de Trabajo</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuConsultasOT.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="617,322,687,383" href="Menu_Ordenes_Trabajo.jsp" target="_self">
    <area shape="rect" coords="130,113,514,147" href="Ordenes_Trabajo_Pendientes.jsp" target="_self">
    <area shape="rect" coords="155,162,542,198" href="Ordenes_Trabajo_Canceladas.jsp" target="_self">
    <area shape="rect" coords="181,215,581,249" href="Escoge_Mes_Ordenes_Finiquitadas.jsp" target="_self">
  </map>
</div>
</body>
</html>
