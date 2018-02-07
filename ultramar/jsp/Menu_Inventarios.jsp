<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Inventarios</title>
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
<div align="center"><img src="imagenes/MenuInventarios.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="628,328,684,393" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="120,175,626,206" href="Existe_Producto_Inventario.jsp">
    <area shape="rect" coords="81,73,310,101" href="Existe_Producto_Mermas.jsp">
    <area shape="rect" coords="163,280,465,304" href="Consultas_Inventarios.jsp">
    <area shape="rect" coords="140,226,473,257" href="Selecciona_Producto_Traspasos.jsp">
    <area shape="rect" coords="100,127,691,152" href="Existe_Producto_Area.jsp">
  </map>
</div>
</body>
</html>
