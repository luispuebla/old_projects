<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Compras</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
<div align="center"><img src="imagenes/MenuCompras.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="630,328,682,393" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="79,75,309,109" href="Alta_Prueba.jsp">
    <area shape="rect" coords="102,128,325,158" href="Escoge_Proveedor_Orden_Baja.jsp">
    <area shape="rect" coords="119,177,460,209" href="Escoge_Proveedor_Orden_Cambio.jsp">
    <area shape="rect" coords="139,228,478,257" href="Escoge_Proveedor_Orden_Factura.jsp">
    <area shape="rect" coords="179,330,450,359" href="Consultas_Compras.jsp">
    <area shape="rect" coords="160,280,402,307" href="Menu_Pagos.jsp">
  </map>
</div>
</body>
</html>
