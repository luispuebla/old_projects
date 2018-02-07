<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.vas.bd.ManagerLogin" scope="page" />
<jsp:useBean id="li" class="com.vas.bd.ManagerLineas" scope="page" />
<jsp:useBean id="mar" class="com.vas.bd.ManagerMarcas" scope="page" />

<html>
<head>
<title>Baja de Producto</title>
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

function MandaForma1(forma) {
	if(document.form1.marca.value == 0){
	}
	else{
		forma.submit();
	}
}

function MandaForma2(forma) {
	if(document.form1.linea.value == 0){
	}
	else{
		forma.submit();
	}
}

//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<p>&nbsp;</p>
<form name="form1" method="post" action="Selecciona_Producto_Baja.jsp">
<table width="735" border="0" align="center">
  <tr> 
    <th width="1503"> <h1>Selecciona la L&iacute;nea del Producto para su Baja: </h1>
      </th>
  </tr>
  <tr>
  	<td><div align="center">
  	          <select name="linea" onChange="MandaForma1(this.form)">
			  <option value="0" selected>SELECCIONA..</option>
            <% ResultSet rs2 = li.dameLineas();
			while(rs2.next()){%>
            <option value="<%=rs2.getString("clave")%>"><%=rs2.getString("nombre")%></option>
            <%}
			if(rs2 != null){
				rs2.close();
			}
			li.cierraConexion();
			%>		
		</select>
	  </div></td>
  </tr>
  <tr> 
          <td>&nbsp;  </td>                
  </tr>
  <tr> 
    <th width="1503"> <h1>Selecciona la Marca del Producto para su Baja:</h1>      </th>
  </tr>
    <tr>
  	<td><div align="center">
  	          <select name="marca" onChange="MandaForma2(this.form)">
			  <option value="0" selected>SELECCIONA..</option>
            <% ResultSet rs3 = mar.dameMarcas();
			while(rs3.next()){%>
            <option value="<%=rs3.getString("clave")%>"><%=rs3.getString("nombre")%></option>
            <%}
			if(rs3 != null){
				rs3.close();
			}
			mar.cierraConexion();
			%>		
		</select>
	  </div></td>
  </tr>
</table>
</form>
<p align="center"><a href="Menu_Productos2.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
