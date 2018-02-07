<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.text.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.ult.bd.ManagerCompras" scope="page" />
<jsp:useBean id="mp" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Alta Compra</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MandaSubmit(f){	
	f.submit();
}

function setFocus(){
	var contenido = document.ph1.proveedorQ.options[0].text;
	if(contenido == "SELECCIONE"){
		document.ph1.proveedorQ.focus();
	}
	else {
		if(ph1.elements[ph1.length - 53].value==""){		
			ph1.elements[ph1.length - 54].select();
		}
		else{
		
			ph1.elements[ph1.length-47].focus();
		}
	}
}

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

function seleccionaTodo(objeto){
	objeto.select();
}

function recalculaValor(cantidad, precio, total, producto){
	var Unidad = new Number();
	Unidad = cantidad.value;
	if (isNaN(Unidad)){
		Unidad = 0;
	}
	if (Unidad == 0){
		producto.value = "";
		MandaSubmit(document.ph1)
	}
	var SPrecio = new String();
	SPrecio = precio.value;
	re = /,/gi;
	SPrecio = SPrecio.replace(re,"");
	var Precio = new Number();
	Precio = SPrecio;
	var Total = new Number();
	Total = Unidad * Precio;
	Total = roundOff(Total);
	total.value = formatCurrency(Total);
}

function roundOff(value){
	value = "" + value //convierte value a string
	var precision = 2;	
	var whole = "" + Math.round(value * Math.pow(10, precision));	
	var decPoint = whole.length - precision;
	if(decPoint != 0) {
		result = whole.substring(0, decPoint);
		result += ".";
		result += whole.substring(decPoint, whole.length);
	}
	else {
		result = 0;
		result += ".";
		result += whole.substring(decPoint, whole.length);
	}
	return result;
}

