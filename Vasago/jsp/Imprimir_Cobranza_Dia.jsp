<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="co" class="com.vas.bd.ManagerCobros" />
<jsp:useBean id="ti" class="com.vas.bd.TimeStamp" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />

<html>
<head>
<title>Cobors Faltantes Todos los Clientes</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
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
<body onLoad="imprimirPagina(); Cerrar()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String fechaInicial = request.getParameter("fecha");
	ResultSet rs = co.cobranzaXDia(fechaInicial);	
	double total = 0.00;	
%>		
	<h1>Cobranza del día: <%=fechaInicial%></h1>
	<table width="600" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<th width="107">Clave Venta</th>
			<th width="320">Cliente</th>
			<th width="151">Monto Recaudado</th>		
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
</body>
</html>
