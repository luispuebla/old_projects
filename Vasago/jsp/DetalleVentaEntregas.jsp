<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="cli" class="com.vas.bd.ManagerClientes" />
<jsp:useBean id="en" class="com.vas.bd.ManagerEntregas" scope="page" />
<jsp:useBean id="produ" class="com.vas.bd.ManagerProductos" scope="page" />

<html>
<head>
<title>Detalle de una Venta</title>
<link href="vasagoCSS.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
function MandaSubmit(f){
	document.form2.submit();
}

function MandaSubmit3(f){
	document.form3.submit();
}
//-->
</script>
</head>
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}

//System.out.println("Antes que nada");
String dia = "";
	String resultado = request.getQueryString();
	//System.out.println("Llega: "+resultado);
	int gato = resultado.indexOf("-");
	int coma = resultado.indexOf(",");
	int aste = resultado.indexOf("*");
	int mas = resultado.indexOf("+");
	String claveVenta = resultado.substring(0,gato);
	String anio = resultado.substring(gato+1,coma);
	String mes = resultado.substring(coma+1,aste);
	dia = resultado.substring(aste+1,mas);
	String tipoConsul = resultado.substring(mas+1);
//System.out.println("Saco valores");
int cantNumProductos = 0;
	String[] ArrayCantidad   = new String[2]; // Inicializo en 2 por facilidad de manejo la primera vez.
	String[] ArrayProducto   = new String[2];
	String[] ArrayCUnidad   = new String[2];
	String[] ArrayImporte   = new String[2];
	String[] ArrayRegalos   = new String[2];

		cantNumProductos = en.cuentaTodosProductosVenta(claveVenta);
		//System.out.println("Productos guardados "+cantNumProductos);
		String cantNumProductos0 = cantNumProductos+"";
		ArrayCantidad   = new String[cantNumProductos+1]; 
		ArrayProducto   = new String[cantNumProductos+1];
		ArrayCUnidad   = new String[cantNumProductos+1];
		ArrayImporte   = new String[cantNumProductos+1];
		ArrayRegalos   = new String[cantNumProductos+1];			
		ResultSet prods = en.todosProductosVenta2(claveVenta);
		for (int i =1; i<=cantNumProductos; i++){
			while (prods.next()){
				ArrayCantidad[i] = prods.getString("Cantidad");
				ArrayProducto[i] = prods.getString("ClaveProducto");
				ArrayCUnidad[i] = en.formatoDinero(prods.getString("Costo"));
				ArrayImporte[i] = en.formatoDinero(prods.getString("Importe"));
				i++;
			}
		}
ResultSet anterior = en.datosVenta(claveVenta);
ResultSet regalos = en.datosRegalosVenta(claveVenta);
	String entrega = "";
//System.out.println("Tengo Arreglos");
%>
<p>&nbsp;</p>
	<table width="600" align="center" cellpadding="0" cellspacing="0" border="1">
	<caption>
	PRODUCTOS VENDIDOS 
	</caption>
	  <tr>
	  	<th width="132"><div align="center">Cantidad</div></th>
		<th width="462"><div align="center">Producto</div></th>
	  </tr>
<%
for (int i =1; i<=cantNumProductos; i++){
if(!(ArrayProducto[i].equalsIgnoreCase(""))){
	%>
      <tr>
		<td><div align="center"><%=ArrayCantidad[i]%></div></td>
		<td><div align="center"><%=produ.descripcionProducto(ArrayProducto[i])%></div></td>
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
<p></p>
  <table width="600" border="1" onClick="imprimirPagina()">
  <caption>
  OBSEQUIOS
  </caption>
	  <tr>
		  <th width="132">Cantidad</th>
		  <th width="452">Producto</th>
	  </tr>
<%
	while(regalos.next()){
%> 
	  <tr>
		    <td><div align="center"><%=regalos.getString("cantidad")%></div></td>
      <td><div align="center">
       <%=produ.descripcionProducto(regalos.getString("ClaveProducto"))%>
      </div></td>
	  </tr>
	  <%}%>
</table>
	<p></p>
<form name="form2" method="post" action="Entregas_Ventas.jsp">
<%//System.out.println("tipoConsul: "+tipoConsul);%>
<%//System.out.println("anio: "+anio);%>
<%//System.out.println("mes: "+mes);%>
<%//System.out.println("dia: "+dia);%>
<input type="hidden" name="tipoConsul" value="<%= tipoConsul%>">
<input type="hidden" name="anio" value="<%= anio%>">
<input type="hidden" name="mes" value="<%= mes%>">
<input type="hidden" name="dia" value="<%= dia%>">
<p align="center"><font color="#FFFFFF"><img src="imagenes/Regresar1.jpg" name="regresar" width="152" height="36" border="0" onClick="MandaSubmit(this.form)"> </font></p>
</form>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></font> 
</body>
</html>
