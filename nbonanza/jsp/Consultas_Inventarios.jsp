<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Consultas de Clientes</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="left">
  <p align="center"><img src="imagenes/MenuConsultasInventarios.jpg" width="700" height="400" border="0" usemap="#Map">
    <map name="Map">
      <area shape="rect" coords="614,325,686,394" href="Menu_Inventarios.jsp" target="_self">
        <area shape="rect" coords="74,58,369,92" href="Selecciona_Producto_Inventario_Consulta.jsp" target="_self">
        <area shape="rect" coords="180,271,410,299" href="Escoge_Mes_Mermas.jsp" target="_self">
        <area shape="rect" coords="139,185,568,215" href="Productos_Maximo.jsp" target="_self">
        <area shape="rect" coords="157,229,599,260" href="Productos_Minimo.jsp" target="_self">
        <area shape="rect" coords="95,103,304,132" href="InventarioTodosConsulta.jsp" target="_self">
        <area shape="rect" coords="116,144,548,174" href="Inventario_Fisico_Todos.jsp" target="_self">
        <area shape="rect" coords="198,315,525,342" href="Escoge_Mes_ModificacionD.jsp" target="_self">
    </map>
</p>
  </p>
</div>
</body>
</html>
