<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Men&uacute; Principal</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<p align="center"><a href="Menu_Compras.jsp"><img src="imagenes/MenuPrincipal.jpg" width="700" height="400" border="0" usemap="#Map"></a> 
  <map name="Map">
    <area shape="poly" coords="484,268,483,263" href="#">
    <area shape="poly" coords="560,307" href="#">
    <area shape="poly" coords="522,333,407,333,407,304,443,304,443,244,500,244,500,304,522,304" href="Menu_Personal.jsp" target="_self">
    <area shape="poly" coords="63,232,228,232,228,204,185,204,185,137,103,137,103,204,63,204" href="Menu_Proveedores.jsp" target="_self">
    <area shape="poly" coords="97,113,212,113,212,87,202,87,202,12,116,12,116,84,97,84" href="Menu_Clientes.jsp" target="_self">
    <area shape="poly" coords="496,75" href="#">
    <area shape="poly" coords="465,84,485,84,485,19,582,9,559,86,597,86,597,112,464,112,465,113" href="Menu_Productos.jsp" target="_self">
    <area shape="poly" coords="167,338,287,338,287,314,256,314,256,243,206,242,206,309,167,309" href="Menu_Compras.jsp" target="_self">
    <area shape="poly" coords="299,100,299,72,313,72,313,27,376,27,376,73,403,73,403,100" href="Menu_Ventas.jsp" target="_self">
    <area shape="poly" coords="524,203,524,131,580,131,580,205,620,205,620,230,480,230,480,203" href="Menu_Inventarios.jsp" target="_self">
  </map>
</p>
</body>
</html>
