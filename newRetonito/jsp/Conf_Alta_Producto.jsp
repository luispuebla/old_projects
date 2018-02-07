<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="pro" class="com.alpha.bd.ManagerPro" />
<jsp:useBean id="proveedor" class="com.alpha.bd.ManagerProveedores" />

<html>
<head>
<title>Producto Agregado</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
javascript:window.history.forward(1);

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
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 		
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String descripcion = "";
	String tipo = "0";
	String iva = "0";
	String mp = "0";
	String cortes = "0";
	String genero = "";
	String codBarras1 = "";
	String codBarras2 = "";
	String codBarras3 = "";
	String codBarras4 = "";
	String codBarras5 = "";
	String codBarras6 = "";
	String codBarras7 = "";
	String codBarras8 = "";
	String codBarras9 = "";
	String codBarras10 = "";
	String codBarras11 = "";
	String codBarras12 = "";
	String proveedor1 = "";	
	String proveedor2 = "";	
	String proveedor3 = "";
	String proveedor4 = "";
	String proveedor5 = "";
	String uniCompra = "";
	String preUniCompra = "0.00";
	String preCaCompra = "0.00";
	String piezasc = "";	
	String preKgCompra = "0.00";
	String kgXUni = "";
	String tipoPrecio = "";
	String manejo = "";
	String precioMenu = "0.00";
	String precioMenuC = "0.00";
	String precioMM = "0.00";
	String precioMMC = "0.00";	
	String precioM = "0.00";
	String precioMC = "0.00";
	String pieza1 = "1";
	String precioE1 = "0.00";
	String pieza2 = "";
	String precioE2 = "0.00";
	String pieza3 = "";
	String precioE3 = "0.00";
	String pieza4 = "";
	String precioE4 = "0.00";
	String pieza5 = "";
	String precioE5 = "0.00";
	String maxInv = "";
	String minInv = "";
	String invTienda = "0";
	String invAlmacen = "0";
	boolean bDescripcion = false;
	boolean bpiezasc = false;
	boolean bpreciop = false;
	boolean bprecioc = false;	
	boolean gpreciop = false;
	boolean gpreciopyc = false;
	boolean gprecioescalon = false;
	boolean codBarrasExi = false;
	boolean faltaProveedor = false;
	boolean faltanPreciosCompra = false;
	boolean faltaDatosCompraXKilo = false;
	boolean faltaPrecioCompraCaja = false;
	boolean inventarioInverso = false;
	boolean precioVentaMenorACompra = false;
	descripcion = request.getParameter("descripcion").trim();
	// Checo si mi descripcion viene vacia.
	if(descripcion.equalsIgnoreCase("")){
		bDescripcion = true;
	}	
	tipo = request.getParameter("tipo");
	if(request.getParameter("iva") != null){
		iva = request.getParameter("iva");
	}
	if(request.getParameter("mp") != null){
		mp = request.getParameter("mp");
	}
	if(request.getParameter("cortes") != null){
		cortes = request.getParameter("cortes");
	}
	genero = request.getParameter("genero");
	codBarras1 = request.getParameter("codBarras1").trim();
	codBarras2 = request.getParameter("codBarras2").trim();
	codBarras3 = request.getParameter("codBarras3").trim();
	codBarras4 = request.getParameter("codBarras4").trim();
	codBarras5 = request.getParameter("codBarras5").trim();
	codBarras6 = request.getParameter("codBarras6").trim();
	codBarras7 = request.getParameter("codBarras7").trim();
	codBarras8 = request.getParameter("codBarras8").trim();
	codBarras9 = request.getParameter("codBarras9").trim();
	codBarras10 = request.getParameter("codBarras10").trim();
	codBarras11 = request.getParameter("codBarras11").trim();
	codBarras12 = request.getParameter("codBarras12").trim();
	String validaCodigo = "";
	if(!codBarras1.trim().equalsIgnoreCase("")){
		validaCodigo += pro.codBarrasR(codBarras1);
	}
	if(!codBarras2.trim().equalsIgnoreCase("")){	
		validaCodigo += pro.codBarrasR(codBarras2);
	}
	if(!codBarras3.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras3);
	}
	if(!codBarras4.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras4);
	}
	if(!codBarras5.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras5);
	}
	if(!codBarras6.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras6);
	}
	if(!codBarras7.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras7);
	}
	if(!codBarras8.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras8);
	}		
	if(!codBarras9.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras9);
	}	
	if(!codBarras10.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras10);
	}	
	if(!codBarras11.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras11);
	}	
	if(!codBarras12.trim().equalsIgnoreCase("")){		
		validaCodigo += pro.codBarrasR(codBarras12);
	}	
	if(!(validaCodigo.equalsIgnoreCase(""))){
		codBarrasExi = true;
	}
	proveedor1 = request.getParameter("proveedor1");
	proveedor2 = request.getParameter("proveedor2");
	proveedor3 = request.getParameter("proveedor3");
	proveedor4 = request.getParameter("proveedor4");
	proveedor5 = request.getParameter("proveedor5");
	if(proveedor1.equals("") && proveedor2.equals("") && proveedor3.equals("")&& proveedor4.equals("")&& proveedor5.equals("")){
		faltaProveedor = true;
	}
	uniCompra = request.getParameter("uniCompra");
	if(request.getParameter("manejo") != null){
		manejo = request.getParameter("manejo");
	}	
	if(uniCompra.equals("1")){
		preUniCompra = request.getParameter("preUniCompra");		
		preCaCompra = request.getParameter("preCaCompra");
		piezasc = request.getParameter("piezasc");	
		if(pro.cambiaADouble(preUniCompra) <= 0.00 && pro.cambiaADouble(preCaCompra) <= 0.00){
			faltanPreciosCompra = true;
		}
		if(pro.cambiaADouble(preCaCompra) > 0.00 && pro.cambiaAInt(piezasc) <= 0){
			bpiezasc = true;
		}
		if(manejo.equals("1") && pro.cambiaAInt(piezasc) <= 0){
			bpiezasc = true;
		}
		if(pro.cambiaAInt(piezasc) > 0 && pro.cambiaADouble(preCaCompra) <= 0.00){
			faltaPrecioCompraCaja = true;
		}
	}
	else{
		preKgCompra = request.getParameter("preKgCompra");
		kgXUni = request.getParameter("kgXUni");
		if(pro.cambiaADouble(preKgCompra) <= 0.00 || pro.cambiaADouble(kgXUni) <= 0.00){
			faltaDatosCompraXKilo = true;
		}
	}
	tipoPrecio = request.getParameter("tipoPrecio");
	precioMenu = request.getParameter("precioMenu");
	if(pro.cambiaADouble(precioMenu) <= 0.00){
		bpreciop = true;
	}
	if(manejo.equals("1")){
		precioMenuC = request.getParameter("precioMenuC");
		if(pro.cambiaADouble(precioMenuC) <= 0.00){
			bprecioc = true;
		}
	}
	else if(manejo.equals("2")){
		precioMenuC = request.getParameter("precioMenuC");
		if(pro.cambiaADouble(precioMenuC) <= 0.00){
			bprecioc = true;
		}
	}
	maxInv = request.getParameter("maxInv");
	minInv = request.getParameter("minInv");
	invTienda = request.getParameter("invTienda");
	invAlmacen = request.getParameter("invAlmacen");
