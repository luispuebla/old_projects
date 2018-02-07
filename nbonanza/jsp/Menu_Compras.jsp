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
<div align="center"><img src="imagenes/MenuCompras.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="615,329,685,390" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="72,57,286,85" href="Alta_Compra.jsp">
    <area shape="rect" coords="107,107,315,136" href="Escoge_Proveedor_Orden_Baja.jsp">
    <area shape="rect" coords="130,155,437,187" href="Escoge_Proveedor_Orden_Cambio.jsp">
    <area shape="rect" coords="160,208,469,237" href="Menu_Recepciones.jsp" target="_self">
    <area shape="rect" coords="221,307,500,337" href="Consultas_Compras.jsp">
    <area shape="rect" coords="191,255,438,288" href="Menu_Pagos.jsp">
  </map>
</div>
</body>
</html>
