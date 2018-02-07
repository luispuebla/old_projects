<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %> 
<jsp:useBean id="produ" class="com.alpha.bd.ManagerPro" />
<html>
<head>
<title>Existencias de Todos los Productos </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseMiniCSS.css" rel="stylesheet" type="text/css">
<style type="text/css">
br.breakhere{page-break-before: always}
</style>

<script language="JavaScript" type="text/JavaScript">
<!--
function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}
//-->
</script>
</head>
<body>
<% 
	String ordenamiento = request.getParameter("ordenamiento");
	double renglonXHoja = 33;
	double inicio = 0;	
	ResultSet rs = produ.listadoPorCodigos(ordenamiento);	
%>
<h1>Listado de Productos por 
<% if(ordenamiento.equalsIgnoreCase("1")){%>
Nombre
<%} else if (ordenamiento.equals("2")){ %>
Clave
<%} else if (ordenamiento.equals("3")){ %>
Nombre y Género
<%} else{ %>
Clave y Género
<%}%>
</h1>

<% if(ordenamiento.equals("1") || ordenamiento.equals("2")){ 
	int claveProducto = 0;
%>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >
<% while (rs.next()){ 
		if(inicio >= renglonXHoja){
		inicio = 0;
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >
		<br class="breakhere"> &nbsp; </br>		
<%	} 
  	if(claveProducto == 0){ 
		claveProducto = rs.getInt("ID_Pro");
%>
	<tr>
<%	  inicio++;  %>		
		<th>Clave Producto</th>
		<td><div align="center"><%=claveProducto%></div></td>
		<th>Nombre Producto</th>
		<td><%=rs.getString("descripcion")%></td>
	</tr>	
	<tr>
<%	  inicio++;  %>		
		<th colspan="4"> C&oacute;digos Registrados:</th>
	</tr>
	<tr>
<%	  inicio++;  %>		
		<th>C&oacute;digo:</th>
		<td colspan="3"><div align="center"><%=rs.getString("codBarra")%></div></td>
	</tr>		
<%	}
	else if(claveProducto == rs.getInt("ID_Pro")){%>
	<tr>
<%	  inicio++;  %>		
		<th>C&oacute;digo:</th>
		<td  colspan="3"><div align="center"><%=rs.getString("codBarra")%></div></td>
	</tr>			
<%	}
	else{
		claveProducto = rs.getInt("ID_Pro");			
%>
	<tr>
<%	  inicio++;  %>		
		<th>Clave Producto</th>
		<td><div align="center"><%=claveProducto%></div></td>
		<th>Nombre Producto</th>
		<td><%=rs.getString("descripcion")%></td>
	</tr>	
	<tr>
<%	  inicio++;  %>		
		<th colspan="4"> C&oacute;digos Registrados:</th>
	</tr>
	<tr>
<%	  inicio++;  %>		
		<th>C&oacute;digo:</th>
		<td colspan="3"><div align="center"><%=rs.getString("codBarra")%></div></td>
	</tr>		
  <% }} rs.close(); produ.cierraConexion(); // Cierro While %>
  </table>
<% } else if(ordenamiento.equals("3") || ordenamiento.equals("4")){ 
	int claveProducto = 0;
	String generoActual = "";
	int claveGeneroActual = 0;
%>	
<table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >
	<% while(rs.next()){
		if(inicio >= renglonXHoja){
			inicio = 0;
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >
		<br class="breakhere"> &nbsp; </br>		
<%		} 	
		if(claveGeneroActual == 0){
			claveGeneroActual = rs.getInt("genero");
			if(claveGeneroActual == 1){
				generoActual = "Cremer&iacute;a";	
			}
			else if(claveGeneroActual == 2){
				generoActual = "Refresco";	
			}
			else if(claveGeneroActual == 3){
				generoActual = "Abarrote";	
			}
%>
	<tr>
<%	  inicio++;  %>			
		<th colspan="4">**<%=generoActual%>**</th>
	</tr>		
<%		
		}
		else if(claveGeneroActual != rs.getInt("genero")){
			claveGeneroActual = rs.getInt("genero");
			if(claveGeneroActual == 1){
				generoActual = "Cremer&iacute;a";	
			}
			else if(claveGeneroActual == 2){
				generoActual = "Refresco";	
			}
			else if(claveGeneroActual == 3){
				generoActual = "Abarrote";	
			}
%>
	<tr>
<%	  inicio++;  %>			
		<th colspan="4">**<%=generoActual%>**</th>
	</tr>		
<%				
		}
  	if(claveProducto == 0){ 
		claveProducto = rs.getInt("ID_Pro");		
%>
	<tr>
<%	  inicio++;  %>				
		<th>Clave Producto</th>
		<td><div align="center"><%=claveProducto%></div></td>
		<th>Nombre Producto</th>
		<td><%=rs.getString("descripcion")%></td>
	</tr>	
	<tr>
<%	  inicio++;  %>				
		<th colspan="4"> C&oacute;digos Registrados:</th>
	</tr>
	<tr>
<%	  inicio++;  %>				
		<th>C&oacute;digo:</th>
		<td colspan="3"><div align="center"><%=rs.getString("codBarra")%></div></td>
	</tr>		
<%	}
	else if(claveProducto == rs.getInt("ID_Pro")){%>
	<tr>
<%	  inicio++;  %>				
		<th>C&oacute;digo:</th>
		<td colspan="3"><div align="center"><%=rs.getString("codBarra")%></div></td>
	</tr>			
<%	}
	else{
		claveProducto = rs.getInt("ID_Pro");			
%>
	<tr>
<%	  inicio++;  %>				
		<th>Clave Producto</th>
		<td><div align="center"><%=claveProducto%></div></td>
		<th>Nombre Producto</th>
		<td><%=rs.getString("descripcion")%></td>
	</tr>	
	<tr>
<%	  inicio++;  %>				
		<th colspan="4"> C&oacute;digos Registrados:</th>
	</tr>
	<tr>
<%	  inicio++;  %>				
		<th>C&oacute;digo:</th>
		<td colspan="3"><div align="center"><%=rs.getString("codBarra")%></div></td>
	</tr>		
	<% }} rs.close(); produ.cierraConexion();  // Cierro While%>
  </table>
<% } %>
</body>
</html> 
