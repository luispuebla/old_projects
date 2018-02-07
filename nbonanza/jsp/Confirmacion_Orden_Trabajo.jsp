<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Confirmación Orden Trabajo</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function formatCurrency(num) {
num = num.toString().replace(/\$|\,/g,'');
if(isNaN(num))
num = "0";
sign = (num == (num = Math.abs(num)));
num = Math.floor(num*100+0.50000000001);
cents = num%100;
num = Math.floor(num/100).toString();
if(cents<10)
cents = "0" + cents;
for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
num = num.substring(0,num.length-(4*i+3))+','+
num.substring(num.length-(4*i+3));
return (((sign)?'':'-') + num + '.' + cents);
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

function verificaSobrePaso(falta1, agrega1){
	var falta2 = document.getElementById(falta1);
	var agrega2 = document.getElementById(agrega1);
	var falta = new Number();
	var agrega = new Number();
	falta = parseInt(falta2.value);
	agrega = parseInt(agrega2.value);
	if (isNaN(falta)){
		falta = 0;
	}
	if (isNaN(agrega)){
		agrega = 0;
	}
	if((falta-agrega)<0){
		alert ("Sobrepasas la Cantidad Solicitada de este Producto, se Reingresara el Máximo Posible");
		agrega2.value= falta2.value;
		agrega2.select();
	}
}


function funcionFoco(){
	document.form1.factura.focus();
}

function seleccionaTodo(objeto){
	objeto.select();
}

function cambiaFoco(){
	document.form1.factura.focus();
}

function OnSubmitForm(){
	var docAval = new String();
	docAval = form1.factura.value;
	re = / /gi;
	docAval = docAval.replace(re,"");
	if(docAval == ''){
		alert("Debes especificare un Documento Aval (Factura/Remisión) de esta transacción");
		form1.factura.focus();
		return false;
	}
	else{
		document.form1.action ="Conf_Factura_Orden.jsp";		
		return true;
	}
}

//-->
</script>
</head>
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
	String fechaHoy = alProd.dameFechaHoy();	
	String clave = "";
	String[] ArrayProducto = null;
	String[] ArrayDescripcion = null;
	String[] ArrayCantidad = null;
	String[] ArrayOriginal = null;
	if(request.getParameter("clave") != null){
		clave = request.getParameter("clave");
	}
	if(clave.equals("")){ %>
	<form name="Regreso1" method="post" action="Existe_Orden_trabajo_Confirmación.jsp" target="_self">
		<b class="roj">Debes introducir una Clave para mostrar su contenido.</b>
		<p><input type="submit" value="Volver" name="Volver"></p>
	</form>
<%	}
	else{  
		ResultSet rs = alProd.datosOrdenImp(clave);
		String fechaAlta = "";
		while(rs.next()){
			fechaAlta = rs.getString("FechaAlta");
		}
		rs.close();
		alProd.cierraConexion();
		if(request.getParameter("interno") != null){
			fechaHoy = request.getParameter("datebox");		
			ArrayProducto = (String [])request.getParameterValues("claveProducto");
			ArrayDescripcion = (String [])request.getParameterValues("descripcion");
			ArrayCantidad = (String [])request.getParameterValues("real");
			ArrayOriginal = new String[ArrayProducto.length];
			ResultSet rsProducs = alProd.DameProductosOrdenAlta(clave);
			int i = 0;
			while(rsProducs.next()){ 
				ArrayOriginal[i] = rsProducs.getString("Cantidad");
				i++;
			}			
		}
		else{
			ResultSet rsProducs = alProd.DameProductosOrdenAlta(clave);
			int contadorProd = 0;
			while(rsProducs.next()){ 
				contadorProd ++;
			}
			rsProducs.beforeFirst();
			ArrayProducto = new String[contadorProd];
			ArrayDescripcion = new String[contadorProd];
			ArrayCantidad =  new String[contadorProd];
			ArrayOriginal = new String[contadorProd];
			int i = 0;
			while(rsProducs.next()){ 
				ArrayProducto[i] = rsProducs.getString("Clave_Producto");
				ArrayDescripcion[i] = rsProducs.getString("descripcion");
				ArrayCantidad[i] = rsProducs.getString("Cantidad");
				ArrayOriginal[i] = rsProducs.getString("Cantidad");		
				i++;
			}
			rsProducs.close();
			alProd.cierraConexion();
		}
%>	
		<form name="form1" method="post" action="Dame_Materia_Prima_OT.jsp"  target="_self">			
			<input type="hidden" name="clave" value="<%=clave%>">
			<table align="center" width="700" border="1" cellpadding="0" cellspacing="0">
			<caption> Datos Generales &Oacute;rden de Trabajo </caption>
			  <tr>
			  	<th width="163">Fecha<br/>Alta:</th>
				<td width="150"><div align="center"><%=fechaAlta%></div></td>
			  	<th width="179"><p>Fecha<br/> Final:</p></th>
				<td width="198"><div align="center"> <input type=text name="datebox" size=15 readonly="true" value="<%=fechaHoy%>"> <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;">&nbsp;<img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a></div></td>
			  </tr>
			</table>
			<br/>
			<table align="center" width="694" border="1" cellpadding="0" cellspacing="0">
			<caption> Producto(s) Cort&eacute;s Solicitado</caption>
		<tr>
			<th width="60">Clave</th>
			<th width="360">Producto</th>
			<th width="115">Cantidad<br/> Solicitad Originalmente</th>
		  <th width="149">Cantidad<br/>
		    Creada </th>
		  </tr>
<%		
		ResultSet rsProducs = alProd.DameProductosOrdenAlta(clave);
		for(int i = 0; i<ArrayCantidad.length; i++){
%>
		  <tr>
			<td><div align="center"><input type="hidden" name="claveProducto" value="<%=ArrayProducto[i]%>"><%=ArrayProducto[i]%></div></td>
			<td><div align="center"><input type="hidden" name="descripcion" value="<%=ArrayDescripcion[i]%>"><%=ArrayDescripcion[i]%></div></td>
			<td><div align="center"><%=ArrayOriginal[i]%>&nbsp;Kg.</div></td>
			<td><div align="center"><input type="text" name="real" value="<%=ArrayCantidad[i]%>" size="8" maxlength="7" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}">&nbsp;Kg.</div></td>
		  </tr>
<%		}  %>		
		</table>
		<br/>
        <p><input type="submit" name="Enviar" value="Enviar"></p>
		</form>				
		
<%	} %>
<p><a href="Existe_Orden_Trabajo_Confirmacion.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
