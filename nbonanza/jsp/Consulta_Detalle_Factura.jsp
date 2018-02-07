<%@ page language="java" import="java.sql.*, java.io.*, java.util.*"%>
<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" />

<html>
<head>
<title>Detalle Factura</title>
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	} 
	String fac = request.getQueryString();
	ResultSet rs = facturas.dameFactura(fac);
	String tickets = "";
	String rfc="";
	String nombre = "";
	String fechaCrea = "";
	String fechaFac = "";
	String tasa0 = "0.00";
	String tasa15 = "0.00";
	String iva = "0.00";
	String total = "0.00";
	while (rs.next()) {  
		tickets = rs.getString("tickets");
		tickets = tickets.replace('%',',');
		nombre = rs.getString("nombre");
		rfc = rs.getString("rfc");
		fechaCrea = rs.getString("fechaCrea");
		fechaFac = rs.getString("fechaFac");
		tasa0 = facturas.formatoDinero(rs.getString("tasa0"));
		tasa15 = facturas.formatoDinero(rs.getString("tasa15"));
		iva = facturas.formatoDinero(rs.getString("iva"));
		total = facturas.formatoDinero(rs.getString("total"));
	}
	rs.close();
	facturas.cierraConexion();		
%>	

<h1>El Detalle de la Factura #<%=fac%>  es:</h1>
<table width="650" border="1">
  <tr> 
    <th width="145"><div align="center">Núm. Factura </div></th>
    <th width="113"><div align="center">Fecha Creaci&oacute;n</div></th>
    <th width="118"><div align="center">Fecha en Factura</div></th>	
    <th width="117"><div align="center">RFC</div></th>
    <th width="123"><div align="center">Nombre</div></th>
  </tr>
  <tr> 
    <td height="25"><div align="center"><%= fac %></div></td>
    <td><div align="center"><%= fechaCrea %></div></td>
    <td><div align="center"><%= fechaFac %></div></td>
    <td><div align="center"><%= rfc %></div></td>
    <td><div align="center"><%= nombre %></div></td>	
  </tr>
  <tr>
  	<td colspan="5">&nbsp;</td>
  </tr>
  <tr> 
    <th><div align="center">Ticket(s)</div></th>
    <th><div align="center">Tasa 0%</div></th>
    <th><div align="center">Tasa 15%</div></th>	
    <th><div align="center">I.V.A.</div></th>
    <th><div align="center">Total</div></th>
  </tr>
  <tr> 
    <td height="25"><div align="center"><%= tickets %></div></td>
    <td><div align="right">$ <%= tasa0 %></div></td>
    <td><div align="right">$ <%= tasa15 %></div></td>
    <td><div align="right">$ <%= iva %></div></td>
    <td><div align="right">$ <%= total %></div></td>	
  </tr>
</table>
<p>&nbsp;</p>
<form name="form1" method="post" action="Consulta_Detalle_CXF.jsp">
<input type="hidden" name="rfc" value="<%=rfc %>">
<input type="hidden" name="nombre" value="<%=nombre %>">
<div align="center"><input type="submit" name="Regresar" value="Regresar"></div>
</form>		
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


