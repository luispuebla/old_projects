<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.ult.bd.ManagerCompras" scope="page" />
<jsp:useBean id="pro" class="com.ult.bd.ManagerProveedores" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Calculos de Compras</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
		document.form1.observaciones.focus();
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
	var de1 = new Number();
	de1 = f.descuento1.value;
	var de2 = new Number();
	de2 = f.descuento2.value;
	var de3 = new Number();
	de3 = f.descuento3.value;

	var iv = new Number();
	iv = SPrecio2 * 0.15;	
	var to = new Number();
	to = SPrecio3;
	
	var resul = new Number();

	resul = impdes - ((impdes * de1)/100);
	resul = resul - ((resul * de2)/100);
	resul = resul - ((resul * de3)/100);

	iv = iv - ((iv * de1)/100);
	iv = iv - ((iv * de2)/100);
	iv = iv - ((iv * de3)/100);
		
	to = resul + iv;

	if (isNaN(resul))
			resul = 0;
	if (isNaN(iv))
			iv = 0;
	if (isNaN(to))
			to = 0;
	
	resul = roundOff(resul);
	iv = roundOff(iv);
	to = roundOff(to);
	
	resul = formatCurrency(resul);
	iv = formatCurrency(iv);
	to = formatCurrency(to);
	//alert(resul);
document.form1.descuentos.value = resul;
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
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	String numProductos = "1";
	int cantNumProductos = 1;
	String proveedor = "";
	//String queryString = request.getQueryString();
	//queryString = queryString.substring(8);	
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	String[] ArrayRegalos = new String[2];
	

	//System.out.println("Entrega Original: "+entrega);
	proveedor = request.getParameter("proveedorQ");
	//System.out.println(proveedor);
	numProductos = request.getParameter("numProductos");
	cantNumProductos = alCom.cambiaAInt(numProductos);
	cantNumProductos -=1;
	ArrayCantidad   = new String[cantNumProductos+1]; // Aumento 1 para facilitar el manejo del arreglo.
	ArrayProducto   = new String[cantNumProductos+1];
	ArrayCUnidad   = new String[cantNumProductos+1];
	ArrayImporte   = new String[cantNumProductos+1];
	ArrayRegalos = new String[cantNumProductos+1];
	
	for (int i =1; i<=cantNumProductos; i++){
		ArrayCantidad[i] = request.getParameter("cantidad"+i);
		ArrayProducto[i] = request.getParameter("producto"+i);
		ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
		ArrayImporte[i] = request.getParameter("importe"+i);
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); funcionFoco(), setFecha(), des(form1)">
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedor%>"/>
<form name="form1" method="post" target="_self" action="Conf_Alta_Compra.jsp">
<% //System.out.println("Clave del Proveedor:  "+proveedor); 
String NomProv = alCom.dameNombreProveedor();
//System.out.println("Fecha Entrega Original: "+FechaEntrega);
double importes = 0.0;
double descuentos =0.0;
double ivas = 0.0;
double totales = 0.0;
double importesiva = 0.0;
double des1BD = 0.0;
double des2BD = 0.0;
double des3BD = 0.0;
String saldo = "";
ResultSet descuentosBD = pro.datos_Proveedor(proveedor);
while(descuentosBD.next()){
	des1BD = descuentosBD.getDouble("descuento1");
	des2BD = descuentosBD.getDouble("descuento2");
	des3BD = descuentosBD.getDouble("descuento3");
	saldo = descuentosBD.getString("saldoDisponible");
}
//System.out.println("Nombre del Proveedor:  "+NomProv);
%>
<table width="842" border="1">
	<tr>
		<th width="83">Proveedor</th>
		<td width="175"><%=NomProv%></td>
		<th width="88">Saldo Disponible</th>
		<td width="94">$ <%=pro.formatoDinero(saldo)%></td>
		<th width="153">Fecha Aproximada de Entrega</th>
            <td width="148">
<input type=text name="datebox" size=15 readonly="true">
 <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a>   
</td>
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
			if(alCom.tieneIva(ArrayProducto[i])){
				conIva = true;			
				importesiva = importesiva + ((alCom.cambiaADouble(alCom.remueveComas(ArrayImporte[i]))*100)/115);			
			}
			if(!conIva){
			String nomantes = ArrayProducto[i];
			String tipoTodo = "";
			//System.out.println(nomantes);
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("A"))
			tipoTodo = " --> Kg.";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("B"))
			tipoTodo = " --> Unidades";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("C"))
			tipoTodo = " --> Botella1";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("D"))
			tipoTodo = " --> Botella2";
			nomantes = nomantes.substring(0, nomantes.length()-1);
	//System.out.println(nomantes.substring(nomantes.length()-1));
%>
      <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%out.print(alCom.dameNombreProducto(nomantes)+tipoTodo);%></td>
		<td><div align="right">$ <%=ArrayCUnidad[i]%></div></td>
		<td><div align="right">$ <%=ArrayImporte[i]%></div></td>
      </tr>
