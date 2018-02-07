<%@ page language="java" import="java.sql.*" %>

<html>
<head>
<title>Alta Línea</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
var valores_select_1 = new Array("Ventas");
var fila2 = new Array("Vendedor");
var valores_select_2 = new Array(fila1);
var numero = new Number();
numero = 0;

function funcionFoco(){
	document.form1.clave.focus();
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="funcionFoco();MM_preloadImages('imagenes/Regresar2.jpg')">
<form name="form1" method="post" target="_self" action="Conf_Alta_Linea.jsp">
<br/>
 <h1>Alta L&iacute;nea </h1>
   <div align="center">Se deben de llenar todos los campos.</div>
  <table align="center" border="1" width="405">
  <tr>
    <th width="87" bgcolor="#DFE1EC">Clave</th>
    <td width="297"><input name="clave" type="text" size="5" maxlength="3"> 
      3 letras, por ejemplo: Leche --&gt; LEC </td>
  </tr>
  <tr>
    <th bgcolor="#DFE1EC">Nombre</th>
    <td><input name="nombre" type="text" size="20" maxlength="20"> </td>
  </tr>		 
</table>
<p>
<table border="0" align="center" width="294">
  <tr>
    <td ><div align="center"> 
          <input type="reset" name="Submit2" value="Limpiar">
        </div></td>
    <td ><div align="center">
          <input name="Submit" type="submit" value="Guardar">
        </div></td>
  </tr>
</table>
</p>
  <p align="center"><a href="Menu_Lineas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" alt="Regresar" name="Regreso" width="152" height="36" border="0"></a>
    <br />
    <img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</form>
</body>
</html>
