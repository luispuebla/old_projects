<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" session = "true" %>
<jsp:useBean id="factura" class="com.alpha.bd.ManagerFacturacion" scope="page" />
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page"/>

<html>
<head>
<title>Existencia del Ticket</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
 	String usuariou = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuariou == null || (!tipou.equalsIgnoreCase("administrador") &&!tipou.equalsIgnoreCase("simple")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String fecha1 = request.getParameter("fecha1");
	String fecha2 = request.getParameter("fecha2");
	String fecha3 = request.getParameter("fecha3");
	String fecha4 = request.getParameter("fecha4");
	String fecha5 = request.getParameter("fecha5");
	String ticket1 = request.getParameter("ticket1").trim();
	String ticket2 = request.getParameter("ticket2").trim();
	String ticket3 = request.getParameter("ticket3").trim();
	String ticket4 = request.getParameter("ticket4").trim();
	String ticket5 = request.getParameter("ticket5").trim();
	String rfc = request.getParameter("rfc");
	String nombre = request.getParameter("nombre");
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
	if (ticket1.equals("") && ticket2.equals("") && ticket3.equals("") && ticket4.equals("") && ticket5.equals("")){
%>	
		<b class="roj">Debes llenar por lo menos un campo de Ticket.</b>
		<form name="form1" method="post" action="Solicitud_Factura_En.jsp">
			<input type="hidden" name="nombre" value="<%=nombre%>">
			<input type="hidden" name="elRFC" value="<%=rfc%>">
			<div align="center"> <input name="Regresar" type="submit" id="Regresar" value="Volver"> </div>
		</form>
<p align="center">&nbsp;</p>
<% 
	}	
// AHORA VERIFICO QUE DONDE ME DIERON TICKETS NO ME ESTEN REPITIENDO NINGUNO:
	else if(tic1 == tic2 || tic1 == tic3 || tic1 == tic4 || tic1 == tic5 || tic2 == tic3 || tic2 == tic4 || tic2 == tic5 || tic3 == tic4 || tic3 == tic5 || tic4 == tic5){
%>	
			<br /><b class="roj">Se detect&oacute; al menos una repetici&oacute;n de ticket en la lista, verifiquelo.<br/></b>
		<form name="form1" method="post" action="Solicitud_Factura_En.jsp">
			<input type="hidden" name="nombre" value="<%=nombre%>">
			<input type="hidden" name="elRFC" value="<%=rfc%>">
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
			%><br />Ticket5 --> <%=tic5%>.<br/> <%		
		}%>
		<p> <input name="Regresar" type="submit" id="Regresar" value="Volver"> </p>
	</form>			
<%		
	}			
	else {
	// CHECO QUE EXISTAN LOS TICKET Y ESTEN YA PAGADOS A CRÉDITO O AL CONTADO.
	int pagado = 0;
	if(ticket1.length() != 0){
		boolean Eticket1 = factura.existeTicket(ticket1, fecha1);
		if(!Eticket1){
			pagado = pagado+1;
		}	
	}
	if(ticket2.length() != 0){
		boolean Eticket2 = factura.existeTicket(ticket2, fecha2);
		if(!Eticket2){
			pagado = pagado+10;
		}
	}
	if(ticket3.length() != 0){	
		boolean Eticket3 = factura.existeTicket(ticket3, fecha3);
		if(!Eticket3){
			pagado = pagado+100;
		}
	}
	if(ticket4.length() != 0){	
		boolean Eticket4 = factura.existeTicket(ticket4, fecha4);
		if(!Eticket4){
			pagado = pagado+1000;
		}
	}
	if(ticket5.length() != 0){	
		boolean Eticket5 = factura.existeTicket(ticket5, fecha5);
		if(!Eticket5){
			pagado = pagado+10000;
		}
	}
	if(pagado != 0) {
		if(pagado >= 10000){
			%><b class="roj">El Ticket#5 (<%=ticket5%>) No existe o la fecha es erronea.</b> <br /> <%
			pagado = pagado -10000;
		}
		if(pagado >= 1000){
			%><b class="roj">El Ticket#4 (<%=ticket4%>) No existe o la fecha es erronea.</b> <br /> <%
			pagado = pagado - 1000;
		}
		if (pagado >=100){
			%><b class="roj">El Ticket#3 (<%=ticket3%>) No existe o la fecha es erronea.</b> <br /> <%
			pagado = pagado - 100;		
		}
		if(pagado >= 10){
			%><b class="roj">El Ticket#2 (<%=ticket2%>) No existe o la fecha es erronea.</b> <br /> <%
			pagado = pagado - 10;
		}
		if (pagado >=1){
			%><b class="roj">El Ticket#1 (<%=ticket1%>) No existe o la fecha es erronea.</b> <br /> <%
		}
%>
<!-- ESTOS 3 PARAMETROS LOS ENVIO DE REGRESO PARA QUE PUEDA MODIFICAR EL NUMERO DE TICKET SIN NECESIDAD DE COMENZAR DE NUEVO EL PROCESO -->
	<form name="form1" method="post" action="Solicitud_Factura_En.jsp">
		<input type="hidden" name="nombre" value="<%=nombre%>">
		<input type="hidden" name="elRFC" value="<%=rfc%>">
		<div align="center"> <input name="Regresar" type="submit" id="Regresar" value="Volver"> </div>
	</form>
<p align="center">
  <% 
		} 
		else{
			// CHECO QUE NO SE ENCUENTREN FACTURADOS PREVIAMENTE.
			int facturado = 0;
			if(ticket1.length() != 0){
				boolean Eticket1 = factura.existeFacturaPrevia(ticket1, fecha1);
				if(Eticket1){
					facturado = facturado+1;
				}	
			}
			if(ticket2.length() != 0){
				boolean Eticket2 = factura.existeFacturaPrevia(ticket2, fecha2);
				if(Eticket2){
					facturado = facturado+10;
				}
			}
			if(ticket3.length() != 0){	
				boolean Eticket3 = factura.existeFacturaPrevia(ticket3, fecha3);
				if(Eticket3){
					facturado = facturado+100;
				}
			}
			if(ticket4.length() != 0){	
				boolean Eticket4 = factura.existeFacturaPrevia(ticket4, fecha4);
				if(Eticket4){
					facturado = facturado+1000;
				}
			}
			if(ticket5.length() != 0){	
				boolean Eticket5 = factura.existeFacturaPrevia(ticket5, fecha5);
				if(Eticket5){
					facturado = facturado+10000;
				}
			}
			if(facturado != 0) {
				if(facturado >= 10000){
					%>
  <b class="roj">No se puede continuar, El Ticket#5 (<%=ticket5%>) ya esta facturado, hay que darlo de baja.</b> <br /> 
  <%
					facturado = facturado -10000;
				}
				if(facturado >= 1000){
					%>
  <b class="roj">No se puede continuar, El Ticket#4 (<%=ticket4%>) ya esta facturado, hay que darlo de baja.</b> <br /> 
  <%
					facturado = facturado - 1000;
				}
				if (facturado >=100){
					%>
  <b class="roj">No se puede continuar, El Ticket#3 (<%=ticket3%>) ya esta facturado, hay que darlo de baja.</b> <br /> 
  <%
					facturado = facturado - 100;		
				}
				if(facturado >= 10){
					%>
  <b class="roj">No se puede continuar, El Ticket#2 (<%=ticket2%>) ya esta facturado, hay que darlo de baja.</b> <br /> 
  <%
					facturado = facturado - 10;
				}
				if (facturado >=1){
					%>
  <b class="roj">No se puede continuar, El Ticket#1 (<%=ticket1%>) ya esta facturado, hay que darlo de baja.</b> <br /> 
  <%				}				
%>
  <!-- ESTOS 3 PARAMETROS LOS ENVIO DE REGRESO PARA QUE PUEDA MODIFICAR EL NUMERO DE TICKET SIN NECESIDAD DE COMENZAR DE NUEVO EL PROCESO -->
</p> 
<form name="form1" method="post" action="Solicitud_Factura_En.jsp">	
	<input type="hidden" name="nombre" value="<%=nombre%>">
	<input type="hidden" name="elRFC" value="<%=rfc%>">
	<div align="center"> <input name="Regresar" type="submit" id="Regresar" value="Volver"> </div>
</form>
<%				
			}
			else{
				// TODO BIEN!, continuamos...
%>			
				<jsp:forward page="Alta_Factura.jsp">					
					<jsp:param name="ticket1" value="<%=ticket1%>" />
					<jsp:param name="ticket2" value="<%=ticket2%>" />
					<jsp:param name="ticket3" value="<%=ticket3%>" />
					<jsp:param name="ticket4" value="<%=ticket4%>" />
					<jsp:param name="ticket5" value="<%=ticket5%>" />
					<jsp:param name="fecha1" value="<%=fecha1%>" />
					<jsp:param name="fecha2" value="<%=fecha2%>" />
					<jsp:param name="fecha3" value="<%=fecha3%>" />
					<jsp:param name="fecha4" value="<%=fecha4%>" />
					<jsp:param name="fecha5" value="<%=fecha5%>" />
					<jsp:param name="rfc" value="<%=rfc%>" />
					<jsp:param name="nombre" value="<%=nombre%>" />
				</jsp:forward>
<%
			} 
		}
	}
%>
<p align="center"><a href="Menu_FacturasV.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
 
</body>
</html>
