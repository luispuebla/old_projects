<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Lista de Precios</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<style type="text/css">
<!--
.style2 {color: #990033}
.style4 {
	color: #000099;
	font-style: italic;
}
.style5 {
	font-size: medium;
	font-weight: bold;
}
.style6 {color: #000099}
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
 <table width="707" border="1" align="center">
  <caption>LISTA DE PRECIOS</caption>
  <tr> 
     <th width="98" bgcolor="#DFE1EC">Clave</th>
    <th width="492" bgcolor="#DFE1EC">Producto</th>
    <th width="98" bgcolor="#DFE1EC">Precio 1</th>
	<th width="98" bgcolor="#DFE1EC">Precio 2</th>
	<th width="98" bgcolor="#DFE1EC">Precio 3</th>
	<th width="98" bgcolor="#DFE1EC">Precio 4</th>
	<th width="98" bgcolor="#DFE1EC">Precio 5</th>
   </tr>
</table>
<p></p>
<table width="710" border="1" align="center">
<%
	ResultSet rs = pro.Lista_Precios();
	String linea = new String();
	String linea2 = ""; 
	String marca = new String();
	String marca2 = "";
	int bandera = 0;

	while(rs.next()){
		linea = rs.getString("Nombre_Linea");
		marca = rs.getString("Nombre_Marca");
		if(!linea.equalsIgnoreCase(linea2)){
			linea2 = linea;
%>
<tr>
	<th colspan="7"><div align="center" class="style5"><%= linea2%></div></th>
</tr>
<%}
		if(!marca.equalsIgnoreCase(marca2)){
			marca2 = marca;
%>
<tr>
	<th colspan="7"><div align="left" class="style4"><%= marca2%></div></th>
</tr>
<%}
%>
  <tr> 
	<td width="98"><div align="center"></div>
	  <div align="center"><%=rs.getString("claveProducto")%></div></td>
    <td width="492"><div align="center"><%=rs.getString("descripcion")%></div></td>
	<td width="98"><div align="right">$ <%=pro.formatoDinero(rs.getString("Precio1"))%></div></td>
	<td width="98"><div align="right">$ <%=pro.formatoDinero(rs.getString("Precio2"))%></div></td>
	<td width="98"><div align="right">$ <%=pro.formatoDinero(rs.getString("Precio3"))%></div></td>
	<td width="98"><div align="right">$ <%=pro.formatoDinero(rs.getString("Precio4"))%></div></td>
	<td width="98"><div align="right">$ <%=pro.formatoDinero(rs.getString("Precio5"))%></div></td>
  </tr>
<%}
	if(rs != null){
		rs.close();
	}
	pro.cierraConexion();
%>	   
</table>
<p></p>
<table width="481" border="0" align="center">
<tr>
<td width="213">
<p align="left"><a href="Consultas_Productos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
</td>
<td width="37">&nbsp;</td>
<td width="186">
<p align="right"><a href="Imprimir_Lista_Precios.jsp" onMouseOut="MM_swapImgRestore()" target="_blank"><img src="imagenes/Imprimir1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
</td>
</tr>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
