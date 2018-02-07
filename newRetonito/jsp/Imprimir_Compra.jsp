<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Impresi&oacute;n de Compra (Pedido)</title>
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

function Cerrar() {
	parent.close(); 
}

</script>
</head>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String claveCompra = request.getParameter("claveCompra");
	ResultSet rs = alCom.dameDatosCompra(claveCompra);
	double subtotal = 0.00;
	double descuentos = 0.00;
	double iva = 0.00;
	double total = 0.00;
	double descuento1 = 0.00;
	double descuento2 = 0.00;
	double descuento3 = 0.00;
	String observaciones = "";
	String fechaImpresion=alCom.dameFechaHoy();
	ResultSet rs2 = alCom.dameProductosCompra(claveCompra);
%>
<body onLoad="imprimirPagina(); Cerrar()">

<table width="750" border="1" cellpadding="0" cellspacing="0">
  <caption>Clave de Compra:<%=claveCompra%>,  Fecha impresi&oacute;n: <%=fechaImpresion%></caption>
  <tr>
	<th>Proveedor</th>
	<th>Alta<br/>Pedido</th>
	<th>Fecha<br/>Entrega</th>
	<th>Estado<br/>Recepci&oacute;n</th>
  </tr>
<% 	while(rs.next()){ 
		subtotal = rs.getDouble("subtotal");
		descuentos = rs.getDouble("descuento");
		iva = rs.getDouble("iva");
		total = rs.getDouble("total");
		descuento1 = rs.getDouble("descuento1");
		descuento2 = rs.getDouble("descuento2");
		descuento3 = rs.getDouble("descuento3");
		observaciones = rs.getString("observaciones");
		int tipoEntrega = rs.getInt("Entrega");
		String fraseEntrega = "Totalmente Recibido";
		if(tipoEntrega == 0){
			fraseEntrega = "Sin Recibir";
		}
		else if(tipoEntrega == 1){
			fraseEntrega = "Parcialmente Recibido";
		}
%>
  <tr>
  	<td><div align="center"><%=alCom.dameNombreProveedor(rs.getString("ClaveProveedor"))%></div></td>
	<td><div align="center"><%=rs.getString("fechaRegistro")%></div></td>
	<td><div align="center"><%=rs.getString("fechaEntrega")%></div></td>
	<td><div align="center"><%=fraseEntrega%></div></td>	
  </tr>
<% }
	rs.close();
	alCom.cierraConexion(); %>	  
</table>
<br/>
<table width="750"  cellpadding="0" cellspacing="0" border="1">
  <caption>Productos Comprados</caption>
  <tr>
	<th width="85">Cantidad</th>
	<th width="58">Tipo</th>	
	<th width="311">Producto</th>
	<th width="105">Precio<br/>Unitaro</th>
	<th width="70">Cambio<br/>Precio</th>
	<th width="107">Importe</th>
  </tr>
<%
	while(rs2.next()){
		if(rs2.getInt("Adquisicion") == 1){
		String elCambio = "No";
		if(rs2.getInt("CambiaPrecio") == 1){
			elCambio = "S&iacute;";
		}
		String elTipo = "Pieza";
		if(rs2.getInt("Tipo") == 1){
			elTipo = "Caja";
		}
		else if(rs2.getInt("Tipo") == 2){
			elTipo = "KG.";
		}
%>
  <tr>
	<td><%=rs2.getDouble("Cantidad")%></td>
	<td><div align="center"><%=elTipo%></div></td>	
	<td><%=alCom.dameDescripcionProducto(rs2.getString("ClaveProducto"))%></td>
	<td><div align="right">$ <%=alCom.formatoCortoDinero(rs2.getDouble("Costo")+"")%></div></td>
	<td><div align="center"><%=elCambio%></div></td>		
	<td><div align="right">$ <%=alCom.formatoDinero(alCom.formatoCortoDinero(rs2.getDouble("Importe")+""))%></div></td>
  </tr>
<%	
		}
	}
	rs2.beforeFirst();
%>	  	  
</table>
<br/>
<table width="750"  cellpadding="0" cellspacing="0" border="1">
  <caption> Productos Obsequiados </caption>
  <tr>
	<th width="161">Cantidad</th>
	<th width="90">Tipo</th>	
	<th width="491">Producto</th>
  </tr>
<%
	while(rs2.next()){
		if(rs2.getInt("Adquisicion") == 0){
		String elTipo = "Pieza";
		if(rs2.getInt("Tipo") == 1){
			elTipo = "Caja";
		}
		else if(rs2.getInt("Tipo") == 2){
			elTipo = "KG.";
		}
%>	
  <tr>
	<td><div align="center"><%=rs2.getDouble("Cantidad")%></div></td>
	<td><div align="center"><%=elTipo%></div></td>	
	<td><%=alCom.dameDescripcionProducto(rs2.getString("ClaveProducto"))%></td>
  </tr>
<%	
		}
	}
	rs2.close();
	alCom.cierraConexion2();
%>	  	  
</table>
<p>
<table width="750" border="1" cellpadding="0" cellspacing="0">
  <tr>
	<th width="243">Observaciones</th>
	<th width="150">&nbsp;</th>
	<td width="96">&nbsp;</td>
	<th width="148">Subtotal</th>
	<td width="101"><div align="right">$ <%=alCom.formatoDinero(subtotal+"")%></div></td>
</tr>
<tr>
	<td rowspan="3"><textarea readonly="true" name="observaciones" cols="35" rows="5"><%= observaciones%></textarea></td>
	<th>Descuento 1</th>
	<td><div align="center"> <%=descuento1%> %</div></td>
	<th height="34"><div align="center"><strong>Descuento</strong></div></th>
	<td height="34"><div align="right">$ <%=alCom.formatoDinero(descuentos+"")%> </div></td>
</tr>
<tr>
  <th>Descuento 2</th>
  <td><div align="center"> <%= descuento2%> %</div></td>
	<th height="35"><div align="center"><strong>I.V.A.</strong></div></th>
  <td height="35"><div align="right">$ <%=alCom.formatoDinero(iva+"")%> </div></td>
</tr>
<tr>
  <th>Descuento 3</th>
  <td><div align="center"> <%= descuento3%> %</div></td>
  <th height="35"><div align="center"><strong>TOTAL</strong></div></th>
  <td><div align="right"><b>$ <%=alCom.formatoDinero(total+"")%></b>  </div></td>
</tr>
</table>
</p>
</body>
</html>

