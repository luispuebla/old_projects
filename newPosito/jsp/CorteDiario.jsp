<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" %>
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" scope="page" />
<jsp:useBean id="vendedores" class="com.alpha.bd.ManagerVendedores"  scope="page"/>

<html>
<head>
<title>Corte Diario</title>
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
//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg','imagenes/Imprimir2.jpg')">
<%
 	String usuarioS = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuarioS == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String tipoConsul = request.getParameter("tipoCon");
	String dia = "%%";
	String totalVentas = "0.00";	
	String mes = request.getParameter("mes");
	String anio = request.getParameter("aaaa");
	if(tipoConsul.equalsIgnoreCase("dia")){
		dia = request.getParameter("dia");
	}
	String fecha = anio+"-"+mes+"-"+dia;
%>
<h1>Los Pagos por Ventas para la Fecha: 
<%  if(!(dia.equalsIgnoreCase("%%"))){ %> 
 	<%=dia%> / 
<% }%> 
	<%=mes%> / <%=anio%> son:</h1>

<%
	boolean existenDatos = facturas.hayTickets(fecha);
	if(! existenDatos){ %>
	
		<b class="roj"> No hay datos disponibles en esta fecha.</b>
		<p><div align="center"><a href="Menu_Consul_Ventas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></div></p>
	
<%	
	}
	else{ 
		String ticketCobroP = ""; 
		String ticketCobroU = "";
		String ticketCredP = "No";
	%>
	<form name="form1" method="post" target="_blank" action="Imprime_Corte.jsp" >
		<input type="hidden" name="fecha" value="<%=fecha%>">	
	  <table align="center" width="500" border="1" cellpadding="0" cellspacing="0">
	    <caption>
	    Tickets para la fecha estipulada
	    </caption>
	  	<tr>
			<th colspan="2">Tickets Pagados No Cr&eacute;ditos (Serie) </th>
		</tr>
	  	<tr>
			<th>Primer Ticket</th>
			<th>&Uacute;ltimo Ticket</th>			
		</tr>
<% 		ResultSet rs = facturas.dameConsecutivoTicketsSinCredito(fecha);
		if(rs == null){ %>
		<tr>
			<td> <div align="center">--- </div></td>
			<td> <div align="center">--- </div></td>			
		</tr>
<%		}
		else{ 
			while(rs.next()){ 
				ticketCobroP = rs.getString("MinTP");
				ticketCobroU = rs.getString("MaxTP");				
			 %>
			<tr>
				<td><div align="center"><%=rs.getInt("MinTP")%></div></td>
				<td><div align="center"><%=rs.getInt("MaxTP")%></div></td>			
			</tr>
<%			}
		}
		rs.close();
		facturas.cierraConexion();	%>
	  	<tr>
			<th colspan="2">Tickets A Cr&eacute;dito Pagados (Existencia)</th>
		</tr>
	  	<tr>
			<th colspan="2">Se cobraron Tickets a Cr&eacute;dito:</th>
		</tr>
<% 		rs = facturas.dameConsecutivoTicketsDeCredito(fecha);
		if(rs == null){ %>
		<tr>
			<td colspan="2"> <div align="center"> No </div></td>
		</tr>
<%		}
		else{ 
			while(rs.next()){
			if (rs.getString("MaxTP") != null){
				ticketCredP = "S&iacute;";
			}
			%>
			<tr>
				<td colspan="2"><div align="center"><%=ticketCredP%></div></td>
			</tr>
<%			}
		}
		rs.close();
		facturas.cierraConexion();	%>		
	  </table>
	  <br />
		<input type="hidden" name="ticketCobroP" value="<%=ticketCobroP%>">
		<input type="hidden" name="ticketCobroU" value="<%=ticketCobroU%>">
		<input type="hidden" name="ticketCredP" value="<%=ticketCredP%>">
<% 	
		rs = facturas.dameCorteTodos(fecha);
		String usuario = "";
		String nombreUsuario = "";
		boolean primero = true;
		BigDecimal parcial = new BigDecimal("0.00");
		BigDecimal total = new BigDecimal("0.00");
		BigDecimal pagoEfectivo = new BigDecimal("0.00");
		BigDecimal pagoCheque = new BigDecimal("0.00");
		BigDecimal pagoTransferencia = new BigDecimal("0.00");
		BigDecimal pagoTC = new BigDecimal("0.00");
		BigDecimal pagoTD = new BigDecimal("0.00");

		while (rs.next()){ 
			String tipoTicket = "Directo";
				if(rs.getInt("Tipo") == 2){
					tipoTicket = "Cr&eacute;dito";
				}		
				String tipoCobro = "Efectivo";
				if(rs.getInt("tipoCobro") == 2){
					tipoCobro = "Cheque /"+rs.getString("referenciaCobro");
					pagoCheque = pagoCheque.add(new BigDecimal(rs.getString("sumaVenta")));					
				}
				else if(rs.getInt("tipoCobro") == 3){
					tipoCobro = "Transferencia /"+rs.getString("referenciaCobro");
					pagoTransferencia = pagoTransferencia.add(new BigDecimal(rs.getString("sumaVenta")));					
				}
				else if(rs.getInt("tipoCobro") == 4){
					tipoCobro = "Tarjeta de Cr&eacute;dito /"+rs.getString("referenciaCobro");
					pagoTC = pagoTC.add(new BigDecimal(rs.getString("sumaVenta")));					
				}
				else if(rs.getInt("tipoCobro") == 5){
					tipoCobro = "Tarjeta de D&eacute;bito /"+rs.getString("referenciaCobro");
					pagoTD = pagoTD.add(new BigDecimal(rs.getString("sumaVenta")));					
				}
				else if(rs.getInt("tipoCobro") == 6){
					tipoCobro = "Finiquito De Abono";
				}
				else{
					pagoEfectivo = pagoEfectivo.add(new BigDecimal(rs.getString("sumaVenta")));									
				}
								
				if(primero){
					usuario = rs.getString("usuario");
					if(facturas.cambiaAInt(usuario) == 0){
						nombreUsuario = usuario;
					}
					else{
						nombreUsuario = vendedores.dameNombreUsuario(usuario);
					}
					primero = false; 
					if(rs.getInt("tipoCobro") != 6){
						parcial = parcial.add(new BigDecimal(rs.getString("sumaVenta")));
						total = total.add(new BigDecimal(rs.getString("sumaVenta")));
					}
%>
		<table align="center" cellpadding="0" cellspacing="0" width="650" border="1">
		<caption>Usuario: <%=nombreUsuario%></caption>
			<tr>
				<th>Ticket</th>
				<th>Cargo De Ticket</th>				
				<th>Forma de Pago / Referencia</th>
				<th>Total</th>
			</tr>
			<tr>
				<td><div align="center"><%=rs.getInt("numTicket")%></div></td>
				<td><div align="center"><%=tipoTicket%></div></td>
				<td><div align="left"><%=tipoCobro%></div></td>
				<td><div align="right"><%=facturas.formatoDinero(rs.getString("sumaVenta"))%><%if(rs.getInt("tipoCobro") == 6){%><span class="style1">**</span><%}%></div></td>
			</tr>			
<%				}
				else{
					if (usuario.equalsIgnoreCase(rs.getString("usuario"))){ 
						if(rs.getInt("tipoCobro") != 6){					
							parcial = parcial.add(new BigDecimal(rs.getString("sumaVenta")));
							total = total.add(new BigDecimal(rs.getString("sumaVenta"))); 
						}%>
				<tr>
					<td><div align="center"><%=rs.getInt("numTicket")%></div></td>
					<td><div align="center"><%=tipoTicket%></div></td>
					<td><div align="left"><%=tipoCobro%></div></td>
					<td><div align="right"><%=facturas.formatoDinero(rs.getString("sumaVenta"))%><%if(rs.getInt("tipoCobro") == 6){%><span class="style1">**</span><%}%></div></td>
				</tr>						
<%					}
					else{	
						parcial = parcial.setScale(2, RoundingMode.HALF_UP);
						usuario = rs.getString("usuario");
						if(facturas.cambiaAInt(usuario) == 0){
							nombreUsuario = usuario;
						}		
						else{
							nombreUsuario = vendedores.dameNombreUsuario(usuario);
						}	%>
				<tr>
					<th colspan="2">&nbsp;</th>
					<th>TOTAL:</th>
					<td><div align="right"><b>$ <%=facturas.formatoDinero(parcial.toString())%></b></div></td>
				</tr>	
			</table><br />
			<%
						if(rs.getInt("tipoCobro") != 6){								
							parcial = new BigDecimal(rs.getString("sumaVenta"));
							total = total.add(new BigDecimal(rs.getString("sumaVenta"))); 
						}
						else{
							parcial = new BigDecimal("0.00");
						}
			%>
		<table align="center" cellpadding="0" cellspacing="0" width="650" border="1">
		<caption>Usuario: <%=nombreUsuario%></caption>		
			<tr>
				<th>Ticket</th>
				<th>Cargo De Ticket</th>				
				<th>Forma de Pago / Referencia</th>
				<th>Total</th>
			</tr>
			<tr>
				<td><div align="center"><%=rs.getInt("numTicket")%></div></td>
				<td><div align="center"><%=tipoTicket%></div></td>
				<td><%=tipoCobro%></td>
				<td><div align="right"><%=facturas.formatoDinero(rs.getString("sumaVenta"))%><%if(rs.getInt("tipoCobro") == 6){%>
				    <span class="style1">**</span>
				    <%}%></div></td>
				</tr>										
<%										
			}
		}
	}
	parcial = parcial.setScale(2, RoundingMode.HALF_UP);	
	total = total.setScale(2, RoundingMode.HALF_UP);
	pagoEfectivo = pagoEfectivo.setScale(2, RoundingMode.HALF_UP);
	pagoCheque = pagoCheque.setScale(2, RoundingMode.HALF_UP);
	pagoTransferencia = pagoTransferencia.setScale(2, RoundingMode.HALF_UP);
	pagoTC = pagoTC.setScale(2, RoundingMode.HALF_UP);
	pagoTD = pagoTD.setScale(2, RoundingMode.HALF_UP);
%>
		<tr>
			<th colspan="2">&nbsp;</th>
			<th>TOTAL:</th>
			<td><div align="right"><b>$ <%=facturas.formatoDinero(parcial.toString())%></b></div></td>
		</tr>	
	</table>
	<span class="style1">** No entran en sumatoria por estar considerados en Abonos</span>
	<br />
<% 	
	parcial = new BigDecimal("0.00");
	rs = facturas.dameAbonos(fecha); %>		
	<table align="center" border="1" width="650" cellpadding="0" cellspacing="0">
	<caption>Abonos Recibidos</caption>
	  <tr>
	  	<th width="250">Cliente</th>
	  	<th width="96">Fecha Pago</th>		
	  	<th width="153">Forma de Pago  / Referencia</th>
	  	<th width="66">Registr&oacute; Pago</th>
	  	<th width="73">Monto</th>
	  </tr>
<%	while(rs.next()){	
		parcial = parcial.add(new BigDecimal(rs.getString("monto")));  
		total = total.add(new BigDecimal (rs.getString("monto"))); 
		String referenciaC = "&nbsp;";
		String formaPago = "Efectivo";
		if(rs.getInt("formatoPago") == 2){
			formaPago = "Cheque";
			referenciaC = rs.getString("referenciaCobro");
			pagoCheque = pagoCheque.add(new BigDecimal (rs.getString("monto")));  	
		}
		else if(rs.getInt("formatoPago") == 3){
			formaPago = "Transferencia";
			referenciaC = rs.getString("referenciaCobro");	
			pagoTransferencia = pagoTransferencia.add(new BigDecimal (rs.getString("monto")));			
		}
		else if(rs.getInt("formatoPago") == 4){
			formaPago = "T.Cr&eacute;dito";
			referenciaC = rs.getString("referenciaCobro");	
			pagoTC = pagoTC.add(new BigDecimal (rs.getString("monto")));	
		}
		else if(rs.getInt("formatoPago") == 5){
			formaPago = "T.D&eacute;bito";
			referenciaC = rs.getString("referenciaCobro");
			pagoTD = pagoTD.add(new BigDecimal (rs.getString("monto")));	
		}
		else{
			pagoEfectivo = pagoEfectivo.add(new BigDecimal (rs.getString("monto")));	
		}
%>
	<tr>
		<td><div align="center"><%=rs.getString("nombreCliente")%> (<%=rs.getString("rfc")%>)</div></td>
		<td><div align="center"><%=rs.getString("fecha")%></div></td>
		<td><div align="center"><%=formaPago%>/<%=referenciaC%></div></td>
		<td><div align="center"><%=rs.getString("cobro")%></div></td>
		<td><div align="right"><%=facturas.formatoDinero(rs.getString("monto"))%></div></td>
	</tr>
<%	}
	rs.close();
	facturas.cierraConexion();
	parcial = parcial.setScale(2, RoundingMode.HALF_UP);	
	total = total.setScale(2, RoundingMode.HALF_UP);
	pagoEfectivo = pagoEfectivo.setScale(2, RoundingMode.HALF_UP);
	pagoCheque = pagoCheque.setScale(2, RoundingMode.HALF_UP);
	pagoTransferencia = pagoTransferencia.setScale(2, RoundingMode.HALF_UP);
	pagoTC = pagoTC.setScale(2, RoundingMode.HALF_UP);
	pagoTD = pagoTD.setScale(2, RoundingMode.HALF_UP);	
%>		
	<tr>
		<th colspan="4"><div align="right">TOTAL POR ABONO(S):</div></th>
		<td><div align="right"><b>$ <%=facturas.formatoDinero(parcial.toString())%></b></div></td>
	</tr>
	</table>
	<input type="hidden" name="abonos" value="<%=facturas.formatoDinero(parcial.toString())%>">
	<table align="center" border="1" width="600" cellpadding="0" cellspacing="0">
	<caption>Total por Tipo de Pago</caption>
	  <tr>
	  	<th>Efectivo</th>
	  	<th>Cheque</th>
	  	<th>Transferencia</th>
	  	<th>T. Cr&eacute;dito</th>
	  	<th>T. D&eacute;bito</th>
	  </tr>
	  <tr>
	  	<td><div align="right"><b>$ <%=facturas.formatoDinero(pagoEfectivo.toString())%></b></div></td>
	  	<td><div align="right"><b>$ <%=facturas.formatoDinero(pagoCheque.toString())%></b></div></td>
	  	<td><div align="right"><b>$ <%=facturas.formatoDinero(pagoTransferencia.toString())%></b></div></td>
	  	<td><div align="right"><b>$ <%=facturas.formatoDinero(pagoTC.toString())%></b></div></td>
	  	<td><div align="right"><b>$ <%=facturas.formatoDinero(pagoTD.toString())%></b></div></td>				
	  </tr>
	</table>
	<br/>	
	<table align="center" border="1" width="350">
	<caption>
	Total "La Nueva Bonanza"
	</caption>
		<tr>
			<th>Total Vendido</th>
			<td><div align="right"><b>$ <%=facturas.formatoDinero(total.toString())%></b></div></td>
		</tr>
	</table>
	<input type="hidden" name="totalRetono" value="<%=facturas.formatoDinero(total.toString())%>">
	<input type="hidden" name="pagoEfectivo" value="<%=facturas.formatoDinero(pagoEfectivo.toString())%>">
	<input type="hidden" name="pagoCheque" value="<%=facturas.formatoDinero(pagoCheque.toString())%>">
	<input type="hidden" name="pagoTransferencia" value="<%=facturas.formatoDinero(pagoTransferencia.toString())%>">
	<input type="hidden" name="pagoTC" value="<%=facturas.formatoDinero(pagoTC.toString())%>">
	<input type="hidden" name="pagoTD" value="<%=facturas.formatoDinero(pagoTD.toString())%>">

<%

double totalCremeria = 0.00;
double totalLiquido = 0.00;
double totalAbarrote = 0.00;

ResultSet rsType = facturas.damePorTipoProducto(fecha);
while (rsType.next()){
	if(rsType.getInt("genero") == 1){
		totalCremeria = rsType.getDouble("Pago");
	}
	else if(rsType.getInt("genero") == 2){
		totalLiquido = rsType.getDouble("Pago");
	}
	else if(rsType.getInt("genero") == 3){
		totalAbarrote = rsType.getDouble("Pago");
	}
}
rsType.close();
facturas.cierraConexion();
%>
<input type="hidden" name="totalCremeria" value="<%=facturas.formatoDinero(facturas.acortaLongitud(totalCremeria+""))%>">
<input type="hidden" name="totalLiquido" value="<%=facturas.formatoDinero(facturas.acortaLongitud(totalLiquido+""))%>">
<input type="hidden" name="totalAbarrote" value="<%=facturas.formatoDinero(facturas.acortaLongitud(totalAbarrote+""))%>">

  <h1>Venta del d&iacute;a por G&eacute;nero de Productos</h1>
  <table width="400" align="center" border="1" cellpadding="0" cellspacing="0">
  <tr>
  	<th>Productos de Cremer&iacute;a</th>
  	<th>Productos L&iacute;quidos</th>	
  	<th>Productos Abarrotes</th>
  </tr>
  <tr>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(facturas.acortaLongitud(totalCremeria+""))%></b></div></td>  
	<td><div align="right"><b>$<%=facturas.formatoDinero(facturas.acortaLongitud(totalLiquido+""))%></b></div></td>  
	<td><div align="right"><b>$<%=facturas.formatoDinero(facturas.acortaLongitud(totalAbarrote+""))%></b></div></td>  
  </tr>
  </table>

<p><table width="400" align="center">
	<tr>
    <td><div align="center"><a href="Menu_Consul_Ventas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></div></td>
	<td>
      <div align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="132" height="41" border="0"></a>			
	    </div></td>
	</tr>
</table></p>
</form>
		
<%	}   %>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>



