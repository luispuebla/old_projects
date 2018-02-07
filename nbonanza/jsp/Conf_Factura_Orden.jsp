<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Factura Asignada a la Compra</title>
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
<body>
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
	String compra =  request.getParameter("factura"); 
	String tipoDoc = request.getParameter("tipoDoc");
	if(compra.length()<= 0){
%>
	<b class="roj">Debes ingresar la Factura y su Fecha.</b>
<%	 } else{
	String fechaCompra = "";
	String datebox = request.getParameter("datebox");
	String mes = datebox.substring(0,2);
	String dia = datebox.substring(3,5);
	String ano = datebox.substring(6,10);
	fechaCompra = ano+"-"+mes+"-"+dia;
	String claveOrden = request.getParameter("claveOrden");
	String claveProveedor = request.getParameter("cProveedor");
%>
<jsp:setProperty name="alCom" property="claveOrden" value="<%=claveOrden%>"/>
<%//System.out.println("Inicio");
	int registro = 0;
	String prodRegalo1 = "";
	String cantidadRegalo1 = "";	
	String tipoUniRegalo1 = "";
	String prodRegalo2 = "";
	String cantidadRegalo2 = "";	
	String tipoUniRegalo2 = "";
	String prodRegalo3 = "";
	String cantidadRegalo3 = "";	
	String tipoUniRegalo3 = "";
	if(request.getParameter("prodRegalo1")!= null){
		prodRegalo1 = request.getParameter("prodRegalo1");
		cantidadRegalo1 = request.getParameter("cantidadRegalo1");
		tipoUniRegalo1 = request.getParameter("tipoUniRegalo1");				
	}
	if(request.getParameter("prodRegalo2")!= null){
		prodRegalo2 = request.getParameter("prodRegalo2");
		cantidadRegalo2 = request.getParameter("cantidadRegalo2");
		tipoUniRegalo2 = request.getParameter("tipoUniRegalo2");				
	}
	if(request.getParameter("prodRegalo3")!= null){
		prodRegalo3 = request.getParameter("prodRegalo3");
		cantidadRegalo3 = request.getParameter("cantidadRegalo3");
		tipoUniRegalo3 = request.getParameter("tipoUniRegalo3");				
	}
	String[] ArrayCantidad = (String[]) request.getParameterValues("cantidad");
	String[] ArrayProducto = (String[]) request.getParameterValues("producto");
	String[] ArrayTipo = (String[]) request.getParameterValues("tipo");
	String[] ArrayCambio = (String[]) request.getParameterValues("cambio");
%> 
<jsp:setProperty name="alCom" property="claveOrden" value="<%=claveOrden%>"/>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=claveProveedor%>"/>
<jsp:setProperty name="alCom" property="compra" value="<%=compra%>"/>
<jsp:setProperty name="alCom" property="tipoDocumento" value="<%=tipoDoc%>"/>
<jsp:setProperty name="alCom" property="fechaCompra" value="<%=fechaCompra%>"/>	
<jsp:setProperty name="alCom" property="can1" value="<%=cantidadRegalo1%>"/>
<jsp:setProperty name="alCom" property="can2" value="<%=cantidadRegalo2%>"/>
<jsp:setProperty name="alCom" property="can3" value="<%=cantidadRegalo3%>"/>
<jsp:setProperty name="alCom" property="prod1" value="<%=prodRegalo1%>"/>
<jsp:setProperty name="alCom" property="prod2" value="<%=prodRegalo2%>"/>
<jsp:setProperty name="alCom" property="prod3" value="<%=prodRegalo3%>"/>
<jsp:setProperty name="alCom" property="tipoUni1" value="<%=tipoUniRegalo1%>"/>
<jsp:setProperty name="alCom" property="tipoUni2" value="<%=tipoUniRegalo2%>"/>
<jsp:setProperty name="alCom" property="tipoUni3" value="<%=tipoUniRegalo3%>"/>
<jsp:setProperty name="alCom" property="arrayProducto" value="<%=ArrayProducto%>"/>
<jsp:setProperty name="alCom" property="arrayTipo" value="<%=ArrayTipo%>"/>
<jsp:setProperty name="alCom" property="arrayCantidad" value="<%=ArrayCantidad%>"/>
<jsp:setProperty name="alCom" property="arrayCambio" value="<%=ArrayCambio%>"/>
<%	
	registro= alCom.finalizaRecepcion(usuario);
	if(registro == 0){%>
					<jsp:forward page="Menu_Recepciones.jsp" />  
<% }
	else if (registro == 1){
%>	
		<b class="roj">No concuerdan las cantidades faltantes en Productos Comprados</b>
		<p>Causa:<br />
			Se esta ingresando más cantidad de producto comprado de lo que se tiene solicitado en la &Oacute;rden de Compra.</p>
<p>		<form name="retache1" action="Factura_Orden.jsp" target="_self" method="post">
			<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
			<input type="hidden" name="proveedor" value="<%=claveProveedor%>">			
			<input type="submit" value="Reingresar" name="Reingresar Datos">
		</form> </p>
<%		
	}
	else if (registro == 2){
%>	
		<b class="roj">No concuerdan las cantidades faltantes en Productos de Obsequio</b>
		<p>Causa:<br />
			Se esta ingresando más cantidad de producto obsequiado de lo que se tiene solicitado en la &Oacute;rden de Compra.</p>
<p>		<form name="retache1" action="Factura_Orden.jsp" target="_self" method="post">
			<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
			<input type="hidden" name="proveedor" value="<%=claveProveedor%>">			
			<input type="submit" value="Reingresar" name="Reingresar Datos">
		</form> </p>			
<% }
	else{  %>
		<b class="roj">Ocurrio un error con la Base de Datos, vuelva a intentarlo.</b>		
<%		 
	}
}
%>
</p>
<p>&nbsp;</p>
<p align="center"><a href="Escoge_Proveedor_Orden_Factura.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	