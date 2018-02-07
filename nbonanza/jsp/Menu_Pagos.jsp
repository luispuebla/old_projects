<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Pagos</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuPagos.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="614,329,687,392" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="108,88,291,121" href="Escoge_Proveedor_Pago.jsp">
    <area shape="rect" coords="139,139,323,168" href="Escoge_Proveedor_Pago_Baja.jsp">
    <area shape="rect" coords="198,238,453,268" href="Consultas_Pagos.jsp">
    <area shape="rect" coords="169,188,446,218" href="#">
  </map>
</div>
</body>
</html>
