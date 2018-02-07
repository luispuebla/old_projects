<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Marcas</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuMarcas.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="66,106,308,140" href="Alta_Marca.jsp" target="_self">
    <area shape="rect" coords="167,235,458,268" href="Todas_Marcas.jsp">
    <area shape="rect" coords="627,323,685,394" href="Menu_Productos.jsp" target="_self">
    <area shape="rect" coords="118,172,461,209" href="Existe_Marca_Cambio.jsp" target="_self">
  </map>
</div>
</body>
</html>
