<%@ page language="java" import="java.sql.*, java.io.*, java.util.*"  %>
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />
<jsp:useBean id="bloqueo" class="com.alpha.bd.BloqueaClientes" scope="page" />

<html>
<head>
<title>Existencia del Ticket</title>
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
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<% 
	bloqueo.depura();
	String fecha = request.getParameter("fecha");
	String ticket1 = request.getParameter("ticket1").trim();
	String ticket2 = request.getParameter("ticket2").trim();
	String ticket3 = request.getParameter("ticket3").trim();
	String ticket4 = request.getParameter("ticket4").trim();
	String ticket5 = request.getParameter("ticket5").trim();
	String pago1 = "";
	String pago2 = "";
	String pago3 = "";
	String pago4 = "";
	String pago5 = "";
	String rfc = request.getParameter("rfc");
	String nombreCliente = request.getParameter("cliente");
	double totalpagado = 0;
	int found= 0;
	int harta = 1;
	int tic1 = -1;
	int tic2 = -2;
	int tic3 = -3;
	int tic4 = -4;
	int tic5 = -5;
	if(!ticket1.trim().equals("")){
		tic1 = credito.cambiaAInt(ticket1);
		if(tic1 == 0){
			tic1 = -1;
		}
	}
	if(!ticket2.trim().equals("")){
		tic2 = credito.cambiaAInt(ticket2);
		if(tic2 == 0){
			tic2 = -2;
		}		
	}
	if(!ticket3.trim().equals("")){
		tic3 = credito.cambiaAInt(ticket3);
		if(tic3 == 0){
			tic3 = -3;
		}		
	}
	if(!ticket4.trim().equals("")){
		tic4 = credito.cambiaAInt(ticket4);
		if(tic4 == 0){
			tic1 = -4;
		}		
	}
	if(!ticket5.trim().equals("")){
		tic5 = credito.cambiaAInt(ticket5);
		if(tic5 == 0){
			tic5 = -5;
		}		
	}		
// VOY A VERIFICAR QUE AL MENOS ME ENVIARAN 1 TICKET 
	if (ticket1.trim().equals("") && ticket2.trim().equals("") && ticket3.trim().equals("") && ticket4.trim().equals("") && ticket5.trim().equals("")){
%>
	<b class="roj">Debes llenar por lo menos un campo de Ticket.</b>
	<form name="form1" method="post" action="Existe_TicketCredito.jsp">
		<input type="hidden" name="nombre" value="<%=nombreCliente%>">
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<p><input name="Regresar" type="submit" id="Regresar" value="Volver"></p>
	</form>
<% 
	}
// AHORA VERIFICO QUE DONDE ME DIERON TICKETS NO ME ESTEN REPITIENDO NINGUNO:
	else if(tic1 == tic2 || tic1 == tic3 || tic1 == tic4 || tic1 == tic5 || tic2 == tic3 || tic2 == tic4 || tic2 == tic5 || tic3 == tic4 || tic3 == tic5 || tic4 == tic5){
%>	
			<br /><b class="roj">Se detect&oacute; al menos una repetici&oacute;n de ticket en la lista, verifiquelo.<br/></b>
<%		
		if(ticket1.length()>0){
			%><br />Ticket1 --> <%=ticket1%>. <%
		}
		if(ticket2.length()>0){
			%><br />Ticket2 --> <%=ticket2%>. <%		
		}
		if(ticket3.length()>0){
			%><br />Ticket3 --> <%=ticket3%>. <%		
		}
		if(ticket4.length()>0){
			%><br />Ticket4 --> <%=ticket4%>. <%		
		}
		if(ticket5.length()>0){
			%><br />Ticket5 --> <%=ticket5%>. <%		
		}
%>		
	<form name="form1" method="post" action="Existe_TicketCredito.jsp">
		<input type="hidden" name="nombre" value="<%=nombreCliente%>">
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<p><input name="Regresar" type="submit" id="Regresar" value="Volver"></p>
	</form>
<%		
	} else {
%>
<jsp:setProperty name="credito" property="fecha" value="<%=fecha%>"/>		
<%		
		if(!(ticket1.length() == 0)){
%>			
<jsp:setProperty name="credito" property="numTicket" value="<%=ticket1%>"/>
<%			
			found = credito.existe();
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#1 (<%=ticket1%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<% 				harta = 0;
			}
			else if(found == 1){
			  	double pagado = credito.obtenVentasTicket();
			 	pago1 = pagado+"";
 				totalpagado = totalpagado + pagado; 
			}
			else if(found == 2){ %>
				<b class="roj"> OJO: El Ticket#1 (<%=ticket1%>) esta registrado en el Sistema como ya Pagado.</b> <br/>
				Cheque en Corte Diario.<br />
<%
				harta = 0;				
			}
			else if(found == 3){ %>
				<b class="roj"> OJO: El Ticket#1 (<%=ticket1%>) esta registrado en el Sistema como ya asignado a Cr&eacute;dito.</b> <br/>
				Cheque en Cr&eacute;ditos.<br />
<%
				harta = 0;
			}								
		}
