<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.text.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Alta Venta</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){	
	f.submit();
}

function setFocus(){
	var contenido = document.ph.clienteC.options[0].text;
	if(contenido == "SELECCIONE"){
		document.ph.clienteC.focus();
	}
	else if(document.ph1 != null){
		if(ph1.elements[ph1.length - 26].value==""){		
			ph1.elements[ph1.length - 25].focus();
		}
		else if (ph1.elements[ph1.length-24].value=="0"){
			ph1.elements[ph1.length-24].select();
		}
		else if (ph1.elements[ph1.length-14].value !="" && ph1.elements[ph1.length-12].value == "0"){
			ph1.elements[ph1.length-12].select();
		}
		else if (ph1.elements[ph1.length-10].value !="" && ph1.elements[ph1.length-8].value == "0"){
			ph1.elements[ph1.length-8].select();
		}
		else if (ph1.elements[ph1.length-6].value !="" && ph1.elements[ph1.length-4].value == "0"){
			ph1.elements[ph1.length-4].select();
		}
		else{
			ph1.elements[ph1.length-13].focus();
		}
	}
	else{
		document.ph.clienteC.focus();
	}
}

function formatCurrency(num) {
num = num.toString().replace(/\$|\,/g,'');
if(isNaN(num))
num = "0";
sign = (num == (num = Math.abs(num)));
num = Math.floor(num*100+0.50000000001);
cents = num%100;
num = Math.floor(num/100).toString();
if(cents<10)
cents = "0" + cents;
for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
num = num.substring(0,num.length-(4*i+3))+','+
num.substring(num.length-(4*i+3));
return (((sign)?'':'-') + num + '.' + cents);
}

function seleccionaTodo(objeto){
	objeto.select();
}

function regresaFoco(cantidadP){
	cantidadP.select();
}

function verificaSobreInv(existe, pide, producto, importe, costo){
	var Existe = new Number();
	var Pide = new Number();
	Existe = existe.value;
	Pide = pide.value;
	if (isNaN(Existe)){
		Existe = 0;
	}
	if (isNaN(Pide)){
		Pide = 0;
	}
	if((Existe-Pide)<0){
		alert ("Sobrepasas la Cantidad Existente en Inventario para el Producto: \n\t" +producto.value);
		pide.value="0";
		importe.value="0";
		pide.select();
	}
}

function verificaInvOb(pide, producto, existe){
	var Producto = new String();
	Producto = producto.value;
	if(Producto.length != 0){
		var Existe = new Number();
		var Pide = new Number();
		Existe = existe.value;
		Pide = pide.value;
		if (isNaN(Existe)){
			Existe = 0;
		}
		if (isNaN(Pide)){
			Pide = 0;
		}
		if((Existe-Pide)<0){
			alert ("Sobrepasas la Cantidad Existente en Inventario\n para el Producto Obsequiado: \n\t" +producto.value);
			pide.value="0";
			pide.select();			
		}	
	}
	else{
		pide.value = "";
	}
}

function recalculaValor(cantidad, precio, total, producto){
	var Unidad = new Number();
	Unidad = cantidad.value;
	if (isNaN(Unidad)){
		Unidad = 0;
	}
	if (Unidad == 0){
		producto.value = "";
		MandaSubmit(document.ph1)
	}
	var SPrecio = new String();
	SPrecio = precio.value;
	re = /,/gi;
	SPrecio = SPrecio.replace(re,"");
	var Precio = new Number();
	Precio = SPrecio;
	var Total = new Number();
	Total = Unidad * Precio;
	Total = roundOff(Total);
	total.value = formatCurrency(Total);
}

function roundOff(value){
	value = "" + value //convierte value a string
	var precision = 2;	
	var whole = "" + Math.round(value * Math.pow(10, precision));	
	var decPoint = whole.length - precision;
	if(decPoint != 0) {
		result = whole.substring(0, decPoint);
		result += ".";
		result += whole.substring(decPoint, whole.length);
	}
	else {
		result = 0;
		result += ".";
		result += whole.substring(decPoint, whole.length);
	}
	return result;
}

