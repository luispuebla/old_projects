<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Inventario Todos</title>
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

function seleccionaTodo(objeto){
	objeto.select();
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function OnSubmitForm(){
	var docAval = new String();	
	docAval = form1.causa.value;
	re = / /gi;
	docAval = docAval.replace(re,"");
	if(docAval == ''){
		alert("Debes especificar una causa para este/estos cambio(s).");
		form1.causa.focus();
		return false;
	}
	else{
		document.form1.action ="Conf_Cambio_Inventario.jsp";		
		return true;
	}
}

function setFocus(){
	if(document.form1 != null){
		document.form1.causa.focus();		
	}
}

//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg');setFocus()">
<%
	ResultSet productos = inv.dameProductos();		
%>	
<h1>Modifica la cantidad de el/los producto(s) en Inventario</h1>
<form name="form1" method="post" onSubmit="return OnSubmitForm();">
	<table width="750" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>INVENTARIO TOTAL</caption>
	<tr>
	  <th><br /><div align="center">Causa:</div><br /></th>
	  <td colspan="5"><div align="center"><br /><input type="text" name="causa" maxlength="80" size="100"><br /><br/></div></td>	
	</tr>	
	  <tr>
	  	<th width="59">Clave</th>
		<th width="277">Nombre Producto</th>
		<th width="100">Cantidad Original Almac&eacute;n</th>
		<th width="100">Cantidad Nueva Almac&eacute;n</th>
		<th width="100">Cantidad Original Tienda</th>
		<th width="100">Cantidad Nueva Tienda</th>
	  </tr>
	 <p></p>
<%
	while (productos.next()){
		String cantidadProductoT = productos.getInt("invTienda")+"";
		String cantidadProductoA = productos.getInt("invAlmacen")+"";
		String tipoP = "Uni.";		
		if(productos.getInt("tipoPro") == 1){
			tipoP = "Kg.";
			cantidadProductoT = productos.getDouble("invTienda")+"";
			cantidadProductoA = productos.getDouble("invAlmacen")+"";			
		}
%>
      <tr>
		<td><div align="center"><%=productos.getInt("ID_Pro")%></div></td>
		<input name="clave" type="hidden" value="<%=productos.getString("ID_Pro")%>">
 		<td><%=productos.getString("descripcion")%></td>
		<td><div align="center"><%=cantidadProductoA%> <%=tipoP%></div></td>
		<input name="invAlmacen" type="hidden" value="<%=cantidadProductoA%>">
		<td><div align="left">
	      <input name="nuevaA" type="text" value="<%=cantidadProductoA%>" size="7" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="
	<% if(tipoP.equals("Kg.")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" > 
	      <%=tipoP%></div></td>
		<td><div align="center"><%=cantidadProductoT%> <%=tipoP%></div></td>
		<input name="invTienda" type="hidden" value="<%=cantidadProductoT%>">
		<td><div align="left">
	      <input name="nuevaT" type="text" value="<%=cantidadProductoT%>" size="7" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="
	<% if(tipoP.equals("Kg.")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" > 
	      <%=tipoP%></div></td>		  
     </tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	inv.cierraConexion();		
%>	  	  
</table>
  <p> 
    <input type="submit" name="Submit" value="Guardar">
 </p>

</form>
<p align="center"><a href="Menu_Inventarios.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"  onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