// LO MISMO PARA TICKET 2
		if(!(ticket2.length() == 0)){
%>			
<jsp:setProperty name="credito" property="numTicket" value="<%=ticket2%>"/>
<%			
	 		found = credito.existe();
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#2 (<%=ticket2%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<% 				harta = 0;
			}
			else if(found == 1){
			  	double pagado = credito.obtenVentasTicket();
			 	pago2 = pagado+"";
 				totalpagado = totalpagado + pagado; 
			}
			else if(found == 2){ %>
				<b class="roj"> OJO: El Ticket#2 (<%=ticket2%>) esta registrado en el Sistema como ya Pagado.</b> <br/>
				Cheque en Corte Diario.<br />
<%
				harta = 0;				
			}
			else if(found == 3){ %>
				<b class="roj"> OJO: El Ticket#2 (<%=ticket2%>) esta registrado en el Sistema como ya asignado a Cr&eacute;dito.</b> <br/>
				Cheque en Cr&eacute;ditos.<br />
<%
				harta = 0;
			}								
		}
		
// RUTINA PARA TICKET 3:

		if(!(ticket3.length() == 0)){
%>			
<jsp:setProperty name="credito" property="numTicket" value="<%=ticket3%>"/>
<%			
			found = credito.existe();
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#3 (<%=ticket3%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<% 				harta = 0;
			}
			else if(found == 1){
			  	double pagado = credito.obtenVentasTicket();
			 	pago3 = pagado+"";
 				totalpagado = totalpagado + pagado; 
			}
			else if(found == 2){ %>
				<b class="roj"> OJO: El Ticket#3 (<%=ticket3%>) esta registrado en el Sistema como ya Pagado.</b> <br/>
				Cheque en Corte Diario.<br />
<%
				harta = 0;				
			}
			else if(found == 3){ %>
				<b class="roj"> OJO: El Ticket#3 (<%=ticket3%>) esta registrado en el Sistema como ya asignado a Cr&eacute;dito.</b> <br/>
				Cheque en Cr&eacute;ditos.<br />
<%
				harta = 0;
			}								
		}

// RUTINA TICKET 4

		if(!(ticket4.length() == 0)){
%>			
<jsp:setProperty name="credito" property="numTicket" value="<%=ticket4%>"/>
<%			
			found = credito.existe();
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#4 (<%=ticket4%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<% 				harta = 0;
			}
			else if(found == 1){
			  	double pagado = credito.obtenVentasTicket();
			 	pago4 = pagado+"";
 				totalpagado = totalpagado + pagado; 
			}
			else if(found == 2){ %>
				<b class="roj"> OJO: El Ticket#4 (<%=ticket4%>) esta registrado en el Sistema como ya Pagado.</b> <br/>
				Cheque en Corte Diario.<br />
<%
				harta = 0;				
			}
			else if(found == 3){ %>
				<b class="roj"> OJO: El Ticket#4 (<%=ticket4%>) esta registrado en el Sistema como ya asignado a Cr&eacute;dito.</b> <br/>
				Cheque en Cr&eacute;ditos.<br />
<%
				harta = 0;
			}								
		}

// RUTINA TICKET 5:

		if(!(ticket5.length() == 0)){
%>			
<jsp:setProperty name="credito" property="numTicket" value="<%=ticket5%>"/>
<%			
			found = credito.existe();
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#5 (<%=ticket5%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<% 				harta = 0;
			}
			else if(found == 1){
			  	double pagado = credito.obtenVentasTicket();
			 	pago5 = pagado+"";
 				totalpagado = totalpagado + pagado; 
			}
			else if(found == 2){ %>
				<b class="roj"> OJO: El Ticket#5 (<%=ticket5%>) esta registrado en el Sistema como ya Pagado.</b> <br/>
				Cheque en Corte Diario.<br />
<%
				harta = 0;				
			}
			else if(found == 3){ %>
				<b class="roj"> OJO: El Ticket#5 (<%=ticket5%>) esta registrado en el Sistema como ya asignado a Cr&eacute;dito.</b> <br/>
				Cheque en Cr&eacute;ditos.<br />
<%
				harta = 0;
			}								
		}

// SI TODO BIEN ENTONCES REDIRECCIONO A PAGO.JSP
		if(harta ==1){
			String pagados = totalpagado+"";
%>
	 <jsp:forward page="PagoCredito.jsp" > 
		<jsp:param name="rfc" value="<%=rfc%>" />
		<jsp:param name="nombreCliente" value="<%=nombreCliente%>" />
		<jsp:param name="pago1" value="<%=pago1 %>" />
		<jsp:param name="pago2" value="<%=pago2 %>" />
		<jsp:param name="pago3" value="<%=pago3 %>" />
		<jsp:param name="pago4" value="<%=pago4 %>" />
		<jsp:param name="pago5" value="<%=pago5 %>" />
		<jsp:param name="ticket1" value="<%=ticket1 %>" />
		<jsp:param name="ticket2" value="<%=ticket2 %>" />
		<jsp:param name="ticket3" value="<%=ticket3 %>" />
		<jsp:param name="ticket4" value="<%=ticket4 %>" />
		<jsp:param name="ticket5" value="<%=ticket5 %>" />	
		<jsp:param name="pagados" value="<%=pagados %>" />
		<jsp:param name="fecha" value="<%=fecha %>" />
	</jsp:forward>

 <% 			
		}
		else{
%>
	<form name="form2" method="post" action="Existe_TicketCredito.jsp">
		<input type="hidden" name="nombre" value="<%=nombreCliente%>">
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<p>	<input name="Regresar" type="submit" id="Regresar" value="Volver"></p>
	</form>
<%
		}
	}
%>	
<p><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
