<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>

<jsp:useBean id="beb" class="com.ult.bd.ManagerBebidas" />
<jsp:useBean id="division" class="com.ult.bd.ManagerDivisiones" />

<html>
<head>
<title>Todas las Bebidas</title>
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
ResultSet todi = division.divisionesXArea("2");
while(todi.next()){
%>
<h1>
  _________________________________<%
out.print(todi.getString("nombre"));
%>_________________________________
</h1>  
<p></p>
<table width="550" border="1">
  <tr> 
    <td width="350" ><div align="center">Nombre</div></td>
    <td width="100" ><div align="center">Precio por Copeo</div></td>
     <td width="100" ><div align="center">Precio por Botella 3/4</div></td>
     <td width="100" ><div align="center">Precio por Botella Lt</div></td>
 </tr>
  <%	
		ResultSet rs = beb.dame_Bebidas_Division(todi.getString("clave"));
		while (rs.next())
				{  
			String precC = rs.getString("precioC");
			if(precC.equalsIgnoreCase("0.00")){
				precC = "&nbsp;";
			}
			else{
				precC = beb.formatoDinero(precC);
				precC = "$ "+precC;
			}
			String precB = rs.getString("precioB1");
			if(precB.equalsIgnoreCase("0.00")){
				precB = "&nbsp;";
			}
			else{
				precB = beb.formatoDinero(precB);
				precB = "$ "+precB;
			}

			String precB2 = rs.getString("precioB2");
			if(precB2.equalsIgnoreCase("0.00")){
				precB2 = "&nbsp;";
			}
			else{
				precB2 = beb.formatoDinero(precB2);
				precB2 = "$ "+precB2;
			}
				%>
  <tr> 
    <td><strong><%= rs.getString("nombre") %><br>
      </strong><%= rs.getString("descripcion")%></td>
    <td><div align="center"><%= precC %> </div></td>
    <td><div align="center"><%= precB %> </div></td>
    <td><div align="center"><%= precB2 %> </div></td>
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
<p align="right"><a href="Menu_Bebidas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="152" height="36" border="0" id="regresar1"></a></p>
</td>
<td width="186">                                                                   <font color="#FFFFFF">------------------</font></td>
<form name="form1" method="post" action="ImprimirBebidas.jsp" target="_blank">
<td width="260">
<font color="#FFFFFF"><img src="imagenes/Imprimir1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)"></font>
</td>
</form>
</table>
<% beb.cierraConexion();%>
<p><font size="2"><img src="imagenes/barraN.jpg" width="532" height="82"></font></p>
</body>
</html>


