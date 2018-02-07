<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />
<jsp:useBean id="diaHoy" class="com.vas.bd.TimeStamp" scope="page" />

<html>
<head>
<title>Venta - Utilidad X Tiempo</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
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

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los men�s");
}

function Cerrar() {
	parent.close(); 
}

//-->
</script>
<style type="text/css">
<!--
.style2 {color: #990033}
.style4 {
	color: #000099;
	font-style: italic;
}
.style5 {
	font-weight: bold;
}
.style6 {color: #000099}
-->
</style>
</head>
<body onLoad="imprimirPagina(); Cerrar()">
<%
	ResultSet productos = alVen.todosLosProductosConInv();	
	double totalC = 0.0;	
%>	
	<table width="780" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>INVENTARIO TOTAL (<%=diaHoy.date%>)</caption>
	  <tr>
	  	<th width="74">Clave</th>
		<th width="357">Descripci&oacute;n Producto</th>
		<th width="100">Cantidad<br />Venta</th>
		<th width="100">Cantidad<br />Obsequio</th>		
		<th width="100">Costo</th>		
	  </tr>
	 <p></p>
<%
	while (productos.next()){
		String tipoP = "Cajas";
		String tempOb = "0";
		if(productos.getString("ExistenciaOb") != null){
			tempOb = productos.getString("ExistenciaOb");
		}
		if(productos.getInt("tipo") == 2){
			tipoP = "Kg.";
		}
		double costo = alVen.dameCostoProducto(productos.getString("claveProducto"));
		costo = costo * productos.getInt("existencia");
		totalC = totalC + costo;
%>
      <tr>
		<td><div align="center"><%=productos.getString("claveProducto")%></div></td>
		<td><%=productos.getString("descripcion")%></td>
		<td><div align="center"><%=productos.getString("existencia")%> <%=tipoP%></div></td>
		<td><div align="center"><%=tempOb%> <%=tipoP%></div></td>
		<td><div align="center">$ <%=alVen.formatoDinero(alVen.acortaLongitud(costo+""))%></div></td>
      </tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	alVen.cierraConexion();		
%>	
      <tr>
		<td colspan="3">&nbsp;</td>
		<th>Costo<br />Inventario</th>
		<td><div align="center"><strong>$ <%=alVen.formatoDinero(alVen.acortaLongitud(totalC+""))%></strong></div></td>
      </tr>  	  
	</table>
</body>
</html>
