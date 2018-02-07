<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="cli" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="en" class="com.vas.bd.ManagerEntregas" scope="page" />
<jsp:useBean id="produ" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Muestra Consulta Ventas por Entregar</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script>

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MandaSubmit(f){
	f.submit();
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
	String tipoConsul = request.getParameter("tipoConsul");
	double total = 0.00;
	String anio = request.getParameter("anio");
	String mes = request.getParameter("mes");
	String dia = "";
	//System.out.println("tipoConsul: "+tipoConsul);
	//System.out.println("mes: "+mes);
	//System.out.println("anio: "+anio);
	if(tipoConsul.equals("dia")){
		dia = request.getParameter("dia");
		//System.out.println("dia: "+dia);
		ResultSet porDia = en.totalCantidadXFecha(anio+"-"+mes+"-"+dia);
%>
<h1>El total de productos vendidos para la fecha: <%=dia%> / <%=mes%> / <%=anio%> </h1>
<p>
<table width="700" border="1">
  <tr> 
    <th width="162">Clave Producto</th>
    <th width="249">Producto</th>
    <th width="135">Cantidad</th>
    <th width="126">Costo</th>	
  </tr>
<% 		while (porDia.next()){
			String elTipo = "Cajas";
			if(porDia.getInt("tipo") == 2){
				elTipo = "Kg.";
			}
			total += (porDia.getDouble("total")*porDia.getDouble("costo"));
%>
  <tr> 
    <td><div align="center"><%=porDia.getString("claveProducto") %></div></td>
    <td><div align="center"><%=porDia.getString("producto")%></div></td>
    <td><div align="center"><%= porDia.getDouble("total") %> <%=elTipo%></div></td>
	<td>
	  <div align="right">$ <%= en.formatoDinero(en.acortaLongitud((porDia.getDouble("total")*porDia.getDouble("costo"))+"")) %></div></td>	
  </tr>
</p>
<%}
		if(porDia != null){
			porDia.close();
		}		
		en.cierraConexion();
%>
	<tr>
		<th colspan="3"><div align="right">Total</div></th>
		<td><div align="right">$ <%=en.formatoDinero(en.acortaLongitud(total+""))%></div></td>
	</tr>
</table>
<%
	}
	else{		
		ResultSet porMes = en.totalCantidadXFecha(anio+"-"+mes);
%>
<h1>El total de productos vendidos para el mes:  <%=mes%> / <%=anio%> </h1><p>
<table width="700" border="1">
  <tr> 
    <th width="162">Clave Producto</th>
    <th width="249">Producto</th>
    <th width="135">Cantidad</th>
    <th width="126">Costo</th>	
  </tr>
<% 		while (porMes.next()){
			String elTipo = "Cajas";
			if(porMes.getInt("tipo") == 2){
				elTipo = "Kg.";
			}
			total += (porMes.getDouble("total")*porMes.getDouble("costo"));			
%>
  <tr> 
    <td><div align="center"><%=porMes.getString("claveProducto") %></div></td>
    <td><div align="center"><%=porMes.getString("producto")%></div></td>
    <td><div align="center"><%= porMes.getDouble("total") %> <%=elTipo%></div></td>
	<td><div align="right">$ <%= en.formatoDinero(en.acortaLongitud(((porMes.getDouble("total") * porMes.getDouble("costo"))+""))) %></div></td>	
  </tr>
</p><%}
		if(porMes != null){
			porMes.close();
		}		
		en.cierraConexion();	
%>
	<tr>
		<th colspan="3"><div align="right">Total</div></th>
		<td><div align="right">$ <%=en.formatoDinero(en.acortaLongitud(total+""))%></div></td>
	</tr>
</table>
<%
	}
%>
<p align="center">
<table border="0" width="300">
	<tr>
		<td valign="top">	
			<form name="form1" target="_blank" action="Imprimir_Cant_Productos.jsp" method="post">
			<p align="center"> <a onClick="MandaSubmit(document.forms[0])" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprime','','imagenes/Imprimir2.jpg',1)"><img src="imagenes/Imprimir1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
			<input type="hidden" name="tipoCon" value="<%=tipoConsul%>">
			<input type="hidden" name="aaaa" value="<%=anio%>">
			<input type="hidden" name="mes" value="<%=mes%>">
			<input type="hidden" name="dia" value="<%=dia%>">								
			</form>
		</td>
		<td>&nbsp;</td>	
		<td valign="top"><a href="Consultas_Ventas.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></td>		
	</tr>
</table>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
