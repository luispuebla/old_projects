<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />

<html>
<head>
<title>Compras Faltantes</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script>
<!--
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
-->
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
	String claveProveedor = request.getParameter("clave");	
	String nombreProveedor = request.getParameter("nombreP");	
	String fechaInicial = request.getParameter("datebox");
	fechaInicial= fechaInicial.substring(6,10)+"-"+fechaInicial.substring(0,2)+"-"+fechaInicial.substring(3,5);
	String fechaFinal = request.getParameter("datebox2");
	fechaFinal= fechaFinal.substring(6,10)+"-"+fechaFinal.substring(0,2)+"-"+fechaFinal.substring(3,5);
%>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=claveProveedor%>"/>
<jsp:setProperty name="alCom" property="fechaInicial" value="<%=fechaInicial%>"/>
<jsp:setProperty name="alCom" property="fechaFinal" value="<%=fechaFinal%>"/>
<h1>Compras faltantes del <%=fechaInicial%> al <%=fechaFinal%><br />
  correspondientes a<br />
  <%=nombreProveedor%>:</h1>
<table width="650" border="1" align="center">
  <caption>
  Para reimprimir Órden con estado de entrega dar click<br /> 
  en el bot&oacute;n correspondiente..
  </caption>
  <tr>
  	<th>Clave<br /> Compra</th>
	<th>Clave<br/>Proveedor</th>
	<th>Fecha <br />Entrega</th>
	<th>Importe<br />Total</th>
	<th>Estado de<br />Transacci&oacute;n</th>
  </tr>
  <%
  int fn = 1;
  ResultSet rs = alCom.dameComprasXProveedorXTiempoNueva();  
  while (rs.next()){
	String estatus = "";
	int estadoTransac = rs.getInt("Entrega");
	if(estadoTransac == 0){
		estatus = "Por entregar";
	}
	else if(estadoTransac == 1){
		estatus = "Parcialmente entregado";
	}
	else{
		estatus = "Finalizado";
	}
%>
  <tr>
  	<td><div align="center"><form name="form<%=fn%>" method="post" target="_blank" action="Reimprimir_CompraCF.jsp">	
	<br/><a href="DetalleCompraCF.jsp?<%=rs.getString("claveOrden")%>"><%=rs.getString("claveOrden")%></a>
	<input type="hidden" name="claveOrden" value="<%=rs.getString("claveOrden")%>"><br/><br/>
	<input type="submit" name="Imprimir" value="Imprimir">	
	 </form>
  		</div></td>
  	<td><div align="center"><%=rs.getString("rfc")%></div></td>
  	<td><div align="center"><%=rs.getString("fechaEntrega")%></div></td>
	<td><div align="right">$ <%=alCom.formatoDinero(rs.getString("total"))%></div></td>
	<td><div align="center"><%=estatus%></div></td>	
  </tr>
<%  
	fn++;
  }
	if(rs != null){
		rs.close();
	}
	alCom.cierraConexion();		// de ResultSet Complex						  
%>  
</table>
<%


%>
	
	
<p align="center"><a href="Consultas_Compras.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
