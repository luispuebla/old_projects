<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />

<html>
<head>
<title>Todos los Clientes</title>
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
%>
<h1>Todos los Clientes registrados en Sistema son:</h1>
<table width="986" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="86" ><div align="center">RFC</div></th>
    <th width="190" ><div align="center">Nombre</div></th>
    <th width="202" ><div align="center">Dirección</div></th>
    <th width="111" ><div align="center">Colonia</div></th>
    <th width="119" ><div align="center">Ciudad</div></th>
    <th width="73" ><div align="center">Tel&eacute;fono</div></th>
	 <th width="159" ><div align="center">Contacto</div></th>
  </tr>
<%	
		ResultSet rs = cliente.dameClientes();
		while (rs.next())
		{  
		String tel = rs.getString("tel1");
		if( tel.equals("")){
			tel = "&nbsp;";
		}
		String con = rs.getString("contacto");
		if( con.equals("")){
			con = "&nbsp;";
		}
%>
  <tr> 
    <td align="center"><div align="center"><a href="DetalleCliente.jsp?<%=rs.getString("rfc")%>"><%= rs.getString("rfc")%></a></div></td>
    <td><%= rs.getString("nombre")%></td>
    <td><%= rs.getString("direccion")%></td>
    <td align="center"><%= rs.getString("colonia")%></td>
    <td align="center"><%= rs.getString("ciudad")%></td>
    <td align="center"><%= tel %></td>
	<td width="159" ><div align="left"><%= con%></div></td>
  </tr>
<%	       
		 } 
		 if(rs != null){
		 	rs.close();
		 }
		 cliente.cierraConexion();
%>
</table>
<p></p>
<table width="742" align="center">
<td width="280">
<p align="right"><a href="Consultas_Clientes.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="152" height="36" border="0" id="regresar1"></a></p>
</td>
<td width="186">                                                                   <font color="#FFFFFF">------------------</font></td>
<form name="form1" method="post" action="ImprimirClientes.jsp" target="_blank">
<td width="260">
<font color="#FFFFFF"><img src="imagenes/Imprimir1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)"></font>
</td>
</form>
</table>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


