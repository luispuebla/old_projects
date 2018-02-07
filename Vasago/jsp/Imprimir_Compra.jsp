<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="alCom" class="com.vas.bd.ManagerCompra" scope="page" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Calculos de Compras</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--


function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function roundOff(value)
{
        value = "" + value //convert value to string
        var precision = 2;

        var whole = "" + Math.round(value * Math.pow(10, precision));

        var decPoint = whole.length - precision;

        if(decPoint != 0)
        {
                result = whole.substring(0, decPoint);
                result += ".";
                result += whole.substring(decPoint, whole.length);
        }
        else
        {
                result = 0;
                result += ".";
                result += whole.substring(decPoint, whole.length);
        }
        return result;
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
}//-->

function imprimirPagina() {
  if (window.print)
    window.print();
  else
    alert("Lo siento, pero a tu navegador no se le puede ordenar imprimir" +
      " desde la web. Actualizate o hazlo desde los menús");
}

function Cerrar() {
	parent.close(); 
}

</script>
</head>
<%
	String numProductos = "1";
	int cantNumProductos = 1;
	String proveedor = "";
	//String queryString = request.getQueryString();
	String observaciones = request.getParameter("observaciones");
	String subtotal = request.getParameter("subtotal");
	String descuento = request.getParameter("descuento");
	String iva = request.getParameter("iva");
	String total = request.getParameter("total");
	String descuento1 = request.getParameter("descuento1");
	String descuento2 = request.getParameter("descuento2");
	String descuento3 = request.getParameter("descuento3");

	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	String[] ArrayRegalos = new String[2];
	
	String claveOrden = "";
	String tempcan1 = "&nbsp;";
	String tempcan2 = "&nbsp;";
	String tempcan3 = "&nbsp;";
	String tempcan4 = "&nbsp;";
	String tempcan5 = "&nbsp;";
	String tempcan6 = "&nbsp;";
	String tempcan7 = "&nbsp;";
	String tempcan8 = "&nbsp;";
	String tempcan9 = "&nbsp;";
	String tempcan10 = "&nbsp;";
	String tempcan11 = "&nbsp;";
	String tempcan12 = "&nbsp;";
	String tempcan13 = "&nbsp;";
	String tempcan14 = "&nbsp;";
	String tempcan15 = "&nbsp;";	
	String tempprod1 = "&nbsp;";
	String tempprod2 = "&nbsp;";
	String tempprod3 = "&nbsp;";
	String tempprod4 = "&nbsp;";
	String tempprod5 = "&nbsp;";
	String tempprod6 = "&nbsp;";
	String tempprod7 = "&nbsp;";
	String tempprod8 = "&nbsp;";
	String tempprod9 = "&nbsp;";
	String tempprod10 = "&nbsp;";
	String tempprod11 = "&nbsp;";
	String tempprod12 = "&nbsp;";
	String tempprod13 = "&nbsp;";
	String tempprod14 = "&nbsp;";
	String tempprod15 = "&nbsp;";
	
	if(request.getParameter("cantidadR1") != null && !request.getParameter("cantidadR1").equals(""))
		tempcan1 = request.getParameter("cantidadR1");
	if(request.getParameter("cantidadR2") != null && !request.getParameter("cantidadR2").equals(""))
		tempcan2 = request.getParameter("cantidadR2");
	if(request.getParameter("cantidadR3") != null && !request.getParameter("cantidadR3").equals(""))
		tempcan3 = request.getParameter("cantidadR3");
	if(request.getParameter("cantidadR4") != null && !request.getParameter("cantidadR4").equals(""))
		tempcan4 = request.getParameter("cantidadR4");
	if(request.getParameter("cantidadR5") != null && !request.getParameter("cantidadR5").equals(""))
		tempcan5 = request.getParameter("cantidadR5");
	if(request.getParameter("cantidadR6") != null && !request.getParameter("cantidadR6").equals(""))
		tempcan6 = request.getParameter("cantidadR6");
	if(request.getParameter("cantidadR7") != null && !request.getParameter("cantidadR7").equals(""))
		tempcan7 = request.getParameter("cantidadR7");
	if(request.getParameter("cantidadR8") != null && !request.getParameter("cantidadR8").equals(""))
		tempcan8 = request.getParameter("cantidadR8");
	if(request.getParameter("cantidadR9") != null && !request.getParameter("cantidadR9").equals(""))
		tempcan9 = request.getParameter("cantidadR9");
	if(request.getParameter("cantidadR10") != null && !request.getParameter("cantidadR10").equals(""))
		tempcan10 = request.getParameter("cantidadR10");
	if(request.getParameter("cantidadR11") != null && !request.getParameter("cantidadR11").equals(""))
		tempcan11 = request.getParameter("cantidadR11");
	if(request.getParameter("cantidadR12") != null && !request.getParameter("cantidadR12").equals(""))
		tempcan12 = request.getParameter("cantidadR12");
	if(request.getParameter("cantidadR13") != null && !request.getParameter("cantidadR13").equals(""))
		tempcan13 = request.getParameter("cantidadR13");
	if(request.getParameter("cantidadR14") != null && !request.getParameter("cantidadR14").equals(""))
		tempcan14 = request.getParameter("cantidadR14");
	if(request.getParameter("cantidadR15") != null && !request.getParameter("cantidadR15").equals(""))
		tempcan15 = request.getParameter("cantidadR15");
	
	if(request.getParameter("productoR1") != null && !request.getParameter("productoR1").equals(""))
		tempprod1 = alCom.dameDescripcionProducto(request.getParameter("productoR1"));
	if(request.getParameter("productoR2") != null && !request.getParameter("productoR2").equals(""))
		tempprod2 = alCom.dameDescripcionProducto(request.getParameter("productoR2"));
	if(request.getParameter("productoR3") != null && !request.getParameter("productoR3").equals(""))
		tempprod3 = alCom.dameDescripcionProducto(request.getParameter("productoR3"));
	if(request.getParameter("productoR4") != null && !request.getParameter("productoR4").equals(""))
		tempprod4 = alCom.dameDescripcionProducto(request.getParameter("productoR4"));
	if(request.getParameter("productoR5") != null && !request.getParameter("productoR5").equals(""))
		tempprod5 = alCom.dameDescripcionProducto(request.getParameter("productoR5"));
	if(request.getParameter("productoR6") != null && !request.getParameter("productoR6").equals(""))
		tempprod6 = alCom.dameDescripcionProducto(request.getParameter("productoR6"));
	if(request.getParameter("productoR7") != null && !request.getParameter("productoR7").equals(""))
		tempprod7 = alCom.dameDescripcionProducto(request.getParameter("productoR7"));
	if(request.getParameter("productoR8") != null && !request.getParameter("productoR8").equals(""))
		tempprod8 = alCom.dameDescripcionProducto(request.getParameter("productoR8"));
	if(request.getParameter("productoR9") != null && !request.getParameter("productoR9").equals(""))
		tempprod9 = alCom.dameDescripcionProducto(request.getParameter("productoR9"));
	if(request.getParameter("productoR10") != null && !request.getParameter("productoR10").equals(""))
		tempprod10 = alCom.dameDescripcionProducto(request.getParameter("productoR10"));
	if(request.getParameter("productoR11") != null && !request.getParameter("productoR11").equals(""))
		tempprod11 = alCom.dameDescripcionProducto(request.getParameter("productoR11"));
	if(request.getParameter("productoR12") != null && !request.getParameter("productoR12").equals(""))
		tempprod12 = alCom.dameDescripcionProducto(request.getParameter("productoR12"));
	if(request.getParameter("productoR13") != null && !request.getParameter("productoR13").equals(""))
		tempprod13 = alCom.dameDescripcionProducto(request.getParameter("productoR13"));
	if(request.getParameter("productoR14") != null && !request.getParameter("productoR14").equals(""))
		tempprod14 = alCom.dameDescripcionProducto(request.getParameter("productoR14"));
	if(request.getParameter("productoR15") != null && !request.getParameter("productoR15").equals(""))
		tempprod15 = alCom.dameDescripcionProducto(request.getParameter("productoR15"));
		
