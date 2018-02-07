<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>

<jsp:useBean id="beb" class="com.ult.bd.ManagerBebidas" />
<jsp:useBean id="division" class="com.ult.bd.ManagerDivisiones" />

<html>
<head>
<title>Todas las Bebidas</title>
<link href="ultramarinaCartaCSS.css" rel="stylesheet" type="text/css">
<style type="text/css">
br.breakhere{page-break-before: always}
</style>
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
</head>
  <%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	

<body onLoad="imprimirPagina(); Cerrar()">
<%
	ResultSet rs = beb.dame_Bebidas_Division_Imp();
	int contadorT1 = 0;
	int contadorT2 = 0;
	int contadorT3 = 0;
	int contadorT4 = 0;
	int contadorT5 = 0;
	int contadorT6 = 0;
	String laDivision = "";
	boolean hayNuevaDivision = false;
	boolean saltoPagina = false;
	String elProducto = "";
	String precioC = "";
	String precioB1 = "";
	String precioB2 = "";
%>
<table cellpadding="0" cellspacing="0" width="762">
  <tr><td colspan="3"><div align="center"><b class="formato">CANTINA "LA ULTRAMARINA" <br /> 
    Lista de Precios Bebidas 1 </b></div></td>
  </tr>
  <tr>
<%
	while(rs.next()){
		precioC = "";
		precioB1 = "";
		precioB2 = "";
		if(laDivision.equalsIgnoreCase("") || !laDivision.equalsIgnoreCase(rs.getString("nombreD"))){
			laDivision = rs.getString("nombreD");
			hayNuevaDivision = true;
		}
		elProducto = rs.getString("nombreB");
		if(rs.getDouble("precioC") == 0.00){
			precioC = "--";
		}
		else {
			precioC = beb.formatoDinero(rs.getString("precioC"));
		}
		if(rs.getDouble("precioB1") == 0.00){
			precioB1 = "--";
		}
		else {
			precioB1 = beb.formatoDinero(rs.getString("precioB1"));
		}
		if(rs.getDouble("precioB2") == 0.00){
			precioB2 = "--";
		}
		else {
			precioB2 = beb.formatoDinero(rs.getString("precioB2"));
		}		
		if(rs.getDouble("precioB1") == 0 && rs.getDouble("precioB2") > 0){
			if(rs.getDouble("litrosXBotella2") <= .750){
				precioB1 = precioB2;
				precioB2 = "--";
			}
		}
		if(rs.getDouble("precioB1") > 0 && rs.getDouble("precioB2") == 0){
			if(rs.getDouble("litrosXBotella1") > .750){
				precioB2 = precioB1;
				precioB1 = "--";
			}
		}
		if(rs.getDouble("precioB1") > 0 && rs.getDouble("precioB2") > 0){
			if(rs.getDouble("litrosXBotella1") > rs.getDouble("litrosXBotella2")){
				if(rs.getDouble("precioB1") > rs.getDouble("precioB2")){
					String temporal = precioB2;
					precioB2 = precioB1;
					precioB1 = temporal;
				}
			}
		}
		if(contadorT1 < 55){
			if(contadorT1 == 0){
%>  
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT1 +=3;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="45%" >&nbsp;</th>
<% 				if(laDivision.equalsIgnoreCase("CERVEZAS") || laDivision.equalsIgnoreCase("REFRESCOS")){
%>
			  	<th width="17%">BOT.</th>
<%				
				}
				else{
%>
			  	<th width="17%">COPA</th>
<%
				}
%>				
			  	<th width="19%">3/4</th>
			  	<th width="19%">1LT</th>						
			  </tr>	
			  <tr>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			  </tr>				
<%
			}
			contadorT1++;
%>
		  <tr>
			<th width="45%" ><%=elProducto%></th>
			<th width="17%"><%=precioC%></th>
			<th width="19%"><%=precioB1%></th>
			<th width="19%"><%=precioB2%></th>						
		  </tr>	
<%
			if(contadorT1 >= 55 && contadorT2 == 0){
%>
		</table></td>
<%		
			}
		}// Cierro Contador T1		  
		else if(contadorT2 < 55){
			if(contadorT2 == 0){
%>  
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT2 +=3;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="45%" >&nbsp;</th>
<% 				if(laDivision.equalsIgnoreCase("CERVEZAS") || laDivision.equalsIgnoreCase("REFRESCOS")){
%>
			  	<th width="17%">BOT.</th>
<%				
				}
				else{
%>
			  	<th width="17%">COPA</th>
<%
				}
%>				
			  	<th width="19%">3/4</th>
			  	<th width="19%">1LT</th>						
			  </tr>	
			  <tr>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			  </tr>				
<%
			}
			contadorT2++;
%>
		  <tr>
			<th width="45%" ><%=elProducto%></th>
			<th width="17%"><%=precioC%></th>
			<th width="19%"><%=precioB1%></th>
			<th width="19%"><%=precioB2%></th>						
		  </tr>	
<%
			if(contadorT2 >= 55 && contadorT3 == 0){
%>
		</table></td>
<%		
			}
		}// Cierro Contador T2	  
		else if(contadorT3 < 55){
			if(contadorT3 == 0){
%>  
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT3 +=3;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="45%" >&nbsp;</th>
<% 				if(laDivision.equalsIgnoreCase("CERVEZAS") || laDivision.equalsIgnoreCase("REFRESCOS")){
%>
			  	<th width="17%">BOT.</th>
<%				
				}
				else{
%>
			  	<th width="17%">COPA</th>
<%
				}
%>				
			  	<th width="19%">3/4</th>
			  	<th width="19%">1LT</th>						
			  </tr>	
			  <tr>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			  </tr>				
<%
			}
			contadorT3++;
%>
		  <tr>
			<th width="45%" ><%=elProducto%></th>
			<th width="17%"><%=precioC%></th>
			<th width="19%"><%=precioB1%></th>
			<th width="19%"><%=precioB2%></th>						
		  </tr>	
<%
			if(contadorT3 >= 55 && contadorT4 == 0){
%>
		</table></td>
  </tr>
</table>		
		<br class="breakhere"> &nbsp; </br>				
<%		
			}
		}
		else if(contadorT4 < 55){
			if(contadorT4 == 0){
%>  
<table cellpadding="0" cellspacing="0" width="762">
  <tr><td colspan="3"><div align="center"><b class="formato">CANTINA "LA ULTRAMARINA" <br /> 
    Lista de Precios Bebidas 2 </b></div></td>
  </tr>
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT4 +=3;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="45%" >&nbsp;</th>
<% 				if(laDivision.equalsIgnoreCase("CERVEZAS") || laDivision.equalsIgnoreCase("REFRESCOS")){
%>
			  	<th width="17%">BOT.</th>
<%				
				}
				else{
%>
			  	<th width="17%">COPA</th>
<%
				}
%>				
			  	<th width="19%">3/4</th>
			  	<th width="19%">1LT</th>						
			  </tr>	
			  <tr>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			  </tr>				
<%
			}
			contadorT4++;
%>
		  <tr>
			<th width="45%" ><%=elProducto%></th>
			<th width="17%"><%=precioC%></th>
			<th width="19%"><%=precioB1%></th>
			<th width="19%"><%=precioB2%></th>						
		  </tr>	
<%
			if(contadorT4 >= 55 && contadorT5 == 0){
%>
		</table></td>
<%		
			}
		}// Cierro Contador T4
		else if(contadorT5 < 55){
			if(contadorT5 == 0){
%>  
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT5 +=3;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="45%" >&nbsp;</th>
<% 				if(laDivision.equalsIgnoreCase("CERVEZAS") || laDivision.equalsIgnoreCase("REFRESCOS")){
%>
			  	<th width="17%">BOT.</th>
<%				
				}
				else{
%>
			  	<th width="17%">COPA</th>
<%
				}
%>				
			  	<th width="19%">3/4</th>
			  	<th width="19%">1LT</th>						
			  </tr>	
			  <tr>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			  </tr>				
<%
			}
			contadorT5++;
%>
		  <tr>
			<th width="45%" ><%=elProducto%></th>
			<th width="17%"><%=precioC%></th>
			<th width="19%"><%=precioB1%></th>
			<th width="19%"><%=precioB2%></th>						
		  </tr>	
<%
			if(contadorT5 >= 55 && contadorT6 == 0){
%>
		</table></td>
<%		
			}
		}// Cierro Contador T5
		else if(contadorT6 < 55){
			if(contadorT6 == 0){
%>  
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT6 +=3;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="45%" >&nbsp;</th>
<% 				if(laDivision.equalsIgnoreCase("CERVEZAS") || laDivision.equalsIgnoreCase("REFRESCOS")){
%>
			  	<th width="17%">BOT.</th>
<%				
				}
				else{
%>
			  	<th width="17%">COPA</th>
<%
				}
%>				
			  	<th width="19%">3/4</th>
			  	<th width="19%">1LT</th>						
			  </tr>	
			  <tr>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			    <th>&nbsp;</th>
			  </tr>				
<%
			}
			contadorT6++;
%>
		  <tr>
			<th width="45%" ><%=elProducto%></th>
			<th width="17%"><%=precioC%></th>
			<th width="19%"><%=precioB1%></th>
			<th width="19%"><%=precioB2%></th>						
		  </tr>	
<%
		}// Cierro Contador T6	  		  		
	}// Cierro ResultSet
	beb.cierraConexion();
%>			
		</table></td>  
  </tr>
</table>
</body>
</html>


