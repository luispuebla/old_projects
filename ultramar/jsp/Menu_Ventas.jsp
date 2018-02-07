<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Ventas</title>
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
<div align="center"><img src="imagenes/MenuVentas.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="119,108,245,136" href="Menu_Cobros.jsp" target="_self">
    <area shape="rect" coords="173,187,391,218" href="Cortes_Caja.jsp" target="_self">
    <area shape="rect" coords="144,149,294,174" href="Dame_Mesa_Cortesia.jsp" target="mainFrame">
    <area shape="rect" coords="200,228,451,257" href="Consultas_Ventas.jsp" target="_self">
    <area shape="rect" coords="621,322,686,396" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="232,269,553,292" href="Dame_Mesa_Baja_Producto.jsp">
    <area shape="rect" coords="260,304,438,337" href="Dame_Mesa_Descuento.jsp" target="_self">
    <area shape="rect" coords="96,64,277,94" href="Menu_Facturas.jsp">
  </map>
</div>
</body>
</html>
