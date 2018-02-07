<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" scope="page" />
<jsp:useBean id="bloquea" class="com.alpha.bd.BloqueaClientes" scope="page" />

<html>
<head>
<title>Detalle Cliente</title>
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
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	bloquea.depura();
	String rfc = request.getQueryString();
	String nombre = "";	
	rfc = request.getQueryString().substring(0,request.getQueryString().indexOf("*!*"));
	rfc = cliente.remueveEspacios(rfc);
	nombre = request.getQueryString().substring(request.getQueryString().lastIndexOf("*!*")+3,request.getQueryString().length());
	nombre = cliente.remueveEspacios(nombre);	
	ResultSet rs = cliente.datos_Cliente_N(rfc, nombre);
	while(rs.next()){
%>
<h1>Detalle de<strong> <%=rs.getString("nombre")%></strong></h1>
<table width="500" border="1" align="center">
  <tr> 
    <th width="110" ><div align="center">RFC</div></th>
    <th width="232"><div align="center">Nombre</div></th>
    <th width="136"><div align="center">Alta</div></th>
  </tr>
  <tr> 
    <td width="110"><div align="center"><%=rfc%></div></td>
    <td width="232" ><div align="center"><%=rs.getString("nombre")%></div></td>
    <td width="136" ><div align="center"><%=rs.getString("alta")%></div></td>
  </tr>
</table>
<p></p>
<h1>Direcci&oacute;n:</h1>
<table width="650" border="1" align="center">
  <tr> 
    <th width="195"><div align="center">Calle</div></th>
    <th width="127" ><div align="center">Colonia</div></th>
    <th width="108" ><div align="center">Municipio/<br />Delegaci&oacute;n</div></th>
    <th width="68" ><div align="center">C.P.</div></th>
    <th width="118" ><div align="center">Ciudad</div></th>
  </tr>
  <tr> 
    <td width="195" ><div align="center"><%=rs.getString("direccion")%></div></td>
    <td width="127" ><div align="center"><%=rs.getString("colonia")%></div></td>
    <td width="108" ><div align="center"><%=rs.getString("delegacion")%></div></td>
    <td width="68" ><div align="center"><%=rs.getString("cp") %></div></td>
    <td width="118" ><div align="center"><%=rs.getString("ciudad") %></div></td>
  </tr>
</table>
<p></p>
<h1>Tel&eacute;fonos y Cont&aacute;cto:</h1>
<table width="500" border="1" align="center">
  <tr> 
    <th width="135"><div align="center">Tel&eacute;fono 1</div></th>
    <th width="183"><div align="center">Tel&eacute;fono 2</div></th>
    <th width="160"><div align="center">Cont&aacute;cto</div></th>
  </tr>
  <tr> 
    <td width="135"><div align="center"><%
	if(rs.getString("tel1").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("tel1"));
		}%></div></td>
    <td width="183" ><div align="center"><%
	if(rs.getString("tel2").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("tel2"));
		}%></div></td>
    <td width="160" ><div align="center"><%
	if(rs.getString("contacto").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("contacto"));
		}%></div></td>
  </tr>
</table>
<p></p>
<h1>Tipo de Cliente: 
<% if(rs.getInt("tipoCliente") == 0){
%>
	Sin Cr&eacute;dito
<%
	}
	else{
%>
	Con cr&eacute;dito
<%
	}
%>
</h1>
<% if(rs.getInt("tipoCliente") == 1){ %>
<table width="500" border="1" align="center">
  <tr> 
    <th width="148" ><div align="center">Cr&eacute;dito</div></th>
    <th width="88" ><div align="center">Paga a</div></th>
    <th width="148" ><div align="center">Saldo <br />Disponible</div></th>
    <th width="88" ><div align="center">Bloqueado</div></th>
  </tr>
  <tr> 
    <td width="148" ><div align="center"><%=cliente.formatoDinero(rs.getString("credito"))%></div></td>
    <td width="88" ><div align="center"><%=rs.getString("tiempoCredito")%> d&iacute;as</div></td>
    <td width="148" ><div align="center"><%=cliente.formatoDinero(rs.getString("saldo"))%></div></td>	
	<td width="88" ><div align="center">
		<% if(rs.getInt("bloqueoXPagoV") == 1){%>
			S&iacute;
		<% }else{%>
			No
		<% } %>
	</div></td>	
  </tr>
</table>
<%
		}
	}
	cliente.cierraConexion();
%>
<p>&nbsp;</p>
<p align="center"><a href="TodosCli.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
