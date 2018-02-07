<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Cortes Caja</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuCobros.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="76,76,252,104" href="Dame_Mesa_Cobros.jsp" target="_self">
    <area shape="rect" coords="102,126,270,158" href="Dame_Comanda_Baja_Cobros.jsp" target="mainFrame">
    <%	if(tipou.equalsIgnoreCase("admin")){%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Ventas.jsp" target="_self">
<%	}
	else{%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Ventas_Cash.jsp" target="_self">
<%	}%>

    <area shape="rect" coords="121,176,396,208" href="Dame_Mesa_Cobros_Pendientes.jsp">
    <area shape="rect" coords="138,225,442,254" href="Dame_Comanda_Cobros_Pendientes.jsp">
    <area shape="rect" coords="161,276,463,310" href="Dame_Comanda_Baja_Cobros_Pendiente.jsp">
  </map>
</div>
</body>
</html>
