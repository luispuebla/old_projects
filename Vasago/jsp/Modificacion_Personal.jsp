<%@ page language="java" import="java.sql.*" %>

<html>
<head>
<title>Modificación del Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function funcionFoco(){
	document.form1.claveu.focus();
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="funcionFoco();MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<form name="form1" method="post" target="_self" action="Conf_Mod_Personal.jsp">
	<br />
	<h1>Modificación Datos del Personal.</h1>
  	Escriba la Clave Del Personal.
	<br />
<table width="419" border="1" align="center">
  <tr>
      <th width="196" bgcolor="#DFE1EC">Clave del Usuario:</th>
    <td width="213"><input name="claveu" type="text" maxlength="8"></td>
  </tr>
</table>
	<br />
<table width="217" border="0" align="center">
  <tr>
    <td width="219"><div align="center"> 
          <input type="reset" name="Submit2" value="Limpiar">
        </div></td>
    <td width="221"><div align="center">
          <input name="Submit" type="submit" value="Modificar">
        </div></td>
  </tr>
</table>
</form>

<div align="center"><a href="Menu_Personal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" alt="Menú del Personal" name="Regreso" width="152" height="36" border="0"></a> 
</div>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
