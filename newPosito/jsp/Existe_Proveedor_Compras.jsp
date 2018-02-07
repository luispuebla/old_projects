<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="prov" class="com.alpha.bd.ManagerProveedores"  scope="page"/>
<html>
<head>
<title>Consulta Compras por Proveedor</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
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

function MandaSubmit(f){	
	f.submit();
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
	ResultSet rsPro = prov.dameProveedores();
%>
<p>&nbsp;</p>
<form name="form1" method="post" action="ComprasXProveedor.jsp">
<table width="600" border="1" align="center">
  <tr> 
    <th colspan="3"> <h1>Selecciona el Proveedor Correspondiente para mostrar las compras realizadas: </h1></th>
  </tr>
  <tr>
  	<th width="61">&nbsp;</th>
	<th width="131">RFC</th>
	<th width="386">Nombre<br/>Proveedor</th>
  </tr>
<%
	while (rsPro.next()){
%>	 
  <tr>
    <td><div align="center">
      <input type="radio" name="elRFC" value="<%= rsPro.getString("rfc")%>" onClick="MandaSubmit(document.forms[0])">
    </div></td>
	<td><div align="center"><%=rsPro.getString("RFC").toUpperCase()%></div></td>
	<td><%=rsPro.getString("Nombre")%></td>
  </tr>
<%
	}
	prov.cierraConexion();
%>	  
</table>
<p><input type="submit" name="Submit" value="Enviar"></p>
</form>
<p align="center"><a href="Menu_Proveedores.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
