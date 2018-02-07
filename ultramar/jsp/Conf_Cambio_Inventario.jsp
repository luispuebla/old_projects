<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp"%>

<jsp:useBean id="inv" class="com.ult.bd.ManagerInventarios" />

<html>
<head>
<title>Inventarios Agregado</title>
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
<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String[] clavetodos = (String[])request.getParameterValues("clave");
	String[] invtodos = (String[])request.getParameterValues("nuevaE");
	String[] tipos = (String[])request.getParameterValues("tip");
	int todobien = 0;
	for (int i=0;i<clavetodos.length;i++) {
		//System.out.println("clave "+clavetodos[i]+"cantidad "+invtodos[i]);
		if(!invtodos[i].equalsIgnoreCase("")){
			//System.out.println("adentro");
			todobien = todobien + inv.update_Inventarios(clavetodos[i],invtodos[i],tipos[i]);
		}
	}
	if(todobien == 0){
%>
				<jsp:forward page="Menu_Inventarios.jsp" />
<% }
else{%>
<b class="roj">Existió un problema al momento de Actualizar los Inventarios.</b>
<%}%>
<p><a href="Menu_Inventarios.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('APadres','','imagenes/regr.gif',1)">
<img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
