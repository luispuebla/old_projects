<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="mticket" class="com.alpha.bd.ManagerTicket" scope="page"/>

<html>
<head>
<title>Muestra Historial Ticket Venta</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<body>
<%	
	String query = request.getQueryString();
	System.out.println(query);
	String ticket = query.substring(0,query.indexOf("*"));
	String de = query.substring(query.indexOf("*")+1, query.indexOf("^"));
	String al = query.substring(query.indexOf("^")+1, query.length());
	System.out.println("de: "+de+" al: "+al);
	ResultSet rs = mticket.dameDatosTicket(ticket); 
	String fechaDePago = "Sin Pago";
	String estatusTicket = "En proceso";
	String estatusPago = "Sin pagar";
	String vendedor = "";
	BigDecimal totalVenta = new BigDecimal("0.00");
	boolean ciclo1 = true;
	while (rs.next() && ciclo1){
		ciclo1 = false;
		if(rs.getString("fechaRealPago")!= null){
			fechaDePago = rs.getString("fechaRealPago");
		}
		vendedor = rs.getString("nombreE");
		if(rs.getInt("estatusTicket") == 1){
			estatusTicket = "Finalizado";
		}
		else if(rs.getInt("estatusTicket") == 2){
			estatusTicket = "Cancelado";
		}
		if(rs.getInt("estatusPago") == 1){
			estatusPago = "Pagado";
		}
		else if(rs.getInt("estatusPago") == 2){
			estatusPago = "A Cr&eacute;dito";
		}
	}
	%>
	<table align="center" width="750" cellpadding="0" cellspacing="0" border="1">
	  <tr>
		<th>Ticket #</th>
		<td><div align="center"><%=ticket%></div></td>
		<th>Estatus<br/>Pago</th>
		<td><div align="center"><b><%=estatusPago%></b></div></td>
		<th>Fecha de Pago</th>
		<td><div align="center"><%=fechaDePago%></div></td>				
	  </tr>
	  <tr>
		<th colspan="2">Nombre Vendedor</th>
		<td><div align="center"><%=vendedor%></div></td>
		<th colspan="2">Estatus Ticket</th>
		<td><div align="center"><%=estatusTicket%></div></td>				
	  </tr>
	  <tr>
		<th>Cantidad</th>
		<th>Tipo</th>
		<th>Producto</th>				
		<th>Registro<br/>Fecha/Hora</th>
		<th>Tipo<br>Precio</th>
		<th>Precio</th>
	  </tr>

<%			
	rs.beforeFirst();
	while(rs.next()){  
		totalVenta = totalVenta.add(new BigDecimal(rs.getString("precioAPagar")));
		String tipo = "Kg.";
		String tipoPrecio = "Menudeo";
		if(rs.getInt("tipoPrecio") == 1){
			tipoPrecio = "Medio Mayoreo";
		}
		else if(rs.getInt("tipoPrecio") == 2){
			tipoPrecio = "Mayoreo";
		}
		else if(rs.getInt("tipoPrecio") == 3){
			tipoPrecio = "Asignaci&oacute;n Directa";
		}
		else if(rs.getInt("tipoPrecio") == 7){
			tipoPrecio = "Escalonado";
		}
		String cantidad = rs.getDouble("cantidadProducto")+"";
		if(rs.getInt("tipoVenta") == 2){
			tipo = "Unidad";
			cantidad = rs.getInt("cantidadProducto")+"";
		}
		else if(rs.getInt("tipoVenta") == 3){
			tipo = "Caja";
			cantidad = mticket.formatoMaxUnDecimal(rs.getString("cantidadProducto"));
		}
		else if(rs.getInt("tipoVenta") == 4){
			tipo = "Pieza";
			cantidad = mticket.formatoMaxUnDecimal(rs.getString("cantidadProducto"));
		}
%>
	<tr>
		<td><div align="center"><%=cantidad%></div></td>
		<td><div align="center"><%=tipo%></div></td>
		<td><%=rs.getString("descripcion")%></td>				
		<td><div align="center"><%=rs.getString("fechaRegistro")%>/<br/><%=rs.getString("horaRegistro")%></div></td>
		<td><div align="center"><%=tipoPrecio%></div></td>
		<td><div align="right">$ <%=mticket.formatoDinero(rs.getString("precioAPagar"))%></div></td>
	</tr>			
<%			}
	rs.close();
	mticket.cierraConexion(); 
	totalVenta = totalVenta.setScale(2, RoundingMode.HALF_UP);			
%>
	  <tr>
		<th colspan="5"><div align="right">TOTAL</div></th>
		<td><div align="right"><b>$ <%=mticket.formatoDinero(totalVenta.toString())%></b></div></td>
	  </tr>
	</table>			
<form name="regreso" method="post" action="Muetra_Prestamos_Semana.jsp">
	<input type="hidden" value="'<%=de%>' AND '<%=al%>'" name="semana">
	<p><input type="submit" value="Volver" name="Volver>"></p>
</form>
<p>&nbsp;</p>
<p><img src="imagenes/barraN.jpg"></p>
</body>
</html>
