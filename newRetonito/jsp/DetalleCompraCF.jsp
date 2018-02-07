<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Reimpresi&oacute;n de &Oacute;rden de Compra</title>
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
//-->
</script>
</head>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String claveOrden = "";
	claveOrden = request.getQueryString();
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<jsp:setProperty name="alCom" property="claveOrden" value="<%=claveOrden%>"/>
<% 
String NomProv = alCom.dameNombreProveedor2();
String FechaEntrega = alCom.DameFechaEntrega();
	String[] ArrayCantidad = null;
	String[] ArrayLlegan = null;
	String[] ArrayProducto = null;
	String[] ArrayCUnidad = null;
	String[] ArrayTipo = null;
	String prodRegalo1 = "";
	String prodRegalo2 = "";
	String prodRegalo3 = "";
	String tipoUniRegalo1 = "";
	String tipoUniRegalo2 = "";
	String tipoUniRegalo3 = "";
	String cantidadRegalo1 = "";
	String cantidadRegalo2 = "";
	String cantidadRegalo3 = "";
	String llegaRegalo1 = "";
	String llegaRegalo2 = "";
	String llegaRegalo3 = "";

	ResultSet rsProComprados = alCom.dameProductosComprados(claveOrden);
	int numeroProductosComprados = 0;
	while (rsProComprados.next()){
		numeroProductosComprados ++;
	}
	rsProComprados.beforeFirst();
	ArrayCantidad = new String[numeroProductosComprados];
	ArrayLlegan = new String[numeroProductosComprados];
	ArrayProducto = new String[numeroProductosComprados];
	ArrayTipo = new String[numeroProductosComprados];
	int contI = 0;
	while (rsProComprados.next()){
		String tipoP = "Pieza";
		if(rsProComprados.getInt("Tipo") == 1){
			tipoP = "Caja";
		}
		else if (rsProComprados.getInt("Tipo") == 2){
			tipoP = "Kilo";
		}
		ArrayCantidad[contI] = rsProComprados.getString("Cantidad");
		ArrayLlegan[contI] = rsProComprados.getString("Llegan");
		ArrayProducto[contI] = rsProComprados.getString("ClaveProducto");
		ArrayTipo[contI] = tipoP;
		contI++;
	}
	rsProComprados.close();
	alCom.cierraConexion();	
	ResultSet rsProObsequiados = alCom.dameProductosObsequiados(claveOrden);
	int contIO = 1;
	while (rsProObsequiados.next()){
		String tipoP = "Pieza";
		if(rsProObsequiados.getInt("Tipo") == 1){
			tipoP = "Caja";
		}
		else if (rsProObsequiados.getInt("Tipo") == 2){
			tipoP = "Kilo";
		}			
		if(contIO == 1){
			prodRegalo1 = rsProObsequiados.getString("ClaveProducto");
			tipoUniRegalo1 = tipoP;
			cantidadRegalo1 = rsProObsequiados.getString("Cantidad");
			llegaRegalo1 = rsProObsequiados.getString("Llegan");
		}
		else if(contIO == 2){
			prodRegalo2 = rsProObsequiados.getString("ClaveProducto");
			tipoUniRegalo2 = tipoP;
			cantidadRegalo2 = rsProObsequiados.getString("Cantidad");
			llegaRegalo2 = rsProObsequiados.getString("Llegan");
		}
		else{
			prodRegalo3 = rsProObsequiados.getString("ClaveProducto");
			tipoUniRegalo3 = tipoP;
			cantidadRegalo3 = rsProObsequiados.getString("Cantidad");			
			llegaRegalo3 = rsProObsequiados.getString("Llegan");
		}
		contIO ++;
	}
	rsProObsequiados.close();
	alCom.cierraConexion();	

%>
<table width="600" border="1">
	<caption>
	Clave de Pedido (Compra): <%=claveOrden%></caption>
	<tr>
		<th width="69">Proveedor</th>
		<td width="215"><%=NomProv%></td>
		<th width="146">Fecha Aproximada de Entrega</th>
		<td width="81"><%=FechaEntrega%></td>
	</tr>
</table>
<p></p>
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>PRODUCTOS COMPRADOS</caption>
	  <tr>
	  	<th width="123"><div align="center">Cantidad Pedida</div></th>
	  	<th width="137"><div align="center">Cantidad Recibida</div></th>		
		<th width="201"><div align="center">Producto</div></th>
	  	<th width="129"><div align="center">Tipo</div></th>		
	  </tr>
