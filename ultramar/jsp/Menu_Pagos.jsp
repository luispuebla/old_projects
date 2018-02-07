<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Pagos</title>
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
<div align="center"><img src="imagenes/MenuPagos.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="621,322,686,396" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="194,127,400,157" href="Escoge_Proveedor_Pago.jsp">
    <area shape="rect" coords="211,178,424,207" href="Escoge_Proveedor_Pago_Baja.jsp">
    <area shape="rect" coords="233,227,469,258" href="Consultas_Pagos.jsp">
  </map>
</div>
</body>
</html>
