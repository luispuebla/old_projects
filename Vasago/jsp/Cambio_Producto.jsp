<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" scope="page" />
<jsp:useBean id="li" class="com.vas.bd.ManagerLineas" scope="page" />
<jsp:useBean id="ma" class="com.vas.bd.ManagerMarcas" scope="page" />
<jsp:useBean id="pro" class="com.vas.bd.ManagerProductos" scope="page" />
<jsp:useBean id="prov" class="com.vas.bd.ManagerProveedores" scope="page" />

<html>
<head>
<title>Cambio de Productos</title>
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

function roundOff(value)
{
        value = "" + value //convert value to string
        var precision = 2;

        var whole = "" + Math.round(value * Math.pow(10, precision));

        var decPoint = whole.length - precision;

        if(decPoint != 0)
        {
                result = whole.substring(0, decPoint);
                result += ".";
                result += whole.substring(decPoint, whole.length);
        }
        else
        {
                result = 0;
                result += ".";
                result += whole.substring(decPoint, whole.length);
        }
        return result;
}

function precios() { 

	var co = new Number();
	var p1 = new Number();
	var p2 = new Number();
	co = document.form1.costo.value;
	p1 = parseFloat(co)*1.05;
	//alert(p1);
	p2 = parseFloat(co)*1.30;
	//alert(p2);
	if (isNaN(p1))
		p1 = 0;
	if (isNaN(p2))
		p2 = 0;
	
	p1 = roundOff(p1);
	p2 = roundOff(p2);
			
document.form1.p1.value = p1; 
document.form1.p2.value = p2; 
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

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg');habilitaPC()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
String clave = request.getParameter("clave");
ResultSet producto = pro.datos_Producto(clave);
%>	
<h1>CAMBIO DE PRODUCTO </h1>
<p align="center">Cambia los campos de la forma para realizar el Cambio del Producto:</p>
<form name="form1" method="post" action="Conf_Cambio_Producto.jsp">
  <input type="hidden" name="clave" value="<%= clave%>">
  <table width="797" border="1">
  <%
  while(producto.next()){
  %>
    <tr> 
      <th height="27" bgcolor="#CCCCCC"> Línea:</th>
      <td> 
<%
String linea = producto.getString("linea");
//System.out.println("linea: "+linea);
String nlinea = li.nombreLinea(linea);
//System.out.println("nombre: "+nlinea);
String marca = producto.getString("marca");
String nmarca = ma.nombreMarca(marca);
String prov1 = producto.getString("proveedor1");
String nprov1 = prov.nombreProveedor(prov1);
String prov2 = producto.getString("proveedor2");
String prov3 = producto.getString("proveedor3");
String prov4 = producto.getString("proveedor4");
String prov5 = producto.getString("proveedor5");
String tipo = producto.getString("tipo");
//System.out.println("RFC: "+prov2);
//System.out.println("Nombre: "+nprov2);
%>
      <input name="linea" type="text" size="20" maxlength="20" readonly="true" value="<%=nlinea%>">
      </td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Marca:</th>
      <td>       <input name="marca" type="text" size="40" maxlength="40" readonly="true" value="<%=nmarca%>">
      </td>
</td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Tipo:</th>
      <td> <select name="tipo" onChange="habilitaPC()">
		  <option value="1" <%if (tipo.equals("1")){%>selected<%}%></option>Caja</option>
		  <option value="2" <%if (tipo.equals("2")){%>selected<%}%>>Peso</option>		  
      </select> <span class="style1">**</span> </td>
    </tr>	
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 1:</th>
      <td> <select name="proveedor1">
	  <option selected value="<%= prov1%>"><%= nprov1%></option>
<%
ResultSet proveedores = prov.dameProveedores();
while(proveedores.next()){
	if(prov1.equalsIgnoreCase(proveedores.getString("rfc"))){
	}
	else{
%>
		<option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%
	}
}
proveedores.beforeFirst();
%>
      </select>   <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 2:</th>
      <td><select name="proveedor2">
<%
boolean haySeleccion = false;
while(proveedores.next()){
	if(proveedores.getString("rfc").equalsIgnoreCase(prov2)){
		haySeleccion = true;
%>
		<option selected value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>		
<%
	}
	else{
%>
			<option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%		
	}
}
proveedores.beforeFirst();
%>
	<option <%if (!haySeleccion){%> selected <%}%> value="0">Ninguno</option>
      </select></td>
    </tr>
	
    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 3:</th>
      <td><select name="proveedor3">
<%
haySeleccion = false;
while(proveedores.next()){
	if(proveedores.getString("rfc").equalsIgnoreCase(prov3)){
		haySeleccion = true;
%>
		<option selected value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>		
<%
	}
	else{
%>
		<option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%		
	}
}
%>
	<option <%if (!haySeleccion){%> selected <%}%> value="0">Ninguno</option>
      </select></td>
    </tr>


    <tr> 
      <th bgcolor="#CCCCCC">Proveedor 4:</th>
      <td><select name="proveedor4">
<%
proveedores.beforeFirst();
haySeleccion = false;
while(proveedores.next()){
	if(proveedores.getString("rfc").equalsIgnoreCase(prov4)){
		haySeleccion = true;
%>
		<option selected value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>		
<%
	}
	else{
%>
			<option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%		
	}
}
%>
	<option <%if (!haySeleccion){%> selected <%}%> value="0">Ninguno</option>
      </select></td>
    </tr>


       <tr> 
      <th bgcolor="#CCCCCC">Proveedor 5:</th>
      <td><select name="proveedor5">
<%
proveedores.beforeFirst();
haySeleccion = false;
while(proveedores.next()){
	if(proveedores.getString("rfc").equalsIgnoreCase(prov5)){
		haySeleccion = true;
%>
		<option selected value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>		
<%
	}
	else{
%>
			<option value="<%= proveedores.getString("rfc")%>"><%= proveedores.getString("nombre")%></option>
<%		
	}
}
if(proveedores != null){
	proveedores.close();
}
prov.cierraConexion();
%>
	<option <%if (!haySeleccion){%> selected <%}%> value="0">Ninguno</option>
      </select></td>
    </tr>

	
    <tr> 
      <th bgcolor="#CCCCCC">Descripci&oacute;n:</th>
      <td> <input name="descripcion" type="text" id="descripcion" size="100" maxlength="100" value="<%=producto.getString("descripcion")%>"> <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Piezas por Caja:</th>
    <td> <input name="pxc" type="text" id="p2" size="12" maxlength="10" value="<%=producto.getString("piezasXcaja")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> 
    piezas </td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Costo:</th>
      <td>$ <input name="costo" type="text" size="12" maxlength="10" value="<%=producto.getString("costo")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">  <span class="style1">**</span></td>
    </tr>
    <tr> 
      <th bgcolor="#CCCCCC">Precio 1:</th>
      <td>$ <input name="p1" type="text" id="p1" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=producto.getString("precio1")%>"> <span class="style1">**</span>
      </td>
	</tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 2:</th>
    <td>$ <input name="p2" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=producto.getString("precio2")%>"> <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 3:</th>
    <td>$ <input name="p3" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=producto.getString("precio3")%>"> <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 4:</th>
    <td>$ <input name="p4" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=producto.getString("precio4")%>"> <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">Precio 5:</th>
    <td>$ <input name="p5" type="text" id="p2" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=producto.getString("precio5")%>"> <span class="style1">**</span></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">M&aacute;ximo:</th>
    <td> <input name="max" type="text" id="max" size="7" maxlength="7" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=producto.getString("maximo")%>"></td>
    </tr>
    <tr> 
    <th bgcolor="#CCCCCC">M&iacute;nimo:</th>
    <td> <input name="min" type="text" id="min" size="7" maxlength="7" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" value="<%=producto.getString("minimo")%>"></td>
    </tr>	
	<%
	}
	if(producto != null){
		producto.close();
	}
	pro.cierraConexion();
	%>
  </table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
    <input type="reset" name="Submit2" value="Limpiar Forma">
  </p>
</form>
<p><a href="Existe_Producto_Cambio.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>