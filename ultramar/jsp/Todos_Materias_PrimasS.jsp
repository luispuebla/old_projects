<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="error.jsp" %>
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="mp" class="com.ult.bd.ManagerMateriasPrimas" />

<html>
<head>
<title>Todas las Materias Primas</title>
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
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (!usuario.equalsIgnoreCase("producto") || !tipou.equalsIgnoreCase("Simple"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
%>
<h1>Todas las Materias Primas registradas en Sistema son:</h1>
<table width="986" border="1" align="center">
  <tr bgcolor="#CCCCCC"> 
    <th width="229" ><div align="center">Nombre</div></th>
    <th width="97" ><div align="center">Tipo</div></th>
    <th width="127" ><div align="center">Tipo Alimento</div></th>
    <th width="124" ><div align="center">Costo Unidad</div></th>
    <th width="102" ><div align="center">Costo Kilo</div></th>
    <th width="134" ><div align="center">Costo Botella 1</div></th>
    <th width="127" ><div align="center">Costo Botella 2</div></th>
  </tr>
  <%	
		ResultSet rs = mp.dameMateriasPrimas();
		while (rs.next())
		{  
		String cu = "$ "+rs.getString("costounidad");
		if( cu.equals("$ 0.00")){
			cu = "&nbsp;";
		}

		String ck = "$ "+rs.getString("costokg");
		if( ck.equals("$ 0.00")){
			ck = "&nbsp;";
		}

		String cb = "$ "+rs.getString("costoBotella1");
		if( cb.equals("$ 0.00")){
			cb = "&nbsp;";
		}

		String cb2 = "$ "+rs.getString("costoBotella2");
		if( cb2.equals("$ 0.00")){
			cb2 = "&nbsp;";
		}

		String ti = rs.getString("tipo");
		if( ti.equals("1")){
			ti = "Alimento";
		}
		if( ti.equals("2")){
			ti = "Bebida";
		}
		
		String tia = rs.getString("tipoA");
		if( tia.equals("1")){
			tia = "Kilo";
		}
		if( tia.equals("2")){
			tia = "Unidad";
		}
		if( tia.equals("0")){
			tia = "&nbsp;";
		}
%>
  <tr> 
    <td align="center"><div align="center"><a href="DetalleMateriaPrimaS.jsp?<%=rs.getString("clave")%>"><%= rs.getString("nombre")%></a></div></td>
    <td><div align="center"><%= ti%></div></td>
    <td><div align="center"><%= tia%></div></td>
    <td align="center"><%= cu%></td>
    <td align="center"><%= ck%></td>
    <td align="center"><%= cb %></td>
    <td width="127" ><div align="center"><%= cb2%></div></td>
  </tr>
  <%	       
		 } 
%>
</table>
<p></p>
<table width="742" align="center">
<td width="280">
<p align="right"><a href="Menu_Materias_PrimasS.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar1','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar1" width="152" height="36" border="0" id="regresar1"></a></p>
</td>
<td width="186">                                                                   <font color="#FFFFFF">------------------</font></td>
<form name="form1" method="post" action="ImprimirMaterias_PrimasS.jsp" target="_blank">
<td width="260">
<font color="#FFFFFF"><img src="imagenes/Imprimir1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)"></font>
</td>
</form>
</table>
<% mp.cierraConexion();%>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


