<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 

<html>
<head>
<title>Men&uacute; Principal</title>
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
<p align="center"><img src="imagenes/MenuPrincipal.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="poly" coords="476,115,609,115,609,27,476,27" href="Menu_Productos.jsp" target="_self">
    <area shape="poly" coords="281,335,430,335,389,244,316,244" href="Menu_Ordenes_Trabajo.jsp" target="_self">
    <area shape="poly" coords="504,320,586,320,607,228,487,228" href="Menu_Ventas.jsp" target="_self">
    <area shape="poly" coords="102,114,213,114,198,12,118,12" href="Menu_Clientes.jsp" target="_self">
    <area shape="poly" coords="33,214,189,214,189,139,54,139" href="Menu_Proveedores.jsp" target="_self">
    <area shape="rect" coords="296,13,417,93" href="Menu_Compras.jsp" target="_self">
    <area shape="poly" coords="99,326,209,326,208,278,190,278,190,227,118,227,118,278,99,278" href="Menu_Vendedores.jsp" target="_self">
    <area shape="poly" coords="523,212,523,180,556,180,556,125,623,125,623,180,661,180,661,212" href="Menu_Inventarios.jsp" target="_self">
  </map>
</p>
</body>
</html>
