<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />

<html>
<head>
<title>Confirmacion Orden de Trabajo</title>
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
<body>
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
	String clave =  request.getParameter("clave"); 
	String observaciones =  request.getParameter("observaciones"); 
	String[] ArrayProducto = request.getParameterValues("claveProducto");
	String[] ArrayCantidad = request.getParameterValues("real");	
	String[] ArrayDescripcion = request.getParameterValues("descripcion");	
	String fecha = request.getParameter("datebox");
	String[] ArrayCantidadMP = request.getParameterValues("cantidadMP");	
	String[] ArrayProductoMP = request.getParameterValues("productoMP");	
	String[] ArrayTipoUMP = request.getParameterValues("tipoMP");	
	int registro= alProd.realizaConfirmacion(clave, ArrayProducto, ArrayCantidad, ArrayCantidadMP, ArrayProductoMP, ArrayTipoUMP,  fecha, observaciones, usuario);
	if(registro == 0){%>
					<jsp:forward page="Menu_Ordenes_Trabajo.jsp" />  
<% 	} else if(registro == 2){ %>
		<b class="roj">Ocurrio un error con la Base de Datos, vuelva a intentarlo.</b>		
<% 	} else if(registro == 1){%>
	<form name="retachin" method="post" target="_self" action="Dame_Materia_Prima_OT.jsp">
	<b class="roj">Al menos un producto de Materia Prima sobre pasa la existencia, de click a Reingresar para corregirlo.</b>
	<input type="hidden" name="interino" value="">	
	<input type="hidden" name="clave" value="<%=clave%>">
	<input type="hidden" name="observaciones" value="<%=observaciones%>">
	<input type="hidden" name="datebox" value="<%=fecha%>">
<%	for(int m = 0; m<ArrayProducto.length; m++){ %>
	<input type="hidden" name="claveProducto" value="<%=ArrayProducto[m]%>">
	<input type="hidden" name="descripcion" value="<%=ArrayDescripcion[m]%>">
	<input type="hidden" name="real" value="<%=ArrayCantidad[m]%>">		
<%	} %>	
<% 	for (int i=0; i<ArrayCantidadMP.length; i++){ %>	
	<input type="hidden" name="cantidadMP" value="<%=ArrayCantidadMP[i]%>">
	<input type="hidden" name="productoMP" value="<%=ArrayProductoMP[i]%>">
	<input type="hidden" name="tipoMP" value="<%=ArrayTipoUMP[i]%>">
<% } %>		
	<p><input type="submit" name="Submit" value="Reingresar"></p>
	</form>
<%	}%>
</p>
<p align="center"><a href="Menu_Ordenes_Trabajo.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	