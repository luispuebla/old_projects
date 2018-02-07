<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Confirma Eliminaci&oacute;n de Recepci&oacute;n</title>
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
			alert("Debes especificar un Documento Aval de esta transaccion");
			form1.aval.focus();
			return false;
		}
		else{
			document.form1.action ="Guarda_Alta_Compra.jsp";		
			return true;
		}
	}
	else{
		document.form1.action ="Guarda_Alta_Compra.jsp";		
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
%>	
	<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">	
<%	
	String proveedor = "";
	String clave = "";
	String[] ArrayConsecutivos = null;
	proveedor = request.getParameter("proveedor");
	clave = request.getParameter("clave");
	ArrayConsecutivos = (String[])request.getParameterValues("claveABorrar");
	if(ArrayConsecutivos != null){ 
		boolean eliminaRecepcion = alCom.eliminaRecepcion(proveedor, clave, ArrayConsecutivos);
		if(eliminaRecepcion){ %>
			<jsp:forward page="Menu_Recepciones.jsp" />
<%		}
		else{ %>
			<p><b class="roj">No se pudo eliminar la(s) recepci&oacute;n(es) pedidas. Vuelva a intentarlo.</b></p>
<%		}
	}
	else{ %>
		<p><b class="roj">Debes seleccionar alguna recepci&oacute;n para poder eliminarla</b></p>
<%	} %>

<p><a href="Menu_Compras.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
