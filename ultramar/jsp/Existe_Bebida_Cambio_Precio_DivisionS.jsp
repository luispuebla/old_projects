<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="div" class="com.ult.bd.ManagerDivisiones" scope="page" />

<html>
<head>
<title>Cambio de Precio por Division</title>
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

function MandaForma0(forma) {
	document.form1.submit();

}

//-->
</script>
</head>
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("Productos"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>	
<body leftmargin="0" topmargin="0" onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<p>&nbsp;</p>
<h1>Selecciona una Divisi&oacute;n para el cambio de Precios</h1>
<form name="form1" method="post" action="Cambio_Bebida_Precio_DivisionS.jsp">
<table width="44%" border="0" align="center">
  <tr> 
    <td width="60%"> 
        <div align="center">
          <select name="division" onChange="MandaForma0(this.form)">
            <% ResultSet rs = div.divisionesXArea("2");
		while(rs.next()){%>
            <option value="<%=rs.getString("clave")%>"><%=rs.getString("nombre")%></option>
            <%}%>
          </select>
        </div>
    </td>
  </tr>
</table>
 </form>
 <% div.cierraConexion();%>
<p align="center"><font color="#FFFFFF" face="Eras Medium ITC"><a href="Menu_Precios_BebidasS.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regresar" width="139" height="35" border="0"></a></font></p>
<p align="center"><font size="2" face="Eras Medium ITC"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>
