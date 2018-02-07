<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Consultas Facturas</title>
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
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<div align="center"><img src="imagenes/Facturas.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <br>  
  <map name="Map">
<%	if(tipou.equalsIgnoreCase("admin")){%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Ventas.jsp" target="_self">
<%	}
	else{%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Ventas_Cash.jsp" target="_self">
<%	}%>
    <area shape="rect" coords="115,176,344,209" href="Dame_Factura_Baja.jsp" target="_self">
    <area shape="rect" coords="99,127,323,155" href="Dame_Comanda_Factura.jsp" target="_self">
    <area shape="rect" coords="139,228,454,262" href="Fecha_Factura_Global.jsp" target="_self">
  </map>
</div>
</body>
</html>
