<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />
<jsp:useBean id="numL" class="com.vas.bd.n2t" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Impresi&oacute;n Remisi&oacute;n</title>
<link href="vasagoFacturaCSS.css" rel="stylesheet" type="text/css">
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
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>
<%
	String cliente = "";
	String dirCliente = "";
	String ciuCliente = "";	
	String rfcCliente = "";
	String fecha = "";
	String subTotal = "";
	String claveOrden = "";
	String iva = "";
	boolean primeraEntrada = true;
	String tipoIVA = "0%";
	String total = "";
	ResultSet rs = null;
	ResultSet rsPV = null;
	ResultSet rsPO = null;
	int contadorProductos = 0;
	claveOrden = request.getParameter("claveOrden");
	fecha = alVen.datosFechaEImpTabla(claveOrden);
	System.out.println(fecha);
	rs = alVen.datosVentaClie(claveOrden);
	while (rs.next()){
		rfcCliente = rs.getString("rfc");
		cliente = rs.getString("nombre");
		dirCliente = rs.getString("direccion");
		ciuCliente = rs.getString("ciudad");
	}
	if(rs != null){
		rs.close();
	}
	alVen.cierraConexion();
	rs = alVen.datosVentaImp(claveOrden);
	while (rs.next()){
		subTotal = alVen.formatoDinero(rs.getString("subtotal"));
		iva = alVen.formatoDinero(rs.getString("iva"));
		total = alVen.formatoDinero(rs.getString("total"));
	}
	if(rs != null){
		rs.close();
	}
	alVen.cierraConexion();
	
%>
<body onLoad="imprimirPagina(); Cerrar()">
<div id="Layer1" style="position:absolute; left:564px; top:128px; width:210px; height:23px; z-index:1">
<table width="200" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td><div align="center">M&eacute;xico, D.F., a <%=fecha.substring(8,10)%> / <%=fecha.substring(5,7)%> / <%=fecha.substring(0,4)%></div></td>
	</tr>
</table>

</div>
<table width="460" border="0" cellpadding="0" cellspacing="0">
	<tr height="80">
		<td colspan="5">&nbsp; </td>
	</tr>
	<tr>
		<td width="18" height="18">&nbsp;</td>
		<td>&nbsp;</td>
		<td colspan="3"><div align="left"><%=cliente%></div></td>			
	</tr>
	<tr>
		<td width="18" height="25">&nbsp;</td>
		<td>&nbsp;</td>
		<td colspan="3"><div align="left"><%=dirCliente%></div></td>			
	</tr>
	<tr>
		<td width="18" height="25">&nbsp;</td>
		<td width="70">&nbsp;</td>
		<td width="127"><div align="left"><%=ciuCliente%></div></td>
		<td width="78">&nbsp;</td>
		<td width="117"><%=rfcCliente%></td>
	</tr>
</table>
<table width="760" cellpadding="0" cellspacing="0" border="0">
	<tr height="35">
		<td colspan="4">&nbsp;</td>
	</tr>
<% 
rsPV = alVen.productosVImp(claveOrden);
while(rsPV.next()){ 
	if(primeraEntrada){
		primeraEntrada = false;
		if(rsPV.getInt("GravaIva")== 1){
			tipoIVA = "15%";
		}
	}
	String unidad = "";
	unidad = alVen.dameTipoDeUnidad(rsPV.getString("ClaveProducto"));
	String laCantidadP = rsPV.getString("Cantidad");
	if(unidad.equalsIgnoreCase("Cajas")){
		laCantidadP = alVen.formatoMaxUnDecimal(laCantidadP);
	}
	contadorProductos++;%>
	<tr >
		<td width="111"><div align="center"><%=laCantidadP%> <%=unidad%></div></td>
		<td width="447"><div align="left"><%=rsPV.getString("Nombre")%></div></td>
		<td width="101"><div align="right"><%=alVen.formatoDinero(rsPV.getString("Costo"))%></div></td>
		<td width="101"><div align="right"><%=alVen.formatoDinero(rsPV.getString("Importe"))%></div></td>
	</tr>
<% } 
	if(rsPV != null){
		rsPV.close();
	}
	alVen.cierraConexion();
	rsPO = alVen.productosOImp(claveOrden);
	while(rsPO.next()){ 
		String unidad = "";
		unidad = alVen.dameTipoDeUnidad(rsPO.getString("ClaveProducto")); 
		String laCantidadP = rsPO.getString("Cantidad");
		if(unidad.equalsIgnoreCase("Cajas")){
			laCantidadP = alVen.formatoMaxUnDecimal(laCantidadP);
		}	
		 contadorProductos ++;%>
	<tr >
		<td><div align="center"><%=laCantidadP%> <%=unidad%></div></td>
		<td><%=rsPO.getString("Nombre")%></td>
		<td><div align="right">0.00
	      </div>
		</div></td>
		<td><div align="right">0.00
	      </div>
		</div></td>
	</tr>
<% } 
	if(rsPO != null){
		rsPO.close();
	}
	alVen.cierraConexion();
	while (contadorProductos <= 28){
		contadorProductos++;
%>	
	<tr >
		<td colspan="4">&nbsp;</td>
	</tr>
<% }%>
</table >
<table width="760" cellpadding="0" cellspacing="0" border="0">
<tr>
	<th width="558" rowspan="3" valign="middle" ><div align="center">*****<%=numL.convertirLetras(Integer.parseInt(alVen.dameEnteros(alVen.remueveComas(total))))%> pesos <%=alVen.dameDecimales(alVen.acortaLongitud(total))%>/100 M.N.*****</div></th>
	<td width="101">&nbsp;</td>
	<th width="101" valign="bottom" height="17"><div align="right"><%=subTotal%></div></th>		
</tr>
<tr>
	<td><div align="right"><%=tipoIVA%></div></td>
	<th height="21"><div align="right"><%=iva%></div></th>		
</tr>
<tr>
	<td>&nbsp;</td>
	<th height="18"><div align="right"><%=total%></div></th>		
</tr>
</table>
</body>
</html>
