<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %> 
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
	String tipoE = (String) session.getAttribute("TipoEmpleo");
	if (usuario == null || !tipoE.equalsIgnoreCase("facturador"))  {
%>	

		<jsp:forward page="RedirectAcceso2.html" />
<%		
	}
%>	
<html>
<head>
<title>Sistema Administrativo El Posito</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

<frameset rows="133,*" cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="FrameTopF.jsp" name="topFrame" scrolling="NO" noresize >
  <frame src="Menu_Cajero.jsp" name="mainFrame">
</frameset>
<noframes><body background="imagenes/TopFac.jpg" tracingsrc="imagenes/TopFac.jpg" tracingopacity="100">
</body></noframes>
</html>
