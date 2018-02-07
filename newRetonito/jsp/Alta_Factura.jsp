<%@ page language="java" import="java.sql.*, java.io.*, java.math.*"%>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" scope="page" />
<jsp:useBean id="factura" class="com.alpha.bd.ManagerFacturacion" scope="page" />

<html>
<head>
<title>Detalle de Factura por Cliente</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

function MandaSubmit(f){	
	f.submit();
}

//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 				
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = request.getParameter("rfc");
	String fecha1 = request.getParameter("fecha1");
	String fecha2 = request.getParameter("fecha2");
	String fecha3 = request.getParameter("fecha3");
	String fecha4 = request.getParameter("fecha4");
	String fecha5 = request.getParameter("fecha5");				
	String ticket1 = request.getParameter("ticket1");
	String ticket2 = request.getParameter("ticket2");
	String ticket3 = request.getParameter("ticket3");
	String ticket4 = request.getParameter("ticket4");
	String ticket5 = request.getParameter("ticket5");			
	String nombre = request.getParameter("nombre");
	ResultSet rs = null;
	double subTotal = 0.00;	
	double total = 0.00;
	double iva = 0.00;
	BigDecimal porcentajeIva = new BigDecimal("115.00");
	BigDecimal porcentajeNeto = new BigDecimal("100.00");
	String formatoFac = "1";
	if(request.getParameter("formatoFac") != null){
		formatoFac = request.getParameter("formatoFac");
	}
%>
<form name="FInterno" action="Alta_Factura.jsp" method="post" target="_self">
<table width="350" border="1" align="center">
  <caption>TIPO DE FACTURA</caption>
	<tr> 
		<th>Globalizada</th>
		<th>Desglozada</th>
	</tr>
	<tr> 
		<td><div align="center"><input name="formatoFac" type="radio" value="1" <%if (formatoFac.equals("1")){%>checked<%}%> onClick="MandaSubmit(document.forms[0])"></div></td>
		<td><div align="center"><input name="formatoFac" type="radio" value="2" <%if (formatoFac.equals("2")){%>checked<%}%> onClick="MandaSubmit(document.forms[0])"></div></td>
	</tr>
</table>	
<input type="hidden" name="rfc" value="<%=rfc%>">
<input type="hidden" name="fecha1" value="<%=fecha1%>">
<input type="hidden" name="fecha2" value="<%=fecha2%>">
<input type="hidden" name="fecha3" value="<%=fecha3%>">
<input type="hidden" name="fecha4" value="<%=fecha4%>">
<input type="hidden" name="fecha5" value="<%=fecha5%>">
<input type="hidden" name="ticket1" value="<%=ticket1%>">
<input type="hidden" name="ticket2" value="<%=ticket2%>">
<input type="hidden" name="ticket3" value="<%=ticket3%>">
<input type="hidden" name="ticket4" value="<%=ticket4%>">
<input type="hidden" name="ticket5" value="<%=ticket5%>">
<input type="hidden" name="nombre" value="<%=nombre%>">
</form>


<h1>Datos del Cliente:</h1>
<form name="form1" method="post" target="_self" action="Num_Factura.jsp" >
<table width="650" border="1">
	<tr> 
		<th width="94">RFC</th>
		<th width="110">Nombre</th>
		<th width="96">Dirección</th>
		<th width="113">Colonia</th>
		<th width="116">Delegación</th>
		<th width="81">Código Postal</th>
	</tr>
<%		
	rs = cliente.datos_Cliente_N(rfc, nombre);		
	while (rs.next()) {  
%>
	<tr> 
		<td><div align="center"><%= rs.getString("rfc") %> </div></td>
		<td><div align="center"><%= rs.getString("nombre") %> </div></td>
		<td><div align="center"><%= rs.getString("direccion") %> </div></td>
		<td><div align="center"><%= rs.getString("colonia") %> </div></td>
		<td><div align="center"><%= rs.getString("delegacion") %> </div></td>
		<td><div align="center"><%= rs.getString("cp") %> </div></td>
	</tr>
<% }
	rs.close();
	cliente.cierraConexion();
