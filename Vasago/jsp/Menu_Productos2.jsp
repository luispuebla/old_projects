<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Productos</title>
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
<div align="center"><img src="imagenes/MenuProductos2.jpg" width="700" height="400" border="0" usemap="#Map">
  <map name="Map">
    <area shape="rect" coords="68,91,333,123" href="Alta_Productos.jsp" target="_self">
    <area shape="rect" coords="123,195,501,224" href="Existe_Producto_Cambio.jsp" target="mainFrame">
    <area shape="rect" coords="94,142,360,174" href="Existe_Producto_Baja.jsp" target="_self">
    <area shape="rect" coords="628,326,685,394" href="Menu_Productos.jsp" target="_self">
    <area shape="rect" coords="153,244,492,273" href="Consultas_Productos.jsp" target="_self">
    <area shape="rect" coords="183,296,485,325" href="Seleccion_Iva.jsp">
  </map>
</div>
</body>
</html>
