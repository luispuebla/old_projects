<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pa" class="com.ult.bd.ManagerPagos" scope="page" />
<jsp:useBean id="dia" class="com.ult.bd.CalculaDate" scope="page" />
<jsp:useBean id="prov" class="com.ult.bd.ManagerProveedores" scope="page" />
<jsp:useBean id="ti" class="com.ult.bd.TimeStamp" scope="page" />

<html>
<head>
<title>Cuentas por Pagar Hoy</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	
	String hoy = ti.date;
	double tt = 0.0;
	double tf = 0.0;
	double tp = 0.0;
%>
 <table width="671" border="1" align="center">
  <caption>
  Cuentas por Pagar <%=hoy%>
  </caption>
  <tr> 
    <th width="290">Proveedor</th>
	<th width="75">Compra</th>
	<th width="156">Fecha de la Entrega</th>
    <th width="122">Total Faltante</th>
   </tr>
<%
ResultSet rs = pa.comprasXproveedorPorPagarHoy();
while(rs.next()){
	
	int diasMas = pa.cambiaAInt(rs.getString("diasPago"));
	String entrega = rs.getString("fechaEntrega");
	
	if(pa.fechaMasDias(entrega,diasMas)){
	
	tp = pa.totalPagado(rs.getString("ClaveOrden"));
	tf = rs.getDouble("total") - tp;
	
	tt = tt + tf;
%>
  <tr> 
  <td> <div align="center"><%= prov.nombreProveedor(rs.getString("claveProveedor"))%></div></td>
    <td><div align="center"><a href="DetallePagos.jsp?<%=rs.getString("ClaveOrden")%>"><%=rs.getString("ClaveOrden")%></a></div></td>
    <td><div align="center"><%=entrega%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(tf+"")%></div></td>
  </tr>
<%
	}
}
%>	  
  <tr> 
  <td></td>
    <td></td>
    <td><div align="right"><strong>TOTAL</strong></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(pa.acortaLongitud(tt+""))%></div></td>
  </tr>
</table>
<p align="center"><a href="Consultas_Pagos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<% pa.cierraConexion();%>
</body>
</html>
