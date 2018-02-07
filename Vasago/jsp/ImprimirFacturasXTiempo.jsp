<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="en" class="com.vas.bd.ManagerEntregas" scope="page" />

<html>
<head>
<title>Muestra Consulta Facturas en Tiempo por Cliente</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">

<script>
<!--
-->
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String fechaInicial = request.getParameter("fechaInicial");
	String fechaFinal = request.getParameter("fechaFinal");
%>
<h1>Facturas del <%=fechaInicial%> al <%=fechaFinal%></h1>
<table width="755" border="1" align="center">
  <tr>
  	<th width="115">Clave<br/>Venta</th>
	<th width="89">Factura No.</th>
	<th width="96">Fecha</th>	
	<th width="122">Importe<br />Total</th>
	<th width="157">Estado de<br />Transacci&oacute;n</th>
 	<th width="136">Estado de<br />Cobro</th>
 </tr>
  <%
  ResultSet rs = en.dameFacturasXTiempo(fechaInicial,fechaFinal);
  while (rs.next()){
	String estatus = "";
	int estadoTransac = rs.getInt("Entrega");
	if(estadoTransac == 0){
		estatus = "Por entregar";
	}
	else if(estadoTransac == 1){
		estatus = "Parcialmente entregado";
	}
	else{
		estatus = "Finalizado";
	}
	String cobro = "";
	int estadoCobro = rs.getInt("Pago");
	if(estadoCobro == 0){
		cobro = "Por Cobrar";
	}
	else if(estadoCobro == 1){
		cobro = "Parcialmente Cobrado";
	}
	else{
		cobro = "Cobrado";
	}
%>
  <tr>
  	<td><div align="center"><%=rs.getInt("claveVenta")%></div></td>
  	<td><div align="center"><%=rs.getString("factura")%></div></td>	
  	<td><div align="center"><%=rs.getString("fechaAlta")%></div></td>
	<td><div align="right">$ <%=en.formatoDinero(rs.getString("total"))%></div></td>
	<td><div align="center"><%=estatus%></div></td>	
	<td><div align="center"><%=cobro%></div></td>	
  </tr>
<%  
  }
	if(rs != null){
		rs.close();
	}		
	en.cierraConexion();	
  
%>  
</table>
</body>
</html>
