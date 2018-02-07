<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />

<html>
<head>
<title>Obtenci&oacute;n de Materias Primas Empleadas</title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

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

function OnSubmitForm(){
	if(document.pressed == 'Guardar')   {
		//alert("Caso 1 Guardar");
		document.ph1.action ="Almacena_Entrega_Orden_Trabajo.jsp";
	}
	else if(document.pressed == 'Aumentar')   {
		document.ph1.action ="ListadoMP.jsp";
	}
	return true;
}

function borrame(IDPro, IDCant, IDTipo){
alert("IDPRO: "+document.getElementById(IDPro));
	var elementoPro = document.getElementById(IDPro);
	var elementoCant = document.getElementById(IDCant);
	var elementoTipo = document.getElementById(IDTipo);
	elementoPro.name="borrame";
	elementoCant.name="borrame";
	elementoTipo.name="borrame";
	MandaSubmit(ph1);
}

function verificaSobreInv(existe, pide, producto){
	var Existe = new Number();
	var Pide = new Number();
	Existe = parseInt(existe.value);
	Pide = parseInt(pide.value);
	if (isNaN(Existe)){
		Existe = 0;
	}
	if (isNaN(Pide)){
		Pide = 0;
	}
	if((Existe-Pide)<0){
		alert ("Sobrepasas la Cantidad Existente en Inventario para el Producto: \n\t" +producto.value);
		pide.value="0";
		pide.select();
	}
}

function MandaSubmit(f){	
	f.submit();
}

//-->
</script>
</head>
<body>
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
	String clave =  request.getParameter("clave"); 
	String[] ArrayProducto = (String[])request.getParameterValues("claveProducto");
	String[] ArrayDescripcion = (String[])request.getParameterValues("descripcion");
	String[] ArrayCantidad = (String[])request.getParameterValues("real");	
	String fecha =request.getParameter("datebox");	
	String[] ArrayCantidadMP = null;
	String[] ArrayProductoMP = null;
	String[] ArrayTipoUMP = null;
	int productosMP = alProd.dameCantidadProdMP();
	if(request.getParameterValues("cantidadMP") != null){
		ArrayCantidadMP = (String[])request.getParameterValues("cantidadMP");
		ArrayProductoMP = (String[])request.getParameterValues("productoMP");
		ArrayTipoUMP = (String[])request.getParameterValues("tipoMP");	
	}	
	if(request.getParameter("interino") != null){
		Vector <String> vTemp = new Vector <String>();
		int contadorInterno = 0;
		for(int i = 1; i<=productosMP; i++){
			if(request.getParameter(("rg"+i))!=null){
				contadorInterno++;
				vTemp.addElement(request.getParameter(("rg"+i)));
			}
		}
		if(!(ArrayProductoMP[0].trim().equals("")) && contadorInterno > 0){ // No esta vacio el arreglo previo y trae algo de ListadoVenta.jsp
			for(int i = 0; i<ArrayProductoMP.length; i++){ // Itero mi arreglo...
				for (int j = 0; j<vTemp.size(); j++){
					if(ArrayProductoMP[i].equals(vTemp.elementAt(j))){
						vTemp.removeElementAt(j);
						j --;
					}
				}
			}
			if(vTemp.size() > 0){
				int nuevoTamanio = (ArrayCantidadMP.length + vTemp.size());
				String[] TempArrayCantidadMP = new String [nuevoTamanio];
				String[] TempArrayProductoMP = new String [nuevoTamanio];
				String[] TempArrayTipoMP = new String [nuevoTamanio];
				for (int i = 0; i<ArrayCantidadMP.length; i++){
					TempArrayCantidadMP[i] = ArrayCantidadMP[i];
					TempArrayProductoMP[i] = ArrayProductoMP[i];
					TempArrayTipoMP[i] = ArrayTipoUMP[i];				
				}
				for (int i = 0; i<vTemp.size(); i++){
					TempArrayCantidadMP[i+ArrayCantidadMP.length] = "1";
					TempArrayProductoMP[i+ArrayProductoMP.length] = vTemp.elementAt(i).substring(2,vTemp.elementAt(i).length());	
					TempArrayTipoMP[i+ArrayCantidadMP.length] = vTemp.elementAt(i).substring(0,2);
				}
				ArrayCantidadMP = new String[nuevoTamanio];
				ArrayProductoMP = new String[nuevoTamanio];
				ArrayTipoUMP = new String[nuevoTamanio];
				System.arraycopy(TempArrayCantidadMP, 0, ArrayCantidadMP, 0, TempArrayCantidadMP.length);
				System.arraycopy(TempArrayProductoMP, 0, ArrayProductoMP, 0, TempArrayProductoMP.length);
				System.arraycopy(TempArrayTipoMP, 0, ArrayTipoUMP, 0, TempArrayTipoMP.length);
			}
		}
		else if(contadorInterno > 0){
			//Solo para la primera vez...
			ArrayCantidadMP = new String[contadorInterno];
			ArrayProductoMP = new String[contadorInterno];
			ArrayTipoUMP = new String[contadorInterno];
			for(int i = 0; i<contadorInterno; i++){
				ArrayProductoMP[i] =  vTemp.elementAt(i).substring(2,vTemp.elementAt(i).length());	
				ArrayCantidadMP[i] = "1";
				ArrayTipoUMP[i] =vTemp.elementAt(i).substring(0,2);
			}
		}
	}
