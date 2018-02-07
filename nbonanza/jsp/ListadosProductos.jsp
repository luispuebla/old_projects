<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>

<html>
<head>
<title>Menu Productos</title>
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
//-->
</script>
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
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<h1>Escoge el tipo de listado que deseas  Imprimir:</h1>
<table align="center" border="1" width="650" cellpadding="0" cellspacing="0">
  <tr>
  	<th width="263" bgcolor="#CCCCCC">Productos:</th>
	<form name="listado" target="_blank" method="post" action="Listado_Producto.jsp">
	<td width="189">
	  <table align="center" width="100%" cellpadding="0" cellspacing="0">
		<caption valign="top">Ordenar por:</caption>
		  <tr valign="top">
		  	<td><div align="center"> <input type="radio" name="ordenamiento" value="1"></div></td>
			<td><div align="left">Nombre</div></td>	
		</tr>		
		<tr valign="top">
			<td><div align="center"><input type="radio" name="ordenamiento" value="2"></div></td>
			<td><div align="left">Clave</div></td>
		</tr>		
		<tr valign="top">
			<td><div align="center"><input type="radio" name="ordenamiento" value="3" checked></div></td>
			<td><div align="left">Nombre y G&eacute;nero</div></td>	
		</tr>		
		<tr valign="top">
			<td><div align="center"> <input type="radio" name="ordenamiento" value="4"> </div></td>
			<td><div align="left">Clave y G&eacute;nero</div></td>			
		</tr>		
	  </table>
	</td>
    <td width="190">
	  <table align="center" width="100%" cellpadding="0" cellspacing="0">
		<caption valign="top">Incluir:</caption>
		  <tr valign="top">
		  	<td><div align="center"> <input type="radio" name="impresion" value="1"> </div></td>
			<td><div align="left">Costos</div></td>	
		</tr>		
		<tr>
			<td><div align="center"><input type="radio" name="impresion"  value="2" checked></div></td>
			<td><div align="left">Precios</div></td>
		</tr>		
		<tr>
			<td><div align="center"><input type="radio" name="impresion"  value="3"></div></td>
			<td><div align="left">Espacios en Blanco</div></td>	
		</tr>		
		<tr>
			<td><div align="center"><input type="radio" name="impresion" value="4"></div></td>
			<td><div align="left">Cantidad en Inventario</div></td>	
		</tr>		
		<tr>
			<td colspan="2"><div align="center"><input type="submit" name="Imprimir" value="Imprimir"></div></td>
		</tr>
	  </table>
	</td>
	</form>	
  </tr>
  <tr>
  	<th >Listados de Productos con C&oacute;digos de Barra</th>
	<form name="listado4" method="post" action="Listado_Por_Codigos.jsp" target="blank" >	
	<td width="189">
	  <table align="center" width="100%" cellpadding="0" cellspacing="0">
		<caption valign="top">Ordenar por:</caption>
		  <tr valign="top">
		  	<td><div align="center"> <input type="radio" name="ordenamiento" value="1"></div></td>
			<td><div align="left">Nombre</div></td>	
		</tr>		
		<tr valign="top">
			<td><div align="center"><input type="radio" name="ordenamiento" value="2"></div></td>
			<td><div align="left">Clave</div></td>
		</tr>		
		<tr valign="top">
			<td><div align="center"><input type="radio" name="ordenamiento" value="3" checked></div></td>
			<td><div align="left">Nombre y G&eacute;nero</div></td>	
		</tr>		
		<tr valign="top">
			<td><div align="center"> <input type="radio" name="ordenamiento" value="4"> </div></td>
			<td><div align="left">Clave y G&eacute;nero</div></td>			
		</tr>		
	  </table>
	</td>	
	<td>
		  <div align="center">
		    <input type="submit" value="Imprimir" name="Imprimir">
	        </div></td>	
	</form>	
  </tr>  
</table>
<p><a href="Menu_Productos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
