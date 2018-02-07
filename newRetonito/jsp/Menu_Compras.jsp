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
    <area shape="rect" coords="617,323,687,384" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="89,67,303,95" href="Alta_Compra.jsp">
    <area shape="rect" coords="126,117,334,146" href="Escoge_Proveedor_Orden_Baja.jsp">
    <area shape="rect" coords="145,165,452,197" href="Escoge_Proveedor_Orden_Cambio.jsp">
    <area shape="rect" coords="186,217,495,246" href="Menu_Recepciones.jsp" target="_self">
    <area shape="rect" coords="245,316,524,346" href="Consultas_Compras.jsp">
    <area shape="rect" coords="209,265,456,298" href="Menu_Pagos.jsp">
  </map>
</div>
</body>
</html>
