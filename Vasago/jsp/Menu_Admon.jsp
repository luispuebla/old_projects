<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Men&uacute; Principal</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body>
<p align="center"><img src="imagenes/MenuPrincipal.jpg" width="700" height="400" border="0" usemap="#Map"> 
  <map name="Map">
    <area shape="poly" coords="227,289,112,289,112,260,148,260,148,220,183,220,183,260,227,260" href="Menu_Personal.jsp">
    <area shape="poly" coords="15,201,180,201,180,174,105,174,105,120,68,120,68,174,15,174" href="Menu_Proveedores.jsp">
    <area shape="poly" coords="111,102,220,102,220,76,186,76,186,20,151,20,151,73,111,73" href="Menu_Clientes.jsp">
    <area shape="poly" coords="298,324,394,324,394,301,373,302,373,247,306,246,306,298,298,298" href="Menu_Bancos.jsp">
    <area shape="poly" coords="458,76,516,76,516,23,543,23,543,78,590,78,590,104,457,104,458,105" href="Menu_Productos.jsp">
    <area shape="poly" coords="460,286,580,286,580,262,549,262,549,222,499,222,499,257,460,257" href="Menu_Compras.jsp">
    <area shape="poly" coords="293,63,293,35,317,35,317,4,381,4,381,38,398,38,398,63" href="Menu_Ventas.jsp" target="_self">
    <area shape="poly" coords="552,174,552,124,598,124,598,176,638,176,638,201,498,201,498,174" href="Menu_Inventarios.jsp">
  </map>
</p>
</body>
</html>
