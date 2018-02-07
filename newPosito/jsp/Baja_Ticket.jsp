<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>

<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" />

<html>
<head>
<title>Baja de Ticket</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
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
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 		
	String ticket1 = request.getParameter("ticket1");
	String tipo = request.getParameter("tipo");
%>
	<form name="form1" method="post" action="Conf_Baja_Ticket.jsp">
	<input name="ticket1" type="hidden" value="<%=ticket1 %>">
	<input name="tipo" type="hidden" value="<%=tipo %>">
<%		
	if(tipo.equalsIgnoreCase("1")){	
%>

<table width="550" border="0" align="center">
  <tr> 
    <th> <div align="center">El Ticket esta registrado como pagado al contado, para reingresar los productos al inventario, cancelar la Factura de Venta (en caso de que exista) y dar de baja el pago presione Eliminar.</div>
        <p align="center"><font face="Eras Medium ITC"> 
          <input type="submit" name="Submit" value="Eliminar">
        </font></p>
    </th>
</tr> 
</table>
<%		
	}
	else if (tipo.equalsIgnoreCase("2")){
%>
<table width="550" border="0" align="center">
  <tr> 
    <th><div align="center">El Ticket esta registrado como pagado a crédito, para reingresar los productos al inventario, cancelar la Factura de Venta (en caso de que exista), regresar el saldo al Cliente (Si es que no ha sido liquidado) y dar de baja el cr&eacute;dito presione Eliminar.</div>
        <p align="center">
          <input type="submit" name="Submit" value="Eliminar">
        </p>
    </th>
</tr> 
</table>
<%		
	}
%>
</form>
<p align="center"><a href="Menu_Bajas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> </p>
</body>
</html>
