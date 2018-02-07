<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>

<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Factura Asignada a la Compra</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}


String compra = "";
String fechaCompra = "";
compra = request.getParameter("factura"); 
String datebox = request.getParameter("datebox");

if(compra.length() <= 0 || datebox.length() <= 0 ){
 	out.print("Debes ingresar la Factura y su Fecha.");
}
else{

String mes = datebox.substring(0,2);
String dia = datebox.substring(3,5);
String ano = datebox.substring(6,10);
fechaCompra = ano+"-"+mes+"-"+dia;
String clave = request.getParameter("clave");
String claveProveedor = request.getParameter("cProveedor");
%>
<jsp:setProperty name="alCom" property="claveOrden" value="<%=clave%>"/>
<%//System.out.println("Inicio");
	boolean registro = true;
	
String cantidad1 = "";
String cantidad2 = "";
String cantidad3 = "";
String cantidad4 = "";
String cantidad5 = "";
String cantidad6 = "";
String cantidad7 = "";
String cantidad8 = "";
String cantidad9 = "";
String cantidad10 = "";
String cantidad11 = "";
String cantidad12 = "";
String cantidad13 = "";
String cantidad14 = "";
String cantidad15 = "";
String producto1 = "";
String producto2 = "";
String producto3 = "";
String producto4 = "";
String producto5 = "";
String producto6 = "";
String producto7 = "";
String producto8 = "";
String producto9 = "";
String producto10 = "";
String producto11 = "";
String producto12 = "";
String producto13 = "";
String producto14 = "";
String producto15 = "";

	if(request.getParameter("cantidadR1") != null)
		cantidad1 = request.getParameter("cantidadR1");
	if(request.getParameter("cantidadR2") != null)
		cantidad2 = request.getParameter("cantidadR2");
	if(request.getParameter("cantidadR3") != null)
		cantidad3 = request.getParameter("cantidadR3");
	if(request.getParameter("cantidadR4") != null)
		cantidad4 = request.getParameter("cantidadR4");
	if(request.getParameter("cantidadR5") != null)
		cantidad5 = request.getParameter("cantidadR5");
	if(request.getParameter("cantidadR6") != null)
		cantidad6 = request.getParameter("cantidadR6");
	if(request.getParameter("cantidadR7") != null)
		cantidad7 = request.getParameter("cantidadR7");
	if(request.getParameter("cantidadR8") != null)
		cantidad8 = request.getParameter("cantidadR8");
	if(request.getParameter("cantidadR9") != null)
		cantidad9 = request.getParameter("cantidadR9");
	if(request.getParameter("cantidadR10") != null)
		cantidad10 = request.getParameter("cantidadR10");
	if(request.getParameter("cantidadR11") != null)
		cantidad11 = request.getParameter("cantidadR11");
	if(request.getParameter("cantidadR12") != null)
		cantidad12 = request.getParameter("cantidadR12");
	if(request.getParameter("cantidadR13") != null)
		cantidad13 = request.getParameter("cantidadR13");
	if(request.getParameter("cantidadR14") != null)
		cantidad14 = request.getParameter("cantidadR14");
	if(request.getParameter("cantidadR15") != null)
		cantidad15 = request.getParameter("cantidadR15");
	if(request.getParameter("productoR1") != null)
		producto1 = request.getParameter("productoR1");
	if(request.getParameter("productoR2") != null)
		producto2 = request.getParameter("productoR2");
	if(request.getParameter("productoR3") != null)
		producto3 = request.getParameter("productoR3");
	if(request.getParameter("productoR4") != null)
		producto4 = request.getParameter("productoR4");
	if(request.getParameter("productoR5") != null)
		producto5 = request.getParameter("productoR5");
	if(request.getParameter("productoR6") != null)
		producto6 = request.getParameter("productoR6");
	if(request.getParameter("productoR7") != null)
		producto7 = request.getParameter("productoR7");
	if(request.getParameter("productoR8") != null)
		producto8 = request.getParameter("productoR8");
	if(request.getParameter("productoR9") != null)
		producto9 = request.getParameter("productoR9");
	if(request.getParameter("productoR10") != null)
		producto10 = request.getParameter("productoR10");
	if(request.getParameter("productoR11") != null)
		producto11 = request.getParameter("productoR11");
	if(request.getParameter("productoR12") != null)
		producto12 = request.getParameter("productoR12");
	if(request.getParameter("productoR13") != null)
		producto13 = request.getParameter("productoR13");
	if(request.getParameter("productoR14") != null)
		producto14 = request.getParameter("productoR14");
	if(request.getParameter("productoR15") != null)
		producto15 = request.getParameter("productoR15");

//System.out.println("Cantidad: "+cantidad2);
int cantNumProductos = 0;
String[] ArrayCantidad   = new String[2];
String[] ArrayProducto   = new String[2];
cantNumProductos = alCom.cuentaTodosProductosOrden();
String cantNumProductos0 = cantNumProductos+"";
ArrayCantidad   = new String[cantNumProductos+1];
ArrayProducto   = new String[cantNumProductos+1];
for (int i =1; i<=cantNumProductos; i++){
		ArrayCantidad[i] = request.getParameter("cantidad"+i);
		ArrayProducto[i] = request.getParameter("producto"+i);
		//System.out.println("Llega de FActura orden: "+ArrayUnidad[i]);
}
//System.out.println("La factura: "+compra+" La fecha: "+fechaCompra+" La orden: "+clave);
%>
<jsp:setProperty name="alCom" property="claveOrden" value="<%=clave%>"/>
<jsp:setProperty name="alCom" property="cantNumProductos" value="<%=cantNumProductos0%>"/>
<jsp:setProperty name="alCom" property="compra" value="<%=compra%>"/>
<jsp:setProperty name="alCom" property="fechaCompra" value="<%=fechaCompra%>"/>	
<jsp:setProperty name="alCom" property="can1" value="<%=cantidad1%>"/>	
<jsp:setProperty name="alCom" property="can2" value="<%=cantidad2%>"/>	
<jsp:setProperty name="alCom" property="can3" value="<%=cantidad3%>"/>	
<jsp:setProperty name="alCom" property="can4" value="<%=cantidad4%>"/>	
<jsp:setProperty name="alCom" property="can5" value="<%=cantidad5%>"/>	
<jsp:setProperty name="alCom" property="can6" value="<%=cantidad6%>"/>	
<jsp:setProperty name="alCom" property="can7" value="<%=cantidad7%>"/>	
<jsp:setProperty name="alCom" property="can8" value="<%=cantidad8%>"/>	
<jsp:setProperty name="alCom" property="can9" value="<%=cantidad9%>"/>	
<jsp:setProperty name="alCom" property="can10" value="<%=cantidad10%>"/>	
<jsp:setProperty name="alCom" property="can11" value="<%=cantidad11%>"/>	
<jsp:setProperty name="alCom" property="can12" value="<%=cantidad12%>"/>	
<jsp:setProperty name="alCom" property="can13" value="<%=cantidad13%>"/>	
<jsp:setProperty name="alCom" property="can14" value="<%=cantidad14%>"/>	
<jsp:setProperty name="alCom" property="can15" value="<%=cantidad15%>"/>	
<jsp:setProperty name="alCom" property="prod1" value="<%=producto1%>"/>	
<jsp:setProperty name="alCom" property="prod2" value="<%=producto2%>"/>	
<jsp:setProperty name="alCom" property="prod3" value="<%=producto3%>"/>	
<jsp:setProperty name="alCom" property="prod4" value="<%=producto4%>"/>	
<jsp:setProperty name="alCom" property="prod5" value="<%=producto5%>"/>	
<jsp:setProperty name="alCom" property="prod6" value="<%=producto6%>"/>	
<jsp:setProperty name="alCom" property="prod7" value="<%=producto7%>"/>	
<jsp:setProperty name="alCom" property="prod8" value="<%=producto8%>"/>	
<jsp:setProperty name="alCom" property="prod9" value="<%=producto9%>"/>	
<jsp:setProperty name="alCom" property="prod10" value="<%=producto10%>"/>	
<jsp:setProperty name="alCom" property="prod11" value="<%=producto11%>"/>	
<jsp:setProperty name="alCom" property="prod12" value="<%=producto12%>"/>	
<jsp:setProperty name="alCom" property="prod13" value="<%=producto13%>"/>	
<jsp:setProperty name="alCom" property="prod14" value="<%=producto14%>"/>	
<jsp:setProperty name="alCom" property="prod15" value="<%=producto15%>"/>	
<%//System.out.println("Asigno2");%>
<jsp:setProperty name="alCom" property="arrayCantidad" value="<%=ArrayCantidad%>"/>
<%//System.out.println("Asigno3");%>
<jsp:setProperty name="alCom" property="arrayProducto" value="<%=ArrayProducto%>"/>
<%	//System.out.println("Antes de nada");
	int validaCantidades = alCom.validaCantidadIngreso();
	int validaCantidadesObsequios = alCom.validaCantidadIngresoObsequio();
	if(validaCantidades == -1 && validaCantidadesObsequios == -1){
		registro= alCom.finalizaRecepcion(usuario);
		if(registro){%>
					<jsp:forward page="Menu_Compras.jsp" />  
		<% }
		else{
			out.print("Existió algún problema al asignar la Factura a la Orden de Compra en la Base de Datos.");
		}
	}
	else{
%>	
<form method="post" name="form1" action="Factura_Orden.jsp">
<%	if(validaCantidades != -1){ %>
		<b class="aviso">Por lo menos la cantidad del producto comprado #<%=validaCantidades%> <br /> <b>no</b> concuerda con el faltante real.</b>
		<p>Posibles causas:<br />
			Se esta ingresando más cantidad de producto de lo que se tiene solicitado en la &Oacute;rden de Compra.</p>
<% } %>			
<%	if(validaCantidadesObsequios != -1){ %>
		<b class="aviso">Por lo menos la cantidad del producto obsequiado #<%=validaCantidadesObsequios%><br /> no concuerda con el faltante real.</b>
		<p>Posibles causas:<br />
			Se esta ingresando más cantidad de producto obsequiado de lo que se tiene solicitado en la &Oacute;rden de Compra.</p>
<% } %>						
			<input type="hidden" name="clave" value="<%=clave %>">
			<input type="hidden" name="proveedor" value="<%=claveProveedor %>">
			<p align="center"><input type="submit" value="Reingresar"></p>
			
</form>			
<%		 
	}
	}
%>
</p>
<p>&nbsp;</p>
<p align="center"><a href="Escoge_Proveedor_Orden_Factura.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	