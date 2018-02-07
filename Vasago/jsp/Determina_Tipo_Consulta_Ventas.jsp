<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="cli" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="en" class="com.vas.bd.ManagerEntregas" scope="page" />
<jsp:useBean id="produ" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Muestra Consulta Ventas</title>
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

function MandaSubmit(f){
	f.submit();
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

<body onLoad="MM_preloadImages('imagenes/Imprimir2.jpg')">
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
	String dia = "";
	if(tipoConsul.equals("dia")){
		dia = request.getParameter("dia");
		ResultSet porDia = en.Facturas_Dia(anio+"-"+mes+"-"+dia);
%>
<strong>El total de Ventas en el d&iacute;a (<%=dia%> / <%=mes%> / <%=anio%>) son:  </strong>
<p>
<table width="824" border="1">
  <tr> 
    <th width="358">Cliente</th>
    <th width="136">Documento</th>
    <th width="125"><div align="center">Total</div></th>
	<th width="177">Costo</th>
  </tr>
<% 		double totalPorDia = 0.0;
		double totalCD = 0.0;

		while (porDia.next()){
			String documento = new String();
			String nombreCliente = cli.nombreCliente(porDia.getString("ClaveCliente"));
			if(porDia.getInt("tipo") == 1){
				documento = "F --> "+porDia.getString("factura");
			}
			else{
				documento = "R --> "+porDia.getString("remision");
			}
			double costoU = en.CostoXVenta(porDia.getInt("claveVenta"));
			totalCD = totalCD +costoU;
%>
  <tr> 
    <td><div align="left"><%=nombreCliente %></div></td>
    <td><div align="center"><%=documento%></div></td>
    <td><div align="center">$ <%= en.formatoDinero(porDia.getString("Total")) %></div></td>
	<td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(costoU+""))%></div></td>
  </tr>
<%
	totalPorDia = totalPorDia + porDia.getDouble("Total");
		}
		if(porDia != null){
			porDia.close();
		}		
		en.cierraConexion();
		// de ResultSet Complex
%>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(totalPorDia+"")) %></div></td>
	<td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(totalCD+"")) %></div></td>
  </tr>
  <tr> 
  	<td></td>
    <th><div align="right">UTILIDAD: </div></th>
    <td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud((totalPorDia-totalCD)+"")) %></div></td>
  </tr>
</p>
</table>
<%
	}
	else if (tipoConsul.equals("semana")){
	String semana=request.getParameter("semana");
	//System.out.println("Fue busqueda por semana para la semana: " +semana);
		ResultSet porSemana = en.Facturas_Semana(semana, anio+"-"+mes);
%>	
<strong>El total de Ventas en la Semana (<%=mes%> / <%=anio%>) fueron:  </strong>
<p>
<table width="824" border="1">
  <tr> 
    <th width="358">Cliente</th>
    <th width="136">Documento</th>
    <th width="125"><div align="center">Total</div></th>
	<th width="177">Costo</th>
  </tr>
<% 		double totalPorSemana = 0.0;
		double totalCS = 0.0;

		while (porSemana.next()){
			String documento2 = new String();
			String nombreCliente2 = cli.nombreCliente(porSemana.getString("ClaveCliente"));
			if(porSemana.getInt("tipo") == 1){
				documento2 = "F --> "+porSemana.getString("factura");
			}
			else{
				documento2 = "R --> "+porSemana.getString("remision");
			}
			double costoUS = en.CostoXVenta(porSemana.getInt("claveVenta"));
			totalCS = totalCS +costoUS;
%>
  <tr> 
    <td><div align="left"><%=nombreCliente2 %></div></td>
    <td><div align="center"><%=documento2%></div></td>
    <td><div align="center">$ <%= en.formatoDinero(porSemana.getString("Total")) %></div></td>
	<td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(costoUS+""))%></div></td>
  </tr>
<%
	totalPorSemana = totalPorSemana + porSemana.getDouble("Total");
		}
		if(porSemana != null){
			porSemana.close();
		}		
		en.cierraConexion();		
%>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(totalPorSemana+"")) %></div></td>
	<td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(totalCS+"")) %></div></td>
  </tr>
  <tr> 
  	<td></td>
    <th><div align="right">UTILIDAD: </div></th>
    <td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud((totalPorSemana-totalCS)+"")) %></div></td>
  </tr>
</p>
</table>
<%		
	}
	else{
		//System.out.println("Fue busqueda por Mes");
		ResultSet porMes = en.Facturas_Mes(anio+"-"+mes);
%>
<strong>El total de Ventas en el Mes (<%=mes%> / <%=anio%>) son:  </strong>
<p>
<table width="824" border="1">
  <tr> 
    <th width="359">Cliente</th>
    <th width="135">Documento</th>
    <th width="125"><div align="center">Total</div></th>
	<th width="177">Costo</th>
  </tr>
<% 		double totalPorMes = 0.0;
		double totalCM = 0.0;

		while (porMes.next()){
			String documento3 = new String();
			String nombreCliente3 = cli.nombreCliente(porMes.getString("ClaveCliente"));
			if(porMes.getInt("tipo") == 1){
				documento3 = "F --> "+porMes.getString("factura");
			}
			else{
				documento3 = "R --> "+porMes.getString("remision");
			}
			double costoUM = en.CostoXVenta(porMes.getInt("claveVenta"));
			totalCM = totalCM +costoUM;

%>
  <tr> 
    <td><div align="left"><%=nombreCliente3 %></div></td>
    <td><div align="center"><%=documento3%></div></td>
    <td><div align="center">$ <%= en.formatoDinero(porMes.getString("Total")) %></div></td>
	<td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(costoUM+""))%></div></td>
  </tr>
<%
	totalPorMes = totalPorMes + porMes.getDouble("Total");
		}
		if(porMes != null){
			porMes.close();
		}		
		en.cierraConexion();				
%>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(totalPorMes+"")) %></div></td>
	<td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud(totalCM+"")) %></div></td>
  </tr>
  <tr> 
  	<td></td>
    <th><div align="right">UTILIDAD: </div></th>
    <td><div align="center">$ <%= en.formatoDinero(en.acortaLongitud((totalPorMes-totalCM)+"")) %></div></td>
  </tr>
</p>
</table>
<%
	}
%>
<table border="0" width="400" align="center">
	<tr>
	<td valign="baseline">
		<p align="center"><a href="Consultas_Ventas.jsp" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"  onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
</td>
		<td>&nbsp;</td>
		<td valign="baseline">
		<form name="form1" target="_blank" action="Imprimir_VentasXTiempo.jsp" method="post">
		<p align="center">
				<a onClick="MandaSubmit(document.forms[0])" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprime','','imagenes/Imprimir2.jpg',1)"><img src="imagenes/Imprimir1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
		<input type="hidden" name="tipoCon" value="<%=tipoConsul%>">
		<input type="hidden" name="aaaa" value="<%=anio%>">
		<input type="hidden" name="mes" value="<%=mes%>">
		<input type="hidden" name="dia" value="<%=dia%>">								

</form></td>
	</tr>
</table>
</body>
</html>
