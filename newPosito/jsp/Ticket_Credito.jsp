<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>

<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" />

<html>
<head>
<title>Impresion Ticket</title>
<link href="ticketCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

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
	String pago = request.getParameter("elTotal");
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
	String fechaPago = request.getParameter("fechaPago");
	String rfc = request.getParameter("rfc");
	String nombre = request.getParameter("nombre");
	String usuario = request.getParameter("usuario");
%>
<table align="left" width="240" border="0" cellpadding="0" cellspacing="0" onClick="imprimirPagina()">
  <tr>
  	<th colspan="3">**** EL POSITO ****</th>
  </tr>
  <tr>
  	<td width="85" ><img src="imagenes/petitLogo.jpg" width="73" height="71"></td>
  	<td width="155" colspan="2">Pasillo 3 Letra I-J<br/>
Local 85<br/>
Central de Abasto, Iztapala <br/>
C.P. 09040 M&eacute;xico, D.F.<br />
Tel. 5694-7059</td>
  </tr>
  <tr>
  	<th  colspan="3">**** PAGARÉ / NO FISCAL ****</th>
  </tr>
  <tr>
  	<td colspan="3"><div align="center">*********************************************</div></td>
  </tr>
  <tr>
  	<td colspan="3">Gorgonio de la Cruz Bautista<br/>
RFC:CUBG-660909-S60<br/>
CURP:CUBG660909-HVZRTR09</td>
  </tr>
  <tr>
  	<td colspan="3"><div align="center">*******************************************</div></td>
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
		  	<th width="40%">Num. Ticket<br/>a Cr&eacute;dito</th>
			<th width="50%">Total Ticket<br/>a Cr&eacute;dito</th>
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
			<td width="50%"><div align="right">$ <%=credito.formatoDinero(credito.acortaLongitud(pago1))%></div></td>
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
			<td width="50%"><div align="right">$ <%=credito.formatoDinero(credito.acortaLongitud(pago2))%></div></td>
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
			<td width="50%"><div align="right">$ <%=credito.formatoDinero(credito.acortaLongitud(pago3))%></div></td>
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
			<td width="50%"><div align="right">$ <%=credito.formatoDinero(credito.acortaLongitud(pago4))%></div></td>
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
			<td width="50%"><div align="right">$ <%=credito.formatoDinero(credito.acortaLongitud(pago5))%></div></td>
		  	<td width="10%">&nbsp;</td>						
		  </tr>
		</table>
	</td>
  </tr>
<% } %>
  <tr>
  	<th colspan="3"><div align="center">********** P A G A R É  *********</div></th>
  </tr> 
  <tr>
  	<td colspan="3"><b>Debemos y pagaremos <br/>
  	incondicionalmente por este pagar&eacute;<br/>
  	a la &oacute;rden de: Gorgonio de la Cruz Bautista,<br/>
  	la cantidad de: </b></td>
  </tr>
  <tr bgcolor="#000000">
  	<td colspan="3"><font color="#FFFFFF"><b>>$ <%=pago%> < </b></font></td>
  </tr>
  <tr>
  	<td colspan="3"><b>Teniendo como d&iacute;a de vencimiento: </b></td>
  </tr> 
  <tr>
  	<td colspan="3"><b>> <%=fechaPago%> < </b></td>
  </tr>   
  <tr>
  	<td colspan="3" height="30">__________________________________</td>
  </tr>   
  <tr>
  	<td colspan="3">Cliente: <%=nombre%></td>	
  </tr>   
  <tr>
  	<td colspan="3">RFC: <%=rfc%></td>	
  </tr>   
  <tr>
  	<th colspan="3"><div align="center">********* P A G A R É  *********</div></th>
  </tr>   
</table>
</body>
</html>