// Solo base...
	if(tipoPrecio.equals("0")){
		if(tipo.equals("0")){
			if(pro.cambiaADouble(preUniCompra) > 0){
				if(pro.cambiaADouble(precioMenu) < pro.cambiaADouble(preUniCompra)){
					precioVentaMenorACompra = true;			
				}
			}
			if(pro.cambiaADouble(preCaCompra) > 0 && manejo.equals("1")){
				if(pro.cambiaADouble(precioMenuC) < pro.cambiaADouble(preCaCompra)){
					precioVentaMenorACompra = true;			
				}		
			}	
		}
		else{
			if(pro.cambiaADouble(preKgCompra) > 0){
				if(pro.cambiaADouble(precioMenu) < pro.cambiaADouble(preKgCompra)){
					precioVentaMenorACompra = true;			
				}
			}
		}
	}
	
	// Grupo de Precios y Solo Piezas
	if(tipoPrecio.equalsIgnoreCase("1") && manejo.equalsIgnoreCase("0")){
		precioMM = request.getParameter("precioMM");
		precioM = request.getParameter("precioM");
		// Grupo de Precios por pieza incompleto
		if(pro.cambiaADouble(precioMM) <= 0 || pro.cambiaADouble(precioM) <= 0){
				gpreciop = true;
		}
		if(tipo.equals("0")){					
			if(pro.cambiaADouble(precioMenu) < pro.cambiaADouble(preUniCompra) || pro.cambiaADouble(precioMM) < pro.cambiaADouble(preUniCompra) || pro.cambiaADouble(precioM) < pro.cambiaADouble(preUniCompra)){
				precioVentaMenorACompra = true;
			}		
		}
		else{
			if(pro.cambiaADouble(precioMenu) < pro.cambiaADouble(preKgCompra) || pro.cambiaADouble(precioMM) < pro.cambiaADouble(preKgCompra) || pro.cambiaADouble(precioM) < pro.cambiaADouble(preKgCompra)){
				precioVentaMenorACompra = true;
			}				
		}
	}
	// Grupo de Precios y Piezas y Cajas.
	else if(tipoPrecio.equalsIgnoreCase("1") && manejo.equalsIgnoreCase("1")){
		precioMM = request.getParameter("precioMM");
		precioM = request.getParameter("precioM");
		precioMMC = request.getParameter("precioMMC");
		precioMC = request.getParameter("precioMC");
		// Grupo de Precios por pieza incompleto
		if(pro.cambiaADouble(precioMM) <= 0 || pro.cambiaADouble(precioM) <= 0){
				gpreciop = true;
		}
		// Grupo de Precios por caja incompleto
		if(pro.cambiaADouble(precioMMC) <= 0 || pro.cambiaADouble(precioMC) <= 0){
				gpreciopyc = true;
		}
		if(pro.cambiaADouble(precioMenu) < pro.cambiaADouble(preUniCompra) || pro.cambiaADouble(precioMM) < pro.cambiaADouble(preUniCompra) || pro.cambiaADouble(precioM) < pro.cambiaADouble(preUniCompra)){
			precioVentaMenorACompra = true;
		}
		if(pro.cambiaADouble(precioMenuC) < pro.cambiaADouble(preCaCompra) || pro.cambiaADouble(precioMMC) < pro.cambiaADouble(preCaCompra) || pro.cambiaADouble(precioMC) < pro.cambiaADouble(preCaCompra)){
			precioVentaMenorACompra = true;
		}
		
	}
	else if(tipoPrecio.equalsIgnoreCase("1") && manejo.equalsIgnoreCase("2")){
		precioMM = request.getParameter("precioMM");
		precioM = request.getParameter("precioM");
		precioMMC = request.getParameter("precioMMC");
		precioMC = request.getParameter("precioMC");
		// Grupo de Precios por pieza incompleto
		if(pro.cambiaADouble(precioMM) <= 0 || pro.cambiaADouble(precioM) <= 0){
				gpreciop = true;
		}
		// Grupo de Precios por caja incompleto
		if(pro.cambiaADouble(precioMMC) <= 0 || pro.cambiaADouble(precioMC) <= 0){
				gpreciopyc = true;
		}
		if(pro.cambiaADouble(precioMenu) < pro.cambiaADouble(preKgCompra) || pro.cambiaADouble(precioMM) < pro.cambiaADouble(preKgCompra) || pro.cambiaADouble(precioM) < pro.cambiaADouble(preKgCompra)){
			precioVentaMenorACompra = true;
		}
		if(pro.cambiaADouble(precioMenuC) < pro.cambiaADouble(preCaCompra) || pro.cambiaADouble(precioMMC) < pro.cambiaADouble(preCaCompra) || pro.cambiaADouble(precioMC) < pro.cambiaADouble(preCaCompra)){
			precioVentaMenorACompra = true;
		}		
	}
	else if(tipoPrecio.equalsIgnoreCase("2")){
		precioE1 = request.getParameter("precioE1");
		pieza2 = request.getParameter("pieza2");
		precioE2 = request.getParameter("precioE2");
		pieza3 = request.getParameter("pieza3");
		precioE3 = request.getParameter("precioE3");		
		pieza4 = request.getParameter("pieza4");
		precioE4 = request.getParameter("precioE4");
		pieza5 = request.getParameter("pieza5");
		precioE5 = request.getParameter("precioE5");
		if(pro.cambiaADouble(precioE1) <= 0){
			gprecioescalon = true;
		}
		if(pro.cambiaAInt(pieza2) <= 0 && pro.cambiaADouble(precioE2) > 0){
			gprecioescalon = true;
		}
		if(pro.cambiaAInt(pieza3) <= 0 && pro.cambiaADouble(precioE3) > 0){
			gprecioescalon = true;
		}
		if(pro.cambiaAInt(pieza4) <= 0 && pro.cambiaADouble(precioE4) > 0){
			gprecioescalon = true;
		}
		if(pro.cambiaAInt(pieza5) <= 0 && pro.cambiaADouble(precioE5) > 0){
			gprecioescalon = true;
		}
		if(pro.cambiaADouble(precioE1) > 0.00){
			if(pro.cambiaADouble(precioE1)  < pro.cambiaADouble(preUniCompra)){
				precioVentaMenorACompra = true;			
			}
		}
		if(pro.cambiaADouble(precioE2) > 0.00){
			if(pro.cambiaADouble(precioE2)  < pro.cambiaADouble(preUniCompra)){
				precioVentaMenorACompra = true;			
			}
		}
		if(pro.cambiaADouble(precioE3) > 0.00){
			if(pro.cambiaADouble(precioE3)  < pro.cambiaADouble(preUniCompra)){
				precioVentaMenorACompra = true;			
			}
		}
		if(pro.cambiaADouble(precioE4) > 0.00){
			if(pro.cambiaADouble(precioE4)  < pro.cambiaADouble(preUniCompra)){
				precioVentaMenorACompra = true;			
			}
		}
		if(pro.cambiaADouble(precioE5) > 0.00){
			if(pro.cambiaADouble(precioE5)  < pro.cambiaADouble(preUniCompra)){
				precioVentaMenorACompra = true;			
			}
		}
	}		
	if(pro.cambiaADouble(minInv) > pro.cambiaADouble(maxInv)){
		inventarioInverso = true;	
	}
	if(bDescripcion || bpreciop || bprecioc || gpreciop || gpreciopyc  || gprecioescalon || bpiezasc || codBarrasExi || faltaProveedor || faltanPreciosCompra || 	faltaDatosCompraXKilo || faltaPrecioCompraCaja || inventarioInverso || precioVentaMenorACompra){
%>
	<form name="regreso" target="_self" method="post" action="Alta_Producto.jsp">
	<b class="roj"><p>¡Error de información! posible(s) causa(s):<br/><br/></p></b>
	<%if(bDescripcion){%> * Falta la descripción del Producto.<br> <%}%>	
	<%if(codBarrasExi){%> * Ya existe otro producto registrado con el mismo C&oacute;digo de Barras <br /><%=validaCodigo%>.<br> <%}%>		
	<%if(faltaProveedor){%> * Debes espec&iacute;ficar al menos un proveedor.<br> <%}%>	
	<%if(faltanPreciosCompra){%> * Faltan por introducir el/los precios de compra por Unidad y/o por Caja.<br> <%}%>			
	<%if(faltaPrecioCompraCaja){%> * Si se especifican Unidades por Caja es indispensable el Precio por Caja<br> <%}%>	
	<%if(bpiezasc){%> *	Se solicit&oacute; manejo por caja y no se especifico la piezas por caja.<br> <%}%>		
	<%if(faltaDatosCompraXKilo){%> * Falta al menos uno de los datos de Compra por Pieza de Kilo (Unidad y Kg. por Unidad)<br> <%}%>		
	<%if(bpreciop){%> *	Falt&oacute; el precio Base por pieza.<br> <%}%>
	<%if(bprecioc){%> 
	*	Se solicit&oacute; manejo por Caja/Piezas y falta el precio Base por Caja/Pieza.<br> <%}%>	
	<%if(gpreciop){%> *	Se solicit&oacute; Grupo de Precios y falta especificar al menos un Grupo de Precio por pieza, o es igual a 0.<br> <%}%>	
	<%if(precioVentaMenorACompra){%> *	Por lo menos uno de los precios de Venta es Menor al precio de Compra, modifiquelo.<br> <%}%>	
	<%if(gpreciopyc){%> 
	* Se solicit&oacute; Grupo de Precios por Unidad/Kg. y Caja/Pieza y falta llenar un campo de Grupo por Caja/Pieza, o es igual a 0.<br> <%}%>
	<%if(gprecioescalon){%> * Esta mal configurada la lista de precios escalonados.<br> <%}%>	
	<%if(inventarioInverso){%> * No puede ser el M&iacute;nimo en Inventario superior al M&aacute;ximo en Inventario<br> <%}%>		
	
	<br/>De un click al bot&oacute;n de Volver para corregir y/o completar la informaci&oacute;n.<br/>
	<input type="hidden" name="interino" value="">
	<input type="hidden" name="descripcion" value="<%=descripcion%>">
	<input type="hidden" name="tipo" value="<%=tipo%>">
	<input type="hidden" name="iva" value="<%=iva%>">
	<input type="hidden" name="mp" value="<%=mp%>">
	<input type="hidden" name="cortes" value="<%=cortes%>">		
	<input type="hidden" name="genero" value="<%=genero%>">	
	<input type="hidden" name="codBarras1" value="<%=codBarras1 %>">
	<input type="hidden" name="codBarras2" value="<%=codBarras2 %>">
	<input type="hidden" name="codBarras3" value="<%=codBarras3 %>">
	<input type="hidden" name="codBarras4" value="<%=codBarras4 %>">
	<input type="hidden" name="codBarras5" value="<%=codBarras5 %>">
	<input type="hidden" name="codBarras6" value="<%=codBarras6 %>">
	<input type="hidden" name="codBarras7" value="<%=codBarras7 %>">
	<input type="hidden" name="codBarras8" value="<%=codBarras8 %>">
	<input type="hidden" name="codBarras9" value="<%=codBarras9 %>">
	<input type="hidden" name="codBarras10" value="<%=codBarras10 %>">
	<input type="hidden" name="codBarras11" value="<%=codBarras11 %>">
	<input type="hidden" name="codBarras12" value="<%=codBarras12 %>">	
	<input type="hidden" name="proveedor1" value="<%=proveedor1 %>">
	<input type="hidden" name="proveedor2" value="<%=proveedor2 %>">
	<input type="hidden" name="proveedor3" value="<%=proveedor3 %>">			
	<input type="hidden" name="proveedor4" value="<%=proveedor4 %>">			
	<input type="hidden" name="proveedor5" value="<%=proveedor5 %>">			
	<input type="hidden" name="uniCompra" value="<%=uniCompra%>">
	<% if(uniCompra.equals("1")){%>	
		<input type="hidden" name="preUniCompra" value="<%=preUniCompra%>">
		<input type="hidden" name="preCaCompra" value="<%=preCaCompra%>">
		<input type="hidden" name="piezasc" value="<%=piezasc%>">
	<% } else{ %>
		<input type="hidden" name="preKgCompra" value="<%=preKgCompra%>">
		<input type="hidden" name="kgXUni" value="<%=kgXUni%>">	
	<% } %>	
	<input type="hidden" name="tipoPrecio" value="<%=tipoPrecio %>">
	<input type="hidden" name="manejo" value="<%=manejo %>">
	<input type="hidden" name="precioMenu" value="<%=precioMenu %>">
	<% if(manejo.equalsIgnoreCase("1") || manejo.equalsIgnoreCase("2")){%>
		<input type="hidden" name="precioMenuC" value="<%=precioMenuC %>">
	<%} if (tipoPrecio.equalsIgnoreCase("1")){%>
		<input type="hidden" name="precioMM" value="<%=precioMM %>">
		<input type="hidden" name="precioM" value="<%=precioM %>">
	<%} if(tipoPrecio.equalsIgnoreCase("1") && (manejo.equalsIgnoreCase("1")) || (manejo.equalsIgnoreCase("2"))){%>		
		<input type="hidden" name="precioMMC" value="<%=precioMMC %>">
		<input type="hidden" name="precioMC" value="<%=precioMC %>">
	<% } if (tipoPrecio.equalsIgnoreCase("2")){%>		
		<input type="hidden" name="precioE1" value="<%=precioE1 %>">
		<input type="hidden" name="pieza2" value="<%=pieza2 %>">
		<input type="hidden" name="precioE2" value="<%=precioE2 %>">
		<input type="hidden" name="pieza3" value="<%=pieza3 %>">
		<input type="hidden" name="precioE3" value="<%=precioE3 %>">
		<input type="hidden" name="pieza4" value="<%=pieza4 %>">
		<input type="hidden" name="precioE4" value="<%=precioE4 %>">
		<input type="hidden" name="pieza5" value="<%=pieza5 %>">
		<input type="hidden" name="precioE5" value="<%=precioE5 %>">
	<% } %>
	<input type="hidden" name="maxInv" value="<%=maxInv%>">
	<input type="hidden" name="minInv" value="<%=minInv%>">
	<input type="hidden" name="invTienda" value="<%=invTienda%>">			
	<input type="hidden" name="invAlmacen" value="<%=invAlmacen%>">			
	<br/>
	<input type="submit" value="Volver" name="Volver">
	</form>
<%	
	}
	// Datos bien!, voy a almacenar
	else{	
		if(tipoPrecio.equalsIgnoreCase("0")){
			precioMM = precioMenu;
			precioM = precioMenu;
			precioMMC = precioMenuC;
			precioMC = precioMenuC;
		}
		int claveProducto = pro.add_Producto(descripcion, tipo, iva, genero, mp, cortes, codBarras1, codBarras2, codBarras3, codBarras4, codBarras5, codBarras6, codBarras7, codBarras8, codBarras9, codBarras10, codBarras11, codBarras12, proveedor1, proveedor2, proveedor3, proveedor4, proveedor5, uniCompra, preUniCompra, preCaCompra, piezasc,preKgCompra, kgXUni, tipoPrecio, manejo, precioMenu, precioMenuC, precioMM, precioMMC, precioM, precioMC, pieza1, precioE1, pieza2, precioE2, pieza3, precioE3, pieza4, precioE4, pieza5, precioE5, maxInv, minInv,invTienda, invAlmacen);
		if(claveProducto == 0){
%>		
			<b class="roj">ERROR AL ALMACENAR PRODUCTO, VERIFIQUE LA BASE DE DATOS.</b>
<%			
		}
		else if(claveProducto == -1){
%>		
	<form name="regreso" target="_self" method="post" action="Alta_Producto.jsp">
	<b class="roj">ERROR DE DUPLICIDAD EN CODIGO DE BARRAS, VERIFIQUE REPETICIÓN DE CODIGO DE BARRAS.</b>
	<br/>De un click al bot&oacute;n de Volver para corregir y/o completar la informaci&oacute;n.<br/>
	<input type="hidden" name="interino" value="">
	<input type="hidden" name="descripcion" value="<%=descripcion%>">
	<input type="hidden" name="tipo" value="<%=tipo%>">
	<input type="hidden" name="iva" value="<%=iva%>">
	<input type="hidden" name="mp" value="<%=mp%>">
	<input type="hidden" name="cortes" value="<%=cortes%>">
	<input type="hidden" name="genero" value="<%=genero%>">	
	<input type="hidden" name="codBarras1" value="<%=codBarras1 %>">
	<input type="hidden" name="codBarras2" value="<%=codBarras2 %>">
	<input type="hidden" name="codBarras3" value="<%=codBarras3 %>">
	<input type="hidden" name="codBarras4" value="<%=codBarras4 %>">
	<input type="hidden" name="codBarras5" value="<%=codBarras5 %>">
	<input type="hidden" name="codBarras6" value="<%=codBarras6 %>">
	<input type="hidden" name="codBarras7" value="<%=codBarras7 %>">
	<input type="hidden" name="codBarras8" value="<%=codBarras8 %>">
	<input type="hidden" name="codBarras9" value="<%=codBarras9 %>">
	<input type="hidden" name="codBarras10" value="<%=codBarras10 %>">
	<input type="hidden" name="codBarras11" value="<%=codBarras11 %>">
	<input type="hidden" name="codBarras12" value="<%=codBarras12 %>">	
	<input type="hidden" name="proveedor1" value="<%=proveedor1 %>">
	<input type="hidden" name="proveedor2" value="<%=proveedor2 %>">
	<input type="hidden" name="proveedor3" value="<%=proveedor3 %>">			
	<input type="hidden" name="proveedor4" value="<%=proveedor4 %>">			
	<input type="hidden" name="proveedor5" value="<%=proveedor5 %>">			
	<input type="hidden" name="uniCompra" value="<%=uniCompra%>">
	<% if(uniCompra.equals("1")){%>	
		<input type="hidden" name="preUniCompra" value="<%=preUniCompra%>">
		<input type="hidden" name="preCaCompra" value="<%=preCaCompra%>">
		<input type="hidden" name="piezasc" value="<%=piezasc%>">
	<% } else{ %> 
		<input type="hidden" name="preKgCompra" value="<%=preKgCompra%>">
		<input type="hidden" name="kgXUni" value="<%=kgXUni%>">	
	<% } %>	
	<input type="hidden" name="tipoPrecio" value="<%=tipoPrecio %>">
	<input type="hidden" name="manejo" value="<%=manejo %>">
	<input type="hidden" name="precioMenu" value="<%=precioMenu %>">
	<% if(manejo.equalsIgnoreCase("1") || manejo.equalsIgnoreCase("2")){%>
		<input type="hidden" name="precioMenuC" value="<%=precioMenuC %>">
	<%} if (tipoPrecio.equalsIgnoreCase("1")){%>
		<input type="hidden" name="precioMM" value="<%=precioMM %>">
		<input type="hidden" name="precioM" value="<%=precioM %>">
	<%} if(tipoPrecio.equalsIgnoreCase("1") && (manejo.equalsIgnoreCase("1")) || (manejo.equalsIgnoreCase("2"))){%>		
		<input type="hidden" name="precioMMC" value="<%=precioMMC %>">
		<input type="hidden" name="precioMC" value="<%=precioMC %>">
	<% } if (tipoPrecio.equalsIgnoreCase("2")){%>		
		<input type="hidden" name="precioE1" value="<%=precioE1 %>">
		<input type="hidden" name="pieza2" value="<%=pieza2 %>">
		<input type="hidden" name="precioE2" value="<%=precioE2 %>">
		<input type="hidden" name="pieza3" value="<%=pieza3 %>">
		<input type="hidden" name="precioE3" value="<%=precioE3 %>">
		<input type="hidden" name="pieza4" value="<%=pieza4 %>">
		<input type="hidden" name="precioE4" value="<%=precioE4 %>">
		<input type="hidden" name="pieza5" value="<%=pieza5 %>">
		<input type="hidden" name="precioE5" value="<%=precioE5 %>">
	<% } %>
	<input type="hidden" name="maxInv" value="<%=maxInv%>">
	<input type="hidden" name="minInv" value="<%=minInv%>">
	<input type="hidden" name="invTienda" value="<%=invTienda%>">			
	<input type="hidden" name="invAlmacen" value="<%=invAlmacen%>">			
	<br/>
	<input type="submit" value="Volver" name="Volver">
	</form>			
<%			
		}
		
		else{
%>		
			<h1>Alta de producto exitosa </h1>
			<div align="center"><b class="aviso"> N&uacute;mero de clave asignada: <%=claveProducto%> </b></div><br/>
  <table align="center" cellpadding="0" cellspacing="0" width="750" border="0">
  	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Genéricos</b></caption>
		  	<tr>
			  <th colspan="2">Nombre Producto:</th>
			  <td colspan="2"><div align="center"><%=descripcion%></div></td>				
			  <th width="22%">Tipo de Producto:</th>
			  <td width="18%"> <div align="center"> <% if(tipo.equals("0")){%> Por Unidad <%}else{%> Por Pesaje <%}%> </div></td>
			</tr>			
		  	<tr>
			  <th colspan="2">Grava I.V.A.:</th>
			  <td width="15%"><div align="center"> <% if(iva.equalsIgnoreCase("1")){%> S&iacute;<%} else{%> No <%}%> </div></td>
			  <th colspan="2">Genero de Producto:</th>
			  <td> <div align="center"> <%if(genero.equalsIgnoreCase("1")){%> Cremer&iacute;a <%} else if(genero.equals("2")){%>Refresco <%} else{%> Abarrote <%}%> </div></td>
			<tr>
		  	<tr>
			  <th colspan="2">Materia Prima:</th>
			  <td><div align="center"> <% if(mp.equalsIgnoreCase("1")){%> S&iacute;<%} else{%> No <%}%> </div></td>
			  <th colspan="2">Producto Reto&ntilde;o:</th>
			  <td><div align="center"> <% if(cortes.equalsIgnoreCase("1")){%> S&iacute;<%} else{%> No <%}%> </div></td>
			<tr>
		      <th colspan="6" bgcolor="#CCCCCC"> -- S&aacute;bana de C&oacute;digos de Barras -- </th>			  
			</tr>	
			<tr>
			  <th width="13%">Código #1:</th>
			  <td width="15%"><div align="center"><% if(codBarras1.equals("")){ %>&nbsp; <%}else{%> <%=codBarras1%> <%}%></div></td>
			  <th>Código #2:</th>
			  <td width="17%"><div align="center"><% if(codBarras2.equals("")){ %>&nbsp; <%}else{%> <%=codBarras2%> <%}%></div></td>
			  <th>Código #3:</th>
			  <td><div align="center"><% if(codBarras3.equals("")){ %>&nbsp; <%}else{%> <%=codBarras3%> <%}%></div></td>
			</tr>
			<tr>
			  <th>Código #4:</th>
			  <td><div align="center"><% if(codBarras4.equals("")){ %>&nbsp; <%}else{%> <%=codBarras4%> <%}%></div></td>
			  <th>Código #5:</th>
			  <td><div align="center"><% if(codBarras5.equals("")){ %>&nbsp; <%}else{%> <%=codBarras5%> <%}%></div></td>
			  <th>Código #6:</th>
			  <td><div align="center"><% if(codBarras6.equals("")){ %>&nbsp; <%}else{%> <%=codBarras6%> <%}%></div></td>
			</tr>
			<tr>
			  <th>Código #7:</th>
			  <td><div align="center"><% if(codBarras7.equals("")){ %>&nbsp; <%}else{%> <%=codBarras7%> <%}%></div></td>
			  <th>Código #8:</th>
			  <td><div align="center"><% if(codBarras8.equals("")){ %>&nbsp; <%}else{%> <%=codBarras8%> <%}%></div></td>
			  <th>Código #9:</th>
			  <td><div align="center"><% if(codBarras9.equals("")){ %>&nbsp; <%}else{%> <%=codBarras9%> <%}%></div></td>
			</tr>
			<tr>
			  <th>Código #10:</th>
			  <td><div align="center"><% if(codBarras10.equals("")){ %>&nbsp; <%}else{%> <%=codBarras10%> <%}%></div></td>
			  <th>Código #11:</th>
			  <td><div align="center"><% if(codBarras11.equals("")){ %>&nbsp; <%}else{%> <%=codBarras11%> <%}%></div></td>
			  <th>Código #12:</th>
			  <td><div align="center"><% if(codBarras12.equals("")){ %>&nbsp; <%}else{%> <%=codBarras12%> <%}%></div></td>
			</tr>
		  </table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Compra</b></caption>
		  	<tr>
			  <th colspan="3">Proveedor 1:</th>
			  <td colspan="3"><div align="center"><%if(proveedor1.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor1)%> <%}%></div></td>
			</tr>		 
		  	<tr>
			  <th colspan="3">Proveedor 2:</th>
			  <td colspan="3"><div align="center"><%if(proveedor2.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor2)%> <%}%></div></td>
			</tr>		 
		  	<tr>
			  <th colspan="3">Proveedor 3:</th>
			  <td colspan="3"><div align="center"><%if(proveedor3.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor3)%> <%}%></div></td>
			</tr>
		  	<tr>
			  <th colspan="3">Proveedor 4:</th>
			  <td colspan="3"><div align="center"><%if(proveedor4.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor4)%> <%}%></div></td>
			</tr>
		  	<tr>
			  <th colspan="3">Proveedor 5:</th>
			  <td colspan="3"><div align="center"><%if(proveedor5.equals("")){%>No asignado<%} else{%> <%=proveedor.nombreProveedor(proveedor5)%> <%}%></div></td>
			</tr>
			<tr>
			  <th colspan="3">Formato de Compra:</th>
			  <td colspan="3"><div align="center"> <% if(uniCompra.equals("1")){%>Por pieza y/o Caja<%} else{ %> Por pieza de Kilogramo <%}%> </div> </td>
			</tr> 
