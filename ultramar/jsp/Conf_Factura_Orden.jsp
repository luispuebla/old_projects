<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>

<jsp:useBean id="alCom" class="com.ult.bd.ManagerCompras" scope="page" />

<html>
<head>
<title>Factura Asignada a la Compra</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

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
<%//System.out.println("Asigno2");%>
<jsp:setProperty name="alCom" property="arrayCantidad" value="<%=ArrayCantidad%>"/>
<%//System.out.println("Asigno3");%>
<jsp:setProperty name="alCom" property="arrayProducto" value="<%=ArrayProducto%>"/>
<%	//System.out.println("Antes de nada");
	int validaCantidades = alCom.validaCantidadIngreso();
	if(validaCantidades == -1){
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