<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />
<jsp:useBean id="pro" class="com.vas.bd.ManagerProductos" scope="page" />
<jsp:useBean id="mar" class="com.vas.bd.ManagerMarcas" scope="page" />

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
	String proveedor = "";
	String queryString = request.getQueryString();
	//System.out.println("--> Q --> " +queryString);
	queryString = queryString.substring(8);	
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	proveedor = request.getParameter("proveedorQ");
	numProductos = request.getParameter("numProductos");
	cantNumProductos = alCom.cambiaAInt(numProductos);
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
	String tempcan4 = request.getParameter("cantidadR4");
	String tempcan5 = request.getParameter("cantidadR5");
	String tempcan6 = request.getParameter("cantidadR6");
	String tempcan7 = request.getParameter("cantidadR7");
	String tempcan8 = request.getParameter("cantidadR8");
	String tempcan9 = request.getParameter("cantidadR9");
	String tempcan10 = request.getParameter("cantidadR10");
	String tempcan11 = request.getParameter("cantidadR11");
	String tempcan12 = request.getParameter("cantidadR12");
	String tempcan13 = request.getParameter("cantidadR13");
	String tempcan14 = request.getParameter("cantidadR14");
	String tempcan15 = request.getParameter("cantidadR15");
	String tempprod1 = request.getParameter("productoR1");
	String tempprod2 = request.getParameter("productoR2");
	String tempprod3 = request.getParameter("productoR3");
	String tempprod4 = request.getParameter("productoR4");
	String tempprod5 = request.getParameter("productoR5");
	String tempprod6 = request.getParameter("productoR6");
	String tempprod7 = request.getParameter("productoR7");
	String tempprod8 = request.getParameter("productoR8");
	String tempprod9 = request.getParameter("productoR9");
	String tempprod10 = request.getParameter("productoR10");
	String tempprod11 = request.getParameter("productoR11");
	String tempprod12 = request.getParameter("productoR12");
	String tempprod13 = request.getParameter("productoR13");
	String tempprod14 = request.getParameter("productoR14");
	String tempprod15 = request.getParameter("productoR15");
	//System.out.println("LCantidad: "+tempcan1);
	//System.out.println("LUnidad: "+tempuni1);
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); setFocus()">
<form name="search1" onSubmit="return findInPage(this.string.value);">
Buscar en la pagina:
<input name="string" type="text" size="20" onChange="n = 0;">
<input type="Submit" value="buscar">
</form>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedor%>"/>
<form name="formaR" method="post" target="_self" action="Alta_Prueba.jsp">
<%
	ResultSet productos = pro.todosLosProductos();
%>	
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
	  	<th width="27">&nbsp;</th>
	  	<th width="114">Clave</th>
	  	<th width="114">Marca</th>
		<th width="451">Descripci&oacute;n Producto</th>
	  </tr>
	 </table>
	 <p></p>
