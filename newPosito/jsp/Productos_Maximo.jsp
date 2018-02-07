<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />

<html>
<head>
<title>Productos con el M&aacute;ximo</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script>

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
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	ResultSet maximo = inv.dame_Maximo();
%>
<p>
<table width="750" border="1" cellpadding="0" cellspacing="0">
<caption>Productos con Existencia igual o mayor al M&aacute;ximo especificado.</caption>
  <tr valign="middle"> 
    <th width="65" rowspan="2">Clave</th>
    <th width="280" rowspan="2">Producto</th>
    <th width="70" rowspan="2">Tipo</th>
    <th width="85" rowspan="2">M&aacute;ximo</th>
	<th colspan="3">Inventario</th>
  </tr>
  <tr>
  	<th width="75">Almac&eacute;n</th>
	<th width="75">Tienda</th>
	<th width="84">Total</th>
  </tr>
<% 
		while (maximo.next()){
		String tipoP = "Unidades";
		String invTienda = maximo.getInt("invTienda")+"";
		String invAlmacen = maximo.getInt("invAlmacen")+"";
		String inventario = maximo.getInt("inventario")+"";
		String elMaximo = maximo.getInt("maxInv")+"";
		if (maximo.getInt("tipoPro") == 1){
			tipoP = "Kg.";
			invTienda = maximo.getDouble("invTienda")+"";
			invAlmacen = maximo.getDouble("invAlmacen")+"";
			inventario = maximo.getDouble("inventario")+"";
			elMaximo = maximo.getDouble("maxInv")+"";			
		}
%>
  <tr> 
    <td><div align="center"><%=maximo.getString("ID_Pro")%></div></td>
    <td><div align="center"><%=maximo.getString("descripcion")%></div></td>
    <td><div align="center"><%=tipoP%></div></td>
    <td><b><div align="center"><%=elMaximo%></div></b></td>	
	<td><div align="center"><%=invTienda%></div></td>
	<td><div align="center"><%=invAlmacen%></div></td>
	<td><b><div align="center"><%=inventario%></div></b></td>
  </tr>
<%
		}
		if(maximo != null){
			maximo.close();
		}
		inv.cierraConexion();
		// de ResultSet Complex
%>
</table>
<p align="center"><a href="Consultas_Inventarios.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
