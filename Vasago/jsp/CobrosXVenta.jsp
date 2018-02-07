<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="co" class="com.vas.bd.ManagerCobros" scope="page" />
<jsp:useBean id="cli" class="com.vas.bd.ManagerClientes" scope="page" />
<jsp:useBean id="ban" class="com.vas.bd.ManagerBancos" scope="page" />
<html>
<head>
<title>Cobros por Venta</title>
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

   String cliente = request.getParameter("cliente");
    String claveVenta = request.getParameter("clave");%>
<%
//System.out.println("la clave que llego: "+clave);
 if(claveVenta == null){%>
  <font>
  <%
 // System.out.println("Entro al vacio");
		out.print("Debes seleccionar una Venta."); %>
  </font> 
  <%
}
else{
%>
<h1>&nbsp;</h1>
 <table width="997" border="1" align="center">
  <caption>
  COBROS
  </caption>
  <tr bgcolor="#CCCCCC"> 
    <th width="38">Clave</th>
    <th width="269">Cliente</th>
    <th width="49">Venta</th>
	<th width="74">Fecha</th>
    <th width="97">Monto</th>
    <th width="111">Forma de Pago</th>
    <th width="169">Observaciones</th>
    <th width="138">Banco</th>
   </tr>
<%
	ResultSet rs = co.dameCobrosVenta2(claveVenta);
	while(rs.next()){
%>
  <tr> 
    <td width="38"><div align="center"><%=rs.getString("consecutivo")%></div></td>
    <td width="269"><%=cli.nombreCliente(rs.getString("claveCliente"))%></td>
    <td width="49"><div align="center"><%=rs.getString("claveVenta")%></div></td>
	<td width="74"><div align="center"><%=rs.getString("fechaCobro")%></div></td>
    <td width="97"><div align="right">$ <%=co.formatoDinero(rs.getString("monto"))%></div></td>
    <td width="111"><div align="center">
        <%
	if(rs.getInt("formaPago") == 1)
		out.print("Efectivo");
	if(rs.getInt("formaPago") == 2)
		out.print("Cheque");
	if(rs.getInt("formaPago") == 3)
		out.print("Dep�sito");
	if(rs.getInt("formaPago") == 4)
		out.print("Tarjeta de Cr�dito");
	if(rs.getInt("formaPago") == 5)
		out.print("Tarjeta de D�bito");
	
	%>
    </div></td>
    <td width="169"><div align="center"><%=rs.getString("observaciones")%></div></td>
    <td width="138"><%
	ResultSet ra = null;
	String todo = "";
	ra = ban.bancoCuenta(rs.getString("bancoCuenta"));
	while(ra.next()){
		todo = ra.getString("banco")+" --> "+ ra.getString("numero");
	}	
	if(ra != null){
		ra.close();
	}
	ban.cierraConexion();								
	out.print(todo);
	%></td>
  </tr>
<%
	}
	if(rs != null){
		rs.close();
	}
	co.cierraConexion();							
%>	  
</table>
<%}%>
<p align="center"><a href="Consultas_Cobros.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Retache','','imagenes/Regresar2.jpg',1)"><img src="imagenes/Regresar1.jpg" name="Retache" width="152" height="36" border="0"></a></p>
<p align="center"><img src="imagenes/barraN.jpg" width="532" height="82"></p>
</body>
</html>
