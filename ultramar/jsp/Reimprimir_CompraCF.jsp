<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.ult.bd.ManagerCompras" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Reimpresi&oacute;n de &Oacute;rden de Compra</title>
<link href="ultramarinaMiniCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

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
	String claveOrden = "";
	claveOrden = request.getParameter("claveOrden");
%>
<body onLoad="imprimirPagina(); Cerrar()">
<jsp:setProperty name="alCom" property="claveOrden" value="<%=claveOrden%>"/>
<% 
String NomProv = alCom.dameNombreProveedor2();
String FechaEntrega = alCom.DameFechaEntrega();
%>
<table width="600" border="1">
	<caption>Clave de Venta: <%=claveOrden%></caption>
	<tr>
		<th width="69">Proveedor</th>
		<td width="215"><%=NomProv%></td>
		<th width="146">Fecha Aproximada de Entrega</th>
		<td width="81"><%=FechaEntrega%></td>
	</tr>
</table>
<p></p>
	<table width="650" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
	  	<th width="64">Cantidad<br />Solicitada</th>	
	  	<th width="72">Cantidad<br />Ya Entregada</th>		
	  	<th width="61">Cantidad<br />Por Entregar</th>				
		<th width="255">Producto</th>
		<th width="92">Precio<br />Unitaro</th>
		<th width="92">Importe</th>
	  </tr>
<%
	ResultSet rs = alCom.dameProductosCompradosYEntregas();
	while (rs.next()){
	String ti = rs.getString("ClaveProducto");
	ti = ti.substring(ti.length()-1);
		if(ti.equalsIgnoreCase("A"))
			ti = " --> Kg.";
		if(ti.equalsIgnoreCase("B"))
			ti = " --> Unidades";
		if(ti.equalsIgnoreCase("C"))
			ti = " --> Botella1";
		if(ti.equalsIgnoreCase("D"))
			ti = " --> Botella2";
%>
      <tr>
		<td><div align="center"><%=rs.getString("Cantidad")%></div></td>
		<td><div align="center"><%=rs.getString("Llegan")%></div></td>
		<td><div align="center"><%=rs.getString("Faltantes")%></div></td>
		<td><div align="center"><%=rs.getString("descripcion")+ti%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(rs.getString("Costo"))%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(rs.getString("Importe"))%></div></td>
      </tr>
<%	
}
%>	  	    	  
	</table>
	<br />
<%
	ResultSet datosCompraRS = alCom.dameResumenCompra();
	int unaEntrada = 1;
	while (datosCompraRS.next() && unaEntrada == 1){
		unaEntrada++;
	
%>
<table width="650" border="1">
<tr>
	<th width="246">Observaciones</th>
	<th width="92">&nbsp;</th>
	<td width="78">&nbsp;</td>
	<th width="111">Subtotal</th>
	<td width="91"><div align="right">$<%=alCom.formatoDinero(datosCompraRS.getString("subtotal"))%>
	  </div></td>
</tr>
<tr>
	<td rowspan="3"><textarea name="observaciones" cols="35" rows="5"><%=datosCompraRS.getString("observaciones")%></textarea></td>
	<th>Descuento 1</th>
	<td><div align="center"> <%=datosCompraRS.getString("descuento1")%> %</div></td>
	<th height="34"><div align="center"><strong>Descuento</strong></div></th>
	<td height="34"><div align="right">$ <%= alCom.formatoDinero(datosCompraRS.getString("descuento"))%>
	  </div></td>
</tr>
<tr>
  <th>Descuento 2</th>
  <td><div align="center"> <%= datosCompraRS.getString("descuento2")%> %</div></td>
	<th height="35"><div align="center"><strong>I.V.A.</strong></div></th>
  <td height="35"><div align="right">$ <%= alCom.formatoDinero(datosCompraRS.getString("iva"))%>
  </div></td>
</tr>
<tr>
  <th>Descuento 3</th>
  <td><div align="center"> <%= datosCompraRS.getString("descuento3")%> %</div></td>
<th><div align="center"><strong>TOTAL</strong></div></th>
  <td><div align="right">$ <%= alCom.formatoDinero(datosCompraRS.getString("total"))%>  </div></td>
</tr>
</table>
<%
	}
	alCom.cierraConexion();%>	
</body>
</html>
