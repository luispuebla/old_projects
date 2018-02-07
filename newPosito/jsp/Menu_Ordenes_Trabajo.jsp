<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Órdenes de Trabajo</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuProduccion.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="rect" coords="126,117,413,147" href="Alta_Orden_Trabajo.jsp" target="_self">
    <area shape="rect" coords="156,167,446,197" href="Existe_Orden_Trabajo_Baja.jsp" target="_self">
    <area shape="rect" coords="181,217,577,249" href="Existe_Orden_Trabajo_Confirmacion.jsp" target="_self">
    <area shape="rect" coords="208,266,627,299" href="Menu_Consul_Ordenes_Trabajo.jsp" target="_self">
    <area shape="rect" coords="615,320,692,389" href="Menu_Admon.jsp" target="_self">
  </map>
</div>
</body>
</html>
