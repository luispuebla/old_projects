<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Consultas Compras</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F8F8F8;
}
-->
</style></head>

<body>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 	
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%		
	}
%>
<div align="center"><img src="imagenes/ConsultasVentas.jpg" width="700" height="400" border="0" usemap="#Map">
  <br>  
  <map name="Map">
    <area shape="rect" coords="68,106,371,138" href="Seleccion_Fecha_Ventas.jsp" target="_self">
    <area shape="rect" coords="632,327,685,392" href="Menu_Ventas.jsp" target="_self">
    <area shape="rect" coords="106,208,507,238" href="Escoge_Producto_Consulta_Mes_Venta.jsp" target="_self">
    <area shape="rect" coords="137,255,589,288" href="Escoge_Cliente_VentasXTiempo.jsp" target="_self">
    <area shape="rect" coords="84,156,493,187" href="Seleccion_Entregas_Ventas.jsp" target="_self">
    <area shape="rect" coords="165,303,475,338" href="Escoge_Cliente_Faltantes_Re.jsp" target="_self">
    <area shape="rect" coords="198,353,523,390" href="Selecciona_LapsoTiempo_Facturas.jsp" target="_self">
  </map>
</div>
</body>
</html>
