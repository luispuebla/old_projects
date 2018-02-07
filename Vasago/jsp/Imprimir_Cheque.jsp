<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />
<jsp:useBean id="numL" class="com.vas.bd.n2t" />

<html>
<head>
<title>Cheque</title>
<link href="vasagoChequeCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
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
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>
  
<body onLoad="imprimirPagina(); Cerrar()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin"))){
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String  fechaentrega = "";	
	String clavePago = request.getParameter("clavePago");
	ResultSet rs = alCom.datosImpCheque(clavePago);
	int cont = 1;
	while (rs.next() && cont == 1){
		cont = 2;
		fechaentrega = rs.getString("fechaPago");
		String mes = fechaentrega.substring(5,7);
		String dia = fechaentrega.substring(8,10);
		String ano = fechaentrega.substring(0,4);
		fechaentrega = dia+" / "+mes+" / "+ano;
	}
	rs.beforeFirst();
	cont = 1;	
%>
<div id="Layer1" style="position:absolute; left:518px; top:52px; width:226px; height:21px; z-index:1">
<table align="center" border="0"><tr><td>M&eacute;xico, D.F. </td><td> <%=fechaentrega%></td></tr></table>
</div>
<table border="0" cellpadding="0" cellspacing="0" width="650">
	<tr>
		<td colspan="4" height="87"></td>
	</tr>
<%
	while (rs.next() && cont == 1){
		cont = 2;		
%>
	<tr>
		<td width="21">&nbsp; </td>
		<td width="156">&nbsp;</td>
		<td width="300">&nbsp;</td>
		<td width="173">&nbsp;</td>
	</tr>
	<tr>
		<td valign="bottom" height="31"></td>
		<td valign="bottom" colspan="2"><div align="left"><%=rs.getString("nombre")%> </div></td>
		<td valign="bottom"><div align="right"><%=alCom.formatoDinero(alCom.acortaLongitud(rs.getString("monto")))%></div></td>
	</tr>	
	<tr>
		<td valign="bottom" height="38">&nbsp;</td>
		<td valign="bottom" colspan="3"><div align="left">*****<%=numL.convertirLetras(Integer.parseInt(alCom.dameEnteros(rs.getString("monto"))))%> pesos <%=alCom.dameDecimales(alCom.acortaLongitud(rs.getString("monto")))%>/100 M.N.*****</div></td>
	</tr>	
<%
	} 
	if(rs != null){
		rs.close();
	}
	alCom.cierraConexion();						
%>		
</table>
<p>&nbsp;</p>
<table border="0" cellpadding="0" cellspacing="0"  width="650">
	<tr>
		<td width="5" height="179">&nbsp;</td>
		<td width="400" valign="bottom"><%=alCom.dameFacturasCheque(clavePago)%></td>
		<td width="245" valign="bottom">&nbsp;</td>
	</tr>
</table>
</body>
</html> 


