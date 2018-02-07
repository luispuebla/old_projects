<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Obtenci&oacute;n Productos y Datos</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

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
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	String numProductos = "1";
	int cantNumProductos = 1;
	int cantidadProd = 1;	
	String cliente = "";
	String queryString = request.getQueryString();
//	System.out.println("--> Q --> " +queryString);
	queryString = queryString.substring(8);	
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	cliente = request.getParameter("cliente");
	numProductos = request.getParameter("numProductos");
	cantNumProductos = alVen.cambiaAInt(numProductos);
	cantNumProductos -=1;
	//System.out.println("--> "+cantNumProductos);
	ArrayCantidad   = new String[cantNumProductos+1]; // Aumento 1 para facilitar el manejo del arreglo.
	ArrayProducto   = new String[cantNumProductos+1];
	ArrayCUnidad   = new String[cantNumProductos+1];
	ArrayImporte   = new String[cantNumProductos+1];
	for (int i =1; i<=cantNumProductos; i++){
		ArrayCantidad[i] = request.getParameter("cantidad"+i);
		ArrayProducto[i] = request.getParameter("producto"+i);
		ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
		ArrayImporte[i] = request.getParameter("importe"+i);
		//System.out.println("Listado Cambia"+i+" :"+Arraycambia[i]);
	}
	String tempcan1 = request.getParameter("cantidadR1"); 
	String tempcan2 = request.getParameter("cantidadR2");
	String tempcan3 = request.getParameter("cantidadR3");
	String tempprod1 = request.getParameter("productoR1");
	String tempprod2 = request.getParameter("productoR2");
	String tempprod3 = request.getParameter("productoR3");
	//System.out.println("LCantidad: "+tempcan1);
	//System.out.println("LUnidad: "+tempuni1);
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); setFocus()">
<form name="search1" onSubmit="return findInPage(this.string.value);">
Buscar en la pagina:
<input name="string" type="text" size="20" onChange="n = 0;">
<input type="Submit" value="buscar">
</form>
<form name="formaR" method="post" target="_self" action="Alta_Venta.jsp">
<%
	ResultSet productos = alVen.todosLosProductosConInv();		
		
%>	
	<table width="680" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
	  	<th width="37">&nbsp;</th>
	  	<th width="74">Clave</th>
		<th width="357">Descripci&oacute;n Producto</th>
		<th width="100">Cantidad<br />Venta</th>
		<th width="100">Cantidad<br />Obsequio</th>		
	  </tr>
	 <p></p>
<%
	while (productos.next()){
		String tempOb = "0";
		if(productos.getString("ExistenciaOb") != null){
			tempOb = productos.getString("ExistenciaOb");
		}
%>
      <tr>
		<td><input type="radio" name="rg1<%=cantidadProd%>" value="<%=productos.getString("claveProducto")%>">
		  </td>
		<td><div align="center"><%=productos.getString("claveProducto")%></div></td>
		<td><%=productos.getString("descripcion")%></td>
		<td><div align="center"><%=productos.getString("existencia")%></div></td>
		<td><div align="center"><%=tempOb%></div></td>
      </tr>
<%	
		cantidadProd++;
	}
	if(productos != null){
		productos.close();
	}
	alVen.cierraConexion();		// de ResultSet Complex												
	cantidadProd --;
%>	  	  
	</table>
<%	
	for (int i=1; i<=cantNumProductos; i++){
%>	
	<input type="hidden" name="cantidad<%=i%>" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto<%=i%>" value="<%=ArrayProducto[i]%>">
	<input type="hidden" name="cUnidad<%=i%>" value="<%=ArrayCUnidad[i]%>">
	<input type="hidden" name="importe<%=i%>" value="<%=ArrayImporte[i]%>">
<%
	}
%>	
	<input type="hidden" name="cantidadProd" value="<%=cantidadProd%>">
	<input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	<input type="hidden" name="clienteC" value="<%=cliente%>">
	<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">
	<input type="hidden" name="productoR1" value="<%=tempprod1%>">
	<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">
	<input type="hidden" name="productoR2" value="<%=tempprod2%>">
	<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">
	<input type="hidden" name="productoR3" value="<%=tempprod3%>">
	<input type="submit" name="Enviar" value="Enviar" >
</form>
<br />
<form method="post" target="_self" name="RegN" action="Alta_Venta.jsp"> 
	<a onClick="MandaSubmit()" onMouseOver="MM_swapImage('RegresoN','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="RegresoN" width="152" height="36" border="0"></a>
	<input type="hidden" name="clienteQ" value="<%=cliente%>">
	<input type="hidden" name="cantidadProd" value="<%=cantidadProd%>">	
<%	
	for (int i=1; i<=cantNumProductos; i++){
%>	
	<input type="hidden" name="cantidad<%=i%>" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto<%=i%>" value="<%=ArrayProducto[i]%>">
	<input type="hidden" name="cUnidad<%=i%>" value="<%=ArrayCUnidad[i]%>">
	<input type="hidden" name="importe<%=i%>" value="<%=ArrayImporte[i]%>">
<%
	}
%><input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	<input type="hidden" name="rg1" value="<%=""%>">
	<input type="hidden" name="clienteC" value="<%=cliente%>">	
	<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">
	<input type="hidden" name="productoR1" value="<%=tempprod1%>">
	<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">
	<input type="hidden" name="productoR2" value="<%=tempprod2%>">
	<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">
	<input type="hidden" name="productoR3" value="<%=tempprod3%>">
</form>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
