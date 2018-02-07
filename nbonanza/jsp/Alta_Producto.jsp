<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="proveedor" class="com.alpha.bd.ManagerProveedores" />

<html>
<head>
<title>Alta de Producto</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
javascript:window.history.forward(1);

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

function Copiador(f){
	var tipoPrecio = f.tipoPrecio.value;
	if(tipoPrecio == 2){
		f.precioE1.value = f.precioMenu.value;
		f.pieza2.focus();
	}
	if(f.manejo.value == 1){
		var numPiezas = new Number();
		var precioActual = new Number();
		numPiezas = f.piezasc.value;
		precioActual = f.precioMenu.value;
		if (isNaN(numPiezas)){
			numPiezas = 0;
		}
		if(isNaN(precioActual)){
			precioActual = 0;
		}
		if(numPiezas > 0){
			f.precioMenuC.value = formatCurrency(roundOff(numPiezas*precioActual));			
		}
	}
}

function AjustaTipo(f){
	var tipoProducto = f.tipo.value;
	if(tipoProducto == 0){
		f.uniCompra.value = 1;		
	}
	else if(tipoProducto == 1){
		f.uniCompra.value = 2;
		if(f.manejo.value == 1){
			f.manejo.value=0;
		}
	}
	Habilitador(f);
	Habilitador2(f);
}

function CalculaCaja(f, objeto){
	if(f.manejo.value == 1){
		var numPiezas = new Number();
		var precioActual = new Number();
		numPiezas = f.piezasc.value;
		precioActual = objeto.value;
		if (isNaN(numPiezas)){
			numPiezas = 0;
		}
		if(isNaN(precioActual)){
			precioActual = 0;
		}
		if(objeto.name == "precioMM"  && numPiezas > 0){
			f.precioMMC.value = formatCurrency(roundOff(numPiezas*precioActual));			
		}
		else if(objeto.name == "precioM"  && numPiezas > 0){
			f.precioMC.value = formatCurrency(roundOff(numPiezas*precioActual));		
		}
	}
	else if(f.manejo.value == 2){
		var kilosXUnidad = new Number();
		var precioActual = new Number();
		kilosXUnidad = f.kgXUni.value;
		precioActual = objeto.value;
		if (isNaN(kilosXUnidad)){
			kilosXUnidad = 0;
		}
		if(isNaN(precioActual)){
			precioActual = 0;
		}
		if(objeto.name == "precioMM"  && kilosXUnidad > 0){
			f.precioMMC.value = formatCurrency(roundOff(kilosXUnidad*precioActual));			
		}
		else if(objeto.name == "precioM"  && kilosXUnidad > 0){
			f.precioMC.value = formatCurrency(roundOff(kilosXUnidad*precioActual));		
		}
	}
	objeto.value = formatCurrency(roundOff(objeto.value));
}

function verificaRepeticion(f, objeto){
	var valorProv1 = f.proveedor1.value;
	var valorProv2 = f.proveedor2.value;
	var valorProv3 = f.proveedor3.value;
	var valorProv4 = f.proveedor4.value;
	var valorProv5 = f.proveedor5.value;
	if(valorProv1!="" && objeto.name=="proveedor1"){
		if(valorProv1 == valorProv2){
			f.proveedor1.value = "";
			valorProv1.value = "";
		}
		if(valorProv1 == valorProv3){
			f.proveedor1.value = "";		
			valorProv1.value = "";
		}
		if(valorProv1 == valorProv4){
			f.proveedor1.value = "";		
			valorProv1.value = "";
		}
		if(valorProv1 == valorProv5){
			f.proveedor1.value = "";		
			valorProv1.value = "";
		}
	}
	if(valorProv2!=""  && objeto.name=="proveedor2"){
		if(valorProv2 == valorProv1){
			f.proveedor2.value = "";
			valorProv2.value = "";
		}
		if(valorProv2 == valorProv3){
			f.proveedor2.value = "";		
			valorProv2.value = "";
		}
		if(valorProv2 == valorProv4){
			f.proveedor2.value = "";		
			valorProv2.value = "";
		}
		if(valorProv2 == valorProv5){
			f.proveedor2.value = "";		
			valorProv2.value = "";
		}		
	}
	if(valorProv3!=""  && objeto.name=="proveedor3"){
		if(valorProv3 == valorProv1){
			f.proveedor3.value = "";
			valorProv3.value = "";
		}
		if(valorProv3 == valorProv2){
			f.proveedor3.value = "";		
			valorProv3.value = "";
		}
		if(valorProv3 == valorProv4){
			f.proveedor3.value = "";		
			valorProv3.value = "";
		}
		if(valorProv3 == valorProv5){
			f.proveedor3.value = "";		
			valorProv3.value = "";
		}		
	}	
	if(valorProv4!=""  && objeto.name=="proveedor4"){
		if(valorProv4 == valorProv1){
			f.proveedor4.value = "";
			valorProv4.value = "";
		}
		if(valorProv4 == valorProv2){
			f.proveedor4.value = "";		
			valorProv4.value = "";
		}
		if(valorProv4 == valorProv3){
			f.proveedor4.value = "";		
			valorProv4.value = "";
		}
		if(valorProv4 == valorProv5){
			f.proveedor4.value = "";		
			valorProv4.value = "";
		}		
	}	
	if(valorProv5!=""  && objeto.name=="proveedor5"){
		if(valorProv5 == valorProv1){
			f.proveedor5.value = "";
			valorProv5.value = "";
		}
		if(valorProv5 == valorProv2){
			f.proveedor5.value = "";		
			valorProv5.value = "";
		}
		if(valorProv5 == valorProv3){
			f.proveedor5.value = "";		
			valorProv5.value = "";
		}
		if(valorProv5 == valorProv4){
			f.proveedor5.value = "";		
			valorProv5.value = "";
		}		
	}	
}

