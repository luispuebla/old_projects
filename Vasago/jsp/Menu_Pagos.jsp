<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Pagos</title>
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
<div align="center"><img src="imagenes/MenuPagos.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="621,322,686,396" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="70,96,276,126" href="Escoge_Proveedor_Pago.jsp">
    <area shape="rect" coords="93,144,306,173" href="Escoge_Proveedor_Pago_Baja.jsp">
    <area shape="rect" coords="151,241,435,275" href="Consultas_Pagos.jsp">
    <area shape="rect" coords="123,193,449,225" href="Escoge_Proveedor_Pagos_Cheque.jsp">
  </map>
</div>
</body>
</html>