%>
<b class="titulos">Introduce la cantidad de Materia Prima Empleada para elaborar la producci&oacute;n registrada:</b>
<table align="center" border="1" cellpadding="0" cellspacing="0" width="600">
  <caption>
  Producto(s) Creado(s).
  </caption>
  <tr>
  	<th width="435">Producto</th>
  	<th width="159">Cantidad<br/>Final</th>	
  </tr>
<%	for (int j = 0; j< ArrayProducto.length; j++){ %>
  <tr>
  	<td><%=ArrayDescripcion[j]%><input type="hidden" name="claveProducto" value="<%=ArrayProducto[j]%>"></td>
  	<td><div align="right"><%=ArrayCantidad[j]%>&nbsp;Kg.<input type="hidden" name="claveProducto" value="<%=ArrayCantidad[j]%>"></div></td>	
  </tr>
<%	}  %>
</table>
<form method="post" name="ph1" target="_self" onSubmit="return OnSubmitForm();">

	<input type="hidden" name="clave" value="<%=clave%>">
	<input type="hidden" name="datebox" value="<%=fecha%>">
<%	for(int m = 0; m<ArrayProducto.length; m++){ %>
	<input type="hidden" name="claveProducto" value="<%=ArrayProducto[m]%>">
	<input type="hidden" name="descripcion" value="<%=ArrayDescripcion[m]%>">
	<input type="hidden" name="real" value="<%=ArrayCantidad[m]%>">		
<%	} %>


<table width="700" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">
   DESCARGO DE MATERIA PRIMA EMPLEADA
  </caption>
  <tr>
  	<th colspan="2">Producto</th>
    <th width="82">Tipo</th>	
	<th width="136">Existencia en <br/>Inventarios</th>
    <th width="111">Cantidad</th>
		
  </tr>  
