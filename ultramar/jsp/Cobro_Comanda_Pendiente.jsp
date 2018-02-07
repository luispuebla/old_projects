<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="co" class="com.ult.bd.ManagerCobros" />
<jsp:useBean id="ven" class="com.ult.bd.ManagerVentas" />

<html>
<head>
<title>Alta Cobro</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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

//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'),setFecha(), funcionFoco()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
   String comanda = request.getParameter("comanda");
   String nombreOriginal = "";  
   if(comanda.length() <= 0){ %>
<h1>Debes introducir una Comanda.</h1>
   <% }
  else{

   boolean tiene = ven.tieneComandaPendiente(comanda);
   
   if(tiene){
	
	int ClaveVen = ven.cambiaAInt(comanda);
	
	String ClaveVenta = ClaveVen+"";

	double totalD = 0.00;
	double yaPagado = 0.00;
	

//System.out.println("la clave que llego: "+clave);
ResultSet total = co.dameTotal2(ClaveVenta);
String to = new String();

while(total.next()){
	to = total.getString("PT");
	totalD = total.getDouble("PT");
	
}
%>
<table width="416" border="1" align="center">
  <tr> 
	<th width="178" bgcolor="#CCCCCC">Total de la Venta  :</th>
    <td width="222"><div align="right">$ <%=co.formatoDinero(to)%></div></td>
  </tr>
</table>
<p></p>
<table width="416" border="1" align="center">
<caption>Cobros Anteriores</caption>
  <tr> 
	<th width="178" bgcolor="#CCCCCC">Fecha Cobro</th>
	<th width="222" bgcolor="#CCCCCC">Monto</th>
</tr>	
<%
ResultSet anteriores = co.dameCobros(ClaveVenta);
while(anteriores.next()){
	yaPagado += anteriores.getDouble("monto");
%>
  <tr> 
	<td width="178"><%=anteriores.getString("fechaCobro")%></td>
	<td width="222"><div align="right">$ <%=co.formatoDinero(anteriores.getString("monto"))%></div></td>
</tr>	
<%}%>
  <tr> 
	<th width="178" bgcolor="#CCCCCC">Total por Cobrar: </th>
	<td width="222"><div align="right">$ <%=co.formatoDinero(co.acortaLongitud(((totalD-yaPagado)+"")))%></div></td>
  </tr>	

</table>
<form name="form1" method="post" action="Conf_Cobro_Comanda_Pendiente.jsp">
<input name="ClaveVenta" value="<%=ClaveVenta%>" type="hidden">
<input name="to" value="<%=to%>" type="hidden">
<h1>Ingresa los Datos  y da Click en el bot&oacute;n de Guardar </h1>
	<table width="762" border="1" align="center">
  <tr> 
	<th width="150" bgcolor="#CCCCCC"><div align="center">Fecha </div></th>
            <td width="596">
<input type=text name="datebox" size=15 readonly="true">
</td>
  </tr>
  <tr> 
	<th width="150" bgcolor="#CCCCCC"><div align="center">Importe </div></th>
            <td width="596">$ 
<input name="importe" type="text" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> </td>
  </tr>
    <tr> 
      <th bgcolor="#CCCCCC"><div align="center">Forma de Pago</div></th>
      <td> <select name="formaPago">
		  <option value="1">Efectivo</option>
          <option value="4">Tarjetas de Crédito</option>
          <option value="5">American Express</option>
        </select></td>
	</tr>	
  <tr> 
	<th width="150" bgcolor="#CCCCCC"><div align="center">Observaciones</div></th>
            <td width="596"><textarea name="observaciones" cols="50" rows="4"></textarea> </td>
  </tr>
  </tr>
  <tr> 
	<th width="150" bgcolor="#CCCCCC"><div align="center">Propina </div></th>
            <td width="596">$ 
<input name="propina" type="text" size="12" maxlength="10" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"> </td>
  </tr>
</table>
		
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<%
}
else{
	out.println("La Comanda ya fue Cobrada o esta Ligada a otra Mesa.");
	}
}
co.cierraConexion();

%>
<p> 
</p>
<p align="center"><a href="Dame_Comanda_Cobros_Pendientes.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
