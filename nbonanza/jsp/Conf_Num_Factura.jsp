<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" session = "true" errorPage="error.jsp"%>
<jsp:useBean id="factura" class="com.alpha.bd.ManagerFacturacion" scope="page" />
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Existencia de la Factura</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 		
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = request.getParameter("rfc");
	String nombre = request.getParameter("nombre");
	String fecha1 = request.getParameter("fecha1");
	String fecha2 = request.getParameter("fecha2");
	String fecha3 = request.getParameter("fecha3");
	String fecha4 = request.getParameter("fecha4");
	String fecha5 = request.getParameter("fecha5");
	String ticket1 = request.getParameter("ticket1");
	String ticket2 = request.getParameter("ticket2");
	String ticket3 = request.getParameter("ticket3");
	String ticket4 = request.getParameter("ticket4");
	String ticket5 = request.getParameter("ticket5");			
	String cantidadP = request.getParameter("cantidadP");
	String subTotal = request.getParameter("subTotal");
	String iva2 = request.getParameter("iva");
	String totalP = request.getParameter("totalP");
	String[] ArrayFactura = (String[])request.getParameterValues("numFactura");
	String fechaDeFactura = request.getParameter("fecha");	
	int cantidadDeFacturas = ArrayFactura.length;
	String produEnFac = request.getParameter("prodXFac");
	// Primero checo que me hayan escrito el numero de Facturas, o sea que no este vacio....
	boolean nombreFacEnBlanco = false;
	boolean facRepetida = false;
	for(int i = 0; i<ArrayFactura.length; i++){
		if(ArrayFactura[i].trim().equals("")){ 
			nombreFacEnBlanco = true;
		}
	}
	if(nombreFacEnBlanco){ %>
		<b class="roj">Debes especificar los n&uacute;meros de cada Factura.</b>
		<form name="form1" method="post" action="Num_Factura.jsp">
			<input type="hidden" name="nombre" value="<%=nombre%>">
			<input type="hidden" name="rfc" value="<%=rfc%>">
			<input type="hidden" name="fecha1" value="<%=fecha1%>">
			<input type="hidden" name="fecha2" value="<%=fecha2%>">
			<input type="hidden" name="fecha3" value="<%=fecha3%>">
			<input type="hidden" name="fecha4" value="<%=fecha4%>">
			<input type="hidden" name="fecha5" value="<%=fecha5%>">
			<input type="hidden" name="ticket1" value="<%=ticket1%>">
			<input type="hidden" name="ticket2" value="<%=ticket2%>">
			<input type="hidden" name="ticket3" value="<%=ticket3%>">
			<input type="hidden" name="ticket4" value="<%=ticket4%>">
			<input type="hidden" name="ticket5" value="<%=ticket5%>">
			<input type="hidden" name="cantidadP" value="<%=cantidadP%>">
			<input type="hidden" name="subTotal" value="<%= subTotal%>" >
			<input type="hidden" name="iva" value="<%=iva2%>" >
			<input type="hidden" name="totalP" value="<%=totalP%>" >
			<input type="hidden" name="laFechaHoy" value="<%=fechaDeFactura%>">
		<div align="center"> <input name="Regresar" type="submit" id="Regresar" value="Reingresar N&uacute;mero Factura"> </div>
		</form>
<%
	}
