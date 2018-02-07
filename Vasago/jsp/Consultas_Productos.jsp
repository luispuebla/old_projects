<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Clientes</title>
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
<div align="center"><img src="imagenes/ConsultasProductos.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="rect" coords="68,125,362,153" href="Todos_Productos.jsp" target="mainFrame">
    <area shape="rect" coords="124,194,356,224" href="Lista_Costos.jsp" target="_self">
    <area shape="rect" coords="628,324,685,395" href="Menu_Productos2.jsp" target="_self">
    <area shape="rect" coords="186,254,422,288" href="Lista_Precios.jsp" target="_self">
  </map>
</div>
</body>
</html>