function Habilitador2(f){
	var unidadCompra = f.uniCompra.value;
	var tipoProducto = f.tipo.value;
	if(unidadCompra == 2 && tipoProducto == 0){
		if(f.manejo.value == 1){
			alert("Se modificaron: Tipo de Producto y Manejo de Precio -- 1");
			f.tipo.value=1;
			f.manejo.value = 0;
			AjustaTipo(f);
		}
		else{
			alert("Se modifico el Tipo de Producto -- 2");
			f.tipo.value=1;
			AjustaTipo(f);
		}
	}
	else if(unidadCompra == 1 && tipoProducto == 1){
		alert("Se modifico el Tipo de Producto -- 3");
		f.tipo.value=0;
		AjustaTipo(f);
	}	
	if(unidadCompra == 1){
		f.preUniCompra.disabled = false;
		f.preCaCompra.disabled = false;
		f.piezasc.disabled = false;
		f.preKgCompra.disabled = true;
		f.kgXUni.disabled=true;
		f.preKgCompra.value="";
		f.kgXUni.value="";		
	}
	else{
		f.preUniCompra.disabled = true;
		f.preCaCompra.disabled = true;
		f.piezasc.disabled = true;
		f.preKgCompra.disabled = false;
		f.kgXUni.disabled = false;	
		f.preUniCompra.value="";		
		f.preCaCompra.value="";		
		f.piezasc.value="";				
	}
}

