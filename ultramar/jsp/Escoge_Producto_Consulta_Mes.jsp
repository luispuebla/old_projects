<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pro" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />

<html>
<head>
<title>Selección Producto</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function setFecha(){
	var fechaHoy = new Date();
	var mesHoy = new String();
	var anioHoy = new String();
	var nmesHoy = new Number();		
	nmesHoy = (fechaHoy.getMonth()+1);
	anioHoy = (fechaHoy.getYear());
	mesHoy = nmesHoy +"";
	if(mesHoy.length==1){
		mesHoy = "0"+mesHoy;
	}
	document.form1.mes.value=mesHoy;
	document.form1.aaaa.value=anioHoy;
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

<!-- Begin
var NS4 = (document.layers);
var IE4 = (document.all);

var win = this;
var n   = 0;

function findInPage(str) {
var txt, i, found;
if (str == "")
return false;
if (NS4) {
if (!win.find(str))
while(win.find(str, false, true))
n++;
else
n++;
if (n == 0) alert(str + " no se encuentran coincidencias en esta pagina.");
}
if (IE4) {
txt = win.document.body.createTextRange();
for (i = 0; i <= n && (found = txt.findText(str)) != false; i++) {
txt.moveStart("character", 1);
txt.moveEnd("textedit");
}
if (found) {
txt.moveStart("character", -1);
txt.findText(str);
txt.select();
txt.scrollIntoView();
n++;
}
else {
if (n > 0) {
n = 0;
findInPage(str);
}
else
alert(str + " no se encuentran coincidencias en esta pagina.");
}
}
return false;
}
//  End -->
//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); setFecha()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>
<form name=search onSubmit="return findInPage(this.string.value);">
Buscar en la pagina:
<input name=string type=text size=15 onChange="n = 0;">
<input type="Submit" value="buscar">
</form>
<form name="form1" method="post" action="Producto_X_Mes.jsp">
 <table width="650" border="1" align="center">
  <caption>
  <br>
    <div align="center">
    <table width="200">
      <tr> 
        <td >Mes:</td>
        <td>
          <select name="mes">
            <option value="01">Enero</option>
            <option value="02">Febrero</option>
            <option value="03">Marzo</option>
            <option value="04">Abril</option>
            <option value="05">Mayo</option>
            <option value="06">Junio</option>
            <option value="07">Julio</option>
            <option value="08">Agosto</option>
            <option value="09">Septiembre</option>
            <option value="10">Octubre</option>
            <option value="11">Noviembre</option>
            <option value="12">Diciembre</option>
          </select>
        </td>
      </tr>
      <tr> 
        <td >A&ntilde;o:</td>
        <td>
          <select name="aaaa">
            <option value="2006">2006</option>
            <option value="2007">2007</option>
            <option value="2008">2008</option>
            <option value="2009">2009</option>
            <option value="2010">2010</option>
            <option value="2011">2011</option>
            <option value="2012">2012</option>
            <option value="2013">2013</option>
            <option value="2014">2014</option>
            <option value="2015">2015</option>
          </select>
        </td>	  
	  </tr>
    </table>
  </div>
  <br>
<%
	ResultSet productos = pro.dameMateriasPrimas();
%>	
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
	  	<th width="27">&nbsp;</th>
	  	<th width="114">Clave</th>
	  	<th width="114">Área</th>
		<th width="451">Nombre</th>
	  </tr>
	 </table>
	 <p></p>
<%
	while (productos.next()){
	String ti = productos.getString("tipo");
	String tia = productos.getString("tipoA");
	String noti = "";
	String notia = "";
	int dos = 0;
	String tib1 = "";
	String tib2 = "";
	if(ti.equalsIgnoreCase("1")){
		noti = "Alimentos";
	}
	else{
		noti = "Bebidas";
		if(productos.getDouble("litrosXBotella1") > 0.000 && productos.getDouble("litrosXBotella2") > 0.000){
			dos = 1;
			tib1 = "--> "+productos.getString("litrosXBotella1")+" lt.";
			tib2 = "--> "+productos.getString("litrosXBotella2")+" lt.";
		}
		if(productos.getDouble("litrosXBotella1") > 0.000){
			tib1 = "--> "+productos.getString("litrosXBotella1")+" lt.";
		}
		if(productos.getDouble("litrosXBotella2") > 0.000){
			tib2 = "--> "+productos.getString("litrosXBotella2")+" lt.";
		}
	}
	if(tia.equalsIgnoreCase("1")){
		notia = "--> Kg.";
	}
	if(tia.equalsIgnoreCase("2")){
		notia = "--> Unidades";
	}
	if(tia.equalsIgnoreCase("0")){
		notia = "";
	}
	//Va la Clave del Producto, si dice A --> Alimento KG, B --> ALIMENTO UNIDADES, C --> Botella1, D --> BOTELLA2
	%>
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
      <tr>
		<% if(noti.equalsIgnoreCase("Alimentos")){
				if(tia.equalsIgnoreCase("1")){
		%>
				<td width="23"><input type="radio" name="clave" value="<%=productos.getString("clave")+"A"%>"></td>
				
      <td width="95"><%=productos.getString("clave")%></td>
				<td width="99"><%=noti%></td>
				<td width="373"><%out.print(productos.getString("nombre")+"  "+notia);%></td>
		<%
				}
				if(tia.equalsIgnoreCase("2")){
		%>
				<td width="23"><input type="radio" name="clave" value="<%=productos.getString("clave")+"B"%>"></td>
				<td width="95"><%=productos.getString("clave")%></td>
				<td width="99"><%=noti%></td>
				<td width="373"><%out.print(productos.getString("nombre")+"  "+notia);%></td>
		<%
				}
		   }
 		if(noti.equalsIgnoreCase("Bebidas")){
			if(dos == 0){
				if(productos.getDouble("litrosXBotella1") > 0.000){
		%>
				<td width="23"><input type="radio" name="clave" value="<%=productos.getString("clave")+"C"%>"></td>
				<td width="95"><%=productos.getString("clave")%></td>
				<td width="99"><%=noti%></td>
				<td width="373"><%out.print(productos.getString("nombre")+"  "+tib1);%></td>
		<%
				}
				if(productos.getDouble("litrosXBotella2") > 0.000){				
		%>
				<td width="23"><input type="radio" name="clave" value="<%=productos.getString("clave")+"D"%>"></td>
				<td width="95"><%=productos.getString("clave")%></td>
				<td width="99"><%=noti%></td>
				<td width="373"><%out.print(productos.getString("nombre")+"  "+tib2);%></td>
		<%
				}
			}
			else{
		%>
				<td width="23"><input type="radio" name="clave" value="<%=productos.getString("clave")+"C"%>"></td>
				<td width="95"><%=productos.getString("clave")%></td>
				<td width="99"><%=noti%></td>
				<td width="373"><%out.print(productos.getString("nombre")+"  "+tib1);%></td>
		<%
			}
		}
		%>
      </tr>
<%
	if(dos == 1){
%>
      <tr>
		<td width="23"><input type="radio" name="clave" value="<%=productos.getString("clave")+"D"%>"></td>
		<td width="95"><%=productos.getString("clave")%></td>
		<td width="99"><%=noti%></td>
		<td width="373"><%out.print(productos.getString("nombre")+"  "+tib2);%></td>
      </tr>
<%
	}	
}
%>
	</table>
  <p><font> 
    <input type="submit" name="Submit" value="Enviar">
  </font> </p>
</form>
<% pro.cierraConexion();%>
<p align="center"><a href="Consultas_Compras.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
