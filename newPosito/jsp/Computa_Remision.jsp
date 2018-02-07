<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="credi" class="com.alpha.bd.ManagerCredito" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Computa Solicitud de Remisi&oacute;n</title>
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
%>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	boolean hayFactura = false;
	String rfc = request.getParameter("rfc");
	String nombre = request.getParameter("nombre");
	String [] ArrayRemision = (String[])request.getParameterValues("remision");
	String [] ArrayNumTicket = (String[])request.getParameterValues("numTicket");
	String [] ArrayAccion = (String[])request.getParameterValues("accion");
	for(int i=0; i < ArrayRemision.length; i++){
		// Anulo Posibilidad de Factura por Remision
		if(ArrayAccion[i].equals("2")){
			credi.cambiaEstatusNoSeFactura(ArrayRemision[i]);
		}
		else if(ArrayAccion[i].equals("1")){
			hayFactura = true;
		}
	}
	if(!hayFactura){ %>
		<jsp:forward page="Menu_FacturasV.jsp" />
<%	}
	else{ %>
	<h1>Solicitaste Facturas las siguientes Remisiones:</h1>
	<form name="form1" action="Alta_Factura_Por_Remision.jsp" target="_self" method="post">
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<input type="hidden" name="nombre" value="<%=nombre%>">

	<table align="center" border="1" cellpadding="0" cellspacing="0" width="350">
		<tr>
			<th width="155">Remisi&oacute;n</th>
			<th width="189">Ticket Correspondiente</th>
		</tr>
			<%	for(int i=0; i < ArrayRemision.length; i++){
					if(ArrayAccion[i].equals("1")){	%>
					<input type="hidden" name="numTicket" value="<%=ArrayNumTicket[i]%>">
							<tr>
								<td><div align="center"><%=ArrayRemision[i]%></div></td>
								<td><div align="center"><%=ArrayNumTicket[i]%></div></td>								
							</tr>
			<%		}
				} %>
		
	</table>
	<p align="center"><input type="submit" value="Facturar" name="Facturar"></p>
	</form>
<%	}  %>	
<p>
<a href="Escoge_Cliente_Factura_Remision.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