function Habilitador (f){
	var unidadCompra = f.uniCompra.value;
	var tipoProducto = f.tipo.value;
	var tipoPrecio = f.tipoPrecio.value;
	var manejo = f.manejo.value;
	if(tipoPrecio == 2){
		f.manejo.value=0;
		f.manejo.disabled = true;
	}
	else {
		f.manejo.disabled = false;
	}
	if(manejo == 1 && tipoProducto == 1){
		if(unidadCompra == 2){
			alert("Se modificaron: Tipo de Producto y Formato de Compra");
			f.tipo.value=0;
			f.uniCompra.value = 1;
			AjustaTipo(f);		
		}
		else{
			alert("Se modifico el Tipo de Producto -- 5");
			f.tipo.value=0;
			AjustaTipo(f);		
		}	
	}	
	else if(manejo == 2 && tipoProducto == 0){
		if(unidadCompra == 1){
			alert("Se modificaron: Tipo de Producto y Formato de Compra");
			f.tipo.value=1;
			f.uniCompra.value = 2;
			AjustaTipo(f);		
		}	
	}
	if(tipoPrecio == 0 && manejo ==0){
		f.precioMenuC.disabled = true;
		f.precioMM.disabled=true;
		f.precioM.disabled=true;
		f.precioMMC.disabled=true;
		f.precioMC.disabled=true;
		f.pieza2.disabled=true;				
		f.pieza3.disabled=true;				
		f.pieza4.disabled=true;				
		f.pieza5.disabled=true;
		f.precioE1.disabled=true;
		f.precioE2.disabled=true;				
		f.precioE3.disabled=true;
		f.precioE4.disabled=true;
		f.precioE5.disabled=true;
		f.precioMenuC.value="0.00";
		f.precioMM.value="0.00";
		f.precioM.value="0.00";
		f.precioMMC.value="0.00";
		f.precioMC.value="0.00";
		f.pieza2.value="";				
		f.pieza3.value="";				
		f.pieza4.value="";				
		f.pieza5.value="";
		f.precioE1.value="0.00";
		f.precioE2.value="0.00";				
		f.precioE3.value="0.00";
		f.precioE4.value="0.00";
		f.precioE5.value="0.00";		
	}
	else if(tipoPrecio == 0 && manejo ==1){
		f.precioMenuC.disabled = false;
		f.precioMM.disabled=true;
		f.precioM.disabled=true;
		f.precioMMC.disabled=true;
		f.precioMC.disabled=true;
		f.pieza2.disabled=true;				
		f.pieza3.disabled=true;				
		f.pieza4.disabled=true;				
		f.pieza5.disabled=true;
		f.precioE1.disabled=true;
		f.precioE2.disabled=true;				
		f.precioE3.disabled=true;
		f.precioE4.disabled=true;
		f.precioE5.disabled=true;
		f.precioMM.value="0.00";
		f.precioM.value="0.00";
		f.precioMMC.value="0.00";
		f.precioMC.value="0.00";
		f.pieza2.value="";				
		f.pieza3.value="";				
		f.pieza4.value="";				
		f.pieza5.value="";
		f.precioE1.value="0.00";
		f.precioE2.value="0.00";				
		f.precioE3.value="0.00";
		f.precioE4.value="0.00";
		f.precioE5.value="0.00";
	}	
// NUEVO POR PIEZA
	else if(tipoPrecio == 0 && manejo == 2){
		f.precioMenuC.disabled = false;
		f.precioMM.disabled=true;
		f.precioM.disabled=true;
		f.precioMMC.disabled=true;
		f.precioMC.disabled=true;
		f.pieza2.disabled=true;				
		f.pieza3.disabled=true;				
		f.pieza4.disabled=true;				
		f.pieza5.disabled=true;
		f.precioE1.disabled=true;
		f.precioE2.disabled=true;				
		f.precioE3.disabled=true;
		f.precioE4.disabled=true;
		f.precioE5.disabled=true;
		f.precioMM.value="0.00";
		f.precioM.value="0.00";
		f.precioMMC.value="0.00";
		f.precioMC.value="0.00";
		f.pieza2.value="";				
		f.pieza3.value="";				
		f.pieza4.value="";				
		f.pieza5.value="";
		f.precioE1.value="0.00";
		f.precioE2.value="0.00";				
		f.precioE3.value="0.00";
		f.precioE4.value="0.00";
		f.precioE5.value="0.00";
	}	


	else if (tipoPrecio == 1 && manejo == 0){
		f.precioMenuC.disabled = true;	
		f.precioMM.disabled=false;
		f.precioM.disabled=false;
		f.precioMMC.disabled=true;
		f.precioMC.disabled=true;
		f.pieza2.disabled=true;				
		f.pieza3.disabled=true;				
		f.pieza4.disabled=true;				
		f.pieza5.disabled=true;
		f.precioE1.disabled=true;
		f.precioE2.disabled=true;				
		f.precioE3.disabled=true;
		f.precioE4.disabled=true;
		f.precioE5.disabled=true;
		f.precioMenuC.value="0.00";
		f.pieza2.value="";	
		f.pieza3.value="";				
		f.pieza4.value="";				
		f.pieza5.value="";
		f.precioE1.value="0.00";
		f.precioE2.value="0.00";
		f.precioE3.value="0.00";
		f.precioE4.value="0.00";
		f.precioE5.value="0.00";
		f.precioMMC.value="0.00";
		f.precioMC.value="0.00";
	}
	else if (tipoPrecio == 1 && manejo == 1){
		f.precioMenuC.disabled = false;	
		f.precioMM.disabled=false;
		f.precioM.disabled=false;
		f.precioMMC.disabled=false;
		f.precioMC.disabled=false;
		f.pieza2.disabled=true;				
		f.pieza3.disabled=true;				
		f.pieza4.disabled=true;				
		f.pieza5.disabled=true;
		f.precioE1.disabled=true;
		f.precioE2.disabled=true;				
		f.precioE3.disabled=true;
		f.precioE4.disabled=true;
		f.precioE5.disabled=true;
		f.pieza2.value="";				
		f.pieza3.value="";				
		f.pieza4.value="";				
		f.pieza5.value="";
		f.precioE1.value="0.00";
		f.precioE2.value="0.00";		
		f.precioE3.value="0.00";
		f.precioE4.value="0.00";
		f.precioE5.value="0.00";
	}
	
	else if (tipoPrecio == 1 && manejo == 2){
		f.precioMenuC.disabled = false;	
		f.precioMM.disabled=false;
		f.precioM.disabled=false;
		f.precioMMC.disabled=false;
		f.precioMC.disabled=false;
		f.pieza2.disabled=true;				
		f.pieza3.disabled=true;				
		f.pieza4.disabled=true;				
		f.pieza5.disabled=true;
		f.precioE1.disabled=true;
		f.precioE2.disabled=true;				
		f.precioE3.disabled=true;
		f.precioE4.disabled=true;
		f.precioE5.disabled=true;
		f.pieza2.value="";				
		f.pieza3.value="";				
		f.pieza4.value="";				
		f.pieza5.value="";
		f.precioE1.value="0.00";
		f.precioE2.value="0.00";		
		f.precioE3.value="0.00";
		f.precioE4.value="0.00";
		f.precioE5.value="0.00";
	}										
	else if(tipoPrecio == 2){	
		f.manejo.value=0;
		f.precioE1.value = f.precioMenu.value;		
		f.pieza2.disabled=false;				
		f.pieza3.disabled=false;				
		f.pieza4.disabled=false;				
		f.pieza5.disabled=false;
		f.precioE1.disabled=false;
		f.precioE2.disabled=false;				
		f.precioE3.disabled=false;
		f.precioE4.disabled=false;
		f.precioE5.disabled=false;
		f.precioMenuC.disabled=true;	
		f.precioMM.disabled=true;
		f.precioM.disabled=true;
		f.precioMMC.disabled=true;
		f.precioMC.disabled=true;
		f.precioMenuC.value="0.00";
		f.precioMM.value="0.00";
		f.precioM.value="0.00";
		f.precioMMC.value="0.00";
		f.precioMC.value="0.00";
	}
}


