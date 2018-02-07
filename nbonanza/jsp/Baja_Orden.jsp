<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Baja Compra</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
   String claveOrden = request.getParameter("claveOrden");
 if(claveOrden == null){
%>
	<b class="roj">Debes seleccionar una Clave.</b>
<% } else{ 
	boolean hayModificadores = alCom.existenModPrecios(claveOrden);
	
%>
	<h1>BAJA DE COMPRA </h1>
	  <p><b class="aviso">&iquest; Esta seguro de que desea eliminar la Compra <br/> con Clave <%=claveOrden%> ? </b> </p>
<% if (hayModificadores){ %>
<form name="form1" method="post" action="Conf_Baja_Orden.jsp">
	<input type="hidden" name="claveOrden" value="<%= claveOrden%>">
	<input type="hidden" name="cambioPrecio" value="1">
	  <p> <input type="submit" name="Submit" value=" S&iacute;, Modificando Precio(s) Compra/Venta"> </p>
</form>	  
<form name="form1" method="post" action="Conf_Baja_Orden.jsp">
	<input type="hidden" name="claveOrden" value="<%= claveOrden%>">
	<input type="hidden" name="cambioPrecio" value="0">
	  <p> <input type="submit" name="Submit" value=" S&iacute;, Sin Modificar Precio(s) Compra/Venta"> </p>	  
</form>	  	  
<%	} else {%>
<form name="form1" method="post" action="Conf_Baja_Orden.jsp">
	<input type="hidden" name="claveOrden" value="<%= claveOrden%>">
	<input type="hidden" name="cambioPrecio" value="0">
	  <p> <input type="submit" name="Submit" value=" S&iacute; &nbsp;"> </p>
</form>	  	  	  
<% 	} %>	
	  <p>Al Aceptar se decrementar&aacute; del Inventario los productos recibidos <br/> de esta compra , as&iacute; como los pagos realizados. </p>	    

<%}%>
<p align="center"><a href="Menu_Compras.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>