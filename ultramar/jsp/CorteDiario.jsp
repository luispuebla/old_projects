<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="cob" class="com.ult.bd.ManagerCobros" scope="page" />

<html>
<head>
<title>Corte Diario</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

function MandaSubmit(f){
	f.submit();
}
//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg','imagenes/Imprimir2.jpg','imagenes/Imprimir.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String tipoConsul = request.getParameter("tipoCon");
	String dia = "%%";
	String mes = request.getParameter("mes");
	String anio = request.getParameter("aaaa");
	if(tipoConsul.equalsIgnoreCase("dia")){
		dia = request.getParameter("dia");
	}
	String fecha = anio+"-"+mes+"-"+dia;	
%>

<form name="form1" method="post" target="_blank" action="CorteDiarioImprime.jsp" >
<input type="hidden" name="fecha" value="<%=fecha%>">
<input type="hidden" name="dia" value="<%=dia%>">
<input type="hidden" name="mes" value="<%=mes%>">
<input type="hidden" name="anio" value="<%=anio%>">
<h1>Los Cobros recibidos para la Fecha:<strong>
<%
	ResultSet datosCorteTC = cob.dameCorteCajaTC(fecha);
	ResultSet datosCorteTD = cob.dameCorteCajaTD(fecha);
	ResultSet datosCorteE = cob.dameCorteCajaE(fecha);
	double totalFinal = 0.0;
	double ttc = 0.0;
	double ttd = 0.0;
	double te = 0.0;
	if(!(dia.equalsIgnoreCase("%%"))){
		out.print(dia+"/");
	}
%><%=mes%>/<%=anio%></strong> son:</font> </h1>
<b>COBROS EN TARJETAS DE CR&Eacute;DITO</b>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
      <th width="142">Mesa</th>
      <th width="142">Cheque</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
	while (datosCorteTC.next()){
	ttc = ttc + datosCorteTC.getDouble("monto");
	
%>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=cob.dameMesa(datosCorteTC.getString("claveVenta"))%></font></div></td>
      <td><div align="center"><%=datosCorteTC.getString("claveVenta")%></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteTC.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteTC.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteTC.getString("consecutivo"))%>&nbsp;</div></td>
    </tr>
    <%}%>
    <tr> 
 	<td></td>
     <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttc+""))%></div></td>
      <td>&nbsp;</td>
    </tr>
  </table>
<p></p>
<b>COBROS EN AMERICAN EXPRESS</b>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
      <th width="142">Mesa</th>
      <th width="142">Cheque</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
	while (datosCorteTD.next()){
	ttd = ttd + datosCorteTD.getDouble("monto");
	
%>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=cob.dameMesa(datosCorteTD.getString("claveVenta"))%></font></div></td>
     <td><div align="center"><%=datosCorteTD.getString("claveVenta")%></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteTD.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteTD.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteTD.getString("consecutivo"))%>&nbsp;</div></td>
	 </tr>
	<%}%>
    <tr> 
 	<td></td>
     <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttd+""))%></div></td>
      <td>&nbsp;</td>
	 </tr>
</table>
<p></p>
<b>COBROS EN EFECTIVO</b>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <tr> 
       <th width="142">Mesa</th>
     <th width="142">Cheque</th>
      <th width="170">Monto</th>
      <th width="166">Cajero</th>
      <th width="162">Factura</th>
    </tr>
    <%  
	while (datosCorteE.next()){
	te = te + datosCorteE.getDouble("monto");
	
%>
    <tr> 
      <td><div align="center"><font color="#FF0000"><%=cob.dameMesa(datosCorteE.getString("claveVenta"))%></font></div></td>
      <td><div align="center"><%=datosCorteE.getString("claveVenta")%></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(datosCorteE.getString("monto")))%></div></td>
      <td><div align="center"> <%=datosCorteE.getString("usuario")%></div></td>
      <td><div align="center"> <%=cob.dameFactura(datosCorteE.getString("consecutivo"))%>&nbsp;</div></td>
	 </tr>
	<%}%>
    <tr> 
	<td></td>
      <tH><div align="right">TOTAL:</div></tH>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(te+""))%></div></td>
      <td>&nbsp;</td>
	 </tr>
</table>
<p></p>
<p></p>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="650">
    <caption>
    CONCENTRADO 
    </caption>
    <tr bgcolor="#CCCCCC"> 
      <th width="215">Tarjetas Cr&eacute;dito</th>
      <th width="247">American Express</th>
      <th width="180">Efectivo</th>
    </tr>
    <tr> 
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttc +"")) %></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(ttd +"")) %></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(cob.acortaLongitud(te+"")) %></div></td>
    </tr>
  </table>
    <br />
<%
totalFinal = ttc + ttd + te;
cob.cierraConexion();
%>
    <table cellpadding="0" cellspacing="0" border="1" align="center" width="650">
      <caption>&nbsp;
      </caption>
      <tr bgcolor="#999999"> 
        <th width="418">GRAN TOTAL...............</th>
        
      <th width="226">$ <%=cob.formatoDinero(cob.acortaLongitud(totalFinal +"")) %></th>
      </tr>
    </table>
    <br/>
    <table align="center" cellpadding="0" cellspacing="0" width="400">
      <tr> 
        <td><div align="center"><a onClick="MandaSubmit(document.forms[0])" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprime','','imagenes/Imprimir2.jpg',1)"><img src="imagenes/Imprimir1.jpg" name="Imprime" width="152" height="36" border="0"></a></div></td>
        <td><div align="center"><a href="Cortes_Caja.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="151" height="33" border="0"></a></div></td>
      </tr>
    </table>
</form>
<p><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


