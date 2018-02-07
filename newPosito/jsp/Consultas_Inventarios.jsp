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
      <area shape="rect" coords="615,318,687,387" href="Menu_Inventarios.jsp" target="_self">
        <area shape="rect" coords="99,65,394,99" href="Selecciona_Producto_Inventario_Consulta.jsp" target="_self">
        <area shape="rect" coords="198,268,428,296" href="Escoge_Mes_Mermas.jsp" target="_self">
        <area shape="rect" coords="158,186,636,217" href="Productos_Maximo.jsp" target="_self">
        <area shape="rect" coords="183,227,625,258" href="Productos_Minimo.jsp" target="_self">
        <area shape="rect" coords="117,109,326,138" href="InventarioTodosConsulta.jsp" target="_self">
        <area shape="rect" coords="134,146,566,176" href="Inventario_Fisico_Todos.jsp" target="_self">
        <area shape="rect" coords="215,308,542,335" href="Escoge_Mes_ModificacionD.jsp" target="_self">
    </map>
</p>
  </p>
</div>
</body>
</html>
