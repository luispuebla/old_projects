<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="ban" class="com.vas.bd.ManagerBancos" scope="page" />

<html>
<head>
<title>Baja Gasto</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String banco = request.getParameter("banco");
	String numero = request.getParameter("numero");
	
	int clave = ban.dameClave(banco,numero);

%>
<form name="form1" method="post" action="Conf_Baja_Gasto.jsp">
 <table width="650" border="1" align="center">
  <caption>
  INGRESOS
  </caption>
  <tr> 
    <td width="28"></th>
    <th width="116">Fecha</th>
    <th width="342">Concepto</th>
    <th width="136">Importe</th>
   </tr>
</table>
<table width="650" border="1" align="center">
<%
	ResultSet rs = ban.dameGastos(clave);
	int cont = 0;
	while(rs.next()){
%>
  <tr> 
  <td width="28"> <div align="center">
    <input type="radio" name="clave" value="<%= rs.getString("clave")%>" >
  </div></td>
    <td width="116"><div align="center"><%=rs.getString("fecha")%></div></td>
    <td width="342"><div align="left"><%=rs.getString("concepto")%></div></td>
    <td width="136"><div align="center">$ <%=ban.formatoDinero(rs.getString("importe"))%></div></td>
  </tr>
<%
		cont++;
	} 
	if(rs != null){
		rs.close();
	}
	ban.cierraConexion();			  		 							
%>	  
</table>
<p></p>
<%
if(cont == 0){
	out.println("No existen Ingresos, de un clic en Regresar para realizar una nueva Busqueda");
}
else{
%>
  <p><font> 
    <input type="submit" name="Submit" value="Enviar">
  </font> </p>
</form>
<%
}
%>
<p align="center"><a href="Baja_Gasto.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
