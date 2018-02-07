<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="personalM" class="com.ult.bd.ManagerPersonal" scope="page" />

<html>
<head>
<title>Detalle</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

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
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

	String queryString = request.getQueryString();
	String vacio = "&nbsp;";
%>
<jsp:setProperty name="personalM" property="usuario" value="<%=queryString%>"/>
 <h1>Detalle de Personal:</h1>

<table width="796" border="1" align="center">
  <tr> 
    <th width="45" bgcolor="#DFE1EC" ><div align="center">Clave:</div></th>
    <th width="96" bgcolor="#DFE1EC" ><div align="center">Tipo<br /> Usuario :</div></th>
    <th width="103" bgcolor="#DFE1EC" ><div align="center">Nombre:</div></th>
    <th width="91" bgcolor="#DFE1EC" ><div align="center">Apellido Paterno:</div></th>
    <th width="87" bgcolor="#DFE1EC" ><div align="center">Apellido Materno:</div></th>
    <th width="74" bgcolor="#DFE1EC" ><div align="center">Area:</div></th>	
    <th width="87" bgcolor="#DFE1EC" ><div align="center">Puesto:</div></th>
  </tr>
<%
	ResultSet rs = personalM.datosUsuario();
	while(rs.next()){
		String tipoDelUsuario = rs.getString("Tipo");
%>
  <tr> 
    <td width="45"><div align="center"><%=queryString%></div></td>
    <td width="96"><div align="center">
<% 
		if (tipoDelUsuario.equalsIgnoreCase("Admin")){
%>
	Administrador
<%	
		}	
		else{
%>
	Usuario Limitado </div></td>	 
<%
		}
%>	  	
    <td width="103" ><div align="center"><%=rs.getString("Nombre")%></div></td>
    <td width="91" ><div align="center"><%=rs.getString("APaterno")%></div></td>
    <td width="87" ><div align="center"><%=rs.getString("AMaterno")%></div></td>
    <td width="74" ><div align="center"><%=rs.getString("Area")%></div></td>
    <td width="87" ><div align="center"><%=rs.getString("Puesto") %></div></td>
  </tr>
<%
	}
%>	  
</table>
<% personalM.cierraConexion();%>
<br />
<a href="ConsultaPersonal.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
<br />
<img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>
