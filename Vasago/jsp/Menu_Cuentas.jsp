<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Cuentas</title>
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
<div align="center"><img src="imagenes/MenuCuentas.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="69,106,299,135" href="Alta_Bancos.jsp" target="_self">
    <area shape="rect" coords="119,174,460,203" href="Existe_Banco_Cambio.jsp" target="mainFrame">
    <area shape="rect" coords="618,326,693,394" href="Menu_Bancos.jsp" target="_self">
    <area shape="rect" coords="170,235,469,265" href="Todos_Bancos.jsp" target="_self">
  </map>
</div>
</body>
</html>
