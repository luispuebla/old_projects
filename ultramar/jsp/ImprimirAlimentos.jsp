<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<jsp:useBean id="alimento" class="com.ult.bd.ManagerAlimentos" />
<jsp:useBean id="division" class="com.ult.bd.ManagerDivisiones" />

<html>
<head>
<title>Todos los Alimentos</title>
<link href="ultramarinaCarta2CSS.css" rel="stylesheet" type="text/css">
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
      " desde la web. Actualizate o hazlo desde los men�s");
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
	ResultSet rs = alimento.dame_Alimentos_Division2();
	int contadorT1 = 0;
	int contadorT2 = 0;
	int contadorT3 = 0;
	String laDivision = "";
	boolean hayNuevaDivision = false;
	String elProducto = "";
	String precio = "";
	String descripcion = "";
%>
<table cellpadding="0" cellspacing="0" width="762">
  <tr><td colspan="3"><div align="center"><b class="formato">CANTINA "LA ULTRAMARINA" <br /> 
    Lista de Precios Alimentos 1 </b></div></td>
  </tr>
  <tr>
<%
	while(rs.next()){
		precio = "";
		descripcion = "";
		if(laDivision.equalsIgnoreCase("") || !laDivision.equalsIgnoreCase(rs.getString("nombreD"))){
			laDivision = rs.getString("nombreD");
			hayNuevaDivision = true;
		}
		elProducto = rs.getString("nombreA");
		precio = alimento.formatoDinero(rs.getString("precio"));
		descripcion = rs.getString("descripcion");
		descripcion = descripcion.toLowerCase();
		if(contadorT1 < 52){
			if(contadorT1 == 0){
%>  
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT1 +=2;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="85%" >&nbsp;</th>
			  	<th width="15%">$</th>
			  </tr>	
<%
			}
			contadorT1++;
%>
		  <tr>
			<td><b><%=elProducto%></b>
<%	
			if(!(descripcion.trim().equalsIgnoreCase(""))){
				contadorT1++;
%>
				<br /><%=descripcion%>
<%			
			}
%>		
			</td>
			<td><div align="center"><b><%=precio%></b></div></td>
		  </tr>	
<%
			if(contadorT1 >= 52 && contadorT2 == 0){
%>
		</table></td>
<%		
			}
		}// Cierro Contador T1		  
		else if(contadorT2 < 52){
			if(contadorT2 == 0){
%>  
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT2 += 2;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="85%" >&nbsp;</th>
			  	<th width="15%">$</th>
			  </tr>	
<%
			}
			contadorT2++;
%>
		  <tr>
			<td><b><%=elProducto%></b>
<%	
			if(!(descripcion.trim().equalsIgnoreCase(""))){
				contadorT2++;
%>
				<br /><%=descripcion%>
<%			
			}
%>		
			</td>
			<td><div align="center"><b><%=precio%></b></div></td>
		  </tr>	
<%
			if(contadorT2 >= 52 && contadorT3 == 0){
%>
		</table></td>
  </tr>
</table>		
		<br class="breakhere"> &nbsp; </br>		
		
<%		
			}
		}// Cierro Contador T2
		else if(contadorT3 < 52){
			if(contadorT3 == 0){
%>   
<table cellpadding="0" cellspacing="0" width="762">
  <tr><td colspan="3"><div align="center"><b class="formato">CANTINA "LA ULTRAMARINA" <br /> 
    Lista de Precios Alimentos 2 </b></div></td>
  </tr>
  	<td valign="top"><table cellpadding="0" cellspacing="0" width="100%">
<%								 
			}
			if(hayNuevaDivision){
				hayNuevaDivision = false;
				contadorT3 += 2;
%>			
			  <tr>
				<th width="100%" colspan="4" bgcolor="#CCCCCC"><%=laDivision%></th>
			  </tr>
			  <tr>
			  	<th width="85%" >&nbsp;</th>
			  	<th width="15%">$</th>
			  </tr>	
<%
			}
			contadorT3++;
%>
		  <tr>
			<td><b><%=elProducto%></b>
<%	
			if(!(descripcion.trim().equalsIgnoreCase(""))){
				contadorT3++;
%>
				<br /><%=descripcion%>
<%			
			}
%>		
			</td>
			<td><div align="center"><b><%=precio%></b></div></td>
		  </tr>	
<%		  
		}// Cierro T3
	}// Cierro ResultSet
	alimento.cierraConexion();
%>			
		</table></td>  
  </tr>
</table>
</body>
</html>


