<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" scope="page"/>

<html>
<head>
<title>Selecciona Semana Prestamo</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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

function MandaSubmit(f){	
	f.submit();
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
	if(document.form1 != null){
		document.form2.Enviar.focus();
	}
}

//-->
</script>
</head>
<%
 	String usuarioS = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuarioS == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String fechaHoy = empleado.dameFechaHoyFBD();
	String anio = fechaHoy.substring(0,4);
	if(request.getParameter("anio") != null){
		anio = request.getParameter("anio");
	}
	String semanita = empleado.semanaCorrespondienteADia(empleado.dameFechaHoyFBD(), anio)+"";
%>
<body  onLoad="funcionFoco(), MM_preloadImages('imagenes/Regresar2.jpg')" >
<%	
	Vector <String> semanas = empleado.semanasDelAnio(anio);
%>
<h1>El año y semana para desplegar los pr&eacute;stamos correspondientes:</h1>
<form action="Selecciona_Semana_Prestamos.jsp" target="_self" method="post" name="form1">
<table align="center" width="600" cellpadding="0" cellspacing="0" border="1">
  <caption>
    Selecciona a&ntilde;o y Semana para mostrar Todos los pr&eacute;stamos otorgados:
  </caption>
  <tr>
  	<th width="155">A&ntilde;o:</th>
	<td width="439"><div align="center">
	  <select name="anio" onChange="MandaSubmit(document.forms[0])">
		    <option value="2007" <%if (anio.equals("2007")){%> selected <%}%>>2007</option>
		    <option value="2008" <%if (anio.equals("2008")){%> selected <%}%>>2008</option>
		    <option value="2009" <%if (anio.equals("2009")){%> selected <%}%>>2009</option>
		    <option value="2010" <%if (anio.equals("2010")){%> selected <%}%>>2010</option>
		    <option value="2011" <%if (anio.equals("2011")){%> selected <%}%>>2011</option>
		    <option value="2012" <%if (anio.equals("2012")){%> selected <%}%>>2012</option>
		    <option value="2013" <%if (anio.equals("2013")){%> selected <%}%>>2013</option>
		    <option value="2014" <%if (anio.equals("2014")){%> selected <%}%>>2014</option>
		    <option value="2015" <%if (anio.equals("2015")){%> selected <%}%>>2015</option>
		    <option value="2016" <%if (anio.equals("2016")){%> selected <%}%>>2016</option>
		    <option value="2017" <%if (anio.equals("2017")){%> selected <%}%>>2017</option>
		    <option value="2018" <%if (anio.equals("2018")){%> selected <%}%>>2018</option>
		    <option value="2019" <%if (anio.equals("2019")){%> selected <%}%>>2019</option>
		    <option value="2020" <%if (anio.equals("2020")){%> selected <%}%>>2020</option>										
	    </select>
	  </div></td>
  </tr>	
</table>  
</form>  
<form action="Muetra_Prestamos_Semana.jsp" target="_self" method="post" name="form2">
<table align="center" width="600" cellpadding="0" cellspacing="0" border="1">
  <tr>
  	<th width="155">Semana:</th>
	<td width="439"><div align="center">
	  <select name="semana">
	    <% for(int i = 0; i<semanas.size(); i++){%>		
		    <option value="<%=semanas.elementAt(i)%>" <% i++; if (semanita.equals(semanas.elementAt(i))){%> selected <%}%>>
		    <%i++;%>
		    <%=semanas.elementAt(i)%></option>		
            <%		} %>
	    </select>
	  </div></td>
  </tr>
</table>
<p><input type="submit" name="Enviar" value="Enviar"></p>
</form>
<p><a href="Menu_Prestamos_Nominas.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>	
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>