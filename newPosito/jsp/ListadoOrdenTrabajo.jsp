<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Obtenci&oacute;n Productos y Datos</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){
	document.RegN.submit();
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

function setFocus(){
	if(document.search1 != null){
		document.search1.string.focus();
	}
}

function deSelecciona(objeto){
	objeto.checked=false;
	var cBoxes = objeto;
	for(var i=0; i<cBoxes.length; ++i){
		cBoxes[i].checked = false;
	}	
}

//-->
</script>
</head>
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
	String queryString = request.getQueryString();
	String[] ArrayCantidad = null;
	String[] ArrayProducto = null;
	if((String[])request.getParameterValues("producto") != null){
		ArrayCantidad = (String[])request.getParameterValues("cantidad");
		ArrayProducto = (String[])request.getParameterValues("producto");
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); setFocus()">
<form name="formaR" method="post" target="_self" action="Alta_Orden_Trabajo.jsp">
	<input type="hidden" name="interino" value="">	
<% 	
	if(ArrayProducto!=null){
		for (int i=0; i<ArrayProducto.length; i++){ 
%>	
	<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
<%	 	} 
	}
	ResultSet productos = alProd.todosLosProductosCortes();				
%>	
	<table width="820" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>
	Seleccione el/los producto(s) Reto&ntilde;o a Producir.
	</caption>
	  <tr>
		<th width="110">Seleccione</th>	  
	  	<th width="93">Clave</th>
		<th width="529">Nombre</th>
	  </tr>
	 <p></p>
<%
	int consecutivo = 0;
	while (productos.next()){
		consecutivo++;
%>
	<tr>
		<td><div align="center">
		  <input type="radio" name="rg<%=consecutivo%>" value="<%=productos.getString("ID_Pro")%>">
		  <input type="button" value="Cancelar" name="Cancelar" onClick="deSelecciona(rg<%=consecutivo%>)">
		  </div></td>	
		<td><div align="center"><%=productos.getString("ID_Pro")%></div></td>
		<td><%=productos.getString("descripcion")%></td>				
	</tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	alProd.cierraConexion();		// de ResultSet Complex	
						
%>	  	  
	</table>
	<input type="hidden"  name="consecutivo" value="<%=consecutivo+""%>">   
	<p><input type="submit" name="Enviar" value="Enviar"></p>
</form>
<br />
<form method="post" target="_self" name="RegN" action="Alta_Orden_Trabajo.jsp"> 
	<input type="hidden" name="modificador" value="">
<% 	for (int i=0; i<ArrayCantidad.length; i++){ %>	
	<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
<% } %>	
	<a onClick="MandaSubmit()" onMouseOver="MM_swapImage('RegresoN','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="RegresoN" width="132" height="41" border="0"></a>
</form>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
