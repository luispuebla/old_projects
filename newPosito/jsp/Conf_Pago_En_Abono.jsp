<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="error.jsp"%>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />

<html>
<head>
<title>Pagos de Abono Agregado</title>
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

function MandaSubmit(f){
	document.form1.submit();
}

function funcionFoco(){
	document.form1.imaC.focus();
}

//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Imprimir2.jpg','imagenes/Regresar2.jpg')">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = request.getParameter("rfc");
	String nombreCliente = request.getParameter("nombreCliente");
	String posibleAPagar = request.getParameter("posibleAPagar");
	String PagoCliente = request.getParameter("PagoCliente");
	String formaPago = request.getParameter("formaPago");
	String referenciaC = "";	
	if(!(formaPago.equals("1"))){
		referenciaC = request.getParameter("referenciaC");
	}
	BigDecimal ImporteMaximo = new BigDecimal(posibleAPagar);
	ImporteMaximo = ImporteMaximo.setScale(2, RoundingMode.HALF_UP);	
	BigDecimal ImportePagado = new BigDecimal(PagoCliente);
	ImportePagado = ImportePagado.setScale(2, RoundingMode.HALF_UP);
	if(ImporteMaximo.compareTo(ImportePagado) == -1){ %>
		<b class="roj">El importe introducido($ <%=ticket.formatoDinero(ImportePagado.toString())%>) es mayor 
		<br/>al monto actual a Cr&eacute;dito ($ <%=ticket.formatoDinero(ImporteMaximo.toString())%>).</b><br/>
		Da click en Modificar para reingresar el monto a Abonar.
		<form name="retache" method="post" target="_self" action="Pago_En_Abono.jsp">
			<input type="hidden" name="clave" value="<%=rfc%>¡<%=nombreCliente%>">
			<p><input type="submit" value="Modificar" name="Modificar"></p>
		</form>
		
<%	}
	else{

		Vector <String> resultado = ticket.almacenaAbono(rfc, nombreCliente, ImportePagado.toString(),formaPago, referenciaC, usuario);
		if(resultado != null){
			if(resultado.elementAt(0).equalsIgnoreCase("Exito")){
%>
				<h1>Se almacen&oacute; correctamente el Abono.</h1>
				<form name="printAbono" method="post" target="blank" action="Ticket_Abono.jsp">
					<input type="hidden" name="rfc" value="<%=rfc%>">
					<input type="hidden" name="nombreCliente" value="<%=nombreCliente%>">
					<input type="hidden" name="importe" value="<%=ImportePagado.toString()%>">
					<input type="hidden" name="formaPago" value="<%=formaPago%>">
					<input type="hidden" name="referenciaC" value="<%=referenciaC%>">
					<input type="hidden" name="usuario" value="<%=usuario%>">
					<p><input type="submit" name="Imprime_Ticket_Abono" value="Imprime Abono"></p>
				</form>
<%			
				if(resultado.size()>1){ %>
					<table align="center" cellpadding="0" cellspacing="0" border="1">
					<caption>
					Ticket(s) a Cr&eacute;dito Finiquitado(s):
					</caption>
 					  <tr>
					  	<th width="162">N&uacute;mero<br/>Ticket</th>
					  	<th width="182">Monto</th>						
					  </tr>
<%					for(int i = 1; i<resultado.size(); i=i+2){%>
 					  <tr>
					  	<td><div align="center"><%=resultado.elementAt(i)%></div></td>
					  	<td><div align="right">$ <%=resultado.elementAt(i+1)%></div></td>
					  </tr>
<%					}  // Cierre for%>
					</table>
<%				} // Cierre if
			} // Cierre Fue Exito
			else{ %>
				<b class="roj"> No se pudo almacenar el abono, se registro el siguiente error:</b><br/>
				<b class="roj"><%=resultado.elementAt(1)%></b>				
<%			} // Cierre Fue Error
		}
		else{ %>
			<b class="roj">No pude almacenar el abono. Vuelve a intentarlo.</b>
<%		}  
	}%>		
<p><a href="Menu_Cobros.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>