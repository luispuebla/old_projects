<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Proveedores</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuProveedores.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="106,85,355,117" href="Alta_Proveedores.jsp" target="_self">
    <area shape="rect" coords="137,136,485,166" href="Existe_Proveedor_Cambio.jsp" target="_self">
    <area shape="rect" coords="163,187,413,219" href="Existe_Proveedor_Baja.jsp" target="_self">
    <area shape="rect" coords="617,320,692,388" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="192,235,491,267" href="Consultas_Proveedores.jsp" target="_self">
  </map>
</div>
</body>
</html>
