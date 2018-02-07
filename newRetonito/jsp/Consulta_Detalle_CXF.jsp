<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" scope="page" />

<html>
<head>
<title>Detalle de Facturas por Cliente</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	} 
	String nombre = request.getParameter("nombre"); 
    String rfc = request.getParameter("rfc"); 
	if(nombre == null){
%>
	<form name="form2" method="post" action="Cambio_Cliente4.jsp">
		<p><b class="roj">No se selecciono ning&uacute;n cliente de la lista</b></p>
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<input type="submit" name="Volver" value="Volver">
	</form>
<%		
	}
	else{
		if (cliente.existeClienteE(rfc, nombre)) {
%>
<table width="750" border="1" align="center">
  <tr> 
    <th width="126"><div align="center"><strong>RFC</strong></div></th>
    <th width="141"><div align="center"><strong>Nombre</strong></div></th>
    <th width="147"><div align="center"><strong>Calle</strong></div></th>
    <th width="109"><div align="center"><strong>Colonia</strong></div></th>
    <th width="109"><div align="center"><strong>Delegación</strong></div></th>
    <th width="78"><div align="center"><strong>Código Postal</strong></div></th>
  </tr>
<%		
		ResultSet rs = cliente.datos_Cliente_N(rfc,nombre);
		while (rs.next()){  
%>
  <tr> 
    <td><%= rs.getString("rfc")%></td>
    <td><%= rs.getString("nombre")%></td>
    <td><%= rs.getString("direccion")%></td>
    <td><%= rs.getString("colonia")%></td>
    <td><%= rs.getString("delegacion")%></td>
    <td><div align="center"><%=rs.getString("cp")%></div></td>
  </tr>
<%	      
		} 
		rs.close();
		cliente.cierraConexion();
%>
</table>
<br/>
<table width="750" border="1" align="center">
  <tr>
    <th>Número de Factura</th>
    <th>Fecha Creaci&oacute;n</th>
	<th>Fecha en Factura</th>
	<th>Ticket(s) Componente(s)</th>	
    <th>Total</th>
  </tr>
<%		
		ResultSet rs2 = cliente.datos_Cliente_Facturas(rfc,nombre);
		String numTickets="";
		while (rs2.next()){  
			numTickets = rs2.getString("tickets");
			numTickets = numTickets.replace('%',',');
%>
  <tr> 
    <td><div align="center"><a href="Consulta_Detalle_Factura.jsp?<%= rs2.getString("numFactura")%>"><%= rs2.getString("numFactura")%></a></div></td>
    <td><div align="center"><%= rs2.getString("fechaCrea")%></div></td>
    <td><div align="center"><%= rs2.getString("fechaFac")%></div></td>
    <td><div align="center"><%= numTickets%></div></td>
    <td><div align="right"><%= cliente.formatoDinero(rs2.getString("total"))%></div></td>
  </tr>
<%	      
		} 
		rs2.close();
		cliente.cierraConexion();
%>
</table>		
<%	     
		}
		 else{  %>
		 <b class="roj">El Cliente no se encuentra registrado en el Sistema.</b>
<%
		}
	}
%>
<p align="center"><a href="Consultas_Clientes.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


