<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="usuario" class="com.alpha.bd.ManagerVendedores" scope="page"/>

<html>
<head>
<title>Selecciona Vendedor para Cr&eacute;dito</title>
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

function MandaSubmit(f){	
	f.submit();
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


function funcionFoco(){
	if(document.form1 != null){
		document.form1.vendedor.focus();
	}
}

//-->
</script>
</head>
<%
 	String usuarioS = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuarioS == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
<body  onLoad="funcionFoco(), MM_preloadImages('imagenes/Regresar2.jpg')" >
<%	
	String vendedor = "";
	if(request.getParameter("vendedor") != null){
		vendedor = request.getParameter("vendedor");
	}
	ResultSet vendedores = usuario.listadoVendedores();
%>
<h1>Asignaci&oacute;n Cr&eacute;dito Interno por Producto </h1>
<form action="Existe_Ticket_Cred_Vend.jsp" target="_self" method="post" name="form1">
<table align="center" width="600" cellpadding="0" cellspacing="0" border="1">
  <caption>Selecciona el Vendedor a otorgar Cr&eacute;dito.</caption>
  <tr>
  	<th>Vendedor:</th>
	<td><select name="vendedor" onChange="MandaSubmit(document.forms[0])">
		<option value="0" <%if (vendedor.equals("")){%> selected <%}%>>SELECCIONA...</option>
<%
		while(vendedores.next()){ %>
		<option value="<%=vendedores.getString("claveVenta")%>" <%if (vendedor.equals(vendedores.getString("claveVenta"))){%> selected <%}%>><%=vendedores.getString("NombreE")%></option>
		
<%		} 
		vendedores.close();
		usuario.cierraConexion();
%>				
	</select></td>
  </tr>
</table>

</form>
<p><a href="Menu_Credito.jsp" target="mainFrame" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)" onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>	
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>