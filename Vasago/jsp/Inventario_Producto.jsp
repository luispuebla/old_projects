<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" scope="page" />
<jsp:useBean id="inv" class="com.vas.bd.ManagerInventarios" scope="page" />

<html>
<head>
<title>Inventario de Productos</title>
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

function setFocus(){
	document.form1.existencia.select();
}

function seleccionaTodo(objeto){
	objeto.select();
}


//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); setFocus()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
String tipo = "Cajas";
String clave = request.getParameter("clave");
ResultSet producto = inv.Inventario_Producto(clave);
%>	
<h1>INVENTARIO DE PRODUCTO </h1>
<form name="form1" method="post" action="Conf_Inventario_Producto.jsp">
  <input type="hidden" name="clave" value="<%= clave%>">
<table align="center" border="1" width="446">
<%
while(producto.next()){
	if(producto.getInt("Tipo") == 2){
		tipo = "Kg.";
	}
%>
	<tr>
		<th colspan="3"><div align="center"><%=clave+" --> "+producto.getString("descripcion")%></div></th>
	</tr>
	<tr>
		<th width="237"><div align="left">Existencia Inventario</div></th>
		<td width="93"><div align="center"><%=producto.getString("existencia")%> <%=tipo%></div><input type="hidden" name="existenciaOri" value="<%=producto.getString("existencia")%>"></td>
		<td width="94"><div align="center"><input type="text" size="7" maxlength="7" name="existencia" onFocus="seleccionaTodo(this)" value="<%=producto.getString("existencia")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}"></div></td>
	</tr>
<%
}
	if(producto != null){
		producto.close();
	}
	inv.cierraConexion();	
ResultSet regalo = inv.Inventario_Producto_Regalo(clave);
while(regalo.next()){
%>
	<tr>
		<th><div align="left">Existencia Inventario Regalos</div></th>
		<td><div align="center"><%=regalo.getString("existencia")%> <%=tipo%></div></td>
		<input type="hidden" name="existenciaOriR" value="<%=regalo.getString("existencia")%>">
		<td><div align="center"><input type="text" size="7" maxlength="7" name="regalos" onFocus="seleccionaTodo(this)" value="<%=regalo.getString("existencia")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}"></div></td>
</tr>
<%
}
	if(regalo != null){
		regalo.close();
	}
	inv.cierraConexion();	
%>
</table>
  <p>
    <input type="submit" name="Submit" value="Guardar">
  </p>
</form>
<p><a href="Existe_Producto_Inventario.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>