<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="passw" class="com.alpha.bd.ManagerUsuarios" />

<html>
<head>
<title>Confirmación de nuevo Password</title>
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
<p align="center">
<%
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String usuario = "super";
	String pass1 = request.getParameter("pass1");
	String pass2 = request.getParameter("pass2");
	String pass3 = request.getParameter("pass3");
	if(pass2.equals(pass3) && !(pass2.trim().equals(""))){ 
		if (passw.Valida_Pass_Nuevo(pass1, pass2, pass3)) { 
			int resultado = passw.cambioContraTipo(pass1, pass2);
			if(resultado == 2){
				response.sendRedirect("Menu_Contras_Texto.jsp");
			}
			else if(resultado == 1){ %>
				<b class="roj"> No concuerda la contrase&ntilde;a previa. Modifiquela. </b><br/>
<form name="regreso" action="Cambia_Pass_Precios.jsp" target="_self" method="post">
					<input type="hidden" name="interno" value="">
					<input type="hidden" name="pass1" value="">					
					<input type="hidden" name="pass2" value="<%=pass2%>">
					<input type="hidden" name="pass3" value="<%=pass3%>">										
					<input type="submit" name="Volver" value="Volver">
</form>
<%			}
			else{ %>
				<b class="roj">Ocurri&oacute; un error al accesar a la Base de Datos, no se pudo cambiar la contraseña. </b><br/>
<%			} 			
		}
		 else{  %>	 
			<b class="roj">Falta un campo por llenar</b><br/>
				<form name="regreso1" action="Cambia_Pass_Precios.jsp" target="_self" method="post">
					<input type="hidden" name="interno" value="">				
					<input type="hidden" name="pass1" value="<%=pass1%>">
					<input type="hidden" name="pass2" value="">
					<input type="hidden" name="pass3" value="">										
					<input type="submit" name="Volver" value="Volver">
				</form>					
<%  	} 
	}
	else{ %>
		<b class="roj">La nueva contrase&ntilde;a no concuerda en la confirmaci&oacute;n, o est&aacute; en blanco.</b><br/>
				<form name="regreso2" action="Cambia_Pass_Precios.jsp" target="_self" method="post">
					<input type="hidden" name="interno" value="">				
					<input type="hidden" name="pass1" value="<%=pass1%>">
					<input type="hidden" name="pass2" value="">
					<input type="hidden" name="pass3" value="">										
					<input type="submit" name="Volver" value="Volver">
				</form>		
<%	} %>
	
	
</p>
<p align="center"><a href="Menu_Contras_Texto.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

