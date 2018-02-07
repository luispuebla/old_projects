<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" />

<html>
<head>
<title>Cliente Agregado</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
javascript:window.history.forward(1);

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
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 				
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = "";
	String curp = "";
	String nombre = "";
	String direccion = "";
	String colonia = "";
	String delegacion = "";
	String cp = "";
	String ciudad = "";	
	String tipoCliente = "";
	String credito = "0";
	String tiempoCredito = "0";
	String contacto = "";
	String telefono1 = "";
	String telefono2 = "";
	rfc = request.getParameter("rfc").trim();
	curp = request.getParameter("curp");
	nombre = request.getParameter("nombre").trim();
	direccion = request.getParameter("direccion");
	colonia = request.getParameter("colonia");
	delegacion = request.getParameter("delegacion");
	cp = request.getParameter("cp");
	ciudad = request.getParameter("ciudad");
	tipoCliente = request.getParameter("tipoCliente");
	contacto = request.getParameter("contacto");
	telefono1 = request.getParameter("telefono1");
	telefono2 = request.getParameter("telefono2");
	if(tipoCliente.equalsIgnoreCase("1")){
		credito = request.getParameter("credito");
		tiempoCredito = request.getParameter("tiempoCredito");
	}
	// Si llenado = 1 OK, llenado = 2 FALTO 1 CAMPO POR LLENAR;  llenado = 3 MAL FORMATO DEL DOUBLE.
	int llenado = 0;
	//existe = cliente.existe(rfc);
	// si es cliente normal checo campos sencillos:
	if(tipoCliente.equalsIgnoreCase("0")){
		llenado = cliente.valida_add1(rfc, nombre, direccion, colonia, delegacion, ciudad, cp);
	}
	else{
		llenado = cliente.valida_add2(rfc, nombre, direccion, colonia, delegacion, ciudad, cp, credito);
	}
	if (llenado==1){
		cliente.add_Cliente(rfc, curp, nombre, direccion, colonia, delegacion, cp, tipoCliente, credito, tiempoCredito, contacto, telefono1, telefono2, ciudad);
		if(contacto.trim().equals("")){
			contacto = "&nbsp;";
		}
		if(telefono1.trim().equals("")){
			telefono1 = "&nbsp;";
		}	
		if(telefono2.trim().equals("")){
			telefono2 = "&nbsp;";
		}	
		if(curp.trim().equals("")){
			curp = "&nbsp;";
		}			
%>
<h1>Se guardó el registro exitosamente</h1>
<table width="550" border="1" align="center">
  <tr> 
    <th width="156">RFC:</th>
    <td width="378"> <%=rfc%> </td>
  </tr>
  <tr> 
    <th>CURP:</th>
    <td> <%=curp%> </td>
  </tr>
  <tr> 
    <th>Nombre del Cliente:</th>
    <td> <%=nombre%></td>
  </tr>
  <tr> 
    <th>Dirección:</th>
    <td><%=direccion%></td>
  </tr>
    <tr> 
    <th>Colonia:</th>
    <td> <%=colonia%> </td>
  </tr>
   <tr> 
    <th>Delegación:</th>
    <td> <%=delegacion%> </td>
  </tr>
   <tr> 
    <th>Código Postal:</th>
    <td> <%=cp%> </td>
  </tr>
   <tr> 
    <th>Ciudad:</th>
    <td> <%=ciudad%> </td>
  </tr>  
   <tr> 
    <th>Cont&aacute;cto:</th>
    <td> <%=contacto%> </td>
  </tr>
   <tr> 
    <th>Tel&eacute;fono 1:</th>
    <td><%=telefono1%> </td>
  </tr>
   <tr> 
    <th>Tel&eacute;fono 2:</th>
    <td><%=telefono2%> </td>
  </tr>
   <tr> 
    <th>Tipo de Cliente:</th>
    <td>
<%
		if(tipoCliente.equalsIgnoreCase("0")){			
%>
		Normal
     </td>
  </tr>  
<%			
		}
		else{
%>
			Con cr&eacute;dito
      </td>
  </tr>
   <tr> 
    <th>Cr&eacute;dito Disponible:</th>
    <td> <%=credito%></td>
  </tr>
   <tr> 
    <th>Tiempo de Cr&eacute;dito:</th>
    <td> <%=tiempoCredito%> </td>
  </tr>    
<%
		}
%>			
</table>

<p>&nbsp;</p>
<a href="Menu_Clientes.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
<% 
	} 
	else if (llenado == 2){
%>	
	<form name="form2" method="post" target="_self" action="Alta_Clientes2.jsp">
	<b class="roj">Falta por completar al menos uno de los datos obligatorios.</b><br />
	<b class="aviso">Para modificar los datos escritos previamente da click en el boton Modificar,<br /> para salir del Proceso de Alta de Cliente da Click en Regresar.</b>
		<input type="hidden" name="interno" value="">
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<input type="hidden" name="curp" value="<%=curp%>">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="direccion" value="<%=direccion%>">
		<input type="hidden" name="colonia" value="<%=colonia%>">
		<input type="hidden" name="delegacion" value="<%=delegacion%>">
		<input type="hidden" name="cp" value="<%=cp%>">
		<input type="hidden" name="ciudad" value="<%=ciudad%>">
		<input type="hidden" name="tipoCliente" value="<%=tipoCliente%>">
		<input type="hidden" name="credito" value="<%=credito%>">
		<input type="hidden" name="tiempoCredito" value="<%=tiempoCredito%>">
		<input type="hidden" name="contacto" value="<%=contacto%>">
		<input type="hidden" name="telefono1" value="<%=telefono1%>">
		<input type="hidden" name="telefono2" value="<%=telefono2%>">
	<p><input type="submit" name="Modificar" value="Modificar"></p>	
	</form>

<p>&nbsp;</p>
<p><a href="Menu_Clientes.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%
	} 
	else if (llenado == 3){
%>		
	<form name="form3" method="post" target="_self" action="Alta_Clientes2.jsp">
	<b class="roj">Posee un formato incorrecto el campo de cr&eacute;dito, no puedes usar letras, solo n&uacute;meros</b><br />
	<b class="aviso">Para modificar el campo cr&eacute;dito da click en el boton Modificar,<br /> para salir del Proceso de Alta de Cliente da Click en Regresar.</b>
		<input type="hidden" name="interno" value="">	
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<input type="hidden" name="curp" value="<%=curp%>">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="direccion" value="<%=direccion%>">
		<input type="hidden" name="colonia" value="<%=colonia%>">
		<input type="hidden" name="delegacion" value="<%=delegacion%>">
		<input type="hidden" name="cp" value="<%=cp%>">
		<input type="hidden" name="ciudad" value="<%=ciudad%>">
		<input type="hidden" name="tipoCliente" value="<%=tipoCliente%>">
		<input type="hidden" name="credito" value="<%=credito%>">
		<input type="hidden" name="tiempoCredito" value="<%=tiempoCredito%>">
		<input type="hidden" name="contacto" value="<%=contacto%>">
		<input type="hidden" name="telefono1" value="<%=telefono1%>">
		<input type="hidden" name="telefono2" value="<%=telefono2%>">
	<p><input type="submit" name="Modificar" value="Modificar"></p>	
	</form>	
<p><a href="Alta_Clientes2.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%
	}
%>
</body>
</html>

