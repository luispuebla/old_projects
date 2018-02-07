<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito"  scope="page"/>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Pagos Agregado</title>
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
	String pago = request.getParameter("totalPago");
	String ticket1 = request.getParameter("ticket1");
	String ticket2 = request.getParameter("ticket2");
	String ticket3 = request.getParameter("ticket3");
	String ticket4 = request.getParameter("ticket4");
	String ticket5 = request.getParameter("ticket5");
	String pago1 = request.getParameter("pago1");
	String pago2 = request.getParameter("pago2");
	String pago3 = request.getParameter("pago3");
	String pago4 = request.getParameter("pago4");
	String pago5 = request.getParameter("pago5");
	String fecha = request.getParameter("fecha");
	String vendedor = request.getParameter("vendedor");
	String vencimiento = request.getParameter("vencimiento");		
	// VOY A CHECAR QUE NO HAYA LLEGADO A ESTA PAGINA DANDOLE AL BOTON DE REGRESAR....
	boolean llegoConBack = false;
	if(ticket1.trim().length() != 0){
		int estaCobrado = ticket.yaEstabaACredito(ticket1, fecha);
		if (estaCobrado == 1){
			llegoConBack = true;
		}
	}
	if(ticket2.trim().length() != 0){
		int estaCobrado = ticket.yaEstabaACredito(ticket2, fecha);
		if (estaCobrado == 1){
			llegoConBack = true;
		}
	}
	if(ticket3.trim().length() != 0){
		int estaCobrado = ticket.yaEstabaACredito(ticket3, fecha);
		if (estaCobrado == 1){
			llegoConBack = true;
		}
	}
	if(ticket4.trim().length() != 0){
		int estaCobrado = ticket.yaEstabaACredito(ticket4, fecha);
		if (estaCobrado == 1){
			llegoConBack = true;
		}
	}
	if(ticket5.trim().length() != 0){
		int estaCobrado = ticket.yaEstabaACredito(ticket5, fecha);
		if (estaCobrado == 1){
			llegoConBack = true;
		}
	}
	if(llegoConBack){
%>
	<b class="roj">Ya habías realizado el registro a Crédito de el/los Ticket(s), no debes usar los botones de Navegación.</b>
<%		
	}
	else{
	
		int resultado = credito.daTicketACreditoVendedor(fecha, ticket1, ticket2, ticket3, ticket4, ticket5, pago1, pago2, pago3, pago4, pago5, vendedor, vencimiento, usuario);
		if(resultado == 0){
%>
<form name="form1" method="post" target="_blank" action="Ticket_Credito_Vendedor.jsp" >
	<input name="ticket1" type="hidden" value="<%=ticket1 %>">
	<input name="ticket2" type="hidden" value="<%=ticket2 %>">
	<input name="ticket3" type="hidden" value="<%=ticket3 %>">
	<input name="ticket4" type="hidden" value="<%=ticket4 %>">
	<input name="ticket5" type="hidden" value="<%=ticket5 %>">
	<input name="pago1" type="hidden" value="<%=pago1 %>">
	<input name="pago2" type="hidden" value="<%=pago2 %>">
	<input name="pago3" type="hidden" value="<%=pago3 %>">
	<input name="pago4" type="hidden" value="<%=pago4 %>">
	<input name="pago5" type="hidden" value="<%=pago5 %>">
	<input name="fecha" type="hidden" value="<%=fecha %>">
	<input name="vendedor" type="hidden" value="<%=vendedor%>">
	<input name="vencimiento" type="hidden" value="<%=vencimiento%>">
	<h1>Se guardó el registro exitosamente</h1>
	<p align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="132" height="41" border="0"></a></p>
	<input type="hidden" name="elTotal" value="<%=pago%>">
	<input type="hidden" name="usuario" value="<%=usuario %>">	
</form>
<%
		} 
		else if(resultado == 1){
			Vector <String> faltante = credito.dameProductosFaltantes(ticket1, ticket2, ticket3, ticket4, ticket5);

%>
		<b class="roj"> ¡¡FALTA PRODUCTO!!!</b>
		<p>	<table align="center" width="700" border="1" cellpadding="0" cellspacing="0">
			  <caption>No puedo finalizar la serie de tickets dado ya que no existe(n) <br/>el/los siguiente(s) producto(s) en Inventario.</caption>
<%				for(int i = 0; i < faltante.size(); i ++){ %>	  
				  <tr>
				  	<td><div align="center"><%=faltante.elementAt(i)%></div></td>
				  </tr>
<%				}    %>	  
			</table></p>
		<b class="aviso">Pida se agreguen al Inventario o bien se haga(n) otro(s) ticket(s).</b><br/>
<%			
		}
		else if(resultado == 2){
%>
	<b class="roj">Al menos un ticket ya esta dado a cr&eacute;dito. Verificalo.</b>
<%			
		}
		else if(resultado == 3){
%>
	<b class="roj">No pude finalizar la transacción de creaci&oacute;n de Cr&eacute;dito, vuelva a intentarlo.</b>
<%						
		}		
	}
%>
<p align="center"><a href="Menu_Credito.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="APadres1" width="132" height="41" border="0" id="APadres1"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>