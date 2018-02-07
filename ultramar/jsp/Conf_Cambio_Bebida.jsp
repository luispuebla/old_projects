<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="beb" class="com.ult.bd.ManagerBebidas" />

<html>
<head>
<title>Bebida Cambiada</title>
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


//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String clave = request.getParameter("clave");
	String nombre = request.getParameter("nombre");
	String descripcion = request.getParameter("descripcion");
	String m1 = request.getParameter("m1");
	String c1 = request.getParameter("c1");
	String m2 = request.getParameter("m2");
	String c2 = request.getParameter("c2");
	String m3 = request.getParameter("m3");
	String c3 = request.getParameter("c3");
	String m4 = request.getParameter("m4");
	String c4 = request.getParameter("c4");
	String m5 = request.getParameter("m5");
	String c5 = request.getParameter("c5");
	String m6 = request.getParameter("m6");
	String c6 = request.getParameter("c6");
	String m7 = request.getParameter("m7");
	String c7 = request.getParameter("c7");
	String m8 = request.getParameter("m8");
	String c8 = request.getParameter("c8");
	String m9 = request.getParameter("m9");
	String c9 = request.getParameter("c9");
	String m10 = request.getParameter("m10");
	String c10 = request.getParameter("c10");
	String precioC = request.getParameter("precioC");
	String precioB = request.getParameter("precioB");
	String precioB2 = request.getParameter("precioB2");
	String division = request.getParameter("division");
	String alco = request.getParameter("alco");
	String combi = request.getParameter("combinable");
	String dimen = request.getParameter("dimensionable");
	// Si llenado = 1 OK, llenado = 2 FALTO 1 CAMPO POR LLENAR;  llenado = 3 MAL FORMATO DEL DOUBLE.

	boolean resultado = false;

	int llenado = 0;
	llenado = beb.valida_add(nombre, m1, c1, precioC, division);
//System.out.println("agente 1 "+agente);
	if (llenado==1){
		resultado = beb.update_bebida( clave, nombre, descripcion, m1, c1, m2, c2, m3, c3, m4, c4, m5, c5, m6, c6, m7, c7, m8, c8, m9, c9, m10, c10, precioC, precioB, precioB2, division,alco,combi,dimen);
		if(resultado){
%>
		<jsp:forward page="Menu_Bebidas.jsp" />
<% 
		}
		else{  %>
		<b class="roj">Ocurrio un Error al Guardar en la Base de Datos</b>		
<p>&nbsp;</p>
<p><a href="Selecciona_Division_BebidaC.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
		<% 
		} 
	} 
	else if (llenado == 2){ 
%>	
	<b class="roj">Se Deben llenar los campos </b>	

<p>&nbsp;</p>
<p><a href="Selecciona_Division_BebidaC.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)">
<img src="imagenes/Regresar1.jpg" name="APadres" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
<%
	} 
%>
</body>
</html>
