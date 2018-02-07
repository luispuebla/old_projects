<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Muestra Consulta Facturas en Tiempo por Cliente</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script>
<!--
function MandaSubmit(f){
	f.submit();
}

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

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String fechaInicial = request.getParameter("datebox");
	fechaInicial= fechaInicial.substring(6,10)+"-"+fechaInicial.substring(0,2)+"-"+fechaInicial.substring(3,5);
	String fechaFinal = request.getParameter("datebox2");
	fechaFinal= fechaFinal.substring(6,10)+"-"+fechaFinal.substring(0,2)+"-"+fechaFinal.substring(3,5);
	String rfc = "%";
	String nombreClie = "%";
	if(!(request.getParameter("clienteAbonar").equals("ToDoS"))){
		rfc= request.getParameter("clienteAbonar").substring(0,request.getParameter("clienteAbonar").indexOf("%!%"));
		nombreClie = request.getParameter("clienteAbonar").substring(request.getParameter("clienteAbonar").indexOf("%!%")+3,request.getParameter("clienteAbonar").length());
	}
	ResultSet rs = ticket.dameDatoAbonos(rfc, nombreClie, fechaInicial, fechaFinal);	
%>
	<table align="center" width="750" border="1" cellpadding="0" cellspacing="0">
	<caption>Abonos de <%=fechaInicial%> a <%=fechaFinal%></caption>
	  <tr>
	  	<th width="242">Cliente</th>
		<th width="77">Fecha</th>
		<th width="104">Forma Pago</th>
		<th width="104">Referencia Pago</th>
		<th width="109">Recibi&oacute; Abono</th>
		<th width="100">Monto</th>		
	  </tr>
<%	while(rs.next()){ 
		String formaPago = "Efectivo";
		String referenciaC = "&nbsp;";
		if(rs.getInt("formatoPago") == 2){
			formaPago = "Cheque";
			referenciaC = rs.getString("referenciaCobro");
		}
		else if(rs.getInt("formatoPago") == 3){
			formaPago = "Transferencia";
			referenciaC = rs.getString("referenciaCobro");		
		}
		else if(rs.getInt("formatoPago") == 4){
			formaPago = "T.Cr&eacute;dito";
			referenciaC = rs.getString("referenciaCobro");		
		}
		else if(rs.getInt("formatoPago") == 5){
			formaPago = "T.D&eacute;bito";
			referenciaC = rs.getString("referenciaCobro");		
		}
%>
	  <tr>
	  	<td><%=rs.getString("nombreCliente")%> (<%=rs.getString("rfc")%>)</td>
	  	<td><div align="center"><%=rs.getString("fecha")%></div></td>		
	  	<td><div align="center"><%=formaPago%></div></td>
	  	<td><div align="center"><%=referenciaC%></div></td>
	  	<td><div align="center"><%=rs.getString("cobro")%></div></td>		
	  	<td><div align="right"><b>$ <%=ticket.formatoDinero(rs.getString("monto"))%></b></div></td>		
	  </tr>
<%	} %>	  
	</table>

<p><a href="Menu_Consul_Ventas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
