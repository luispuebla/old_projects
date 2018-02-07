<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="error.jsp" %>
<jsp:useBean id="convertidor" class="com.alpha.bd.n2t" />
<jsp:useBean id="factura" class="com.alpha.bd.ManagerFacturacion" />
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" />

<html>
<head>
<title>Factura</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="FacCSS.css" rel="stylesheet" type="text/css">
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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>
  
<body onLoad="imprimirPagina(); Cerrar()">
<% 
	String rfc = request.getParameter("rfc");
	String nombre = request.getParameter("nombre");
	String ticket1 = request.getParameter("ticket1");
	String ticket2 = request.getParameter("ticket2");
	String ticket3 = request.getParameter("ticket3");
	String ticket4 = request.getParameter("ticket4");
	String ticket5 = request.getParameter("ticket5");      
	String fechaFactura = request.getParameter("fechaFac");
	double tasa0 = 0.00;
	double tasa15 = 0.00;
	double iva = 0.00;
	double subD = 0.00;	
	BigDecimal total = new BigDecimal("0.00");
	int primerProducto = factura.cambiaAInt(factura.dameEnteros(request.getParameter("primerProducto")));
	int ultimoProducto = factura.cambiaAInt(factura.dameEnteros(request.getParameter("ultimoProducto")));
	boolean conIva = false;	
	String diaFac = fechaFactura.substring(3,5);
	String mesFac = fechaFactura.substring(0,2);
	String anioFac = fechaFactura.substring(6,10);
	BigDecimal porcentajeIva = new BigDecimal("115.00");
	BigDecimal porcentajeNeto = new BigDecimal("100.00");
%>
<table width="470" onClick="imprimirPagina();" cellpadding="0" cellspacing="0" align="center">
  <tr>
	<!-- Ajuste lateral -->
	<td width="0" ></td>
	<td rowspan="4" height="165">&nbsp;</td>
	<td colspan="3" >&nbsp;</td>
  </tr>
</table>
<table width="470" onClick="imprimirPagina();"  align="center">
<%
	ResultSet rs = cliente.datos_Cliente_N(rfc,nombre);
	while (rs.next()){  
%>	
  <tr>
	<!-- Ajuste lateral -->
	<td width="15" height="25">&nbsp;</td>  
    <td colspan="4"><div align="center"><%=rs.getString("nombre").toUpperCase()%></div></td>
	<td width="5" >&nbsp;</td>  	
  </tr>
  <tr>
	<!-- Ajuste lateral -->
	<td height="20">&nbsp;</td>  
    <td valign="bottom"><div align="center"><%=rs.getString("rfc").toUpperCase()%></div></td>
	<td width="55"><div align="center"><%=diaFac%></div></td>
	<td width="55"><div align="center"><%=mesFac%></div></td>
	<td width="30"><div align="center"><%=anioFac%></div></td>			
	<td>&nbsp;</td>  	
  </tr>
  <tr>
	<td height="26">&nbsp;</td>  
    <td valign="bottom"><div align="left"><%=rs.getString("direccion").toLowerCase()%> <%if (rs.getString("delegacion").length() >1) {%>, Del.  <%=rs.getString("delegacion").toLowerCase()%><%} %></div></td>
	<td colspan="3">&nbsp;</td>  		
	<td>&nbsp;</td>  	
  </tr>
  <tr>
	<td height="26">&nbsp;</td>  
    <td valign="middle"><%if(rs.getString("colonia").length() > 1){ %>Col. <%=rs.getString("colonia").toLowerCase()%><%}%>, <%=rs.getString("cp")%>, <%=rs.getString("ciudad")%>, </div></td>
	<td colspan="3">&nbsp;</td>  		
	<td>&nbsp;</td>  	
  </tr>
<% }  // Cierre ResultSet Datos Cliente
	rs.close(); 
	cliente.cierraConexion(); 
	rs = factura.dameListadoTicketsFac(ticket1, ticket2, ticket3, ticket4, ticket5);
%>  
</table>
<table width="470" onClick="imprimirPagina();" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td colspan="5" height="27">&nbsp;</td>
  </tr>
