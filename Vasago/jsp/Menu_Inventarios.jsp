<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Inventarios</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
    <area shape="rect" coords="68,108,574,139" href="Existe_Producto_Inventario.jsp">
    <area shape="rect" coords="108,205,337,233" href="Existe_Producto_Mermas.jsp">
    <area shape="rect" coords="169,309,471,332" href="Consultas_Inventarios.jsp">
    <area shape="rect" coords="138,258,471,289" href="Tipo_Traslados_Inventario.jsp">
    <area shape="rect" coords="89,158,680,183" href="Modificacion_Inventario_Todos.jsp">
  </map>
</div>
</body>
</html>
