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
    <area shape="rect" coords="65,93,321,126" href="Alta_Personal.jsp" target="_self">
    <area shape="rect" coords="121,191,485,224" href="Modificacion_Personal.jsp" target="_self">
    <area shape="rect" coords="94,140,346,177" href="Baja_Personal.jsp" target="_self">
    <area shape="rect" coords="154,242,473,276" href="ConsultaPersonal.jsp" target="_self">
    <area shape="rect" coords="616,326,688,394" href="Menu_Admon.jsp" target="_self">
  </map>
</div>
</body>
</html>
