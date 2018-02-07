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
    <area shape="rect" coords="613,328,683,389" href="Menu_Ordenes_Trabajo.jsp" target="_self">
    <area shape="rect" coords="109,85,493,119" href="Ordenes_Trabajo_Pendientes.jsp" target="_self">
    <area shape="rect" coords="136,135,523,171" href="Ordenes_Trabajo_Canceladas.jsp" target="_self">
    <area shape="rect" coords="160,185,560,219" href="Escoge_Mes_Ordenes_Finiquitadas.jsp" target="_self">
  </map>
</div>
</body>
</html>
