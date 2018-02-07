<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.text.*, java.util.Vector" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Alta Compra</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){	
	f.submit();
}

function setFocus(){
	var contenido = document.ph.proveedorC.options[0].text;
	if(contenido == "SELECCIONE"){
		document.ph.proveedorC.focus();
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
		num = num.substring(0,num.length-(4*i+3))+','+ num.substring(num.length-(4*i+3));
	return (((sign)?'':'-') + num + '.' + cents);
}

function seleccionaTodo(objeto){
	objeto.select();
}

function regresaFoco(cantidadP){
	cantidadP.select();
}


function recalculaValor(IDcantidad, IDprecio, IDtotal){
	var elementoCantidad = document.getElementById(IDcantidad);
	var Unidad = new Number();
	Unidad = elementoCantidad.value;
	if (isNaN(Unidad)){
		Unidad = 1;
		elementoCantidad.value="1.00";
		alert("La cantidad debe ser un número válido.");
	}
	var elementoPrecio = document.getElementById(IDprecio);
	var SPrecio = new String();
	SPrecio = elementoPrecio.value;
	re = /,/gi;
	SPrecio = SPrecio.replace(re,"");
	var Precio = new Number();
	Precio = SPrecio;
	if (isNaN(Precio)){
		Precio = 0;
		elementoPrecio.value="0.00";
		alert("El precio debe ser un número válido");
	}
	var Total = new Number();
	Total = Unidad * Precio;
	Total = roundOff(Total);
	var elementoTotal = document.getElementById(IDtotal);	
	elementoTotal.value = formatCurrency(Total);
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
		document.ph1.action ="Conf_Alta_Compra.jsp";
	}
	else if(document.pressed == 'Aumentar')   {
		document.ph1.action ="ListadoCompra.jsp";
	}
	else if(document.pressed == 'Regalo1'){
		document.ph1.action ="ListadoCompraO.jsp?"+"1";
	}
	else if(document.pressed == 'Regalo2'){
		document.ph1.action ="ListadoCompraO.jsp?"+"2";
	}
	else if(document.pressed == 'Regalo3'){
		document.ph1.action ="ListadoCompraO.jsp?"+"3";
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

function borrame(IDPro, IDCant, IDTipo, IDUni, IDImpo){
	var elementoPro = document.getElementById(IDPro);
	var elementoCant = document.getElementById(IDCant);
	var elementoTipo = document.getElementById(IDTipo);
	var elementoUni = document.getElementById(IDUni);
	var elementoImpo = document.getElementById(IDImpo);				
	elementoPro.name="borrame";
	elementoCant.name="borrame";
	elementoTipo.name="borrame";
	elementoUni.name="borrame";
	elementoImpo.name="borrame";
	MandaSubmit(ph1);
}

function borrame2(Clave, Tipo, Cantidad){
	Clave.value="";
	Tipo.value = "";
	Cantidad.value="";
	MandaSubmit(ph1);
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
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String proveedor = "";
	String[] ArrayCantidad = null;
	String[] ArrayProducto = null;
	String[] ArrayCUnidad = null;
	String[] ArrayImporte = null;
	String[] ArrayTipo = null;
	String[] ArrayCambio = null;
	String prodRegalo1 = "";
	String prodRegalo2 = "";
	String prodRegalo3 = "";
	String tipoUniRegalo1 = "";
	String tipoUniRegalo2 = "";
	String tipoUniRegalo3 = "";
	String cantidadRegalo1 = "";
	String cantidadRegalo2 = "";
	String cantidadRegalo3 = "";
	int productosDeProveedor = 0;
	if(request.getParameter("proveedorC") != null){
		proveedor = request.getParameter("proveedorC");
		productosDeProveedor = alCom.dameCantidadProdXProv(proveedor);
		if((String[])request.getParameterValues("cantidad") != null){
			ArrayCantidad = (String[])request.getParameterValues("cantidad");
			ArrayProducto = (String[])request.getParameterValues("producto");
			ArrayTipo = (String[])request.getParameterValues("tipo");
			ArrayCambio = (String[])request.getParameterValues("cambio");
			ArrayCUnidad = (String[])request.getParameterValues("unidad");
			ArrayImporte = (String[])request.getParameterValues("importe");		
		}
		if(request.getParameter("prodRegalo1") != null){
			prodRegalo1 = request.getParameter("prodRegalo1");
			prodRegalo2 = request.getParameter("prodRegalo2");
			prodRegalo3 = request.getParameter("prodRegalo3");
			tipoUniRegalo1 = request.getParameter("tipoUniRegalo1");
			tipoUniRegalo2 = request.getParameter("tipoUniRegalo2");
			tipoUniRegalo3 = request.getParameter("tipoUniRegalo3");
			cantidadRegalo1 = request.getParameter("cantidadRegalo1");
			cantidadRegalo2 = request.getParameter("cantidadRegalo2");
			cantidadRegalo3 = request.getParameter("cantidadRegalo3");
		}			
	}	
	if(request.getParameter("interino") != null){
		Vector <String> vTemp = new Vector <String>();
		int contadorInterno = 0;
		for(int i = 1; i<=productosDeProveedor; i++){
			if(request.getParameter(("rg"+i))!=null){
				contadorInterno++;
				vTemp.addElement(request.getParameter(("rg"+i)));
			}
		}
		if(!(ArrayCantidad[0].trim().equals("")) && contadorInterno > 0){ // No esta vacio el arreglo previo y trae algo de ListadoCompra.jsp
			for(int i = 0; i<ArrayProducto.length; i++){ // Itero mi arreglo...
				for (int j = 0; j<vTemp.size(); j++){
					if(ArrayProducto[i].equals(vTemp.elementAt(j).substring(2,vTemp.elementAt(j).length()))){
						String tipoTemporal = vTemp.elementAt(j).substring(0,2);
						if(tipoTemporal.equals("PZ")){
							tipoTemporal ="Pieza";
						} else if(tipoTemporal.equals("CJ")){
							tipoTemporal = "Caja";
						} else {
							tipoTemporal = "Kilo";
						}
						if(ArrayTipo[i].equals(tipoTemporal)){ // Como es igual lo voy a borrar de mi vector.
							vTemp.removeElementAt(j);
							j --;
						}
					}
				}
			}
			if(vTemp.size() > 0){
				int nuevoTamanio = (ArrayCantidad.length + vTemp.size());
				String[] TempArrayCantidad = new String [nuevoTamanio];
				String[] TempArrayProducto = new String [nuevoTamanio];
				String[] TempArrayCUnidad = new String [nuevoTamanio];
				String[] TempArrayImporte = new String [nuevoTamanio];
				String[] TempArrayTipo = new String [nuevoTamanio];
				String[] TempArrayCambio = new String [nuevoTamanio];
				for (int i = 0; i<ArrayCantidad.length; i++){
					TempArrayCantidad[i] = ArrayCantidad[i];
					TempArrayProducto[i] = ArrayProducto[i];
					TempArrayCUnidad[i] = ArrayCUnidad[i];
					TempArrayImporte[i] = ArrayImporte[i];
					TempArrayTipo[i] = ArrayTipo[i];
					TempArrayCambio[i] = ArrayCambio[i];					
				}
				for (int i = 0; i<vTemp.size(); i++){
					TempArrayCantidad[i+ArrayCantidad.length] = "1";
					TempArrayCambio[i+ArrayCantidad.length] = "0";
					TempArrayProducto[i+ArrayCantidad.length] = vTemp.elementAt(i).substring(2,vTemp.elementAt(i).length());					
					TempArrayCUnidad[i+ArrayCantidad.length] = (alCom.precioAsignado(vTemp.elementAt(i).substring(2,vTemp.elementAt(i).length()), vTemp.elementAt(i).substring(0,2))+"");						
					TempArrayTipo[i+ArrayCantidad.length] = vTemp.elementAt(i).substring(0,2);						
					TempArrayImporte[i+ArrayCantidad.length] = TempArrayCUnidad[i+ArrayCantidad.length];								
				}
				ArrayCantidad = new String[nuevoTamanio];
				ArrayProducto = new String[nuevoTamanio];
				ArrayTipo = new String[nuevoTamanio];
				ArrayCambio = new String[nuevoTamanio];
				ArrayCUnidad = new String[nuevoTamanio];
				ArrayImporte = new String[nuevoTamanio];			
				System.arraycopy(TempArrayCantidad, 0, ArrayCantidad, 0, TempArrayCantidad.length);
				System.arraycopy(TempArrayProducto, 0, ArrayProducto, 0, TempArrayProducto.length);
				System.arraycopy(TempArrayCUnidad, 0, ArrayCUnidad, 0, TempArrayCUnidad.length);
				System.arraycopy(TempArrayImporte, 0, ArrayImporte, 0, TempArrayImporte.length);
				System.arraycopy(TempArrayTipo, 0, ArrayTipo, 0, TempArrayTipo.length);
				System.arraycopy(TempArrayCambio, 0, ArrayCambio, 0, TempArrayCambio.length);
			}
		}
		else if(contadorInterno > 0){
			//Solo para la primera vez...
			ArrayCantidad = new String[contadorInterno];
			ArrayProducto = new String[contadorInterno];
			ArrayTipo = new String[contadorInterno];
			ArrayCambio  = new String[contadorInterno];
			ArrayCUnidad = new String[contadorInterno];
			ArrayImporte = new String[contadorInterno];
			for(int i = 0; i<contadorInterno; i++){
				ArrayProducto[i] = vTemp.elementAt(i).substring(2,vTemp.elementAt(i).length());
				ArrayTipo[i] = vTemp.elementAt(i).substring(0,2);
				ArrayCUnidad[i] = (alCom.precioAsignado(ArrayProducto[i], ArrayTipo[i])+"");
				ArrayImporte[i] = ArrayCUnidad[i];
				ArrayCantidad[i] = "1";
				ArrayCambio[i] = "0";
			}
		}
	}
	else if(request.getParameter("obsequio") != null){
		String obsequio = request.getParameter("obsequio");
		if(request.getParameter("rg")!= null){
			String tipoTemporal = request.getParameter("rg").substring(0,2);
			if(tipoTemporal.equals("PZ")){
				tipoTemporal ="Pieza";
			} else if(tipoTemporal.equals("CJ")){
				tipoTemporal = "Caja";
			} else {
				tipoTemporal = "Kilo";
			}		
			if(obsequio.equals("1")) {
				prodRegalo1 = request.getParameter("rg").substring(2,request.getParameter("rg").length());
				prodRegalo2 = request.getParameter("prodRegalo2");
				prodRegalo3 = request.getParameter("prodRegalo3");
				tipoUniRegalo1 = tipoTemporal;
				tipoUniRegalo2 = request.getParameter("tipoUniRegalo2");
				tipoUniRegalo3 = request.getParameter("tipoUniRegalo3");
				cantidadRegalo1 = "1";
				cantidadRegalo2 = request.getParameter("cantidadRegalo2");
				cantidadRegalo3 = request.getParameter("cantidadRegalo3");
			}
			else if(obsequio.equals("2")){
				prodRegalo1 = request.getParameter("prodRegalo1");
				prodRegalo2 = request.getParameter("rg").substring(2,request.getParameter("rg").length());
				prodRegalo3 = request.getParameter("prodRegalo3");
				tipoUniRegalo1 = request.getParameter("tipoUniRegalo1");
				tipoUniRegalo2 = tipoTemporal;
				tipoUniRegalo3 = request.getParameter("tipoUniRegalo3");
				cantidadRegalo1 = request.getParameter("cantidadRegalo1");
				cantidadRegalo2 = "1";
				cantidadRegalo3 = request.getParameter("cantidadRegalo3");
			}
			else{
				prodRegalo1 = request.getParameter("prodRegalo1");
				prodRegalo2 = request.getParameter("prodRegalo2");
				prodRegalo3 = request.getParameter("rg").substring(2,request.getParameter("rg").length());
				tipoUniRegalo1 = request.getParameter("tipoUniRegalo1");
				tipoUniRegalo2 = request.getParameter("tipoUniRegalo2");
				tipoUniRegalo3 = tipoTemporal;
				cantidadRegalo1 = request.getParameter("cantidadRegalo1");
				cantidadRegalo2 = request.getParameter("cantidadRegalo2");
				cantidadRegalo3 = "1";		
			}
		}
	}
	
%>
<body onLoad="setFocus();MM_preloadImages('imagenes/Regresar2.jpg')">
<h1>FORMATO SOLICITUD ALTA DE COMPRA.</h1>
<form method="post" name="ph" target="_self" onSubmit="return OnSubmitForm();">
<%
	ResultSet proveedores = alCom.datosProveedoresActivos();
%>
<table align="center" width="500" cellpadding="0" cellspacing="0" border="1">
<caption>
Selecci&oacute;n del Proveedor:
</caption>
  <tr>
    <th width="180"><div align="center">Proveedor:</div></th>
	<td width="284">
	  <div align="center">
	    <select name="proveedorC" onChange="MandaSubmit(document.forms[0])">
<%
	if(proveedor.equalsIgnoreCase("")){
%>	
		  <option selected value="">SELECCIONE</option>
<%
	}
	while (proveedores.next()){
%>	
		  <option <% if(proveedor.equalsIgnoreCase(proveedores.getString("rfc"))){ %> selected <%	} %> value ="<%=proveedores.getString("rfc")%>"><%=proveedores.getString("nombre")%></option>
<%
	}
	if(proveedores != null){
		proveedores.close();
	}
	alCom.cierraConexion();		// de ResultSet Complex							
%>				 
	      </select>
    </div></td>
  </tr>
</table>
<br />
</form>
<% if(!proveedor.equalsIgnoreCase("")){
%>
<form method="post" name="ph1" target="_self" onSubmit="return OnSubmitForm();">
<table width="700" border="1" cellspacing="0" cellpadding="0">
  <caption align="top"> ALTA DE COMPRA </caption>
  <tr>
  	<th colspan="2">Producto</th>
    <th width="62">Tipo</th>	
    <th width="100">Cantidad</th>
    <th width="121">Costo</th>
	<th width="62">Cambia<br/>Precio</th>
    <th width="127">Importe<br/>Total</th>	
  </tr>  
<%
	if(ArrayCantidad != null){
	for (int i=0; i < ArrayCantidad.length; i++){
		String tempCantidad = (ArrayCantidad[i] == null) ? "0" : ArrayCantidad[i];
		String tempProducto = (ArrayProducto[i] == null) ? "" : ArrayProducto[i];
		String tempCambio = (ArrayCambio[i] == null) ? "0" : ArrayCambio[i];
		String tempTipo = "";
		if(ArrayTipo[i].equals("PZ") || ArrayTipo[i].equals("Pieza"))
			tempTipo ="Pieza";
		else if(ArrayTipo[i].equals("CJ") || ArrayTipo[i].equals("Caja"))
			tempTipo = "Caja";
		else
			tempTipo = "Kilo";
		String tempCUnidad = (ArrayCUnidad[i] == null) ? "0" : alCom.formatoDinero(alCom.acortaLongitud(ArrayCUnidad[i]));
		String tempImporte = (ArrayImporte[i] == null) ? "0" : alCom.formatoDinero(alCom.acortaLongitud(ArrayImporte[i]));
%> 
  <tr>
    <td width="137"><%  if(tempProducto.equals("")){  %><input id="producto<%=i%>" type="hidden" name="producto" value="<%=tempProducto%>"><%  } else{ %> <input id="producto<%=i%>" type="hidden" name="producto" value="<%=tempProducto%>"><%=alCom.dameDescripcionProducto(tempProducto)%><%  }  %></td>
	<td width="75"><%  if(tempProducto.equals("")){  %><input type="button" name="Borrar" value="Borrar" disabled onClick="borrame(producto.id)"><%  } else{ %><input type="button" name="Borrar" value="Borrar" onClick="borrame('producto<%=i%>', 'cantidad<%=i%>', 'tipo<%=i%>', 'unidad<%=i%>', 'importe<%=i%>')"><%  }  %> </td>
	<td> <div align="center"><input type="hidden" id="tipo<%=i%>" name="tipo" value="<%=tempTipo%>"><%=tempTipo%></div></td>	
    <td><div align="center">
      <input type="text" id="cantidad<%=i%>" name="cantidad" size="7"  onFocus="seleccionaTodo(this)" maxlength="6" value="<%=tempCantidad%>" onChange="recalculaValor('cantidad<%=i%>',  'unidad<%=i%>', 'importe<%=i%>' )"  onKeypress="
	<% if(tempTipo.equals("Kilo")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" > <input type="button" value="Re"></div></td>
    <td><div align="right">$ <input  type="text" id="unidad<%=i%>" name="unidad" size="8" maxlength="8" value="<%=tempCUnidad%>" onFocus="seleccionaTodo(this)"  onChange="recalculaValor('cantidad<%=i%>',  'unidad<%=i%>', 'importe<%=i%>' )" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}"></div></td>
	<td><div align="center"><select name="cambio" id="cambio<%=i%>">
		<option value="0" <%if(tempCambio.equals("0")){%> selected <%}%>>No</option>
		<option value="1" <%if(tempCambio.equals("1")){%> selected <%}%>>Sí</option>		
	</select></div></td>	
    <td><div align="right">$ <input type="text" id="importe<%=i%>" name="importe" readonly="true" size="8" maxlength="8" value="<%=tempImporte%>"></div></td>
  </tr>  
<% 		} // cierro ciclo for 
	}else {// Cierro no es nulo %>
  <tr>
    <td width="137">&nbsp;<input id="producto" type="hidden" name="producto"></td>
	<td  width="75"><input type="button" name="Borrar" value="Borrar" disabled onClick="borrame(producto)"></td>
	<td> <div align="center"><input type="hidden" name="tipo">&nbsp;</div></td>		
    <td><div align="center">
      <input type="text" name="cantidad" size="7"  onFocus="seleccionaTodo(this)" maxlength="6" readonly="true"> <input type="button" value="Re">
    </div></td>
    <td><div align="right">$ <input type="text" name="unidad" readonly="true" size="8" maxlength="8" ></div></td>
	<td><div align="center"><select name="cambio">
		<option disabled value="0" selected >No</option>		
	</select></div></td>	
    <td><div align="right">$ <input type="text" name="importe" readonly="true" size="8" maxlength="8" ></div></td>	
  </tr>  
<%	} // Cierro nulo %>
</table>
<p>
  <input type="reset" name="reset" value="Restablecer"><br/>
  <input type="hidden" name="proveedorC" value="<%=proveedor%>"><br />
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Aumentar">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Guardar">
</p>
<table align="center" width="600" border="1">
	<caption>Productos de Obsequio</caption>
	<tr>
		<th colspan="2">Producto</th>
		<th>Tipo</th>
		<th>Cantidad</th>
		<th>Borrar</th>		
	</tr>
	<tr>
		<td><input type="hidden" name="prodRegalo1" value="<%=prodRegalo1%>"> <%if(prodRegalo1.length()>0){%><%=alCom.dameDescripcionProducto(prodRegalo1)%><%} else{%>&nbsp;<% } %></td>
		<td><input type="submit" name="Regalo1" onClick="document.pressed=this.name" value="Selecciona.."></td>
		<td><input type="hidden" name="tipoUniRegalo1" value="<%=tipoUniRegalo1%>"> <%if(tipoUniRegalo1.length()>0){%><%=tipoUniRegalo1%><%} else{%>&nbsp;<% } %></td>
		<td><input type="text" size="8" maxlength="6" onFocus="seleccionaTodo(this)" name="cantidadRegalo1" <% if(prodRegalo1.equals("")){%> readonly="true" <% }%> value="<%=cantidadRegalo1%>" onKeyPress="	
	<% if(tipoUniRegalo1.equals("Kilo")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else if(tipoUniRegalo1.equals("Pieza") || tipoUniRegalo1.equals("Caja")) { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" ></td>		
		<td><input type="button" name="borrar1" value="Borrar" <%if(prodRegalo1.equals("")){%> disabled <% }%> onClick="borrame2(prodRegalo1, tipoUniRegalo1, cantidadRegalo1)"></td>		
	</tr>
	<tr>
		<td><input type="hidden" name="prodRegalo2" value="<%=prodRegalo2%>"> <%if(prodRegalo2.length()>0){%><%=alCom.dameDescripcionProducto(prodRegalo2)%><%} else{%>&nbsp;<% } %> </td>
		<td><input type="submit" name="Regalo2" onClick="document.pressed=this.name" value="Selecciona.."></td>
		<td><input type="hidden" name="tipoUniRegalo2" value="<%=tipoUniRegalo2%>"> <%if(tipoUniRegalo2.length()>0){%><%=tipoUniRegalo2%><%} else{%>&nbsp;<% } %></td>
		<td><input type="text" size="8" maxlength="6" onFocus="seleccionaTodo(this)" name="cantidadRegalo2" <% if(prodRegalo2.equals("")){%> readonly="true" <% }%> value="<%=cantidadRegalo2%>" onKeyPress="	
	<% if(tipoUniRegalo2.equals("Kilo")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else if(tipoUniRegalo2.equals("Pieza") || tipoUniRegalo2.equals("Caja")) { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" ></td>	
		<td><input type="button" name="borrar2" value="Borrar" <%if(prodRegalo2.equals("")){%> disabled <% }%> onClick="borrame2(prodRegalo2, tipoUniRegalo2, cantidadRegalo2)"></td>	
	</tr>
	<tr>
		<td><input type="hidden" name="prodRegalo3" value="<%=prodRegalo3%>"> <%if(prodRegalo3.length()>0){%><%=alCom.dameDescripcionProducto(prodRegalo3)%><%} else{%>&nbsp;<% } %></td>
		<td><input type="submit" name="Regalo3" onClick="document.pressed=this.name" value="Selecciona.."></td>
		<td><input type="hidden" name="tipoUniRegalo3" value="<%=tipoUniRegalo3%>"> <%if(tipoUniRegalo3.length()>0){%><%=tipoUniRegalo3%><%} else{%>&nbsp;<% } %></td>
		<td><input type="text" size="8" maxlength="6" onFocus="seleccionaTodo(this)" name="cantidadRegalo3" <% if(prodRegalo3.equals("")){%> readonly="true" <% }%> value="<%=cantidadRegalo3%>" onKeyPress="
	<% if(tipoUniRegalo3.equals("Kilo")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else if(tipoUniRegalo3.equals("Pieza") || tipoUniRegalo3.equals("Caja")) { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" ></td>		
		<td><input type="button" name="borrar3" value="Borrar" <%if(prodRegalo3.equals("")){%> disabled <% }%> onClick="borrame2(prodRegalo3, tipoUniRegalo3, cantidadRegalo3)"></td>		
	</tr>
</table>
</form>
<% } %>
<p>
<a href="Menu_Compras.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

