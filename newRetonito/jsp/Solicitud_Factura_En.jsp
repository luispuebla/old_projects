<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" session = "true" %>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Captura de Ticket</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

function funcionFoco(){
	if(document.form1 != null){
		document.form1.ticket1.focus();
	}
}

//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); funcionFoco()" >
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 				
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String elRFC = request.getParameter("elRFC");
	String elNombre = request.getParameter("nombre");
	String laFechaHoy = ticket.dameFechaHoy();	
	if(elNombre == null){
%>
		<b class="roj">Debes Seleccionar un Nombre de la lista<br/></b>
		<form name="retache" action="Escoge_Cliente_Fac_En.jsp" target="_self" method="post">
			<input type="hidden" name="rfc" value="<%=elRFC%>">
			<p><input type="submit" name="Volver" value="Volver"></p>
		</form>
<%	
	} 	
	else{
%>
		<h1>Introduce el Ticket a Facturar:</h1>
		<form name="form1" method="post"  target="_self" action="Conf_Solicitud_Factura_En.jsp">
		<table width="600" border="1" align="center" cellspacing="0">
		  <tr>
			<th width="180">N&uacute;mero de Ticket: </th>
			<td width="113"> <div align="center"> <input type="text" name="ticket1" size="8" maxlength="7">  </div></td>
			<th width="125">Fecha ticket 1:</th>
			<td width="164"> <div align="center"> <input type=text name="fecha1" size=15 readonly="true" value="<%=laFechaHoy%>">  
			  <a href="javascript:show_calendar('form1.fecha1');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"> <img src="imagenes/show-calendar.gif" width=24 height=22 border=0 align="absmiddle"></a> </div></td>	
  		  </tr>
		</table>
<br />
		<table width="350" border="0" align="center">
		  <tr>
		    <td><div align="right"> <input type="reset" name="Borrar" value="Borrar"> </div> </td>
		    <td width="50">&nbsp;</td>
		    <td><div align="left"> <input type="submit" name="Submit" value="Enviar"> </div> </td>
		  </tr>
</table>
<input type="hidden" name="nombre" value="<%=elNombre%>"> 
<input type="hidden" name="rfc" value="<%=elRFC%>">
</form>
<%	
		}
%>
<p align="center"><a href="Existe_Cliente_Fac_En.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>