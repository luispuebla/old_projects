<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<title>Menu Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuPersonal.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="76,76,321,105" href="Alta_Personal.jsp" target="_self">
    <area shape="rect" coords="120,179,481,206" href="Modificacion_Personal.jsp" target="_self">
    <area shape="rect" coords="101,129,339,159" href="Baja_Personal.jsp" target="_self">
    <area shape="rect" coords="140,227,408,257" href="ConsultaPersonal.jsp" target="_self">
    <area shape="rect" coords="616,326,688,394" href="Menu_Admon.jsp" target="_self">
    <area shape="rect" coords="161,280,423,304" href="Selecciona_Empleado_Fecha.jsp" target="_self">
  </map>
</div>
</body>
</html>
