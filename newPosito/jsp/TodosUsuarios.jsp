<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<jsp:useBean id="usuario" class="com.alpha.bd.ManagerVendedores" />

<html>
<head>
<title>Todos los Vendedores</title>
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
%>	
<h1>Todos los Vendedores registrados en el Sistema son:</h1>
<table width="750" border="1" cellpadding="0" cellspacing="0">
  <tr> 
    <th width="96" ><div align="center">Clave Maestra</div></th>
    <th width="127" ><div align="center">Clave(s) Secundaria(s)</div></th>
    <th width="312" ><div align="center">Nombre</div></th>
    <th width="77" ><div align="center">Con Permiso<br/>de Cobro</div></th>
    <th width="126" ><div align="center">Salario<br/>Semanal</div></th>
  </tr>
<%	
		ResultSet rs = usuario.dameUsuarios();
		while (rs.next()) {
		String permiso = "No";
		if(rs.getInt("permisoCobro") == 1 ){
			permiso = "Si";
		} 
%>
  <tr> 
    <td align="center"><a href="DetalleEmpleado.jsp?<%=rs.getString("claveVenta")%>"><%= rs.getString("claveVenta") %></a></td>
	<td><div align="center"><%= usuario.dameClavesSecundarias(rs.getString("claveVenta"), rs.getString("nombreE"))%> </div></td>
    <td><%= rs.getString("nombreE") %> </td>
    <td><div align="center"><%= permiso %> </div></td>
    <td><div align="right">$ <%= usuario.formatoDinero(rs.getString("salario"))%> </div></td>
  </tr>
  <%	      
		        } 
		%>
</table>
	<p>
</p>
<p><a href="Menu_Vendedores.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


