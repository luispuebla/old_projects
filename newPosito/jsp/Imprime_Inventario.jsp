<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />
<jsp:useBean id="diaHoy" class="com.alpha.bd.TimeStamp" scope="page" />

<html>
<head>
<title>Inventario Total Actual</title>
<link href="baseMiniCSS.css" rel="stylesheet" type="text/css">
<style type="text/css">
br.breakhere{page-break-before: always}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
	ResultSet productos = inv.dameProductos();
	double renglonXHoja = 65;
	double inicio = 0;	
%>	
	<table width="750" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>INVENTARIO TOTAL (<%=diaHoy.date%>)</caption>
	  <tr>
<%	  inicio++;  %>	  
	  	<th width="91">Clave</th>
		<th width="423">Nombre Producto</th>
		<th width="113">Cantidad en Almac&eacute;n</th>
		<th width="113">Cantidad en Tienda</th>
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
	  	<th width="91">Clave</th>
		<th width="423">Nombre Producto</th>
		<th width="113">Cantidad en Almac&eacute;n</th>
		<th width="113">Cantidad en Tienda</th>
	</tr>			
<%		} 
		String invTienda = productos.getInt("invTienda")+"";
		String invAlmacen = productos.getInt("invAlmacen")+"";
		String tipoP = "Unidades";		
		if(productos.getInt("tipoPro") == 1){
			tipoP = "Kg.";
			invTienda = productos.getDouble("invTienda")+"";
			invAlmacen = productos.getDouble("invAlmacen")+"";
		}
%>
      <tr>
<%	  inicio++;  %>		  
		<td><div align="center"><%=productos.getInt("ID_Pro")%></div></td>
 		<td><%=productos.getString("descripcion")%></td>
		<td><div align="center"><%=invAlmacen%> <%=tipoP%></div></td>
		<td><div align="center"><%=invTienda%> <%=tipoP%></div></td>
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
