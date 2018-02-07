<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="pro" class="com.alpha.bd.ManagerProveedores" />
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />
<jsp:useBean id="produ" class="com.alpha.bd.ManagerPro" scope="page" />

<html>
<head>
<title>Muestra Consulta Productos</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script>

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
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
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
	String anio = request.getParameter("aaaa");
	String mes = request.getParameter("mes");
	String produc = request.getParameter("clave");
	ResultSet porMes = produ.Producto_Mes(anio+"-"+mes+"-",produc);
	BigDecimal cantidadPedidaPz = new BigDecimal ("0.00");
	BigDecimal cantidadPedidaCj = new BigDecimal ("0.00");
	BigDecimal cantidadPedidaKg = new BigDecimal ("0.00");		
	BigDecimal cantidadLlegadaPz = new BigDecimal ("0.00");
	BigDecimal cantidadLlegadaCj = new BigDecimal ("0.00");
	BigDecimal cantidadLlegadaKg = new BigDecimal ("0.00");		
	String fechaHoy = alCom.dameFechaHoy();			
%>
<h1>Cantidad de producto comprado hasta hoy (<%=fechaHoy%>) para el mes de <%=mes%> / <%=anio%></h1>
<jsp:setProperty name="alCom" property="claveProducto" value="<%=produc%>"/>
<p>
<table align="center" width="550" cellpadding="0" cellspacing="0" border="1">
  <tr>
    <th width="133">Producto:</th>
	<td width="411" height="50"><div align="center"><b class="titulos"><%= alCom.dameDescripcionProducto(produc)%></b></div></td>
  </tr>
</table>
<p></p>
<table width="750" border="1" cellpadding="0" cellspacing="0">
  <tr> 
    <th width="71">Clave<br/>Compra</th>  
	<th width="114">Proveedor</th>  	
    <th width="114">Fecha(s)<br/>Entrega(s)</th>
    <th width="121">Factura(s)</th>
    <th width="123">Cantidad<br/>Pedida</th>
	<th width="125">Cantidad<br/>Recibida</th>
	<th width="66">Tipo</th>	
  </tr>
<% 		
	while (porMes.next()){
		String cantidadSolicitada = alCom.dameEnteros(porMes.getString("Cantidad"));
		String cantidadRecibida = alCom.dameEnteros(porMes.getString("Llegan"));
		ResultSet mas3 = alCom.dameFacturasExtras(porMes.getString("ClaveOrden"));
		String factu3 = porMes.getString("docAval");
		String factufe3 = porMes.getString("FechaEntrega");
		while(mas3.next()){
			factu3 = factu3+" / "+mas3.getString("docAval");
			factufe3 = factufe3+" / "+mas3.getString("fechaDoc");
		}
		if(mas3 != null){
			mas3.close();
		}
		alCom.cierraConexion2();
		String tipoProd = "Pieza";
		if(porMes.getInt("Tipo") == 0){
			cantidadPedidaPz = cantidadPedidaPz.add(new BigDecimal(porMes.getString("Cantidad")));
			cantidadLlegadaPz = cantidadLlegadaPz.add(new BigDecimal(porMes.getString("Llegan")));		
		}
		if(porMes.getInt("Tipo") == 1){
			tipoProd = "Caja";
			cantidadPedidaCj = cantidadPedidaCj.add(new BigDecimal(porMes.getString("Cantidad")));
			cantidadLlegadaCj = cantidadLlegadaCj.add(new BigDecimal(porMes.getString("Llegan")));					
		}
		else if(porMes.getInt("Tipo") == 2){
			tipoProd = "Kilo";
			cantidadSolicitada = porMes.getString("Cantidad");
			cantidadRecibida = porMes.getString("Llegan");
			cantidadPedidaKg = cantidadPedidaKg.add(new BigDecimal(porMes.getString("Cantidad")));
			cantidadLlegadaKg = cantidadLlegadaKg.add(new BigDecimal(porMes.getString("Llegan")));			
		}
%>
  <tr> 
  	<td><div align="center"><%=porMes.getString("claveOrden")%></div></td>
	<td><div align="center"><%=porMes.getString("nombre")%></div></td>
	<td><div align="center"><%=factufe3%></div></td>
	<td><div align="center"><%=factu3%></div></td>
	<td><div align="center"><%=cantidadSolicitada%></div></td>
	<td><div align="center"><%=cantidadRecibida%></div></td>
    <td><div align="center"><%= tipoProd %></div></td>
  </tr>

<% 
	}
	if(porMes != null){
		porMes.close();
	}
	alCom.cierraConexion();		// de ResultSet Complex					
	cantidadPedidaPz = cantidadPedidaPz.setScale(3, RoundingMode.HALF_UP);
	cantidadLlegadaPz = cantidadLlegadaPz.setScale(3, RoundingMode.HALF_UP);			
	cantidadPedidaCj = cantidadPedidaCj.setScale(3, RoundingMode.HALF_UP);
	cantidadLlegadaCj = cantidadLlegadaCj.setScale(3, RoundingMode.HALF_UP);			
	cantidadPedidaKg = cantidadPedidaKg.setScale(3, RoundingMode.HALF_UP);
	cantidadLlegadaKg = cantidadLlegadaKg.setScale(3, RoundingMode.HALF_UP);			
%> 

  <tr> 
    <th colspan="4" rowspan="3"><div align="right">T O T A L E S: </div></th>
    <td><table width="100%" cellpadding="0" cellspacing="0"> 
    <tr> <th width="65%">Piezas</th> <td width="40%"><div align="right"><b><%= alCom.formatoDinero(cantidadPedidaPz.toString()) %></b></div></td></tr> </table></td>
    <td><table width="100%"  cellpadding="0" cellspacing="0"> <tr> <th width="65%">Piezas</th> <td width="40%"><div align="right"><b><%= alCom.formatoDinero(cantidadLlegadaPz.toString()) %></b></div></td></tr> </table></td>
    <th>&nbsp;</th>	
  </tr>
  <tr> 
    <td><table width="100%"  cellpadding="0" cellspacing="0"> <tr> <th width="65%">Cajas</th> <td width="40%"><div align="right"><b><%= alCom.formatoDinero(cantidadPedidaCj.toString()) %></b></div></td></tr> </table></td>
    <td><table width="100%"  cellpadding="0" cellspacing="0"> <tr> <th width="65%">Cajas</th> <td width="40%"><div align="right"><b><%= alCom.formatoDinero(cantidadLlegadaCj.toString()) %></b></div></td></tr> </table></td>
    <th>&nbsp;</th>	
  </tr>
  <tr> 
    <td><table width="100%"  cellpadding="0" cellspacing="0"> <tr> <th width="65%">Kg.</th> <td width="40%"><div align="right"><b><%= alCom.formatoDinero(cantidadPedidaKg.toString()) %></b></div></td></tr> </table></td>
    <td><table width="100%"  cellpadding="0" cellspacing="0"> <tr> <th width="65%">Kg.</th> <td width="40%"><div align="right"><b><%= alCom.formatoDinero(cantidadLlegadaKg.toString()) %></b></div></td></tr> </table></td>
    <th>&nbsp;</th>	
  </tr>
</p>
</table>
<p align="center"><font color="#FFFFFF"><a href="Consultas_Compras.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></font></p>
<p align="center"><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>
