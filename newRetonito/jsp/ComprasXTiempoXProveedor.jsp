<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Muestra Consulta Compras por Proveedor</title>
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
	String claveProveedor = request.getParameter("clave");	
	String nombreProveedor = request.getParameter("nombreP");	
	String fechaInicial = request.getParameter("datebox");
	fechaInicial= fechaInicial.substring(6,10)+"-"+fechaInicial.substring(0,2)+"-"+fechaInicial.substring(3,5);
	String fechaFinal = request.getParameter("datebox2");
	fechaFinal= fechaFinal.substring(6,10)+"-"+fechaFinal.substring(0,2)+"-"+fechaFinal.substring(3,5);
	String fechaHoy = alCom.dameFechaHoy();
	BigDecimal totalComprado = new BigDecimal("0.00");
%>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=claveProveedor%>"/>
<jsp:setProperty name="alCom" property="fechaInicial" value="<%=fechaInicial%>"/>
<jsp:setProperty name="alCom" property="fechaFinal" value="<%=fechaFinal%>"/>
<h1>Compras al d&iacute;a de hoy (<%=fechaHoy%>), solicitadas <br/>al Proveedor <%=nombreProveedor%> (<%=claveProveedor%>), <br /> entre <%=fechaInicial%> a <%=fechaFinal%>:</h1>
<table width="780" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
  	<th width="78">Clave<br /> Compra</th>
	<th width="95">Fecha <br />Registro</th>
	<th width="82">Fecha <br />Entrega</th>
	<th width="139">Factura(s)/<br />Remision(es)</th>
	<th width="102">Importe<br />Total</th>
	<th width="116">Estado de<br />Transacci&oacute;n</th>
	<th width="122">Estado de<br />Pago</th>
  </tr>
  <%
  ResultSet rs = alCom.dameComprasXProveedorXTiempo2();
  while (rs.next()){
  	totalComprado = totalComprado.add(new BigDecimal(rs.getString("total")));
  	String facRem = rs.getString("docAval");
	String estatus = "";
	String pago = "";
	boolean primerE = true;
  	ResultSet rsInterno = alCom.dameFacturasRemisionesAdicionales(rs.getString("claveOrden"));
	while (rsInterno.next()){
		if(primerE){
			primerE = false;
			facRem += rsInterno.getString("docAval");
		}
		else{
			facRem += ", "+rsInterno.getString("docAval");
		}
	}
	if(rsInterno != null){
		rsInterno.close();
	}
	alCom.cierraConexion2();		// de ResultSet Complex						
	int estadoTransac = rs.getInt("Entrega");
	if(estadoTransac == 0){
		estatus = "Por entregar";
	}
	else if(estadoTransac == 1){
		estatus = "Parcialmente entregado";
	}
	else{
		estatus = "Finalizado";
	}
	int estadoPago = rs.getInt("pago");
	if(estadoPago == 0){
		pago = "Por Pagar";
	}
	else if(estadoPago == 1){
		pago = "Parcialmente Pagado";
	}
	else{
		pago = "Pagado";
	}

%>
  <tr>
  	<td><div align="center"><%=rs.getString("claveOrden")%></div></td>
  	<td><div align="center"><%=rs.getString("fechaRegistro")%></div></td>
  	<td><div align="center"><%=rs.getString("fechaEntrega")%></div></td>
	<td><div align="center"><%=facRem%>&nbsp;</div></td>
	<td><div align="right">$ <%=alCom.formatoDinero(rs.getString("total"))%></div></td>
	<td><div align="center"><%=estatus%></div></td>	
	<td><div align="center"><%=pago%></div></td>	
  </tr>
<%  
  }
	if(rs != null){
		rs.close();
	}
	alCom.cierraConexion();		// de ResultSet Complex	
	totalComprado = totalComprado.setScale(2, RoundingMode.HALF_UP);			  
%>  
<tr>
	<th colspan="4">TOTAL COMPRADO: </th>
	<td height="40"><div align="right"><b>$ <%=alCom.formatoDinero(totalComprado.toString())%></b></div></td>
	<th colspan="2">&nbsp;</th>
</tr>
</table>
	
<p align="center"><a href="Consultas_Compras.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
