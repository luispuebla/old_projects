<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="personalV" class="com.vas.bd.ManagerPersonal" scope="page" />

<html>
<head>
<title>Confirmacion Baja Personal de Cobros</title>
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
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	String elUsuario = request.getParameter("claveu").trim();
%>
<jsp:setProperty name="personalV" property="usuario" value="<%=elUsuario%>"/>
<%
if(elUsuario.equalsIgnoreCase("super") || elUsuario.equalsIgnoreCase("salvador") || elUsuario.equalsIgnoreCase("piero") || elUsuario.equalsIgnoreCase("bety")){
%>
	<p align="center">Los Usuarios SUPER no se pueden dar de baja.</p>		
<p align="center"><a href="Menu_Personal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<%
}
else{

	boolean existe = personalV.yaExiste();
	if(existe){
		boolean exito = personalV.baja_Personal();
		if(exito){
%>
 <p align="center">El Usuario fue dado de baja exitosamente.</p>		
<%		
		}
		else{
%>
 <p align="center"><font color="#FF0000">Ocurrio un problema al momento de ejecutar la baja, vuelva a intentarlo.</font></p>		
<%		
		}
%>
<p align="center"><a href="Menu_Personal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<%		
	}
	else{
%>
 <p align="center"><font color="#FF0000">El Usuario que especifico no existe, Vuelva a intentarlo</font></p>		

<p align="center"><a href="Baja_Personal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache2','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache2" width="152" height="36" border="0"></a></p>
<%	
	}
}
%>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>
