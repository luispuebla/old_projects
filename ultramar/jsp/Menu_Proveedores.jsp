<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Proveedores</title>
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
<div align="center"><img src="imagenes/MenuProveedores.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="70,80,347,107" href="Alta_Proveedores.jsp" target="_self">
    <area shape="rect" coords="120,175,476,207" href="Existe_Proveedor_Cambio.jsp" target="mainFrame">
    <area shape="rect" coords="97,128,363,158" href="Existe_Proveedor_Baja.jsp" target="_self">
    <area shape="rect" coords="618,326,693,394" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="139,228,509,259" href="Consultas_Proveedores.jsp" target="_self">
  </map>
</div>
</body>
</html>
