<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.ult.bd.ManagerCompras" scope="page" />
<jsp:useBean id="prod" class="com.ult.bd.ManagerMateriasPrimas" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Factura de una Compra</title>
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">
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
function funcionFoco(){
	document.form1.factura.focus();
}

function seleccionaTodo(objeto){
	objeto.select();
}


function setFecha(){
	var fechaHoy = new Date();
	var mesHoy = new String();
	var anioHoy = new String();
	var diaHoy = new String();
	var ndiaHoy =  new Number();
	var nmesHoy = new Number();		
	nmesHoy = (fechaHoy.getMonth()+1);
	anioHoy = (fechaHoy.getYear());
	ndiaHoy = (fechaHoy.getDate());
	diaHoy = ndiaHoy +"";
	mesHoy = nmesHoy +"";
	if(diaHoy.length==1){
		diaHoy = "0"+diaHoy;
	}
	if(mesHoy.length==1){
		mesHoy = "0"+mesHoy;
	}
	document.form1.datebox.value=mesHoy+"/"+diaHoy+"/"+anioHoy;
}
//-->
</script>
</head>
<%
//System.out.println("1");
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
//System.out.println("2");
String clave = request.getParameter("clave");
String proveedor = request.getParameter("proveedor");
//System.out.println("3");
%>
<jsp:setProperty name="alCom" property="claveOrden" value="<%=clave%>"/>
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedor%>"/>

<body onLoad="funcionFoco();MM_preloadImages('imagenes/Regresar2.jpg'), setFecha()">
<form name="form1" method="post" action="Conf_Factura_Orden.jsp">
<%
//System.out.println("4");
int cantNumProductos = 0;
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];

		cantNumProductos = alCom.cuentaTodosProductosOrden();
		//System.out.println("Productos guardados "+cantNumProductos);
		String cantNumProductos0 = cantNumProductos+"";
		ArrayCantidad   = new String[cantNumProductos+1]; 
		ArrayProducto   = new String[cantNumProductos+1];
		ArrayCUnidad   = new String[cantNumProductos+1];
		ArrayImporte   = new String[cantNumProductos+1];
		ResultSet prods = alCom.todosProductosOrden3();
		//System.out.println("5");
		for (int i =1; i<=cantNumProductos; i++){
			while (prods.next()){
				ArrayCantidad[i] = prods.getString("Cantidad");
				ArrayProducto[i] = prods.getString("ClaveProducto");
				//System.out.println("Producto1: "+ArrayProducto[i]);
				ArrayCUnidad[i] = alCom.formatoDinero(prods.getString("Costo"));
				ArrayImporte[i] = alCom.formatoDinero(prods.getString("Importe"));
				i++;
			}
		}
		//System.out.println("6");
	String provee = alCom.dameNombreProveedor();
	//System.out.println("7");
%>
<input name="cantNumProductos" type="hidden" value="<%=cantNumProductos%>">
<table align="center" width="732" cellpadding="0" cellspacing="0" border="1">
<caption>
Datos Compra
</caption>
  <tr>
    <th width="97">Proveedor:</th>
	<td width="629">
	<input name="proveedor" type="text" value="<%= provee%>" size="100" maxlength="100" readonly="true">
	</td>
  </tr>
 </table>
<%//System.out.println("8");%>
<table width="760" border="1" cellspacing="0" cellpadding="0">
  <caption align="top">&nbsp;
  </caption>
  <tr>
    <th width="81" height="29" scope="col">Clave</th>
    <th width="92" scope="col">Fecha</th>
    <th width="230" scope="col">Observaciones</th>
	<th width="81" scope="col">Subtotal</th>
	<th width="90" scope="col">Descuento</th>
	<th width="71" scope="col">I.V.A.</th>
	<th width="99" scope="col">Total</th>
  </tr>
  <% //System.out.println("9");
  ResultSet rs = alCom.datosOrdenCompra();
  while(rs.next()){
  		//System.out.println("10");
		%>
  <input type="hidden" name="clave" value="<%= rs.getString("ClaveOrden")%>">
  <input type="hidden" name="cProveedor" value="<%= proveedor%>">
  
  <tr>
    <td><div align="center"><%= rs.getString("ClaveOrden")%></div></td>
    <td><div align="center"><%= rs.getString("Fecha")%></div></td>
    <td><%= rs.getString("Observaciones")+""%></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Subtotal"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Descuento"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Iva"))%></div></td>
    <td><div align="right">$ <%= alCom.formatoDinero(rs.getString("Total"))%></div></td>
  </tr>
<%
	}
%>	  
</table>
<p></p>
<table width="560" border="1">
  <tr>
    <th width="91">Factura /<br />
    Remisi&oacute;n:</th>
	<td width="126">
	<input type="text" name="factura" size="12" maxlength="11">
	</td>
	<th width="116">Fecha de Recepci&oacute;n:</th>
	<td width="199">
		<input type=text name="datebox" size=15 readonly="true">
 <a href="javascript:show_calendar('form1.datebox');" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="imagenes/show-calendar.gif" width=30 height=26 border=0 align="absmiddle"></a>
	</td>
  </tr>
 </table>
 <p></p>
 <p></p>
	<table width="560" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
	  	<th width="132"><div align="center">Cantidad</div></th>
		<th width="422">Producto</th>
	  </tr>
<%
//System.out.println("11");
for (int i =1; i<=cantNumProductos; i++){
//System.out.println("11b2");
//System.out.println("Producto2: " +ArrayProducto[i]);
if(!(ArrayProducto[i].equalsIgnoreCase(""))){
//System.out.println("11b3");
double totalpro = alCom.cambiaADouble(ArrayCantidad[i]);
//System.out.println("11d");
//System.out.println("11e");
double llegaron = 0.00;
//System.out.println("11f");
llegaron = alCom.dameLlegaron(ArrayProducto[i]);
//System.out.println("11g");
//System.out.println("los que regalan: "+ArrayRegalos[i]);
double tt = totalpro;
tt = tt - llegaron;
//System.out.println("12");
			String nomantes = ArrayProducto[i];
			String tipoTodo = "";
			//System.out.println(nomantes);
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("A"))
			tipoTodo = " --> Kg.";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("B"))
			tipoTodo = " --> Unidades";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("C"))
			tipoTodo = " --> Botella1";
		if(nomantes.substring(nomantes.length()-1).equalsIgnoreCase("D"))
			tipoTodo = " --> Botella2";
			nomantes = nomantes.substring(0, nomantes.length()-1);
	%>
      <tr>
		<td><div align="center">
          <input name="cantidad<%=i%>" size="7" maxlength="6" value="<%=tt%>" onFocus="seleccionaTodo(this)" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) {event.returnValue = false;};">
</div></td>
		<td><input name="producto<%=i%>" type="hidden" size="7" maxlength="6" value="<%=ArrayProducto[i]%>"><%out.print(alCom.dameNombreProducto(nomantes)+tipoTodo);%></td> 
	  </tr>
<%	
	//System.out.println("Antes de la Suma:  "+importes);
	//System.out.println("Despues de la Suma:  "+importes);
}}
%>	  	  
  </table>
 <p>
  <input type="reset" name="Submit2" value="Volver Originales">
  <input type="submit" name="Submit" VALUE="Guardar">
</p>
</form>
<p>
<a href="Escoge_Proveedor_Orden_Factura.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
</p>
<%prod.cierraConexion();%>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
