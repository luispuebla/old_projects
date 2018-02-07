<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Clientes</title>
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
<div align="center"><img src="imagenes/MenuClientes.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="68,93,313,126" href="Alta_Clientes.jsp" target="_self">
    <area shape="rect" coords="123,193,481,222" href="Existe_Cliente_Cambio.jsp" target="_self">
    <area shape="rect" coords="93,142,340,176" href="Existe_Cliente_Baja.jsp" target="mainFrame">
    <area shape="rect" coords="152,241,475,275" href="Consultas_Clientes.jsp" target="_self">
    <area shape="rect" coords="621,322,686,396" href="Menu_Admon.jsp" target="_self">
  </map>
</div>
</body>
</html>
