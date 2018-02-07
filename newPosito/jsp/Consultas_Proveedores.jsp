<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Men&uacute; Consultas de Proveedores</title>
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
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<body>
<div align="left">
  <p align="center"><img src="imagenes/MenuConsultaProveedores.jpg" width="700" height="400" border="0" usemap="#Map">   
    <map name="Map">
      <area shape="rect" coords="150,163,470,199" href="Existe_Proveedor_Compras.jsp" target="mainFrame">
      <area shape="rect" coords="617,323,684,392" href="Menu_Proveedores.jsp" target="_self">
      <area shape="rect" coords="123,116,424,150" href="Todos_Proveedores.jsp" target="mainFrame">
    </map>
  </p></p>
</div>
</body>
</html>
