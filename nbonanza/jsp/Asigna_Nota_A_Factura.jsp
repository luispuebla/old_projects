<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.alpha.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Asignaci&oacute;n de Nota a Factura</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
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
 
function seleccionaTodo(objeto){
	objeto.select();
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
	if(document.pressed == 'Guardar'){
		if(checaVacio(form1.nuevaFac.value)){
			alert("Se debe llenar la nueva Factura");
			form1.nuevaFac.focus();
			return false;		
		}
		else{
			document.form1.action = "Asigna_Nota_A_Factura.jsp";
		}
	}
	else if(document.pressed == 'Eliminar'){
		if(form2.facturaElimina.value == ""){
			alert("Debes Seleccionar al menos una Factura para eliminarla");
			form2.facturaElimina.focus();
			return false;		
		}
		else{
			document.form2.action = "Asigna_Nota_A_Factura.jsp";
		}
	}
	else{
		document.form3.action = "Asigna_Nota_A_Factura.jsp";
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
//System.out.println("2");
	String claveOrden = request.getParameter("claveOrden");
	String proveedor = request.getParameter("proveedor");
	String fechaHoy = alCom.dameFechaHoy();
	if(request.getParameter("NuevaFactura") != null){
		alCom.guardaNuevaFactura(request.getParameter("nuevaFac"), request.getParameter("datebox"), claveOrden);
	}
	else if(request.getParameter("EliminaFactura") != null){
		alCom.eliminaFactura(request.getParameter("facturaElimina"), claveOrden);
	}
	else if(request.getParameter("AsignaFactura") != null){
		alCom.asignaFactura((String [])request.getParameterValues("notas"), (String[])request.getParameterValues("facturaGuarda"), claveOrden);
	}

//System.out.println("3");
%>
<jsp:setProperty name="alCom" property="claveOrden" value="<%=claveOrden%>"/>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedor%>"/>

<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">

<form name="form1" method="post" onSubmit="return OnSubmitForm();" target="_self">
<input type="hidden" name="NuevaFactura" value="1">
<input type="hidden" name="proveedor" value="<%=proveedor%>">
<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
<table align="center" width="500" border="1">
  <caption>Nueva Factura</caption>
  <tr>
  	<th width="256"><div align="center"><b>Escribe el n&uacute;mero y fecha de la <br/>
        nueva Factura para esta compra:</b></div></th>
	<td width="228"><div align="center"><input type="text" name="nuevaFac" size="15" maxlength="11"> &nbsp;
	  <input type=text name="datebox" size=15 readonly="true" value="<%=fechaHoy%>"> 
	  <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a></div></td>
  </tr>
  <tr>
  	<td colspan="2"><div align="center">
  	  <input type="submit" value="Guardar" name="Guardar" onClick="document.pressed=this.value">
	  </div></td>
  </tr>
</table>
</form>

<form name="form2" method="post" onSubmit="return OnSubmitForm();" target="_self">
<input type="hidden" name="EliminaFactura" value="1">
<input type="hidden" name="proveedor" value="<%=proveedor%>">
<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
<% ResultSet rs = alCom.dameFacturas(claveOrden);%>
<table align="center" width="500" border="1">
  <caption>Borrar Factura</caption>
  <tr>
  	<th><div align="center"><b>Selecciona la factura a eliminar:</b></div></th>
	<td><div align="center">
		<select name="facturaElimina">
		  <option value="" selected>Selecciona...</option>
<%		  while(rs.next()){ %>
          <option value="<%=rs.getString("docAval")%>"><%=rs.getString("docAval")%> (<%=rs.getString("fechaDoc")%>)</option>
<%		  } 
		  rs.close();
		  alCom.cierraConexion();
%>
        </select>
	</div></td>
  </tr>
  <tr>
  	<td colspan="2"><div align="center">
  	  <input type="submit" value="Eliminar" name="Eliminar" onClick="document.pressed=this.value">
	  </div></td>
  </tr>
</table>
</form>


<form name="form3" method="post" onSubmit="return OnSubmitForm();" target="_self">
<input type="hidden" name="AsignaFactura" value="1">
<input type="hidden" name="proveedor" value="<%=proveedor%>">
<input type="hidden" name="claveOrden" value="<%=claveOrden%>">
<% 	
	ResultSet rs1 = alCom.dameFacturas(claveOrden);
	ResultSet rs2 = alCom.dameNotas(claveOrden);
%>
<table align="center" width="500" border="1">
  <caption>Asigna Factura</caption>
  <tr>
  	<th>Nota(s)</th>
  	<th>Factura(s)</th>	
  </tr>
<%  while(rs2.next()){ %>
  <tr>
  	<td><div align="center">
  	  <input type="text" readonly="true" name="notas" value="<%=rs2.getString("docAval")%>">
	  </div></td>
	<td><div align="center">
	  <select name="facturaGuarda">
		      <option value="" selected>Ninguno</option>
            <%		  while(rs1.next()){ %>
                <option <%if (rs2.getString("docPadre").equals(rs1.getString("docAval"))){%> selected <%}%>value="<%=rs1.getString("docAval")%>"><%=rs1.getString("docAval")%> (<%=rs1.getString("fechaDoc")%>)</option>
            <%		  }
		  rs1.beforeFirst();
%>
          </select>
	  </div></td>	
  </tr>
<%	} 
	rs2.close();
	rs1.close();
	alCom.cierraConexion();
	alCom.cierraConexion2();
%>
  <tr>
  	<td colspan="2"><div align="center">
  	  <input type="submit" value="Asignar" name="Asignar" onClick="document.pressed=this.value">
	  </div></td>
  </tr>
</table>
</form>



--------------------------------------------------------------------------
<%
	String provee = alCom.dameNombreProveedor();
%>
<table align="center" width="600" cellpadding="0" cellspacing="0" border="1">
<caption>
 Datos Generales de la Compra: 
</caption>
  <tr>
    <th width="97">Proveedor:</th>
	<td width="629"><div align="center"><%= provee%></div></td>
  </tr>
</table>
<table width="760" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">&nbsp;
  </caption>
  <tr>
    <th width="75" height="29" scope="col">Clave</th>
    <th width="84" scope="col">Fecha</th>
	<th width="115" scope="col">Estado<br/>Recepci&oacute;n</th>	
	<th width="101" scope="col">Estado<br/>Pagos</th>	
	<th width="95" scope="col">Subtotal</th>
	<th width="88" scope="col">Descuentos</th>	
	<th width="86" scope="col">I.V.A.</th>
	<th width="98" scope="col">Total</th>	
	
  </tr>
  <% //System.out.println("9");
  rs = alCom.datosOrdenCompra();
  while(rs.next()){
  	String edoPago = "Sin pagos";
	String edoRecepcion = "Sin Recepciones";
	if (rs.getInt("entrega") == 1){
		edoRecepcion = "Recibido Parcialmente";
	}
	else if(rs.getInt("entrega") == 2){
		edoRecepcion = "Totalmente Recibido";
	}
	if (rs.getInt("pago") == 1){
		edoPago = "Pagado Parcialmente";
	}
	else if(rs.getInt("pago") == 2){
		edoPago = "Totalmente Pagado";
	}	
		%>  
  <tr>
    <td><div align="center"><%= rs.getString("ClaveOrden")%></div></td>
    <td><div align="center"><%= rs.getString("FechaRegistro")%></div></td>
    <td><div align="center"><%= edoRecepcion%></div></td>
    <td><div align="center"><%= edoPago%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("subtotal"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("realDescuento"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Iva"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Total"))%></div></td>
  </tr>
<%
	}
	if(rs != null){
		rs.close();
	}
	alCom.cierraConexion();
	ResultSet rsR = alCom.dameRecepcionesPrevias(claveOrden);
	boolean primeraAsignacion = true;
	String claveRecepcion = "";	
%>	  
</table>
<br/>
<table align="center" width="760" cellpadding="0" cellspacing="0" border="1">
	<caption>Recepciones Registradas</caption>
<%	while(rsR.next()){ 	
		if(rsR.getDouble("Cantidad") > 0.00){
			String documentoAval = rsR.getString("DocAval");
			String tipoProducto = "Pieza";
			if(rsR.getInt("Tipo") == 1){
				tipoProducto = "Caja";	
			}
			else if(rsR.getInt("Tipo") == 2){
				tipoProducto = "Kg.";
			}
			String tipodoc = "Nota/Remisi&oacute;n";
			if(rsR.getInt("TipoDocAval") == 1){
				tipodoc = "Factura";
			}
			if(primeraAsignacion){
				primeraAsignacion = false;
				claveRecepcion = rsR.getString("ConsecutivoRecepcion");
%>
	<tr>
		<th width="95">Recepci&oacute;n: </th>
		<td width="80"><div align="center"><%=claveRecepcion%></div></td>
		<th width="110">Documento<br/>Aval: </th>
		<td width="70"><div align="center"><%=documentoAval%></div></td>
		<th width="115">Tipo<br/>Documento: </th>
		<td width="80"><div align="center"><%=tipodoc%></div></td>
		<th width="112">Fecha<br/>Documento:</th>
		<td width="80"><div align="center"><%=rsR.getString("FechaDocAval")%></div></td>
	</tr>
	<tr>
		<th colspan="2">Clave <br/>Producto</th>
		<th colspan="2">Producto</th>
		<th colspan="2">Tipo</th>				
		<th colspan="2">Cantidad<br/>Recibida</th>
	</tr>
			
<%			}
			else if(!(claveRecepcion.equalsIgnoreCase(rsR.getString("ConsecutivoRecepcion")))){
				claveRecepcion = rsR.getString("ConsecutivoRecepcion");		
%>
	<tr>
		<td colspan="8">&nbsp;</td>
	</tr>
	<tr>
		<th>Recepci&oacute;n: </th>
		<td><div align="center"><%=claveRecepcion%></div></td>
		<th>Documento<br/>Aval: </th>
		<td><div align="center"><%=documentoAval%></div></td>
		<th>Tipo<br/>Documento: </th>
		<td><div align="center"><%=tipodoc%></div></td>
		<th>Fecha<br/>Documento:</th>
		<td><div align="center"><%=rsR.getString("FechaDocAval")%></div></td>		
	</tr>		
	<tr>
		<th colspan="2">Clave <br/>Producto</th>
		<th colspan="2">Producto</th>
		<th colspan="2">Tipo</th>				
		<th colspan="2">Cantidad<br/>Recibida</th>
	</tr>	
<%			}  %>
	<tr>
		<td colspan="2"><div align="center"><%=rsR.getString("ClaveProducto")%></div></td>
		<td colspan="2"><div align="center"><%=rsR.getString("Descripcion")%></div></td>
		<td colspan="2"><div align="center"><%=tipoProducto%></div></td>
		<td colspan="2"><div align="right"><%=alCom.formatoDinero(rsR.getString("Cantidad"))%></div></td>	
	</tr>	
<% 		}
	}
	rsR.close();
	alCom.cierraConexion();	
%>
</table>
<p>
<a href="Menu_Recepciones.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
