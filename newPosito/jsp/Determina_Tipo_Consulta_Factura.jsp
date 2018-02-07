<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="pro" class="com.alpha.bd.ManagerProveedores" />
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />
<jsp:useBean id="produ" class="com.alpha.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Muestra Consulta Compras</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

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
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 	
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String tipoConsul = request.getParameter("tipoCon");
	String anio = request.getParameter("aaaa");
	String mes = request.getParameter("mes");
	String fechaHoy = alCom.dameFechaHoy();	
%>
	<b class="titulos">Siendo Hoy (<%=fechaHoy%>) </b>
	<br/>
<%	
	if(tipoConsul.equals("dia")){
		String dia = request.getParameter("dia");
		ResultSet porDia = alCom.Facturas_Dia(anio+"-"+mes+"-"+dia);
%>
<strong>El total de Compras Registradas para el d&iacute;a <%=dia%> / <%=mes%> / <%=anio%> son:  </strong>
<p>
<table width="850" border="1" cellpadding="0" cellspacing="0">
  <tr> 
    <th width="111">Proveedor</th>
	<th width="65">Clave<br/>Compra</th>
    <th width="104">Total<br/>Compra</th>
    <th width="98">Factura(s) y/o<br/>Remisiones</th>	
	<th width="77">Fecha<br/>Registro</th>
	<th width="95">Fecha(s)<br/>Entrega(s) </th>
	<th width="84">Fecha<br/>Pago </th>
	<th width="95">Estado<br/>Entrega</th>
	<th width="101">Estado<br/>Pago</th>
  </tr>
<% 		BigDecimal totalPorDia = new BigDecimal("0.00");
		while (porDia.next()){
			String nombreProveedor = pro.nombreProveedor(porDia.getString("ClaveProveedor"));
			ResultSet mas = alCom.dameFacturasExtras(porDia.getString("ClaveOrden"));
			String factu = "";
			String factufe = "";
			while(mas.next()){			
				if(mas.getInt("tipoDoc") == 1){
					if(factu.length() > 0){			
						factu += ", F-" +mas.getString("docAval");
						factufe += ", " +mas.getString("fechaDoc");
					}
					else{
						factu = "F-"+mas.getString("docAval");
						factufe = mas.getString("fechaDoc");					
					}
				}
				else{
					if(factu.length() > 0){							
						factu += ", N-" +mas.getString("docAval");
						factufe += ", " +mas.getString("fechaDoc");
					}
					else{
						factu = "N-"+mas.getString("docAval");
						factufe = mas.getString("fechaDoc");					
					}
				}		
			}
			if(mas != null){
				mas.close();
			}
			alCom.cierraConexion2();
			String edoEntrega = "Sin Recibir";
			if(porDia.getInt("Entrega") == 1){
				edoEntrega = "Recibido Parcialmente";
			}
			else if(porDia.getInt("Entrega") == 2){
				edoEntrega = "Recibido Totalmente";
			}
			String edoPago = "Sin pagos";
			if(porDia.getInt("pago") == 1){
				edoPago = "Pagado Parcialmente";
			}
			else if(porDia.getInt("pago") == 2){
				edoPago = "Pagado Totalmente";			
			}
%>
  <tr> 
    <td><div align="center"><%=nombreProveedor %></div></td>
	<td><div align="center"><%=porDia.getString("claveOrden")%></div></td>
	<td><div align="right">$ <%=alCom.formatoDinero(porDia.getString("Total"))%></div></td>
    <td><div align="center">&nbsp;<%=factu%></div></td>	
	<td><div align="center"><%=porDia.getString("fechaRegistro")%></div></td>	
	<td><div align="center">&nbsp;<%=factufe%></div></td>
	<td><div align="center"><%=porDia.getString("fechaPago")%></div></td>	
    <td><div align="center"><%=edoEntrega%></div></td>
    <td><div align="center"><%=edoPago%></div></td>
  </tr>
<%
	totalPorDia = totalPorDia.add(new BigDecimal(porDia.getDouble("Total")));
		}
		if(porDia != null){
			porDia.close();
		}
		alCom.cierraConexion();
		// de ResultSet Complex
%>
  <tr> 
    <th colspan="7"><div align="right">TOTAL SOLICITADO: </div></th>
    <td colspan="2"><div align="right"><b>$ <%= alCom.formatoDinero(totalPorDia.toString())%></b></div></td>
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
<strong>El total de Compras en la Semana <%=semana%> del mes <%=mes%> / <%=anio%> son:  </strong>
<p>
<table width="850" border="1" cellpadding="0" cellspacing="0">
  <tr> 
    <th width="111">Proveedor</th>
	<th width="65">Clave<br/>Compra</th>
    <th width="104">Total<br/>Compra</th>
    <th width="98">Factura(s) y/o<br/>Remisiones</th>	
	<th width="79">Fecha<br/>Registro</th>
	<th width="93">Fecha(s)<br/>Entrega(s) </th>
	<th width="84">Fecha<br/>Pago </th>
	<th width="95">Estado<br/>Entrega</th>
	<th width="101">Estado<br/>Pago</th>
  </tr>
<% 		BigDecimal totalPorSemana = new BigDecimal("0.00");

		while (porSemana.next()){
			String nombreProveedor = pro.nombreProveedor(porSemana.getString("ClaveProveedor"));
			ResultSet mas2 = alCom.dameFacturasExtras(porSemana.getString("ClaveOrden"));
			String factu2 = "";
			String factufe2 = "";
			while(mas2.next()){
				if(mas2.getInt("tipoDoc") == 1){
					if(factu2.length() > 0){
						factu2 += ", F-"+mas2.getString("docAval");
						factufe2 += ", " +mas2.getString("fechaDoc");
					}
					else{
						factu2 = "F-"+mas2.getString("docAval");
						factufe2 = mas2.getString("fechaDoc");					
					}
				}
				else{
					if(factu2.length() > 0){				
						factu2 += ", N-" +mas2.getString("docAval");
						factufe2 += ", " +mas2.getString("fechaDoc");
					}
					else{
						factu2 = "N-"+mas2.getString("docAval");
						factufe2 = mas2.getString("fechaDoc");					
					}
				}		
			}
			if(mas2 != null){
				mas2.close();
			}
			alCom.cierraConexion2();
			String edoEntrega = "Sin Recibir";
			if(porSemana.getInt("Entrega") == 1){
				edoEntrega = "Recibido Parcialmente";
			}
			else if(porSemana.getInt("Entrega") == 2){
				edoEntrega = "Recibido Totalmente";
			}
			String edoPago = "Sin pagos";
			if(porSemana.getInt("pago") == 1){
				edoPago = "Pagado Parcialmente";
			}
			else if(porSemana.getInt("pago") == 2){
				edoPago = "Pagado Totalmente";			
			}							
%>
  <tr> 
    <td><div align="center"><%=nombreProveedor %></div></td>
	<td><div align="center"><%=porSemana.getString("claveOrden")%></div></td>
	<td><div align="right">$ <%=alCom.formatoDinero(porSemana.getString("Total"))%></div></td>
    <td><div align="center">&nbsp;<%=factu2%> </div></td>
	<td><div align="center"><%=porSemana.getString("fechaRegistro")%></div></td>	
	<td><div align="center">&nbsp;<%=factufe2%></div></td>	
	<td><div align="center"><%=porSemana.getString("fechaPago")%></div></td>	
    <td><div align="center"><%=edoEntrega%></div></td>
    <td><div align="center"><%=edoPago%></div></td>
	  </tr>
<%
	totalPorSemana = totalPorSemana.add(new BigDecimal(porSemana.getDouble("Total")));
		}
		if(porSemana != null){
			porSemana.close();
		}
		alCom.cierraConexion();		// de ResultSet Complex
%>
  <tr> 
    <th colspan="7"><div align="right">TOTAL SOLICITADO: </div></th>
    <td colspan="2"><div align="right"><b>$ <%= alCom.formatoDinero(totalPorSemana.toString()) %></b></div></td>
  </tr>
</p>
</table>
<%		
	}
	else{
		//System.out.println("Fue busqueda por Mes");
		ResultSet porMes = alCom.Facturas_Mes(anio+"-"+mes);
%>
<strong>El total de Compras en el Mes <%=mes%> / <%=anio%> son:  </strong>
<p>
<table width="850" border="1" cellpadding="0" cellspacing="0">
  <tr> 
    <th width="111">Proveedor</th>
	<th width="65">Clave<br/>Compra</th>
    <th width="104">Total<br/>Compra</th>
    <th width="98">Factura(s) y/o<br/>Remisiones</th>	
	<th width="79">Fecha<br/>Registro</th>
	<th width="93">Fecha(s)<br/>Entrega(s) </th>
	<th width="84">Fecha<br/>Pago </th>
	<th width="95">Estado<br/>Entrega</th>
	<th width="101">Estado<br/>Pago</th>
  </tr>
<% 		BigDecimal totalPorMes = new BigDecimal("0.00");

		while (porMes.next()){
			String nombreProveedor = pro.nombreProveedor(porMes.getString("ClaveProveedor"));
			ResultSet mas3 = alCom.dameFacturasExtras(porMes.getString("ClaveOrden"));
			String factu3 = "";
			String factufe3 = "";
			while(mas3.next()){
				if(mas3.getInt("tipoDoc") == 1){
					if(factu3.length() > 0){
						factu3 += ", F-" +mas3.getString("docAval");
						factufe3 += ", " +mas3.getString("fechaDoc");
					}
					else{
						factu3 = "F-"+mas3.getString("docAval");
						factufe3 = mas3.getString("fechaDoc");					
					}
				}
				else{
					if(factu3.length() > 0){				
						factu3 += ", N-" +mas3.getString("docAval");
						factufe3 += ", " +mas3.getString("fechaDoc");
					}
					else{
						factu3 = "N-"+mas3.getString("docAval");
						factufe3 = mas3.getString("fechaDoc");					
					}
				}		
			}
			if(mas3 != null){
				mas3.close();
			}
			alCom.cierraConexion2();
			String edoEntrega = "Sin Recibir";
			if(porMes.getInt("Entrega") == 1){
				edoEntrega = "Recibido Parcialmente";
			}
			else if(porMes.getInt("Entrega") == 2){
				edoEntrega = "Recibido Totalmente";
			}
			String edoPago = "Sin pagos";
			if(porMes.getInt("pago") == 1){
				edoPago = "Pagado Parcialmente";
			}
			else if(porMes.getInt("pago") == 2){
				edoPago = "Pagado Totalmente";			
			}								
%>
  <tr> 
    <td><div align="center"><%=nombreProveedor %></div></td>
	<td><div align="center"><%=porMes.getString("claveOrden")%></div></td>
	<td><div align="right">$ <%=alCom.formatoDinero(porMes.getString("Total"))%></div></td>
    <td><div align="center">&nbsp;<%=factu3%>&nbsp;</div></td>	
	<td><div align="center"><%=porMes.getString("fechaRegistro")%></div></td>	
	<td><div align="center">&nbsp;<%=factufe3%></div></td>	
	<td><div align="center"><%=porMes.getString("fechaPago")%></div></td>	
    <td><div align="center"><%=edoEntrega%></div></td>
    <td><div align="center"><%=edoPago%></div></td>
  </tr>
 <%
	totalPorMes = totalPorMes.add(new BigDecimal(porMes.getDouble("Total")));
		}
		if(porMes != null){
			porMes.close();
		}
		alCom.cierraConexion();		// de ResultSet Complex		
%>
  <tr> 
    <th colspan="7"><div align="right">TOTAL SOLICITADO: </div></th>
    <td colspan="2"><div align="right"><b>$ <%= alCom.formatoDinero(totalPorMes.toString()) %></b></div></td>
  </tr>
</p>
</table>
<%
	}
%>
<p align="center"><a href="Consultas_Compras.jsp" target="_self"  onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"  onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