<%			if(uniCompra.equals("1")){ %>					
			<tr>
			  <th colspan="6">-- Compra por Unidad y/o Caja -- </th>
			</tr>			  
			<tr>
				<th>Precio por Unidad:</th>
				<td><div align="center"> <% if (pro.cambiaADouble(preUniCompra) <= 0){%> No aplica <%} else{ %> $ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(preUniCompra)+""))%> <%}%></div></td>
				<th>Precio por Caja:</th>
				<td><div align="center"> <% if (pro.cambiaADouble(preCaCompra) <= 0){%> No aplica <%} else{ %> $ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(preCaCompra)+""))%> <%}%> </div></td>
				<th>Unidades por Caja:</th>
				<td><div align="center">  <% if (pro.cambiaAInt(piezasc) <= 0){%> No aplica <%} else{ %> <%=pro.cambiaAInt(piezasc)%> <%}%> </div></td>
		 	</tr>
<%			} else { %>				
			<tr>
			  <th colspan="6">-- Compra por Pieza de Kilo -- </th>
			</tr>			  
			<tr>
			  <th colspan="2">Precio de 1 Kg.:</th>
				<td><div align="center"> $ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(preKgCompra)+""))%> </div></td>
			  <th colspan="2">Kilos por Pieza:</th>
				<td><div align="center"> <%=pro.cambiaADouble(kgXUni)%> </div></td>
		 	</tr>		
