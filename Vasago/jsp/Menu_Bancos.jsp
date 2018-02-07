<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Bancos</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
<div align="center"><img src="imagenes/MenuBancos.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="206,99,358,128" href="Menu_Cuentas.jsp" target="_self">
    <area shape="rect" coords="618,326,693,394" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="234,148,386,179" href="Menu_Ingresos.jsp">
    <area shape="rect" coords="263,200,391,223" href="Menu_Gastos.jsp">
    <area shape="rect" coords="295,248,446,276" href="Selecciona_Banco_Balance.jsp">
    <area shape="rect" coords="337,299,502,329" href="Traspaso.jsp">
  </map>
</div>
</body>
</html>
