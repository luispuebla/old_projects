<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Ventas</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("caja"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuVentasC.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="190,166,316,194" href="Menu_Cobros.jsp" target="_self">
    <area shape="rect" coords="224,238,442,269" href="Fecha_Corte_Caja_S.jsp" target="_self">
    <area shape="rect" coords="621,322,686,396" href="Menu_Cashier.jsp" target="_self">
    <area shape="rect" coords="136,96,317,126" href="Menu_Facturas.jsp">
  </map>
</div>
</body>
</html>
