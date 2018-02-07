<%@ page language="java" import="java.sql.*" session="true" errorPage="error.jsp" %> 
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (!usuario.equalsIgnoreCase("producto") || !tipo.equalsIgnoreCase("Simple"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%		
	}
%>
<html>
<head>
<title>Sistema Administrativo La Ultramarina</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

<frameset rows="140,*" cols="*" frameborder="NO" border="0" framespacing="0">
  <frame src="FrameTopAdminP.jsp" name="topFrame" scrolling="NO" noresize >
  <frame src="Menu_ProductosS.jsp" name="mainFrame">
</frameset>

<noframes><body background="/jsp/imagenes/FrameTop.jpg" tracingsrc="/jsp/imagenes/FrameTop.jpg" tracingopacity="100">

</body></noframes>
</html>