// Verifico que no me esten repitiendo el nombre/numero de Factura.	
	else{
		for(int i = 0; i<ArrayFactura.length; i++){
			for(int j = i+1; j < ArrayFactura.length; j++){
				if(ArrayFactura[i].trim().equalsIgnoreCase(ArrayFactura[j].trim())){
					facRepetida = true;
				}				
			}
		}
		if(facRepetida){ %>		
		<b class="roj">No puedes repetir el n&uacute;mero de Factura Asignada, cada factura debe tener un n&uacute;mero &uacute;nico.</b>
		<form name="form1" method="post" action="Num_Factura.jsp">
			<input type="hidden" name="nombre" value="<%=nombre%>">
			<input type="hidden" name="rfc" value="<%=rfc%>">
			<input type="hidden" name="fecha1" value="<%=fecha1%>">
			<input type="hidden" name="fecha2" value="<%=fecha2%>">
			<input type="hidden" name="fecha3" value="<%=fecha3%>">
			<input type="hidden" name="fecha4" value="<%=fecha4%>">
			<input type="hidden" name="fecha5" value="<%=fecha5%>">
			<input type="hidden" name="ticket1" value="<%=ticket1%>">
			<input type="hidden" name="ticket2" value="<%=ticket2%>">
			<input type="hidden" name="ticket3" value="<%=ticket3%>">
			<input type="hidden" name="ticket4" value="<%=ticket4%>">
			<input type="hidden" name="ticket5" value="<%=ticket5%>">
			<input type="hidden" name="cantidadP" value="<%=cantidadP%>">
			<input type="hidden" name="subTotal" value="<%= subTotal%>" >
			<input type="hidden" name="iva" value="<%=iva2%>" >
			<input type="hidden" name="totalP" value="<%=totalP%>" >
			<input type="hidden" name="laFechaHoy" value="<%=fechaDeFactura%>">			
		<div align="center"> <input name="Regresar" type="submit" id="Regresar" value="Reingresar N&uacute;mero Factura"> </div>
		</form>		
<%		}
		else{
			int almacena = factura.almacenaFacturas(rfc, nombre, ticket1, ticket2, ticket3, ticket4, ticket5, ArrayFactura, fechaDeFactura, produEnFac);
			if(almacena == -1){%>
				<b class="roj">Ocurrio un error al momento de almacenar en la BD, no se pudo guardar la Factura</b>					
<%			}			
			else if(almacena == 0){%>
				<b class="roj">Una de las facturas especificadas ya fue usada para otra Venta, verifique y modifique.</b>
				<form name="form1" method="post" action="Num_Factura.jsp">
					<input type="hidden" name="nombre" value="<%=nombre%>">
					<input type="hidden" name="rfc" value="<%=rfc%>">
					<input type="hidden" name="fecha1" value="<%=fecha1%>">
					<input type="hidden" name="fecha2" value="<%=fecha2%>">
					<input type="hidden" name="fecha3" value="<%=fecha3%>">
					<input type="hidden" name="fecha4" value="<%=fecha4%>">
					<input type="hidden" name="fecha5" value="<%=fecha5%>">
					<input type="hidden" name="ticket1" value="<%=ticket1%>">
					<input type="hidden" name="ticket2" value="<%=ticket2%>">
					<input type="hidden" name="ticket3" value="<%=ticket3%>">
					<input type="hidden" name="ticket4" value="<%=ticket4%>">
					<input type="hidden" name="ticket5" value="<%=ticket5%>">
					<input type="hidden" name="cantidadP" value="<%=cantidadP%>">
					<input type="hidden" name="subTotal" value="<%= subTotal%>" >
					<input type="hidden" name="iva" value="<%=iva2%>" >
					<input type="hidden" name="totalP" value="<%=totalP%>" >
					<input type="hidden" name="laFechaHoy" value="<%=fechaDeFactura%>">					
				<div align="center"> <input name="Regresar" type="submit" id="Regresar" value="Reingresar N&uacute;mero Factura"> </div>
				</form>											
<%			}
			else if(almacena == 2){ %>
				<b class="roj">Los tickets ya estan facturados, no emplee el Regresar del Navegador.</b>
<%			}
			else{
				ResultSet rs = factura.dameListadoTicketsFac(ticket1, ticket2, ticket3, ticket4, ticket5);			
				for(int i=0; i<ArrayFactura.length; i++){

					int ultimoProducto = factura.cambiaAInt(factura.dameEnteros(cantidadP));
					int primerProducto = ultimoProducto - (ultimoProducto-1);
					if(factura.cambiaAInt(factura.dameEnteros(cantidadP)) > factura.cambiaAInt(factura.dameEnteros(produEnFac))){
						ultimoProducto = factura.cambiaAInt(factura.dameEnteros(produEnFac))*(i+1);
						primerProducto = ultimoProducto - (factura.cambiaAInt(factura.dameEnteros(produEnFac))-1);
					}
					double tasa0 = 0.00;
					double tasa15 = 0.00;
					double iva = 0.00;	
					BigDecimal porcentajeIva = new BigDecimal("115.00");
					BigDecimal porcentajeNeto = new BigDecimal("100.00");
					int contador = 0;
					while(rs.next()){
						contador ++;					
						if((contador >= primerProducto) && (contador <= ultimoProducto)){
							if(rs.getInt("gravaIVA") == 0){
								tasa0 += rs.getDouble("precioAPagar");
							}
							else{
								BigDecimal precioOriginalConIVA = new BigDecimal(rs.getString("precioAPagar"));
								BigDecimal precioTotalP = new BigDecimal(rs.getString("precioAPagar"));
								precioTotalP = precioTotalP.multiply(porcentajeNeto);
								precioTotalP = precioTotalP.divide(porcentajeIva, new MathContext(100));
								precioOriginalConIVA = precioOriginalConIVA.subtract(precioTotalP);
								precioTotalP = precioTotalP.setScale(2, RoundingMode.HALF_UP);
								precioOriginalConIVA = precioOriginalConIVA.setScale(2, RoundingMode.HALF_UP);
								tasa15 += factura.cambiaADouble(precioTotalP.toString());
								iva += factura.cambiaADouble(precioOriginalConIVA.toString());
							}
						} // Cierro limite contador
					}//Cierro ResultSet
					%>
					<form name="formFac" action="Print_Fac.jsp" method="post" target="_blank">
						<input type="hidden" name="fechaFac" value="<%=fechaDeFactura%>">
						<input type="hidden" name="ticket1" value="<%=ticket1%>">
						<input type="hidden" name="ticket2" value="<%=ticket2%>">
						<input type="hidden" name="ticket3" value="<%=ticket3%>">
						<input type="hidden" name="ticket4" value="<%=ticket4%>">
						<input type="hidden" name="ticket5" value="<%=ticket5%>">
						<input type="hidden" name="primerProducto" value="<%=primerProducto+""%>">
						<input type="hidden" name="ultimoProducto" value="<%=ultimoProducto+""%>">
						<input type="hidden" name="tasa0" value="<%=tasa0+""%>">
						<input type="hidden" name="tasa15" value="<%=tasa15+""%>">
						<input type="hidden" name="iva" value="<%=iva+""%>">
						<input type="hidden" name="rfc" value="<%=rfc%>">
						<input type="hidden" name="nombre" value="<%=nombre%>">						
					<table align="center" cellpadding="0" cellspacing="0" width="300" border="1">
					  <tr>
					  	<th>Factura #<%=ArrayFactura[i]%></th>
						<td><div align="center">
						  <input type="submit" name="Imprime" value="Imprime">
						  </div></td>
					  </tr>
					</table>
					
					</form>
<%					rs.beforeFirst();
				}
				factura.cierraConexion();
			}
		}		
	}
if (tipou.equalsIgnoreCase("administrador")){
%>
<p align="center"><a href="Menu_FacturasV.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<% } 
	else if(usuariou.equalsIgnoreCase("Factura")){ %>
<a href="Menu_Cajero.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a> 	
<%	}
%>
</body>
</html>
