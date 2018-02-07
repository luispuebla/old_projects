<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Facturas por Rango</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script>
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
	String fechaInicial = request.getParameter("datebox");
	fechaInicial= fechaInicial.substring(6,10)+"-"+fechaInicial.substring(0,2)+"-"+fechaInicial.substring(3,5);
	String fechaFinal = request.getParameter("datebox2");
	fechaFinal= fechaFinal.substring(6,10)+"-"+fechaFinal.substring(0,2)+"-"+fechaFinal.substring(3,5);
	String fechaHoy = alCom.dameFechaHoy();
%>
<jsp:setProperty name="alCom" property="fechaInicial" value="<%=fechaInicial%>"/>
<jsp:setProperty name="alCom" property="fechaFinal" value="<%=fechaFinal%>"/>
<h1>Al d&iacute;a de hoy (<%=fechaHoy%>), Facturas registradas <br/>en el Rango de Tiempo comprendido entre: <br /> <%=fechaInicial%> al <%=fechaFinal%>:</h1>
<table width="850" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<th width="92">Fecha<br/>en<br/>Factura</th>	  	
	<th width="95">Factura<br/>No.</th>
	<th width="103">RFC</th>	
	<th width="190">Proveedor</th>		
	<th width="90">Tasa 0%</th>
	<th width="90">Tasa 15%</th>
 	<th width="82">Iva</th>
 	<th width="90">Total</th>	
 </tr>
  <%
	  BigDecimal sigmaTasa0 = new BigDecimal("0.00");
	  BigDecimal sigmaTasa15 = new BigDecimal("0.00");
	  BigDecimal sigmaIva = new BigDecimal("0.00");
	  BigDecimal sigmaTotal = new BigDecimal("0.00");
	  BigDecimal sumaTasa0 = new BigDecimal("0.00");
	  BigDecimal sumaTasa15 = new BigDecimal("0.00");
	  BigDecimal sumaIva = new BigDecimal("0.00");
	  BigDecimal sumaTotal = new BigDecimal("0.00");
	  String docAval = "";
	  String claveProveedor = "";
	  String nombreProveedor = "";
	  String fechaEnFac = "";
	  boolean primerEntrada = true;
	  ResultSet rs = alCom.facturasComprasXTiempo(fechaInicial,fechaFinal);  
	  while (rs.next()){
		if(primerEntrada){
			primerEntrada = false;
			docAval = rs.getString("docPadre");
			claveProveedor = rs.getString("claveProveedor");
			nombreProveedor = rs.getString("nombre");
			fechaEnFac = rs.getString("fechaDoc");
		}
		if(rs.getString("docPadre").equalsIgnoreCase(docAval)  && rs.getString("claveProveedor").equalsIgnoreCase(claveProveedor)){
			if(rs.getInt("gravaIVA") == 0){
				sumaTasa0 = sumaTasa0.add((new BigDecimal(rs.getString("Costo"))));
				sumaTotal = sumaTotal.add(new BigDecimal(rs.getString("Costo")));
				sigmaTasa0 = sigmaTasa0.add(new BigDecimal(rs.getString("Costo")));		
				sigmaTotal = sigmaTotal.add(new BigDecimal(rs.getString("Costo")));
			}
			else{
				BigDecimal impuesto = new BigDecimal("1.15");
				BigDecimal impuesto2 = new BigDecimal("0.15");
				sumaTasa15 = sumaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sumaIva = sumaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sumaTotal = sumaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTasa15 = sigmaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sigmaIva = sigmaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTotal = sigmaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));		
			}		
		}
		else{ 
			sumaTasa0 = sumaTasa0.setScale(2, RoundingMode.HALF_UP);
			sumaTasa15 = sumaTasa15.setScale(2, RoundingMode.HALF_UP);
			sumaIva = sumaIva.setScale(2, RoundingMode.HALF_UP);
			sumaTotal = sumaTotal.setScale(2, RoundingMode.HALF_UP);  	%>
	<tr>
		<td><div align="center"><%=fechaEnFac%></div></td>	  	
		<td><div align="center"><%=docAval%></div></td>
		<td><div align="center"><%=claveProveedor%></div></td>	
		<td><div align="center"><%=nombreProveedor%></div></td>		
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa0.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa15.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaIva.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTotal.toString())%></div></td>	
	</tr>	
<%	
			docAval = rs.getString("docPadre");
			claveProveedor = rs.getString("claveProveedor");
			nombreProveedor = rs.getString("nombre");
			fechaEnFac = rs.getString("fechaDoc");
			sumaTasa0 = new BigDecimal("0.00");
			sumaTasa15 = new BigDecimal("0.00");
			sumaIva = new BigDecimal("0.00");
			sumaTotal = new BigDecimal("0.00");
			if(rs.getInt("gravaIVA") == 0){
				sumaTasa0 = sumaTasa0.add(new BigDecimal(rs.getString("Costo")));
				sumaTotal = sumaTotal.add(new BigDecimal(rs.getString("Costo")));
				sigmaTasa0 = sigmaTasa0.add(new BigDecimal(rs.getString("Costo")));		
				sigmaTotal = sigmaTotal.add(new BigDecimal(rs.getString("Costo")));
			}
			else{
				BigDecimal impuesto = new BigDecimal("1.15");
				BigDecimal impuesto2 = new BigDecimal("0.15");
				sumaTasa15 = sumaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sumaIva = sumaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sumaTotal = sumaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTasa15 = sigmaTasa15.add(new BigDecimal(rs.getString("Costo")));
				sigmaIva = sigmaIva.add(impuesto2.multiply(new BigDecimal(rs.getString("Costo"))));
				sigmaTotal = sigmaTotal.add(impuesto.multiply(new BigDecimal(rs.getString("Costo"))));		
			}		
		}  
	}// Cierro While
	rs.close();
	alCom.cierraConexion();
	%>
	<tr>
		<td><div align="center"><%=fechaEnFac%></div></td>	  	
		<td><div align="center"><%=docAval%></div></td>
		<td><div align="center"><%=claveProveedor%></div></td>	
		<td><div align="center"><%=nombreProveedor%></div></td>		
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa0.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTasa15.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaIva.toString())%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(sumaTotal.toString())%></div></td>	
	</tr>	
<%	
	sigmaTasa0 = sigmaTasa0.setScale(2, RoundingMode.HALF_UP);
	sigmaTasa15 = sigmaTasa15.setScale(2, RoundingMode.HALF_UP);
	sigmaIva = sigmaIva.setScale(2, RoundingMode.HALF_UP);
	sigmaTotal = sigmaTotal.setScale(2, RoundingMode.HALF_UP);  
%>  
  <tr>
  	<th colspan="4">TOTALES</th>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaTasa0.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaTasa15.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaIva.toString())%></b></div></td>
	<td><div align="right"><b>$ <%=alCom.formatoDinero(sigmaTotal.toString())%></b></div></td>			
  </tr>
</table>

<table border="0" width="300">
	<tr>
		<td valign="top">	
			<form name="form1" target="_blank" action="ImprimirFacturas_Compras_Tiempo.jsp" method="post">
			<p align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="132" height="41" border="0"></a></p>
			<input type="hidden" name="fechaInicial" value="<%=fechaInicial%>">
			<input type="hidden" name="fechaFinal" value="<%=fechaFinal%>">
			</form>
		</td>
		<td>&nbsp;</td>	
		<td valign="top"><a href="Consultas_Compras.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></td>		
	</tr>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
