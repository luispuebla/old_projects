<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %>
<jsp:useBean id="ticket" class="com.alpha.bd.ManagerTicket" />

<html>
<head>
<title>Cancelaciones Registradas</title>
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
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg','imagenes/Imprimir2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String tipoConsul = request.getParameter("tipoCon");
	String dia = "%%";
	String mes = request.getParameter("mes");
	String anio = request.getParameter("aaaa");
	if(tipoConsul.equalsIgnoreCase("dia")){
		dia = request.getParameter("dia");
	}
	String fecha = anio+"-"+mes+"-"+dia;
	if(tipoConsul.equalsIgnoreCase("total")){
		fecha = "NO";
	}
	
%>
<h1>Las Bajas Realizadas en �rden de la m&aacute;s reciente a la m&aacute;s antigua son: </h1>
<%
	ResultSet rs = ticket.dameCancelaciones(fecha);
%>
  <table width="600" border="1" align="center">
    <tr bgcolor="#CCCCCC"> 
      <th>N&uacute;mero<br />Ticket</th>
      <th>Fecha <br />Ticket</th>
	  <th>Tipo<br />Ticket</th>
	  <th>Ticket <br />Cobrado por</th>
	  <th>Monto<br />Ticket</th>
	  <th>Fecha<br />Baja</th>
  	  <th>Hora<br />Baja</th>
	</tr>
<%
	while (rs.next()){
%>
	<tr>
	  <td><div align="center"><%=rs.getInt("numTicket")%></div></td>
	  <td><div align="center"><%=rs.getString("fechaTicket")%></div></td>
	  <td><div align="center">
        <%
	  int elTipo = 0;
	  elTipo = rs.getInt("tipoTicket");
	  if(elTipo == 1){
	  	out.print("Contado");
	  }
	  else{
	  	out.print("Cr&eacute;dito");
	  }
	  %>
	    </div></td>
	  <td><div align="center">&nbsp;<%=rs.getString("cajeroTicket")%></div></td>
	  <td><div align="right">$ <%=ticket.formatoDinero(ticket.acortaLongitud((rs.getDouble("montoTotal")+"")))%></div></td>
	  <td><div align="center"><%=rs.getString("fechaBaja")%></div></td>
	  <td><div align="center"><%=rs.getString("horaBaja")%></div></td>	  	  	  	  	  
	</tr>
<%	
	}	
	rs.close();
	ticket.cierraConexion();
%>	
  </table>
  <div align="right">&nbsp;</div>

<a href="Menu_Bajas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


