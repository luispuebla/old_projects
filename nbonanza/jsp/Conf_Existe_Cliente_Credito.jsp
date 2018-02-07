<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" session = "true"%>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" />

<html>
<head>
<title>Existencia del Cliente</title>
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
<p>&nbsp; </p>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	} 
	String nombre = request.getParameter("nombre"); 
    String rfc = request.getParameter("rfc"); 
	if(nombre == null){
%>
	<form name="form2" method="post" action="Escoge_Cliente_Credito.jsp">
		<p><b class="roj">No se selecciono ningún cliente de la lista</b></p>
		<input type="hidden" name="rfc" value="<%=rfc%>">
		<input type="submit" name="Regresar" value="Regresar">
	</form>
<%		
	}
	else{
		int found= 0;
		found = cliente.existeClienteDeCreditoSinBloqueo(rfc, nombre);
		if(found == 0) {
%>		
			<p><b class="roj">El Cliente no esta registrado con Crédito, cambia su Tipo para Continuar.</b></p>
<%
		}
		else if(found == 2){
%>		
			<p><b class="roj">El Estatus Actual del Cliente Seleccionado es de Bloqueado, tiene saldos vencidos.</b></p>		
<%
		}
		else {
%>
			 <jsp:forward page="Existe_TicketCredito.jsp"> 
			 	<jsp:param name="nombre" value="<%=nombre %>" />
				<jsp:param name="rfc" value="<%=rfc %>" />
			</jsp:forward>	
<%		
		}
	}
%>
<p align="center"><a href="Existe_Cliente_Credito.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
