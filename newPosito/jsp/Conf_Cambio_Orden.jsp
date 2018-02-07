<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Calculos de Compras Modificaci&oacute;n</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function Calculadescuentos(f) { 
	var SubPrecio = new String();
	SubPrecio = f.subtotal.value;
	re = /,/gi;
	SubPrecio = SubPrecio.replace(re,"");
	var IvaPrecio = new String();
	IvaPrecio = f.ivaFijo.value;
	re = /,/gi;
	IvaPrecio = IvaPrecio.replace(re,"");
	var TotalPrecio = new String();
	TotalPrecio = f.total.value;
	re = /,/gi;
	TotalPrecio = TotalPrecio.replace(re,"");
	var subtotal = new Number();
	subtotal = SubPrecio;
	var descu1 = new Number();
	descu1 = f.descuento1.value;
	var descu2 = new Number();
	descu2 = f.descuento2.value;
	var descu3 = new Number();
	descu3 = f.descuento3.value;
	var ivaN = new Number();
	ivaN = IvaPrecio * 0.15;
	var totalN = new Number();
	totalN = TotalPrecio;
	var resultado = new Number();
	ivaN = roundOff(ivaN);
	totalN = roundOff(totalN);
	resultado = formatCurrency(resultado);	
	resultado = subtotal - ((subtotal * descu1)/100);
	resultado = resultado - ((resultado * descu2)/100);
	resultado = resultado - ((resultado * descu3)/100);
	ivaN = ivaN - ((ivaN * descu1)/100);
	ivaN = ivaN - ((ivaN * descu2)/100);
	ivaN = ivaN - ((ivaN * descu3)/100);
	totalN = resultado + ivaN;	
	if (isNaN(resultado))
		resultado = 0; 
	if (isNaN(ivaN))
		ivaN = 0;	
	if (isNaN(totalN))
		totalN = 0;	 		
	resultado = roundOff(resultado);
	ivaN = roundOff(ivaN);
	totalN = roundOff(totalN);
	resultado = formatCurrency(resultado);
	ivaN = formatCurrency(ivaN);
	totalN = formatCurrency(totalN);
	//alert(resul);
	document.form1.descuentos.value = resultado;
	document.form1.iva.value = ivaN;
	document.form1.total.value = totalN;
}

function roundOff(value) {
	value = "" + value //convert value to string
	var precision = 2;
	var whole = "" + Math.round(value * Math.pow(10, precision));
	var decPoint = whole.length - precision;
	if(decPoint != 0) 	{
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
		num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3));
	return (((sign)?'':'-') + num + '.' + cents);
}


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

function seleccionaTodo(objeto){
	objeto.select();
}

function verificaPermisos(){
	var valor;
	for(var i=0; i<form1.rg.length; ++i){
		if(form1.rg[i].checked){
			valor = form1.rg[i].value;
		}
	}	
	if(valor == '1'){
		form1.aval.disabled = false;
		form1.aval.focus();
	}
	else{
		form1.aval.value="";
		form1.aval.disabled = true;
	}
 }
 
