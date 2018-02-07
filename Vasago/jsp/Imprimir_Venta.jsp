<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />
<jsp:useBean id="numL" class="com.vas.bd.n2t" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Impresi&oacute;n Remisi&oacute;n</title>
<link href="vasagoRemisionCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--


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
//-->
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 14px;
	font-weight: bold;
}
.style2 {
	font-size: 14px;
	font-weight: normal;
}
-->
</style>
</head>
<%
	String claveOrden = "";
	String observaciones = "&nbsp;";
	String subTotal = "";
	String iva = "";
	String remision = "";
	String total = "";	
	String fAlta = "";
	String fEntrega = "";
	String repartidor = "";
	ResultSet rs = null;
	ResultSet rsPV = null;
	ResultSet rsPO = null;
	claveOrden = request.getParameter("claveOrden");
	String cliente = alVen.datosClienteImpTabla(claveOrden);
	remision = alVen.numRemisionImp(claveOrden);
	boolean hayProductosV = alVen.hayProductosV(claveOrden);
	boolean hayProductosO = alVen.hayProductosO(claveOrden);
	if(hayProductosV){	
		rsPV = alVen.productosVImp(claveOrden);
	}
	if (hayProductosO){
		rsPO = alVen.productosOImp(claveOrden);
	}
	rs = alVen.datosVentaImp(claveOrden);
	while (rs.next()){
	String tempOb = rs.getString("observaciones");
		if(! tempOb.trim().equals("")){
			observaciones = rs.getString("observaciones");
		}
		fAlta = rs.getString("fechaAlta");
		fEntrega = rs.getString("fechaEntrega");
		subTotal = alVen.formatoDinero(rs.getString("subtotal"));
		iva = alVen.formatoDinero(rs.getString("iva"));
		total = alVen.formatoDinero(rs.getString("total"));
		repartidor = rs.getString("repartidor");
	}
	if(rs != null){
		rs.close();
	}
	alVen.cierraConexion();		// de ResultSet Complex											
%>
<body onLoad="imprimirPagina(); Cerrar()">
<table width="750" height="1000" border="0" cellpadding="0" cellspacing="0">
	<tr>
	  <td><table width="700" cellpadding="0" cellspacing="0" vspace="0" hspace="0" >
				<tr>
					<td colspan="5"><div align="center" class="style1">DISTRIBUIDORA VASAGO</div></td>
				</tr>		
				<tr>
					<th width="150">Fecha Alta: </th>
					<td width="100"><div align="center"><%=fAlta.substring(8,10)+" / "+fAlta.substring(5,7)+" / "+fAlta.substring(0,4)%></div></td>
					<th width="151">Fecha Entrega:</th>
					<td width="100"><div align="center"><%=fEntrega.substring(8,10)+" / "+fEntrega.substring(5,7)+" / "+fEntrega.substring(0,4)%></div></td>
					<th width="197"><div align="center" class="style2">Original</div></th>
				</tr>		
	  </table></td>	  
  	</tr>
	<tr>
	  <td><table width="700" cellpadding="0" cellspacing="0" vspace="0" hspace="0" >
				<tr>
					<th width="104">Cliente:</th>
					<td width="363"><div align="center"><b class="alta"><%=cliente%></b></div></td>
					<th width="112">No. Remisi&oacute;n:</th>
					<td width="51"><div align="center"><b class="alta"><%=remision%></b></div></td>
				</tr>		
	  </table></td>
	</tr>
<% if(hayProductosV && hayProductosO){%>
	<tr valign="top">
		<td><table width="700" cellpadding="0" cellspacing="0" vspace="0" hspace="0"  >
			<caption>Productos Vendidos: </caption>
			<tr >
				<th width="83">Cantidad</th>
				<th width="361">Producto</th>
				<th width="125">$ Unitario</th>
				<th width="129">$ Importe</th>								
			</tr>	
<%  
	while (rsPV.next()){	
		String unidad= "";
		unidad=alVen.dameTipoDeUnidad(rsPV.getString("ClaveProducto"));
%>		
			<tr valign="top">
				<td><div align="center"><%=rsPV.getString("Cantidad")%> <%=unidad%> </div></td>
				<td><%=rsPV.getString("Nombre")%></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Costo"))%></div></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Importe"))%></div></td>
			</tr>
