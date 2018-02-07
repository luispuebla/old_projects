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
	if (usuario == null || !tipo.equalsIgnoreCase("caja"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<p align="center"><img src="imagenes/MenuB.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="poly" coords="484,268,483,263" href="#">
    <area shape="poly" coords="560,307" href="#">
    <area shape="poly" coords="84,219,199,219,199,193,189,193,189,118,103,118,103,190,84,190" href="Menu_Clientes.jsp" target="_self">
    <area shape="poly" coords="496,75" href="#">
    <area shape="poly" coords="502,192,522,192,522,127,615,111,593,194,634,194,634,220,501,220,502,221" href="Menu_Productos.jsp" target="_self">
    <area shape="poly" coords="304,100,304,72,318,72,318,27,381,27,381,73,408,73,408,100" href="Menu_Ventas_Cash.jsp" target="_self">
  </map>
</p>
</body>
</html>
