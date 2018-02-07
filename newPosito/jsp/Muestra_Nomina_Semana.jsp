<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" scope="page"/>
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Dame Monto a Pr&eacute;stamo</title>
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
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 				
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%	
	String fechaHoy = ticket.dameFechaHoy();
	String semana = request.getParameter("semana");
	String de = semana.substring(1,11);
	String a = semana.substring(18,28);
	String nombreVendedor = "";	
	if(request.getParameter("libera") != null){
		empleado.liberaCreditoXProducto(semana);
	}

%>	
	<h1>Siendo hoy: <%=fechaHoy%></h1>
	<b>N&oacute;mina correspondiente a la semana que inici&oacute; el <%=de%></b>
<%	
	ResultSet rs = empleado.dameNominaCorrespondiente(semana);
	BigDecimal nominaXEmpleado = new BigDecimal("0.00");
	BigDecimal prestadoXEmpleado = new BigDecimal("0.00");
	BigDecimal totalXNomina = new BigDecimal("0.00");
	BigDecimal totalXPrestamos = new BigDecimal("0.00");	
	boolean hayNomina = false;
	while(rs.next() && !hayNomina){
		hayNomina = true;
	}
	if(hayNomina){ 
		rs.beforeFirst(); 
%>
	<table align="center" width="750" border="1" cellpadding="0" cellspacing="0">
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
		<td height="35"><div align="center"><b>$ <%=empleado.formatoDinero(nominaXEmpleado.toString())%></b></div></td>
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
		<td height="35"><div align="center"><b>$ <%=empleado.formatoDinero(nominaXEmpleado.toString())%></b></div></td>
	  </tr>
	</table>
	<br/>
	<table align="center" cellpadding="0" cellspacing="0" width="650" border="1">
	  <tr>
	  	<th>TOTAL N&Oacute;MINA</th>
	  	<th>TOTAL PRESTAMOS</th>		
	  	<th>N&Oacute;MINA REAL</th>				
	  </tr>
	  <tr>  
	  	<td><div align="right">$ <%=empleado.formatoDinero(totalXNomina.toString())%></div></td>
	  	<td><div align="right">$ <%=empleado.formatoDinero(totalXPrestamos.toString())%></div></td>
	  	<td height="35"><div align="right"><b>$ <%=empleado.formatoDinero(nominaReal.toString())%></b></div></td>
	  </tr>
	</table>
<form name="form1" method="post" target="_blank" action="Nomina_X_Semana.jsp" >
	<input name="semana" type="hidden" value="<%=semana%>">
	<p align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="132" height="41" border="0"></a>			
	</p>
</form>	
<form name="form1" method="post" target="_self" action="Muestra_Nomina_Semana.jsp" >
	<input name="semana" type="hidden" value="<%=semana%>">
	<input  type="hidden" name="libera" value="">
	<p align="center"><input type="submit" name="Libera" value="Libera pagos de Cr&eacute;dito por Producto"></p>
</form>	

	
	
	
<%	}
	else{ %>
		<b class="roj">No hay empleados registrados para calcular la n&oacute;mina de la semana del <%=de%> al <%=a%></b>
<%	} 
	empleado.cierraConexion();
%>
<p><a href="Menu_Prestamos_Nominas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p><img src="imagenes/barraN.jpg"></p>
</body>
</html>
