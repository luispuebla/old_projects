<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="acceso" class="com.alpha.bd.ManagerLogin" scope="page"/>
<html>
<head>
<title>Validaci&oacute;n y Verificaci&oacute;n</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<%
	String elUsuario = "";
	String laContra = "";
	if(request.getParameter("usuario") != null){
		elUsuario = request.getParameter("usuario");
	}
	if(request.getParameter("contrase") != null){
		laContra = request.getParameter("contrase");
	}
	String elTipo = new String();
	String elEmpleo = new String();
	boolean entrada = false;
%>
<jsp:setProperty name="acceso" property="usuario" value="<%=elUsuario%>"/>
<jsp:setProperty name="acceso" property="contra" value="<%=laContra%>"/>
<%
	entrada = acceso.Acceso();
	if(entrada){
		session.setAttribute("UsuarioActual", elUsuario);
		ResultSet rs = acceso.MandaTipoYArea();
		while (rs.next()){
			elTipo = rs.getString("Tipo");
			elEmpleo = rs.getString("NombreE");
		}
		rs.close();
		acceso.cierraConexion();
// Guardo en mi sesion el tipo y el Area correspondiente del Usuario.		
		session.setAttribute("TipoUsuario", elTipo);
		session.setAttribute("TipoEmpleo", elEmpleo);
		if (elTipo.equalsIgnoreCase("administrador")){
			response.sendRedirect("IndexAdmon.jsp");
		}
		else if(elTipo.equalsIgnoreCase("Simple") && elEmpleo.equalsIgnoreCase("facturador")){
			response.sendRedirect("IndexUser.jsp");
		}
		else if(elTipo.equalsIgnoreCase("Simple") && elEmpleo.equalsIgnoreCase("cajero")){			
			response.sendRedirect("IndexUser2.jsp");
		}
	}
	else{
%>
		<jsp:forward page="error_login.html" />
<%
	}
%>
</body>
</html>