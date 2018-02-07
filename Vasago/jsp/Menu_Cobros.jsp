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
<div align="center"><img src="imagenes/MenuCobros.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="621,322,686,396" href="Menu_Ventas.jsp" target="_self">
    <area shape="rect" coords="72,123,298,158" href="Escoge_Cliente_Cobro.jsp">
    <area shape="rect" coords="124,194,354,224" href="Escoge_Cliente_Baja_Cobro.jsp">
    <area shape="rect" coords="186,256,486,287" href="Consultas_Cobros.jsp">
  </map>
</div>
</body>
</html>
