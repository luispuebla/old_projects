<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="ban" class="com.vas.bd.ManagerBancos" />

<html>
<head>
<title>Modifica Cuenta</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
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
	if (usuario == null || !tipou.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String banco = request.getParameter("banco");
	String numero = request.getParameter("numero");

	boolean exis = true;
	exis = ban.existe(banco, numero);
	
	if(exis){ %>

<form name="form1" method="post" action="Conf_Cambio_Cuenta.jsp">
<% 
	ResultSet rs = ban.datos_Cuenta(banco,numero);
	while (rs.next()) {
%>
       
<h1>Realiza las modificaciones necesarias y da Click en el bot&oacute;n de Guardar </h1>
	<table width="279" align="center">
		<tr align="left">
			<th width="175" align="left"><b>Campo NO Editable --></b></th>
			<td width="92" align="left"><b class="roj">**</b></td>			
		</tr>
  </table>		
<table width="762" border="1" align="center">
  <tr> 
	<th width="126" bgcolor="#CCCCCC">N&uacute;mero:</th>
	<td width="620"><input name="numero" type="text" id="numero" value="<%= rs.getString("numero") %>" size="30" maxlength="30" readonly="true"> 
	<b class="roj">**</b></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Banco:</th>
	<td><input name="banco" type="text" id="banco" value="<%= rs.getString("banco")%>" size="100" maxlength="100"></td>
  </tr>
  <tr> 
	<th width="126" bgcolor="#CCCCCC">Importe Inicial :</th>
	<td width="620"> $ <input name="importeI" type="text" id="importeI" value="<%= ban.formatoDinero(rs.getString("importeInicial")) %>" size="15" maxlength="12" readonly="true"> 
	<b class="roj">**</b></td>
  </tr>
  <tr> 
	<th width="126" bgcolor="#CCCCCC">Importe Actual :</th>
	<td width="620"> $ <input name="importeA" type="text" id="importeA" value="<%= ban.formatoDinero(rs.getString("importeActual")) %>" size="15" maxlength="12">	</td>
  </tr>
</table>
		
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
		 <input type="hidden" name="clave" value="<%=rs.getString("clave")%>"> 
</form>
<p> 
  <% }
	if(rs != null){
		rs.close();
	}
	ban.cierraConexion();			  
 }
 else{ %>
 	<b class="roj">La Cuenta no se encuentra Registrada en el Sistema</b>	
<%
}
%>
</p>
<p align="center"><a href="Existe_Banco_Cambio.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
