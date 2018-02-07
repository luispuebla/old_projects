<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" scope="page" />

<html>
<head>
<title>Muestra Consulta Facturas en Tiempo por Cliente</title>
<link href="baseMiniCSS.css" rel="stylesheet" type="text/css">

<script>
<!--
function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

-->
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String fechaInicial = request.getParameter("fechaInicial");
	String fechaFinal = request.getParameter("fechaFinal");
%>
<h1>Facturas del <%=fechaInicial%> al <%=fechaFinal%></h1>
<table width="755" border="1" align="center" cellpadding="0" cellspacing="0" onClick="imprimirPagina()">
  <tr>
	<th width="76">Fecha<br/>en<br/>Factura</th>	  	
	<th width="78">Factura<br/>No.</th>
	<th width="93">RFC</th>	
	<th width="158">Cliente</th>		
	<th width="82">Tasa 0%</th>
	<th width="79">Tasa 15%</th>
 	<th width="77">Iva</th>
 	<th width="94">Total</th>	
 </tr>
  <%
  ResultSet rs = facturas.dameFacturasXTiempo(fechaInicial,fechaFinal);
  BigDecimal sumaTasa0 = new BigDecimal("0.00");
  BigDecimal sumaTasa15 = new BigDecimal("0.00");
  BigDecimal sumaIva = new BigDecimal("0.00");
  BigDecimal sumaTotal = new BigDecimal("0.00");      
  while (rs.next()){
  	BigDecimal temporal = new BigDecimal(rs.getString("tasa0"));
	sumaTasa0 = sumaTasa0.add(temporal);
  	temporal = new BigDecimal(rs.getString("tasa15"));
	sumaTasa15 = sumaTasa15.add(temporal);
  	temporal = new BigDecimal(rs.getString("iva"));
	sumaIva = sumaIva.add(temporal);
  	temporal = new BigDecimal(rs.getString("total"));
	sumaTotal = sumaTotal.add(temporal);	
%>
  <tr>
	<td><div align="center"><%=rs.getString("fechaFac")%></div></td>	  	
	<td><div align="center"><%=rs.getString("numFactura")%></div></td>
	<td><div align="center"><%=rs.getString("RFC")%></div></td>	
	<td><%=rs.getString("nombre")%></td>		
	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("tasa0"))%></div></td>
	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("tasa15"))%></div></td>
 	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("iva"))%></div></td>
 	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("total"))%></div></td>	
  </tr>
<%  
  }
	if(rs != null){
		rs.close();
	}		
	facturas.cierraConexion();	
	sumaTasa0 = sumaTasa0.setScale(2, RoundingMode.HALF_UP);
	sumaTasa15 = sumaTasa15.setScale(2, RoundingMode.HALF_UP);
	sumaIva = sumaIva.setScale(2, RoundingMode.HALF_UP);
	sumaTotal = sumaTotal.setScale(2, RoundingMode.HALF_UP);    
%>  
  <tr>
  	<th colspan="4">TOTALES:</th>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(sumaTasa0.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(sumaTasa15.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(sumaIva.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(sumaTotal.toString())%></b></div></td>			
  </tr>
</table>
</body>
</html>
