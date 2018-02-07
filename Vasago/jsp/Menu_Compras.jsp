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
<div align="center"><img src="imagenes/MenuCompras.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="628,328,684,393" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="65,67,306,95" href="Alta_Prueba.jsp">
    <area shape="rect" coords="92,118,319,146" href="Escoge_Proveedor_Orden_Baja.jsp">
    <area shape="rect" coords="122,165,466,195" href="Escoge_Proveedor_Orden_Cambio.jsp">
    <area shape="rect" coords="151,216,503,252" href="Escoge_Proveedor_Orden_Factura.jsp">
    <area shape="rect" coords="211,316,526,350" href="Consultas_Compras.jsp">
    <area shape="rect" coords="180,267,453,301" href="Menu_Pagos.jsp">
  </map>
</div>
</body>
</html>