<%			} %>					
		  </table>
		</td>	
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>	
	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Venta</b></caption>

		  	<tr>
      		  <th colspan="2">Tipo de Precio: </th>
			  
			  <td width="14%"><div align="center"> <% if(tipoPrecio.equals("0")){%>Solo Base<%} else if(tipoPrecio.equals("1")){ %>Grupo de Precios<%} else{%>Escalonado<%}%></div> </td>
			  <th colspan="2">Manejo de Precio:</th>
			  <td width="31%"><div align="center"> <% if(manejo.equals("0")){%>
			  Solo por unidad o Kg.
			      <%} else if(manejo.equals("1")){ %> Por unidad y Caja <%} else{%>Por Kg. y Pieza <%}%> </div> </td>
			</tr>
<%			if(manejo.equals("0")){ %>			
    		<tr>
			  <th colspan="4">Precio Base<br />(Unidad / 1Kg.):</th>
			  <td colspan="2"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMenu)+""))%> </div></td>
			 </tr>
<%			} else { %>			  
			<tr>
			  <th colspan="2">Precio Menudeo <br />
			    (Unidad / 1Kg.):</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMenu)+""))%> </div></td>
			  <th colspan="2">Precio Menudeo<br/> (Caja / Pieza):</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMenuC)+""))%> </div></td>
			</tr>
