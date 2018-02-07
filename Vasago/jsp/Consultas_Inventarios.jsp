<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Consultas de Clientes</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

//-->
</script>
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
<div align="left">
  <p align="center"><img src="imagenes/ConsultasInventarios.jpg" width="700" height="400" border="0" usemap="#Map">
    <map name="Map">
      <area shape="rect" coords="619,325,686,394" href="Menu_Inventarios.jsp" target="_self">
        <area shape="rect" coords="25,70,365,102" href="Existe_Producto_Inventario_Consulta.jsp">
        <area shape="rect" coords="174,321,420,351" href="Escoge_Mes_Mermas.jsp">
        <area shape="rect" coords="110,219,672,251" href="Productos_Maximo.jsp">
        <area shape="rect" coords="140,270,691,302" href="Productos_Minimo.jsp">
        <area shape="rect" coords="50,120,295,149" href="InventarioTodosConsulta.jsp">
        <area shape="rect" coords="83,172,567,198" href="Inventario_Fisico_Todos.jsp">
    </map>
</p>
  </p>
</div>
</body>
</html>
