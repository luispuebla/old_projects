<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alVen" class="com.ult.bd.ManagerInventarios" scope="page" />

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

function seleccionaTodo(objeto){
	objeto.select();
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
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
%>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	String tipo2 = request.getParameter("tipo2");

	ResultSet productos = alVen.todosLosProductosModInv(tipo2);		
%>	
<form name="form1" method="post" action="Conf_Cambio_Inventario_B.jsp">
	
  <table width="766" align="center" cellpadding="0" cellspacing="0" border="1">
    <caption>
    INVENTARIO TOTAL
    </caption>
    <tr> 
      <th width="52">Clave</th>
      <th width="231">Nombre</th>
      <th width="121">Cantidad Botella 1 Original</th>
      <th width="117">Cantidad Botella 1 Nueva</th>
      <th width="121">Cantidad Botella 2 Original</th>
      <th width="117">Cantidad Botella 2 Nueva</th>
      <th width="116">Cantidad Copeo Original</th>
      <th width="104">Cantidad Copeo Nueva</th>
    </tr>
    <p></p>
    <%
	while (productos.next()){
		String tipoB = "Botella 1(s)";
		String tipoB2 = "Botella 2(s)";
		String tipoC = "Lt.";
		String inveB1 = productos.getString("inventarioBotella1");		
		String inveB2 = productos.getString("inventarioBotella2");		
		String inveC = productos.getString("inventarioCopeo");
		double cantB1 = productos.getDouble("litrosXBotella1");
		double cantB2 = productos.getDouble("litrosXBotella2");
%>
    <tr> 
	      <input name="tip" type="hidden" value="<%=tipo2%>">
      <td><div align="center"><%=productos.getString("clave")%></div></td>
      <input name="clave" type="hidden" value="<%=productos.getString("clave")%>">
      <td><%=productos.getString("descripcion")%></td>
<%	  if(cantB1 > 0.00){%>
      <td><div align="center"><%=inveB1%> Botella(s) de <%=cantB1%> Lt.</div></td>
      <td><div align="center">
          <input name="nuevaEB" type="text" value="<%=inveB1%>" size="7" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}">
        </div></td>
<%		}else{%>
      <td><div align="center">NO APLICA</div></td>
      <td><div align="center">
          <input name="nuevaEB" readonly="true" type="text" value="<%=inveB1%>" size="7" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}" >
        </div></td>		  
<%		} %>		
<%	  if(cantB2 > 0.00){%>
      <td><div align="center"><%=inveB2%> Botella(s) de <%=cantB2%> Lt.</div></td>
      <td><div align="center">
          <input name="nuevaEB2" type="text" value="<%=inveB2%>" size="7" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}">
        </div></td>
<%		}else{%>		
      <td><div align="center">NO APLICA</div></td>
      <td><div align="center">
          <input name="nuevaEB2" readonly="true" type="text" value="<%=inveB2%>" size="7" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}" >
        </div></td>		  
<%		} %>		
      <td><div align="center"><%=inveC%> <%=tipoC%></div></td>
      <td><div align="center">
          <input name="nuevaEC" type="text" value="<%=inveC%>" size="7" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}">
        </div></td>
    </tr>
    <%	
	}
%>
  </table>
  <p> 
    <input type="submit" name="Submit" value="Guardar">
 </p>

</form>
<p align="center"><a href="Menu_Inventarios.jsp" target="_self" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"  onMouseOut="MM_swapImgRestore()"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
<% alVen.cierraConexion();%>
</body>
</html>
