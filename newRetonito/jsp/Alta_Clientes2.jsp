<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<html>
<head>
<title>Alta de Clientes</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
javascript:window.history.forward(1);

function Habilitador (f){
	var tipoPrecio = f.tipoCliente.value;
	if (tipoPrecio == 1){
		f.credito.disabled=false;				
		f.tiempoCredito.disabled=false;				
	}										
	else if(tipoPrecio == 0){
		f.credito.value="";
		f.tiempoCredito.value="1";	
		f.credito.disabled=true;				
		f.tiempoCredito.disabled=true;				
	}
}

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

//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body  onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco(); Habilitador(document.form1)" >
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 				
	String rfc = "";
	String curp = "";
	String nombre = "";
	String direccion = "";
	String colonia = "";
	String delegacion = "";
	String cp = "";
	String ciudad = "";	
	String tipoCliente = "";
	String credito = "";
	String tiempoCredito = "";
	String contacto = "";
	String telefono1 = "";
	String telefono2 = "";
	if(request.getParameter("interno") != null){
		rfc = request.getParameter("rfc");
		curp = request.getParameter("curp");
		nombre = request.getParameter("nombre");
		direccion = request.getParameter("direccion");
		colonia = request.getParameter("colonia");
		delegacion = request.getParameter("delegacion");
		cp = request.getParameter("cp");
		ciudad = request.getParameter("ciudad");	
		tipoCliente =request.getParameter("tipoCliente");
		credito = request.getParameter("credito");
		tiempoCredito = request.getParameter("tiempoCredito");
		contacto = request.getParameter("contacto");
		telefono1 = request.getParameter("telefono1");
		telefono2 = request.getParameter("telefono2");	
	}
%>	

