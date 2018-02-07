<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Productos</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuProductos.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="207,114,330,145" href="Menu_Lineas.jsp" target="_self">
    <area shape="rect" coords="308,242,474,275" href="Menu_Productos2.jsp" target="_self">
    <area shape="rect" coords="627,326,682,394" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="256,184,388,211" href="Menu_Marcas.jsp" target="_self">
  </map>
</div>
</body>
</html>