//System.out.println("Producto gratis: "+);

	//System.out.println("Entrega Original: "+entrega);
	claveOrden = request.getParameter("claveOrden");
	proveedor = request.getParameter("proveedor");
	numProductos = request.getParameter("numProductos");
	cantNumProductos = alCom.cambiaAInt(numProductos);
	//cantNumProductos -=1;
	ArrayCantidad   = new String[cantNumProductos+1]; // Aumento 1 para facilitar el manejo del arreglo.
	ArrayProducto   = new String[cantNumProductos+1];
	ArrayCUnidad   = new String[cantNumProductos+1];
	ArrayImporte   = new String[cantNumProductos+1];
	ArrayRegalos = new String[cantNumProductos+1];
	for (int i =1; i<=cantNumProductos; i++){
		ArrayCantidad[i] = request.getParameter("cantidad"+i);
		ArrayProducto[i] = request.getParameter("producto"+i);
		ArrayCUnidad[i] = request.getParameter("cUnidad"+i);
		ArrayImporte[i] = request.getParameter("importe"+i);
	}
%>
<body onLoad="imprimirPagina(); Cerrar()">
<jsp:setProperty name="alCom" property="claveProveedor" value="<%=proveedor%>"/>
<% //System.out.println("Clave del Proveedor:  "+proveedor); 
String NomProv = alCom.dameNombreProveedor();
String FechaEntrega = request.getParameter("fechaentrega");
//System.out.println("Fecha Entrega Original: "+FechaEntrega);
//System.out.println("Nombre del Proveedor:  "+NomProv);
%>
<table width="600" border="1">
	<caption>
	Clave de Pedido (Compra): <%=claveOrden%></caption>
	<tr>
		<th width="69">Proveedor</th>
		<td width="215"><%=NomProv%></td>
		<th width="146">Fecha Aproximada de Entrega</th>
		<td width="81"><%=FechaEntrega%></td>
	</tr>
</table>
<p></p>
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
	  <tr>
	  	<th width="95">Cantidad</th>
		<th width="177">Producto</th>
		<th width="133">Precio Unitaro</th>
		<th width="100">Importe</th>
	  </tr>
