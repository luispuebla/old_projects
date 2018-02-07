<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />

<html>
<head>
<title>Mermas de Producto</title>
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

function seleccionaTodo(objeto){
	objeto.select();
}


function setFocus(){
	if(document.form1 != null){
		document.form1.invTienda.focus();
	}
}

function OnSubmitForm(){
	var docAval = new String();
	docAval = form1.causa.value;
	re = / /gi;
	docAval = docAval.replace(re,"");
	if(docAval == ''){
		alert("Debes especificar una Causa para esta Merma");
		form1.causa.focus();
		return false;
	}
	else{
		document.form1.action ="Conf_Mermas_Producto.jsp";		
		return true;
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

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg');setFocus()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	if(request.getParameter("ID_Pro") == null || request.getParameter("ID_Pro").trim().equals("")){
%>		
			<b class="roj">NO SELECCIONO EL PRODUCTO.</b>
			<form name="regreso" action="Selecciona_Producto_Mermas.jsp" method="post" target="_self">
				<input type="submit" name="Volver" value="Volver">
			</form>
<%	
	}
	else{
		String elProducto = request.getParameter("ID_Pro").trim();
		boolean existeProducto = inv.existe(elProducto);
		if(!existeProducto){ %>
			<b class="roj">EL PRODUCTO NO EXISTE.</b>
			<form name="regreso" action="Selecciona_Producto_Mermas.jsp" method="post" target="_self">
				<input type="submit" name="Volver" value="Volver">
			</form>		
<%		}
		else{ 
%>	
<h1>MERMAS DE PRODUCTO </h1>
<form name="form1" method="post" onSubmit="return OnSubmitForm();">
  <input type="hidden" name="elProducto" value="<%= elProducto%>">
<table align="center" border="1" width="760" cellpadding="0" cellspacing="0">
<caption>Escribe la cantidad del Producto Mermada y la Causa: </caption>
<%
	ResultSet productos = inv.dameExistenciaProducto(elProducto);
	while (productos.next()){
		String invTienda = productos.getInt("invTienda")+"";
		String invAlmacen = productos.getInt("invAlmacen")+"";
		String tipoP = "Uni.";		
		if(productos.getInt("tipoPro") == 1){
			tipoP = "Kg.";
			invTienda = productos.getDouble("invTienda")+"";
			invAlmacen = productos.getDouble("invAlmacen")+"";
		}
%>
	<tr>
		<th colspan="4"><div align="center"><%=elProducto+" --> "+productos.getString("descripcion")%></div></th>
	</tr>
	<tr>
		<th colspan="2"><div align="center">Cantidad Actual<br/> de Producto: </div></th>
		<th>Merma en Almac&eacute;n</th>
		<th>Merma en Tienda</th>
	</tr> 
	<tr>
		<th width="115">Almac&eacute;n:<br/><%=invAlmacen%> <%=tipoP%></th>
		<th width="118">Tienda:<br/><%=invTienda%> <%=tipoP%></th>
		<td width="229">
          <div align="center">
            <input type="text" size="7" maxlength="7" name="invAlmacen" value="0" onFocus="seleccionaTodo(this)" onKeypress="
	<% if(tipoP.equals("Kg.")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" > <%=tipoP%></div></td>
		<td width="288">
          <div align="center">
            <input type="text" size="7" maxlength="7" name="invTienda" value="0" onFocus="seleccionaTodo(this)" onKeypress="
	<% if(tipoP.equals("Kg.")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" > <%=tipoP%></div></td></tr>
<%
}
	if(productos != null){
		productos.close();
	}
	inv.cierraConexion();				
%>	
	<tr valign="middle">
		<th colspan="2"><div align="center"><br/>Causa:<br/></div></th>
		<td colspan="2"><div align="center"><input type="text" maxlength="75"name="causa" size="85"><br/></div></td>
	</tr>
</table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
  </p>
</form>
<% 		}
	}%>
<p><a href="Selecciona_Producto_Mermas.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>