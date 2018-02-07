<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />

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
	String proveedor = "";
	String  datebox = request.getParameter("datebox");
	
	String mes = datebox.substring(0,2);
	String dia = datebox.substring(3,5);
	String ano = datebox.substring(6,10);
	String fechaentrega = ano+"-"+mes+"-"+dia;
	
	//System.out.println("Fecha de Entrega Web: "+fechaentrega);
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
	
	String tempcan1 = "";
	String tempcan2 = "";
	String tempcan3 = "";
	String tempcan4 = "";
	String tempcan5 = "";
	String tempcan6 = "";
	String tempcan7 = "";
	String tempcan8 = "";
	String tempcan9 = "";
	String tempcan10 = "";
	String tempcan11 = "";
	String tempcan12 = "";
	String tempcan13 = "";
	String tempcan14 = "";
	String tempcan15 = "";	
	String tempprod1 = "";
	String tempprod2 = "";
	String tempprod3 = "";
	String tempprod4 = "";
	String tempprod5 = "";
	String tempprod6 = "";
	String tempprod7 = "";
	String tempprod8 = "";
	String tempprod9 = "";
	String tempprod10 = "";
	String tempprod11 = "";
	String tempprod12 = "";
	String tempprod13 = "";
	String tempprod14 = "";
	String tempprod15 = "";
	
	if(request.getParameter("cantidadR1") != null)
		tempcan1 = request.getParameter("cantidadR1");
	if(request.getParameter("cantidadR2") != null)
		tempcan2 = request.getParameter("cantidadR2");
	if(request.getParameter("cantidadR3") != null)
		tempcan3 = request.getParameter("cantidadR3");
	if(request.getParameter("cantidadR4") != null)
		tempcan4 = request.getParameter("cantidadR4");
	if(request.getParameter("cantidadR5") != null)
		tempcan5 = request.getParameter("cantidadR5");
	if(request.getParameter("cantidadR6") != null)
		tempcan6 = request.getParameter("cantidadR6");
	if(request.getParameter("cantidadR7") != null)
		tempcan7 = request.getParameter("cantidadR7");
	if(request.getParameter("cantidadR8") != null)
		tempcan8 = request.getParameter("cantidadR8");
	if(request.getParameter("cantidadR9") != null)
		tempcan9 = request.getParameter("cantidadR9");
	if(request.getParameter("cantidadR10") != null)
		tempcan10 = request.getParameter("cantidadR10");
	if(request.getParameter("cantidadR11") != null)
		tempcan11 = request.getParameter("cantidadR11");
	if(request.getParameter("cantidadR12") != null)
		tempcan12 = request.getParameter("cantidadR12");
	if(request.getParameter("cantidadR13") != null)
		tempcan13 = request.getParameter("cantidadR13");
	if(request.getParameter("cantidadR14") != null)
		tempcan14 = request.getParameter("cantidadR14");
	if(request.getParameter("cantidadR15") != null)
		tempcan15 = request.getParameter("cantidadR15");
	if(request.getParameter("productoR1") != null)
		tempprod1 = request.getParameter("productoR1");
	if(request.getParameter("productoR2") != null)
		tempprod2 = request.getParameter("productoR2");
	if(request.getParameter("productoR3") != null)
		tempprod3 = request.getParameter("productoR3");
	if(request.getParameter("productoR4") != null)
		tempprod4 = request.getParameter("productoR4");
	if(request.getParameter("productoR5") != null)
		tempprod5 = request.getParameter("productoR5");
	if(request.getParameter("productoR6") != null)
		tempprod6 = request.getParameter("productoR6");
	if(request.getParameter("productoR7") != null)
		tempprod7 = request.getParameter("productoR7");
	if(request.getParameter("productoR8") != null)
		tempprod8 = request.getParameter("productoR8");
	if(request.getParameter("productoR9") != null)
		tempprod9 = request.getParameter("productoR9");
	if(request.getParameter("productoR10") != null)
		tempprod10 = request.getParameter("productoR10");
	if(request.getParameter("productoR11") != null)
		tempprod11 = request.getParameter("productoR11");
	if(request.getParameter("productoR12") != null)
		tempprod12 = request.getParameter("productoR12");
	if(request.getParameter("productoR13") != null)
		tempprod13 = request.getParameter("productoR13");
	if(request.getParameter("productoR14") != null)
		tempprod14 = request.getParameter("productoR14");
	if(request.getParameter("productoR15") != null)
		tempprod15 = request.getParameter("productoR15");
	//System.out.println("Creo arreglos JSP");
	proveedor = request.getParameter("proveedor");
	//System.out.println("Entrega: "+entrega);
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
		ArrayRegalos[i] = request.getParameter("reg"+i);
		//System.out.println("Cambia: "+Arraycambia[i]);
	}