<%	
				importes = importes + alCom.cambiaADouble(alCom.remueveComas(ArrayImporte[i]));
			}
			else{
			String nomantes = ArrayProducto[i];
			String tipoTodo = "";
			//System.out.println(nomantes);
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("A"))
			tipoTodo = " --> Kg.";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("B"))
			tipoTodo = " --> Unidades";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("C"))
			tipoTodo = " --> Botella1";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("D"))
			tipoTodo = " --> Botella2";
			nomantes = nomantes.substring(0, nomantes.length()-1);
	//System.out.println(nomantes.substring(nomantes.length()-1));
%>		
      <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%out.print(alCom.dameNombreProducto(nomantes)+tipoTodo);%></td>
		<td><div align="right">$ <%=alCom.formatoDinero(alCom.acortaLongitud(((alCom.cambiaADouble(alCom.remueveComas(ArrayCUnidad[i]))*100)/115)+""))%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(alCom.acortaLongitud(((alCom.cambiaADouble(alCom.remueveComas(ArrayImporte[i]))*100)/115)+""))%></div></td>
      </tr>			
<%			
				importes = importes + ((alCom.cambiaADouble(alCom.remueveComas(ArrayImporte[i]))*100)/115);
			}
				int compro = 0;
				int regalan = 0;
				int cant = 0;
				int comp = 0;

				}
			}
%>	  	  
  </table>
	<br />
<table width="728" border="1">
<tr>
	<th width="261">Observaciones</th>
	<th width="114">&nbsp;</th>
	<td width="64">&nbsp;</td>
	<th width="104">Subtotal</th>
	<td width="151"><div align="right">
	  $ 
	  <input name="subtotal" type="text" value="<%=alCom.formatoDinero(alCom.acortaLongitud(importes+""))%>" size="10" maxlength="10" readonly="true">
	  </div></td>
</tr>
<tr>
	<td rowspan="3"><textarea name="observaciones" cols="35" rows="5"></textarea></td>
	<th>Descuento 1</th>
	<td><div align="center">
        <input type="text" name="descuento1" size="3" maxlength="2" onFocus="seleccionaTodo(this)" onChange="des(this.form)" value="<%=des1BD%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ form1.descuento2.focus();}">
    %</div></td>
	<th height="34"><div align="center"><strong>Descuento</strong></div></td>
	<%descuentos = importes;%>
	<td height="34"><div align="right">
	  $ 
	  <input name="descuentos" type="text" value="<%=alCom.formatoDinero(alCom.acortaLongitud(descuentos+""))%>" size="10" maxlength="10" readonly="true">
	  </div></td>
</tr>
<tr>
  <th>Descuento 2</th>
  <td><div align="center">
      <input type="text" name="descuento2" size="3" maxlength="2" onFocus="seleccionaTodo(this)" onChange="des(this.form)" value="<%=des2BD%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ form1.descuento3.focus();}">
    %</div></td>
	<th height="35"><div align="center"><strong>I.V.A.</strong></div></th>
  <%
 // System.out.println("importesiva: "+importesiva);
  ivas = importesiva * 0.15;
   //System.out.println("ivas: "+ivas); 
  %>
  <input name="imporiva" type="hidden" value="<%=importesiva%>">
  <td height="35"><div align="right">
    $ 
    <input name="iva" type="text" value="<%=alCom.formatoDinero(alCom.acortaLongitud(ivas+""))%>" size="10" maxlength="10" readonly="true">
  </div></td>
</tr>
<tr>
  <th>Descuento 3</th>
  <td><div align="center">
      <input type="text" name="descuento3" size="3" maxlength="2" onFocus="seleccionaTodo(this)" onChange="des(this.form)" value="<%=des3BD%>" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ form1.descuento4.focus();}">
    %</div></td>
<th><div align="center"><strong>TOTAL</strong></div></th>
  <%totales = descuentos + ivas;%>
  <td><div align="right">
    $ 
    <input name="total" type="text" value="<%=alCom.formatoDinero(alCom.acortaLongitud(totales+""))%>" size="10" maxlength="10" readonly="true">
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

	<input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	<input type="hidden" name="proveedor" value="<%=proveedor%>">
	<input type="submit" name="Enviar" value="Enviar" >
</form>
<br />
<form method="post" target="_self" name="RegN" action="Alta_Prueba.jsp"> 
	<a onClick="MandaSubmit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('RegresoN','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="RegresoN" width="152" height="36" border="0"></a>
	<input type="hidden" name="proveedor" value="<%=proveedor%>">
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

	<input type="hidden" name="numProductos" value="<%=cantNumProductos%>">	
	<input type="hidden" name="idProducto" value="<%=""%>">
	<input type="hidden" name="proveedor" value="<%=proveedor%>">
	<input type="hidden" name="rg1" value="<%=""%>">
</form>
<%pro.cierraConexion();%>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
