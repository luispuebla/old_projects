<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="personal" class="com.vas.bd.ManagerPersonal" />

<html>
<head>
<title>Clientes por Agente</title>
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
    String agente = request.getParameter("agente"); 
	%>
<jsp:setProperty name="personal" property="usuario" value="<%=agente%>"/>
<%
	if (personal.yaExiste()) {
	ResultSet nom = personal.dameNombreAgente(agente);
	String nombreAgente = new String();
	while(nom.next()){
		nombreAgente = nom.getString("NombreCompleto");
	}
	if(nom != null){
		nom.close();
	}
	personal.cierraConexion();
%>
</p>
<p><font size="5" face="Eras Medium ITC"><strong>Clientes de <%= nombreAgente%></strong></font> </p>
<font face="Eras Medium ITC" size="3" color="#000099"></font>
<table width="782" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="74"><div align="center"><strong>RFC</strong></div></th>
    <th width="193"><div align="center"><strong>Nombre</strong></div></th>
    <th width="193"><div align="center"><strong>Dirección</strong></div></th>
    <th width="111"><div align="center"><strong>Delegaci&oacute;n / Municipio</strong></div></th>
    <th width="98"><div align="center">Tel&eacute;fono</div></th>
    <th width="73"><div align="center"><strong>Fax</strong></div></th>
  </tr>
<%		
		ResultSet cliXagen = cliente.ClientesXAgente(agente);
		while (cliXagen.next()){  
		String tel = cliXagen.getString("tel1");
		if( tel.equals("")){
			tel = "&nbsp;";
		}
		String fax = cliXagen.getString("fax");
		if( fax.equals("")){
			fax = "&nbsp;";
		}
%>
  <tr> 
    <td><%= cliXagen.getString("rfc")%></td>
    <td><%= cliXagen.getString("nombre")%></td>
    <td><%= cliXagen.getString("direccion")%></td>
    <td><%= cliXagen.getString("delegacion")%></td>
    <td><div align="center"><%= tel%></div></td>
    <td><div align="center"><%=fax%></div></td>
  </tr>
<%	      
		} 
		if(cliXagen != null){
			cliXagen.close();
		}
		cliente.cierraConexion();
%>
</table>
</font>
</p>
<p align="center"><a href="Consultas_Clientes.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<%	     
	}
	 else{ %>
		<b class="roj">El Agente no se encuentra registrado en el Sistema.</b>

<p align="center"><a href="Consultas_Clientes.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p> 
<%
	}
%>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

