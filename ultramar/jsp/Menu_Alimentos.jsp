<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Alimentos</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null  || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuAlimentos.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="rect" coords="70,80,327,106" href="Alta_Alimentos.jsp" target="_self">
    <area shape="rect" coords="120,175,467,207" href="Selecciona_Division_AlimentoC.jsp" target="mainFrame">
    <area shape="rect" coords="97,128,350,157" href="Selecciona_Division_Alimento.jsp" target="_self">
    <area shape="rect" coords="618,325,693,393" href="Menu_Productos.jsp" target="_self">
    <area shape="rect" coords="163,277,438,307" href="TodosAlimentos.jsp" target="_self">
    <area shape="rect" coords="142,226,470,256" href="Menu_Precios_Alimentos.jsp">
  </map>
</div>
</body>
</html>