<%
for (int i = 0; i<ArrayProducto.length; i++){
	if(!(ArrayProducto[i].equalsIgnoreCase(""))){
		BigDecimal totalpro = new BigDecimal(ArrayCantidad[i]);
		BigDecimal llegaron = new BigDecimal(ArrayLlegan[i]);
		totalpro = totalpro.setScale(3, RoundingMode.HALF_UP);					
		llegaron = llegaron.setScale(3, RoundingMode.HALF_UP);					
		String pide = alCom.dameEnteros(totalpro.toString());
		String llega = alCom.dameEnteros(llegaron.toString());
		if (ArrayTipo[i].equalsIgnoreCase("Kilo")){
			pide = totalpro.toString();
			llega =llegaron.toString();
		}			
%>
      <tr>
		<td><div align="center"><%=pide%></div></td>
		<td><div align="center"><%=llega%></div></td>
		<td><div align="center"><%=alCom.dameDescripcionProducto(ArrayProducto[i])%></div></td>
		<td><div align="center"><%=ArrayTipo[i]%></div></td>
      </tr>
<%	
	}}
%>	  	  
	</table>
<p></p>
<% if (!prodRegalo1.equals("") || !prodRegalo2.equals("") || !prodRegalo3.equals("")) { %>
  <table width="600" border="1" onClick="imprimirPagina()">
  <caption> OBSEQUIOS EXTRAS  </caption>
	  <tr>
	  	<th width="123"><div align="center">Cantidad Obsequiada</div></th>
	  	<th width="137"><div align="center">Cantidad Recibida</div></th>		
		<th width="201"><div align="center">Producto</div></th>
	  	<th width="129"><div align="center">Tipo</div></th>		
	  </tr>
<%
	if(!prodRegalo1.equals("")){
		BigDecimal totalpro = new BigDecimal(cantidadRegalo1);
		BigDecimal llegaron = new BigDecimal(llegaRegalo1);
		totalpro = totalpro.setScale(3, RoundingMode.HALF_UP);					
		llegaron = llegaron.setScale(3, RoundingMode.HALF_UP);					
		String pide = alCom.dameEnteros(totalpro.toString());
		String llega = alCom.dameEnteros(llegaron.toString());	
		if (tipoUniRegalo1.equalsIgnoreCase("Kilo")){
			pide = totalpro.toString();
			llega = llegaron.toString();	
		}					
%> 
	  <tr>
		<td><div align="center"><%=pide%></div></td>
		<td><div align="center"><%=llega%></div></td>
		<td><div align="center"><%=alCom.dameDescripcionProducto(prodRegalo1)%></div></td>
		<td><div align="center"><%=tipoUniRegalo1%></div></td>	  
	  </tr>
<%}	if(!prodRegalo2.equals("")){ 
		BigDecimal totalpro = new BigDecimal(cantidadRegalo2);
		BigDecimal llegaron = new BigDecimal(llegaRegalo2);
		totalpro = totalpro.setScale(3, RoundingMode.HALF_UP);					
		llegaron = llegaron.setScale(3, RoundingMode.HALF_UP);					
		String pide = alCom.dameEnteros(totalpro.toString());
		String llega = alCom.dameEnteros(llegaron.toString());	
		if (tipoUniRegalo2.equalsIgnoreCase("Kilo")){
			pide = totalpro.toString();
			llega = llegaron.toString();	
		}			
%> 
	  <tr>
		<td><div align="center"><%=pide%></div></td>
		<td><div align="center"><%=llega%></div></td>
		<td><div align="center"><%=alCom.dameDescripcionProducto(prodRegalo2)%></div></td>
		<td><div align="center"><%=tipoUniRegalo2%></div></td>	  
	  </tr>
<%} if(!prodRegalo3.equals("")){ 
		BigDecimal totalpro = new BigDecimal(cantidadRegalo3);
		BigDecimal llegaron = new BigDecimal(llegaRegalo3);
		totalpro = totalpro.setScale(3, RoundingMode.HALF_UP);					
		llegaron = llegaron.setScale(3, RoundingMode.HALF_UP);					
		String pide = alCom.dameEnteros(totalpro.toString());
		String llega = alCom.dameEnteros(llegaron.toString());	
		if (tipoUniRegalo3.equalsIgnoreCase("Kilo")){
			pide = totalpro.toString();
			llega = llegaron.toString();	
		}			
%> 
	  <tr>
		<td><div align="center"><%=pide%></div></td>
		<td><div align="center"><%=llega%></div></td>
		<td><div align="center"><%=alCom.dameDescripcionProducto(prodRegalo3)%></div></td>
		<td><div align="center"><%=tipoUniRegalo3%></div></td>	  

	  </tr>
<%}%>
</table>
<% } %>
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
<div align="center">
  <%
	}
	if(datosCompraRS != null){
		datosCompraRS.close();
	}
	alCom.cierraConexion();		// de ResultSet Complex									
%>	
  <br />
    <a href="javascript:window.close()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Image3" width="132" height="41" border="0"></a>
</div>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
