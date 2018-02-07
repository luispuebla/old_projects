<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Compras</title>
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
<div align="center"><img src="imagenes/MenuVentas.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="628,328,684,393" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="92,73,303,103" href="Alta_Venta.jsp" target="_self">
    <area shape="rect" coords="112,126,323,156" href="Escoge_Cliente_Venta_Baja.jsp" target="_self">
    <area shape="rect" coords="175,225,469,256" href="Consultas_Ventas.jsp" target="_self">
    <area shape="rect" coords="142,176,399,208" href="Menu_Cobros.jsp" target="_self">
  </map>
</div>
</body>
</html>
