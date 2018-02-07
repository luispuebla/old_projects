<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="error.jsp" %>
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" />

<html>
<head>
<title>Corte Diario</title>
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
	document.form1.submit();
}
//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg','imagenes/Imprimir2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String tipoConsul = request.getParameter("tipoCon");
	String dia = "%%";
	String mes = request.getParameter("mes");
	String anio = request.getParameter("aaaa");
	if(tipoConsul.equalsIgnoreCase("dia")){
		dia = request.getParameter("dia");
	}
	String fecha = anio+"-"+mes+"-"+dia;
%>
<form name="form1" method="post" target="_blank" action="Imprime_Credito.jsp" >
<input type="hidden" name="fecha" value="<%=fecha%>">
<h1>Los Créditos Asignados/Vencidos para la Fecha: 
<%
 if(!(dia.equalsIgnoreCase("%%"))){
 	out.print(dia+"/");
 }
%><%=mes%>/<%=anio%></strong> son: </h1>
<table width="610"  border="1" align="center" cellpadding="0" cellspacing="0">
	<caption>CR&Eacute;DITOS ASIGNADOS  A CLIENTES: 
	</caption>
	<tr>
      <th width="75"><div align="center">Número de Ticket</div></th>
      <th width="70"><div align="center">Monto</div></th>
      <th width="100"><div align="center">RFC</div></th>
      <th width="205"><div align="center">Nombre Cliente</div></th>
      <th width="80"><div align="center">Vencimiento</div></th>
      <th width="80"><div align="center">Estatus</div></th>
    </tr>
	<tr>
<%
	ResultSet rs = facturas.dameCreditosXFecha(fecha);
	BigDecimal ts = new BigDecimal("0.00");
	String colorestatus = "0";
	String cliente = "";
	BigDecimal sumaAdeudos = new BigDecimal("0.00");
	while (rs.next()) { 
		String tempcliente = rs.getString("nombreCliente");
		if(cliente.equalsIgnoreCase("")){
			cliente = tempcliente;
		}
		if (!(cliente.equalsIgnoreCase(tempcliente))){
			sumaAdeudos = sumaAdeudos.setScale(2, RoundingMode.HALF_UP);
%>
	<tr>
				<td>&nbsp;</td>
				<th colspan="4"><div align="center">TOTAL DE <%=cliente%></div></th>
				<td><div align="center">$ <%=facturas.formatoDinero(sumaAdeudos.toString())%></div></td>				
	</tr>
<%			
			sumaAdeudos = new BigDecimal("0.00");			
			cliente = tempcliente;			
		}
		
		sumaAdeudos = sumaAdeudos.add(new BigDecimal(rs.getString("cantidadAPagar")));
		ts = ts.add(new BigDecimal(rs.getString("cantidadAPagar")));
		colorestatus = rs.getString("estatusCredito");
		if (colorestatus.equalsIgnoreCase("0") || colorestatus.equalsIgnoreCase("2")){
			colorestatus = "#0000CC";
		}
		else{
			colorestatus = "#990000";
		}
%>		
	  <td><div align="center"><%= rs.getString("numTicket") %> </div></td>
	  <td><div align="right">$<%= facturas.formatoDinero(facturas.acortaLongitud(rs.getString("cantidadAPagar"))) %> </div></td>		
	  <td><div align="center"><%= rs.getString("rfc") %> </div></td>
	  <td><div align="center"><%= rs.getString("nombreCliente") %> </div></td>
	  <td><div align="center"><%= rs.getString("fechaAPagar") %> </div></td>
	  <td><font color="<%=colorestatus %>"><div align="center">
<%
	String estatus = rs.getString("estatusCredito");
	if(estatus.equalsIgnoreCase("0")){
		estatus = "A Tiempo";
	}
	else if (estatus.equalsIgnoreCase("1")){
		estatus = "Vencido";
	}
	else if (estatus.equalsIgnoreCase("2")){
		estatus = "Pagado";
	}
	out.print(estatus);

%>
	 </div></font></td>		
   </tr>
<%
	}
	rs.close();
	facturas.cierraConexion();
	sumaAdeudos = sumaAdeudos.setScale(2, RoundingMode.HALF_UP);
	ts = ts.setScale(2, RoundingMode.HALF_UP);			
	if (!(cliente.equalsIgnoreCase(""))){
%>
			<tr>
				<td>&nbsp;</td>
				<th colspan="4"><div align="center">TOTAL DE <%=cliente%></div></th>
				<td><div align="center">$ <%=facturas.formatoDinero(sumaAdeudos.toString())%></div></td>				
			</tr>
<%	
	}	
