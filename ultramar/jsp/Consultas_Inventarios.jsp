<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Consultas de Clientes</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
        <area shape="rect" coords="115,104,455,136" href="Existe_Producto_Inventario_Consulta.jsp">
        <area shape="rect" coords="178,257,424,287" href="Escoge_Mes_Mermas.jsp">
      <area shape="rect" coords="135,157,380,186" href="Existe_Producto_Area_Consulta.jsp">
        <area shape="rect" coords="155,207,639,233" href="Existe_Producto_Area_Levantamiento.jsp">
      <area shape="rect" coords="202,307,517,338" href="Selecciona_LapsoTiempo3.jsp">
    </map>
</p>
  </p>
</div>
</body>
</html>
