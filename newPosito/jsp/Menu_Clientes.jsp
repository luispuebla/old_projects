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
    <area shape="rect" coords="102,67,308,102" href="Alta_Clientes2.jsp" target="_self">
    <area shape="rect" coords="133,116,440,149" href="Existe_Cliente_Cambio.jsp" target="_self">
    <area shape="rect" coords="154,169,363,205" href="Existe_Cliente_Baja.jsp" target="_self">
    <area shape="rect" coords="189,213,474,248" href="Consultas_Clientes.jsp" target="_self">
    <area shape="rect" coords="616,322,693,391" href="Menu_Admon.jsp" target="_self">
  </map>
</div>
</body>
</html>
