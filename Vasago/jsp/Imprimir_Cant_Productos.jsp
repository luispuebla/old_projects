<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.vas.bd.ManagerProductos" scope="page" />
<jsp:useBean id="cli" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="en" class="com.vas.bd.ManagerEntregas" scope="page" />
<jsp:useBean id="produ" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Cantidad de Producto + Costo x Tiempo</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
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

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

function Cerrar() {
	parent.close(); 
}

//-->
</script>
</head>
<body onLoad="imprimirPagina(); Cerrar()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	String dia = "";
	double total = 0.00;
	String tipoConsul = request.getParameter("tipoCon");
	String anio = request.getParameter("aaaa");
	String mes = request.getParameter("mes");
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
</body>
</html>
