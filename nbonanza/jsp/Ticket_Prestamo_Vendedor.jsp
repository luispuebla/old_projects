<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" scope="page"/>

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
	String vencimiento = request.getParameter("vencimiento");
	String claveE = request.getParameter("claveE");
	String prestamo = request.getParameter("prestamo");
	String nombreVendedor = empleado.dameNombreUsuario(claveE);	
%>
<table align="left" width="240" border="0" cellpadding="0" cellspacing="0" onClick="imprimirPagina()">
  <tr>
  	<th colspan="3">**** LA NUEVA BONANZA ****</th>
  </tr>
  <tr>
  	<td width="85" ><img src="imagenes/petitLogo.jpg" width="73" height="69"></td>
  	<td width="155" colspan="2">Pasillo 5 Letra I-J<br/> Locales 86 y 87 <br/>
Central de Abasto, Iztapala <br/>
C.P. 09040 M&eacute;xico, D.F.<br />
Tel.5694 - 1066 </td>
  </tr>
  <tr>
  	<th  colspan="3">******** P A G A R É  ********</th>
  </tr>
  <tr>
  	<td colspan="3"><div align="center">*********************************************</div></td>
  </tr>
  <tr>
  	<td colspan="3">Iv&aacute;n Sa&uacute;l Cort&eacute;s Garc&iacute;a <br/>
RFC: COGI-720102-GZ9<br/>
CURP:CXGI720102HDFRRV02</td>
  </tr>
  <tr>
  	<td colspan="3"><div align="center">*******************************************</div></td>
  </tr> 
  <tr>
  	<th colspan="3"><div align="center">********** P A G A R É  *********</div></th>
  </tr> 
  <tr>
  	<td colspan="3"><b>Debo y cubrir&eacute; incondicionalmente <br/>
	a trav&eacute;s de mi sueldo percibido<br/> este pagar&eacute; a la &oacute;rden de:<br/> Iv&aacute;n Sa&uacute;l Cort&eacute;s Garc&iacute;a,<br/> por la cantidad de: </b></td>
  </tr>
  <tr bgcolor="#000000">
  	<td colspan="3"><font color="#FFFFFF"><b>>$ <%=empleado.formatoDinero(prestamo)%> < </b></font></td>
  </tr>
  <tr>
  	<td colspan="3"><b>Teniendo como d&iacute;a de descuento: </b></td>
  </tr> 
  <tr>
  	<td colspan="3"><b>> <%=vencimiento%> < </b></td>
  </tr>   
  <tr>
  	<td colspan="3" height="30">__________________________________</td>
  </tr>   
  <tr>
  	<td colspan="3">Vendedor: <%=empleado.dameNombreUsuario(claveE)%></td>	
  </tr>   
  <tr>
  	<td colspan="3" height="10">&nbsp;</td>	
  </tr>   
  <tr>
  	<th colspan="3"><div align="center">********* P A G A R É  *********</div></th>
  </tr>   
</table>
</body>
</html>