<%
	if(ArrayCantidadMP != null){
	for (int i=0; i < ArrayCantidadMP.length; i++){
		String tempCantidad = (ArrayCantidadMP[i] == null) ? "0" : ArrayCantidadMP[i];
		String tempProducto = (ArrayProductoMP[i] == null) ? "" : ArrayProductoMP[i];
		String tempTipo = "";
		String tempMax = "";
		if(ArrayTipoUMP[i].equals("PZ") || ArrayTipoUMP[i].equals("Pieza")){
			tempTipo ="Pieza";
			tempMax = alProd.dameEnteros(alProd.dameCantidadEnInve(tempProducto,tempTipo)+"");
		}else if(ArrayTipoUMP[i].equals("CJ") || ArrayTipoUMP[i].equals("Caja")){
			tempTipo = "Caja";
			tempMax = alProd.dameEnteros(alProd.dameCantidadEnInve(tempProducto, tempTipo)+"");			
		}else{
			tempTipo = "Kilo";
			tempMax = alProd.dameEnteros(alProd.dameCantidadEnInve(tempProducto,tempTipo)+"");			
		}
%> 
  <tr>
    <td width="250"><%  if(tempProducto.equals("")){  %><input id="productoMP<%=i%>" type="hidden" name="productoMP" value="<%=tempProducto%>"><%  } else{ %> <input id="productoMP<%=i%>" type="hidden" name="productoMP" value="<%=tempProducto%>"><%=alProd.dameDescripcionProducto(tempProducto)%><%  }  %><input type="hidden" name="nombreProdu<%=i%>" value="<%=alProd.dameDescripcionProducto(tempProducto)%>"></td>
	<td width="109"><%  if(tempProducto.equals("")){  %><input type="button" name="Borrar" value="Borrar" disabled onClick="borrame('productoMP<%=i%>', 'cantidadMP<%=i%>', 'tipoMP<%=i%>')"><%  } else{ %><input type="button" name="Borrar" value="Borrar" onClick="borrame('productoMP<%=i%>', 'cantidadMP<%=i%>', 'tipoMP<%=i%>')"><%  }  %> </td>
	<td> <div align="center"><input type="hidden" id="tipoMP<%=i%>" name="tipoMP" value="<%=tempTipo%>"><%=tempTipo%></div></td>	   
	<td><div align="center">
	      <input type="hidden" name="existenciaMP<%=i%>" value="<%=tempMax%>">
	      <%=tempMax%></div></td>
	 <td><div align="center">	
      <input type="text" id="cantidadMP<%=i%>" name="cantidadMP" size="7"  onFocus="seleccionaTodo(this)" maxlength="6" onBlur="verificaSobreInv(ph1.existenciaMP<%=i%>, this, ph1.nombreProdu<%=i%>)" value="<%=tempCantidad%>" onKeypress="
	<% if(tempTipo.equals("Kilo")){ %>
	   if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}
	<% } else { %>	   
	   if (event.keyCode < 48 || event.keyCode > 57) {event.returnValue = false;}
	<% } %>" ></div></td>
  </tr>  
<% 		} // cierro ciclo for 
	}else {// Cierro no es nulo %>
  <tr>
    <td width="250">&nbsp;<input id="producto" type="hidden" name="productoMP"></td>
	<td  width="109"><input type="button" name="Borrar" value="Borrar" disabled onClick="borrame(producto)"></td>
	<td> <div align="center"><input type="hidden" name="tipoMP">&nbsp;</div></td>	
	<td><div align="center">
	  <input type="hidden" name="existenciaMP" id="existencia">
	  </div></td>	
    <td><div align="center">
      <input type="text" name="cantidadMP" size="7"  onFocus="seleccionaTodo(this)" maxlength="6" readonly="true"> <input type="button" value="Re">
    </div></td>
  </tr>  
<%	} // Cierro nulo %>
</table>
<br/>
<table align="center" border="1" width="700" cellpadding="0" cellspacing="0">
  <tr>
  	<th width="182">Observaciones:</th>
  	<td width="512"><div align="center">
  	  <textarea name="observaciones" rows="3" cols="60"></textarea>
	  </div></td>	
  </tr>
</table>
<p>
  <input type="reset" name="reset" value="Restablecer"><br/>
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Aumentar">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Guardar">
</p>
</form>  
<p>
<form name="regreso" method="post" action="Confirmacion_Orden_Trabajo.jsp">
	<input type="hidden" name="interno" value="">
	<input type="hidden" name="clave" value="<%=clave%>">
	<input type="hidden" name="datebox" value="<%=fecha%>">
<%	for(int m = 0; m<ArrayProducto.length; m++){ %>
	<input type="hidden" name="claveProducto" value="<%=ArrayProducto[m]%>">
	<input type="hidden" name="descripcion" value="<%=ArrayDescripcion[m]%>">
	<input type="hidden" name="real" value="<%=ArrayCantidad[m]%>">		
<%	} %>

<input type="submit" name="Regreso" value="Volver">
</form>
</p>
<p align="center"><a href="Menu_Ordenes_Trabajo.jsp" target="mainFrame" onMouseOut="MM_swapImgRestore()" 
onMouseOver="MM_swapImage('APadres','','imagenes/Regresar2.jpg',1)"> <img src="imagenes/Regresar1.jpg" name="APadres" width="132" height="41" border="0"></a></p> 
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p> 
</body>
</html>	