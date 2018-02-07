<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.text.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Alta Compra</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){	
	f.submit();
}

function setFocus(){
	var contenido = document.ph1.proveedorQ.options[0].text;
	if(contenido == "SELECCIONE"){
		document.ph1.proveedorQ.focus();
	}
	else {
		if(ph1.elements[ph1.length - 53].value==""){		
			ph1.elements[ph1.length - 54].select();
		}
		else{
		
			ph1.elements[ph1.length-47].focus();
		}
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
		document.ph1.action ="Conf_Alta_Prueba.jsp";
	}
	else if(document.pressed == 'Aumentar')   {
		document.ph1.action ="Alta_Prueba.jsp";
	}
	else{
		var kiko = document.pressed.name;
		if(kiko != '') {		
			document.ph1.action ="ListadoTest.jsp?"+kiko;
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
	String numProductos = "1";
	int cantNumProductos = 1;
	String idProducto = "";
	String proveedor = "";
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

	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	//System.out.println("2");
	if(request.getParameter("proveedor") != null){
		proveedor = request.getParameter("proveedor"); 
	}	
	if(request.getParameter("numProductos")!= null){
		numProductos = request.getParameter("numProductos");
		cantNumProductos = alCom.cambiaAInt(numProductos);
		ArrayCantidad   = new String[cantNumProductos+1]; // Aumento 1 para facilitar el manejo del arreglo.
		ArrayProducto   = new String[cantNumProductos+1];
		ArrayCUnidad   = new String[cantNumProductos+1];
		ArrayImporte   = new String[cantNumProductos+1];
		//System.out.println("4");
		for (int i =1; i<=cantNumProductos; i++){
		
			ArrayCantidad[i] = request.getParameter("cantidad"+i);
			ArrayProducto[i] = request.getParameter("producto"+i);
			ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
			ArrayImporte[i] = request.getParameter("importe"+i);
			//System.out.println("Cambia"+i+" :"+Arraycambia[i]);
		}	
		//System.out.println("5");
		if(request.getParameter("idProducto")!= null){
		//System.out.println("query: "+request.getParameter("idProducto"));
		if(request.getParameter("idProducto").equalsIgnoreCase("R1") || request.getParameter("idProducto").equalsIgnoreCase("R2") || request.getParameter("idProducto").equalsIgnoreCase("R3")  || request.getParameter("idProducto").equalsIgnoreCase("R4") || request.getParameter("idProducto").equalsIgnoreCase("R5") || request.getParameter("idProducto").equalsIgnoreCase("R6") || request.getParameter("idProducto").equalsIgnoreCase("R7") || request.getParameter("idProducto").equalsIgnoreCase("R8") || request.getParameter("idProducto").equalsIgnoreCase("R9") || request.getParameter("idProducto").equalsIgnoreCase("R10") || request.getParameter("idProducto").equalsIgnoreCase("R11") || request.getParameter("idProducto").equalsIgnoreCase("R12") || request.getParameter("idProducto").equalsIgnoreCase("R13") || request.getParameter("idProducto").equalsIgnoreCase("R14") || request.getParameter("idProducto").equalsIgnoreCase("R15")){
			if(request.getParameter("idProducto").equalsIgnoreCase("R1")){
					tempprod1 = request.getParameter("rg1");
					tempprod1 = tempprod1.substring(0,tempprod1.length()); 	
					//System.out.println("Forma: "+tempuni1);
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R2")){
				tempprod2 = request.getParameter("rg1");	
				tempprod2 = tempprod2.substring(0,tempprod2.length()); 						
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R3")){
				tempprod3 = request.getParameter("rg1");	
				tempprod3 = tempprod3.substring(0,tempprod3.length()); 
			}	

			if(request.getParameter("idProducto").equalsIgnoreCase("R4")){
				tempprod4 = request.getParameter("rg1");	
				tempprod4 = tempprod4.substring(0,tempprod4.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R5")){
				tempprod5 = request.getParameter("rg1");	
				tempprod5 = tempprod5.substring(0,tempprod5.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R6")){
				tempprod6 = request.getParameter("rg1");	
				tempprod6 = tempprod6.substring(0,tempprod6.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R7")){
				tempprod7 = request.getParameter("rg1");	
				tempprod7 = tempprod7.substring(0,tempprod7.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R8")){
				tempprod8 = request.getParameter("rg1");	
				tempprod8 = tempprod8.substring(0,tempprod8.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R9")){
				tempprod9 = request.getParameter("rg1");	
				tempprod9 = tempprod9.substring(0,tempprod9.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R10")){
				tempprod10 = request.getParameter("rg1");	
				tempprod10 = tempprod10.substring(0,tempprod10.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R11")){
				tempprod11 = request.getParameter("rg1");	
				tempprod11 = tempprod11.substring(0,tempprod11.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R12")){
				tempprod12 = request.getParameter("rg1");	
				tempprod12 = tempprod12.substring(0,tempprod12.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R13")){
				tempprod13 = request.getParameter("rg1");	
				tempprod13 = tempprod13.substring(0,tempprod13.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R14")){
				tempprod14 = request.getParameter("rg1");	
				tempprod14 = tempprod14.substring(0,tempprod14.length()); 
			}	
			if(request.getParameter("idProducto").equalsIgnoreCase("R15")){
				tempprod15 = request.getParameter("rg1");	
				tempprod15 = tempprod15.substring(0,tempprod15.length()); 
			}	


		}
		else{
			idProducto = request.getParameter("idProducto");
			int idpro = alCom.cambiaAInt(idProducto);
			String claveProducto = request.getParameter("rg1");		
			//System.out.println(claveProducto);
			if(claveProducto == null){
				claveProducto = "";
			}
			//System.out.println("7");
			if(!(claveProducto.equalsIgnoreCase(""))){
				claveProducto = claveProducto.substring(0, (claveProducto.length()));
				boolean repetido = false;	// Bandera para verificar que no este repetido ya ese producto.
				for(int i=1; i<=cantNumProductos; i++){
					if(ArrayProducto[i].equalsIgnoreCase(claveProducto)){
							repetido = true;
					}
				}
				if(!repetido){
					ArrayProducto[idpro] = claveProducto;
%>
<jsp:setProperty name="alCom" property="claveProducto" value="<%=claveProducto%>"/>
<%				
//System.out.println(claveProducto);
					ArrayCUnidad[idpro] = alCom.formatoDinero(alCom.precioProducto(claveProducto));
					String piezas = ArrayCantidad[idpro];
// NUEVO PARA CORRECTO DESPLIEGUE DE LOS DECIMALES:					
					double multiplicados = (alCom.cambiaADouble(alCom.remueveComas((ArrayCUnidad[idpro]))) * alCom.cambiaADouble(piezas));
					NumberFormat nf = NumberFormat.getInstance();
					String numeritolargo = nf.format(multiplicados);
					ArrayImporte[idpro] = numeritolargo;
// HASTA ACA...					
				}
			}
			}
		}
		//System.out.println("8");
		for (int i=1; i<=cantNumProductos; i++){
			if(ArrayProducto[i] == null || ArrayProducto[i].equalsIgnoreCase("")){
				String[] Arraytemp1 = new String[cantNumProductos];
				String[] Arraytemp2 = new String[cantNumProductos];
				String[] Arraytemp4 = new String[cantNumProductos];
				String[] Arraytemp5 = new String[cantNumProductos];
				if(ArrayProducto.length != 2){
					if(i<cantNumProductos){
						int n = i;
						int m = 1;
						for (int k = 1; k<=cantNumProductos; k++){							
							if(k!=n){
								Arraytemp1[m] = ArrayCantidad[k];
								Arraytemp2[m] = ArrayProducto[k];
								Arraytemp4[m] = ArrayCUnidad[k];
								Arraytemp5[m] = ArrayImporte[k];
								m++;
							}
						}
						cantNumProductos -=1;
						ArrayCantidad = new String[cantNumProductos +1];
						ArrayProducto = new String[cantNumProductos +1];
						ArrayCUnidad = new String[cantNumProductos +1];
						ArrayImporte = new String[cantNumProductos +1];
						for (int j = 1; j<=cantNumProductos; j++){
							ArrayCantidad[j] = Arraytemp1[j];
							ArrayProducto[j] = Arraytemp2[j];
							ArrayCUnidad[j] = Arraytemp4[j];
							ArrayImporte[j] = Arraytemp5[j];
						}
						i--;
					}
				}					
			}
		}		
	}
%>
<body onLoad="setFocus();MM_preloadImages('imagenes/Regresar2.jpg')">
<h1>FORMATO SOLICITUD ALTA DE COMPRA.</h1>
<form method="post" name="ph1" target="_self" onSubmit="return OnSubmitForm();">
<!-- AQUI EMPIEZA -->
<%
	ResultSet proveedores = alCom.datosProveedoresActivos();
%>

<table align="center" width="531" cellpadding="0" cellspacing="0" border="1">
<caption>Proveedor:</caption>
  <tr>
    <th width="108">Seleccione Proveedor:</th>
	<td width="417">
	<select name="proveedorQ">
<%
	while (proveedores.next()){
%>	
		<option
<%
		if(proveedor.equalsIgnoreCase(proveedores.getString("rfc"))){
%>
selected 
<%
		}
%>		
			 value ="<%=proveedores.getString("rfc")%>"><%=proveedores.getString("nombre")%></option>
<%
	}
	if(proveedores != null){
		proveedores.close();
	}
	alCom.cierraConexion();
%>				 
	</select>
	</td>
    </tr>
</table>
<p></p>
<table width="649" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">
  COMPRA ALTA
  </caption>
  <tr>
  	<th width="100" rowspan="2" scope="col">Cantidad</th>
    <th width="362" rowspan="2" scope="col">Producto</th>
    <th width="135" rowspan="2" scope="col">Costo Unidad</th>
    <th width="112" rowspan="2" scope="col">Importe</th>
  </tr>
  </table>
<%
	for (int i=1; i<=cantNumProductos; i++){
		String tempCantidad = (ArrayCantidad[i] == null) ? "1" : ArrayCantidad[i];
		String tempProducto = (ArrayProducto[i] == null) ? "" : ArrayProducto[i];
		String tempCUnidad = (ArrayCUnidad[i] == null) ? "0" : ArrayCUnidad[i];
		String tempImporte = (ArrayImporte[i] == null) ? "0" : ArrayImporte[i];
%> 
<table width="649" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="95"><input type="text" name="cantidad<%=i%>" size="7" onFocus="seleccionaTodo(this)" maxlength="6" value="<%=tempCantidad%>" onChange="recalculaValor(this, ph1.cUnidad<%=i%>, ph1.importe<%=i%>, ph1.producto<%=i%>)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ ph1.Submit<%=i%>.focus();}"></td>
    <td width="317"><input type="text" name="producto<%=i%>" size="15" maxlength="8" readonly="true" value="<%=tempProducto%>">
	<input type="Submit" name="Submit<%=i%>" value="Ob.." onClick="document.pressed=this.form.producto<%=i%>">
	</td>
    <td width="122"><div align="right">$ <input type="text" name="cUnidad<%=i%>" onFocus="seleccionaTodo(this)" onChange="recalculaValor(ph1.cantidad<%=i%>, this, ph1.importe<%=i%>, ph1.producto<%=i%>)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ ph1.Submit<%=i%>.focus();}"  size="10" maxlength="9" value="<%=tempCUnidad%>"></div></td>
    <td width="105"><div align="right">$ <input type="text" name="importe<%=i%>" size="10" readonly="true"  maxlength="9" value="<%=tempImporte%>"></div></td>
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
  <input type="hidden" name="proveedor" value="<%=proveedor%>">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Aumentar">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Guardar">
</p>
  <table width="541" border="1">
  <caption>
  OBSEQUIOS EXTRAS
  </caption>
	  <tr>
		  <th width="105">Cantidad</th>
		  <th width="410">Producto</th>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR1" size="7" maxlength="6" value="<%=tempcan1%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR1" size="15" maxlength="12" readonly="true" value="<%=tempprod1%>">
	  <input type="Submit" name="SubmitR1" value="Ob.." onClick="document.pressed=this.form.productoR1">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR2" size="7" maxlength="6" value="<%=tempcan2%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR2" size="15" maxlength="12" readonly="true" value="<%=tempprod2%>">
	  <input type="Submit" name="SubmitR2" value="Ob.." onClick="document.pressed=this.form.productoR2">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR3" size="7" maxlength="6" value="<%=tempcan3%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR3" size="15" maxlength="12" readonly="true" value="<%=tempprod3%>">
	  <input type="Submit" name="SubmitR3" value="Ob.." onClick="document.pressed=this.form.productoR3">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR4" size="7" maxlength="6" value="<%=tempcan4%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR4" size="15" maxlength="12" readonly="true" value="<%=tempprod4%>">
	  <input type="Submit" name="SubmitR4" value="Ob.." onClick="document.pressed=this.form.productoR4">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR5" size="7" maxlength="6" value="<%=tempcan5%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR5" size="15" maxlength="12" readonly="true" value="<%=tempprod5%>">
	  <input type="Submit" name="SubmitR5" value="Ob.." onClick="document.pressed=this.form.productoR5">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR6" size="7" maxlength="6" value="<%=tempcan6%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR6" size="15" maxlength="12" readonly="true" value="<%=tempprod6%>">
	  <input type="Submit" name="SubmitR6" value="Ob.." onClick="document.pressed=this.form.productoR6">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR7" size="7" maxlength="6" value="<%=tempcan7%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR7" size="15" maxlength="12" readonly="true" value="<%=tempprod7%>">
	  <input type="Submit" name="SubmitR7" value="Ob.." onClick="document.pressed=this.form.productoR7">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR8" size="7" maxlength="6" value="<%=tempcan8%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR8" size="15" maxlength="12" readonly="true" value="<%=tempprod8%>">
	  <input type="Submit" name="SubmitR8" value="Ob.." onClick="document.pressed=this.form.productoR8">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR9" size="7" maxlength="6" value="<%=tempcan9%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR9" size="15" maxlength="12" readonly="true" value="<%=tempprod9%>">
	  <input type="Submit" name="SubmitR9" value="Ob.." onClick="document.pressed=this.form.productoR9">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR10" size="7" maxlength="6" value="<%=tempcan10%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR10" size="15" maxlength="12" readonly="true" value="<%=tempprod10%>">
	  <input type="Submit" name="SubmitR10" value="Ob.." onClick="document.pressed=this.form.productoR10">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR11" size="7" maxlength="6" value="<%=tempcan11%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR11" size="15" maxlength="12" readonly="true" value="<%=tempprod11%>">
	  <input type="Submit" name="SubmitR11" value="Ob.." onClick="document.pressed=this.form.productoR11">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR12" size="7" maxlength="6" value="<%=tempcan12%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR12" size="15" maxlength="12" readonly="true" value="<%=tempprod12%>">
	  <input type="Submit" name="SubmitR12" value="Ob.." onClick="document.pressed=this.form.productoR12">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR13" size="7" maxlength="6" value="<%=tempcan13%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR13" size="15" maxlength="12" readonly="true" value="<%=tempprod13%>">
	  <input type="Submit" name="SubmitR13" value="Ob.." onClick="document.pressed=this.form.productoR13">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR14" size="7" maxlength="6" value="<%=tempcan14%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR14" size="15" maxlength="12" readonly="true" value="<%=tempprod14%>">
	  <input type="Submit" name="SubmitR14" value="Ob.." onClick="document.pressed=this.form.productoR14">
	  </td>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR15" size="7" maxlength="6" value="<%=tempcan15%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
	        </div></td>
      <td><input type="text" name="productoR15" size="15" maxlength="12" readonly="true" value="<%=tempprod15%>">
	  <input type="Submit" name="SubmitR15" value="Ob.." onClick="document.pressed=this.form.productoR15">
	  </td>
	  </tr>

  </table>
</form>
<p>
<a href="Menu_Compras.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
