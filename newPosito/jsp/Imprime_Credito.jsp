<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" />

<html>
<head>
<title>Factura</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
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
	String totalCreditos = request.getParameter("totalCreditos");
	String totalCreditosV = request.getParameter("totalCreditosV");
	String totalCreditosE = request.getParameter("totalCreditosE");
	String fecha = request.getParameter("fecha");
	if(fecha.indexOf("%%") != -1){
		fecha = fecha.substring(0,(fecha.length()-3));
	}
%>
<table width="448" border="1" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <tr>
    <td width="259" align="center"><img src="imagenes/logoTienda.jpg" width="160" height="147">	</td>
    <th width="161" align="center"><font face="Eras Medium ITC" size="4" color="#000099">Corte de Créditos para la Fecha:<br/><br/><%=fecha%></font></th>	
  </tr>
  <tr >
    <th align="center"><strong>Monto Otorgado Clientes:</strong> </th>
    <td align="center"><div align="right"><strong>$<%=facturas.formatoDinero(totalCreditos)%></strong></div></td>	
  </tr>
  <tr >
    <th align="center"><strong>Monto Otorgado Empleados:</strong> </th>
    <td  align="center"><div align="right"><strong>$<%=facturas.formatoDinero(totalCreditosE)%></strong></div></td>	
  </tr>
  <tr>
    <th  align="center"><strong>Monto  Vencido:</strong>	</th>
    <td  align="center"><div align="right"><strong>$<%=facturas.formatoDinero(totalCreditosV)%></strong>	</div></td>
  </tr>  
</table>

</body>
</html>
