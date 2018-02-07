<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Guardar Orden de Compra</title>
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
-->
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
	String cliente = "";
	String numFac = "";
	String  datebox = request.getParameter("datebox");
	String datebox2 = request.getParameter("datebox2");
	String mes = datebox.substring(0,2);
	String dia = datebox.substring(3,5);
	String ano = datebox.substring(6,10);
	String repartidor = request.getParameter("repartidor");
	String fechaAlta = ano+"-"+mes+"-"+dia;
	mes = datebox2.substring(0,2);
	dia = datebox2.substring(3,5);
	ano = datebox2.substring(6,10);
	String fechaEntrega = ano+"-"+mes+"-"+dia;		
	//System.out.println("Fecha de Entrega Web: "+fechaentrega);
	String observaciones = request.getParameter("observaciones");
	String documento = request.getParameter("documento");
	if(documento.equals("1")){
		numFac = request.getParameter("numFac");
	}
	String subtotal = request.getParameter("subtotal");
	String iva = request.getParameter("iva");
	String total = request.getParameter("total2");
	String claveDeCompra = "";
	String numRemision = "";
	//String queryString = request.getQueryString();
	//queryString = queryString.substring(8);	
	//System.out.println("Recupero información JSP");
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCunidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	String[] ArrayRegalos = new String[2];
	
	String tempcan1 = "";
	String tempcan2 = "";
	String tempcan3 = "";
	String tempprod1 = "";
	String tempprod2 = "";
	String tempprod3 = "";
	
	if(request.getParameter("cantidadR1") != null)
		tempcan1 = request.getParameter("cantidadR1");
	if(request.getParameter("cantidadR2") != null)
		tempcan2 = request.getParameter("cantidadR2");
	if(request.getParameter("cantidadR3") != null)
		tempcan3 = request.getParameter("cantidadR3");
	if(request.getParameter("productoR1") != null)
		tempprod1 = request.getParameter("productoR1");
	if(request.getParameter("productoR2") != null)
		tempprod2 = request.getParameter("productoR2");
	if(request.getParameter("productoR3") != null)
		tempprod3 = request.getParameter("productoR3");
	//System.out.println("Creo arreglos JSP");
	cliente = request.getParameter("cliente");
	//System.out.println("Entrega: "+entrega);
	numProductos = request.getParameter("numProductos");
	cantNumProductos = alVen.cambiaAInt(numProductos);
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
		ArrayRegalos[i] = request.getParameter("reg"+i);
		//System.out.println("Cambia: "+Arraycambia[i]);
	}
%>
<body onLoad="MM_preloadImages('imagenes/Imprimir2.jpg')">

<jsp:setProperty name="alVen" property="claveCliente" value="<%=cliente%>"/>
<jsp:setProperty name="alVen" property="observaciones" value="<%=observaciones%>"/>
<jsp:setProperty name="alVen" property="subtotal" value="<%=subtotal%>"/>
<jsp:setProperty name="alVen" property="iva" value="<%=iva%>"/>
<jsp:setProperty name="alVen" property="total" value="<%=total%>"/>
<jsp:setProperty name="alVen" property="documento" value="<%=documento%>"/>
<jsp:setProperty name="alVen" property="numFac" value="<%=numFac%>"/>
<jsp:setProperty name="alVen" property="fechaAlta" value="<%=fechaAlta%>"/>
<jsp:setProperty name="alVen" property="fechaEntrega" value="<%=fechaEntrega%>"/>
<jsp:setProperty name="alVen" property="cantNumProductos" value="<%=numProductos%>"/>
<jsp:setProperty name="alVen" property="arrayCantidad" value="<%=ArrayCantidad%>"/>
<jsp:setProperty name="alVen" property="arrayProducto" value="<%=ArrayProducto%>"/>
<jsp:setProperty name="alVen" property="arrayCunidad" value="<%=ArrayCunidad%>"/>
<jsp:setProperty name="alVen" property="arrayImporte" value="<%=ArrayImporte%>"/>
<jsp:setProperty name="alVen" property="arrayRegalos" value="<%=ArrayRegalos%>"/>
<jsp:setProperty name="alVen" property="can1" value="<%=tempcan1%>"/>
<jsp:setProperty name="alVen" property="can2" value="<%=tempcan2%>"/>
<jsp:setProperty name="alVen" property="can3" value="<%=tempcan3%>"/>
<jsp:setProperty name="alVen" property="prod1" value="<%=tempprod1%>"/>
<jsp:setProperty name="alVen" property="prod2" value="<%=tempprod2%>"/>
<jsp:setProperty name="alVen" property="prod3" value="<%=tempprod3%>"/>
<jsp:setProperty name="alVen" property="repartidor" value="<%=repartidor%>"/>
<% //System.out.println("envio información jsp al java");
String primero = "";
primero=alVen.add_Orden_Venta(usuario);
int direccion = 1;
//System.out.println(primero);
if(primero.startsWith("ERROR")){
	direccion = -1;
}
else if(primero.startsWith("OK")){
	claveDeCompra = primero.substring((primero.lastIndexOf("*")+1),primero.length());
	//System.out.println("Clave Compra: " +claveDeCompra);
	if(primero.substring(2,3).equalsIgnoreCase("R")){
		numRemision = primero.substring(3,(primero.lastIndexOf("*")-1));
		//System.out.println("Remision: *" +numRemision);
	}
}
// Se agoto de inventario al menos uno de los productos.
else{
	direccion = -2;
}


