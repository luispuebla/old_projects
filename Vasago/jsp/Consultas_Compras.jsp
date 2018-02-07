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
<div align="center"><img src="imagenes/ConsultasCompras.jpg" width="700" height="400" border="0" usemap="#Map">
  <br>  
  <map name="Map">
    <area shape="rect" coords="62,108,392,140" href="Seleccion_Fecha_Facturas.jsp" target="_self">
    <area shape="rect" coords="632,327,685,392" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="106,205,535,236" href="Escoge_Producto_Consulta_Mes.jsp" target="_self">
    <area shape="rect" coords="137,255,628,288" href="Escoge_Proveedor_ComprasXTiempo.jsp" target="_self">
    <area shape="rect" coords="82,155,374,186" href="Seleccion_Entregas_Ordenes_Compra.jsp" target="_self">
    <area shape="rect" coords="167,302,629,338" href="Escoge_Proveedor_Faltantes_Re.jsp" target="_self">
  </map>
</div>
</body>
</html>
