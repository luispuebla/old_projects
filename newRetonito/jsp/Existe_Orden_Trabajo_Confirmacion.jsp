<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />

<html>
<head>
<title>Baja de Orden de Trabajo</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MandaSubmit(f){	
	f.submit();
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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

function funcionFoco(){
	document.form1.clave.focus();
}
//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'), funcionFoco()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<p>&nbsp;</p>
<form name="form1" method="post" action="Confirmacion_Orden_Trabajo.jsp">
<h1>Selecciona la Órden de Trabajo a Confirmar.</h1>
<table width="608" border="1" align="center" cellpadding="0" cellspacing="0">
 <caption>&Oacute;rdenes de Trabajo Activas (Sin confirmar)</caption>
  <tr> 
	<th>Clave</th>
	<th>Fecha Alta</th>
	<th>Usuario Alta</th>		
  </tr>
<% ResultSet rs = alProd.dameOrdenesTrabajoActivos();
	while (rs.next()){   %>
  <tr>
  	<td><div align="center"><input type="radio" name="clave" value="<%= rs.getString("clave")%>" onClick="MandaSubmit(document.forms[0])"> &nbsp;<%=rs.getString("clave")%></div></td>
  	<td><div align="center"><%=rs.getString("fechaAlta")%></div></td>
  	<td><div align="center"><%=rs.getString("usuarioAlta")%></div></td>		
  </tr>
<%	}
	rs.close();
	alProd.cierraConexion();  %>
</table>
<p>
          <input type="reset" name="Borrar" value="Borrar">
          <input type="submit" name="Submit" value="Enviar">			
</p>
</form>
<p align="center"><a href="Menu_Ordenes_Trabajo.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