%>
<body onLoad="MM_preloadImages('imagenes/Imprimir2.jpg')">

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
<jsp:setProperty name="alCom" property="arrayRegalos" value="<%=ArrayRegalos%>"/>
<jsp:setProperty name="alCom" property="can1" value="<%=tempcan1%>"/>
<jsp:setProperty name="alCom" property="can2" value="<%=tempcan2%>"/>
<jsp:setProperty name="alCom" property="can3" value="<%=tempcan3%>"/>
<jsp:setProperty name="alCom" property="can4" value="<%=tempcan4%>"/>
<jsp:setProperty name="alCom" property="can5" value="<%=tempcan5%>"/>
<jsp:setProperty name="alCom" property="can6" value="<%=tempcan6%>"/>
<jsp:setProperty name="alCom" property="can7" value="<%=tempcan7%>"/>
<jsp:setProperty name="alCom" property="can8" value="<%=tempcan8%>"/>
<jsp:setProperty name="alCom" property="can9" value="<%=tempcan9%>"/>
<jsp:setProperty name="alCom" property="can10" value="<%=tempcan10%>"/>
<jsp:setProperty name="alCom" property="can11" value="<%=tempcan11%>"/>
<jsp:setProperty name="alCom" property="can12" value="<%=tempcan12%>"/>
<jsp:setProperty name="alCom" property="can13" value="<%=tempcan13%>"/>
<jsp:setProperty name="alCom" property="can14" value="<%=tempcan14%>"/>
<jsp:setProperty name="alCom" property="can15" value="<%=tempcan15%>"/>
<jsp:setProperty name="alCom" property="prod1" value="<%=tempprod1%>"/>
<jsp:setProperty name="alCom" property="prod2" value="<%=tempprod2%>"/>
<jsp:setProperty name="alCom" property="prod3" value="<%=tempprod3%>"/>
<jsp:setProperty name="alCom" property="prod4" value="<%=tempprod4%>"/>
<jsp:setProperty name="alCom" property="prod5" value="<%=tempprod5%>"/>
<jsp:setProperty name="alCom" property="prod6" value="<%=tempprod6%>"/>
<jsp:setProperty name="alCom" property="prod7" value="<%=tempprod7%>"/>
<jsp:setProperty name="alCom" property="prod8" value="<%=tempprod8%>"/>
<jsp:setProperty name="alCom" property="prod9" value="<%=tempprod9%>"/>
<jsp:setProperty name="alCom" property="prod10" value="<%=tempprod10%>"/>
<jsp:setProperty name="alCom" property="prod11" value="<%=tempprod11%>"/>
<jsp:setProperty name="alCom" property="prod12" value="<%=tempprod12%>"/>
<jsp:setProperty name="alCom" property="prod13" value="<%=tempprod13%>"/>
<jsp:setProperty name="alCom" property="prod14" value="<%=tempprod14%>"/>
<jsp:setProperty name="alCom" property="prod15" value="<%=tempprod15%>"/>

<% //System.out.println("envio información jsp al java");
int primero = 0;
primero=alCom.add_Orden_Compra(usuario);
//System.out.println(primero);
if(primero != -1){%>
				  <form method="post" target="_blank" name="RegN" action="Imprimir_Compra.jsp"> 
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
    <input type="hidden" name="claveOrden" value="<%=primero%>">
  	<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">	
	<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">	
	<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">	
	<input type="hidden" name="productoR1" value="<%=tempprod1%>">	
	<input type="hidden" name="productoR2" value="<%=tempprod2%>">	
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

<% }	else{

				out.print("Existió algún problema al guardar la Orden de Compra en la Base de Datos.");}
	%>
	
  </font></p>
<p align="center"> <a href="Menu_Compras.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></font></p>
<p align="center"></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
