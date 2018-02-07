<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="usuario" class="com.alpha.bd.ManagerVendedores" scope="page"/>

<html>
<head>
<title>Detalle Cliente</title>
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
 	String usuarioS = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuarioS == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String claveVendedor = request.getQueryString();
	String nombreVendedor = "";
	ResultSet rs = usuario.dameUsuario(claveVendedor);
	while(rs.next()){ 
		nombreVendedor = rs.getString("NombreE");
		String permiso = "No";
		if(rs.getInt("permisoCobro")== 1){
			permiso = "Si";
		}	
%>
<h1>Detalle de<strong> <%=rs.getString("NombreE")%></strong></h1>
<table width="750" border="1" align="center">
  <caption>Detalle de Empleado</caption>
  <tr>
	<th width="130">Nombre:</th>
	<td width="604"><%=rs.getString("NombreE")%></td>
  </tr>
  <tr>	
	<th>Permiso de Cobro:</th>
	<td><%=permiso%></td>	
  </tr>
  <tr>	
	<th>Salario Semanal:</th>
	<td>$ <%=usuario.formatoDinero(rs.getString("salario"))%></td>	
  </tr>
  <tr>	
	<th>Direcci&oacute;n</th>
	<td><%=rs.getString("direccion")%> &nbsp;</td>	
  </tr>
  <tr>	
	<th>Tel. Casa:</th>
	<td><%=rs.getString("telCasa")%> &nbsp;</td>	
  </tr>
  <tr>	
	<th>Tel. Celular:</th>
	<td><%=rs.getString("telCel")%> &nbsp;</td>	
  </tr>
  <tr>	
	<th>Observaciones:</th>
	<td><%=rs.getString("observacion")%>&nbsp;</td>	
  </tr>
<%	} 
	rs.close();
	usuario.cierraConexion();
%>  
</table>
<p>
<% 	rs = usuario.dameOtrasClaves(claveVendedor, nombreVendedor); 
	boolean masClaves = false;
	while(rs.next() && !masClaves){
		masClaves = true;
	}
	if(masClaves){	
		rs.beforeFirst();
%>
<table width="750" border="1" align="center">
  <tr>
	<th>Otras Claves de Vendedor:</th>
  </tr>	
<%   	while (rs.next()){ %>
		  <tr>
			<td><div align="center"><%=rs.getString("claveVenta")%></div></td>
		  </tr>
<%		} 
		rs.close();
		usuario.cierraConexion();
%>  
</table>
<%	} %>
</p>
<p align="center"><a href="TodosUsuarios.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
