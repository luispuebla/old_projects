<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" session = "true"%>

<html>
<head>
<title>Menu Inventarios</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--



function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
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
  <p align="center"><img src="imagenes/MenuPrestamoYNomina.jpg" width="700" height="400" border="0" usemap="#Map"> </p>
  <p align="right">          
    <map name="Map">
      <area shape="rect" coords="96,63,469,97" href="Selecciona_Vendedor_Prestamo.jsp" target="_self">
      <area shape="rect" coords="158,168,570,199" href="Selecciona_Semana_Prestamos.jsp" target="_self">
      <area shape="rect" coords="192,219,601,244" href="Selecciona_Semana_Prestamos_Cancelados.jsp" target="_self">
      <area shape="rect" coords="220,268,420,301" href="Selecciona_Semana_Pago_Nomina.jsp" target="_self">
      <area shape="rect" coords="613,320,689,390" href="Menu_Vendedores.jsp" target="_self">
              <area shape="rect" coords="132,117,574,149" href="Selecciona_Vendedor_Baja_Prestamo.jsp" target="_self">
  </map>
  </p>
</div>
</body>
</html>
