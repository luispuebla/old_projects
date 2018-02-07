<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*" errorPage="error.jsp" %>
<jsp:useBean id="cob" class="com.ult.bd.ManagerCobros" scope="page" />

<html>
<head>
<title>Factura Global</title>
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

function checaVacio(valor){
	var elValor = new String();
	elValor = valor;
	re = / /gi;
	elValor = elValor.replace(re,"");
	if(elValor == ''){
		return true;
	}
	return false;
}

function funcionFoco(){
	document.form1.factura.focus();
}
 
function OnSubmitForm(){
	if(checaVacio(form1.factura.value)){
		alert("Te falta llenar el número de Factura asignada");
		form1.factura.focus();
		return false;		
	}
	document.form1.action ="Datos_Print_Fac_Global.jsp";		
	return true;	
}

//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg','imagenes/Imprimir2.jpg','imagenes/Imprimir.jpg'); funcionFoco()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String mes = request.getParameter("mes");
	String anio = request.getParameter("aaaa");
	String dia = request.getParameter("dia");
	String fecha = anio+"-"+mes+"-"+dia;	
%>
<h1>La Factura Global para <strong>
<%
	ResultSet datosCorteE = cob.dameCorteCajaE(fecha);
	ResultSet datosCorteES = cob.dameCorteCajaES(fecha);
	ResultSet datosCorteTCS = cob.dameCorteCajaTCSinFacturar(fecha);
	ResultSet datosCorteEC = cob.dameCorteCajaEC(fecha);	
	ResultSet datosCorteESinFacturar = cob.dameCorteCajaESinFacturar(fecha);
	double totalFinal = 0.0;
	double totalTC = 0.0;
	double totalCompro = 0.0;
	double totalEfec = 0.0;
	double totalFactur = 0.0;
	double totalTarget = 0.00;
	double totalPosible = 0.00;
	double sub = 0.00;
	double iva =0.00;
	double total = 0.00;
	while (datosCorteTCS.next()){
		totalTC = totalTC + datosCorteTCS.getDouble("monto");
	}
	  
	while (datosCorteE.next()){
		totalEfec = totalEfec + datosCorteE.getDouble("monto");
	} 

	while (datosCorteES.next()){
		totalFactur = totalFactur + datosCorteES.getDouble("monto");
	} 
	
	while (datosCorteEC.next()){
		totalCompro = totalCompro + datosCorteEC.getDouble("monto");
	} 		
	totalTarget = (totalEfec * 15)/100;
	if(totalFactur+totalCompro < totalTarget){	
		while (datosCorteESinFacturar.next() && totalFactur+totalCompro+totalPosible < totalTarget){ 
			totalPosible += datosCorteESinFacturar.getDouble("monto");		
		}
	}
	total = totalTC+totalCompro+totalPosible;
	BigDecimal montoTotal = new BigDecimal(total+"");
	BigDecimal subTotal = new BigDecimal ("0.00");
	subTotal = (montoTotal.multiply(new BigDecimal("100"))).divide(new BigDecimal("115"), new MathContext(100));
	BigDecimal ivaBD = new BigDecimal ("0.00");
	ivaBD = montoTotal.subtract(subTotal);
	montoTotal = montoTotal.setScale(2, RoundingMode.HALF_UP);
	subTotal = subTotal.setScale(2, RoundingMode.HALF_UP);
	ivaBD = ivaBD.setScale(2, RoundingMode.HALF_UP);
	cob.cierraConexion();		
%><%=dia%>/<%=mes%>/<%=anio%></strong> es:</font> </h1>
<p></p>
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="500">
    <caption>
  IMPORTE 
  </caption>
    <tr bgcolor="#CCCCCC"> 
      
    <th width="161">Subtotal</th>
      
    <th width="144">I.V.A.</th>
      
    <th width="185">Total</th>
    </tr>
    <tr> 
      <td><div align="center">$ <%=cob.formatoDinero(subTotal.toString()) %></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(ivaBD.toString()) %></div></td>
      <td><div align="center">$ <%=cob.formatoDinero(montoTotal.toString()) %></div></td>
    </tr>
  </table>
  <form name="form1" method="post" onSubmit="return OnSubmitForm();" target="_self">
    <table align="center" border="1" cellpadding="0" cellspacing="0" width="500">
	  <tr>
	  	<th>Folio Factura Global:</th>
		<td><div align="center">
		  <input type="text" name="factura" size="10" maxlength="8">
	    </div></td>
	  </tr>	
	</table>
  	<input type="hidden" name="subTotal" value="<%=subTotal.toString()%>">
  	<input type="hidden" name="ivaBD" value="<%=ivaBD.toString()%>">
  	<input type="hidden" name="montoTotal" value="<%=montoTotal.toString()%>">
  	<input type="hidden" name="fecha" value="<%=fecha%>">			
	<p align="center"><input type="submit" name="Print_Fac_Global" value="Imprime Factura Global"></p>
  </form>
<p><br />
</p>
<table align="center" cellpadding="0" cellspacing="0" width="400">
  <tr> 
    <td><div align="center"><a href="Menu_Facturas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="151" height="33" border="0"></a></div></td>
  </tr>
</table>
<p><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


