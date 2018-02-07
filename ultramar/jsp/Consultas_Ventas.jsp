<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Consultas Compras</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F8F8F8;
}
-->
</style></head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<div align="center"><img src="imagenes/ConsultasVentas.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <br>  
  <map name="Map">
    <area shape="rect" coords="632,327,685,392" href="Menu_Ventas.jsp" target="_self">
    <area shape="rect" coords="115,176,615,211" href="Selecciona_LapsoTiempo5.jsp" target="_self">
    <area shape="rect" coords="99,127,445,158" href="Selecciona_LapsoTiempo4.jsp" target="_self">
    <area shape="rect" coords="137,228,512,253" href="Selecciona_LapsoTiempo6.jsp" target="_self">
    <area shape="rect" coords="161,277,303,310" href="Selecciona_LapsoTiempo7.jsp">
  </map>
</div>
</body>
</html>
