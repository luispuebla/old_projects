<%@ page language="java" import="java.sql.*, java.io.*, java.util.*"  %>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page"/>

<html>
<head>
<title>Validando Ticket</title>
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
	int tipot1 = 0;
	int tipot2 = 0;
	int tipot3 = 0;
	int tipot4 = 0;
	int tipot5 = 0;
	int tic1 = -1;
	int tic2 = -2;
	int tic3 = -3;
	int tic4 = -4;
	int tic5 = -5;
	if(!ticket1.trim().equals("")){
		tic1 = ticket.cambiaAInt(ticket1);
		if(tic1 == 0){
			tic1 = -1;
		}
	}
	if(!ticket2.trim().equals("")){
		tic2 = ticket.cambiaAInt(ticket2);
		if(tic2 == 0){
			tic2 = -2;
		}		
	}
	if(!ticket3.trim().equals("")){
		tic3 = ticket.cambiaAInt(ticket3);
		if(tic3 == 0){
			tic3 = -3;
		}		
	}
	if(!ticket4.trim().equals("")){
		tic4 = ticket.cambiaAInt(ticket4);
		if(tic4 == 0){
			tic1 = -4;
		}		
	}
	if(!ticket5.trim().equals("")){
		tic5 = ticket.cambiaAInt(ticket5);
		if(tic5 == 0){
			tic5 = -5;
		}		
	}	
	double totalpagado = 0;
	int found= 0;
	int harta = 1;
	// VOY A VERIFICAR QUE AL MENOS ME ENVIARAN 1 TICKET 
	if (ticket1.trim().equals("") && ticket2.trim().equals("") && ticket3.trim().equals("") && ticket4.trim().equals("") && ticket5.trim().equals("")){
%>		
			<p><b class="roj">Se debe especificar al menos un ticket.</b></p>
<% 
	}	
	
// AHORA VERIFICO QUE DONDE ME DIERON TICKETS NO ME ESTEN REPITIENDO NINGUNO:
	else if(tic1 == tic2 || tic1 == tic3 || tic1 == tic4 || tic1 == tic5 || tic2 == tic3 || tic2 == tic4 || tic2 == tic5 || tic3 == tic4 || tic3 == tic5 || tic4 == tic5){
%>	
			<br /><b class="roj">Se detect&oacute; al menos una repetici&oacute;n de ticket en la lista, verifiquelo.<br/></b>
<%		
		if(tic1 != -1){
			%><br />Ticket1 --> <%=tic1%>. <%
		}
		if(tic2 != -2){
			%><br />Ticket2 --> <%=tic2%>. <%		
		}
		if(tic3 != -3){
			%><br />Ticket3 --> <%=tic3%>. <%		
		}
		if(tic4 != -4){
			%><br />Ticket4 --> <%=tic4%>. <%		
		}
		if(tic5 != -5){
			%><br />Ticket5 --> <%=tic5%>. <%		
		}
	}		
	else { // Todo bien, checo que no esten ya pagados.
		if(!(ticket1.length() == 0)){
			found = ticket.existe(ticket1, fecha);
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#1 (<%=ticket1%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<%				harta = 0;
			}
			else if(found == 1){
				double pagado = ticket.datosTicketVenta(ticket1, fecha);
				tipot1=ticket.dameTipoTicket(ticket1, fecha);				
				if(tipot1 == 2){
					int estaPagado = ticket.yaEstabaPagadoCredito(ticket1, fecha);
					if (estaPagado == 1){ %>
						<b class="roj"> <br/>El Ticket#1 (<%=ticket1%>) ya fue Cobrado (fue dado a Cr&eacute;dito). </b> <br />
				<% 		harta = 0; 
					}					
				}
				if(pagado == 0.0){ %>
					<b class="roj"> OJO: No Hay Cantidad por Cobrar en Ticket#1 (<%=ticket1%>), ya fue Cobrado Previamente.</b> <br />
<%					harta = 0; 
				}
				else{
					pago1 = pagado+"";
					totalpagado = totalpagado + pagado; 
				}
			}
		}
// LO MISMO PARA TICKET 2
		if(!(ticket2.length() == 0)){
			found = ticket.existe(ticket2, fecha);
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#2 (<%=ticket2%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<%				harta = 0;
			}
			else if(found == 1){
				double pagado = ticket.datosTicketVenta(ticket2, fecha);
				tipot2=ticket.dameTipoTicket(ticket2, fecha);				
				if(tipot2 == 2){
					int estaPagado = ticket.yaEstabaPagadoCredito(ticket2, fecha);
					if (estaPagado == 1){ %>
						<b class="roj"> <br/>El Ticket#2 (<%=ticket2%>) ya fue Cobrado (fue dado a Cr&eacute;dito). </b> <br />
				<% 		harta = 0; 
					}					
				}
				if(pagado == 0.0){ %>
					<b class="roj"> OJO: No Hay Cantidad por Cobrar en Ticket#2 (<%=ticket2%>), ya fue Cobrado Previamente.</b> <br />
<%					harta = 0; 
				}
				else{
					pago2 = pagado+"";
					totalpagado = totalpagado + pagado; 
				}
			}
		}
