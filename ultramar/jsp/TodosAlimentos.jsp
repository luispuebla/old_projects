<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<jsp:useBean id="alimento" class="com.ult.bd.ManagerAlimentos" />
<jsp:useBean id="division" class="com.ult.bd.ManagerDivisiones" />

<html>
<head>
<title>Todos los Alimentos</title>
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

function MandaSubmit(f){
	document.form1.submit();
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

<body onLoad="MM_preloadImages('imagenes/regr.gif')">

<p align="left">&nbsp;</p>
 <%
ResultSet todi = division.divisionesXArea("1");
while(todi.next()){
%>
<h1>
  _________________________________<%
out.print(todi.getString("nombre"));
%>_________________________________
</h1>  
<p></p>
<table width="542" border="1">
  <tr> 
    <td width="408" ><div align="center">Nombre</div></td>
    <td width="110" ><div align="center">Precio</div></td>
  </tr>
  <%	
		ResultSet rs = alimento.dame_Alimentos_Division(todi.getString("clave"));
		while (rs.next())
				{  
				%>
  <tr> 
    <td><strong><%= rs.getString("nombre") %><br>
      </strong><%= rs.getString("descripcion")%></td>
    <td><div align="center">$ <%= alimento.formatoDinero(rs.getString("precio")) %> </div></td>
  </tr>
  <%	      
		        } 
		%>
</table>
<p></p>
<%}%>
	<p>
</p>
<p></p>
<table width="742" align="center">
<td width="280">
<p align="right"><a href="Menu_Alimentos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="152" height="36" border="0" id="regresar1"></a></p>
</td>
<td width="186">                                                                   <font color="#FFFFFF">------------------</font></td>
<form name="form1" method="post" action="ImprimirAlimentos.jsp" target="_blank">
<td width="260">
<font color="#FFFFFF"><img src="imagenes/Imprimir1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)"></font>
</td>
</form>
</table>
<% division.cierraConexion();%>
<p><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font></p>
</body>
</html>


