<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<title>Men&uacute; Contrase&ntilde;as y Texto</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--



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
<p align="center"><img src="imagenes/MenuContraYTexto.jpg" width="700" height="400" border="0" usemap="#Map"> </p>
<p align="right"> 
  <map name="Map">
    <area shape="rect" coords="130,118,522,153" href="Cambia_Pass_Precios.jsp" target="_self">
    <area shape="rect" coords="616,322,690,386" href="Menu_Ventas.jsp" target="_self">
    <area shape="rect" coords="174,214,583,248" href="Modifica_Aviso_Ticket.jsp" target="_self">
    <area shape="rect" coords="158,166,631,197" href="Cambia_Pass_Directa.jsp" target="_self">
  </map>
</p>
</body>
</html>
