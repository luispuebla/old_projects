<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="error.jsp"%>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page"/>

<html>
<head>
<title>Pago de Ticket(s)</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
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
	if(document.form1 != null){
		document.form1.PagoCliente.focus();
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

function OnSubmitForm(){
	var tipoCobro = form1.formaPago.value;	
	var pagoACubrir = new Number();
	pagoACubrir = parseInt(form1.posibleAPagar.value);
	if (isNaN(pagoACubrir)){
		pagoACubrir = 0.00;
	}
	var pagoCubierto = new Number();
	pagoCubierto = parseInt(form1.PagoCliente.value);
	if (isNaN(pagoCubierto)){
		pagoCubierto = 0.00;
	}
	if(pagoCubierto <= 0.00){
		alert("Debes ingresar un Monto de Abono Mayor a 0");
		form1.PagoCliente.select();
		return false;		
	}	
	else if(pagoCubierto > pagoACubrir){
		alert("El importe es mayor al Total Adeudado por Crédito, Modificalo: "+pagoCubierto +" --> "+pagoACubrir);
		form1.PagoCliente.select();
		return false;
	} 
	if(tipoCobro == '2' ||  tipoCobro == '3' || tipoCobro == '4' || tipoCobro == '5'){
		var docAval = new String();
		docAval = form1.referenciaC.value;
		re = / /gi;
		docAval = docAval.replace(re,"");
		if(docAval == ''){
			alert("Debes especificar un Documento Referencia para esta Forma de Pago");
			form1.referenciaC.focus();
			return false;
		}
		else{
			document.form1.action ="Conf_Pago_En_Abono.jsp";		
			return true;
		}
	}
	else{
		document.form1.action ="Conf_Pago_En_Abono.jsp";		
		return true;	
	}
}

function seleccionaTodo(objeto){
	objeto.select();
}

function Habilitador(){
	var contenido = form1.formaPago.value;
	var total = form1.total.value;
	if(contenido =='1'){
		form1.referenciaC.readOnly = true;
		form1.PagoCliente.readOnly = false;
		form1.PagoCliente.value = "";
	}
	else{
		form1.PagoCliente.value = total;
		form1.PagoCliente.readOnly = true;		
		form1.referenciaC.readOnly = false;
		form1.referenciaC.value = "";
		
	}
}

//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco()">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String temporal = "";
	String rfc = "";
	String nombreCliente = "";
	if(request.getParameter("clave") != null){
		temporal = request.getParameter("clave");
	}
	if(temporal.trim().length() == 0){
%>
		<form name="retache" method="post" action="Escoge_Cliente_A_Abonar.jsp" target="_self">
			<b class="roj">Debes seleccionar un Cliente de la lista para realizar un abono.</b>
			<p><input type="submit" name="Volver" value="Volver"></p>
		</form>
<%	
	}
	else{	
		rfc = temporal.substring(0, temporal.lastIndexOf("¡"));
		nombreCliente = temporal.substring(temporal.lastIndexOf("¡")+1, temporal.length());
%>
<form name="form1" method="post" onSubmit="return OnSubmitForm();" >
	<input name="rfc" type="hidden" value="<%=rfc %>">
	<input name="nombreCliente" type="hidden" value="<%=nombreCliente%>">

<table width="510" align="center" border="1">
 <caption><b class="titulos">Datos para Abono:</b></caption>
  <tr valign="top"> 
  	<th width="169">Monto a <br/>Cr&eacute;dito</th>
	<th width="149">Monto Abonos Previos</th>
	<th width="170">Total Adeudo por Cr&eacute;dito </th>
  </tr>
<% 
	BigDecimal faltante = new BigDecimal("0.00");
	BigDecimal yaAbonado = new BigDecimal("0.00");
	ResultSet rs = ticket.dameDatosDeClienteParaAbono(rfc, nombreCliente);
	while(rs.next()){
		BigDecimal aCredito = new BigDecimal(rs.getString("MontoACredito"));
		if(rs.getString("ACuenta") != null){
			yaAbonado = new BigDecimal(rs.getString("ACuenta"));			
		}
		faltante = aCredito.subtract(yaAbonado);
		faltante = faltante.setScale(2, RoundingMode.HALF_UP);		
%>  
	<input type="hidden" name="posibleAPagar" value="<%=faltante.toString()%>">
  <tr>
  	<td><div align="right">$ <%=ticket.formatoDinero(aCredito.toString())%></div></td>
  	<td><div align="right">$ <%=ticket.formatoDinero(yaAbonado.toString())%></div></td>
  	<td><div align="right"><b>$ <%=ticket.formatoDinero(faltante.toString())%></b></div></td>		
  </tr>
<%
	}
	rs.close();
	ticket.cierraConexion();	  
%>  
  <tr>
  	<th colspan="3">Monto desglosado por Tickets a Cr&eacute;dito sin finiquitar: </th>
  </tr>
  <tr>
  	<th>Ticket</th>
  	<th>Monto</th>	
  	<th>Faltante usando abonos Previos</th>		
  </tr>
<% 	rs = ticket.dameDatosDesglosadoXTicket(rfc, nombreCliente); 
  	while(rs.next()){ 
		BigDecimal restante = new BigDecimal(rs.getString("cantidadAPagar"));
		restante = restante.subtract(yaAbonado);
%>
  	<tr>
		<td><div align="center"><%=rs.getString("numTicket")%></div></td>
		<td><div align="right">$ <%=ticket.formatoDinero(rs.getString("cantidadAPagar"))%></div></td>
		<td><div align="right"><b>$ <%=ticket.formatoDinero(restante.toString())%></b></div></td>
	</tr>
<%
	}
	rs.close();
	ticket.cierraConexion();
%>	  
  <tr> 
    <th height="40"> Formato de Pago: </th>
	<td colspan="2" valign="middle"> <div align="center">
	  <select name="formaPago" onChange="Habilitador()">
		      <option selected value="1">Efectivo</option>
		      <option value="2">Cheque</option>			
		      <option value="3">Transferencia</option>						
		      <option value="4">T.Cr&eacute;dito</option>						
		      <option value="5">T.Débito</option>									
          </select> 
	  </div></td>
  </tr>  
  <tr>
	<th>Introduce el Importe<br />con el que Paga: </th>
	<td colspan="2"><br /><div align="center">$ <input type="text" name="PagoCliente" size="12" onFocus="seleccionaTodo(this)" value="" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){document.form1.Submit.click();}"> </div><br />
  </tr>	
  <tr>
	<th>Documento Referencia:<br />(Num. Cheque / Autorizaci&oacute;n)</th>
	<td valign="middle" colspan="2"><br /><div align="center"><input type="text" name="referenciaC" size="32" maxlength="30" readonly="true"> </div><br />
  </tr>	
</table>
<p>	<div align="center"><input type="submit" name="Submit" value="Pagar"></div></td>
</p>
</form>
<%	
	}
%>
<p align="center"><a href="Escoge_Cliente_A_Abonar.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>
