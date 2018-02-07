<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="ma" class="com.vas.bd.ManagerMarcas" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" />

<html>
<head>
<title>Modifica Marca</title>
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
	String clave = request.getParameter("linea");

	boolean exis = true;
	exis = ma.existe(clave);
	
	if(exis){ %>

<form name="form1" method="post" action="Conf_Cambio_Marca.jsp">
<% 
	ResultSet rs = ma.datos_Marca(clave);
	while (rs.next()) {
%>
       
<h1>Realiza las modificaciones necesarias y da Click en el bot&oacute;n de Guardar </h1>
	<table width="286" align="center">
		<tr align="left">
			<th width="193" align="left"><b>Campo NO Editable --></b></th>
			<td width="81" align="left"><b class="roj">**</b></td>			
		</tr>
  </table>		
<table width="274" border="1" align="center">
  <tr> 
	<th width="99" bgcolor="#CCCCCC">Clave:</th>
	<td width="159"><input type="text" name="clave" value="<%= rs.getString("clave") %>" readonly="true" size="4" maxlength="2"> <b class="roj">**</b></td>
  </tr>
  <tr> 
	<th bgcolor="#CCCCCC">Nombre:</th>
	<td><input type="text" name="nombre" value="<%= rs.getString("nombre")%>" size="20" maxlength="20"></td>
  </tr>
</table>
		
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<p> 
  <% }
  	if(rs != null){
		rs.close();
	}
	ma.cierraConexion();
 }
 else{ %>
 	<b class="roj">La Marca no se encuentra Registrada en el Sistema</b>	
<%
}
%>
</p>
<p align="center"><a href="Existe_Marca_Cambio.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
