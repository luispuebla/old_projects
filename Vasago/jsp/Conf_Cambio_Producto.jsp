<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="pro" class="com.vas.bd.ManagerProductos" />

<html>
<head>
<title>Confirmaci&oacute;n de modificaciones del Producto</title>
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
	String pxc = "";
	String clave = request.getParameter("clave");
	String tipo = request.getParameter("tipo");	
	String proveedor1 = request.getParameter("proveedor1");
	String proveedor2 = request.getParameter("proveedor2");
	String proveedor3 = request.getParameter("proveedor3");
	String proveedor4 = request.getParameter("proveedor4");
	String proveedor5 = request.getParameter("proveedor5");
	String descripcion = request.getParameter("descripcion");
	if (tipo.equals("1")){
		pxc = request.getParameter("pxc");
	}
	String costo = request.getParameter("costo");
	String p1 = request.getParameter("p1");
	String p2 = request.getParameter("p2");
	String p3 = request.getParameter("p3");
	String p4 = request.getParameter("p4");
	String p5 = request.getParameter("p5");
	String max = request.getParameter("max");
	String min = request.getParameter("min");

	boolean resultado = false;

	int llenado = pro.valida_add2(clave, tipo, proveedor1, descripcion, pxc, costo, p1, p2, p3, p4, p5);
	
		if(llenado == 1) {
			resultado = pro.update_Producto(clave, tipo, proveedor1, proveedor2, proveedor3, proveedor4, proveedor5, descripcion, pxc, costo, p1, p2, p3, p4, p5, max, min);
			if(resultado){
%>
				<jsp:forward page="Menu_Productos2.jsp" />
<% 
			}
			else{  %>
				<b class="roj">Ocurrio un Error al Guardar en la Base de Datos</b>		
				<p>&nbsp;</p>
				<p><a href="Existe_Producto_Cambio.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
				<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 

<%
			}
		}  
		if (llenado == 2){
%>	
			<b class="roj">Se Deben llenar los campos necesarios.</b>
			<p>&nbsp;</p>
			<p align="center"><a href="Existe_Producto_Cambio.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
			<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<%
		} 
%>	
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
	
