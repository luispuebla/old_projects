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
    <area shape="rect" coords="616,322,688,384" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="99,68,554,99" href="Selecciona_Producto_Inventario.jsp">
    <area shape="rect" coords="159,167,371,196" href="Selecciona_Producto_Mermas.jsp">
    <area shape="rect" coords="188,214,476,248" href="Consultas_Inventarios.jsp">
    <area shape="rect" coords="131,116,656,149" href="Modificacion_Inventario_Todos.jsp">
    <area shape="rect" coords="221,264,538,293" href="Tipo_Traslados_Inventario.jsp" target="_self">
  </map>
</div>
</body>
</html>