<%		
	}
%>
			<tr>
				<td colspan="2" rowspan="3">Importe:<br/>*****<%=numL.convertirLetras(Integer.parseInt(alVen.dameEnteros(alVen.remueveComas(total))))%> pesos <%=alVen.dameDecimales(alVen.acortaLongitud(total))%>/100 M.N.*****</td>
				<th>Sub-Total</th>
				<td><div align="right"><%=subTotal%></div></td>				
			</tr>	
			<tr valign="top">
				<th>I.V.A.</th>
				<td><div align="right"><%=iva%></div></td>				
			</tr>	
			<tr >
				<th>Total</th>
				<td><div align="right"><%=total%></div></td>				
			</tr>	
			<tr></tr>
			<tr>
				<th colspan="4">Productos Obsequiados:</th>
			</tr>
			
			<tr>
				<th colspan="1">Cantidad</th>
				<th colspan="3">Producto</th>
			</tr>	
<%			while(rsPO.next()){ 
				String unidad = "";
				unidad = alVen.dameTipoDeUnidad(rsPO.getString("ClaveProducto"));
%>
			<tr>
				<td colspan="1"><div align="center"><%=rsPO.getString("Cantidad")%> <%=unidad%> </div></td>
				<td colspan="3"><%=rsPO.getString("Nombre")%></td>	
			</tr>
<%
	}
%>
			<tr></tr>
			<tr>
				<th colspan="4">Observaciones:</th>
			</tr>
			<tr>
				<th colspan="4"><%=observaciones%>
				<div align="left">Repartidor: <%=repartidor%></div></th>
			</tr>
	  </table></td>		
	</tr>
<% 	rsPV.beforeFirst(); 
	rsPO.beforeFirst();
} else if(hayProductosV && !hayProductosO){%>
	<tr valign="top">
		<td><table width="700" cellpadding="0" cellspacing="0" border="0" vspace="0" hspace="0"  >
			<caption>Productos Vendidos: </caption>
			<tr >
				<th width="83">Cantidad</th>
				<th width="361">Producto</th>
				<th width="125">$ Unitario</th>
				<th width="129">$ Importe</th>								
			</tr>	
<%  
	while (rsPV.next()){	
		String unidad= "";
		unidad=alVen.dameTipoDeUnidad(rsPV.getString("ClaveProducto"));
%>		
			<tr valign="top">
				<td><div align="center"><%=rsPV.getString("Cantidad")%> <%=unidad%></div></td>
				<td><%=rsPV.getString("Nombre")%></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Costo"))%></div></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Importe"))%></div></td>
			</tr>
<%		
	}
%>
			<tr>
				<td colspan="2" rowspan="3">Importe:<br/>*****<%=numL.convertirLetras(Integer.parseInt(alVen.dameEnteros(alVen.remueveComas(total))))%> pesos <%=alVen.dameDecimales(alVen.acortaLongitud(total))%>/100 M.N.*****</td>
				<th>Sub-Total</th>
				<td><div align="right"><%=subTotal%></div></td>				
			</tr>	
			<tr valign="top">
				<th>I.V.A.</th>
				<td><div align="right"><%=iva%></div></td>				
			</tr>	
			<tr >
				<th>Total</th>
				<td><div align="right"><%=total%></div></td>				
			</tr>	
			<tr></tr>
			<tr>
				<th colspan="4">Observaciones:</th>
			</tr>
			<tr>
				<th colspan="4"><%=observaciones%>
				<div align="left">Repartidor: <%=repartidor%></div></th>
			</tr>
	  </table></td>		
	</tr>