%>	
  </table>
  
<input type="hidden" name="totalCreditos" value="<%=ts.toString()%>">
<div align="left"></div>
  <table width="610" border="1" align="center">
    <tr> 
      <th width="500"><div align="center">Monto Total por Cr&eacute;ditos Asignados a Clientes:</div></th>
      <td width="110"><div align="right">$<%=facturas.formatoDinero(ts.toString())%></div></td>
	</tr>
  </table>
<br />

<table width="610"  border="1" align="center" cellpadding="0" cellspacing="0">
	<caption>CR&Eacute;DITOS ASIGNADOS A VENDEDORES: 
	</caption>
	<tr>
      <th width="75"><div align="center">Número de Ticket</div></th>
      <th width="70"><div align="center">Monto</div></th>
      <th width="100"><div align="center">Clave Vendedor</div></th>
      <th width="205"><div align="center">Vendedor</div></th>
      <th width="80"><div align="center">Vencimiento</div></th>
      <th width="80"><div align="center">Estatus</div></th>
    </tr>
	<tr>
<%
	rs = facturas.dameCreditosXFechaV(fecha);
	BigDecimal tsV = new BigDecimal("0.00");
	colorestatus = "0";
	String clienteV = "";
	BigDecimal sumaAdeudosV = new BigDecimal("0.00");
	while (rs.next()) { 
		String tempcliente = rs.getString("NombreE");
		if(clienteV.equalsIgnoreCase("")){
			clienteV = tempcliente;
		}
		if (!(clienteV.equalsIgnoreCase(tempcliente))){
			sumaAdeudosV = sumaAdeudosV.setScale(2, RoundingMode.HALF_UP);
%>
	<tr>
				<td>&nbsp;</td>
				<th colspan="4"><div align="center">TOTAL DE <%=clienteV%></div></th>
				<td><div align="center">$ <%=facturas.formatoDinero(sumaAdeudosV.toString())%></div></td>				
	</tr>
<%			
			sumaAdeudosV = new BigDecimal("0.00");			
			clienteV = tempcliente;			
		}
		
		sumaAdeudosV = sumaAdeudosV.add(new BigDecimal(rs.getString("cantidadAPagar")));
		tsV = tsV.add(new BigDecimal(rs.getString("cantidadAPagar")));
		colorestatus = rs.getString("estatusCredito");
		if (colorestatus.equalsIgnoreCase("0") || colorestatus.equalsIgnoreCase("2")){
			colorestatus = "#0000CC";
		}
		else{
			colorestatus = "#990000";
		}
%>		
	  <td><div align="center"><%= rs.getString("numTicket") %> </div></td>
	  <td><div align="right">$<%= facturas.formatoDinero(facturas.acortaLongitud(rs.getString("cantidadAPagar"))) %> </div></td>		
	  <td><div align="center"><%= rs.getString("rfc") %> </div></td>
	  <td><div align="center"><%= rs.getString("NombreE") %> </div></td>
	  <td><div align="center"><%= rs.getString("fechaAPagar") %> </div></td>
	  <td><font color="<%=colorestatus %>"><div align="center">
<%
	String estatus = rs.getString("estatusCredito");
	if(estatus.equalsIgnoreCase("0")){
		estatus = "A Tiempo";
	}
	else if (estatus.equalsIgnoreCase("1")){
		estatus = "Vencido";
	}
	else if (estatus.equalsIgnoreCase("2")){
		estatus = "Pagado";
	}
	out.print(estatus);

%>
	 </div></font></td>		
   </tr>
<%
	}
	rs.close();
	facturas.cierraConexion();
	sumaAdeudosV = sumaAdeudosV.setScale(2, RoundingMode.HALF_UP);
	tsV = tsV.setScale(2, RoundingMode.HALF_UP);			
	if (!(clienteV.equalsIgnoreCase(""))){
%>
			<tr>
				<td>&nbsp;</td>
				<th colspan="4"><div align="center">TOTAL DE <%=clienteV%></div></th>
				<td><div align="center">$ <%=facturas.formatoDinero(sumaAdeudosV.toString())%></div></td>				
			</tr>
<%	
	}	
