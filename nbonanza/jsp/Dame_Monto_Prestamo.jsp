<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" scope="page"/>
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Dame Monto a Pr&eacute;stamo</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
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

function funcionFoco(){
	document.form1.prestamo.focus();
}

function seleccionaTodo(objeto){
	objeto.select();
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function OnSubmitForm(){
	var pagoACubrir = new Number();
	pagoACubrir = parseInt(form1.prestamo.value);
	if (isNaN(pagoACubrir) || pagoACubrir <= 0.00){
		alert("El préstamo debe ser mayor a 0");
		form1.prestamo.value = "";
		form1.prestamo.select();
		return false;
	}
	else{
		document.form1.action ="Conf_Dame_Monto_Prestamo.jsp";		
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
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String claveE = request.getParameter("claveE");
	String nombreVendedor = empleado.dameNombreUsuario(claveE);
	String vencimiento = credito.parseaFechaASabado(ticket.dameFechaHoy());	
	BigDecimal totalPrestadoPrevio = new BigDecimal("0.00");
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); funcionFoco()">
<% 
// Averiguo si existen prestamos previos ya sean monetarios o por producto.
	boolean existenPrevios = false;
	ResultSet rsPreviosM = empleado.damePrestamosMPrevios(claveE); 
	ResultSet rsPreviosP = empleado.damePrestamosPPrevios(claveE); 
	while(rsPreviosM.next() && !existenPrevios){
		existenPrevios = true;
	}
	while(rsPreviosP.next() && !existenPrevios){
		existenPrevios = true;
	}
	rsPreviosM.beforeFirst();
	rsPreviosP.beforeFirst();
	if(existenPrevios){
%>
	<table border="1" cellpadding="0" cellspacing="0" width="700" align="center">
	<caption>Pr&eacute;stamos Previos.</caption>
	  <tr>
	  	<th width="180">Fecha Pr&eacute;stamo</th>
	  	<th width="200">Fecha Descuento</th>		
	  	<th width="160">Monto</th>
		<th width="150">Tipo</th>
	  </tr>
<% 		while(rsPreviosM.next()){ 
			totalPrestadoPrevio = totalPrestadoPrevio.add(new BigDecimal(rsPreviosM.getString("cantidadAPagar")));
%>
	  <tr>
	  	<td><div align="center"><%=rsPreviosM.getString("fechaPrestamo")%></div></td>
	  	<td><div align="center"><%=rsPreviosM.getString("fechaFiniquito")%></div></td>
	  	<td><div align="right">$<%=empleado.formatoDinero(rsPreviosM.getString("cantidadAPagar"))%></div></td>
	  	<td><div align="center">Monetario</div></td>						
	  </tr>		
<%		}   
		rsPreviosM.close();
		while(rsPreviosP.next()){ 
			totalPrestadoPrevio = totalPrestadoPrevio.add(new BigDecimal(rsPreviosP.getString("cantidadAPagar")));
%>
	  <tr>
	  	<td><div align="center"><%=rsPreviosP.getString("fechaCredito")%></div></td>
	  	<td><div align="center"><%=rsPreviosP.getString("fechaAPagar")%></div></td>
	  	<td><div align="right">$<%=empleado.formatoDinero(rsPreviosP.getString("cantidadAPagar"))%></div></td>
	  	<td><div align="center">Por Producto</div></td>						
	  </tr>		
<%		} 
		rsPreviosP.close();
		totalPrestadoPrevio = totalPrestadoPrevio.setScale(2, RoundingMode.HALF_UP);		
%> 
	  <tr>
	  	<th colspan="2">TOTAL A PR&Eacute;STAMO(S) PREVIO(S): </th>
	  	<td colspan="2"><div align="center"><b>$<%=empleado.formatoDinero(totalPrestadoPrevio.toString())%></b></div></td>
	  </tr>		
	</table>
<%	}	
	empleado.cierraConexion();
	empleado.cierraConexion2();
%>	
<form name="form1" method="post" onSubmit="return OnSubmitForm();"  target="_self">
<input type="hidden" name="claveE" value="<%=claveE%>">
<input type="hidden" name="vencimiento" value="<%=vencimiento%>">
<table align="center" cellpadding="0" cellspacing="0" border="1" width="700">
  <tr>
  	<th colspan="2">Escribe el Monto a Préstamo para:<br/><%=nombreVendedor%> </th>
  </tr>
  <tr>
  	<td colspan="2"><div align="center">$<input type="text" name="prestamo" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){document.form1.Submit.click();}"></div></td>
  </tr>
  <tr>
  	<th width="562">Fecha de Pago/Descuento:</th>
	<td width="132"><div align="center"><%=vencimiento%></div></td>
  </tr>
</table>
<p><input type="submit" value="Guardar" name="Enviar"></p>
</form> 
<p><a href="Menu_Prestamos_Nominas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p><img src="imagenes/barraN.jpg"></p>
</body>
</html>
