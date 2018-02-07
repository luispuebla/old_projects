<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Proveedores</title>
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
<div align="center"><img src="imagenes/MenuProveedores.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="68,97,367,124" href="Alta_Proveedores.jsp" target="_self">
    <area shape="rect" coords="123,193,530,223" href="Existe_Proveedor_Cambio.jsp" target="mainFrame">
    <area shape="rect" coords="94,143,393,175" href="Existe_Proveedor_Baja.jsp" target="_self">
    <area shape="rect" coords="618,326,693,394" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="153,242,523,273" href="Consultas_Proveedores.jsp" target="_self">
  </map>
</div>
</body>
</html>
