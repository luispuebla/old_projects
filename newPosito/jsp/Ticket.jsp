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
	String pago = request.getParameter("pago");
	String PagoCliente = request.getParameter("PagoCliente");
	String cambio = request.getParameter("cambio");
	String fecha = request.getParameter("fecha");
	String ticket1 = request.getParameter("ticket1");
	String ticket2 = request.getParameter("ticket2");
	String ticket3 = request.getParameter("ticket3");
	String ticket4 = request.getParameter("ticket4");
	String ticket5 = request.getParameter("ticket5");
	String pago1 = request.getParameter("pago1");
	String pago2 = request.getParameter("pago2");
	String pago3 = request.getParameter("pago3");
	String pago4 = request.getParameter("pago4");
	String pago5 = request.getParameter("pago5");
	String usuario = request.getParameter("usuario");
%>
<table align="left" width="250" border="0" cellpadding="0" cellspacing="0" onClick="imprimirPagina()">
  <tr>
	<th colspan="3">***  EL POSITO ***</th>
  </tr>
  <tr>
  	<th width="107" rowspan="2"><div align="center"><img src="imagenes/petitLogo.jpg" width="73" height="71"></div></th>
  	<td colspan="2">Pasillo 3 Letra I-J<br/> 
  	Local 85<br/>
  	  Central de Abasto, <br/>Col. Iztapala <br/>
  	  C.P. 09040 M&eacute;xico, D.F.<br /> 
    Tel. 5694-7059</td>
  </tr>
  <tr>
  	<th  colspan="2">*** No Fiscal ***</th>
  </tr>
  <tr>
  	<td colspan="3"><div align="center">*********************************************</div></td>
  </tr>
  <tr>
  	<th>Usuario:</th>
	<td colspan="2"><%=usuario.toUpperCase()%></td>
  </tr>
  <tr>
  	<th>Fecha:</th>
	<td colspan="2"><%=fecha%></td>
  </tr>
  <tr>
  	<td colspan="3">
		<table cellpadding="0" cellspacing="0" width="240">
		  <tr>
		  	<th width="40%">Num. Ticket</th>
			<th width="50%">Total Ticket</th>
			<th width="10%">&nbsp;</th>			
		  </tr>
		</table>
	</td>
  </tr>  
<%if(!(ticket1.length() == 0)){%>
  <tr>
  	<td colspan="3">
		<table cellpadding="0" cellspacing="0" width="240">
		  <tr>
		  	<td width="40%"><div align="center"><%=ticket1%></div></td>
			<td width="50%"><div align="right">$ <%=ticket.formatoDinero(ticket.acortaLongitud(pago1))%></div></td>
		  	<td width="10%">&nbsp;</td>			
		  </tr>
		</table>
	</td>
  </tr>
<% } %>
<%if(!(ticket2.length() == 0)){%>
  <tr>
  	<td colspan="3">
		<table cellpadding="0" cellspacing="0" width="240">
		  <tr>
		  	<td width="40%"><div align="center"><%=ticket2%></div></td>
			<td width="50%"><div align="right">$ <%=ticket.formatoDinero(ticket.acortaLongitud(pago2))%></div></td>
		  	<td width="10%">&nbsp;</td>						
		  </tr>
		</table>
	</td>
  </tr>
<% } %>
<%if(!(ticket3.length() == 0)){%>
  <tr>
  	<td colspan="3">
		<table cellpadding="0" cellspacing="0" width="240">
		  <tr>
		  	<td width="40%"><div align="center"><%=ticket3%></div></td>
			<td width="50%"><div align="right">$ <%=ticket.formatoDinero(ticket.acortaLongitud(pago3))%></div></td>
		  	<td width="10%">&nbsp;</td>						
		  </tr>
		</table>
	</td>
  </tr>
<% } %>
<%if(!(ticket4.length() == 0)){%>
  <tr>
  	<td colspan="3">
		<table cellpadding="0" cellspacing="0" width="240">
		  <tr>
		  	<td width="40%"><div align="center"><%=ticket4%></div></td>
			<td width="50%"><div align="right">$ <%=ticket.formatoDinero(ticket.acortaLongitud(pago4))%></div></td>
		  	<td width="10%">&nbsp;</td>						
		  </tr>
		</table>
	</td>
  </tr>
<% } %>
<%if(!(ticket5.length() == 0)){%>
  <tr>
  	<td colspan="3">
		<table cellpadding="0" cellspacing="0" width="240">
		  <tr>
		  	<td width="40%"><div align="center"><%=ticket5%></div></td>
			<td width="50%"><div align="right">$ <%=ticket.formatoDinero(ticket.acortaLongitud(pago5))%></div></td>
		  	<td width="10%">&nbsp;</td>						
		  </tr>
		</table>
	</td>
  </tr>
<% } %>
  <tr>
  	<td colspan="3"><div align="center">--------------------------------------------------------</div></td>
  </tr> 
  <tr>
  	<th>Total:</th>
	<td width="119"><div align="right"><b>$ <%=ticket.formatoDinero(ticket.acortaLongitud(pago))%></b></div></td>
 	<td width="24">&nbsp;</td>				
  </tr>
  <tr bgcolor="#000000">
  	<th><font color="#FFFFFF">Pago:</font></th>
	<td><font color="#FFFFFF"><div align="right"><b>$ <%=ticket.formatoDinero(ticket.acortaLongitud(PagoCliente))%></b></div></font></td>
 	<td width="24">&nbsp;</td>					
  </tr>
  <tr bgcolor="#999999">
  	<th>Cambio:</th>
	<td><div align="right"><b>$ <%=ticket.formatoDinero(ticket.acortaLongitud(cambio))%></b></div></td>
 	<td width="24">&nbsp;</td>					
  </tr>
  <tr>
  	<td colspan="3"><div align="center">-----------------------------------------------------</div></td>
  </tr>   
  <tr>
  	<th colspan="3"> ¡Gracias por su compra!<br/>Vuelva pronto.</th>
  </tr>
</table>
</body>
</html>
