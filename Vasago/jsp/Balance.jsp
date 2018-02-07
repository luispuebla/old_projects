<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="ban" class="com.vas.bd.ManagerBancos" />

<html>
<head>
<title>Balance</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
	document.form1.submit();
}
//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin"))){
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	
	String banco = request.getParameter("banco");
	String cuenta = request.getParameter("numero");
	String mes = request.getParameter("mes");
	String mes1 = new String();
	if(mes.equalsIgnoreCase("1")){
		mes1 = "Enero";
	}
	if(mes.equalsIgnoreCase("2")){
		mes1 = "Febrero";
	}
	if(mes.equalsIgnoreCase("3")){
		mes1 = "Marzo";
	}
	if(mes.equalsIgnoreCase("4")){
		mes1 = "Abril";
	}
	if(mes.equalsIgnoreCase("5")){
		mes1 = "Mayo";
	}
	if(mes.equalsIgnoreCase("6")){
		mes1 = "Junio";
	}
	if(mes.equalsIgnoreCase("7")){
		mes1 = "Julio";
	}
	if(mes.equalsIgnoreCase("8")){
		mes1 = "Agosto";
	}
	if(mes.equalsIgnoreCase("9")){
		mes1 = "Septiembre";
	}
	if(mes.equalsIgnoreCase("10")){
		mes1 = "Octubre";
	}
	if(mes.equalsIgnoreCase("11")){
		mes1 = "Noviembre";
	}
	if(mes.equalsIgnoreCase("12")){
		mes1 = "Diciembre";
	}
	String ano = request.getParameter("ano");
	int clave = ban.dameClave(banco,cuenta);
	double totalI = 0.0;
	double totalG = 0.0;
%>
<h1>Balance para <%= banco%> en la Cuenta <%= cuenta%> </h1>
<h1><%= mes1%> del <%= ano%></h1>
<table width="709" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="145" ><div align="center">Fecha</div></th>
    <th width="296" ><div align="center">Concepto</div></th>
    <th width="172" ><div align="center">Ingreso</div></th>
    <th width="145" ><div align="center">Gasto</div></th>
  </tr>
<%	
		ResultSet rs = ban.dameBalance(clave, mes, ano);
		while (rs.next())
		{  
%>
  <tr> 
    <td><div align="center"><%= rs.getString("fecha")%></div></td>
    <td><div align="center"><%= rs.getString("concepto")%></div></td>
<%
	if(rs.getString("tipo").equalsIgnoreCase("1")){
		totalI = totalI + rs.getDouble("importe");
%>
    <td><div align="center">$ <%= ban.formatoDinero(ban.acortaLongitud((rs.getString("importe"))))%></div></td>
	<td align="center">&nbsp;</td>
<%
	}else{
		totalG = totalG + rs.getDouble("importe");
%>
    <td align="center">&nbsp;</td>
    <td><div align="center">$ <%= ban.formatoDinero(ban.acortaLongitud((rs.getString("importe"))))%></div></td>
<%
	}
%>
  </tr>
<%	       
		 } 
	if(rs != null){
		rs.close();
	}
	ban.cierraConexion();			  		 									 
%>
  <tr> 
    <td><div align="center">&nbsp;</div></td>
    <td><div align="right"><strong>&nbsp;TOTAL:</strong></div></td>
    <td><div align="center">$ <%= ban.formatoDinero(ban.acortaLongitud(totalI+""))%></div></td>
    <td><div align="center">$ <%= ban.formatoDinero(ban.acortaLongitud(totalG+""))%></div></td>
</tr>
</table>
<p></p>
<table width="742" align="center">
<td width="280">
<p align="right"><a href="Menu_Bancos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="152" height="36" border="0" id="regresar1"></a></p>
</td>
<td width="186">                                                                   <font color="#FFFFFF">------------------</font></td>
<form name="form1" method="post" action="ImprimirBalance.jsp" target="_blank">
<input type="hidden" name="banco" value="<%=banco%>">
<input type="hidden" name="numero" value="<%=cuenta%>">
<input type="hidden" name="mes" value="<%=mes%>">
<input type="hidden" name="ano" value="<%=ano%>">

<td width="260">
<font color="#FFFFFF"><img src="imagenes/Imprimir1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)"></font>
</td>
</form>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