<%		
	int contador = 0;	
	int contadorInterno = 0;
	while(rs.next()){
		contador ++;
		if((contador >= primerProducto) && (contador <= ultimoProducto)){
			total = total.add(new BigDecimal(rs.getString("precioAPagar")));		
			String nombreProducto = rs.getString("descripcion");
			if(nombreProducto.length() > 35){
				nombreProducto = nombreProducto.substring(0,35);
			}
			String tipoP = "Kg.";
			String cantidad = rs.getString("cantidadProducto");
			if(rs.getInt("tipoVenta") == 2){			
				tipoP = "Uni.";
				cantidad = rs.getInt("cantidadProducto")+"";
			}
			else if(rs.getInt("tipoVenta") == 3){
				tipoP = "Cj.";
				cantidad = factura.formatoMaxUnDecimal(cantidad);
			}
			else if(rs.getInt("tipoVenta") == 4){
				tipoP = "Pz.";
				cantidad = factura.formatoMaxUnDecimal(cantidad);
				nombreProducto = "("+factura.formatoDinero(rs.getString("pesoEnPz"))+" Kg.) "+nombreProducto;
			}%>
			  <tr>
				<td width="12" height="20">&nbsp;</td>   
				<td width="55"><table cellpadding="0" cellspacing="0" width="100%"><tr><td width="57%" align="right"><div class="petit"><%=cantidad%></div></td><td width="43%" align="left"><%=tipoP%></td></tr></table></td>
				<td><%=nombreProducto.toLowerCase()%></td>
			
<%			if(rs.getInt("gravaIVA") == 0){
				contadorInterno++;	
				tasa0 += rs.getDouble("precioAPagar"); %>		
			    <td width="80"><div align="right"><%= factura.formatoDinero(rs.getString("precioVenta"))%></div></td>
				<td width="100"> <div align="right"><%= factura.formatoDinero(rs.getString("precioAPagar"))%></div></td>
				<td width="5">&nbsp;</td>
			  </tr>
				
<%			}
			else{
				BigDecimal precioOriginalConIVA = new BigDecimal(rs.getString("precioAPagar"));
				BigDecimal precioProducto = new BigDecimal(rs.getString("precioVenta"));
				precioProducto = precioProducto.multiply(porcentajeNeto);
				precioProducto = precioProducto.divide(porcentajeIva, new MathContext(100));
				precioProducto = precioProducto.setScale(2, RoundingMode.HALF_UP);			
				BigDecimal precioTotalP = new BigDecimal(rs.getString("precioAPagar"));
				precioTotalP = precioTotalP.multiply(porcentajeNeto);
				precioTotalP = precioTotalP.divide(porcentajeIva, new MathContext(100));
				precioOriginalConIVA = precioOriginalConIVA.subtract(precioTotalP);				
				precioTotalP = precioTotalP.setScale(2, RoundingMode.HALF_UP);
				precioOriginalConIVA = precioOriginalConIVA.setScale(2, RoundingMode.HALF_UP);				
				tasa15 += factura.cambiaADouble(precioTotalP.toString());
				iva += factura.cambiaADouble(precioOriginalConIVA.toString());				
				contadorInterno++; %>
			    <td width="80"><div align="right"><%= factura.formatoDinero(precioProducto.toString())%></div></td>
				<td width="100">&nbsp;</td>
				<td width="5"><div align="right"><%= factura.formatoDinero(precioTotalP.toString())%></div></td>
			  </tr>								
<%			}
		} // Cierro limite contador
	}//Cierro ResultSet
	factura.cierraConexion();
	total = total.setScale(2, RoundingMode.HALF_UP);		
	subD = tasa0 + tasa15;
%>
</table>
<table width="470" onClick="imprimirPagina();" cellpadding="0" cellspacing="0" align="center">
<%
	while (contadorInterno<15) {
%>
  <tr>
	<td height="20">&nbsp;</td>
  </tr>
<% 		
		contadorInterno ++; 
	} 
%>	
</table>
<table width="470" onClick="imprimirPagina();"  align="center" cellpadding="0" cellspacing="0">
<tr valign="top">
	<td width="130" rowspan="3">&nbsp;</td>
	<td width="136" rowspan="3"><div align="center"><%=convertidor.convertirLetras(Integer.parseInt(convertidor.dameEnteros(total.toString())))+" pesos  "+convertidor.dameDecimales(convertidor.acortaLongitud(total.toString()))+"/100 m.n."%></div></td>
	<td width="27" rowspan="3">&nbsp;</td>
	<td width="160" height="13" valign="top"><div align="right"><%=factura.formatoDinero(factura.acortaLongitud(subD+""))%></div></td>
	<td width="15" rowspan="3">&nbsp;</td>	
  </tr>  
  <tr>
  	<!-- Ajuste lateral -->
	<td height="19" valign="top"><div align="right"><%=factura.formatoDinero(factura.acortaLongitud(iva+""))%></div></td>
  </tr>
  <tr>
  	<!-- Ajuste lateral -->
	<td height="19" valign="top"><div align="right"><%=factura.formatoDinero(total.toString())%></div></td>
  </tr>    
</table>
</body>
</html>
