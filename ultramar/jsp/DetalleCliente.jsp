<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<jsp:useBean id="Clientes" class="com.ult.bd.ManagerClientes" scope="page" />

<html>
<head>
<title>Detalle Cliente</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

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
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja"))){
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	
	}
	String clie = request.getQueryString();	
	while(clie.lastIndexOf("%20")!= -1){
		int ocurrencia = clie.lastIndexOf("%20");
		clie=clie.replaceAll("%20"," ");
	}
	ResultSet rs = Clientes.datos_Cliente(clie);
	while(rs.next()){
%>
<h1>Detalle de<strong> <%=rs.getString("nombre")%></strong></h1>
<table width="718" border="1" align="center">
  <tr> 
    <td width="96" bgcolor="#DFE1EC" ><div align="center">RFC</div></td>
    <td width="96" bgcolor="#DFE1EC" ><div align="center">Folio RFC</div></td>
    <td width="131" bgcolor="#DFE1EC" ><div align="center">CURP</div></td>
    <td width="239" bgcolor="#DFE1EC" ><div align="center">Nombre</div></td>
    <td width="106" bgcolor="#DFE1EC" ><div align="center">Alta</div></td>
  </tr>
</table>
<table width="718" border="1" align="center">
  <tr> 
    <td width="96"><div align="center"><%=clie%></div></td>
    <td width="96" ><div align="center"><%=rs.getString("folio")%></div></td>
    <td width="131" ><div align="center"><%=rs.getString("CURP")%></div></td>
    <td width="239" ><div align="center"><%=rs.getString("nombre")%></div></td>
    <td width="106" ><div align="center"><%=rs.getString("alta")%></div></td>
  </tr>
</table>
<p></p>
<h1>Direcci&oacute;n:</h1>
<table width="604" border="1" align="center">
  <tr> 
    <td width="212" bgcolor="#DFE1EC" ><div align="center">Direcci&oacute;n</div></td>
    <td width="91" bgcolor="#DFE1EC" ><div align="center">Colonia</div></td>
    <td width="138" bgcolor="#DFE1EC" ><div align="center">Municipio/Delegaci&oacute;n</div></td>
    <td width="40" bgcolor="#DFE1EC" ><div align="center">CP</div></td>
    <td width="89" bgcolor="#DFE1EC" ><div align="center">Ciudad</div></td>
  </tr>
</table>
<table width="604" border="1" align="center">
  <tr> 
    <td width="212" ><div align="center"><%=rs.getString("direccion")%></div></td>
    <td width="91" ><div align="center"><%=rs.getString("colonia")%></div></td>
    <td width="138" ><div align="center"><%=rs.getString("delegacion")%></div></td>
    <td width="40" ><div align="center"><%=rs.getString("cp") %></div></td>
    <td width="89" ><div align="center"><%=rs.getString("Ciudad") %></div></td>
  </tr>
</table>
<p></p>
<h1>Tel&eacute;fonos:</h1>
<table width="446" border="1" align="center">
  <tr> 
    <td width="124" bgcolor="#DFE1EC" ><div align="center">Tel&eacute;fono 1</div></td>
    <td width="155" bgcolor="#DFE1EC" ><div align="center">Tel&eacute;fono 2</div></td>
    <td width="145" bgcolor="#DFE1EC" ><div align="center">Fax</div></td>
  </tr>
</table>
<table width="446" border="1" align="center">
  <tr> 
    <td width="124"><div align="center"><%
	if(rs.getString("tel1").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("tel1"));
		}%></div></td>
    <td width="155" ><div align="center"><%
	if(rs.getString("tel2").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("tel2"));
		}%></div></td>
    <td width="145" ><div align="center"><%
	if(rs.getString("fax").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("fax"));
		}%></div></td>
  </tr>
</table>
<p></p>
<h1>Correo Electr&oacute;nico :</h1>
  <div align="center">
    <table width="586" border="1">
      <tr> 
        <td width="65" bgcolor="#DFE1EC">e-mail</td>
        <td width="505"><div align="center"><%
	if(rs.getString("email").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("email"));
		}%></div></td>
      </tr>
    </table>
<p></p>
  <h1>Contacto:</h1>
  <table width="330" border="1" align="center">
    <tr> 
      <td width="320" bgcolor="#DFE1EC" ><div align="center">Contacto</div></td>
    </tr>
  </table>
  <table width="330" border="1" align="center">
    <tr> 
      <td width="320" ><div align="center"> 
          <%
	if(rs.getString("contacto").equals("")){
			out.print("&nbsp;");
		}
	else{
			out.print(rs.getString("contacto"));
		}%>
        </div></td>
    </tr>
  </table>
<%
	}
	Clientes.cierraConexion();
%>
  </div>
  <p>&nbsp;</p>
<p align="center"><a href="TodosCli.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