//System.out.println(primero);
if(direccion != -1 && direccion != -2){
	if(!numRemision.equalsIgnoreCase("")){ %>
		<form method="post" target="_blank" name="RegN" action="Imprimir_Venta.jsp"> 
		<div align="center"><a onClick="MandaSubmit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprimir','','imagenes/Imprimir2.jpg',0)"><img src="imagenes/Imprimir1.jpg" name="Imprimir" width="152" height="36" border="0"></a>
		  <input type="hidden" name="cliente" value="<%=cliente%>">
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
		<input type="hidden" name="claveOrden" value="<%=claveDeCompra%>">
		<input type="hidden" name="numRemision" value="<%=numRemision%>">
		<input type="hidden" name="documento" value="<%=documento%>">
		<input type="hidden" name="numFac" value="<%=numFac%>">
		<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">	
		<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">	
		<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">	
		<input type="hidden" name="productoR1" value="<%=tempprod1%>">	
		<input type="hidden" name="productoR2" value="<%=tempprod2%>">	
		<input type="hidden" name="productoR3" value="<%=tempprod3%>">		  
		  <input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
		  <input type="hidden" name="observaciones" value="<%=observaciones%>">	
		  <input type="hidden" name="subtotal" value="<%=subtotal%>">	
		  <input type="hidden" name="iva" value="<%=iva%>">	
		  <input type="hidden" name="total" value="<%=total%>">	
		  <input type="hidden" name="idProducto" value="<%=""%>">
		  <input type="hidden" name="rg1" value="<%=""%>">
		</div>
	  </form>
<%	  }
	  else{ %>
		<form method="post" target="_blank" name="RegN" action="Imprimir_Factura.jsp"> 
		<div align="center"><a onClick="MandaSubmit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprimir','','imagenes/Imprimir2.jpg',0)"><img src="imagenes/Imprimir1.jpg" name="Imprimir" width="152" height="36" border="0"></a>
		  <input type="hidden" name="cliente" value="<%=cliente%>">
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
		<input type="hidden" name="claveOrden" value="<%=claveDeCompra%>">
		<input type="hidden" name="numRemision" value="<%=numRemision%>">
		<input type="hidden" name="documento" value="<%=documento%>">
		<input type="hidden" name="numFac" value="<%=numFac%>">
		<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">	
		<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">	
		<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">	
		<input type="hidden" name="productoR1" value="<%=tempprod1%>">	
		<input type="hidden" name="productoR2" value="<%=tempprod2%>">	
		<input type="hidden" name="productoR3" value="<%=tempprod3%>">		  
		  <input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
		  <input type="hidden" name="observaciones" value="<%=observaciones%>">	
		  <input type="hidden" name="subtotal" value="<%=subtotal%>">	
		  <input type="hidden" name="iva" value="<%=iva%>">	
		  <input type="hidden" name="total" value="<%=total%>">	
		  <input type="hidden" name="idProducto" value="<%=""%>">
		  <input type="hidden" name="rg1" value="<%=""%>">
		</div>
	  </form>	  
	  
<%
		}
	 }	
	else if(direccion == -1){

				out.print("Existió algún problema al guardar la Orden de Venta en la Base de Datos.");
	}
	else{
%>
	<b class="roj">No se pudo concretar la venta debido a que <br/>al menos uno de los productos vendido/obsequiado ya no existe en el Inventario.<br/>El Sistema envi&oacute; el siguiente mensaje de Error:</b>
	<p><%=primero%></p>
	Vuelva a dar de alta su Venta.
<% } %>
	
  </p>
<p align="center"> <a href="Menu_Ventas.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></font></p>
<p align="center"></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
