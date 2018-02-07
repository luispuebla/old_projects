<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="per" class="com.ult.bd.ManagerPersonal" scope="page" />
<jsp:useBean id="ven" class="com.ult.bd.ManagerVentas" scope="page" />
<jsp:useBean id="beb" class="com.ult.bd.ManagerBebidas" />
<jsp:useBean id="ali" class="com.ult.bd.ManagerAlimentos" />
<jsp:useBean id="cob" class="com.ult.bd.ManagerCobros" />

<html>
<head>
<title>Detalle</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ultramarinaCSS.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipoU = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipoU.equalsIgnoreCase("admin"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />

<%
	}
	String queryString = request.getQueryString();
	String vacio = "&nbsp;";
	//System.out.println(queryString);
	int mesero = ven.dameMeseroComanda(queryString);
	//System.out.println(mesero);
	ResultSet nombres = per.dameNombreMesera(mesero+"");	
	String nom = "";
	while(nombres.next()){
		nom = nombres.getString("NombreCompleto");
	}
	//System.out.println(nom);
	int cc = ven.cambiaAInt(queryString);
		ResultSet rs = ven.todosLosProductosComanda2(cc);
		ResultSet co = cob.dameCobros(queryString);
//System.out.println(queryString);
//System.out.println(cc);
%>
<h1>DETALLE COMANDA</h1>
<h1>Atendido por: <%=nom%></h1>
<table width="375" border="1" align="center">
  <tr> 
    <th width="77" bgcolor="#DFE1EC" ><div align="center">Cantidad:</div></th>
    <th width="85" bgcolor="#DFE1EC" ><div align="center">Tipo :</div></th>
    <th width="191" bgcolor="#DFE1EC" ><div align="center">Producto:</div></th>
  </tr>
  <% 
//System.out.println("1");
String tipo = "";
String nombre ="";
String mando = "";
//System.out.println("2");
	while (rs.next()) {
if(rs.getString("tipo").equals("0"))
	tipo = "No Aplica";
if(rs.getString("tipo").equals("1"))
	tipo = "Copa";
if(rs.getString("tipo").equals("2"))
	tipo = "Botella";

if(rs.getString("ge").equals("1"))
	nombre = ali.dameNombreAlimento(rs.getString("ClPro"));
if(rs.getString("ge").equals("2"))
	nombre = beb.dameNombreBebida(rs.getString("ClPro"));
		
mando = rs.getString("tipo")+rs.getString("ClPro");		
//System.out.println("3");
		  %>
  <tr> 
      <td width="77"> <div align="center"><%= rs.getString("CanPro") %></div></td>
		      
      <td width="85"> <div align="center"><%= tipo %></div></td>
            <td><%= nombre %></td>
		  </tr>
		    <% } %>
</table>
<p></p>
<table width="453" border="1" align="center">
<caption>Cobros</caption>
  <tr> 
    <th width="77" bgcolor="#DFE1EC" ><div align="center">Fecha</div></th>
    <th width="85" bgcolor="#DFE1EC" ><div align="center">Monto</div></th>
    <th width="85" bgcolor="#DFE1EC" ><div align="center">Forma de Pago</div></th>
  </tr>
  <% 
//System.out.println("1");
String fp = "";
double coto = 0.00;
	while (co.next()) {
	
if(co.getString("formaPago").equals("1"))
	fp = "Efectivo";
if(co.getString("formaPago").equals("4"))
	fp = "Tarjeta de Crédito";
if(co.getString("formaPago").equals("5"))
	fp = "Tarjeta de Débito";
	
	coto = coto + co.getDouble("monto");
		  %>
  <tr> 
      <td width="77"> <div align="center"><%= co.getString("fechaCobro") %></div></td>
		      
      <td width="85"> <div align="center">$ <%= cob.acortaLongitud(cob.formatoDinero(co.getString("monto"))) %></div></td>
            <td><%= fp %></td>
		  </tr>
		    <% } %>
  <tr> 
      <th width="77">Cobrado</div></th>
		      
      <td width="85"> <div align="center">$ <%= cob.acortaLongitud(cob.formatoDinero(coto+"")) %></div></td>
            <td></td>
		  </tr>
</table>
<% 
//System.out.println("4");
per.cierraConexion();%>
<br />
<a href="javascript:history.back()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Regreso','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Regreso" width="152" height="36" border="0"></a>
<br />
<img src="imagenes/barraN.jpg" width="532" height="82">
</body>
</html>
