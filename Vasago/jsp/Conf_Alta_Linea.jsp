<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="personalM" class="com.vas.bd.ManagerPersonal" scope="page" />
<jsp:useBean id="li" class="com.vas.bd.ManagerLineas" scope="page" />

<html>
<head>
<title>Confirmación Almacenamiento Línea</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
function MandaSubmit(){
	document.formaR.submit();
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String clave = request.getParameter("clave");
	String nombre = request.getParameter("nombre"); 
%>
<%
	int valida = li.valida_add(clave, nombre);
	if(valida == 1){
		boolean existeC = li.existe(clave);
		if(!existeC){
			boolean guardado = li.add_Linea(clave, nombre);
			if (guardado){
%>
		<jsp:forward page="Menu_Lineas.jsp" />
<%		
			}
			else{
%>
		<b class="roj">Ocurrio un Error al Guardar en la Base de Datos</b>		
<p>&nbsp;</p>
<p><a href="Alta_Linea.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%		
			}
		}
		else{
%>
		<b class="roj">La Clave de Línea ya se encuentra registrada en el Sistema.</b>		
<p>&nbsp;</p>
<p><a href="Alta_Linea.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%			
		}
	}
	else{
%>
		<b class="roj">Debes llenar todos los Campos.</b>		
<p>&nbsp;</p>
<p><a href="Alta_Linea.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>

<%		
		}
%> 
</body>
</html>