function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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
	document.form1.descripcion.focus();
}
//-->
</script>
</head>
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
	String iva = "";
	String mp = "";
	String cortes = "";
	String genero = "1";
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
	String uniCompra = "1";
	String preUniCompra = "0.00";
	String preCaCompra = "0.00";
	String piezasc = "";	
	String preKgCompra = "0.00";
	String kgXUni = "";
	String tipoPrecio = "0";
	String manejo = "0";
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
	if(request.getParameter("interino") != null){
		descripcion = request.getParameter("descripcion");
		tipo = request.getParameter("tipo");
		iva = request.getParameter("iva");
		mp = request.getParameter("mp");
		cortes = request.getParameter("cortes");
		genero = request.getParameter("genero");
		codBarras1 = request.getParameter("codBarras1");
		codBarras2 = request.getParameter("codBarras2");
		codBarras3 = request.getParameter("codBarras3");
		codBarras4 = request.getParameter("codBarras4");
		codBarras5 = request.getParameter("codBarras5");
		codBarras6 = request.getParameter("codBarras6");
		codBarras7 = request.getParameter("codBarras7");
		codBarras8 = request.getParameter("codBarras8");
		codBarras9 = request.getParameter("codBarras9");
		codBarras10 = request.getParameter("codBarras10");
		codBarras11 = request.getParameter("codBarras11");
		codBarras12 = request.getParameter("codBarras12");
		proveedor1 = request.getParameter("proveedor1");
		proveedor2 = request.getParameter("proveedor2");
		proveedor3 = request.getParameter("proveedor3");
		proveedor4 = request.getParameter("proveedor4");
		proveedor5 = request.getParameter("proveedor5");
		uniCompra = request.getParameter("uniCompra");
		if(uniCompra.equals("1")){
			preUniCompra = request.getParameter("preUniCompra");
			preCaCompra = request.getParameter("preCaCompra");
			piezasc = request.getParameter("piezasc");
		}
		else{ 
			preKgCompra = request.getParameter("preKgCompra");
			kgXUni = request.getParameter("kgXUni");
		}		
		tipoPrecio = request.getParameter("tipoPrecio");
		manejo = request.getParameter("manejo");
		precioMenu = request.getParameter("precioMenu");
		if(manejo.equals("1") || manejo.equals("2")){
			precioMenuC = request.getParameter("precioMenuC");
		}
		// Grupo de Precios y Solo Piezas
		if(tipoPrecio.equalsIgnoreCase("1") && manejo.equalsIgnoreCase("0")){
			precioMM = request.getParameter("precioMM");
			precioM = request.getParameter("precioM");
		}
			// Grupo de Precios y Piezas y Cajas.
		else if(tipoPrecio.equalsIgnoreCase("1") && (manejo.equalsIgnoreCase("1") ||  manejo.equalsIgnoreCase("2"))){
			precioMM = request.getParameter("precioMM");
			precioM = request.getParameter("precioM");
			precioMMC = request.getParameter("precioMMC");
			precioMC = request.getParameter("precioMC");
		}
		// Precios Escalonados
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
		}		
		maxInv = request.getParameter("maxInv");
		minInv = request.getParameter("minInv");
		invTienda = request.getParameter("invTienda");
		invAlmacen = request.getParameter("invAlmacen");
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco(), Habilitador(document.form1), Habilitador2(document.form1)">
<form name="form1" method="post" action="Conf_Alta_Producto.jsp">
  <table width="750" border="0" cellpadding="0" cellspacing="0">
  <caption><h1>ALTA DE PRODUCTO</h1></caption>
  	<tr>
		<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0">
		  <caption><b class="aviso">Datos Genéricos</b></caption>
		  	<tr>
			  <th colspan="2">Nombre Producto:</th>
			  <td colspan="2"><div align="center">
			    <input type="text" name="descripcion" value="<%=descripcion%>" maxlength="35" size="40">
			    </div></td>				
			  <th>Tipo de Producto:</th>
			  <td>
	  	        <div align="center">
	  	          <select name="tipo" onChange="AjustaTipo(this.form)">
   	        	      <option value="0" <%if(tipo.equalsIgnoreCase("0") || tipo.equals("")){%> selected<%}%>>Por Unidad</option>
       	    	      <option value="1" <%if(tipo.equalsIgnoreCase("1")){%> selected <%}%>>Por Pesaje</option>
			      </select>
		        </div></td>
			</tr>			
		  	<tr>
			  <th colspan="2">Grava I.V.A.:</th>
			  <td><div align="center"> <input type="checkbox" name="iva" <%if(iva.equalsIgnoreCase("1")){%> checked<%}%> value="1" > </div></td>
			  <th colspan="2">Genero de Producto:</th>
			  <td>
	  	        <div align="center">
	  	          <select name="genero">
   	        	      <option value="1" <%if(genero.equalsIgnoreCase("1") || genero.equals("")){%> selected<%}%>>Cremer&iacute;a</option>
       	    	      <option value="2" <%if(genero.equalsIgnoreCase("2")){%> selected <%}%>>Refresco</option>
       	    	      <option value="3" <%if(genero.equalsIgnoreCase("3")){%> selected <%}%>>Abarrotes</option>
			      </select>
			      </div></td>
			<tr>
		  	<tr>
			  <th colspan="2">Producto Materia Prima:</th>
			  <td><div align="center"> <input type="checkbox" name="mp" <%if(mp.equalsIgnoreCase("1")){%> checked<%}%> value="1" > </div></td>
			  <th colspan="2">Producto Gama Cort&eacute;s</th>
			  <td><div align="center"> <input type="checkbox" name="cortes" <%if(cortes.equalsIgnoreCase("1")){%> checked<%}%> value="1" > </div></td>			<tr>
		      <th colspan="6" bgcolor="#CCCCCC"> -- S&aacute;bana de C&oacute;digos de Barras -- </th>			  
			</tr>	
			<tr>
			  <th>Código #1:</th>
			  <td><div align="center"> <input name="codBarras1" type="text" id="codBarras1" size="13" maxlength="13" value="<%=codBarras1%>"> </div></td>
			  <th>Código #2:</th>
			  <td><div align="center"> <input name="codBarras2" type="text" id="codBarras2" size="13" maxlength="13" value="<%=codBarras2%>"> </div></td>
			  <th>Código #3:</th>
			  <td><div align="center"> <input name="codBarras3" type="text" id="codBarras3" size="13" maxlength="13" value="<%=codBarras3%>"> </div></td>
			</tr>
			<tr>
			  <th>Código #4:</th>
			  <td><div align="center"> <input name="codBarras4" type="text" id="codBarras4" size="13" maxlength="13" value="<%=codBarras4%>"> </div></td>
			  <th>Código #5:</th>
			  <td><div align="center"> <input name="codBarras5" type="text" id="codBarras5" size="13" maxlength="13" value="<%=codBarras5%>"> </div></td>
			  <th>Código #6:</th>
			  <td><div align="center"> <input name="codBarras6" type="text" id="codBarras6" size="13" maxlength="13" value="<%=codBarras6%>"> </div></td>
			</tr>
			<tr>
			  <th>Código #7:</th>
			  <td><div align="center"> <input name="codBarras7" type="text" id="codBarras7" size="13" maxlength="13" value="<%=codBarras7%>"> </div></td>
			  <th>Código #8:</th>
			  <td><div align="center"> <input name="codBarras8" type="text" id="codBarras8" size="13" maxlength="13" value="<%=codBarras8%>"> </div></td>
			  <th>Código #9:</th>
			  <td><div align="center"> <input name="codBarras9" type="text" id="codBarras9" size="13" maxlength="13" value="<%=codBarras9%>"> </div></td>
			</tr>
			<tr>
			  <th>Código #10:</th>
			  <td><div align="center"> <input name="codBarras10" type="text" id="codBarras10" size="13" maxlength="13" value="<%=codBarras10%>"> </div></td>
			  <th>Código #11:</th>
			  <td><div align="center"> <input name="codBarras11" type="text" id="codBarras11" size="13" maxlength="13" value="<%=codBarras11%>"> </div></td>
			  <th>Código #12:</th>
			  <td><div align="center"> <input name="codBarras12" type="text" id="codBarras12" size="13" maxlength="13" value="<%=codBarras12%>"> </div></td>
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
			  <td colspan="3"><div align="center">
