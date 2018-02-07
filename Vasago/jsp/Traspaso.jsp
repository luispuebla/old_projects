<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="ba" class="com.vas.bd.ManagerBancos" scope="page" />

<html>
<head>
<title>Traspaso</title>
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
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<p>&nbsp;</p>
<form name="form1" method="post" action="Conf_Traspaso.jsp">
<table width="459" border="0" align="center">
  <tr> 
    <th width="448">Selecciona la Cuenta de la que vamos a sacar Dinero: </th>
  </tr>
  <tr>
  	<td><div align="center">
  	         <select name="bancoS">
                    <% ResultSet bancos = ba.dameTodo();
			while(bancos.next()){%>
                    <option value="<%=bancos.getString("clave")%>"><%=bancos.getString("banco")+" --> "+bancos.getString("numero")%></option>
                    <%}
			if(bancos != null){
				bancos.close();
			}
			ba.cierraConexion();			  		 											
					%>		
	            </select>
	  </div></td>
  </tr>
  <tr>
  	<td><p>&nbsp;</p>  </td>
  </tr>
  <tr> 
    <th>Cantidad a Traspasar</th>
  </tr>
  <tr>
  	<td><div align="center">$ 
  	  <input name="importe" type="text" size="12">
	  </div></td>
  </tr>
  <tr>
  	<td><p>&nbsp;</p>  </td>
  </tr>
  <tr> 
    <th>Selecciona la Cuenta a la que vamos a meter Dinero: </th>
  </tr>
  <tr>
  	<td><div align="center">
  	          <select name="bancoM">
                    <% ResultSet bancos2 = ba.dameTodo();
			while(bancos2.next()){%>
                    <option value="<%=bancos2.getString("clave")%>"><%=bancos2.getString("banco")+" --> "+bancos2.getString("numero")%></option>
                    <%}
			if(bancos2 != null){
				bancos2.close();
			}
			ba.cierraConexion();			  		 											
					%>		
	            </select>
	  </div></td>
  </tr>
</table>
<p></p>
<input name="Submit" type="submit" value="Guardar">
</form>
<p align="center"><a href="Menu_Bancos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
