<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pa" class="com.ult.bd.ManagerPagos" scope="page" />
<jsp:useBean id="prov" class="com.ult.bd.ManagerProveedores" scope="page" />
<jsp:useBean id="com" class="com.ult.bd.ManagerCompras" scope="page" />

<html>
<head>
<title>Pagos por Compra</title>
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

   String proveedor = request.getParameter("proveedor");
    String claveOrden = request.getParameter("clave");%>
<%
//System.out.println("la clave que llego: "+clave);
 if(claveOrden == null){%>
  <font>
  <%
 // System.out.println("Entro al vacio");
		out.print("Debes seleccionar una Compra."); %>
  </font> 
  <%
}
else{
%>
 <table width="860" border="1" align="center">
  <caption>
  Compra
  </caption>
  <tr> 
    <th width="60" bgcolor="#CCCCCC">Compra</th>
    <th width="100" bgcolor="#CCCCCC">Fecha</th>
	<th width="100" bgcolor="#CCCCCC">Descuento 1</th>
    <th width="100" bgcolor="#CCCCCC">Descuento 2</th>
    <th width="100" bgcolor="#CCCCCC">Descuento 3</th>
    <th width="100" bgcolor="#CCCCCC">SubTotal</th>
    <th width="100" bgcolor="#CCCCCC">Descuento</th>
    <th width="100" bgcolor="#CCCCCC">IVA</th>
    <th width="100" bgcolor="#CCCCCC">Total</th>
   </tr>
<%
	ResultSet rs1 = com.datosOrdenCompra2(claveOrden);
	while(rs1.next()){
%>
  <tr> 
    <td><div align="center"><%=rs1.getString("claveOrden")%></div></td>
    <td><div align="center"><%=rs1.getString("fecha")%></div></td>
	<td><div align="center"><%=rs1.getString("descuento1")%> %</div></td>
    <td><div align="right"><%=rs1.getString("descuento2")%> %</div></td>
    <td><div align="center"><%=rs1.getString("descuento3")%> %</div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("subtotal"))%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("descuento"))%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("iva"))%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs1.getString("total"))%></div></td>
  </tr>
<%
	}
%>	  
</table>
<h1>&nbsp;</h1>
 <table width="794" border="1" align="center">
  <caption>
  PAGOS
  </caption>
  <tr> 
    <th width="38" bgcolor="#CCCCCC">Clave</th>
    <th width="82" bgcolor="#CCCCCC">Compra</th>
	<th width="74" bgcolor="#CCCCCC">Fecha</th>
    <th width="86" bgcolor="#CCCCCC">Monto</th>
    <th width="118" bgcolor="#CCCCCC">Forma de Pago</th>
    <th width="80" bgcolor="#CCCCCC">Cheque / Referencia</th>
   </tr>
<%
	ResultSet rs = pa.damePagosCompra2(claveOrden);
	double topa = 0.0;
	while(rs.next()){
	topa = topa + rs.getDouble("monto");
%>
  <tr> 
    <td width="38"><div align="center"><%=rs.getString("consecutivo")%></div></td>
    <td width="82"><div align="center"><%=rs.getString("claveOrden")%></div></td>
	<td width="74"><div align="center"><%=rs.getString("fechaPago")%></div></td>
    <td width="86"><div align="right">$ <%=pa.formatoDinero(rs.getString("monto"))%></div></td>
    <td width="118"><div align="center">
        <%
	if(rs.getInt("formaPago") == 1)
		out.print("Efectivo");
	if(rs.getInt("formaPago") == 2)
		out.print("Cheque");
	if(rs.getInt("formaPago") == 3)
		out.print("Dep�sito");
	if(rs.getInt("formaPago") == 4)
		out.print("Tarjeta de Cr�dito");
	if(rs.getInt("formaPago") == 5)
		out.print("Tarjeta de D�bito");
	
	%>
    </div></td>
    <td width="80"><div align="center"><%=rs.getString("numeroCheque")%></div></td>
  </tr>
<%
	}
%>	  
</table>
 <table width="794" border="1" align="center">
  <tr> 
    <td width="38"></td>
    <td width="82"></td>
	<th width="74" bgcolor="#CCCCCC">TOTAL:</th>
    <th width="86" bgcolor="#CCCCCC"><div align="right">$ <%=pa.formatoDinero(topa+"")%></div></th>
    <td width="118"></td>
    <td width="80"></td>
   </tr>
</table>
<%}%>
<p align="center"><a href="Consultas_Pagos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<% pa.cierraConexion();%>
</body>
</html>
