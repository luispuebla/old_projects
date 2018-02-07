<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<html>
<head>
<title>Cambio de Contrase&ntilde;a Ventas</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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
	document.form1.pass1.focus();
}
//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco()">
<%
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String pass1 = "";
	String pass2 = "";
	String pass3 = "";
	if(request.getParameter("interno") != null){
		pass1 = request.getParameter("pass1");
		pass2 = request.getParameter("pass2");
		pass3 = request.getParameter("pass3");				
	}
%>
<h1>Cambio de Contraseña Asignaci&oacute;n Precio Directo </h1>
<form name="form1" method="post" action="Cambia_Pass_DirectaJ.jsp">
<table width="500" border="1" align="center">
  <tr> 
	<th>Escribe la clave de autorizaci&oacute;n  anterior:</th>
	<td><div align="center">
	  <input type="password" name="pass1" size="20" maxlength="4" value="<%=pass1%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
	  </div></td>
  </tr>
  <tr> 
	<th>Escribe la nueva clave de autorizaci&oacute;n</th>
	<td><div align="center">
	  <input type="password" name="pass2" size="20" maxlength="4" value="<%=pass2%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
	  </div></td>
  </tr>
  <tr> 
	<th>Confirma la nueva clave:</th>
	<td> <div align="center">
	  <input type="password" name="pass3" size="20" maxlength="4" value="<%=pass3%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> 
	  </div></td>
  </tr>
</table>
<p>
	<input type="reset" name="Borrar" value="Borrar">
	<input type="submit" name="Submit" value="Enviar">
</p>
</form>
<p align="center"><a href="Menu_Contras_Texto.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

