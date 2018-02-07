<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Cortes Caja</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
<div align="center"><img src="imagenes/CortesCaja.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="98,129,433,158" href="Fecha_Corte_Caja.jsp" target="_self">
    <area shape="rect" coords="120,175,489,209" href="Fecha_Corte_Caja_S.jsp" target="mainFrame">
    <area shape="rect" coords="621,326,696,394" href="Menu_Ventas.jsp" target="_self">
  </map>
</div>
</body>
</html>
