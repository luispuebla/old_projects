<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />

<html>
<head>
<title>Confirmaci&oacute;n de modificaciones del Cliente</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
<p>&nbsp;</p>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = request.getParameter("rfc");
	String nombre = request.getParameter("nombre");
	String direccion = request.getParameter("direccion");
	String colonia = request.getParameter("colonia");
	String delegacion = request.getParameter("delegacion");
	String cp = request.getParameter("cp");
	String ciudad = request.getParameter("ciudad");
	String tipo = request.getParameter("tipo");
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String fax = request.getParameter("fax");
	String email = request.getParameter("email");
	String diaCierran = request.getParameter("diaCierran");
	String horaComida = request.getParameter("horaComida");
	String contacto = request.getParameter("contacto");
	String credito = request.getParameter("credito");
	String pagoA = request.getParameter("pagoA");
	String agente = request.getParameter("agente");
	boolean resultado = false;

	int llenado = cliente.valida_add(rfc, nombre, direccion, colonia, delegacion, cp, ciudad);
	
		if(llenado == 1) {
			resultado = cliente.update_Cliente(rfc, nombre, direccion, colonia, delegacion, cp, ciudad, tipo, tel1, tel2, fax, email, diaCierran, horaComida, contacto, credito, pagoA, agente);
			if(resultado){
%>
				<jsp:forward page="Menu_Clientes.jsp" />
<% 
			}
			else{  %>
				<b class="roj">Ocurrio un Error al Guardar en la Base de Datos</b>		
				<p>&nbsp;</p>
				<p><a href="Existe_Cliente_Cambio.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
				<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 

<%
			}
		}  
		if (llenado == 2){
%>	
			<b class="roj">Se Deben llenar todos los campos.</b>
			<p>&nbsp;</p>
			<p align="center"><a href="Existe_Cliente_Cambio.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()"  onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
			<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<%
		} 
%>	
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
	
