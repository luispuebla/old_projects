<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="co" class="com.ult.bd.ManagerCobros" />
<jsp:useBean id="cli" class="com.ult.bd.ManagerClientes" />

<html>
<head>
<title>Factura Agregada</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
	f.submit();
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
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = request.getParameter("rfc");
	String factura = request.getParameter("factura");
	String[] cobro = (String[])request.getParameterValues("cobro");
	String comanda = request.getParameter("comanda");
	double monto = co.dameMonto(cobro);
	int resultado = -1;
	// Verifico que exista cliente:
	if(cli.existe(rfc)){ 
		// Verifico que el numero de comanda no este repetido.
		if(!co.existe(factura)){ 
			resultado = co.add_Factura( rfc, factura, cobro, comanda);
			// 1 OK , 2 ERROR, 3 NO HAY CONEXION.		
			if(resultado == 2 || resultado == 3){%>
				<b class="roj">Sucedio un Error al Almacenar la informaci&oacute;n en la Base de Datos.</b>
				<br/>No se pudo guardar la factura. Vuelva a Intentarlo.
<%			}
			else { %>
			<form action="Imprimir_Factura.jsp" method="post" target="_blank">
			<input type="hidden" name="rfc" value="<%=rfc%>">
			<input type="hidden" name="total" value="<%=monto+""%>">
				La Factura fue almacenado correctamente, de un click en Imprimir para imprimir la Factura.
	<p align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOver="MM_swapImage('impri','','imagenes/Imprimir2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Imprimir1.jpg" name="impri" width="152" height="36" border="0"></a>			
	</p>
			</form>
				
<%			}
		}
		else{%>
			<b class="roj">Ya tengo una Factura Registrada con el Folio: <%=factura%></b>	
			<br/>Para escribir otro Folio presiona el boton de Volver.
			<form name="retache" target="_self" method="post" action="FacturaXCobro.jsp">
				<input type="hidden" name="comanda" value="<%=comanda%>">
				<input type="hidden" name="rfc" value="<%=rfc%>">
				<%	for (int i=0; i<cobro.length; i++){%>
					<input type="hidden" name="cobro" value="<%=cobro[i]%>">
				<%	} %>		
			<p align="center"><input type="submit" value="Volver" name="Volver"></p>
			</form>		
<%		}
	}
	else{ %>		
		<b class="roj">No tengo un cliente registrado con el RFC = "<%=rfc.toUpperCase()%>"</b>	
		<br/>Para escribir otro RFC presiona el boton de Volver.
		<form name="retache" target="_self" method="post" action="FacturaXCobro.jsp">
			<input type="hidden" name="comanda" value="<%=comanda%>">
			<%	for (int i=0; i<cobro.length; i++){%>
				<input type="hidden" name="cobro" value="<%=cobro[i]%>">
			<%	} %>		
		<p align="center"><input type="submit" value="Volver" name="Volver"></p>
		</form>
<%	} %>
	
<p><a href="Menu_Facturas.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

