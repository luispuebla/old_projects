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
 
function seleccionaTodo(objeto){
	objeto.select();
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

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	String provee = alCom.dameNombreProveedor();
%>
<table align="center" width="600" cellpadding="0" cellspacing="0" border="1">
<caption> Datos Generales de Compra: </caption>
  <tr>
    <th width="97">Proveedor:</th>
	<td width="629"><div align="center"><%= provee%></div></td>
  </tr>
</table>
<table width="760" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">&nbsp;
  </caption>
  <tr>
    <th width="70" height="29" scope="col">Clave</th>
    <th width="96" scope="col">Fecha</th>
	<th width="100" scope="col">Estado<br/>Recepci&oacute;n</th>	
	<th width="100" scope="col">Estado<br/>Pagos</th>	
	<th width="99" scope="col">Subtotal</th>
	<th width="90" scope="col">Descuentos</th>	
	<th width="90" scope="col">I.V.A.</th>
	<th width="97" scope="col">Total</th>	
  </tr>
  <% //System.out.println("9");
  ResultSet rs = alCom.datosOrdenCompra();
  while(rs.next()){
  	String edoPago = "Sin pagos";
	String edoRecepcion = "Sin Recepciones";
	if (rs.getInt("entrega") == 1){
		edoRecepcion = "Recibido Parcialmente";
	}
	else if(rs.getInt("entrega") == 2){
		edoRecepcion = "Totalmente Recibido";
	}
	if (rs.getInt("pago") == 1){
		edoPago = "Pagado Parcialmente";
	}
	else if(rs.getInt("pago") == 2){
		edoPago = "Totalmente Pagado";
	}	
		%>  
  <tr>
    <td><div align="center"><%= rs.getString("ClaveOrden")%></div></td>
    <td><div align="center"><%= rs.getString("FechaRegistro")%></div></td>
    <td><div align="center"><%= edoRecepcion%></div></td>
    <td><div align="center"><%= edoPago%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("subtotal"))%></div></td>
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
	ResultSet rsR = alCom.dameRecepcionesPrevias(clave);
	boolean primeraAsignacion = true;
	String claveRecepcion = "";
	
%>	  
</table>
<br/>
<table align="center" width="760" cellpadding="0" cellspacing="0" border="1">
	<caption>Recepciones Registradas</caption>
<%	while(rsR.next()){ 	
		if(rsR.getDouble("Cantidad") > 0.00){
			String documentoAval = rsR.getString("DocAval");
			String tipoProducto = "Pieza";
			if(rsR.getInt("Tipo") == 1){
				tipoProducto = "Caja";
			}
			else if(rsR.getInt("Tipo") == 2){
				tipoProducto = "Kg.";
			}
			String tipodoc = "Nota/Remisi&oacute;n";
			if(rsR.getInt("TipoDocAval") == 1){
				tipodoc = "Factura";
			}
			if(primeraAsignacion){
				primeraAsignacion = false;
				claveRecepcion = rsR.getString("ConsecutivoRecepcion");
%>
	<tr>
		<th width="95">Recepci&oacute;n: </th>
		<td width="80"><div align="center"><%=claveRecepcion%></div></td>
		<th width="110">Documento<br/>Aval: </th>
		<td width="70"><div align="center"><%=documentoAval%></div></td>
		<th width="115">Tipo<br/>Documento: </th>
		<td width="80"><div align="center"><%=tipodoc%></div></td>
		<th width="112">Fecha<br/>Documento:</th>
		<td width="80"><div align="center"><%=rsR.getString("FechaDocAval")%></div></td>
	</tr>
	<tr>
		<th colspan="2">Clave <br/>Producto</th>
		<th colspan="2">Producto</th>
		<th colspan="2">Tipo</th>				
		<th colspan="2">Cantidad<br/>Recibida</th>
	</tr>
			
<%			}
			else if(!(claveRecepcion.equalsIgnoreCase(rsR.getString("ConsecutivoRecepcion")))){
				claveRecepcion = rsR.getString("ConsecutivoRecepcion");		
%>
	<tr>
		<td colspan="8">&nbsp;</td>
	</tr>
	<tr>
		<th>Recepci&oacute;n: </th>
		<td><div align="center"><%=claveRecepcion%></div></td>
		<th>Documento<br/>Aval: </th>
		<td><div align="center"><%=documentoAval%></div></td>
		<th>Tipo<br/>Documento: </th>
		<td><div align="center"><%=tipodoc%></div></td>
		<th>Fecha<br/>Documento:</th>
		<td><div align="center"><%=rsR.getString("FechaDocAval")%></div></td>		
	</tr>		
	<tr>
		<th colspan="2">Clave <br/>Producto</th>
		<th colspan="2">Producto</th>
		<th colspan="2">Tipo</th>				
		<th colspan="2">Cantidad<br/>Recibida</th>
	</tr>	
<%			}  %>
	<tr>
		<td colspan="2"><div align="center"><%=rsR.getString("ClaveProducto")%></div></td>
		<td colspan="2"><div align="center"><%=rsR.getString("Descripcion")%></div></td>
		<td colspan="2"><div align="center"><%=tipoProducto%></div></td>
		<td colspan="2"><div align="right"><%=alCom.formatoDinero(rsR.getString("Cantidad"))%></div></td>	
	</tr>	
<% 		}
	}
	rsR.close();
	alCom.cierraConexion();	
%>
</table>
<p>
<a href="Menu_Recepciones.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
