<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Muestra Consulta Facturas en Tiempo por Proveedor</title>
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
	String fechaHoy = alCom.dameFechaHoy();	
%>
<jsp:setProperty name="alCom" property="fechaInicial" value="<%=fechaInicial%>"/>
<jsp:setProperty name="alCom" property="fechaFinal" value="<%=fechaFinal%>"/>
<h1>Al d&iacute;a de hoy (<%=fechaHoy%>), Facturas registradas <br/>en el Rango de Tiempo comprendido entre: <br /> <%=fechaInicial%> al <%=fechaFinal%>:</h1>
<table width="700" border="1" align="center" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <tr>
	<th width="81">Fecha<br/>en<br/>Factura</th>	  	
	<th width="79">Factura<br/>No.</th>
	<th width="81">RFC</th>	
	<th width="154">Proveedor</th>		
	<th width="73">Tasa 0%</th>
	<th width="73">Tasa 15%</th>
 	<th width="64">Iva</th>
 	<th width="77">Total</th>	
 </tr>
  <%
	  BigDecimal sigmaTasa0 = new BigDecimal("0.00");
	  BigDecimal sigmaTasa15 = new BigDecimal("0.00");
	  BigDecimal sigmaIva = new BigDecimal("0.00");
	  BigDecimal sigmaTotal = new BigDecimal("0.00");
	  BigDecimal sumaTasa0 = new BigDecimal("0.00");
	  BigDecimal sumaTasa15 = new BigDecimal("0.00");
	  BigDecimal sumaIva = new BigDecimal("0.00");
	  BigDecimal sumaTotal = new BigDecimal("0.00");
	  String docAval = "";
	  String claveProveedor = "";
	  String nombreProveedor = "";
	  String fechaEnFac = "";
	  boolean primerEntrada = true;
	  ResultSet rs = alCom.facturasComprasXTiempo(fechaInicial,fechaFinal);  
	  while (rs.next()){
		if(primerEntrada){
			primerEntrada = false;
			docAval = rs.getString("docPadre");
			claveProveedor = rs.getString("claveProveedor");
			nombreProveedor = rs.getString("nombre");
			fechaEnFac = rs.getString("fechaDoc");
		}
		if(rs.getString("docPadre").equalsIgnoreCase(docAval)  && rs.getString("claveProveedor").equalsIgnoreCase(claveProveedor)){
			if(rs.getInt("gravaIVA") == 0){
				sumaTasa0 = sumaTasa0.add((new BigDecimal(rs.getString("Costo"))));
				sumaTotal = sumaTotal.add(new BigDecimal(rs.getString("Costo")));
				sigmaTasa0 = sigmaTasa0.add(new BigDecimal(rs.getString("Costo")));		
				sigmaTotal = sigmaTotal.add(new BigDecimal(rs.getString("Costo")));
			}
			else{
				BigDecimal impuesto = new BigDecimal("1.15");
				BigDecimal impuesto2 = new BigDecimal("0.15");
				sumaTasa15 = sumaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sumaIva = sumaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sumaTotal = sumaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTasa15 = sigmaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sigmaIva = sigmaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTotal = sigmaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));		
			}		
		}
		else{ 
			sumaTasa0 = sumaTasa0.setScale(2, RoundingMode.HALF_UP);
			sumaTasa15 = sumaTasa15.setScale(2, RoundingMode.HALF_UP);
			sumaIva = sumaIva.setScale(2, RoundingMode.HALF_UP);
			sumaTotal = sumaTotal.setScale(2, RoundingMode.HALF_UP);  	%>
	<tr>
		<td><div align="center"><%=fechaEnFac%></div></td>	  	
		<td><div align="center"><%=docAval%></div></td>
		<td><div align="center"><%=claveProveedor%></div></td>	
		<td><div align="center"><%=nombreProveedor%></div></td>		
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa0.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa15.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaIva.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTotal.toString())%></div></td>	
	</tr>	
<%	
			docAval = rs.getString("docPadre");
			claveProveedor = rs.getString("claveProveedor");
			nombreProveedor = rs.getString("nombre");
			fechaEnFac = rs.getString("fechaDoc");
			sumaTasa0 = new BigDecimal("0.00");
			sumaTasa15 = new BigDecimal("0.00");
			sumaIva = new BigDecimal("0.00");
			sumaTotal = new BigDecimal("0.00");
			if(rs.getInt("gravaIVA") == 0){
				sumaTasa0 = sumaTasa0.add(new BigDecimal(rs.getString("Costo")));
				sumaTotal = sumaTotal.add(new BigDecimal(rs.getString("Costo")));
				sigmaTasa0 = sigmaTasa0.add(new BigDecimal(rs.getString("Costo")));		
				sigmaTotal = sigmaTotal.add(new BigDecimal(rs.getString("Costo")));
			}
			else{
				BigDecimal impuesto = new BigDecimal("1.15");
				BigDecimal impuesto2 = new BigDecimal("0.15");
				sumaTasa15 = sumaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sumaIva = sumaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sumaTotal = sumaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTasa15 = sigmaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sigmaIva = sigmaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTotal = sigmaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));		
			}		
		}  
	}// Cierro While
	rs.close();
	alCom.cierraConexion();
	%>
	<tr>
		<td><div align="center"><%=fechaEnFac%></div></td>	  	
		<td><div align="center"><%=docAval%></div></td>
		<td><div align="center"><%=claveProveedor%></div></td>	
		<td><div align="center"><%=nombreProveedor%></div></td>		
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa0.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa15.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaIva.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTotal.toString())%></div></td>	
	</tr>	
<%	
	sigmaTasa0 = sigmaTasa0.setScale(2, RoundingMode.HALF_UP);
	sigmaTasa15 = sigmaTasa15.setScale(2, RoundingMode.HALF_UP);
	sigmaIva = sigmaIva.setScale(2, RoundingMode.HALF_UP);
	sigmaTotal = sigmaTotal.setScale(2, RoundingMode.HALF_UP);  
%>  
  <tr>
  	<th colspan="4">TOTALES</th>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaTasa0.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaTasa15.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaIva.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaTotal.toString())%></b></div></td>			
  </tr>
</table>
</body>
</html>
