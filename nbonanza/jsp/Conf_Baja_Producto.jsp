<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>
<jsp:useBean id="prodc" class="com.alpha.bd.ManagerPro" />

<html>
<head>
<title>Baja de Producto</title>
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
<p>&nbsp; </p>
<%
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String plu = request.getParameter("plu");
	if(plu.trim().equals("")){
%>
		<form name="retache" method="post" target="_self" action="Baja_Producto.jsp">
		<b class="roj">Debes especificar la clave del producto a Eliminar.</b>
		<p><input type="submit" name="Volver" value="Volver"></p>
		</form>
<%		
	}
	else{
		boolean found = prodc.existe2(plu);
		if(!found) {
%>	
	<b class="roj">El Producto no se encuentra registrado en el Sistema.<br/></b>	
<%	
		}	 
		else{
			boolean exito = prodc.baja_Producto(plu);
			if(exito){
%>
	<h1>El Producto fue dado de baja exitosamente.</h1>
<%
			}
			else{
%>
	<b class="roj">El Producto no pudo ser dado de baja.<br/></b>	
<%		
			}
		}
	}	
%>
<p align="center"><a href="Menu_Productos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