function OnSubmitForm(){
	if(document.pressed == 'Guardar')   {
		//alert("Caso 1 Guardar");
		document.ph1.action ="Conf_Alta_Prueba.jsp";
	}
	else if(document.pressed == 'Aumentar')   {
		document.ph1.action ="Alta_Prueba.jsp";
	}
	else{
		var kiko = document.pressed.name;
		if(kiko != '') {		
			document.ph1.action ="ListadoTest.jsp?"+kiko;
		}
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
//-->
</script>
</head>
<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
//System.out.println("1");
	String numProductos = "1";
	int cantNumProductos = 1;
	String idProducto = "";
	String proveedor = "";
	
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	//System.out.println("2");
	if(request.getParameter("proveedor") != null){
		proveedor = request.getParameter("proveedor"); 
	}	
	if(request.getParameter("numProductos")!= null){
		numProductos = request.getParameter("numProductos");
		cantNumProductos = alCom.cambiaAInt(numProductos);
		ArrayCantidad   = new String[cantNumProductos+1]; // Aumento 1 para facilitar el manejo del arreglo.
		ArrayProducto   = new String[cantNumProductos+1];
		ArrayCUnidad   = new String[cantNumProductos+1];
		ArrayImporte   = new String[cantNumProductos+1];
		//System.out.println("4");
		for (int i =1; i<=cantNumProductos; i++){
		
			ArrayCantidad[i] = request.getParameter("cantidad"+i);
			ArrayProducto[i] = request.getParameter("producto"+i);
			ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
			ArrayImporte[i] = request.getParameter("importe"+i);
			//System.out.println("Cambia"+i+" :"+Arraycambia[i]);
		}	
		//System.out.println("5");

			idProducto = request.getParameter("idProducto");
			int idpro = alCom.cambiaAInt(idProducto);
			String claveProducto = request.getParameter("rg1");
			String tipoPre = "";		
			//System.out.println(claveProducto);
			if(claveProducto == null){
				claveProducto = "";
			}
			//System.out.println("7");
			if(!(claveProducto.equalsIgnoreCase(""))){
				String claveProducto1 = request.getParameter("rg1");
				//System.out.println(claveProducto);
				tipoPre = claveProducto.substring(claveProducto.length()-1);
				//System.out.println(tipoPre);
				claveProducto = claveProducto.substring(0, (claveProducto.length())-1);
				//System.out.println(claveProducto);
				boolean repetido = false;	// Bandera para verificar que no este repetido ya ese producto.
				/*for(int i=1; i<=cantNumProductos; i++){
					if(ArrayProducto[i].equalsIgnoreCase(claveProducto)){
							repetido = true;
					}
				}*/
				if(!repetido){
					ArrayProducto[idpro] = claveProducto1;
%>
<jsp:setProperty name="alCom" property="claveProducto" value="<%=claveProducto%>"/>
<%				
//System.out.println(claveProducto);
					ArrayCUnidad[idpro] = alCom.formatoDinero(alCom.precioProducto(claveProducto,tipoPre));
					String piezas = ArrayCantidad[idpro];
// NUEVO PARA CORRECTO DESPLIEGUE DE LOS DECIMALES:					
					double multiplicados = (alCom.cambiaADouble(alCom.remueveComas((ArrayCUnidad[idpro]))) * alCom.cambiaADouble(piezas));
					NumberFormat nf = NumberFormat.getInstance();
					String numeritolargo = nf.format(multiplicados);
					ArrayImporte[idpro] = numeritolargo;
// HASTA ACA...					
				}
			}

		//System.out.println("8");
		for (int i=1; i<=cantNumProductos; i++){
			if(ArrayProducto[i] == null || ArrayProducto[i].equalsIgnoreCase("")){
				String[] Arraytemp1 = new String[cantNumProductos];
				String[] Arraytemp2 = new String[cantNumProductos];
				String[] Arraytemp4 = new String[cantNumProductos];
				String[] Arraytemp5 = new String[cantNumProductos];
				if(ArrayProducto.length != 2){
					if(i<cantNumProductos){
						int n = i;
						int m = 1;
						for (int k = 1; k<=cantNumProductos; k++){							
							if(k!=n){
								Arraytemp1[m] = ArrayCantidad[k];
								Arraytemp2[m] = ArrayProducto[k];
								Arraytemp4[m] = ArrayCUnidad[k];
								Arraytemp5[m] = ArrayImporte[k];
								m++;
							}
						}
						cantNumProductos -=1;
						ArrayCantidad = new String[cantNumProductos +1];
						ArrayProducto = new String[cantNumProductos +1];
						ArrayCUnidad = new String[cantNumProductos +1];
						ArrayImporte = new String[cantNumProductos +1];
						for (int j = 1; j<=cantNumProductos; j++){
							ArrayCantidad[j] = Arraytemp1[j];
							ArrayProducto[j] = Arraytemp2[j];
							ArrayCUnidad[j] = Arraytemp4[j];
							ArrayImporte[j] = Arraytemp5[j];
						}
						i--;
					}
				}					
			}
		}		
	}
%>
<body onLoad="setFocus();MM_preloadImages('imagenes/Regresar2.jpg')">
<h1>FORMATO SOLICITUD ALTA DE COMPRA.</h1>
<form method="post" name="ph1" target="_self" onSubmit="return OnSubmitForm();">
<!-- AQUI EMPIEZA -->
<%
	ResultSet proveedores = alCom.datosProveedoresActivos();
%>

<table align="center" width="531" cellpadding="0" cellspacing="0" border="1">
<caption>Proveedor:</caption>
  <tr>
    <th width="108">Seleccione Proveedor:</th>
	<td width="417">
	<select name="proveedorQ">
<%
	while (proveedores.next()){
%>	
		<option<%
		if(proveedor.equalsIgnoreCase(proveedores.getString("rfc"))){
%>
selected 
<%
		}
%>		
			 value ="<%=proveedores.getString("rfc")%>"><%=proveedores.getString("nombre")%></option>
<%
	}
%>				 
	</select>
	</td>
    </tr>
</table>
<p></p>
<table width="649" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">
  COMPRA ALTA
  </caption>
  <tr>
  	<th width="100" rowspan="2" scope="col">Cantidad</th>
    <th width="362" rowspan="2" scope="col">Producto</th>
    <th width="135" rowspan="2" scope="col">Costo Unidad</th>
    <th width="112" rowspan="2" scope="col">Importe</th>
  </tr>
  </table>
<%
	for (int i=1; i<=cantNumProductos; i++){
		String tempCantidad = (ArrayCantidad[i] == null) ? "1" : ArrayCantidad[i];
		String tempProducto = (ArrayProducto[i] == null) ? "" : ArrayProducto[i];
		String tempCUnidad = (ArrayCUnidad[i] == null) ? "0" : ArrayCUnidad[i];
		String tempImporte = (ArrayImporte[i] == null) ? "0" : ArrayImporte[i];
%> 
  <table width="649" border="1" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="95"><input type="text" name="cantidad<%=i%>" size="7" onFocus="seleccionaTodo(this)" maxlength="6" value="<%=tempCantidad%>" onChange="recalculaValor(this, ph1.cUnidad<%=i%>, ph1.importe<%=i%>, ph1.producto<%=i%>)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ ph1.Submit<%=i%>.focus();}"></td>
      <td width="317"><p align="center"> 
          <input type="text" name="producto<%=i%>" size="15" maxlength="8" readonly="true" value="<%=tempProducto%>">
          <input type="Submit" name="Submit<%=i%>" value="Ob.." onClick="document.pressed=this.form.producto<%=i%>"> 
          <%
	if (! tempProducto.trim().equals(""))	{
		String nombreTemporal = mp.dameNombreMP(tempProducto.substring(0, (tempProducto.length())-1));
		if(tempProducto.substring(tempProducto.length()-1).equalsIgnoreCase("A"))
			nombreTemporal = nombreTemporal+" --> Kg.";
		if(tempProducto.substring(tempProducto.length()-1).equalsIgnoreCase("B"))
			nombreTemporal = nombreTemporal+" --> Unidades";
		if(tempProducto.substring(tempProducto.length()-1).equalsIgnoreCase("C"))
			nombreTemporal = nombreTemporal+" --> Botella1";
		if(tempProducto.substring(tempProducto.length()-1).equalsIgnoreCase("D"))
			nombreTemporal = nombreTemporal+" --> Botella2";
		
%>
		<br><%=nombreTemporal%></td>
      <%}%>
      <td width="122"><div align="right">$ 
          <input type="text" name="cUnidad<%=i%>" onFocus="seleccionaTodo(this)" onChange="recalculaValor(ph1.cantidad<%=i%>, this, ph1.importe<%=i%>, ph1.producto<%=i%>)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;}; if(event.keyCode == 13){ ph1.Submit<%=i%>.focus();}"  size="10" maxlength="9" value="<%=tempCUnidad%>">
        </div></td>
      <td width="105"><div align="right">$ 
          <input type="text" name="importe<%=i%>" size="10" readonly="true"  maxlength="9" value="<%=tempImporte%>">
        </div></td>
    </tr>
    <%
	}
%>
  </table>
      <%
	cantNumProductos += 1;
%>
      <!-- AQUI TERMINA -->
</div>
<div align="left">
</div>
<p>
  <input type="hidden" name="numProductos" value="<%=cantNumProductos%>">
  <input type="hidden" name="proveedor" value="<%=proveedor%>">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Aumentar">
  <input type="submit" name="Submit" onClick="document.pressed=this.value" VALUE="Guardar">
</p>
</form>
<p>
<%
mp.cierraConexion();
%>
<a href="Menu_Compras.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
</p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
