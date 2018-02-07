<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.vas.bd.ManagerProveedores" />
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />
<jsp:useBean id="produ" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Muestra Consulta Productos</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script>

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
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	String anio = request.getParameter("aaaa");
	String mes = request.getParameter("mes");
	String produc = request.getParameter("clave");
	ResultSet porMes = alCom.Producto_Mes(anio+"-"+mes+"-",produc);
%>
<jsp:setProperty name="alCom" property="claveProducto" value="<%=produc%>"/>
<p>
<table align="center" width="563" cellpadding="0" cellspacing="0" border="1">
  <tr>
    <th width="103">Producto:</th>
	<td width="454"><%= produc+" "+produ.descripcionProducto(produc)%>
	</td>
  </tr>
</table>
<p></p>
<table width="726" border="1">
  <tr> 
    <th width="80">Fecha</th>
    <th width="86">Factura</th>
    <th width="331">Proveedor</th>
	<th width="97">Cantidad Unidad</th>
  </tr>
<% 		double totalPorMes1 = 0.00;
		while (porMes.next()){
			double cantuni = 0.00;
			String nombreProveedor = pro.nombreProveedor(porMes.getString("ClaveProveedor"));
			cantuni = porMes.getDouble("cantidad");
			ResultSet mas3 = alCom.dameFacturasExtras(porMes.getString("ClaveOrden"));
			String factu3 = porMes.getString("factura");
			String factufe3 = porMes.getString("FechaEntrega");
			while(mas3.next()){
				factu3 = factu3+" / "+mas3.getString("factura");
				factufe3 = factufe3+" / "+mas3.getString("fecha_factura");
			}
			if(mas3 != null){
				mas3.close();
			}
			alCom.cierraConexion2();		// de ResultSet Complex							
			

%>
  <tr> 
    <td><div align="center"><%=factufe3%></div></td>
    <td><div align="center"><%=factu3%></div></td>
    <td><div align="left"><%= nombreProveedor%></div></td>
	<td><div align="right"><%= cantuni %></div></td>
  </tr>
<%
	totalPorMes1 = totalPorMes1 + cantuni;
		}
		if(porMes != null){
			porMes.close();
		}
		alCom.cierraConexion();		// de ResultSet Complex				
%>
  <tr> 
  	<td></td>
	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="right"><%= alCom.formatoDinero(alCom.acortaLongitud(totalPorMes1+"")) %></div></td>
  </tr>
</p>
</table>
<p align="center"><font color="#FFFFFF"><a href="Escoge_Producto_Consulta_Mes.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></font></p>
<p align="center"><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>