<%
			ResultSet rs = proveedor.dameProveedores();
%>			  
			    <select name="proveedor1" onChange="verificaRepeticion(this.form, this)">
      	            <option <%if (proveedor1.equals("")){%>selected<%}%> value="">Seleccione...</option>
				<% while(rs.next()){%>
					<option value="<%=rs.getString("rfc")%>" <%if (proveedor1.equalsIgnoreCase(rs.getString("rfc"))){%>selected<%}%>><%=rs.getString("nombre")%></option>
				<% } rs.beforeFirst();%>
		        </select>
			    </div></td>
			</tr>		 
		  	<tr>
			  <th colspan="3">Proveedor 2:</th>
			  <td colspan="3"><div align="center">
			    <select name="proveedor2" onChange="verificaRepeticion(this.form, this)">
      	            <option <%if (proveedor2.equals("")){%>selected<%}%> value="" >Seleccione...</option>
				<% while(rs.next()){%>
					<option value="<%=rs.getString("rfc")%>" <%if (proveedor2.equalsIgnoreCase(rs.getString("rfc"))){%>selected<%}%> ><%=rs.getString("nombre")%></option>
				<% } rs.beforeFirst();%>					
		        </select>
			    </div></td>
			</tr>		 
		  	<tr>
			  <th colspan="3">Proveedor 3:</th>
			  <td colspan="3"><div align="center">
			    <select name="proveedor3" onChange="verificaRepeticion(this.form, this)">
      	            <option <%if (proveedor3.equals("")){%>selected<%}%> value="" >Seleccione...</option>
				<% while(rs.next()){%>
					<option value="<%=rs.getString("rfc")%>" <%if (proveedor3.equalsIgnoreCase(rs.getString("rfc"))){%>selected<%}%> ><%=rs.getString("nombre")%></option>
				<% } rs.beforeFirst();%>					
		        </select>
			    </div></td>
			</tr>
		  	<tr>
			  <th colspan="3">Proveedor 4:</th>
			  <td colspan="3"><div align="center">
			    <select name="proveedor4" onChange="verificaRepeticion(this.form, this)">
      	            <option <%if (proveedor4.equals("")){%>selected<%}%> value="" >Seleccione...</option>
				<% while(rs.next()){%>
					<option value="<%=rs.getString("rfc")%>" <%if (proveedor4.equalsIgnoreCase(rs.getString("rfc"))){%>selected<%}%> ><%=rs.getString("nombre")%></option>
				<% } rs.beforeFirst();%>					
		        </select>
			    </div></td>
			</tr>
		  	<tr>
			  <th colspan="3">Proveedor 5:</th>
			  <td colspan="3"><div align="center">
                <select name="proveedor5" onChange="verificaRepeticion(this.form, this)">
                  <option <%if (proveedor5.equals("")){%>selected<%}%> value="" >Seleccione...</option>
                  <% while(rs.next()){%>
                  <option value="<%=rs.getString("rfc")%>" <%if (proveedor5.equalsIgnoreCase(rs.getString("rfc"))){%>selected<%}%> ><%=rs.getString("nombre")%></option>
                  <% } proveedor.cierraConexion();%>
                </select>
