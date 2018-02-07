<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Consultas Compras</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<div align="center"><img src="imagenes/ConsultasCompras.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <br>  
  <map name="Map">
    <area shape="rect" coords="632,327,685,392" href="Menu_Compras.jsp" target="_self">
    <area shape="rect" coords="115,176,544,207" href="Escoge_Producto_Consulta_Mes.jsp" target="_self">
    <area shape="rect" coords="99,127,391,158" href="Seleccion_Entregas_Ordenes_Compra.jsp" target="_self">
    <area shape="rect" coords="139,228,475,261" href="Escoge_Proveedor_Faltantes_Re.jsp" target="_self">
  </map>
</div>
</body>
</html>
