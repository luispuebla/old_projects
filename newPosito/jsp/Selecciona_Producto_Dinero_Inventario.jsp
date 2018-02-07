<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<html>
<head>
<title>Selecci&oacute;n de Producto Invenrsi&oacute;n en Inventario</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
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

function deshabilitaP (f){
	f.claveProducto.value = "";
	f.claveProducto.disabled = true;
}

function habilitaP (f){
	f.claveProducto.value = "";
	f.claveProducto.disabled = false;
	f.claveProducto.focus();
}


//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
  <h1>Selecciona el tipo de consulta, y en su caso especif&iacute;ca la clave del producto <br />
     para mostrar la inversi&oacute;n  en inventario<br />
de acuerdo a su precio base de venta actual:</h1>
  <form name="form1" method="post" action="InversionEnInventarioPV.jsp">
  <table align="center" border="1" width="450">
   <caption>Consulta por:</caption>
  	<tr>	
        <th width="30"><div align="center"> <input type="radio" name="tipoConsul" checked value="*" onClick="deshabilitaP(this.form)"></div></th>
		<th colspan="2"><div align="left"> Todos los Productos </div></th>
    </tr>
      <tr> 
        <th><div align="center"> <input type="radio" name="tipoConsul"  value="prod" onClick="habilitaP(this.form)"></div></th>
		<th width="274"><div align="left"> Espec&iacute;fico, Clave de Producto: </div></th>
		<td width="124"><div align="center"> <input type="text" name="claveProducto" size="8" disabled maxlength="6" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){document.form1.Submit.click();}">
	    </div></td>
	</tr>
  </table>
<p align="center">
    <input type="submit" name="Submit" value="Enviar">
</p>
</form>
<p align="center"><font color="#FFFFFF"><a href="Menu_Consul_Estadisticas.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></font></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
