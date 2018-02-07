<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="prov" class="com.alpha.bd.ManagerProveedores"  scope="page"/>
<jsp:useBean id="com" class="com.alpha.bd.ManagerCompra" />

<html>
<head>
<title>Detalle de Compras a Proveedor</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	} 
    String rfc = request.getParameter("elRFC"); 
	if(rfc == null){ %>
		<form name="retache" method="post" target="_self" action="Existe_Proveedor_Compras.jsp">
			<b class="roj">Debes especificar un proveedor</b>		
			<p><input type="submit" value="Volver" name="Volver"></p>
		</form>
<%	}
	else{
		if (prov.existe(rfc)) {
%>
<h1>Datos del Proveedor:</strong></h1>
<table width="800" border="1" align="center">
  <tr> 
    <th width="108">RFC</th>
    <th width="182">Nombre</th>
    <th width="194">Dirección</th>
    <th width="108">Colonia</th>
    <th width="94">Delegación / Municipio</th>
    <th width="74">Código Postal</th>
  </tr>
<%		
		ResultSet rs = prov.datos_Proveedor(rfc);
		while (rs.next()){ 
%>
  <tr> 
    <td><div align="center"><%= rs.getString("rfc")%></div></td>
    <td><div align="center"><%= rs.getString("nombre")%></div></td>
    <td><div align="center">&nbsp;<%= rs.getString("direccion")%></div></td>
    <td><div align="center">&nbsp;<%= rs.getString("colonia")%></div></td>
    <td><div align="center">&nbsp;<%= rs.getString("delegacion")%></div></td>
    <td><div align="center">&nbsp;<%=rs.getString("cp")%></div></td>
  </tr>
<%	      
		} 
		rs.close();
		prov.cierraConexion();
%>
</table>

<h1>Datos de Compras (Ordenadas de la m&aacute;s reciente a la m&aacute;s antigua):</h1>
<table width="750" border="1" align="center">
  <tr >
    <th>Clave Compra</th>
    <th>Fecha Registro</th>
    <th>Pago</th>
    <th>Entrega</th>	
    <th>Total</th>
	
  </tr>
<%		
	ResultSet compra = com.todasLasComprasXProveedores(rfc);
	while(compra.next()){
		String pago = "Sin Pagar";
		String entrega = "Sin Recibir";
		if(compra.getInt("pago") == 1){
			pago = "Parcialmente Pagado";
		}
		else if(compra.getInt("pago") == 2){
			pago = "Finalizado";
		}
		if(compra.getInt("entrega") == 1){
			entrega = "Parcialmente Recibido";
		}
		else if(compra.getInt("entrega") == 2){
			entrega = "Totalmente Recibido";
		}
%>
  <tr> 
    <td><div align="center"><%=compra.getString("claveOrden")%></div></td>
    <td><div align="center"><%=compra.getString("fechaRegistro")%></div></td>
    <td><div align="center"><%=pago%></div></td>
    <td><div align="center"><%=entrega%></div></td>
    <td><div align="right">$ <%=com.formatoDinero(compra.getString("total"))%></div></td>
  </tr>
 <%
 	}
	compra.close();
	com.cierraConexion();
 %>
</table>		
<%	     
	}
	 else{ %>
		<b class="roj">El Proveedor con RFC = <%=rfc%> no se encuentra registrado en el Sistema.</b>
<%
	}
}
%>
<p><a href="Consultas_Proveedores.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p> 

<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

