<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" scope="page" />

<html>
<head>
<title>Muestra Consulta Facturas en Tiempo por Cliente</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script>
<!--
function MandaSubmit(f){
	f.submit();
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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
-->
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String fechaInicial = request.getParameter("datebox");
	fechaInicial= fechaInicial.substring(6,10)+"-"+fechaInicial.substring(0,2)+"-"+fechaInicial.substring(3,5);
	String fechaFinal = request.getParameter("datebox2");
	fechaFinal= fechaFinal.substring(6,10)+"-"+fechaFinal.substring(0,2)+"-"+fechaFinal.substring(3,5);
%>
<h1>Facturas del <%=fechaInicial%> al <%=fechaFinal%></h1>
<table width="850" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<th width="116">Fecha<br/>en<br/>Factura</th>	  	
	<th width="105">Factura<br/>No.</th>
	<th width="73">RFC</th>	
	<th width="188">Cliente</th>		
	<th width="91">Tasa 0%</th>
	<th width="87">Tasa 15%</th>
 	<th width="80">Iva</th>
 	<th width="92">Total</th>	
 </tr>
  <%
  ResultSet rs = facturas.dameFacturasXTiempo(fechaInicial,fechaFinal);
  BigDecimal sumaTasa0 = new BigDecimal("0.00");
  BigDecimal sumaTasa15 = new BigDecimal("0.00");
  BigDecimal sumaIva = new BigDecimal("0.00");
  BigDecimal sumaTotal = new BigDecimal("0.00");      
  while (rs.next()){
  	BigDecimal temporal = new BigDecimal(rs.getString("tasa0"));
	sumaTasa0 = sumaTasa0.add(temporal);
  	temporal = new BigDecimal(rs.getString("tasa15"));
	sumaTasa15 = sumaTasa15.add(temporal);
  	temporal = new BigDecimal(rs.getString("iva"));
	sumaIva = sumaIva.add(temporal);
  	temporal = new BigDecimal(rs.getString("total"));
	sumaTotal = sumaTotal.add(temporal);	
%>
  <tr>
	<td><div align="center"><%=rs.getString("fechaFac")%></div></td>	  	
	<td><div align="center"><%=rs.getString("numFactura")%></div></td>
	<td><div align="center"><%=rs.getString("RFC")%></div></td>	
	<td><%=rs.getString("nombre")%></td>		
	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("tasa0"))%></div></td>
	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("tasa15"))%></div></td>
 	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("iva"))%></div></td>
 	<td><div align="right">$ <%=facturas.formatoDinero(rs.getString("total"))%></div></td>	
  </tr>
<%  
  }
	if(rs != null){
		rs.close();
	}		
	facturas.cierraConexion();	
	sumaTasa0 = sumaTasa0.setScale(2, RoundingMode.HALF_UP);
	sumaTasa15 = sumaTasa15.setScale(2, RoundingMode.HALF_UP);
	sumaIva = sumaIva.setScale(2, RoundingMode.HALF_UP);
	sumaTotal = sumaTotal.setScale(2, RoundingMode.HALF_UP);  
%>  
  <tr>
  	<th colspan="4">TOTALES:</th>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(sumaTasa0.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(sumaTasa15.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=facturas.formatoDinero(sumaIva.toString())%></b></div></td>
	<td width="92"><div align="right"><b>$ <%=facturas.formatoDinero(sumaTotal.toString())%></b></div></td>			
  </tr>
</table>

<table border="0" width="300">
	<tr>
		<td valign="top">	
			<form name="form1" target="_blank" action="ImprimirFacturasXTiempo.jsp" method="post">
			<p align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="132" height="41" border="0"></a></p>
			<input type="hidden" name="fechaInicial" value="<%=fechaInicial%>">
			<input type="hidden" name="fechaFinal" value="<%=fechaFinal%>">
			</form>
		</td>
		<td>&nbsp;</td>	
		<td valign="top"><a href="Menu_FacturasV.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></td>		
	</tr>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
