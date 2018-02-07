<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="inv" class="com.alpha.bd.ManagerInventarios" scope="page" />

<html>
<head>
<title>Hist&oacute;rico Modificaci&oacute;n Directa en Inventario</title>
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String anio = request.getParameter("aaaa");
	String mes = request.getParameter("mes");
%>
<p>
<table width="900" border="1" cellpadding="0" cellspacing="0">
<caption>Hist&oacute;rico de Modificaci&oacute;n Directa o por Merma en Inventario<br/>Ordenado del m&aacute;s reciente al m&aacute;s antiguo.</caption>
  <tr> 
    <th width="85">Fecha</th>
    <th width="84">Hora</th>	
    <th width="269">Producto</th>
	<th width="75">Sitio</th>	
	<th width="83">Cantidad<br/>Previa</th>	
	<th width="91">Cantidad<br/>
	Nueva</th>	
	<th width="111">Causa</th>	
	<th width="84">Usuario</th>		
  </tr>
<% 		
	ResultSet rs = inv.HistoricoInventario(anio+"-"+mes+"-%%");
	while (rs.next()){
		String tipoP = "Uni.";
		String elSitio = "Tienda";		
		String cantidadPrevia = rs.getInt("cantidadOriginal")+"";
		String cantidadActual = rs.getInt("nuevaCantidad")+"";
		String razon = "Cambio Directo";
		if(rs.getInt("tipoPro") == 1){
			tipoP = "Kg.";
			cantidadPrevia = rs.getDouble("cantidadOriginal")+"";
			cantidadActual = rs.getDouble("nuevaCantidad")+"";
		}
		if(rs.getInt("tipo") == 2){
			razon = "Por Merma: "+rs.getString("causa");
		}
		else{
			razon = "Cambio Directo: "+rs.getString("causa");
		}
		if(rs.getInt("sitio") == 2){
			elSitio = "Almac&eacute;n";
		}		
%>
  <tr> 
    <td><div align="center"><%=rs.getString("fecha")%></div></td>
    <td><div align="center"><%=rs.getString("Hora")%></div></td>
    <td><div align="left">(<%=rs.getString("ID_Pro")+") "+rs.getString("descripcion")%></div></td>
    <td><div align="center"><%=elSitio%></div></td>
    <td><div align="right"><%=cantidadPrevia%> <%=tipoP%></div></td>
    <td><div align="right"><%=cantidadActual%> <%=tipoP%></div></td>
    <td><div align="center"><%=razon%></div></td>
    <td><div align="center"><%=rs.getString("claveUsuario")%></div></td>
<%
	}
	if(rs != null){
		rs.close();
	}
	inv.cierraConexion();		
		// de ResultSet Complex
%>
</table>
<p align="center"><a href="Consultas_Inventarios.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"  onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
