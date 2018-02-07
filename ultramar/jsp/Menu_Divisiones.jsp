<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Divisiones</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
<div align="center"><img src="imagenes/MenuDivisiones.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="98,129,339,155" href="Alta_Division.jsp" target="_self">
    <area shape="rect" coords="120,175,455,206" href="Selecciona_Division.jsp" target="mainFrame">
    <area shape="rect" coords="621,326,696,394" href="Menu_Productos.jsp" target="_self">
    <area shape="rect" coords="139,227,426,255" href="Todas_Divisiones.jsp" target="_self">
  </map>
</div>
</body>
</html>
