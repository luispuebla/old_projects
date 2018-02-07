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
	String [] ArrayNumTicket = (String[])request.getParameterValues("numTicket");
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
	ResultSet rs = cliente.datos_Cliente_N(rfc,nombre);
%>
<div id="Layer1" style="position:absolute; left:518px; top:201px; width:128px; height:23px; z-index:1">
<table cellpadding="0" cellspacing="0" width="115" align="center">
  <tr>
  	<th width="39"><div align="center"><%=diaFac %></div></th>
  	<th width="38"><div align="center"><%=mesFac %></div></th>
  	<th width="36"><div align="right"><%=anioFac %></div></th>
  </tr>
</table>
</div>
<table width="750" height="147" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <tr>
  	<td width="20">&nbsp;</td>
  	<td width="430">&nbsp;</td>
  </tr>
</table>
<%		
	while (rs.next()) {  
%>
<table width="750" border="0" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <tr height="19"> 
  	<th width="55">&nbsp;</th>  
    <th width="449"><div align="left"><%= rs.getString("nombre")%></div></th>
    <td width="30">&nbsp;</td>
    <th valign="bottom" width="216"><div align="center"><%= rs.getString("rfc").toUpperCase()%></div></th>	
  </tr>
</table>
<table width="750" border="0" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <tr valign="middle" height="32"> 
	<!-- Ajuste lateral -->
  	<td width="70">&nbsp;</td>  
    <td width="587" colspan="5"><div align="left"><%=rs.getString("direccion")%> <%if (rs.getString("delegacion").length() >1) {%>, Del.  <%=rs.getString("delegacion")%><%} if(rs.getString("colonia").length() > 1){ %>, Col. <%=rs.getString("colonia")%><%}%></div></td>
	<td width="93">&nbsp;</td>	
  </tr>
</table>  
<table width="750" border="0" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">  
  <tr valign="bottom">
  	<td width="51">&nbsp;</td>  
    <th width="79"><div align="center"><%=rs.getString("cp") %></div></th>
    <td width="32" >&nbsp;</td>
    <td width="128"><div align="center"><%=rs.getString("ciudad")%></div></td>  
    <td width="58" >&nbsp;</td>
    <td width="155"><div align="center"><%=rs.getString("CURP") %></div></td>
    <td width="247" >&nbsp;</td>	
  </tr>
</table>
<%	      
	} 
	rs.close(); 
	cliente.cierraConexion(); 
	rs = factura.dameListadoTicketsFac(ArrayNumTicket);	
%>
<table width="750" onClick="imprimirPagina();" cellpadding="0" cellspacing="0">
  <tr height="33">
  	<td width="26">&nbsp;</td>  
    <td colspan="7" >&nbsp;</td>
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
			}%>
			
  <tr height="20">
  	<td width="30">&nbsp;</td>  
	<td width="59"><table cellpadding="0" cellspacing="0" width="100%"><tr><td width="57%" align="right"><div class="petit"><%=cantidad%></div></td><td width="43%" align="left"><%=tipoP%></td></tr></table></td>
	<td width="11">&nbsp;</td>
	<td width="380"><div align="left"><%=nombreProducto.toLowerCase()%> </div></td>						
<%			if(rs.getInt("gravaIVA") == 0){
				contadorInterno++;	
				tasa0 += rs.getDouble("precioAPagar"); %>		
			    <td width="75"><div align="right"><%= factura.formatoDinero(rs.getString("precioVenta"))%></div></td>
				<td width="85"> <div align="right"><%= factura.formatoDinero(rs.getString("precioAPagar"))%></div></td>
				<td width="85">&nbsp;</td>
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
			    <td width="75"><div align="right"><%= factura.formatoDinero(precioProducto.toString())%></div></td>
				<td width="85">&nbsp;</td>
				<td width="85"><div align="right"><%= factura.formatoDinero(precioTotalP.toString())%></div></td>
			  </tr>								
<%			}
		} // Cierro limite contador
	}//Cierro ResultSet
	factura.cierraConexion();
	total = total.setScale(2, RoundingMode.HALF_UP);		
%>
</table>
<table width="750" onClick="imprimirPagina();" cellpadding="0" cellspacing="0" >
<%
	while (contadorInterno<28) {
%>
  <tr height="20">
  	<td width="20">&nbsp;</td>  
  	<td width="430">&nbsp;</td>		
  </tr>
<% 		
		contadorInterno ++; 
	} 
%>	
</table>

<table width="750" border="0" cellpadding="0" cellspacing="0" onClick="imprimirPagina();">
  <tr height="63" valign="middle">
  <td width="18">&nbsp;</td>
  	<th width="543" valign="middle"><%=convertidor.convertirLetras(Integer.parseInt(convertidor.dameEnteros(total.toString())))+" pesos "+convertidor.dameDecimales(convertidor.acortaLongitud(total.toString()))+"/100 m.n."%>	
</th>
	<td width="187">&nbsp;</td>	
  </tr>
</table>
<table width="750" border="0" cellpadding="0" cellspacing="0" onClick="imprimirPagina();">
  <tr height="19"> 
	<td width="566">&nbsp;</td>	 
	<th width="85"><div align="right"><%=factura.formatoDinero(factura.acortaLongitud(tasa0+""))%></div></th>
	<th width="85"><div align="right"><%=factura.formatoDinero(factura.acortaLongitud(tasa15+""))%></div></th>
	<th width="14">&nbsp;</th>	
  </tr>	
  <tr height="36"> 
  	<td colspan="2">&nbsp;</td>    
	<th><div align="right"><%=factura.formatoDinero(factura.acortaLongitud(iva+""))%></div></th>
	<th>&nbsp;</th>		
  </tr>	
  <tr height="35"> 
  	<td colspan="2">&nbsp;</td>    
	<th><div align="right"><%=factura.formatoDinero(total.toString())%></div></th>
	<th>&nbsp;</th>		
  </tr>	
</table>
</body>
</html>
