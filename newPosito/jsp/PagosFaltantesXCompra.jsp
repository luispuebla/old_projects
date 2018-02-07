<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="pa" class="com.alpha.bd.ManagerPagos" scope="page" />
<jsp:useBean id="prov" class="com.alpha.bd.ManagerProveedores" scope="page" />
<jsp:useBean id="com" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Pagos por Compra</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
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
	String proveedor = request.getParameter("proveedor");
	String claveOrden = request.getParameter("claveOrden");
	BigDecimal porPagar = new BigDecimal("0.00");
	BigDecimal yaPagado = new BigDecimal("0.00");	
	if(claveOrden == null){%>
 	<b class="roj">Debes seleccionar una Compra para mostrar sus Pagos.</b>
<% } else{
	String fechaHoy = com.dameFechaHoy();	 %>
<h1>Historial de Pago de la Compra # <%=claveOrden%> al d&iacute;a de Hoy (<%=fechaHoy%>)</h1>	
 <table width="850" border="1" align="center">
  <caption>
  Compra
  </caption>
  <tr> 
    <th width="57">Compra</th>
    <th width="88">Fecha</th>
	<th width="95">Desc. 1</th>
    <th width="104">Desc. 2</th>
    <th width="86">Desc. 3</th>
    <th width="92">SubTotal</th>
    <th width="94">Descuento</th>
    <th width="85">IVA</th>
    <th width="91">Total</th>
   </tr>
<%
	ResultSet rs1 = com.datosOrdenCompra2(claveOrden);
	while(rs1.next()){
	porPagar = new BigDecimal(rs1.getString("total"));
%>
  <tr> 
    <td><div align="center"><%=rs1.getString("claveOrden")%></div></td>
    <td><div align="center"><%=rs1.getString("fechaRegistro")%></div></td>
	<td><div align="right"><%=rs1.getString("descuento1")%> %</div></td>
    <td><div align="right"><%=rs1.getString("descuento2")%> %</div></td>
    <td><div align="right"><%=rs1.getString("descuento3")%> %</div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("subtotal"))%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("realDescuento"))%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("iva"))%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("total"))%></div></td>
  </tr>
<%
	}
	if(rs1 != null){
		rs1.close();
	}
	com.cierraConexion();							
%>	  
</table>
<p></p>
 <table width="800" border="1" align="center">
  <caption>
  PAGOS
  </caption>
  <tr> 
    <th width="71">Clave</th>
    <th width="121">Compra</th>
	<th width="128">Fecha</th>
    <th width="123">Monto</th>
    <th width="168">Forma de Pago</th>
    <th width="149">Cheque / Referencia</th>
   </tr>
<%
	ResultSet rs = pa.damePagosCompra2(claveOrden);
	while(rs.next()){
		BigDecimal temporalPago = new BigDecimal(rs.getString("monto"));
		yaPagado = yaPagado.add(temporalPago);		
%>
  <tr> 
    <td width="71"><div align="center"><%=rs.getString("consecutivo")%></div></td>
    <td width="121"><div align="center"><%=rs.getString("claveOrden")%></div></td>
	<td width="128"><div align="center"><%=rs.getString("fechaPago")%></div></td>
    <td width="123"><div align="right">$ <%=pa.formatoDinero(rs.getString("monto"))%></div></td>
    <td width="168"><div align="center">
<%
	if(rs.getInt("formaPago") == 1)
		out.print("Efectivo");
	if(rs.getInt("formaPago") == 2)
		out.print("Cheque");
	if(rs.getInt("formaPago") == 3)
		out.print("Depósito");
	if(rs.getInt("formaPago") == 4)
		out.print("Tarjeta de Crédito");
	if(rs.getInt("formaPago") == 5)
		out.print("Tarjeta de Débito");	
%>
    </div></td>
    <td width="149"><div align="center"><%=rs.getString("numeroCheque")%> &nbsp;</div></td>
  </tr>
<%
	}
	if(rs != null){
		rs.close();
	}
	pa.cierraConexion();
	BigDecimal restante = porPagar.subtract(yaPagado);
	restante = restante.setScale(2, RoundingMode.HALF_UP);	
%>	  
</table>
<p></p>
<table align="center" width="300" border="1">
  <caption>Restante por Pagar</caption>
  <tr>
  	<th>Faltante</th>
  </tr>
  <tr>
  	<td><div align="center"><b class="aviso">$ <%=com.formatoDinero(restante.toString())%></b></div></td>
  </tr>  
</table>
<%}%>
<p align="center"><a href="Consultas_Pagos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
