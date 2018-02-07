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
	Clave de Compra: <%=claveOrden%></caption>
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
%>
      <tr>
		<td><%=ArrayCantidad[i]%></td>
		<td><%=alCom.dameDescripcionProducto(ArrayProducto[i])%></td>
		<td><div align="right">$ <%=ArrayCUnidad[i]%></div></td>
		<td><div align="right">$ <%=ArrayImporte[i]%></div></td>
      </tr>
<%	
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
	  <th width="184">Cantidad</th>
  	  <th width="400">Producto</th>
	</tr>
<%
	ResultSet regalosRS = alCom.dameRegalosRegistrados(claveOrden);
	while (regalosRS.next()){
%>	
	<tr>
	  <td><div align="center"><%=regalosRS.getDouble("Cantidad")%></div></td>
	  <td><div align="center"> <%=regalosRS.getString("descripcion")%> </div></td>
	</tr>	
<%
	}	
	if(regalosRS != null){
		regalosRS.close();
	}
	alCom.cierraConexion();						
%>	
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
