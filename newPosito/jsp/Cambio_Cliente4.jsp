<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.html" %>
<jsp:useBean id="cliente" class="com.alpha.bd.ManagerClientes" scope="page" />

<html>
<head>
<title>Confirmacion Existencia del Cliente</title>
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
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String rfc = request.getParameter("rfc");
	int found= 0;
	found = cliente.existe2(rfc);	  
	if(found == 0) {
%>	
<p>&nbsp; </p>
<table width="500" border="0" align="center">
  <tr> 
    <td>  
<div align="center"> <b class="roj">No existe ningun cliente registrado con el RFC: <%=rfc%></b> </div>
 	</td>
  </tr>
</table>
<%
	 }
	 else if(found == 1) {
%>
<h1> Selecciona el Cliente y da Click en el bot&oacute;n de Enviar </h1>
<form name="form1" method="post" action="Consulta_Detalle_CXF.jsp">
        <table width="600" border="1">
          <tr> 
		  	<td width="10%"></td>
            <th width="90%" bgcolor="#CCCCCC">Nombre:</th>
          </tr>
<%
	ResultSet rs = cliente.datos_Cliente(rfc);
	while (rs.next()) {
%>
		 <tr>
		 <td><div align="center"> <input type="radio" name="nombre" value="<%= rs.getString("nombre") %>"> </div></td>
	      <td width="90%"> <%= rs.getString("nombre") %> <input type="hidden" name="rfc" value="<%=rfc%>"></td>
		  </tr>
<% 	
	} 
	cliente.cierraConexion();
%>
</table>
<p>
    <input type="submit" name="Submit" value="Enviar">
</p>
</form>
<%
	}
%>
  </tr>
</table>
<p align="center"><a href="Existe_Cliente_Con2.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
