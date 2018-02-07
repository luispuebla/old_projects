<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<html>
<head>
<title>Alta de Vendedores</title>
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

function Habilita (f){
	var tipoPrecio = f.permiso.value;
	if(tipoPrecio == 0){
		f.contraPCD.disabled = true;
		f.contraPCD2.disabled = true;
	}
	else{
		f.contraPCD.value = "";
		f.contraPCD2.value = "";	
		f.contraPCD.disabled = false;
		f.contraPCD2.disabled = false;
	}
}

function OnSubmitForm(){
	if(checaVacio(form1.nombre.value)){
		alert("Debes escribir el Nombre del Vendedor");
		form1.nombre.focus();
		return false;		
	}
	if(form1.permiso.value == 1){
		if(checaVacio(form1.contraPCD.value)){
			alert("Te falta escribir la contraseña para cobro directo");
			form1.contraPCD.focus();
			return false;		
		}
		else if (checaVacio(form1.contraPCD2.value)){
			alert("Te falta escribir la confirmación de la contraseña para cobro directo");
			form1.contraPCD2.focus();
			return false;		
		}
	}
	if(checaVacio(form1.salario.value)){
		alert("Te falta llenar el campo de Salario del Vendedor");
		form1.salario.focus();
		return false;		
	}
	else if (isNaN(parseInt(form1.salario.value))){
		alert("El Salario debe ser mayor un número");
		form1.salario.focus();
		return false;		
	}
	document.form1.action ="Conf_Alta_Usuarios.jsp";		
	return true;	
}

function checaVacio(valor){
	var elValor = new String();
	elValor = valor;
	re = / /gi;
	elValor = elValor.replace(re,"");
	if(elValor == ''){
		return true;
	}
	return false;
}


function funcionFoco(){
	document.form1.nombre.focus();
}

//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String nombre = "";
	String permiso = "0";
	String salario = "";
	String direccion = "";
	String telCasa = "";
	String telCel = "";
	String observacion = "";
	if(request.getParameter("interino") != null){
		nombre = request.getParameter("nombre");
		permiso = request.getParameter("permiso");
		salario = request.getParameter("salario");
		direccion = request.getParameter("direccion");
		telCasa = request.getParameter("telCasa");
		telCel = request.getParameter("telCel");
		observacion = request.getParameter("observacion");
	}
%>	
<body  onLoad="funcionFoco(), MM_preloadImages('imagenes/Regresar2.jpg'), Habilita(document.form1)" >
<h1>ALTA DE VENDEDOR</h1>
<p>Por favor introduce el Nombre Completo as&iacute; como los atributos de venta para dar de Alta al Vendedor</p>
<form name="form1" method="post" onSubmit="return OnSubmitForm();">
  <table width="750" border="1">
    <tr> 
      <th width="184">Nombre del Vendedor:<br> <font size="2">(A.Paterno A.Materno Nombre(s))</font></th>
      <td width="550"> <div align="center"> <input name="nombre" type="text" size="60" maxlength="50" value="<%=nombre%>"> <span class="style1">**</span>
      </div></td>
    </tr>	
	<tr>
	  <th>Permiso Cobro Directo:</th>
	  <td><div align="center">
	    <select name="permiso" onChange="Habilita(this.form)">
	        <option value="0" <% if (permiso.equals("0")){%> selected <%}%>>No</option>
	        <option value="1" <% if (permiso.equals("1")){ %> selected <%}%>>Si</option>
	      </select>
	    </div></td>
	</tr>
	<tr>
	  <th>Contraseña Permiso:</th>
	  <td><div align="center">
	  <input name="contraPCD" type="password" size="6" maxlength="4" align="right" disabled  onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"> <span class="style1">++</span>  
	    <br /> 
	    <font size="1">* Númerico</font></div></td>
	</tr>	
	<tr>
	  <th>Confirma Contraseña Permiso:</th>
	  <td><div align="center">
	  <input name="contraPCD2" type="password" size="6" maxlength="4" align="right"  disabled onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"> <span class="style1">++</span>
	    <br /> 
	    <font size="1">* Númerico</font></div></td>
	</tr>	
	<tr>
	  <th>Salario Semanal:</th>
	  <td><div align="center">$ <input name="salario" type="text" size="10" maxlength="8" align="right" value="<%=salario%>"  onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;"><span class="style1">**</span></div></td>
	</tr>	
	<th colspan="2">DATOS PERSONALES</th>
	<tr>
	  <th>Direcci&oacute;n:</th>
	  <td><div align="center"><input name="direccion" type="text" size="85" maxlength="80" align="right" value="<%=direccion%>"></div></td>
	</tr>	
	<tr>
	  <th>Tel&eacute;fono Casa:</th>
	  <td><div align="center"><input name="telCasa" type="text" size="18" maxlength="15" align="right" value="<%=telCasa%>"></div></td>
	</tr>	
	<tr>
	  <th>Tel&eacute;fono Celular:</th>
	  <td><div align="center"><input name="telCel" type="text" size="18" maxlength="15" align="right" value="<%=telCel%>" ></div></td>
	</tr>	
	<tr>
	  <th>Observaciones:</th>
	  <td><div align="center"><input name="observacion" type="text" size="85" maxlength="80" align="right" value="<%=observacion%>"></div></td>
	</tr>	
	
  </table>
  <span class="style1">**</span> Campos Obligatorios.  <br />  
  <span class="style1">++</span> Campos Obligatorios solo con Permiso de Cobro Directo.  	
  <p>
	<input type="reset" name="Submit2" value="Limpiar Forma">
	<input type="submit" name="Submit" value="Guardar">
  </p>
</form>
<p><a href="Menu_Vendedores.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>