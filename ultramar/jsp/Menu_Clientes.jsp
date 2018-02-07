<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Menu Clientes</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	//System.out.println(tipou);
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
	//System.out.println(tipou);
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<div align="center"><img src="imagenes/MenuClientes.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="rect" coords="68,76,313,109" href="Alta_Clientes.jsp" target="_self">
    <area shape="rect" coords="121,176,456,204" href="Existe_Cliente_Cambio.jsp" target="_self">
    <area shape="rect" coords="93,126,340,160" href="Existe_Cliente_Baja.jsp" target="mainFrame">
    <area shape="rect" coords="138,225,424,260" href="Consultas_Clientes.jsp" target="_self">
<%	if(tipou.equalsIgnoreCase("admin")){%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Admon.jsp" target="_self">
<%	}
	else{%>
    <area shape="rect" coords="621,322,686,396" href="Menu_Cashier.jsp" target="_self">
<%	}%>
  </map>
</div>
</body>
</html>