<%
for (int i =1; i<=cantNumProductos; i++){
//System.out.println("Vamos en el: "+i);
if(!(ArrayProducto[i].equalsIgnoreCase(""))){
	boolean conIva = false;
	if(alCom.tieneIva(ArrayProducto[i])){
		conIva = true;			
	}
	if(!conIva){

%>
      <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%=alCom.dameDescripcionProducto(ArrayProducto[i])%></td>
		<td><div align="right">$ <%=ArrayCUnidad[i]%></div></td>
		<td><div align="right">$ <%=ArrayImporte[i]%></div></td>
      </tr>
<%	
	}
	else{
%>
      <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%=alCom.dameDescripcionProducto(ArrayProducto[i])%></td>
		<td><div align="right">$ <%=alCom.formatoDinero(alCom.acortaLongitud(((alCom.cambiaADouble(alCom.remueveComas(ArrayCUnidad[i]))*100)/115)+""))%></div></td>
		<td><div align="right">$ <%=alCom.formatoDinero(alCom.acortaLongitud(((alCom.cambiaADouble(alCom.remueveComas(ArrayImporte[i]))*100)/115)+""))%></div></td>
      </tr>
<%	
}
	//System.out.println("Antes de la Suma:  "+importes);
	//System.out.println("Despues de la Suma:  "+importes);  
	int compro = 0;
	int regalan = 0;
	int cant = 0;
	int comp = 0;
}}
%>	  	  
  	  
	</table>
	<br />
  <table width="600" border="1">
  <caption>
  OBSEQUIOS EXTRAS
  </caption>
	<tr>
	  <th>Cantidad</th>
  	  <th>Producto</th>
	  <th width="5">&nbsp;</th>
	  <th>Cantidad</th>
	  <th>Producto</th>
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan1%></div></td>
	  <td><div align="center"> <%=tempprod1%> </div></td>
	  <td>&nbsp;</td>
	  <td><div align="center"><%=tempcan2%></div></td>
	  <td><div align="center"><%=tempprod2%> </div></td>
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan3%></div></td>
	  <td><div align="center"><%=tempprod3%></div></td>
	  <td>&nbsp;</td>
	  <td><div align="center"><%=tempcan4%></div></td>
	  <td><div align="center"><%=tempprod4%> </div></td>	  
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan5%></div></td>
	  <td><div align="center"> <%=tempprod5%> </div></td>
	  <td>&nbsp;</td>
	  <td><div align="center"><%=tempcan6%></div></td>
	  <td><div align="center"><%=tempprod6%> </div></td>
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan7%></div></td>
	  <td><div align="center"><%=tempprod7%></div></td>
	  <td>&nbsp;</td>
	  <td><div align="center"><%=tempcan8%></div></td>
	  <td><div align="center"><%=tempprod8%> </div></td>	  
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan9%></div></td>
	  <td><div align="center"> <%=tempprod9%> </div></td>
	  <td>&nbsp;</td>
	  <td><div align="center"><%=tempcan10%></div></td>
	  <td><div align="center"><%=tempprod10%> </div></td>
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan11%></div></td>
	  <td><div align="center"><%=tempprod11%></div></td>
	  <td>&nbsp;</td>
	  <td><div align="center"><%=tempcan12%></div></td>
	  <td><div align="center"><%=tempprod12%> </div></td>	  
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan13%></div></td>
	  <td><div align="center"> <%=tempprod13%> </div></td>
	  <td>&nbsp;</td>
	  <td><div align="center"><%=tempcan14%></div></td>
	  <td><div align="center"><%=tempprod14%> </div></td>
	</tr>
	<tr>
	  <td><div align="center"><%=tempcan15%></div></td>
	  <td><div align="center"><%=tempprod15%></div></td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	</tr>
  </table>
<br />
<table width="652" border="1">
<tr>
	<th width="246">Observaciones</th>
	<th width="92">&nbsp;</th>
	<td width="78">&nbsp;</td>
	<th width="111">Subtotal</th>
	<td width="91"><div align="right">$   <%= subtotal%>
	  </div></td>
</tr>
<tr>
	<td rowspan="3"><textarea name="observaciones" cols="35" rows="5"><%= observaciones%></textarea></td>
	<th>Descuento 1</th>
	<td><div align="center"> <%= descuento1%> %</div></td>
	<th height="34"><div align="center"><strong>Descuento</strong></div></th>
	<td height="34"><div align="right">$ <%= descuento%>
	  </div></td>
</tr>
<tr>
  <th>Descuento 2</th>
  <td><div align="center"> <%= descuento2%> %</div></td>
	<th height="35"><div align="center"><strong>I.V.A.</strong></div></th>
  <td height="35"><div align="right">$ <%= iva%>
  </div></td>
</tr>
<tr>
  <th>Descuento 3</th>
  <td><div align="center"> <%= descuento3%> %</div></td>
<th><div align="center"><strong>TOTAL</strong></div></th>
  <td><div align="right">$ <%= total%>  </div></td>
</tr>
</table>
</body>
</html>
