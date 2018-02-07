<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="error.jsp"%>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />

<html>
<head>
<title>Pagos Agregado</title>
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

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MandaSubmit(f){
	document.form1.submit();
}

function funcionFoco(){
	document.form1.imaC.focus();
}

//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Imprimir2.jpg','imagenes/Regresar2.jpg')">
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
	String pago = request.getParameter("total");
	String PagoCliente = request.getParameter("PagoCliente");
	String formaPago = request.getParameter("formaPago");
	String referenciaC = "";	
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
	String abonoPrevio = request.getParameter("abonoPrevio");
	if(!(formaPago.equals("1"))){
		referenciaC = request.getParameter("referenciaC");
	}
	BigDecimal ImporteACubrir = new BigDecimal(pago);
	ImporteACubrir = ImporteACubrir.setScale(2, RoundingMode.HALF_UP);	
	BigDecimal ImportePagado = new BigDecimal(PagoCliente);
	ImportePagado = ImportePagado.setScale(2, RoundingMode.HALF_UP);
	BigDecimal cambio = new BigDecimal("0.00");
	if(ImporteACubrir.compareTo(ImportePagado) == 1){ %>
		<b class="roj">El importe introducido es menor al total a Pagar.</b><br/>
		Da click en Modificar para reingresar el monto.
		<form name="retache" method="post" target="_self" action="Pago.jsp">
			<input type="hidden" name="pagados" value="<%=pago%>">
			<input type="hidden" name="pago1" value="<%=pago1%>">
			<input type="hidden" name="pago2" value="<%=pago2%>">
			<input type="hidden" name="pago3" value="<%=pago3%>">
			<input type="hidden" name="pago4" value="<%=pago4%>">
			<input type="hidden" name="pago5" value="<%=pago5%>">
			<input type="hidden" name="ticket1" value="<%=ticket1%>">
			<input type="hidden" name="ticket2" value="<%=ticket2%>">
			<input type="hidden" name="ticket3" value="<%=ticket3%>">			
			<input type="hidden" name="ticket4" value="<%=ticket4%>">
			<input type="hidden" name="ticket5" value="<%=ticket5%>">
			<input type="hidden" name="fecha" value="<%=fecha%>">
			<input type="hidden" name="tipot1" value="<%=tipot1%>">
			<input type="hidden" name="tipot2" value="<%=tipot2%>">
			<input type="hidden" name="tipot3" value="<%=tipot3%>">
			<input type="hidden" name="tipot4" value="<%=tipot4%>">
			<input type="hidden" name="tipot5" value="<%=tipot5%>">
			<p><input type="submit" value="Modificar" name="Modificar"></p>
		</form>
		
<%	}
	else{
		cambio = ImportePagado.subtract(ImporteACubrir);
		cambio = cambio.setScale(2, RoundingMode.HALF_UP);
		// VOY A CHECAR QUE NO HAYA LLEGADO A ESTA PAGINA DANDOLE AL BOTON DE REGRESAR....
		boolean llegoConBack = false;
		if(ticket1.trim().length() != 0){
			if(tipot1.equalsIgnoreCase("2")){
				int estaPagado = ticket.yaEstabaPagadoCredito(ticket1, fecha);
				if (estaPagado == 1){
					llegoConBack = true;
				}
			}
			else{
				int estaCobrado = ticket.yaEstabaPagado(ticket1, fecha);
				if (estaCobrado == 1){
					llegoConBack = true;
				}
			}
		}
		if(ticket2.trim().length() != 0){
			if(tipot2.equalsIgnoreCase("2")){
				int estaPagado = ticket.yaEstabaPagadoCredito(ticket2, fecha);
				if (estaPagado == 1){
					llegoConBack = true;
				}
			}
			else{
				int estaCobrado = ticket.yaEstabaPagado(ticket2, fecha);
				if (estaCobrado == 1){
					llegoConBack = true;
				}
			}
		}
		if(ticket3.trim().length() != 0){
			if(tipot3.equalsIgnoreCase("2")){
				int estaPagado = ticket.yaEstabaPagadoCredito(ticket3, fecha);
				if (estaPagado == 1){
					llegoConBack = true;
				}
			}
			else{
				int estaCobrado = ticket.yaEstabaPagado(ticket3, fecha);
				if (estaCobrado == 1){
					llegoConBack = true;
				}
			}
		}
		if(ticket4.trim().length() != 0){
			if(tipot4.equalsIgnoreCase("2")){
				int estaPagado = ticket.yaEstabaPagadoCredito(ticket4, fecha);
				if (estaPagado == 1){
					llegoConBack = true;
				}
			}
			else{
				int estaCobrado = ticket.yaEstabaPagado(ticket4, fecha);
				if (estaCobrado == 1){
					llegoConBack = true;
				}
			}
		}
		if(ticket5.trim().length() != 0){
			if(tipot5.equalsIgnoreCase("2")){
				int estaPagado = ticket.yaEstabaPagadoCredito(ticket5, fecha);
				if (estaPagado == 1){
					llegoConBack = true;
				}
			}
			else{
				int estaCobrado = ticket.yaEstabaPagado(ticket5, fecha);
				if (estaCobrado == 1){
					llegoConBack = true;
				}
			}
		}
		if(llegoConBack){
%>
<b class="roj">Ya habías realizado el cobro de este Ticket, no debes usar los botones de Navegación.</b>
<%		
		}
		else{
			int resultado = ticket.finalizaTicketVenta(fecha, ticket1, ticket2, ticket3, ticket4, ticket5, pago1, pago2, pago3, pago4, pago5, tipot1, tipot2, tipot3, tipot4, tipot5, formaPago, referenciaC, usuario);
			if(resultado == 0){
%>
<form name="form1" method="post" target="_blank" action="Ticket.jsp" >
	<input name="ticket1" type="hidden" value="<%=ticket1 %>">
	<input name="ticket2" type="hidden" value="<%=ticket2 %>">
	<input name="ticket3" type="hidden" value="<%=ticket3 %>">
	<input name="ticket4" type="hidden" value="<%=ticket4 %>">
	<input name="ticket5" type="hidden" value="<%=ticket5 %>">
	<input name="pago1" type="hidden" value="<%=pago1 %>">
	<input name="pago2" type="hidden" value="<%=pago2 %>">
	<input name="pago3" type="hidden" value="<%=pago3 %>">
	<input name="pago4" type="hidden" value="<%=pago4 %>">
	<input name="pago5" type="hidden" value="<%=pago5 %>">
	<input name="fecha" type="hidden" value="<%=fecha %>">
	<input name="pago" type="hidden" value="<%=ImporteACubrir.toString() %>">
	<input name="PagoCliente" type="hidden" value="<%=ImportePagado.toString() %>">
	<input name="cambio" type="hidden" value="<%=cambio.toString()%>">
	<input name="usuario" type="hidden" value="<%=usuario%>">
	<h1>Se guardó el registro exitosamente</em></h1>
	<table align="center" border="1" width="350">
	 <tr>
		<th height="45">Cambio:</th>
		<td><div align="right"><b> $<%=ticket.formatoDinero(ticket.acortaLongitud(cambio.toString()))%></b></div></td>
	 </tr>
	</table>
	
	<p align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="132" height="41" border="0"></a>			
	</p>
</form>	
<%
			}
			else if(resultado == 1){
			Vector <String> faltante = ticket.dameProductosFaltantes(ticket1, ticket2, ticket3, ticket4, ticket5, tipot1, tipot2, tipot3, tipot4, tipot5);

%>
	<b class="roj"> ¡¡FALTA PRODUCTO!!!</b>
<p>	<table align="center" width="700" border="1" cellpadding="0" cellspacing="0">
	  <caption>No puedo finalizar la serie de tickets dado ya que no existe(n) <br/>el/los siguiente(s) producto(s) en Inventario.</caption>
<%		for(int i = 0; i < faltante.size(); i ++){ %>	  
	  <tr>
	  	<td><div align="center"><%=faltante.elementAt(i)%></div></td>
	  </tr>
<%		}  %>	  
	</table></p>
	<b class="aviso">Pida se agreguen al Inventario o bien se haga(n) otro(s) ticket(s).</b><br/>
<%			
			}
			else if(resultado == 2){
%>
	<b class="roj">Al menos un ticket ya esta pagado. Verificalo.</b>
<%			
			}
			else if(resultado == 3){
%>
	<b class="roj">No pude finalizar la transacción de cierre de Venta, vuelva a intentarlo.</b>
<%						
			}		
		}
	}
%>
<p><a href="Existe_Ticket2.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>