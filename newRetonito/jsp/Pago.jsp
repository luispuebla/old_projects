<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>
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
	document.form1.PagoCliente.focus();
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
	pagoACubrir = parseInt(form1.total.value);
	if (isNaN(pagoACubrir)){
		pagoACubrir = 0.00;
	}
	var pagoCubierto = new Number();
	pagoCubierto = parseInt(form1.PagoCliente.value);
	if (isNaN(pagoCubierto)){
		pagoCubierto = 0.00;
	}
	if(pagoCubierto < pagoACubrir){
		alert("El importe es menor al Total a Pagar, Modificalo: "+pagoACubrir +" --> "+pagoCubierto);
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
			document.form1.action ="Conf_Pago.jsp";		
			return true;
		}
	}
	else{
		document.form1.action ="Conf_Pago.jsp";		
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
<style type="text/css">
<!--
.style2 {color: #FF3300}
-->
</style>
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
	String pago = request.getParameter("pagados");
	String tpago = ticket.acortaLongitud(pago);
	String ticket1 = request.getParameter("ticket1");
	String ticket2 = request.getParameter("ticket2");
	String ticket3 = request.getParameter("ticket3");
	String ticket4 = request.getParameter("ticket4");
	String ticket5 = request.getParameter("ticket5");
	String tipot1 = request.getParameter("tipot1");
	String tipot2 = request.getParameter("tipot2");
	String tipot3 = request.getParameter("tipot3");
	String tipot4 = request.getParameter("tipot4");
	String tipot5 = request.getParameter("tipot5");		
	String pago1 = request.getParameter("pago1");
	String pago2 = request.getParameter("pago2");
	String pago3 = request.getParameter("pago3");
	String pago4 = request.getParameter("pago4");
	String pago5 = request.getParameter("pago5");
	String fecha = request.getParameter("fecha");	
	Double abonoPrevio = 0.00;
	String rfc = "";
	String nombreCli = "";
	boolean clienteDiverso = false;
	if(tipot1.equals("2")){
		Vector<String> dataAbono = ticket.damePosibleAbono(ticket1);
		if(rfc.equals("")){
			rfc = dataAbono.elementAt(0);
			nombreCli = dataAbono.elementAt(1);
			abonoPrevio = ticket.cambiaADouble(dataAbono.elementAt(2));
		}
		else{
			if(!(rfc.equalsIgnoreCase(dataAbono.elementAt(0)) && nombreCli.equalsIgnoreCase(dataAbono.elementAt(1)))){
				clienteDiverso = true;				
			}
		}
	}
	if(tipot2.equals("2")){
		Vector<String> dataAbono = ticket.damePosibleAbono(ticket2);
		if(rfc.equals("")){
			rfc = dataAbono.elementAt(0);
			nombreCli = dataAbono.elementAt(1);
			abonoPrevio = ticket.cambiaADouble(dataAbono.elementAt(2));
		}
		else{
			if(!(rfc.equalsIgnoreCase(dataAbono.elementAt(0)) && nombreCli.equalsIgnoreCase(dataAbono.elementAt(1)))){
				clienteDiverso = true;				
			}
		}		
	}
	if(tipot3.equals("2")){
		Vector<String> dataAbono = ticket.damePosibleAbono(ticket3);
		if(rfc.equals("")){
			rfc = dataAbono.elementAt(0);
			nombreCli = dataAbono.elementAt(1);
			abonoPrevio = ticket.cambiaADouble(dataAbono.elementAt(2));
		}
		else{
			if(!(rfc.equalsIgnoreCase(dataAbono.elementAt(0)) && nombreCli.equalsIgnoreCase(dataAbono.elementAt(1)))){
				clienteDiverso = true;				
			}
		}		
	}
	if(tipot4.equals("2")){
		Vector<String> dataAbono = ticket.damePosibleAbono(ticket4);
		if(rfc.equals("")){
			rfc = dataAbono.elementAt(0);
			nombreCli = dataAbono.elementAt(1);
			abonoPrevio = ticket.cambiaADouble(dataAbono.elementAt(2));
		}
		else{
			if(!(rfc.equalsIgnoreCase(dataAbono.elementAt(0)) && nombreCli.equalsIgnoreCase(dataAbono.elementAt(1)))){
				clienteDiverso = true;				
			}
		}		
	}
	if(tipot5.equals("2")){
		Vector<String> dataAbono = ticket.damePosibleAbono(ticket5);
		if(rfc.equals("")){
			rfc = dataAbono.elementAt(0);
			nombreCli = dataAbono.elementAt(1);
			abonoPrevio = ticket.cambiaADouble(dataAbono.elementAt(2));
		}
		else{
			if(!(rfc.equalsIgnoreCase(dataAbono.elementAt(0)) && nombreCli.equalsIgnoreCase(dataAbono.elementAt(1)))){
				clienteDiverso = true;				
			}
		}		
	}
	if(!clienteDiverso){
		if(abonoPrevio > 0.00){ %>
			<h1 class="style2">&gt;&gt;&gt; Se encontr&oacute; un monto en Abono por $<%=ticket.formatoDinero(ticket.acortaLongitud(abonoPrevio+""))%>, por lo que <br/>
		     se debe(n) finiquitar el/los Ticket(s) a cr&eacute;dito<br/> para este cliente (<%=nombreCli%>(<%=rfc%>))<br/>
		     a trav�s de la opci&oacute;n de Pago en Abono &lt;&lt;&lt; </h1>
<%		}
		else{ %>
<form name="form1" method="post" onSubmit="return OnSubmitForm();" >
	<input name="ticket1" type="hidden" value="<%=ticket1 %>">
	<input name="ticket2" type="hidden" value="<%=ticket2 %>">
	<input name="ticket3" type="hidden" value="<%=ticket3 %>">
	<input name="ticket4" type="hidden" value="<%=ticket4 %>">
	<input name="ticket5" type="hidden" value="<%=ticket5 %>">
	<input name="tipot1" type="hidden" value="<%=tipot1 %>">
	<input name="tipot2" type="hidden" value="<%=tipot2 %>">
	<input name="tipot3" type="hidden" value="<%=tipot3 %>">
	<input name="tipot4" type="hidden" value="<%=tipot4 %>">
	<input name="tipot5" type="hidden" value="<%=tipot5 %>">
	<input name="pago1" type="hidden" value="<%=pago1 %>">
	<input name="pago2" type="hidden" value="<%=pago2 %>">
	<input name="pago3" type="hidden" value="<%=pago3 %>">
	<input name="pago4" type="hidden" value="<%=pago4 %>">
	<input name="pago5" type="hidden" value="<%=pago5 %>">
	<input name="fecha" type="hidden" value="<%=fecha %>">
	<input name="total" type="hidden" value="<%=tpago%>">

<table width="510" align="center" border="1">
 <caption><b class="titulos">Total a Pagar:</b></caption>
  <tr valign="top"> 
    <td colspan="2" height="40" bgcolor="#FFFFCC" ><div align="center"><br />
          <b class="aviso2">$ <%= ticket.formatoDinero(tpago)%></b><br />
    </div></td>
  </tr>
  <tr> 
    <th height="40"> Formato de Pago: </th>
	<td valign="middle"> <div align="center">
	  <select name="formaPago" onChange="Habilitador()">
		      <option selected value="1">Efectivo</option>
		      <option value="2">Cheque</option>			
		      <option value="3">Transferencia</option>						
		      <option value="4">T.Cr&eacute;dito</option>						
		      <option value="5">T.D�bito</option>									
          </select> 
	  </div></td>
  </tr>  
  <tr>
	<th>Introduce el Importe<br />con el que Paga: </th>
	<td><br /><div align="center">$ <input type="text" name="PagoCliente" size="12" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){document.form1.Submit.click();}"> </div><br />
  </tr>	
  <tr>
	<th>Documento Referencia:<br />(Num. Cheque / Autorizaci&oacute;n)</th>
	<td valign="middle"><br /><div align="center"><input type="text" name="referenciaC" size="32" maxlength="30" readonly="true"> </div><br />
  </tr>	
</table>
<p>	<div align="center"><input type="submit" name="Submit" value="Pagar"></div></td>
</p>
</form>
<%		}
	} // Cierre if
	else{ %>
		<b class="roj"> Al menos dos de los tickets estan dados a cr&eacute;dito y no corresponden al mismo cliente.</b><br/>
		Debe procesar estos tickets por separado.
<%  } %>	
<p align="center"><a href="Existe_Ticket2.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>
