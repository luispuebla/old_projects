<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.math.*, java.math.text.*" errorPage="error.jsp" %>
<jsp:useBean id="info" class="com.alpha.bd.ManagerComprasNuevas" />

<html>
<head>
<title>Resultado Producto x Fecha x $</title>
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
//-->
</script>
</head>
  
<body onLoad="MM_preloadImages('imagenes/Regresar2.jpg')">
<%
 	String usuario = (String) session.getAttribute("UsuarioActual");
 	String tipou = (String) session.getAttribute("TipoUsuario");
	if (usuario == null || !tipou.equalsIgnoreCase("administrador"))  {
%>	
		<jsp:forward page="RedirectAcceso2.html" />
<%
	}
	String elVendedor = "%";
	String inicio = "";
	String fin = "";
	boolean existencia = true;
	String tipoConsulta = request.getParameter("tipoConsul");
	if (tipoConsulta.equals("vend")){
		elVendedor = request.getParameter("claveVendedor");
		existencia = info.existeVendedor(elVendedor);
	}
	if(existencia){
		inicio = request.getParameter("datebox");
		String mes = inicio.substring(0,2);
		String dia = inicio.substring(3,5);
		String ano = inicio.substring(6,10);
		inicio = ano+"-"+mes+"-"+dia;		
		fin = request.getParameter("datebox2");
		mes = fin.substring(0,2);
		dia = fin.substring(3,5);
		ano = fin.substring(6,10);
		fin = ano+"-"+mes+"-"+dia;
	
%>
	<h1> Monto vendido por vendedor en el periodo <%=inicio %> a <%=fin %></h1>
	<table align="center" border="1" width="600">
	  <tr>
	    <th>Clave Vendedor</th>
		<th>Vendedor</th>
		<th>Monto Vendido ($)</th>		
	  </tr>	
<%	
		ResultSet rs = null;
		rs = info.consultaVPV(elVendedor, inicio, fin);
		while (rs.next()){
%>
	  <tr>
		<td><div align="center"><%=rs.getString("claveVenta")%></div></td>
		<td><div align="center"> <%=rs.getString("NombreE")%> </div></td>
		<td><div align="right">$ <%=info.formatoDinero(info.acortaLongitud(rs.getString("Total")))%></div></td>												
	  </tr>				
<%			
		}
		rs.close();
		info.cierraConexion();
%>    

	</table>
<%
	}
	else{
%>	
		<b class="roj"> No existe el usuario con clave: <%= elVendedor%> </b>
<%	
	}
%>
<p align="center"><a href="Menu_Consul_Estadisticas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


