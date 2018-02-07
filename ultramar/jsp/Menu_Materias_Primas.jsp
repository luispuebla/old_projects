<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Materias Primas</title>
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
<div align="center"><img src="imagenes/MenuMateriaPrima.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="98,130,428,155" href="Alta_Materia_Prima.jsp" target="_self">
    <area shape="rect" coords="120,175,543,205" href="Selecciona_Materia_Prima.jsp" target="mainFrame">
    <area shape="rect" coords="621,326,696,394" href="Menu_Productos.jsp" target="_self">
    <area shape="rect" coords="139,227,486,255" href="Todos_Materias_Primas.jsp" target="_self">
  </map>
</div>
</body>
</html>
