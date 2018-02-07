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
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<p align="center"><img src="imagenes/MenuCancelaciones.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="137,135,488,167" href="Fecha_Bajas.jsp" target="_self">
    <area shape="rect" coords="105,86,300,117" href="Existe_Baja_Ticket.jsp" target="_self">
    <area shape="rect" coords="615,324,687,393" href="Menu_Ventas.jsp" target="_self">
  </map></div>
</p>
<p align="right">&nbsp;</p>
</body>
</html>
