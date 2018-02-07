<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>

<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="div" class="com.ult.bd.ManagerDivisiones" scope="page" />

<html>
<head>
<title>Cambio de Precio por División por Porcentaje</title>
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
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<p>&nbsp;</p>
<p></p>
<form name="form1" method="post" action="Cambio_Bebida_Precio_Porcentaje_Division.jsp">
<h1>Introduce los datos para realizar los cambios en Precios:</h1> 
        <table width="30%" height="97" border="1" align="center">
		  <caption>Este aumento monetario solo aplica en bebida por copa</caption>
          <th width="37%">Nombre:</td>
          <td width="63%" height="39">
          <select name="division">
            <% ResultSet rs = div.divisionesXArea("2");
		
		while(rs.next()){%>
            <option value="<%=rs.getString("clave")%>"><%=rs.getString("nombre")%></option>
            <%}%>
          </select>
     		</td>
          <tr> 
            <th>Aumento:</td> 
            <td height="43"><input type="text" name="aumento" size="5" maxlength="3" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}" >
              pesos</td>
			  <tr> 
            <th>Decremento:</td> 
            <td height="43"><input type="text" name="decremento" size="5" maxlength="3" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}">
              pesos</td>
			  </tr>
        </table>
        <table width="75%" border="0" align="center">
          <tr> 
            <td><div align="center"> 
                <p>&nbsp;</p>
                <p>
                  <input type="submit" name="Submit" value="Enviar">
                  <input type="reset" name="Borrar" value="Borrar">
                  </p>
              </div></td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </form>
	  <% div.cierraConexion();%>
<p align="center"><a href="Menu_Precios_Bebidas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="139" height="35" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>
