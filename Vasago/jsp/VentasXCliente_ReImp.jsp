<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />

<html>
<head>
<title>Compras Faltantes</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script>
<!--
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
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String claveCliente = request.getParameter("clave");	
	String nombreCliente = request.getParameter("nombreP");	
	String fechaInicial = request.getParameter("datebox");
	fechaInicial= fechaInicial.substring(6,10)+"-"+fechaInicial.substring(0,2)+"-"+fechaInicial.substring(3,5);
	String fechaFinal = request.getParameter("datebox2");
	fechaFinal= fechaFinal.substring(6,10)+"-"+fechaFinal.substring(0,2)+"-"+fechaFinal.substring(3,5);
%>
<jsp:setProperty name="alVen" property="claveCliente" value="<%=claveCliente%>"/>
<jsp:setProperty name="alVen" property="fechaInicial" value="<%=fechaInicial%>"/>
<jsp:setProperty name="alVen" property="fechaFinal" value="<%=fechaFinal%>"/>
<h1>Ventas del <%=fechaInicial%> al <%=fechaFinal%><br />
  correspondientes a<br />
  <%=nombreCliente%>:</h1>
<table width="700" border="1" align="center">
  <caption>
  Para reimprimir Remisi&oacute;n y/o Factura dar click<br /> 
  en el bot&oacute;n correspondiente..
  </caption>
  <tr>
  	<th>Clave<br /> 
  	Venta </th>
	<th>Clave<br/>Cliente</th>
	<th>Fecha <br />Entrega</th>
	<th>Fecha <br />Alta</th>
	<th>Importe<br />Total</th>
	<th>Estado de<br />Transacci&oacute;n</th>
	<th>Estado de<br />Cobro</th>
	<th>Documento<br />Aval</th>
  </tr>
  <%
  int fn = 1;
  ResultSet rs = alVen.dameVentasXClienteXTiempo();  
  while (rs.next()){
	String estatus = "";
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
	
	String estatusP = "";
	int estadoTransacP = rs.getInt("pago");
	if(estadoTransacP == 0){
		estatusP = "Sin Cobrar";
	}
	else if(estadoTransacP == 1){
		estatusP = "Parcialmente Cobrado";
	}
	else{
		estatusP = "Cobrado";
	}
	
	
	String documento = "";
	int tipoDoc = rs.getInt("tipo");
	if(tipoDoc == 1){
		documento = "F -- "+rs.getString("factura");
	}
	else if(tipoDoc == 2){
		documento = "R -- "+rs.getString("remision");;
	}
%>
  <tr>
  	<td><div align="center"><form name="form<%=fn%>" method="post" target="_blank" action= <%if (tipoDoc == 2){%> "Imprimir_Venta.jsp" <%} else{ %> "Imprimir_Factura.jsp"<%}%>>	
	<br/><a href="DetalleVentaCF.jsp?<%=rs.getString("claveVenta")%>"><%=rs.getString("claveVenta")%></a>
	<input type="hidden" name="claveOrden" value="<%=rs.getString("claveVenta")%>"><br/><br/>
	<input type="submit" name="Imprimir" value="Imprimir">	
	 </form>
  		</div></td>
  	<td><div align="center"><%=rs.getString("claveCliente")%></div></td>
  	<td><div align="center"><%=rs.getString("fechaEntrega")%></div></td>
  	<td><div align="center"><%=rs.getString("fechaAlta")%></div></td>
	<td><div align="right">$ <%=alVen.formatoDinero(rs.getString("total"))%></div></td>
	<td><div align="center"><%=estatus%></div></td>	
	<td><div align="center"><%=estatusP%></div></td>	
	<td><div align="center"><%=documento%></div></td>	
  </tr>
<%  
	fn++;
  }
	if(rs != null){
		rs.close();
	}		
	alVen.cierraConexion();		  
%>  
</table>
<%


%>
	
	
<p align="center"><a href="Consultas_Ventas.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
