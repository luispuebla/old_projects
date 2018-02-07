<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %> 
<jsp:useBean id="data" class="com.ult.bd.ManagerConsultas" />
<html>
<head>
<title>Selección de Cortesias por Comanda</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
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
//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/regr.gif')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipoU = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipoU.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

   String mesa = request.getParameter("mesa").trim();
   String nombreOriginal = "";
   if(mesa.length() <= 0){ %>
	<h1>Debes introducir una Mesa.</h1>
   <% }
  else{
	nombreOriginal = mesa;
  	if(mesa.equalsIgnoreCase("B1")){
		mesa = "25";
	}
	else if(mesa.equalsIgnoreCase("B2")){
		mesa = "26";
	}
	else if(mesa.equalsIgnoreCase("B3")){
		mesa = "27";
	}
	else if(mesa.equalsIgnoreCase("B4")){
		mesa = "28";
	}
	else if(mesa.equalsIgnoreCase("B5")){
		mesa = "29";
	}
	boolean tiene = data.tieneComanda(mesa);
    if(tiene){
		int comanda = data.dameComanda(mesa);
		int comensales = data.dameComensales(comanda+"");
%>
<h1>Asigna un descuento para la mesa: <%=nombreOriginal%> por cada comensal </h1>
<form name="form1" method="post" action="Conf_Asigna_Descuento.jsp">
<input type="hidden" name="comanda" value="<%=comanda%>">
<input type="hidden" name="numComensales" value="<%=comensales%>">
	<table width="450" border="1">
	  <tr>
	  	<th>Comensal #</th>
	  	<th>Descuento(%) 0 - 100</th>		
	  </tr>
<%
	for(int i= 1; i<=comensales; i++){
%>	
	  <tr>
	  	<td><div align="center"><strong><%=i%></strong></div></td>
	  	<td><div align="center">
	  	  <input type="text" maxlength="3" size="5" name="descuento<%=i%>" value="0" onKeyPress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" >
	  	  %</div></td>
	  </tr>
<%	
	}
%>
	</table>
<input type="submit" name="Submit" value="Guardar">
<input type="reset" name="Submit2" value="Limpiar Forma">
</form>
<%
	}else{ %>
<h1>Esa mesa no tiene Asignada una Comanda en curso.</h1>
<% } }%>
<p><a href="Dame_Mesa_Descuento.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>
