<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %> 
<jsp:useBean id="inv" class="com.alpha.bd.ManagerPro" />

<html>
<head>
<title>Listado de Productos</title>
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
	String impresion = request.getParameter("impresion");
	ResultSet rs = inv.listadoProductos(ordenamiento);	
	double renglonXHoja = 33;
	double inicio = 0;
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
<% if(ordenamiento.equals("1") || ordenamiento.equals("2")){ %>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >
<% if(impresion.equals("1")){ %>
	<tr>
<%	  inicio++;  %>
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th colspan="2">Costo 
      (Unidad - Caja / 1Kg.)</th>
	  <th>Unidades por Caja</th>
	  <th>Kilos por Unidad</th>
	</tr>
<% while(rs.next()){
		String tipo = "Por Unidad";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
		if(inicio == renglonXHoja){
			inicio = 0;
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th colspan="2">Costo 
      (Unidad - Caja / 1Kg.)</th>
	  <th>Unidades por Caja</th>
	  <th>Kilos por Unidad</th>
	</tr>			
<%		} %>
	<tr>
<%	  inicio++;  %>	
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <% if(rs.getInt("tipoPro") == 1){ %>
	  <td colspan="2"><div align="right">$ <%=inv.formatoDinero(rs.getString("precioUnidadKG"))%></div></td>
	  <td ><div align="center">No Aplica</div></td>
	  <td><div align="center"><%= rs.getDouble("kgXUnidad")%> Kg.</div></td>	  
	  <%} else{%>
	  <td><div align="right">U-$ <%=inv.formatoDinero(rs.getString("precioUniCompra"))%></div></td>
	  <td><div align="right">C-$ <%=inv.formatoDinero(rs.getString("preCaCompra"))%></div></td>
	  <td><div align="center"><%= rs.getInt("cantidadXCaja")%> Uni.</div></td>
	  <td><div align="center">No Aplica</div></td>	  
	  <% } %>
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>
<% } else if(impresion.equals("2")){%>
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>Manejo<br /> de Precio</th>
	  <th colspan="2">$ Menudeo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Medio Mayoreo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Mayoreo Unidad/Kg. - Caja/Pieza</th>
	</tr>
	<% while(rs.next()){
		String tipo = "Por Unidad";
		String tipoPrecio ="Precio Base";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
		if(rs.getInt("tipoPrecio") == 1){
			tipoPrecio ="Por Grupo";
		}
		if(rs.getInt("tipoPrecio") == 2){
			tipoPrecio ="Escalonado";
		}		
		if(inicio == renglonXHoja){
			inicio = 0;
		
	 %>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>Manejo<br /> de Precio</th>
	  <th colspan="2">$ Menudeo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Medio Mayoreo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Mayoreo Unidad/Kg. - Caja/Pieza</th>
	</tr>			
<%		} %>
	<tr>
<%	  inicio++;  %>		
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <td><div align="center"><%=tipoPrecio%></div></td>	  
	  <% if(rs.getInt("tipoPrecio") == 0 && rs.getInt("manejoPrecio") == 0){ %>
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td colspan="2"><div align="center">NA</div></td>
		  <td colspan="2"><div align="center">NA</div></td>
	  <%} else if(rs.getInt("tipoPrecio") == 0 && (rs.getInt("manejoPrecio") == 1 || rs.getInt("manejoPrecio") == 2)){ %> 
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenuC"))%></div></td>		  
		  <td colspan="2"><div align="center">NA</div></td>
		  <td colspan="2"><div align="center">NA</div></td>
	  <%} else if(rs.getInt("tipoPrecio") == 1 && rs.getInt("manejoPrecio") == 0){ %> 
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioMM"))%></div></td>
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioM"))%></div></td>
	  <%} else if(rs.getInt("tipoPrecio") == 1 && (rs.getInt("manejoPrecio") == 1 || rs.getInt("manejoPrecio") == 2)){ %> 
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenuC"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMM"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMMC"))%></div></td>	  		  
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioM"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMC"))%></div></td>	  		  
	  <%} else if(rs.getInt("tipoPrecio") == 2){ 
	  		ResultSet interino = inv.dameInfoEscalon(rs.getString("ID_Pro"));%>
		  <td colspan="14"><div align="right">Escalon: 
	  <%	while(interino.next()){   %> 
	  			<%=interino.getInt("ca_peEscalon")+1%> --> $ <%=inv.formatoDinero(interino.getString("campoPrecio"))%> //
	  <% 	} interino.close(); inv.cierraConexion2();%>				
	  	  </div></td>		  
	  <% } %>
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>
<% } else if(impresion.equals("3")){%>
	<tr>
<%	  inicio++;  %>		
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	</tr>
	<% while(rs.next()){
		String tipo = "Por Unidad";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
		if(inicio == renglonXHoja){
			inicio = 0;
				
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	</tr>			
<%		} %>
	<tr>
<%	  inicio++;  %>		
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <td width="150">&nbsp;</td>
	  <td width="150">&nbsp;</td>
	  <td width="150">&nbsp;</td>	  	  
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>
	
<% } else{%>
	<tr>
<%	  inicio++;  %>		
	  <th rowspan="2">Clave<br/>Producto</th>
	  <th rowspan="2">Nombre Producto</th>
	  <th rowspan="2">Tipo</th>
	  <th colspan="2">Existencia</th>
	  <th rowspan="2">&nbsp;</th>	  
	</tr>
	<tr>
<%	  inicio++;  %>			
	  <th>Tienda</th>
	  <th>Almac&eacute;n</th>
	</tr>
	<% while(rs.next()){
		String tipo = "Por Unidad";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
		if(inicio == renglonXHoja){
			inicio = 0;
						
	 %>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	</tr>			
<%		} %>	 
	<tr>
<%	  inicio++;  %>		
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <% if(rs.getInt("tipoPro") == 1){ %>
	  <td>	  
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>
		  <td width="65%"><div align="right"><%=rs.getDouble("invTienda")%></div></td>
		  <td width="35%"><div align="center">Kg.</div></td>
		 </tr>
		</table></td>
	  <td>	  
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>
		  <td width="65%"><div align="right"><%=rs.getDouble("invAlmacen")%></div></td>
		  <td width="35%"><div align="center">Kg.</div></td>
		 </tr>
		</table></td>
	  <%  } else{ %>
	  <td>
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>	  
		  <td width="65%"><div align="right"><%=rs.getInt("invTienda")%></div></td>
		  <td width="35%"><div align="center">Uni(s).</div></td>
		 </tr>
		</table></td>
	  <td>
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>	  
		  <td width="65%"><div align="right"><%=rs.getInt("invAlmacen")%></div></td>
		  <td width="35%"><div align="center">Uni(s).</div></td>
		 </tr>
		</table></td>
	  <% } %>
	  <td width="150">&nbsp;</td>	  
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>	
<% } %>
  </table>
<% } else if(ordenamiento.equals("3") || ordenamiento.equals("4")){ 
	String generoActual = "";
	int claveGeneroActual = 0;
%>	
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >
<% if(impresion.equals("1")){ %>
	<tr>
<%	  inicio++;  %>		
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th colspan="2">Costo<br/>
      (Unidad - Caja / 1Kg.)</th>
	  <th>Unidades por Caja</th>
	  <th>Kilos por Unidad</th>
	</tr>
	<% while(rs.next()){
		if(inicio == renglonXHoja){
			inicio = 0;									
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th colspan="2">Costo<br/>
      (Unidad - Caja / 1Kg.)</th>
	  <th>Unidades por Caja</th>
	  <th>Kilos por Unidad</th>
	</tr>			
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
		<th colspan="7"><%=generoActual%></th>
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
		<th colspan="7"><%=generoActual%></th>
	</tr>		
<%				
		}
		String tipo = "Por Unidad";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
	 %>
	<tr>
<%	  inicio++;  %>		
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <% if(rs.getInt("tipoPro") == 1){ %>
	  <td colspan="2"><div align="right">$ <%=inv.formatoDinero(rs.getString("precioUnidadKG"))%></div></td>
	  <td ><div align="center">No Aplica</div></td>
	  <td><div align="center"><%= rs.getDouble("kgXUnidad")%> Kg.</div></td>	  
	  <%} else{%>
	  <td><div align="right">U-$ <%=inv.formatoDinero(rs.getString("precioUniCompra"))%></div></td>
	  <td><div align="right">C-$ <%=inv.formatoDinero(rs.getString("preCaCompra"))%></div></td>
	  <td><div align="center"><%= rs.getInt("cantidadXCaja")%> Uni.</div></td>
	  <td><div align="center">No Aplica</div></td>	  
	  <% } %>
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>
<% } else if(impresion.equals("2")){%>
	<tr>
<%	  inicio++;  %>		
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>Manejo<br /> de Precio</th>
	  <th colspan="2">$ Menudeo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Medio Mayoreo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Mayoreo Unidad/Kg. - Caja/Pieza</th>
	</tr>
	<% while(rs.next()){
		if(inicio == renglonXHoja){
			inicio = 0;
												
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>Manejo<br /> de Precio</th>
	  <th colspan="2">$ Menudeo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Medio Mayoreo Unidad/Kg. - Caja/Pieza</th>
	  <th colspan="2">$ Mayoreo Unidad/Kg. - Caja/Pieza</th>
	</tr>			
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
		<th colspan="18"><%=generoActual%></th>
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
		<th colspan="18"><%=generoActual%></th>
	</tr>		
<%				
		}	
		String tipo = "Por Unidad";
		String tipoPrecio ="Precio Base";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
		if(rs.getInt("tipoPrecio") == 1){
			tipoPrecio ="Por Grupo";
		}
		if(rs.getInt("tipoPrecio") == 2){
			tipoPrecio ="Escalonado";
		}		
	 %>
	<tr>
<%	  inicio++;  %>		
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <td><div align="center"><%=tipoPrecio%></div></td>	  
	  <% if(rs.getInt("tipoPrecio") == 0 && rs.getInt("manejoPrecio") == 0){ %>
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td colspan="2"><div align="center">NA</div></td>
		  <td colspan="2"><div align="center">NA</div></td>
	  		  		  		  		  
	  <%} else if(rs.getInt("tipoPrecio") == 0 && (rs.getInt("manejoPrecio") == 1 || rs.getInt("manejoPrecio") == 2)){ %> 
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenuC"))%></div></td>		  
		  <td colspan="2"><div align="center">NA</div></td>
		  <td colspan="2"><div align="center">NA</div></td>
	  <%} else if(rs.getInt("tipoPrecio") == 1 && rs.getInt("manejoPrecio") == 0){ %> 
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioMM"))%></div></td>
		  <td colspan="2"><div align="right"><%=inv.formatoDinero(rs.getString("precioM"))%></div></td>
	  <%} else if(rs.getInt("tipoPrecio") == 1 && (rs.getInt("manejoPrecio") == 1 || rs.getInt("manejoPrecio") == 2)){ %> 
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenu"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMenuC"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMM"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMMC"))%></div></td>	  		  
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioM"))%></div></td>
		  <td><div align="right"><%=inv.formatoDinero(rs.getString("precioMC"))%></div></td>	  		  
	  <%} else if(rs.getInt("tipoPrecio") == 2){ 
	  		ResultSet interino = inv.dameInfoEscalon(rs.getString("ID_Pro"));%>
		  <td colspan="14"><div align="right">Escalon: 
	  <%	while(interino.next()){   %> 
	  			<%=interino.getInt("ca_peEscalon")+1%> --> $ <%=inv.formatoDinero(interino.getString("campoPrecio"))%> //
	  <% 	} interino.close(); inv.cierraConexion2();%>				
	  	  </div></td>		  
	  <% } %>
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>
<% } else if(impresion.equals("3")){%>
	<tr>
<%	  inicio++;  %>		
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	</tr>
	<% while(rs.next()){
		if(inicio == renglonXHoja){
			inicio = 0;
															
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th>Clave<br/>Producto</th>
	  <th>Nombre Producto</th>
	  <th>Tipo</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	  <th>&nbsp;</th>
	</tr>			
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
		<th colspan="6"><%=generoActual%></th>
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
		<th colspan="6"><%=generoActual%></th>
	</tr>		
<%				
		}	
		String tipo = "Por Unidad";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
	 %>
	<tr>
<%	  inicio++;  %>		 	
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <td width="150">&nbsp;</td>
	  <td width="150">&nbsp;</td>
	  <td width="150">&nbsp;</td>	  	  
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>
	
<% } else{%>
	<tr>
<%	  inicio++;  %>		 	
	  <th rowspan="2">Clave<br/>Producto</th>
	  <th rowspan="2">Nombre Producto</th>
	  <th rowspan="2">Tipo</th>
	  <th colspan="2">Existencia</th>
	  <th rowspan="2">&nbsp;</th>	  
	</tr>
	<tr>
<%	  inicio++;  %>		 		
	  <th>En Tienda</th>
	  <th>En Inventario</th>	  
	</tr>
	<% while(rs.next()){
		if(inicio == renglonXHoja){
			inicio = 0;																		
%>
  </table>
  <table border="1" cellpadding="0" cellspacing="0" width="750" onClick="imprimirPagina();" >  
		<br class="breakhere"> &nbsp; </br>		
	<tr>
<%	  inicio++;  %>	
	  <th rowspan="2">Clave<br/>Producto</th>
	  <th rowspan="2">Nombre Producto</th>
	  <th rowspan="2">Tipo</th>
	  <th colspan="2">Existencia</th>
	  <th rowspan="2">&nbsp;</th>	  
	</tr>
	<tr>
<%	  inicio++;  %>		 		
	  <th>En Tienda</th>
	  <th>En Inventario</th>	  
	</tr>			
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
		<th colspan="6"><%=generoActual%></th>
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
		<th colspan="6"><%=generoActual%></th>
	</tr>		
<%				
		}	
		String tipo = "Por Unidad";
		if(rs.getInt("tipoPro") == 1){
			tipo = "Por Kg.";
		}
	 %>
	<tr>
<%	  inicio++;  %>		 				
	  <td><div align="center"><%=rs.getInt("ID_Pro")%></div></td>
	  <td><%=rs.getString("descripcion")%></td>
	  <td><div align="center"><%=tipo%></div></td>
	  <% if(rs.getInt("tipoPro") == 1){ %>
	  <td>	  
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>
		  <td width="65%"><div align="right"><%=rs.getDouble("invTienda")%></div></td>
		  <td width="35%"><div align="center">Kg.</div></td>
		 </tr>
		</table></td>
	  <td>	  
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>
		  <td width="65%"><div align="right"><%=rs.getDouble("invAlmacen")%></div></td>
		  <td width="35%"><div align="center">Kg.</div></td>
		 </tr>
		</table></td>
	  <%  } else{ %>
	  <td>
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>	  
		  <td width="65%"><div align="right"><%=rs.getInt("invTienda")%></div></td>
		  <td width="35%"><div align="center">Unidad(es).</div></td>
		 </tr>
		</table></td>
	  <td>
	  	<table width="100%" cellpadding="0" cellspacing="0">
		 <tr>	  
		  <td width="65%"><div align="right"><%=rs.getInt("invAlmacen")%></div></td>
		  <td width="35%"><div align="center">Unidad(es).</div></td>
		 </tr>
		</table></td>
	  <% } %>
	  <td width="150">&nbsp;</td>	  
	</tr>
	<% } rs.close(); inv.cierraConexion();  // Cierro While%>	
<% } %>
  </table>
<% } %>
</body>
</html>
