<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.math.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Guardar Orden Trabajo</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="date-picker.js">
</script>
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


function OnSubmitForm(){
	if(document.pressed == 'Modificar')   {
		document.form1.action ="Alta_Orden_Trabajo.jsp";
	}
	if(document.pressed == 'Guardar')   {
		document.form1.action ="Guarda_Alta_Orden_Trabajo.jsp";					
	}
	return true;
}

function funcionFoco(){
	if(document.form1 != null){
		document.form1.observaciones.focus();
	}
}

-->
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
	
	String[] ArrayCantidad = null;
	String[] ArrayProducto = null;
	ArrayCantidad = (String[])request.getParameterValues("cantidad");
	ArrayProducto = (String[])request.getParameterValues("producto");
//System.out.println("Size productos Array: " +ArrayProducto.length);	
	String fechaHoy = alProd.dameFechaHoy();	
	// Voy a revisar mis arreglos....
	for(int i = 0; i< ArrayProducto.length; i ++){
	// Si viene con 0 u otra cosa lo elimino.
		if((ArrayCantidad[i].equals("") || alProd.cambiaAInt(ArrayCantidad[i]) <= 0)){
			// Tengo que eliminar mis Arreglos
			String[] TempArrayCantidad = new String [(ArrayProducto.length - 1)];
			String[] TempArrayProducto = new String [(ArrayProducto.length - 1)];
			int alterno = -1;
			for(int j=0; j<ArrayProducto.length; j++){
				if(j != i){
					alterno ++;
					TempArrayProducto[alterno] = ArrayProducto[j];
					TempArrayCantidad[alterno] = ArrayCantidad[j];
				}
			}
			alterno++;
			ArrayCantidad = new String[alterno];
			ArrayProducto = new String[alterno];
			System.arraycopy(TempArrayCantidad, 0, ArrayCantidad, 0, TempArrayCantidad.length);
			System.arraycopy(TempArrayProducto, 0, ArrayProducto, 0, TempArrayProducto.length);
			i=0;
		}
	}
	//Verifico que no quieran meter gol entre las existencias de venta y de regalo.
%>
	
	<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg'); funcionFoco()">	
<%	// Si no trae ningun producto ... lo regreso!
	if(ArrayProducto.length == 0){
%>
	<form name="retache" method="post" target="_self" action="Alta_Orden_Trabajo.jsp" >
<table>
	<tr>
		<td><b class="roj">Tienes que especificar al menos un producto para la Orden de Trabajo.</b></td>
	</tr>
	<tr>
		<td><div align="center">Para reingresar producto da click en Volver</div></td>
	</tr>
</table>
	<p><input type="submit" name="Volver" value="Volver"></p>
	</form>
<%	
	} else{
%>
<form name="form1" method="post" target="_self" onSubmit="return OnSubmitForm();">
	<input type="hidden" name="modificador" value="">	
<% 	
	if(ArrayProducto!=null){
		for (int i=0; i<ArrayProducto.length; i++){ 
%>	
	<input type="hidden" name="cantidad" value="<%=ArrayCantidad[i]%>">
	<input type="hidden" name="producto" value="<%=ArrayProducto[i]%>">
<%	 	}  }%>
<table align="center" width="305" border="1" cellpadding="0" cellspacing="0">
	<caption>&nbsp;</caption>
	<tr>
		<th width="117">Fecha Alta:</th>
            <td width="182">
              <div align="center">
                <input type=text name="datebox" size=15 readonly="true" value="<%=fechaHoy%>">
                </div></td>
	</tr>
</table>
<br/>
<% if(ArrayProducto.length > 0){ %>
<table align="center" width="584" border="1" cellpadding="0" cellspacing="0">
	<caption>
	Productos 
	</caption>
	<tr>
		<th width="86">Cantidad</th>
		<th width="492">Producto</th>
	</tr>
<% 	for(int i = 0; i < ArrayProducto.length ; i++){ 
%>
	<tr>
		<td><div align="center"><%=alProd.cambiaADouble(ArrayCantidad[i])%>&nbsp;Kg.</div></td>
		<td><%=alProd.dameDescripcionProducto(ArrayProducto[i])%></td>	
	</tr>
<% } %>
</table>
<% } %>
<br/>
<table width="548" height="159" border="1" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<th width="544">Observaciones</th>
	</tr>
	<tr>
		<td height="122"><div align="center">
		  <textarea name="observaciones" cols="70" rows="5"></textarea>
		  </div></td>
	</tr>
	
</table>

<p>
<table align="center" width="775" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td><div align="center">
	  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Guardar">
	  </div></td>	
	</tr>	
	<tr>
		<td height="30">&nbsp;</td>
	</tr>
	<tr>
		<td><div align="center"><input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Modificar"> </div></td>
	</tr>
</table>
</p>
</form>
<%	}  %>
<p><a href="Menu_Ordenes_Trabajo.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	  	  
