<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Lista de Costos</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
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

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

function Cerrar() {
	parent.close(); 
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
	font-weight: bold;
}
.style6 {color: #000099}
-->
</style>
</head>
<body onLoad="imprimirPagina(); Cerrar()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
 <table width="649" border="1" align="center" bordercolor="">
  <caption>
  LISTA DE COSTOS 
  </caption>
  <tr> 
     <th width="98" bgcolor="#DFE1EC" bordercolor="#000000">Clave</th>
    <th width="489" bgcolor="#DFE1EC" bordercolor="#000000">Producto</th>
    <th width="98" bgcolor="#DFE1EC" bordercolor="#000000">Costo</th>
   </tr>
</table>
<p></p>
<table width="647" border="1" align="center" bordercolor="#FFFFFF">
<%
	ResultSet rs = pro.Lista_Costos();
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
	<th colspan="7" bordercolor="#FFFFFF"><div align="center" class="style5"><%= linea2%></div></th>
</tr>
<%}
		if(!marca.equalsIgnoreCase(marca2)){
			marca2 = marca;
%>
<tr>
	<th colspan="7" bordercolor="#FFFFFF"><div align="left" class="style4"><%= marca2%></div></th>
</tr>
<%}
%>
  <tr> 
	<td width="98" bordercolor="#000000"><div align="center"></div>
	  <div align="center"><%=rs.getString("claveProducto")%></div></td>
    <td width="492" bordercolor="#000000"><div align="center"><%=rs.getString("descripcion")%></div></td>
	<td width="98" bordercolor="#000000"><div align="right">$ <%=pro.formatoDinero(rs.getString("costo"))%></div></td>
  </tr>
<%}
	if(rs != null){
		rs.close();
	}
	pro.cierraConexion();
%>	   
</table>
</body>
</html>
