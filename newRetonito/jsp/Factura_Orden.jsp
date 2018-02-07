<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Factura de una Compra</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
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
	document.form1.factura.focus();
}

function seleccionaTodo(objeto){
	objeto.select();
}

function cambiaFoco(){
	document.form1.factura.focus();
}

function OnSubmitForm(){
	var docAval = new String();
	docAval = form1.factura.value;
	re = / /gi;
	docAval = docAval.replace(re,"");
	if(docAval == ''){
		alert("Debes especificare un Documento Aval (Factura/Remisión) de esta transacción");
		form1.factura.focus();
		return false;
	}
	else{
		document.form1.action ="Conf_Factura_Orden.jsp";		
		return true;
	}
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

//System.out.println("2");
String clave = request.getParameter("claveOrden");
String proveedor = request.getParameter("proveedor");
//System.out.println("3");
%>
<jsp:setProperty name="alCom" property="claveOrden" value="<%=clave%>"/>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedor%>"/>

<body onLoad="funcionFoco();MM_preloadImages('imagenes/Regresar2.jpg')">
<form name="form1" method="post" onSubmit="return OnSubmitForm();" target="_self">
<%
	String[] ArrayCantidad = null;
	String[] ArrayProducto = null;
	String[] ArrayCUnidad = null;
	String[] ArrayImporte = null;
	String[] ArrayTipo = null;
	String[] ArrayLlegan = null;
	String[] ArrayCambio = null;
	String fechaHoy = alCom.dameFechaHoy();
	String prodRegalo1 = "";
	String prodRegalo2 = "";
	String prodRegalo3 = "";
	String tipoUniRegalo1 = "";
	String tipoUniRegalo2 = "";
	String tipoUniRegalo3 = "";
	BigDecimal cantidadRegalo1 = new BigDecimal("0.00");
	BigDecimal cantidadRegalo2 = new BigDecimal("0.00");
	BigDecimal cantidadRegalo3 = new BigDecimal("0.00");
	BigDecimal llegaCantRegalo1 = new BigDecimal("0.00");
	BigDecimal llegaCantRegalo2 = new BigDecimal("0.00");
	BigDecimal llegaCantRegalo3 = new BigDecimal("0.00");
	ResultSet rsProComprados = alCom.todosProductosOrden3();
	int numeroProductosComprados = 0;
	while (rsProComprados.next()){
		numeroProductosComprados ++;
	}
	rsProComprados.beforeFirst();
	ArrayCantidad = new String[numeroProductosComprados];
	ArrayProducto = new String[numeroProductosComprados];
	ArrayTipo = new String[numeroProductosComprados];
	ArrayCUnidad = new String[numeroProductosComprados];
	ArrayImporte = new String[numeroProductosComprados];
	ArrayLlegan = new String[numeroProductosComprados];
	ArrayCambio = new String[numeroProductosComprados];	
	int contI = 0;
	while (rsProComprados.next()){
		ArrayCambio[contI] = rsProComprados.getString("CambiaPrecio");
		ArrayCantidad[contI] = rsProComprados.getString("Cantidad");
		ArrayLlegan[contI] = rsProComprados.getString("Llegan");
		ArrayProducto[contI] = rsProComprados.getString("ClaveProducto");
		ArrayTipo[contI] = rsProComprados.getInt("Tipo")+"";
		if(alCom.tieneIva(rsProComprados.getString("ClaveProducto"))){
			ArrayCUnidad[contI] = alCom.formatoCortoDinero(alCom.regresaIVA(rsProComprados.getString("Costo"))+"");
			ArrayImporte[contI] = alCom.formatoCortoDinero(alCom.regresaIVA(rsProComprados.getString("Importe"))+"");
		}
		else{
			ArrayCUnidad[contI] = rsProComprados.getString("Costo");
			ArrayImporte[contI] = rsProComprados.getString("Importe");				
		}
		contI++;
	}
	rsProComprados.close();
	alCom.cierraConexion();	
	ResultSet rsProObsequiados = alCom.datosRegalosOrdenCompra();
	int contIO = 1;
	while (rsProObsequiados.next()){
		if(contIO == 1){
			prodRegalo1 = rsProObsequiados.getString("ClaveProducto");
			tipoUniRegalo1 = rsProObsequiados.getString("Tipo");
			cantidadRegalo1 = new BigDecimal(rsProObsequiados.getString("Cantidad"));
			llegaCantRegalo1 = new BigDecimal(rsProObsequiados.getString("Llegan"));			
		}
		else if(contIO == 2){
			prodRegalo2 = rsProObsequiados.getString("ClaveProducto");
			tipoUniRegalo2 = rsProObsequiados.getString("Tipo");
			cantidadRegalo2 = new BigDecimal(rsProObsequiados.getString("Cantidad"));
			llegaCantRegalo2 = new BigDecimal(rsProObsequiados.getString("Llegan"));			
		}
		else{
			prodRegalo3 = rsProObsequiados.getString("ClaveProducto");
			tipoUniRegalo3 = rsProObsequiados.getString("Tipo");
			cantidadRegalo3 = new BigDecimal(rsProObsequiados.getString("Cantidad"));
			llegaCantRegalo3 = new BigDecimal(rsProObsequiados.getString("Llegan"));			
		}
		contIO ++;
	}
	rsProObsequiados.close();
	alCom.cierraConexion();	
	String provee = alCom.dameNombreProveedor();
%>
<table align="center" width="600" cellpadding="0" cellspacing="0" border="1">
<caption> Datos Compra </caption>
  <tr>
    <th width="97">Proveedor:</th>
	<td width="629"><div align="center"><%= provee%></div></td>
  </tr>
 </table>
<%//System.out.println("8");%>
<table width="760" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">&nbsp;
  </caption>
  <tr>
    <th width="81" height="29" scope="col">Clave</th>
    <th width="92" scope="col">Fecha</th>
    <th width="230" scope="col">Observaciones</th>
	<th width="81" scope="col">Subtotal</th>
	<th width="90" scope="col">Descuento</th>
	<th width="71" scope="col">I.V.A.</th>
	<th width="99" scope="col">Total</th>
  </tr>
  <% //System.out.println("9");
  ResultSet rs = alCom.datosOrdenCompra();
  while(rs.next()){
  		//System.out.println("10");
		%>
  <input type="hidden" name="claveOrden" value="<%= rs.getString("ClaveOrden")%>">
  <input type="hidden" name="cProveedor" value="<%= proveedor%>">
  
  <tr>
    <td><div align="center"><%= rs.getString("ClaveOrden")%></div></td>
    <td><div align="center"><%= rs.getString("FechaRegistro")%></div></td>
    <td><%= rs.getString("Observaciones")%>&nbsp;</td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Subtotal"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("realDescuento"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Iva"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Total"))%></div></td>
  </tr>
<%
	}
	if(rs != null){
		rs.close();
	}
	alCom.cierraConexion();			
%>	  
</table>
<p></p>
<table width="600" border="1">
  <tr>
	<th colspan="2">Tipo de Documento Aval:</th>
	<th width="254" rowspan="2">Fecha de Recepci&oacute;n:</th>
  </tr>		
  <tr>
	<td width="146"><div align="center"> <input type="radio" name="tipoDoc" value="1" checked onClick="cambiaFoco();"> Factura</div></td>
	<td width="178"><div align="center"><input type="radio" name="tipoDoc" value="2" onClick="cambiaFoco();">Nota</div></td>
  </tr>		
  <tr>
    <th>Documento Aval:</th>
	<td><div align="center"> <input type="text" name="factura" size="12" maxlength="11"> </div></td>
	<td> <div align="center"><input type=text name="datebox" size=15 readonly="true" value="<%=fechaHoy%>"> <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a> </div></td>
  </tr>
 </table>
 <p></p>
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>Productos Comprados</caption>
	  <tr>
	  	<th width="132"><div align="center">Cantidad</div></th>
	  	<th width="132"><div align="center">Tipo</div></th>
		<th width="422">Producto</th>
	  </tr>
<%
	for (int i =0; i<ArrayProducto.length; i++){
		if(!(ArrayProducto[i].equalsIgnoreCase(""))){
			BigDecimal totalpro = new BigDecimal(ArrayCantidad[i]);
			BigDecimal llegaron = new BigDecimal(ArrayLlegan[i]);
			BigDecimal tt = totalpro.subtract(llegaron);
			tt = tt.setScale(3, RoundingMode.HALF_UP);		
			if(alCom.cambiaADouble(tt.toString()) > 0){						
				String tipoP = "Pieza";
				String muestra = alCom.dameEnteros(tt.toString());
				if(alCom.cambiaAInt(ArrayTipo[i]) == 1){
					tipoP = "Caja";
				}
				else if (alCom.cambiaAInt(ArrayTipo[i]) == 2){
					tipoP = "Kilo";
					muestra = tt.toString();				
				}			
%>
      <tr>
		<td><div align="center"> <input name="cantidad" size="7" maxlength="6" value="<%=muestra%>" onFocus="seleccionaTodo(this)" onKeypress="
	<% if(ArrayTipo[i].equals("2")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" > </div></td>
		<td><input name="tipo" type="hidden" value="<%=ArrayTipo[i]%>"> <input name="cambio" type="hidden" value="<%=ArrayCambio[i]%>"><%=tipoP%></td> 		
		<td><input name="producto" type="hidden" size="7" maxlength="6" value="<%=ArrayProducto[i]%>"><%=alCom.dameDescripcionProducto(ArrayProducto[i])%></td> 
	  </tr>
<%			}
		}
	}
%>	  	  
  </table> 
<p></p>
  <table width="600" border="1">
  <caption>   OBSEQUIOS EXTRAS   </caption>
	  <tr>
		  <th width="132">Cantidad</th>
		  <th>Tipo</th>
		  <th width="419">Producto</th>
	  </tr>
<%
	if (!prodRegalo1.equals("")){
		BigDecimal faltante = cantidadRegalo1.subtract(llegaCantRegalo1);
		faltante = faltante.setScale(3, RoundingMode.HALF_UP);		
		if(alCom.cambiaADouble(faltante.toString()) > 0){						
			String tipoP = "Pieza";
			String muestra = alCom.dameEnteros(faltante.toString());
			if(alCom.cambiaAInt(tipoUniRegalo1) == 1){
				tipoP = "Caja";
			}
			else if (alCom.cambiaAInt(tipoUniRegalo1) == 2){
				tipoP = "Kilo";
				muestra = faltante.toString();
			}	
%>
	  <tr>
		<td><div align="center"><input name="cantidadRegalo1" onFocus="seleccionaTodo(this)" size="7" maxlength="6" value="<%=muestra%>" onKeypress="
		<% if(tipoUniRegalo1.equals("2")){ %>
		   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
		<% } else { %>	   
		   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
		<% } %>" > </div></td>
		<td><div align="center"><input type="hidden" name="tipoUniRegalo1" value="<%=tipoUniRegalo1%>"><%=tipoP%></div></td>
      	<td><div align="center"> <input name="prodRegalo1" type="hidden" size="7" maxlength="6" value="<%=prodRegalo1%>"><%=alCom.dameDescripcionProducto(prodRegalo1)%>       </div></td>
	  </tr>
<% }} if(!prodRegalo2.equals("")){ 
		BigDecimal faltante = cantidadRegalo2.subtract(llegaCantRegalo2); 
		faltante = faltante.setScale(3, RoundingMode.HALF_UP);		
		if(alCom.cambiaADouble(faltante.toString()) > 0){								
			String tipoP = "Pieza";
			String muestra = alCom.dameEnteros(faltante.toString());
			if(alCom.cambiaAInt(tipoUniRegalo2) == 1){
				tipoP = "Caja";
			}
			else if (alCom.cambiaAInt(tipoUniRegalo2) == 2){
				tipoP = "Kilo";
				muestra = faltante.toString();
			}	
%>
	  <tr>
		<td><div align="center"><input name="cantidadRegalo2" onFocus="seleccionaTodo(this)" size="7" maxlength="6" value="<%=muestra%>" onKeypress="
		<% if(tipoUniRegalo2.equals("2")){ %>
		   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
		<% } else { %>	   
		   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
		<% } %>" > </div></td>
		<td><div align="center"><input type="hidden" name="tipoUniRegalo2" value="<%=tipoUniRegalo2%>"><%=tipoP%></div></td>
      	<td><div align="center"> <input name="prodRegalo2" type="hidden" size="7" maxlength="6" value="<%=prodRegalo2%>"><%=alCom.dameDescripcionProducto(prodRegalo2)%>       </div></td>
	  </tr>
<% }} if(!prodRegalo3.equals("")){
		BigDecimal faltante = cantidadRegalo3.subtract(llegaCantRegalo3); 
		faltante = faltante.setScale(3, RoundingMode.HALF_UP);		
		if(alCom.cambiaADouble(faltante.toString()) > 0){								
			String tipoP = "Pieza";
			String muestra = alCom.dameEnteros(faltante.toString());
			if(alCom.cambiaAInt(tipoUniRegalo3) == 1){
				tipoP = "Caja";
			}
			else if (alCom.cambiaAInt(tipoUniRegalo3) == 2){
				tipoP = "Kilo";
				muestra = faltante.toString();
			}	
%>
	  <tr>
		<td><div align="center"><input name="cantidadRegalo3" onFocus="seleccionaTodo(this)" size="7" maxlength="6" value="<%=muestra%>" onKeypress="
		<% if(tipoUniRegalo3.equals("2")){ %>
		   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
		<% } else { %>	   
		   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
		<% } %>" > </div></td>
		<td><div align="center"><input type="hidden" name="tipoUniRegalo3" value="<%=tipoUniRegalo3%>"><%=tipoP%></div></td>
      	<td><div align="center"> <input name="prodRegalo3" type="hidden" size="7" maxlength="6" value="<%=prodRegalo3%>"><%=alCom.dameDescripcionProducto(prodRegalo3)%>       </div></td>
	  </tr>

<% }} %>

  </table>
<p>
  <input type="reset" name="Submit2" value="Volver Originales">
  <input type="submit" name="Submit" VALUE="Guardar">
</p>
</form>
<p>
<a href="Escoge_Proveedor_Orden_Factura.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
