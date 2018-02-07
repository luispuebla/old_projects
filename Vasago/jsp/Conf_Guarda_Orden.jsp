<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Guardar Compra</title>
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
//System.out.println("Empiezo JSP");
	String numProductos = "1";
	int cantNumProductos = 1;
	String proveedor = "";
	String  datebox = request.getParameter("datebox");
	
	String mes = datebox.substring(0,2);
	String dia = datebox.substring(3,5);
	String ano = datebox.substring(6,10);
	String fechaentrega = ano+"-"+mes+"-"+dia;
	String  claveOrden = request.getParameter("claveOrden");
	String observaciones = request.getParameter("observaciones");
	String subtotal = request.getParameter("subtotal");
	String descuento = request.getParameter("descuentos");
	String iva = request.getParameter("iva");
	String total = request.getParameter("total");
	String descuento1 = request.getParameter("descuento1");
	String descuento2 = request.getParameter("descuento2");
	String descuento3 = request.getParameter("descuento3");
	//String queryString = request.getQueryString();
	//queryString = queryString.substring(8);	
	//System.out.println("Recupero información JSP");
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCunidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	String[] ArrayRegalos = new String[2];
	//System.out.println("Creo arreglos JSP");
	proveedor = request.getParameter("proveedor");
	numProductos = request.getParameter("numProductos");
	cantNumProductos = alCom.cambiaAInt(numProductos);
	//cantNumProductos -=1;
	//System.out.println("Recupero información2 JSP");
	ArrayCantidad   = new String[cantNumProductos+1]; // Aumento 1 para facilitar el manejo del arreglo.
	ArrayProducto   = new String[cantNumProductos+1];
	ArrayCunidad   = new String[cantNumProductos+1];
	ArrayImporte   = new String[cantNumProductos+1];
	ArrayRegalos = new String[cantNumProductos+1];
	//System.out.println("Asigno tamaño arreglos JSP: "+cantNumProductos);
	for (int i =1; i<=cantNumProductos; i++){
		//System.out.println("Empiezo a Guardo arreglos JSP: "+i);
		ArrayCantidad[i] = request.getParameter("cantidad"+i);
		ArrayProducto[i] = request.getParameter("producto"+i);
		ArrayCunidad[i] = request.getParameter("cUnidad"+i);
		ArrayImporte[i] = request.getParameter("importe"+i);
		//System.out.println("Guardo arreglos JSP: "+i);
	}
%>
<body>
<%//System.out.println("Empiezo a asignar variables");%>
<jsp:setProperty name="alCom" property="usuario" value="<%=usuario%>"/>
<jsp:setProperty name="alCom" property="claveOrden" value="<%=claveOrden%>"/>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedor%>"/>
<jsp:setProperty name="alCom" property="observaciones" value="<%=observaciones%>"/>
<jsp:setProperty name="alCom" property="descuento1" value="<%=descuento1%>"/>
<jsp:setProperty name="alCom" property="descuento2" value="<%=descuento2%>"/>
<jsp:setProperty name="alCom" property="descuento3" value="<%=descuento3%>"/>
<jsp:setProperty name="alCom" property="subtotal" value="<%=subtotal%>"/>
<jsp:setProperty name="alCom" property="descuento" value="<%=descuento%>"/>
<jsp:setProperty name="alCom" property="iva" value="<%=iva%>"/>
<jsp:setProperty name="alCom" property="total" value="<%=total%>"/>
<jsp:setProperty name="alCom" property="fechaentrega" value="<%=fechaentrega%>"/>
<jsp:setProperty name="alCom" property="cantNumProductos" value="<%=numProductos%>"/>
<jsp:setProperty name="alCom" property="arrayCantidad" value="<%=ArrayCantidad%>"/>
<jsp:setProperty name="alCom" property="arrayProducto" value="<%=ArrayProducto%>"/>
<jsp:setProperty name="alCom" property="arrayCunidad" value="<%=ArrayCunidad%>"/>
<jsp:setProperty name="alCom" property="arrayImporte" value="<%=ArrayImporte%>"/>
<% //System.out.println("Mando a actualizar la Orden");
boolean primero = false;
primero=alCom.update_Orden_Compra();
 //System.out.println("Mando a actualizar los productos");
 //System.out.println("Primero1 "+primero);
primero=alCom.update_Productos_Orden_Compra();
//System.out.println("Primero2 "+primero);
if(primero){
%>
<form method="post" target="_blank" name="RegN" action="Imprimir_Compra2.jsp"> 
	<div align="center"><a onClick="MandaSubmit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprimir','','imagenes/Imprimir2.jpg',0)"><img src="imagenes/Imprimir1.jpg" name="Imprimir" width="152" height="36" border="0"></a>
      <input type="hidden" name="proveedor" value="<%=proveedor%>">
      <%	
	for (int i=1; i<=cantNumProductos; i++){
%>	
      <input type="hidden" name="cantidad<%=i%>" value="<%=ArrayCantidad[i]%>">
      <input type="hidden" name="producto<%=i%>" value="<%=ArrayProducto[i]%>">
      <input type="hidden" name="cUnidad<%=i%>" value="<%=ArrayCunidad[i]%>">
      <input type="hidden" name="importe<%=i%>" value="<%=ArrayImporte[i]%>">
      <%
	}
%>		
    <input type="hidden" name="claveOrden" value="<%=claveOrden%>">
      <input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	  <input type="hidden" name="descuento1" value="<%=descuento1%>">	
	  <input type="hidden" name="descuento2" value="<%=descuento2%>">	
	  <input type="hidden" name="descuento3" value="<%=descuento3%>">	
	  <input type="hidden" name="observaciones" value="<%=observaciones%>">	
	  <input type="hidden" name="subtotal" value="<%=subtotal%>">	
	  <input type="hidden" name="descuento" value="<%=descuento%>">	
	  <input type="hidden" name="iva" value="<%=iva%>">	
	  <input type="hidden" name="total" value="<%=total%>">	
      <input type="hidden" name="idProducto" value="<%=""%>">
      <input type="hidden" name="rg1" value="<%=""%>">
	  <input type="hidden" name="fechaentrega" value="<%=fechaentrega%>">
    </div>
</form>
<%
} 	else{
//System.out.println("Todo mal");

				out.print("Existió un problema al actualizar la Orden de Compra en la Base de Datos.");}
	%>
	
</p>
<p>&nbsp;</p>
<p align="center"><a href="Menu_Compras.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
