<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="Credi" class="com.alpha.bd.ManagerCredito" scope="page" />

<html>
<head>
<title>Selecci�n de Remision a Facturar</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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

//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
   String remision = request.getParameter("clave");%>
<%
//System.out.println("la clave que llego: "+clave);
 if(remision == null){%>

	<b class="roj">Debes seleccionar un Cliente.</b>
<%
}
else{
	String rfc = Credi.dameRFCClieXTicketLigado(remision);
	String nombre = Credi.dameNombreClieXTicketLigado(remision);
%>
<h1>Selecciona por cada remisi�n encontrada que deseas hacer:</h1>
<form name="form1" method="post" target="_self" action="Computa_Remision.jsp">
<input type="hidden" name="rfc" value="<%=rfc%>">
<input type="hidden" name="nombre" value="<%=nombre%>">
 <table width="588" border="1" align="center">
  <caption>
  REMISIONES REGISTRADAS PARA ESTE CLIENTE:<br/><%=nombre%> (<%=rfc%>)
  </caption>
  <tr> 
    <th width="79">Remisi&oacute;n</th>
	<th width="159">Fecha Venta </th>
    <th width="135">Monto Remisi&oacute;n </th>
    <th width="187">Acci&oacute;n</th>
   </tr>
<%
	ResultSet rs = Credi.dameRemisionesDeCliente(nombre, rfc);
	while(rs.next()){
%>
	<input type="hidden" name="remision" value="<%=rs.getString("ID_Liga")%>">
	<input type="hidden" name="numTicket" value="<%=rs.getString("numTicket")%>">
  <tr> 
  <td> <div align="center"><%=rs.getString("ID_Liga")%>  </div></td>
    <td><div align="center"><%=rs.getString("FechaCredito")%></div></td>
    <td ><div align="right">$ <%=Credi.formatoDinero(rs.getString("cantidadAPagar"))%></div></td>
    <td ><div align="center"><select name="accion">
								<option selected value="0">Definir despu&eacute;s</option>
								<option value="1">Facturar</option>
								<option value="2">No Factura</option>																
	</select></div></td>
  </tr>
<%
	}
	if(rs != null){
		rs.close();
	}
	Credi.cierraConexion();			
	
%>	  
</table>
  <p><font> 
    <input type="submit" name="Submit" value="Enviar">
  </font> </p>
</form>
<%}%>
<p align="center"><a href="Escoge_Cliente_Factura_Remision.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
