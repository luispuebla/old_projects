<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pa" class="com.ult.bd.ManagerCobros" scope="page" />

<html>
<head>
<title>Selección de Cobro para su Baja</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || (!tipo.equalsIgnoreCase("admin") && !tipo.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

   String comanda = request.getParameter("comanda");%>
<%
//System.out.println("la clave que llego: "+clave);
 if(comanda == null){%>
  <font>
  <%
 // System.out.println("Entro al vacio");
		out.print("Debes escribir una Comanda."); %>
  </font> 
  <%
}
else{
%>
<h1>Escoge el Cobro que deseas dar de Baja:</h1>
<p></p>
<form name=search onSubmit="return findInPage(this.string.value);">
Buscar en la pagina:
<input name=string type=text size=15 onChange="n = 0;">
<input type="Submit" value="buscar">
</form>
<form name="form1" method="post" action="Baja_Cobro.jsp">
<input type="hidden" name="comanda" value="<%=comanda%>">
 <table width="576" border="1" align="center">
  <caption>
    COBROS COMANDA # <%=comanda%>
    </caption>
  <tr> 
    <td width="22"></th>
    <th width="59">Clave</th>
	<th width="205">Fecha en la que se Cobro</th>
    <th width="116">Monto</th>
	<th width="140">Forma de Pago</th>
   </tr>
</table>
<table width="576" align="center" border="1">
<%
	ResultSet rs = pa.dameCobros(comanda);
	while(rs.next()){
	String fp = "";
	
	if(rs.getInt("formaPago") == 1 ){
		fp = "Efectivo";
	}
	if(rs.getInt("formaPago") == 4 ){
		fp = "Tarjetas de Crédito";
	}
	if(rs.getInt("formaPago") == 5 ){
		fp = "American Express";
	}
%>
  <tr> 
  <td width="22"> <div align="center">
    <input type="radio" name="clave" value="<%= rs.getString("consecutivo")%>" >
  </div></td>
    <td width="59"><div align="center"><%=rs.getString("consecutivo")%></div></td>
    <td width="205"><div align="center"><%=rs.getString("fechaCobro")%></div></td>
    <td width="116"><div align="right">$ <%=pa.formatoDinero(rs.getString("monto"))%></div></td>
    <td width="140"><div align="center"><%=fp%></div></td>
  </tr>
<%
	}
%>	  
</table>
  <p><font> 
    <input type="submit" name="Submit" value="Enviar">
  </font> </p>
</form>
<%}
pa.cierraConexion();%>
<p align="center"><a href="Menu_Cobros.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
