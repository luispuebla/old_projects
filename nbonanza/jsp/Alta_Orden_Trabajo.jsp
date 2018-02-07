<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.text.*, java.util.Vector" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alProd" class="com.alpha.bd.ManagerProduccion" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Alta Orden de Trabajo (Producci&oacute;n) </title>
<link href="baseCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){	
	f.submit();
}

function seleccionaTodo(objeto){
	objeto.select();
}

function regresaFoco(cantidadP){
	cantidadP.select();
}


function OnSubmitForm(){
	if(document.pressed == 'Guardar')   {
		//alert("Caso 1 Guardar");
		document.ph1.action ="Conf_Alta_Orden_Trabajo.jsp";
	}
	else if(document.pressed == 'Aumentar')   {
		document.ph1.action ="ListadoOrdenTrabajo.jsp";
	}
	return true;
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

function borrame(IDPro, IDCant){
	var elementoPro = document.getElementById(IDPro);
	var elementoCant = document.getElementById(IDCant);
	elementoPro.name="borrame";
	elementoCant.name="borrame";
	MandaSubmit(ph1);
}


function borrame2(Clave, Cantidad){
	Clave.value="";
	Cantidad.value="";
	MandaSubmit(ph1);
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
	String[] ArrayCantidad = null;
	String[] ArrayProducto = null;

	if(request.getParameter("propio") !=null){
		if((String[])request.getParameterValues("producto") != null){
			ArrayCantidad = (String[])request.getParameterValues("cantidad");
			ArrayProducto = (String[])request.getParameterValues("producto");
		}		
	}
	if(request.getParameter("modificador") !=null){
		if((String[])request.getParameterValues("producto") != null){
			ArrayCantidad = (String[])request.getParameterValues("cantidad");
			ArrayProducto = (String[])request.getParameterValues("producto");
		}		
	}
	else if(request.getParameter("interino") != null){	
		if((String[])request.getParameterValues("producto") != null){
			ArrayCantidad = (String[])request.getParameterValues("cantidad");
			ArrayProducto = (String[])request.getParameterValues("producto");
		}					
		//System.out.println("1");
		int consecutivo = alProd.cambiaAInt(request.getParameter("consecutivo"));
		//System.out.println("2");
		Vector <String> vTemp = new Vector <String>();
		int contadorInterno = 0;
		for(int i = 1; i<=consecutivo; i++){
			if(request.getParameter(("rg"+i))!=null){
				contadorInterno++;
				vTemp.addElement(request.getParameter(("rg"+i)));
			}
		}
		//System.out.println(contadorInterno);
		if(!(ArrayProducto[0].trim().equals("")) && contadorInterno > 0){ // No esta vacio el arreglo previo y trae algo de ListadoVenta.jsp
			for(int i = 0; i<ArrayProducto.length; i++){ // Itero mi arreglo...
				for (int j = 0; j<vTemp.size(); j++){
					if(ArrayProducto[i].equals(vTemp.elementAt(j))){
							vTemp.removeElementAt(j);
						j --;
					}
				}
			}
			if(vTemp.size() > 0){
				int nuevoTamanio = (ArrayCantidad.length + vTemp.size());
				String[] TempArrayCantidad = new String [nuevoTamanio];
				String[] TempArrayProducto = new String [nuevoTamanio];
				for (int i = 0; i<ArrayCantidad.length; i++){
					TempArrayCantidad[i] = ArrayCantidad[i];
					TempArrayProducto[i] = ArrayProducto[i];
				}
				for (int i = 0; i<vTemp.size(); i++){
					TempArrayCantidad[i+ArrayCantidad.length] = "1";
					TempArrayProducto[i+ArrayCantidad.length] = vTemp.elementAt(i);
				}
				ArrayCantidad = new String[nuevoTamanio];
				ArrayProducto = new String[nuevoTamanio];
				System.arraycopy(TempArrayCantidad, 0, ArrayCantidad, 0, TempArrayCantidad.length);
				System.arraycopy(TempArrayProducto, 0, ArrayProducto, 0, TempArrayProducto.length);
			}
		}
		else if(contadorInterno > 0){
			//Solo para la primera vez...
			ArrayCantidad = new String[contadorInterno];
			ArrayProducto = new String[contadorInterno];
			for(int i = 0; i<contadorInterno; i++){
				ArrayProducto[i] = vTemp.elementAt(i);
				ArrayCantidad[i] = "1";
			}
		}
	}

%> 
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<h1>FORMATO ALTA DE ORDEN DE TRABAJO</h1>
<b>Selecciona los productos que se van a Producir</b>
<form method="post" name="ph1" target="_self" onSubmit="return OnSubmitForm();">
<input type="hidden" name="propio" value="">
<table width="650" border="1" cellspacing="0" cellpadding="0">
  <caption align="top"> PRODUCTOS  CORT&Eacute;S  </caption>
  <tr>
  	<th colspan="2">Producto</th>
    <th width="150">Cantidad</th>
  </tr>  
<%
	if(ArrayCantidad != null){
		for (int i=0; i < ArrayCantidad.length; i++){
			String tempCantidad = (ArrayCantidad[i] == null) ? "0" : ArrayCantidad[i];
			String tempProducto = (ArrayProducto[i] == null) ? "" : ArrayProducto[i];
%> 
  <tr>
  	<td width="377"><div align="center"><%if(tempProducto.equals("")){%><input id="producto<%=i%>" type="hidden" name="producto" value="<%=tempProducto%>"> <%} else{%> <input id="producto<%=i%>" type="hidden" name="producto" value="<%=tempProducto%>"><%=alProd.dameDescripcionProducto(tempProducto)%><%  }  %></div></td>
  	<td width="115"><div align="center"><%if(tempProducto.equals("")){%><input type="button" name="Borrar" value="Borrar" disabled onClick="borrame(producto.id)"> <%} else{%> <input type="button" name="Borrar" value="Borrar" onClick="borrame('producto<%=i%>', 'cantidad<%=i%>')"> <%  }  %></div></td>
  	<td><div align="center"><%if(tempProducto.equals("")){%> <input type="text" readonly="true" name="cantidad" size="7"  maxlength="6" > <%} else{%><input type="text" name="cantidad" size="7" id="cantidad<%=i%>"  onFocus="seleccionaTodo(this)" maxlength="6" value="<%=tempCantidad%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}"> <%  }  %>
  	&nbsp; Kg.</div></td>  
  </tr>

<% 		} // cierro ciclo for 
	}else {// Cierro no es nulo %>
  <tr>
    <td>&nbsp;<input id="producto" type="hidden" name="producto" value=""></td>
	<td><input type="button" name="Borrar" value="Borrar" disabled onClick="borrame(producto)"></td>
    <td><div align="center">
      <input type="text" name="cantidad" size="7"  onFocus="seleccionaTodo(this)" maxlength="6" > 
      &nbsp; Kg.
    </div></td>
  </tr>  
<%	} // Cierro nulo %>
</table>
<p>
  <input type="reset" name="reset" value="Restablecer"><br/>
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Aumentar">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Guardar">
</p>
</form>		
<p>
<a href="Menu_Ordenes_Trabajo.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="132" height="41" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>