<h1>ALTA DE CLIENTES</h1>
<form name="form1" method="post" action="Conf_Alta_Cliente2.jsp">
  <table width="550" border="1">
    <tr> 
      <th>RFC:</th>
      <td> <input name="rfc"  value="<%=rfc%>"type="text" size="15" maxlength="13"> <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th>CURP:</th>
      <td> <input name="curp" value="<%=curp%>" type="text" size="22" maxlength="20"> </td>
    </tr>
    <tr> 
      <th> Nombre del Cliente:</th>
      <td> <input name="nombre" value="<%=nombre%>" type="text" size="50" maxlength="45"> 
      <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th>Dirección:</th>
      <td> <input name="direccion" value="<%=direccion%>" type="text" size="37" maxlength="35"> <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th>Colonia:</th>
      <td> <input name="colonia" value="<%=colonia%>" type="text" size="27" maxlength="25"> <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th>Delegación:</th>
      <td><input name="delegacion" value="<%=delegacion%>" type="text" size="22" maxlength="20"> 
      <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th>Código Postal:</th>
      <td> <input name="cp" value="<%=cp%>" type="text" size="6" maxlength="5" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;" > <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th>Ciudad:</th>
      <td> <input name="ciudad" value="<%=ciudad%>" type="text" size="22" maxlength="20"> 
      <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th>Tipo de Cliente:</th>
      <td>
		<select name="tipoCliente" onChange="Habilitador(this.form)">
          <option <%if (tipoCliente.equals("") || tipoCliente.equals("0")){%> selected <% } %> value="0">Normal</option>
          <option <%if (tipoCliente.equals("1")){%> selected <% } %>value="1">Cr&eacute;dito</option>
        </select>
      </td>
	</tr>
    <tr> 
      <th>Crédito Disponible:</th>
      <td> $ <input value="<%=credito%>" name="credito" type="text" size="10" maxlength="9" onKeyPress="if (event.keyCode < 46 || event.keyCode > 57) event.returnValue = false;" disabled> <span class="style1">++</span></td>
	</tr>
    <tr> 
      <th>Tiempo de Crédito:</th>
      <td> <select name="tiempoCredito" disabled>
          <option <%if (tiempoCredito.equals("") || tiempoCredito.equals("1")){%> selected <% } %> value="1">1</option>
          <option <%if (tiempoCredito.equals("2")){%> selected <% } %> value="2">2</option>
          <option <%if (tiempoCredito.equals("3")){%> selected <% } %> value="3">3</option>
          <option <%if (tiempoCredito.equals("4")){%> selected <% } %> value="4">4</option>
          <option <%if (tiempoCredito.equals("5")){%> selected <% } %> value="5">5</option>
          <option <%if (tiempoCredito.equals("6")){%> selected <% } %> value="6">6</option>
          <option <%if (tiempoCredito.equals("7")){%> selected <% } %> value="7">7</option>
          <option <%if (tiempoCredito.equals("8")){%> selected <% } %> value="8">8</option>
          <option <%if (tiempoCredito.equals("9")){%> selected <% } %> value="9">9</option>
          <option <%if (tiempoCredito.equals("10")){%> selected <% } %> value="10">10</option>
          <option <%if (tiempoCredito.equals("11")){%> selected <% } %> value="11">11</option>
          <option <%if (tiempoCredito.equals("12")){%> selected <% } %> value="12">12</option>
          <option <%if (tiempoCredito.equals("13")){%> selected <% } %> value="13">13</option>
          <option <%if (tiempoCredito.equals("14")){%> selected <% } %> value="14">14</option>
          <option <%if (tiempoCredito.equals("15")){%> selected <% } %> value="15">15</option>
          <option <%if (tiempoCredito.equals("16")){%> selected <% } %> value="16">16</option>
          <option <%if (tiempoCredito.equals("17")){%> selected <% } %> value="17">17</option>
          <option <%if (tiempoCredito.equals("18")){%> selected <% } %> value="18">18</option>
          <option <%if (tiempoCredito.equals("19")){%> selected <% } %> value="19">19</option>
          <option <%if (tiempoCredito.equals("20")){%> selected <% } %> value="20">20</option>
          <option <%if (tiempoCredito.equals("21")){%> selected <% } %> value="21">21</option>
          <option <%if (tiempoCredito.equals("22")){%> selected <% } %> value="22">22</option>
          <option <%if (tiempoCredito.equals("23")){%> selected <% } %> value="23">23</option>
          <option <%if (tiempoCredito.equals("24")){%> selected <% } %> value="24">24</option>
          <option <%if (tiempoCredito.equals("25")){%> selected <% } %> value="25">25</option>
          <option <%if (tiempoCredito.equals("26")){%> selected <% } %> value="26">26</option>
          <option <%if (tiempoCredito.equals("27")){%> selected <% } %> value="27">27</option>
          <option <%if (tiempoCredito.equals("28")){%> selected <% } %> value="28">28</option>
          <option <%if (tiempoCredito.equals("29")){%> selected <% } %> value="29">29</option>
          <option <%if (tiempoCredito.equals("30")){%> selected <% } %> value="30">30</option>
        </select> &nbsp; Días <span class="style1">++</span></td>
	</tr>	
	<tr>
		<th>Cont&aacute;cto:</th>
		<td><input type="text" value="<%=contacto%>" name="contacto" size="45" maxlength="40"></td>
	</tr>
	<tr>
		<th>Tel&eacute;fono 1:</th>
		<td><input type="text" value="<%=telefono1%>" name="telefono1" size="15" maxlength="12"></td>
	</tr>
	<tr>
		<th>Tel&eacute;fono 2:</th>
		<td><input type="text" value="<%=telefono2%>" name="telefono2" size="15" maxlength="12"></td>
	</tr>
  </table>
	<span class="style1">**</span> Campos Obligatorios.  <br />
	<span class="style1">++</span> Campos Obligatorios solo con Cr&eacute;dito.  	
  <p>
    <input type="reset" name="Submit2" value="Limpiar Forma">
	<input type="submit" name="Submit" value="Guardar">	
  </p>
</form>
<p><a href="Menu_Clientes.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>