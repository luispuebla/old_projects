<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Alta de Clientes</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
	document.form1.rfc.focus();
}

 function emailCheck() {
  txt=document.form1.email.value;
  if (txt.indexOf("@")<3){
   alert("La direccion e-mail no es valida. Por favor"
   +" introduzca una direccion que contenga el simbolo '@'.");
   }
  if ((txt.indexOf(".com")<5)&&(txt.indexOf(".org")<5)
  &&(txt.indexOf(".gov")<5)&&(txt.indexOf(".net")<5)
  &&(txt.indexOf(".mil")<5)){
   alert("La direccion e-mail no es valida."
   +" La direccion e-mail debe contener un sufijo del tipo "
   +".com,.net,.org,.gov or .mil");
  }
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<h1>ALTA DE CLIENTES</h1>
<p align="center">Llena todos los campos de la forma para  dar de alta un Cliente:</p>
<form name="form1" method="post" action="Conf_Alta_Cliente.jsp">
  <table width="666" border="1">
    <tr> 
      <th width="20%" bgcolor="#CCCCCC">RFC:</th>
      <td width="80%"> <input name="rfc" type="text" size="15" maxlength="13"> 
        <span class="style1">**</span> </td>
    </tr>
	<tr> 
      <th width="20%" bgcolor="#CCCCCC">Folio RFC:</th>
      <td width="80%"> <input name="folio" type="text" size="12" maxlength="10"> 
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th width="20%" bgcolor="#CCCCCC">CURP:</th>
      <td width="80%"> <input name="curp" type="text" size="20" maxlength="18">
      </td>
    </tr>
    <tr> 
      <th height="52" bgcolor="#CCCCCC"> Nombre del Cliente:</th>
      <td> <input name="nombre" type="text" size="80" maxlength="80"> <span class="style1">**</span> 
      </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Dirección:</th>
      <td> <input name="direccion" type="text" size="80" maxlength="80"> <span class="style1">**</span> 
      </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Colonia:</th>
      <td> <input name="colonia" type="text" size="30" maxlength="25"> <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Delegación / Municipio:</th>
      <td><input name="delegacion" type="text" size="25" maxlength="20"> <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Código Postal:</th>
      <td> <input name="cp" type="text" size="6" maxlength="5" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> 
        <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Ciudad:</th>
      <td> <input name="ciudad" type="text" size="35" maxlength="30"> <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Teléfono 1:</th>
      <td> <input name="tel1" type="text" size="25" maxlength="20"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Teléfono 2:</th>
      <td> <input name="tel2" type="text" size="25" maxlength="20"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Fax:</th>
      <td> <input name="fax" type="text" size="25" maxlength="20"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">e-mail:</th>
      <td> <input name="email" type="text" size="85" maxlength="80" onChange="emailCheck()"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Contacto:</th>
      <td> <input name="contacto" type="text" size="50" maxlength="50"></td>
    </tr>
  </table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
  </p>
</form>
<p><a href="Menu_Clientes.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>