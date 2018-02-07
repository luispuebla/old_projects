<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" scope="page" />
<jsp:useBean id="li" class="com.vas.bd.ManagerLineas" scope="page" />
<jsp:useBean id="ma" class="com.vas.bd.ManagerMarcas" scope="page" />
<jsp:useBean id="pro" class="com.vas.bd.ManagerProveedores" scope="page" />

<html>
<head>
<title>Alta de Productos</title>
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
 
function habilitaPC(){
	var contenido = document.form1.tipo.value;
	if(contenido == '1'){
		form1.pxc.disabled = false;
	}
	else{
		form1.pxc.value = "";
		form1.pxc.disabled = true;
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

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<h1>ALTA DE PRODUCTOS </h1>
<p align="center">Llena todos los campos de la forma para  dar de alta un Producto:</p>
<form name="form1" method="post" action="Conf_Alta_Producto.jsp">
  <table width="797" border="1">
	<tr> 
	  <th width="127" bgcolor="#CCCCCC"><div align="center">Línea:</div></th>
	  <td width="654"><font color="#000066"> <select name="linea"> 
		<%
		ResultSet rs2 = li.dameLineas();
		while(rs2.next()){
		%>
				<option value="<%=rs2.getString("clave")%>"><%=rs2.getString("nombre")%></option>
		<%}
			if(rs2 != null){
				rs2.close();
			}
			li.cierraConexion();
		%>		
		</select>
	  <span class="style1">**</span> </font></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Marca:</th>
      <td> <select name="marca">
<%
ResultSet marcas = ma.dameMarcas();
while(marcas.next()){
%>
		  <option value="<%= marcas.getString("clave")%>"><%= marcas.getString("nombre")%></option>
<%
}
	if(marcas != null){
		marcas.close();
	}
	ma.cierraConexion();
%>
      </select> <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Tipo:</th>
      <td> <select name="tipo" onChange="habilitaPC()">
		  <option value="1">Caja</option>
		  <option value="2">Peso</option>		  
      </select> <span class="style1">**</span> </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 1:</th>
      <td> <select name="proveedor1">
<%
ResultSet proveedores = pro.dameProveedores();
while(proveedores.next()){
%>
		  <option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%
}
proveedores.beforeFirst();
%>
      </select>   <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 2:</th>
      <td><select name="proveedor2">
 	<option selected value="0">Seleccione ...</option>
<%
while(proveedores.next()){
%>
		  <option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%
}
proveedores.beforeFirst();
%>
      </select></td>
    </tr>
	
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 3:</th>
      <td><select name="proveedor3">
 	<option selected value="0">Seleccione ...</option>
<%
while(proveedores.next()){
%>
		  <option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%
}
proveedores.beforeFirst();
%>
      </select></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 4:</th>
      <td><select name="proveedor4">
 	<option selected value="0">Seleccione ...</option>
<%
while(proveedores.next()){
%>
		  <option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%
}
proveedores.beforeFirst();
%>
      </select></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 5:</th>
      <td><select name="proveedor5">
 	<option selected value="0">Seleccione ...</option>
<%
while(proveedores.next()){
%>
		  <option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%
}
if(proveedores != null){
	proveedores.close();
}
pro.cierraConexion();
%>
      </select></td>
    </tr>
	
	
    <tr> 
      <th bgcolor="#CCCCCC">Descripci&oacute;n:</th>
      <td> <input name="descripcion" type="text" id="descripcion" size="100" maxlength="100">   <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Piezas por Caja:</th>
      <td> <input name="pxc" type="text" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> piezas / kg.   <span class="style1">** Si tipo --> Caja. **</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Costo:</th>
      <td> <input name="costo" type="text" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">   <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Precio 1:</th>
      <td><input name="p1" type="text" id="p1" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
      <span class="style1">** </span>      </td>
	</tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 2:</th>
    <td> <input name="p2" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
      <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 3:</th>
    <td> <input name="p3" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
      <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 4:</th>
    <td> <input name="p4" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
      <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 5:</th>
    <td> <input name="p5" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
      <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">M&aacute;ximo:</th>
    <td> <input name="max" type="text" id="max" size="7" maxlength="7" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">M&iacute;nimo:</th>
    <td> <input name="min" type="text" id="min" size="7" maxlength="7" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Existencia:</th>
    <td> <input name="existencia" type="text" id="existencia" size="6" maxlength="6" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> <span class="style1">**</span></td>
    </tr>	
  </table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
  </p>
</form>
<p><a href="Menu_Productos2.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>