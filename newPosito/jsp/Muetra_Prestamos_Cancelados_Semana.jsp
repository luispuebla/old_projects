<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<jsp:useBean id="empleado" class="com.alpha.bd.ManagerVendedores" scope="page"/>
<jsp:useBean id="credito" class="com.alpha.bd.ManagerCredito" scope="page" />
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" scope="page" />

<html>
<head>
<title>Prestamos Cancelados.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="baseCSS.css" rel="stylesheet" type="text/css">
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
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 				
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>	
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%	String semana = request.getParameter("semana");
	String de = semana.substring(1,11);
	String a = semana.substring(18,28);
	String nombreVendedor = "";
	ResultSet rs = empleado.dameTodosPrestamosCancelados(semana);
	BigDecimal totalCancelado = new BigDecimal("0.00");	
	boolean existenPrestamos = false;
	while(rs.next() && !existenPrestamos){
		existenPrestamos = true;
	}
	if(existenPrestamos){ 
		rs.beforeFirst(); 
%>
	<table align="center" width="750" border="1" cellpadding="0" cellspacing="0">
	<caption>Registro de pr&eacute;stamos monetarios cancelados del <%=de%> al <%=a%></caption>
	  <tr>
		<th width="129">Fecha de Cancelaci&oacute;n</th>
		<th width="128">Cancel&oacute;</th>
		<th width="269">Pr&eacute;stamo a</th>		
		<th width="105">Fecha Pr&eacute;stamo</th>				
		<th width="107">Monto a Pr&eacute;stamo</th>						
	  </tr>	
<%			
		while(rs.next()){
			totalCancelado = totalCancelado.add(new BigDecimal(rs.getString("cantidadAPagar")));
%>
	  <tr>
		<td><div align="center"><%=rs.getString("fechaBaja")%> / <br/>
		<%=rs.getString("horaBaja")%></div></td>
		<td><div align="center"><%=rs.getString("cancelo")%></div></td>
		<td><%=rs.getString("NombreE")%></td>		
		<td><div align="center"><%=rs.getString("fechaPrestamo")%></div></td>				
		<td><div align="right">$<%=empleado.formatoDinero(rs.getString("cantidadAPagar"))%></div></td>
	  </tr>	
<%		}
		rs.close(); 
		totalCancelado = totalCancelado.setScale(2, RoundingMode.HALF_UP); %>
	  <tr>
	  	<th colspan="4">Suma Monto Cancelado</th>
		<td height="32"><div align="right"><b>$ <%=empleado.formatoDinero(totalCancelado.toString())%></b></div></td>
	  </tr>
	</table>
<%	}
	else{ %>
		<b class="roj">No hay registro de pr&eacute;stamos monetarios cancelados para la semana del <%=de%> al <%=a%></b>
<%	} 
	empleado.cierraConexion();
%>
<p><a href="Menu_Prestamos_Nominas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p><img src="imagenes/barraN.jpg"></p>
</body>
</html>
