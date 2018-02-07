<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="error.jsp" %>
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" />
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" />

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
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
<h1>Todos los Créditos no cobrados son:</h1>
<table width="726"  border="1" align="center" cellpadding="0" cellspacing="0">
<caption> CR&Eacute;DITOS SIN COBRAR (CLIENTES)</caption>
	<tr>
      <th width="76"><div align="center">Número de Ticket</div></th>
      <th width="70"><div align="center">Monto</div></th>
      <th width="97"><div align="center">RFC</div></th>
      <th width="196"><div align="center">Nombre Cliente</div></th>
      <th width="87"><div align="center">Otorgado</div></th>
      <th width="95"><div align="center">Vencimiento</div></th>
      <th width="89"><div align="center">Estatus</div></th>
    </tr>
	<tr>
<%
	ResultSet rs = facturas.dameCreditosTodos();	
	BigDecimal ts = new BigDecimal("0.00");
	String colorestatus = "";
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
		<td colspan="6"><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center"><strong>* <%=cliente%> ADEUDA EN TOTAL ...*</strong></div></font></td>
		<td><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center">$ <%=facturas.formatoDinero(sumaAdeudos.toString())%></div></font></td>				
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
	  <td><%= rs.getString("rfc") %> </div></td>
	  <td><%= rs.getString("nombreCliente") %> </div></td>
	  <td><div align="center"><%= rs.getString("fechaCredito") %> </div></td>
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
			<td colspan="6"><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center"><strong>* <%=cliente%> ADEUDA EN TOTAL ...*</strong></div></font></td>
			<td><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center">$ <%=facturas.formatoDinero(sumaAdeudos.toString())%></div></font></td>				
  </tr>
<%	
	}
%>	
</table>
<br/>
  <table width="650" border="1" align="center">
    <tr> 
      <th width="532"><div align="center"><strong>Monto Total por Cr&eacute;ditos a Clientes:</strong></div></th>
      <td width="102"><div align="right"><strong>$ <%=facturas.formatoDinero(ts.toString())%></strong></div></td>
	</tr>
  </table>
<br/>
----------------------------------------------------------------------------------------------------------------------
<br/>
  <table width="726"  border="1" align="center" cellpadding="0" cellspacing="0">
<caption> CR&Eacute;DITOS SIN COBRAR (EMPLEADOS)</caption>
	<tr>
      <th width="76"><div align="center">Número de Ticket</div></th>
      <th width="70"><div align="center">Monto</div></th>
      <th width="97"><div align="center">Clave Vendedor</div></th>
      <th width="196"><div align="center">Nombre Vendedor</div></th>
      <th width="87"><div align="center">Otorgado</div></th>
      <th width="95"><div align="center">Vencimiento</div></th>
      <th width="89"><div align="center">Estatus</div></th>
    </tr>
	<tr>
<%
	rs = facturas.dameCreditosTodosV();	
	BigDecimal tsV = new BigDecimal("0.00");
	String colorestatusV = "";
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
		<td colspan="6"><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center"><strong>* <%=clienteV%> ADEUDA EN TOTAL ...*</strong></div></font></td>
		<td><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center">$ <%=facturas.formatoDinero(sumaAdeudosV.toString())%></div></font></td>				
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
	  <td><div align="center"><%= rs.getString("rfc") %>        </div>
	    </div></td>
	  <td><%= rs.getString("NombreE") %> </div></td>
	  <td><div align="center"><%= rs.getString("fechaCredito") %> </div></td>
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
			<td colspan="6"><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center"><strong>* <%=clienteV%> ADEUDA EN TOTAL ...*</strong></div></font></td>
			<td><font face="Eras Medium ITC" size="3" color="#0000CC"><div align="center">$ <%=facturas.formatoDinero(sumaAdeudosV.toString())%></div></font></td>				
  </tr>
<%	
	}
%>	
</table>
<br/>
  <table width="650" border="1" align="center">
    <tr> 
      <th width="532"><div align="center"><strong>Monto Total por Cr&eacute;ditos a Vendedores:</strong></div></th>
      <td width="102"><div align="right"><strong>$ <%=facturas.formatoDinero(tsV.toString())%></strong></div></td>
	</tr>
  </table>
<%
	tsV = tsV.add(ts);
	tsV = tsV.setScale(2, RoundingMode.HALF_UP);		
%>
<br/>
  <table width="550" border="1" align="center">
    <tr> 
      <th width="379"><div align="center"><strong>MONTO TOTAL TODOS LOS CR&Eacute;DITOS: </strong></div></th>
      <td width="155"><div align="right"><strong>$ <%=facturas.formatoDinero(tsV.toString())%></strong></div></td>
	</tr>
  </table>
  
  
  <p align="center"><a href="Menu_Consul_Ventas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>