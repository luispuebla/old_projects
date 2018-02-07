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
  <p align="center"><img src="imagenes/MenuPersonal.jpg" width="700" height="400" border="0" usemap="#Map"> </p>
  <p align="right">          
    <map name="Map">
      <area shape="rect" coords="94,63,330,96" href="Alta_Usuarios.jsp" target="_self">
      <area shape="rect" coords="149,165,388,201" href="Existe_Usuario_Baja.jsp" target="_self">
      <area shape="rect" coords="181,213,440,249" href="TodosUsuarios.jsp" target="_self">
      <area shape="rect" coords="616,319,692,389" href="Menu_Admon.jsp" target="_self">
              <area shape="rect" coords="127,112,459,146" href="Dame_ClaveUsuario.jsp" target="_self">
              <area shape="rect" coords="219,267,543,297" href="Menu_Prestamos_Nominas.jsp" target="_self">
    </map>
  </p>
</div>
</body>
</html>
