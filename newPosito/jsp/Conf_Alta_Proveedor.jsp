<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="prov" class="com.alpha.bd.ManagerProveedores" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Proveedor Agregado</title>
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
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%	
	String rfc = "";
	String nombre = "";
	String direccion = "";
	String colonia = "";
	String delegacion = "";
	String cp = "";
	String ciudad = "";
	String tel1 = "";
	String tel2 = "";
	String fax = "";
	String pagina = "";
	String email = "";
	String vendedor = "";
	String formaPago = "";
	String cuentas = "";
	String idCredito = "";
	String credito = "0.00";
	String pagoA = "";
	String des1 = "";
	String des2 = "";
	String des3 = "";

	if(request.getParameter("rfc") != null){
		rfc = request.getParameter("rfc").trim();}
	if(request.getParameter("nombre")!= null){		
		nombre = request.getParameter("nombre").trim();}
	if(request.getParameter("direccion") != null){
		direccion = request.getParameter("direccion");}
	if(request.getParameter("colonia") != null){	
		colonia = request.getParameter("colonia");}
	if(request.getParameter("delegacion") != null){	
		delegacion = request.getParameter("delegacion");}
	if(request.getParameter("cp") != null){	
		cp = request.getParameter("cp");}
	if(request.getParameter("ciudad") != null){	
		ciudad = request.getParameter("ciudad");}
	if(request.getParameter("tel1") != null){	
		tel1 = request.getParameter("tel1").trim();}
	if(request.getParameter("tel2") != null){	
		tel2 = request.getParameter("tel2");}
	if(request.getParameter("fax") != null){	
		fax = request.getParameter("fax");}
	if(request.getParameter("pagina") != null){	
		pagina = request.getParameter("pagina");}
	if(request.getParameter("email") != null){	
		email = request.getParameter("email");}
	if(request.getParameter("vendedor") != null){	
		vendedor = request.getParameter("vendedor");}
	if(request.getParameter("formaPago") != null){	
		formaPago = request.getParameter("formaPago");}
	if(request.getParameter("cuentas") != null){	
		cuentas = request.getParameter("cuentas");}
	if(request.getParameter("idCredito") != null){	
		idCredito = request.getParameter("idCredito");}
	if(idCredito.equals("1")){
		if(request.getParameter("credito") != null){	
			credito = request.getParameter("credito");}
	}
	if(request.getParameter("pagoA") != null){	
		pagoA = request.getParameter("pagoA");}
	if(request.getParameter("des1") != null){	
		des1 = request.getParameter("des1");}
	if(request.getParameter("des2") != null){	
		des2 = request.getParameter("des2");}
	if(request.getParameter("des3") != null){
		des3 = request.getParameter("des3");}
	
	// Si llenado = 1 OK, llenado = 2 FALTO 1 CAMPO POR LLENAR;  llenado = 3 MAL FORMATO DEL DOUBLE.

	boolean resultado = false;
	boolean exis = true;
	exis = prov.existe(rfc);	
	if(exis){ %>
	<form name="retache" method="post" target="_self" action="Alta_Proveedores.jsp">
		<b class="roj">Ya tengo un proveedor dado de alta con ese RFC, no puede haber duplicidad.</b>
		<br />
		<br />
		<b class="aviso">Para cambiar los datos presione Modificar, para Salir de este proceso de Alta presione Regresar</b>
		<input type="hidden" name="interno" value="">
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="direccion" value="<%=direccion%>">
		<input type="hidden" name="colonia" value="<%=colonia%>">
		<input type="hidden" name="delegacion" value="<%=delegacion%>">
		<input type="hidden" name="cp" value="<%=cp%>">
		<input type="hidden" name="ciudad" value="<%=ciudad%>">
		<input type="hidden" name="tel1" value="<%=tel1%>">
		<input type="hidden" name="tel2" value="<%=tel2%>">
		<input type="hidden" name="fax" value="<%=fax%>">
		<input type="hidden" name="pagina" value="<%=pagina%>">
		<input type="hidden" name="email" value="<%=email%>">
		<input type="hidden" name="vendedor" value="<%=vendedor%>">
		<input type="hidden" name="formaPago" value="<%=formaPago%>">
		<input type="hidden" name="cuentas" value="<%=cuentas%>">
		<input type="hidden" name="idCredito" value="<%=idCredito%>">
		<input type="hidden" name="credito" value="<%=credito%>">
		<input type="hidden" name="pagoA" value="<%=pagoA%>">
		<input type="hidden" name="des1" value="<%=des1%>">
		<input type="hidden" name="des2" value="<%=des2%>">
		<input type="hidden" name="des3" value="<%=des3%>">		
	<p>	<input type="submit" name="Modificar" value="Modificar"></p>
	</form>

<p><a href="Menu_Proveedores.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
	<%
	}
	else{
		int llenado = 0;
	llenado = prov.valida_add(rfc, nombre, tel1);
//System.out.println("agente 1 "+agente);
	if (llenado==1){
		resultado = prov.add_Proveedor( rfc, nombre, direccion, colonia, delegacion, cp, ciudad, tel1, tel2, fax, pagina, email, vendedor, formaPago, cuentas, credito, pagoA, des1, des2, des3, idCredito);
		if(resultado){
%>
		<jsp:forward page="Menu_Proveedores.jsp" />
<% 
		}
		else{  %>
		<b class="roj">Ocurrio un Error al Guardar en la Base de Datos</b>		
<p><a href="Alta_Proveedores.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
		<% 
		} 
	} 
	else if (llenado == 2){ 
%>	
	<form name="retache" method="post" target="_self" action="Alta_Proveedores.jsp">
	<b class="roj">Falto por llenar al menos uno de los campos obligatorios (RFC, Nombre, Telefono1)</b> <br /> <br />
		<b class="aviso">Para completar los datos presione Modificar, para Salir de este proceso de Alta presione Regresar</b>
		<input type="hidden" name="interno" value="">
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="direccion" value="<%=direccion%>">
		<input type="hidden" name="colonia" value="<%=colonia%>">
		<input type="hidden" name="delegacion" value="<%=delegacion%>">
		<input type="hidden" name="cp" value="<%=cp%>">
		<input type="hidden" name="ciudad" value="<%=ciudad%>">
		<input type="hidden" name="tel1" value="<%=tel1%>">
		<input type="hidden" name="tel2" value="<%=tel2%>">
		<input type="hidden" name="fax" value="<%=fax%>">
		<input type="hidden" name="pagina" value="<%=pagina%>">
		<input type="hidden" name="email" value="<%=email%>">
		<input type="hidden" name="vendedor" value="<%=vendedor%>">
		<input type="hidden" name="formaPago" value="<%=formaPago%>">
		<input type="hidden" name="cuentas" value="<%=cuentas%>">
		<input type="hidden" name="idCredito" value="<%=idCredito%>">
		<input type="hidden" name="credito" value="<%=credito%>">
		<input type="hidden" name="pagoA" value="<%=pagoA%>">
		<input type="hidden" name="des1" value="<%=des1%>">
		<input type="hidden" name="des2" value="<%=des2%>">
		<input type="hidden" name="des3" value="<%=des3%>">		
	<p>	<input type="submit" name="Modificar" value="Modificar"></p>
	</form>
<p><a href="Menu_Proveedores.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%
	} }
%>
</body>
</html>

