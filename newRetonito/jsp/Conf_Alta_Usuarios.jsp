<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="usuario" class="com.alpha.bd.ManagerVendedores" />

<html>
<head>
<title>Vendedor Agregado</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String nombre = request.getParameter("nombre");
	String permiso = request.getParameter("permiso");
	String salario = request.getParameter("salario");	
	String claveP = "";
	String direccion = request.getParameter("direccion").trim();	
	String telCasa = request.getParameter("telCasa").trim();	
	String telCel = request.getParameter("telCel").trim();	
	String observacion = request.getParameter("observacion").trim();	
	boolean errorTamanio = false;
	boolean errorContra = false;
	if(permiso.equals("1")){
		claveP = request.getParameter("contraPCD");
		if(claveP.trim().length() == 0){
			errorTamanio = true;
		}
		if(! claveP.equals(request.getParameter("contraPCD2"))){
			errorContra = true;
		}		
	}
	String clave = new String("");
	int existePrevio = 0;
	if(nombre.length() <= 0){
%>	
	<b class="roj">Debes ingresar un Nombre.</b>
	<form name="retache" target="_self" action="Alta_Usuarios.jsp" method="post">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="permiso" value="<%=permiso%>">
		<input type="hidden" name="salario" value="<%=salario%>">
		<input type="hidden" name="direccion" value="<%=direccion%>">
		<input type="hidden" name="telCasa" value="<%=telCasa%>">
		<input type="hidden" name="telCel" value="<%=telCel%>">
		<input type="hidden" name="observacion" value="<%=observacion%>">
		<input type="hidden" name="interino" value="">								
	<p><input type="submit" name="Volver" value="Volver"></p>
	</form>
<%	
	}
	else if(permiso.equals("1") && (errorTamanio || errorContra)){
%>	
	<b class="roj">
	<% if(errorTamanio){%>La contraseña debe tener por lo menos 1 caracter. <br /><%}%>
	<% if(errorContra){%>La confirmacion de la contraseña no concuerda con la contraseña <%}%>	
	</b>
	<form name="retache" target="_self" action="Alta_Usuarios.jsp" method="post">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="permiso" value="<%=permiso%>">
		<input type="hidden" name="salario" value="<%=salario%>">
		<input type="hidden" name="direccion" value="<%=direccion%>">
		<input type="hidden" name="telCasa" value="<%=telCasa%>">
		<input type="hidden" name="telCel" value="<%=telCel%>">
		<input type="hidden" name="observacion" value="<%=observacion%>">		
		<input type="hidden" name="interino" value="">									
	<p><input type="submit" name="Volver" value="Volver"></p>
	</form>
<%		
	}
	else if(usuario.cambiaADouble(salario) == 0){
%>
	<b class="roj">El Salario especificado para el Vendedor debe ser mayor a 0.</b>
	<form name="retache" target="_self" action="Alta_Usuarios.jsp" method="post">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="permiso" value="<%=permiso%>">
		<input type="hidden" name="salario" value="0.00">
		<input type="hidden" name="direccion" value="<%=direccion%>">
		<input type="hidden" name="telCasa" value="<%=telCasa%>">
		<input type="hidden" name="telCel" value="<%=telCel%>">
		<input type="hidden" name="observacion" value="<%=observacion%>">		
		<input type="hidden" name="interino" value="">									
	<p><input type="submit" name="Volver" value="Volver"></p>
	</form>
<%	
	}
	else{
		int exito = usuario.add_Vendedor(nombre, permiso, claveP, salario, direccion, telCasa, telCel, observacion);
		if(exito != -1){
%>
		<h1>Se guardó el registro exitosamente</h1>
<table width="457" border="1" align="center">
  <tr> 
    <th width="185">Nombre del Vendedor:</th>
    <td width="256"> <div align="center"><%=nombre%> </div></td>
  </tr>
  <tr> 
    <th>Clave Asignada al Vendedor:</th>
    <td> <div align="center"><%= exito %> </div></td>
  </tr>  
</table>
<%			
	}
		else{
%>
			<b class="roj">Existio un problema con la Base de Datos, no se pudo almacenar el vendedor.</b>
<%} }%>
<p><a href="Menu_Vendedores.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="AVendedores" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>

