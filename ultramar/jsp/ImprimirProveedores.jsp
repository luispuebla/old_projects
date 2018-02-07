<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="prov" class="com.ult.bd.ManagerProveedores" />

<html>
<head>
<title>Todos los Proveedores</title>
<link href="ultramarinaMiniCSS.css" rel="stylesheet" type="text/css">
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
      " desde la web. Actualizate o hazlo desde los men�s");
}

function Cerrar() {
	parent.close(); 
}
//-->
</script>
</head>
  
<body onLoad="imprimirPagina(); Cerrar()">
<h1>Todos los Proveedores registrados en Sistema son:</h1>
<table width="668" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="48" ><div align="center">RFC</div></th>
    <th width="143" ><div align="center">Nombre</div></th>
    <th width="162" ><div align="center">Direcci�n</div></th>
    <th width="54" ><div align="center">Colonia</div></th>
    <th width="56" ><div align="center">Ciudad</div></th>
    <th width="53" ><div align="center">Tel&eacute;fono</div></th>
	 <th width="106" ><div align="center">Vendedor</div></th>
  </tr>
<%	
		ResultSet rs = prov.dameProveedores();
		while (rs.next())
		{  
		String tel = rs.getString("tel1");
		if( tel.equals("")){
			tel = "&nbsp;";
		}
		String con = rs.getString("vendedor");
		if( con.equals("")){
			con = "&nbsp;";
		}
%>
  <tr> 
    <td align="center"><div align="center"><%= rs.getString("rfc")%></div></td>
    <td><div align="center"><%= rs.getString("nombre")%></div></td>
    <td><%= rs.getString("direccion")%></td>
    <td align="center"><%= rs.getString("colonia")%></td>
    <td align="center"><%= rs.getString("ciudad")%></td>
    <td align="center"><%= tel %></td>
	<td width="106" ><div align="center"><%= con%></div></td>
  </tr>
<%	       
		 } 
%>
</table>
<% prov.cierraConexion();%>
<p> </p>
</body>
</html>