</div></td>
			</tr>
			<tr>
			  <th colspan="3">Formato de Compra:</th>
			  <td colspan="3"><div align="center">
			  	<select name="uniCompra" onChange="Habilitador2(this.form)">
      	          <option <% if(uniCompra.equals("1")){%> selected <%}%> value="1" >Por Pieza y/o Caja</option>
      	          <option <% if(uniCompra.equals("2")){%> selected <%}%> value="2" >Por Pieza de Kilo</option>				  
		        </select></div>			    
			  </td>
			</tr> 
			<tr>
			  <th colspan="6">-- Compra por Unidad y/o Caja -- </th>
			</tr>			  
			<tr>
				<th>Precio por Unidad:</th>
				<td><div align="center">$ 
			      <input name="preUniCompra" type="text" value="<%=preUniCompra%>" id="preUniCompra" size="8" maxlength="6" onFocus="seleccionaTodo(this)" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>
				<th>Precio por Caja:</th>
				<td><div align="center">$ 
			      <input name="preCaCompra" type="text" value="<%=preCaCompra%>" id="preCaCompra" size="8" maxlength="6" onFocus="seleccionaTodo(this)" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>				
				<th>Unidades por Caja:</th>
				<td><div align="center">
				  <input name="piezasc" type="text" value="<%=piezasc%>" id="piezasc" size="8" maxlength="6" onFocus="seleccionaTodo(this)" onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>				
		 	</tr>				
			<tr>
			  <th colspan="6">-- Compra por Pieza de Kilo -- </th>
			</tr>			  
			<tr>
			  <th colspan="2">Precio de 1 Kg:</th>
			  <td><div align="center">$ 
			      <input name="preKgCompra" disabled type="text" value="<%=preKgCompra%>" onFocus="seleccionaTodo(this)" id="preKgCompra" size="8" maxlength="6" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>							
			  <th colspan="2">Kilos en Pieza: </th>
			  <td><div align="center">
			    <input name="kgXUni" disabled type="text" value="<%=kgXUni%>" id="kgXUni" onFocus="seleccionaTodo(this)" size="8" maxlength="6" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>
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
		  <caption><b class="aviso">Datos Venta</b></caption>
		  	<tr>
      		  <th colspan="2">Tipo de Precio: </th>
		      <td><div align="center">
		          <select name="tipoPrecio" onChange="Habilitador(this.form)">
		            <option value="0">Solo Menudeo</option>
		            <option value="1" selected <%if(tipoPrecio.equalsIgnoreCase("1")){%> <%}%>>Grupo de Precios</option>
		            <option value="2">Precios Escalonados</option>
		          </select>
      		  </div></td>
			  <th colspan="2">Manejo de Precio:</th>
			  <td colspan="4"><div align="center">
		          <select name="manejo" onChange="Habilitador(this.form)">
        		    <option value="0" selected <%if(manejo.equalsIgnoreCase("0") || manejo.equals("")){%> selected<%}%>>Solo por Unidad o Kg.</option>
		            <option <%if(manejo.equalsIgnoreCase("1")){%> selected<%}%> value="1">Por Unidad y Caja</option>
		            <option <%if(manejo.equalsIgnoreCase("2")){%> selected<%}%> value="2">Por Kg y Pieza</option>
        		  </select>
			  </div></td>			  			  
			</tr>
    		<tr>
			  <th colspan="2">Precio Menudeo<br />
			  (Unidad / 1Kg.):</th>
			  <td><div align="center">$ <input name="precioMenu" type="text" size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)"  onBlur="Copiador(this.form)" value="<%=precioMenu%>" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>
			  <th colspan="2">Precio Menudeo <br />
			     (Caja / Pieza):</th>
			  <td><div align="center">$ <input name="precioMenuC" type="text" size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)" value="<%=precioMenuC%>" disabled onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;">
			  </div></td>
			</tr>
    		<tr>
			  <th colspan="6"><div align="center">-- Grupo de Precios --</div></th>
			</tr>
			<tr>
			  <th colspan="2">Precio Medio Mayoreo:<br/>
		      (Unidad/1Kg)</th>
			  <td><div align="center">$ <input name="precioMM" type="text" size="8"  maxlength="6" align="right" onFocus="seleccionaTodo(this)" onBlur="CalculaCaja(this.form, this)" disabled value= "<%=precioMM%>" onC onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"> </div></td>
			  <th colspan="2">Precio Medio Mayoreo :<br/>
		      (Caja/Pieza)</th>
			  <td><div align="center">$ <input name="precioMMC" type="text" size="8"  maxlength="6" align="right" onFocus="seleccionaTodo(this)" disabled value="<%=precioMMC%>" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"> </div></td>
		    </tr>
			 <tr>
			  <th colspan="2">Precio Mayoreo :<br/>
		       (Unidad/1Kg)</th>
			  <td><div align="center">$ <input name="precioM" type="text"  size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)" onBlur="CalculaCaja(this.form, this)"  disabled value="<%=precioM%>" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"> </div></td>
			  <th colspan="2">Precio Mayoreo:<br/>
		       (Caja/Pieza)</th>
			  <td><div align="center">$ <input name="precioMC" type="text"  size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)"  disabled value="<%=precioMC%>" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"> </div></td>
			 </tr>
			<tr>
			  <th colspan="6" bgcolor="#CCCCCC">-- Precios Escalonados --</th>
			</tr>
			<tr>
			  <th colspan="3" bgcolor="#CCCCCC">Cantidad Unidades / Kg.:</th>
			  <th colspan="3" bgcolor="#CCCCCC">Precio:</th>
			</tr>
			<tr>
			  <td colspan="3"><div align="center"><input name="pieza1" type="text" size="5" maxlength="3" align="right" disabled value="1"></div></td>
			  <td colspan="3"><div align="center">$ <input name="precioE1" type="text" size="8" maxlength="6" value="<%=precioE1%>" onFocus="seleccionaTodo(this)" align="right" disabled onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"></div></td>
			</tr>
			<tr>
			  <td colspan="3"><div align="center"><input name="pieza2" type="text" size="5" maxlength="3" align="right" onFocus="seleccionaTodo(this)" value="<%=pieza2%>" disabled onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"></div></td>
			  <td colspan="3"><div align="center">$ <input name="precioE2" type="text" size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)" value="<%=precioE2%>" disabled onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"></div></td>
			</tr>
			<tr>
			  <td colspan="3"><div align="center"><input name="pieza3" type="text" size="5" maxlength="3" align="right" onFocus="seleccionaTodo(this)" value="<%=pieza3%>" disabled onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"></div></td>
			  <td colspan="3"><div align="center">$ <input name="precioE3" type="text" size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)" value="<%=precioE3%>" disabled onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"></div></td>
			</tr>
			<tr>
			  <td colspan="3"><div align="center"><input name="pieza4" type="text" size="5" maxlength="3" align="right" onFocus="seleccionaTodo(this)" value="<%=pieza4%>" disabled onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"></div></td>
			  <td colspan="3"><div align="center">$ <input name="precioE4" type="text" size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)" value="<%=precioE4%>" disabled onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"></div></td>
			</tr>
			<tr>
			  <td colspan="3"><div align="center"><input name="pieza5" type="text" size="5" maxlength="3" align="right" onFocus="seleccionaTodo(this)" value="<%=pieza5%>" disabled onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"></div></td>
			  <td colspan="3"><div align="center">$ <input name="precioE5" type="text" size="8" maxlength="6" align="right" onFocus="seleccionaTodo(this)" value="<%=precioE5%>" disabled onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"></div></td>
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
		  <caption><b class="aviso">Datos Inventario</b></caption>
		  	<tr>
			  <th width="16%">M&aacute;ximo:</th>
			  <td width="35%"><div align="center">
		        <input type="text" name="maxInv" value="<%=maxInv%>" maxlength="7" onFocus="seleccionaTodo(this)" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;" size="8"> 
	          Unidades/Kg.</div></td>
			  <th width="24%">M&iacute;nimo:</th>
			  <td width="25%"><div align="center">
		        <input type="text" name="minInv" value="<%=minInv%>" maxlength="7" onFocus="seleccionaTodo(this)" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;" size="8"> 
	          Unidades/Kg.</div></td>
			</tr>
			<tr>
			  <th rowspan="2" colspan="2">Existencia Actual:<br /> (Unidades / Kg.)</th>
			  <th>En Tienda</th>
			  <th>En Almacén</th>
			</tr>
			<tr>
			  <td><div align="center"> <input name="invTienda" type="text" size="10" maxlength="7" value="<%=invTienda%>"onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"></div></td>			  
			  <td><div align="center"> <input name="invAlmacen" type="text" size="10" maxlength="7" value="<%=invAlmacen%>"onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"></div></td>			  
			
			</tr>	
		  </table>
		</td>
	</tr>
  </table>
  <p>
  	<input type="reset" name="Limpiar Forma" value="Limpiar Forma">
	<input type="submit" name="Guardar" value="Guardar">	  
  </p>
</form>
<p align="center"><a href="Menu_Productos.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a><br />
<img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>