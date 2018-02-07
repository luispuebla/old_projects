<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="inv" class="com.vas.bd.ManagerInventarios" scope="page" />
<jsp:useBean id="produ" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Muestra Consulta Mermas</title>
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
	ResultSet porMes = inv.Mermas_Mes(anio+"-"+mes+"-%%");
%>
<p>
<table width="726" border="1">
  <tr> 
    <th width="72">Fecha</th>
    <th width="369">Producto</th>
    <th width="104">Inventario</th>
	<th width="153">Inventario Regalos </th>
  </tr>
<% 		
		double totalPorMesICajas = 0.00;
		double totalPorMesIRCajas = 0.00;
		double totalPorMesIKg = 0.00;
		double totalPorMesIRKg = 0.00;
		while (porMes.next()){
			String tipoP = "Cajas";
			if(porMes.getInt("tipo") == 2){
				tipoP = "kg.";
			}
			String descripcion = produ.descripcionProducto(porMes.getString("ClaveProducto"));
			double cantidad = porMes.getDouble("cantidad");
			double tipoI = porMes.getDouble("tipo");
%>
  <tr> 
    <td><div align="center"><%=porMes.getString("fecha")%></div></td>
    <td><div align="center"><%=descripcion%></div></td>
<%
if(tipoI == 1){
	if(porMes.getInt("tipo") == 1){
		totalPorMesICajas = totalPorMesICajas + cantidad;
	}else{
		totalPorMesIKg = totalPorMesIKg + cantidad;	
	}
%>
    <td><div align="center"><%= cantidad%> <%=tipoP%></div></td>
	<td>&nbsp;</td><%
}
else{
	if(porMes.getInt("tipo") == 1){
		totalPorMesIRCajas = totalPorMesIRCajas + cantidad;	
	}else{
		totalPorMesIRKg = totalPorMesIRKg + cantidad;		
	}
%>
    <td><div align="left">&nbsp;</div></td>
	<td><div align="center"><%= cantidad%> <%=tipoP%></div></td>
<%
}
%>
  </tr>
<%
		}
		if(porMes != null){
			porMes.close();
		}
		inv.cierraConexion();		
		// de ResultSet Complex
%>
  <tr> 
  	<td></td>
    <th><div align="right">T O T A L : </div></th>
    <td><div align="center"><%= inv.acortaLongitud(totalPorMesICajas+"") %> Cajas.<br/><%= inv.acortaLongitud(totalPorMesIKg+"") %> Kg.</div></td>
    <td><div align="center"><%= inv.acortaLongitud(totalPorMesIRCajas+"")%> Cajas.<br/><%= inv.acortaLongitud(totalPorMesIRKg+"") %> Kg.</div></td>
  </tr>
</p>
</table>
<p align="center"><a href="Consultas_Inventarios.jsp" target="_self" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
