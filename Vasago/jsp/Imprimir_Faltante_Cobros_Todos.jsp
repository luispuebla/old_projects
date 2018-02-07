<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="co" class="com.vas.bd.ManagerCobros" />
<jsp:useBean id="ti" class="com.vas.bd.TimeStamp" />
<jsp:useBean id="cliente" class="com.vas.bd.ManagerClientes" />

<html>
<head>
<title>Cobors Faltantes Todos los Clientes</title>
<link href="vasagoMiniCSS.css" rel="stylesheet" type="text/css">
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

//-->
</script>
</head>
<body onLoad="imprimirPagina(); Cerrar()">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipo = (String) session.getAttribute("TipoUsuario");
 	String area = (String) session.getAttribute("AreaUsuario");
	if (usuario == null || !tipo.equalsIgnoreCase("Admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%}%>		

<h1>Cuentas por Cobrar Total </h1>
<table width="650" border="1" align="center" onClick="imprimirPagina()">
  <tr bgcolor="#CCCCCC"> 
    <th width="343"><div align="center"><strong>Nombre</strong></div></th>
    <th width="131"><div align="center"><strong>Documento</strong></div></th>
    <th width="154"><div align="center"><strong>Debe</strong></div></th>
  </tr>
<%
	String hoy = ti.date;
	double totalT = 0.0;
	ResultSet cliXagen = cliente.dameClientes();
	while (cliXagen.next()){  

		ResultSet ventas = co.ventasXclientePorCobrarListado(cliXagen.getString("rfc"));
		while(ventas.next()){
			String documento = new String();
			double total = 0.0;
			double pagado = 0.0;
			double resta = 0.0;
%>
  <tr> 
    <td><%= cliXagen.getString("nombre")%></td>
    <td><div align="center"><%
			if(ventas.getInt("tipo") == 1){
				documento = "F --> "+ventas.getString("factura");
			}
			else{
				documento = "R --> "+ventas.getString("remision");
			}
	out.print(documento);%></div></td>
    <td><div align="right">$ 
        <%
			total = ventas.getDouble("total");
			pagado = co.dameSumaCobrados(ventas.getString("claveVenta"));
			resta = total - pagado;
			totalT = totalT + resta;
	out.print(co.formatoDinero(co.acortaLongitud(resta+"")));
	%>
    </div></td>
  </tr>
<%	      
		} 
	}
%>
  <tr> 
    <th width="343"></th>
    <th width="131">TOTAL</th>
    <th width="154"><div align="right">$ <%=co.formatoDinero(co.acortaLongitud(totalT+""))%></div></th>
  </tr>
</table>

</body>
</html>
