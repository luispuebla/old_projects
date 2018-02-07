<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="pa" class="com.alpha.bd.ManagerPagos" />

<html>
<head>
<title>Pago Agregado</title>
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
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String cheque = "";	
	String formaPago = request.getParameter("formaPago");
	if(formaPago.equals("2")){
		cheque = request.getParameter("cheque");
	}
	String importe = request.getParameter("importe");
	String datebox = request.getParameter("datebox");
	String ClaveOrden = request.getParameter("ClaveOrden");
	String proveedor = request.getParameter("proveedor");
	String total = request.getParameter("porPagar");	
	String mes = datebox.substring(0,2);
	String dia = datebox.substring(3,5);
	String ano = datebox.substring(6,10);
	String fecha = ano+"-"+mes+"-"+dia;
	int resultado = 0;
	if(pa.cambiaADouble(total) < pa.cambiaADouble(importe)){
%>
		<b class="roj">El importe que especificas (<%=importe%>) sobrepasa el Faltante a Cubrir (<%=total%>)</b>
		<form name="retache" method="post" target="_self" action="Pago_Compra.jsp">
			<input type="hidden" name="claveOrden" value="<%=ClaveOrden%>">
			<input type="hidden" name="proveedor" value="<%=proveedor%>">
			<p><input type="submit" value="Reingresar" name="Reingresar"></p>
		</form>
<%		
	}
	else {
		resultado = pa.add_Pago(ClaveOrden, proveedor, fecha, importe, formaPago, cheque, total, usuario);
		if(resultado == 0){
%>
				<jsp:forward page="Menu_Pagos.jsp" />
<% 
		}
		else if(resultado == 1){  %>
		<b class="roj">Pago Cancelado, el importe que especificas (<%=importe%>) sobrepasa el Faltante a Cubrir</b>
<%		} else if(resultado == 3){  %>
			<b class="roj">Ocurrio un Error al Guardar en la Base de Datos vuelva a Intentarlo</b>
			<p>&nbsp;</p>
<%		}
 } %>			
<p><a href="Menu_Pagos.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

