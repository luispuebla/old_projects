<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="prov" class="com.vas.bd.ManagerProveedores" />
<jsp:useBean id="com" class="com.vas.bd.ManagerCompra" />

<html>
<head>
<title>Detalle de Compras a Proveedor</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	} 
    String rfc = request.getParameter("rfc"); 
	if (prov.existe(rfc)) {
%>
</p>
<p><font size="5" face="Eras Medium ITC"><strong>Datos del Proveedor:</strong></font> </p>
<font face="Eras Medium ITC" size="3" color="#000099"></font>
<table width="799" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="74"><div align="center"><strong>RFC</strong></div></th>
    <th width="218"><div align="center"><strong>Nombre</strong></div></th>
    <th width="210"><div align="center"><strong>Dirección</strong></div></th>
    <th width="92"><div align="center"><strong>Colonia</strong></div></th>
    <th width="98"><div align="center"><strong>Delegación / Municipio</strong></div></th>
    <th width="67"><div align="center"><strong>Código Postal</strong></div></th>
  </tr>
<%		
		ResultSet rs = prov.datos_Proveedor(rfc);
		while (rs.next()){ 
		String cp = rs.getString("cp");
		if( cp.equals("")){
			cp = "&nbsp;";
		}
		String di = rs.getString("direccion");
		if( di.equals("")){
			di = "&nbsp;";
		}
		String co = rs.getString("colonia");
		if( co.equals("")){
			co = "&nbsp;";
		}
		String de = rs.getString("delegacion");
		if( de.equals("")){
			de = "&nbsp;";
		} 
%>
  <tr> 
    <td><div align="center"><%= rs.getString("rfc")%></div></td>
    <td><div align="center"><%= rs.getString("nombre")%></div></td>
    <td><div align="center"><%= di%></div></td>
    <td><div align="center"><%= co%></div></td>
    <td><div align="center"><%= de%></div></td>
    <td><div align="center"><%=cp%></div></td>
  </tr>
<%	      
		} 
		if(rs != null){
			rs.close();			
		}
		prov.cierraConexion();
%>
</table>
</font>
<h1>Datos de sus Compras:</h1>
<table width="629" border="1" align="center">
  <tr bgcolor="#CCCCCC">
    <th width="192"><div align="center">Número de la Compra </div></th>
    <th width="157"><div align="center">Fecha de la Compra </div></th>
    <th width="106"><div align="center">Total</div></th>
    <th width="146"><div align="center">Pago</div></th>
  </tr>
<%		
ResultSet compra = com.todasLasComprasXProveedores(rfc);
while(compra.next()){
%>
  <tr> 
    <td><div align="center"><%=compra.getString("claveOrden")%></div></td>
    <td><div align="center"><%=compra.getString("fecha")%></div></td>
    <td><div align="right">$ <%=com.formatoDinero(compra.getString("total"))%></div></td>
    <td><div align="center"><%
	if(compra.getInt("pago") == 0)
		out.print("No se ha Pagado");
	if(compra.getInt("pago") == 1)
		out.print("Pago Parcial");
	if(compra.getInt("pago") == 2)
		out.print("Pagado");
	%></div></td>
  </tr>
 <%
 }
 	if(compra != null){
		compra.close();
	}
	com.cierraConexion();
 %>
</table>		
</p>
<p align="center"><a href="Consultas_Proveedores.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<%	     
	}
	 else{ %>
		<b class="roj">El Proveedor no se encuentra registrado en el Sistema.</b>

<p><a href="Consultas_Proveedores.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p> 
<%
	}
%>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

