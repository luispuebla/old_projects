<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

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

<!-- Begin
var NS4 = (document.layers);
var IE4 = (document.all);

var win = this;
var n   = 0;

function findInPage(str) {
var txt, i, found;
if (str == "")
return false;
if (NS4) {
if (!win.find(str))
while(win.find(str, false, true))
n++;
else
n++;
if (n == 0) alert(str + " no se encuentran coincidencias en esta pagina.");
}
if (IE4) {
txt = win.document.body.createTextRange();
for (i = 0; i <= n && (found = txt.findText(str)) != false; i++) {
txt.moveStart("character", 1);
txt.moveEnd("textedit");
}
if (found) {
txt.moveStart("character", -1);
txt.findText(str);
txt.select();
txt.scrollIntoView();
n++;
}
else {
if (n > 0) {
n = 0;
findInPage(str);
}
else
alert(str + " no se encuentran coincidencias en esta pagina.");
}
}
return false;
}

function deSelecciona(objeto){
	objeto.checked=false;
	var cBoxes = objeto;
	for(var i=0; i<cBoxes.length; ++i){
		cBoxes[i].checked = false;
	}	
}
//  End -->
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
	String proveedorC = "";
	String[] ArrayCantidad = null;
	String[] ArrayProducto = null;
	String[] ArrayCUnidad = null;
	String[] ArrayImporte = null;
	String[] ArrayTipo = null;	
	String[] ArrayCambio = null;	
	proveedorC = request.getParameter("proveedorC");
	ArrayCantidad = (String[])request.getParameterValues("cantidad");
	ArrayProducto = (String[])request.getParameterValues("producto");
	ArrayTipo = (String[])request.getParameterValues("tipo");		
	ArrayCambio = (String[])request.getParameterValues("cambio");		
	ArrayCUnidad = (String[])request.getParameterValues("unidad");
	ArrayImporte = (String[])request.getParameterValues("importe");
	String prodRegalo1 = request.getParameter("prodRegalo1");
	String prodRegalo2 = request.getParameter("prodRegalo2");
	String prodRegalo3 = request.getParameter("prodRegalo3");
	String tipoUniRegalo1 = request.getParameter("tipoUniRegalo1");
	String tipoUniRegalo2 = request.getParameter("tipoUniRegalo2");
	String tipoUniRegalo3 = request.getParameter("tipoUniRegalo3");
	String cantidadRegalo1 = request.getParameter("cantidadRegalo1");
	String cantidadRegalo2 = request.getParameter("cantidadRegalo2");
	String cantidadRegalo3 = request.getParameter("cantidadRegalo3");
%>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); setFocus()">
<form name="search1" onSubmit="return findInPage(this.string.value);">
Buscar en la pagina:
<input name="string" type="text" size="20" onChange="n = 0;">
<input type="Submit" value="buscar">
</form>
<form name="formaR" method="post" target="_self" action="Alta_Compra.jsp">
	<input type="hidden" name="interino" value="">	
	<input type="hidden" name="prodRegalo1" value="<%=prodRegalo1%>">
	<input type="hidden" name="prodRegalo2" value="<%=prodRegalo2%>">
	<input type="hidden" name="prodRegalo3" value="<%=prodRegalo3%>">
	<input type="hidden" name="tipoUniRegalo1" value="<%=tipoUniRegalo1%>">
	<input type="hidden" name="tipoUniRegalo2" value="<%=tipoUniRegalo2%>">
	<input type="hidden" name="tipoUniRegalo3" value="<%=tipoUniRegalo3%>">
	<input type="hidden" name="cantidadRegalo1" value="<%=cantidadRegalo1%>">
	<input type="hidden" name="cantidadRegalo2" value="<%=cantidadRegalo2%>">
	<input type="hidden" name="cantidadRegalo3" value="<%=cantidadRegalo3%>">
<% 	for (int i=0; i<ArrayCantidad.length; i++){ %>	
	<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
	<input type="hidden" name="unidad" value="<%=ArrayCUnidad[i]%>">
	<input type="hidden" name="importe" value="<%=ArrayImporte[i]%>">
	<input type="hidden" name="tipo" value="<%=ArrayTipo[i]%>">
	<input type="hidden" name="cambio" value="<%=ArrayCambio[i]%>">
<% } %>	
<%
	ResultSet productos = alCom.productosXProveedor(proveedorC);				
