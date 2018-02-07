<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />

<html>
<head>
<title>Existencia de un Ticket</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function funcionFoco(){
	document.form1.ticket1.focus();
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body onLoad="funcionFoco(), MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	} 
	String laFechaHoy = credito.dameFechaHoy();	
	String elRFC = request.getParameter("rfc");
	String clienteNombre = request.getParameter("nombre");
%>
<h1>Introduce el n&uacute;mero de el/los Ticket(s) a cr&eacute;dito:</h1>
<form name="form1" method="post" action="Esperando_TicketCredito.jsp">
 <input type="hidden" name="rfc" value="<%=elRFC %>">
 <input type="hidden" name="cliente" value="<%=clienteNombre %>">
 <table width="400" border="1" align="center" cellspacing="0">
  <tr>
	<th width="46%" bgcolor="#CCCCCC">Fecha: </th>
	<td width="54%" height="39"><div align="center">
	  <input type=text name="fecha" size=15 readonly="true" value="<%=laFechaHoy%>"> 
	    <a href="javascript:show_calendar('form1.fecha');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"> <img src="imagenes/show-calendar.gif" width=24 height=22 border=0 align="absmiddle"></a> 
        </div>
	  </div></td>
  </tr>
  <tr> 
	<th>N&uacute;mero de Ticket 1:</th>
	<td height="43"><div align="center">
	  <input type="text" name="ticket1" size="8" maxlength="7">
	  </div></td>
  </tr>
  <tr> 
	<th>N&uacute;mero de Ticket 2: </th>
	<td height="43"><div align="center">
	  <input type="text" name="ticket2" size="8" maxlength="7">
	  </div></td>
  </tr>  
  <tr> 
	<th>N&uacute;mero de Ticket 3: </th>
	<td height="43"><div align="center">
	  <input type="text" name="ticket3" size="8" maxlength="7">
	  </div></td>
  </tr>
  <tr> 
	<th>N&uacute;mero de Ticket 4: </th>
	<td height="43"><div align="center">
	  <input type="text" name="ticket4" size="8" maxlength="7">
	  </div></td>
  </tr>
  <tr> 
	<th>N&uacute;mero de Ticket 5: </th>
	<td height="43"><div align="center">
	  <input type="text" name="ticket5" size="8" maxlength="7">
	  </div></td>
  </tr>
</table>
<br />
<table width="450" border="0" align="center">
  <tr>
    <td width="190"><div align="right"><input type="reset" name="Borrar" value="Borrar"></div></td>
    <td width="52"></td>
    <td width="194"><div align="left"><input type="submit" name="Submit" value="Enviar"> </div></td>
  </tr>
</table>
</form>
<p align="center"><a href="Menu_Credito.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('RetacheI','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="RetacheI" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
