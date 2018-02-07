<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.vas.bd.ManagerProveedores" />
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />
<jsp:useBean id="produ" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Muestra Consulta Compras</title>
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

	String tipoConsul = request.getParameter("tipoCon");
	String anio = request.getParameter("aaaa");
	String mes = request.getParameter("mes");
	if(tipoConsul.equals("dia")){
		String dia = request.getParameter("dia");
		ResultSet porDia = alCom.Facturas_Dia(anio+"-"+mes+"-"+dia);
%>
<strong>El total de Compras en el d&iacute;a son:  </strong>
<p>
<table width="824" border="1">
  <tr bgcolor="#CCCCCC"> 
    <th width="357">Proveedor</th>
    <th width="137">Factura</th>
    <th width="101">Total</th>
	<th width="201">Fecha Entrega </th>
  </tr>
<% 		double totalPorDia = 0.0;

		while (porDia.next()){
			String nombreProveedor = pro.nombreProveedor(porDia.getString("ClaveProveedor"));
			ResultSet mas = alCom.dameFacturasExtras(porDia.getString("ClaveOrden"));
			String factu = porDia.getString("Factura");
			String factufe = porDia.getString("Fecha");
			while(mas.next()){
				if(mas.getString("factura") != null){
					factu = factu+" / "+mas.getString("factura");
					factufe = factufe+" / "+mas.getString("fecha_factura");
				}
			}
			if(mas != null){
				mas.close();
			}
			alCom.cierraConexion2();			
%>
  <tr> 
    <td><div align="left"><%=nombreProveedor %></div></td>
    <td><div align="center"><%=factu%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(porDia.getString("Total")) %></div></td>
	<td><div align="center"><%= factufe %></div></td>
  </tr>
<%
	totalPorDia = totalPorDia + porDia.getDouble("Total");
		}
		if(porDia != null){
			porDia.close();
		}
		alCom.cierraConexion();
		// de ResultSet Complex
%>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="right">$ <%= alCom.formatoDinero(alCom.acortaLongitud(totalPorDia+"")) %></div></td>
	<td></td>
  </tr>
</p>
</table>
<%
	}
	else if (tipoConsul.equals("semana")){
	String semana=request.getParameter("semana");
	//System.out.println("Fue busqueda por semana para la semana: " +semana);
		ResultSet porSemana = alCom.Facturas_Semana(semana, anio+"-"+mes);
%>	
<strong>El total de Facturas en la Semana fueron:  </strong>
<p>
<table width="824" border="1">
  <tr bgcolor="#CCCCCC"> 
    <th width="357">Proveedor</th>
    <th width="137">Factura</th>
    <th width="101">Total</th>
	<th width="201">Fecha Entrega</th>
  </tr>
<% 		double totalPorSemana = 0.0;

		while (porSemana.next()){
			String nombreProveedor = pro.nombreProveedor(porSemana.getString("ClaveProveedor"));
			ResultSet mas2 = alCom.dameFacturasExtras(porSemana.getString("ClaveOrden"));
			String factu2 = porSemana.getString("factura");
			String factufe2 = porSemana.getString("Fecha");
			while(mas2.next()){
				if(mas2.getString("factura") != null){
					factu2 = factu2+" / "+mas2.getString("factura");
					factufe2 = factufe2+" / "+mas2.getString("fecha_factura");
				}
			}
			if(mas2 != null){
				mas2.close();
			}
			alCom.cierraConexion2();						
%>
  <tr> 
    <td><div align="left"><%=nombreProveedor %></div></td>
    <td><div align="center"><%=factu2%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(porSemana.getString("Total")) %></div></td>
	<td><div align="center"><%= factufe2 %></div></td>
  </tr>
<%
	totalPorSemana = totalPorSemana + porSemana.getDouble("Total");
		}
		if(porSemana != null){
			porSemana.close();
		}
		alCom.cierraConexion();		// de ResultSet Complex
%>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="right">$ <%= alCom.formatoDinero(alCom.acortaLongitud(totalPorSemana+"")) %></div></td>
	<td></td>
  </tr>
</p>
</table>
<%		
	}
	else{
		//System.out.println("Fue busqueda por Mes");
		ResultSet porMes = alCom.Facturas_Mes(anio+"-"+mes);
%>
<strong>El total de Facturas en el Mes son:  </strong>
<p>
<table width="824" border="1">
  <tr bgcolor="#CCCCCC"> 
    <th width="357">Proveedor</th>
    <th width="137">Factura</th>
    <th width="101">Total</th>
	<th width="201">Fecha Entrega</th>
  </tr>
<% 		double totalPorMes = 0.0;

		while (porMes.next()){
			String nombreProveedor = pro.nombreProveedor(porMes.getString("ClaveProveedor"));
			ResultSet mas3 = alCom.dameFacturasExtras(porMes.getString("ClaveOrden"));
			String factu3 = porMes.getString("factura");
			String factufe3 = porMes.getString("Fecha");
			while(mas3.next()){
				if(mas3.getString("factura") != null){
					factu3 = factu3+" / "+mas3.getString("factura");
					factufe3 = factufe3+" / "+mas3.getString("fecha_factura");
				}
			}
			if(mas3 != null){
				mas3.close();
			}
			alCom.cierraConexion2();						
%>
  <tr> 
    <td><div align="left"><%=nombreProveedor %></div></td>
    <td><div align="center"><%=factu3%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(porMes.getString("Total")) %></div></td>
	<td><div align="center"><%= factufe3 %></div></td>
  </tr>
<%
	totalPorMes = totalPorMes + porMes.getDouble("Total");
		}
		if(porMes != null){
			porMes.close();
		}
		alCom.cierraConexion();		// de ResultSet Complex		
%>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="right">$ <%= alCom.formatoDinero(alCom.acortaLongitud(totalPorMes+"")) %></div></td>
	<td></td>
  </tr>
</p>
</table>
<%
	}
%>
<p align="center"><font color="#FFFFFF"><a href="Seleccion_Fecha_Facturas.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></font></p>
<p align="center"><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>
