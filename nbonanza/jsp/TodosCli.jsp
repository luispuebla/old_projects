<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" scope="page" />

<html>
<head>
<title>Todos los Clientes</title>
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
	if (usuario == null || (!tipou.equalsIgnoreCase("administrador") &&  !tipou.equalsIgnoreCase("facturacion")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
<h1>Todos los Clientes registrados en Sistema (Ordenados Alfabeticamente) son:</h1>
<table width="780" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="93" ><div align="center">RFC / CURP </div></th>
    <th width="169" ><div align="center">Nombre</div></th>
    <th width="199" ><div align="center">Direcci�n</div></th>
    <th width="119" ><div align="center">Cont&aacute;cto <br />y Tel&eacute;fonos</div></th>
    <th width="166" ><div align="center">Tipo</div></th>
  </tr>
<%	
		ResultSet rs = cliente.dameClientes();
		while (rs.next()){  
			String contacto = rs.getString("contacto");
			String tel1 =  rs.getString("tel1");
			String tel2 = rs.getString("tel2");
			if(contacto.trim().equals("")){
				contacto = "&nbsp;";
			}
			if(tel1.trim().equals("")){
				tel1 = "&nbsp;";
			}	
			if(tel2.trim().equals("")){
				tel2 = "&nbsp;";
			}	
			
%>
  <tr> 
    <td align="center"><a href="DetalleCliente.jsp?<%=rs.getString("rfc")+"*!*"+rs.getString("nombre")%>"><%= rs.getString("rfc")%></a> / <br/><%=rs.getString("curp")%></td>
    <td><%= rs.getString("nombre")%></td>
    <td><%= rs.getString("direccion")%>, Col. <%=rs.getString("colonia")%>, Del.<%= rs.getString("delegacion")%>,Ciudad <%=rs.getString("ciudad")%> </td>
    <td align="center"><%= contacto%><br/><%= tel1%> <br /> <%=tel2 %></td>
<%
	String fraseTipoCliente = "";
	int tipoCliente = rs.getInt("tipoCliente");
	if (tipoCliente == 1){
		fraseTipoCliente = "Con Cr&eacute;dito";
		fraseTipoCliente += " <br /> " +"Cr&eacute;dito: $" +cliente.formatoDinero(rs.getString("credito"));
		fraseTipoCliente += " <br /> " +"Saldo Disponible: $" +cliente.formatoDinero(rs.getString("saldo"));
	}
	else{
		fraseTipoCliente = "Sin Cr&eacute;dito";
	}
%>	
    <td align="center"><div align="left"><%= fraseTipoCliente %></div></td>
  </tr>
<%	      
		        } 
%>
</table>

<table width="742" align="center">
<td width="280">
<p align="right"><a href="Consultas_Clientes.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="132" height="41" border="0" id="regresar1"></a></p>
</td>
<td width="186">&nbsp; </td>
<form name="form1" method="post" action="ImprimirClientes.jsp" target="_blank">
<td width="260">
<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Imprimir2.jpg',1)"><img src="imagenes/Imprimir1.jpg" name="Retache" width="132" height="41" border="0" onClick="MandaSubmit(this.form)"></a>
</td>
</form>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


