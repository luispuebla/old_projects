<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="en" class="com.vas.bd.ManagerEntregas" scope="page" />

<html>
<head>
<title>Muestra Consulta Facturas en Tiempo por Cliente</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

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
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
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
<table width="755" border="1" align="center">
  <tr>
  	<th width="115">Clave<br/>Venta</th>
	<th width="89">Factura No.</th>
	<th width="96">Fecha</th>	
	<th width="122">Importe<br />Total</th>
	<th width="157">Estado de<br />Transacci&oacute;n</th>
 	<th width="136">Estado de<br />Cobro</th>
 </tr>
  <%
  ResultSet rs = en.dameFacturasXTiempo(fechaInicial,fechaFinal);
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
	String cobro = "";
	int estadoCobro = rs.getInt("Pago");
	if(estadoCobro == 0){
		cobro = "Por Cobrar";
	}
	else if(estadoCobro == 1){
		cobro = "Parcialmente Cobrado";
	}
	else{
		cobro = "Cobrado";
	}
%>
  <tr>
  	<td><div align="center"><%=rs.getInt("claveVenta")%></div></td>
  	<td><div align="center"><%=rs.getString("factura")%></div></td>	
  	<td><div align="center"><%=rs.getString("fechaAlta")%></div></td>
	<td><div align="right">$ <%=en.formatoDinero(rs.getString("total"))%></div></td>
	<td><div align="center"><%=estatus%></div></td>	
	<td><div align="center"><%=cobro%></div></td>	
  </tr>
<%  
  }
	if(rs != null){
		rs.close();
	}		
	en.cierraConexion();	
  
%>  
</table>

<table border="0" width="300">
	<tr>
		<td valign="top">	
			<form name="form1" target="_blank" action="ImprimirFacturasXTiempo.jsp" method="post">
			<p align="center"> <a onClick="MandaSubmit(document.forms[0])" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprime','','imagenes/Imprimir2.jpg',1)"><img src="imagenes/Imprimir1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
			<input type="hidden" name="fechaInicial" value="<%=fechaInicial%>">
			<input type="hidden" name="fechaFinal" value="<%=fechaFinal%>">
			</form>
		</td>
		<td>&nbsp;</td>	
		<td valign="top"><a href="Consultas_Ventas.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></td>		
	</tr>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
