<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Alta de Bancos</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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

function funcionFoco(){
	document.form1.banco.focus();
}

//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body  onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco()" >
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<h1>ALTA DE BANCOS </h1>
<p align="center">Llena todos los campos de la forma para  dar de alta un Banco:</p>
<form name="form1" method="post" action="Conf_Alta_Banco.jsp">
  <table width="769" border="1">
    <tr> 
      <th width="138" height="52" bgcolor="#CCCCCC">  Banco:</th>
      <td width="638"> <input name="banco" type="text" id="banco" size="100" maxlength="100"> 
        <span class="style1">**</span>  </td>
    </tr>
    <tr> 
      <th height="52" bgcolor="#CCCCCC"> N&uacute;mero:</th>
      <td><input name="numero" type="text" id="numero" size="30" maxlength="30">        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Importe Inicial :</th>
      <td> $ <input name="importe" type="text" id="importe" size="12" maxlength="10">
        <span class="style1">**</span>  </td>
    </tr>	
  </table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
  </p>
</form>
<p><a href="Menu_Cuentas.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>