function OnSubmitForm(){
	if(document.pressed == 'Guardar')   {
		//alert("Caso 1 Guardar");
		document.ph1.action ="Conf_Alta_Venta.jsp";
	}
	else if(document.pressed == 'Aumentar')   {
		document.ph1.action ="Alta_Venta.jsp";
	}
	else{
		var kiko = document.pressed.name;
		if(kiko == 'productoR1' || kiko == 'productoR2' || kiko == 'productoR3'){
			document.ph1.action ="ListadoVentaO.jsp?"+kiko;
		}
		else if(kiko != '') {		
			document.ph1.action ="ListadoVenta.jsp?"+kiko;
		}
	}
	return true;
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
//System.out.println("1");
	String cantidadExistente1 = "";
	String cantidadExistente2 = "";
	String cantidadExistente3 = "";		
	String numProductos = "1";
	int cantNumProductos = 1;
	int cantidadProd = 0;
	String idProducto = "";
	String cliente = "";
	boolean haySaldo = true;
	String tempprod1 = "";
	String tempprod2 = "";
	String tempprod3 = "";
	String tempcan1 = "";
	String tempcan2 = "";
	String tempcan3 = "";
	String numFac = "";
	String documento = "";
	
	if(request.getParameter("documento")!= null){
		documento = request.getParameter("documento");
	}
	if(request.getParameter("numFac")!= null){
		numFac = request.getParameter("numFac");
	}
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
	if(!(tempprod2.equals(""))){
		if (tempprod2.equals(tempprod1)){
			tempprod2 = "";
			tempcan2 = "";
		}
	}
	if(!(tempprod3.equals(""))){
		if (tempprod3.equals(tempprod1) || tempprod3.equals(tempprod2) ){
			tempprod3 = "";
			tempcan3 = "";
		}
	}
	
	if(request.getParameter("numProductos")!= null){
		numProductos = request.getParameter("numProductos");
		cantNumProductos = alVen.cambiaAInt(numProductos);		
	}
	if(request.getParameter("clienteC") != null){
		cliente = request.getParameter("clienteC"); 
	}	
	
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];