%>	
  </table>

<input type="hidden" name="totalCreditosE" value="<%=tsV.toString()%>">
<div align="left"></div>
  <table width="610" border="1" align="center">
    <tr> 
      <th width="500"><div align="center">Monto Total por Cr&eacute;ditos Asignados a Empleados:</div></th>
      <td width="110"><div align="right">$<%=facturas.formatoDinero(tsV.toString())%></div></td>
	</tr>
  </table>
<br />


<table width="610"  border="1" align="center" cellpadding="0" cellspacing="0">
<caption>CR&Eacute;DITOS VENCIDOS:</caption>
	<tr>
      <th width="75"><div align="center">Número de Ticket</div></td>
      <th width="70"><div align="center">Monto</div></th>
      <th width="100"><div align="center">RFC</div></th>
      <th width="205"><div align="center">Nombre Cliente</div></th>
      <th width="80"><div align="center">Vencimiento</div></th>
      <th width="80"><div align="center">Estatus</div></th>
    </tr>
	<tr>
<%
	rs = facturas.dameCreditosXFechaVencidos(fecha);
	BigDecimal tv = new BigDecimal("0.00");
	cliente = "";
	sumaAdeudos = new BigDecimal("0.00");
	while (rs.next()) { 
		String tempcliente = rs.getString("nombreCliente");
		if(cliente.equalsIgnoreCase("")){
			cliente = tempcliente;
		}
		if (!(cliente.equalsIgnoreCase(tempcliente))){
			sumaAdeudos = sumaAdeudos.setScale(2, RoundingMode.HALF_UP);		
%>
	<tr>
				<td>&nbsp;</td>
				<th colspan="4"><div align="center">TOTAL DE <%=cliente%></div></th>
				<td><div align="center">$ <%=facturas.formatoDinero(sumaAdeudos.toString())%></div></td>				
	</tr>
<%			
			sumaAdeudos = new BigDecimal("0.00");			
			cliente = tempcliente;	
		}
		sumaAdeudos = sumaAdeudos.add(new BigDecimal(rs.getString("cantidadAPagar")));
		tv = tv.add(new BigDecimal(rs.getString("cantidadAPagar")));
%>		
	  <td><div align="center"><%= rs.getString("numTicket") %> </div></td>
	  <td><div align="right">$<%= facturas.formatoDinero(facturas.acortaLongitud(rs.getString("cantidadAPagar"))) %> </div></td>		
	  <td><div align="center"><%= rs.getString("rfc") %> </div></td>
	  <td><div align="center"><%= rs.getString("nombreCliente") %> </div></td>
	  <td><div align="center"><%= rs.getString("fechaAPagar") %> </div></td>
	  <td><div align="center">Vencido</div></font></td>		
   </tr>
<%
	}
	rs.close();
	facturas.cierraConexion();
	sumaAdeudos = sumaAdeudos.setScale(2, RoundingMode.HALF_UP);
	tv = tv.setScale(2, RoundingMode.HALF_UP);			
	if (!(cliente.equalsIgnoreCase(""))){
%>
			<tr>
				<td>&nbsp;</td>
				<th colspan="4"><div align="center">TOTAL DE <%=cliente%></div></th>
				<td><div align="center">$ <%=facturas.formatoDinero(sumaAdeudos.toString())%></div></td>				
			</tr>
<%	
	}	
%>	
  </table>   
<input type="hidden" name="totalCreditosV" value="<%=tv.toString()%>">   
  <table width="610" border="1" align="center">
    <tr> 
      <th width="500"><div align="center">Monto Total por Cr&eacute;ditos Vencidos:</div></td>
      <td width="110"><div align="right">$ <%=facturas.formatoDinero(tv.toString())%></div></td>
	</tr>
  </table>   
  <div align="right">&nbsp;</div>  
<table width="400" align="center">
	<tr>
    <td><div align="center"><a href="Fecha_Corte_Credito.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></div></td>
	<td>
      <div align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="132" height="41" border="0"></a>			
	    </div></td>
	</tr>
</table>  
</form>
<p><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>