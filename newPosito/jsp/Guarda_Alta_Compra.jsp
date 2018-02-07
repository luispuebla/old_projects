<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Guardar Orden de Compra</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){
	document.RegN.submit();
}

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
-->
</script>
</head>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String datebox = alCom.dameFechaHoy();
	String proveedorC = request.getParameter("proveedorC");
	String tipoDoc = request.getParameter("tipoDoc");
	String aval = "";
	String[] ArrayCantidad = (String[])request.getParameterValues("cantidad");
	String[] ArrayProducto = (String[])request.getParameterValues("producto");
	String[] ArrayTipo = (String[])request.getParameterValues("tipo");		
	String[] ArrayCUnidad = (String[])request.getParameterValues("unidad");
	String[] ArrayImporte = (String[])request.getParameterValues("importe");
	String[] ArrayCambio = (String[])request.getParameterValues("cambio");	
	String prodRegalo1 = request.getParameter("prodRegalo1");
	String prodRegalo2 = request.getParameter("prodRegalo2");
	String prodRegalo3 = request.getParameter("prodRegalo3");
	String tipoUniRegalo1 = request.getParameter("tipoUniRegalo1");
	String tipoUniRegalo2 = request.getParameter("tipoUniRegalo2");
	String tipoUniRegalo3 = request.getParameter("tipoUniRegalo3");
	String cantidadRegalo1 = request.getParameter("cantidadRegalo1");
	String cantidadRegalo2 = request.getParameter("cantidadRegalo2");
	String cantidadRegalo3 = request.getParameter("cantidadRegalo3");
	String recepcion = request.getParameter("rg");
	if(recepcion.equals("1")){
		aval = request.getParameter("aval").trim();		
	}
	if(recepcion.equals("2")){
		datebox = request.getParameter("datebox");
	}
	String subtotal = request.getParameter("subtotal");
	String descuento = request.getParameter("descuentos");
	String iva = request.getParameter("iva");
	String total = request.getParameter("total");
	String descuento1 = request.getParameter("descuento1");
	String descuento2 = request.getParameter("descuento2");
	String descuento3 = request.getParameter("descuento3");
	String observaciones = request.getParameter("observaciones");
	String mes = datebox.substring(0,2);
	String dia = datebox.substring(3,5);
	String ano = datebox.substring(6,10);
	String fechaentrega = ano+"-"+mes+"-"+dia;
%>
<body onLoad="MM_preloadImages('imagenes/Imprimir2.jpg')">
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedorC%>"/>
<jsp:setProperty name="alCom" property="observaciones" value="<%=observaciones%>"/>
<jsp:setProperty name="alCom" property="tipoDocumento" value="<%=tipoDoc%>"/>
<jsp:setProperty name="alCom" property="descuento1" value="<%=descuento1%>"/>
<jsp:setProperty name="alCom" property="descuento2" value="<%=descuento2%>"/>
<jsp:setProperty name="alCom" property="descuento3" value="<%=descuento3%>"/>
<jsp:setProperty name="alCom" property="subtotal" value="<%=subtotal%>"/>
<jsp:setProperty name="alCom" property="descuento" value="<%=descuento%>"/>
<jsp:setProperty name="alCom" property="iva" value="<%=iva%>"/>
<jsp:setProperty name="alCom" property="total" value="<%=total%>"/>
<jsp:setProperty name="alCom" property="fechaentrega" value="<%=fechaentrega%>"/>
<jsp:setProperty name="alCom" property="arrayProducto" value="<%=ArrayProducto%>"/>
<jsp:setProperty name="alCom" property="arrayTipo" value="<%=ArrayTipo%>"/>
<jsp:setProperty name="alCom" property="arrayCunidad" value="<%=ArrayCUnidad%>"/>
<jsp:setProperty name="alCom" property="arrayImporte" value="<%=ArrayImporte%>"/>
<jsp:setProperty name="alCom" property="arrayCantidad" value="<%=ArrayCantidad%>"/>
<jsp:setProperty name="alCom" property="arrayCambio" value="<%=ArrayCambio%>"/>
<jsp:setProperty name="alCom" property="can1" value="<%=cantidadRegalo1%>"/>
<jsp:setProperty name="alCom" property="can2" value="<%=cantidadRegalo2%>"/>
<jsp:setProperty name="alCom" property="can3" value="<%=cantidadRegalo3%>"/>
<jsp:setProperty name="alCom" property="prod1" value="<%=prodRegalo1%>"/>
<jsp:setProperty name="alCom" property="prod2" value="<%=prodRegalo2%>"/>
<jsp:setProperty name="alCom" property="prod3" value="<%=prodRegalo3%>"/>
<jsp:setProperty name="alCom" property="tipoUni1" value="<%=tipoUniRegalo1%>"/>
<jsp:setProperty name="alCom" property="tipoUni2" value="<%=tipoUniRegalo2%>"/>
<jsp:setProperty name="alCom" property="tipoUni3" value="<%=tipoUniRegalo3%>"/>
<jsp:setProperty name="alCom" property="docAval" value="<%=aval%>"/>
<jsp:setProperty name="alCom" property="recepcion" value="<%=recepcion%>"/>
<% //System.out.println("envio información jsp al java");
String clave = alCom.add_Orden_Compra(usuario);
if(alCom.cambiaAInt(clave) > 0){	%>
<table align="center" border="0" width="600">
<caption>
Se guard&oacute; satisfactoriamente la Transacci&oacute;n.
</caption>
  <tr>
  	<td><div align="center"><b>Clave de Compra:</b></div></td>
  </tr>
  <tr>
	<th height="50"><b class="titulos"><%=clave%></b></th>
  </tr>		
<% if(recepcion.equals("1")){  %>
  <tr>
  	<td height="50"><div align="center"><b class="aviso"> --> La compra ya fue ingresada al Inventario por ser de Recepci&oacute;n Directa. <-- </b></div></td>
  </tr>
<% } else { %>
  <tr>
  	<td height="50"><div align="center"><b class="aviso"> --> Deber&aacute; realizar la(s) recepcion(es) de Mercanc&iacute;a para alimentar el Inventario por ser una Recepci&oacute;n Programada <-- </b></div></td>
  </tr>
<% } %>  
  <tr>	
	<td height="35"><form method="post" target="_blank" name="RegN" action="Imprimir_Compra.jsp">
		<div align="center">
		  <input type="hidden" name="claveCompra" value="<%=clave%>">
		  <input type="submit" value="Imprime Compra" name="Imprime">
	      </div>
	</form></td>	
  </tr>
</table>
<% 	}	else{ %>
<b class="roj">No se pudo concretar la transacci&oacute;n de Compra.<br/>Vuelva a intentarlo.</b>
<% } %>
	
<p><a href="Menu_Compras.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
