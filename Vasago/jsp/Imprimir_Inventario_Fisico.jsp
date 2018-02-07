<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="inv" class="com.vas.bd.ManagerInventarios" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Inventario Físico</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

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
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	ResultSet productos = inv.InventarioFisico();		
%>	
	<table width="590" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>INVENTARIO FÍSICO</caption>
	  <tr>
	  	<th width="67">Clave</th>
		<th width="253">Descripci&oacute;n Producto</th>
		<th width="60">Tipo<br/>Unidad</th>		
		<th width="99">Cantidad<br />Venta</th>
		<th width="99">Cantidad<br />Obsequio</th>		
	  </tr>
	 <p></p>
<%
	while (productos.next()){
	String tipoP = "Cajas";
	if(productos.getInt("tipo") == 2){
		tipoP = "Kg.";
	}	
%>
      <tr>
		<td><div align="center"><%=productos.getString("claveProducto")%></div></td>
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
