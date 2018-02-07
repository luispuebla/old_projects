<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Lineas</title>
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
<div align="center"><img src="imagenes/MenuLineas.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="65,104,291,138" href="Alta_Linea.jsp" target="_self">
    <area shape="rect" coords="171,234,450,271" href="Todas_Lineas.jsp">
    <area shape="rect" coords="627,322,688,397" href="Menu_Productos.jsp" target="_self">
    <area shape="rect" coords="118,172,454,207" href="Existe_Linea_Cambio.jsp" target="_self">
  </map>
</div>
</body>
</html>
