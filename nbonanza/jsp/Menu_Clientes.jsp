<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Clientes</title>
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
<div align="center"><img src="imagenes/MenuClientes.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="rect" coords="108,84,314,119" href="Alta_Clientes2.jsp" target="_self">
    <area shape="rect" coords="137,134,444,167" href="Existe_Cliente_Cambio.jsp" target="_self">
    <area shape="rect" coords="166,183,375,219" href="Existe_Cliente_Baja.jsp" target="_self">
    <area shape="rect" coords="193,234,478,269" href="Consultas_Clientes.jsp" target="_self">
    <area shape="rect" coords="616,322,693,391" href="Menu_Admon.jsp" target="_self">
  </map>
</div>
</body>
</html>