<% 	rsPV.beforeFirst();
} else if (hayProductosO && !hayProductosV){%>	
	<tr valign="top">
		<td><table width="700" cellpadding="0" cellspacing="0" vspace="0" hspace="0" height="0" border="0" >
			<tr>
				<th colspan="4">Productos Obsequiados:</th>
			</tr>			
			<tr>
				<th width="102" colspan="1">Cantidad</th>
				<th width="598" colspan="3">Producto</th>
			</tr>	
<%			while(rsPO.next()){ 
				String unidad = "";
				unidad = alVen.dameTipoDeUnidad(rsPO.getString("ClaveProducto"));
%>
			<tr>
				<td colspan="1"><div align="center"><%=rsPO.getString("Cantidad")%> <%=unidad%></div></td>
				<td colspan="3"><%=rsPO.getString("Nombre")%></td>	
			</tr>
<%			}	%>
			<tr></tr>
			<tr>
				<th colspan="4">Observaciones:</th>
			</tr>
			<tr>
				<th colspan="4"><%=observaciones%>
				<div align="left">Repartidor: <%=repartidor%></div></th>
			</tr>
	  </table></td>		
	</tr>
<% rsPO.beforeFirst();
} %>	
	<tr valign="bottom" >
		<td ><table width="700">
				<tr>
					<td colspan="5"><div align="center" class="style1">DISTRIBUIDORA VASAGO</div></td>
				</tr>		
				<tr>
					<th width="150">Fecha Alta: </th>
					<td width="100"><div align="center"><%=fAlta.substring(8,10)+" / "+fAlta.substring(5,7)+" / "+fAlta.substring(0,4)%></div></td>
					<th width="151">Fecha Entrega:</th>
					<td width="100"><div align="center"><%=fEntrega.substring(8,10)+" / "+fEntrega.substring(5,7)+" / "+fEntrega.substring(0,4)%></div></td>
					<th width="197"><div align="center" class="style2">Copia</div></th>
				</tr>		
	  </table></td>
  	</tr>
	<tr >
	  <td><table width="700" cellpadding="0" cellspacing="0" >
				<tr>
					<th width="104">Cliente:</th>
					<td width="363"><div align="center"><b class="alta"><%=cliente%></b></div></td>
					<th width="112">No. Remisi&oacute;n:</th>
					<td width="51"><div align="center"><b class="alta"><%=remision%></b></div></td>
				</tr>		
	  </table></td>
	</tr>
<% if(hayProductosV && hayProductosO){%>
	<tr valign="top">
		<td><table width="700" cellpadding="0" cellspacing="0" border="0" vspace="0" hspace="0"  >
			<caption>Productos Vendidos: </caption>
			<tr >
				<th width="83">Cantidad</th>
				<th width="361">Producto</th>
				<th width="125">$ Unitario</th>
				<th width="129">$ Importe</th>								
			</tr>	
<%  
	while (rsPV.next()){	
		String unidad= "";
		unidad=alVen.dameTipoDeUnidad(rsPV.getString("ClaveProducto"));
%>		
			<tr valign="top">
				<td><div align="center"><%=rsPV.getString("Cantidad")%> <%=unidad%></div></td>
				<td><%=rsPV.getString("Nombre")%></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Costo"))%></div></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Importe"))%></div></td>
			</tr>
<%		
	}
%>
			<tr>
				<td colspan="2" rowspan="3">Importe:<br/>*****<%=numL.convertirLetras(Integer.parseInt(alVen.dameEnteros(alVen.remueveComas(total))))%> pesos <%=alVen.dameDecimales(alVen.acortaLongitud(total))%>/100 M.N.*****</td>
				<th>Sub-Total</th>
				<td><div align="right"><%=subTotal%></div></td>				
			</tr>	
			<tr valign="top">
				<th>I.V.A.</th>
				<td><div align="right"><%=iva%></div></td>				
			</tr>	
			<tr >
				<th>Total</th>
				<td><div align="right"><%=total%></div></td>				
			</tr>	
			<tr></tr>
			<tr>
				<th colspan="4">Productos Obsequiados:</th>
			</tr>
			
			<tr>
				<th colspan="1">Cantidad</th>
				<th colspan="3">Producto</th>
			</tr>	
