<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" %> 
<jsp:useBean id="acceso" class="com.ult.bd.ManagerLogin" scope="page" />
<jsp:useBean id="co" class="com.ult.bd.ManagerCobros" />
<jsp:useBean id="ven" class="com.ult.bd.ManagerVentas" />

<html>
<head>
<title>Selección Cobro</title>
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

function OnSubmitForm(){
	if(form1.cobro != null){
		var valor = 'Ninguno';
		for(var i=0; i<form1.cobro.length; ++i){
			if(form1.cobro[i].checked){
				valor = form1.cobro[i].value;
			}
		}	
		if(valor == 'Ninguno'){
			alert("Debes seleccionar al menos un cobro para proseguir.");
			return false;
		}
		else{
			document.form1.action ="FacturaXCobro.jsp";		
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
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || (!tipou.equalsIgnoreCase("admin") && !tipou.equalsIgnoreCase("caja")))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
   String comanda = request.getParameter("comanda");

   boolean tiene = co.tieneComanda(comanda);
   
   if(tiene){
%>	
<form name="form1" method="post" onSubmit="return OnSubmitForm();">
<input type="hidden" name="comanda" value="<%=comanda%>">
<table width="416" border="1" align="center">
<caption>
    Seleccione el/los Monto(s) a Facturar
</caption>
  <tr> 
	<td><div align="center"> <input type="checkbox" name="cobro" readonly="true" disabled> </div> </td>
	<th width="178" bgcolor="#CCCCCC">Fecha Cobro</th>
	<th width="222" bgcolor="#CCCCCC">Monto</th>
</tr>	
<%
ResultSet anteriores = co.dameCobrosNoFacturados(comanda);
while(anteriores.next()){
%>
  <tr> 
	<td width="23">
	<input type="checkbox" name="cobro" value="<%=anteriores.getString("consecutivo")%>"></td>
	<td width="178"><%=anteriores.getString("fechaCobro")%></td>
	<td width="222"><div align="right">$ <%=co.formatoDinero(anteriores.getString("monto"))%></div></td>
</tr>	
<%}%>
</table>
	<div align="center">
          <input type="submit" name="Submit" value="Guardar">
  </div>
          </p>
</form>
<%
}
else{
	out.println("No existe la Comanda.");
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
