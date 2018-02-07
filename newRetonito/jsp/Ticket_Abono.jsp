<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" />

<html>
<head>
<title>Impresion Ticket</title>
<link href="ticketCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

function Cerrar() {
	parent.close(); 
}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0" onLoad="imprimirPagina(); Cerrar()">
<%
	String rfc = request.getParameter("rfc");
	String nombreCliente = request.getParameter("nombreCliente");
	String importe = request.getParameter("importe");
	String formaPago = request.getParameter("formaPago");
	String referenciaC = request.getParameter("referenciaC");
	String usuario = request.getParameter("usuario");
%>
<table align="left" width="250" border="0" cellpadding="0" cellspacing="0" onClick="imprimirPagina()">
  <tr>
	<th colspan="3">***  EL RETO&Ntilde;ITO ***</th>
  </tr>
  <tr>
  	<th width="107" rowspan="2"><div align="center"><img src="imagenes/petitLogo.jpg" width="73" height="71"></div></th>
  	<td colspan="2">Pasillo 3 Letra I-J<br/>
Local 82<br/>
  	  Central de Abasto, <br/>Col. Iztapala <br/>
  	  C.P. 09040 M&eacute;xico, D.F.<br /> 
    Tel.  5600-2607</td>
  </tr>
  <tr>
  	<th  colspan="2">** Pago Abono**</th>
  </tr>
  <tr>
  	<td colspan="3"><div align="center">*********************************************</div></td>
  </tr>
  <tr>
  	<th>RFC:</th>
	<td colspan="2"><%=rfc.toUpperCase()%></td>
  </tr>
  <tr>
  	<th>Cliente:</th>
	<td colspan="2"><%=nombreCliente.toUpperCase()%></td>
  </tr>
  <tr>
  	<th>Usuario:</th>
	<td colspan="2"><%=usuario.toUpperCase()%></td>
  </tr>
  <tr>
  	<td colspan="3"><div align="center">--------------------------------------------------------</div></td>
  </tr> 
  <tr>
  	<th>Total:</th>
	<td width="119"><div align="right"><b>$ <%=ticket.formatoDinero(ticket.acortaLongitud(importe))%></b></div></td>
 	<td width="24">&nbsp;</td>				
  </tr>
  <tr>
  	<th colspan="3"> ¡Gracias por su abono!<br/>Vuelva pronto.</th>
  </tr>
</table>
</body>
</html>
