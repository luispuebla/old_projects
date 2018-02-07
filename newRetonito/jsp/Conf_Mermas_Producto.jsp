<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />

<html>
<head>
<title>Confirmaci&oacute;n de Mermas del Producto</title>
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
<p>&nbsp;</p>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String elProducto = request.getParameter("elProducto");
	String invTienda = request.getParameter("invTienda");
	String invAlmacen = request.getParameter("invAlmacen");
	String causa = request.getParameter("causa");
	int resultado = inv.add_Mermas(elProducto, invTienda, invAlmacen, usuario, causa);
	if(resultado == 1){
%>
		<jsp:forward page="Menu_Inventarios.jsp" />
<% 
	}
	else if(resultado == 2){  %>
		<b class="roj">Sobre pasas la Cantidad Existente con t&uacute; Merma, Modificala</b><br/>
		<form name="retache" method="post" target="_self" action="Mermas_Producto.jsp">
		<input type="hidden" name="elProducto" value="<%=elProducto%>">
		<p><input type="submit" name="Volver" value="Volver"></p>
		</form>
		<p>&nbsp;</p>
<%
	}
	else {
%>	
		<b class="roj">Ocurrio un Error con la Base de Datos.</b>
		<p>&nbsp;</p>
<%
	} 
%>
<p><a href="Menu_Inventarios.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
<p align="center"></p>
<p><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
	
