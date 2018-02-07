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
    <area shape="rect" coords="73,58,378,92" href="Seleccion_Fecha_Facturas.jsp" target="_self">
    <area shape="rect" coords="615,329,685,391" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="133,157,528,187" href="Escoge_Producto_Consulta_Mes.jsp" target="_self">
    <area shape="rect" coords="166,206,611,238" href="Escoge_Proveedor_ComprasXTiempo.jsp" target="_self">
    <area shape="rect" coords="101,109,367,138" href="Seleccion_Entregas_Ordenes_Compra.jsp" target="_self">
    <area shape="rect" coords="201,257,624,292" href="Escoge_Proveedor_Faltantes_Re.jsp" target="_self">
    <area shape="rect" coords="225,304,491,343" href="Selecciona_LapsoTiempo_Facs.jsp" target="_self">
  </map>
</div>
</body>
</html>
