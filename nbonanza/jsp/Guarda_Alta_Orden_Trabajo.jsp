<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Almacenamiento de Orden de Trabajo</title>
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
	String  datebox = request.getParameter("datebox");
	String mes = datebox.substring(0,2);
	String dia = datebox.substring(3,5);
	String ano = datebox.substring(6,10);
	String fechaAlta = ano+"-"+mes+"-"+dia;	
	String[] ArrayCantidad = (String[])request.getParameterValues("cantidad");
	String[] ArrayProducto = (String[])request.getParameterValues("producto");
	String observaciones = request.getParameter("observaciones");	
	String claveOrden = "";
%>
<body> 
<%
	String primero = "";
	primero=alProd.add_Orden_Trabajo(fechaAlta, ArrayCantidad, ArrayProducto, observaciones, usuario);
	int direccion = 1;
	if(primero.startsWith("ERROR")){
		direccion = -1;
	}
 if(primero.startsWith("OK")){
		claveOrden = primero.substring((primero.lastIndexOf("*")+1),primero.length());
		//System.out.println("Clave Compra: " +claveDeCompra);
	}
	// Se agoto de inventario al menos uno de los productos.

if(direccion != -1){ %>
	  	<p class="aviso">¡Almacenamiento Exitoso!</p>	
		<table align="center" cellpadding="0" cellspacing="0" border="1" width="500">
		<tr>
			<td width="259"><b class="aviso">Orden de Trabajo  con clave:</b></td>
			<th width="235"><b><%=claveOrden%></b></th>
		</tr>
		</table>
		<form method="post" target="_blank" name="RegN" action="Imprimir_Orden_Trabajo.jsp"> 
		<input type="submit" value="Impresión Órden" name="ImpresionOrden">
		<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
		<input type="hidden" name="usuario" value="<%=usuario%>">
	  </form>

<%
	 }	
	else if(direccion == -1){

				out.print("Existió algún problema al guardar la Orden de Trabajo en la Base de Datos.");
	}
%>
	<p><a href="Menu_Ordenes_Trabajo.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
