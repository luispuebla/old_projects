<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ven" class="com.ult.bd.ManagerVentas" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Impresion Tickets</title>
<link href="ultramarinaTicketCSS.css" rel="stylesheet" type="text/css">

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

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

function Cerrar() {
	parent.close(); 
}

//-->
</script>
<style type="text/css">
br.breakhere{page-break-before: always}
</style>
</head>
  
<body>
<%
	double Descuento = 0.00;
	String PagoTotal = "";
	String totalTarget = request.getParameter("totalTarget");
	String totalFactur = request.getParameter("totalFactur");
	String totalCompro = request.getParameter("totalCompro");
	String fecha = request.getParameter("fecha");
	ResultSet rst = ven.dameComandasAImprimir(fecha, totalTarget, totalFactur, totalCompro);
	int idDiario = 0;
	while(rst.next()){
		idDiario ++;
		Descuento = ven.dameDescuento(rst.getInt("IDC"));
		double total = 0.00;
		total = rst.getDouble("PT") - Descuento;
		total = ven.cambiaADouble(ven.formatoCortoDinero(total+""));
		PagoTotal = ven.formatoDinero(ven.acortaLongitud((total+"")));
%>
<table width="240" cellpadding="0" cellspacing="0">
	<tr>
	  <td width="108"  rowspan="2"><div align="right"><img src="imagenes/petitLogo.jpg" width="68" height="53"></div></td>
	  <th width="130" colspan="2"><div align="center">LA ULTRAMARINA</div></th>
	</tr>
	<tr>
	  <th colspan="2"><div align="center">Cuenta Final</div></th>
	</tr>
	<tr>
	  <th colspan="3">*****************************</th>
	</tr>
	<tr>
	  <th colspan="3">Cantina "La Ultramarina", Tonalá #178,</th>
	</tr>
	<tr>
	  <th colspan="3">esq. Yucatán, Col. Roma, Tel. 5574 - 3953</th>
	</tr>
	<tr>
	  <th colspan="3">*********** NO FISCAL *********</th>
	</tr>	
	<tr>
	  <th>ID Comanda Diaria:</th>
	  <th colspan="2"><%=idDiario%></th>
	</tr>
	<tr>
	  <th>Fecha: <%=rst.getString("FA")%></th>
	  <th colspan="2">Hora: <%=rst.getString("TA")%></th>
	</tr>
	<tr>
	  <th>Mesa: <%=rst.getString("IDMM")%></th>
	  <th colspan="2">Comensales: <%=rst.getString("NC")%></th>
	</tr>
	<tr>
	  <th colspan="3">---------------------------------------------</th>
	</tr>	
</table>
<table width="240" cellpadding="0" cellspacing="0">
	<tr>
	  <td width="40"><div align="center"><strong>Cant.</strong></div></td>
 	  <td width="116"><div align="center"><strong>Producto</strong></div></td>
  	  <td width="51"><div align="center"><strong>$ Unitario</strong></div></td>
  	  <td width="51"><div align="center"><strong>$ Total</strong></div></td>
	</tr>
<%
	ResultSet rsp = ven.dameTicketsInternos(rst.getInt("IDC"));
	while (rsp.next()){
	String tipo = "";
	String cantidad = "";	
	String precioUnitario = ven.formatoCortoDinero(rsp.getString("precioUnitario"));
	String precioTotal = ven.formatoCortoDinero(rsp.getString("precioTotal"));
	String elProducto =  rsp.getString("Producto").toLowerCase();
	if(elProducto.length() > 25){
	elProducto= elProducto.substring(0,25);
	}	
	cantidad = ven.dameEnteros(rsp.getString("Cantidad"));
	if(rsp.getString("tipo").equalsIgnoreCase("1") && rsp.getInt("Tamanio")==1){
		tipo = "C.";
	}
	else if(rsp.getString("tipo").equalsIgnoreCase("1") && rsp.getInt("Tamanio")==2){
		tipo = "Cd.";
	}
	else if(rsp.getString("tipo").equalsIgnoreCase("1") && rsp.getInt("Tamanio")==3){
		tipo = "Ct.";
	}
	else if(rsp.getString("tipo").equalsIgnoreCase("2")){
		tipo = "B.";
	}
	else if(rsp.getString("tipo").equalsIgnoreCase("3")){
		tipo = "BG.";
	}
	else if(rsp.getString("tipo").equalsIgnoreCase("4")){
		tipo = "BP.";
	}
%>	
	<tr>
  	  <td><div align="left"><%=cantidad+" "+tipo%></div></td>
	  <td><div align="left"><%=elProducto%></div></td>
	  <td><div align="right"><%=ven.formatoDinero(ven.acortaLongitud(precioUnitario))%></div></td>
	  <td><div align="right"><%=ven.formatoDinero(ven.acortaLongitud(precioTotal))%></div></td>		
	</tr>
<%
	}
	ven.cierraConexion2();
%>	
</table>
<table width="240" cellpadding="0" cellspacing="0">
	<tr>
	  <th colspan="3">--------------------------------------------</th>
	</tr>	
<%
	if(Descuento > 0){
%>	
	<tr>
	  <th>&nbsp;</th>	  	
	  <th><div align="left">DESCUENTO........$</div></th>	  
	  <th><div align="right"><%=Descuento%></div></th>	  	  	  
	</tr>
<%
	}
%>			
	<tr>
	  <th>&nbsp;</th>	  	
	  <th><div align="left">TOTAL.................$</div></th>	  
	  <th><div align="right"><%=PagoTotal%></div></th>	  	  	  
	</tr>
	<tr>
	  <th colspan="3">***************************</th>
	</tr>
	<tr>
	  <th colspan="3">**** Los precios incluyen I.V.A. ****</th>
	</tr>		
	<tr>
	  <th colspan="3">Gracias por su visita, Vuelva Pronto</th>
	</tr>		
</table>
<br class="breakhere"> &nbsp; </br>
<%	
	}
	ven.cierraConexion();
%>	
</body>
</html>
