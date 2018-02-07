<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="alCom" class="com.ult.bd.ManagerCompras" scope="page" />

<html>
<head>
<title>Muestra Consulta Compras por Recibir</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
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
%>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=claveProveedor%>"/>
<jsp:setProperty name="alCom" property="fechaInicial" value="<%=fechaInicial%>"/>
<jsp:setProperty name="alCom" property="fechaFinal" value="<%=fechaFinal%>"/>
<h1>Compras  del <%=fechaInicial%> al <%=fechaFinal%><br />
  correspondientes a<br />
  <%=nombreProveedor%>, (<%=claveProveedor%>):</h1>
<table width="780" border="1" align="center">
  <tr>
  	<th width="79">Clave<br /> Compra</th>
	<th width="79">Fecha <br />Entrega</th>
	<th width="114">Factura(s)/<br />Remision(es)</th>
	<th width="87">Importe<br />Total</th>
	<th width="146">Responsable</th>
	<th width="117">Estado de<br />Transacci&oacute;n</th>
	<th width="112">Estado de<br />Pago</th>
  </tr>
  <%
  ResultSet rs = alCom.dameComprasXProveedorXTiempo2();
  while (rs.next()){
  	String facRem = rs.getString("factura");
	String estatus = "";
	String pago = "";
  	ResultSet rsInterno = alCom.dameFacturasRemisionesAdicionales(rs.getString("claveOrden"));
	while (rsInterno.next()){
		facRem += ", "+rsInterno.getString("factura");
	}
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
  	<td><div align="center"><%=rs.getString("fechaEntrega")%></div></td>
	<td><div align="center"><%=facRem%></div></td>
	<td><div align="right">$ <%=alCom.formatoDinero(rs.getString("total"))%></div></td>
	<td><div align="center"><%=rs.getString("Nombre")%></div></td>
	<td><div align="center"><%=estatus%></div></td>	
	<td><div align="center"><%=pago%></div></td>	
  </tr>
<%  
  }
%>  
</table>
<%
alCom.cierraConexion();

%>
	
	
<p align="center"><a href="Consultas_Proveedores.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