<%			} if(tipoPrecio.equals("1")){%>			
    		<tr>
			  <th colspan="6"><div align="center">-- Grupo de Precios --</div></th>
			</tr>
<%				if(manejo.equals("0")){ %>
			<tr>
			  <th colspan="4">Precio Medio Mayoreo :<br/>
			  (Unidad /1Kg)</th>
			  <td colspan="2"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMM)+""))%> </div></td>
		    </tr>
			 <tr>
			  <th colspan="4">Precio  Mayoreo:<br/>
		       			    (Unidad /1Kg)</th>
			  <td colspan="2"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioM)+""))%> </div></td>
			 </tr>
<%				} else{ %>
			<tr>
			  <th colspan="2">Precio Medio Mayoreo:<br/>			    
		      (Unidad /1Kg)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMM)+""))%> </div></td>
			  <th colspan="2">Precio Medio Mayoreo:<br/> 
			  (Caja / Pieza)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMMC)+""))%> </div></td>
		    </tr>
			 <tr>
			  <th colspan="2">Precio  Mayoreo:<br/>			    
		       (Unidad /1Kg)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioM)+""))%> </div></td>
			  <th colspan="2">Precio  Mayoreo:<br/>		        
		       (Caja / Pieza)</th>
			  <td><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioMC)+""))%> </div></td>
			 </tr>