%>	
	<table width="680" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>Realiza la Selecci&oacute;n M&uacute;ltiple de Productos para su Compra</caption>
	  <tr>
	  	<th>Clave</th>
		<th>Nombre</th>
		<th colspan="2">Tipo Unidad</th>
		<th>Cancelar</th>
	  </tr>
	 <p></p>
<%
	int consecutivo = 0;
	while (productos.next()){
		consecutivo ++;
		boolean esporKilo = true;
		if(productos.getInt("uniCompra") == 1){
			esporKilo = false;
		}		
%>
	<tr>
		<td><%=productos.getString("ID_Pro")%></td>
		<td><%=productos.getString("descripcion")%></td>		
<%		if (esporKilo) {  %>
			<td colspan="2"><input type="radio" name="rg<%=consecutivo%>" value="KG<%=productos.getString("ID_Pro")%>"> Por Kilo</td>
			<td><input type="button" value="Cancelar" name="Cancelar" onClick="deSelecciona(rg<%=consecutivo%>)"></td>
<%		} else{   
			boolean soloPieza = false;
			boolean soloCaja = false;
			if(productos.getDouble("preCaCompra") <= 0.00){
				soloPieza = true;
			}
			else if(productos.getDouble("precioUniCompra") <= 0.00 ){
				soloCaja = true;
			}
			if(!soloPieza && !soloCaja){
%>
				<td><input type="radio" name="rg<%=consecutivo%>" value="PZ<%=productos.getString("ID_Pro")%>"> Por Pieza</td>
				<td><input type="radio" name="rg<%=consecutivo%>" value="CJ<%=productos.getString("ID_Pro")%>"> Por Caja</td>
				<td><input type="button" value="Cancelar" name="Cancelar" onClick="deSelecciona(rg<%=consecutivo%>)"></td>				
<%			} else if(soloPieza){ 	%>
				<td colspan="2"><input type="radio" name="rg<%=consecutivo%>" value="PZ<%=productos.getString("ID_Pro")%>"> Por Pieza</td>
				<td><input type="button" value="Cancelar" name="Cancelar" onClick="deSelecciona(rg<%=consecutivo%>)"></td>				
<%			} else { 	%>
				<td colspan="2"><input type="radio" name="rg<%=consecutivo%>" value="CJ<%=productos.getString("ID_Pro")%>"> Por Caja</td>
				<td><input type="button" value="Cancelar" name="Cancelar" onClick="deSelecciona(rg<%=consecutivo%>)"></td>				
<%			} %>
<%		} 		%>		
	</tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	alCom.cierraConexion();		// de ResultSet Complex													
%>	  	  
	</table>
	<input type="hidden" name="proveedorC" value="<%=proveedorC%>">	
	<p><input type="submit" name="Enviar" value="Enviar" ></p>
</form>
<br />
<form method="post" target="_self" name="RegN" action="Alta_Compra.jsp"> 
<% 	for (int i=0; i<ArrayCantidad.length; i++){ %>	
	<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
	<input type="hidden" name="unidad" value="<%=ArrayCUnidad[i]%>">
	<input type="hidden" name="importe" value="<%=ArrayImporte[i]%>">
	<input type="hidden" name="tipo" value="<%=ArrayTipo[i]%>">
	<input type="hidden" name="cambio" value="<%=ArrayCambio[i]%>">
<% } %>	
	<input type="hidden" name="prodRegalo1" value="<%=prodRegalo1%>">
	<input type="hidden" name="prodRegalo2" value="<%=prodRegalo2%>">
	<input type="hidden" name="prodRegalo3" value="<%=prodRegalo3%>">
	<input type="hidden" name="tipoUniRegalo1" value="<%=tipoUniRegalo1%>">
	<input type="hidden" name="tipoUniRegalo2" value="<%=tipoUniRegalo2%>">
	<input type="hidden" name="tipoUniRegalo3" value="<%=tipoUniRegalo3%>">
	<input type="hidden" name="cantidadRegalo1" value="<%=cantidadRegalo1%>">
	<input type="hidden" name="cantidadRegalo2" value="<%=cantidadRegalo2%>">
	<input type="hidden" name="cantidadRegalo3" value="<%=cantidadRegalo3%>">
	<a onClick="MandaSubmit()" onMouseOver="MM_swapImage('RegresoN','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="RegresoN" width="132" height="41" border="0"></a>
	<input type="hidden" name="proveedorC" value="<%=proveedorC%>">
</form>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
