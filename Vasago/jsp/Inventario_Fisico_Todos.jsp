<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="inv" class="com.vas.bd.ManagerInventarios" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Inventario Físico</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

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

function MandaSubmit(f){
	document.form1.submit();
}
//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	ResultSet productos = inv.InventarioFisico();		
%>	
	<table width="680" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>INVENTARIO FÍSICO</caption>
	  <tr>
	  	<th width="75">Clave</th>
		<th width="334">Descripci&oacute;n Producto</th>
		<th width="67">Tipo<br/>Unidad</th>
		<th width="92">Cantidad<br />Venta</th>
		<th width="100">Cantidad<br />Obsequio</th>		
	  </tr>
	 <p></p>
<%
	while (productos.next()){
	String tipoP = "Cajas";
	if(productos.getInt("tipo") == 2){
		tipoP = "Kg.";
	}
%>
      <tr>
		<td><div align="center"><%=productos.getString("claveProducto")%></div></td>
		<td><%=productos.getString("descripcion")%></td>
		<td><div align="center"><%=tipoP%></div></td>
		<td><div align="center">&nbsp;</div></td>
		<td><div align="center">&nbsp;</div></td>
      </tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	inv.cierraConexion();		
%>	  	  
	</table>
<table width="742" align="center">
<td width="280">
<p align="right"><a href="Consultas_Inventarios.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="152" height="36" border="0" id="regresar1"></a></p>
</td>
<td width="186">                                                                   <font color="#FFFFFF">------------------</font></td>
<form name="form1" method="post" action="Imprimir_Inventario_Fisico.jsp" target="_blank">
<td width="260">
<font color="#FFFFFF"><img src="imagenes/Imprimir1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)"></font>
</td>
</form>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