// CHECO QUE VENGA DE LA PAGINA DE LISTADO Y QUE AL MENOS TRAIGA UN PRODUCTO	
	if (request.getParameter("cantidadProd") != null && !(request.getParameter("cantidadProd").equals("1"))){
		cantidadProd = alVen.cambiaAInt(request.getParameter("cantidadProd"));
		int productosSeleccionados = 0;
		for(int i = 1; i<=cantidadProd; i++){
			if(request.getParameter("rg1"+i) != null){
				productosSeleccionados ++;
			}
		}
		int nuevoTamanioArray = productosSeleccionados+cantNumProductos;
		ArrayCantidad   = new String[nuevoTamanioArray+1]; //  Aumento 1 para facilitar el manejo del arreglo.
		ArrayProducto   = new String[nuevoTamanioArray+1];
		ArrayCUnidad   = new String[nuevoTamanioArray+1];
		ArrayImporte   = new String[nuevoTamanioArray+1];
// LLENO MIS ARREGLOS CORRESPONDIENTES:	
		for(int i = 1; i<=cantNumProductos; i++){
			ArrayCantidad[i] = request.getParameter("cantidad"+i);
			ArrayProducto[i] = request.getParameter("producto"+i);
			ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
			ArrayImporte[i] = request.getParameter("importe"+i);
		}
		for(int i = 1; i<=cantidadProd; i++){
			if(request.getParameter("rg1"+i) != null){
				String claveProducto = request.getParameter("rg1"+i);
// BUSCO SI ESTA REPETIDO EN ESE CASO NO HAGO NADA.
				boolean repetido = false;
				for(int j=1; j<=cantNumProductos-2; j++){
					if(ArrayProducto[j].equalsIgnoreCase(claveProducto)){
						repetido = true;
					}
				}
				if(!repetido){
					ArrayProducto[cantNumProductos] = claveProducto;
					ArrayCUnidad[cantNumProductos] = alVen.formatoDinero(alVen.precioProducto(claveProducto, cliente));
					String piezas = ArrayCantidad[cantNumProductos];
					double multiplicados = (alVen.cambiaADouble(alVen.remueveComas((ArrayCUnidad[cantNumProductos]))) * alVen.cambiaADouble(piezas));
					NumberFormat nf = NumberFormat.getInstance();
					String numeritolargo = nf.format(multiplicados);
					ArrayImporte[cantNumProductos] = numeritolargo;
				}
				cantNumProductos++;				
			}
		}
		cantNumProductos--;						
	}
	
	else {	
		int contadorCeroInterno = 0;	
		if(request.getParameter("idProducto")!= null){
//		System.out.println("query: "+request.getParameter("idProducto"));
			if(request.getParameter("idProducto").equalsIgnoreCase("R1") || request.getParameter("idProducto").equalsIgnoreCase("R2") || request.getParameter("idProducto").equalsIgnoreCase("R3")){
				if(request.getParameter("idProducto").equalsIgnoreCase("R1")){
					tempprod1 = request.getParameter("rg1");
					tempprod1 = tempprod1.substring(0,tempprod1.length()); 	
				}	
				if(request.getParameter("idProducto").equalsIgnoreCase("R2")){
					tempprod2 = request.getParameter("rg1");	
					tempprod2 = tempprod2.substring(0,tempprod2.length()); 						
				}	
				if(request.getParameter("idProducto").equalsIgnoreCase("R3")){
					tempprod3 = request.getParameter("rg1");	
					tempprod3 = tempprod3.substring(0,tempprod3.length()); 
					}
				// VERIFICO QUE NO ME REPITAN REGALO.
				if(!(tempprod2.equals(""))){
					if (tempprod2.equals(tempprod1)){
						tempprod2 = "";
						tempcan2 = "";
					}
				}
				if(!(tempprod3.equals(""))){
					if (tempprod3.equals(tempprod1) || tempprod3.equals(tempprod2) ){
						tempprod3 = "";
						tempcan3 = "";
					}
				}
			}
		}
		if(request.getParameter("producto"+(cantNumProductos-1)) != null && ! request.getParameter("producto"+(cantNumProductos-1)).equals("")){
			ArrayCantidad   = new String[cantNumProductos+1]; //  Aumento 1 para facilitar el manejo del arreglo.
			ArrayProducto   = new String[cantNumProductos+1];
			ArrayCUnidad   = new String[cantNumProductos+1];
			ArrayImporte   = new String[cantNumProductos+1];	
			for(int i = 1; i<=cantNumProductos; i++){
				if(request.getParameter("producto"+i)!= null && ! request.getParameter("cantidad"+i).equals("0") && ! request.getParameter("producto"+i).equals("")){
					ArrayCantidad[i] = request.getParameter("cantidad"+i);
					ArrayProducto[i] = request.getParameter("producto"+i);
					ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
					ArrayImporte[i] = request.getParameter("importe"+i);
				}
				else if (request.getParameter("producto"+i)!= null){
					contadorCeroInterno++;
				}
			}
		}
		else if (request.getParameter("producto"+(cantNumProductos-1)) != null){
			cantNumProductos--;
			cantNumProductos--;
			ArrayCantidad   = new String[cantNumProductos+1]; //  Aumento 1 para facilitar el manejo del arreglo.
			ArrayProducto   = new String[cantNumProductos+1];
			ArrayCUnidad   = new String[cantNumProductos+1];
			ArrayImporte   = new String[cantNumProductos+1];	
			for(int i = 1; i<=cantNumProductos; i++){
				if(request.getParameter("producto"+i)!= null && ! request.getParameter("cantidad"+i).equals("0") && ! request.getParameter("producto"+i).equals("")){		
					ArrayCantidad[i] = request.getParameter("cantidad"+i);
					ArrayProducto[i] = request.getParameter("producto"+i);
					ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
					ArrayImporte[i] = request.getParameter("importe"+i);
				}
				else if (request.getParameter("producto"+i)!= null){
					contadorCeroInterno++;
				}				
			}		
		}
// Ajuste por cero Interno.
		if(contadorCeroInterno > 0){
//			for (int j = 1; j<=cantNumProductos ; j++){
//				System.out.println("Producto -->" +ArrayProducto[j]);
//				System.out.println("Cantidad -->" +ArrayCantidad[j]);
//				System.out.println("Unidad -->" +ArrayCUnidad[j]);
//				System.out.println("Importe -->" +ArrayImporte[j]);
//				System.out.println("");
//			}
			String[] TArrayCantidad   = new String[cantNumProductos+1-contadorCeroInterno]; //  Aumento 1 para facilitar el manejo del arreglo.
			String[] TArrayProducto   = new String[cantNumProductos+1-contadorCeroInterno];
			String[] TArrayCUnidad   = new String[cantNumProductos+1-contadorCeroInterno];
			String[] TArrayImporte   = new String[cantNumProductos+1-contadorCeroInterno];	
			int interino = 1;			
			for(int i = 1; i<=cantNumProductos; i++){				
				if(ArrayProducto[i] != null && !ArrayProducto[i].equals("")){		
					TArrayCantidad[interino] = ArrayCantidad[i];
					TArrayProducto[interino] = ArrayProducto[i];
					TArrayCUnidad[interino] = ArrayCUnidad[i];
					TArrayImporte[interino] = ArrayImporte[i];
					interino ++;
				}
			}		
			ArrayCantidad = new String[cantNumProductos+1-contadorCeroInterno];
			ArrayProducto = new String[cantNumProductos+1-contadorCeroInterno];
			ArrayCUnidad = new String[cantNumProductos+1-contadorCeroInterno];
			ArrayImporte = new String[cantNumProductos+1-contadorCeroInterno];
			for(int i = 1; i<=cantNumProductos-contadorCeroInterno; i++){
				ArrayCantidad[i] = TArrayCantidad[i];
				ArrayProducto[i] = TArrayProducto[i];
				ArrayCUnidad[i] = TArrayCUnidad[i];
				ArrayImporte[i] = TArrayImporte[i];
			}		
			cantNumProductos -= contadorCeroInterno;
		}
	}
	if(! cliente.trim().equals("")){
		haySaldo = alVen.estatusCredito(cliente);
	}
