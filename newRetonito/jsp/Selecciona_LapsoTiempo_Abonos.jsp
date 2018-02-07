<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Selecci&oacute;n de Cliente/Periodo para Abono</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
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

function OnSubmitForm(){
	var encontro = false;
	var fecha = new Date();
	var fecha2 = new Date();
	var fechaInicio = new String();
	var fechaFin = new String();
	var temporal = "";
	fechaInicio = document.calform.datebox.value;
	fechaFin = document.calform.datebox2.value;
	kiko = fechaInicio.substring(3,5);
	if (kiko.charAt(0) == "0"){
		kiko = kiko.substring(1,kiko.length);
	}
	fecha.setDate(kiko);
	kiko = fechaInicio.substring(0,2);
	if (kiko.charAt(0) == "0"){
		kiko = kiko.substring(1,kiko.length);
	}	
	var copia = new Number();
	copia = kiko;
	fecha.setMonth(copia -1);
	fecha.setYear(fechaInicio.substring(6,fechaInicio.length));
	kiko = fechaFin.substring(3,5);
	if (kiko.charAt(0) == "0"){
		kiko = kiko.substring(1,kiko.length);
	}
	fecha2.setDate(kiko);
	kiko = fechaFin.substring(0,2);
	if (kiko.charAt(0) == "0"){
		kiko = kiko.substring(1,kiko.length);
	}	
	var copia = new Number();
	copia = kiko;
	fecha2.setMonth(copia -1);
	fecha2.setYear(fechaFin.substring(6,fechaFin.length));
	if(fecha > fecha2){
		alert("La Fecha de Inicio no puede ser mayor que la Fecha Final.");
	}
	else{
		encontro = true;
		document.calform.action ="AbonosXClienteXTiempo.jsp";				
	}
	return encontro;
}


function setFecha(){
	var fechaHoy = new Date();
	var mesHoy = new String();
	var anioHoy = new String();
	var diaHoy = new String();
	var ndiaHoy =  new Number();
	var nmesHoy = new Number();		
	nmesHoy = (fechaHoy.getMonth()+1);
	anioHoy = (fechaHoy.getYear());
	ndiaHoy = (fechaHoy.getDate());
	diaHoy = ndiaHoy +"";
	mesHoy = nmesHoy +"";
	if(diaHoy.length==1){
		diaHoy = "0"+diaHoy;
	}
	if(mesHoy.length==1){
		mesHoy = "0"+mesHoy;
	}
	document.calform.datebox.value=mesHoy+"/"+diaHoy+"/"+anioHoy;
	document.calform.datebox2.value=mesHoy+"/"+diaHoy+"/"+anioHoy;
}

//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	ResultSet rs = ticket.dameClientesConAbonos();
%>
<body onLoad="setFecha()">
<h1>Selecciona el cliente y el lapso de tiempo para<br /> 
  mostrar sus abonos realizados </h1>
  <form name="calform" method="post" onSubmit="return OnSubmitForm()">  
  <br />
  	<table width="500" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
		<th>Clientes con Abonos:</th>
		<td>
		  <select name="clienteAbonar">
		    <option value="ToDoS" selected>TODOS</option>
<% 			while(rs.next()){ %>
			<option value="<%=rs.getString("rfc")%>%!%<%=rs.getString("nombreCliente")%>"><%=rs.getString("nombreCliente")%> (<%=rs.getString("rfc")%>)</option>
<%			} 
			rs.close();
			ticket.cierraConexion();%>
		  </select>
		</td>
	  </tr>
	</table>
  <br />	
	<table width="300" border="1">
	 <caption>Rango de Fechas:</caption>
	  <tr> 
		<th>Inicio:</th>
		<td><div align="center">
		  <input type=text name="datebox" size=15 readonly="true"> 
		  <a href="javascript:show_calendar('calform.datebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"> <img src="imagenes/show-calendar.gif" width=24 height=22 border=0 align="absmiddle"></a> 
	    </div></td>
	  </tr>
	  <tr> 
		<th>Final:</th>
		<td><div align="center">
		  <input type=text name="datebox2" size=15 readonly="true">
		  <a href="javascript:show_calendar('calform.datebox2');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"> <img src="imagenes/show-calendar.gif" width=24 height=22 border=0 align="absmiddle"></a>
	    </div></td>
	  </tr>
	</table>
<p align="center">
    <input type="submit" name="Submit" value="Enviar">
</p>
</form>
<p align="center"><a href="Menu_Consul_Ventas.jsp" target="_self"  onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" 
onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