<%				}	
			}	else if(tipoPrecio.equals("2")){%>						
			<tr>
			  <th colspan="6" bgcolor="#CCCCCC">-- Precios Escalonados --</th>
			</tr>
			<tr>
			  <th colspan="3" bgcolor="#CCCCCC">Cantidad Unidades / Kg:</th>
			  <th colspan="3" bgcolor="#CCCCCC">Precio:</th>
			</tr>
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza1)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE1)+""))%></div></td>
			</tr>
<%				if(pro.cambiaAInt(pieza2) > 0 ){ %>
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza2)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE2)+""))%></div></td>
			</tr>
<%				}
				if(pro.cambiaAInt(pieza3) > 0 ){ %>			
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza3)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE3)+""))%></div></td>
			</tr>
<%				}
				if(pro.cambiaAInt(pieza4) > 0 ){ %>						
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza4)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE4)+""))%></div></td>
			</tr>
<%				}
				if(pro.cambiaAInt(pieza5) > 0 ){ %>						
			<tr>
			  <td colspan="3"><div align="center"><%=pro.cambiaAInt(pieza5)%>
		        </div>
		      </div></td>
			  <td colspan="3"><div align="center">$ <%=pro.formatoDinero(pro.acortaLongitud(pro.cambiaADouble(precioE5)+""))%></div></td>
			</tr>			
<%			}}  %>			
		  </table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>	
	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Inventario</b></caption>
		  	<tr>
			  <th>M&aacute;ximo:</th>
			  <td><div align="center"><%=pro.cambiaADouble(maxInv)%> Unidades/Kg.</div></td>
			  <th>M&iacute;nimo:</th>
			  <td><div align="center"><%=pro.cambiaADouble(minInv)%> Unidades/Kg.</div></td>
			</tr>
			<tr valign="bottom" >
			  <th rowspan="2" colspan="2" >Existencia Actual:<br />			  </th>
			  <th>En Tienda</th>
			  <th>En Almacen</th>
			</tr>			
			<tr>
			  <td><div align="center"><%=pro.cambiaADouble(invTienda)%> Unidades/Kg.</div></td>			  
			  <td><div align="center"><%=pro.cambiaADouble(invAlmacen)%> Unidades/Kg.</div></td>			  							
			</tr>
		  </table>
		</td>
	</tr>  
  </table>			
<%	
		}
	}
%>
<p><a href="Menu_Productos.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