%>
<body onLoad="setFocus();MM_preloadImages('imagenes/Regresar2.jpg')">
<h1>FORMATO SOLICITUD ALTA DE VENTA.</h1>
<form method="post" name="ph" target="_self" onSubmit="return OnSubmitForm();">
<%
	ResultSet clientes = alVen.datosClientesActivos();
%>
<table align="center" width="470" cellpadding="0" cellspacing="0" border="1">
<caption>Selecci&oacute;n de Cliente:</caption>
  <tr>
    <th width="180"><div align="center">Cliente:</div></th>
	<td width="284">
	  <div align="center">
	    <select name="clienteC" onChange="MandaSubmit(document.forms[0])">
    <%
	// Si todavia no me eligen un cliente.
	if(cliente.equalsIgnoreCase("")){
%>	
		    <option selected value="">SELECCIONE</option>
            <%
	}
	// Lleno Combo
	while (clientes.next()){
%>	
		    <option
<%
		if(cliente.equalsIgnoreCase(clientes.getString("rfc"))){
%>
selected 
<%
		}
%>		
			 value ="<%=clientes.getString("rfc")%>"><%=clientes.getString("nombre")%></option>
            <%
	}
	if(clientes != null){
		clientes.close();
	}
	alVen.cierraConexion();		// de ResultSet Complex							
%>				 
	      </select>
	    </div></td>
  </tr>
