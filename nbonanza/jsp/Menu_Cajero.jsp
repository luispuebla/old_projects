<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="administrador" class="com.alpha.bd.ManagerLogin" />

<html>
<head>
<title>Bienvenido</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	String tipoE = (String) session.getAttribute("TipoEmpleo");
	if (usuario == null || !tipo.equalsIgnoreCase("simple") || !tipoE.equalsIgnoreCase("facturador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%		
	}
%>	

<body>
<div align="center"><img src="imagenes/MenuFactura.jpg" width="700" height="400" border="0" usemap="#Map"> 
    <map name="Map">
      <area shape="poly" coords="93,222,93,144,177,144,177,224,202,292,73,292" href="TodosCliFac.jsp" target="_self">
      <area shape="poly" coords="502,166,522,265,607,265,631,166" href="Existe_Ticket2.jsp" target="_self">
      <area shape="poly" coords="284,17,284,104,435,104,435,5" href="Existe_Cliente.jsp" target="_self">
  </map>
</div>
</body>
</html>
