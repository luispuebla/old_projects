<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>C&aacute;lculo de Venta</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
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

function funcionFoco(){
	document.form1.documento.focus();
}

function seleccionaTodo(objeto){
	objeto.select();
}

function des(f) { 
	var SPrecio = new String();
	SPrecio = f.subtotal.value;
	re = /,/gi;
	SPrecio = SPrecio.replace(re,"");

	var SPrecio2 = new String();
	SPrecio2 = f.imporiva.value;
	re = /,/gi;
	SPrecio2 = SPrecio2.replace(re,"");

	var SPrecio3 = new String();
	SPrecio3 = f.total.value;
	SPrecio3 = SPrecio3.replace(re,"");

	var impdes = new Number();
	impdes = SPrecio;
	var iv = new Number();
	iv = SPrecio2 * 0.15;	
	var to = new Number();
	to = SPrecio;		
	if (isNaN(iv))
			iv = 0;
	if (isNaN(to))
			to = 0;
	iv = roundOff(iv);
	to = roundOff(to);
	iv = formatCurrency(iv);
	to = formatCurrency(to);
	//alert(resul);
document.form1.iva.value = iv;
document.form1.total.value = to;
}

function roundOff(value)
{
        value = "" + value //convert value to string
        var precision = 2;

        var whole = "" + Math.round(value * Math.pow(10, precision));

        var decPoint = whole.length - precision;

        if(decPoint != 0)
        {
                result = whole.substring(0, decPoint);
                result += ".";
                result += whole.substring(decPoint, whole.length);
        }
        else
        {
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
num = num.substring(0,num.length-(4*i+3))+','+
num.substring(num.length-(4*i+3));
return (((sign)?'':'-') + num + '.' + cents);
}


function defineEstado(f){
	var define = f.documento.value;
	if(define == "1"){	
		f.numFac.value="";	
		f.numFac.disabled = false;
	}
	else{
		f.numFac.value="";		
		f.numFac.disabled = true;
	}
}

function setFecha(){
if(document.form1 != null){
	var fechaHoy = new Date();
	var mesHoy = new String();
	var anioHoy = new String();
	var diaHoy = new String();
	var ndiaHoy =  new Number();
	var nmesHoy = new Number();		
	nmesHoy = (fechaHoy.getMonth()+1);
	anioHoy = (fechaHoy.getYear());
	ndiaHoy = (fechaHoy.getDate());
	diaHoy = ndiaHoy +"";
	mesHoy = nmesHoy +"";
	if(diaHoy.length==1){
		diaHoy = "0"+diaHoy;
	}
	if(mesHoy.length==1){
		mesHoy = "0"+mesHoy;
	}
	document.form1.datebox.value=mesHoy+"/"+diaHoy+"/"+anioHoy;
	document.form1.datebox2.value=mesHoy+"/"+diaHoy+"/"+anioHoy;
	}	
}

function OnSubmitForm(){
	var regreso = true;
	if(document.pressed == 'Enviar')   {
		if (document.form1.documento.value == "1"){
			if(document.form1.numFac.value == ""){
				alert("Debes ingresar la Factura correspondiente a la Venta");
				document.form1.numFac.focus();
				regreso = false;
			}
			else{
				document.form1.action ="Guarda_Alta_Venta.jsp";
			}			
		}
		else{
			document.form1.action ="Guarda_Alta_Venta.jsp";
		}
	}
	return regreso;
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
	int contadorCeroInterno = 0;	
	String numProductos = "1";
	int cantNumProductos = 1;
	String cliente = "";
	//String queryString = request.getQueryString();
	//queryString = queryString.substring(8);	
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	String[] ArrayRegalos = new String[2];
	boolean sinProducto = false;
	boolean nohayProductoVenta = true;
	String tempcan1 = "";
	String tempcan2 = "";
	String tempcan3 = "";
	String tempprod1 = "";
	String tempprod2 = "";
	String tempprod3 = "";
	String numFac = "";
	String documento = "";
	
	if(request.getParameter("numFac") != null)
		numFac = request.getParameter("numFac");
	if(request.getParameter("documento") != null)
		documento = request.getParameter("documento");
	if(request.getParameter("cantidadR1") != null)
		tempcan1 = request.getParameter("cantidadR1");
	if(request.getParameter("cantidadR2") != null)
		tempcan2 = request.getParameter("cantidadR2");
	if(request.getParameter("cantidadR3") != null)
		tempcan3 = request.getParameter("cantidadR3");
	if(request.getParameter("productoR1") != null && !tempcan1.equals("") && alVen.cambiaADouble(tempcan1) > 0)
		tempprod1 = request.getParameter("productoR1");
	else
		tempcan1 = "";	
	if(request.getParameter("productoR2") != null && !tempcan2.equals("") && alVen.cambiaADouble(tempcan2) > 0)
		tempprod2 = request.getParameter("productoR2");
	else
		tempcan2 = "";			
	if(request.getParameter("productoR3") != null && !tempcan3.equals("") && alVen.cambiaADouble(tempcan3) > 0)
		tempprod3 = request.getParameter("productoR3");
	else
		tempcan3 = "";			
	//System.out.println("Entrega Original: "+entrega);
	cliente = request.getParameter("clienteC");
	//System.out.println(cliente);
	numProductos = request.getParameter("numProductos");
	cantNumProductos = alVen.cambiaAInt(numProductos);
	cantNumProductos -=1;
	ArrayCantidad   = new String[cantNumProductos+1]; // Aumento 1 para facilitar el manejo del arreglo.
	ArrayProducto   = new String[cantNumProductos+1];
	ArrayCUnidad   = new String[cantNumProductos+1];
	ArrayImporte   = new String[cantNumProductos+1];
	ArrayRegalos = new String[cantNumProductos+1];	
	if(request.getParameter("producto"+(cantNumProductos)) != null){
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
	
	for (int i =0; i<=cantNumProductos; i++){
		if (ArrayProducto[i] != null && ! ArrayProducto[i].equals("")){
			nohayProductoVenta = false;
		}
	}
	
	if(tempprod1.equals("") && tempprod2.equals("") && tempprod3.equals("") && nohayProductoVenta){
		sinProducto = true;
	}
	try{
		if(ArrayProducto[1] == null){}
	}
	catch(IndexOutOfBoundsException iobe){
		if(tempprod1.equals("") && tempprod2.equals("") && tempprod3.equals("")){
			sinProducto = true;	
		}
	}
	
	if(!sinProducto){	
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); funcionFoco(), setFecha(), des(form1)">
<jsp:setProperty name="alVen" property="claveCliente" value="<%=cliente%>"/>
<form name="form1" method="post" target="_self" onSubmit="return OnSubmitForm();">
<% //System.out.println("Clave del Proveedor:  "+cliente); 
String NomClie = alVen.dameNombreCliente();
//System.out.println("Fecha Entrega Original: "+FechaEntrega);
double importes = 0.0;
double descuentos =0.0;
double ivas = 0.0;
double totales = 0.0;
double importesiva = 0.0;
double des1BD = 0.0;
double des2BD = 0.0;
double des3BD = 0.0;
//System.out.println("Nombre del Proveedor:  "+NomProv);
%>

<table align="center" width="600" border="1">
	<caption>Datos Documento Aval:</caption>
	<tr>
		<th>Tipo de Documento:</th>
		<td><select name="documento" onChange="defineEstado(this.form)">
			<option <%if (documento.equals("2") || documento.equals("")){%> selected <%}%>value="2">Remision</option>
			<option  <%if (documento.equals("1")){%> selected <%}%> value="1">Factura</option>
			</select>
		</td>
		<th>Número Factura:</th>
		<td><div align="center">
		  <input type="text" name="numFac" disabled value="<%=numFac%>">
		  </div></td>
	</tr>

</table>
<p></p>


<table width="730" border="1">
	<tr>
		<th width="92">Cliente:</th>
		<td width="193"><%=NomClie%></td>
		<th width="146">Fecha  Alta Venta:</th>
            <td width="190">
<input type=text name="datebox" size=15 readonly="true">
 <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a>   
</td>
	</tr>

<tr>
    <th>Fecha de Entrega:</th>
	<td><input type=text name="datebox2" size=15 readonly="true"> <a href="javascript:show_calendar('form1.datebox2');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a>
	</td>
     <th>Repartido:</th>
	<td><select name="repartidor" id="repartidor">
<%
ResultSet repartidores = personal.dameRepartidores();
while(repartidores.next()){
%>
		  <option value="<%= repartidores.getString("ClaveU")%>"><%= repartidores.getString("NombreCompleto")%></option>
<%
}
	if(repartidores != null){
		repartidores.close();
	}
	personal.cierraConexion();		// de ResultSet Complex									
%>
        </select></td>
 </tr>
	
</table>
<p></p>
	<table width="773" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
	  	<th width="120">Cantidad</th>
		<th width="318">Producto</th>
		<th width="168">Precio Unitario</th>
		<th width="157">Importe</th>
	  </tr>
<%
	for (int i =1; i<=cantNumProductos; i++){
		boolean conIva = false;
		if(!(ArrayProducto[i].equalsIgnoreCase(""))){
			if(alVen.tieneIva(ArrayProducto[i])){
				conIva = true;
				importesiva = importesiva + ((alVen.cambiaADouble(alVen.remueveComas(ArrayImporte[i]))*100)/115);
			}
			if(!conIva){
%>
      <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%=alVen.dameNombreProducto(ArrayProducto[i])%></td>
		<td><div align="right">$ <%=ArrayCUnidad[i]%></div></td>
		<td><div align="right">$ <%=ArrayImporte[i]%></div></td>
      </tr>
<%	
				importes = importes + alVen.cambiaADouble(alVen.remueveComas(ArrayImporte[i]));
			}
			else{
%>		
      <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%=alVen.dameNombreProducto(ArrayProducto[i])%></td>
		<td><div align="right">$ <%=alVen.formatoDinero(alVen.acortaLongitud(((alVen.cambiaADouble(alVen.remueveComas(ArrayCUnidad[i]))*100)/115)+""))%></div></td>
		<td><div align="right">$ <%=alVen.formatoDinero(alVen.acortaLongitud(((alVen.cambiaADouble(alVen.remueveComas(ArrayImporte[i]))*100)/115)+""))%></div></td>
      </tr>			
<%			
				importes = importes + ((alVen.cambiaADouble(alVen.remueveComas(ArrayImporte[i]))*100)/115);
			}
			//System.out.println("Antes de la Suma:  "+importes);
			//System.out.println("Despues de la Suma:  "+importes);  
			int compro = 0;
			int regalan = 0;
			int cant = 0;
			int comp = 0;

			}
		}
%>	  	  
  </table>
	<br />
  <table width="650" border="1">
  <caption>
  OBSEQUIOS EXTRAS
  </caption>
	  <tr>
		  <th>Cantidad</th>
		  <th>Producto</th>
	  </tr>
	  <tr>
		    <td><div align="center">
		      <input type="text" name="cantidadR1" size="7" maxlength="6" value="<%=tempcan1%>" readonly="true">
	        </div></td>
      <td><div align="left">
        <input type="text" name="productoR1" size="15" maxlength="12" readonly="true" value="<%=tempprod1%>">
		<%
			String tempNam1="";
			if(alVen.dameNombreProducto(tempprod1) != null){
				tempNam1 = alVen.dameNombreProducto(tempprod1);
			}
		%>
		<%=tempNam1%>
      </div></td>
	</tr>
	<tr>
	    <td>
	          <div align="center">
		          <input type="text" name="cantidadR2" size="7" maxlength="6" value="<%=tempcan2%>" readonly="true">
	              </div></td>
	    <td>
          <div align="left">
		    <input type="text" name="productoR2" size="15" maxlength="12" readonly="true" value="<%=tempprod2%>">
		    <%
			String tempNam2="";	
			if(alVen.dameNombreProducto(tempprod2) != null){
				tempNam2 = alVen.dameNombreProducto(tempprod2);
			}
		%>
		    <%=tempNam2%>
	      </div></td></tr>
	  <tr>
		    <td>
	          <div align="center">
	            <input type="text" name="cantidadR3" size="7" maxlength="6" value="<%=tempcan3%>" readonly="true">
	              </div></td>
		    <td>
              <div align="left">
		    <input type="text" name="productoR3" size="15" maxlength="12" readonly="true" value="<%=tempprod3%>">
		    <%
			String tempNam3="";	
			if(alVen.dameNombreProducto(tempprod3) != null){
				tempNam3 = alVen.dameNombreProducto(tempprod3);
			}
		%>
		    <%=tempNam3%>		
	            </div></td></tr>
  </table>
<br />
<table width="538" border="1">
<tr>
	<th width="261">Observaciones</th>
	<th width="104">Subtotal</th>
	<td width="151">
	  <div align="right">$ 
	      <input name="subtotal" type="text" value="<%=alVen.formatoDinero(alVen.acortaLongitud(importes+""))%>" size="10" maxlength="10" readonly="true">	  
        </div></td>
</tr>
<tr>
	<td rowspan="2"><textarea name="observaciones" cols="35" rows="5"></textarea></td>
    <th height="35"><div align="center"><strong>I.V.A.</strong></div></th>
  <%
 // System.out.println("importesiva: "+importesiva);
  ivas = importesiva * 0.15;
   //System.out.println("ivas: "+ivas); 
  %>
  <input name="imporiva" type="hidden" value="<%=importesiva%>">
  <td height="35"><div align="right">
    $ 
    <input name="iva" type="text" value="<%=alVen.formatoDinero(alVen.acortaLongitud(ivas+""))%>" size="10" maxlength="10" readonly="true">
  </div></td>
</tr>
<tr>
  <th><div align="center"><strong>TOTAL</strong></div></th>
<%  totales = (importes+ivas); %>
  <td><div align="right">
    $ 
    <input name="total2" type="text" value="<%=alVen.formatoDinero(alVen.acortaLongitud(totales+""))%>" size="10" maxlength="10" readonly="true">
  </div></td>
</tr>
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
<p></p>
<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">	
<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">	
<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">	
<input type="hidden" name="productoR1" value="<%=tempprod1%>">	
<input type="hidden" name="productoR2" value="<%=tempprod2%>">	
<input type="hidden" name="productoR3" value="<%=tempprod3%>">	
	<input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	<input type="hidden" name="cliente" value="<%=cliente%>">
	<input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Enviar">	
</form>
<% }else{ %>
		<b class="roj">No Hay productos a la Venta ni de Obsequio. Debe Seleccionar al menos uno de estos.</b>
<% } %>
<br />
<form method="post" target="_self" name="RegN" action="Alta_Venta.jsp"> 
	<a onClick="MandaSubmit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('RegresoN','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="RegresoN" width="152" height="36" border="0"></a>
	<input type="hidden" name="cliente" value="<%=cliente%>">
<%	
	try{	
		if (ArrayProducto[1] != null){
			for (int i=1; i<=cantNumProductos; i++){
%>	
	<input type="hidden" name="cantidad<%=i%>" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto<%=i%>" value="<%=ArrayProducto[i]%>">
	<input type="hidden" name="cUnidad<%=i%>" value="<%=ArrayCUnidad[i]%>">
	<input type="hidden" name="importe<%=i%>" value="<%=ArrayImporte[i]%>">
<%
			}
		if(cantNumProductos == 1){ cantNumProductos = 2;}			
		}
	}
	catch (IndexOutOfBoundsException ioobe){
		cantNumProductos = 1;
	}
%>		
<input type="hidden" name="cantidadR1" value="<%=tempcan1%>">	
<input type="hidden" name="cantidadR2" value="<%=tempcan2%>">	
<input type="hidden" name="cantidadR3" value="<%=tempcan3%>">	
<input type="hidden" name="productoR1" value="<%=tempprod1%>">	
<input type="hidden" name="productoR2" value="<%=tempprod2%>">	
<input type="hidden" name="productoR3" value="<%=tempprod3%>">	
<input type="hidden" name="documento" value="<%=documento%>">	
<input type="hidden" name="numFac" value="<%=numFac%>">	
	<input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	<input type="hidden" name="idProducto" value="<%=""%>">
	<input type="hidden" name="clienteC" value="<%=cliente%>">
	<input type="hidden" name="rg1" value="<%=""%>">
</form>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
