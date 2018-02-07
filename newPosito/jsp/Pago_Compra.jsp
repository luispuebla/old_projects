<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" %> 
<jsp:useBean id="pa" class="com.alpha.bd.ManagerPagos" />

<html>
<head>
<title>Alta Pago</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
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
function setFecha(){
if(document.form1 != null){
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
	document.form1.datebox.value=mesHoy+"/"+diaHoy+"/"+anioHoy;
}	
}

function funcionFoco(){
	document.form1.importe.focus();
}

function VerificaCheque(){
	var valor;
	for(var i=0; i<form1.formaPago.length; i++){
		if(form1.formaPago[i].selected){
			valor = form1.formaPago[i].value;
		}
	}	
	if(valor == '2'){
		form1.cheque.disabled = false;
		form1.cheque.focus();
	}
	else{
		form1.cheque.value="";
		form1.cheque.disabled = true;
	}
 }

function OnSubmitForm(){
	var valor;
	for(var i=0; i<form1.formaPago.length; i++){
		if(form1.formaPago[i].selected){
			valor = form1.formaPago[i].value;
		}
	}	
	if(valor == '2'){
		var elCheque = new String();
		elCheque = form1.cheque.value;
		re = / /gi;
		elCheque = elCheque.replace(re,"");
		if(elCheque == ''){
			alert("Debes especificar el número de Cheque para este Pago.");
			form1.cheque.focus();
			return false;
		}
		else{
			document.form1.action ="Conf_Pago_Compra.jsp";
			return true;
		}
	}
	else{
		document.form1.action ="Conf_Pago_Compra.jsp";	
		return true;	
	}
}

//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'),setFecha(), funcionFoco()">
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
	String ClaveOrden = request.getParameter("claveOrden");
	String proveedor = request.getParameter("proveedor");
	double totalD = 0.00;
	double yaPagado = 0.00;

//System.out.println("la clave que llego: "+clave);
 if(ClaveOrden == null){%>
  <font>
  <%
 // System.out.println("Entro al vacio");
		out.print("Debes seleccionar una Compra."); %>
  </font> 
  <%
}
else{
ResultSet total = pa.dameTotal(ClaveOrden);
String to = new String();
while(total.next()){
	to = total.getString("total");
	totalD = total.getDouble("total");
}
	if(total != null){
		total.close();
	}
	pa.cierraConexion();				
%>
<table width="416" border="1" align="center">
  <tr> 
	<th width="199" bgcolor="#CCCCCC">Total de la Compra  :</th>
    <td width="201"><div align="right">$ <%=pa.formatoDinero(to)%></div></td>
  </tr>
</table>
<table width="416" border="1" align="center">
<br />
<caption>Pagos Anteriores</caption>
  <tr> 
	<th width="199" bgcolor="#CCCCCC">Fecha Pago</th>
	<th width="201" bgcolor="#CCCCCC">Monto</th>
</tr>	
<%
ResultSet anteriores = pa.damePagos(ClaveOrden);
while(anteriores.next()){
	yaPagado += anteriores.getDouble("monto");
%>
  <tr> 
	<td width="199"><div align="center"><%=anteriores.getString("fechaPago")%></div></td>
	<td width="201"><div align="right">$ <%=pa.formatoDinero(anteriores.getString("monto"))%></div></td>
</tr>	
<%}
	if(anteriores != null){
		anteriores.close();
	}
	pa.cierraConexion();				
%>
 
</table>
<table width="416" border="1" align="center">
<br />
  <caption>Total Faltante a Cubrir</caption>  
  <tr>	
	<th width="199" bgcolor="#CCCCCC">Total........... </th>
<%
	BigDecimal yaAPagado = null;
	BigDecimal porPagar = null;
	yaAPagado = new BigDecimal(Double.toString(yaPagado));
	porPagar = new BigDecimal(Double.toString(totalD));
	porPagar = porPagar.subtract(yaAPagado);
	porPagar = porPagar.setScale(2, RoundingMode.HALF_UP);
%>		
	<td width="201"><div align="right">$ <%=pa.formatoDinero(pa.acortaLongitud((porPagar.toString())))%></div></td>
  </tr>	
</table>  

<form name="form1" method="post" onSubmit="return OnSubmitForm();">
<input type="hidden" name="porPagar" value="<%=porPagar.toString()%>">
<input name="ClaveOrden" value="<%=ClaveOrden%>" type="hidden">
<input name="proveedor" value="<%=proveedor%>" type="hidden">
<h1>Ingresa los Datos  y da Click en el bot&oacute;n de Guardar </h1>
	<table width="750" border="1" align="center">
  <tr> 
	<th width="150"><div align="center">Fecha </div></th>
    <td width="596"> <input type=text name="datebox" size=15 readonly="true">  <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a> </td>
  </tr>
  <tr> 
	<th><div align="center">Importe </div></th>
    <td>$ <input name="importe" type="text" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> </td>
  </tr>
    <tr> 
      <th><div align="center">Forma de Pago</div></th>
      <td> <select name="formaPago" onChange="VerificaCheque()">
		  <option value="1">Efectivo</option>
          <option value="2">Cheque</option>
          <option value="3">Depósito</option>
          <option value="4">Tarjeta de Crédito</option>
          <option value="5">Tarjeta de Débito</option>
        </select></td>
	</tr>	
  <tr> 
	<th><div align="center">Número de Cheque / Referencia</div></th>
    <td><input name="cheque" type="text" size="12" maxlength="11" disabled> </td>
  </tr>
</table>
  <p><div align="center">  <input type="submit" name="Submit" value="Guardar" readonly="true"> </div> </p>
</form>
<%
	}
%>
<p align="center"><a href="Escoge_Proveedor_Pago.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
