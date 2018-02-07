<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page"/>
<html>
<head>
<title>Validaci&oacute;n y Verificaci&oacute;n</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
	String elArea = new String();
	boolean entrada = false;
%>
<jsp:setProperty name="acceso" property="usuario" value="<%=elUsuario%>"/>
<jsp:setProperty name="acceso" property="contra" value="<%=laContra%>"/>
<%
	entrada = acceso.Acceso();
	//System.out.println("entrada: "+entrada);

	if(entrada){
		session.setAttribute("UsuarioActual", elUsuario);
		ResultSet rs = acceso.MandaTipoYArea();
		while (rs.next()){
			elTipo = rs.getString("Tipo");
		}
		//System.out.println(elTipo);
// Guardo en mi sesion el tipo y el Area correspondiente del Usuario.		
		session.setAttribute("TipoUsuario", elTipo);
		if (elTipo.equalsIgnoreCase("Admin")){
			response.sendRedirect("IndexAdmon.jsp");
		}
		else if(elTipo.equalsIgnoreCase("Simple") && elUsuario.equalsIgnoreCase("Producto")){
			response.sendRedirect("IndexUserProductos.jsp");
		}
		else if(elTipo.equalsIgnoreCase("Caja")){			
			response.sendRedirect("IndexCash.jsp");
		}
	}
	else{
%>
		<jsp:forward page="error_login.html" />
<%
	}
	acceso.cierraConexion();
%>
</body>
</html>