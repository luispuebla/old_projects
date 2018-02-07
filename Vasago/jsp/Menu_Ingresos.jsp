<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Ingresos</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
<div align="center"><img src="imagenes/MenuIngresos.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="rect" coords="145,126,394,159" href="Alta_Ingreso.jsp" target="_self">
    <area shape="rect" coords="618,326,693,394" href="Menu_Bancos.jsp" target="_self">
    <area shape="rect" coords="192,195,431,227" href="Baja_Ingreso.jsp" target="_self">
  </map>
</div>
</body>
</html>
