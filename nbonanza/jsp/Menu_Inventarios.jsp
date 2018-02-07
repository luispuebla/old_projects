<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Inventarios</title>
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
<div align="center"><img src="imagenes/MenuInventarios.jpg" width="700" height="400" border="0" usemap="#Map">  
  <map name="Map">
    <area shape="rect" coords="616,329,688,391" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="108,86,563,117" href="Selecciona_Producto_Inventario.jsp">
    <area shape="rect" coords="164,188,376,217" href="Selecciona_Producto_Mermas.jsp">
    <area shape="rect" coords="197,236,485,270" href="Consultas_Inventarios.jsp">
    <area shape="rect" coords="137,133,662,166" href="Modificacion_Inventario_Todos.jsp">
    <area shape="rect" coords="230,287,547,316" href="Tipo_Traslados_Inventario.jsp" target="_self">
  </map>
</div>
</body>
</html>
