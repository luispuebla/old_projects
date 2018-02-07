<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Bebidas</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (!usuario.equalsIgnoreCase("producto") || !tipou.equalsIgnoreCase("Simple"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuBebidas.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="70,80,298,104" href="Alta_BebidasS.jsp" target="_self">
    <area shape="rect" coords="120,175,428,205" href="Selecciona_Division_BebidaCS.jsp" target="mainFrame">
    <area shape="rect" coords="97,128,314,158" href="Selecciona_Division_BebidaS.jsp" target="_self">
    <area shape="rect" coords="618,325,693,393" href="Menu_ProductosS.jsp" target="_self">
    <area shape="rect" coords="163,277,407,306" href="Todas_BebidasS.jsp" target="_self">
  </map>
</div>
</body>
</html>
