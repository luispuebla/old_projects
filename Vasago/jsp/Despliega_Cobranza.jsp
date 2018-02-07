<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="co" class="com.vas.bd.ManagerCobros" scope="page" />

<html>
<head>
<title>Cobranza Por Día </title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">

<script>
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

function MandaSubmit(f){
	document.form1.submit();
}
-->
</script> 

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String fechaInicial = request.getParameter("datebox");
	fechaInicial= fechaInicial.substring(6,10)+"-"+fechaInicial.substring(0,2)+"-"+fechaInicial.substring(3,5);
	ResultSet rs = co.cobranzaXDia(fechaInicial);
	double total = 0.00;
%>
	<h1>Cobranza del día: <%=fechaInicial%></h1>
	<table width="600" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th width="120">Clave Venta</th>
			<th width="327">Cliente</th>
			<th width="145">Monto Recaudado</th>		
		</tr>	
<%
		while (rs.next()){
			total += rs.getDouble("monto");
%>		
		<tr>
			<td><div align="center"><%=rs.getString("claveVenta")%></div></td>
			<td><%=rs.getString("nombre")%></td>
			<td><div align="right">$ <%=co.formatoDinero(co.acortaLongitud(rs.getString("monto")))%></div></td>
		</tr>
<%}
	if(rs != null){
		rs.close();
	}
	co.cierraConexion();										

%>		
		<tr>
			<th colspan="2"><div align="right">TOTAL....</div></th>
			<td><div align="right"><b>$ <%=co.formatoDinero(co.acortaLongitud(co.roundDBL2(total)+""))%></b></div></td>
		</tr>
	</table>
<br />	
<table>
	<tr>
		<td valign="top">	
			<form name="form1" target="_blank" action="Imprimir_Cobranza_Dia.jsp" method="post">
			<p align="center"> <a onClick="MandaSubmit(document.forms[0])" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Imprime','','imagenes/Imprimir2.jpg',1)"><img src="imagenes/Imprimir1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
			<input type="hidden" name="fecha" value="<%=fechaInicial%>">
			</form>			
		</td>
		<td>&nbsp;</td>
		<td valign="top"><p align="center"><a href="Consultas_Cobros.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p></td>
	</tr>
</table>	
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