function OnSubmitForm(){
	var valor;
	for(var i=0; i<form1.rg.length; ++i){
		if(form1.rg[i].checked){
			valor = form1.rg[i].value;
		}
	}	
	if(valor == '1'){
		var docAval = new String();
		docAval = form1.aval.value;
		re = / /gi;
		docAval = docAval.replace(re,"");
		if(docAval == ''){
			alert("Debes especificare un Documento Aval de esta transaccion");
			form1.aval.focus();
			return false;
		}
		else{
			document.form1.action ="Conf_Guarda_Orden.jsp";		
			return true;
		}
	}
	else{
		document.form1.action ="Conf_Guarda_Orden.jsp";		
		return true;	
	}
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
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String claveOrden = request.getParameter("claveOrden");
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
	ArrayCUnidad = (String[])request.getParameterValues("unidad");
	ArrayImporte = (String[])request.getParameterValues("importe");
	ArrayCambio = (String[])request.getParameterValues("cambio");		
	String prodRegalo1 = request.getParameter("prodRegalo1");
	String prodRegalo2 = request.getParameter("prodRegalo2");
	String prodRegalo3 = request.getParameter("prodRegalo3");
	String tipoUniRegalo1 = request.getParameter("tipoUniRegalo1");
	String tipoUniRegalo2 = request.getParameter("tipoUniRegalo2");
	String tipoUniRegalo3 = request.getParameter("tipoUniRegalo3");
	String cantidadRegalo1 = request.getParameter("cantidadRegalo1");
	String cantidadRegalo2 = request.getParameter("cantidadRegalo2");
	String cantidadRegalo3 = request.getParameter("cantidadRegalo3");
	String nombreProveedor = "";
	String descuento1 = request.getParameter("descuento1");
	String descuento2 = request.getParameter("descuento2");
	String descuento3 = request.getParameter("descuento3");	
	double subTotal = 0.00;
	double descuentos = 0.00;
	double iva = 0.00;
	double total = 0.00;
	double des1BD = alCom.cambiaADouble(descuento1);
	double des2BD = alCom.cambiaADouble(descuento2);
	double des3BD = alCom.cambiaADouble(descuento3);
	String fechaRegistro = request.getParameter("fechaRegistro");
	String fechaEntrega = request.getParameter("fechaEntrega");	
	if(fechaEntrega.substring(4,5).equals("-")){
		fechaEntrega = fechaEntrega.substring(5,7)+"/"+fechaEntrega.substring(8,10)+"/"+fechaEntrega.substring(0,4);
	}
	double saldoDisponible = 0.00;
	boolean tienesCredito = false;
	String fechaHoy = alCom.dameFechaHoy();
	String subtotal2 = request.getParameter("subtotal");
	String iva2 = request.getParameter("iva");
	String descuentos2 = request.getParameter("descuentos");
	String total2 = request.getParameter("total");	
	String observaciones2 = request.getParameter("observaciones");	
	
	if(ArrayCantidad[0].equals("") && prodRegalo1.equals("") && prodRegalo2.equals("") && prodRegalo3.equals("")){
	
%>
	<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
	<form name="retache" method="post" target="_self" action="Cambio_Orden.jsp" >
		<input type="hidden" name="prodRegalo1" value="<%=prodRegalo1%>">
		<input type="hidden" name="prodRegalo2" value="<%=prodRegalo2%>">
		<input type="hidden" name="prodRegalo3" value="<%=prodRegalo3%>">
		<input type="hidden" name="tipoUniRegalo1" value="<%=tipoUniRegalo1%>">
		<input type="hidden" name="tipoUniRegalo2" value="<%=tipoUniRegalo2%>">
		<input type="hidden" name="tipoUniRegalo3" value="<%=tipoUniRegalo3%>">
		<input type="hidden" name="cantidadRegalo1" value="<%=cantidadRegalo1%>">
		<input type="hidden" name="cantidadRegalo2" value="<%=cantidadRegalo2%>">
		<input type="hidden" name="cantidadRegalo3" value="<%=cantidadRegalo3%>">
		<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
		<input type="hidden" name="descuento1" value="<%=descuento1%>">
		<input type="hidden" name="descuento2" value="<%=descuento2%>">
		<input type="hidden" name="descuento3" value="<%=descuento3%>">
		<input type="hidden" name="fechaRegistro" value="<%=fechaRegistro%>">
		<input type="hidden" name="fechaEntrega" value="<%=fechaEntrega%>">
		<input type="hidden" name="subtotal" value="<%=subtotal2%>">
		<input type="hidden" name="iva" value="<%=iva2%>">
		<input type="hidden" name="descuentos" value="<%=descuentos2%>">
		<input type="hidden" name="total" value="<%=total2%>">
		<input type="hidden" name="observaciones" value="<%=observaciones2%>">
<% 		for (int i=0; i<ArrayCantidad.length; i++){ %>	
			<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
			<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
			<input type="hidden" name="unidad" value="<%=ArrayCUnidad[i]%>">
			<input type="hidden" name="importe" value="<%=ArrayImporte[i]%>">
			<input type="hidden" name="tipo" value="<%=ArrayTipo[i]%>">
			<input type="hidden" name="cambio" value="<%=ArrayCambio[i]%>">									
<% 		} %>	
		<input type="hidden" name="proveedorC" value="<%=proveedorC%>">	
<table>
	<tr>
		<td><b class="roj">Tienes que especificar al menos un producto de Compra o uno de Regalo.</b></td>
	</tr>
	<tr>
		<td><div align="center">Para reingresar producto da click en Volver</div></td>
	</tr>
</table>
	<p><input type="submit" name="Volver" value="Volver"></p>
	</form>
<%	
	} else{
		ResultSet rsProv = alCom.datosProveedorCompra(proveedorC);
		while(rsProv.next()){
			nombreProveedor = rsProv.getString("nombre");
			if(rsProv.getInt("IDCredito") == 1){
				tienesCredito = true;
			}
			if(tienesCredito){
				saldoDisponible = rsProv.getDouble("saldoDisponible");
			}
		}
		rsProv.close();
		alCom.cierraConexion();	
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); Calculadescuentos(form1)">
<form name="form1" method="post" onSubmit="return OnSubmitForm();" target="_self">
		<input type="hidden" name="prodRegalo1" value="<%=prodRegalo1%>">
		<input type="hidden" name="prodRegalo2" value="<%=prodRegalo2%>">
		<input type="hidden" name="prodRegalo3" value="<%=prodRegalo3%>">
		<input type="hidden" name="tipoUniRegalo1" value="<%=tipoUniRegalo1%>">
		<input type="hidden" name="tipoUniRegalo2" value="<%=tipoUniRegalo2%>">
		<input type="hidden" name="tipoUniRegalo3" value="<%=tipoUniRegalo3%>">
		<input type="hidden" name="cantidadRegalo1" value="<%=cantidadRegalo1%>">
		<input type="hidden" name="cantidadRegalo2" value="<%=cantidadRegalo2%>">
		<input type="hidden" name="cantidadRegalo3" value="<%=cantidadRegalo3%>">
		<input type="hidden" name="claveOrden" value="<%=claveOrden%>">		
		<input type="hidden" name="fechaRegistro" value="<%=fechaRegistro%>">
		<input type="hidden" name="fechaEntrega" value="<%=fechaEntrega%>">		
<% 		for (int i=0; i<ArrayCantidad.length; i++){ %>	
			<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
			<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
			<input type="hidden" name="unidad" value="<%=ArrayCUnidad[i]%>">
			<input type="hidden" name="importe" value="<%=ArrayImporte[i]%>">
			<input type="hidden" name="tipo" value="<%=ArrayTipo[i]%>">
			<input type="hidden" name="cambio" value="<%=ArrayCambio[i]%>">						
<% 		} %>	
		<input type="hidden" name="proveedorC" value="<%=proveedorC%>">	
	<table align="center" border="1" width="700" cellpadding="0" cellspacing="0">
		<caption>Datos Proveedor / Cr&eacute;dito</caption>
		<tr>
			<th>Proveedor:</th>
			<th>Cr&eacute;dito<br/>Disponible:</th>	
			<th>Tipo de Entrega:</th> 
		</tr>
		<tr>
			<td><div align="center"><%=nombreProveedor%></div></td>		
		<% if(tienesCredito){ %>
			<td><div align="right"><%=alCom.formatoDinero(saldoDisponible+"")%></div></td>
		<% } else { %>
			<td><div align="center">Sin Cr&eacute;dito</div></td>		
		<% } %>
			<td>
				<table cellpadding="0" cellspacing="0" width="100%" border="1">
					<tr>
						<td  width="8%" rowspan="2"><div align="center"> <input type="radio" name="rg" value="1" onClick="verificaPermisos()"> </div></td>
						<td width="41%" rowspan="2"><div align="left">Recepción Directa</div></td>
						<td width="28%"><div align="left"> <input type="radio" name="tipoDoc" value="1" checked> Factura</div></td>
						<td width="23%"><div align="left"><input type="radio" name="tipoDoc" value="2">Nota</div></td>
					</tr>
					<tr>
						<td colspan="2"><div align="center"> Documento Aval: 
						    <input type="text" name="aval" maxlength="8" size="10"></div></td>
					</tr>
					<tr>
						<td rowspan="2"><div align="center"> <input type="radio" name="rg" value="2" checked onClick="verificaPermisos()"> </div></td>
						<td rowspan="2" height="40"><div align="left">Recepción Programada</div></td>
					  <td rowspan="2" colspan="2"><div align="center"> <input type=text name="datebox" size=15 readonly="true" value="<%=fechaEntrega%>"> <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a></div></td>
					</tr>
				</table>
			</td>
		</tr>

	</table>
<br />	
<% if(!ArrayProducto[0].equals("")){ %>
	<table align="center" border="1" width="700" cellpadding="0" cellspacing="0">
  	  <caption>Productos Solicitados.</caption>
	  <tr>
		<th width="76">Cantidad</th>
		<th width="78">Tipo</th>
		<th width="270">Producto</th>
		<th width="97">Costo</th>
		<th width="59">Cambia<br/>Precio</th>
		<th width="106">Importe<br/>Total</th>
	  </tr>
<% 	  for(int i = 0; i<ArrayCantidad.length; i++){ 
		String datoCambio = "No";
		if(ArrayCambio[i].equals("1")){
			datoCambio = "S&iacute;";
		}
%>
	  <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%=ArrayTipo[i]%></td>
		<td><%=alCom.dameDescripcionProducto(ArrayProducto[i])%></td>
		<td><div align="right">
		<% if(alCom.tieneIva(ArrayProducto[i])){ 
			double pUnitarioTemp = alCom.quitaIVA(ArrayCUnidad[i]);
			double pImporteTemp = pUnitarioTemp*alCom.cambiaADouble(ArrayCantidad[i]);
			subTotal += pImporteTemp;
			iva += pImporteTemp;
			total += alCom.cambiaADouble(ArrayImporte[i]);			
		%>
		<%=alCom.formatoCortoDinero(pUnitarioTemp+"")%>
		<% } else { 
			subTotal += alCom.cambiaADouble(ArrayImporte[i]);
			total += alCom.cambiaADouble(ArrayImporte[i]);
		%>		
		<%=ArrayCUnidad[i]%><% } %>
		</div></td>
		<td><div align="center"><%=datoCambio%></div></td>
		<td><div align="right">
		<% if(alCom.tieneIva(ArrayProducto[i])){ 
			double pUnitarioTemp = alCom.quitaIVA(ArrayCUnidad[i]);
			double pImporteTemp = pUnitarioTemp*alCom.cambiaADouble(ArrayCantidad[i]);
		%>
		<%=alCom.formatoCortoDinero(pImporteTemp+"")%>
		<% } else { %>		
		<%=ArrayImporte[i]%><% } %>
		</div></td>
	  </tr>
<% 	  }  %>
	</table>	
<% } if(!prodRegalo1.equals("") || !prodRegalo2.equals("") || !prodRegalo3.equals("")){ %>
<br/>
	<table align="center" width="700" border="1" cellpadding="0"  cellspacing="0">
	  <caption>Productos de Obsequio</caption>
	  <tr>
	  	<th>Producto</th>
		<th>Tipo</th>
		<th>Cantidad</th>
	  </tr>
	  <% if(!(prodRegalo1.equals(""))){ %>
	  <tr>
	  	<td><div align="center"><%=alCom.dameDescripcionProducto(prodRegalo1)%></div></td>
	  	<td><div align="center"><%=tipoUniRegalo1%></div></td>
	  	<td><div align="center"><%=cantidadRegalo1%></div></td>				
	  </tr>
	  <% } if(!(prodRegalo2.equals(""))){ %>
	  <tr>
	  	<td><div align="center"><%=alCom.dameDescripcionProducto(prodRegalo2)%></div></td>
	  	<td><div align="center"><%=tipoUniRegalo2%></div></td>
	  	<td><div align="center"><%=cantidadRegalo2%></div></td>				
	  </tr>
	  <% } if(!(prodRegalo3.equals(""))){ %>
	  <tr>
	  	<td><div align="center"><%=alCom.dameDescripcionProducto(prodRegalo3)%></div></td>
	  	<td><div align="center"><%=tipoUniRegalo3%></div></td>
	  	<td><div align="center"><%=cantidadRegalo3%></div></td>				
	  </tr>
	  <% } %>	  
	</table>
<%}	%>	
<br/>	
	<table width="700" border="1" cellpadding="0" cellspacing="0">
	  <tr>
		<th width="299">Observaciones</th>
		<th width="116">&nbsp;</th>
		<td width="68">&nbsp;</td>
		<th width="98">Subtotal</th>
		<td width="107"><div align="right"> $ <input name="subtotal" type="text" value="<%=alCom.formatoDinero(alCom.formatoCortoDinero(subTotal+""))%>" size="10" maxlength="10" readonly="true"> </div></td>
	  </tr>
	  <tr>
		<td rowspan="3"><textarea name="observaciones" cols="35" rows="5"><%=observaciones2%></textarea></td>
		<th>Descuento 1</th>
		<td><div align="center"> <input type="text" name="descuento1" size="3" maxlength="2" onFocus="seleccionaTodo(this)" onBlur="Calculadescuentos(document.forms[0])" value="<%=des1BD%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ form1.descuento2.focus();}"> %</div></td>
		<th height="34"><div align="center"><strong>Descuento</strong></div></td>
		<%descuentos = subTotal;%>
		<td height="34"><div align="right"> $ <input name="descuentos" type="text" value="<%=alCom.formatoDinero(alCom.acortaLongitud(descuentos+""))%>" size="10" maxlength="10" readonly="true"></div></td>
	  </tr>
	  <tr>
		<th>Descuento 2</th>
		<td><div align="center"> <input type="text" name="descuento2" size="3" maxlength="2" onFocus="seleccionaTodo(this)" onChange="Calculadescuentos(document.forms[0])" value="<%=des2BD%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ form1.descuento3.focus();}"> %</div></td>
		<th height="35"><div align="center"><strong>I.V.A.</strong></div></th>
		<input type="hidden" name="ivaFijo" value="<%=iva%>">
		<% double ivas = (iva * 0.15); %>
		<td height="35"><div align="right"> $  <input name="iva" type="text" value="<%=alCom.formatoCortoDinero(ivas+"")%>" size="10" maxlength="10" readonly="true"> </div></td>
	  </tr>
	  <tr>
		<th>Descuento 3</th>
		<td><div align="center"> <input type="text" name="descuento3" size="3" maxlength="2" onFocus="seleccionaTodo(this)" onChange="Calculadescuentos(document.forms[0])" value="<%=des3BD%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}"> %</div></td>
		<th><div align="center"><strong>TOTAL</strong></div></th>
		<%total = descuentos+iva ;%>		
		<td><div align="right"> $ <input name="total" type="text" value="<%=alCom.formatoCortoDinero(total+"")%>" size="10" maxlength="10" readonly="true"> </div></td>
	  </tr>
</table>
<p>
<table cellpadding="0" cellspacing="0" width="350" border="0" align="center">
	<tr>
		<td><div align="center">
		  <input type="submit" name="Guardar" value="Guardar">
		  </div></td>
	</tr>
</table>
</p>
</form>		
<form name="retache2" method="post" target="_self" action="Cambio_Orden.jsp">
	<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
	<input type="hidden" name="descuento1" value="<%=des1BD%>">
	<input type="hidden" name="descuento2" value="<%=des2BD%>">
	<input type="hidden" name="descuento3" value="<%=des3BD%>">
	<input type="hidden" name="fechaRegistro" value="<%=fechaRegistro%>">
	<input type="hidden" name="fechaEntrega" value="<%=fechaEntrega%>">
	<input type="hidden" name="subtotal" value="<%=subtotal2%>">
	<input type="hidden" name="iva" value="<%=iva2%>">
	<input type="hidden" name="descuentos" value="<%=descuentos2%>">
	<input type="hidden" name="total" value="<%=total2%>">
	<input type="hidden" name="observaciones" value="<%=observaciones2%>">
	<input type="hidden" name="prodRegalo1" value="<%=prodRegalo1%>">
	<input type="hidden" name="prodRegalo2" value="<%=prodRegalo2%>">
	<input type="hidden" name="prodRegalo3" value="<%=prodRegalo3%>">
	<input type="hidden" name="tipoUniRegalo1" value="<%=tipoUniRegalo1%>">
	<input type="hidden" name="tipoUniRegalo2" value="<%=tipoUniRegalo2%>">
	<input type="hidden" name="tipoUniRegalo3" value="<%=tipoUniRegalo3%>">
	<input type="hidden" name="cantidadRegalo1" value="<%=cantidadRegalo1%>">
	<input type="hidden" name="cantidadRegalo2" value="<%=cantidadRegalo2%>">
	<input type="hidden" name="cantidadRegalo3" value="<%=cantidadRegalo3%>">
<%	for (int i=0; i<ArrayCantidad.length; i++){ %>	
		<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
		<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
		<input type="hidden" name="unidad" value="<%=ArrayCUnidad[i]%>">
		<input type="hidden" name="importe" value="<%=ArrayImporte[i]%>">
		<input type="hidden" name="tipo" value="<%=ArrayTipo[i]%>">
		<input type="hidden" name="cambio" value="<%=ArrayCambio[i]%>">								
<%	} %>	
	<input type="hidden" name="proveedorC" value="<%=proveedorC%>">	
<p><input type="submit" name="Modificar" value="Modificar"></p>
</form>
<%	}  %>
<p><a href="Menu_Compras.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
