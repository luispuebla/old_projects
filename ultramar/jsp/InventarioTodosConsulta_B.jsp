<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.ult.bd.ManagerInventarios" scope="page" />
<jsp:useBean id="diaHoy" class="com.ult.bd.TimeStamp" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Inventario Todos</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){
	document.RegN.submit();
}

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
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg','imagenes/Imprimir2.jpg')">
<%
String clave = request.getParameter("tipo2");

	ResultSet productos = alVen.todosLosProductosConInv(clave);	
	double totalC = 0.0;
	double totalB = 0.0;	
	double totalB2 = 0.0;	
%>	
	<table width="902" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>INVENTARIO TOTAL (<%=diaHoy.date%>)</caption>
	  <tr>
	  	<th width="55">Clave</th>
		<th width="219">Nombre</th>
		<th width="96">Cantidad <br /> Botella(s) 1</th>
		<th width="122">Costo</th>		
		<th width="101">Cantidad <br /> Botella(s) 2</th>
		<th width="99">Costo</th>		
		<th width="94">Cantidad <br />
      Copeo Lt.</th>
		<th width="98">Costo</th>		
	  </tr>
	 <p></p>
<%
	while (productos.next()){
		double cantB1 = productos.getDouble("litrosXBotella1");
		double cantB2 = productos.getDouble("litrosXBotella2");

		double costoB = productos.getDouble("costoBotella1");
		costoB = costoB * (productos.getInt("inventarioBotella1") * productos.getDouble("litrosXBotella1"));
		totalB = totalB + costoB;

		double costoB2 = productos.getDouble("costoBotella2");
		costoB2 = costoB2 * (productos.getInt("inventarioBotella2") * productos.getDouble("litrosXBotella2"));
		totalB2 = totalB2 + costoB2;
		
		double costoC = productos.getDouble("costoBotella2");
		if(costoC == 0.000){
			costoC = productos.getDouble("costoBotella1");
		}
		costoC = costoC * productos.getDouble("inventarioCopeo");
		totalC = totalC + costoC;
%>
      <tr>
		<td><div align="center"><%=productos.getString("clave")%></div></td>
		<td><%=productos.getString("descripcion")%></td>
<%	  if(cantB1 > 0.00){%>		
		<td><div align="center"><%=productos.getString("inventarioBotella1")%>  Botella(s) de <%=cantB1%> Lt. </div></td>
<%		}else{%>
      <td><div align="center">NO APLICA</div></td>
<%		}%>	  		
		<td><div align="center">$ <%=alVen.formatoDinero(alVen.acortaLongitud(costoB+""))%></div></td>
<%	  if(cantB2 > 0.00){%>				
		<td><div align="center"><%=productos.getString("inventarioBotella2")%> Botella(s) de <%=cantB2%> Lt. </div></td>
<%		}else{%>
      <td><div align="center">NO APLICA</div></td>
<%		}%>	  		
		<td><div align="center">$ <%=alVen.formatoDinero(alVen.acortaLongitud(costoB2+""))%></div></td>
		<td><div align="center"><%=productos.getString("inventarioCopeo")%></div></td>
		<td><div align="center">$ <%=alVen.formatoDinero(alVen.acortaLongitud(costoC+""))%></div></td>
      </tr>
<%	
	}
%>	
      <tr>
		<td colspan="2">&nbsp;</td>
		<th>Costo<br />Inventario</th>
		<td width="122"><div align="center"><strong>$ <%=alVen.formatoDinero(alVen.acortaLongitud(totalB+""))%></strong></div></td>
		<td>&nbsp;</td>
		<td width="99"><div align="center"><strong>$ <%=alVen.formatoDinero(alVen.acortaLongitud(totalB2+""))%></strong></div></td>
		<td>&nbsp;</td>
 		<td width="98"><div align="center"><strong>$ <%=alVen.formatoDinero(alVen.acortaLongitud(totalC+""))%></strong></div></td>
     </tr>  	  
	</table>
	<br/>
	<p><a href="Consultas_Inventarios.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"  onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
<% alVen.cierraConexion();%>
</body>
</html>
