<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Compras</title>
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
<div align="center"><img src="imagenes/MenuRecepciones.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="615,329,685,390" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="104,84,345,118" href="Escoge_Proveedor_Orden_Factura.jsp" target="_self">
    <area shape="rect" coords="170,186,476,217" href="Escoge_Proveedor_Consulta_Recepcion.jsp" target="_self">
    <area shape="rect" coords="133,137,380,170" href="Escoge_Proveedor_Baja_Recepcion.jsp" target="_self">
    <area shape="rect" coords="194,235,564,269" href="Escoge_Proveedor_Ordenamiento_NoFac.jsp" target="_self">
  </map>
</div>
</body>
</html>
