<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="" %> 
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" scope="page"/>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />
<html>
<head>
<title>Existencias de Todos los Productos </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseMiniCSS.css" rel="stylesheet" type="text/css">

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
</head>
<body>
<%
	String fechaHoy = ticket.dameFechaHoy();
	String semana = request.getParameter("semana");
	String de = semana.substring(1,11);
	String a = semana.substring(18,28);
	String nombreVendedor = "";
%>	
	<b>Siendo hoy: <%=fechaHoy%><br/>N&oacute;mina correspondiente a la semana que inici&oacute; el <%=de%></b>
<%	
	ResultSet rs = empleado.dameNominaCorrespondiente(semana);
	BigDecimal nominaXEmpleado = new BigDecimal("0.00");
	BigDecimal prestadoXEmpleado = new BigDecimal("0.00");
	BigDecimal totalXNomina = new BigDecimal("0.00");
	BigDecimal totalXPrestamos = new BigDecimal("0.00");	
%>
	<table align="center" width="750" border="1" cellpadding="0" cellspacing="0" onClick="imprimirPagina();">
<%			
	while(rs.next()){
		if(nombreVendedor.equals("")){
			nombreVendedor = rs.getString("nombreE");				
			nominaXEmpleado = new BigDecimal(rs.getString("salario"));
			totalXNomina = new BigDecimal(rs.getString("salario"));
			if(rs.getString("cantidadAPagar") != null){
				prestadoXEmpleado = new BigDecimal(rs.getString("cantidadAPagar"));
				totalXPrestamos = new BigDecimal(rs.getString("cantidadAPagar"));
			}
%>
	  <tr>
	  	<th colspan="2">Empleado:</th>
		<th width="274">Salario:</th>
	  </tr>
	  <tr>
	  	<td colspan="2"><div align="center"><%=nombreVendedor%></div></td>
		<td><div align="center"><b>$ <%=empleado.formatoDinero(rs.getString("salario"))%></b></div></td>
	  </tr>
	  <tr>
		<th colspan="3">Prestamos</th>
	  </tr>
	  <tr>
		<th width="140">Tipo</th>
		<th width="328">Fecha Prestamo</th>
		<th>Cantidad a Pr&eacute;stamo</th>				
	  </tr>
<% 		if(rs.getString("tipo") != null) { %>
		  <tr>
			<td><div align="center"><%=rs.getString("tipo")%></div></td>
			<td><div align="center"><%=rs.getString("fechaPrestamo")%></div></td>
			<td><div align="right">$ <%=rs.getString("cantidadAPagar")%></div></td>				
		  </tr>
<%		} 
			} // Cierro if
			else if(nombreVendedor.equals(rs.getString("nombreE"))){ 			
				if(rs.getString("cantidadAPagar") != null){
					prestadoXEmpleado = prestadoXEmpleado.add(new BigDecimal(rs.getString("cantidadAPagar")));
					totalXPrestamos = totalXPrestamos.add(new BigDecimal(rs.getString("cantidadAPagar")));
				}
		 		if(rs.getString("tipo") != null) { %>
			  <tr>
				<td><div align="center"><%=rs.getString("tipo")%></div></td>
				<td><div align="center"><%=rs.getString("fechaPrestamo")%></div></td>
				<td><div align="right">$ <%=rs.getString("cantidadAPagar")%></div></td>				
			  </tr>
<%				}  
			} // Cierro else if
			else if(!nombreVendedor.equals(rs.getString("nombreE"))){ 
				nominaXEmpleado = nominaXEmpleado.subtract(prestadoXEmpleado);
				prestadoXEmpleado = prestadoXEmpleado.setScale(2, RoundingMode.HALF_UP);
				nominaXEmpleado = nominaXEmpleado.setScale(2, RoundingMode.HALF_UP);				
%>
	  <tr>
	  	<th colspan="2">TOTAL PARCIAL PRESTADO:</th>
		<td><div align="right">$ <%=empleado.formatoDinero(prestadoXEmpleado.toString())%></div></td>
	  </tr>
	  <tr>
	  	<th colspan="2">NOMINA REAL:</th>
		<td height="25"><div align="center"><b>$ <%=empleado.formatoDinero(nominaXEmpleado.toString())%></b></div></td>
	  </tr>
	  <tr>
	  	<td colspan="3">&nbsp;</td>
	  </tr>
<%				prestadoXEmpleado = new BigDecimal("0.00");
				nombreVendedor = rs.getString("nombreE");
				nominaXEmpleado = new BigDecimal(rs.getString("salario"));
				totalXNomina = totalXNomina.add(new BigDecimal(rs.getString("salario")));
				if(rs.getString("cantidadAPagar") != null){
					prestadoXEmpleado = new BigDecimal(rs.getString("cantidadAPagar"));
					totalXPrestamos = totalXPrestamos.add(new BigDecimal(rs.getString("cantidadAPagar")));
				}				
%>
			  <tr>
				<th colspan="2">Empleado:</th>
				<th>Salario:</th>
			  </tr>
			  <tr>
				<td colspan="2"><div align="center"><%=nombreVendedor%></div></td>
				<td><div align="center"><b>$ <%=empleado.formatoDinero(rs.getString("salario"))%></b></div></td>
			  </tr>
			  <tr>
				<th colspan="3">Prestamos</th>
			  </tr>
			  <tr>
				<th>Tipo</th>
				<th>Fecha Prestamo</th>
				<th>Cantidad a Pr&eacute;stamo </th>				
			  </tr>
		<% 		if(rs.getString("tipo") != null) { %>
				  <tr>
					<td><div align="center"><%=rs.getString("tipo")%></div></td>
					<td><div align="center"><%=rs.getString("fechaPrestamo")%></div></td>
					<td><div align="right">$ <%=rs.getString("cantidadAPagar")%></div></td>				
				  </tr>
		<%		} 			
			} // Cierro else if
		} // Cierro while
		rs.close();
		empleado.cierraConexion();		
		nominaXEmpleado = nominaXEmpleado.subtract(prestadoXEmpleado);
		prestadoXEmpleado = prestadoXEmpleado.setScale(2, RoundingMode.HALF_UP);
		nominaXEmpleado = nominaXEmpleado.setScale(2, RoundingMode.HALF_UP);
		BigDecimal nominaReal = new BigDecimal("0.00");
		nominaReal = totalXNomina.subtract(totalXPrestamos);
		totalXNomina = totalXNomina.setScale(2, RoundingMode.HALF_UP);
		totalXPrestamos = totalXPrestamos.setScale(2, RoundingMode.HALF_UP);	
		nominaReal = nominaReal.setScale(2, RoundingMode.HALF_UP);	
%>
	  <tr>
	  	<th colspan="2">TOTAL PARCIAL PRESTADO:</th>
		<td><div align="right">$ <%=empleado.formatoDinero(prestadoXEmpleado.toString())%></div></td>
	  </tr>
	  <tr>
	  	<th colspan="2">NOMINA REAL:</th>
		<td height="25"><div align="center"><b>$ <%=empleado.formatoDinero(nominaXEmpleado.toString())%></b></div></td>
	  </tr>
	</table>
	<br/>
	<table align="center" cellpadding="0" cellspacing="0" width="650" border="1" onClick="imprimirPagina();">
	  <tr>
	  	<th>TOTAL N&Oacute;MINA</th>
	  	<th>TOTAL PRESTAMOS</th>		
	  	<th>N&Oacute;MINA REAL</th>				
	  </tr>
	  <tr>  
	  	<td><div align="right">$ <%=empleado.formatoDinero(totalXNomina.toString())%></div></td>
	  	<td><div align="right">$ <%=empleado.formatoDinero(totalXPrestamos.toString())%></div></td>
	  	<td height="25"><div align="right"><b>$ <%=empleado.formatoDinero(nominaReal.toString())%></b></div></td>
	  </tr>
	</table>
</body>
</html>
