<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Consultas Compras</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
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
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<div align="center"><img src="imagenes/MenuConsultasCompras.jpg" width="700" height="400" border="0" usemap="#Map">
  <br>  
  <map name="Map">
    <area shape="rect" coords="95,68,400,102" href="Seleccion_Fecha_Facturas.jsp" target="_self">
    <area shape="rect" coords="617,321,687,383" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="154,166,549,196" href="Escoge_Producto_Consulta_Mes.jsp" target="_self">
    <area shape="rect" coords="187,215,632,247" href="Escoge_Proveedor_ComprasXTiempo.jsp" target="_self">
    <area shape="rect" coords="120,115,386,144" href="Seleccion_Entregas_Ordenes_Compra.jsp" target="_self">
    <area shape="rect" coords="219,263,642,298" href="Escoge_Proveedor_Faltantes_Re.jsp" target="_self">
    <area shape="rect" coords="247,313,513,352" href="Selecciona_LapsoTiempo_Facs.jsp" target="_self">
  </map>
</div>
</body>
</html>
