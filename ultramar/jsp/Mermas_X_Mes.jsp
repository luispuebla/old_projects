<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="inv" class="com.ult.bd.ManagerInventarios" scope="page" />
<jsp:useBean id="produ" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />

<html>
<head>
<title>Muestra Consulta Mermas</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

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
	ResultSet porMes = inv.Mermas_Mes(anio+"-"+mes+"-%%");
	ResultSet porMesB = inv.Mermas_Mes_B(anio+"-"+mes+"-%%");	
%>
<p>
<table width="763" border="1">
  <tr> 
    <th width="98">Fecha</th>
    <th width="247">Producto</th>
    <th width="90">Merma Kg.</th>
    <th width="90">Merma Unidad</th>
	<th width="130">Merma Botella 1 </th>
	<th width="130">Merma Botella 21 </th>
	<th width="127">Merma Copeo Lt. </th>
  </tr>
<% 		
		int totalPorMesIBotella = 0;
		int totalPorMesIBotella2 = 0;
		double totalPorMesICopeo = 0;
		double totalPorMesIKg = 0.00;
		int totalPorMesIUnidad = 0;
		while (porMes.next()){
			String descripcion = produ.dameNombreMP(porMes.getString("ClaveProducto"));
	%>
	  <tr> 
	<%
			if(porMes.getString("Tipo").equalsIgnoreCase("A")){
			double cantidad = porMes.getDouble("cantidad");
				totalPorMesIKg = totalPorMesIKg + cantidad;
%>
    <td><div align="center"><%=porMes.getString("fecha")%></div></td>
    <td><div align="center"><%=descripcion%></div></td>
    <td><div align="center"><%= cantidad%></div></td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<%
			}
			if(porMes.getString("Tipo").equalsIgnoreCase("B")){
				int canti = porMes.getInt("cantidad");
				totalPorMesIUnidad = totalPorMesIUnidad + canti;			
%>
    <td><div align="center"><%=porMes.getString("fecha")%></div></td>
    <td><div align="center"><%=descripcion%></div></td>
    <td><div align="center">&nbsp;</div></td>
	<td><div align="center"><%= canti%></div></td>
	<td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<%
		}
	}
%>
  </tr>
<% 		
		while (porMesB.next()){
			String descripcion = produ.dameNombreMP(porMesB.getString("ClaveProducto"));
			int cantidadB = porMesB.getInt("cantidadB");
			int cantidadB2 = porMesB.getInt("cantidadB2");
			double cantidadC = porMesB.getDouble("cantidadC");
			totalPorMesIBotella = totalPorMesIBotella + cantidadB;
			totalPorMesIBotella2 = totalPorMesIBotella2 + cantidadB2;
			totalPorMesICopeo = totalPorMesICopeo + cantidadC;
%>
  <tr> 
    <td><div align="center"><%=porMesB.getString("fecha")%></div></td>
    <td><div align="center"><%=descripcion%></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
	<%
	if(cantidadB == 0){
	%>
	<td>&nbsp;</td>
	<%
	}
	else{%>
	<td><div align="center"><%= cantidadB%></div></td>
	<%
	}
	if(cantidadB2 == 0){
	%>
	<td>&nbsp;</td>
	<%
	}
	else{%>
	<td><div align="center"><%= cantidadB2%></div></td>
	<%
	}
	if(cantidadC == 0.00){
	%>
	<td>&nbsp;</td>
	<%
	}
	else{%>
	<td><div align="center"><%= cantidadC%></div></td>
<%	}
		}
%>
  </tr>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="center"><%= inv.acortaLongitud(totalPorMesIKg+"") %> Kg.</div></td>
    <td><div align="center"><%= inv.acortaLongitud(totalPorMesIUnidad+"") %> Unidad</div></td>
    <td><div align="center"><%= inv.acortaLongitud(totalPorMesIBotella+"") %> Botella(s)</div></td>
    <td><div align="center"><%= inv.acortaLongitud(totalPorMesIBotella2+"") %> Botella(s)</div></td>
    <td><div align="center"><%= inv.acortaLongitud(totalPorMesICopeo+"") %> Lt.</div></td>
  </tr>
</p>
</table>
<p align="center"><a href="Consultas_Inventarios.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
<% inv.cierraConexion();%>
</body>
</html>
