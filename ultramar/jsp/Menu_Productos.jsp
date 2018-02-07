<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Productos</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuProductos.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="208,98,424,124" href="Menu_Materias_Primas.jsp" target="_self">
    <area shape="rect" coords="252,195,382,226" href="Menu_Bebidas.jsp" target="mainFrame">
    <area shape="rect" coords="231,146,398,175" href="Menu_Divisiones.jsp" target="_self">
<%	if(tipou.equalsIgnoreCase("admin")){%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Admon.jsp" target="_self">
<%	}
	else{%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Cashier.jsp" target="_self">
<%	}%>
    <area shape="rect" coords="267,246,439,275" href="Menu_Alimentos.jsp" target="_self">
  </map>
</div>
</body>
</html>