// RUTINA PARA TICKET 3:
		if(!(ticket3.length() == 0)){
			found = ticket.existe(ticket3, fecha);
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#3 (<%=ticket3%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<%				harta = 0;
			}
			else if(found == 1){
				double pagado = ticket.datosTicketVenta(ticket3, fecha);
				tipot3=ticket.dameTipoTicket(ticket3, fecha);				
				if(tipot3 == 2){
					int estaPagado = ticket.yaEstabaPagadoCredito(ticket3, fecha);
					if (estaPagado == 1){ %>
						<b class="roj"> <br/>El Ticket#3 (<%=ticket3%>) ya fue Cobrado (fue dado a Cr&eacute;dito). </b> <br />
				<% 		harta = 0; 
					}					
				}
				if(pagado == 0.0){ %>
					<b class="roj"> OJO: No Hay Cantidad por Cobrar en Ticket#3 (<%=ticket3%>), ya fue Cobrado Previamente.</b> <br />
<%					harta = 0; 
				}
				else{
					pago3 = pagado+"";
					totalpagado = totalpagado + pagado; 
				}
			}
		}
// RUTINA TICKET 4
		if(!(ticket4.length() == 0)){
			found = ticket.existe(ticket4, fecha);
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#4 (<%=ticket4%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<%				harta = 0;
			}
			else if(found == 1){
				double pagado = ticket.datosTicketVenta(ticket4, fecha);
				tipot4=ticket.dameTipoTicket(ticket4, fecha);				
				if(tipot4 == 2){
					int estaPagado = ticket.yaEstabaPagadoCredito(ticket4, fecha);
					if (estaPagado == 1){ %>
						<b class="roj"> <br/>El Ticket#4 (<%=ticket4%>) ya fue Cobrado (fue dado a Cr&eacute;dito). </b> <br />
				<% 		harta = 0; 
					}					
				}
				if(pagado == 0.0){ %>
					<b class="roj"> OJO: No Hay Cantidad por Cobrar en Ticket#4 (<%=ticket4%>), ya fue Cobrado Previamente.</b> <br />
<%					harta = 0; 
				}
				else{
					pago4 = pagado+"";
					totalpagado = totalpagado + pagado; 
				}
			}
		}
// RUTINA TICKET 5:
		if(!(ticket5.length() == 0)){
			found = ticket.existe(ticket5, fecha);
			if(found == 0) { %>
				<br/><b class="roj"> OJO: El Ticket#5 (<%=ticket5%>) no esta registrado en el Sistema.</b><br/>
				Posibles Causas: <br/>
				1. Esta mal escrito el número del Ticket.<br/>
				2. La fecha no corresponde.<br/>
<%				harta = 0;
			}
			else if(found == 1){
				double pagado = ticket.datosTicketVenta(ticket5, fecha);
				tipot5=ticket.dameTipoTicket(ticket5, fecha);				
				if(tipot5 == 2){
					int estaPagado = ticket.yaEstabaPagadoCredito(ticket5, fecha);
					if (estaPagado == 1){ %>
						<b class="roj"> <br/>El Ticket#5 (<%=ticket5%>) ya fue Cobrado (fue dado a Cr&eacute;dito). </b> <br />
				<% 		harta = 0; 
					}					
				}
				if(pagado == 0.0){ %>
					<b class="roj"> OJO: No Hay Cantidad por Cobrar en Ticket#5 (<%=ticket5%>), ya fue Cobrado Previamente.</b> <br />
<%					harta = 0; 
				}
				else{
					pago5 = pagado+"";
					totalpagado = totalpagado + pagado; 
				}
			}
		}
// SI TODO BIEN ENTONCES REDIRECCIONO A PAGO.JSP
		if(harta ==1){
			String pagados = totalpagado+"";
			//response.sendRedirect("Pago.jsp");
%>
 <jsp:forward page="Pago.jsp" > 
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
	<jsp:param name="tipot1" value="<%=tipot1 %>" />
	<jsp:param name="tipot2" value="<%=tipot2 %>" />
	<jsp:param name="tipot3" value="<%=tipot3 %>" />
	<jsp:param name="tipot4" value="<%=tipot4 %>" />
	<jsp:param name="tipot5" value="<%=tipot5 %>" />	
	<jsp:param name="pagados" value="<%=pagados %>" />
	<jsp:param name="fecha" value="<%=fecha %>" />
</jsp:forward>

<% 			
		}	
	}
%>
<p align="center"> <a href="Existe_Ticket2.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar2','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar2" width="132" height="41" border="0"></a></p>
<p><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
