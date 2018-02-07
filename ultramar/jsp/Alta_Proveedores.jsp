<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />

<html>
<head>
<title>Alta de Proveedores</title>
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
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<h1>ALTA DE PROVEEDORES </h1>
<p align="center">Llena todos los campos de la forma para  dar de alta un Proveedor:</p>
<form name="form1" method="post" action="Conf_Alta_Proveedor.jsp">
  <table width="724" border="1">
    <tr> 
      <th width="93" height="52" bgcolor="#CCCCCC"> RFC:</th>
      <td width="598"> <input name="rfc" type="text" size="15" maxlength="13"> 
        <span class="style1">**</span>  </td>
    </tr>
    <tr> 
      <th height="52" bgcolor="#CCCCCC"> Nombre:</th>
      <td> <input name="nombre" type="text" size="100" maxlength="100">
        <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Dirección:</th>
      <td> <input name="direccion" type="text" size="65" maxlength="50"> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Colonia:</th>
      <td> <input name="colonia" type="text" size="30" maxlength="25"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Delegación / Municipio:</th>
      <td><input name="delegacion" type="text" size="25" maxlength="20"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Código Postal:</th>
      <td> <input name="cp" type="text" size="6" maxlength="5" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Ciudad:</th>
      <td> <input name="ciudad" type="text" size="35" maxlength="30"></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Teléfono 1:</th>
      <td> <input name="tel1" type="text" size="25" maxlength="20">   <span class="style1">**</span></td>
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
    <th bgcolor="#CCCCCC">Página Web:</th>
      <td> <input name="pagina" type="text" size="100" maxlength="100" onChange="emailCheck()"></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">e-mail:</th>
      <td> <input name="email" type="text" size="85" maxlength="80" onChange="emailCheck()"></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Vendedor:</th>
      <td> <input name="vendedor" type="text" id="contacto" size="65" maxlength="50"></td>
	</tr>	
    <tr> 
      <th bgcolor="#CCCCCC">Forma de Pago:</th>
      <td> <select name="formaPago">
		  <option value="1">Efectivo</option>
          <option value="2">Cheque</option>
          <option value="3">Depósito</option>
          <option value="4">Tarjeta de Crédito</option>
          <option value="5">Tarjeta de Débito</option>
        </select></td>
	</tr>	
     <tr> 
      <th bgcolor="#CCCCCC">Cuentas del Banco:</th>
      <td><textarea name="cuentas" cols="70" rows="4"></textarea>
      </td>
	</tr>
    <tr> 
      <th bgcolor="#CCCCCC">Cr&eacute;dito:</th>
      <td>$ 
        <input name="credito" type="text" id="credito" size="15" maxlength="11" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
	</tr>	
    <tr> 
      <th bgcolor="#CCCCCC">Se le Paga a:</th>
      <td> <select name="pagoA" id="pagoA">
          <option value="0" selected>0</option>
		  <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
          <option value="13">13</option>
          <option value="14">14</option>
          <option value="15">15</option>
          <option value="16">16</option>
          <option value="17">17</option>
          <option value="18">18</option>
          <option value="19">19</option>
          <option value="20">20</option>
          <option value="21">21</option>
          <option value="22">22</option>
          <option value="23">23</option>
          <option value="24">24</option>
          <option value="25">25</option>
          <option value="26">26</option>
          <option value="27">27</option>
          <option value="28">28</option>
          <option value="29">29</option>
          <option value="30">30</option>
		  <option value="60">60</option>
		  <option value="90">90</option>
        </select> &nbsp; Días</td>
	</tr>	
    <tr> 
      <th bgcolor="#CCCCCC">Descuentos:</th>
      <td>1--&gt;
        <input name="des1" type="text" size="8" maxlength="6" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
        %  &nbsp; 
		2--&gt;
		<input name="des2" type="text" id="des2" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="8" maxlength="6">
		% &nbsp; 3--&gt;
		<input name="des3" type="text" id="des3" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" size="8" maxlength="6">
	  % &nbsp; </td>
	</tr>	
  </table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
  </p>
</form>
<p><a href="Menu_Proveedores.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>