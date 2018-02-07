<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="co" class="com.ult.bd.ManagerCobros" />
<jsp:useBean id="ven" class="com.ult.bd.ManagerVentas" />

<html>
<head>
<title>Alta Factura</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
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


function funcionFoco(){
	document.form1.rfc.focus();
}

function checaVacio(valor){
	var elValor = new String();
	elValor = valor;
	re = / /gi;
	elValor = elValor.replace(re,"");
	if(elValor == ''){
		return true;
	}
	return false;
}


function OnSubmitForm(){
	if(checaVacio(form1.rfc.value)){
		alert("Te falta asignar el RFC del Cliente a Facturar");
		form1.rfc.focus();
		return false;		
	}
	if(checaVacio(form1.factura.value)){
		alert("Te falta llenar el número de Factura asignada");
		form1.factura.focus();
		return false;		
	}
	document.form1.action ="Conf_Guarda_Factura.jsp";		
	return true;	
}



//-->
</script>
</head>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'),funcionFoco()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
   String[] cobro = null;
   String rfc = "";
   if(request.getParameter("rfc") != null){
		rfc = request.getParameter("rfc");
   }
	if(request.getParameterValues("cobro") != null){
		cobro = (String[])request.getParameterValues("cobro");
	}   
   String comanda = request.getParameter("comanda");
   if(cobro == null){ 
	   	out.println("Debes Seleccionar un Cobro.");
	}
	else{%>
   
<form name="form1" method="post" onSubmit="return OnSubmitForm();">
<%	for (int i=0; i<cobro.length; i++){%>
		<input type="hidden" name="cobro" value="<%=cobro[i]%>">
<%	} %>		
	<input type="hidden" name="comanda" value="<%=comanda%>">
<h1>Ingresa los Datos  y da Click en el bot&oacute;n de Guardar </h1>
	
  <table width="270" border="1" align="center">
    <tr> 
      <th width="86" bgcolor="#CCCCCC"><div align="center">RFC :</div></th>
      <td width="168">
<input name="rfc" type="text" id="rfc" size="15" maxlength="13" value="<%=rfc%>"> 
      </td>
    <tr> 
      <th width="86" bgcolor="#CCCCCC"><div align="center">Factura :</div></th>
      <td width="168">
<input name="factura" type="text" id="factura" size="14" maxlength="11"> 
      </td>
    </tr>
  </table>
		
        <p>
		<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<%
}
co.cierraConexion();
%>
<p> 
</p>
<p align="center"><a href="Dame_Comanda_Factura.jsp" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"> 
</body>
</html>