%>
</table>
<p>&nbsp;</p>
<%

	rs = factura.dameListadoTicketsFac(ticket1, ticket2, ticket3, ticket4, ticket5, formatoFac);
	if(rs == null){ %>
		<b class="roj">No existen productos en los tickets especificados.</b>
<%	}
	else{
%>
	<table align="center" border="1" width="650" cellpadding="0" cellspacing="0">
	<caption>
	Los productos de el/los ticket(s) agrupados que conformar&aacute;n la(s) factura(s) son: 
	</caption>
	  <tr>
	  	<th width="96">Cantidad</th>
		<th width="86">Tipo</th>		
		<th width="225">Producto</th>
		<th width="115">Precio Unitario</th>
		<th width="116">Importe</th>
	  </tr>
<%		while (rs.next()){	  
			String tipo = "Kg.";
			String cantidad = rs.getDouble("cantidadProducto")+"";
			if(rs.getInt("tipoVenta") == 2){
				tipo = "Unidad";
				cantidad = rs.getInt("cantidadProducto")+"";
			}
			else if(rs.getInt("tipoVenta") == 3){
				tipo = "Caja";
				cantidad = factura.formatoMaxUnDecimal(rs.getString("cantidadProducto"));
			}
			else if(rs.getInt("tipoVenta") == 4){
				tipo = "Pieza";	
				cantidad = factura.formatoMaxUnDecimal(rs.getString("cantidadProducto"));				
			}
			String precioUnitario = "";
			String importe = "";
			if(rs.getInt("gravaIVA") == 0){
				precioUnitario = rs.getDouble("precioVenta")+"";
				importe = rs.getDouble("precioAPagar")+"";
				subTotal += rs.getDouble("precioAPagar");
			}
			else{
				BigDecimal precioProducto = new BigDecimal(rs.getString("precioVenta"));
				precioProducto = precioProducto.multiply(porcentajeNeto);
				precioProducto = precioProducto.divide(porcentajeIva, new MathContext(100));
				precioProducto = precioProducto.setScale(2, RoundingMode.HALF_UP);
				BigDecimal precioOriginalConIVA = new BigDecimal(rs.getString("precioAPagar"));
				BigDecimal precioTotalP = new BigDecimal(rs.getString("precioAPagar"));
				precioTotalP = precioTotalP.multiply(porcentajeNeto);
				precioTotalP = precioTotalP.divide(porcentajeIva, new MathContext(100));
				precioOriginalConIVA = precioOriginalConIVA.subtract(precioTotalP);				
				precioTotalP = precioTotalP.setScale(2, RoundingMode.HALF_UP);
				precioOriginalConIVA = precioOriginalConIVA.setScale(2, RoundingMode.HALF_UP);
				precioUnitario = precioProducto.toString();				
				importe = precioTotalP.toString();
				subTotal += factura.cambiaADouble(precioTotalP.toString());
				iva += factura.cambiaADouble(precioOriginalConIVA.toString());				
			}
%>
	  <tr>
	  	<td><div align="center"><%=cantidad%></div></td>
		<td><div align="center"><%=tipo%></div></td>
		<td><div align="left"><%=rs.getString("descripcion")%></div></td>		
		<td><div align="right">$ <%=factura.formatoDinero(factura.acortaLongitud(precioUnitario))%></div></td>
		<td><div align="right">$ <%=factura.formatoDinero(factura.acortaLongitud(importe))%></div></td>
	  </tr>

<%		}  
		rs.close();
		factura.cierraConexion();
		total = iva+subTotal;
		rs = factura.dameListadoTicketsFac(ticket1, ticket2, ticket3, ticket4, ticket5, formatoFac);
		int cantidadProductos = factura.getResultSetSize(rs);
		rs.close();
		
%>
	</table>
<p>&nbsp;</p>	
	<form name="form1"	 method="post" action="Num_Factura.jsp" target="_self">
    <input type="hidden" name="formatoFac" value="<%=formatoFac%>">
    <input type="hidden" name="rfc" value="<%=rfc%>">
    <input type="hidden" name="nombre" value="<%=nombre%>">
    <input type="hidden" name="ticket1" value="<%=ticket1%>">
    <input type="hidden" name="ticket2" value="<%=ticket2%>">
    <input type="hidden" name="ticket3" value="<%=ticket3%>">
    <input type="hidden" name="ticket4" value="<%=ticket4%>">
    <input type="hidden" name="ticket5" value="<%=ticket5%>">
    <input type="hidden" name="fecha1" value="<%=fecha1%>">
    <input type="hidden" name="fecha2" value="<%=fecha2%>">
    <input type="hidden" name="fecha3" value="<%=fecha3%>">
    <input type="hidden" name="fecha4" value="<%=fecha4%>">
    <input type="hidden" name="fecha5" value="<%=fecha5%>">
    <input type="hidden" name="subTotal" value="<%= factura.acortaLongitud(subTotal+"")%>" >
    <input type="hidden" name="iva" value="<%=factura.acortaLongitud(iva+"")%>" >
    <input type="hidden" name="totalP" value="<%=factura.acortaLongitud(total+"")%>" >
    <input type="hidden" name="cantidadP" value="<%=cantidadProductos+""%>">
	
	
<table width="350" border="1" align="center">
	<tr> 
		<th>Subtotal</th>
		<th>I.V.A.</th>
		<th>Total</th>
	</tr>
	<tr> 
		<td><div align="right">$ <%= factura.formatoDinero(factura.acortaLongitud(subTotal+"")) %> </div></td>
		<td><div align="right">$ <%= factura.formatoDinero(factura.acortaLongitud(iva+"")) %> </div></td>
		<td><div align="right"><strong>$ <%= factura.formatoDinero(factura.acortaLongitud(total+"")) %></strong> </div></td>
	</tr>
</table>	
<p align="center"> <input name="Enviar" type="submit" id="Enviar" value="Continuar"> </p>	
</form>	
	
<%	
	}
%>
<p><a href="Menu_FacturasV.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Image5" width="132" height="41" border="0"></a></p>
<p><img src="imagenes/barraN.jpg" width="532" height="82"></font></p>
</form>
</body>
</html>