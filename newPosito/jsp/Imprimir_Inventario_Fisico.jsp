<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Inventario Físico</title>
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

function Cerrar() {
	parent.close(); 
}

//-->
</script>
</head>
  
<body onLoad="imprimirPagina(); Cerrar()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	ResultSet productos = inv.dameProductos();	
	double renglonXHoja = 65;
	double inicio = 0;			
%>	
	<table width="750" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>
	INVENTARIO F&Iacute;SICO
	</caption>
	  <tr>
<%	  inicio++;  %>	  	  
	  	<th width="68">Clave</th>
		<th width="358">Nombre Producto</th>
		<th width="76">Tipo</th>
		<th width="117">Existencia en Almac&eacute;n</th>		
		<th width="119">Existencia en Tienda</th>				
	  </tr>
	 <p></p>
<%
	while (productos.next()){
		if(inicio == renglonXHoja){
			inicio = 0;
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  	<th width="68">Clave</th>
		<th width="358">Nombre Producto</th>
		<th width="76">Tipo</th>
		<th width="117">Existencia en Almac&eacute;n</th>		
		<th width="119">Existencia en Tienda</th>				
	</tr>			
<%		} 	
		String tipoP = "Unidades";		
		if(productos.getInt("tipoPro") == 1){
			tipoP = "Kg.";
		}
%>
      <tr>
<%	  inicio++;  %>		  
		<td><div align="center"><%=productos.getInt("ID_Pro")%></div></td>
 		<td><%=productos.getString("descripcion")%></td>
		<td><div align="center"><%=tipoP%></div></td>
		<td><div align="center">&nbsp;</div></td>
		<td><div align="center">&nbsp;</div></td>
     </tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	inv.cierraConexion();		
%>	  	  
	</table>
</body>
</html>