</table>
</form>
<%
	// Si no me selecciona el Cliente NO despliego el llenado del pedido.
	 if(! cliente.equalsIgnoreCase("") &&  haySaldo){
%>
<form method="post" name="ph1" target="_self" onSubmit="return OnSubmitForm();">
<table border="1" width="650">
	<tr>
		<th width="461">Saldo de Crédito Disponible:</th>
		<td width="173"><div align="right"> <%=alVen.dameCreditoDisponible(cliente)%></div></td>
	</tr>
</table>
<table width="700" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">
  COMPRA ALTA 
  </caption>
  <tr>
  	<th width="300">Selecci&oacute;n /<br />Producto</th>
    <th width="110">Cantidad</th>
    <th width="87">Inventario</th>
    <th width="95">Costo<br />Unidad</th>
    <th width="96">Importe<br/>Total</th>	
  </tr>
<%
	for (int i=1; i<=cantNumProductos; i++){
		String tempCantidad = (ArrayCantidad[i] == null) ? "0" : ArrayCantidad[i];
		String tempProducto = (ArrayProducto[i] == null) ? "" : ArrayProducto[i];
		String tempCUnidad = (ArrayCUnidad[i] == null) ? "0" : ArrayCUnidad[i];
		String tempImporte = (ArrayImporte[i] == null) ? "0" : ArrayImporte[i];
		String cantidadExistente = " -- ";
		String tipoUnidad = "";
%> 
  <tr>
    <td><input type="text" name="producto<%=i%>" size="15" maxlength="8" readonly="true" value="<%=tempProducto%>">
	<input type="Submit" name="Submit<%=i%>" value="Prod.." onClick="document.pressed=this.form.producto<%=i%>">
<%
	if (! tempProducto.trim().equals(""))	{
		String nombreTemporal = alVen.dameNombreProducto(tempProducto);
		cantidadExistente = alVen.dameCantidadEnInventarioV (tempProducto);
		tipoUnidad = alVen.dameTipoDeUnidad(tempProducto);
%>
			<br/><div align="center"><%=nombreTemporal%></div>
<%		
	}
%>	
	
	</td>
    <td><div align="center">
      <input type="text" name="cantidad<%=i%>" size="7"  onFocus="seleccionaTodo(this)" maxlength="6" value="<%=tempCantidad%>" onChange="recalculaValor(this, ph1.cUnidad<%=i%>, ph1.importe<%=i%>, ph1.producto<%=i%>)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ ph1.Submit<%=i%>.focus();}" onBlur="verificaSobreInv(ph1.existente<%=i%>, this, ph1.producto<%=i%>, ph1.importe<%=i%>, ph1.cUnidad<%=i%>)"> <input type="button" value="Re">
    </div></td>
	<td> <div align="right"><input type="text" name="existente<%=i%>" readonly="true" size="4" maxlength="4" value="<%=cantidadExistente%>"> <%=tipoUnidad%></div></td>	
    <td><div align="right">$ 
<%
		if(tempProducto.equalsIgnoreCase("")){
%>		
			<input type="text" readonly="true" name="cUnidad<%=i%>"  size="8" maxlength="8" value="<%=tempCUnidad%>">
<%			
		}
		else{
%>		<select name="cUnidad<%=i%>" onChange="recalculaValor(ph1.cantidad<%=i%>, this, ph1.importe<%=i%>, ph1.producto<%=i%>)">
<%
		ResultSet preProd= alVen.preciosDeProducto(tempProducto);
		while (preProd.next()){
%>		
			<option value="<%=preProd.getString("precio1")%>" <%if(tempCUnidad.equalsIgnoreCase(preProd.getString("precio1"))){%> selected <%}%> ><%=preProd.getString("precio1")%></option>
			<option value="<%=preProd.getString("precio2")%>" <%if(tempCUnidad.equalsIgnoreCase(preProd.getString("precio2"))){%> selected <%}%> ><%=preProd.getString("precio2")%></option>
			<option value="<%=preProd.getString("precio3")%>" <%if(tempCUnidad.equalsIgnoreCase(preProd.getString("precio3"))){%> selected <%}%> ><%=preProd.getString("precio3")%></option>
			<option value="<%=preProd.getString("precio4")%>" <%if(tempCUnidad.equalsIgnoreCase(preProd.getString("precio4"))){%> selected <%}%> ><%=preProd.getString("precio4")%></option>
			<option value="<%=preProd.getString("precio5")%>" <%if(tempCUnidad.equalsIgnoreCase(preProd.getString("precio5"))){%> selected <%}%> ><%=preProd.getString("precio5")%></option>
<%		
		}
	if(preProd != null){
		preProd.close();
	}
	alVen.cierraConexion();		// de ResultSet Complex									
%>	
	</select>
<% 
	}
%>	
	</div></td>
	<td><div align="right">$ <input type="text" name="importe<%=i%>" size="8" readonly="true"  maxlength="8" value="<%=tempImporte%>"></div></td>
  </tr>
<%
	}
%>	  
</table>
      <%
	cantNumProductos += 1;
%>
      <!-- AQUI TERMINA -->
</div>
<div align="left">
</div>
<p>
  <input type="hidden" name="numProductos" value="<%=cantNumProductos%>">
  <input type="hidden" name="cliente" value="<%=cliente%>">
  <input type="hidden" name="numFac" value="<%=numFac%>">  
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Aumentar">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Guardar">
</p>
  <table width="685" border="1">
  <caption>
  OBSEQUIOS EXTRAS
  </caption>
	  <tr>
		  <th width="442">Producto</th>
		  <th width="85">Cantidad</th>		  
		  <th width="136">Inventario</th>
	  </tr>
	  <tr>
      <td><div align="left">
	    <input type="text" name="productoR1" size="15" maxlength="12" readonly="true" value="<%=tempprod1%>">
	    <input type="Submit" name="SubmitR1" value="Prod.." onClick="document.pressed=this.form.productoR1">
        <%
	String tipoUnidadOb1 = "";		
	if (! tempprod1.trim().equals("")){
		String nombreTemporal = alVen.dameNombreProducto(tempprod1.trim());	
		if(tempcan1.trim().equals("")){
			tempcan1 = "0";
		}
%>
		  <%=nombreTemporal%>	
          <%	
	}
%>	
	    </div></td>
	  <td><div align="center">
		      <input type="text" name="cantidadR1" size="7" maxlength="6" value="<%=tempcan1%>" onFocus="seleccionaTodo(this)" onBlur="verificaInvOb(this, ph1.productoR1,ph1.cantE1)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	  </div></td>	  
	<td>
      <div align="right">
          <%
	if (tempprod1.trim().equals("")){
	}
	else{
		 cantidadExistente1 =alVen.dameCantidadEnInventarioO (tempprod1);
		 tipoUnidadOb1 = alVen.dameTipoDeUnidad(tempprod1);
	}
%>	
<input type="text" name="cantE1" maxlength="8" size="8" readonly="true" value="<%=cantidadExistente1%>"> <%=tipoUnidadOb1%>
	    </div></td>	  	  
	  </tr>
	  <tr>
      <td><div align="left">
	    <input type="text" name="productoR2" size="15" maxlength="12" readonly="true" value="<%=tempprod2%>">
	    <input type="Submit" name="SubmitR2" value="Prod.." onClick="document.pressed=this.form.productoR2">
        <%
	String tipoUnidadOb2 = "";		
	if (! tempprod2.trim().equals("")){
		String nombreTemporal = alVen.dameNombreProducto(tempprod2.trim());	
		if(tempcan2.trim().equals("")){
			tempcan2 = "0";
		}

%>
		  <%=nombreTemporal%>	
<%	
	}
%>	
	    </div></td>
	  <td><div align="center">
		      <input type="text" name="cantidadR2" size="7" onBlur="verificaInvOb(this, ph1.productoR2,ph1.cantE2)" maxlength="6" value="<%=tempcan2%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	  </div></td>	  
	<td>
        <div align="right">
          <%
	if (tempprod2.trim().equals("")){
	}
	else{
		cantidadExistente2 = alVen.dameCantidadEnInventarioO (tempprod2);
		tipoUnidadOb2 = alVen.dameTipoDeUnidad(tempprod2);
	}
%>	
		  <input type="text" name="cantE2" maxlength="8" size="8" readonly="true" value="<%=cantidadExistente2%>"> <%=tipoUnidadOb2%>		
	      </div></td>	  	  
	  </tr>
	  <tr>
      <td><div align="left">
	    <input type="text" name="productoR3" size="15" maxlength="12" readonly="true" value="<%=tempprod3%>">
	    <input type="Submit" name="SubmitR3" value="Prod.." onClick="document.pressed=this.form.productoR3">  
        <%
	String tipoUnidadOb3 = "";				
	if (! tempprod3.trim().equals("")){
		String nombreTemporal = alVen.dameNombreProducto(tempprod3.trim());	
		if(tempcan3.trim().equals("")){
			tempcan3 = "0";
		}		
%>
		  <%=nombreTemporal%>	
<%	
	}
%>	
	    </div></td>
	  <td><div align="center">
		      <input type="text" name="cantidadR3" size="7" onBlur="verificaInvOb(this, ph1.productoR3,ph1.cantE3)" maxlength="6" value="<%=tempcan3%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	  </div></td>	  
	<td>
      <div align="right">
 <%
	if (tempprod3.trim().equals("")){
	}
	else{
		cantidadExistente3 = alVen.dameCantidadEnInventarioO (tempprod3);
		tipoUnidadOb3 = alVen.dameTipoDeUnidad(tempprod3);		
	}
%>	
	  <input type="text" name="cantE3" maxlength="8" size="8" readonly="true" value="<%=cantidadExistente3%>"> <%=tipoUnidadOb3%>		
	    </div></td>	  	  
  </tr>
  </table>
  <input type="hidden" name="clienteC" value="<%=cliente%>">  
  <input type="hidden" name="documento" value="<%=documento%>">

</form>
<%
	}
	else if(!haySaldo){
%>	
	<b class="roj"> Este cliente no tiene m&aacute;s cr&eacute;dito disponible para venta.</b><br/>
	Posible Soluciones:
		<br/> 1. Pagar Ventas Pendientes.
		<br/> 2. Aumentar Cr&eacute;dito del Cliente.
<%	
	}
%>	
<p>
<a href="Menu_Ventas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
