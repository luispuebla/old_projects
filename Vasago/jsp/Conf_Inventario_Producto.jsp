<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %> 
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="inv" class="com.vas.bd.ManagerInventarios" />

<html>
<head>
<title>Confirmaci&oacute;n de Inventario del Producto</title>
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

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<p>&nbsp;</p>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String clave = request.getParameter("clave");
	String existencia = request.getParameter("existencia");
	String regalos = request.getParameter("regalos");
	String existenciaOri = request.getParameter("existenciaOri");
	String existenciaOriR = request.getParameter("existenciaOriR");
	
	if(regalos == null){
		regalos = "0";
		existenciaOriR = "0";		
	}
	int resultado = 0;
	resultado = inv.update_Producto_Inventario(clave, existenciaOri, existencia, existenciaOriR, regalos, usuario);
	if(resultado == 1){
%>
		<jsp:forward page="Menu_Inventarios.jsp" />
<% 
	}
	else if (resultado == 2){ 
%>
<b class="roj">¡NO SE REALIZO LA ACTUALIZACI&Oacute;N!...<br/></b>
<b class="roj">Existió una transacci&oacute;n que modific&oacute; paralelamente el Inventario de este Producto.<br/></b>
<b class="roj">Vuelva a introducir el cambio de Inventario para este Producto.</b>
<form name="retache" method="post" target="_self" action="Inventario_Producto.jsp">
<input type="hidden" name="clave" value="<%=clave%>">
<p>	<input type="submit" name="Volver" value="Volver"> </p>
</form>
<%
	}
	else{
%>
<b class="roj">Existió un problema al momento de Actualizar los Inventarios.</b>
<%}%>			
<p><a href="Menu_Inventarios.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
	
