<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.vas.bd.ManagerVenta" scope="page" />
<jsp:useBean id="diaHoy" class="com.vas.bd.TimeStamp" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Inventario Todos</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){
	document.RegN.submit();
}

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
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg','imagenes/Imprimir2.jpg')">
<%
	ResultSet productos = alVen.todosLosProductosConInv();	
	double totalC = 0.0;	
%>	
	<table width="780" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>INVENTARIO TOTAL (<%=diaHoy.date%>)</caption>
	  <tr>
	  	<th width="74">Clave</th>
		<th width="357">Descripci&oacute;n Producto</th>
		<th width="100">Cantidad<br />Venta</th>
		<th width="100">Cantidad<br />Obsequio</th>		
		<th width="100">Costo</th>		
	  </tr>
	 <p></p>
<%
	while (productos.next()){
		String tipoP = "Cajas";
		String tempOb = "0";
		if(productos.getString("ExistenciaOb") != null){
			tempOb = productos.getString("ExistenciaOb");
		}
		if(productos.getInt("tipo") == 2){
			tipoP = "Kg.";
		}
		double costo = alVen.dameCostoProducto(productos.getString("claveProducto"));
		costo = costo * productos.getInt("existencia");
		totalC = totalC + costo;
%>
      <tr>
		<td><div align="center"><%=productos.getString("claveProducto")%></div></td>
		<td><%=productos.getString("descripcion")%></td>
		<td><div align="center"><%=productos.getString("existencia")%> <%=tipoP%></div></td>
		<td><div align="center"><%=tempOb%> <%=tipoP%></div></td>
		<td><div align="center">$ <%=alVen.formatoDinero(alVen.acortaLongitud(costo+""))%></div></td>
      </tr>
<%	
	}
	if(productos != null){
		productos.close();
	}
	alVen.cierraConexion();	
	
%>	
      <tr>
		<td></td>
		<td></td>
		<td></td>
		<th>Costo<br />Inventario</th>
		<td><div align="center"><strong>$ <%=alVen.formatoDinero(alVen.acortaLongitud(totalC+""))%></strong></div></td>
      </tr>  	  
	</table>
	<br/>
	<table width="450" align="center" border="0">
		<tr>
			<td><a href="Consultas_Inventarios.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"  onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a>
</td>
			<td>&nbsp;</td>
			<td><a href="Imprime_Inventario.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprime','','imagenes/Imprimir2.jpg',1)"><img src="imagenes/Imprimir1.jpg" name="Imprime" width="152" height="36" border="0"></a></td>						
		</tr>	
	</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
