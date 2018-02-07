<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="vendedores" class="com.alpha.bd.ManagerVendedores" scope="page" />
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" scope="page" />

<html>
<head>
<title>Impresi&oacute;n Corte</title>
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

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>
  
<body>
<% 
	String fecha = request.getParameter("fecha");
	String ticketCobroP = request.getParameter("ticketCobroP");
	String ticketCobroU = request.getParameter("ticketCobroU");
	String ticketCredP = request.getParameter("ticketCredP");
	String ticketCredU = request.getParameter("ticketCredU");
	String totalRetono = request.getParameter("totalRetono");
	String totalCremeria = request.getParameter("totalCremeria");
	String totalLiquido = request.getParameter("totalLiquido");
	String totalAbarrote = request.getParameter("totalAbarrote");
	String pagoEfectivo = request.getParameter("pagoEfectivo");
	String pagoCheque = request.getParameter("pagoCheque");
	String pagoTransferencia = request.getParameter("pagoTransferencia");
	String pagoTC = request.getParameter("pagoTC");
	String pagoTD = request.getParameter("pagoTD");
	String abonos = request.getParameter("abonos");
	if(fecha.indexOf("%%") != -1){
		fecha = fecha.substring(0,(fecha.length()-3));
	}
%>
<table width="510" border="1" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <tr>
    <td width="100" align="center"><img src="imagenes/logoTienda.jpg" width="160" height="147">
	</td>
    <td width="410"align="center"><font face="Eras Medium ITC" size="4" color="#000099">Corte de Caja con Fecha:
	<div align="center"><%=fecha%></div></font>
	</td>	
  </tr>
</table>
<br  />
<table width="555" border="1" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
<caption>Tickets Cobrados</caption>
  <tr>
  	<th width="351">Tickets Directos Cobrados (Primero - &Uacute;ltimo) : </th>
	<td width="198"><div align="center"><b><%=ticketCobroP%> - <%=ticketCobroU%></b></div></td>
  </tr>
  <tr>
  	<th>Tickets A Cr&eacute;dito Cobrados (Existencia): </th>
	<td><div align="center"><b><%=ticketCredP%></b></div></td>
  </tr>
</table>
<br/>
<table width="525" border="1" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <caption>
  Total recuperado por Usuario (No Abono):
  </caption>
  <tr>
  	<th width="340">Usuario</th>
	<th width="179"><b>Total</b></th>	
  </tr>
<%
	ResultSet rs = facturas.dameTotalesCorteTodos(fecha);
	while(rs.next()){
		String usuario = rs.getString("usuario");	
		if(facturas.cambiaAInt(usuario) != 0){
			usuario = vendedores.dameNombreUsuario(usuario);
		} %>		
		<tr>
		  <td><div align="center"><%=usuario%></div></td>
		  <td><div align="right">$ <%=facturas.formatoDinero(rs.getString("Total"))%></div></td>
		</tr>
		
<%	}
	rs.close();
	facturas.cierraConexion();
%>	  
</table>
<%	rs = facturas.dameTotalesCorteAbonos(fecha); %>
<br/>
<table align="center" border="1"  cellpadding="0" cellspacing="0" width="525" onClick="imprimirPagina();">
<caption>
Recibido por Abonos ordenado por Usuario:
</caption>
<tr>
	<th width="342">Usuario:</th>
	<th width="177">Total:</th>
</tr>
<%while(rs.next()){%>
<tr>
	<td><div align="center"><%=rs.getString("cobro")%></div></td>
	<td><div align="right">$<%=facturas.formatoDinero(rs.getString("total"))%></div></td>	
</tr>
<%	} 
	rs.close();
	facturas.cierraConexion();%>
</table>
<br  />
<table align="center" border="1" cellpadding="0" cellspacing="0" onClick="imprimirPagina();" width="360">
  <caption>Entrada por tipo de Producto:</caption>
  <tr>
  	<th colspan="2">Producto Cremeria:</th>
	<td width="146" colspan="2"><div align="right"><strong>$ <%=totalCremeria%></strong></div></td>
  </tr>
  <tr>
  	<th colspan="2">Producto L&iacute;quido:</th>
	<td colspan="2"><div align="right"><strong>$ <%=totalLiquido%></strong></div></td>
  </tr>
  <tr>
  	<th colspan="2">Producto Abarrote: </th>
	<td colspan="2"><div align="right"><strong>$ <%=totalAbarrote%></strong></div></td>
  </tr>
</table>
<br />
<table align="center" border="1" cellpadding="0" cellspacing="0" onClick="imprimirPagina();" width="360">
  <caption>Corte Total:</caption>
  <tr>
  	<th colspan="2"> Total Efectivo:</th>
	<td width="146" colspan="2"><div align="right"><b>$ <%=pagoEfectivo%></b></div></td>
  </tr>
  <tr>
  	<th colspan="2"> Total Cheque:</th>
	<td width="146" colspan="2"><div align="right"><b>$ <%=pagoCheque%></b></div></td>
  </tr>
  <tr>
  	<th colspan="2"> Total Transferencia:</th>
	<td width="146" colspan="2"><div align="right"><b>$ <%=pagoTransferencia%></b></div></td>
  </tr>
  <tr>
  	<th colspan="2"> Total T.Cr&eacute;dito:</th>
	<td width="146" colspan="2"><div align="right"><b>$ <%=pagoTC%></b></div></td>
  </tr>
  <tr>
  	<th colspan="2"> Total T.D&eacute;bito:</th>
	<td width="146" colspan="2"><div align="right"><b>$ <%=pagoTD%></b></div></td>
  </tr>
  <tr>
  	<th colspan="2" height="35"> GRAN TOTAL:</th>
	<td width="146" colspan="2"><div align="right"><font size="4"><strong>$ <%=totalRetono%></strong></font></div></td>
  </tr>
</table>

</body>
</html>
