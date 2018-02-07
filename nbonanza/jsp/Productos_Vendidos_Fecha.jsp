<%@ page language="java" import="java.sql.*, java.io.*, java.util.*" errorPage="" %>

<jsp:useBean id="facturas" class="com.alpha.bd.ManagerFacturacion" />

<html>
<head>
<title>Todos las Facturas</title>
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
	String tipoConsul = request.getParameter("tipoCon");
	String dia = "%%";
	String mes = request.getParameter("mes");
	String anio = request.getParameter("aaaa");
	if(tipoConsul.equalsIgnoreCase("dia")){
		dia = request.getParameter("dia");
	}
	String fecha = anio+"-"+mes+"-"+dia;
%>

<h1>Los Productos Vendidos para la Fecha:
<%
 if(!(dia.equalsIgnoreCase("%%"))){
 	out.print(dia+"/");
 }
%><%=mes%>/<%=anio%> son: </h1>
<table width="670" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <th width="81"><div align="center">Cantidad</div></th>
	<th width="87"><div align="center">Tipo</div></th>	
    <th width="97"><div align="center">Clave</div></th>
    <th width="395"><div align="center">Art&iacute;culo</div></th>
  </tr>
<%	
	ResultSet rs = facturas.productosVendidosXFechaRetonito(fecha);
	while (rs.next()) {  
		String elTipo = "Kg.";
		String laCantidad = rs.getDouble("Cantidad")+"";
		if(rs.getInt("tipoVenta")== 2){
			elTipo = "Unidad";
			laCantidad = rs.getInt("Cantidad")+"";
		}
		else if(rs.getInt("tipoVenta")== 3){
			elTipo = "Caja";
			laCantidad = facturas.formatoMaxUnDecimal(rs.getString("Cantidad"));
		}
		else if(rs.getInt("tipoVenta")== 4){
			elTipo = "Pieza";
			laCantidad = facturas.formatoMaxUnDecimal(rs.getString("Cantidad"));			
		}
%>
  <tr> 
    <td><div align="center"></div>
      <div align="center"><%=laCantidad%></div></td>	
    <td><div align="center"><%=elTipo%></div></td>
    <td><div align="center"><%=rs.getString("ID_Pro")%></div></td>
    <td><div align="left"><%=rs.getString("descripcion")%></div></td>		
  </tr>
<%	      
	} 
	rs.close();
	facturas.cierraConexion();
%>
</table>
<br />
<p align="center"><a href="Menu_Consul_Estadisticas.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('regresar','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="regresar" width="132" height="41" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>


