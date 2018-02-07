<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<html>
<head>
<title>Cambio de Password</title>
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
	document.form1.usuario.focus();
}
//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco()">
<form name="form1" method="post" action="Cambia_PassJ.jsp">
<h1>Completa los siguientes datos para modificar la contraseña:</h1>
<table width="400" border="0">
  <tr>
	<th width="264">Usuario:</th>
	<td width="126"> <input type="text" name="usuario" size="20" maxlength="12"></td>
  </tr>
  <tr> 
	<th>Escribe tu contrase&ntilde;a actual:</th>
	<td><input type="password" name="pass1" size="20" maxlength="12"></td>
  </tr>
  <tr> 
	<th>Escribe tu nueva contrase&ntilde;a:</th>
	<td> <input type="password" name="pass2" size="20" maxlength="12"> </td>
  </tr>
  <tr> 
	<th>Confirma tu nueva contrase&ntilde;a:</th>
	<td> <input type="password" name="pass3" size="20" maxlength="12"> </td>
  </tr>
</table>
<p align="center">
<input type="reset" name="Borrar" value="Borrar">  
<input type="submit" name="Submit" value="Enviar">
</p>
</form>		
<p align="center"><a href="Login.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

