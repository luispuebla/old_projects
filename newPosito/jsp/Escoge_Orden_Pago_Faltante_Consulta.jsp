<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="pa" class="com.alpha.bd.ManagerPagos" scope="page" />

<html>
<head>
<title>Selección de una Compra</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
	document.form1.Submit.click();
}

function OnSubmitForm(){
	if(form1.claveOrden != null){
		var valor = 'Ninguno';
		for(var i=0; i<form1.claveOrden.length; ++i){
			if(form1.claveOrden[i].checked){
				valor = form1.claveOrden[i].value;
			}
		}	
		if(valor == 'Ninguno'){
			alert("Debes seleccionar al menos una transacción para proseguir.");
			return false;
		}
		else{
			document.form1.action ="PagosFaltantesXCompra.jsp";		
		}
	}
	else{
		return false;	
	}
}


//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
   String proveedor = request.getParameter("clave");%>
<% if(proveedor == null){%>
		<b class="roj">Debes seleccionar un Proveedor.</b>
<% }
	else{ %>
<h1>Escoge la Compra Pendiente para mostrar su historial de Pago:</h1>
<p></p>
<form name="form1" method="post" onSubmit="return OnSubmitForm();">
<input type="hidden" name="proveedor" value="<%=proveedor%>">
 <table width="520" border="1" align="center">
  <caption>
  COMPRAS  
  </caption>
  <tr> 
    <td><div align="center"> <input type="radio" name="claveOrden"  readonly="true" disabled> </div> </td>
    <th width="92">Clave</th>
	<th width="240">Fecha en la que se Realizo</th>
    <th width="125">Total</th>
   </tr>
<%
	ResultSet rs = pa.comprasXproveedorPorPagar(proveedor);
	while(rs.next()){
%>
  <tr> 
	<td> <div align="center"> <input type="radio" name="claveOrden" value="<%= rs.getString("ClaveOrden")%>" onClick="MandaSubmit(document.forms[0])"> </div></td>
    <td><div align="center"><%=rs.getString("ClaveOrden")%></div></td>
    <td><div align="center"><%=rs.getString("fechaRegistro")%></div></td>
    <td><div align="right">$ <%=pa.formatoDinero(rs.getString("total"))%></div></td>
  </tr>
<%
	}
	if(rs != null){
		rs.close();
	}
	pa.cierraConexion();						
%>	  
</table>
  <p><font> 
    <input type="submit" name="Submit" value="Enviar">
  </font> </p>
</form>
<%}%>
<p align="center"><a href="Consultas_Pagos.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
