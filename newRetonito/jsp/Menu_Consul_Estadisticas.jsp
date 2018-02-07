<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<title>Consultas Ventas</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
<body>
<p align="center"><img src="imagenes/MenuEstadisticasVenta.jpg" width="700" height="400" border="0" usemap="#Map"> 
</p>
<p align="right"> 
  <map name="Map">
    <area shape="rect" coords="124,113,375,149" href="Fecha_Facturas.jsp" target="_self">
    <area shape="rect" coords="185,214,566,252" href="Selecciona_Periodo_Venta.jsp" target="_self">
    <area shape="rect" coords="101,65,361,98" href="Fecha_Venta_Productos.jsp" target="_self">
    <area shape="rect" coords="222,267,587,305" href="Selecciona_Producto_Dinero_Inventario.jsp" target="_self">
    <area shape="rect" coords="153,166,642,204" href="Selecciona_Vendedor_Fecha.jsp" target="_self">
    <area shape="rect" coords="611,319,691,390" href="Menu_Ventas_ConsulYEstad.jsp" target="_self">
    <area shape="rect" coords="249,315,516,350" href="Fecha_Utilidad_Diaria.jsp" target="_self">
  </map>
</p>
</body>
</html>