<%			while(rsPO.next()){ 
				String unidad = "";
				unidad = alVen.dameTipoDeUnidad(rsPO.getString("ClaveProducto"));
%>
			<tr>
				<td colspan="1"><div align="center"><%=rsPO.getString("Cantidad")%> <%=unidad%> </div></td>
				<td colspan="3"><%=rsPO.getString("Nombre")%></td>	
			</tr>
<%			}	%>
			<tr></tr>
			<tr>
				<th colspan="4">Observaciones:</th>
			</tr>
			<tr>
				<th colspan="4"><%=observaciones%>
				<div align="left">Repartidor: <%=repartidor%></div></th>
			</tr>
	  </table></td>		
	</tr>
<% 	rsPV.beforeFirst(); 
	rsPO.beforeFirst();
} else if(hayProductosV && !hayProductosO){%>
	<tr valign="top">
		<td><table width="700" cellpadding="0" cellspacing="0" border="0" vspace="0" hspace="0"  >
			<caption>Productos Vendidos: </caption>
			<tr >
				<th width="83">Cantidad</th>
				<th width="361">Producto</th>
				<th width="125">$ Unitario</th>
				<th width="129">$ Importe</th>								
			</tr>	
<%  
	while (rsPV.next()){	
		String unidad= "";
		unidad=alVen.dameTipoDeUnidad(rsPV.getString("ClaveProducto"));
%>		
			<tr valign="top">
				<td><div align="center"><%=rsPV.getString("Cantidad")%> <%=unidad%></div></td>
				<td><%=rsPV.getString("Nombre")%></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Costo"))%></div></td>			
				<td><div align="right"><%=alVen.formatoDinero(rsPV.getString("Importe"))%></div></td>
			</tr>
<%		
	}
%>
			<tr>
				<td colspan="2" rowspan="3">Importe:<br/>*****<%=numL.convertirLetras(Integer.parseInt(alVen.dameEnteros(alVen.remueveComas(total))))%> pesos <%=alVen.dameDecimales(alVen.acortaLongitud(total))%>/100 M.N.*****</td>
				<th>Sub-Total</th>
				<td><div align="right"><%=subTotal%></div></td>				
			</tr>	
			<tr valign="top">
				<th>I.V.A.</th>
				<td><div align="right"><%=iva%></div></td>				
			</tr>	
			<tr >
				<th>Total</th>
				<td><div align="right"><%=total%></div></td>				
			</tr>	
			<tr></tr>
			<tr>
				<th colspan="4">Observaciones:</th>
			</tr>
			<tr>
				<th colspan="4"><%=observaciones%>
				<div align="left">Repartidor: <%=repartidor%></div>	</th>
			</tr>
	  </table></td>		
	</tr>
<% 	rsPV.beforeFirst();
} else if (hayProductosO && !hayProductosV){%>	
	<tr valign="top">
		<td><table width="700" cellpadding="0" cellspacing="0" vspace="0" hspace="0" height="0" border="0" >
			<tr>
				<th colspan="4">Productos Obsequiados:</th>
			</tr>			
			<tr>
				<th width="102" colspan="1">Cantidad</th>
				<th width="598" colspan="3">Producto</th>
			</tr>	
<%			while(rsPO.next()){ 
				String unidad = "";
				unidad = alVen.dameTipoDeUnidad(rsPO.getString("ClaveProducto"));
%>
			<tr>
				<td colspan="1"><div align="center"><%=rsPO.getString("Cantidad")%> <%=unidad%> </div></td>
				<td colspan="3"><%=rsPO.getString("Nombre")%></td>	
			</tr>
<%			}	%>
			<tr></tr>
			<tr>
				<th colspan="4">Observaciones:</th>
			</tr>
			<tr>
				<th colspan="4"><%=observaciones%>
				<div align="left">Repartidor: <%=repartidor%></div></th>
			</tr>
	  </table></td>		
	</tr>
<% rsPO.beforeFirst();
}
if(rsPO != null){
	rsPO.close();
}
if(rsPV != null){
	rsPV.close();
}
alVen.cierraConexion();
 %>	
</table>
</body>
</html>