<%
	while (productos.next()){
%>
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
      <tr>
		<td width="23"><input type="radio" name="rg1" value="<%=productos.getString("claveProducto")%>"></td>
		<td width="95"><%=productos.getString("claveProducto")%></td>
		<td width="99"><%=mar.nombreMarca(productos.getString("marca"))%></td>
		<td width="373"><%=productos.getString("descripcion")%></td>
      </tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	pro.cierraConexion();	
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
	<input type="hidden" name="idProducto" value="<%=queryString%>">
	<input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	<input type="hidden" name="proveedor" value="<%=proveedor%>">
	<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">
	<input type="hidden" name="productoR1" value="<%=tempprod1%>">
	<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">
	<input type="hidden" name="productoR2" value="<%=tempprod2%>">
	<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">
	<input type="hidden" name="productoR3" value="<%=tempprod3%>">
	<input type="hidden" name="cantidadR4" value="<%=tempcan4%>">
	<input type="hidden" name="productoR4" value="<%=tempprod4%>">
	<input type="hidden" name="cantidadR5" value="<%=tempcan5%>">
	<input type="hidden" name="productoR5" value="<%=tempprod5%>">
	<input type="hidden" name="cantidadR6" value="<%=tempcan6%>">
	<input type="hidden" name="productoR6" value="<%=tempprod6%>">
	<input type="hidden" name="cantidadR7" value="<%=tempcan7%>">
	<input type="hidden" name="productoR7" value="<%=tempprod7%>">
	<input type="hidden" name="cantidadR8" value="<%=tempcan8%>">
	<input type="hidden" name="productoR8" value="<%=tempprod8%>">
	<input type="hidden" name="cantidadR9" value="<%=tempcan9%>">
	<input type="hidden" name="productoR9" value="<%=tempprod9%>">
	<input type="hidden" name="cantidadR10" value="<%=tempcan10%>">
	<input type="hidden" name="productoR10" value="<%=tempprod10%>">
	<input type="hidden" name="cantidadR11" value="<%=tempcan11%>">
	<input type="hidden" name="productoR11" value="<%=tempprod11%>">
	<input type="hidden" name="cantidadR12" value="<%=tempcan12%>">
	<input type="hidden" name="productoR12" value="<%=tempprod12%>">
	<input type="hidden" name="cantidadR13" value="<%=tempcan13%>">
	<input type="hidden" name="productoR13" value="<%=tempprod13%>">
	<input type="hidden" name="cantidadR14" value="<%=tempcan14%>">
	<input type="hidden" name="productoR14" value="<%=tempprod14%>">
	<input type="hidden" name="cantidadR15" value="<%=tempcan15%>">
	<input type="hidden" name="productoR15" value="<%=tempprod15%>">
	<input type="submit" name="Enviar" value="Enviar" >
</form>
<br />
<form method="post" target="_self" name="RegN" action="Alta_Prueba.jsp"> 
	<a onClick="MandaSubmit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('RegresoN','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="RegresoN" width="152" height="36" border="0"></a>
	<input type="hidden" name="proveedor" value="<%=proveedor%>">
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
	<input type="hidden" name="idProducto" value="<%=""%>">
	<input type="hidden" name="rg1" value="<%=""%>">
	<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">
	<input type="hidden" name="productoR1" value="<%=tempprod1%>">
	<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">
	<input type="hidden" name="productoR2" value="<%=tempprod2%>">
	<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">
	<input type="hidden" name="productoR3" value="<%=tempprod3%>">
	<input type="hidden" name="cantidadR4" value="<%=tempcan4%>">
	<input type="hidden" name="productoR4" value="<%=tempprod4%>">
	<input type="hidden" name="cantidadR5" value="<%=tempcan5%>">
	<input type="hidden" name="productoR5" value="<%=tempprod5%>">
	<input type="hidden" name="cantidadR6" value="<%=tempcan6%>">
	<input type="hidden" name="productoR6" value="<%=tempprod6%>">
	<input type="hidden" name="cantidadR7" value="<%=tempcan7%>">
	<input type="hidden" name="productoR7" value="<%=tempprod7%>">
	<input type="hidden" name="cantidadR8" value="<%=tempcan8%>">
	<input type="hidden" name="productoR8" value="<%=tempprod8%>">
	<input type="hidden" name="cantidadR9" value="<%=tempcan9%>">
	<input type="hidden" name="productoR9" value="<%=tempprod9%>">
	<input type="hidden" name="cantidadR10" value="<%=tempcan10%>">
	<input type="hidden" name="productoR10" value="<%=tempprod10%>">
	<input type="hidden" name="cantidadR11" value="<%=tempcan11%>">
	<input type="hidden" name="productoR11" value="<%=tempprod11%>">
	<input type="hidden" name="cantidadR12" value="<%=tempcan12%>">
	<input type="hidden" name="productoR12" value="<%=tempprod12%>">
	<input type="hidden" name="cantidadR13" value="<%=tempcan13%>">
	<input type="hidden" name="productoR13" value="<%=tempprod13%>">
	<input type="hidden" name="cantidadR14" value="<%=tempcan14%>">
	<input type="hidden" name="productoR14" value="<%=tempprod14%>">
	<input type="hidden" name="cantidadR15" value="<%=tempcan15%>">
	<input type="hidden" name="productoR15" value="<%=tempprod15%>">	
</form>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
